SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_sbn602_erros.txt"
gnConnHandle           = -1
gc_4c_UsuarioLogado    = "TESTE"

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\utils\,C:\4c\projeto\app\classes\,C:\4c\projeto\app\start\")
SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\sigpremaBO.prg") ADDITIVE

LOCAL loc_cOut, loc_oBO, loc_cChave
loc_cOut = "PATH medido = [" + SET("PATH") + "]" + CHR(13)

TRY
    loc_oBO = CREATEOBJECT("sigpremaBO")
    IF VARTYPE(loc_oBO) = "O"
        loc_cOut = loc_cOut + "CREATEOBJECT: OK (classe=" + loc_oBO.Class + ")" + CHR(13)
    ELSE
        loc_cOut = loc_cOut + "CREATEOBJECT: FALHOU - VARTYPE=" + VARTYPE(loc_oBO) + CHR(13)
    ENDIF
CATCH TO loc_oE
    loc_cOut = loc_cOut + "CREATEOBJECT: EXCECAO " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + CHR(13)
ENDTRY

IF VARTYPE(loc_oBO) = "O"
    *-- chave posicional: 3 + 20 + 6 = 29 (regra Erro177)
    TRY
        loc_cChave = loc_oBO.MontarChaveEmpDopNums("001", "MALOTE", 3)
        loc_cOut = loc_cOut + "MontarChaveEmpDopNums: len=" + TRANSFORM(LEN(loc_cChave)) + ;
                   " (esperado 29) [" + loc_cChave + "]" + CHR(13)
    CATCH TO loc_oE
        loc_cOut = loc_cOut + "MontarChaveEmpDopNums: EXCECAO " + loc_oE.Message + CHR(13)
    ENDTRY

    *-- Inserir/Atualizar devem VIR DA BASE e recusar sem ficar mudos
    TRY
        loc_oBO.NovoRegistro()
        loc_cOut = loc_cOut + "Salvar() em BO somente-leitura retornou: " + ;
                   TRANSFORM(loc_oBO.Salvar()) + " (esperado .F.)" + CHR(13)
        loc_cOut = loc_cOut + "  this_lErroExibido = " + TRANSFORM(loc_oBO.this_lErroExibido) + CHR(13)
    CATCH TO loc_oE
        loc_cOut = loc_cOut + "Salvar: EXCECAO " + loc_oE.Message + CHR(13)
    ENDTRY

    *-- MarcarTodos/DesmarcarTodos/OrdenarPorColuna sem cursor: nao podem estourar
    TRY
        loc_oBO.MarcarTodos()
        loc_oBO.DesmarcarTodos()
        loc_oBO.OrdenarPorColuna("Rclis")
        loc_cOut = loc_cOut + "MarcarTodos/DesmarcarTodos/OrdenarPorColuna sem cursor: OK (sem excecao)" + CHR(13)
    CATCH TO loc_oE
        loc_cOut = loc_cOut + "Marcar/Ordenar: EXCECAO " + loc_oE.Message + CHR(13)
    ENDTRY

    *-- RegistrarLogEnvio passa pelo wrapper no-op utils\fgravarlog.prg
    TRY
        loc_cOut = loc_cOut + "RegistrarLogEnvio: " + TRANSFORM(loc_oBO.RegistrarLogEnvio("001MALOTE   3")) + CHR(13)
    CATCH TO loc_oE
        loc_cOut = loc_cOut + "RegistrarLogEnvio: EXCECAO " + loc_oE.Message + CHR(13)
    ENDTRY

    loc_oBO = .NULL.
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + CHR(13) + "--- erros capturados em modo teste ---" + CHR(13) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\probe_sbn602_result.txt")
QUIT
