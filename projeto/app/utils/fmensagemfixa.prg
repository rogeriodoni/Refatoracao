*==============================================================================
* fmensagemfixa.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* clsleitora (classobj.vcx), na leitura de cheque, avisa o operador com:
*
*     if !correto
*         clear typeahead
*         fMensagemFixa('Leitura de cheque incorreta!', 0+48, '', 'X ')
*         sd = .f.
*     endif
*
* Sem o arquivo o VFP procura 'fmensagemfixa.prg' no PATH e estoura
*
*     File 'fmensagemfixa.prg' does not exist.
*
* e - pior que o erro - o operador PERDE o aviso de leitura errada. Familia de
* isempty.prg / fconfiggeral.prg.
*
* CONTRATO, LIDO DO CALL SITE
* ---------------------------
* Os tres primeiros argumentos sao exatamente os do MESSAGEBOX nativo: texto,
* nBotoes/nIcone (0+48 = OK + icone de exclamacao) e titulo. O retorno eh
* DESCARTADO pelo chamador.
*
* O 4o argumento ('X ') eh IGNORADO: o fonte legado nao veio no acervo, ha um
* unico call site e nao da para saber o que ele controlava (provavelmente o
* caractere/beep da leitora). Passar a ignora-lo nao muda o que o usuario ve -
* a caixa de aviso, que eh o essencial, volta a aparecer.
*
* Titulo vazio: MESSAGEBOX sem titulo usa "Microsoft Visual FoxPro", que
* vazaria nome de ferramenta na tela do operador. Por isso o default abaixo.
*
* Regra #13 do CLAUDE.md: em codigo NOSSO use MsgAviso()/MsgInfo() de
* utils\messages.prg. Este arquivo existe APENAS para binario legado.
*
* Origem: Erro163_Aba1 (2026-09-18).
*==============================================================================
LPARAMETERS par_cMensagem, par_nBotoes, par_cTitulo, par_cReservado

LOCAL loc_cMensagem, loc_nBotoes, loc_cTitulo

loc_cMensagem = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
loc_nBotoes   = IIF(VARTYPE(par_nBotoes)   = "N", par_nBotoes, 0 + 48)
loc_cTitulo   = IIF(VARTYPE(par_cTitulo)   = "C" AND !EMPTY(par_cTitulo), ;
                    par_cTitulo, "Aten" + CHR(231) + CHR(227) + "o")

IF EMPTY(loc_cMensagem)
    RETURN .T.
ENDIF

MESSAGEBOX(loc_cMensagem, loc_nBotoes, loc_cTitulo)

RETURN .T.
