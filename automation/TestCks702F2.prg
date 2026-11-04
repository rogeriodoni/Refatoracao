*-- Teste de instanciacao e logica pura da Fase 2 (SigOpCks/task702).
*-- Sem conexao SQL real: gnConnHandle = -1, como no ValidarUIFidelity.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ValidandoUI
gnConnHandle = -1
gc_4c_UsuarioLogado = "TESTUSR"
gb_4c_ValidandoUI = .T.

SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\sigopcksBO.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE

LOCAL loc_oBO, loc_cSaida, loc_lOk
loc_cSaida = ""

TRY
    loc_oBO = CREATEOBJECT("sigopcksBO")
    loc_cSaida = loc_cSaida + "VARTYPE=" + VARTYPE(loc_oBO) + CHR(13)

    *-- DTENTREGA: sem flags, texto simples
    loc_oBO.DefinirTipo("DTENTREGA", "Pedido 123", "", 0, DATE(), " ", " ", 0)
    loc_cSaida = loc_cSaida + "DTENTREGA.Caption=[" + loc_oBO.this_cCaption + "]" + CHR(13)
    loc_cSaida = loc_cSaida + "DTENTREGA.Frase=[" + loc_oBO.this_cFrase + "]" + CHR(13)
    loc_cSaida = loc_cSaida + "DTENTREGA.Financ=" + TRANSFORM(loc_oBO.this_lFinanc) + CHR(13)

    *-- CHDEVOLVIDO com 1 cheque (_Titulo numerico = 1)
    loc_oBO.DefinirTipo("CHDEVOLVIDO", 1, "12345", 0, DATE(), " ", " ", 0)
    loc_cSaida = loc_cSaida + "CHDEV1.Frase=[" + loc_oBO.this_cFrase + "]" + CHR(13)
    loc_cSaida = loc_cSaida + "CHDEV1.Financ=" + TRANSFORM(loc_oBO.this_lFinanc) + CHR(13)

    *-- CHDEVOLVIDO com 3 cheques
    loc_oBO.DefinirTipo("CHDEVOLVIDO", 3, "12345", 0, DATE(), " ", " ", 0)
    loc_cSaida = loc_cSaida + "CHDEV3.Frase=[" + loc_oBO.this_cFrase + "]" + CHR(13)

    *-- MAXIMO
    loc_oBO.DefinirTipo("MAXIMO", "ABC", "Condicao X", 0, DATE(), " ", " ", 0)
    loc_cSaida = loc_cSaida + "MAXIMO.Caption=[" + loc_oBO.this_cCaption + "]" + CHR(13)
    loc_cSaida = loc_cSaida + "MAXIMO.Frase=[" + loc_oBO.this_cFrase + "]" + CHR(13)
    loc_cSaida = loc_cSaida + "MAXIMO.EstaEmModoSenhaDoDia=" + TRANSFORM(loc_oBO.EstaEmModoSenhaDoDia()) + CHR(13)
    loc_cSaida = loc_cSaida + "MAXIMO.DevePreencherUsuarioLogado=" + TRANSFORM(loc_oBO.DevePreencherUsuarioLogado()) + CHR(13)

    *-- LIBPRDZ2 (this_lLiblCreds fica .F. sem banco -> EstaEmModoSenhaDoDia
    *-- deve dar .F. mesmo com DevePreencherUsuarioLogado = .T., conforme a
    *-- divergencia documentada na secao 7 do BO)
    loc_oBO.DefinirTipo("LIBPRDZ2", "X", "Y", 0, DATE(), " ", " ", 0)
    loc_cSaida = loc_cSaida + "LIBPRDZ2.LibProducao=" + TRANSFORM(loc_oBO.this_lLibProducao) + CHR(13)
    loc_cSaida = loc_cSaida + "LIBPRDZ2.EstaEmModoSenhaDoDia=" + TRANSFORM(loc_oBO.EstaEmModoSenhaDoDia()) + CHR(13)
    loc_cSaida = loc_cSaida + "LIBPRDZ2.DevePreencherUsuarioLogado=" + TRANSFORM(loc_oBO.DevePreencherUsuarioLogado()) + CHR(13)

    *-- LIBTITULO
    loc_oBO.DefinirTipo("LIBTITULO", "Titulo 999", "", 0, DATE(), " ", " ", 0)
    loc_cSaida = loc_cSaida + "LIBTITULO.Caption=[" + loc_oBO.this_cCaption + "]" + CHR(13)
    loc_cSaida = loc_cSaida + "LIBTITULO.LiberaTitulo=" + TRANSFORM(loc_oBO.this_lLiberaTitulo) + CHR(13)

    *-- MOVESTOQUE (usa this_cTitulo nos dois textos)
    loc_oBO.DefinirTipo("MOVESTOQUE", "Movimento Z", "ignorado", 0, DATE(), " ", " ", 0)
    loc_cSaida = loc_cSaida + "MOVESTOQUE.Caption=[" + loc_oBO.this_cCaption + "]" + CHR(13)
    loc_cSaida = loc_cSaida + "MOVESTOQUE.Frase=[" + loc_oBO.this_cFrase + "]" + CHR(13)

    *-- ObterQuerySqlUsuario eh PROTECTED - confirma que NAO pode ser
    *-- chamado de fora (regra #51); CarregarUsuariosAutorizados (PUBLIC)
    *-- eh quem usa internamente
    loc_oBO.DefinirTipo("CANCITEM", "T1", "T2", 0, DATE(), " ", " ", 0)
    loc_cSaida = loc_cSaida + "PEMSTATUS_ObterQuerySqlUsuario_Protected=" + ;
        TRANSFORM(PEMSTATUS(loc_oBO, "ObterQuerySqlUsuario", 2)) + CHR(13)

    *-- ObterChavePrimaria / CarregarDoCursor (cursor manual, sem SQL)
    IF USED("cursor_4c_Fake")
        USE IN cursor_4c_Fake
    ENDIF
    CREATE CURSOR cursor_4c_Fake (usuarios C(10), senhas C(10), ccargs C(10), cativos C(1))
    INSERT INTO cursor_4c_Fake VALUES ("JOAO", "SENHA123", "GERENTE", "S")
    loc_lOk = loc_oBO.CarregarDoCursor("cursor_4c_Fake")
    loc_cSaida = loc_cSaida + "CarregarDoCursor=" + TRANSFORM(loc_lOk) + ;
        " Usuario=[" + loc_oBO.this_cUsuario + "] Senha=[" + loc_oBO.this_cSenhaCadastrada + ;
        "] Cargo=[" + loc_oBO.this_cCargoUsuario + "] Ativo=[" + loc_oBO.this_cUsuarioAtivo + "]" + CHR(13)
    *-- ObterChavePrimaria eh PROTECTED (so RegistrarAuditoria chama) -
    *-- confirma status em vez de chamar direto
    loc_cSaida = loc_cSaida + "PEMSTATUS_ObterChavePrimaria_Protected=" + ;
        TRANSFORM(PEMSTATUS(loc_oBO, "ObterChavePrimaria", 2)) + CHR(13)
    loc_cSaida = loc_cSaida + "UsuarioTemSenhaCadastrada=" + TRANSFORM(loc_oBO.UsuarioTemSenhaCadastrada()) + CHR(13)
    USE IN cursor_4c_Fake

    *-- CarregarParametrosSistema sem conexao real (gnConnHandle=-1): nao
    *-- deve travar, so falhar dentro do TRY e manter os defaults .F.
    loc_lOk = loc_oBO.CarregarParametrosSistema()
    loc_cSaida = loc_cSaida + "CarregarParametrosSistema_SemConexao=" + TRANSFORM(loc_lOk) + ;
        " LiblCreds=" + TRANSFORM(loc_oBO.this_lLiblCreds) + CHR(13)

    *-- ValidarSenha sem fCriptografar portada: deve devolver .F. e
    *-- mensagem de erro, sem travar (fail-closed)
    loc_oBO.this_cSenhaCadastrada = "XYZ"
    loc_lOk = loc_oBO.ValidarSenha("123")
    loc_cSaida = loc_cSaida + "ValidarSenha_SemfCriptografar=" + TRANSFORM(loc_lOk) + ;
        " ZSen=" + TRANSFORM(loc_oBO.this_lZSen) + ;
        " MsgErro=[" + loc_oBO.this_cMensagemErro + "]" + CHR(13)

    loc_cSaida = loc_cSaida + "FIM_OK"
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "EXCECAO: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\test_cks702_f2_output.txt")
QUIT
