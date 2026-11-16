SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loE, loForm, loc_lr
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_PrbDir, gn_4c_PrbPag
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_PrbDir = "C:\4c\refatoracao\automation\erro379\"
gn_4c_PrbPag = 0
gc_4c_ArquivoErroTeste = gc_4c_PrbDir + "mensagens.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSigReInf")
    CD (gc_4c_PrbDir)   && sigprnfx.prg do probe (PNG no lugar da impressora)

    *-- A: pelo menu, sem NF (a imagem)
    loForm = CREATEOBJECT("FormSigReInf")
    loc_cOut = loc_cOut + "A) menu: form=" + VARTYPE(loForm) + " caption=[" + loForm.Caption + "] W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + ;
        " botoes L=" + TRANSFORM(loForm.cmg_4c_Botoes.Left) + " vis.en=" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(1).Enabled) + " imp.en=" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(2).Enabled) + " email.en=" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(3).Enabled) + CHR(13)+CHR(10)
    gn_4c_PrbPag = 0
    loForm.BtnImprimirClick()
    loc_cOut = loc_cOut + "   imprimir sem NF: paginas=" + TRANSFORM(gn_4c_PrbPag) + " form aberto=" + TRANSFORM(VARTYPE(loForm) = "O" AND !ISNULL(loForm)) + CHR(13)+CHR(10)
    IF VARTYPE(loForm) = "O"
        loForm.Release()
    ENDIF

    *-- B: Visualizar NF 000032 (VENDA 9364) - modo "V" direto no BO
    loForm = CREATEOBJECT("FormSigReInf", "001", "VENDA", 9364, "1")
    loc_cOut = loc_cOut + "B) NF VENDA 9364: caption=[" + loForm.Caption + "]" + CHR(13)+CHR(10)
    gn_4c_PrbPag = 0
    loc_lr = loForm.this_oRelatorio.Visualizar()
    loc_cOut = loc_cOut + "   visualizar=" + TRANSFORM(loc_lr) + " paginas png=" + TRANSFORM(gn_4c_PrbPag) + " msg=[" + loForm.this_oRelatorio.this_cMensagemErro + "]" + CHR(13)+CHR(10)
    IF FILE(gc_4c_PrbDir + "nf_1.png")
        RENAME (gc_4c_PrbDir + "nf_1.png") TO (gc_4c_PrbDir + "B_visualizar_nf000032.png")
    ENDIF

    *-- C: Imprimir pelo botao (modo "I": grava Impress e fecha a tela)
    gn_4c_PrbPag = 0
    loForm.BtnImprimirClick()
    =SQLEXEC(gnConnHandle, "SELECT impress FROM SigMvNfi WHERE emps = '001' AND nfis = '000032' AND dopes = 'VENDA'", "cImp")
    loc_cOut = loc_cOut + "C) imprimir: paginas=" + TRANSFORM(gn_4c_PrbPag) + " Impress no banco=" + TRANSFORM(cImp.impress) + ;
        " tela fechou=" + TRANSFORM(VARTYPE(loForm) <> "O" OR ISNULL(loForm)) + CHR(13)+CHR(10)
    IF FILE(gc_4c_PrbDir + "nf_1.png")
        RENAME (gc_4c_PrbDir + "nf_1.png") TO (gc_4c_PrbDir + "C_imprimir_nf000032.png")
    ENDIF

    *-- D: NF inexistente
    loForm = CREATEOBJECT("FormSigReInf", "001", "VENDA", 999999, "1")
    gn_4c_PrbPag = 0
    loc_lr = loForm.this_oRelatorio.Visualizar()
    loc_cOut = loc_cOut + "D) NF inexistente: visualizar=" + TRANSFORM(loc_lr) + " paginas=" + TRANSFORM(gn_4c_PrbPag) + CHR(13)+CHR(10)
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, gc_4c_PrbDir + "simulacao_out.txt")
QUIT
