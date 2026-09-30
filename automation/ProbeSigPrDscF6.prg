*==============================================================================
* ProbeSigPrDscF6.prg - prova headless da Fase 6 do FormSigPrDsc
*
* Mede o que a Fase 6 entrega: os 3 campos de filtro, os 2 metodos de lookup
* e a exclusividade faixa-de-produto X grupo (PROCEDURE When do legado).
*
* NAO chama ConfigurarAmbiente() - ele nao retorna nesta maquina; carrega a
* mao so as dependencias do form. Bootstrap de modo teste em PAR
* (gb_4c_ModoTeste + gc_4c_ArquivoErroTeste), senao MsgErro cai em MESSAGEBOX
* real e o processo trava sem produzir resultado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_sigprdsc_f6_dialogs.txt"

LOCAL loc_cOut, loc_cLog, loc_oForm, loc_oErro
loc_cLog = "C:\4c\automation\probe_sigprdsc_f6_resultado.txt"
loc_cOut = ""

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

STRTOFILE("[1] bootstrap" + CHR(13) + CHR(10), loc_cLog, 0)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)

    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrDscBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrDsc.prg") ADDITIVE

    STRTOFILE("[2] dependencias carregadas" + CHR(13) + CHR(10), loc_cLog, 1)

    *-- sem SQL Server alcancavel nesta maquina: handle invalido de proposito
    gnConnHandle = -1

    loc_oForm = CREATEOBJECT("FormSigPrDsc")
    STRTOFILE("[3] CREATEOBJECT retornou " + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cLog, 1)

    IF VARTYPE(loc_oForm) != "O"
        loc_cOut = "FAIL: CREATEOBJECT devolveu " + VARTYPE(loc_oForm)
    ELSE
        *-- (a) os 3 campos de filtro existem, com a geometria do SCX legado
        loc_cOut = "OK Init" + ;
            " | CProsI L=" + TRANSFORM(loc_oForm.txt_4c_CProsI.Left) + ;
                    " T=" + TRANSFORM(loc_oForm.txt_4c_CProsI.Top) + ;
                    " W=" + TRANSFORM(loc_oForm.txt_4c_CProsI.Width) + ;
                 " MaxL=" + TRANSFORM(loc_oForm.txt_4c_CProsI.MaxLength) + ;
            " | CProsF L=" + TRANSFORM(loc_oForm.txt_4c_CProsF.Left) + ;
                 " MaxL=" + TRANSFORM(loc_oForm.txt_4c_CProsF.MaxLength) + ;
            " | CGrus  L=" + TRANSFORM(loc_oForm.txt_4c_CGrus.Left) + ;
                 " MaxL=" + TRANSFORM(loc_oForm.txt_4c_CGrus.MaxLength) + ;
            " | lblGrupo=[" + ALLTRIM(loc_oForm.lbl_4c_Grupo.Caption) + "]"

        *-- (b) os metodos de lookup existem e sao alcancaveis de fora
        loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
            "metodos: AbrirLookupProduto=" + TRANSFORM(PEMSTATUS(loc_oForm, "AbrirLookupProduto", 5)) + ;
            " AbrirLookupGrupo=" + TRANSFORM(PEMSTATUS(loc_oForm, "AbrirLookupGrupo", 5)) + ;
            " AtualizarExclusividadeFiltros=" + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarExclusividadeFiltros", 5)) + ;
            " CProsIKeyPress=" + TRANSFORM(PEMSTATUS(loc_oForm, "CProsIKeyPress", 5))

        *-- (c) exclusividade: estado inicial (tudo vazio) = tudo habilitado
        loc_oForm.AtualizarExclusividadeFiltros()
        loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
            "vazio   -> CProsI=" + TRANSFORM(loc_oForm.txt_4c_CProsI.Enabled) + ;
            " CProsF=" + TRANSFORM(loc_oForm.txt_4c_CProsF.Enabled) + ;
            " CGrus=" + TRANSFORM(loc_oForm.txt_4c_CGrus.Enabled)

        *-- grupo preenchido -> faixa de produto inalcancavel (When de getCProsI/F)
        loc_oForm.txt_4c_CGrus.Value = "001"
        loc_oForm.AtualizarExclusividadeFiltros()
        loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
            "grupo   -> CProsI=" + TRANSFORM(loc_oForm.txt_4c_CProsI.Enabled) + ;
            " CProsF=" + TRANSFORM(loc_oForm.txt_4c_CProsF.Enabled) + ;
            " CGrus=" + TRANSFORM(loc_oForm.txt_4c_CGrus.Enabled)

        *-- faixa preenchida -> grupo inalcancavel (When de getCGrus)
        loc_oForm.txt_4c_CGrus.Value  = ""
        loc_oForm.txt_4c_CProsI.Value = "100"
        loc_oForm.AtualizarExclusividadeFiltros()
        loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
            "faixa   -> CProsI=" + TRANSFORM(loc_oForm.txt_4c_CProsI.Enabled) + ;
            " CProsF=" + TRANSFORM(loc_oForm.txt_4c_CProsF.Enabled) + ;
            " CGrus=" + TRANSFORM(loc_oForm.txt_4c_CGrus.Enabled)

        STRTOFILE("[4] exclusividade medida" + CHR(13) + CHR(10), loc_cLog, 1)

        *-- (d) lookup com handle invalido: o CATCH tem de segurar e devolver
        *--     .F. sem exibir picker. Se o picker abrisse, Show() de form
        *--     MODAL travaria e este .prg nunca chegaria ao fim.
        loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
            "lookupProduto(handle -1) devolveu " + ;
            TRANSFORM(loc_oForm.AbrirLookupProduto(loc_oForm.txt_4c_CProsI))

        STRTOFILE("[5] AbrirLookupProduto retornou" + CHR(13) + CHR(10), loc_cLog, 1)

        loc_oForm.txt_4c_CGrus.Value = "001"
        loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
            "lookupGrupo(handle -1)   devolveu " + ;
            TRANSFORM(loc_oForm.AbrirLookupGrupo(loc_oForm.txt_4c_CGrus))

        *-- (e) guarda de reentrancia foi liberada mesmo tendo passado no CATCH
        loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
            "this_lEmLookup pos-lookup = " + TRANSFORM(loc_oForm.this_lEmLookup)

        *-- (f) cursores de busca nao ficaram abertos
        loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
            "cursores abertos: BuscaPro=" + TRANSFORM(USED("cursor_4c_BuscaPro")) + ;
            " BuscaGru=" + TRANSFORM(USED("cursor_4c_BuscaGru"))

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cOut = "EXCECAO: " + loc_oErro.Message + ;
               " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
               " | Procedure: " + loc_oErro.Procedure
ENDTRY

STRTOFILE(CHR(13) + CHR(10) + "=== RESULTADO ===" + CHR(13) + CHR(10) + ;
          loc_cOut + CHR(13) + CHR(10) + "[FIM]" + CHR(13) + CHR(10), loc_cLog, 1)

QUIT
