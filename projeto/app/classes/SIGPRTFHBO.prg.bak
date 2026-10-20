*============================================================================
* SIGPRTFHBO.prg - Business Object para Consulta de Cheque via SiTef
*
* Origem         : SIGPRIFF.SCX ("SiTef - Consulta de Cheque")
* Tabela         : nenhuma - dialogo de integracao com terminal de pagamento
*                  (CliSiTef32I.DLL), sem persistencia em tabela SQL Server.
* Dados tratados : parametros recebidos do chamador (dados do cheque/conta) e
*                  o retorno textual da transacao SiTef (this_cRetChe), que o
*                  form devolve ao caller via Unload (padrao fwDialog legado).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SIGPRTFHBO AS BusinessBase

    *==========================================================================
    * Propriedades - parametros recebidos pelo Init do form legado (PARAMETERS)
    *==========================================================================
    this_cIp        = ""   && Endereco IP do servidor SiTef
    this_cInicio    = ""   && Codigo da modalidade/funcao SiTef (lcInicio)
    this_nValor     = 0    && Valor da transacao (pcValor)
    this_cCupom     = ""   && Numero do cupom fiscal (pcCupom)
    this_cCaixa     = ""   && Identificacao do caixa/operador (pcCaixa)
    this_nIdent     = 0    && Identificador da transacao SiTef (pcIdent)
    this_cPos       = ""   && Identificacao do POS/terminal (pcPos)
    this_nParcs     = 0    && Numero de parcelas (pcParcs)
    this_cFuncoes   = ""   && Lista de funcoes habilitadas, separadas por virgula (pcFuncoes)
    this_cBanco     = ""   && Codigo do banco do cheque (pcBanco / GetBanco)
    this_cAgencia   = ""   && Agencia do cheque (pcAgencia / GetAgencia)
    this_cConta     = ""   && Conta do cheque (pcConta / GetConta)
    this_cNCheque   = ""   && Numero do cheque (pcnCheque / GetCheque)
    this_cDtCheque  = ""   && Data do cheque, formato bruto do terminal (pcDtCheque)
    this_cCpf       = ""   && CPF/CNPJ do emitente (pcCpf / GetCpf)
    this_cTpPessoa  = ""   && Tipo de pessoa: "F"=Fisica, outro=Juridica (pcTpPessoa)
    this_cCupomNv   = ""   && Numero do cupom nao-vinculado (pcCupomnv)
    this_cAgendc    = ""   && Digito verificador da agencia (pcAgendc / GetDvAgencia)
    this_cContadc   = ""   && Digito verificador da conta (pcContadc / GetDvConta)
    this_cNumdc     = ""   && Digito verificador do numero do cheque (pcNumdc / GetDvCheque)
    this_cPraca     = ""   && Praca de compensacao (pcPraca / GetPraca)
    this_cPesquisa  = ""   && Opcao de pesquisa pre-definida (pcPesquisa)
    this_cCmc7      = ""   && Linha CMC7 lida do cheque (pcCMC7 / CMC7)
    this_cTeste     = ""   && Flag de ambiente de teste (pcteste)

    *==========================================================================
    * Propriedades - retorno/estado do dialogo (nao vem de parametro)
    *==========================================================================
    this_cRetChe    = ""   && Retorno textual da transacao SiTef (pcRetChe), devolvido ao caller no Unload
    this_lAbandona  = .F.  && Indica que o usuario abandonou/cancelou o dialogo (abandona)

    *==========================================================================
    * Propriedades - estado do protocolo interativo SiTef
    * Origem: variaveis locais do laco de SIGPRIFF.SAIDA.GotFocus. Ficam como
    * property porque o laco e dirigido pela tela um passo por vez, e o estado
    * tem de sobreviver entre os passos.
    *==========================================================================
    this_nStatus          = 10000  && Stts - status devolvido pelo terminal
    this_nProximoComando  = 0      && ProximoComando
    this_nTipoCampo       = 0      && TipoCampo
    this_nTamanhoMinimo   = 0      && TamanhoMinimo
    this_nTamanhoMaximo   = 0      && TamanhoMaximo
    this_nResultado       = 0      && lnResultado
    this_cBuffer          = ""     && Buffer (2000 bytes, completado com CHR(0))

    *-- Campos da transacao devolvidos pelo terminal, por TipoCampo
    this_cTipTran         = ""     && lsTipTran  (TipoCampo 100)
    this_cDataHora        = ""     && lsDataHora (TipoCampo 105)
    this_cCupomRet        = ""     && lsCupom    (TipoCampo 121)
    this_cCartao          = ""     && lsCartao   (TipoCampo 132)
    this_cNsu             = ""     && lsNsu      (TipoCampo 134)
    this_cAutoriza        = ""     && lsAutoriza (TipoCampo 135)
    this_cFinaliza        = ""     && lsFinaliza

    *-- Textos que o terminal envia ao longo da conversa
    this_cMensagemSiTef   = ""     && lsMensagem  (comando 22)
    this_cMensagemRet     = ""     && lsMRet      (comando 3)
    this_cMensagemAnalise = ""     && lsMensagem1 (opcaoc = "4")
    this_cTituloComando   = ""     && lcTitulo    (comandos 30/34/20/4)

    *-- Retorno SERASA decodificado (3 linhas exibidas na tela)
    this_cRetSerasa1      = ""
    this_cRetSerasa2      = ""
    this_cRetSerasa3      = ""
    this_nIndiceSerasa    = 0      && npos do Ascan(CodSerasa, Substr(Buffer,1,2))

    *-- Contadores das respostas automaticas
    this_nEtapaTipo       = 1      && lnTipo  - etapas do comando 21
    this_nEtapaCartao     = 1      && lnCard  - etapas do comando 30
    this_nPosFuncao       = 1      && lnPos   - indice em pcFuncoes
    this_nCarSen          = 1      && carsen  - 1 = aguarda cartao, 2 = aguarda senha
    this_cOpcaoConsulta   = "0"    && Opcaoc  - opcao de consulta escolhida

    *-- Valores digitados pelo usuario, na forma exibivel
    this_cNumParcelas     = ""     && nNumParcs
    this_cValorDigitado   = "0,00" && nValores
    this_cDataDigitada    = ""     && nDatas

    *-- Biblioteca do terminal (CliSiTef32I.DLL) carregada com sucesso pelos
    *-- DECLARE de DeclararFuncoesSiTef. Fica .F. na estacao que nao tem o
    *-- integrador SiTef instalado - ver DeclararFuncoesSiTef/IniciarSessaoSiTef.
    this_lSiTefDisponivel = .F.

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Este dialogo nao grava em tabela alguma: o resultado da consulta de
    * cheque e repassado ao terminal SiTef (CliSiTef32I.DLL) e o retorno fica
    * em this_cRetChe. this_cTabela/this_cCampoChave permanecem vazios
    * (herdados de BusinessBase), pois Salvar/Excluir/Buscar nao se aplicam
    * a este BO.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.DeclararFuncoesSiTef()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Persistencia e metodos CRUD - decisao de projeto
    *
    * Este dialogo NAO grava nem le tabela do SQL Server (ver o cabecalho do
    * arquivo). Conferido no dump do legado (SIGPRTFH_form_codigo_fonte.txt):
    * nao existe TABLEUPDATE nem .AddCursor, e o unico alvo de Insert Into e o
    * cursor LOCAL crSiTef, criado no proprio form com CREATE CURSOR e copiado
    * para arquivo SDF. Nao ha tabela, nem chave primaria, nem coluna a mapear.
    *
    * Por isso os metodos de persistencia da BusinessBase ficam HERDADOS, e nao
    * sobrescritos aqui:
    *   - CarregarDoCursor  : nao existe cursor de registro para mapear;
    *   - Inserir           : nao existe tabela destino - sobrescrever exigiria
    *   - Atualizar           INVENTAR um INSERT/UPDATE, e a regra #22 manda a
    *                         lista de colunas vir do schema, nunca de palpite;
    *   - ExecutarExclusao  : idem;
    *   - ObterChavePrimaria: nao ha chave.
    * O comportamento herdado - recusar a operacao e reportar pelo ExibirFalha
    * do Salvar - ja eh o correto para esta tela.
    *
    * A logica de negocio real deste BO e a integracao com o terminal SiTef via
    * CliSiTef32I.DLL, portada a partir de SIGPRIFF.SCX: Procedures Load,
    * errotef, montaretorno, retornofalha e Unload, mais o laco interativo de
    * SAIDA.GotFocus (os metodos Iniciar/Continuar/MontarBuffer*/Capturar*/
    * Decodificar* abaixo).
    *==========================================================================

    *--------------------------------------------------------------------------
    * DeclararFuncoesSiTef - Registra as assinaturas das funcoes do terminal
    * SiTef (CliSiTef32I.DLL). Origem: SIGPRIFF.Load. Chamado uma vez no Init
    * de cada instancia do BO (DECLARE repetido e inofensivo em VFP9).
    *
    * O DECLARE ... IN <dll> do VFP9 CARREGA a biblioteca na hora: na estacao
    * sem o integrador SiTef instalado ele estoura "Cannot load 32-bit DLL
    * CliSiTef32I.DLL." Sem o TRY abaixo esse erro subia para o CATCH do Init,
    * que devolvia .F., e dai CREATEOBJECT("SIGPRTFHBO") devolvia .F. (logico)
    * -> o Form via VARTYPE <> "O", InicializarForm devolvia .F. e
    * CREATEOBJECT("FormSIGPRTFH") devolvia .F.: a TELA NAO ABRIA, exibindo so
    * "VARTYPE retornou: L", que nao diz ao operador o que faltou.
    *
    * Com a biblioteca ausente, a conversa com o terminal e impossivel - que e
    * exatamente a condicao para a qual o legado JA tem mensagem propria em
    * SIGPRIFF.SAIDA.GotFocus ("Sem comunicacao com SiTef", o ramo de
    * ConfiguraIntSiTefInterativo <> 0). Registra-se portanto a indisponibilidade
    * em this_lSiTefDisponivel e deixa-se IniciarSessaoSiTef dar essa mesma
    * resposta, em vez de impedir a abertura da tela. NENHUMA funcao da DLL e
    * chamada com a flag em .F. (ver os quatro wrappers abaixo) - chamar funcao
    * nao declarada faria o VFP procurar <nome>.prg no PATH (regra #13).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        THIS.this_lSiTefDisponivel = .F.

        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String par_cEndereco, String par_cLoja, String par_cTerminal, Integer par_nReservado

            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer par_nModalidade, String par_cValor, String par_cCupom, ;
                String par_cData, String par_cHorario, String par_cOperador, String par_cRestricao

            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @par_nComando, Integer @par_nTipo, Integer @par_nMinimo, ;
                Integer @par_nMaximo, String @par_cBuffer, Integer par_nTamanho, Integer par_nResultado

            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer par_nConfirma, String par_cCupom, String par_cData, String par_cHorario

            THIS.this_lSiTefDisponivel = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarConexaoSiTef - Abre a sessao com o terminal SiTef.
    * Origem: SIGPRIFF.SAIDA.GotFocus (ConfiguraIntSiTefInterativo).
    * Retorna .T. se a conexao foi configurada com sucesso.
    *--------------------------------------------------------------------------
    FUNCTION ConfigurarConexaoSiTef(par_cIp, par_cIdTerminal, par_cPos)
        LOCAL loc_lOk
        loc_lOk = .F.

        IF THIS.this_lSiTefDisponivel
            loc_lOk = (ConfiguraIntSiTefInterativo(par_cIp, par_cIdTerminal, par_cPos, 0) = 0)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * IniciarFuncaoSiTef - Inicia a funcao/modalidade na sessao SiTef aberta.
    * Origem: SIGPRIFF.SAIDA.GotFocus (IniciaFuncaoSiTefInterativo).
    * Retorna .T. quando o terminal aceita o inicio (codigo 10000).
    *--------------------------------------------------------------------------
    FUNCTION IniciarFuncaoSiTef(par_nModalidade, par_cValor, par_cCupom, par_cData, par_cHora, par_cOperador)
        LOCAL loc_lOk
        loc_lOk = .F.

        IF THIS.this_lSiTefDisponivel
            loc_lOk = (IniciaFuncaoSiTefInterativo(par_nModalidade, par_cValor, par_cCupom, ;
                par_cData, par_cHora, par_cOperador, "") = 10000)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * FinalizarTransacaoSiTef - Confirma/cancela a transacao com o terminal.
    * Origem: SIGPRIFF.Load (DECLARE FinalizaTransacaoSiTefInterativo) - a
    * chamada do legado nao aparecia no dump de metodos com codigo, mas a
    * funcao e declarada e faz parte do contrato do protocolo SiTef.
    *--------------------------------------------------------------------------
    FUNCTION FinalizarTransacaoSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        *-- -1 = "Modulo Nao Iniciado" na tabela de erros do proprio legado
        *-- (SIGPRIFF.errotef / ProcessarErroSiTef), que e o que a biblioteca
        *-- ausente significa: o modulo SiTef nunca foi iniciado.
        loc_nRetorno = -1

        IF THIS.this_lSiTefDisponivel
            loc_nRetorno = FinalizaTransacaoSiTefInterativo(par_nConfirma, par_cCupom, ;
                par_cData, par_cHora)
        ENDIF

        RETURN loc_nRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarErroSiTef - Traduz o codigo de retorno de erro do terminal para
    * mensagem e grava o retorno de falha (origem: SIGPRIFF.errotef).
    * NOTA: o legado testa tambem "Type('lnRetorno')<>'N' And (lnRetorno>-1
    * Or lnRetorno<-5)" antes das faixas abaixo, mas lnRetorno nunca e
    * declarado/recebido no metodo original (so existe pnRetornos) - essa
    * comparacao estouraria "Variable 'LNRETORNO' is not found" se alcancada,
    * portanto e um ramo morto do legado e nao foi transcrito.
    *--------------------------------------------------------------------------
    FUNCTION ProcessarErroSiTef(par_nRetornos)
        LOCAL loc_cMensagem
        loc_cMensagem = ""

        DO CASE
            CASE par_nRetornos = -1
                loc_cMensagem = "M" + CHR(243) + "dulo N" + CHR(227) + "o Iniciado"
            CASE par_nRetornos = -2
                loc_cMensagem = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"
            CASE par_nRetornos = -3
                loc_cMensagem = "Fornecida uma Modalidade Inv" + CHR(225) + "lida"
            CASE par_nRetornos = -4
                loc_cMensagem = "Falta Mem" + CHR(243) + "ria para Rodar a Fun" + CHR(231) + CHR(227) + "o"
            CASE par_nRetornos = -5
                loc_cMensagem = "Sem Comunica" + CHR(231) + CHR(227) + "o com o SiTef"
        ENDCASE

        IF !EMPTY(loc_cMensagem)
            THIS.GravarRetornoFalha(loc_cMensagem, 0)
        ENDIF

        RETURN !EMPTY(loc_cMensagem)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMensagemSerasa - Mapeia o codigo de retorno SERASA (2 digitos) para
    * a mensagem correspondente, numa unica string.
    * Origem: SIGPRIFF.Init / SIGPRIFF.SAIDA.GotFocus (arrays CodSerasa /
    * RetSerasa). A tabela em si mora em LocalizarSerasa, que e quem conhece as
    * 3 linhas separadas - aqui elas sao apenas concatenadas.
    * Retorna "" quando o codigo nao esta na tabela (o chamador usa o Buffer
    * cru como mensagem nesse caso, igual ao legado).
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemSerasa(par_cCodigo)
        LOCAL loc_cMensagem

        loc_cMensagem = ""

        IF THIS.LocalizarSerasa(par_cCodigo)
            loc_cMensagem = THIS.this_cRetSerasa1 + " " + THIS.this_cRetSerasa2 + " " + ;
                THIS.this_cRetSerasa3
        ENDIF

        RETURN loc_cMensagem
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarRetornoFalha - Grava o arquivo de retorno de falha lido pelo
    * integrador SiTef (IntPos.001/IntPos.STS, formato SDF). Origem:
    * SIGPRIFF.retornofalha.
    * NOTA: o legado grava "STR(ltIdent,10)" - ltIdent nunca e declarado em
    * retornofalha nem em metodo algum do form (so existe ThisForm.pcIdent),
    * o que estouraria "Variable 'LTIDENT' is not found" se exercido; aqui usa-se
    * THIS.this_nIdent (equivalente portado de pcIdent) no lugar da variavel
    * inexistente.
    *--------------------------------------------------------------------------
    PROCEDURE GravarRetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_cMensagem, loc_cValPago

        loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
            "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usu" + CHR(225) + "rio", par_cMensagem)
        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (Tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO "C:\client\Resp\IntPos.001" SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO "C:\client\Resp\IntPos.STS" SDF

            USE IN crSiTef
            THIS.this_cRetChe = "999 - " + loc_cMensagem
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarRetornoSucesso - Grava o arquivo de retorno de sucesso lido pelo
    * integrador SiTef (IntPos.001/IntPos.STS, formato SDF). Origem:
    * SIGPRIFF.montaretorno.
    *--------------------------------------------------------------------------
    PROCEDURE GravarRetornoSucesso(par_cTipTran, par_cDataHora, par_cCupom, par_cCartao, ;
            par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)

        LOCAL loc_cValPago, loc_aCartao[11], loc_cCupomRestante, loc_nPos, loc_nLinha

        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        loc_aCartao[1]  = "Outro, n" + CHR(227) + "o definido"
        loc_aCartao[2]  = "Visa"
        loc_aCartao[3]  = "Mastercard"
        loc_aCartao[4]  = "Diners"
        loc_aCartao[5]  = "American Express"
        loc_aCartao[6]  = "Sollo"
        loc_aCartao[7]  = "Sidecard (Redecard)"
        loc_aCartao[8]  = "Private Label (Redecard)"
        loc_aCartao[9]  = "Redeshop"
        loc_aCartao[10] = ""
        loc_aCartao[11] = "Fininvest"

        IF VAL(par_cCartao) > 10 OR VAL(par_cCartao) < 0
            par_cCartao = "0"
        ENDIF

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (Tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(par_cCartao) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_cTipTran)
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_cNsu)
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_cAutoriza)
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_cFinaliza)
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))

            loc_cCupomRestante = par_cCupom
            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos != 0
                loc_nPos = AT(CHR(10), loc_cCupomRestante)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                    IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante))
                loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMenRet)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO "C:\client\Resp\IntPos.001" SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO "C:\client\Resp\IntPos.STS" SDF

            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterIdTerminal - Identificacao da loja enviada ao SiTef.
    * Origem: SIGPRIFF.SAIDA.GotFocus (lsIdTerminal = "00000" + _Empr).
    * O legado usa a PUBLIC _Empr; aqui usa-se go_4c_Sistema.cCodEmpresa,
    * conforme a regra do projeto que aposenta _EMPR.
    *--------------------------------------------------------------------------
    FUNCTION ObterIdTerminal()
        LOCAL loc_cEmpresa
        loc_cEmpresa = ""

        IF TYPE("go_4c_Sistema") = "O"
            IF !ISNULL(go_4c_Sistema) AND PEMSTATUS(go_4c_Sistema, "cCodEmpresa", 5)
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF
        ENDIF

        RETURN "00000" + loc_cEmpresa
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarValorSiTef - Valor no formato que o terminal espera (virgula
    * decimal, sem separador de milhar).
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   lnValPago = ALLTRIM(STRTRAN(TRANSFORM(pcValor,"999999999.99"),".",","))
    *--------------------------------------------------------------------------
    FUNCTION FormatarValorSiTef(par_nValor)
        LOCAL loc_nValor
        loc_nValor = IIF(VARTYPE(par_nValor) = "N", par_nValor, VAL(TRANSFORM(par_nValor)))
        RETURN ALLTRIM(STRTRAN(TRANSFORM(loc_nValor, "999999999.99"), ".", ","))
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterDataSiTef / ObterHoraSiTef - Data (AAAAMMDD) e hora (HHMMSS) da
    * transacao. Origem: SIGPRIFF.SAIDA.GotFocus
    *   lcData = STR(YEAR(DATE()),4)+SUBSTR(DTOC(DATE()),4,2)+SUBSTR(DTOC(DATE()),1,2)
    *   lcHora = STRTRAN(TIME(),":","")
    * O recorte 4,2 / 1,2 do DTOC pressupoe SET DATE BRITISH (dd/mm/aaaa), que
    * FormBase.Init garante.
    *--------------------------------------------------------------------------
    FUNCTION ObterDataSiTef()
        RETURN STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
    ENDFUNC

    FUNCTION ObterHoraSiTef()
        RETURN STRTRAN(TIME(), ":", "")
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarFalhaSiTef - Encerra a transacao com falha, gravando o arquivo
    * de retorno que o integrador le.
    *
    * Origem: SIGPRIFF.SAIDA.GotFocus, que nos caminhos de falha faz
    *   DO SigTfSup WITH "P", <mensagem>, "", "", "", "", "", "", "", lnValPago, "", pcIdent
    * O SigTfSup.prg dessa chamada (12 argumentos) NAO veio no acervo, e nao e
    * o SIGPRSTF.SCX ja migrado como FormSIGPRSTF - esse e o dialogo de senha
    * de supervisor e nao recebe argumento algum. Dos 12 argumentos, os que
    * carregam informacao sao exatamente <mensagem>, lnValPago e pcIdent, que e
    * o mesmo contrato do retornofalha do proprio form (portado aqui como
    * GravarRetornoFalha): grava IntPos.001/IntPos.STS com a mensagem, o valor
    * e o identificador. Delega-se portanto ao equivalente ja portado, em vez
    * de supor o conteudo de um arquivo ausente.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarFalhaSiTef(par_cMensagem)
        THIS.this_cMensagemErro = par_cMensagem
        THIS.GravarRetornoFalha(par_cMensagem, THIS.this_nValor)
    ENDPROC

    *--------------------------------------------------------------------------
    * ReiniciarEstadoSiTef - Zera o estado do protocolo antes de iniciar a
    * conversa com o terminal.
    * Origem: SIGPRIFF.SAIDA.GotFocus (bloco de inicializacao de
    * Stts/ProximoComando/TipoCampo/Buffer/lsTipTran/.../lnPos/carsen/lnTipo/
    * lnCard/Opcaoc/nNumParcs/nValores/nDatas).
    *--------------------------------------------------------------------------
    PROCEDURE ReiniciarEstadoSiTef()
        THIS.this_nStatus          = 10000
        THIS.this_nProximoComando  = 0
        THIS.this_nTipoCampo       = 0
        THIS.this_nTamanhoMinimo   = 0
        THIS.this_nTamanhoMaximo   = 0
        THIS.this_cBuffer          = SPACE(2000)
        THIS.this_nResultado       = 0

        THIS.this_cTipTran         = ""
        THIS.this_cDataHora        = ""
        THIS.this_cCupomRet        = ""
        THIS.this_cCartao          = ""
        THIS.this_cNsu             = ""
        THIS.this_cAutoriza        = ""
        THIS.this_cFinaliza        = ""

        THIS.this_cMensagemSiTef   = ""
        THIS.this_cMensagemRet     = ""
        THIS.this_cMensagemAnalise = ""

        THIS.this_cRetSerasa1      = ""
        THIS.this_cRetSerasa2      = ""
        THIS.this_cRetSerasa3      = ""
        THIS.this_nIndiceSerasa    = 0

        THIS.this_nEtapaTipo       = 1
        THIS.this_nEtapaCartao     = 1
        THIS.this_nPosFuncao       = 1
        THIS.this_nCarSen          = 1
        THIS.this_cOpcaoConsulta   = "0"

        THIS.this_cNumParcelas     = ALLTRIM(STR(THIS.this_nParcs))
        THIS.this_cValorDigitado   = "0,00"
        THIS.this_cDataDigitada    = ""
        THIS.this_lAbandona        = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarSessaoSiTef - Configura a conexao e inicia a funcao no terminal.
    * Origem: SIGPRIFF.SAIDA.GotFocus (ConfiguraIntSiTefInterativo seguido de
    * IniciaFuncaoSiTefInterativo). Em qualquer das duas falhas o legado grava
    * o retorno de falha "Sem comunicacao com SiTef" e aborta.
    *
    * O 1o argumento de IniciaFuncaoSiTefInterativo e declarado Integer (ver
    * DeclararFuncoesSiTef); o legado passa pcInicio, que recebe o parametro
    * lcInicio - caractere. Converte-se com VAL para respeitar o tipo da DLL.
    *
    * Retorna .T. quando a sessao esta aberta e o laco pode comecar.
    *--------------------------------------------------------------------------
    FUNCTION IniciarSessaoSiTef()
        LOCAL loc_lSucesso, loc_cMsgSemCom, loc_oErro

        loc_lSucesso   = .F.
        loc_cMsgSemCom = "Sem comunica" + CHR(231) + CHR(227) + "o com SiTef"

        TRY
            IF !THIS.ConfigurarConexaoSiTef(THIS.this_cIp, THIS.ObterIdTerminal(), THIS.this_cPos)
                THIS.RegistrarFalhaSiTef(loc_cMsgSemCom)
            ELSE
                IF !THIS.IniciarFuncaoSiTef(VAL(THIS.this_cInicio), ;
                        THIS.FormatarValorSiTef(THIS.this_nValor), THIS.this_cCupom, ;
                        THIS.ObterDataSiTef(), THIS.ObterHoraSiTef(), THIS.this_cCaixa)
                    THIS.RegistrarFalhaSiTef(loc_cMsgSemCom)
                ELSE
                    THIS.ReiniciarEstadoSiTef()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao iniciar sess" + CHR(227) + "o SiTef")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ContinuarFuncaoSiTef - Executa UM passo do protocolo interativo.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   Stts = ContinuaFuncaoSiTefInterativo(@ProximoComando, @TipoCampo,
    *          @TamanhoMinimo, @TamanhoMaximo, @Buffer,
    *          Len(ALLTRIM(Buffer)), lnResultado)
    *   lnResultado = 0
    * Os 5 primeiros argumentos sao por REFERENCIA, por isso passam por
    * variaveis LOCAIS - property de objeto nao pode ser passada com @ - e
    * voltam para as properties depois da chamada. Retorna o status (Stts).
    *--------------------------------------------------------------------------
    FUNCTION ContinuarFuncaoSiTef()
        LOCAL loc_nComando, loc_nTipo, loc_nMinimo, loc_nMaximo, loc_cBuffer, loc_nStatus

        IF !THIS.this_lSiTefDisponivel
            *-- -1 = "Modulo Nao Iniciado" (SIGPRIFF.errotef). Sai do laco pelo
            *-- mesmo caminho de qualquer status <> 10000.
            THIS.this_nStatus = -1
            RETURN -1
        ENDIF

        loc_nComando = THIS.this_nProximoComando
        loc_nTipo    = THIS.this_nTipoCampo
        loc_nMinimo  = THIS.this_nTamanhoMinimo
        loc_nMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer  = THIS.this_cBuffer

        loc_nStatus = ContinuaFuncaoSiTefInterativo(@loc_nComando, @loc_nTipo, ;
            @loc_nMinimo, @loc_nMaximo, @loc_cBuffer, ;
            LEN(ALLTRIM(loc_cBuffer)), THIS.this_nResultado)

        THIS.this_nProximoComando = loc_nComando
        THIS.this_nTipoCampo      = loc_nTipo
        THIS.this_nTamanhoMinimo  = loc_nMinimo
        THIS.this_nTamanhoMaximo  = loc_nMaximo
        THIS.this_cBuffer         = loc_cBuffer
        THIS.this_nStatus         = loc_nStatus
        THIS.this_nResultado      = 0

        RETURN loc_nStatus
    ENDFUNC

    *--------------------------------------------------------------------------
    * PreencherBuffer - Monta o buffer de 2000 bytes que o terminal espera,
    * completando com CHR(0).
    * Origem: SIGPRIFF.SAIDA.GotFocus (Buffer = <valor> +
    * REPLICATE(CHR(0), 2000 - LEN(<valor>)), que no legado aparece tambem com
    * as constantes ja calculadas 1999/1998/1992).
    *--------------------------------------------------------------------------
    FUNCTION PreencherBuffer(par_cValor)
        LOCAL loc_cValor, loc_nFalta

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", par_cValor, TRANSFORM(par_cValor))
        loc_nFalta = 2000 - LEN(loc_cValor)

        IF loc_nFalta > 0
            loc_cValor = loc_cValor + REPLICATE(CHR(0), loc_nFalta)
        ELSE
            loc_cValor = LEFT(loc_cValor, 2000)
        ENDIF

        THIS.this_cBuffer = loc_cValor
        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparBuffer - Origem: SIGPRIFF.SAIDA.GotFocus, ultimo IF do laco:
    * quando o comando NAO e 30/21/34/20/31, o legado faz Buffer = SPACE(2000).
    *--------------------------------------------------------------------------
    PROCEDURE LimparBuffer()
        THIS.this_cBuffer = SPACE(2000)
    ENDPROC

    *--------------------------------------------------------------------------
    * ComandoEsperaCampo - .T. quando o comando corrente e um dos que pedem
    * conteudo no buffer (e portanto NAO deve ter o buffer limpo no fim do
    * passo). Origem: SIGPRIFF.SAIDA.GotFocus (ProximoComando 30/21/34/20/31).
    *--------------------------------------------------------------------------
    FUNCTION ComandoEsperaCampo(par_nComando)
        RETURN INLIST(par_nComando, 30, 21, 34, 20, 31)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTotalFuncoes / ObterFuncaoPorIndice - Quebra a lista pcFuncoes
    * (codigos de funcao separados por virgula) nos caracteres que o legado
    * envia um a um ao terminal.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   DECLARE funcoes[OCCURS(",",pcFuncoes)+1]
    *   FOR npos = 1 TO OCCURS(",",pcFuncoes)
    *       funcoes[npos] = SUBSTR(pcFuncoes, IIF(npos=1, 1, AT(",",pcFuncoes,npos)+1), 1)
    *   NEXT
    *   funcoes[npos] = SUBSTR(pcFuncoes, LEN(pcFuncoes), 1)
    * Ou seja: o ULTIMO elemento e o ultimo caractere da lista, e nao o que
    * segue a ultima virgula - transcrito exatamente assim.
    *--------------------------------------------------------------------------
    FUNCTION ObterTotalFuncoes()
        IF EMPTY(THIS.this_cFuncoes)
            RETURN 0
        ENDIF

        RETURN OCCURS(",", THIS.this_cFuncoes) + 1
    ENDFUNC

    FUNCTION ObterFuncaoPorIndice(par_nIndice)
        LOCAL loc_nOcorrencias, loc_cFuncao

        loc_cFuncao = ""

        IF !EMPTY(THIS.this_cFuncoes)
            loc_nOcorrencias = OCCURS(",", THIS.this_cFuncoes)

            DO CASE
                CASE par_nIndice = 1
                    loc_cFuncao = SUBSTR(THIS.this_cFuncoes, 1, 1)
                CASE par_nIndice > 1 AND par_nIndice <= loc_nOcorrencias
                    loc_cFuncao = SUBSTR(THIS.this_cFuncoes, ;
                        AT(",", THIS.this_cFuncoes, par_nIndice) + 1, 1)
                CASE par_nIndice = loc_nOcorrencias + 1
                    loc_cFuncao = SUBSTR(THIS.this_cFuncoes, LEN(THIS.this_cFuncoes), 1)
            ENDCASE
        ENDIF

        RETURN loc_cFuncao
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBufferCheque - Dados do cheque no comando 31.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   If Empty(CMC7)
    *     Buffer = "0:"+pcPraca+pcBanco+pcAgencia+pcAgendc+PADR(pcConta,10)+
    *              pcContadc+pcnCheque+pcNumdc
    *   Else
    *     Buffer = "1:"+CMC7
    *--------------------------------------------------------------------------
    FUNCTION MontarBufferCheque()
        LOCAL loc_cValor

        IF EMPTY(THIS.this_cCmc7)
            loc_cValor = "0:" + THIS.this_cPraca + THIS.this_cBanco + ;
                THIS.this_cAgencia + THIS.this_cAgendc + ;
                PADR(THIS.this_cConta, 10) + THIS.this_cContadc + ;
                THIS.this_cNCheque + THIS.this_cNumdc
        ELSE
            loc_cValor = "1:" + THIS.this_cCmc7
        ENDIF

        RETURN THIS.PreencherBuffer(loc_cValor)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBufferCartao - Respostas automaticas do comando 30 quando
    * pcFuncoes = "1". Origem: SIGPRIFF.SAIDA.GotFocus (etapas lnCard 1/2/3):
    *   1 -> IIF(pcTpPessoa="F","0","1")   (pessoa fisica / juridica)
    *   2 -> pcCpf
    *   3 -> pcDtCheque
    * Avanca a etapa (this_nEtapaCartao) exatamente como o legado.
    *--------------------------------------------------------------------------
    FUNCTION MontarBufferCartao()
        LOCAL loc_cValor, loc_lMontou

        loc_cValor  = ""
        loc_lMontou = .F.

        DO CASE
            CASE THIS.this_nEtapaCartao = 1
                loc_cValor  = IIF(THIS.this_cTpPessoa = "F", "0", "1")
                loc_lMontou = .T.
            CASE THIS.this_nEtapaCartao = 2
                loc_cValor  = THIS.this_cCpf
                loc_lMontou = .T.
            CASE THIS.this_nEtapaCartao = 3
                loc_cValor  = THIS.this_cDtCheque
                loc_lMontou = .T.
        ENDCASE

        IF loc_lMontou
            THIS.PreencherBuffer(loc_cValor)
            THIS.this_nEtapaCartao = THIS.this_nEtapaCartao + 1
        ENDIF

        RETURN loc_lMontou
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBufferTipoConsulta - Respostas automaticas do comando 21 quando
    * pcFuncoes = "1". Origem: SIGPRIFF.SAIDA.GotFocus (etapas lnTipo 1/2):
    *   1 -> "1" (fixo)
    *   2 -> a opcao de consulta escolhida (pcPesquisa, ou a escolha do
    *        dialogo que a tela abre quando pcPesquisa vem vazio)
    * A etapa 2 depende de interacao, por isso recebe a opcao por parametro -
    * quem a obtem e a tela, nas fases de UI.
    *--------------------------------------------------------------------------
    FUNCTION MontarBufferTipoConsulta(par_cOpcao)
        LOCAL loc_lMontou

        loc_lMontou = .F.

        DO CASE
            CASE THIS.this_nEtapaTipo = 1
                THIS.PreencherBuffer("1")
                THIS.this_nEtapaTipo = 2
                loc_lMontou = .T.
            CASE THIS.this_nEtapaTipo = 2
                THIS.this_cOpcaoConsulta = par_cOpcao
                THIS.PreencherBuffer(par_cOpcao)
                THIS.this_nEtapaTipo = 3
                loc_lMontou = .T.
        ENDCASE

        RETURN loc_lMontou
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterOpcaoConsultaPadrao - Opcao de consulta que dispensa perguntar.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF EMPTY(pcPesquisa) -> DO FORM SigCqTef TO opcaoc   (tela escolhe)
    *   ELSE                 -> opcaoc = pcPesquisa
    * Devolve "" quando a escolha tem de vir do dialogo.
    *--------------------------------------------------------------------------
    FUNCTION ObterOpcaoConsultaPadrao()
        RETURN IIF(EMPTY(THIS.this_cPesquisa), "", THIS.this_cPesquisa)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBufferParcelas - Responde o numero de parcelas sem perguntar ao
    * usuario, quando ele ja veio por parametro.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF ProximoComando = 30 and (TipoCampo = 505 OR TipoCampo = 511) AND pcParcs <> 0
    *     Buffer = ALLTRIM(TRANSFORM(pcParcs,"@L 99"))+REPLICATE(CHR(0),1998)
    *     pcParcs = 0
    * O legado ZERA pcParcs para responder uma unica vez - preservado aqui.
    *--------------------------------------------------------------------------
    FUNCTION MontarBufferParcelas()
        LOCAL loc_lRespondeu

        loc_lRespondeu = .F.

        IF THIS.this_nProximoComando = 30 AND ;
                INLIST(THIS.this_nTipoCampo, 505, 511) AND THIS.this_nParcs != 0
            THIS.PreencherBuffer(ALLTRIM(TRANSFORM(THIS.this_nParcs, "@L 99")))
            THIS.this_nParcs = 0
            loc_lRespondeu = .T.
        ENDIF

        RETURN loc_lRespondeu
    ENDFUNC

    *--------------------------------------------------------------------------
    * ClassificarTipoDados - Diz que tipo de dado o terminal esta pedindo, para
    * o dialogo de captura saber o que exibir.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   TipoDados = ""
    *   IF TipoCampo = 504 OR 506 OR 515 OR "DDMMAAAA" $ Buffer -> "D"
    *   IF TipoCampo = 130                                      -> "V"
    * A ordem importa: 130 e testado DEPOIS e prevalece sobre "D".
    *--------------------------------------------------------------------------
    FUNCTION ClassificarTipoDados(par_nTipoCampo, par_cBuffer)
        LOCAL loc_cTipo

        loc_cTipo = ""

        IF INLIST(par_nTipoCampo, 504, 506, 515) OR "DDMMAAAA" $ par_cBuffer
            loc_cTipo = "D"
        ENDIF

        IF par_nTipoCampo = 130
            loc_cTipo = "V"
        ENDIF

        RETURN loc_cTipo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterEscolhasSimNao - Lista de opcoes do comando 20.
    * Origem: SIGPRIFF.SAIDA.GotFocus (Escolhas = "0:Sim;1:Nao;").
    * Literal preservado byte a byte: a string e PROTOCOLO, consumida pelo
    * dialogo de captura, nao texto de tela - acentuar mudaria o conteudo.
    *--------------------------------------------------------------------------
    FUNCTION ObterEscolhasSimNao()
        RETURN "0:Sim;1:Nao;"
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarDataParaSiTef - Converte a data escolhida pelo usuario para
    * DDMMAAAA e guarda a versao exibivel (nDatas do legado).
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   Valores = DTOC(Valores)
    *   nDatas  = Valores
    *   Valores = SUBSTR(Valores,1,2)+SUBSTR(Valores,4,2)+SUBSTR(Valores,7,4)
    * Usa ConverterParaData porque o valor chega ora DATE, ora DATETIME, ora
    * caractere, conforme o caminho - DTOC cru estouraria erro 11.
    *--------------------------------------------------------------------------
    FUNCTION FormatarDataParaSiTef(par_xData)
        LOCAL loc_dData, loc_cData

        loc_dData = ConverterParaData(par_xData)
        loc_cData = DTOC(loc_dData)

        THIS.this_cDataDigitada = loc_cData

        RETURN SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarValorParaSiTef - Converte o valor digitado pelo usuario e guarda
    * a versao exibivel (nValores do legado).
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   Valores  = STRTRAN(ALLTRIM(TRANSFORM(Valores,"99999999.99")),".",",")
    *   nValores = Valores
    *--------------------------------------------------------------------------
    FUNCTION FormatarValorParaSiTef(par_xValor)
        LOCAL loc_nValor, loc_cValor

        loc_nValor = IIF(VARTYPE(par_xValor) = "N", par_xValor, VAL(TRANSFORM(par_xValor)))
        loc_cValor = STRTRAN(ALLTRIM(TRANSFORM(loc_nValor, "99999999.99")), ".", ",")

        THIS.this_cValorDigitado = loc_cValor

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarNumeroParcelas - Guarda o numero de parcelas escolhido no
    * dialogo. Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF ProximoComando = 30 and (TipoCampo = 505 OR TipoCampo = 511)
    *     nNumParcs = Valores
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarNumeroParcelas(par_cValor)
        IF THIS.this_nProximoComando = 30 AND INLIST(THIS.this_nTipoCampo, 505, 511)
            THIS.this_cNumParcelas = par_cValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CapturarCampoRetorno - Guarda os campos da transacao que o terminal
    * devolve ao longo do laco, cada um identificado por TipoCampo.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   100 -> lsTipTran    105 -> lsDataHora   121 -> lsCupom
    *   132 -> lsCartao     134 -> lsNsu        135 -> lsAutoriza
    * O 134 e o unico normalizado (ALLTRIM(STR(VAL(Buffer)))).
    *--------------------------------------------------------------------------
    PROCEDURE CapturarCampoRetorno(par_nTipoCampo, par_cBuffer)
        DO CASE
            CASE par_nTipoCampo = 100
                THIS.this_cTipTran  = par_cBuffer
            CASE par_nTipoCampo = 105
                THIS.this_cDataHora = par_cBuffer
            CASE par_nTipoCampo = 121
                THIS.this_cCupomRet = par_cBuffer
            CASE par_nTipoCampo = 132
                THIS.this_cCartao   = par_cBuffer
            CASE par_nTipoCampo = 134
                THIS.this_cNsu      = ALLTRIM(STR(VAL(par_cBuffer)))
            CASE par_nTipoCampo = 135
                THIS.this_cAutoriza = par_cBuffer
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarTituloComando / RegistrarMensagemRetorno / RegistrarMensagemAnalise
    * Textos que o terminal manda em comandos especificos.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   ProximoComando 30/34/20 e 4 -> lcTitulo   = ALLTRIM(Buffer)
    *   ProximoComando 3            -> lsMRet     = ALLTRIM(Buffer)
    *   opcaoc = "4" AND stts <> 0  -> lsMensagem1 = ALLTRIM(Buffer)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarTituloComando(par_cBuffer)
        THIS.this_cTituloComando = ALLTRIM(par_cBuffer)
    ENDPROC

    PROCEDURE RegistrarMensagemRetorno(par_cBuffer)
        THIS.this_cMensagemRet = ALLTRIM(par_cBuffer)
    ENDPROC

    PROCEDURE RegistrarMensagemAnalise(par_cBuffer)
        IF THIS.this_cOpcaoConsulta = "4" AND THIS.this_nStatus != 0
            THIS.this_cMensagemAnalise = ALLTRIM(par_cBuffer)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarMensagemParcial / ConsumirMensagemParcial - Mensagem de
    * acompanhamento do comando 22 e o retorno aprovado que o legado monta a
    * partir dela.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF ProximoComando = 22 -> lsMensagem = ALLTRIM(STRTRAN(Buffer,CHR(0),''))
    *   e no inicio do passo seguinte:
    *     If !Empty(pcBanco) -> pcRetChe = '00' + ALLTRIM(lsMensagem)
    *     lsMensagem = ""
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarMensagemParcial(par_cBuffer)
        THIS.this_cMensagemSiTef = ALLTRIM(STRTRAN(par_cBuffer, CHR(0), ""))
    ENDPROC

    PROCEDURE ConsumirMensagemParcial()
        IF !EMPTY(THIS.this_cMensagemSiTef)
            IF !EMPTY(THIS.this_cBanco)
                THIS.this_cRetChe = "00" + ALLTRIM(THIS.this_cMensagemSiTef)
            ENDIF
            THIS.this_cMensagemSiTef = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalizarSerasa - Tabela de retorno SERASA do legado (CodSerasa /
    * RetSerasa, 8 codigos x 3 linhas). Origem: SIGPRIFF.Init e
    * SIGPRIFF.SAIDA.GotFocus, onde a tabela aparece duplicada - aqui ela vive
    * num unico lugar.
    * Preenche this_cRetSerasa1/2/3 e this_nIndiceSerasa, e retorna .T. quando
    * o codigo esta na tabela.
    *--------------------------------------------------------------------------
    FUNCTION LocalizarSerasa(par_cCodigo)
        LOCAL loc_aCodSerasa[8], loc_aRetSerasa[8,3], loc_nPos

        loc_aCodSerasa[1] = "00"
        loc_aCodSerasa[2] = "19"
        loc_aCodSerasa[3] = "56"
        loc_aCodSerasa[4] = "57"
        loc_aCodSerasa[5] = "60"
        loc_aCodSerasa[6] = "61"
        loc_aCodSerasa[7] = "65"
        loc_aCodSerasa[8] = "76"

        loc_aRetSerasa[1,1] = ""
        loc_aRetSerasa[1,2] = "Aprovado"
        loc_aRetSerasa[1,3] = ""

        loc_aRetSerasa[2,1] = "Banco N" + CHR(227) + "o Existe ou"
        loc_aRetSerasa[2,2] = "N" + CHR(227) + "o Trabalha com Conta Corrente ou"
        loc_aRetSerasa[2,3] = "Est" + CHR(225) + " em Processo de Liquida" + CHR(231) + CHR(227) + "o"

        loc_aRetSerasa[3,1] = "Pagamento de Compra com Cheque Pr" + CHR(233)
        loc_aRetSerasa[3,2] = "por Cliente N" + CHR(227) + "o Cadastrado no "
        loc_aRetSerasa[3,3] = "Estabelecimento"

        loc_aRetSerasa[4,1] = ""
        loc_aRetSerasa[4,2] = "Realizar Consulta Anal" + CHR(237) + "tica"
        loc_aRetSerasa[4,3] = ""

        loc_aRetSerasa[5,1] = ""
        loc_aRetSerasa[5,2] = "Falha no Processo de Consulta"
        loc_aRetSerasa[5,3] = ""

        loc_aRetSerasa[6,1] = "Excedido Limite para Pagamento"
        loc_aRetSerasa[6,2] = "de Compras com Cheque Pre-Datados"
        loc_aRetSerasa[6,3] = "Determinado pelo Estabelecimento"

        loc_aRetSerasa[7,1] = ""
        loc_aRetSerasa[7,2] = "Cheque Maior que o Limite de Compra"
        loc_aRetSerasa[7,3] = ""

        loc_aRetSerasa[8,1] = "Cliente Cadastrado Al" + CHR(233) + "m do Prazo"
        loc_aRetSerasa[8,2] = "Definido pelo Estabelecimento para"
        loc_aRetSerasa[8,3] = "Validade do Cart" + CHR(227) + "o provis" + CHR(243) + "rio"

        THIS.this_nIndiceSerasa = 0
        THIS.this_cRetSerasa1   = ""
        THIS.this_cRetSerasa2   = ""
        THIS.this_cRetSerasa3   = ""

        loc_nPos = ASCAN(loc_aCodSerasa, par_cCodigo)

        IF loc_nPos > 0
            THIS.this_nIndiceSerasa = loc_nPos
            THIS.this_cRetSerasa1   = loc_aRetSerasa[loc_nPos, 1]
            THIS.this_cRetSerasa2   = loc_aRetSerasa[loc_nPos, 2]
            THIS.this_cRetSerasa3   = loc_aRetSerasa[loc_nPos, 3]
        ENDIF

        RETURN (loc_nPos > 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * DecodificarRetornoFinal - Fecha a consulta traduzindo o buffer final.
    * Origem: SIGPRIFF.SAIDA.GotFocus (bloco final, depois do Enddo):
    *   If stts <> 1000 and stts <> 0
    *     npos = Ascan(CodSerasa, Substr(Buffer,1,2))
    *     If nPos = 0 -> pcRetChe = ALLTRIM(Buffer)        (1 linha, vermelho)
    *     Else        -> pcRetChe = Substr(Buffer,1,2)+linha1+' '+linha2+' '+linha3
    * Retorna .T. quando o codigo foi reconhecido (a tela mostra as 3 linhas) e
    * .F. quando nao (a tela mostra o buffer cru numa linha so).
    *--------------------------------------------------------------------------
    FUNCTION DecodificarRetornoFinal()
        LOCAL loc_lSerasa

        loc_lSerasa = .F.

        IF THIS.this_nStatus != 1000 AND THIS.this_nStatus != 0
            IF THIS.LocalizarSerasa(SUBSTR(THIS.this_cBuffer, 1, 2))
                THIS.this_cRetChe = SUBSTR(THIS.this_cBuffer, 1, 2) + ;
                    THIS.this_cRetSerasa1 + " " + THIS.this_cRetSerasa2 + " " + ;
                    THIS.this_cRetSerasa3
                loc_lSerasa = .T.
            ELSE
                THIS.this_cRetChe = ALLTRIM(THIS.this_cBuffer)
            ENDIF
        ENDIF

        RETURN loc_lSerasa
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterRetornoFinal - Valor que o dialogo devolve ao chamador.
    * Origem: SIGPRIFF.Unload
    *   pcRetChe = IIF(Type('pcRetChe') = 'L','999 - Consulta com Erro', pcRetChe)
    *   Return(pcRetChe)
    * No legado o Type 'L' denuncia a property nunca atribuida; aqui ela nasce
    * caractere, entao a condicao equivalente e estar vazia.
    *--------------------------------------------------------------------------
    FUNCTION ObterRetornoFinal()
        IF EMPTY(THIS.this_cRetChe)
            THIS.this_cRetChe = "999 - Consulta com Erro"
        ENDIF

        RETURN THIS.this_cRetChe
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarCancelamentoUsuario - Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF stts = -2 -> lsMensagem = "Operacao Canceleda pelo Usuario" / EXIT
    * O legado tem o erro de digitacao "Canceleda"; a mensagem aqui segue a
    * grafia correta, por ser texto exibido ao usuario.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarCancelamentoUsuario()
        THIS.this_lAbandona      = .T.
        THIS.this_cMensagemSiTef = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + ;
            CHR(225) + "rio"
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarSenhaDigitada / ObterEtapaCartaoSenha - Estado do aviso "Passe ou
    * Insira o Cartao" / "Digite a Senha".
    * Origem: SIGPRIFF.SAIDA.GotFocus (variavel carsen: nasce 1 e vira 2 no
    * comando 13, que e quando o cartao ja foi lido).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarSenhaDigitada()
        THIS.this_nCarSen = 2
    ENDPROC

    FUNCTION ObterEtapaCartaoSenha()
        RETURN THIS.this_nCarSen
    ENDFUNC

ENDDEFINE
