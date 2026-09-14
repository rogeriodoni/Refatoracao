# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\forms\cadastros\Formlch.prg: .Top = 29 .Left = 0 .Width = THIS.Width .Height = 80 | Error in line 115: Syntax error. | .BackColor = RGB(100, 100, 100) .BorderWidth = 0 .Visible = .T. | Error in line 116: Syntax error. | .Caption = THIS.Caption .AutoSize = .F. .Width = THIS.Width .Height = 40 | Error in line 121: Syntax error. | .Top = 15 .Left = 10 .FontName = "Tahoma" .FontSize = 16 .FontBold = .T. | Error in line 122: Syntax error. | .ForeColor = RGB(0, 0, 0) .BackStyle = 0 .Visible = .T. | Error in line 123: Syntax error. | .Caption = THIS.Caption .AutoSize = .F. .Width = THIS.Width .Height = 46 | Error in line 128: Syntax error. | .Top = 18 .Left = 10 .FontName = "Tahoma" .FontSize = 16 .FontBold = .T. | Error in line 129: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 130: Syntax error. | .Top = 29 .Left = 542 .Width = 385 .Height = 85 | Error in line 137: Syntax error. | .BackStyle = 1 .BackColor = RGB(53, 53, 53) .BorderWidth = 0 .Visible = .T. | Error in line 138: Syntax error. | .Top = 5 .Left = 5 .Width = 75 .Height = 75 .Caption = "Incluir" | Error in line 143: Syntax error. | .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg" .PicturePosition = 13 | Error in line 144: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 145: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 146: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 147: Syntax error. | .Top = 5 .Left = 80 .Width = 75 .Height = 75 .Caption = "Visualizar" | Error in line 153: Syntax error. | .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg" .PicturePosition = 13 | Error in line 154: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 155: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 156: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 157: Syntax error. | .Top = 5 .Left = 155 .Width = 75 .Height = 75 .Caption = "Alterar" | Error in line 163: Syntax error. | .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg" .PicturePosition = 13 | Error in line 164: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 165: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 166: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 167: Syntax error. | .Top = 5 .Left = 230 .Width = 75 .Height = 75 .Caption = "Excluir" | Error in line 173: Syntax error. | .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg" .PicturePosition = 13 | Error in line 174: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 175: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 176: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 177: Syntax error. | .Top = 5 .Left = 305 .Width = 75 .Height = 75 .Caption = "Buscar" | Error in line 183: Syntax error. | .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg" .PicturePosition = 13 | Error in line 184: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 185: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 186: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 187: Syntax error. | .Top = 29 .Left = 917 .Width = 90 .Height = 85 | Error in line 195: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 196: Syntax error. | .Top = 5 .Left = 5 .Width = 75 .Height = 75 .Caption = "Encerrar" | Error in line 201: Syntax error. | .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg" .PicturePosition = 13 | Error in line 202: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 203: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 204: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 205: Syntax error. | .Top = 115 .Left = 5 .Width = 267 .Height = 46 | Error in line 214: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 215: Syntax error. | .Top = 3 .Left = 0 .Width = 267 .Height = 40 | Error in line 221: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 222: Syntax error. | .Caption = "Per" + CHR(237) + "odo : " .Top = 6 .Left = 23 .Width = 48 .Height = 15 | Error in line 227: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 228: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 229: Syntax error. | .Top = 2 .Left = 70 .Width = 80 .Height = 21 | Error in line 234: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 235: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 236: Syntax error. | .Caption = CHR(224) .Top = 6 .Left = 152 .Width = 10 .Height = 15 | Error in line 241: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 242: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 243: Syntax error. | .Top = 2 .Left = 167 .Width = 80 .Height = 21 | Error in line 248: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 249: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 250: Syntax error. | .Caption = "Situa" + CHR(231) + CHR(227) + "o :" .Top = 146 .Left = 39 .Width = 55 .Height = 15 | Error in line 256: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 257: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 258: Syntax error. | .Top = 142 .Left = 96 .Width = 178 .Height = 24 | Error in line 263: Syntax error. | .Style = 2 .ListIndex = 1 | Error in line 266: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 267: Syntax error. | .Top = 115 .Left = 271 .Width = 75 .Height = 75 | Error in line 274: Syntax error. | .FontName = "Tahoma" .FontBold = .F. .FontSize = 8 | Error in line 276: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 277: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 278: Syntax error. | .Top = 115 .Left = 347 .Width = 75 .Height = 75 | Error in line 285: Syntax error. | .FontName = "Tahoma" .FontBold = .F. .FontSize = 8 | Error in line 287: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 288: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 289: Syntax error. | .Top = 193 .Left = 5 .Width = 990 .Height = 435 | Error in line 298: Syntax error. | .FontName = "Verdana" .FontSize = 8 | Error in line 299: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 300: Syntax error. | .DeleteMark = .F. .RecordMark = .F. | Error in line 305: Syntax error. | .RowHeight = 16 .ScrollBars = 2 .GridLines = 3 .Visible = .T. | Error in line 306: Syntax error. | .Width = 60 .Header1.Caption = "Lote" | Error in line 309: Syntax error. | .Width = 80 .Header1.Caption = "Empresa" | Error in line 312: Syntax error. | .Width = 90 .Header1.Caption = "Data Entrada" | Error in line 315: Syntax error. | .Width = 100 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o" | Error in line 318: Syntax error. | .Width = 110 .Header1.Caption = "Valor Total" | Error in line 321: Syntax error. | .Width = 80 .Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o" | Error in line 324: Syntax error. | .Top = 29 .Left = 853 .Width = 160 .Height = 85 | Error in line 349: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 350: Syntax error. | .Top = 5 .Left = 5 .Width = 75 .Height = 75 .Caption = "Confirmar" | Error in line 355: Syntax error. | .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg" .PicturePosition = 13 | Error in line 356: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 357: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 358: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 359: Syntax error. | .Top = 5 .Left = 80 .Width = 75 .Height = 75 .Caption = "Encerrar" | Error in line 365: Syntax error. | .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg" .PicturePosition = 13 | Error in line 366: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 367: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 368: Syntax error. | .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 369: Syntax error. | .Caption = "Usu" + CHR(225) + "rio :" .Top = 41 .Left = 36 .Width = 52 .Height = 18 | Error in line 379: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 380: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 381: Syntax error. | .Top = 38 .Left = 86 .Width = 80 .Height = 21 | Error in line 386: Syntax error. | .MaxLength = 15 .Value = "" .ReadOnly = .T. | Error in line 387: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 388: Syntax error. | .Caption = "Lote :" .Top = 41 .Left = 181 .Width = 32 .Height = 18 | Error in line 393: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 394: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 395: Syntax error. | .Top = 38 .Left = 215 .Width = 70 .Height = 21 | Error in line 400: Syntax error. | .Value = 0 .ReadOnly = .T. | Error in line 401: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 402: Syntax error. | .Caption = "Data :" .Top = 41 .Left = 300 .Width = 35 .Height = 18 | Error in line 407: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 408: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 409: Syntax error. | .Top = 38 .Left = 337 .Width = 85 .Height = 21 | Error in line 414: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 415: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 416: Syntax error. | .Top = 59 .Left = 209 .Width = 153 .Height = 25 | Error in line 423: Syntax error. | .ButtonCount = 3 .BackStyle = 0 .Value = 1 .Visible = .T. | Error in line 424: Syntax error. | .Caption = "Movimento :" .Top = 64 .Left = 23 .Width = 62 .Height = 18 | Error in line 433: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 434: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 435: Syntax error. | .Top = 61 .Left = 86 .Width = 117 .Height = 21 | Error in line 440: Syntax error. | .MaxLength = 15 .Value = "" | Error in line 441: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 442: Syntax error. | .Top = 81 .Left = 6 .Width = 464 .Height = 53 | Error in line 453: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 454: Syntax error. | .Caption = "Cheques :" .Top = 6 .Left = 27 .Width = 52 .Height = 15 | Error in line 459: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 460: Syntax error. | .Top = 3 .Left = 80 .Width = 70 .Height = 21 | Error in line 465: Syntax error. | .Value = 0 .ReadOnly = .T. | Error in line 466: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 467: Syntax error. | .Caption = "Moeda :" .Top = 6 .Left = 159 .Width = 42 .Height = 15 | Error in line 472: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 473: Syntax error. | .Top = 3 .Left = 202 .Width = 32 .Height = 21 | Error in line 478: Syntax error. | .MaxLength = 5 .Value = "" | Error in line 479: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 480: Syntax error. | .Top = 1 .Left = 236 .Width = 24 .Height = 23 .Caption = "$" | Error in line 486: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontSize = 10 | Error in line 487: Syntax error. | .BackColor = RGB(255, 255, 255) .Themes = .T. .SpecialEffect = 0 .Visible = .T. | Error in line 488: Syntax error. | .Caption = "Cota" + CHR(231) + CHR(227) + "o :" .Top = 6 .Left = 281 .Width = 50 .Height = 15 | Error in line 494: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 495: Syntax error. | .Top = 3 .Left = 332 .Width = 108 .Height = 21 | Error in line 500: Syntax error. | .Value = 0 .InputMask = "99999999.9999" | Error in line 501: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 502: Syntax error. | .Caption = "Valor :" .Top = 29 .Left = 45 .Width = 35 .Height = 15 | Error in line 507: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 508: Syntax error. | .Top = 26 .Left = 80 .Width = 154 .Height = 21 | Error in line 513: Syntax error. | .Value = 0 .ReadOnly = .T. .InputMask = "999999999.99" | Error in line 514: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 515: Syntax error. | .Caption = "Convertido :" .Top = 29 .Left = 268 .Width = 62 .Height = 15 | Error in line 520: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 521: Syntax error. | .Top = 26 .Left = 332 .Width = 108 .Height = 21 | Error in line 526: Syntax error. | .Value = 0 .ReadOnly = .T. .InputMask = "999999999.99" | Error in line 527: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 528: Syntax error. | .Top = 135 .Left = 6 .Width = 464 .Height = 58 | Error in line 537: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 538: Syntax error. | .Caption = "Origem" .Top = 0 .Left = 4 .Width = 60 .Height = 14 | Error in line 543: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T. | Error in line 544: Syntax error. | .BackStyle = 0 .Visible = .T. | Error in line 545: Syntax error. | .Caption = "Grupo :" .Top = 15 .Left = 18 .Width = 42 .Height = 15 | Error in line 550: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 551: Syntax error. | .Top = 12 .Left = 61 .Width = 79 .Height = 21 | Error in line 556: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 557: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 558: Syntax error. | .Top = 12 .Left = 142 .Width = 319 .Height = 21 | Error in line 564: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 565: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 566: Syntax error. | .Caption = "Conta :" .Top = 38 .Left = 18 .Width = 42 .Height = 15 | Error in line 571: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 572: Syntax error. | .Top = 35 .Left = 61 .Width = 79 .Height = 21 | Error in line 577: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 578: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 579: Syntax error. | .Top = 35 .Left = 142 .Width = 115 .Height = 21 | Error in line 585: Syntax error. | .MaxLength = 14 .Value = "" | Error in line 586: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 587: Syntax error. | .Top = 35 .Left = 259 .Width = 202 .Height = 21 | Error in line 592: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 593: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 594: Syntax error. | .Top = 135 .Left = 497 .Width = 464 .Height = 58 | Error in line 603: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 604: Syntax error. | .Caption = "Despesa" .Top = 0 .Left = 4 .Width = 60 .Height = 14 | Error in line 609: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T. | Error in line 610: Syntax error. | .BackStyle = 0 .Visible = .T. | Error in line 611: Syntax error. | .Caption = "Grupo :" .Top = 15 .Left = 18 .Width = 42 .Height = 15 | Error in line 616: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 617: Syntax error. | .Top = 12 .Left = 61 .Width = 79 .Height = 21 | Error in line 622: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 623: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 624: Syntax error. | .Top = 12 .Left = 142 .Width = 319 .Height = 21 | Error in line 630: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 631: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 632: Syntax error. | .Caption = "Conta :" .Top = 38 .Left = 18 .Width = 42 .Height = 15 | Error in line 637: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 638: Syntax error. | .Top = 35 .Left = 61 .Width = 79 .Height = 21 | Error in line 643: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 644: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 645: Syntax error. | .Top = 35 .Left = 142 .Width = 115 .Height = 21 | Error in line 651: Syntax error. | .MaxLength = 14 .Value = "" | Error in line 652: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 653: Syntax error. | .Top = 35 .Left = 259 .Width = 202 .Height = 21 | Error in line 658: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 659: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 660: Syntax error. | .Top = 195 .Left = 6 .Width = 464 .Height = 58 | Error in line 669: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 670: Syntax error. | .Caption = "Destino" .Top = 0 .Left = 4 .Width = 60 .Height = 14 | Error in line 675: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T. | Error in line 676: Syntax error. | .BackStyle = 0 .Visible = .T. | Error in line 677: Syntax error. | .Caption = "Grupo :" .Top = 15 .Left = 17 .Width = 42 .Height = 15 | Error in line 682: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 683: Syntax error. | .Top = 12 .Left = 60 .Width = 79 .Height = 21 | Error in line 688: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 689: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 690: Syntax error. | .Top = 12 .Left = 141 .Width = 320 .Height = 21 | Error in line 696: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 697: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 698: Syntax error. | .Caption = "Conta :" .Top = 38 .Left = 17 .Width = 42 .Height = 15 | Error in line 703: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 704: Syntax error. | .Top = 35 .Left = 60 .Width = 79 .Height = 21 | Error in line 709: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 710: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 711: Syntax error. | .Top = 35 .Left = 141 .Width = 115 .Height = 21 | Error in line 717: Syntax error. | .MaxLength = 14 .Value = "" | Error in line 718: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 719: Syntax error. | .Top = 35 .Left = 258 .Width = 203 .Height = 21 | Error in line 724: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 725: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 726: Syntax error. | .Top = 195 .Left = 497 .Width = 464 .Height = 58 | Error in line 736: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 737: Syntax error. | .Caption = "Centro de Custo" .Top = 0 .Left = 4 .Width = 100 .Height = 14 | Error in line 742: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T. | Error in line 743: Syntax error. | .BackStyle = 0 .Visible = .T. | Error in line 744: Syntax error. | .Caption = "Grupo :" .Top = 15 .Left = 17 .Width = 42 .Height = 15 | Error in line 749: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 750: Syntax error. | .Top = 12 .Left = 60 .Width = 79 .Height = 21 | Error in line 755: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 756: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 757: Syntax error. | .Top = 12 .Left = 141 .Width = 320 .Height = 21 | Error in line 763: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 764: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 765: Syntax error. | .Caption = "Conta :" .Top = 38 .Left = 17 .Width = 42 .Height = 15 | Error in line 770: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 771: Syntax error. | .Top = 35 .Left = 60 .Width = 79 .Height = 21 | Error in line 776: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 777: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 778: Syntax error. | .Top = 35 .Left = 141 .Width = 115 .Height = 21 | Error in line 784: Syntax error. | .MaxLength = 14 .Value = "" | Error in line 785: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 786: Syntax error. | .Top = 35 .Left = 258 .Width = 203 .Height = 21 | Error in line 791: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 792: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 793: Syntax error. | .Top = 254 .Left = 6 .Width = 464 .Height = 58 | Error in line 802: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 803: Syntax error. | .Caption = "Carteira" .Top = 0 .Left = 4 .Width = 60 .Height = 14 | Error in line 808: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T. | Error in line 809: Syntax error. | .BackStyle = 0 .Visible = .T. | Error in line 810: Syntax error. | .Caption = "Grupo :" .Top = 15 .Left = 17 .Width = 42 .Height = 15 | Error in line 815: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 816: Syntax error. | .Top = 12 .Left = 60 .Width = 80 .Height = 21 | Error in line 821: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 822: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 823: Syntax error. | .Top = 12 .Left = 142 .Width = 319 .Height = 21 | Error in line 829: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 830: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 831: Syntax error. | .Caption = "Conta :" .Top = 38 .Left = 17 .Width = 42 .Height = 15 | Error in line 836: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 837: Syntax error. | .Top = 35 .Left = 60 .Width = 80 .Height = 21 | Error in line 842: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 843: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 844: Syntax error. | .Top = 35 .Left = 142 .Width = 319 .Height = 21 | Error in line 850: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 851: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 852: Syntax error. | .Top = 254 .Left = 497 .Width = 480 .Height = 58 | Error in line 862: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 863: Syntax error. | .Caption = "Per" + CHR(237) + "odo :" .Top = 8 .Left = 21 .Width = 46 .Height = 15 | Error in line 868: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 869: Syntax error. | .Top = 5 .Left = 68 .Width = 80 .Height = 21 | Error in line 874: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 875: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 876: Syntax error. | .Caption = CHR(224) .Top = 9 .Left = 152 .Width = 10 .Height = 15 | Error in line 881: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 882: Syntax error. | .Top = 5 .Left = 165 .Width = 80 .Height = 21 | Error in line 887: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 888: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 889: Syntax error. | .Caption = "Empresa :" .Top = 34 .Left = 17 .Width = 50 .Height = 15 | Error in line 894: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 895: Syntax error. | .Top = 31 .Left = 68 .Width = 31 .Height = 21 | Error in line 900: Syntax error. | .MaxLength = 3 .Value = "" | Error in line 901: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 902: Syntax error. | .Caption = "Lote :" .Top = 34 .Left = 131 .Width = 35 .Height = 15 | Error in line 907: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 908: Syntax error. | .Top = 31 .Left = 165 .Width = 52 .Height = 21 | Error in line 913: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 915: Syntax error. | .Caption = "Planilha :" .Top = 34 .Left = 237 .Width = 48 .Height = 15 | Error in line 920: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 921: Syntax error. | .Top = 31 .Left = 285 .Width = 120 .Height = 21 | Error in line 926: Syntax error. | .MaxLength = 250 .Value = "" | Error in line 927: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 928: Syntax error. | .Top = 29 .Left = 406 .Width = 24 .Height = 24 .Caption = "..." | Error in line 933: Syntax error. | .FontName = "Tahoma" .FontSize = 8 | Error in line 934: Syntax error. | .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 935: Syntax error. | .Caption = "" .Top = 133 .Left = 13 .Width = 2 .Height = 15 | Error in line 941: Syntax error. | .AutoSize = .T. .FontName = "Tahoma" .FontSize = 8 | Error in line 942: Syntax error. | .ForeColor = RGB(200, 0, 0) .BackStyle = 0 .Visible = .T. | Error in line 943: Syntax error. | .Top = 313 .Left = 6 .Width = 464 .Height = 58 | Error in line 952: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 953: Syntax error. | .Caption = "Emissor" .Top = 0 .Left = 4 .Width = 60 .Height = 14 | Error in line 958: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T. | Error in line 959: Syntax error. | .BackStyle = 0 .Visible = .T. | Error in line 960: Syntax error. | .Caption = "Grupo :" .Top = 15 .Left = 18 .Width = 42 .Height = 15 | Error in line 965: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 966: Syntax error. | .Top = 12 .Left = 61 .Width = 79 .Height = 21 | Error in line 971: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 972: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 973: Syntax error. | .Top = 12 .Left = 142 .Width = 319 .Height = 21 | Error in line 979: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 980: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 981: Syntax error. | .Caption = "Conta :" .Top = 38 .Left = 18 .Width = 42 .Height = 15 | Error in line 986: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 987: Syntax error. | .Top = 35 .Left = 61 .Width = 79 .Height = 21 | Error in line 992: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 993: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 994: Syntax error. | .Top = 35 .Left = 142 .Width = 115 .Height = 21 | Error in line 1000: Syntax error. | .MaxLength = 14 .Value = "" | Error in line 1001: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1002: Syntax error. | .Top = 35 .Left = 259 .Width = 202 .Height = 21 | Error in line 1007: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 1008: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1009: Syntax error. | .Caption = "Observa" + CHR(231) + CHR(227) + "o :" .Top = 319 .Left = 509 .Width = 70 .Height = 15 | Error in line 1018: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 1019: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 1020: Syntax error. | .Top = 317 .Left = 581 .Width = 391 .Height = 48 | Error in line 1025: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .ScrollBars = 2 .Visible = .T. | Error in line 1027: Syntax error. | .Top = 374 .Left = 5 .Width = 759 .Height = 94 | Error in line 1036: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 1037: Syntax error. | .Top = 0 .Left = 0 .Width = 759 .Height = 93 | Error in line 1044: Syntax error. | .FontName = "Verdana" .FontSize = 7 | Error in line 1045: Syntax error. | .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255) | Error in line 1046: Syntax error. | .DeleteMark = .F. .RecordMark = .F. | Error in line 1051: Syntax error. | .RowHeight = 16 .ScrollBars = 3 .GridLines = 3 .Visible = .T. | Error in line 1052: Syntax error. | .Width = 30 .Header1.Caption = "Bco" | Error in line 1055: Syntax error. | .Width = 38 .Header1.Caption = "Ag" + CHR(234) + "ncia" | Error in line 1058: Syntax error. | .Width = 70 .Header1.Caption = "N" + CHR(176) + " Conta" | Error in line 1061: Syntax error. | .Width = 65 .Header1.Caption = "N" + CHR(176) + " Chq" | Error in line 1064: Syntax error. | .Width = 75 .Header1.Caption = "Valor" | Error in line 1067: Syntax error. | .Width = 75 .Header1.Caption = "Vencimento" | Error in line 1070: Syntax error. | .Width = 40 .Header1.Caption = "Alin" + CHR(233) + "a" | Error in line 1073: Syntax error. | .Width = 30 .Header1.Caption = "Emp" | Error in line 1076: Syntax error. | .Width = 80 .Header1.Caption = "C" + CHR(243) + "d. Cliente" | Error in line 1079: Syntax error. | .Width = 70 .Header1.Caption = "Protocolo" | Error in line 1082: Syntax error. | .Width = 75 .Header1.Caption = "Dt. Emiss" + CHR(227) + "o" | Error in line 1085: Syntax error. | .Width = 30 .Header1.Caption = "Sel" | Error in line 1089: Syntax error. | .Caption = "" .Alignment = 0 .ReadOnly = .F. .Visible = .T. | Error in line 1093: Syntax error. | .Top = 9 .Left = 2 .Height = 17 .Width = 22 | Error in line 1094: Syntax error. | .Top = 378 .Left = 767 .Width = 40 .Height = 40 | Error in line 1103: Syntax error. | .FontName = "Tahoma" .FontSize = 7 | Error in line 1105: Syntax error. | .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 1106: Syntax error. | .Top = 419 .Left = 767 .Width = 40 .Height = 40 | Error in line 1113: Syntax error. | .FontName = "Tahoma" .FontSize = 7 | Error in line 1115: Syntax error. | .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 1116: Syntax error. | .Top = 393 .Left = 826 .Width = 75 .Height = 75 | Error in line 1129: Syntax error. | .Caption = "Repetir Followup" .Value = 0 | Error in line 1130: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 1131: Syntax error. | .Top = 393 .Left = 901 .Width = 75 .Height = 75 | Error in line 1136: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 1138: Syntax error. | .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 1139: Syntax error. | .Top = 470 .Left = 826 .Width = 75 .Height = 75 | Error in line 1145: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 1147: Syntax error. | .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 1148: Syntax error. | .Top = 470 .Left = 901 .Width = 75 .Height = 75 | Error in line 1154: Syntax error. | .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8 | Error in line 1156: Syntax error. | .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T. | Error in line 1157: Syntax error. | .Caption = "S" .Top = 469 .Left = 7 .Width = 21 .Height = 26 | Error in line 1167: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 10 .FontBold = .T. | Error in line 1168: Syntax error. | .ForeColor = RGB(180, 180, 180) .BackStyle = 0 .Visible = .T. | Error in line 1169: Syntax error. | .Caption = "M" .Top = 469 .Left = 30 .Width = 21 .Height = 26 | Error in line 1174: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 10 .FontBold = .T. | Error in line 1175: Syntax error. | .ForeColor = RGB(180, 180, 180) .BackStyle = 0 .Visible = .T. | Error in line 1176: Syntax error. | .Caption = "T" .Top = 469 .Left = 53 .Width = 21 .Height = 26 | Error in line 1181: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 10 .FontBold = .T. | Error in line 1182: Syntax error. | .ForeColor = RGB(180, 180, 180) .BackStyle = 0 .Visible = .T. | Error in line 1183: Syntax error. | .Caption = "P" .Top = 469 .Left = 76 .Width = 21 .Height = 26 | Error in line 1188: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 10 .FontBold = .T. | Error in line 1189: Syntax error. | .ForeColor = RGB(180, 180, 180) .BackStyle = 0 .Visible = .T. | Error in line 1190: Syntax error. | .Top = 469 .Left = 173 .Width = 52 .Height = 23 | Error in line 1195: Syntax error. | .Value = 0 .ReadOnly = .T. | Error in line 1196: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1197: Syntax error. | .Top = 469 .Left = 226 .Width = 122 .Height = 23 | Error in line 1202: Syntax error. | .Value = 0 .ReadOnly = .T. .InputMask = "999999999.99" | Error in line 1203: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1204: Syntax error. | .Top = 469 .Left = 489 .Width = 116 .Height = 23 | Error in line 1209: Syntax error. | .MaxLength = 20 .Value = "" | Error in line 1210: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1211: Syntax error. | .Top = 497 .Left = 6 .Width = 735 .Height = 39 | Error in line 1221: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 1222: Syntax error. | .Caption = "Protocolo" .Top = 4 .Left = 18 .Width = 55 .Height = 12 | Error in line 1227: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1228: Syntax error. | .Top = 16 .Left = 5 .Width = 66 .Height = 21 | Error in line 1233: Syntax error. | .MaxLength = 20 .Value = "" | Error in line 1234: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1235: Syntax error. | .Top = 16 .Left = 41 .Width = 66 .Height = 21 | Error in line 1240: Syntax error. | .MaxLength = 20 .Value = "" | Error in line 1241: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1242: Syntax error. | .Caption = "Bco" .Top = 4 .Left = 118 .Width = 25 .Height = 12 | Error in line 1247: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1248: Syntax error. | .Top = 16 .Left = 108 .Width = 36 .Height = 21 | Error in line 1253: Syntax error. | .MaxLength = 5 .Value = "" | Error in line 1254: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1255: Syntax error. | .Caption = "Agen." .Top = 4 .Left = 153 .Width = 35 .Height = 12 | Error in line 1260: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1261: Syntax error. | .Top = 16 .Left = 145 .Width = 40 .Height = 21 | Error in line 1266: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 1267: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1268: Syntax error. | .Caption = "Conta" .Top = 4 .Left = 213 .Width = 35 .Height = 12 | Error in line 1273: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1274: Syntax error. | .Top = 16 .Left = 186 .Width = 82 .Height = 21 | Error in line 1279: Syntax error. | .MaxLength = 20 .Value = "" | Error in line 1280: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1281: Syntax error. | .Caption = "Numero" .Top = 4 .Left = 279 .Width = 40 .Height = 12 | Error in line 1286: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1287: Syntax error. | .Top = 16 .Left = 269 .Width = 54 .Height = 21 | Error in line 1292: Syntax error. | .MaxLength = 20 .Value = "" | Error in line 1293: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1294: Syntax error. | .Caption = "Valor" .Top = 4 .Left = 361 .Width = 35 .Height = 12 | Error in line 1299: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1300: Syntax error. | .Top = 16 .Left = 324 .Width = 104 .Height = 21 | Error in line 1305: Syntax error. | .Value = 0 .InputMask = "999999999.99" | Error in line 1306: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1307: Syntax error. | .Caption = "Vencimento" .Top = 4 .Left = 438 .Width = 65 .Height = 12 | Error in line 1312: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1313: Syntax error. | .Top = 16 .Left = 429 .Width = 82 .Height = 21 | Error in line 1318: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 1319: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1320: Syntax error. | .Caption = "Alinea" .Top = 4 .Left = 514 .Width = 35 .Height = 12 | Error in line 1325: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1326: Syntax error. | .Top = 16 .Left = 512 .Width = 31 .Height = 21 | Error in line 1331: Syntax error. | .MaxLength = 5 .Value = "" | Error in line 1332: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1333: Syntax error. | .Caption = "Dt Emis Cheque" .Top = 4 .Left = 550 .Width = 90 .Height = 12 | Error in line 1338: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T. | Error in line 1339: Syntax error. | .Top = 16 .Left = 544 .Width = 82 .Height = 21 | Error in line 1344: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 1345: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1346: Syntax error. | .Top = 537 .Left = 42 .Width = 698 .Height = 24 | Error in line 1355: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 1356: Syntax error. | .Caption = "Empresa :" .Top = 4 .Left = 11 .Width = 50 .Height = 15 | Error in line 1361: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 1362: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 1363: Syntax error. | .Top = 1 .Left = 63 .Width = 31 .Height = 21 | Error in line 1368: Syntax error. | .MaxLength = 3 .Value = "" | Error in line 1369: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1370: Syntax error. | .Top = 1 .Left = 96 .Width = 290 .Height = 21 | Error in line 1376: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 1377: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1378: Syntax error. | .Top = 560 .Left = 52 .Width = 648 .Height = 23 | Error in line 1388: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 1389: Syntax error. | .Caption = "Conta :" .Top = 4 .Left = 13 .Width = 38 .Height = 15 | Error in line 1394: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 1395: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 1396: Syntax error. | .Top = 0 .Left = 53 .Width = 79 .Height = 21 | Error in line 1401: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 1402: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1403: Syntax error. | .Top = 0 .Left = 133 .Width = 150 .Height = 21 | Error in line 1409: Syntax error. | .MaxLength = 14 .Value = "" | Error in line 1410: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1411: Syntax error. | .Top = 0 .Left = 285 .Width = 360 .Height = 21 | Error in line 1416: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 1417: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1418: Syntax error. | .Top = 560 .Left = 699 .Width = 296 .Height = 60 | Error in line 1428: Syntax error. | .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T. | Error in line 1429: Syntax error. | .Caption = "Filtro Vencimento :" .Top = 8 .Left = 29 .Width = 92 .Height = 15 | Error in line 1434: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 1435: Syntax error. | .Top = 5 .Left = 122 .Width = 79 .Height = 21 | Error in line 1440: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 1441: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1442: Syntax error. | .Caption = CHR(224) .Top = 8 .Left = 203 .Width = 8 .Height = 15 | Error in line 1447: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 1448: Syntax error. | .Top = 5 .Left = 212 .Width = 79 .Height = 21 | Error in line 1453: Syntax error. | .Value = {} .InputMask = "@D" | Error in line 1454: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1455: Syntax error. | .Caption = "Classe Empresarial :" .Top = 34 .Left = 22 .Width = 98 .Height = 15 | Error in line 1460: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T. | Error in line 1461: Syntax error. | .Top = 31 .Left = 122 .Width = 115 .Height = 21 | Error in line 1466: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 1467: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1468: Syntax error. | .Top = 582 .Left = 19 .Width = 681 .Height = 24 | Error in line 1477: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 1478: Syntax error. | .Caption = "Respons" + CHR(225) + "vel :" .Top = 5 .Left = 14 .Width = 68 .Height = 15 | Error in line 1483: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 1484: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 1485: Syntax error. | .Top = 0 .Left = 86 .Width = 79 .Height = 21 | Error in line 1490: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 1491: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1492: Syntax error. | .Caption = "/" .Top = 3 .Left = 168 .Width = 8 .Height = 15 | Error in line 1498: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 1499: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 1500: Syntax error. | .Top = 0 .Left = 178 .Width = 79 .Height = 21 | Error in line 1505: Syntax error. | .MaxLength = 10 .Value = "" | Error in line 1506: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1507: Syntax error. | .Top = 0 .Left = 259 .Width = 419 .Height = 21 | Error in line 1513: Syntax error. | .Value = "" .ReadOnly = .T. | Error in line 1514: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1515: Syntax error. | .Top = 603 .Left = 41 .Width = 658 .Height = 25 | Error in line 1524: Syntax error. | .BackStyle = 0 .BorderWidth = 0 .Visible = .T. | Error in line 1525: Syntax error. | .Caption = "Followup :" .Top = 3 .Left = 12 .Width = 50 .Height = 15 | Error in line 1530: Syntax error. | .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 | Error in line 1531: Syntax error. | .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T. | Error in line 1532: Syntax error. | .Top = 1 .Left = 64 .Width = 592 .Height = 21 | Error in line 1537: Syntax error. | .MaxLength = 200 .Value = "" | Error in line 1538: Syntax error. | .FontName = "Tahoma" .FontSize = 8 .Visible = .T. | Error in line 1539: Syntax error. | IF VARTYPE(loc_oPg2.txt_4c_Lote) = "O"       : loc_oPg2.txt_4c_Lote.Value  = 0    : ENDIF | Error in line 2427: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.txt_4c_Usuar) = "O"      : loc_oPg2.txt_4c_Usuar.Value = ALLTRIM(gc_4c_UsuarioLogado) : ENDIF | Error in line 2428: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"        : loc_oPg2.txt_4c_Data.Value  = DATE() : ENDIF | Error in line 2429: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"        : loc_oPg2.txt_4c_Oper.Value  = ""  : ENDIF | Error in line 2430: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.opt_4c_SNA) = "O"         : loc_oPg2.opt_4c_SNA.Value   = 1   : ENDIF | Error in line 2431: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Qtde) = "O"    : loc_oPg2.cnt_4c_Infos.txt_4c_Qtde.Value    = 0  : ENDIF | Error in line 2434: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"   : loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value   = "" : ENDIF | Error in line 2435: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O" : loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Value = 0  : ENDIF | Error in line 2436: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Valor) = "O"   : loc_oPg2.cnt_4c_Infos.txt_4c_Valor.Value   = 0  : ENDIF | Error in line 2437: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_ValConv) = "O" : loc_oPg2.cnt_4c_Infos.txt_4c_ValConv.Value = 0  : ENDIF | Error in line 2438: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"   : loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Value   = "" : ENDIF | Error in line 2441: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O"   : loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig.Value   = "" : ENDIF | Error in line 2442: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig) = "O"  : loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig.Value  = "" : ENDIF | Error in line 2443: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig) = "O"  : loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig.Value  = "" : ENDIF | Error in line 2444: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_CpfOrig) = "O"   : loc_oPg2.cnt_4c_Origem.txt_4c_CpfOrig.Value   = "" : ENDIF | Error in line 2445: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts) = "O"  : loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts.Value  = "" : ENDIF | Error in line 2448: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts) = "O"  : loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts.Value  = "" : ENDIF | Error in line 2449: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_DGruEmts) = "O" : loc_oPg2.cnt_4c_Despesa.txt_4c_DGruEmts.Value = "" : ENDIF | Error in line 2450: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_DConEmts) = "O" : loc_oPg2.cnt_4c_Despesa.txt_4c_DConEmts.Value = "" : ENDIF | Error in line 2451: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_CpfEmts) = "O"  : loc_oPg2.cnt_4c_Despesa.txt_4c_CpfEmts.Value  = "" : ENDIF | Error in line 2452: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo) = "O"   : loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value   = "" : ENDIF | Error in line 2455: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Conta) = "O"   : loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value   = "" : ENDIF | Error in line 2456: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DGrupo) = "O"  : loc_oPg2.cnt_4c_Destino.txt_4c_DGrupo.Value  = "" : ENDIF | Error in line 2457: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DConta) = "O"  : loc_oPg2.cnt_4c_Destino.txt_4c_DConta.Value  = "" : ENDIF | Error in line 2458: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest) = "O" : loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest.Value = "" : ENDIF | Error in line 2459: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs) = "O"  : loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs.Value  = "" : ENDIF | Error in line 2462: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs) = "O"  : loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs.Value  = "" : ENDIF | Error in line 2463: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_DGrupoCcs) = "O" : loc_oPg2.cnt_4c_CCusto.txt_4c_DGrupoCcs.Value = "" : ENDIF | Error in line 2464: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_DContaCcs) = "O" : loc_oPg2.cnt_4c_CCusto.txt_4c_DContaCcs.Value = "" : ENDIF | Error in line 2465: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_CpfCCs) = "O"    : loc_oPg2.cnt_4c_CCusto.txt_4c_CpfCCs.Value    = "" : ENDIF | Error in line 2466: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart) = "O"  : loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart.Value  = "" : ENDIF | Error in line 2469: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart) = "O"  : loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart.Value  = "" : ENDIF | Error in line 2470: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_DGruCart) = "O" : loc_oPg2.cnt_4c_Carteira.txt_4c_DGruCart.Value = "" : ENDIF | Error in line 2471: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_DConCart) = "O" : loc_oPg2.cnt_4c_Carteira.txt_4c_DConCart.Value = "" : ENDIF | Error in line 2472: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss) = "O"  : loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss.Value  = "" : ENDIF | Error in line 2475: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss) = "O"  : loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss.Value  = "" : ENDIF | Error in line 2476: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_DGruEmiss) = "O" : loc_oPg2.cnt_4c_Emissor.txt_4c_DGruEmiss.Value = "" : ENDIF | Error in line 2477: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_DConEmiss) = "O" : loc_oPg2.cnt_4c_Emissor.txt_4c_DConEmiss.Value = "" : ENDIF | Error in line 2478: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_CpfEmiss) = "O"  : loc_oPg2.cnt_4c_Emissor.txt_4c_CpfEmiss.Value  = "" : ENDIF | Error in line 2479: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"     : loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value     = "" : ENDIF | Error in line 2485: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"  : loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value  = "" : ENDIF | Error in line 2488: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"    : loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value    = "" : ENDIF | Error in line 2489: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"   : loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value   = "" : ENDIF | Error in line 2490: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes) = "O" : loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes.Value = "" : ENDIF | Error in line 2491: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes) = "O" : loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes.Value = "" : ENDIF | Error in line 2492: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_DConRes) = "O": loc_oPg2.cnt_4c_Responsavel.txt_4c_DConRes.Value = "" : ENDIF | Error in line 2493: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.edt_4c_Obs) = "O"                      : loc_oPg2.edt_4c_Obs.Value                      = "" : ENDIF | Error in line 2494: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs) = "O"      : loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs.Value      = "" : ENDIF | Error in line 2495: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.chk_4c_FollowUp) = "O"                 : loc_oPg2.chk_4c_FollowUp.Value                 = 0  : ENDIF | Error in line 2496: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.txt_4c_QtdeChqs) = "O"                  : loc_oPg2.txt_4c_QtdeChqs.Value                 = 0  : ENDIF | Error in line 2497: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.txt_4c_ValorTotal) = "O"               : loc_oPg2.txt_4c_ValorTotal.Value               = 0  : ENDIF | Error in line 2498: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.txt_4c_CondPagto) = "O"                : loc_oPg2.txt_4c_CondPagto.Value                = "" : ENDIF | Error in line 2499: Command contains unrecognized phrase/keyword. | Error in line 2500: An IF | ELSE | ENDIF statement is missing. | IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"         : loc_oPg2.txt_4c_Oper.Enabled         = loc_lEdicao : ENDIF | Error in line 2510: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"         : loc_oPg2.txt_4c_Data.Enabled          = loc_lEdicao : ENDIF | Error in line 2511: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.opt_4c_SNA) = "O"          : loc_oPg2.opt_4c_SNA.Enabled           = loc_lEdicao : ENDIF | Error in line 2512: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"   : loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Enabled    = loc_lEdicao : ENDIF | Error in line 2514: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O" : loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Enabled  = loc_lEdicao : ENDIF | Error in line 2515: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O" : loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Enabled = loc_lEdicao : ENDIF | Error in line 2517: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O" : loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig.Enabled = loc_lEdicao : ENDIF | Error in line 2518: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts) = "O": loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts.Enabled = loc_lEdicao : ENDIF | Error in line 2519: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts) = "O": loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts.Enabled = loc_lEdicao : ENDIF | Error in line 2520: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo) = "O"  : loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Enabled  = loc_lEdicao : ENDIF | Error in line 2521: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Conta) = "O"  : loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Enabled  = loc_lEdicao : ENDIF | Error in line 2522: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs) = "O": loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs.Enabled = loc_lEdicao : ENDIF | Error in line 2523: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs) = "O": loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs.Enabled = loc_lEdicao : ENDIF | Error in line 2524: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart) = "O": loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart.Enabled = loc_lEdicao : ENDIF | Error in line 2525: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart) = "O": loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart.Enabled = loc_lEdicao : ENDIF | Error in line 2526: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss) = "O": loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss.Enabled = loc_lEdicao : ENDIF | Error in line 2527: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss) = "O": loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss.Enabled = loc_lEdicao : ENDIF | Error in line 2528: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"   : loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Enabled    = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR") : ENDIF | Error in line 2529: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes) = "O": loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes.Enabled = loc_lEdicao : ENDIF | Error in line 2530: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes) = "O": loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes.Enabled = loc_lEdicao : ENDIF | Error in line 2531: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.edt_4c_Obs) = "O"                   : loc_oPg2.edt_4c_Obs.Enabled                    = loc_lEdicao : ENDIF | Error in line 2532: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs) = "O"   : loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs.Enabled    = loc_lEdicao : ENDIF | Error in line 2533: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.chk_4c_FollowUp) = "O"              : loc_oPg2.chk_4c_FollowUp.Enabled               = loc_lEdicao : ENDIF | Error in line 2534: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O": loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Enabled = loc_lEdicao : ENDIF | Error in line 2535: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cmd_4c_BtnExcluir) = "O"            : loc_oPg2.cmd_4c_BtnExcluir.Enabled             = loc_lEdicao : ENDIF | Error in line 2536: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cmd_4c_BtnMarca) = "O"              : loc_oPg2.cmd_4c_BtnMarca.Enabled               = loc_lEdicao : ENDIF | Error in line 2537: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cmd_4c_CmdExcCheque) = "O"          : loc_oPg2.cmd_4c_CmdExcCheque.Enabled           = loc_lEdicao : ENDIF | Error in line 2538: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cmd_4c_Comm_Ini) = "O"              : loc_oPg2.cmd_4c_Comm_Ini.Enabled               = loc_lEdicao : ENDIF | Error in line 2539: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cmd_4c_Comm_Fim) = "O"              : loc_oPg2.cmd_4c_Comm_Fim.Enabled               = loc_lEdicao : ENDIF | Error in line 2540: Command contains unrecognized phrase/keyword. | Error in line 2547: An IF | ELSE | ENDIF statement is missing. | IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"    : loc_oBotoes.cmd_4c_Incluir.Enabled    = .T. : ENDIF | Error in line 2559: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O" : loc_oBotoes.cmd_4c_Visualizar.Enabled = .T. : ENDIF | Error in line 2560: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"    : loc_oBotoes.cmd_4c_Alterar.Enabled    = .T. : ENDIF | Error in line 2561: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"    : loc_oBotoes.cmd_4c_Excluir.Enabled    = .T. : ENDIF | Error in line 2562: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"     : loc_oBotoes.cmd_4c_Buscar.Enabled     = .T. : ENDIF | Error in line 2563: Command contains unrecognized phrase/keyword. | Error in line 2571: An IF | ELSE | ENDIF statement is missing. | IF VARTYPE(loc_oPg2.txt_4c_Oper) != "O" : RETURN : ENDIF | Error in line 2580: Command contains unrecognized phrase/keyword. | IF EMPTY(loc_cOper) : RETURN : ENDIF | Error in line 2582: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_ValidOper") : USE IN cursor_4c_ValidOper : ENDIF | Error in line 2595: Command contains unrecognized phrase/keyword. | Error in line 2596: An IF | ELSE | ENDIF statement is missing. | IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) != "O" : RETURN : ENDIF | Error in line 2601: Command contains unrecognized phrase/keyword. | IF EMPTY(loc_cMoeda) : RETURN : ENDIF | Error in line 2603: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_ValidMoe") : USE IN cursor_4c_ValidMoe : ENDIF | Error in line 2616: Command contains unrecognized phrase/keyword. | Error in line 2617: An IF | ELSE | ENDIF statement is missing. | IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) != "O" : RETURN : ENDIF | Error in line 2678: Command contains unrecognized phrase/keyword. | IF EMPTY(loc_cEmps) : RETURN : ENDIF | Error in line 2680: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_ValidEmp") : USE IN cursor_4c_ValidEmp : ENDIF | Error in line 2702: Command contains unrecognized phrase/keyword. | Error in line 2703: An IF | ELSE | ENDIF statement is missing. | IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) != "O" : RETURN : ENDIF | Error in line 2708: Command contains unrecognized phrase/keyword. | IF EMPTY(loc_cConta) : RETURN : ENDIF | Error in line 2710: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"  : loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = "" : ENDIF | Error in line 2727: Command contains unrecognized phrase/keyword. | IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O" : loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = "" : ENDIF | Error in line 2728: Command contains unrecognized phrase/keyword. | CATCH TO loc_oErro | Error in line 2730: Nesting error. | ENDTRY | Error in line 2732: Nesting error. | IF USED("cursor_4c_ValidCli") : USE IN cursor_4c_ValidCli : ENDIF | Error in line 2733: Command contains unrecognized phrase/keyword. | Error in line 2734: An IF | ELSE | ENDIF statement is missing. | IF VARTYPE(loc_oCnt) != "O" : RETURN : ENDIF | Error in line 2749: Command contains unrecognized phrase/keyword. | IF EVALUATE("VARTYPE(loc_oCnt." + par_cTxtGru + ")") != "O" : RETURN : ENDIF | Error in line 2751: Command contains unrecognized phrase/keyword. | IF EMPTY(loc_cGrupo) : RETURN : ENDIF | Error in line 2755: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_DescGru") : USE IN cursor_4c_DescGru : ENDIF | Error in line 2783: Command contains unrecognized phrase/keyword. | Error in line 2784: An IF | ELSE | ENDIF statement is missing. | IF VARTYPE(loc_oCnt) != "O" : RETURN : ENDIF | Error in line 2799: Command contains unrecognized phrase/keyword. | IF EVALUATE("VARTYPE(loc_oCnt." + par_cTxtCon + ")") != "O" : RETURN : ENDIF | Error in line 2800: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_DescCon") : USE IN cursor_4c_DescCon : ENDIF | Error in line 2828: Command contains unrecognized phrase/keyword. | Error in line 2829: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_Dados")       : USE IN cursor_4c_Dados       : ENDIF | Error in line 2874: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_Cheques")      : USE IN cursor_4c_Cheques      : ENDIF | Error in line 2875: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_ChequesM")     : USE IN cursor_4c_ChequesM     : ENDIF | Error in line 2876: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_BuscaLch")     : USE IN cursor_4c_BuscaLch     : ENDIF | Error in line 2877: Command contains unrecognized phrase/keyword. | CATCH TO loc_oErro | Error in line 2882: Nesting error. | ENDTRY | Error in line 2884: Nesting error. | Error in line 2887: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupOper() : ENDIF | Error in line 2927: Command contains unrecognized phrase/keyword. | Error in line 2928: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupMoeda() : ENDIF | Error in line 2931: Command contains unrecognized phrase/keyword. | Error in line 2932: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Origem",  "txt_4c_GruOrig", "txt_4c_DGruOrig") : ENDIF | Error in line 2935: Command contains unrecognized phrase/keyword. | Error in line 2936: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Origem",  "txt_4c_ConOrig", "txt_4c_DConOrig") : ENDIF | Error in line 2939: Command contains unrecognized phrase/keyword. | Error in line 2940: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_Origem",   "txt_4c_CpfOrig") : ENDIF | Error in line 2943: Command contains unrecognized phrase/keyword. | Error in line 2944: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Despesa", "txt_4c_GruEmts", "txt_4c_DGruEmts") : ENDIF | Error in line 2947: Command contains unrecognized phrase/keyword. | Error in line 2948: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Despesa", "txt_4c_ConEmts", "txt_4c_DConEmts") : ENDIF | Error in line 2951: Command contains unrecognized phrase/keyword. | Error in line 2952: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_Despesa",  "txt_4c_CpfEmts") : ENDIF | Error in line 2955: Command contains unrecognized phrase/keyword. | Error in line 2956: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Destino", "txt_4c_Grupo",   "txt_4c_DGrupo") : ENDIF | Error in line 2959: Command contains unrecognized phrase/keyword. | Error in line 2960: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Destino", "txt_4c_Conta",   "txt_4c_DConta") : ENDIF | Error in line 2963: Command contains unrecognized phrase/keyword. | Error in line 2964: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_Destino",  "txt_4c_CpfDest") : ENDIF | Error in line 2967: Command contains unrecognized phrase/keyword. | Error in line 2968: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_CCusto",  "txt_4c_GrupoCcs","txt_4c_DGrupoCcs") : ENDIF | Error in line 2971: Command contains unrecognized phrase/keyword. | Error in line 2972: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_CCusto",  "txt_4c_ContaCcs","txt_4c_DContaCcs") : ENDIF | Error in line 2975: Command contains unrecognized phrase/keyword. | Error in line 2976: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_CCusto",   "txt_4c_CpfCCs") : ENDIF | Error in line 2979: Command contains unrecognized phrase/keyword. | Error in line 2980: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Carteira","txt_4c_GruCart", "txt_4c_DGruCart") : ENDIF | Error in line 2983: Command contains unrecognized phrase/keyword. | Error in line 2984: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Carteira","txt_4c_ConCart", "txt_4c_DConCart") : ENDIF | Error in line 2987: Command contains unrecognized phrase/keyword. | Error in line 2988: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Emissor", "txt_4c_GruEmiss","txt_4c_DGruEmiss") : ENDIF | Error in line 2991: Command contains unrecognized phrase/keyword. | Error in line 2992: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Emissor", "txt_4c_ConEmiss","txt_4c_DConEmiss") : ENDIF | Error in line 2995: Command contains unrecognized phrase/keyword. | Error in line 2996: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_Emissor",  "txt_4c_CpfEmiss") : ENDIF | Error in line 2999: Command contains unrecognized phrase/keyword. | Error in line 3000: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupAlinea() : ENDIF | Error in line 3003: Command contains unrecognized phrase/keyword. | Error in line 3004: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupEmpresa() : ENDIF | Error in line 3007: Command contains unrecognized phrase/keyword. | Error in line 3008: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupContaIclis() : ENDIF | Error in line 3011: Command contains unrecognized phrase/keyword. | Error in line 3012: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupClasemp() : ENDIF | Error in line 3015: Command contains unrecognized phrase/keyword. | Error in line 3016: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Responsavel","txt_4c_GruRes","") : ENDIF | Error in line 3019: Command contains unrecognized phrase/keyword. | Error in line 3020: An IF | ELSE | ENDIF statement is missing. | IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Responsavel","txt_4c_ConRes","txt_4c_DConRes") : ENDIF | Error in line 3023: Command contains unrecognized phrase/keyword. | Error in line 3024: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_BuscaOper") : USE IN cursor_4c_BuscaOper : ENDIF | Error in line 3057: Command contains unrecognized phrase/keyword. | Error in line 3059: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_BuscaMoe") : USE IN cursor_4c_BuscaMoe : ENDIF | Error in line 3095: Command contains unrecognized phrase/keyword. | Error in line 3097: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_BuscaGru") : USE IN cursor_4c_BuscaGru : ENDIF | Error in line 3143: Command contains unrecognized phrase/keyword. | Error in line 3145: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_BuscaCon") : USE IN cursor_4c_BuscaCon : ENDIF | Error in line 3191: Command contains unrecognized phrase/keyword. | Error in line 3193: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_BuscaCpf") : USE IN cursor_4c_BuscaCpf : ENDIF | Error in line 3234: Command contains unrecognized phrase/keyword. | Error in line 3236: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_BuscaEmp") : USE IN cursor_4c_BuscaEmp : ENDIF | Error in line 3279: Command contains unrecognized phrase/keyword. | Error in line 3281: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_BuscaIclis") : USE IN cursor_4c_BuscaIclis : ENDIF | Error in line 3327: Command contains unrecognized phrase/keyword. | Error in line 3329: An IF | ELSE | ENDIF statement is missing. | SCATTER MEMVAR MEMO FROM cursor_4c_BuscaGre | Error in line 3352: Command contains unrecognized phrase/keyword. | IF USED("cursor_4c_BuscaGre") : USE IN cursor_4c_BuscaGre : ENDIF | Error in line 3365: Command contains unrecognized phrase/keyword. | Error in line 3367: An IF | ELSE | ENDIF statement is missing. | IF USED("cursor_4c_BuscaAli") : USE IN cursor_4c_BuscaAli : ENDIF | Error in line 3403: Command contains unrecognized phrase/keyword. | Error in line 3405: An IF | ELSE | ENDIF statement is missing. | Error in line 3407: An IF | ELSE | ENDIF statement is missing. | 

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formlch.prg):
*==============================================================================
* Formlch.prg - Formulario de Lote de Cheques
* SIGCDLCH migrado para nova arquitetura em camadas
* Herda de  : FormBase
* BO        : lchBO
* Tabela    : SigChLcq (PK: numlotes)
* Tabela ch.: SIGCHE   (cheques do lote)
* Tipo      : CRUD (frmcadastro) - 2 paginas (Lista / Dados)
*==============================================================================

DEFINE CLASS Formlch AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Lote de Cheques"
    DataSession = 2
    ShowWindow = 1
    AutoCenter  = .T.
    ShowWindow   = 0
    WindowType   = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Estado do form
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - chama DODEFAULT() (FormBase.Init faz SET DATE BRITISH + SET CENTURY ON)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria BO, monta PageFrame, carrega lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("lchBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar lchBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.InicializarForm")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas (Lista / Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas
        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
    * +29 em todos os Top pelo PageFrame.Top=-29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        LOCAL loc_oCnt, loc_oCntP

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top = 29 .Left = 0 .Width = THIS.Width .Height = 80
            .BackColor = RGB(100, 100, 100) .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Caption = THIS.Caption .AutoSize = .F. .Width = THIS.Width .Height = 40
            .Top = 15 .Left = 10 .FontName = "Tahoma" .FontSize = 16 .FontBold = .T.
            .ForeColor = RGB(0, 0, 0) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Caption = THIS.Caption .AutoSize = .F. .Width = THIS.Width .Height = 46
            .Top = 18 .Left = 10 .FontName = "Tahoma" .FontSize = 16 .FontBold = .T.
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        *-- Botoes CRUD
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top = 29 .Left = 542 .Width = 385 .Height = 85
            .BackStyle = 1 .BackColor = RGB(53, 53, 53) .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Top = 5 .Left = 5 .Width = 75 .Height = 75 .Caption = "Incluir"
            .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg" .PicturePosition = 13
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Top = 5 .Left = 80 .Width = 75 .Height = 75 .Caption = "Visualizar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg" .PicturePosition = 13
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Top = 5 .Left = 155 .Width = 75 .Height = 75 .Caption = "Alterar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg" .PicturePosition = 13
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Top = 5 .Left = 230 .Width = 75 .Height = 75 .Caption = "Excluir"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg" .PicturePosition = 13
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Top = 5 .Left = 305 .Width = 75 .Height = 75 .Caption = "Buscar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg" .PicturePosition = 13
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Saida canonico (Left=917)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top = 29 .Left = 917 .Width = 90 .Height = 85
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Top = 5 .Left = 5 .Width = 75 .Height = 75 .Caption = "Encerrar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg" .PicturePosition = 13
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Filtro de periodo (cntFiltros > cnt__periodo > Dt_inicial/Dt_final)
        *-- original top=86+29=115
        loc_oPg1.AddObject("cnt_4c_Filtros", "Container")
        loc_oCnt = loc_oPg1.cnt_4c_Filtros
        WITH loc_oCnt
            .Top = 115 .Left = 5 .Width = 267 .Height = 46
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("cnt_4c__periodo", "Container")
        loc_oCntP = loc_oCnt.cnt_4c__periodo
        WITH loc_oCntP
            .Top = 3 .Left = 0 .Width = 267 .Height = 40
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oCntP.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oCntP.lbl_4c_LblPeriodo
            .Caption = "Per" + CHR(237) + "odo : " .Top = 6 .Left = 23 .Width = 48 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCntP.AddObject("txt_4c_Dt_inicial", "TextBox")
        WITH loc_oCntP.txt_4c_Dt_inicial
            .Top = 2 .Left = 70 .Width = 80 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oCntP.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oCntP.lbl_4c_Sep
            .Caption = CHR(224) .Top = 6 .Left = 152 .Width = 10 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCntP.AddObject("txt_4c_Dt_final", "TextBox")
        WITH loc_oCntP.txt_4c_Dt_final
            .Top = 2 .Left = 167 .Width = 80 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *-- Situacao (Cmb_Concilia) - top=113+29=142
        loc_oPg1.AddObject("lbl_4c_Situacao", "Label")
        WITH loc_oPg1.lbl_4c_Situacao
            .Caption = "Situa" + CHR(231) + CHR(227) + "o :" .Top = 146 .Left = 39 .Width = 55 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg1.AddObject("cbo_4c_Cmb_Concilia", "ComboBox")
        WITH loc_oPg1.cbo_4c_Cmb_Concilia
            .Top = 142 .Left = 96 .Width = 178 .Height = 24
            .RowSourceType = 1
            .RowSource = "Todos,Conciliados,Pendentes,Ambos"
            .Style = 2 .ListIndex = 1
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.cbo_4c_Cmb_Concilia, "InteractiveChange", THIS, "CboConcilaChange")

        *-- Botao Limpar Data - top=86+29=115, left=271
        loc_oPg1.AddObject("cmd_4c_LimpaDT", "CommandButton")
        WITH loc_oPg1.cmd_4c_LimpaDT
            .Top = 115 .Left = 271 .Width = 75 .Height = 75
            .Caption = "Limpar Data"
            .FontName = "Tahoma" .FontBold = .F. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.cmd_4c_LimpaDT, "Click", THIS, "BtnLimpaDTClick")

        *-- Botao Conciliacao - top=86+29=115, left=347
        loc_oPg1.AddObject("cmd_4c_Conciliacao", "CommandButton")
        WITH loc_oPg1.cmd_4c_Conciliacao
            .Top = 115 .Left = 347 .Width = 75 .Height = 75
            .Caption = "Concilia" + CHR(231) + CHR(227) + "o"
            .FontName = "Tahoma" .FontBold = .F. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.cmd_4c_Conciliacao, "Click", THIS, "BtnConciliacaoClick")

        *-- Grid lista de lotes - top=193, left=5
        loc_oPg1.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Dados
        loc_oGrid.ColumnCount = 6
        WITH loc_oGrid
            .Top = 193 .Left = 5 .Width = 990 .Height = 435
            .FontName = "Verdana" .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .GridLineColor = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle = 2
            .DeleteMark = .F. .RecordMark = .F.
            .RowHeight = 16 .ScrollBars = 2 .GridLines = 3 .Visible = .T.
        ENDWITH
        WITH loc_oGrid.Column1
            .Width = 60 .Header1.Caption = "Lote"
        ENDWITH
        WITH loc_oGrid.Column2
            .Width = 80 .Header1.Caption = "Empresa"
        ENDWITH
        WITH loc_oGrid.Column3
            .Width = 90 .Header1.Caption = "Data Entrada"
        ENDWITH
        WITH loc_oGrid.Column4
            .Width = 100 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
        ENDWITH
        WITH loc_oGrid.Column5
            .Width = 110 .Header1.Caption = "Valor Total"
        ENDWITH
        WITH loc_oGrid.Column6
            .Width = 80 .Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: todos os containers e campos de edicao
    * Posicoes: layout.json + 29 (compensacao PageFrame.Top=-29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva, loc_oInf, loc_oOrig, loc_oDes
        LOCAL loc_oDst, loc_oCC, loc_oCart, loc_oProc, loc_oEmiss
        LOCAL loc_oGrd, loc_oChe, loc_oEmp, loc_oCnt, loc_oFil
        LOCAL loc_oRes, loc_oFol, loc_oGrid

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *=====================================================================
        *-- cnt_4c_Salva (Confirmar/Cancelar) - substitui cmdGrpBotoes legado
        *-- original: top=0+29=29, posicao na coluna direita
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top = 29 .Left = 853 .Width = 160 .Height = 85
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
            .Top = 5 .Left = 5 .Width = 75 .Height = 75 .Caption = "Confirmar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg" .PicturePosition = 13
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
            .Top = 5 .Left = 80 .Width = 75 .Height = 75 .Caption = "Encerrar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg" .PicturePosition = 13
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *=====================================================================
        *-- Linha 1: Usuario / Lote / Data
        *-- original: top=9+29=38 (textboxes), top=12+29=41 (labels)
        *=====================================================================
        loc_oPg2.AddObject("lbl_4c_Usuar", "Label")
        WITH loc_oPg2.lbl_4c_Usuar
            .Caption = "Usu" + CHR(225) + "rio :" .Top = 41 .Left = 36 .Width = 52 .Height = 18
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Usuar", "TextBox")
        WITH loc_oPg2.txt_4c_Usuar
            .Top = 38 .Left = 86 .Width = 80 .Height = 21
            .MaxLength = 15 .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Lote", "Label")
        WITH loc_oPg2.lbl_4c_Lote
            .Caption = "Lote :" .Top = 41 .Left = 181 .Width = 32 .Height = 18
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Lote", "TextBox")
        WITH loc_oPg2.txt_4c_Lote
            .Top = 38 .Left = 215 .Width = 70 .Height = 21
            .Value = 0 .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_DataEnt", "Label")
        WITH loc_oPg2.lbl_4c_DataEnt
            .Caption = "Data :" .Top = 41 .Left = 300 .Width = 35 .Height = 18
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPg2.txt_4c_Data
            .Top = 38 .Left = 337 .Width = 85 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *-- OptionGroup SNA (Todos/Pendentes/Conciliados)
        *-- original: top=30+29=59, left=209
        loc_oPg2.AddObject("opt_4c_SNA", "OptionGroup")
        WITH loc_oPg2.opt_4c_SNA
            .Top = 59 .Left = 209 .Width = 153 .Height = 25
            .ButtonCount = 3 .BackStyle = 0 .Value = 1 .Visible = .T.
            .Buttons(1).Caption = "Todos"
            .Buttons(2).Caption = "Pend."
            .Buttons(3).Caption = "Concil."
        ENDWITH

        *-- Movimento / Operacao - original: top=32+29=61 (txt), top=35+29=64 (lbl)
        loc_oPg2.AddObject("lbl_4c_Movimento", "Label")
        WITH loc_oPg2.lbl_4c_Movimento
            .Caption = "Movimento :" .Top = 64 .Left = 23 .Width = 62 .Height = 18
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Oper", "TextBox")
        WITH loc_oPg2.txt_4c_Oper
            .Top = 61 .Left = 86 .Width = 117 .Height = 21
            .MaxLength = 15 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Oper, "KeyPress", THIS, "ValidarOper")

        *=====================================================================
        *-- cnt_4c_Infos - Cheques/Moeda/Cotacao/Valores
        *-- original: top=52+29=81, left=6, width=464, height=53
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Infos", "Container")
        loc_oInf = loc_oPg2.cnt_4c_Infos
        WITH loc_oInf
            .Top = 81 .Left = 6 .Width = 464 .Height = 53
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("lbl_4c_Cheques", "Label")
        WITH loc_oInf.lbl_4c_Cheques
            .Caption = "Cheques :" .Top = 6 .Left = 27 .Width = 52 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("txt_4c_Qtde", "TextBox")
        WITH loc_oInf.txt_4c_Qtde
            .Top = 3 .Left = 80 .Width = 70 .Height = 21
            .Value = 0 .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oInf.lbl_4c_Moeda
            .Caption = "Moeda :" .Top = 6 .Left = 159 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oInf.txt_4c_Moeda
            .Top = 3 .Left = 202 .Width = 32 .Height = 21
            .MaxLength = 5 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oInf.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")

        loc_oInf.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
        WITH loc_oInf.cmd_4c_AlteraCotacao
            .Top = 1 .Left = 236 .Width = 24 .Height = 23 .Caption = "$"
            .FontName = "Tahoma" .FontBold = .T. .FontSize = 10
            .BackColor = RGB(255, 255, 255) .Themes = .T. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oInf.cmd_4c_AlteraCotacao, "Click", THIS, "BtnAlteraCotacaoClick")

        loc_oInf.AddObject("lbl_4c_Cotacao", "Label")
        WITH loc_oInf.lbl_4c_Cotacao
            .Caption = "Cota" + CHR(231) + CHR(227) + "o :" .Top = 6 .Left = 281 .Width = 50 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("txt_4c_Cotacao", "TextBox")
        WITH loc_oInf.txt_4c_Cotacao
            .Top = 3 .Left = 332 .Width = 108 .Height = 21
            .Value = 0 .InputMask = "99999999.9999"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("lbl_4c_Valor", "Label")
        WITH loc_oInf.lbl_4c_Valor
            .Caption = "Valor :" .Top = 29 .Left = 45 .Width = 35 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oInf.txt_4c_Valor
            .Top = 26 .Left = 80 .Width = 154 .Height = 21
            .Value = 0 .ReadOnly = .T. .InputMask = "999999999.99"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("lbl_4c_ValConv", "Label")
        WITH loc_oInf.lbl_4c_ValConv
            .Caption = "Convertido :" .Top = 29 .Left = 268 .Width = 62 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oInf.AddObject("txt_4c_ValConv", "TextBox")
        WITH loc_oInf.txt_4c_ValConv
            .Top = 26 .Left = 332 .Width = 108 .Height = 21
            .Value = 0 .ReadOnly = .T. .InputMask = "999999999.99"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Origem - top=106+29=135, left=6, width=464, height=58
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Origem", "Container")
        loc_oOrig = loc_oPg2.cnt_4c_Origem
        WITH loc_oOrig
            .Top = 135 .Left = 6 .Width = 464 .Height = 58
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oOrig.AddObject("lbl_4c_TitOrigem", "Label")
        WITH loc_oOrig.lbl_4c_TitOrigem
            .Caption = "Origem" .Top = 0 .Left = 4 .Width = 60 .Height = 14
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T.
            .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oOrig.AddObject("lbl_4c_GruOrig", "Label")
        WITH loc_oOrig.lbl_4c_GruOrig
            .Caption = "Grupo :" .Top = 15 .Left = 18 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oOrig.AddObject("txt_4c_GruOrig", "TextBox")
        WITH loc_oOrig.txt_4c_GruOrig
            .Top = 12 .Left = 61 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oOrig.txt_4c_GruOrig, "KeyPress", THIS, "ValidarGrupoOrig")

        loc_oOrig.AddObject("txt_4c_DGruOrig", "TextBox")
        WITH loc_oOrig.txt_4c_DGruOrig
            .Top = 12 .Left = 142 .Width = 319 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oOrig.AddObject("lbl_4c_ConOrig", "Label")
        WITH loc_oOrig.lbl_4c_ConOrig
            .Caption = "Conta :" .Top = 38 .Left = 18 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oOrig.AddObject("txt_4c_ConOrig", "TextBox")
        WITH loc_oOrig.txt_4c_ConOrig
            .Top = 35 .Left = 61 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oOrig.txt_4c_ConOrig, "KeyPress", THIS, "ValidarContaOrig")

        loc_oOrig.AddObject("txt_4c_CpfOrig", "TextBox")
        WITH loc_oOrig.txt_4c_CpfOrig
            .Top = 35 .Left = 142 .Width = 115 .Height = 21
            .MaxLength = 14 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oOrig.AddObject("txt_4c_DConOrig", "TextBox")
        WITH loc_oOrig.txt_4c_DConOrig
            .Top = 35 .Left = 259 .Width = 202 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Despesa - top=106+29=135, left=497, width=464, height=58
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Despesa", "Container")
        loc_oDes = loc_oPg2.cnt_4c_Despesa
        WITH loc_oDes
            .Top = 135 .Left = 497 .Width = 464 .Height = 58
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oDes.AddObject("lbl_4c_TitDespesa", "Label")
        WITH loc_oDes.lbl_4c_TitDespesa
            .Caption = "Despesa" .Top = 0 .Left = 4 .Width = 60 .Height = 14
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T.
            .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oDes.AddObject("lbl_4c_GruEmts", "Label")
        WITH loc_oDes.lbl_4c_GruEmts
            .Caption = "Grupo :" .Top = 15 .Left = 18 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oDes.AddObject("txt_4c_GruEmts", "TextBox")
        WITH loc_oDes.txt_4c_GruEmts
            .Top = 12 .Left = 61 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oDes.txt_4c_GruEmts, "KeyPress", THIS, "ValidarGrupoEmts")

        loc_oDes.AddObject("txt_4c_DGruEmts", "TextBox")
        WITH loc_oDes.txt_4c_DGruEmts
            .Top = 12 .Left = 142 .Width = 319 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oDes.AddObject("lbl_4c_ConEmts", "Label")
        WITH loc_oDes.lbl_4c_ConEmts
            .Caption = "Conta :" .Top = 38 .Left = 18 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oDes.AddObject("txt_4c_ConEmts", "TextBox")
        WITH loc_oDes.txt_4c_ConEmts
            .Top = 35 .Left = 61 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oDes.txt_4c_ConEmts, "KeyPress", THIS, "ValidarContaEmts")

        loc_oDes.AddObject("txt_4c_CpfEmts", "TextBox")
        WITH loc_oDes.txt_4c_CpfEmts
            .Top = 35 .Left = 142 .Width = 115 .Height = 21
            .MaxLength = 14 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oDes.AddObject("txt_4c_DConEmts", "TextBox")
        WITH loc_oDes.txt_4c_DConEmts
            .Top = 35 .Left = 259 .Width = 202 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Destino - top=166+29=195, left=6, width=464, height=58
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Destino", "Container")
        loc_oDst = loc_oPg2.cnt_4c_Destino
        WITH loc_oDst
            .Top = 195 .Left = 6 .Width = 464 .Height = 58
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oDst.AddObject("lbl_4c_TitDestino", "Label")
        WITH loc_oDst.lbl_4c_TitDestino
            .Caption = "Destino" .Top = 0 .Left = 4 .Width = 60 .Height = 14
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T.
            .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oDst.AddObject("lbl_4c_GruDest", "Label")
        WITH loc_oDst.lbl_4c_GruDest
            .Caption = "Grupo :" .Top = 15 .Left = 17 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oDst.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oDst.txt_4c_Grupo
            .Top = 12 .Left = 60 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oDst.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoDest")

        loc_oDst.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oDst.txt_4c_DGrupo
            .Top = 12 .Left = 141 .Width = 320 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oDst.AddObject("lbl_4c_ConDest", "Label")
        WITH loc_oDst.lbl_4c_ConDest
            .Caption = "Conta :" .Top = 38 .Left = 17 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oDst.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oDst.txt_4c_Conta
            .Top = 35 .Left = 60 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oDst.txt_4c_Conta, "KeyPress", THIS, "ValidarContaDest")

        loc_oDst.AddObject("txt_4c_CpfDest", "TextBox")
        WITH loc_oDst.txt_4c_CpfDest
            .Top = 35 .Left = 141 .Width = 115 .Height = 21
            .MaxLength = 14 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oDst.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oDst.txt_4c_DConta
            .Top = 35 .Left = 258 .Width = 203 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_CCusto - Centro de Custo
        *-- top=166+29=195, left=497, width=464, height=58
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_CCusto", "Container")
        loc_oCC = loc_oPg2.cnt_4c_CCusto
        WITH loc_oCC
            .Top = 195 .Left = 497 .Width = 464 .Height = 58
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oCC.AddObject("lbl_4c_TitCC", "Label")
        WITH loc_oCC.lbl_4c_TitCC
            .Caption = "Centro de Custo" .Top = 0 .Left = 4 .Width = 100 .Height = 14
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T.
            .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCC.AddObject("lbl_4c_GruCC", "Label")
        WITH loc_oCC.lbl_4c_GruCC
            .Caption = "Grupo :" .Top = 15 .Left = 17 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCC.AddObject("txt_4c_GrupoCcs", "TextBox")
        WITH loc_oCC.txt_4c_GrupoCcs
            .Top = 12 .Left = 60 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCC.txt_4c_GrupoCcs, "KeyPress", THIS, "ValidarGrupoCC")

        loc_oCC.AddObject("txt_4c_DGrupoCcs", "TextBox")
        WITH loc_oCC.txt_4c_DGrupoCcs
            .Top = 12 .Left = 141 .Width = 320 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oCC.AddObject("lbl_4c_ConCC", "Label")
        WITH loc_oCC.lbl_4c_ConCC
            .Caption = "Conta :" .Top = 38 .Left = 17 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCC.AddObject("txt_4c_ContaCcs", "TextBox")
        WITH loc_oCC.txt_4c_ContaCcs
            .Top = 35 .Left = 60 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCC.txt_4c_ContaCcs, "KeyPress", THIS, "ValidarContaCC")

        loc_oCC.AddObject("txt_4c_CpfCCs", "TextBox")
        WITH loc_oCC.txt_4c_CpfCCs
            .Top = 35 .Left = 141 .Width = 115 .Height = 21
            .MaxLength = 14 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oCC.AddObject("txt_4c_DContaCcs", "TextBox")
        WITH loc_oCC.txt_4c_DContaCcs
            .Top = 35 .Left = 258 .Width = 203 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Carteira - top=225+29=254, left=6, width=464, height=58
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Carteira", "Container")
        loc_oCart = loc_oPg2.cnt_4c_Carteira
        WITH loc_oCart
            .Top = 254 .Left = 6 .Width = 464 .Height = 58
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oCart.AddObject("lbl_4c_TitCart", "Label")
        WITH loc_oCart.lbl_4c_TitCart
            .Caption = "Carteira" .Top = 0 .Left = 4 .Width = 60 .Height = 14
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T.
            .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCart.AddObject("lbl_4c_GruCart", "Label")
        WITH loc_oCart.lbl_4c_GruCart
            .Caption = "Grupo :" .Top = 15 .Left = 17 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCart.AddObject("txt_4c_GruCart", "TextBox")
        WITH loc_oCart.txt_4c_GruCart
            .Top = 12 .Left = 60 .Width = 80 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCart.txt_4c_GruCart, "KeyPress", THIS, "ValidarGrupoCart")

        loc_oCart.AddObject("txt_4c_DGruCart", "TextBox")
        WITH loc_oCart.txt_4c_DGruCart
            .Top = 12 .Left = 142 .Width = 319 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oCart.AddObject("lbl_4c_ConCart", "Label")
        WITH loc_oCart.lbl_4c_ConCart
            .Caption = "Conta :" .Top = 38 .Left = 17 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCart.AddObject("txt_4c_ConCart", "TextBox")
        WITH loc_oCart.txt_4c_ConCart
            .Top = 35 .Left = 60 .Width = 80 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCart.txt_4c_ConCart, "KeyPress", THIS, "ValidarContaCart")

        loc_oCart.AddObject("txt_4c_DConCart", "TextBox")
        WITH loc_oCart.txt_4c_DConCart
            .Top = 35 .Left = 142 .Width = 319 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Processa - Processamento em lote
        *-- top=225+29=254, left=497, width=480, height=58
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Processa", "Container")
        loc_oProc = loc_oPg2.cnt_4c_Processa
        WITH loc_oProc
            .Top = 254 .Left = 497 .Width = 480 .Height = 58
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oProc.lbl_4c_LblPeriodo
            .Caption = "Per" + CHR(237) + "odo :" .Top = 8 .Left = 21 .Width = 46 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("txt_4c_FweditdataIni", "TextBox")
        WITH loc_oProc.txt_4c_FweditdataIni
            .Top = 5 .Left = 68 .Width = 80 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("lbl_4c_SepProc", "Label")
        WITH loc_oProc.lbl_4c_SepProc
            .Caption = CHR(224) .Top = 9 .Left = 152 .Width = 10 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("txt_4c_FweditdataFin", "TextBox")
        WITH loc_oProc.txt_4c_FweditdataFin
            .Top = 5 .Left = 165 .Width = 80 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("lbl_4c_LblEmpProc", "Label")
        WITH loc_oProc.lbl_4c_LblEmpProc
            .Caption = "Empresa :" .Top = 34 .Left = 17 .Width = 50 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("txt_4c_EmpProc", "TextBox")
        WITH loc_oProc.txt_4c_EmpProc
            .Top = 31 .Left = 68 .Width = 31 .Height = 21
            .MaxLength = 3 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("lbl_4c_LblLoteProc", "Label")
        WITH loc_oProc.lbl_4c_LblLoteProc
            .Caption = "Lote :" .Top = 34 .Left = 131 .Width = 35 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("txt_4c_LoteProc", "TextBox")
        WITH loc_oProc.txt_4c_LoteProc
            .Top = 31 .Left = 165 .Width = 52 .Height = 21
            .Value = 0
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("lbl_4c_LblPlanilha", "Label")
        WITH loc_oProc.lbl_4c_LblPlanilha
            .Caption = "Planilha :" .Top = 34 .Left = 237 .Width = 48 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("txt_4c_Planilha", "TextBox")
        WITH loc_oProc.txt_4c_Planilha
            .Top = 31 .Left = 285 .Width = 120 .Height = 21
            .MaxLength = 250 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oProc.AddObject("cmd_4c_Sel_Planilha", "CommandButton")
        WITH loc_oProc.cmd_4c_Sel_Planilha
            .Top = 29 .Left = 406 .Width = 24 .Height = 24 .Caption = "..."
            .FontName = "Tahoma" .FontSize = 8
            .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oProc.cmd_4c_Sel_Planilha, "Click", THIS, "BtnSelPlanilhaClick")

        loc_oProc.AddObject("lbl_4c_Mensagem", "Label")
        WITH loc_oProc.lbl_4c_Mensagem
            .Caption = "" .Top = 133 .Left = 13 .Width = 2 .Height = 15
            .AutoSize = .T. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(200, 0, 0) .BackStyle = 0 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Emissor - top=284+29=313, left=6, width=464, height=58
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Emissor", "Container")
        loc_oEmiss = loc_oPg2.cnt_4c_Emissor
        WITH loc_oEmiss
            .Top = 313 .Left = 6 .Width = 464 .Height = 58
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oEmiss.AddObject("lbl_4c_TitEmissor", "Label")
        WITH loc_oEmiss.lbl_4c_TitEmissor
            .Caption = "Emissor" .Top = 0 .Left = 4 .Width = 60 .Height = 14
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .FontBold = .T.
            .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oEmiss.AddObject("lbl_4c_GruEmiss", "Label")
        WITH loc_oEmiss.lbl_4c_GruEmiss
            .Caption = "Grupo :" .Top = 15 .Left = 18 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oEmiss.AddObject("txt_4c_GruEmiss", "TextBox")
        WITH loc_oEmiss.txt_4c_GruEmiss
            .Top = 12 .Left = 61 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oEmiss.txt_4c_GruEmiss, "KeyPress", THIS, "ValidarGrupoEmiss")

        loc_oEmiss.AddObject("txt_4c_DGruEmiss", "TextBox")
        WITH loc_oEmiss.txt_4c_DGruEmiss
            .Top = 12 .Left = 142 .Width = 319 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oEmiss.AddObject("lbl_4c_ConEmiss", "Label")
        WITH loc_oEmiss.lbl_4c_ConEmiss
            .Caption = "Conta :" .Top = 38 .Left = 18 .Width = 42 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oEmiss.AddObject("txt_4c_ConEmiss", "TextBox")
        WITH loc_oEmiss.txt_4c_ConEmiss
            .Top = 35 .Left = 61 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oEmiss.txt_4c_ConEmiss, "KeyPress", THIS, "ValidarContaEmiss")

        loc_oEmiss.AddObject("txt_4c_CpfEmiss", "TextBox")
        WITH loc_oEmiss.txt_4c_CpfEmiss
            .Top = 35 .Left = 142 .Width = 115 .Height = 21
            .MaxLength = 14 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oEmiss.AddObject("txt_4c_DConEmiss", "TextBox")
        WITH loc_oEmiss.txt_4c_DConEmiss
            .Top = 35 .Left = 259 .Width = 202 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- Observacao (fwmemo1) - EditBox
        *-- original: top=288+29=317, left=581, width=391, height=48
        *=====================================================================
        loc_oPg2.AddObject("lbl_4c_Observacao", "Label")
        WITH loc_oPg2.lbl_4c_Observacao
            .Caption = "Observa" + CHR(231) + CHR(227) + "o :" .Top = 319 .Left = 509 .Width = 70 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("edt_4c_Obs", "EditBox")
        WITH loc_oPg2.edt_4c_Obs
            .Top = 317 .Left = 581 .Width = 391 .Height = 48
            .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .ScrollBars = 2 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Grade (GradeCheque - 12 colunas)
        *-- top=345+29=374, left=5, width=759, height=94
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Grade", "Container")
        WITH loc_oPg2.cnt_4c_Grade
            .Top = 374 .Left = 5 .Width = 759 .Height = 94
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.cnt_4c_Grade.AddObject("grd_4c_Cheques", "Grid")
        loc_oGrid = loc_oPg2.cnt_4c_Grade.grd_4c_Cheques
        loc_oGrid.ColumnCount = 12
        WITH loc_oGrid
            .Top = 0 .Left = 0 .Width = 759 .Height = 93
            .FontName = "Verdana" .FontSize = 7
            .ForeColor = RGB(90, 90, 90) .BackColor = RGB(255, 255, 255)
            .GridLineColor = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle = 2
            .DeleteMark = .F. .RecordMark = .F.
            .RowHeight = 16 .ScrollBars = 3 .GridLines = 3 .Visible = .T.
        ENDWITH
        WITH loc_oGrid.Column1
            .Width = 30 .Header1.Caption = "Bco"
        ENDWITH
        WITH loc_oGrid.Column2
            .Width = 38 .Header1.Caption = "Ag" + CHR(234) + "ncia"
        ENDWITH
        WITH loc_oGrid.Column3
            .Width = 70 .Header1.Caption = "N" + CHR(176) + " Conta"
        ENDWITH
        WITH loc_oGrid.Column4
            .Width = 65 .Header1.Caption = "N" + CHR(176) + " Chq"
        ENDWITH
        WITH loc_oGrid.Column5
            .Width = 75 .Header1.Caption = "Valor"
        ENDWITH
        WITH loc_oGrid.Column6
            .Width = 75 .Header1.Caption = "Vencimento"
        ENDWITH
        WITH loc_oGrid.Column7
            .Width = 40 .Header1.Caption = "Alin" + CHR(233) + "a"
        ENDWITH
        WITH loc_oGrid.Column8
            .Width = 30 .Header1.Caption = "Emp"
        ENDWITH
        WITH loc_oGrid.Column9
            .Width = 80 .Header1.Caption = "C" + CHR(243) + "d. Cliente"
        ENDWITH
        WITH loc_oGrid.Column10
            .Width = 70 .Header1.Caption = "Protocolo"
        ENDWITH
        WITH loc_oGrid.Column11
            .Width = 75 .Header1.Caption = "Dt. Emiss" + CHR(227) + "o"
        ENDWITH
        *-- Coluna Sel (checkbox marca)
        WITH loc_oGrid.Column12
            .Width = 30 .Header1.Caption = "Sel"
            .Sparse = .F.
            .AddObject("Check1", "CheckBox")
            WITH .Check1
                .Caption = "" .Alignment = 0 .ReadOnly = .F. .Visible = .T.
                .Top = 9 .Left = 2 .Height = 17 .Width = 22
            ENDWITH
        ENDWITH

        *=====================================================================
        *-- Botao Marcar cheque na grade - top=349+29=378, left=767
        *=====================================================================
        loc_oPg2.AddObject("cmd_4c_BtnMarca", "CommandButton")
        WITH loc_oPg2.cmd_4c_BtnMarca
            .Top = 378 .Left = 767 .Width = 40 .Height = 40
            .Caption = "Marca"
            .FontName = "Tahoma" .FontSize = 7
            .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_BtnMarca, "Click", THIS, "BtnMarcaClick")

        *-- Botao Excluir cheque da grade - top=390+29=419, left=767
        loc_oPg2.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH loc_oPg2.cmd_4c_BtnExcluir
            .Top = 419 .Left = 767 .Width = 40 .Height = 40
            .Caption = "Excluir"
            .FontName = "Tahoma" .FontSize = 7
            .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirChequeClick")

        *=====================================================================
        *-- Botoes leitora + FollowUp (coluna direita)
        *-- Chk_FollowUp: top=364+29=393, left=826
        *-- CmdExcCheque: top=364+29=393, left=901
        *-- Comm_Ini:     top=441+29=470, left=826
        *-- Comm_Fim:     top=441+29=470, left=901
        *=====================================================================
        loc_oPg2.AddObject("chk_4c_FollowUp", "CheckBox")
        WITH loc_oPg2.chk_4c_FollowUp
            .Top = 393 .Left = 826 .Width = 75 .Height = 75
            .Caption = "Repetir Followup" .Value = 0
            .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("cmd_4c_CmdExcCheque", "CommandButton")
        WITH loc_oPg2.cmd_4c_CmdExcCheque
            .Top = 393 .Left = 901 .Width = 75 .Height = 75
            .Caption = "Excluir Cheque"
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_CmdExcCheque, "Click", THIS, "BtnCmdExcChequeClick")

        loc_oPg2.AddObject("cmd_4c_Comm_Ini", "CommandButton")
        WITH loc_oPg2.cmd_4c_Comm_Ini
            .Top = 470 .Left = 826 .Width = 75 .Height = 75
            .Caption = "Acionar Leitora"
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_Comm_Ini, "Click", THIS, "BtnCommIniClick")

        loc_oPg2.AddObject("cmd_4c_Comm_Fim", "CommandButton")
        WITH loc_oPg2.cmd_4c_Comm_Fim
            .Top = 470 .Left = 901 .Width = 75 .Height = 75
            .Caption = "Encerrar Leitora"
            .FontName = "Tahoma" .FontBold = .T. .FontItalic = .T. .FontSize = 8
            .BackColor = RGB(255, 255, 255) .Themes = .F. .SpecialEffect = 0 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_Comm_Fim, "Click", THIS, "BtnCommFimClick")

        *=====================================================================
        *-- Indicadores de porta + totalizadores
        *-- top=440+29=469
        *=====================================================================
        loc_oPg2.AddObject("lbl_4c_AvisoPortaS", "Label")
        WITH loc_oPg2.lbl_4c_AvisoPortaS
            .Caption = "S" .Top = 469 .Left = 7 .Width = 21 .Height = 26
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 10 .FontBold = .T.
            .ForeColor = RGB(180, 180, 180) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_AvisoPortaM", "Label")
        WITH loc_oPg2.lbl_4c_AvisoPortaM
            .Caption = "M" .Top = 469 .Left = 30 .Width = 21 .Height = 26
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 10 .FontBold = .T.
            .ForeColor = RGB(180, 180, 180) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_AvisoPortaT", "Label")
        WITH loc_oPg2.lbl_4c_AvisoPortaT
            .Caption = "T" .Top = 469 .Left = 53 .Width = 21 .Height = 26
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 10 .FontBold = .T.
            .ForeColor = RGB(180, 180, 180) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_AvisoPortaP", "Label")
        WITH loc_oPg2.lbl_4c_AvisoPortaP
            .Caption = "P" .Top = 469 .Left = 76 .Width = 21 .Height = 26
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 10 .FontBold = .T.
            .ForeColor = RGB(180, 180, 180) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_QtdeChqs", "TextBox")
        WITH loc_oPg2.txt_4c_QtdeChqs
            .Top = 469 .Left = 173 .Width = 52 .Height = 23
            .Value = 0 .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ValorTotal", "TextBox")
        WITH loc_oPg2.txt_4c_ValorTotal
            .Top = 469 .Left = 226 .Width = 122 .Height = 23
            .Value = 0 .ReadOnly = .T. .InputMask = "999999999.99"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_CondPagto", "TextBox")
        WITH loc_oPg2.txt_4c_CondPagto
            .Top = 469 .Left = 489 .Width = 116 .Height = 23
            .MaxLength = 20 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Cheque - entrada da leitora
        *-- original: top=468+29=497, left=6, width=735, height=39
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Cheque", "Container")
        loc_oChe = loc_oPg2.cnt_4c_Cheque
        WITH loc_oChe
            .Top = 497 .Left = 6 .Width = 735 .Height = 39
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_ProtB", "Label")
        WITH loc_oChe.lbl_4c_Lbl_ProtB
            .Caption = "Protocolo" .Top = 4 .Left = 18 .Width = 55 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_ProtL", "TextBox")
        WITH loc_oChe.txt_4c_ProtL
            .Top = 16 .Left = 5 .Width = 66 .Height = 21
            .MaxLength = 20 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_ProtB", "TextBox")
        WITH loc_oChe.txt_4c_ProtB
            .Top = 16 .Left = 41 .Width = 66 .Height = 21
            .MaxLength = 20 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_Bco", "Label")
        WITH loc_oChe.lbl_4c_Lbl_Bco
            .Caption = "Bco" .Top = 4 .Left = 118 .Width = 25 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_Bco", "TextBox")
        WITH loc_oChe.txt_4c_Bco
            .Top = 16 .Left = 108 .Width = 36 .Height = 21
            .MaxLength = 5 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_Age", "Label")
        WITH loc_oChe.lbl_4c_Lbl_Age
            .Caption = "Agen." .Top = 4 .Left = 153 .Width = 35 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_Age", "TextBox")
        WITH loc_oChe.txt_4c_Age
            .Top = 16 .Left = 145 .Width = 40 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_Conta", "Label")
        WITH loc_oChe.lbl_4c_Lbl_Conta
            .Caption = "Conta" .Top = 4 .Left = 213 .Width = 35 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_ContaChe", "TextBox")
        WITH loc_oChe.txt_4c_ContaChe
            .Top = 16 .Left = 186 .Width = 82 .Height = 21
            .MaxLength = 20 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_Numero", "Label")
        WITH loc_oChe.lbl_4c_Lbl_Numero
            .Caption = "Numero" .Top = 4 .Left = 279 .Width = 40 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_NumChe", "TextBox")
        WITH loc_oChe.txt_4c_NumChe
            .Top = 16 .Left = 269 .Width = 54 .Height = 21
            .MaxLength = 20 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_Valor", "Label")
        WITH loc_oChe.lbl_4c_Lbl_Valor
            .Caption = "Valor" .Top = 4 .Left = 361 .Width = 35 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_ValorChe", "TextBox")
        WITH loc_oChe.txt_4c_ValorChe
            .Top = 16 .Left = 324 .Width = 104 .Height = 21
            .Value = 0 .InputMask = "999999999.99"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_Venc", "Label")
        WITH loc_oChe.lbl_4c_Lbl_Venc
            .Caption = "Vencimento" .Top = 4 .Left = 438 .Width = 65 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_VencChe", "TextBox")
        WITH loc_oChe.txt_4c_VencChe
            .Top = 16 .Left = 429 .Width = 82 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_Alinea", "Label")
        WITH loc_oChe.lbl_4c_Lbl_Alinea
            .Caption = "Alinea" .Top = 4 .Left = 514 .Width = 35 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_AlineaChe", "TextBox")
        WITH loc_oChe.txt_4c_AlineaChe
            .Top = 16 .Left = 512 .Width = 31 .Height = 21
            .MaxLength = 5 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("lbl_4c_Lbl_DtEmiss", "Label")
        WITH loc_oChe.lbl_4c_Lbl_DtEmiss
            .Caption = "Dt Emis Cheque" .Top = 4 .Left = 550 .Width = 90 .Height = 12
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 7 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oChe.AddObject("txt_4c_DtEmissChe", "TextBox")
        WITH loc_oChe.txt_4c_DtEmissChe
            .Top = 16 .Left = 544 .Width = 82 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Empresa - top=508+29=537, left=42, width=698, height=24
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Empresa", "Container")
        loc_oEmp = loc_oPg2.cnt_4c_Empresa
        WITH loc_oEmp
            .Top = 537 .Left = 42 .Width = 698 .Height = 24
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oEmp.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oEmp.lbl_4c_LblEmpresa
            .Caption = "Empresa :" .Top = 4 .Left = 11 .Width = 50 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oEmp.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oEmp.txt_4c_Emps
            .Top = 1 .Left = 63 .Width = 31 .Height = 21
            .MaxLength = 3 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oEmp.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpresa")

        loc_oEmp.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oEmp.txt_4c_DEmps
            .Top = 1 .Left = 96 .Width = 290 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Conta - Conta do cliente/emissor
        *-- top=531+29=560, left=52, width=648, height=23
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Conta", "Container")
        loc_oCnt = loc_oPg2.cnt_4c_Conta
        WITH loc_oCnt
            .Top = 560 .Left = 52 .Width = 648 .Height = 23
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblConta", "Label")
        WITH loc_oCnt.lbl_4c_LblConta
            .Caption = "Conta :" .Top = 4 .Left = 13 .Width = 38 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_ContaIclis", "TextBox")
        WITH loc_oCnt.txt_4c_ContaIclis
            .Top = 0 .Left = 53 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_ContaIclis, "KeyPress", THIS, "ValidarContaIclis")

        loc_oCnt.AddObject("txt_4c_CpfIclis", "TextBox")
        WITH loc_oCnt.txt_4c_CpfIclis
            .Top = 0 .Left = 133 .Width = 150 .Height = 21
            .MaxLength = 14 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_NomeIclis", "TextBox")
        WITH loc_oCnt.txt_4c_NomeIclis
            .Top = 0 .Left = 285 .Width = 360 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Filtro - Filtro vencimento
        *-- top=531+29=560, left=699, width=296, height=60
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Filtro", "Container")
        loc_oFil = loc_oPg2.cnt_4c_Filtro
        WITH loc_oFil
            .Top = 560 .Left = 699 .Width = 296 .Height = 60
            .BackStyle = 1 .BackColor = RGB(235, 235, 235) .BorderWidth = 1 .Visible = .T.
        ENDWITH

        loc_oFil.AddObject("lbl_4c_LblFiltroVenc", "Label")
        WITH loc_oFil.lbl_4c_LblFiltroVenc
            .Caption = "Filtro Vencimento :" .Top = 8 .Left = 29 .Width = 92 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oFil.AddObject("txt_4c_DataI", "TextBox")
        WITH loc_oFil.txt_4c_DataI
            .Top = 5 .Left = 122 .Width = 79 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oFil.AddObject("lbl_4c_SepFil", "Label")
        WITH loc_oFil.lbl_4c_SepFil
            .Caption = CHR(224) .Top = 8 .Left = 203 .Width = 8 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oFil.AddObject("txt_4c_DataF", "TextBox")
        WITH loc_oFil.txt_4c_DataF
            .Top = 5 .Left = 212 .Width = 79 .Height = 21
            .Value = {} .InputMask = "@D"
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        loc_oFil.AddObject("lbl_4c_LblClasemp", "Label")
        WITH loc_oFil.lbl_4c_LblClasemp
            .Caption = "Classe Empresarial :" .Top = 34 .Left = 22 .Width = 98 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8 .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oFil.AddObject("txt_4c_Clasemp", "TextBox")
        WITH loc_oFil.txt_4c_Clasemp
            .Top = 31 .Left = 122 .Width = 115 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_Responsavel - top=553+29=582, left=19, width=681, height=24
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_Responsavel", "Container")
        loc_oRes = loc_oPg2.cnt_4c_Responsavel
        WITH loc_oRes
            .Top = 582 .Left = 19 .Width = 681 .Height = 24
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oRes.AddObject("lbl_4c_LblResp", "Label")
        WITH loc_oRes.lbl_4c_LblResp
            .Caption = "Respons" + CHR(225) + "vel :" .Top = 5 .Left = 14 .Width = 68 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oRes.AddObject("txt_4c_GruRes", "TextBox")
        WITH loc_oRes.txt_4c_GruRes
            .Top = 0 .Left = 86 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oRes.txt_4c_GruRes, "KeyPress", THIS, "ValidarGrupoRes")

        loc_oRes.AddObject("lbl_4c_SepRes", "Label")
        WITH loc_oRes.lbl_4c_SepRes
            .Caption = "/" .Top = 3 .Left = 168 .Width = 8 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oRes.AddObject("txt_4c_ConRes", "TextBox")
        WITH loc_oRes.txt_4c_ConRes
            .Top = 0 .Left = 178 .Width = 79 .Height = 21
            .MaxLength = 10 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oRes.txt_4c_ConRes, "KeyPress", THIS, "ValidarContaRes")

        loc_oRes.AddObject("txt_4c_DConRes", "TextBox")
        WITH loc_oRes.txt_4c_DConRes
            .Top = 0 .Left = 259 .Width = 419 .Height = 21
            .Value = "" .ReadOnly = .T.
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        *=====================================================================
        *-- cnt_4c_FollowUp - top=574+29=603, left=41, width=658, height=25
        *=====================================================================
        loc_oPg2.AddObject("cnt_4c_FollowUp", "Container")
        loc_oFol = loc_oPg2.cnt_4c_FollowUp
        WITH loc_oFol
            .Top = 603 .Left = 41 .Width = 658 .Height = 25
            .BackStyle = 0 .BorderWidth = 0 .Visible = .T.
        ENDWITH

        loc_oFol.AddObject("lbl_4c_LblFollowUp", "Label")
        WITH loc_oFol.lbl_4c_LblFollowUp
            .Caption = "Followup :" .Top = 3 .Left = 12 .Width = 50 .Height = 15
            .AutoSize = .F. .FontName = "Tahoma" .FontSize = 8
            .ForeColor = RGB(255, 255, 255) .BackStyle = 0 .Visible = .T.
        ENDWITH

        loc_oFol.AddObject("txt_4c_Obs", "TextBox")
        WITH loc_oFol.txt_4c_Obs
            .Top = 1 .Left = 64 .Width = 592 .Height = 21
            .MaxLength = 200 .Value = ""
            .FontName = "Tahoma" .FontSize = 8 .Visible = .T.
        ENDWITH

        THIS.RegistrarKeyPressLookups()
        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - carrega cursor_4c_Dados e vincula ao grd_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
        LOCAL loc_oPg1, loc_dDtI, loc_dDtF, loc_nConc
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                LOCAL loc_nDsAtual
                loc_nDsAtual = THIS.DataSessionID
                SET DATASESSION TO 1
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados ;
                    (numlotes N(10,0), emps C(3), dtents D, codigos C(15), ;
                     valtots N(15,2), concs N(1,0))
                SET DATASESSION TO (loc_nDsAtual)
                loc_lResultado = .T.
            ELSE
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1

                *-- Montar filtro a partir dos controles da Page1
                loc_cFiltro = ""
                loc_dDtI = {}
                loc_dDtF = {}
                loc_nConc = 0

                IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial) = "O"
                    loc_dDtI = loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial.Value
                ENDIF
                IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_final) = "O"
                    loc_dDtF = loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_final.Value
                ENDIF
                IF VARTYPE(loc_oPg1.cbo_4c_Cmb_Concilia) = "O"
                    loc_nConc = loc_oPg1.cbo_4c_Cmb_Concilia.ListIndex
                ENDIF

                IF !EMPTY(loc_dDtI) AND !EMPTY(loc_dDtF)
                    loc_cFiltro = loc_cFiltro + ;
                        " AND a.dtents >= " + FormatarDataSQL(loc_dDtI) + ;
                        " AND a.dtents <= " + FormatarDataSQL(loc_dDtF)
                ENDIF

                DO CASE
                CASE loc_nConc = 2   && Conciliados
                    loc_cFiltro = loc_cFiltro + " AND a.concs = 1"
                CASE loc_nConc = 3   && Pendentes
                    loc_cFiltro = loc_cFiltro + " AND a.concs = 0"
                ENDCASE

                IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_lResultado = .F.
                ELSE
                    IF VARTYPE(loc_oPg1.grd_4c_Dados) = "O"
                        loc_oGrid = loc_oPg1.grd_4c_Dados
                        loc_oGrid.ColumnCount = 6
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numlotes"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dtents"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.valtots"
                        loc_oGrid.Column6.ControlSource = ;
                            "IIF(cursor_4c_Dados.concs=1,'Conciliado','Pendente')"
                        loc_oGrid.Column1.Header1.Caption = "Lote"
                        loc_oGrid.Column2.Header1.Caption = "Empresa"
                        loc_oGrid.Column3.Header1.Caption = "Data Entrada"
                        loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column5.Header1.Caption = "Valor Total"
                        loc_oGrid.Column6.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR !INLIST(par_nPagina, 1, 2)
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - carrega cheques do lote no grd_4c_Cheques (Page2)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_lResultado, loc_oGrid, loc_nLote
        loc_lResultado = .F.

        TRY
            loc_nLote = THIS.this_oBusinessObject.this_nNumLotes

            IF loc_nLote <= 0
                IF USED("cursor_4c_ChequesM")
                    USE IN cursor_4c_ChequesM
                ENDIF
                CREATE CURSOR cursor_4c_ChequesM ;
                    (bancos C(5), agencias C(10), ncontas C(20), ncheques C(20), ;
                     valors N(15,2), vencs D, nalineas C(5), emps C(3), ;
                     iclis C(10), protocolos C(20), dtemis D, marca L)
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.BuscarCheques(loc_nLote)
                    IF USED("cursor_4c_ChequesM")
                        USE IN cursor_4c_ChequesM
                    ENDIF

                    IF USED("cursor_4c_Cheques") AND RECCOUNT("cursor_4c_Cheques") >= 0
                        SELECT bancos, agencias, ncontas, ncheques, valors, vencs, ;
                            nalineas, emps, iclis, protocolos, dtemis, .F. AS marca ;
                            FROM cursor_4c_Cheques ;
                            INTO CURSOR cursor_4c_ChequesM READWRITE
                    ELSE
                        CREATE CURSOR cursor_4c_ChequesM ;
                            (bancos C(5), agencias C(10), ncontas C(20), ncheques C(20), ;
                             valors N(15,2), vencs D, nalineas C(5), emps C(3), ;
                             iclis C(10), protocolos C(20), dtemis D, marca L)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF loc_lResultado
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques) = "O"
                    loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques
                    loc_oGrid.ColumnCount = 12
                    loc_oGrid.RecordSource = "cursor_4c_ChequesM"
                    loc_oGrid.Column1.ControlSource  = "cursor_4c_ChequesM.bancos"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_ChequesM.agencias"
                    loc_oGrid.Column3.ControlSource  = "cursor_4c_ChequesM.ncontas"
                    loc_oGrid.Column4.ControlSource  = "cursor_4c_ChequesM.ncheques"
                    loc_oGrid.Column5.ControlSource  = "cursor_4c_ChequesM.valors"
                    loc_oGrid.Column6.ControlSource  = "cursor_4c_ChequesM.vencs"
                    loc_oGrid.Column7.ControlSource  = "cursor_4c_ChequesM.nalineas"
                    loc_oGrid.Column8.ControlSource  = "cursor_4c_ChequesM.emps"
                    loc_oGrid.Column9.ControlSource  = "cursor_4c_ChequesM.iclis"
                    loc_oGrid.Column10.ControlSource = "cursor_4c_ChequesM.protocolos"
                    loc_oGrid.Column11.ControlSource = "cursor_4c_ChequesM.dtemis"
                    loc_oGrid.Column12.ControlSource = "cursor_4c_ChequesM.marca"
                ENDIF

                *-- Atualizar totalizadores
                IF USED("cursor_4c_ChequesM")
                    LOCAL loc_nQtde, loc_nVlrTot
                    loc_nQtde   = RECCOUNT("cursor_4c_ChequesM")
                    loc_nVlrTot = 0
                    SELECT SUM(valors) FROM cursor_4c_ChequesM INTO ARRAY laVlr
                    IF TYPE("laVlr") = "N"
                        loc_nVlrTot = laVlr
                    ENDIF

                    IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_QtdeChqs) = "O"
                        THIS.pgf_4c_Paginas.Page2.txt_4c_QtdeChqs.Value = loc_nQtde
                    ENDIF
                    IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal) = "O"
                        THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal.Value = loc_nVlrTot
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.CarregarGrade")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.CarregarGrade()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nLote

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nLote = cursor_4c_Dados.numlotes

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.CarregarGrade()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nLote

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nLote = cursor_4c_Dados.numlotes

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.CarregarGrade()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nLote

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lote de cheques?" + CHR(13) + ;
                        "Os cheques vinculados tamb" + CHR(233) + "m ser" + CHR(227) + "o exclu" + ;
                        CHR(237) + "dos!", "Confirmar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nLote = cursor_4c_Dados.numlotes

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_nLote, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigChLcq", "cursor_4c_BuscaLch", "numlotes", "", ;
                "Lote de Cheques")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("numlotes", "", "Lote")
                loc_oBusca.mAddColuna("dtents",   "", "Data")
                loc_oBusca.mAddColuna("codigos",  "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("emps",     "", "Empresa")
                loc_oBusca.mAddColuna("valtots",  "", "Valor")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLch")
                    SELECT cursor_4c_BuscaLch
                    IF !EOF("cursor_4c_BuscaLch")
                        loc_nLote = cursor_4c_BuscaLch.numlotes
                        THIS.this_oBusinessObject.Buscar("AND a.numlotes = " + ;
                            FormatarNumeroSQL(loc_nLote))
                        THIS.CarregarLista()
                    ENDIF
                ELSE
                    THIS.CarregarLista()
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaLch")
            USE IN cursor_4c_BuscaLch
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes fora do TRY (RETURN funciona aqui)
        IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Oper.Value))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!", "")
                RETURN
            ENDIF
        ENDIF

        IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
            IF EMPTY(loc_oPg2.txt_4c_Data.Value)
                MsgAviso("Data de entrada obrigat" + CHR(243) + "ria!", "")
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnLimpaDTClick - limpa datas do filtro e recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnLimpaDTClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        TRY
            IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial) = "O"
                loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial.Value = {}
            ENDIF
            IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_final) = "O"
                loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_final.Value = {}
            ENDIF
            IF VARTYPE(loc_oPg1.cbo_4c_Cmb_Concilia) = "O"
                loc_oPg1.cbo_4c_Cmb_Concilia.ListIndex = 1
            ENDIF
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.BtnLimpaDTClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConciliacaoClick - stub para processo de conciliacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnConciliacaoClick()
        MsgInfo("Processo de concilia" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                "o implementado nesta vers" + CHR(227) + "o.", "")
    ENDPROC

    *--------------------------------------------------------------------------
    * CboConcilaChange - recarrega lista ao mudar filtro de situacao
    *--------------------------------------------------------------------------
    PROCEDURE CboConcilaChange()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraCotacaoClick - abre busca de cotacao para a moeda selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraCotacaoClick()
        LOCAL loc_oPg2, loc_cMoeda
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
            loc_cMoeda = ALLTRIM(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value)
        ELSE
            loc_cMoeda = ""
        ENDIF

        IF EMPTY(loc_cMoeda)
            MsgAviso("Informe a moeda antes de alterar a cota" + CHR(231) + CHR(227) + "o.", "")
            RETURN
        ENDIF

        MsgInfo("Consulta de cota" + CHR(231) + CHR(227) + "o para moeda: " + loc_cMoeda, "")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelPlanilhaClick - selecionar planilha Excel para processamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelPlanilhaClick()
        LOCAL loc_cArquivo
        loc_cArquivo = GETFILE("XLS;XLSX", "Selecionar Planilha", "Selecionar")
        IF !EMPTY(loc_cArquivo)
            IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Processa.txt_4c_Planilha) = "O"
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Processa.txt_4c_Planilha.Value = loc_cArquivo
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCmdProcessaClick - processamento em lote (stub)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCmdProcessaClick()
        MsgInfo("Processamento em lote n" + CHR(227) + "o implementado nesta vers" + CHR(227) + "o.", "")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirChequeClick - exclui cheque selecionado no grd_4c_Cheques
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirChequeClick()
        LOCAL loc_cSQL, loc_nResult, loc_nNums

        IF !USED("cursor_4c_ChequesM") OR EOF("cursor_4c_ChequesM")
            MsgAviso("Selecione um cheque na lista.", "")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste cheque do lote?", "")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_ChequesM

            IF THIS.this_oBusinessObject.this_nNumLotes <= 0
                MsgAviso("Salve o lote antes de excluir cheques.", "")
                RETURN
            ENDIF

            loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
                FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumLotes) + ;
                " AND bancos = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.bancos)) + ;
                " AND agencias = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.agencias)) + ;
                " AND ncontas = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncontas)) + ;
                " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncheques))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir cheque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso!", "")
                THIS.CarregarGrade()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.BtnExcluirChequeClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcaClick - marca/desmarca cheque selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcaClick()
        IF !USED("cursor_4c_ChequesM") OR EOF("cursor_4c_ChequesM")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_ChequesM
            REPLACE cursor_4c_ChequesM.marca WITH !cursor_4c_ChequesM.marca
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.BtnMarcaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCmdExcChequeClick - exclui cheques marcados do lote
    *--------------------------------------------------------------------------
    PROCEDURE BtnCmdExcChequeClick()
        LOCAL loc_cSQL, loc_nResult, loc_nExcluidos

        IF !USED("cursor_4c_ChequesM") OR RECCOUNT("cursor_4c_ChequesM") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " cheques para excluir.", "")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o dos cheques marcados?", "")
            RETURN
        ENDIF

        TRY
            loc_nExcluidos = 0
            SELECT cursor_4c_ChequesM
            GO TOP

            DO WHILE !EOF("cursor_4c_ChequesM")
                IF cursor_4c_ChequesM.marca
                    loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
                        FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumLotes) + ;
                        " AND bancos = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.bancos)) + ;
                        " AND agencias = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.agencias)) + ;
                        " AND ncontas = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncontas)) + ;
                        " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncheques))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult >= 0
                        loc_nExcluidos = loc_nExcluidos + 1
                    ENDIF
                ENDIF
                SKIP IN cursor_4c_ChequesM
            ENDDO

            IF loc_nExcluidos > 0
                MsgInfo(TRANSFORM(loc_nExcluidos) + " cheque(s) exclu" + CHR(237) + "do(s).", "")
                THIS.CarregarGrade()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.BtnCmdExcChequeClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCommIniClick - stub: acionar leitora de cheques
    *--------------------------------------------------------------------------
    PROCEDURE BtnCommIniClick()
        MsgInfo("Leitora de cheques n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCommFimClick - stub: encerrar leitora de cheques
    *--------------------------------------------------------------------------
    PROCEDURE BtnCommFimClick()
        MsgInfo("Leitora de cheques n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere dados dos campos para as propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            *-- Campos principais
            IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
                .this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
                .this_dDtEnts = loc_oPg2.txt_4c_Data.Value
            ENDIF

            *-- Infos financeiras
            IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
                .this_cMoeds = ALLTRIM(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O"
                .this_nCotas = loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Value
            ENDIF

            *-- Origem
            IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"
                .this_cGruOrig = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O"
                .this_cConOrig = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig) = "O"
                .this_cDGruOrig = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig) = "O"
                .this_cDConOrig = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig.Value)
            ENDIF

            *-- Despesa
            IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts) = "O"
                .this_cGruEmts = ALLTRIM(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts) = "O"
                .this_cConEmts = ALLTRIM(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_DGruEmts) = "O"
                .this_cDGruEmts = ALLTRIM(loc_oPg2.cnt_4c_Despesa.txt_4c_DGruEmts.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_DConEmts) = "O"
                .this_cDConEmts = ALLTRIM(loc_oPg2.cnt_4c_Despesa.txt_4c_DConEmts.Value)
            ENDIF

            *-- Destino (grupos/contas na tabela SigChLcq)
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo) = "O"
                .this_cGrupos = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Conta) = "O"
                .this_cContas = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DGrupo) = "O"
                .this_cDGruDest = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_DGrupo.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DConta) = "O"
                .this_cDConDest = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_DConta.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest) = "O"
                .this_cCpfDest = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest.Value)
            ENDIF

            *-- Centro de Custo
            IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs) = "O"
                .this_cGruCCs = ALLTRIM(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs) = "O"
                .this_cConCCs = ALLTRIM(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs.Value)
            ENDIF

            *-- Carteira
            IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart) = "O"
                .this_cGruCart = ALLTRIM(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart) = "O"
                .this_cConCart = ALLTRIM(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart.Value)
            ENDIF

            *-- Emissor (exibicao apenas - iclis/grclis sao da tabela)
            IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss) = "O"
                .this_cGruEmiss = ALLTRIM(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss) = "O"
                .this_cConEmiss = ALLTRIM(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss.Value)
            ENDIF

            *-- Responsavel
            IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes) = "O"
                .this_cGruRes = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes) = "O"
                .this_cConRes = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_DConRes) = "O"
                .this_cDConRes = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_DConRes.Value)
            ENDIF

            *-- Empresa
            IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"
                .this_cEmps = ALLTRIM(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value)
            ENDIF

            *-- Observacao e FollowUp
            IF VARTYPE(loc_oPg2.edt_4c_Obs) = "O"
                .this_cObss = ALLTRIM(loc_oPg2.edt_4c_Obs.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs) = "O"
                .this_cFollowUp = ALLTRIM(loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.chk_4c_FollowUp) = "O"
                .this_lFollowUp = (loc_oPg2.chk_4c_FollowUp.Value = 1)
            ENDIF

            *-- Conta do cliente/emissor (CntConta)
            IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"
                .this_cIclis = ALLTRIM(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
                .this_cCpfIclis = ALLTRIM(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transfere dados do BO para os campos do formulario
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            *-- Campos principais (readonly)
            IF VARTYPE(loc_oPg2.txt_4c_Lote) = "O"
                loc_oPg2.txt_4c_Lote.Value = .this_nNumLotes
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Usuar) = "O"
                loc_oPg2.txt_4c_Usuar.Value = ALLTRIM(.this_cUsuar)
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
                loc_oPg2.txt_4c_Data.Value = .this_dDtEnts
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
                loc_oPg2.txt_4c_Oper.Value = ALLTRIM(.this_cCodigos)
            ENDIF

            *-- Infos financeiras
            IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Qtde) = "O"
                loc_oPg2.cnt_4c_Infos.txt_4c_Qtde.Value = .this_nQtdeCheqs
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
                loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ALLTRIM(.this_cMoeds)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O"
                loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Value = .this_nCotas
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Valor) = "O"
                loc_oPg2.cnt_4c_Infos.txt_4c_Valor.Value = .this_nValTots
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_ValConv) = "O"
                loc_oPg2.cnt_4c_Infos.txt_4c_ValConv.Value = .this_nValConvs
            ENDIF

            *-- Origem
            IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"
                loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Value = ALLTRIM(.this_cGruOrig)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O"
                loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig.Value = ALLTRIM(.this_cConOrig)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig) = "O"
                loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig.Value = ALLTRIM(.this_cDGruOrig)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig) = "O"
                loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig.Value = ALLTRIM(.this_cDConOrig)
            ENDIF

            *-- Despesa
            IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts) = "O"
                loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts.Value = ALLTRIM(.this_cGruEmts)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts) = "O"
                loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts.Value = ALLTRIM(.this_cConEmts)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_DGruEmts) = "O"
                loc_oPg2.cnt_4c_Despesa.txt_4c_DGruEmts.Value = ALLTRIM(.this_cDGruEmts)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_DConEmts) = "O"
                loc_oPg2.cnt_4c_Despesa.txt_4c_DConEmts.Value = ALLTRIM(.this_cDConEmts)
            ENDIF

            *-- Destino (grupos/contas)
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo) = "O"
                loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ALLTRIM(.this_cGrupos)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Conta) = "O"
                loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ALLTRIM(.this_cContas)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DGrupo) = "O"
                loc_oPg2.cnt_4c_Destino.txt_4c_DGrupo.Value = ALLTRIM(.this_cDGruDest)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DConta) = "O"
                loc_oPg2.cnt_4c_Destino.txt_4c_DConta.Value = ALLTRIM(.this_cDConDest)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest) = "O"
                loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest.Value = ALLTRIM(.this_cCpfDest)
            ENDIF

            *-- Centro de Custo
            IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs) = "O"
                loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs.Value = ALLTRIM(.this_cGruCCs)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs) = "O"
                loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs.Value = ALLTRIM(.this_cConCCs)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_DGrupoCcs) = "O"
                loc_oPg2.cnt_4c_CCusto.txt_4c_DGrupoCcs.Value = ALLTRIM(.this_cDGruCCs)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_DContaCcs) = "O"
                loc_oPg2.cnt_4c_CCusto.txt_4c_DContaCcs.Value = ALLTRIM(.this_cDConCCs)
            ENDIF

            *-- Carteira
            IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart) = "O"
                loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart.Value = ALLTRIM(.this_cGruCart)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart) = "O"
                loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart.Value = ALLTRIM(.this_cConCart)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_DGruCart) = "O"
                loc_oPg2.cnt_4c_Carteira.txt_4c_DGruCart.Value = ALLTRIM(.this_cDGruCart)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_DConCart) = "O"
                loc_oPg2.cnt_4c_Carteira.txt_4c_DConCart.Value = ALLTRIM(.this_cDConCart)
            ENDIF

            *-- Emissor
            IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss) = "O"
                loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss.Value = ALLTRIM(.this_cGruEmiss)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss) = "O"
                loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss.Value = ALLTRIM(.this_cConEmiss)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_DGruEmiss) = "O"
                loc_oPg2.cnt_4c_Emissor.txt_4c_DGruEmiss.Value = ALLTRIM(.this_cDGruEmiss)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_DConEmiss) = "O"
                loc_oPg2.cnt_4c_Emissor.txt_4c_DConEmiss.Value = ALLTRIM(.this_cDConEmiss)
            ENDIF

            *-- Responsavel
            IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes) = "O"
                loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes.Value = ALLTRIM(.this_cGruRes)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes) = "O"
                loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes.Value = ALLTRIM(.this_cConRes)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_DConRes) = "O"
                loc_oPg2.cnt_4c_Responsavel.txt_4c_DConRes.Value = ALLTRIM(.this_cDConRes)
            ENDIF

            *-- Empresa
            IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"
                loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ALLTRIM(.this_cEmps)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
                loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ALLTRIM(.this_cDEmps)
            ENDIF

            *-- Conta cliente/emissor
            IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"
                loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ALLTRIM(.this_cIclis)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
                loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ALLTRIM(.this_cCpfIclis)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
                loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ALLTRIM(.this_cNomeIclis)
            ENDIF

            *-- Observacao e FollowUp
            IF VARTYPE(loc_oPg2.edt_4c_Obs) = "O"
                loc_oPg2.edt_4c_Obs.Value = ALLTRIM(.this_cObss)
            ENDIF
            IF VARTYPE(loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs) = "O"
                loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs.Value = ALLTRIM(.this_cFollowUp)
            ENDIF
            IF VARTYPE(loc_oPg2.chk_4c_FollowUp) = "O"
                loc_oPg2.chk_4c_FollowUp.Value = IIF(.this_lFollowUp, 1, 0)
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - limpa todos os campos de edicao do Page2
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Linha principal
        IF VARTYPE(loc_oPg2.txt_4c_Lote) = "O"       : loc_oPg2.txt_4c_Lote.Value  = 0    : ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Usuar) = "O"      : loc_oPg2.txt_4c_Usuar.Value = ALLTRIM(gc_4c_UsuarioLogado) : ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"        : loc_oPg2.txt_4c_Data.Value  = DATE() : ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"        : loc_oPg2.txt_4c_Oper.Value  = ""  : ENDIF
        IF VARTYPE(loc_oPg2.opt_4c_SNA) = "O"         : loc_oPg2.opt_4c_SNA.Value   = 1   : ENDIF

        *-- Infos
        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Qtde) = "O"    : loc_oPg2.cnt_4c_Infos.txt_4c_Qtde.Value    = 0  : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"   : loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value   = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O" : loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Value = 0  : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Valor) = "O"   : loc_oPg2.cnt_4c_Infos.txt_4c_Valor.Value   = 0  : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_ValConv) = "O" : loc_oPg2.cnt_4c_Infos.txt_4c_ValConv.Value = 0  : ENDIF

        *-- Origem
        IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"   : loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Value   = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O"   : loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig.Value   = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig) = "O"  : loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig) = "O"  : loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_CpfOrig) = "O"   : loc_oPg2.cnt_4c_Origem.txt_4c_CpfOrig.Value   = "" : ENDIF

        *-- Despesa
        IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts) = "O"  : loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts) = "O"  : loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_DGruEmts) = "O" : loc_oPg2.cnt_4c_Despesa.txt_4c_DGruEmts.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_DConEmts) = "O" : loc_oPg2.cnt_4c_Despesa.txt_4c_DConEmts.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_CpfEmts) = "O"  : loc_oPg2.cnt_4c_Despesa.txt_4c_CpfEmts.Value  = "" : ENDIF

        *-- Destino
        IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo) = "O"   : loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value   = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Conta) = "O"   : loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value   = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DGrupo) = "O"  : loc_oPg2.cnt_4c_Destino.txt_4c_DGrupo.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_DConta) = "O"  : loc_oPg2.cnt_4c_Destino.txt_4c_DConta.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest) = "O" : loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest.Value = "" : ENDIF

        *-- CCusto
        IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs) = "O"  : loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs) = "O"  : loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_DGrupoCcs) = "O" : loc_oPg2.cnt_4c_CCusto.txt_4c_DGrupoCcs.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_DContaCcs) = "O" : loc_oPg2.cnt_4c_CCusto.txt_4c_DContaCcs.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_CpfCCs) = "O"    : loc_oPg2.cnt_4c_CCusto.txt_4c_CpfCCs.Value    = "" : ENDIF

        *-- Carteira
        IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart) = "O"  : loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart) = "O"  : loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_DGruCart) = "O" : loc_oPg2.cnt_4c_Carteira.txt_4c_DGruCart.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_DConCart) = "O" : loc_oPg2.cnt_4c_Carteira.txt_4c_DConCart.Value = "" : ENDIF

        *-- Emissor
        IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss) = "O"  : loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss) = "O"  : loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_DGruEmiss) = "O" : loc_oPg2.cnt_4c_Emissor.txt_4c_DGruEmiss.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_DConEmiss) = "O" : loc_oPg2.cnt_4c_Emissor.txt_4c_DConEmiss.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_CpfEmiss) = "O"  : loc_oPg2.cnt_4c_Emissor.txt_4c_CpfEmiss.Value  = "" : ENDIF

        *-- Empresa
        IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"
            loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value  = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"     : loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value     = "" : ENDIF

        *-- Conta / Responsavel / FollowUp
        IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"  : loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value  = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"    : loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value    = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"   : loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value   = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes) = "O" : loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes) = "O" : loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_DConRes) = "O": loc_oPg2.cnt_4c_Responsavel.txt_4c_DConRes.Value = "" : ENDIF
        IF VARTYPE(loc_oPg2.edt_4c_Obs) = "O"                      : loc_oPg2.edt_4c_Obs.Value                      = "" : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs) = "O"      : loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs.Value      = "" : ENDIF
        IF VARTYPE(loc_oPg2.chk_4c_FollowUp) = "O"                 : loc_oPg2.chk_4c_FollowUp.Value                 = 0  : ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_QtdeChqs) = "O"                  : loc_oPg2.txt_4c_QtdeChqs.Value                 = 0  : ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_ValorTotal) = "O"               : loc_oPg2.txt_4c_ValorTotal.Value               = 0  : ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_CondPagto) = "O"                : loc_oPg2.txt_4c_CondPagto.Value                = "" : ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - habilita/desabilita campos conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = (par_lHabilitar = .T.) AND (THIS.this_cModoAtual != "VISUALIZAR")

        IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"         : loc_oPg2.txt_4c_Oper.Enabled         = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"         : loc_oPg2.txt_4c_Data.Enabled          = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.opt_4c_SNA) = "O"          : loc_oPg2.opt_4c_SNA.Enabled           = loc_lEdicao : ENDIF

        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"   : loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Enabled    = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O" : loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Enabled  = loc_lEdicao : ENDIF

        IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O" : loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O" : loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts) = "O": loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts) = "O": loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo) = "O"  : loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Enabled  = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Conta) = "O"  : loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Enabled  = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs) = "O": loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs) = "O": loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart) = "O": loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart) = "O": loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss) = "O": loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss) = "O": loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"   : loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Enabled    = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR") : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes) = "O": loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes) = "O": loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.edt_4c_Obs) = "O"                   : loc_oPg2.edt_4c_Obs.Enabled                    = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs) = "O"   : loc_oPg2.cnt_4c_FollowUp.txt_4c_Obs.Enabled    = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.chk_4c_FollowUp) = "O"              : loc_oPg2.chk_4c_FollowUp.Enabled               = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O": loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Enabled = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cmd_4c_BtnExcluir) = "O"            : loc_oPg2.cmd_4c_BtnExcluir.Enabled             = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cmd_4c_BtnMarca) = "O"              : loc_oPg2.cmd_4c_BtnMarca.Enabled               = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cmd_4c_CmdExcCheque) = "O"          : loc_oPg2.cmd_4c_CmdExcCheque.Enabled           = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cmd_4c_Comm_Ini) = "O"              : loc_oPg2.cmd_4c_Comm_Ini.Enabled               = loc_lEdicao : ENDIF
        IF VARTYPE(loc_oPg2.cmd_4c_Comm_Fim) = "O"              : loc_oPg2.cmd_4c_Comm_Fim.Enabled               = loc_lEdicao : ENDIF

        IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
            IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - ajusta visibilidade/estado dos botoes
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_lEdicao, loc_oPg2
        loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oBotoes) = "O"
            IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"    : loc_oBotoes.cmd_4c_Incluir.Enabled    = .T. : ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O" : loc_oBotoes.cmd_4c_Visualizar.Enabled = .T. : ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"    : loc_oBotoes.cmd_4c_Alterar.Enabled    = .T. : ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"    : loc_oBotoes.cmd_4c_Excluir.Enabled    = .T. : ENDIF
            IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"     : loc_oBotoes.cmd_4c_Buscar.Enabled     = .T. : ENDIF
        ENDIF

        IF VARTYPE(loc_oPg2) = "O" AND VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
            IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible = loc_lEdicao
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Validadores de campos - LostFocus handlers
    * Padrao: buscar descricao no SQL e popular o campo de desc
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOper()
        LOCAL loc_oPg2, loc_cOper, loc_nRes
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF VARTYPE(loc_oPg2.txt_4c_Oper) != "O" : RETURN : ENDIF
        loc_cOper = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
        IF EMPTY(loc_cOper) : RETURN : ENDIF

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT operacao FROM SigCdOpt WHERE operacao = " + EscaparSQL(loc_cOper), ;
                "cursor_4c_ValidOper")
            IF loc_nRes < 0 OR RECCOUNT("cursor_4c_ValidOper") = 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cOper, "")
                loc_oPg2.txt_4c_Oper.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.ValidarOper")
        ENDTRY
        IF USED("cursor_4c_ValidOper") : USE IN cursor_4c_ValidOper : ENDIF
    ENDPROC

    PROCEDURE ValidarMoeda()
        LOCAL loc_oPg2, loc_cMoeda, loc_nRes
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) != "O" : RETURN : ENDIF
        loc_cMoeda = ALLTRIM(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value)
        IF EMPTY(loc_cMoeda) : RETURN : ENDIF

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT codigos FROM SigCdMoe WHERE codigos = " + EscaparSQL(loc_cMoeda), ;
                "cursor_4c_ValidMoe")
            IF loc_nRes < 0 OR RECCOUNT("cursor_4c_ValidMoe") = 0
                MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cMoeda, "")
                loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.ValidarMoeda")
        ENDTRY
        IF USED("cursor_4c_ValidMoe") : USE IN cursor_4c_ValidMoe : ENDIF
    ENDPROC

    PROCEDURE ValidarGrupoOrig()
        THIS.BuscarDescGrupo("cnt_4c_Origem", "txt_4c_GruOrig", "txt_4c_DGruOrig")
    ENDPROC

    PROCEDURE ValidarContaOrig()
        THIS.BuscarDescConta("cnt_4c_Origem", "txt_4c_ConOrig", "txt_4c_DConOrig")
    ENDPROC

    PROCEDURE ValidarGrupoEmts()
        THIS.BuscarDescGrupo("cnt_4c_Despesa", "txt_4c_GruEmts", "txt_4c_DGruEmts")
    ENDPROC

    PROCEDURE ValidarContaEmts()
        THIS.BuscarDescConta("cnt_4c_Despesa", "txt_4c_ConEmts", "txt_4c_DConEmts")
    ENDPROC

    PROCEDURE ValidarGrupoDest()
        THIS.BuscarDescGrupo("cnt_4c_Destino", "txt_4c_Grupo", "txt_4c_DGrupo")
    ENDPROC

    PROCEDURE ValidarContaDest()
        THIS.BuscarDescConta("cnt_4c_Destino", "txt_4c_Conta", "txt_4c_DConta")
    ENDPROC

    PROCEDURE ValidarGrupoCC()
        THIS.BuscarDescGrupo("cnt_4c_CCusto", "txt_4c_GrupoCcs", "txt_4c_DGrupoCcs")
    ENDPROC

    PROCEDURE ValidarContaCC()
        THIS.BuscarDescConta("cnt_4c_CCusto", "txt_4c_ContaCcs", "txt_4c_DContaCcs")
    ENDPROC

    PROCEDURE ValidarGrupoCart()
        THIS.BuscarDescGrupo("cnt_4c_Carteira", "txt_4c_GruCart", "txt_4c_DGruCart")
    ENDPROC

    PROCEDURE ValidarContaCart()
        THIS.BuscarDescConta("cnt_4c_Carteira", "txt_4c_ConCart", "txt_4c_DConCart")
    ENDPROC

    PROCEDURE ValidarGrupoEmiss()
        THIS.BuscarDescGrupo("cnt_4c_Emissor", "txt_4c_GruEmiss", "txt_4c_DGruEmiss")
    ENDPROC

    PROCEDURE ValidarContaEmiss()
        THIS.BuscarDescConta("cnt_4c_Emissor", "txt_4c_ConEmiss", "txt_4c_DConEmiss")
    ENDPROC

    PROCEDURE ValidarGrupoRes()
        THIS.BuscarDescGrupo("cnt_4c_Responsavel", "txt_4c_GruRes", "")
    ENDPROC

    PROCEDURE ValidarContaRes()
        THIS.BuscarDescConta("cnt_4c_Responsavel", "txt_4c_ConRes", "txt_4c_DConRes")
    ENDPROC

    PROCEDURE ValidarEmpresa()
        LOCAL loc_oPg2, loc_cEmps, loc_nRes
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) != "O" : RETURN : ENDIF
        loc_cEmps = ALLTRIM(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value)
        IF EMPTY(loc_cEmps) : RETURN : ENDIF

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmps), ;
                "cursor_4c_ValidEmp")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ValidEmp") > 0
                SELECT cursor_4c_ValidEmp
                IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
                    loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_ValidEmp.razas)
                ENDIF
                THIS.this_oBusinessObject.this_cDEmps = ALLTRIM(cursor_4c_ValidEmp.razas)
            ELSE
                MsgAviso("Empresa n" + CHR(227) + "o encontrada: " + loc_cEmps, "")
                loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ""
                IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
                    loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.ValidarEmpresa")
        ENDTRY
        IF USED("cursor_4c_ValidEmp") : USE IN cursor_4c_ValidEmp : ENDIF
    ENDPROC

    PROCEDURE ValidarContaIclis()
        LOCAL loc_oPg2, loc_cConta, loc_nRes
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) != "O" : RETURN : ENDIF
        loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value)
        IF EMPTY(loc_cConta) : RETURN : ENDIF

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT iclis, cpfs, razaos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
                "cursor_4c_ValidCli")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ValidCli") > 0
                SELECT cursor_4c_ValidCli
                IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
                    loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ALLTRIM(cursor_4c_ValidCli.cpfs)
                ENDIF
                IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
                    loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ALLTRIM(cursor_4c_ValidCli.razaos)
                ENDIF
            ELSE
                MsgAviso("Cliente n" + CHR(227) + "o encontrado: " + loc_cConta, "")
                loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ""
                IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"  : loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = "" : ENDIF
                IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O" : loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = "" : ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.ValidarContaIclis")
        ENDTRY
        IF USED("cursor_4c_ValidCli") : USE IN cursor_4c_ValidCli : ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescGrupo - helper para buscar descricao de grupo contabil (SigCdGcr)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarDescGrupo(par_cCnt, par_cTxtGru, par_cTxtDesc)
        LOCAL loc_oPg2, loc_oCnt, loc_cGrupo, loc_nRes, loc_cDesc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMPTY(loc_oPg2) AND VARTYPE(loc_oPg2) = "O"
            loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
        ELSE
            RETURN
        ENDIF

        IF VARTYPE(loc_oCnt) != "O" : RETURN : ENDIF

        IF EVALUATE("VARTYPE(loc_oCnt." + par_cTxtGru + ")") != "O" : RETURN : ENDIF
        loc_cGrupo = ALLTRIM(EVALUATE("loc_oCnt." + par_cTxtGru + ".Value"))

        IF EMPTY(par_cTxtDesc)
            IF EMPTY(loc_cGrupo) : RETURN : ENDIF
        ENDIF

        IF EMPTY(loc_cGrupo)
            IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
                EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
                "cursor_4c_DescGru")
            loc_cDesc = ""
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGru") > 0
                SELECT cursor_4c_DescGru
                loc_cDesc = ALLTRIM(cursor_4c_DescGru.descrs)
            ELSE
                MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cGrupo, "")
                EVALUATE("loc_oCnt." + par_cTxtGru + ".Value = ''")
            ENDIF
            IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
                EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = loc_cDesc")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.BuscarDescGrupo")
        ENDTRY
        IF USED("cursor_4c_DescGru") : USE IN cursor_4c_DescGru : ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescConta - helper para buscar descricao de conta (SigCdCli.razaos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarDescConta(par_cCnt, par_cTxtCon, par_cTxtDesc)
        LOCAL loc_oPg2, loc_oCnt, loc_cConta, loc_nRes, loc_cDesc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) = "O"
            loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
        ELSE
            RETURN
        ENDIF

        IF VARTYPE(loc_oCnt) != "O" : RETURN : ENDIF
        IF EVALUATE("VARTYPE(loc_oCnt." + par_cTxtCon + ")") != "O" : RETURN : ENDIF
        loc_cConta = ALLTRIM(EVALUATE("loc_oCnt." + par_cTxtCon + ".Value"))

        IF EMPTY(loc_cConta)
            IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
                EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT iclis, razaos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
                "cursor_4c_DescCon")
            loc_cDesc = ""
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCon") > 0
                SELECT cursor_4c_DescCon
                loc_cDesc = ALLTRIM(cursor_4c_DescCon.razaos)
            ELSE
                MsgAviso("Conta/cliente n" + CHR(227) + "o encontrado: " + loc_cConta, "")
                EVALUATE("loc_oCnt." + par_cTxtCon + ".Value = ''")
            ENDIF
            IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
                EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = loc_cDesc")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.BuscarDescConta")
        ENDTRY
        IF USED("cursor_4c_DescCon") : USE IN cursor_4c_DescCon : ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - recursivo: garante Visible=.T. em todos os filhos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMPTY(loc_oCtrl) = .F.
                    loc_oCtrl.Visible = .T.
                    IF loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - aplica formatacao padrao no grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")       : USE IN cursor_4c_Dados       : ENDIF
            IF USED("cursor_4c_Cheques")      : USE IN cursor_4c_Cheques      : ENDIF
            IF USED("cursor_4c_ChequesM")     : USE IN cursor_4c_ChequesM     : ENDIF
            IF USED("cursor_4c_BuscaLch")     : USE IN cursor_4c_BuscaLch     : ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarKeyPressLookups - registra handlers F4/F5 para campos lookup
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarKeyPressLookups()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        BINDEVENT(loc_oPg2.txt_4c_Oper,                      "KeyPress", THIS, "KeyPressOper")
        BINDEVENT(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda,        "KeyPress", THIS, "KeyPressMoeda")
        BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig,     "KeyPress", THIS, "KeyPressGruOrig")
        BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig,     "KeyPress", THIS, "KeyPressConOrig")
        BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_CpfOrig,     "KeyPress", THIS, "KeyPressCpfOrig")
        BINDEVENT(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts,    "KeyPress", THIS, "KeyPressGruEmts")
        BINDEVENT(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts,    "KeyPress", THIS, "KeyPressConEmts")
        BINDEVENT(loc_oPg2.cnt_4c_Despesa.txt_4c_CpfEmts,    "KeyPress", THIS, "KeyPressCpfEmts")
        BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo,      "KeyPress", THIS, "KeyPressGruDest")
        BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_Conta,      "KeyPress", THIS, "KeyPressConDest")
        BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest,    "KeyPress", THIS, "KeyPressCpfDest")
        BINDEVENT(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs,    "KeyPress", THIS, "KeyPressGruCC")
        BINDEVENT(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs,    "KeyPress", THIS, "KeyPressConCC")
        BINDEVENT(loc_oPg2.cnt_4c_CCusto.txt_4c_CpfCCs,      "KeyPress", THIS, "KeyPressCpfCC")
        BINDEVENT(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart,   "KeyPress", THIS, "KeyPressGruCart")
        BINDEVENT(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart,   "KeyPress", THIS, "KeyPressConCart")
        BINDEVENT(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss,   "KeyPress", THIS, "KeyPressGruEmiss")
        BINDEVENT(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss,   "KeyPress", THIS, "KeyPressConEmiss")
        BINDEVENT(loc_oPg2.cnt_4c_Emissor.txt_4c_CpfEmiss,   "KeyPress", THIS, "KeyPressCpfEmiss")
        BINDEVENT(loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe,   "KeyPress", THIS, "KeyPressAlinea")
        BINDEVENT(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps,       "KeyPress", THIS, "KeyPressEmps")
        BINDEVENT(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis,   "KeyPress", THIS, "KeyPressContaIclis")
        BINDEVENT(loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp,     "KeyPress", THIS, "KeyPressClasemp")
        BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes, "KeyPress", THIS, "KeyPressGruRes")
        BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes, "KeyPress", THIS, "KeyPressConRes")
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress handlers - F4=115 / F5=116 abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE KeyPressOper(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupOper() : ENDIF
    ENDPROC

    PROCEDURE KeyPressMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupMoeda() : ENDIF
    ENDPROC

    PROCEDURE KeyPressGruOrig(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Origem",  "txt_4c_GruOrig", "txt_4c_DGruOrig") : ENDIF
    ENDPROC

    PROCEDURE KeyPressConOrig(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Origem",  "txt_4c_ConOrig", "txt_4c_DConOrig") : ENDIF
    ENDPROC

    PROCEDURE KeyPressCpfOrig(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_Origem",   "txt_4c_CpfOrig") : ENDIF
    ENDPROC

    PROCEDURE KeyPressGruEmts(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Despesa", "txt_4c_GruEmts", "txt_4c_DGruEmts") : ENDIF
    ENDPROC

    PROCEDURE KeyPressConEmts(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Despesa", "txt_4c_ConEmts", "txt_4c_DConEmts") : ENDIF
    ENDPROC

    PROCEDURE KeyPressCpfEmts(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_Despesa",  "txt_4c_CpfEmts") : ENDIF
    ENDPROC

    PROCEDURE KeyPressGruDest(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Destino", "txt_4c_Grupo",   "txt_4c_DGrupo") : ENDIF
    ENDPROC

    PROCEDURE KeyPressConDest(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Destino", "txt_4c_Conta",   "txt_4c_DConta") : ENDIF
    ENDPROC

    PROCEDURE KeyPressCpfDest(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_Destino",  "txt_4c_CpfDest") : ENDIF
    ENDPROC

    PROCEDURE KeyPressGruCC(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_CCusto",  "txt_4c_GrupoCcs","txt_4c_DGrupoCcs") : ENDIF
    ENDPROC

    PROCEDURE KeyPressConCC(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_CCusto",  "txt_4c_ContaCcs","txt_4c_DContaCcs") : ENDIF
    ENDPROC

    PROCEDURE KeyPressCpfCC(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_CCusto",   "txt_4c_CpfCCs") : ENDIF
    ENDPROC

    PROCEDURE KeyPressGruCart(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Carteira","txt_4c_GruCart", "txt_4c_DGruCart") : ENDIF
    ENDPROC

    PROCEDURE KeyPressConCart(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Carteira","txt_4c_ConCart", "txt_4c_DConCart") : ENDIF
    ENDPROC

    PROCEDURE KeyPressGruEmiss(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Emissor", "txt_4c_GruEmiss","txt_4c_DGruEmiss") : ENDIF
    ENDPROC

    PROCEDURE KeyPressConEmiss(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Emissor", "txt_4c_ConEmiss","txt_4c_DConEmiss") : ENDIF
    ENDPROC

    PROCEDURE KeyPressCpfEmiss(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupCpf("cnt_4c_Emissor",  "txt_4c_CpfEmiss") : ENDIF
    ENDPROC

    PROCEDURE KeyPressAlinea(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupAlinea() : ENDIF
    ENDPROC

    PROCEDURE KeyPressEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupEmpresa() : ENDIF
    ENDPROC

    PROCEDURE KeyPressContaIclis(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupContaIclis() : ENDIF
    ENDPROC

    PROCEDURE KeyPressClasemp(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupClasemp() : ENDIF
    ENDPROC

    PROCEDURE KeyPressGruRes(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupGrupo("cnt_4c_Responsavel","txt_4c_GruRes","") : ENDIF
    ENDPROC

    PROCEDURE KeyPressConRes(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116) : THIS.AbrirLookupConta("cnt_4c_Responsavel","txt_4c_ConRes","txt_4c_DConRes") : ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupOper - lookup SigCdOpt (operacao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupOper()
        LOCAL loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpt", "cursor_4c_BuscaOper", "operacao", "", ;
                "Opera" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("operacao", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOper")
                    SELECT cursor_4c_BuscaOper
                    IF !EOF("cursor_4c_BuscaOper") AND VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
                        loc_oPg2.txt_4c_Oper.Value = ALLTRIM(cursor_4c_BuscaOper.operacao)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupOper")
        ENDTRY

        IF USED("cursor_4c_BuscaOper") : USE IN cursor_4c_BuscaOper : ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - lookup SigCdMoe (codigos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "codigos", "", ;
                "Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    IF !EOF("cursor_4c_BuscaMoe") AND ;
                       VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
                        loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ;
                            ALLTRIM(cursor_4c_BuscaMoe.codigos)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupMoeda")
        ENDTRY

        IF USED("cursor_4c_BuscaMoe") : USE IN cursor_4c_BuscaMoe : ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - lookup generico SigCdGcr (codigos/descrs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGrupo(par_cCnt, par_cTxtGru, par_cTxtDesc)
        LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_lResultado, loc_oTxtGru, loc_oTxtDesc
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
            IF VARTYPE(loc_oCnt) = "O"
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGru", "codigos", "", ;
                    "Grupo Cont" + CHR(225) + "bil")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
                        SELECT cursor_4c_BuscaGru
                        IF !EOF("cursor_4c_BuscaGru")
                            loc_oTxtGru = EVALUATE("loc_oCnt." + par_cTxtGru)
                            IF VARTYPE(loc_oTxtGru) = "O"
                                loc_oTxtGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
                            ENDIF
                            IF !EMPTY(par_cTxtDesc)
                                loc_oTxtDesc = EVALUATE("loc_oCnt." + par_cTxtDesc)
                                IF VARTYPE(loc_oTxtDesc) = "O"
                                    loc_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_oBusca.Release()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupGrupo")
        ENDTRY

        IF USED("cursor_4c_BuscaGru") : USE IN cursor_4c_BuscaGru : ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - lookup generico SigCdCli (iclis/razaos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupConta(par_cCnt, par_cTxtCon, par_cTxtDesc)
        LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_lResultado, loc_oTxtCon, loc_oTxtDesc
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
            IF VARTYPE(loc_oCnt) = "O"
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaCon", "iclis", "", ;
                    "Conta / Cliente")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("iclis",  "", "Conta")
                    loc_oBusca.mAddColuna("razaos", "", "Nome")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCon")
                        SELECT cursor_4c_BuscaCon
                        IF !EOF("cursor_4c_BuscaCon")
                            loc_oTxtCon = EVALUATE("loc_oCnt." + par_cTxtCon)
                            IF VARTYPE(loc_oTxtCon) = "O"
                                loc_oTxtCon.Value = ALLTRIM(cursor_4c_BuscaCon.iclis)
                            ENDIF
                            IF !EMPTY(par_cTxtDesc)
                                loc_oTxtDesc = EVALUATE("loc_oCnt." + par_cTxtDesc)
                                IF VARTYPE(loc_oTxtDesc) = "O"
                                    loc_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaCon.razaos)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_oBusca.Release()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupConta")
        ENDTRY

        IF USED("cursor_4c_BuscaCon") : USE IN cursor_4c_BuscaCon : ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCpf - lookup SigCdCli por CPF
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupCpf(par_cCnt, par_cTxtCpf)
        LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_lResultado, loc_oTxtCpf
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
            IF VARTYPE(loc_oCnt) = "O"
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaCpf", "cpfs", "", ;
                    "Busca por CPF / Cliente")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("cpfs",   "", "CPF")
                    loc_oBusca.mAddColuna("iclis",  "", "Conta")
                    loc_oBusca.mAddColuna("razaos", "", "Nome")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
                        SELECT cursor_4c_BuscaCpf
                        IF !EOF("cursor_4c_BuscaCpf")
                            loc_oTxtCpf = EVALUATE("loc_oCnt." + par_cTxtCpf)
                            IF VARTYPE(loc_oTxtCpf) = "O"
                                loc_oTxtCpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_oBusca.Release()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupCpf")
        ENDTRY

        IF USED("cursor_4c_BuscaCpf") : USE IN cursor_4c_BuscaCpf : ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - lookup SigCdEmp (cemps/razas)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", "", ;
                "Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cemps",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    IF !EOF("cursor_4c_BuscaEmp")
                        IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"
                            loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ;
                                ALLTRIM(cursor_4c_BuscaEmp.cemps)
                        ENDIF
                        IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
                            loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ;
                                ALLTRIM(cursor_4c_BuscaEmp.razas)
                        ENDIF
                        THIS.this_oBusinessObject.this_cDEmps = ;
                            ALLTRIM(cursor_4c_BuscaEmp.razas)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupEmpresa")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp") : USE IN cursor_4c_BuscaEmp : ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaIclis - lookup SigCdCli para cnt_4c_Conta
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaIclis()
        LOCAL loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaIclis", "iclis", "", ;
                "Conta / Cliente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis",  "", "Conta")
                loc_oBusca.mAddColuna("cpfs",   "", "CPF")
                loc_oBusca.mAddColuna("razaos", "", "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIclis")
                    SELECT cursor_4c_BuscaIclis
                    IF !EOF("cursor_4c_BuscaIclis")
                        IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"
                            loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ;
                                ALLTRIM(cursor_4c_BuscaIclis.iclis)
                        ENDIF
                        IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
                            loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ;
                                ALLTRIM(cursor_4c_BuscaIclis.cpfs)
                        ENDIF
                        IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
                            loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ;
                                ALLTRIM(cursor_4c_BuscaIclis.razaos)
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupContaIclis")
        ENDTRY

        IF USED("cursor_4c_BuscaIclis") : USE IN cursor_4c_BuscaIclis : ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupClasemp - lookup SigCdGre (classe empresarial)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupClasemp()
        LOCAL loc_oPg2, loc_oBusca, loc_lResultado, loc_cClasse
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGre", "cursor_4c_BuscaGre", "class", "", ;
                "Classe Empresarial")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("class", "", "Classe")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGre")
                    SELECT cursor_4c_BuscaGre
                    IF !EOF("cursor_4c_BuscaGre") AND ;
                       VARTYPE(loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp) = "O"
                        SCATTER MEMVAR MEMO FROM cursor_4c_BuscaGre
                        loc_cClasse = ALLTRIM(m.class)
                        loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp.Value = loc_cClasse
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupClasemp")
        ENDTRY

        IF USED("cursor_4c_BuscaGre") : USE IN cursor_4c_BuscaGre : ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupAlinea - lookup SigCdAli (codigos) para txt_4c_AlineaChe
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupAlinea()
        LOCAL loc_oPg2, loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdAli", "cursor_4c_BuscaAli", "codigos", "", ;
                "Al" + CHR(237) + "nea")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAli")
                    SELECT cursor_4c_BuscaAli
                    IF !EOF("cursor_4c_BuscaAli") AND ;
                       VARTYPE(loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe) = "O"
                        loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe.Value = ;
                            ALLTRIM(cursor_4c_BuscaAli.codigos)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formlch.AbrirLookupAlinea")
        ENDTRY

        IF USED("cursor_4c_BuscaAli") : USE IN cursor_4c_BuscaAli : ENDIF
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\lchBO.prg):
*==============================================================================
* lchBO.prg - Business Object para Lote de Cheques
* Herda de BusinessBase
* Tabela Principal : SigChLcq
* Chave Primaria   : NumLotes (numeric)
* Cursor de Dados  : cursor_4c_Dados
* Form relacionado : Formlch.prg
*==============================================================================

DEFINE CLASS lchBO AS BusinessBase

    *==========================================================================
    * PROPRIEDADES - TABELA SigChLcq (campos diretos)
    *==========================================================================

    *-- Identificacao do Lote
    this_nNumLotes    = 0      && PK - Numero do Lote
    this_nNumLoteFPs  = 0      && Numero do Lote de Parcelas vinculado

    *-- Operacao e configuracao
    this_cCodigos     = ""     && Codigo da Operacao (SigCdOpt.Operacao)
    this_cEmps        = ""     && Empresa C(3)
    this_cUsuar       = ""     && Usuario que criou/alterou

    *-- Moeda e valores financeiros
    this_cMoeds       = ""     && Codigo da Moeda
    this_nCotas       = 0      && Cotacao da Moeda
    this_cCotUsus     = ""     && Cotacao definida pelo Usuario (char(10) em SigChLcq)
    this_nValTots     = 0      && Valor Total em Moeda Original
    this_nValConvs    = 0      && Valor Total Convertido (ValTots / Cotas)

    *-- Datas
    this_dDtEnts      = {}     && Data de Entrada do Lote
    this_dDataTrans   = {}     && Data de Transporte (nullable em SigChLcq)

    *-- Grupo e Conta Destino (campos da tabela SigChLcq)
    this_cGrupos      = ""     && Grupo de Destino
    this_cContas      = ""     && Conta de Destino

    *-- Cliente Emissor (vinculo com SigCdCli)
    this_cIclis       = ""     && Codigo do Cliente Emissor
    this_cGrclis      = ""     && Grupo do Cliente Emissor

    *-- Quantidade e identificadores auxiliares
    this_nQtdeCheqs   = 0      && Quantidade de Cheques no Lote
    this_nOrdens      = 0      && Tipo de Ordens (de SigCdOpt.Ordens)

    *-- Observacoes e follow up
    this_cObss        = ""     && Observacoes gerais do Lote
    this_cFollowUp    = ""     && Texto do Follow Up
    this_lFollowUp    = .F.    && Flag Repetir Follow Up

    *==========================================================================
    * PROPRIEDADES - DESTINO (com descricoes para a UI)
    * Campos do container CntDestino (Page2)
    *==========================================================================

    this_cGruDest     = ""     && Grupo Destino (Get_Grupo em CntDestino)
    this_cConDest     = ""     && Conta Destino (Get_Conta em CntDestino)
    this_cDGruDest    = ""     && Descricao do Grupo Destino
    this_cDConDest    = ""     && Descricao da Conta Destino
    this_cCpfDest     = ""     && CPF quando destino e pessoa fisica

    *==========================================================================
    * PROPRIEDADES - ORIGEM
    * Campos do container CntOrigem (Page2)
    *==========================================================================

    this_cGruOrig     = ""     && Grupo de Origem (Get_GruOrig)
    this_cConOrig     = ""     && Conta de Origem (Get_ConOrig)
    this_cDGruOrig    = ""     && Descricao do Grupo de Origem
    this_cDConOrig    = ""     && Descricao da Conta de Origem
    this_cCpfOrig     = ""     && CPF da Origem

    *==========================================================================
    * PROPRIEDADES - CARTEIRA
    * Campos do container CntCarteira (Page2)
    *==========================================================================

    this_cGruCart     = ""     && Grupo de Carteira (Get_GruCart)
    this_cConCart     = ""     && Conta de Carteira (Get_ConCart)
    this_cDGruCart    = ""     && Descricao do Grupo de Carteira
    this_cDConCart    = ""     && Descricao da Conta de Carteira

    *==========================================================================
    * PROPRIEDADES - EMISSOR
    * Campos do container CntEmissor (Page2)
    *==========================================================================

    this_cGruEmiss    = ""     && Grupo do Emissor (Get_GruEmiss)
    this_cConEmiss    = ""     && Conta do Emissor (Get_ConEmiss)
    this_cDGruEmiss   = ""     && Descricao do Grupo do Emissor
    this_cDConEmiss   = ""     && Descricao da Conta do Emissor
    this_cCpfEmiss    = ""     && CPF do Emissor (Get_Cpf em CntEmissor)
    this_cNomeEmiss   = ""     && Nome do Emissor (Rclis de SigCdCli)

    *==========================================================================
    * PROPRIEDADES - DESPESA
    * Campos do container cntDespesa (Page2)
    *==========================================================================

    this_cGruEmts     = ""     && Grupo de Despesa (Get_GruEmts)
    this_cConEmts     = ""     && Conta de Despesa (Get_ConEmts)
    this_cDGruEmts    = ""     && Descricao do Grupo de Despesa
    this_cDConEmts    = ""     && Descricao da Conta de Despesa
    this_cCpfEmts     = ""     && CPF da Despesa

    *==========================================================================
    * PROPRIEDADES - CENTRO DE CUSTO
    * Campos do container CntCCusto (Page2)
    *==========================================================================

    this_cGruCCs      = ""     && Grupo de Centro de Custo (Get_GrupoCcs)
    this_cConCCs      = ""     && Conta de Centro de Custo (Get_ContaCcs)
    this_cDGruCCs     = ""     && Descricao do Grupo CC
    this_cDConCCs     = ""     && Descricao da Conta CC
    this_cCpfCCs      = ""     && CPF do Centro de Custo

    *==========================================================================
    * PROPRIEDADES - RESPONSAVEL
    * Campos do container CntResponsavel (Page2)
    *==========================================================================

    this_cGruRes      = ""     && Grupo do Responsavel (Get_GruRes)
    this_cConRes      = ""     && Conta do Responsavel (Get_ConRes)
    this_cDConRes     = ""     && Descricao da Conta do Responsavel

    *==========================================================================
    * PROPRIEDADES - EMPRESA (descricao para exibicao)
    *==========================================================================

    this_cDEmps       = ""     && Razao Social / Descricao da Empresa

    *==========================================================================
    * PROPRIEDADES - CONTA DO CLIENTE/EMISSOR (CntConta)
    * Container na parte inferior da Page2 para identificacao do emissor
    *==========================================================================

    this_cContaIclis  = ""     && Conta/Iclis do Emissor (Get_Conta em CntConta)
    this_cCpfIclis    = ""     && CPF do Emissor (Get_CPF em CntConta)
    this_cNomeIclis   = ""     && Nome do Emissor (Get_Nome em CntConta)

    *==========================================================================
    * PROPRIEDADES - PROCESSAMENTO EM LOTE
    * Campos do container CntProcessa (Page2) - processamento automatico
    *==========================================================================

    this_dDtIniProc   = {}     && Data Inicial do Processamento
    this_dDtFimProc   = {}     && Data Final do Processamento
    this_nLoteProc    = 0      && Numero do Lote para Processamento
    this_cEmpProc     = ""     && Empresa para Processamento em Lote
    this_cPlanilha    = ""     && Caminho completo da Planilha Excel (.XLS)

    *==========================================================================
    * PROPRIEDADES - FILTROS DE LISTAGEM (Page1)
    * Campos do cntFiltros na Page1 (lista de lotes)
    *==========================================================================

    this_dDataFiltroI = {}     && Data Inicial do Filtro (Dt_inicial)
    this_dDataFiltroF = {}     && Data Final do Filtro (Dt_final)
    this_nFiltroConc  = 0      && Filtro Conciliacao: 0=Todos, 1=Conciliados, 2=Pendentes, 3=Ambos
    this_cFiltClasemp = ""     && Filtro por Classe Empresarial (Get_Clasemp)

    *==========================================================================
    * PROPRIEDADES - CURSOR DE DADOS
    *==========================================================================

    this_cCursorDados = "cursor_4c_Dados"   && Cursor principal para listagem de lotes

    *==========================================================================
    * INIT - Configuracao da tabela principal
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChLcq"
            THIS.this_cCampoChave = "NumLotes"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar lchBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(STR(THIS.this_nNumLotes, 10))
    ENDFUNC

    *==========================================================================
    * Buscar - Lista lotes de cheques com filtros opcionais
    * par_cFiltro: condicoes WHERE adicionais (ex: "AND a.dtents >= '2024-01-01'")
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.codigos, a.emps, a.dtents, a.datas," + ;
                " a.datatrans, a.moeds, a.cotas, a.valtots, a.valconvs," + ;
                " a.grupos, a.contas, a.gruorigs, a.conorigs," + ;
                " a.grucarts, a.concarts, a.iclis, a.grclis, a.usuarios," + ;
                " a.concs, a.numloteFps, a.cotusus," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.obs" + ;
                " FROM SigChLcq a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.dtents DESC, a.numlotes DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega lote pelo numlotes (PK)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.numloteFps, a.codigos, a.emps, a.usuarios," + ;
                " a.moeds, a.cotas, a.cotusus, a.valtots, a.valconvs," + ;
                " a.dtents, a.datatrans, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.iclis, a.grclis, a.concs, a.obs," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.tipos, a.nums," + ;
                " a.numdopes, a.dopes, a.empdopnums, a.cnotas, a.locals, a.ntrans" + ;
                " FROM SigChLcq a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLotes)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLotes    = TratarNulo(numlotes,   "N")
            THIS.this_nNumLoteFPs  = TratarNulo(numloteFps, "N")
            THIS.this_cCodigos     = TratarNulo(codigos,    "C")
            THIS.this_cEmps        = TratarNulo(emps,       "C")
            THIS.this_cUsuar       = TratarNulo(usuarios,   "C")
            THIS.this_cMoeds       = TratarNulo(moeds,      "C")
            THIS.this_nCotas       = TratarNulo(cotas,      "N")
            THIS.this_cCotUsus     = TratarNulo(cotusus,    "C")
            THIS.this_nValTots     = TratarNulo(valtots,    "N")
            THIS.this_nValConvs    = TratarNulo(valconvs,   "N")
            THIS.this_dDtEnts      = TratarNulo(dtents,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,  "D")
            THIS.this_cGrupos      = TratarNulo(grupos,     "C")
            THIS.this_cContas      = TratarNulo(contas,     "C")
            THIS.this_cIclis       = TratarNulo(iclis,      "C")
            THIS.this_cGrclis      = TratarNulo(grclis,     "C")
            THIS.this_cObss        = TratarNulo(obs,        "C")
            THIS.this_cGruCart     = TratarNulo(grucarts,   "C")
            THIS.this_cConCart     = TratarNulo(concarts,   "C")
            THIS.this_cGruOrig     = TratarNulo(gruorigs,   "C")
            THIS.this_cConOrig     = TratarNulo(conorigs,   "C")
            THIS.this_cGruCCs      = TratarNulo(grupoccs,   "C")
            THIS.this_cConCCs      = TratarNulo(contaccs,   "C")
            THIS.this_cGruEmts     = TratarNulo(grupems,    "C")
            THIS.this_cConEmts     = TratarNulo(contems,    "C")
            THIS.this_cGruRes      = TratarNulo(gratends,   "C")
            THIS.this_cConRes      = TratarNulo(atends,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarCheques - Carrega cheques do lote em cursor_4c_Cheques (grid Page2)
    *==========================================================================
    FUNCTION BuscarCheques(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.nums, a.bancos, a.agencias, a.ncontas, a.ncheques," + ;
                " a.valors, a.valpags, a.vencs, a.datas, a.dtemis, a.nalineas," + ;
                " a.emps, a.iclis, a.grclis, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.grures, a.conres, a.protocolos, a.leituras, a.numeros" + ;
                " FROM SIGCHE a" + ;
                " WHERE a.numos = " + FormatarNumeroSQL(par_nNumLotes) + ;
                " ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

            IF USED("cursor_4c_Cheques")
                USE IN cursor_4c_Cheques
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cheques")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar cheques do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.this_nQtdeCheqs = RECCOUNT("cursor_4c_Cheques")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.BuscarCheques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterProximoLote - Retorna proximo numlotes disponivel para a empresa
    *==========================================================================
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigChLcq" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo
        loc_lSucesso = .F.

        TRY
            loc_nProximo = THIS.ObterProximoLote()
            THIS.this_nNumLotes = loc_nProximo

            loc_cSQL = "INSERT INTO SigChLcq (" + ;
                " numlotes, numloteFps, codigos, emps, usuarios, moeds, cotas, cotusus," + ;
                " valtots, valconvs, dtents, datatrans, grupos, contas," + ;
                " iclis, grclis, obs, concs, grucarts, concarts," + ;
                " gruorigs, conorigs, grupoccs, contaccs, grupems, contems," + ;
                " gratends, atends, autos, tipos, nums, numdopes, dopes," + ;
                " empdopnums, cnotas, locals, ntrans, dtsis)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLotes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumLoteFPs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                "0," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConRes)) + "," + ;
                "0,'','',0,'','',0,0,GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigChLcq SET" + ;
                " codigos = "   + EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                " emps = "      + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                " cotusus = "   + EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                " dtents = "    + FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                " datatrans = " + IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                " grupos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                " contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                " iclis = "     + EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                " grclis = "    + EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                " obs = "       + EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                " grucarts = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                " concarts = "  + EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                " gruorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                " conorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                " grupoccs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                " contaccs = "  + EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                " grupems = "   + EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                " contems = "   + EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                " gratends = "  + EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                " atends = "    + EscaparSQL(ALLTRIM(THIS.this_cConRes)) + ;
                " WHERE numlotes = " + FormatarNumeroSQL(THIS.this_nNumLotes)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de cheques (SIGCHE) e do lote (SigChLcq)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigChLcq WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

