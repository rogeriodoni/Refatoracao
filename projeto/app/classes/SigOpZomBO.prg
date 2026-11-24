*==============================================================================
* SigOpZomBO.prg
*
* Business Object para SIGOPZOM (Zoom - Visualizacao de Imagem)
*
* Este form NAO persiste dados e NAO consulta tabela nenhuma: e um dialogo
* OPERACIONAL (WindowType = 1, modal, AlwaysOnTop) chamado por outro form
* para EXIBIR AMPLIADA uma imagem cujo caminho completo vem por parametro,
* com dois textos opcionais logo abaixo (os dois quadros Shape1/Shape2) e
* fechamento automatico opcional por Timer.
*
* Tabela: (nenhuma - visualizador parametrizado, sem persistencia e sem SQL)
*
* Assinatura do Init legado (SIGOPZOM.Init):
*   Lparameters pArquivo, pTexto1, pTexto2, pTimer
*     pArquivo = Nome Completo do Arquivo de Imagem (incluindo Path)
*     pTexto1  = Texto apresentado no 1o quadro, abaixo da imagem (Opcional)
*     pTexto2  = Texto apresentado no 2o quadro, abaixo da imagem (Opcional)
*     pTimer   = quando verdadeiro, a tela se fecha sozinha (Timer.Interval
*                = 3000); senao o Timer fica com Interval 0 e Enabled .F.
*
* SOMENTE LEITURA - por que Inserir()/Atualizar()/ExecutarExclusao() NAO sao
* sobrescritos aqui: o dump do legado nao tem UM UNICO Insert Into, Update,
* Delete From, Replace, TableUpdate nem .AddCursor - os tres metodos do form
* (Init, Timer.Timer e btnSair.Click) so mexem em propriedades de controles
* e chamam ThisForm.Release. Nao existe nem cursor local. Escrever
* INSERT/UPDATE aqui significaria INVENTAR tabela e colunas, o que a regra
* #22 do CLAUDE.md proibe (a lista vem do schema, nunca de adivinhacao). O
* comportamento padrao herdado de BusinessBase (recusar a operacao e
* reportar pelo ExibirFalha do Salvar) ja e o correto.
*
* Divisao de responsabilidade com o Form (o Form exibe, o BO decide):
*
*   DefinirParametros()        espelha os 4 Lparameters do Init legado, com
*                              as MESMAS guardas de tipo (Type('pTextoN')
*                              = 'C' e o teste de verdade de pTimer)
*   ValidarArquivoImagem()     o If Empty(pArquivo) Or Not File(pArquivo) e
*                              o If Not InList(Lower(Right(Alltrim(...),4)),
*                              '.bmp', '.dib', '.gif', '.jpg', '.cur',
*                              '.ani', '.ico') - sao DOIS motivos de recusa
*                              com tratamento DIFERENTE no legado (ver
*                              this_cMotivoRecusa abaixo)
*   ObterExtensaoArquivo()     Lower(Right(Alltrim(pArquivo), 4))
*   ObterIntervaloTimer()      Iif(pTimer, 3000, 0)
*
* ATENCAO - os DOIS motivos de recusa do legado NAO
* se comportam igual, e achatar os dois num unico caminho muda a UX:
*   arquivo vazio ou inexistente -> ThisForm.Release SILENCIOSO (sem aviso)
*   extensao fora da lista       -> MessageBox(..., 16, '') e SO DEPOIS o
*                                   ThisForm.Release
* Por isso this_cMotivoRecusa guarda QUAL dos dois ocorreu, em vez de um
* unico .F.: e o Form que decide exibir ou nao a mensagem.
*
* NOTA sobre o Release do legado: no Init original o ThisForm.Release esta
* DENTRO dos dois If, sem Return, entao o codigo seguinte continua
* executando mesmo apos o pedido de fechamento (inclusive o
* ImgFigJpg.Picture = (pArquivo) com arquivo invalido). O Form migrado
* aborta a inicializacao no primeiro motivo de recusa - o resultado visivel
* para o usuario e o mesmo (a tela nao abre) e evita atribuir Picture
* inexistente, que em VFP9 falha em SILENCIO (regra #25 do CLAUDE.md).
*==============================================================================

DEFINE CLASS SigOpZomBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros recebidos do form chamador, espelhando UM A UM os
    * Lparameters do Init legado (pArquivo, pTexto1, pTexto2, pTimer)
    *--------------------------------------------------------------------------
    this_cArquivoImagem = ""            && pArquivo - caminho completo do arquivo de imagem
    this_cTexto1 = ""                   && pTexto1  - texto do 1o quadro (Shape1 / lblTexto1)
    this_cTexto2 = ""                   && pTexto2  - texto do 2o quadro (Shape2 / lblTexto2)
    this_lFechamentoAutomatico = .F.    && pTimer   - .T. fecha a tela sozinha pelo Timer

    *--------------------------------------------------------------------------
    * Estado resultante do Timer (o If pTimer / Else do Init legado).
    * Sao DUAS propriedades porque o legado mexe em DUAS propriedades do
    * controle: no ramo falso ele zera o Interval E desliga o Enabled.
    *--------------------------------------------------------------------------
    this_nIntervaloTimer = 0            && Timer.Interval resultante (3000 ou 0)
    this_lTimerHabilitado = .F.         && Timer.Enabled resultante (.T. ou .F.)

    *--------------------------------------------------------------------------
    * Constantes transcritas do legado (nao inventar outros valores)
    *--------------------------------------------------------------------------
    *-- Interval usado quando pTimer e verdadeiro: 3000 ms = 3 segundos
    this_nIntervaloFechamento = 3000

    *-- Lista EXATA do InList do Init legado, na MESMA ORDEM. A comparacao do
    *-- legado e sobre Lower(Right(Alltrim(pArquivo), 4)), isto e, sobre os 4
    *-- ultimos caracteres do nome - por isso toda extensao da lista tem 4
    *-- caracteres, com o ponto incluido.
    this_cExtensoesValidas = ".bmp,.dib,.gif,.jpg,.cur,.ani,.ico"

    *--------------------------------------------------------------------------
    * Resultado da validacao do arquivo
    *--------------------------------------------------------------------------
    this_lArquivoValido = .F.           && .T. quando o arquivo existe E a extensao e aceita
    this_cExtensaoArquivo = ""          && Lower(Right(Alltrim(pArquivo), 4))

    *-- Motivo da recusa, vazio quando o arquivo e valido. Valores possiveis:
    *--   "AUSENTE"   -> Empty(pArquivo) ou Not File(pArquivo): fecha CALADO
    *--   "EXTENSAO"  -> extensao fora de this_cExtensoesValidas: exibe a
    *--                 mensagem this_cMensagemArquivoInvalido e so depois fecha
    this_cMotivoRecusa = ""

    *-- Texto do MessageBox do legado, montado com CHR() no Init (regra #4 do
    *-- CLAUDE.md: PROIBIDO acentuar literal em .prg)
    this_cMensagemArquivoInvalido = ""

    *-- Caption do form legado ("Zoom"), que o Init replica nos dois labels da
    *-- faixa do cabecalho (lblSombra e lblTitulo)
    this_cTituloTela = "Zoom"

    *====================================================================
    * Init - Inicializa Business Object
    *
    * Visualizador parametrizado: nao ha tabela nem campo chave proprios,
    * entao this_cTabela e this_cCampoChave ficam vazios de proposito (o
    * Buscar/Salvar herdados nunca sao usados por este form).
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Parametros (equivalente ao estado do form antes do Init legado)
        THIS.this_cArquivoImagem = ""
        THIS.this_cTexto1 = ""
        THIS.this_cTexto2 = ""
        THIS.this_lFechamentoAutomatico = .F.

        *-- Estado do Timer: default = desligado, igual ao ramo Else do legado
        *-- (Timer.Interval = 0 / Timer.Enabled = .F.). O SCX legado tambem
        *-- nasce com Interval = 0.
        THIS.this_nIntervaloTimer = 0
        THIS.this_lTimerHabilitado = .F.

        *-- Constantes do legado
        THIS.this_nIntervaloFechamento = 3000
        THIS.this_cExtensoesValidas = ".bmp,.dib,.gif,.jpg,.cur,.ani,.ico"

        *-- Resultado da validacao: comeca recusado por ausencia, porque
        *-- enquanto nenhum arquivo foi informado o caso e exatamente o
        *-- Empty(pArquivo) do legado
        THIS.this_lArquivoValido = .F.
        THIS.this_cExtensaoArquivo = ""
        THIS.this_cMotivoRecusa = "AUSENTE"

        *-- Mensagem do MessageBox do legado, transcrita LITERALMENTE:
        *-- 'O Arquivo Passado Nao e Um Arquivo de Imagem Valido!!!' + Chr(13) +
        *-- 'Use Um Arquivo de Extensao : .bmp, .dib, .gif, .jpg, .cur, .ani ou .ico'
        THIS.this_cMensagemArquivoInvalido = ;
            "O Arquivo Passado N" + CHR(227) + "o " + CHR(201) + " Um Arquivo de Imagem V" + ;
            CHR(225) + "lido!!!" + CHR(13) + ;
            "Use Um Arquivo de Extens" + CHR(227) + "o : .bmp, .dib, .gif, .jpg, .cur, .ani ou .ico"

        *-- Caption do form legado, replicado nos labels da faixa do cabecalho
        THIS.this_cTituloTela = "Zoom"

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterExtensaoArquivo - Replica "Lower(Right(Alltrim(pArquivo),4))"
    * do Init legado: os 4 ultimos caracteres do caminho, em minusculas
    * (cada item de this_cExtensoesValidas tem 4 caracteres, ponto
    * incluido - por isso 4 e nao 3).
    *====================================================================
    FUNCTION ObterExtensaoArquivo()
        RETURN LOWER(RIGHT(ALLTRIM(THIS.this_cArquivoImagem), 4))
    ENDFUNC

    *====================================================================
    * ValidarArquivoImagem - Replica os DOIS testes de recusa do Init
    * legado, na MESMA ORDEM e preservando qual deles ocorreu em
    * this_cMotivoRecusa (ver cabecalho desta classe: os dois motivos
    * tem tratamento de UX diferente, e e o Form quem decide se exibe
    * mensagem antes de fechar):
    *
    *   1) Empty(pArquivo) Or Not File(pArquivo)             -> "AUSENTE"
    *   2) Not InList(extensao, '.bmp','.dib','.gif','.jpg',
    *                           '.cur','.ani','.ico')        -> "EXTENSAO"
    *
    * PUBLIC (sem PROTECTED) porque o Form chama este metodo diretamente
    * em InicializarForm - regra #51 do CLAUDE.md: Form nunca chama
    * metodo PROTECTED do BO.
    *====================================================================
    FUNCTION ValidarArquivoImagem()
        LOCAL loc_cListaBusca, loc_lValido

        loc_lValido = .F.
        THIS.this_cExtensaoArquivo = THIS.ObterExtensaoArquivo()

        IF EMPTY(THIS.this_cArquivoImagem) OR !FILE(THIS.this_cArquivoImagem)
            THIS.this_cMotivoRecusa = "AUSENTE"
        ELSE
            *-- Comparar com bordas de virgula (nao $direto), senao uma
            *-- extensao de 4 chars poderia casar como substring de outra
            loc_cListaBusca = "," + THIS.this_cExtensoesValidas + ","
            IF ("," + THIS.this_cExtensaoArquivo + ",") $ loc_cListaBusca
                THIS.this_cMotivoRecusa = ""
                loc_lValido = .T.
            ELSE
                THIS.this_cMotivoRecusa = "EXTENSAO"
            ENDIF
        ENDIF

        THIS.this_lArquivoValido = loc_lValido
        RETURN loc_lValido
    ENDFUNC

    *====================================================================
    * AtualizarEstadoTimer - Replica "If pTimer / Interval=3000 / Else /
    * Interval=0 / Enabled=.F." do Init legado. So chamar DEPOIS de
    * ValidarArquivoImagem() ter aprovado o arquivo (mesma ordem do
    * Init original). PUBLIC pelo mesmo motivo de ValidarArquivoImagem.
    *====================================================================
    FUNCTION AtualizarEstadoTimer()
        THIS.this_nIntervaloTimer  = IIF(THIS.this_lFechamentoAutomatico, THIS.this_nIntervaloFechamento, 0)
        THIS.this_lTimerHabilitado = THIS.this_lFechamentoAutomatico
        RETURN .T.
    ENDFUNC

    *==============================================================================
    * DECISAO DE PROJETO (Fase 2 - BO/Metodos CRUD)
    *
    * Este BO NAO sobrescreve CarregarDoCursor(), Inserir() nem Atualizar():
    * o dump do legado (SIGOPZOM.Init / Timer.Timer / btnSair.Click) nao tem
    * nenhuma tabela, nenhum cursor local e nenhum Select/Insert Into/Update/
    * Delete From/Replace/TableUpdate/.AddCursor - o form recebe 4 parametros
    * (pArquivo, pTexto1, pTexto2, pTimer) e apenas EXIBE AMPLIADA a imagem
    * apontada por pArquivo, sem persistir nada em lugar nenhum.
    *
    * Nao ha coluna para CarregarDoCursor() mapear, nao ha registro para
    * Inserir()/Atualizar() gravar, e ObterChavePrimaria()/RegistrarAuditoria()
    * exigiriam uma chave primaria que este form nunca teve. O comportamento
    * padrao herdado de BusinessBase (recusar a operacao via ExibirFalha) ja e
    * o correto - sobrescrever esses metodos aqui so para preencher a fase
    * exigiria inventar tabela e colunas, o que a regra #22 do CLAUDE.md
    * proibe (a lista de colunas vem do schema, nunca de adivinhacao).
    *==============================================================================

ENDDEFINE
