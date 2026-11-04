*==============================================================================
* ProbeCks702Fase6.prg - Probe da Fase 6 de Formsigopcks (task702)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA com os parametros do Init legado
*   2) os BINDEVENTs estao REGISTRADOS (AEVENTS, nao PEMSTATUS) nos dois
*      campos: usuario -> KeyPress/LostFocus/DblClick, senha -> LostFocus
*   3) os delegates e o funil sao PUBLIC (alvo de BINDEVENT - regra #3;
*      PEMSTATUS atributo 2 = Protected)
*   4) usuario.When legado: Enabled = .F. em senha-do-dia (MAXIMO) e
*      Enabled = .T. no tipo comum (CANCITEM)
*   5) o truque das colunas do picker (zerar this_nColunas + mAddColuna)
*      devolve as DUAS colunas com os titulos do legado (Codigo/cargo) e
*      preserva this_cCampoCodigo/this_cCampoDescricao, de que Mostrar depende
*   6) AbortarAutorizacao deixa BO.this_lZSen = .F. (fail-closed) e
*      FecharDialogo (Hide) nao estoura em form ainda nao exibido
*
* NAO chama Show() nem Mostrar(): os dois sao MODAIS (WindowType = 1) e
* bloqueariam o harness headless. NAO exercita ValidarUsuario/ValidarSenha com
* valor preenchido: o SQL Server 192.168.200.10 nao tem rota desta maquina
* (gnConnHandle = -1 aqui).
*
* Regra #6: script auxiliar roda unattended - SET SAFETY OFF + SET RESOURCE OFF.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cks702.txt"
#DEFINE OUT "C:\4c\automation\probe_cks702_f6.txt"

LOCAL loc_oForm, loc_oBO, loc_oForm2, loc_oBusca, loc_cL, loc_nFalhas, loc_oE
LOCAL loc_nBind, loc_i, loc_cEventos, loc_nColunas
LOCAL ARRAY loc_aEv[1]
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 6 - Formsigopcks (task702) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigopcksBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigopcks.prg") ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao com os parametros do Init legado (_Tipo, _Titulo, _Titulo2)
    loc_oForm = CREATEOBJECT("Formsigopcks", "CANCITEM", "Cancelamento de Item", ;
                             "Item ja faturado!")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", ;
                  " Width=" + TRANSFORM(loc_oForm.Width) + ;
                  " Height=" + TRANSFORM(loc_oForm.Height) + ;
                  " Caption=[" + ALLTRIM(loc_oForm.Caption) + "]", ;
                  " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) BINDEVENTs REGISTRADOS (AEVENTS tem DOIS argumentos; evento = col 3)
    loc_nBind = AEVENTS(loc_aEv, loc_oForm.txt_4c_Usuario)
    loc_cEventos = ""
    FOR loc_i = 1 TO loc_nBind
        loc_cEventos = loc_cEventos + "[" + ALLTRIM(loc_aEv[loc_i, 3]) + "->" + ;
                       ALLTRIM(loc_aEv[loc_i, 4]) + "]"
    ENDFOR
    loc_cL = "2) BINDEVENT em txt_4c_Usuario: n=" + TRANSFORM(loc_nBind) + " " + ;
             loc_cEventos + CHR(13) + CHR(10)
    IF loc_nBind < 3 OR !("KEYPRESS" $ UPPER(loc_cEventos)) ;
            OR !("LOSTFOCUS" $ UPPER(loc_cEventos)) OR !("DBLCLICK" $ UPPER(loc_cEventos))
        loc_cL = loc_cL + "   *** FALHA: faltou binding no campo usuario" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    loc_nBind = AEVENTS(loc_aEv, loc_oForm.txt_4c_Senha)
    loc_cEventos = ""
    FOR loc_i = 1 TO loc_nBind
        loc_cEventos = loc_cEventos + "[" + ALLTRIM(loc_aEv[loc_i, 3]) + "->" + ;
                       ALLTRIM(loc_aEv[loc_i, 4]) + "]"
    ENDFOR
    loc_cL = loc_cL + "   BINDEVENT em txt_4c_Senha: n=" + TRANSFORM(loc_nBind) + " " + ;
             loc_cEventos + CHR(13) + CHR(10)
    IF loc_nBind < 1 OR !("LOSTFOCUS" $ UPPER(loc_cEventos))
        loc_cL = loc_cL + "   *** FALHA: faltou binding no campo senha" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) escopos: tudo que BINDEVENT chama (ou que o funil usa) tem de ser PUBLIC
    loc_cL = "3) escopos (atributo 2 = Protected; esperado .F. em todos):" + CHR(13) + CHR(10) + ;
        "   UsuarioKeyPress            = " + TRANSFORM(PEMSTATUS(loc_oForm, "UsuarioKeyPress", 2)) + CHR(13) + CHR(10) + ;
        "   UsuarioDblClick            = " + TRANSFORM(PEMSTATUS(loc_oForm, "UsuarioDblClick", 2)) + CHR(13) + CHR(10) + ;
        "   ValidarUsuarioDigitado     = " + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarUsuarioDigitado", 2)) + CHR(13) + CHR(10) + ;
        "   ValidarUsuarioDigitadoExec = " + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarUsuarioDigitadoExec", 2)) + CHR(13) + CHR(10) + ;
        "   AbrirBuscaUsuario          = " + TRANSFORM(PEMSTATUS(loc_oForm, "AbrirBuscaUsuario", 2)) + CHR(13) + CHR(10) + ;
        "   ValidarSenhaDigitada       = " + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarSenhaDigitada", 2)) + CHR(13) + CHR(10) + ;
        "   ValidarSenhaDigitadaExec   = " + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarSenhaDigitadaExec", 2)) + CHR(13) + CHR(10) + ;
        "   AbortarAutorizacao         = " + TRANSFORM(PEMSTATUS(loc_oForm, "AbortarAutorizacao", 2)) + CHR(13) + CHR(10) + ;
        "   FecharDialogo              = " + TRANSFORM(PEMSTATUS(loc_oForm, "FecharDialogo", 2)) + CHR(13) + CHR(10) + ;
        "   ConfigurarBINDEVENTs       = " + TRANSFORM(PEMSTATUS(loc_oForm, "ConfigurarBINDEVENTs", 2)) + CHR(13) + CHR(10) + ;
        "   AplicarRegraWhenUsuario    = " + TRANSFORM(PEMSTATUS(loc_oForm, "AplicarRegraWhenUsuario", 2)) + CHR(13) + CHR(10)
    IF PEMSTATUS(loc_oForm, "UsuarioKeyPress", 2) OR PEMSTATUS(loc_oForm, "UsuarioDblClick", 2) ;
            OR PEMSTATUS(loc_oForm, "ValidarUsuarioDigitado", 2) ;
            OR PEMSTATUS(loc_oForm, "ValidarUsuarioDigitadoExec", 2) ;
            OR PEMSTATUS(loc_oForm, "AbrirBuscaUsuario", 2) ;
            OR PEMSTATUS(loc_oForm, "ValidarSenhaDigitada", 2) ;
            OR PEMSTATUS(loc_oForm, "ValidarSenhaDigitadaExec", 2) ;
            OR PEMSTATUS(loc_oForm, "AbortarAutorizacao", 2) ;
            OR PEMSTATUS(loc_oForm, "FecharDialogo", 2) ;
            OR PEMSTATUS(loc_oForm, "ConfigurarBINDEVENTs", 2) ;
            OR PEMSTATUS(loc_oForm, "AplicarRegraWhenUsuario", 2)
        loc_cL = loc_cL + "   *** FALHA: metodo PROTECTED no caminho de BINDEVENT" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) usuario.When legado: CANCITEM digitavel, MAXIMO nao
    loc_oForm2 = CREATEOBJECT("Formsigopcks", "MAXIMO", "30 dias", "Cond. Pagto")
    loc_cL = "4) usuario.When (Enabled):" + CHR(13) + CHR(10) + ;
        "   CANCITEM -> Enabled=" + TRANSFORM(loc_oForm.txt_4c_Usuario.Enabled) + ;
        " / SenhaDoDia=" + TRANSFORM(loc_oBO.EstaEmModoSenhaDoDia()) + ;
        "   esperado .T./.F." + CHR(13) + CHR(10)
    IF VARTYPE(loc_oForm2) = "O"
        loc_cL = loc_cL + "   MAXIMO   -> Enabled=" + TRANSFORM(loc_oForm2.txt_4c_Usuario.Enabled) + ;
            " / SenhaDoDia=" + TRANSFORM(loc_oForm2.this_oBusinessObject.EstaEmModoSenhaDoDia()) + ;
            "   esperado .F./.T." + CHR(13) + CHR(10) + ;
            "   MAXIMO   -> usuario.Value=[" + ALLTRIM(loc_oForm2.txt_4c_Usuario.Value) + ;
            "] lbl Senha=[" + ALLTRIM(loc_oForm2.lbl_4c_Label3.Caption) + "]" + CHR(13) + CHR(10)
        IF !loc_oForm.txt_4c_Usuario.Enabled OR loc_oForm2.txt_4c_Usuario.Enabled
            loc_cL = loc_cL + "   *** FALHA: regra When nao aplicada" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    ELSE
        loc_cL = loc_cL + "   *** FALHA: form com tipo MAXIMO nao abriu" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) colunas do picker: cursor fabricado (sem banco) + o truque do titulo
    CREATE CURSOR cursor_4c_Usuar (usuarios C(10), senhas C(10), ccargs C(10), cativos C(1))
    INSERT INTO cursor_4c_Usuar VALUES ("TESTE", "XYZ", "GERENTE", "S")
    INSERT INTO cursor_4c_Usuar VALUES ("OUTRO", "ABC", "CAIXA", "S")

    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
    loc_cL = "5) colunas do picker: VARTYPE=" + VARTYPE(loc_oBusca) + CHR(13) + CHR(10)
    IF VARTYPE(loc_oBusca) = "O"
        loc_oBusca.DefinirCursor("cursor_4c_Usuar", "usuarios", "ccargs", ;
            "Sele" + CHR(231) + CHR(227) + "o")
        loc_oBusca.this_nColunas = 0
        loc_oBusca.mAddColuna("usuarios", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("ccargs", "", "cargo")
        loc_nColunas = loc_oBusca.this_nColunas
        loc_cL = loc_cL + "   this_nColunas=" + TRANSFORM(loc_nColunas) + " esperado 2" + CHR(13) + CHR(10) + ;
            "   col1=[" + ALLTRIM(loc_oBusca.this_aColunas[1,1]) + "/" + ;
            ALLTRIM(loc_oBusca.this_aColunas[1,3]) + "]" + ;
            "  col2=[" + ALLTRIM(loc_oBusca.this_aColunas[2,1]) + "/" + ;
            ALLTRIM(loc_oBusca.this_aColunas[2,3]) + "]" + CHR(13) + CHR(10) + ;
            "   CampoCodigo=[" + ALLTRIM(loc_oBusca.this_cCampoCodigo) + ;
            "] CampoDescricao=[" + ALLTRIM(loc_oBusca.this_cCampoDescricao) + ;
            "] Titulo=[" + ALLTRIM(loc_oBusca.this_cTitulo) + "]" + CHR(13) + CHR(10)
        IF loc_nColunas != 2 ;
                OR ALLTRIM(loc_oBusca.this_aColunas[1,1]) != "usuarios" ;
                OR ALLTRIM(loc_oBusca.this_aColunas[2,1]) != "ccargs" ;
                OR ALLTRIM(loc_oBusca.this_cCampoCodigo) != "usuarios" ;
                OR ALLTRIM(loc_oBusca.this_cCampoDescricao) != "ccargs"
            loc_cL = loc_cL + "   *** FALHA: colunas/campos do picker errados" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
        loc_oBusca.Release()
    ELSE
        loc_cL = loc_cL + "   *** FALHA: FormBuscaAuxiliar nao instanciou" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) abortar: fail-closed + Hide em form nao exibido
    loc_oBO.this_lZSen = .T.
    loc_oForm.AbortarAutorizacao()
    loc_cL = "6) AbortarAutorizacao -> BO.this_lZSen=" + TRANSFORM(loc_oBO.this_lZSen) + ;
             " esperado .F. (Hide sem erro)" + CHR(13) + CHR(10)
    IF loc_oBO.this_lZSen
        loc_cL = loc_cL + "   *** FALHA: nao ficou fail-closed" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    STRTOFILE("PROBE_FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("*** ERRO NAO TRATADO: " + loc_oE.Message + ;
        " | LN=" + TRANSFORM(loc_oE.LineNo) + ;
        " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("PROBE_FALHAS=EXCECAO" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT
