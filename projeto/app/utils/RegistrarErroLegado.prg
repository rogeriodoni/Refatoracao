*==============================================================================
* RegistrarErroLegado.prg - Handler de ON ERROR para forms wrapper de VCX legado.
*
* POR QUE ISTO EXISTE
* -------------------
* Nos forms que hospedam VCX legado Fortyus (FormCliente/clsconta), a maior parte
* do codigo que roda eh p-code COMPILADO que nao da para editar nem envolver em
* TRY/CATCH. Quando um Valid/When/Click de la estoura, nao ha quem trate: a
* excecao sobe e o VFP DERRUBA O FORM - do ponto de vista do usuario, "a tela
* fechou de repente", sem mensagem e sem log.
*
* Foi o que aconteceu ao sair do campo UF do Cadastro de Cliente (Erro163_Aba1_2)
* e nao foi possivel reproduzir fora da tela: instanciando o form e chamando
* GetEstado.Valid() direto, com 'SP', vazio e com UF inexistente, NAO da erro
* nenhum (medido em 2026-09-18). Sem captura no ambiente do usuario nao ha o que
* diagnosticar.
*
* O QUE ELE FAZ
* -------------
* Registra erro, mensagem, programa e linha em projeto\app\ErroLegado.log e
* DEIXA A EXECUCAO CONTINUAR, em vez de o form morrer. Exibe MsgErro na PRIMEIRA
* ocorrencia de cada sessao de form - assim o erro nao fica silencioso (regra #9)
* mas tambem nao vira dialog em cadeia se o mesmo erro repetir a cada tecla.
*
* LIMITE HONESTO
* --------------
* Isto eh CAPTURA + MITIGACAO, nao correcao de causa raiz. Continuar depois de um
* erro pode deixar a tela em estado inconsistente; o que se ganha eh que o
* usuario nao perde o que digitou e o log passa a dizer QUAL eh o erro. Assim que
* o log apontar a causa, corrigir a causa e reavaliar se este handler continua
* fazendo sentido.
*
* Fica instalado apenas enquanto o FormCliente existe (Init instala, Destroy
* remove), nao no sistema inteiro.
*
* Origem: Erro163_Aba1_2 (2026-09-18).
*==============================================================================
LPARAMETERS par_nErro, par_cMensagem, par_cPrograma, par_nLinha

LOCAL loc_cArquivo, loc_cLinha, loc_cFoco

*-- Controle de quem ja avisou nesta sessao de form
IF TYPE("gn_4c_ErrosLegado") <> "N"
    PUBLIC gn_4c_ErrosLegado
    gn_4c_ErrosLegado = 0
ENDIF
gn_4c_ErrosLegado = gn_4c_ErrosLegado + 1

*-- Qual controle estava com o foco quando estourou (a pista mais util)
loc_cFoco = "?"
IF TYPE("_SCREEN.ActiveForm") = "O"
    IF TYPE("_SCREEN.ActiveForm.ActiveControl") = "O"
        loc_cFoco = _SCREEN.ActiveForm.Name + "." + _SCREEN.ActiveForm.ActiveControl.Name
    ELSE
        loc_cFoco = _SCREEN.ActiveForm.Name + ".(sem controle ativo)"
    ENDIF
ENDIF

loc_cLinha = "[" + TTOC(DATETIME()) + "] erro " + TRANSFORM(par_nErro) + ": " + ;
             TRANSFORM(par_cMensagem) + CHR(13) + CHR(10) + ;
             "    programa : " + TRANSFORM(par_cPrograma) + ;
             "   linha: " + TRANSFORM(par_nLinha) + CHR(13) + CHR(10) + ;
             "    foco    : " + loc_cFoco + CHR(13) + CHR(10) + ;
             "    ocorrencia n. " + TRANSFORM(gn_4c_ErrosLegado) + " nesta tela" + CHR(13) + CHR(10)

IF TYPE("gc_4c_CaminhoBase") = "C"
    loc_cArquivo = ADDBS(gc_4c_CaminhoBase) + "ErroLegado.log"
    STRTOFILE(loc_cLinha, loc_cArquivo, 1)
ENDIF

*-- Primeira ocorrencia: avisa. Demais: so log, para nao virar dialog em cadeia.
*-- gb_4c_ValidandoUI = .T. (harness / pipeline nao-atendido): NUNCA abrir modal,
*-- senao a execucao noturna trava indefinidamente (regra #6 do CLAUDE.md).
*-- Nesse modo o log continua sendo gravado - e ele que o harness le.
LOCAL loc_lPodeAvisar
loc_lPodeAvisar = .T.
IF TYPE("gb_4c_ValidandoUI") = "L"
    loc_lPodeAvisar = !gb_4c_ValidandoUI
ENDIF

IF gn_4c_ErrosLegado = 1 AND loc_lPodeAvisar
    MsgErro("Ocorreu um erro interno na tela, mas ela foi mantida aberta." + CHR(13) + ;
            "Confira os dados antes de gravar." + CHR(13) + CHR(13) + ;
            "Erro " + TRANSFORM(par_nErro) + ": " + TRANSFORM(par_cMensagem) + CHR(13) + ;
            "Em: " + TRANSFORM(par_cPrograma) + " linha " + TRANSFORM(par_nLinha) + CHR(13) + ;
            "Foco: " + loc_cFoco, ;
            "Erro interno")
ENDIF

RETURN
