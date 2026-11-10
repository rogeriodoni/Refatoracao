*-- Probe da FASE 6 do FormSigOpLib (task760): instancia o dialogo de verdade e
*-- mede o que a fase entregou - os BINDEVENT dos dois campos, o estado inicial
*-- da descricao (get_descr.When), as DUAS guardas do LostFocus, o bloco de
*-- aplicacao do tipo escolhido e o fechamento do retorno pela descricao.
*--
*-- Sem banco (gnConnHandle = 0) as consultas da BO caem no CATCH e devolvem
*-- .F.: o ramo do picker NAO abre, e isso eh proposital. Picker modal TRAVARIA
*-- o processo headless, portanto o probe TERMINAR ja eh prova de que nenhum
*-- dialogo subiu indevidamente.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut760
gcOut760 = "C:\4c\automation\probef6sigoplib760.txt"
STRTOFILE("PROBE F6 task760 INICIO" + CHR(13) + CHR(10), gcOut760)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpLib")

*-- gnConnHandle eh definida pelo main.prg, NAO pelo config.prg: sem declarar
*-- aqui, qualquer leitura dela estoura "Variable GNCONNHANDLE is not found"
*-- fora de TRY/CATCH, o VFP abre o Program Error MODAL e o probe headless
*-- TRAVA (foi o que aconteceu na primeira execucao). Zero = sem banco, igual
*-- ao que o TesteAutomatico.prg faz.
PUBLIC gnConnHandle
gnConnHandle = 0

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probef6sigoplib760_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log760("ambiente OK - gnConnHandle=" + TRANSFORM(gnConnHandle))

LOCAL loForm, loc_nI, loc_cCod, loc_cDes

*------------------------------------------------------------------
* 1) Instanciacao (prova que o Init inteiro roda, inclusive a
*    chamada nova de AtualizarEstadoDescricao)
*------------------------------------------------------------------
loForm = CREATEOBJECT("FormSigOpLib", 1, "")
Log760("1) CREATEOBJECT(1, '') -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"

    *-- Metodos da fase 6 presentes e PUBLIC (PEMSTATUS 5 = existe)
    Log760("2) metodos: ValidarCodigoLostFocus=" + TRANSFORM(PEMSTATUS(loForm, "ValidarCodigoLostFocus", 5)) + ;
           " TxtCodigoKeyPress=" + TRANSFORM(PEMSTATUS(loForm, "TxtCodigoKeyPress", 5)) + ;
           " TxtCodigoDblClick=" + TRANSFORM(PEMSTATUS(loForm, "TxtCodigoDblClick", 5)) + ;
           " AbrirLookupTipoLiberacao=" + TRANSFORM(PEMSTATUS(loForm, "AbrirLookupTipoLiberacao", 5)))
    Log760("   AplicarTipoSelecionado=" + TRANSFORM(PEMSTATUS(loForm, "AplicarTipoSelecionado", 5)) + ;
           " AtualizarEstadoDescricao=" + TRANSFORM(PEMSTATUS(loForm, "AtualizarEstadoDescricao", 5)) + ;
           " ValidarDescricaoLostFocus=" + TRANSFORM(PEMSTATUS(loForm, "ValidarDescricaoLostFocus", 5)))

    *-- PROTECTED (atributo 2) tem de ser .F. em todos: alvo de BINDEVENT
    *-- PROTECTED falha em silencio (regra #3)
    Log760("   PROTECTED? ValidarCodigoLostFocus=" + TRANSFORM(PEMSTATUS(loForm, "ValidarCodigoLostFocus", 2)) + ;
           " TxtCodigoKeyPress=" + TRANSFORM(PEMSTATUS(loForm, "TxtCodigoKeyPress", 2)) + ;
           " TxtCodigoDblClick=" + TRANSFORM(PEMSTATUS(loForm, "TxtCodigoDblClick", 2)) + ;
           " ValidarDescricaoLostFocus=" + TRANSFORM(PEMSTATUS(loForm, "ValidarDescricaoLostFocus", 2)) + ;
           " (todos esperados .F.)")

    *-- BINDEVENT registrados. AEVENTS por OBJETO-FONTE (nao o modo 0): a
    *-- lista que interessa eh a dos tres controles desta tela, e o array tem
    *-- de ser lido so apos conferir que veio com as 4 colunas documentadas
    *-- (fonte, evento, delegate, metodo) - ler [i,2] num array de UMA dimensao
    *-- estoura "Invalid subscript reference" e, fora de TRY, abre dialogo
    *-- MODAL que trava o processo headless.
    Log760("3) BINDEVENT por controle:")
    ListarBind760(loForm.txt_4c__codigo, "txt_4c__codigo")
    ListarBind760(loForm.txt_4c__descr,  "txt_4c__descr")
    ListarBind760(loForm.cmd_4c_Ok,      "cmd_4c_Ok")

    *-- Estado inicial da descricao: codigo vazio -> When do legado da .F.
    Log760("4) abertura com codigo vazio: txt_4c__descr.ReadOnly=" + ;
           TRANSFORM(loForm.txt_4c__descr.ReadOnly) + " (esperado .T.) TabStop=" + ;
           TRANSFORM(loForm.txt_4c__descr.TabStop) + " (esperado .F.)")

    *------------------------------------------------------------------
    * 5) GUARDA 1 - reentrancia (this_lEmLookup ja ligada)
    *    Observavel: o funil termina chamando AtualizarEstadoDescricao,
    *    que poria ReadOnly = .T. Pre-setando ReadOnly = .F., se a guarda
    *    funcionar o valor PERMANECE .F.
    *------------------------------------------------------------------
    loForm.txt_4c__codigo.Value        = "ABC"
    loForm.this_cUltimoCodigoValidado  = ""
    loForm.this_lEmLookup              = .T.
    loForm.txt_4c__descr.ReadOnly      = .F.
    loForm.ValidarCodigoLostFocus()
    Log760("5) GUARDA reentrancia: descr.ReadOnly=" + TRANSFORM(loForm.txt_4c__descr.ReadOnly) + ;
           " (esperado .F. - funil NAO rodou) marca=[" + loForm.this_cUltimoCodigoValidado + ;
           "] (esperado vazio)")
    loForm.this_lEmLookup = .F.

    *------------------------------------------------------------------
    * 6) GUARDA 2 - valor nao mudou (marca == valor do campo)
    *------------------------------------------------------------------
    loForm.this_cUltimoCodigoValidado = "ABC"
    loForm.txt_4c__descr.ReadOnly     = .F.
    loForm.ValidarCodigoLostFocus()
    Log760("6) GUARDA valor-nao-mudou: descr.ReadOnly=" + TRANSFORM(loForm.txt_4c__descr.ReadOnly) + ;
           " (esperado .F. - funil NAO rodou)")

    *------------------------------------------------------------------
    * 7) GUARDA campo vazio (legado: If Not Empty(This.Value))
    *------------------------------------------------------------------
    loForm.txt_4c__codigo.Value       = ""
    loForm.this_cUltimoCodigoValidado = "ZZZ"
    loForm.txt_4c__descr.ReadOnly     = .F.
    loForm.ValidarCodigoLostFocus()
    Log760("7) GUARDA campo vazio: descr.ReadOnly=" + TRANSFORM(loForm.txt_4c__descr.ReadOnly) + ;
           " (esperado .F. - funil NAO rodou)")

    *------------------------------------------------------------------
    * 8) FUNIL RODANDO - valor novo, guarda livre. Sem banco a BO nao
    *    acha nada e o cursor nem existe, entao NAO abre picker (se
    *    abrisse, o processo travaria aqui) e a descricao volta a
    *    nao-editavel. A marca tem de ficar com o valor corrente.
    *------------------------------------------------------------------
    loForm.txt_4c__codigo.Value       = "XY1"
    loForm.this_cUltimoCodigoValidado = ""
    loForm.txt_4c__descr.ReadOnly     = .F.
    loForm.txt_4c__descr.TabStop      = .T.
    loForm.ValidarCodigoLostFocus()
    Log760("8) FUNIL executado: descr.ReadOnly=" + TRANSFORM(loForm.txt_4c__descr.ReadOnly) + ;
           " (esperado .T.) TabStop=" + TRANSFORM(loForm.txt_4c__descr.TabStop) + ;
           " (esperado .F.) marca=[" + ALLTRIM(loForm.this_cUltimoCodigoValidado) + ;
           "] (esperado XY1) EmLookup=" + TRANSFORM(loForm.this_lEmLookup) + ;
           " (esperado .F. - liberada apos o ENDTRY)")
    Log760("   codigo digitado PRESERVADO? [" + ALLTRIM(loForm.txt_4c__codigo.Value) + ;
           "] (esperado XY1 - regra #50 proibe apagar)")

    *------------------------------------------------------------------
    * 9) AplicarTipoSelecionado - bloco final do get_codigo.Valid.
    *    Alimenta as properties da BO como se CarregarDoCursor tivesse
    *    lido a linha escolhida.  Fixos <> 2 -> preenche descricao e
    *    fecha o retorno POSICIONAL (cods char(10) + descs char(60)).
    *------------------------------------------------------------------
    loForm.this_oBusinessObject.this_cCods  = PADR("01", 10)
    loForm.this_oBusinessObject.this_cDescs = PADR("LIBERACAO TOTAL", 60)
    loForm.this_oBusinessObject.this_nFixos = 1
    loForm.AplicarTipoSelecionado()
    Log760("9) AplicarTipoSelecionado com Fixos=1: codigo=[" + loForm.txt_4c__codigo.Value + ;
           "] descr=[" + ALLTRIM(loForm.txt_4c__descr.Value) + "]")
    Log760("   retorno LEN=" + TRANSFORM(LEN(loForm.this_cRetorno)) + ;
           " (esperado 70 = 10 + 60) retorno=[" + loForm.this_cRetorno + "]")

    *-- Fixos = 2 (descricao livre): o legado NAO toca descricao nem retorno
    loForm.this_oBusinessObject.this_cCods  = PADR("02", 10)
    loForm.this_oBusinessObject.this_cDescs = PADR("NAO DEVE APARECER", 60)
    loForm.this_oBusinessObject.this_nFixos = 2
    loForm.txt_4c__descr.Value = ""
    loForm.AplicarTipoSelecionado()
    Log760("   Fixos=2: codigo=[" + loForm.txt_4c__codigo.Value + ;
           "] descr=[" + ALLTRIM(loForm.txt_4c__descr.Value) + ;
           "] (esperado VAZIO - legado so preenche quando Fixos <> 2)")

    *------------------------------------------------------------------
    * 10) ValidarDescricaoLostFocus - get_descr.Valid do legado
    *------------------------------------------------------------------
    loForm.txt_4c__descr.Value = "DESCRICAO DIGITADA"
    loForm.ValidarDescricaoLostFocus()
    Log760("10) ValidarDescricaoLostFocus: retorno=[" + loForm.this_cRetorno + "]")
    Log760("    comeca com cods padded? " + ;
           TRANSFORM(LEFT(loForm.this_cRetorno, 10) == PADR("02", 10)) + ;
           " (esperado .T. - concatenacao POSICIONAL, regra #42)")

    *-- Descricao vazia nao mexe no retorno (legado: If Not Empty)
    loForm.this_cRetorno       = "RETORNO-ANTERIOR"
    loForm.txt_4c__descr.Value = ""
    loForm.ValidarDescricaoLostFocus()
    Log760("    descr vazia: retorno=[" + loForm.this_cRetorno + ;
           "] (esperado RETORNO-ANTERIOR, inalterado)")

    *------------------------------------------------------------------
    * 11) F4 e DblClick nao estouram (e, sem banco, nao abrem picker)
    *------------------------------------------------------------------
    loForm.txt_4c__codigo.Value = "03"
    loForm.TxtCodigoKeyPress(115, 0)
    Log760("11) TxtCodigoKeyPress(115) OK - codigo=[" + ALLTRIM(loForm.txt_4c__codigo.Value) + "]")

    *-- Tecla qualquer NAO pode acionar o funil (regra #47). Observavel: a
    *-- marca de ultimo-validado nao muda.
    loForm.this_cUltimoCodigoValidado = "SENTINELA"
    loForm.TxtCodigoKeyPress(65, 0)
    Log760("    TxtCodigoKeyPress(65='A'): marca=[" + ALLTRIM(loForm.this_cUltimoCodigoValidado) + ;
           "] (esperado SENTINELA - tecla comum NAO abre lookup)")

    loForm.TxtCodigoDblClick()
    Log760("    TxtCodigoDblClick OK")

    *-- Cursor do picker nao ficou pendurado
    Log760("12) cursor_4c_SigCdNcf aberto? " + TRANSFORM(USED("cursor_4c_SigCdNcf")) + ;
           " (esperado .F. - o funil fecha o alias)")

    loForm.Release()
    loForm = .NULL.
ELSE
    Log760("   FALHA: CREATEOBJECT nao devolveu objeto")
ENDIF

Log760("PROBE F6 task760 FIM")
QUIT

PROCEDURE Log760(pcTexto)
    STRTOFILE(pcTexto + CHR(13) + CHR(10), gcOut760, 1)
ENDPROC

PROCEDURE ListarBind760(poFonte, pcNome)
    LOCAL loc_nQtd, loc_nJ
    LOCAL ARRAY laB[1, 4]

    loc_nQtd = AEVENTS(laB, poFonte)
    Log760("   " + PADR(pcNome, 16) + " bindings=" + TRANSFORM(loc_nQtd))

    IF loc_nQtd > 0 AND ALEN(laB, 2) >= 4
        FOR loc_nJ = 1 TO loc_nQtd
            Log760("      evento=" + PADR(TRANSFORM(laB[loc_nJ, 2]), 12) + ;
                   " -> metodo=" + TRANSFORM(laB[loc_nJ, 4]))
        ENDFOR
    ENDIF
ENDPROC
