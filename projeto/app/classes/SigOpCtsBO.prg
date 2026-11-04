*====================================================================
* SigOpCtsBO.prg
*
* Business Object para o dialogo de Senha (SigOpCts)
* Dialogo modal generico reaproveitado por varios cadastros: confere a
* senha atual gravada na coluna Senhas de um cursor ja aberto (alias
* informado em this_cArquivo, default crSigCdCli) e, em modo alteracao
* (this_lAltera = .T.), troca essa senha depois de confirmar a nova
* senha duas vezes.
* Nao existe tabela/SQL proprios - a leitura/gravacao e feita por
* alias dinamico sobre o cursor que o chamador ja mantem aberto (regra
* CLAUDE.md #9: SELECT (alias) antes de acessar o campo, nunca a
* sintaxe invalida campo).
* Herda de: BusinessBase
*
* Convencao de nomes do legado Fortyus (invertida, mas preservada aqui -
* ver pafBO.prg/sigtosenBO.prg/SigOpAlCBO.prg, mesma convencao):
*   fCriptografar(valor gravado)  = valor decodificado, comparavel com o
*                                   que o usuario digitou (senha.Valid)
*   fDecriptografar(valor digitado) = valor codificado para gravar
*                                     (GetNova2.Valid)
* Nenhuma das duas foi portada (NAO existe utils\fcriptografar.prg; e
* utils\fdecriptografar.prg e um wrapper pass-through de OUTRO contrato -
* decodificar numero de fabricacao de impressora fiscal, nao senha). Sao
* chamadas aqui exatamente como o legado chama, dentro de TRY/CATCH, para
* o form ver o erro em this_cMensagemErro em vez da tela fechar.
*
* ATENCAO - o par esta ASSIMETRICO neste ambiente, e a assimetria eh
* PERIGOSA na direcao da GRAVACAO: a leitura chama fCriptografar, que nao
* existe e portanto ESTOURA (erro visivel, que eh o comportamento correto
* pela regra CLAUDE.md #27); a gravacao chama fDecriptografar, que EXISTE
* como pass-through e portanto TERIA EXITO gravando a senha em CLARO, sem
* erro algum. Com as duas pontas usando algoritmos diferentes, quem
* trocasse a senha ficaria sem acesso a propria conta - e sem mensagem.
* Por isso AlterarSenha() so grava depois de conferir a IDA-E-VOLTA
* (fCriptografar(fDecriptografar(x)) == x); ver o comentario no proprio
* metodo. Nao criar utils\fcriptografar.prg com algoritmo inventado: a
* funcao original nao esta legivel em nenhum fonte do acervo.
*
* Completado em: Fase 2 - CarregarDoCursor()/ValidarSenhaAtual()/
* AlterarSenha()/ObterChavePrimaria().
*
* Este dialogo NAO persiste nenhuma tabela propria (SigOpCts nao existe
* no banco). Inserir()/Atualizar()/ExecutarExclusao()/RegistrarAuditoria()
* NAO sao sobrescritos - o comportamento padrao herdado de BusinessBase
* ja eh o correto para este caso (mesmo padrao de SigOpAutBO.prg/
* sigtosenBO.prg, outros dialogos sem tabela mestre).
*====================================================================

DEFINE CLASS SigOpCtsBO AS BusinessBase

    *-- Parametros recebidos pelo form na abertura (Init legado: _Titulo, _Altera, _Arquivo)
    this_cTitulo  = ""              && _Titulo - identificacao exibida na mensagem (Frase.Caption)
    this_lAltera  = .F.             && Altera - .T. = modo alterar senha, .F. = modo so confere a senha atual
    this_cArquivo = "crSigCdCli"    && Arquivo - alias do cursor aberto que tem a coluna Senhas

    *-- Propriedade customizada do legado sem uso nos metodos extraidos do dump
    this_cUsuLibs = ""               && UsuLibs - propriedade do SIGOPCTS original

    *-- Resultado do dialogo (retorno de Unload/Release no legado: Return This.ZSen)
    this_lZSen = .F.

    *-- Valores digitados pelo usuario (transitorios - NUNCA persistidos como estao)
    this_cSenhaDigitada = ""        && senha.Value - senha atual informada para confirmacao
    this_cSenhaNova1     = ""       && GetNova1.Value - nova senha (1a digitacao)
    this_cSenhaNova2     = ""       && GetNova2.Value - nova senha (2a digitacao)

    *-- Campo a focar apos falha de validacao ("SENHA"/"NOVA1"/"NOVA2")
    this_cCampoFoco = ""

    *-- Valor BRUTO (codificado) da coluna Senhas, carregado por
    *-- CarregarDoCursor - referencia/diagnostico, nao usado na comparacao
    *-- (ValidarSenhaAtual le a coluna direto do alias no momento do Valid)
    this_cSenhaArmazenada = ""

    *====================================================================
    * Init - Inicializa Business Object
    * par_cTitulo  - _Titulo do legado (identificacao usada na mensagem)
    * par_lAltera  - _Altera do legado (.T. = alterar senha, .F. = so confere)
    * par_cArquivo - _Arquivo do legado (alias do cursor com a coluna Senhas;
    *                se nao for char, o legado usa 'crSigCdCli' como default)
    *====================================================================
    PROCEDURE Init(par_cTitulo, par_lAltera, par_cArquivo)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Dialogo nao persiste tabela propria - sem this_cTabela/this_cCampoChave
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cTitulo = IIF(VARTYPE(par_cTitulo) = "C", par_cTitulo, "")
            THIS.this_lAltera = IIF(VARTYPE(par_lAltera) = "L", par_lAltera, .F.)

            IF VARTYPE(par_cArquivo) = "C" AND !EMPTY(ALLTRIM(par_cArquivo))
                THIS.this_cArquivo = ALLTRIM(par_cArquivo)
            ELSE
                THIS.this_cArquivo = "crSigCdCli"
            ENDIF

            THIS.this_lZSen = .F.
            THIS.this_cSenhaDigitada = ""
            THIS.this_cSenhaNova1    = ""
            THIS.this_cSenhaNova2    = ""
            THIS.this_cCampoFoco     = ""

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpCtsBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Le o valor BRUTO (codificado) da coluna Senhas do
    * alias informado (par_cAliasCursor; se vazio, usa this_cArquivo) para
    * this_cSenhaArmazenada. Regra CLAUDE.md #9: SELECT (alias) antes de
    * acessar o campo - nunca a sintaxe invalida campo.
    * Nao decodifica (fCriptografar) aqui - isso fica em ValidarSenhaAtual,
    * no instante exato da comparacao, para nunca comparar valor obsoleto
    * se outro processo trocar a senha entre a carga e o Valid.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(ALLTRIM(par_cAliasCursor)), ;
            ALLTRIM(par_cAliasCursor), THIS.this_cArquivo)

        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            SELECT (loc_cAlias)
            IF !EOF()
                THIS.this_cSenhaArmazenada = TratarNulo(Senhas, "C")
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ValidarSenhaAtual - Legado (senha.Valid, 1a metade - a MessageBox de
    * "Deseja Digitar Novamente?" e o Release ficam no FORM, que decide a
    * navegacao):
    *   Senha = fCriptografar(&Arquivo..Senhas)
    *   If (Alltrim(This.Value) == Alltrim(Senha))
    *       If Not ThisForm.Altera / ThisForm.ZSen = .t. / EndIf
    *   Else
    *       (form pergunta se quer digitar de novo)
    *   EndIf
    * Par: par_cSenhaDigitada - senha.Value digitado pelo usuario
    * Ret: .T. se a senha digitada confere com a gravada em this_cArquivo
    *====================================================================
    PROCEDURE ValidarSenhaAtual(par_cSenhaDigitada)
        LOCAL loc_lSucesso, loc_cDigitada, loc_cSenhaDecodificada
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cDigitada = ALLTRIM(NVL(par_cSenhaDigitada, ""))
        THIS.this_cSenhaDigitada = loc_cDigitada

        TRY
            IF EMPTY(THIS.this_cArquivo) OR !USED(THIS.this_cArquivo)
                THIS.this_cMensagemErro = "Arquivo " + ALLTRIM(NVL(THIS.this_cArquivo, "")) + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            ELSE
                SELECT (THIS.this_cArquivo)
                loc_cSenhaDecodificada = ALLTRIM(fCriptografar(Senhas))

                IF loc_cDigitada == loc_cSenhaDecodificada
                    loc_lSucesso = .T.

                    *-- Legado: so fecha o dialogo aqui quando NAO esta em
                    *-- modo alterar - em modo alterar segue para GetNova1/2
                    IF !THIS.this_lAltera
                        THIS.this_lZSen = .T.
                    ENDIF
                ELSE
                    THIS.this_lZSen = .F.
                    THIS.this_cMensagemErro = "Senha Conflitante..."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AlterarSenha - Legado (GetNova2.Valid):
    *   If (ThisForm.GetNova1.Value = ThisForm.GetNova2.Value)
    *       ThisForm.ZSen = .t.
    *       Select (Arquivo)
    *       Replace &Arquivo..Senhas With fDecriptografar(This.Value)
    *   Else
    *       Messagebox('Senha Conflitante!!! Altera...Cancelada!!!')
    *       ThisForm.ZSen = .f.
    *   EndIf
    * Par: par_cSenhaNova1/par_cSenhaNova2 - GetNova1.Value/GetNova2.Value
    * Ret: .T. se as duas senhas batem e a gravacao foi feita
    *====================================================================
    FUNCTION AlterarSenha(par_cSenhaNova1, par_cSenhaNova2)
        LOCAL loc_lSucesso, loc_cNova1, loc_cNova2, loc_cCodificada
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cNova1 = NVL(par_cSenhaNova1, "")
        loc_cNova2 = NVL(par_cSenhaNova2, "")
        THIS.this_cSenhaNova1 = loc_cNova1
        THIS.this_cSenhaNova2 = loc_cNova2

        *-- Legado compara com "=" simples (SET EXACT ON no config.prg faz
        *-- o mesmo efeito de comparacao exata apos trim das duas pontas)
        IF loc_cNova1 = loc_cNova2
            TRY
                IF EMPTY(THIS.this_cArquivo) OR !USED(THIS.this_cArquivo)
                    THIS.this_cMensagemErro = "Arquivo " + ALLTRIM(NVL(THIS.this_cArquivo, "")) + ;
                        " n" + CHR(227) + "o est" + CHR(225) + " aberto"
                ELSE
                    SELECT (THIS.this_cArquivo)

                    *-- Codifica a nova senha exatamente como o legado codifica.
                    loc_cCodificada = fDecriptografar(loc_cNova2)

                    *-- GUARDA DE IDA-E-VOLTA. Nao existe no legado porque lah as
                    *-- duas funcoes existem e sao inversas de verdade - com elas
                    *-- esta checagem sempre passa e o comportamento eh identico.
                    *-- Aqui ela eh o que impede GRAVAR uma senha que a propria
                    *-- conferencia nao consegue ler de volta.
                    *--
                    *-- O par esta ASSIMETRICO neste ambiente (ver cabecalho):
                    *-- fCriptografar NAO foi portada, enquanto
                    *-- utils\fdecriptografar.prg existe e eh um PASS-THROUGH de
                    *-- OUTRO contrato (decodificar numero de fabricacao de
                    *-- impressora fiscal - o proprio arquivo avisa "NAO confundir
                    *-- com fCriptografar"). Sem esta guarda a gravacao "funciona"
                    *-- em silencio e grava a senha em CLARO; no acesso seguinte
                    *-- fCriptografar(<claro>) nao casa com o que o usuario digita
                    *-- e a conta fica inacessivel, sem erro na tela - exatamente
                    *-- o desastre silencioso que a regra CLAUDE.md #27 proibe
                    *-- ("stub que devolve VALOR DE CALCULO: DEIXAR AUSENTE").
                    *--
                    *-- Hoje a chamada abaixo estoura (funcao ausente), o CATCH
                    *-- devolve a mensagem ao form e NADA eh gravado: a ausencia
                    *-- continua VISIVEL, como a regra manda. No dia em que
                    *-- fCriptografar for recuperada, esta linha passa a ser a
                    *-- afericao real de que ida e volta usam o MESMO algoritmo -
                    *-- e segue recusando a gravacao se nao usarem.
                    IF ALLTRIM(fCriptografar(loc_cCodificada)) == ALLTRIM(loc_cNova2)
                        REPLACE Senhas WITH loc_cCodificada
                        THIS.this_cSenhaArmazenada = TratarNulo(Senhas, "C")
                        THIS.this_lZSen = .T.
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_lZSen = .F.
                        THIS.this_cMensagemErro = "A nova senha n" + CHR(227) + "o pode ser gravada: " + ;
                            "a codifica" + CHR(231) + CHR(227) + "o e a confer" + CHR(234) + "ncia de " + ;
                            "senha usam algoritmos diferentes neste ambiente. " + ;
                            "Nada foi alterado."
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lSucesso = .F.
            ENDTRY
        ELSE
            THIS.this_lZSen = .F.
            THIS.this_cMensagemErro = "Senha Conflitante!!! Altera" + CHR(231) + CHR(227) + "o Cancelada!!!"
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - Este dialogo nao edita uma unica linha de uma
    * unica tabela (regra CLAUDE.md #51): opera sobre a coluna Senhas de
    * um cursor externo, identificado por this_cArquivo. Fica disponivel
    * so por completude de contrato - RegistrarAuditoria nunca eh chamado
    * aqui, porque Inserir/Atualizar nao sao sobrescritos (mesmo padrao de
    * SigOpAutBO.ObterChavePrimaria).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cArquivo, ""))
    ENDPROC

    *====================================================================
    * Este dialogo NAO persiste nenhuma tabela propria (SigOpCts nao existe
    * no banco - e um dialogo modal de senha que le/grava a coluna Senhas
    * de um cursor ja aberto, informado em this_cArquivo). Inserir()/
    * Atualizar()/ExecutarExclusao()/RegistrarAuditoria() NAO sao
    * sobrescritos aqui - o comportamento padrao herdado de BusinessBase
    * ja eh o correto para este caso.
    *====================================================================

ENDDEFINE
