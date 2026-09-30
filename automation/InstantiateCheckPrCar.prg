SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_prcar.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_cNome, loc_i
loc_cRes = "FAIL(v2)"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    *-- Subclasse de teste: os hooks FormParaBO/BOParaForm/LimparCampos sao
    *-- PROTECTED (herdados de FormBase), logo so uma SUBCLASSE consegue
    *-- exercita-los de fora do corpo original - exatamente como FormBase faz.
    loc_oForm = CREATEOBJECT("ProbeSigPrCar", .NULL., "TESTE00000001", "ALTERAR")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK" + ;
            " W=" + TRANSFORM(loc_oForm.Width) + ;
            " H=" + TRANSFORM(loc_oForm.Height) + ;
            " Cols=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
            " C1W=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + ;
            " C2W=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Width) + ;
            " MaxL1=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Text1.MaxLength) + ;
            " MaxL2=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Text1.MaxLength) + ;
            " Mrg1=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Text1.Margin) + ;
            " C1RO=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
            " InsVis=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Visible) + ;
            " InsEna=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Enabled) + ;
            " SairEna=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + ;
            " Modo=" + loc_oForm.this_cModoPai

        *-- HabilitarCampos eh PUBLIC (nao existe em FormBase)
        loc_oForm.HabilitarCampos(.F.)
        loc_cRes = loc_cRes + " | Hab(.F.): C1RO=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
                   " C2RO=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.ReadOnly) + ;
                   " InsEna=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Enabled) + ;
                   " SairEna=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled)
        loc_oForm.HabilitarCampos(.T.)
        loc_cRes = loc_cRes + " | Hab(.T.): C1RO=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
                   " InsEna=" + TRANSFORM(loc_oForm.cmd_4c_Inserir.Enabled)

        *-- Hooks protegidos, via subclasse: sem cursor devolvem .F. sem estourar
        loc_cRes = loc_cRes + " | semCursor: " + loc_oForm.ProbeHooks()

        *-- Agora COM cursor: cria o cursor da grade com a mesma estrutura que
        *-- SigPrCarBO.Buscar produz e exercita Inserir + os tres hooks
        *-- O form tem DataSession = 2 (privada): o cursor da grade tem de ser
        *-- criado DENTRO da sessao dele, senao USED() dentro dos metodos da .F.
        SET DATASESSION TO loc_oForm.DataSessionId
        SET NULL OFF
        CREATE CURSOR cursor_4c_Dados (pkchaves C(20), cpros C(14), codigos C(20), descrs C(40))
        loc_oForm.BtnInserirClick()
        loc_cRes = loc_cRes + " | posInserir: Rec=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + ;
                   " cpros=[" + ALLTRIM(cursor_4c_Dados.cpros) + "]" + ;
                   " pkVazio=" + TRANSFORM(EMPTY(cursor_4c_Dados.pkchaves)) + ;
                   " ehNovo=" + TRANSFORM(loc_oForm.EhRegistroNovo(ALLTRIM(cursor_4c_Dados.pkchaves)))
        REPLACE codigos WITH "CAR001", descrs WITH "COR AZUL" IN cursor_4c_Dados
        loc_cRes = loc_cRes + " | comCursor: " + loc_oForm.ProbeHooks()

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_prcar.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_prcar.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_prcar_result.txt")
QUIT

DEFINE CLASS ProbeSigPrCar AS FormSigPrCar
    PROCEDURE ProbeHooks()
        LOCAL loc_c, loc_oE
        loc_c = "v2"
        TRY
            loc_c = loc_c + " FormParaBO=" + TRANSFORM(THIS.FormParaBO())
        CATCH TO loc_oE
            loc_c = loc_c + " FormParaBO=ERRO[" + loc_oE.Message + "]"
        ENDTRY
        TRY
            loc_c = loc_c + " BOParaForm=" + TRANSFORM(THIS.BOParaForm())
        CATCH TO loc_oE
            loc_c = loc_c + " BOParaForm=ERRO[" + loc_oE.Message + "]"
        ENDTRY
        TRY
            loc_c = loc_c + " LimparCampos=" + TRANSFORM(THIS.LimparCampos())
        CATCH TO loc_oE
            loc_c = loc_c + " LimparCampos=ERRO[" + loc_oE.Message + "]"
        ENDTRY
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            loc_c = loc_c + " codigosPosLimpar=[" + ALLTRIM(cursor_4c_Dados.codigos) + "]"
        ENDIF
        RETURN loc_c
    ENDPROC

    PROCEDURE ProbeHooksAntigo()
        LOCAL loc_c
        loc_c = "FormParaBO=" + TRANSFORM(THIS.FormParaBO())
        loc_c = loc_c + " BOParaForm=" + TRANSFORM(THIS.BOParaForm())
        loc_c = loc_c + " LimparCampos=" + TRANSFORM(THIS.LimparCampos())
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            loc_c = loc_c + " codigosPosLimpar=[" + ALLTRIM(cursor_4c_Dados.codigos) + "]"
        ENDIF
        RETURN loc_c
    ENDPROC
ENDDEFINE
