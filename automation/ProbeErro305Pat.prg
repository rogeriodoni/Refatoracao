*==============================================================================
* ProbeErro305Pat.prg - Erro305: "Nao esta em modo de edicao" ao Confirmar.
* Prova que o BO entra/sai de edicao nos caminhos certos. Usa uma subclasse
* de teste do BO para nao depender do banco: so o ESTADO (this_lEmEdicao /
* this_lNovoRegistro) importa aqui.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gcL305, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_pat305.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

gcL305 = "C:\4c\automation\probe_erro305_pat.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL305)

LOCAL loc_oE, loF, loBO

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "PATBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormPAT.prg") ADDITIVE
    Log305("B: deps carregadas")

    go_4c_Sistema = CREATEOBJECT("Empty")
    ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")

    loF = CREATEOBJECT("FormPAT")
    Log305("C: CREATEOBJECT -> " + VARTYPE(loF))
    IF VARTYPE(loF) # "O"
        Log305("   abortando")
    ELSE
        loBO = loF.this_oBusinessObject
        *-- O FormPAT tem DataSession = 2 (sessao PRIVADA). Cursor criado na
        *-- sessao padrao e INVISIVEL para os metodos do form - USED() devolve
        *-- .F. e o BtnAlterarClick aborta em "Selecione um registro". Entrar na
        *-- sessao do form antes de montar qualquer cursor de teste.
        SET DATASESSION TO loF.DataSessionId
        Log305("D: estado inicial -> " + Est(loBO) + ;
               "   DataSessionId=" + TRANSFORM(loF.DataSessionId))

        *-- cursor minimo para o caminho de ALTERAR nao abortar
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados (pkchaves C(20), datas T, emps C(3), ;
            codvends C(10), clientes C(50), vendconcs N(1,0), perguntas M)
        INSERT INTO cursor_4c_Dados VALUES ("K1", DATETIME(), "001", ;
            "1110100001", "A", 1, "teste")
        GO TOP

        *-- 1) INCLUIR deve POR em edicao
        Log305("E: --- INCLUIR ---")
        loF.BtnIncluirClick()
        Log305("   depois de BtnIncluirClick -> " + Est(loBO) + ;
               "   Salvar aceitaria? " + TRANSFORM(loBO.this_lEmEdicao))

        *-- 2) ENCERRAR deve TIRAR de edicao
        Log305("F: --- ENCERRAR (cancelar) ---")
        loF.BtnCancelarClick()
        Log305("   depois de BtnCancelarClick -> " + Est(loBO))

        *-- 3) ALTERAR depois de um INCLUIR cancelado: o cenario que fazia o
        *--    EditarRegistro() ser recusado e o erro voltar
        Log305("G: --- ALTERAR apos INCLUIR cancelado ---")
        *-- o IrParaLista do Encerrar chama CarregarLista -> Buscar, que sem
        *-- banco DESTROI o cursor. Repor antes, senao o BtnAlterarClick aborta
        *-- em "Selecione um registro" e o teste nao exercita nada.
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados (pkchaves C(20), datas T, emps C(3), ;
            codvends C(10), clientes C(50), vendconcs N(1,0), perguntas M)
        INSERT INTO cursor_4c_Dados VALUES ("K1", DATETIME(), "001", ;
            "1110100001", "A", 1, "teste")
        GO TOP
        Log305("   cursor reposto: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")))
        loF.BtnAlterarClick()
        Log305("   depois de BtnAlterarClick -> " + Est(loBO) + ;
               "   Salvar aceitaria? " + TRANSFORM(loBO.this_lEmEdicao))

        *-- 4) o caminho do erro original: Confirmar SEM ter entrado em edicao
        Log305("H: --- controle negativo: Salvar fora de edicao ---")
        loBO.CancelarEdicao()
        Log305("   apos CancelarEdicao -> " + Est(loBO))
        Log305("   Salvar() = " + TRANSFORM(loBO.Salvar()) + ;
               "  msg=[" + ALLTRIM(loBO.this_cMensagemErro) + "]" + ;
               "  erroExibido=" + TRANSFORM(loBO.this_lErroExibido))

        SET DATASESSION TO 1
        loF.Release()
        Log305("I: Release OK")
    ENDIF

CATCH TO loc_oE
    Log305("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
           " | Proc:" + loc_oE.Procedure)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    Log305("DIALOGOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    Log305("DIALOGOS: nenhum")
ENDIF
Log305("Z: fim")
QUIT

PROCEDURE Log305(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL305, 1)
ENDPROC

FUNCTION Est(par_oBO)
    RETURN "EmEdicao=" + PADR(TRANSFORM(par_oBO.this_lEmEdicao), 3) + ;
           " NovoRegistro=" + PADR(TRANSFORM(par_oBO.this_lNovoRegistro), 3)
ENDFUNC
