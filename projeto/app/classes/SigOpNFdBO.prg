*==============================================================================
* SigOpNFdBO.prg - Business Object para SigOpNFd (Eventos NFe)
*
* Form OPERACIONAL (SIGOPNFD.SCX, Caption "Eventos NFe"). NAO eh cadastro
* CRUD: eh um dialogo FILHO, aberto pelo form de movimentacao/nota fiscal
* (ParentForm) passando (pForm1, pForm2, pDId, pEvento), que registra na
* SEFAZ um EVENTO sobre uma NFe ja emitida:
*
*   pEvento = 'CAN' -> CANCELAMENTO       (tpEvento 110111)
*   pEvento = 'CAR' -> CARTA DE CORRECAO  (tpEvento 110110)
*
* Fluxo do legado (a reproduzir nas fases seguintes):
*
*   Init do form
*     - Evento := pEvento; rotulo do campo GetEvento conforme o evento
*     - getData.Value := ttoc(DATETIME())
*     - atucur()  -> le o ULTIMO evento desta operacao e, se for 'CAR' ou se
*                    nao houver linha, APPEND BLANK + Replace no cursor de
*                    SigMvNfd com nfeseq = ultimo + 1 (1 quando nao ha linha)
*     - le SigMvCab pela chave empdopnums da nota
*     - le a configuracao da operacao (SigCdOpe + SigOpCdd + SigOpCdc +
*       SigOpCdi) para o cursor LocalOpe
*
*   atucur (metodo do form legado)
*     Select * From SigMvNfd Where empdopnums = <chave> And nfeEve = <evento>
*       Order By nfeseq desc
*     lnUltSeq = IIF(EOF(), 1, nfeseq + 1)
*     Replace cidchaves With fUniqueIds(), nfis, dopes, numes, emps,
*             empdopnums, nfedte With CTOT(getData.Value), nfedesc With '',
*             nfeeve With Evento, nfeseq With lnUltSeq
*     Espelha nfis / nfeseq / nfedesc nos campos da tela
*
*   btnSelItens.Click ("Enviar") - tres caminhos, decididos por SigCdOpe.CupFis
*     CupFis = 5 -> NFCe emitida pelo Migrate: cancela pela DLL
*                   DarumaFramework (tCFCancelar_NFCe_Daruma), exigindo
*                   SigPrNfe.stats = 'EMI' e situacao '100' na consulta
*     CupFis = 6 -> CF-e do SAT: canccfe() monta o XML de cancelamento
*                   (cursor CFTags) e grava SigMvNfi.canxml
*     demais     -> NFe pela UniNFe: valida/envia o XML do evento, le o
*                   retorno (cStat/xMotivo), grava SigMvNfd.nfexml +
*                   nfedesc, marca SigMvNfi.cancelas / SigPrNfe.stats e
*                   envia o XML por e-mail ao cliente
*     Fecha SEMPRE com atucur() (repopula o cursor do evento)
*
*   conscan (metodo do form legado)
*     Monta consSitNFe versao 4.00, envia pela UniNFe e, com cStat 100/101,
*     grava SigPrNfe.stats = 'CAN' / statts = '0' / prots = <nProt>
*
*   Refazer.Click
*     Marcado    -> reusa o ULTIMO evento gravado (nao cria sequencia nova):
*                   reenvia o XML de cancelamento ou reimprime a carta
*     Desmarcado -> atucur() (volta a criar a proxima sequencia)
*
* TABELAS E COLUNAS - todos os nomes conferidos em docs/schema.sql lido com
* Get-Content -Raw (o arquivo eh UTF-16; grep/findstr devolvem ZERO em
* silencio - regra #14 do CLAUDE.md):
*
*   SigMvNfd (tabela principal deste BO - um registro por EVENTO da nota)
*     cidchaves  char(20)      NOT NULL  PK (fUniqueIds no legado)
*     dopes      char(20)      NOT NULL
*     empdopnums char(29)      NOT NULL  Emps(3) + Dopes(20) + Str(Numes,6)
*     emps       char(3)       NOT NULL
*     nfedesc    text          NULL      justificativa / texto da correcao
*     nfedte     datetime      NULL      data/hora do evento (dhEvento)
*     nfeeve     char(3)       NOT NULL  'CAN' ou 'CAR'
*     nfeprt     char(15)      NOT NULL  protocolo
*     nfeseq     numeric(2,0)  NOT NULL  nSeqEvento (1..99)
*     nfexml     text          NULL      XML do evento autorizado
*     nfis       char(6)       NOT NULL  numero da nota
*     numes      numeric(6,0)  NOT NULL
*     numeronota char(10)      NOT NULL
*
*   SigMvNfi (nota fiscal de origem - crSigMvNfi no legado; gravada pelo
*            form PAI, lida e marcada por este fluxo)
*     cidchaves char(20), empdopnums char(29), emps char(3), dopes char(20),
*     numes numeric(6,0), nfis char(6), series char(8), clifors char(20),
*     emis datetime NULL, nfechv char(44), nfeprt char(15),
*     nfexml text NULL, canxml text NULL, cancelas bit
*
*   SigPrNfe (situacao da NFe - crSigPrNfe no legado)
*     stats char(3), statts char(1), prots char(15), arquivos char(250)
*
*   SigMvCab (cabecalho do movimento - crSigMvCab no legado)
*     empdopnums char(29), dopes char(20), lcancelas bit
*
*   SigCdOpe  cupfis numeric(1,0), dopes char(20)   (5=NFCe Migrate, 6=SAT)
*   SigOpCdd  configgers char(250)  (posicao 239..241 = empresa emitente)
*   SigOpCdc  cncaixas char(3), geropes numeric(1,0), dopenfs char(20)
*   SigCdPac  direxpsdfs char(200) (pasta de backup do XML)
*   SigCdEmp  cemps char(3) PK, razas char(40), cgcs char(20),
*             pastas char(50), textonfe text, emailnfe char(250),
*             servs char(50), senhas char(30), portas numeric(3,0),
*             textopaf text
*             ATENCAO (regra #48): a coluna de empresa de SigCdEmp eh
*             CEMPS; em SigMvNfd/SigMvNfi/SigPrNfe/SigMvCab eh EMPS.
*   SigCdCli  iclis char(10) PK, emails char(50)
*
* Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() no sentido CRUD
* classico: a gravacao do evento (Fase 2) espelha o APPEND BLANK + Replace
* do legado sobre SigMvNfd, por isso this_cTabela/this_cCampoChave apontam
* para SigMvNfd/cidchaves.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpNFdBO AS BusinessBase

    *==========================================================================
    * SigMvNfd - registro do EVENTO (tabela principal deste BO)
    *
    * nfedte eh declarada com {/:} (DATETIME vazio, VARTYPE "T") e NAO com {}
    * (DATE): a hora faz parte do dhEvento enviado a SEFAZ, e so com tipo "T"
    * o FormatarDataSQL() acrescenta " HH:MM:SS" ao literal. Pelo mesmo motivo
    * NUNCA aplicar TTOD() a esta property (regra #16) - o valor vem de
    * CTOT(<TextBox>.Value) no form e pode chegar como DATE quando o campo
    * esta vazio; normalizar com ConverterParaData() apenas onde se quiser a
    * DATA pura (nome da pasta de autorizados, por exemplo).
    *==========================================================================
    this_cCidchaves  = ""     && cidchaves  char(20) NOT NULL - PK (fUniqueIds)
    this_cDopes      = ""     && dopes      char(20) NOT NULL - documento da operacao
    this_cEmpDopNums = ""     && empdopnums char(29) NOT NULL - Emps+Dopes+Str(Numes,6)
    this_cEmps       = ""     && emps       char(3)  NOT NULL - empresa do movimento
    this_cNfedesc    = ""     && nfedesc    text     NULL     - justificativa / correcao
    this_dNfedte     = {/:}   && nfedte     datetime NULL     - data/hora do evento
    this_cNfeeve     = ""     && nfeeve     char(3)  NOT NULL - 'CAN' ou 'CAR'
    this_cNfeprt     = ""     && nfeprt     char(15) NOT NULL - protocolo do evento
    this_nNfeseq     = 0      && nfeseq     numeric(2,0) NOT NULL - nSeqEvento (1..99)
    this_cNfexml     = ""     && nfexml     text     NULL     - XML do evento autorizado
    this_cNfis       = ""     && nfis       char(6)  NOT NULL - numero da nota
    this_nNumes      = 0      && numes      numeric(6,0) NOT NULL
    this_cNumeroNota = ""     && numeronota char(10) NOT NULL

    *==========================================================================
    * SigMvNfi - nota fiscal de ORIGEM (crSigMvNfi no legado)
    *
    * Prefixo "Nfi" nos nomes porque SigMvNfi e SigMvNfd tem colunas
    * HOMONIMAS com conteudo diferente (nfis, nfeprt, nfexml, emps, dopes,
    * numes, empdopnums, cidchaves): sem o prefixo, o protocolo da NOTA
    * sobrescreveria o protocolo do EVENTO.
    *==========================================================================
    this_cNfiCidchaves  = ""     && cidchaves  char(20) - PK da nota
    this_cNfiEmpDopNums = ""     && empdopnums char(29) - liga nota, evento e cabecalho
    this_cNfiEmps       = ""     && emps       char(3)
    this_cNfiDopes      = ""     && dopes      char(20)
    this_nNfiNumes      = 0      && numes      numeric(6,0)
    this_cNfiNfis       = ""     && nfis       char(6)  - numero da nota (exibido na tela)
    this_cNfiSeries     = ""     && series     char(8)  - serie da nota
    this_cNfiCliFors    = ""     && clifors    char(20) - cliente/fornecedor (SigCdCli.IClis)
    this_dNfiEmis       = {/:}   && emis       datetime NULL - emissao (pasta de autorizados)
    this_cNfiNfechv     = ""     && nfechv     char(44) - chave de acesso da NFe (cId / chNFe)
    this_cNfiNfeprt     = ""     && nfeprt     char(15) - protocolo da AUTORIZACAO (nProt)
    this_cNfiNfexml     = ""     && nfexml     text NULL - XML de autorizacao (origem do tpAmb)
    this_cNfiCanxml     = ""     && canxml     text NULL - XML do cancelamento
    this_lNfiCancelas   = .F.    && cancelas   bit - nota cancelada

    *==========================================================================
    * SigPrNfe - situacao da NFe (crSigPrNfe no legado)
    *
    * stats = 'EMI' eh pre-requisito para os dois eventos; o cancelamento
    * tambem aceita 'CAN' (reenvio). Ao autorizar o cancelamento o legado
    * grava stats = 'CAN' + statts = '0' e, no conscan, prots = <nProt>.
    *==========================================================================
    this_cStats    = ""   && stats    char(3)   - 'EMI' / 'CAN'
    this_cStatts   = ""   && statts   char(1)   - '0' apos cancelar
    this_cProts    = ""   && prots    char(15)  - protocolo retornado pela consulta
    this_cArquivos = ""   && arquivos char(250) - justificativa gravada no cancelamento de NFCe

    *==========================================================================
    * SigMvCab - cabecalho do movimento (crSigMvCab no legado)
    *==========================================================================
    this_cCabDopes     = ""    && dopes     char(20) - operacao do movimento (le a config da operacao)
    this_lCabLCancelas = .F.   && lcancelas bit - marca a OPERACAO como cancelada

    *==========================================================================
    * Configuracao da OPERACAO (cursor LocalOpe do legado: SigCdOpe +
    * SigOpCdd + SigOpCdc + SigOpCdi) e parametros do sistema (SigCdPac)
    *==========================================================================
    this_nCupFis     = 0    && SigCdOpe.cupfis     numeric(1,0) - 5=NFCe Migrate, 6=CF-e SAT, outros=NFe
    this_cConfigGers = ""   && SigOpCdd.configgers char(250)    - 239..241 = empresa emitente
    this_cCnCaixas   = ""   && SigOpCdc.cncaixas   char(3)      - numero do caixa (SAT: numeroCaixa)
    this_nGeropes    = 0    && SigOpCdc.geropes    numeric(1,0) - 4 = gera operacao automatica
    this_cDopenfs    = ""   && SigOpCdc.dopenfs    char(20)     - operacao gerada automaticamente
    this_cDirExpSdfs = ""   && SigCdPac.direxpsdfs char(200)    - pasta de backup do XML

    *==========================================================================
    * Empresa EMITENTE (cursor LocalEmp do legado: SigCdEmp da empresa
    * resolvida em ConfigGers 239..241, com fallback na empresa da nota)
    *
    * textopaf guarda, em posicoes FIXAS, os dados do SAT:
    *   1..14    CNPJ da casa de software (CNPJ da AC)
    *   16..359  assinatura (signAC)
    *   361..370 fabricante do equipamento SAT
    *==========================================================================
    this_cEmpCemps    = ""   && SigCdEmp.cemps    char(3) PK - empresa emitente
    this_cEmpRazas    = ""   && SigCdEmp.razas    char(40)
    this_cEmpCgcs     = ""   && SigCdEmp.cgcs     char(20) - CNPJ (a pasta do XML usa so os digitos)
    this_cEmpPastas   = ""   && SigCdEmp.pastas   char(50) - pasta raiz da UniNFe (cPathUni)
    this_cEmpTextoNfe = ""   && SigCdEmp.textonfe text NULL - corpo do e-mail
    this_cEmpEmailNfe = ""   && SigCdEmp.emailnfe char(250) - remetente / copia
    this_cEmpServs    = ""   && SigCdEmp.servs    char(50) - servidor SMTP
    this_cEmpSenhas   = ""   && SigCdEmp.senhas   char(30) - senha SMTP
    this_nEmpPortas   = 0    && SigCdEmp.portas   numeric(3,0) - porta SMTP
    this_cEmpTextoPaf = ""   && SigCdEmp.textopaf text NULL - dados do SAT em posicoes fixas

    *==========================================================================
    * Destinatario (SigCdCli) - e-mail para onde vai o XML do evento
    *==========================================================================
    this_cEmailCliente = ""   && SigCdCli.emails char(50) - WHERE IClis = SigMvNfi.clifors

    *==========================================================================
    * Estado do EVENTO em edicao (campos da tela e parametro de abertura)
    *
    * this_cEvento eh o pEvento recebido pelo form; os rotulos exibidos no
    * campo GetEvento sao atribuidos no Init (precisam de CHR() para os
    * acentos, e declaracao de property nao aceita chamada de funcao).
    *==========================================================================
    this_cEvento             = ""    && 'CAN' (cancelamento) ou 'CAR' (carta de correcao)
    this_cRotuloEvento       = ""    && texto exibido no campo GetEvento
    this_cRotuloCancelamento = ""    && 'CANCELAMENTO'      (atribuido no Init)
    this_cRotuloCarta        = ""    && 'CARTA DE CORRECAO'  (atribuido no Init, com CHR())
    this_lRefazer            = .F.   && CheckBox Refazer: reusa o ULTIMO evento gravado
    this_lHorarioVerao       = .F.   && CheckBox Horario de Verao: fuso 02:00 em vez de 03:00
    this_cFusoHorario        = ""    && '02:00' / '03:00' - sufixo do dhEvento (vem do CheckBox)
    this_nUltimaSequencia    = 0     && lnUltSeq do atucur: ultimo nfeseq + 1 (1 se nao ha evento)

    *==========================================================================
    * Constantes do evento NFe (layout nacional) - transcritas do legado
    *==========================================================================
    this_cTpEventoCancelamento = "110111"   && tpEvento do cancelamento
    this_cTpEventoCarta        = "110110"   && tpEvento da carta de correcao
    this_cVersaoEvento         = "1.00"     && versao do envEvento / evento / detEvento
    this_cVersaoConsulta       = "4.00"     && versao do consSitNFe (conscan)
    this_nTamMinDescricao      = 15         && LEN(ALLTRIM(nfedesc)) < 15 recusa o envio
    this_nMaxSequencia         = 99         && nfeseq eh numeric(2,0): 1..99

    *==========================================================================
    * Retorno da SEFAZ / do SAT (lido do XML de retorno)
    *==========================================================================
    this_cTipoAmbiente     = ""   && tpAmb extraido do XML de autorizacao da nota
    this_cStatusRetorno    = ""   && cStat (135 / 'EVENTO REGISTRADO' no evento; 100/101 no conscan)
    this_cMotivoRetorno    = ""   && xMotivo
    this_cMensagemRetorno  = ""   && mensagem montada para o usuario (cCampo no legado)
    this_cProtocoloRetorno = ""   && nProt retornado pela consulta de situacao
    this_cConteudoXml      = ""   && conteudo do XML autorizado (gravado em nfexml / canxml)

    *==========================================================================
    * Caminhos de arquivo da UniNFe - a pasta raiz vem de SigCdEmp.pastas e as
    * subpastas sao FIXAS no legado (nomes transcritos literalmente, pois sao
    * os nomes que o UniNFe monitora em disco)
    *==========================================================================
    this_cPathUni      = ""   && cPathUni - SigCdEmp.pastas
    this_cPathNFe      = ""   && cPathUni + <CNPJ sem pontuacao> + "\"
    this_cPathBackup   = ""   && SigCdPac.direxpsdfs ou cPathUni + "BKP\"
    this_cCnpjEmitente = ""   && SigCdEmp.cgcs sem ponto, barra e hifen
    this_cChaveAcesso  = ""   && cId - SigMvNfi.nfechv (44 posicoes)

    this_cPastaEnvio       = "envio\"
    this_cPastaEnviado     = "Enviado\"
    this_cPastaEmProc      = "Enviado\EmProcessamento\"
    this_cPastaEnvioLote   = "EnvioEmLote\"
    this_cPastaErro        = "Erro\"
    this_cPastaRetorno     = "Retorno\"
    this_cPastaValidar     = "Validar\"
    this_cPastaBkEnviados  = "BKenviados\"
    this_cPastaAssinado    = "Assinado\"
    this_cPastaValidado    = "Validado\"
    this_cPastaAutorizados = "Enviado\Autorizados\"
    this_cPastaPdf         = "PDF\"
    this_cPastaTxt         = "TXT\"

    *==========================================================================
    * CF-e do SAT (canccfe do legado) - dados lidos de SigCdEmp.textopaf
    *==========================================================================
    this_cCnpjAC        = ""   && textopaf 1..14    - CNPJ da casa de software
    this_cAssinaturaAC  = ""   && textopaf 16..359  - signAC
    this_cFabricanteSat = ""   && textopaf 361..370 - SWEDA / BEMAT / outros
    this_nCodFabricante = 0    && 3=SWEDA, 2=BEMAT, 0=demais
    this_cXmlCancelaSat = ""   && XML de cancelamento devolvido pelo SAT (pcXml no legado)

    *==========================================================================
    * Nomes dos cursores usados pelo BO e pelo Form (mantidos em property
    * para o Form nao repetir literais - mesmo padrao do SigOpNchBO)
    *==========================================================================
    this_cCursorEventos    = "cursor_4c_Eventos"     && SigMvNfd (crSigMvNfd no legado)
    this_cCursorNota       = "cursor_4c_Nota"        && SigMvNfi (crSigMvNfi)
    this_cCursorSitNFe     = "cursor_4c_SitNFe"      && SigPrNfe (crSigPrNfe)
    this_cCursorCabecalho  = "cursor_4c_Cabecalho"   && SigMvCab (crSigMvCab)
    this_cCursorOperacao   = "cursor_4c_Operacao"    && SigCdOpe + SigOpCdd/Cdc/Cdi (LocalOpe)
    this_cCursorEmpresa    = "cursor_4c_Empresa"     && SigCdEmp (LocalEmp)
    this_cCursorCliente    = "cursor_4c_Cliente"     && SigCdCli (LocalCliD)
    this_cCursorParametros = "cursor_4c_Parametros"  && SigCdPac (crSigCdPac)
    this_cCursorTagsCFe    = "cursor_4c_TagsCFe"     && CFTags - estrutura do XML do SAT

    *==========================================================================
    * Init - Configura tabela/chave principal (SigMvNfd) e os rotulos de
    *        evento que dependem de CHR() para os acentos.
    *
    * NAO faz acesso a banco: Init que retorna .F. mata o form, e o BO eh
    * instanciado tambem pelo harness de teste, sem gnConnHandle valido.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela gravada por este BO: um registro por evento da nota
            THIS.this_cTabela     = "SigMvNfd"
            THIS.this_cCampoChave = "cidchaves"

            *-- Rotulos exibidos no campo GetEvento (legado: Init do form)
            THIS.this_cRotuloCancelamento = "CANCELAMENTO"
            THIS.this_cRotuloCarta        = "CARTA DE CORRE" + CHR(199) + CHR(195) + "O"

            *-- Fuso default do dhEvento: sem horario de verao o legado usa
            *-- '03:00' (IIF(thisform.verao.Value = 1, '02:00', '03:00'))
            THIS.this_cFusoHorario = "03:00"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpNFdBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Valor da PK de SigMvNfd para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente de SigMvNfd (crSigMvNfd no
    * legado - par_cAliasCursor eh tipicamente THIS.this_cCursorEventos) nas
    * properties deste BO. Mapeia TODAS as 13 colunas da tabela, na ordem do
    * schema (regra #22 do CLAUDE.md - conferido em docs/schema.sql lido com
    * Get-Content -Raw, por ser UTF-16).
    *
    * SELECT (par_cAliasCursor) primeiro, depois campo sem alias (Problema 9
    * do FORMCOR_LICOES_APRENDIDAS.md - "campo" eh sintaxe invalida
    * em VFP9).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cNfedesc    = TratarNulo(nfedesc, "")
                THIS.this_dNfedte     = TratarNulo(nfedte, {/:})
                THIS.this_cNfeeve     = TratarNulo(nfeeve, "")
                THIS.this_cNfeprt     = TratarNulo(nfeprt, "")
                THIS.this_nNfeseq     = TratarNulo(nfeseq, 0)
                THIS.this_cNfexml     = TratarNulo(nfexml, "")
                THIS.this_cNfis       = TratarNulo(nfis, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cNumeroNota = TratarNulo(numeronota, "")

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MontarInsertEvento - Fonte UNICA do SQL de INSERT em SigMvNfd. Espelha o
    * "APPEND BLANK + Replace" do atucur() legado (linhas 564-574 do dump):
    *
    *   replace cidchaves with fUniqueIds(), nfis with crsigmvnfi.nfis,
    *           dopes with crsigmvnfi.dopes, numes with crsigmvnfi.numes,
    *           emps with crsigmvnfi.emps, empdopnums with crsigmvnfi.empdopnums,
    *           nfedte with CTOT(thisform.cntData.getData.Value),
    *           nfedesc with '', nfeeve with thisform.Evento,
    *           nfeseq with lnUltSeq in crSigMvNfd
    *
    * nfis/dopes/numes/emps/empdopnums vem das properties "Nfi" (espelham
    * crSigMvNfi - a nota de ORIGEM), nao das properties homonimas da nota
    * (que sao colunas DIFERENTES, com conteudo do proprio EVENTO).
    *
    * nfeprt char(15) NOT NULL e numeronota char(10) NOT NULL NUNCA aparecem
    * no atucur() nem em nenhum outro ponto do dump legado contra crSigMvNfd -
    * exatamente a armadilha da regra #22 (coluna invisivel no dump porque so
    * existia no buffer em branco do AddCursor). Gravar EscaparSQL("") para
    * as duas explicitamente, para nao violar o NOT NULL.
    *
    * nfedesc e nfexml sao NULL no schema. nfedesc vai com this_cNfedesc (e
    * NAO com '' literal): o '' do APPEND legado e valor INICIAL do cursor em
    * memoria - quando a linha chega de fato ao banco, pelo
    * "poDataMgr.Update([crSigMvNfd])" do Click, ela ja passou pelo "replace
    * nfedesc with lcdesc" (linhas 1406 e 1649 do dump) e carrega a
    * justificativa digitada. Gravar '' aqui perderia a descricao em todo
    * evento novo - exatamente o campo que o fluxo existe para registrar.
    * nfexml fica NULL (o legado nunca o toca antes da autorizacao; quem
    * grava o XML autorizado e Atualizar()).
    *==========================================================================
    PROTECTED PROCEDURE MontarInsertEvento()
        LOCAL loc_cSQL

        loc_cSQL = "INSERT INTO SigMvNfd (cidchaves, dopes, empdopnums, emps, " + ;
                   "nfedesc, nfedte, nfeeve, nfeprt, nfeseq, nfexml, nfis, " + ;
                   "numes, numeronota) VALUES (" + ;
                   EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                   EscaparSQL(THIS.this_cNfedesc) + ", " + ;
                   FormatarDataSQL(THIS.this_dNfedte) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNfeeve, 3)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNfeseq, 0) + ", " + ;
                   "NULL, " + ;
                   EscaparSQL(LEFT(THIS.this_cNfis, 6)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ")"

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * MontarUpdateEvento - Fonte UNICA do SQL de UPDATE em SigMvNfd. Espelha o
    * UNICO Update que o legado faz contra crSigMvNfd (btnSelItens.Click,
    * linhas 1405-1406 e 1648-1649 do dump, repetido nos tres caminhos de
    * envio - NFCe/Migrate nao atualiza SigMvNfd, so SAT e UniNFe):
    *
    *   replace nfexml with cConteudoxml in crSigMvNfd
    *   replace nfedesc with lcdesc in crSigMvNfd
    *
    * So essas DUAS colunas sao tocadas em algum ponto do fluxo legado depois
    * do INSERT inicial - o resto do registro (chave, nota de origem, sequencia)
    * nasce certo no atucur() e nunca muda. Atualizar nfedte/nfeprt/nfeseq aqui
    * seria regra de negocio inventada (regra #17 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE MontarUpdateEvento()
        LOCAL loc_cSQL

        loc_cSQL = "UPDATE SigMvNfd SET " + ;
                   "nfedesc = " + EscaparSQL(THIS.this_cNfedesc) + ", " + ;
                   "nfexml = " + IIF(EMPTY(THIS.this_cNfexml), "NULL", EscaparSQL(THIS.this_cNfexml)) + ;
                   " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * Inserir - INSERT de UM evento em SigMvNfd (caminho BusinessBase.Salvar e
    * o equivalente, nesta arquitetura, do atucur()/APPEND BLANK legado).
    *
    * cidchaves eh gerado AQUI quando ainda vazio, reproduzindo
    * "replace cidchaves with fUniqueIds()" - NUNCA string vazia (regra #22:
    * colidiria no indice unico do segundo evento).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF EMPTY(THIS.this_cCidchaves)
                    THIS.this_cCidchaves = fUniqueIds()
                ENDIF

                loc_cSQL = THIS.MontarInsertEvento()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o do Evento da NFe." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.Inserir")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarUltimoEvento - SELECT do atucur() legado (linhas 552-558 do
    * dump):
    *
    *   lcEDN = crSigmvNfi.empdopnums
    *   lcQuery = Select * From SigMvNfd Where empdopnums = <lcEDN>
    *             and nfeEve = <thisform.Evento> order by nfeseq desc
    *
    * Carrega a linha mais recente (se houver) nas properties deste BO via
    * CarregarDoCursor. NAO faz APPEND BLANK - isso fica em
    * AtualizarUltimoEvento(), que decide se cria linha nova ou reusa esta.
    *
    * GUARDA: this_cNfiEmpDopNums (chave da nota de origem) ainda nao e
    * populada em nenhuma fase deste BO - a leitura do contexto da nota via
    * SigMvNfi (que no legado chega pela DataSession compartilhada com o
    * form pai) e a mesma pendencia ja documentada em
    * FormSigOpNFd.BtnEnviarClick e no cabecalho desta classe ("Fluxo do
    * legado... fases seguintes"). Consultar com a chave vazia casaria
    * empdopnums = '' e corromperia o diagnostico de "encontrado"/"nao
    * encontrado" - por isso o metodo nao tenta a consulta nesse caso.
    *==========================================================================
    PROCEDURE ConsultarUltimoEvento()
        LOCAL loc_lEncontrado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lEncontrado = .F.

        IF EMPTY(THIS.this_cNfiEmpDopNums)
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorEventos)
                    USE IN (THIS.this_cCursorEventos)
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvNfd WHERE empdopnums = " + ;
                           EscaparSQL(LEFT(THIS.this_cNfiEmpDopNums, 29)) + ;
                           " AND nfeeve = " + EscaparSQL(LEFT(THIS.this_cEvento, 3)) + ;
                           " ORDER BY nfeseq DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEventos)

                IF loc_nResultado >= 0 AND USED(THIS.this_cCursorEventos) AND !EOF(THIS.this_cCursorEventos)
                    THIS.CarregarDoCursor(THIS.this_cCursorEventos)
                    loc_lEncontrado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.ConsultarUltimoEvento")
        ENDTRY

        RETURN loc_lEncontrado
    ENDPROC

    *==========================================================================
    * AtualizarUltimoEvento - Equivalente ao atucur() legado completo (linhas
    * 548-584 do dump): consulta o ultimo evento (ConsultarUltimoEvento) e,
    * quando o evento e 'CAR' (carta de correcao sempre gera sequencia nova)
    * OU nao ha nenhum evento anterior, PREPARA a linha nova (equivalente ao
    * "APPEND BLANK + Replace" do legado). Quando acha um evento 'CAN'
    * existente, apenas REUSA os dados ja carregados por
    * ConsultarUltimoEvento (igual ao legado, que nesse caso NAO cria linha
    * nova).
    *
    * NAO PERSISTE NADA - e isso e fidelidade ao legado, nao omissao. O
    * "APPEND BLANK + replace ... in crSigMvNfd" do atucur mexe apenas no
    * CURSOR em memoria; quem grava e o Click do botao Enviar, que faz
    * "replace nfedesc with lcdesc in crSigMvNfd" e so entao
    * "poDataMgr.Update([crSigMvNfd]) + Commit()" (linhas 1406-1430 e
    * 1649-1660 do dump). Chamar Salvar() aqui gravaria um evento de
    * descricao vazia a CADA abertura do dialogo (inclusive quando o usuario
    * desiste e clica Cancelar) e um SEGUNDO registro no Enviar.
    *
    * O que este metodo deixa pronto e o MODO de gravacao do BO:
    * NovoRegistro() no ramo da linha nova (Salvar -> Inserir) e
    * EditarRegistro() no ramo de reuso (Salvar -> Atualizar). Quem dispara
    * a gravacao e FormSigOpNFd.BtnEnviarClick, com a descricao final ja
    * lida do controle.
    *
    * par_dDataHora equivale a "CTOT(thisform.cntData.getData.Value)" do
    * legado - o Form passa o valor atual do campo de data/hora, porque esta
    * e uma leitura de CONTROLE da tela (camada de UI), nao de cursor.
    *
    * Mesma guarda de ConsultarUltimoEvento: sem this_cNfiEmpDopNums nao ha
    * como montar um registro valido (emps/dopes/numes/nfis viriam vazios),
    * entao o metodo nao grava nada e devolve .F.
    *==========================================================================
    PROCEDURE AtualizarUltimoEvento(par_dDataHora)
        LOCAL loc_lEncontrado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cNfiEmpDopNums)
            RETURN .F.
        ENDIF

        loc_lEncontrado = THIS.ConsultarUltimoEvento()
        THIS.this_nUltimaSequencia = IIF(loc_lEncontrado, THIS.this_nNfeseq + 1, 1)

        IF THIS.this_cEvento = "CAR" OR !loc_lEncontrado
            THIS.NovoRegistro()

            THIS.this_cCidchaves  = ""
            THIS.this_cDopes      = THIS.this_cNfiDopes
            THIS.this_cEmpDopNums = THIS.this_cNfiEmpDopNums
            THIS.this_cEmps       = THIS.this_cNfiEmps
            THIS.this_nNumes      = THIS.this_nNfiNumes
            THIS.this_cNfis       = THIS.this_cNfiNfis
            THIS.this_cNfedesc    = ""
            THIS.this_dNfedte     = IIF(VARTYPE(par_dDataHora) = "T", par_dDataHora, {/:})
            THIS.this_cNfeeve     = THIS.this_cEvento
            THIS.this_nNfeseq     = THIS.this_nUltimaSequencia

            loc_lSucesso = .T.
        ELSE
            *-- Legado nao faz APPEND neste ramo: REUSA a linha que o SELECT
            *-- trouxe (this_cCidchaves/this_cNfedesc/this_nNfeseq/this_cNfis
            *-- ja vieram de ConsultarUltimoEvento via CarregarDoCursor), e o
            *-- "replace nfedesc ... in crSigMvNfd" do Click vira UPDATE.
            *-- EditarRegistro deixa this_lNovoRegistro = .F., que eh o que
            *-- faz BusinessBase.Salvar() rotear para Atualizar() em vez de
            *-- Inserir().
            *--
            *-- RESET do modo ANTES de EditarRegistro: BusinessBase.
            *-- EditarRegistro() RECUSA (devolve .F. com "Nao ha registro
            *-- para editar") quando this_lNovoRegistro ainda esta .T., e
            *-- este metodo eh um FUNIL que roda VARIAS vezes na mesma vida
            *-- do form - uma abertura em 'CAR'/sem evento anterior passa
            *-- pelo ramo de cima e deixa a flag ligada, e a chamada seguinte
            *-- (Refazer desmarcado, ou o atucur do fim do Enviar) cai aqui
            *-- com ela ainda ligada. Sem o reset, o ramo de reuso falharia e
            *-- o BO continuaria em modo INSERT: o Salvar seguinte gravaria
            *-- um registro DUPLICADO onde o legado faz UPDATE.
            *--
            *-- A flag eh zerada na mao, e NAO por CancelarEdicao(): aquele
            *-- chama LimparDados() quando this_lNovoRegistro esta .T., o que
            *-- apagaria as properties que ConsultarUltimoEvento acabou de
            *-- carregar do banco, logo acima.
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = THIS.EditarRegistro()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE do evento existente em SigMvNfd (nfedesc/nfexml) -
    * caminho usado depois que a SEFAZ/SAT autoriza o evento e o XML/
    * justificativa definitivos sao conhecidos.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF EMPTY(THIS.this_cCidchaves)
                    THIS.this_cMensagemErro = "Evento da NFe n" + CHR(227) + ;
                        "o identificado para atualiza" + CHR(231) + CHR(227) + "o."
                ELSE
                    loc_cSQL = THIS.MontarUpdateEvento()
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_cErro = CapturarErroSQL()
                        THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                            "o do Evento da NFe." + CHR(13) + loc_cErro
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.Atualizar")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
