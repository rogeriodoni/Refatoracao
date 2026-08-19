*==============================================================================
* CLIENTEBO.PRG
* Business Object para Cadastro de Cliente (SIGCDCLI)
*
* Tabela Principal : SIGCDCLI - Cadastro de clientes
* Chave Primaria   : iclis char(10)
*
* Nota: Form OPERACIONAL - wrapping do container clsconta (framework).
*       BO gerencia CRUD direto no SQL Server para a entidade Cliente.
*==============================================================================

DEFINE CLASS cliBO AS BusinessBase

    *-- Identificacao
    this_cIclis            = ""    && iclis     char(10) PK - Codigo do cliente
    this_nNclis            = 0     && nclis     numeric(10,0) - Numero sequencial
    this_nIdcontas         = 0     && idcontas  numeric(6,0) - ID conta vinculada
    this_nIdconta          = 0     && idconta   numeric(10,0) - ID conta

    *-- Dados cadastrais basicos
    this_cRclis            = ""    && rclis     char(50) - Razao social / Nome
    this_cRazaos           = ""    && razaos    char(50) - Razao social alternativa
    this_cNomearts         = ""    && nomearts  char(50) - Nome artistico
    this_cCpfs             = ""    && cpfs      char(20) - CPF ou CNPJ
    this_cCpfcs            = ""    && cpfcs     char(11) - CPF conjuge
    this_cRgs              = ""    && rgs       char(20) - RG ou IE
    this_cRgconjuges       = ""    && rgconjuges char(13) - RG conjuge
    this_cRgcs             = ""    && rgcs      char(9) - RG codigo
    this_cEmissors         = ""    && emissors  char(15) - Emissor RG
    this_cSexos            = ""    && sexos     char(1) - Sexo (M/F)
    this_cEstcivils        = ""    && estcivils char(20) - Estado civil
    this_cNacionals        = ""    && nacionals char(15) - Nacionalidade
    this_cProfiss          = ""    && profiss   char(20) - Profissao
    this_cConjuges         = ""    && conjuges  char(40) - Nome do conjuge
    this_cPis              = ""    && pis       char(14) - PIS/PASEP
    this_cSuframas         = ""    && suframas  char(15) - Suframa
    this_cInscmuns         = ""    && inscmuns  char(20) - Inscricao municipal
    this_cMicroemps        = ""    && microemps char(1) - Micro empresa (S/N)
    this_cOptsimples       = ""    && optsimples char(1) - Optante simples (S/N)

    *-- Datas
    this_dNascs            = {}    && nascs     datetime - Data nascimento
    this_dDtcasas          = {}    && dtcasas   datetime - Data casamento
    this_dDtncons          = {}    && dtncons   datetime - Data aniversario conjuge
    this_dDataincs         = {}    && dataincs  datetime - Data inclusao
    this_dDtalts           = {}    && dtalts    datetime - Data alteracao
    this_dDatatrans        = {}    && datatrans datetime - Data transacao
    this_dUltcomps         = {}    && ultcomps  datetime - Ultima compra
    this_dDtfilms          = {}    && dtfilms   datetime - Data filme
    this_dDtfats           = {}    && dtfats    datetime - Data faturamento
    this_dDtmacums         = {}    && dtmacums  datetime - Data macro acumulado
    this_dDtadmis          = {}    && dtadmis   datetime - Data admissao trabalho
    this_dDtvals           = {}    && dtvals    datetime - Data validade
    this_dAutdtavld        = {}    && autdtavld datetime - Data validade LGPD
    this_dPenultcomp       = {}    && penultcomp datetime - Penultima compra
    this_dDataesp          = {}    && dataesp   datetime - Data especial

    *-- Datas parciais (dia/mes)
    this_cDmcasas          = ""    && dmcasas   char(4) - Dia/Mes casamento
    this_cDmconjs          = ""    && dmconjs   char(4) - Dia/Mes conjuge
    this_cDmnascs          = ""    && dmnascs   char(4) - Dia/Mes nascimento

    *-- Endereco residencial
    this_cEndes            = ""    && endes     char(60) - Endereco
    this_cNums             = ""    && nums      char(10) - Numero
    this_cCompls           = ""    && compls    char(50) - Complemento
    this_cBairs            = ""    && bairs     char(40) - Bairro
    this_cCidas            = ""    && cidas     char(30) - Cidade
    this_cEstas            = ""    && estas     char(2) - Estado (UF)
    this_cCeps             = ""    && ceps      char(9) - CEP
    this_cPaises           = ""    && paises    char(30) - Pais
    this_nNmuncips         = 0     && nmuncips  numeric(4,0) - Codigo IBGE municipio

    *-- Contatos
    this_cDdds             = ""    && ddds      char(4) - DDD telefone 1
    this_cTel1s            = ""    && tel1s     char(20) - Telefone 1
    this_cDdd2s            = ""    && ddd2s     char(4) - DDD telefone 2
    this_cTel2s            = ""    && tel2s     char(20) - Telefone 2
    this_cTel3s            = ""    && tel3s     char(20) - Telefone 3
    this_cFaxs             = ""    && faxs      char(20) - Fax
    this_cRamals           = ""    && ramals    char(4) - Ramal
    this_cEmails           = ""    && emails    char(50) - Email
    this_cContato          = ""    && contato   char(40) - Contato
    this_cContats          = ""    && contats   char(20) - Contatos adicionais
    this_cCtelems          = ""    && ctelems   char(3) - Celular DDD
    this_cObspagto         = ""    && obspagto  char(30) - Observacao pagamento
    this_nValemail         = 0     && valemail  numeric(1,0) - Validacao email

    *-- Empresa / Grupo / Comercial
    this_cEmps             = ""    && emps      char(3) - Codigo empresa
    this_cGrupos           = ""    && grupos    char(10) - Grupo do cliente
    this_cGrupovens        = ""    && grupovens char(10) - Grupo vendas
    this_cGrupomats        = ""    && grupomats char(10) - Grupo matrizes
    this_cGrupocobs        = ""    && grupocobs char(10) - Grupo cobran?as
    this_cGrupocents       = ""    && grupocents char(10) - Grupo centros
    this_cGruprods         = ""    && gruprods  char(10) - Grupo produtos
    this_cGrufals          = ""    && grufals   char(10) - Grupo falencia
    this_cContavens        = ""    && contavens char(10) - Conta vendas
    this_cContaven2s       = ""    && contaven2s char(10) - Conta vendas 2
    this_cContamats        = ""    && contamats char(10) - Conta matrizes
    this_cContacobs        = ""    && contacobs char(10) - Conta cobranca
    this_cContacents       = ""    && contacents char(10) - Conta centros
    this_cCcontabs         = ""    && ccontabs  char(10) - Conta contabil
    this_cConprods         = ""    && conprods  char(10) - Conta produtos
    this_cCodigos          = ""    && codigos   char(10) - Codigo auxiliar
    this_cHists            = ""    && hists     char(30) - Historico
    this_nTphists          = 0     && tphists   numeric(1,0) - Tipo historico
    this_cRegiaos          = ""    && regiaos   char(10) - Regiao
    this_cSituas           = ""    && situas    char(3) - Situacao
    this_cCodegs           = ""    && codsegs   char(10) - Codigo segmento
    this_cFpags            = ""    && fpags     char(12) - Forma de pagamento
    this_cTabds            = ""    && tabds     char(10) - Tabela de desconto
    this_cTabd2s           = ""    && tabd2s    char(10) - Tabela desconto 2
    this_cLprecos          = ""    && lprecos   char(30) - Lista de precos
    this_cTransps          = ""    && transps   char(10) - Transportadora

    *-- Limites e valores comerciais
    this_nLimcres          = 0     && limcres   numeric(11,2) - Limite de credito
    this_nComis            = 0     && comis     numeric(5,2) - Comissao
    this_nJuros            = 0     && juros     numeric(5,2) - Juros
    this_nPercdescli       = 0     && percdescli numeric(5,2) - Percentual desconto
    this_nMacums           = 0     && macums    numeric(11,2) - Macro acumulado
    this_nMfats            = 0     && mfats     numeric(11,2) - Media faturamento
    this_nVultcomps        = 0     && vultcomps numeric(11,2) - Valor ultima compra
    this_nMaxtransps       = 0     && maxtransps numeric(11,2) - Max transportadora
    this_nPrazoents        = 0     && prazoents numeric(3,0) - Prazo de entrega
    this_nDiasPEntrega     = 0     && DiasPEntrega numeric(3,0) - Dias para entrega

    *-- Flags de controle
    this_nTpcads           = 0     && tpcads    numeric(1,0) - Tipo cadastro
    this_nTpclis           = 0     && tpclis    numeric(1,0) - Tipo cliente
    this_cTpcps            = ""    && tpcps     char(2) - Tipo de CPF
    this_nInativas         = 0     && inativas  numeric(1,0) - Inativo
    this_nColetors         = 0     && coletors  numeric(1,0) - Cobrador
    this_nVcolets          = 0     && vcolets   numeric(3,0) - Valor cobran?a
    this_nConcilias        = 0     && concilias numeric(1,0) - Concilia
    this_nGerbals          = 0     && gerbals   numeric(1,0) - Gera balancete
    this_nPagfals          = 0     && pagfals   numeric(1,0) - Pagamento falencia
    this_nRecfals          = 0     && recfals   numeric(1,0) - Recebe falencia
    this_nIntconts         = 0     && intconts  numeric(1,0) - Integra contas
    this_nVinculas         = 0     && vinculas  numeric(1,0) - Vincula
    this_nConsigs          = 0     && consigs   numeric(1,0) - Consignacao
    this_nConsignas        = 0     && consignas numeric(1,0) - Consignado
    this_nMsgpends         = 0     && msgpends  numeric(1,0) - Mensagem pendente
    this_nPatrietqs        = 0     && patrietqs numeric(1,0) - Patrimonial/ETQS
    this_nRestfors         = 0     && restfors  numeric(1,0) - Restricao fornecedor
    this_nComcargs         = 0     && comcargs  numeric(1,0) - Comercio exterior
    this_nMasters          = 0     && masters   numeric(1,0) - Master
    this_nLibtabcmvs       = 0     && libtabcmvs numeric(1,0) - Libera tabela CMV
    this_nAptos            = 0     && aptos     numeric(5,0) - Apontamentos
    this_nChkexcdre        = 0     && chkexcdre numeric(1,0) - Check excede RE
    this_nInvisivel        = 0     && invisivel numeric(1,0) - Invisivel

    *-- Dados LGPD / Autorizacoes
    this_nAutdados         = 0     && autdados  numeric(1,0) - Autoriza dados
    this_nAutemail         = 0     && autemail  numeric(1,0) - Autoriza email
    this_nAutsms           = 0     && autsms    numeric(1,0) - Autoriza SMS
    this_nAutwhats         = 0     && autwhats  numeric(1,0) - Autoriza WhatsApp
    this_nAutteleg         = 0     && autteleg  numeric(1,0) - Autoriza Telegram
    this_nCtaencrypt       = 0     && ctaencrypt numeric(1,0) - Criptografar conta
    this_cFiglgpds         = ""    && figlgpds  text - Figura LGPD

    *-- Biometria (dedos)
    this_nDdpolegar        = 0     && ddpolegar numeric(2,0) - Dedo polegar
    this_nDdindicado       = 0     && ddindicado numeric(2,0) - Dedo indicador
    this_nDdmedio          = 0     && ddmedio   numeric(2,0) - Dedo medio
    this_nDdanular         = 0     && ddanular  numeric(2,0) - Dedo anular
    this_nDdminimo         = 0     && ddminimo  numeric(2,0) - Dedo minimo

    *-- Valorizacao
    this_nVlrvaltransp     = 0     && vlrvaltransp numeric(12,2) - Valor val transporte
    this_nVlrvalref        = 0     && vlrvalref  numeric(12,2) - Valor val refeicao
    this_nVlrvalalim       = 0     && vlrvalalim numeric(12,2) - Valor val alimentacao
    this_nVlrplansaude     = 0     && vlrplansaude numeric(12,2) - Plano saude
    this_nVlrplandent      = 0     && vlrplandent numeric(12,2) - Plano dental

    *-- Endereco de cobranca
    this_cEndcobs          = ""    && endcobs   char(80) - Endereco cobranca
    this_cBaicobs          = ""    && baicobs   char(20) - Bairro cobranca
    this_cCidcobs          = ""    && cidcobs   char(20) - Cidade cobranca
    this_cEstcobs          = ""    && estcobs   char(2) - Estado cobranca
    this_cCepcobs          = ""    && cepcobs   char(9) - CEP cobranca
    this_cPaicobs          = ""    && paicobs   char(30) - Pais cobranca
    this_cContacobs        = ""    && contacobs char(10) - Conta cobranca

    *-- Endereco trabalho
    this_cEndtrabs         = ""    && endtrabs  char(48) - Endereco trabalho
    this_cNumtrabs         = ""    && numtrabs  char(10) - Numero trabalho
    this_cCompltrabs       = ""    && compltrabs char(25) - Complemento trabalho
    this_cBairtrabs        = ""    && bairtrabs char(40) - Bairro trabalho
    this_cCidatrabs        = ""    && cidatrabs char(30) - Cidade trabalho
    this_cEstatrabs        = ""    && estatrabs char(2) - Estado trabalho
    this_cCeptrabs         = ""    && ceptrabs  char(9) - CEP trabalho
    this_cPaitrabs         = ""    && paitrabs  char(30) - Pais trabalho
    this_cEmptrabs         = ""    && emptrabs  char(50) - Empresa trabalho
    this_cCnpjtrabs        = ""    && cnpjtrabs char(20) - CNPJ empresa trabalho
    this_cTeltrabs         = ""    && teltrabs  char(20) - Telefone trabalho
    this_nSalarios         = 0     && salarios  numeric(11,2) - Salario
    this_nRendafams        = 0     && rendafams numeric(11,2) - Renda familiar
    this_cGrauparens       = ""    && grauparens char(30) - Grau parentesco

    *-- Enderecos alternativos (entrega/outro)
    this_cEndcos           = ""    && endcos    char(60) - Endereco alternativo
    this_cNomecos          = ""    && nomecos   char(50) - Nome alternativo
    this_cBaicos           = ""    && baicos    char(30) - Bairro alternativo
    this_cCidcos           = ""    && cidcos    char(30) - Cidade alternativa
    this_cEstcos           = ""    && estcos    char(2) - Estado alternativo
    this_cCepcos           = ""    && cepcos    char(9) - CEP alternativo
    this_nNumcos           = 0     && numcos    numeric(5,0) - Numero alternativo
    this_cComplcos         = ""    && complcos  char(25) - Complemento alternativo

    *-- Fiscal / Tributario
    this_cCfos             = ""    && cfos      char(10) - CFO
    this_cCodtifs          = ""    && codtifs   char(3) - Codigo TIF
    this_cFpubls           = ""    && fpubls    char(3) - Funcionario publico
    this_cCfgfiscos        = ""    && cfgfiscos char(50) - Config fiscal COS
    this_cCfgfiscss        = ""    && cfgfiscss char(50) - Config fiscal CSS
    this_cCfgfisics        = ""    && cfgfisics char(50) - Config fiscal ICS
    this_cCfgfisiis        = ""    && cfgfisiis char(50) - Config fiscal IIS
    this_cCfgfisins        = ""    && cfgfisins char(50) - Config fiscal INS
    this_cCfgfisips        = ""    && cfgfisips char(50) - Config fiscal IPS
    this_cCfgfisirs        = ""    && cfgfisirs char(50) - Config fiscal IRS
    this_cCfgfisiss        = ""    && cfgfisiss char(50) - Config fiscal ISS
    this_cCfgfispis        = ""    && cfgfispis char(50) - Config fiscal PIS
    this_cCcargs           = ""    && ccargs    char(10) - Cargo
    this_nEan13ents        = 0     && ean13ents numeric(13,0) - EAN13 entrega
    this_nEan13cobs        = 0     && ean13cobs numeric(13,0) - EAN13 cobranca

    *-- Vendedor / Pra?a
    this_cPracas           = ""    && pracas    char(40) - Praca de venda
    this_cCodvendedor      = ""    && codvendedor char(10) - Codigo vendedor

    *-- Auditoria / Sistema
    this_cUsuars           = ""    && usuars    char(10) - Usuario inclusao
    this_cUsualts          = ""    && usualts   char(10) - Usuario alteracao
    this_cUsuariocrm       = ""    && usuariocrm char(50) - Usuario CRM
    this_cSenhas           = ""    && senhas    char(10) - Senha
    this_cCcartoes         = ""    && ccartoes  char(60) - Cartoes

    *-- Memo / texto livre
    this_cObs              = ""    && obs       text - Observacoes
    this_cCobs             = ""    && cobs      char(250) - Observacoes cobranca
    this_cPerfils          = ""    && perfils   text - Perfil do cliente
    this_cPastas           = ""    && pastas    text - Pastas
    this_cFigjpgs          = ""    && figjpgs   text - Figura JPG (base64)

    *-- Pais / Mae
    this_cPais             = ""    && pais      char(50) - Nome do pais
    this_cMaes             = ""    && maes      char(50) - Nome da mae

    *===========================================================================
    PROCEDURE Init()
        LOCAL loc_nResult, loc_oErro
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCLI"
        THIS.this_cCampoChave = "iclis"

        *-- Popular crSigCdPam com GrPadClis (grupo padrao de clientes).
        *-- FormCliente.InicializarForm depende deste cursor para determinar
        *-- o grupo default quando o form abre sem par_cGrupo (menu principal).
        *-- Sem esse cursor, form mostra "Grupo Padrao Nao Configurado" e abre em branco.
        *-- Padrao canonico: Formsigatcrp.prg:1253-1281.
        TRY
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT GrPadClis FROM SigCdPam", "cursor_4c_Pam_Temp")
                IF loc_nResult > 0
                    SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE
                    IF USED("cursor_4c_Pam_Temp")
                        USE IN cursor_4c_Pam_Temp
                    ENDIF
                    IF RECCOUNT("crSigCdPam") > 0
                        SELECT crSigCdPam
                        GO TOP
                    ENDIF
                ELSE
                    *-- Fallback: cursor vazio para nao quebrar checagens downstream
                    CREATE CURSOR crSigCdPam (GrPadClis C(10))
                    APPEND BLANK
                ENDIF
            ELSE
                *-- Modo teste (gnConnHandle nao inicializado)
                CREATE CURSOR crSigCdPam (GrPadClis C(10))
                APPEND BLANK
            ENDIF
        CATCH TO loc_oErro
            IF !USED("crSigCdPam")
                CREATE CURSOR crSigCdPam (GrPadClis C(10))
                APPEND BLANK
            ENDIF
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIclis
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cIclis))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do cliente obrigat" + CHR(243) + "rio."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cRclis))
            THIS.this_cMensagemErro = "Nome / Raz" + CHR(227) + "o Social obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor VFP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                *-- Identificacao
                THIS.this_cIclis         = TratarNulo(iclis, "C")
                THIS.this_nNclis         = TratarNulo(nclis, "N")
                THIS.this_nIdcontas      = TratarNulo(idcontas, "N")
                THIS.this_nIdconta       = TratarNulo(idconta, "N")
                *-- Dados cadastrais
                THIS.this_cRclis         = TratarNulo(rclis, "C")
                THIS.this_cRazaos        = TratarNulo(razaos, "C")
                THIS.this_cNomearts      = TratarNulo(nomearts, "C")
                THIS.this_cCpfs          = TratarNulo(cpfs, "C")
                THIS.this_cCpfcs         = TratarNulo(cpfcs, "C")
                THIS.this_cRgs           = TratarNulo(rgs, "C")
                THIS.this_cRgconjuges    = TratarNulo(rgconjuges, "C")
                THIS.this_cRgcs          = TratarNulo(rgcs, "C")
                THIS.this_cEmissors      = TratarNulo(emissors, "C")
                THIS.this_cSexos         = TratarNulo(sexos, "C")
                THIS.this_cEstcivils     = TratarNulo(estcivils, "C")
                THIS.this_cNacionals     = TratarNulo(nacionals, "C")
                THIS.this_cProfiss       = TratarNulo(profiss, "C")
                THIS.this_cConjuges      = TratarNulo(conjuges, "C")
                THIS.this_cPis           = TratarNulo(pis, "C")
                THIS.this_cSuframas      = TratarNulo(suframas, "C")
                THIS.this_cInscmuns      = TratarNulo(inscmuns, "C")
                THIS.this_cMicroemps     = TratarNulo(microemps, "C")
                THIS.this_cOptsimples    = TratarNulo(optsimples, "C")
                *-- Datas
                THIS.this_dNascs         = TratarNulo(nascs, "D")
                THIS.this_dDtcasas       = TratarNulo(dtcasas, "D")
                THIS.this_dDtncons       = TratarNulo(dtncons, "D")
                THIS.this_dDataincs      = TratarNulo(dataincs, "D")
                THIS.this_dDtalts        = TratarNulo(dtalts, "D")
                THIS.this_dDatatrans     = TratarNulo(datatrans, "D")
                THIS.this_dUltcomps      = TratarNulo(ultcomps, "D")
                THIS.this_dDtfilms       = TratarNulo(dtfilms, "D")
                THIS.this_dDtfats        = TratarNulo(dtfats, "D")
                THIS.this_dDtmacums      = TratarNulo(dtmacums, "D")
                THIS.this_dDtadmis       = TratarNulo(dtadmis, "D")
                THIS.this_dDtvals        = TratarNulo(dtvals, "D")
                THIS.this_dAutdtavld     = TratarNulo(autdtavld, "D")
                THIS.this_dPenultcomp    = TratarNulo(penultcomp, "D")
                THIS.this_dDataesp       = TratarNulo(dataesp, "D")
                *-- Datas parciais dia/mes
                THIS.this_cDmcasas       = TratarNulo(dmcasas, "C")
                THIS.this_cDmconjs       = TratarNulo(dmconjs, "C")
                THIS.this_cDmnascs       = TratarNulo(dmnascs, "C")
                *-- Endereco residencial
                THIS.this_cEndes         = TratarNulo(endes, "C")
                THIS.this_cNums          = TratarNulo(nums, "C")
                THIS.this_cCompls        = TratarNulo(compls, "C")
                THIS.this_cBairs         = TratarNulo(bairs, "C")
                THIS.this_cCidas         = TratarNulo(cidas, "C")
                THIS.this_cEstas         = TratarNulo(estas, "C")
                THIS.this_cCeps          = TratarNulo(ceps, "C")
                THIS.this_cPaises        = TratarNulo(paises, "C")
                THIS.this_nNmuncips      = TratarNulo(nmuncips, "N")
                *-- Contatos
                THIS.this_cDdds          = TratarNulo(ddds, "C")
                THIS.this_cTel1s         = TratarNulo(tel1s, "C")
                THIS.this_cDdd2s         = TratarNulo(ddd2s, "C")
                THIS.this_cTel2s         = TratarNulo(tel2s, "C")
                THIS.this_cTel3s         = TratarNulo(tel3s, "C")
                THIS.this_cFaxs          = TratarNulo(faxs, "C")
                THIS.this_cRamals        = TratarNulo(ramals, "C")
                THIS.this_cEmails        = TratarNulo(emails, "C")
                THIS.this_cContato       = TratarNulo(contato, "C")
                THIS.this_cContats       = TratarNulo(contats, "C")
                THIS.this_cCtelems       = TratarNulo(ctelems, "C")
                THIS.this_cObspagto      = TratarNulo(obspagto, "C")
                THIS.this_nValemail      = TratarNulo(valemail, "N")
                *-- Empresa / Grupo / Comercial
                THIS.this_cEmps          = TratarNulo(emps, "C")
                THIS.this_cGrupos        = TratarNulo(grupos, "C")
                THIS.this_cGrupovens     = TratarNulo(grupovens, "C")
                THIS.this_cGrupomats     = TratarNulo(grupomats, "C")
                THIS.this_cGrupocobs     = TratarNulo(grupocobs, "C")
                THIS.this_cGrupocents    = TratarNulo(grupocents, "C")
                THIS.this_cGruprods      = TratarNulo(gruprods, "C")
                THIS.this_cGrufals       = TratarNulo(grufals, "C")
                THIS.this_cContavens     = TratarNulo(contavens, "C")
                THIS.this_cContaven2s    = TratarNulo(contaven2s, "C")
                THIS.this_cContamats     = TratarNulo(contamats, "C")
                THIS.this_cContacobs     = TratarNulo(contacobs, "C")
                THIS.this_cContacents    = TratarNulo(contacents, "C")
                THIS.this_cCcontabs      = TratarNulo(ccontabs, "C")
                THIS.this_cConprods      = TratarNulo(conprods, "C")
                THIS.this_cCodigos       = TratarNulo(codigos, "C")
                THIS.this_cHists         = TratarNulo(hists, "C")
                THIS.this_nTphists       = TratarNulo(tphists, "N")
                THIS.this_cRegiaos       = TratarNulo(regiaos, "C")
                THIS.this_cSituas        = TratarNulo(situas, "C")
                THIS.this_cCodegs        = TratarNulo(codsegs, "C")
                THIS.this_cFpags         = TratarNulo(fpags, "C")
                THIS.this_cTabds         = TratarNulo(tabds, "C")
                THIS.this_cTabd2s        = TratarNulo(tabd2s, "C")
                THIS.this_cLprecos       = TratarNulo(lprecos, "C")
                THIS.this_cTransps       = TratarNulo(transps, "C")
                *-- Limites e valores comerciais
                THIS.this_nLimcres       = TratarNulo(limcres, "N")
                THIS.this_nComis         = TratarNulo(comis, "N")
                THIS.this_nJuros         = TratarNulo(juros, "N")
                THIS.this_nPercdescli    = TratarNulo(percdescli, "N")
                THIS.this_nMacums        = TratarNulo(macums, "N")
                THIS.this_nMfats         = TratarNulo(mfats, "N")
                THIS.this_nVultcomps     = TratarNulo(vultcomps, "N")
                THIS.this_nMaxtransps    = TratarNulo(maxtransps, "N")
                THIS.this_nPrazoents     = TratarNulo(prazoents, "N")
                THIS.this_nDiasPEntrega  = TratarNulo(DiasPEntrega, "N")
                *-- Flags de controle
                THIS.this_nTpcads        = TratarNulo(tpcads, "N")
                THIS.this_nTpclis        = TratarNulo(tpclis, "N")
                THIS.this_cTpcps         = TratarNulo(tpcps, "C")
                THIS.this_nInativas      = TratarNulo(inativas, "N")
                THIS.this_nColetors      = TratarNulo(coletors, "N")
                THIS.this_nVcolets       = TratarNulo(vcolets, "N")
                THIS.this_nConcilias     = TratarNulo(concilias, "N")
                THIS.this_nGerbals       = TratarNulo(gerbals, "N")
                THIS.this_nPagfals       = TratarNulo(pagfals, "N")
                THIS.this_nRecfals       = TratarNulo(recfals, "N")
                THIS.this_nIntconts      = TratarNulo(intconts, "N")
                THIS.this_nVinculas      = TratarNulo(vinculas, "N")
                THIS.this_nConsigs       = TratarNulo(consigs, "N")
                THIS.this_nConsignas     = TratarNulo(consignas, "N")
                THIS.this_nMsgpends      = TratarNulo(msgpends, "N")
                THIS.this_nPatrietqs     = TratarNulo(patrietqs, "N")
                THIS.this_nRestfors      = TratarNulo(restfors, "N")
                THIS.this_nComcargs      = TratarNulo(comcargs, "N")
                THIS.this_nMasters       = TratarNulo(masters, "N")
                THIS.this_nLibtabcmvs    = TratarNulo(libtabcmvs, "N")
                THIS.this_nAptos         = TratarNulo(aptos, "N")
                THIS.this_nChkexcdre     = TratarNulo(chkexcdre, "N")
                THIS.this_nInvisivel     = TratarNulo(invisivel, "N")
                *-- LGPD / Autorizacoes
                THIS.this_nAutdados      = TratarNulo(autdados, "N")
                THIS.this_nAutemail      = TratarNulo(autemail, "N")
                THIS.this_nAutsms        = TratarNulo(autsms, "N")
                THIS.this_nAutwhats      = TratarNulo(autwhats, "N")
                THIS.this_nAutteleg      = TratarNulo(autteleg, "N")
                THIS.this_nCtaencrypt    = TratarNulo(ctaencrypt, "N")
                *-- Biometria
                THIS.this_nDdpolegar     = TratarNulo(ddpolegar, "N")
                THIS.this_nDdindicado    = TratarNulo(ddindicado, "N")
                THIS.this_nDdmedio       = TratarNulo(ddmedio, "N")
                THIS.this_nDdanular      = TratarNulo(ddanular, "N")
                THIS.this_nDdminimo      = TratarNulo(ddminimo, "N")
                *-- Valorizacao
                THIS.this_nVlrvaltransp  = TratarNulo(vlrvaltransp, "N")
                THIS.this_nVlrvalref     = TratarNulo(vlrvalref, "N")
                THIS.this_nVlrvalalim    = TratarNulo(vlrvalalim, "N")
                THIS.this_nVlrplansaude  = TratarNulo(vlrplansaude, "N")
                THIS.this_nVlrplandent   = TratarNulo(vlrplandent, "N")
                *-- Endereco cobranca
                THIS.this_cEndcobs       = TratarNulo(endcobs, "C")
                THIS.this_cBaicobs       = TratarNulo(baicobs, "C")
                THIS.this_cCidcobs       = TratarNulo(cidcobs, "C")
                THIS.this_cEstcobs       = TratarNulo(estcobs, "C")
                THIS.this_cCepcobs       = TratarNulo(cepcobs, "C")
                THIS.this_cPaicobs       = TratarNulo(paicobs, "C")
                *-- Endereco trabalho
                THIS.this_cEndtrabs      = TratarNulo(endtrabs, "C")
                THIS.this_cNumtrabs      = TratarNulo(numtrabs, "C")
                THIS.this_cCompltrabs    = TratarNulo(compltrabs, "C")
                THIS.this_cBairtrabs     = TratarNulo(bairtrabs, "C")
                THIS.this_cCidatrabs     = TratarNulo(cidatrabs, "C")
                THIS.this_cEstatrabs     = TratarNulo(estatrabs, "C")
                THIS.this_cCeptrabs      = TratarNulo(ceptrabs, "C")
                THIS.this_cPaitrabs      = TratarNulo(paitrabs, "C")
                THIS.this_cEmptrabs      = TratarNulo(emptrabs, "C")
                THIS.this_cCnpjtrabs     = TratarNulo(cnpjtrabs, "C")
                THIS.this_cTeltrabs      = TratarNulo(teltrabs, "C")
                THIS.this_nSalarios      = TratarNulo(salarios, "N")
                THIS.this_nRendafams     = TratarNulo(rendafams, "N")
                THIS.this_cGrauparens    = TratarNulo(grauparens, "C")
                *-- Enderecos alternativos
                THIS.this_cEndcos        = TratarNulo(endcos, "C")
                THIS.this_cNomecos       = TratarNulo(nomecos, "C")
                THIS.this_cBaicos        = TratarNulo(baicos, "C")
                THIS.this_cCidcos        = TratarNulo(cidcos, "C")
                THIS.this_cEstcos        = TratarNulo(estcos, "C")
                THIS.this_cCepcos        = TratarNulo(cepcos, "C")
                THIS.this_cComplcos      = TratarNulo(complcos, "C")
                THIS.this_nNumcos        = TratarNulo(numcos, "N")
                *-- Fiscal / Tributario
                THIS.this_cCfos          = TratarNulo(cfos, "C")
                THIS.this_cCodtifs       = TratarNulo(codtifs, "C")
                THIS.this_cFpubls        = TratarNulo(fpubls, "C")
                THIS.this_cCfgfiscos     = TratarNulo(cfgfiscos, "C")
                THIS.this_cCfgfiscss     = TratarNulo(cfgfiscss, "C")
                THIS.this_cCfgfisics     = TratarNulo(cfgfisics, "C")
                THIS.this_cCfgfisiis     = TratarNulo(cfgfisiis, "C")
                THIS.this_cCfgfisins     = TratarNulo(cfgfisins, "C")
                THIS.this_cCfgfisips     = TratarNulo(cfgfisips, "C")
                THIS.this_cCfgfisirs     = TratarNulo(cfgfisirs, "C")
                THIS.this_cCfgfisiss     = TratarNulo(cfgfisiss, "C")
                THIS.this_cCfgfispis     = TratarNulo(cfgfispis, "C")
                THIS.this_cCcargs        = TratarNulo(ccargs, "C")
                THIS.this_nEan13ents     = TratarNulo(ean13ents, "N")
                THIS.this_nEan13cobs     = TratarNulo(ean13cobs, "N")
                *-- Vendedor / Praca
                THIS.this_cPracas        = TratarNulo(pracas, "C")
                THIS.this_cCodvendedor   = TratarNulo(codvendedor, "C")
                *-- Auditoria / Sistema
                THIS.this_cUsuars        = TratarNulo(usuars, "C")
                THIS.this_cUsualts       = TratarNulo(usualts, "C")
                THIS.this_cUsuariocrm    = TratarNulo(usuariocrm, "C")
                THIS.this_cSenhas        = TratarNulo(senhas, "C")
                THIS.this_cCcartoes      = TratarNulo(ccartoes, "C")
                THIS.this_cCobs          = TratarNulo(cobs, "C")
                THIS.this_cPais          = TratarNulo(pais, "C")
                THIS.this_cMaes          = TratarNulo(maes, "C")
                *-- Memo / texto livre (nullable - verificar existencia no cursor)
                IF TYPE("obs") != "U"
                    THIS.this_cObs       = TratarNulo(obs, "C")
                ENDIF
                IF TYPE("perfils") != "U"
                    THIS.this_cPerfils   = TratarNulo(perfils, "C")
                ENDIF
                IF TYPE("pastas") != "U"
                    THIS.this_cPastas    = TratarNulo(pastas, "C")
                ENDIF
                IF TYPE("figjpgs") != "U"
                    THIS.this_cFigjpgs   = TratarNulo(figjpgs, "C")
                ENDIF
                IF TYPE("figlgpds") != "U"
                    THIS.this_cFiglgpds  = TratarNulo(figlgpds, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SIGCDCLI com todos os campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cVals, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Bloco de valores
            loc_cVals = ;
                EscaparSQL(THIS.this_cIclis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIdcontas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIdconta, 0) + ", " + ;
                EscaparSQL(THIS.this_cRclis) + ", " + ;
                EscaparSQL(THIS.this_cRazaos) + ", " + ;
                EscaparSQL(THIS.this_cNomearts) + ", " + ;
                EscaparSQL(THIS.this_cCpfs) + ", " + ;
                EscaparSQL(THIS.this_cCpfcs) + ", " + ;
                EscaparSQL(THIS.this_cRgs) + ", " + ;
                EscaparSQL(THIS.this_cRgconjuges) + ", " + ;
                EscaparSQL(THIS.this_cRgcs) + ", " + ;
                EscaparSQL(THIS.this_cEmissors) + ", " + ;
                EscaparSQL(THIS.this_cSexos) + ", " + ;
                EscaparSQL(THIS.this_cEstcivils) + ", " + ;
                EscaparSQL(THIS.this_cNacionals) + ", " + ;
                EscaparSQL(THIS.this_cProfiss) + ", " + ;
                EscaparSQL(THIS.this_cConjuges) + ", " + ;
                EscaparSQL(THIS.this_cPis) + ", " + ;
                EscaparSQL(THIS.this_cSuframas) + ", " + ;
                EscaparSQL(THIS.this_cInscmuns) + ", " + ;
                EscaparSQL(THIS.this_cMicroemps) + ", " + ;
                EscaparSQL(THIS.this_cOptsimples) + ", " + ;
                FormatarDataSQL(THIS.this_dNascs) + ", " + ;
                FormatarDataSQL(THIS.this_dDtcasas) + ", " + ;
                FormatarDataSQL(THIS.this_dDtncons) + ", " + ;
                FormatarDataSQL(THIS.this_dDataincs) + ", " + ;
                FormatarDataSQL(THIS.this_dDtalts) + ", " + ;
                FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                FormatarDataSQL(THIS.this_dUltcomps) + ", " + ;
                FormatarDataSQL(THIS.this_dDtfilms) + ", " + ;
                FormatarDataSQL(THIS.this_dDtfats) + ", " + ;
                FormatarDataSQL(THIS.this_dDtmacums) + ", " + ;
                FormatarDataSQL(THIS.this_dDtadmis) + ", " + ;
                FormatarDataSQL(THIS.this_dDtvals) + ", " + ;
                FormatarDataSQL(THIS.this_dAutdtavld) + ", " + ;
                FormatarDataSQL(THIS.this_dPenultcomp) + ", " + ;
                FormatarDataSQL(THIS.this_dDataesp) + ", " + ;
                EscaparSQL(THIS.this_cDmcasas) + ", " + ;
                EscaparSQL(THIS.this_cDmconjs) + ", " + ;
                EscaparSQL(THIS.this_cDmnascs) + ", " + ;
                EscaparSQL(THIS.this_cEndes) + ", " + ;
                EscaparSQL(THIS.this_cNums) + ", " + ;
                EscaparSQL(THIS.this_cCompls) + ", " + ;
                EscaparSQL(THIS.this_cBairs) + ", " + ;
                EscaparSQL(THIS.this_cCidas) + ", " + ;
                EscaparSQL(THIS.this_cEstas) + ", " + ;
                EscaparSQL(THIS.this_cCeps) + ", " + ;
                EscaparSQL(THIS.this_cPaises) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNmuncips, 0)

            loc_cVals = loc_cVals + ", " + ;
                EscaparSQL(THIS.this_cDdds) + ", " + ;
                EscaparSQL(THIS.this_cTel1s) + ", " + ;
                EscaparSQL(THIS.this_cDdd2s) + ", " + ;
                EscaparSQL(THIS.this_cTel2s) + ", " + ;
                EscaparSQL(THIS.this_cTel3s) + ", " + ;
                EscaparSQL(THIS.this_cFaxs) + ", " + ;
                EscaparSQL(THIS.this_cRamals) + ", " + ;
                EscaparSQL(THIS.this_cEmails) + ", " + ;
                EscaparSQL(THIS.this_cContato) + ", " + ;
                EscaparSQL(THIS.this_cContats) + ", " + ;
                EscaparSQL(THIS.this_cCtelems) + ", " + ;
                EscaparSQL(THIS.this_cObspagto) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValemail, 0) + ", " + ;
                EscaparSQL(THIS.this_cEmps) + ", " + ;
                EscaparSQL(THIS.this_cGrupos) + ", " + ;
                EscaparSQL(THIS.this_cGrupovens) + ", " + ;
                EscaparSQL(THIS.this_cGrupomats) + ", " + ;
                EscaparSQL(THIS.this_cGrupocobs) + ", " + ;
                EscaparSQL(THIS.this_cGrupocents) + ", " + ;
                EscaparSQL(THIS.this_cGruprods) + ", " + ;
                EscaparSQL(THIS.this_cGrufals) + ", " + ;
                EscaparSQL(THIS.this_cContavens) + ", " + ;
                EscaparSQL(THIS.this_cContaven2s) + ", " + ;
                EscaparSQL(THIS.this_cContamats) + ", " + ;
                EscaparSQL(THIS.this_cContacobs) + ", " + ;
                EscaparSQL(THIS.this_cContacents) + ", " + ;
                EscaparSQL(THIS.this_cCcontabs) + ", " + ;
                EscaparSQL(THIS.this_cConprods) + ", " + ;
                EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cHists) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTphists, 0) + ", " + ;
                EscaparSQL(THIS.this_cRegiaos) + ", " + ;
                EscaparSQL(THIS.this_cSituas) + ", " + ;
                EscaparSQL(THIS.this_cCodegs) + ", " + ;
                EscaparSQL(THIS.this_cFpags) + ", " + ;
                EscaparSQL(THIS.this_cTabds) + ", " + ;
                EscaparSQL(THIS.this_cTabd2s) + ", " + ;
                EscaparSQL(THIS.this_cLprecos) + ", " + ;
                EscaparSQL(THIS.this_cTransps) + ", " + ;
                FormatarNumeroSQL(THIS.this_nLimcres, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nComis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nJuros, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPercdescli, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMacums, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMfats, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVultcomps, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMaxtransps, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPrazoents, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDiasPEntrega, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpcads, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpclis, 0) + ", " + ;
                EscaparSQL(THIS.this_cTpcps)

            loc_cVals = loc_cVals + ", " + ;
                FormatarNumeroSQL(THIS.this_nInativas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nColetors, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVcolets, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConcilias, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nGerbals, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPagfals, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRecfals, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntconts, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVinculas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConsigs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConsignas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMsgpends, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPatrietqs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRestfors, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nComcargs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMasters, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nLibtabcmvs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAptos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkexcdre, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInvisivel, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutdados, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutemail, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutsms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutwhats, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutteleg, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtaencrypt, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdpolegar, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdindicado, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdmedio, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdanular, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdminimo, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrvaltransp, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrvalref, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrvalalim, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrplansaude, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrplandent, 2) + ", " + ;
                EscaparSQL(THIS.this_cEndcobs) + ", " + ;
                EscaparSQL(THIS.this_cBaicobs) + ", " + ;
                EscaparSQL(THIS.this_cCidcobs) + ", " + ;
                EscaparSQL(THIS.this_cEstcobs) + ", " + ;
                EscaparSQL(THIS.this_cCepcobs) + ", " + ;
                EscaparSQL(THIS.this_cPaicobs) + ", " + ;
                EscaparSQL(THIS.this_cEndtrabs) + ", " + ;
                EscaparSQL(THIS.this_cNumtrabs) + ", " + ;
                EscaparSQL(THIS.this_cCompltrabs) + ", " + ;
                EscaparSQL(THIS.this_cBairtrabs) + ", " + ;
                EscaparSQL(THIS.this_cCidatrabs) + ", " + ;
                EscaparSQL(THIS.this_cEstatrabs) + ", " + ;
                EscaparSQL(THIS.this_cEstatrabs) + ", " + ;
                EscaparSQL(THIS.this_cCeptrabs) + ", " + ;
                EscaparSQL(THIS.this_cPaitrabs) + ", " + ;
                EscaparSQL(THIS.this_cEmptrabs) + ", " + ;
                EscaparSQL(THIS.this_cCnpjtrabs) + ", " + ;
                EscaparSQL(THIS.this_cTeltrabs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSalarios, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRendafams, 2) + ", " + ;
                EscaparSQL(THIS.this_cGrauparens) + ", " + ;
                EscaparSQL(THIS.this_cEndcos) + ", " + ;
                EscaparSQL(THIS.this_cNomecos) + ", " + ;
                EscaparSQL(THIS.this_cBaicos) + ", " + ;
                EscaparSQL(THIS.this_cCidcos) + ", " + ;
                EscaparSQL(THIS.this_cEstcos) + ", " + ;
                EscaparSQL(THIS.this_cCepcos) + ", " + ;
                EscaparSQL(THIS.this_cComplcos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumcos, 0) + ", " + ;
                EscaparSQL(THIS.this_cCfos) + ", " + ;
                EscaparSQL(THIS.this_cCodtifs) + ", " + ;
                EscaparSQL(THIS.this_cFpubls) + ", " + ;
                EscaparSQL(THIS.this_cCfgfiscos) + ", " + ;
                EscaparSQL(THIS.this_cCfgfiscss) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisics) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisiis) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisins) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisips) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisirs) + ", " + ;
                EscaparSQL(THIS.this_cCfgfisiss) + ", " + ;
                EscaparSQL(THIS.this_cCfgfispis) + ", " + ;
                EscaparSQL(THIS.this_cCcargs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nEan13ents, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nEan13cobs, 0) + ", " + ;
                EscaparSQL(THIS.this_cPracas) + ", " + ;
                EscaparSQL(THIS.this_cCodvendedor) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                EscaparSQL(THIS.this_cUsuariocrm) + ", " + ;
                EscaparSQL(THIS.this_cSenhas) + ", " + ;
                EscaparSQL(THIS.this_cCcartoes) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCobs, 250)) + ", " + ;
                EscaparSQL(THIS.this_cPais) + ", " + ;
                EscaparSQL(THIS.this_cMaes) + ", " + ;
                IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs)) + ", " + ;
                IIF(EMPTY(THIS.this_cPerfils), "NULL", EscaparSQL(THIS.this_cPerfils)) + ", " + ;
                IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                IIF(EMPTY(THIS.this_cFigjpgs), "NULL", EscaparSQL(THIS.this_cFigjpgs)) + ", " + ;
                IIF(EMPTY(THIS.this_cFiglgpds), "NULL", EscaparSQL(THIS.this_cFiglgpds)) + ", " + ;
                "NULL"

            loc_cSQL = "INSERT INTO SIGCDCLI (" + ;
                "iclis, nclis, idcontas, idconta, rclis, razaos, nomearts, cpfs, cpfcs, rgs, " + ;
                "rgconjuges, rgcs, emissors, sexos, estcivils, nacionals, profiss, conjuges, pis, suframas, " + ;
                "inscmuns, microemps, optsimples, nascs, dtcasas, dtncons, dataincs, dtalts, datatrans, " + ;
                "ultcomps, dtfilms, dtfats, dtmacums, dtadmis, dtvals, autdtavld, penultcomp, dataesp, " + ;
                "dmcasas, dmconjs, dmnascs, endes, nums, compls, bairs, cidas, estas, ceps, paises, nmuncips, " + ;
                "ddds, tel1s, ddd2s, tel2s, tel3s, faxs, ramals, emails, contato, contats, ctelems, obspagto, " + ;
                "valemail, emps, grupos, grupovens, grupomats, grupocobs, grupocents, gruprods, grufals, " + ;
                "contavens, contaven2s, contamats, contacobs, contacents, ccontabs, conprods, codigos, hists, " + ;
                "tphists, regiaos, situas, codsegs, fpags, tabds, tabd2s, lprecos, transps, limcres, comis, " + ;
                "juros, percdescli, macums, mfats, vultcomps, maxtransps, prazoents, DiasPEntrega, tpcads, " + ;
                "tpclis, tpcps, inativas, coletors, vcolets, concilias, gerbals, pagfals, recfals, intconts, " + ;
                "vinculas, consigs, consignas, msgpends, patrietqs, restfors, comcargs, masters, libtabcmvs, " + ;
                "aptos, chkexcdre, invisivel, autdados, autemail, autsms, autwhats, autteleg, ctaencrypt, " + ;
                "ddpolegar, ddindicado, ddmedio, ddanular, ddminimo, vlrvaltransp, vlrvalref, vlrvalalim, " + ;
                "vlrplansaude, vlrplandent, endcobs, baicobs, cidcobs, estcobs, cepcobs, paicobs, endtrabs, " + ;
                "numtrabs, compltrabs, bairtrabs, cidatrabs, estatrabs, esttrabs, ceptrabs, paitrabs, emptrabs, " + ;
                "cnpjtrabs, teltrabs, salarios, rendafams, grauparens, endcos, nomecos, baicos, cidcos, estcos, " + ;
                "cepcos, complcos, numcos, cfos, codtifs, fpubls, cfgfiscos, cfgfiscss, cfgfisics, cfgfisiis, " + ;
                "cfgfisins, cfgfisips, cfgfisirs, cfgfisiss, cfgfispis, ccargs, ean13ents, ean13cobs, pracas, " + ;
                "codvendedor, usuars, usualts, usuariocrm, senhas, ccartoes, cobs, pais, maes, " + ;
                "obs, perfils, pastas, figjpgs, figlgpds, figuras" + ;
                ") VALUES (" + loc_cVals + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cUsuars = gc_4c_UsuarioLogado
                THIS.this_dDataincs = DATETIME()
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir cliente no banco de dados."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SIGCDCLI com todos os campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SIGCDCLI SET " + ;
                "rclis = " + EscaparSQL(THIS.this_cRclis) + ", " + ;
                "razaos = " + EscaparSQL(THIS.this_cRazaos) + ", " + ;
                "nomearts = " + EscaparSQL(THIS.this_cNomearts) + ", " + ;
                "cpfs = " + EscaparSQL(THIS.this_cCpfs) + ", " + ;
                "cpfcs = " + EscaparSQL(THIS.this_cCpfcs) + ", " + ;
                "rgs = " + EscaparSQL(THIS.this_cRgs) + ", " + ;
                "rgconjuges = " + EscaparSQL(THIS.this_cRgconjuges) + ", " + ;
                "rgcs = " + EscaparSQL(THIS.this_cRgcs) + ", " + ;
                "emissors = " + EscaparSQL(THIS.this_cEmissors) + ", " + ;
                "sexos = " + EscaparSQL(THIS.this_cSexos) + ", " + ;
                "estcivils = " + EscaparSQL(THIS.this_cEstcivils) + ", " + ;
                "nacionals = " + EscaparSQL(THIS.this_cNacionals) + ", " + ;
                "profiss = " + EscaparSQL(THIS.this_cProfiss) + ", " + ;
                "conjuges = " + EscaparSQL(THIS.this_cConjuges) + ", " + ;
                "pis = " + EscaparSQL(THIS.this_cPis) + ", " + ;
                "suframas = " + EscaparSQL(THIS.this_cSuframas) + ", " + ;
                "inscmuns = " + EscaparSQL(THIS.this_cInscmuns) + ", " + ;
                "microemps = " + EscaparSQL(THIS.this_cMicroemps) + ", " + ;
                "optsimples = " + EscaparSQL(THIS.this_cOptsimples) + ", " + ;
                "nascs = " + FormatarDataSQL(THIS.this_dNascs) + ", " + ;
                "dtcasas = " + FormatarDataSQL(THIS.this_dDtcasas) + ", " + ;
                "dtncons = " + FormatarDataSQL(THIS.this_dDtncons) + ", " + ;
                "dataincs = " + FormatarDataSQL(THIS.this_dDataincs) + ", " + ;
                "dtalts = " + "GETDATE()" + ", " + ;
                "datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                "ultcomps = " + FormatarDataSQL(THIS.this_dUltcomps) + ", " + ;
                "dtfilms = " + FormatarDataSQL(THIS.this_dDtfilms) + ", " + ;
                "dtfats = " + FormatarDataSQL(THIS.this_dDtfats) + ", " + ;
                "dtmacums = " + FormatarDataSQL(THIS.this_dDtmacums) + ", " + ;
                "dtadmis = " + FormatarDataSQL(THIS.this_dDtadmis) + ", " + ;
                "dtvals = " + FormatarDataSQL(THIS.this_dDtvals) + ", " + ;
                "autdtavld = " + FormatarDataSQL(THIS.this_dAutdtavld) + ", " + ;
                "penultcomp = " + FormatarDataSQL(THIS.this_dPenultcomp) + ", " + ;
                "dataesp = " + FormatarDataSQL(THIS.this_dDataesp) + ", " + ;
                "dmcasas = " + EscaparSQL(THIS.this_cDmcasas) + ", " + ;
                "dmconjs = " + EscaparSQL(THIS.this_cDmconjs) + ", " + ;
                "dmnascs = " + EscaparSQL(THIS.this_cDmnascs) + ", " + ;
                "endes = " + EscaparSQL(THIS.this_cEndes) + ", " + ;
                "nums = " + EscaparSQL(THIS.this_cNums) + ", " + ;
                "compls = " + EscaparSQL(THIS.this_cCompls) + ", " + ;
                "bairs = " + EscaparSQL(THIS.this_cBairs) + ", " + ;
                "cidas = " + EscaparSQL(THIS.this_cCidas) + ", " + ;
                "estas = " + EscaparSQL(THIS.this_cEstas) + ", " + ;
                "ceps = " + EscaparSQL(THIS.this_cCeps) + ", " + ;
                "paises = " + EscaparSQL(THIS.this_cPaises) + ", " + ;
                "nmuncips = " + FormatarNumeroSQL(THIS.this_nNmuncips, 0) + ", " + ;
                "ddds = " + EscaparSQL(THIS.this_cDdds) + ", " + ;
                "tel1s = " + EscaparSQL(THIS.this_cTel1s) + ", " + ;
                "ddd2s = " + EscaparSQL(THIS.this_cDdd2s) + ", " + ;
                "tel2s = " + EscaparSQL(THIS.this_cTel2s) + ", "

            loc_cSQL = loc_cSQL + ;
                "tel3s = " + EscaparSQL(THIS.this_cTel3s) + ", " + ;
                "faxs = " + EscaparSQL(THIS.this_cFaxs) + ", " + ;
                "ramals = " + EscaparSQL(THIS.this_cRamals) + ", " + ;
                "emails = " + EscaparSQL(THIS.this_cEmails) + ", " + ;
                "contato = " + EscaparSQL(THIS.this_cContato) + ", " + ;
                "contats = " + EscaparSQL(THIS.this_cContats) + ", " + ;
                "ctelems = " + EscaparSQL(THIS.this_cCtelems) + ", " + ;
                "obspagto = " + EscaparSQL(THIS.this_cObspagto) + ", " + ;
                "valemail = " + FormatarNumeroSQL(THIS.this_nValemail, 0) + ", " + ;
                "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                "grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
                "grupovens = " + EscaparSQL(THIS.this_cGrupovens) + ", " + ;
                "grupomats = " + EscaparSQL(THIS.this_cGrupomats) + ", " + ;
                "grupocobs = " + EscaparSQL(THIS.this_cGrupocobs) + ", " + ;
                "grupocents = " + EscaparSQL(THIS.this_cGrupocents) + ", " + ;
                "gruprods = " + EscaparSQL(THIS.this_cGruprods) + ", " + ;
                "grufals = " + EscaparSQL(THIS.this_cGrufals) + ", " + ;
                "contavens = " + EscaparSQL(THIS.this_cContavens) + ", " + ;
                "contaven2s = " + EscaparSQL(THIS.this_cContaven2s) + ", " + ;
                "contamats = " + EscaparSQL(THIS.this_cContamats) + ", " + ;
                "contacobs = " + EscaparSQL(THIS.this_cContacobs) + ", " + ;
                "contacents = " + EscaparSQL(THIS.this_cContacents) + ", " + ;
                "ccontabs = " + EscaparSQL(THIS.this_cCcontabs) + ", " + ;
                "conprods = " + EscaparSQL(THIS.this_cConprods) + ", " + ;
                "codigos = " + EscaparSQL(THIS.this_cCodigos) + ", " + ;
                "hists = " + EscaparSQL(THIS.this_cHists) + ", " + ;
                "tphists = " + FormatarNumeroSQL(THIS.this_nTphists, 0) + ", " + ;
                "regiaos = " + EscaparSQL(THIS.this_cRegiaos) + ", " + ;
                "situas = " + EscaparSQL(THIS.this_cSituas) + ", " + ;
                "codsegs = " + EscaparSQL(THIS.this_cCodegs) + ", " + ;
                "fpags = " + EscaparSQL(THIS.this_cFpags) + ", " + ;
                "tabds = " + EscaparSQL(THIS.this_cTabds) + ", " + ;
                "tabd2s = " + EscaparSQL(THIS.this_cTabd2s) + ", " + ;
                "lprecos = " + EscaparSQL(THIS.this_cLprecos) + ", " + ;
                "transps = " + EscaparSQL(THIS.this_cTransps) + ", " + ;
                "limcres = " + FormatarNumeroSQL(THIS.this_nLimcres, 2) + ", " + ;
                "comis = " + FormatarNumeroSQL(THIS.this_nComis, 2) + ", " + ;
                "juros = " + FormatarNumeroSQL(THIS.this_nJuros, 2) + ", " + ;
                "percdescli = " + FormatarNumeroSQL(THIS.this_nPercdescli, 2) + ", " + ;
                "macums = " + FormatarNumeroSQL(THIS.this_nMacums, 2) + ", " + ;
                "mfats = " + FormatarNumeroSQL(THIS.this_nMfats, 2) + ", " + ;
                "vultcomps = " + FormatarNumeroSQL(THIS.this_nVultcomps, 2) + ", " + ;
                "maxtransps = " + FormatarNumeroSQL(THIS.this_nMaxtransps, 2) + ", " + ;
                "prazoents = " + FormatarNumeroSQL(THIS.this_nPrazoents, 0) + ", " + ;
                "DiasPEntrega = " + FormatarNumeroSQL(THIS.this_nDiasPEntrega, 0) + ", " + ;
                "tpcads = " + FormatarNumeroSQL(THIS.this_nTpcads, 0) + ", " + ;
                "tpclis = " + FormatarNumeroSQL(THIS.this_nTpclis, 0) + ", " + ;
                "tpcps = " + EscaparSQL(THIS.this_cTpcps) + ", "

            loc_cSQL = loc_cSQL + ;
                "inativas = " + FormatarNumeroSQL(THIS.this_nInativas, 0) + ", " + ;
                "coletors = " + FormatarNumeroSQL(THIS.this_nColetors, 0) + ", " + ;
                "vcolets = " + FormatarNumeroSQL(THIS.this_nVcolets, 0) + ", " + ;
                "concilias = " + FormatarNumeroSQL(THIS.this_nConcilias, 0) + ", " + ;
                "gerbals = " + FormatarNumeroSQL(THIS.this_nGerbals, 0) + ", " + ;
                "pagfals = " + FormatarNumeroSQL(THIS.this_nPagfals, 0) + ", " + ;
                "recfals = " + FormatarNumeroSQL(THIS.this_nRecfals, 0) + ", " + ;
                "intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ", " + ;
                "vinculas = " + FormatarNumeroSQL(THIS.this_nVinculas, 0) + ", " + ;
                "consigs = " + FormatarNumeroSQL(THIS.this_nConsigs, 0) + ", " + ;
                "consignas = " + FormatarNumeroSQL(THIS.this_nConsignas, 0) + ", " + ;
                "msgpends = " + FormatarNumeroSQL(THIS.this_nMsgpends, 0) + ", " + ;
                "patrietqs = " + FormatarNumeroSQL(THIS.this_nPatrietqs, 0) + ", " + ;
                "restfors = " + FormatarNumeroSQL(THIS.this_nRestfors, 0) + ", " + ;
                "comcargs = " + FormatarNumeroSQL(THIS.this_nComcargs, 0) + ", " + ;
                "masters = " + FormatarNumeroSQL(THIS.this_nMasters, 0) + ", " + ;
                "libtabcmvs = " + FormatarNumeroSQL(THIS.this_nLibtabcmvs, 0) + ", " + ;
                "aptos = " + FormatarNumeroSQL(THIS.this_nAptos, 0) + ", " + ;
                "chkexcdre = " + FormatarNumeroSQL(THIS.this_nChkexcdre, 0) + ", " + ;
                "invisivel = " + FormatarNumeroSQL(THIS.this_nInvisivel, 0) + ", " + ;
                "autdados = " + FormatarNumeroSQL(THIS.this_nAutdados, 0) + ", " + ;
                "autemail = " + FormatarNumeroSQL(THIS.this_nAutemail, 0) + ", " + ;
                "autsms = " + FormatarNumeroSQL(THIS.this_nAutsms, 0) + ", " + ;
                "autwhats = " + FormatarNumeroSQL(THIS.this_nAutwhats, 0) + ", " + ;
                "autteleg = " + FormatarNumeroSQL(THIS.this_nAutteleg, 0) + ", " + ;
                "ctaencrypt = " + FormatarNumeroSQL(THIS.this_nCtaencrypt, 0) + ", " + ;
                "ddpolegar = " + FormatarNumeroSQL(THIS.this_nDdpolegar, 0) + ", " + ;
                "ddindicado = " + FormatarNumeroSQL(THIS.this_nDdindicado, 0) + ", " + ;
                "ddmedio = " + FormatarNumeroSQL(THIS.this_nDdmedio, 0) + ", " + ;
                "ddanular = " + FormatarNumeroSQL(THIS.this_nDdanular, 0) + ", " + ;
                "ddminimo = " + FormatarNumeroSQL(THIS.this_nDdminimo, 0) + ", " + ;
                "vlrvaltransp = " + FormatarNumeroSQL(THIS.this_nVlrvaltransp, 2) + ", " + ;
                "vlrvalref = " + FormatarNumeroSQL(THIS.this_nVlrvalref, 2) + ", " + ;
                "vlrvalalim = " + FormatarNumeroSQL(THIS.this_nVlrvalalim, 2) + ", " + ;
                "vlrplansaude = " + FormatarNumeroSQL(THIS.this_nVlrplansaude, 2) + ", " + ;
                "vlrplandent = " + FormatarNumeroSQL(THIS.this_nVlrplandent, 2) + ", " + ;
                "endcobs = " + EscaparSQL(THIS.this_cEndcobs) + ", " + ;
                "baicobs = " + EscaparSQL(THIS.this_cBaicobs) + ", " + ;
                "cidcobs = " + EscaparSQL(THIS.this_cCidcobs) + ", " + ;
                "estcobs = " + EscaparSQL(THIS.this_cEstcobs) + ", " + ;
                "cepcobs = " + EscaparSQL(THIS.this_cCepcobs) + ", " + ;
                "paicobs = " + EscaparSQL(THIS.this_cPaicobs) + ", " + ;
                "endtrabs = " + EscaparSQL(THIS.this_cEndtrabs) + ", " + ;
                "numtrabs = " + EscaparSQL(THIS.this_cNumtrabs) + ", " + ;
                "compltrabs = " + EscaparSQL(THIS.this_cCompltrabs) + ", " + ;
                "bairtrabs = " + EscaparSQL(THIS.this_cBairtrabs) + ", " + ;
                "cidatrabs = " + EscaparSQL(THIS.this_cCidatrabs) + ", " + ;
                "estatrabs = " + EscaparSQL(THIS.this_cEstatrabs) + ", " + ;
                "esttrabs = " + EscaparSQL(THIS.this_cEstatrabs) + ", " + ;
                "ceptrabs = " + EscaparSQL(THIS.this_cCeptrabs) + ", " + ;
                "paitrabs = " + EscaparSQL(THIS.this_cPaitrabs) + ", " + ;
                "emptrabs = " + EscaparSQL(THIS.this_cEmptrabs) + ", " + ;
                "cnpjtrabs = " + EscaparSQL(THIS.this_cCnpjtrabs) + ", " + ;
                "teltrabs = " + EscaparSQL(THIS.this_cTeltrabs) + ", " + ;
                "salarios = " + FormatarNumeroSQL(THIS.this_nSalarios, 2) + ", " + ;
                "rendafams = " + FormatarNumeroSQL(THIS.this_nRendafams, 2) + ", " + ;
                "grauparens = " + EscaparSQL(THIS.this_cGrauparens) + ", " + ;
                "endcos = " + EscaparSQL(THIS.this_cEndcos) + ", " + ;
                "nomecos = " + EscaparSQL(THIS.this_cNomecos) + ", " + ;
                "baicos = " + EscaparSQL(THIS.this_cBaicos) + ", " + ;
                "cidcos = " + EscaparSQL(THIS.this_cCidcos) + ", " + ;
                "estcos = " + EscaparSQL(THIS.this_cEstcos) + ", " + ;
                "cepcos = " + EscaparSQL(THIS.this_cCepcos) + ", " + ;
                "complcos = " + EscaparSQL(THIS.this_cComplcos) + ", " + ;
                "numcos = " + FormatarNumeroSQL(THIS.this_nNumcos, 0) + ", " + ;
                "cfos = " + EscaparSQL(THIS.this_cCfos) + ", " + ;
                "codtifs = " + EscaparSQL(THIS.this_cCodtifs) + ", " + ;
                "fpubls = " + EscaparSQL(THIS.this_cFpubls) + ", " + ;
                "cfgfiscos = " + EscaparSQL(THIS.this_cCfgfiscos) + ", " + ;
                "cfgfiscss = " + EscaparSQL(THIS.this_cCfgfiscss) + ", " + ;
                "cfgfisics = " + EscaparSQL(THIS.this_cCfgfisics) + ", " + ;
                "cfgfisiis = " + EscaparSQL(THIS.this_cCfgfisiis) + ", " + ;
                "cfgfisins = " + EscaparSQL(THIS.this_cCfgfisins) + ", " + ;
                "cfgfisips = " + EscaparSQL(THIS.this_cCfgfisips) + ", " + ;
                "cfgfisirs = " + EscaparSQL(THIS.this_cCfgfisirs) + ", " + ;
                "cfgfisiss = " + EscaparSQL(THIS.this_cCfgfisiss) + ", " + ;
                "cfgfispis = " + EscaparSQL(THIS.this_cCfgfispis) + ", " + ;
                "ccargs = " + EscaparSQL(THIS.this_cCcargs) + ", " + ;
                "ean13ents = " + FormatarNumeroSQL(THIS.this_nEan13ents, 0) + ", " + ;
                "ean13cobs = " + FormatarNumeroSQL(THIS.this_nEan13cobs, 0) + ", " + ;
                "pracas = " + EscaparSQL(THIS.this_cPracas) + ", " + ;
                "codvendedor = " + EscaparSQL(THIS.this_cCodvendedor) + ", " + ;
                "usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "usuariocrm = " + EscaparSQL(THIS.this_cUsuariocrm) + ", " + ;
                "senhas = " + EscaparSQL(THIS.this_cSenhas) + ", " + ;
                "ccartoes = " + EscaparSQL(THIS.this_cCcartoes) + ", " + ;
                "cobs = " + EscaparSQL(LEFT(THIS.this_cCobs, 250)) + ", " + ;
                "pais = " + EscaparSQL(THIS.this_cPais) + ", " + ;
                "maes = " + EscaparSQL(THIS.this_cMaes) + ", " + ;
                "obs = " + IIF(EMPTY(THIS.this_cObs), "NULL", EscaparSQL(THIS.this_cObs)) + ", " + ;
                "perfils = " + IIF(EMPTY(THIS.this_cPerfils), "NULL", EscaparSQL(THIS.this_cPerfils)) + ", " + ;
                "pastas = " + IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                "figjpgs = " + IIF(EMPTY(THIS.this_cFigjpgs), "NULL", EscaparSQL(THIS.this_cFigjpgs)) + ", " + ;
                "figlgpds = " + IIF(EMPTY(THIS.this_cFiglgpds), "NULL", EscaparSQL(THIS.this_cFiglgpds)) + " " + ;
                "WHERE iclis = " + EscaparSQL(THIS.this_cIclis)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cUsualts = gc_4c_UsuarioLogado
                THIS.this_dDtalts  = DATETIME()
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar cliente no banco de dados."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SIGCDCLI
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SIGCDCLI WHERE iclis = " + EscaparSQL(THIS.this_cIclis)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir cliente do banco de dados."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
