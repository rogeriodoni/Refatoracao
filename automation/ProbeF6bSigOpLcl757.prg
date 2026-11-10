*-- Probe da FASE 6 (parte b) do FormSigOpLcl (task757): prova os DOIS funis de
*-- picker acrescentados (AbrirBuscaBase / AbrirBuscaNivel), os resolvedores de
*-- nivel e a guarda de reentrancia em SAVE/RESTORE.
*--
*-- DIAGNOSTICO IMPLICITO: FormBuscaAuxiliar.Mostrar() chama Show() de form
*-- MODAL, que TRAVA a execucao em headless. Se este script TERMINA dentro do
*-- timeout, nenhum picker foi aberto nos caminhos exercitados - que eh
*-- exatamente o que se quer provar nos ramos "achou" e "nivel invalido".
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut757c
gcOut757c = "C:\4c\automation\probef6bsigoplcl757.txt"
STRTOFILE("PROBE F6b task757 INICIO" + CHR(13) + CHR(10), gcOut757c)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpLcl")

*-- gnConnHandle NAO eh criado por config.prg (mora em main.prg, linha 75):
*-- sem esta PUBLIC, qualquer leitura CRUA da variavel abre o dialogo
*-- "Variable GNCONNHANDLE is not found" e TRAVA o probe headless. Fixado em
*-- -1 de proposito: com handle invalido o SQLEXEC de AbrirLookupCanonico cai
*-- no CATCH dele e NENHUM picker modal eh aberto.
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probef6bsigoplcl757_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log757c("ambiente OK")

*-- Cursor do form CHAMADOR (contrato externo - nome do legado)
CREATE CURSOR crTpmMvItn (cItens N(10,0), Cpros C(14), Dpros C(65), ;
                          Locals C(10), Localos C(10))
INSERT INTO crTpmMvItn VALUES (1, "PROD001", "PRODUTO UM",   "", "")
INSERT INTO crTpmMvItn VALUES (2, "PROD002", "PRODUTO DOIS", "", "")

LOCAL loForm, loc_oA, loc_oB, loc_lAntes, loc_lDepois

loForm = CREATEOBJECT("FormSigOpLcl", .NULL., "INSERIR", "")
Log757c("1) CREATEOBJECT INSERIR -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) != "O"
    Log757c("   ABORTA: form nao instanciou")
ELSE

    *------------------------------------------------------------------
    * 2) Os funis EXISTEM e sao PUBLIC (regra #3 - PEMSTATUS atributo 2
    *    = Protected; .F. significa PUBLIC)
    *------------------------------------------------------------------
    Log757c("2) AbrirBuscaBase  existe=" + TRANSFORM(PEMSTATUS(loForm, "AbrirBuscaBase", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loForm, "AbrirBuscaBase", 2)) + " (esperado .T. / .F.)")
    Log757c("   AbrirBuscaNivel existe=" + TRANSFORM(PEMSTATUS(loForm, "AbrirBuscaNivel", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loForm, "AbrirBuscaNivel", 2)) + " (esperado .T. / .F.)")
    Log757c("   ValidarNivelExec existe=" + TRANSFORM(PEMSTATUS(loForm, "ValidarNivelExec", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loForm, "ValidarNivelExec", 2)) + " (esperado .T. / .F.)")

    *------------------------------------------------------------------
    * 3) Resolvedores: nivel -> (COD, DESC, PAI) / cursor / titulo
    *    Os tres sao PROTECTED, por isso a medicao usa o acesso de DENTRO
    *    via ValidarNivelExec; aqui se mede o EFEITO observavel (qual
    *    controle o metodo escolhe) comparando por .Name.
    *------------------------------------------------------------------
    Log757c("3) nomes reais: Nvl2=[" + loForm.txt_4c_Nvl2.Name + "] DNvl2=[" + loForm.txt_4c_DNvl2.Name + ;
            "] Base=[" + loForm.txt_4c_Base.Name + "]")
    Log757c("   nomes reais: Nvl3=[" + loForm.txt_4c_Nvl3.Name + "] DNvl3=[" + loForm.txt_4c_DNvl3.Name + ;
            "] Nvl4=[" + loForm.txt_4c_Nvl4.Name + "] DNvl4=[" + loForm.txt_4c_DNvl4.Name + "]")

    *------------------------------------------------------------------
    * 4) ValidarNivelExec no ramo "ACHOU": cursor local com o codigo
    *    digitado -> SEEK casa -> NAO abre picker (se abrisse, o script
    *    travaria aqui) e NAO reatribui Value/Desc (fidelidade ao legado)
    *------------------------------------------------------------------
    IF USED("cursor_4c_LcNv2")
        USE IN cursor_4c_LcNv2
    ENDIF
    CREATE CURSOR cursor_4c_LcNv2 (Cods C(2), Descs C(40), Codigo C(4))
    INSERT INTO cursor_4c_LcNv2 VALUES ("01", "CORREDOR A", "AA")
    INSERT INTO cursor_4c_LcNv2 VALUES ("01", "CORREDOR B", "BB")
    INSERT INTO cursor_4c_LcNv2 VALUES ("02", "OUTRA BASE", "CC")

    loForm.txt_4c_Base.Value  = "01"
    loForm.txt_4c_Nvl2.Value  = "BB"
    loForm.txt_4c_DNvl2.Value = "MARCA PRESERVADA"

    loForm.ValidarNivelExec(2)

    Log757c("4) ACHOU: Nvl2=[" + ALLTRIM(loForm.txt_4c_Nvl2.Value) + "] (esperado BB) DNvl2=[" + ;
            ALLTRIM(loForm.txt_4c_DNvl2.Value) + "] (esperado MARCA PRESERVADA - o legado nao reatribui no ramo achou)")
    Log757c("   cursor_4c_LocalNivel usado=" + TRANSFORM(USED("cursor_4c_LocalNivel")) + ;
            " reccount=" + TRANSFORM(IIF(USED("cursor_4c_LocalNivel"), RECCOUNT("cursor_4c_LocalNivel"), -1)) + ;
            " (esperado 2 - filtrado por Cods='01')")
    Log757c("   this_lEmLookup apos ValidarNivelExec=" + TRANSFORM(loForm.this_lEmLookup) + " (esperado .F.)")

    *------------------------------------------------------------------
    * 5) ValidarNivelExec com campo VAZIO: aborta antes de qualquer
    *    consulta e nao abre picker
    *------------------------------------------------------------------
    loForm.txt_4c_Nvl3.Value = ""
    loForm.ValidarNivelExec(3)
    Log757c("5) VAZIO: ValidarNivelExec(3) retornou sem picker; this_lEmLookup=" + ;
            TRANSFORM(loForm.this_lEmLookup) + " (esperado .F.)")

    *------------------------------------------------------------------
    * 6) ValidarNivelExec com nivel FORA de 2..4: resolvedor devolve
    *    .NULL. e o metodo aborta (nao estoura, nao abre picker)
    *------------------------------------------------------------------
    loForm.ValidarNivelExec(9)
    Log757c("6) NIVEL INVALIDO 9: retornou sem erro e sem picker")

    *------------------------------------------------------------------
    * 7) Guarda de reentrancia em SAVE/RESTORE (regra #47): chamado com a
    *    flag JA ligada (como acontece de dentro do LostFocus), o funil
    *    tem de devolver a flag LIGADA - clear simples a liberaria cedo e
    *    o LostFocus redisparado abriria um SEGUNDO picker.
    *------------------------------------------------------------------
    loForm.this_lEmLookup = .T.
    loForm.AbrirBuscaNivel(9)
    Log757c("7) ANINHADO: flag antes=.T. -> depois=" + TRANSFORM(loForm.this_lEmLookup) + " (esperado .T.)")

    loForm.this_lEmLookup = .F.
    loForm.AbrirBuscaNivel(9)
    Log757c("   STANDALONE: flag antes=.F. -> depois=" + TRANSFORM(loForm.this_lEmLookup) + " (esperado .F.)")

    *------------------------------------------------------------------
    * 8) AbrirBuscaBase com gnConnHandle invalido: AbrirLookupCanonico
    *    cai no proprio CATCH (SQLEXEC com handle invalido dispara
    *    excecao), nenhum picker eh aberto, e a flag volta restaurada
    *------------------------------------------------------------------
    Log757c("8) gnConnHandle=" + TRANSFORM(gnConnHandle))
    loForm.txt_4c_Base.Value = "01"

    loForm.this_lEmLookup = .T.
    loForm.AbrirBuscaBase()
    Log757c("   ANINHADO: flag antes=.T. -> depois=" + TRANSFORM(loForm.this_lEmLookup) + " (esperado .T.)")

    loForm.this_lEmLookup = .F.
    loForm.AbrirBuscaBase()
    Log757c("   STANDALONE: flag antes=.F. -> depois=" + TRANSFORM(loForm.this_lEmLookup) + " (esperado .F.)")
    Log757c("   Base preservada=[" + ALLTRIM(loForm.txt_4c_Base.Value) + "] (esperado 01 - nunca apagar o digitado, regra #50)")

    *------------------------------------------------------------------
    * 9) BINDEVENT dos quatro campos continua ligado apos o refactor
    *    (AEVENTS com 2 argumentos; evento na coluna 3, metodo na 4 -
    *    AEVENTS(a, 0) devolveria 0 sob outra data session)
    *------------------------------------------------------------------
    Dump757c(loForm.txt_4c_Base, "txt_4c_Base")
    Dump757c(loForm.txt_4c_Nvl2, "txt_4c_Nvl2")
    Dump757c(loForm.txt_4c_Nvl3, "txt_4c_Nvl3")
    Dump757c(loForm.txt_4c_Nvl4, "txt_4c_Nvl4")

    loForm.Release()
    loForm = .NULL.
ENDIF

Log757c("PROBE F6b FIM")
QUIT

PROCEDURE Log757c(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut757c, .T.)
ENDPROC

PROCEDURE Dump757c(par_oObj, par_cNome)
    LOCAL loc_n, loc_i, loc_cLinha
    LOCAL ARRAY loc_aEv[1]
    loc_cLinha = "9) " + par_cNome + " -> "
    IF VARTYPE(par_oObj) != "O"
        Log757c(loc_cLinha + "NAO EH OBJETO")
    ELSE
        loc_n = AEVENTS(loc_aEv, par_oObj)
        loc_cLinha = loc_cLinha + TRANSFORM(loc_n) + " binding(s)"
        FOR loc_i = 1 TO loc_n
            loc_cLinha = loc_cLinha + " [" + UPPER(ALLTRIM(loc_aEv[loc_i, 3])) + ;
                         " -> " + UPPER(ALLTRIM(loc_aEv[loc_i, 4])) + "]"
        ENDFOR
        Log757c(loc_cLinha)
    ENDIF
ENDPROC
