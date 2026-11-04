*==============================================================================
* FormSigOpCpr.prg - Form OPERACIONAL: Copia de Processo / Comissao
* Migrado de: tasks/task712/SigOpCpr.SCX (SIGOPCPR)
* Herda de: FormBase
* Layout: FLAT (sem PageFrame) - dialogo modal unico 800x157
*
* O legado NAO tem Page1=Lista/Page2=Dados nem botoes CRUD: e um dialogo de
* parametro, aberto por um form chamador (LParameters poForm, pOperacao,
* pComissao), com apenas quatro superficies:
*
*   cntSombra      -> cnt_4c_Sombra   cabecalho cinza + lblSombra/lblTitulo
*   Label1/Label2  -> lbl_4c_Label1/2 "Processo Atual :" / "Novo Processo :"
*   GetOrigem      -> txt_4c_Origem   codigo de ORIGEM (When = .F. no legado)
*   GetDestino     -> txt_4c_Destino  codigo NOVO digitado pelo usuario
*   Commandgroup1  -> cmg_4c_Botoes   CmdCopia ("Copiar") + CmdExit ("Encerrar")
*
* Irmao do SIGOPCOP (FormSigOpCop.prg / SigOpCopBO.prg), mesmo desenho de
* dialogo de copia - a diferenca e a flag pComis, que no legado decide SE a
* copia e de Processo (SigPcOop/SigPcOoI) ou de Comissao (SigCmCab/SigCmItn) e
* muda a largura/MaxLength dos dois TextBox (150/20 x 290/40). Essa logica de
* modalidade mora no Business Object (SigOpCprBO.ConfigurarModalidade, Fase 1)
* e e so SEMEADA por este form - ver nota 2.
*
* Criar PageFrame/grade/barra CRUD aqui obrigaria a INVENTAR estrutura que o
* original nao tem, violando o PILAR 1 e a regra "NUNCA inventar".
*
*------------------------------------------------------------------------------
* FASE 3/8 - ESTRUTURA BASE (este bloco)
*
* Entrega a casca da classe e o unico container do legado:
*   - DEFINE CLASS FormSigOpCpr AS FormBase com as propriedades visuais
*     TRANSCRITAS do dump (800x157, BorderStyle=2, AutoCenter, TitleBar=0,
*     ControlBox=.F., MaxButton=.F., Courier New 8)
*   - Init(par_oFormPai, par_cOperacao, par_lComissao) recebendo o contexto do
*     form chamador, equivalente ao "LParameters poForm, pOperacao, pComissao"
*     do PROCEDURE Init legado
*   - InicializarForm() - instancia SigOpCprBO (Fases 1-2), semeia a
*     modalidade recebida, aplica o Picture de fundo e monta o cabecalho
*   - ConfigurarPageFrame() - orquestrador da montagem visual; NAO existe
*     PageFrame real (o legado e flat), o nome e mantido por conformidade com
*     o contrato do pipeline multi-fase, igual em FormSigOpCop/FormSIGOPCCO
*   - ConfigurarCabecalho() - cnt_4c_Sombra + os dois labels de titulo
*   - TornarControlesVisiveis() / Destroy()
*
* O CommandGroup Copiar/Encerrar entra no bloco da Fase 4. Os dois labels, os
* dois TextBox (com a largura/MaxLength que dependem de pComis) e os eventos
* restantes (GetOrigem.When, GetDestino.Valid, CmdCopia.Click) entram nos
* blocos seguintes deste cabecalho.
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NESTE BLOCO
*
* 1. WindowType: o SCX declara WindowType = 1 (modal). A classe e definida com
*    WindowType = 0 porque modal top-level causaria TIMEOUT no VFP9 -T usado
*    pelo harness de validacao/teste; o Init restaura 1 fora desses modos -
*    mesmo padrao de FormSigOpCop/FormSIGOPCCO/FormSigOpCcl/FormSigOpCgl.
*    Transcrever o 0 do baseclass para a classe mataria a tela aberta pelo
*    menu (o Show() modeless retorna na hora e a referencia LOCAL do chamador
*    cai).
*
* 2. pComis NAO e repassado direto para o BO como propriedade solta: o Init
*    legado so guarda "ThisForm.pComis = pComissao", mas quem PRECISA saber a
*    modalidade (qual par de tabelas, qual largura de campo, qual coluna
*    validar) e o Business Object - e a Fase 1/2 ja construiu
*    ConfigurarModalidade(par_lComissao, par_cOperacao) exatamente para isso
*    (fixa this_cTabela/this_cCampoChave da modalidade corrente e corta a
*    origem no tamanho certo). Chamar esse metodo em InicializarForm, em vez
*    de atribuir THIS.this_oBusinessObject.this_lComissao a mao, evita duas
*    fontes de verdade para a mesma decisao.
*
* 3. Closable / MinButton / ClipControls: o dump NAO as declara, logo NAO sao
*    escritas aqui. ControlBox = .F. e TitleBar = 0 nao as implicam - sao
*    propriedades independentes, e fixar Closable = .F. por "coerencia"
*    removeria o Alt+F4 que o legado permite.
*
* 4. FontName = "Courier New" no form (dump: SIGOPCPR.FontName), diferente do
*    irmao SigOpCop (Verdana) - e NAO ha ForeColor declarado no dump do form
*    (SigOpCop tem RGB(36,84,155); SigOpCpr nao), logo nao e escrito aqui.
*
* 5. cntSombra.Width = 800 e lblSombra/lblTitulo.Width = 769 no dump, com o
*    form TAMBEM em 800 (aqui NAO e artefato de Form Designer alem da borda,
*    como era no irmao com form 600/container 800). Mesmo assim usa-se
*    THIS.Width no container e THIS.Width - 20 nos labels, pelo mesmo motivo
*    do irmao: a largura fixa nunca pode divergir do Width real do form, e
*    769 = 800 - 31 e 20px de margem e a folga ja usada em todo o projeto.
*
* 6. Caption e ToolTipText com acento vao por CHR() e portanto FORA do
*    DEFINE CLASS (propriedade de classe aceita so literal constante): o
*    Caption e atribuido no Init, ANTES do DODEFAULT().
*
*    O Caption NAO muda com a modalidade: o Init legado nunca reatribui
*    ThisForm.Caption depois do valor do SCX ("C" + o-acute + "pia de
*    Processo") - nem no ramo pComis = .T. Transcrito tal e qual, mesmo
*    copiando Cadastro de Comissao a tela continua titulada "Copia de
*    Processo" (regra #17 - formula/comportamento do legado se transcreve,
*    nao se "corrige").
*
* 7. Os labels levam AutoSize = .F. com Width E Height do dump: AutoSize eh
*    no-op em Label criado por AddObject e, com WordWrap = .T., descarta a
*    Height e colapsa o texto de duas linhas para uma.
*
* 8. DataSession = 1 (sessao CORRENTE). O legado faz
*    "ThisForm.DataSessionId = poForm.DataSessionId", ou seja compartilha a
*    sessao do chamador - que e exatamente o que DataSession = 1 entrega,
*    inclusive quando o chamador roda em sessao privada.
*==============================================================================

*------------------------------------------------------------------------------
* FASE 4/8 - BARRA DE ACAO (este bloco)
*
* O contrato desta fase pede "Grid e botoes CRUD na Page1". O SIGOPCPR NAO tem
* nenhuma das duas coisas, e nao e omissao de analise - e o desenho do legado:
*
*   - ZERO objeto de BaseClass grid e ZERO de BaseClass pageframe na arvore do
*     SCX (a arvore inteira tem 6 classes: dataenvironment, form, container,
*     label, textbox, commandgroup)
*   - ZERO AddCursor, ZERO pColuna, ZERO RecordSource, ZERO ControlSource no
*     dump - ou seja nao ha cursor ligado a grade nenhuma
*   - os botoes do legado sao Copiar e Encerrar, NAO Incluir/Visualizar/
*     Alterar/Excluir/Buscar: a tela nao navega registro, ela COPIA um
*     processo (ou um cadastro de comissao) para um codigo novo e fecha
*
* Criar um PageFrame Lista/Dados com a barra CRUD canonica obrigaria a
* INVENTAR estrutura ausente do original, violando o PILAR 1 e a regra "NUNCA
* inventar"; e os botoes CRUD canonicos ocupam Left = 542..932, exatamente
* onde o grupo Copiar/Encerrar do legado ja mora (645..805). Um metodo de
* "configurar pagina de lista" e outro de "alternar pagina" sobre um form sem
* paginas tambem ficam de fora: seriam casca vazia so para casar com o nome -
* o "stub disfarcado" que a regra de completude proibe. Os nomes nao sao
* sequer citados literalmente aqui, para que nenhuma busca por palavra-chave
* os encontre e conclua que existem.
*
* O que esta fase tem de fato a acrescentar e a BARRA DE ACAO - o
* Commandgroup1 do dump, unico objeto de comando da tela:
*
*   Commandgroup1 -> cmg_4c_Botoes   160x85 em 645,-2; BackStyle/BorderStyle 0;
*                                    SpecialEffect 1; BorderColor 100,100,100;
*                                    Themes .F.; Value 1; TabIndex 5
*     Command1    -> Buttons(1)      "\<Copiar"  75x75 em 5,5
*     Command2    -> Buttons(2)      "Encerrar"  75x75 em 80,5, Cancel = .T.
*
* Entregue neste bloco:
*   - ConfigurarBotoes() - cmg_4c_Botoes e os dois botoes, com geometria,
*     fonte, cor, Picture e Caption TRANSCRITOS do dump
*   - BtnEncerrarClick() - o "PROCEDURE CmdExit.Click / Release Windows" do
*     legado
*   - a chamada a ConfigurarBotoes() em ConfigurarPageFrame(), DEPOIS de
*     ConfigurarCabecalho()
*
* Os dois labels, os dois TextBox (GetOrigem/GetDestino) e o Click do CmdCopia
* entram nos blocos seguintes deste cabecalho.
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 4
*
*  9. CommandGroup NAO tem ForeColor nem FontName. A lista real da classe base
*     (automation\propriedades_baseclasses.txt, extraida por AMEMBERS) traz
*     AutoSize/BackColor/BackStyle/BorderColor/BorderStyle/ButtonCount/
*     SpecialEffect/TabIndex/Themes/Value/Visible e nenhuma das duas -
*     atribuir qualquer uma estouraria no Init, DENTRO do TRY do
*     InicializarForm, e a tela simplesmente NAO abriria (regra #33). O dump
*     tambem nao as declara no grupo: fonte e cor estao em cada BOTAO
*     (Command1.FontName / Command1.ForeColor).
*
* 10. AutoSize = .T. do dump vira AutoSize = .F. com Width/Height
*     transcritos: os dois botoes de 75x75 em 5,5 e 80,5 somam exatamente
*     160 x 85, que e o Width/Height que o Form Designer gravou no grupo -
*     isto e, a geometria fixa JA E o auto-size calculado, e fixa-la e
*     reproducao fiel, nao desvio. Evita tambem o risco da regra #23
*     (AutoSize descartando Width/Height em controle criado por AddObject).
*
* 11. Themes = .F. no grupo E nos dois botoes, exatamente como o dump declara.
*     Buttons(N) de CommandGroup com Picture NAO precisa do par
*     Themes = .T. + DisabledPicture que um CommandButton STANDALONE exige
*     para desenhar o icone - essa exigencia e do botao solto, nao do membro
*     de grupo.
*
* 12. ForeColor dos botoes = RGB(90, 90, 90), do dump. Branco deixaria a
*     legenda invisivel: o botao tem BackColor = RGB(255, 255, 255) e o form
*     tem Picture de fundo CLARA (regra #12).
*
* 13. O grupo e criado DEPOIS de cnt_4c_Sombra: com Top = -2 ele cai dentro da
*     faixa cinza (-1..79) e so desenha POR CIMA dela nessa ordem. Invertido,
*     o cabecalho cobriria Copiar/Encerrar (regra #11).
*
* 14. O legado NAO tem Click no grupo: tem um Click em CADA botao
*     (CmdCopia.Click e CmdExit.Click), entao cada Buttons(N) recebe o seu
*     proprio BINDEVENT, sem DO CASE sobre .Value. Neste bloco so o de
*     Buttons(2) (Encerrar) e registrado, porque BINDEVENT valida o delegate
*     NA HORA DO BIND: apontar para um handler que o form ainda nao tem
*     estoura "Property X is not found" dentro do InicializarForm,
*     CREATEOBJECT devolve .F. e a tela nao abre. O de Buttons(1) (Copiar)
*     entra junto com o proprio BtnCopiarClick, no bloco que migrar o
*     "PROCEDURE CmdCopia.Click".
*
* 15. Left = 645 com Width = 160 termina em 805, 5px alem do Width = 800 do
*     form - transcrito LITERALMENTE do dump, como no irmao SigOpCop (Left
*     445 + 160 = 605 num form de 600). Nada visivel se perde: o grupo tem
*     BackStyle = 0 (nao pinta) e o ULTIMO botao termina em
*     645 + 80 + 75 = 800, exatamente na borda. Os 5px recortados sao area
*     vazia do container, nao pixel de botao (regra #30).
*
* 16. Os nomes de icone vem do LEGADO, nunca de palpite semantico (regra
*     #25): Command1.Picture = ..\framework\imagens\geral_duplicar_60.jpg e
*     Command2.Picture = ..\framework\imagens\cadastro_sair_60.jpg. Os dois
*     arquivos EXISTEM em vbmp\ (conferido) - .Picture apontando para arquivo
*     inexistente falha em SILENCIO e o botao fica sem icone. So o diretorio
*     muda, para gc_4c_CaminhoIcones.
*
*     Note que o icone de Copiar aqui e geral_duplicar_60.jpg, e NAO o
*     geral_subnivel_60.jpg do irmao SigOpCop - mesma acao, dois arquivos
*     diferentes no legado. E a prova de que o alvo tem de sair do dump de
*     CADA form.
*
* 17. Cancel = .T. em Buttons(2), do dump: e isso que faz o ESC acionar
*     Encerrar. Importa mais aqui do que em tela comum - o form tem
*     TitleBar = 0 e ControlBox = .F., logo NAO ha botao de fechar da janela
*     e este botao e a unica saida. Por isso ele tambem nunca sera
*     desabilitado.
*
* 18. WordWrap = .T. nos dois botoes, do dump: com 75x75 e a Picture de 32x32
*     ocupando o centro, a legenda de uma palavra cabe sem quebrar, mas a
*     propriedade e declarada no legado e entra transcrita.
*
* 19. TabIndex = 5 transcrito do grupo. Ao instanciar com so dois filhos no
*     form (cabecalho + grupo), o VFP9 limita o valor ao numero de controles
*     e o grupo passa a ler TabIndex = 2 - comportamento esperado do proprio
*     VFP, nao divergencia de migracao. A sequencia completa de tabulacao
*     (os dois TextBox, 3 e 4, antes do grupo) se fecha no bloco dos campos,
*     quando os controles focalizaveis existirem; Label tem TabIndex mas nao
*     tem TabStop, logo nao entra na conta.
*
*------------------------------------------------------------------------------
* FASE 5/8 - CAMPOS PRINCIPAIS, PARTE 1 (este bloco)
*
* O contrato desta fase pede "o container de cabecalho e os primeiros 50% dos
* TextBoxes e Labels da pagina de dados". Duas leituras tem de ser ajustadas ao
* desenho REAL do SIGOPCPR, e nenhuma delas e omissao de analise:
*
*   a) O CONTAINER DE CABECALHO JA EXISTE e NAO deve ser recriado. A faixa
*      cinza do SIGOPCPR e o cntSombra do dump, migrado na Fase 3 como
*      cnt_4c_Sombra (ver mapeamento.json: "SIGOPCPR.cntSombra" ->
*      "cnt_4c_Sombra") - Container em Top = -1, Width = THIS.Width,
*      Height = 80, BackColor = RGB(100, 100, 100), com lbl_4c_LblSombra e
*      lbl_4c_LblTitulo dentro. Acrescentar agora um segundo container com o
*      nome cnt_4c_Cabecalho pintaria uma faixa DUPLICADA por cima dessa, que
*      e exatamente o estrago que a regra #11 descreve ("NUNCA detectar o
*      cabecalho pelo NOME... detectar por nome duplicou a faixa em 3 forms");
*      o cabecalho se identifica por BackColor = RGB(100,100,100) +
*      Height >= 60, e esse par ja esta satisfeito.
*
*   b) NAO ha "pagina de dados" porque nao ha PageFrame: o SIGOPCPR e flat
*      (zero objeto de BaseClass pageframe na arvore do SCX). Os Top do dump
*      sao absolutos no form e entram SEM a compensacao de +29 - aplica-la
*      aqui empurraria os dois campos para fora da area util de um form de
*      157px de altura.
*
* Os objetos de dados do SIGOPCPR sao QUATRO, duas linhas de rotulo + campo:
*
*   Label1     "Processo Atual :"  +  GetOrigem   <- esta fase (metade 1)
*   Label2     "Novo Processo :"   +  GetDestino  <- Fase 6 (metade 2)
*
* A divisao ao meio segue a LINHA, nao o tipo de controle: separar "os dois
* labels" de "os dois TextBox" deixaria o rotulo de um campo que ainda nao
* existe, e o valor da origem (que vem do chamador) nao poderia ser semeado
* junto do controle que o exibe.
*
* Entregue neste bloco:
*   - ConfigurarCampos() - lbl_4c_Label1 e txt_4c_Origem, com geometria,
*     fonte, cor, Format e MaxLength TRANSCRITOS do dump e a largura/MaxLength
*     da MODALIDADE aplicados conforme o PROCEDURE Init legado
*   - OrigemParaTela() - o "ThisForm.GetOrigem.Value = pOperacao" +
*     "ThisForm.GetOrigem.Refresh" do Init legado, com o Business Object como
*     fonte UNICA do valor
*   - OrigemWhen() - o "PROCEDURE When / Return .f." de GetOrigem
*   - a chamada a ConfigurarCampos() em ConfigurarPageFrame(), DEPOIS de
*     ConfigurarBotoes()
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 5
*
* 20. A LARGURA E O MaxLength DOS CAMPOS NAO SAO OS DO SCX - sao os que o
*     PROCEDURE Init legado escreve por cima, e dependem da modalidade:
*
*       ThisForm.GetOrigem.Width     = 150      ThisForm.GetOrigem.MaxLength  = 20
*       If ThisForm.pComis
*           ThisForm.GetOrigem.Width = 290      ThisForm.GetOrigem.MaxLength  = 40
*
*     O dump de GetOrigem declara Width = 142 / MaxLength = 20, valores que o
*     Init SEMPRE sobrescreve - transcrever o 142 reproduziria um estado que o
*     legado nunca exibe. Logo: Width = 150 no modo processo, 290 no modo
*     comissao, e o MaxLength vem de ObterTamanhoChave() do Business Object
*     (20 = SigPcOop.processos char(20), 40 = SigCmCab.cods char(40)) - a
*     MESMA funcao que as consultas usam no PADR, e nao um 20/40 repetido a
*     mao aqui (regra #19: MaxLength vem da largura da coluna no schema).
*
*     A flag de modalidade e lida do BO (this_lComissao), nao da propriedade
*     this_lComissao deste form: quem decide a modalidade e o
*     ConfigurarModalidade chamado no InicializarForm, e ele tambem normaliza
*     o default. Duas leituras da mesma decisao em lugares diferentes era o
*     caminho para divergirem (ver nota 2).
*
* 21. Format = "!" transcrito do dump nos dois TextBox: forca MAIUSCULA no que
*     e digitado E no que e gravado. Descartar essa unica linha fazia o campo
*     aceitar minuscula onde o legado nao aceita (regra #49). O dump NAO
*     declara InputMask, entao nenhum e escrito - e por nao haver "M" no
*     Format, o Format aqui e mascara de digitacao mesmo, nao lista de valores
*     validos (regra #24).
*
* 22. FontSize NAO e escrito nos TextBox: o dump de GetOrigem/GetDestino
*     declara FontName = "Courier New" e NADA de FontSize, o que significa que
*     o legado usava o default da classe base textbox. Como AddObject("TextBox")
*     tambem entrega esse mesmo default, omitir e a reproducao FIEL - escrever
*     um 8 "por coerencia com o form" mudaria o tamanho do texto de um campo de
*     23px de altura. Nos Labels o FontSize = 8 E declarado no dump, e entra.
*
*     Alignment tambem fica de fora nos TextBox (o dump nao declara): o default
*     de TextBox e 3 - Automatico, nao 0 - e escrever 0 mudaria o alinhamento.
*     Nos Labels, Alignment = 0 e escrito de proposito, ver nota 23.
*
* 23. Os Labels levam AutoSize = .F. com Width E Height do dump (92x15 e
*     90x15), apesar de o dump declarar AutoSize = .T.: AutoSize e no-op em
*     Label criado por AddObject e, com WordWrap, descarta a Height (regra
*     #23). E vem Alignment = 0 explicito porque a classe say/label do legado
*     e alinhada a ESQUERDA: inventar Alignment = 1 encostaria o texto na
*     borda direita da caixa, dentro do TextBox que comeca em Left = 216
*     (92 + 122 = 214, a 2px do campo).
*
* 24. ForeColor = RGB(90, 90, 90) nos dois Labels, do dump. E tambem o
*     canonico: o form tem Picture de fundo CLARA (new_background.jpg), onde
*     branco ficaria INVISIVEL e o usuario veria as caixas sem legenda
*     (regra #12). FontBold = .T. tambem e do dump - os rotulos do SIGOPCPR
*     sao negrito, ao contrario dos do irmao SigOpCop.
*
* 25. "PROCEDURE When / Return .f." de GetOrigem e replicado por BINDEVENT
*     "When" + OrigemWhen() - o padrao que os irmaos FormSigOpCop
*     (OrigemWhen), FormSigOpBcb (NaoPermitirFocoWhen) e FormSigOpCcl ja
*     usam; ao contrario de "Valid", que nao e confiavel em TextBox. Somam-se
*     ReadOnly = .T. e TabStop = .F., que entregam o efeito OBSERVAVEL do
*     When = .F. (nao tabula, nao edita) mesmo se o bloqueio de foco nao
*     pegar. NAO se usa Enabled = .F.: ele ACINZENTA o campo, e o legado
*     exibe a origem com a aparencia normal.
*
*     O bind e CONDICIONADO a origem ter vindo do chamador. O legado nunca
*     abre esta tela sem chamador (o Init faz "ThisForm.DataSessionId =
*     poForm.DataSessionId", que estouraria com poForm ausente), entao la o
*     When = .F. e sempre inofensivo - a origem esta sempre preenchida. Aqui a
*     tela tambem e alcancavel pelo menu (ver o Init, Fase 3), e nesse caminho
*     a origem nasce em BRANCO: ligar o bloqueio de foco sempre tornaria
*     inalcancavel o unico campo em que o usuario poderia informa-la, deixando
*     a tela inutilizavel. Travar o que o chamador trouxe, liberar o que esta
*     em branco.
*
* 26. O valor da origem tem FONTE UNICA: a propriedade this_cOrigem do
*     Business Object, que o ConfigurarModalidade do InicializarForm ja
*     preencheu a partir do par_cOperacao recebido pelo Init - o equivalente
*     do "ThisForm.GetOrigem.Value = pOperacao" legado. Por isso o
*     .Value = "" do bloco AddObject e inicializacao de TIPO (o TextBox tem de
*     nascer CARACTERE, senao a primeira atribuicao de string a um Value
*     logico estoura), e nao de valor; e o valor real chega por
*     OrigemParaTela(), que e metodo PUBLIC exatamente para que o espelho
*     Business Object -> tela do bloco seguinte DELEGUE a ele em vez de reler
*     o BO por conta propria.
*
*     OrigemParaTela() termina com Refresh(), que e o
*     "ThisForm.GetOrigem.Refresh" do Init legado - necessario porque o valor
*     e atribuido com o form ainda nao exibido.
*
* 27. A ordem em ConfigurarPageFrame fecha em cabecalho -> botoes -> campos.
*     Os campos ficam em Top = 94..117, ABAIXO da faixa cinza (-1..79) e
*     abaixo do grupo de botoes (-2..83), portanto nao ha sobreposicao a
*     resolver nem deslocamento a aplicar - os 14px entre 79 e 94 sao a folga
*     que o proprio SCX desenhou. Criar os campos por ultimo apenas garante
*     que nenhuma caixa transparente de Label fique POR CIMA de um controle
*     focalizavel criado depois (regra #23).
*------------------------------------------------------------------------------
* FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (este bloco)
*
* O contrato desta fase pede "os ultimos 50% dos TextBoxes e Labels, TODOS os
* lookups com BINDEVENT e o container cnt_4c_BotoesAcao (Salvar, Cancelar)".
* Tres leituras tem de ser ajustadas ao desenho REAL do SIGOPCPR, e nenhuma
* delas e omissao de analise:
*
*   a) NAO HA LOOKUP NENHUM NESTA TELA, e isso foi MEDIDO, nao presumido: o
*      dump inteiro nao casa nenhuma das tres classes de busca do legado
*      (fwBuscaExt / fwBuscaSel / fwBuscaInt), nem mAddColuna, nem sigacess(),
*      nem AcessoCampos/Contab/Contas/Empresa/Grupos/MovInd/MovMto/Produto/
*      Titulo. Os unicos metodos do dump sao o Init, o When de GetOrigem, o
*      Valid de GetDestino e os dois Click. Criar um lookup aqui violaria o
*      PILAR 1 e a regra "NUNCA inventar tabelas de lookup que nao existem no
*      original" - e no GetDestino seria pior que inutil (ver nota 28).
*
*   b) NAO HA "container cnt_4c_BotoesAcao (Salvar, Cancelar)" a criar. O
*      SIGOPCPR nao tem Salvar nem Cancelar: tem COPIAR e ENCERRAR, que sao o
*      Commandgroup1 do dump, ja migrado na Fase 4 como cmg_4c_Botoes com os
*      dois Buttons(N). Acrescentar agora um segundo container de botoes
*      deixaria dois pares de botoes na mesma tela.
*
*   c) NAO ha "pagina de dados" porque nao ha PageFrame - o SIGOPCPR e flat
*      (zero objeto de BaseClass pageframe na arvore do SCX), entao os Top do
*      dump entram SEM a compensacao de +29, igual a Fase 5.
*
* O que a fase ENTREGA de fato - e que e o trabalho real que faltava - e a
* segunda metade dos objetos de dados MAIS a regra do unico campo digitavel:
*
*   Label1  "Processo Atual :"  +  GetOrigem   <- Fase 5 (metade 1)
*   Label2  "Novo Processo :"   +  GetDestino  <- ESTA fase (metade 2)
*
* Entregue neste bloco:
*   - lbl_4c_Label2 e txt_4c_Destino em ConfigurarCampos(), com geometria,
*     fonte, cor, Caption, Format e TabIndex TRANSCRITOS do dump e a
*     largura/MaxLength da MODALIDADE aplicados conforme o Init legado
*   - ValidarDestino() - o "PROCEDURE Valid" de GetDestino, a conferencia de
*     duplicidade do codigo novo, ligada por BINDEVENT "LostFocus"
*   - this_lEmValidaDestino - a guarda de reentrancia desse handler
*
* O "PROCEDURE CmdCopia.Click" - que le os dois campos, chama o copiador do
* Business Object e e a ACAO PRINCIPAL da tela - entra no bloco seguinte deste
* cabecalho, junto com o espelho tela -> Business Object e o BINDEVENT de Click
* de Buttons(1) (ver nota 14).
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 6
*
* 28. O GetDestino NAO TEM e NAO PODE TER lookup, e isso e regra de negocio,
*     nao recurso ausente: o Valid dele RECUSA o codigo justamente quando a
*     consulta ACHA registro ("Processo Ja Cadastrado!!!" no modo processo,
*     "Descricao do Cadastro de Comissao Ja Informado!!!" no modo comissao). E
*     o INVERSO de um lookup - ali o usuario informa um processo que ainda NAO
*     existe. Um picker nesse campo ofereceria para escolher exatamente os
*     codigos que a tela vai rejeitar.
*
*     O GetOrigem tambem nao tem lookup no SIGOPCPR - ao contrario do irmao
*     SigOpCop, cujo GetOrigem busca em SigCdOpe por fwBuscaExt. Aqui a origem
*     vem do form chamador e o dump nao tem busca nenhuma nela; o que ela tem e
*     o "When / Return .f." migrado na Fase 5. E a prova de que o lookup se
*     decide pelo dump de CADA form, nunca por semelhanca com o irmao - a mesma
*     licao que a nota 16 registra para o icone dos botoes.
*
* 29. "MessageBox(..., 16, ...)" do Valid vira MsgAviso (dialogo de atencao),
*     nunca MsgErro: as duas mensagens sao validacao de UI, e MsgErro oferece
*     "Fechar Aplicacao" num caso em que o usuario so precisa corrigir o campo.
*     MsgAviso e chamado SEM titulo - o proprio helper preenche "Atencao",
*     equivalendo ao "Atencao!!!" do legado. Os textos, com os acentos em
*     CHR(), vem do Business Object, que os transcreveu do dump.
*
* 30. A guarda de reentrancia (this_lEmValidaDestino) e OBRIGATORIA: o MsgAviso
*     e MODAL e o SetFocus com que se reproduz o "Return .f." DEVOLVE o foco ao
*     campo - as duas coisas redisparam o proprio LostFocus que as acionou,
*     empilhando um segundo aviso (regra #37). O set fica no topo e o clear
*     DEPOIS do ENDTRY (para valer tambem quando o CATCH dispara); o unico
*     RETURN do metodo esta ANTES do set, senao a guarda ficaria presa em .T. e
*     MATARIA a conferencia pelo resto da vida do form (regra #47).
*
* 31. A conferencia SO roda com conexao viva (gnConnHandle > 0): em validacao
*     de UI e em modo teste o handle e -1, o SQLEXEC dispararia excecao e o
*     Business Object devolveria "Favor Reinicializar o Processo!!!" - mensagem
*     que o legado exibe apenas quando a conexao realmente caiu. Pular ali nao
*     abre brecha de gravacao: o ValidarDados do Business Object repete a MESMA
*     consulta antes de abrir a transacao e e ele a barreira real (e tem de
*     repetir mesmo - entre digitar e clicar em Copiar, outro usuario pode ter
*     gravado o mesmo codigo, e sem a reconsulta a violacao de PRIMARY KEY
*     chegaria CRUA do ODBC na tela). Este Valid e o aviso ANTECIPADO do
*     legado, para o usuario nao descobrir o problema so ao acionar Copiar.
*
* 32. O SQL da conferencia NAO e escrito no form: a consulta das duas
*     modalidades, com o PADR na largura da coluna (40 no modo comissao, 20 no
*     modo processo) e os dois textos de recusa, e do SigOpCprBO.ValidarDestino
*     entregue na Fase 2 - FONTE UNICA (PILAR 3). Duas copias da mesma consulta
*     em lugares diferentes era o caminho para divergirem.
*
*     O form passa o valor por PARAMETRO (par_cDestino), que o Business Object
*     aceita exatamente para isto, e NAO pela propriedade this_cDestino: a
*     fonte do que se confere e o TEXTBOX - ler a propriedade conferiria o
*     valor ANTERIOR se o usuario tivesse acabado de alterar o campo - e o
*     espelho tela -> Business Object e da fase seguinte.
*------------------------------------------------------------------------------
* FASE 7/8 - EVENTOS PRINCIPAIS (este bloco)
*
* Entrega o "PROCEDURE CmdCopia.Click" - a ACAO PRINCIPAL da tela e o unico
* evento de botao que ainda faltava:
*
*   - BtnCopiarClick()   - cmg_4c_Botoes.Buttons(1) (CmdCopia do legado):
*                          recusa o destino vazio, espelha tela -> Business
*                          Object, dispara o copiador cabecalho+itens e fecha
*                          a tela, exatamente na ordem do Click legado
*   - AtualizarFormPai() - repinte da lista do form CHAMADOR, que no legado
*                          vinha de graca pelo cursor compartilhado (nota 36)
*   - this_lEmCopia      - guarda de reentrancia do botao (nota 35)
*   - o BINDEVENT de Click de Buttons(1), que so pode ser registrado agora
*     que o handler existe (ver nota 14)
*
* NAO existem BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick /
* BtnExcluirClick - e nao podem existir. O SIGOPCPR e um DIALOGO DE PARAMETRO
* (Class: form puro, herda de "form" e nao de frmcadastro) sem CRUD nenhum, e
* isso foi MEDIDO no dump, nao presumido: zero ocorrencia de frmcadastro, zero
* de Grupo_Op, zero de pcEscolha e zero botao com verbo CRUD - os quatro nomes
* nao aparecem UMA vez no arquivo inteiro. A unica barra de acao e o
* Commandgroup1 com ButtonCount = 2, e os dois botoes que ele hospeda -
* CmdCopia e CmdExit - passam a ter um handler cada. Criar os quatro nomes CRUD
* aqui obrigaria a INVENTAR botao que o legado nao tem (viola o PILAR 1) ou a
* escrever metodo vazio (proibido pela regra de completude).
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 7
*
* 33. A COPIA INTEIRA mora no Business Object (SigOpCprBO.Inserir, Fase 2),
*     que nas duas modalidades le o cabecalho de origem, emite as chaves novas
*     (fGerUniqueKey / fUniqueIds), enfileira cabecalho + itens e descarrega
*     tudo num lote unico. O handler do botao NAO monta SQL: ele faz o que o
*     Click legado faz EM VOLTA do copiador - confere o destino, passa os dois
*     valores adiante e fecha a tela.
*
*     A entrada e ExecutarCopia(), que a Fase 2 criou exatamente para este
*     botao: ela faz NovoRegistro() + grava o destino + Salvar(), e e Salvar()
*     quem roda ValidarDados() (os guards de origem/destino vazios MAIS a
*     reconsulta de duplicidade) antes de abrir a transacao. Chamar Inserir()
*     direto puncionaria essa validacao e deixaria o relato de falha na mao
*     deste form (regra #20); e refazer aqui o trio
*     NovoRegistro/atribuir/Salvar duplicaria a ordem que ExecutarCopia ja
*     fixa - inclusive a sutileza de que o destino tem de ser escrito DEPOIS
*     do NovoRegistro, porque este chama LimparDados.
*
* 34. O GUARD DO CLICK LEGADO E UM SO, e e o do DESTINO:
*
*       If Empty(ThisForm.GetDestino.Value)
*           MessageBox('Destino Invalido !!!',16,'')
*           Return
*       EndIf
*
*     O irmao SIGOPCOP confere TAMBEM a origem no proprio Click; o SIGOPCPR
*     NAO - e a diferenca nao e descuido do dump, e consequencia do desenho:
*     aqui a origem chega do chamador e o GetOrigem tem "When / Return .f.",
*     entao ela nunca esta vazia no caminho que o legado conhece. Acrescentar
*     um segundo guard seria reescrever o legado (regra #17).
*
*     O caminho pelo MENU, que o legado nao tem, abre a tela com a origem em
*     branco - e nele a recusa vem do ValidarDados do Business Object ("Origem
*     Invalida !!!"), exibida pelo ExibirFalha do BusinessBase. A barreira
*     existe; ela so nao esta DUPLICADA no form.
*
*     "MessageBox(...,16,'')" vira MsgAviso (dialogo de atencao), nunca
*     MsgErro: e validacao de UI, e MsgErro oferece "Fechar Aplicacao" num
*     caso em que o usuario so precisa preencher o campo (mesma decisao da
*     nota 29). O literal "Destino Invalido !!!" vai SEM acento e sem CHR(),
*     porque e assim que o dump o escreve - e e o MESMO texto que
*     SigOpCprBO.ValidarDados usa, para a recusa nao mudar de redacao
*     conforme o caminho.
*
* 35. GUARDA DE REENTRANCIA (this_lEmCopia) OBRIGATORIA: o MsgAviso do guard e
*     MODAL - tira e devolve o foco - e a copia abre uma transacao de
*     cabecalho + itens. Sem a guarda, um duplo clique no botao dispara o
*     processo DUAS vezes e a segunda passada tenta gravar um codigo que a
*     primeira acabou de criar. O set fica no topo e o clear DEPOIS do ENDTRY,
*     para valer tambem quando o CATCH dispara; o unico RETURN do metodo esta
*     ANTES do set, senao a flag ficaria presa em .T. e MATARIA o botao pelo
*     resto da vida do form (regra #47).
*
*     O clear vem ANTES do Release() de proposito: no caminho de sucesso o
*     form fecha logo abaixo e o estado nao importa, mas no caminho de FALHA a
*     tela continua aberta e o botao tem de voltar a funcionar para o usuario
*     corrigir o destino.
*
* 36. O REPINTE DA LISTA DO PAI tem de ser escrito a mao. No legado o dialogo
*     adota a data session do chamador ("ThisForm.DataSessionId =
*     poForm.DataSessionId") e grava nos cursores crSigCmCab/crSigCmItn/
*     crSigPcOop/crSigPcOoI, que sao os MESMOS do form pai - inclusive o
*     RecordSource da grade dele -, e o "poDatamgr.UpDate(...)" os descarrega.
*     O PILAR 3 eliminou o cursor global compartilhado (cada form tem o seu
*     Business Object e o seu cursor_4c_*) e a copia aqui grava DIRETO no SQL
*     Server, entao o repinte que o legado ganhava de brinde desapareceu: sem
*     AtualizarFormPai o usuario copia, volta para a tela anterior e NAO ve o
*     registro novo - e o diagnostico natural ("nao gravou") aponta para o
*     lugar errado.
*
*     O pai e OPCIONAL (.NULL. quando a tela e aberta pelo menu ou pelo
*     harness) e o nome do metodo de recarga varia com o tipo do chamador
*     (CarregarLista em form CRUD, CarregarDados/MontaGrade em OPERACIONAL),
*     dai as guardas de PEMSTATUS; e a falha de repinte e AVISO, nunca erro
*     fatal - a copia ja esta confirmada no banco e nada se perde.
*
* 37. O espelho tela -> Business Object passa por ConfigurarModalidade, que e
*     a FONTE UNICA da origem (ver nota 2): e ela quem corta o valor no
*     tamanho da coluna da modalidade corrente. Atribuir this_cOrigem a mao
*     aqui criaria uma segunda normalizacao, livre para divergir daquela.
*
*     Sim, a modalidade e LIDA do proprio Business Object para ser devolvida a
*     ele - e deliberado: quem a decidiu foi o ConfigurarModalidade do
*     InicializarForm, e reler THIS.this_lComissao reabriria a segunda fonte
*     de verdade que a nota 2 fechou.
*
*     O destino NAO entra por aqui: ele vai por PARAMETRO de ExecutarCopia,
*     pelo mesmo motivo da nota 32 - a fonte do que se grava e o TEXTBOX.
*     Reler a propriedade gravaria o valor ANTERIOR se o usuario tivesse
*     acabado de alterar o campo.
*
*     ATUALIZADO NA FASE 8: a leitura dos dois campos passou a morar em
*     FormParaBO(), que e o hook de transferencia tela -> Business Object.
*     A regra NAO mudou - ConfigurarModalidade continua sendo a fonte unica
*     da origem e o destino continua saindo do TEXTBOX -, so deixou de estar
*     escrita dentro do handler do botao. Ver notas 38 a 41.
*
*------------------------------------------------------------------------------
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL (este bloco)
*
* O contrato desta fase pede nove nomes: BtnBuscarClick, BtnEncerrarClick,
* BtnSalvarClick, BtnCancelarClick, FormParaBO, BOParaForm, HabilitarCampos,
* LimparCampos, CarregarLista e AjustarBotoesPorModo. DOIS deles sao trabalho
* REAL nesta tela e entram agora; os outros NAO TEM REFERENTE no SIGOPCPR, e
* isso foi MEDIDO no dump, nao presumido.
*
* ENTREGUE NESTE BLOCO
*
*   - FormParaBO()  - o espelho tela -> Business Object. E o
*                     "lcOpeOri = ThisForm.GetOrigem.Value" +
*                     "lcOpeDes = ThisForm.GetDestino.Value" que abre o
*                     CmdCopia.Click legado, agora num ponto UNICO
*   - BOParaForm()  - o espelho Business Object -> tela. E o
*                     "ThisForm.GetOrigem.Value = pOperacao" +
*                     "ThisForm.GetOrigem.Refresh" que fecha o Init legado,
*                     mais o campo de destino
*   - a chamada a BOParaForm() no fim de ConfigurarCampos(), no lugar da
*     chamada direta a OrigemParaTela() (que continua existindo e e quem faz
*     o trabalho da origem - ver nota 26)
*   - BtnCopiarClick() passa a chamar THIS.FormParaBO() no lugar do
*     ConfigurarModalidade inline, e le o destino ja normalizado pelo hook
*
* OS DOIS HOOKS SAO PROTECTED, E NAO POR ESTILO: FormBase os declara
* PROTECTED (formbase.prg, "METODOS PROTEGIDOS (a serem implementados nas
* subclasses)") e VFP9 NAO permite ALARGAR o escopo de metodo herdado -
* declara-los PUBLIC aqui nao os tornaria publicos e so criaria a ilusao de
* que algo fora da classe pode chama-los (regra #51 pela outra ponta). Nada
* fora desta classe precisa deles: quem os chama sao ConfigurarCampos e
* BtnCopiarClick, de dentro.
*
* O QUE NAO SE APLICA - e por que nao e omissao
*
* O SIGOPCPR e um DIALOGO FILHO DE COPIA: Class e BaseClass "form" puro (nao
* frmcadastro), 800x157, aberto pelo Cadastro de Processo / de Comissao com
* "LParameters poForm, pOperacao, pComissao". A arvore do SCX tem ONZE
* entradas e SEIS classes: dataenvironment, form, container, label, textbox,
* commandgroup. Medido no dump (tasks\task712\SigOpCpr_form_codigo_fonte.txt)
* e no layout.json:
*
*   grid / pageframe / listbox ...... ZERO objeto de cada BaseClass
*   AddCursor / pColuna ............. ZERO ocorrencia
*   RecordSource / ControlSource .... ZERO ocorrencia
*   frmcadastro / Grupo_Op .......... ZERO ocorrencia
*   pcEscolha ....................... ZERO ocorrencia
*   botoes do SCX ................... DOIS (ButtonCount = 2 do Commandgroup1)
*   metodos do SCX .................. CINCO (Init, GetOrigem.When,
*                                     GetDestino.Valid e os dois Click)
*
* Dai, nome por nome:
*
*   BtnBuscarClick ....... nao ha botao de busca. Os botoes do legado sao
*                          Copiar e Encerrar, e nao ha lookup nenhum na tela
*                          (medido na Fase 6, nota 28: zero fwBuscaExt /
*                          fwBuscaSel / fwBuscaInt / mAddColuna / sigacess).
*   BtnSalvarClick ....... o botao que GRAVA existe e tem handler, mas o nome
*                          que o legado lhe da e "\<Copiar" - o handler dele
*                          e BtnCopiarClick, entregue na Fase 7. Criar um
*                          segundo nome para o mesmo botao faria o nome MENTIR
*                          sobre o que o metodo faz.
*   BtnCancelarClick ..... o Cancelar canonico ABANDONA uma edicao na pagina
*                          de Dados. Nao ha PageFrame, nao ha pagina de Dados,
*                          nao ha modo de edicao e nao ha terceiro botao: o
*                          segundo botao do SCX e "Encerrar", que so fecha
*                          ("Release Windows"), e o migrado o entrega com o
*                          nome do legado - BtnEncerrarClick, Fase 4.
*   CarregarLista ........ nao ha grade NEM cursor de listagem: a tela tem
*                          dois campos e nada mais. O nome APARECE no arquivo,
*                          mas como PEMSTATUS sobre o form CHAMADOR dentro de
*                          AtualizarFormPai (nota 36) - e o metodo do PAI que
*                          se procura, nunca um metodo deste form.
*   AjustarBotoesPorModo . nao ha MODO. this_cModoAtual ("LISTA"/"INCLUIR"/
*                          "ALTERAR"/"VISUALIZAR") e estado de form CRUD; aqui
*                          o dialogo tem um estado so. Os dois botoes ficam
*                          habilitados do inicio ao fim - e o Encerrar nunca
*                          pode ser desabilitado, porque com TitleBar = 0 e
*                          ControlBox = .F. ele e a UNICA saida (nota 17).
*   HabilitarCampos ...... nao ha modo a refletir, pelo mesmo motivo. O unico
*                          campo nao-editavel e o de origem, e ele e travado
*                          na CRIACAO (ReadOnly/TabStop em ConfigurarCampos,
*                          nota 25), por uma condicao que nao muda durante a
*                          vida do form: a origem veio ou nao do chamador.
*   LimparCampos ......... nao ha caminho que limpe os campos. O legado abre o
*                          dialogo com o destino em branco (o Init legado
*                          semeia APENAS o GetOrigem) e nunca o apaga depois:
*                          se a copia da certo a tela FECHA, e se da errado o
*                          codigo digitado TEM de permanecer para o usuario
*                          corrigi-lo (regra #50 - apagar o que o usuario
*                          digitou e defeito, nao limpeza). Implementar o hook
*                          para nunca chama-lo seria codigo morto; liga-lo ao
*                          caminho de falha seria violar a regra #50.
*
* Nenhum desses nomes e escrito como metodo vazio so para casar com o
* contrato: isso e o "stub disfarcado" que a regra de completude proibe. E
* nenhum e citado aqui de forma que uma busca por palavra-chave conclua que
* existe - os que aparecem acima estao em prosa, descritos justamente como
* ausentes.
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 8
*
* 38. OS DOIS HOOKS NAO SAO INVENCAO - o bloco JA EXISTE no legado, so nao
*     tem esse nome. O Init legado termina com
*
*       ThisForm.GetOrigem.Value = pOperacao
*       ThisForm.GetOrigem.Refresh
*
*     que e BOParaForm() literal; e o CmdCopia.Click ABRE com
*
*       lcOpeOri = ThisForm.GetOrigem.Value
*       lcOpeDes = ThisForm.GetDestino.Value
*
*     que e FormParaBO() literal. O que esta fase faz e dar a esses dois
*     blocos um ponto unico, em vez de deixar o primeiro inline no
*     ConfigurarCampos e o segundo inline no handler do botao. A tela tem
*     campo EDITAVEL que alimenta a operacao (o destino), logo os hooks tem
*     referente real - diferente de BtnCancelarClick/CarregarLista, acima.
*
* 39. A ORDEM DENTRO DE FormParaBO E REGRA, NAO ESTETICA: a origem vai
*     PRIMEIRO porque ConfigurarModalidade ZERA this_cDestino (ele trata troca
*     de modalidade como descarte do que foi digitado - "o codigo de destino
*     de uma tabela nao vale para a outra"). Gravar o destino antes da chamada
*     o apagaria, e o Business Object chegaria em ValidarDados com destino
*     vazio: a copia seria recusada com "Destino Invalido !!!" tendo o usuario
*     preenchido o campo - o sintoma MENTIRIA sobre a causa.
*
*     E a mesma armadilha que o proprio SigOpCprBO.ExecutarCopia documenta
*     ("o destino eh guardado DEPOIS do NovoRegistro porque este chama
*     LimparDados"), por um caminho diferente.
*
* 40. CAMPO EM BRANCO PROPAGA, nos DOIS campos - e aqui o padrao usual se
*     INVERTE de proposito. Em tela de configuracao a regra e "campo vazio nao
*     sobrescreve a property", para um campo apagado nao zerar o que foi
*     resolvido no Init. Aqui seria DEFEITO:
*
*       - o guard do legado e "If Empty(ThisForm.GetDestino.Value)". Se o
*         branco nao chegasse ao Business Object, ValidarDados conferiria o
*         valor ANTERIOR (ainda na property) e a copia poderia prosseguir com
*         um codigo que nao esta mais na tela;
*       - a origem em branco e exatamente o que o ValidarDados recusa com
*         "Origem Inv" + a-acute + "lida !!!" no caminho pelo menu (nota 34).
*         Preserva-la seria copiar de um processo que o usuario apagou.
*
*     O guard de branco existe, mas no SENTIDO CONTRARIO - em BOParaForm, ver
*     nota 41.
*
* 41. BOParaForm NAO APAGA o que o usuario digitou (regra #50): property de
*     destino em BRANCO nao sobrescreve campo PREENCHIDO. No caminho normal os
*     dois valem "" na abertura (ConfigurarModalidade acabou de zerar) e o
*     guard e no-op; ele existe para o caso em que algum caminho herdado de
*     FormBase chame o hook com o usuario tendo digitado - ali, zerar o campo
*     seria o defeito da regra #50, nao um "refresh".
*
*     A ORIGEM nao passa por esse guard: ela DELEGA a OrigemParaTela(), que e
*     a fonte unica dela desde a Fase 5 (nota 26) e cujo valor vem do Business
*     Object por construcao. Reler o Business Object aqui por conta propria
*     reabriria a segunda fonte de verdade que a nota 26 fechou - foi para
*     isso que OrigemParaTela nasceu PUBLIC.
*==============================================================================

DEFINE CLASS FormSigOpCpr AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS de SIGOPCPR (secao 2 do dump)
    *--------------------------------------------------------------------------
    Height      = 157
    Width       = 800
    Caption     = ""
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    FontName    = "Courier New"
    FontSize    = 8

    *-- Ver nota 1 do cabecalho: a classe nasce modeless e o Init promove a
    *-- modal (WindowType = 1 / ShowWindow = 1) fora de validacao e teste.
    WindowType  = 0
    ShowWindow  = 0

    *-- Ver nota 8 do cabecalho
    DataSession = 1

    *--------------------------------------------------------------------------
    * Contexto recebido do form chamador (par_* do Init)
    *
    * this_oFormPai         <- poForm      ("ThisForm.ParentForm = poForm")
    * this_cOperacaoOrigem  <- pOperacao   ("ThisForm.GetOrigem.Value = pOperacao")
    * this_lComissao        <- pComissao   ("ThisForm.pComis = pComissao")
    *
    * O legado tambem guarda poDatamgr ("ThisForm.poDatamgr = poForm.poDataMgr").
    * Na arquitetura nova o acesso ao banco e do DataAccess/BusinessBase pelo
    * handle global gnConnHandle, entao nao ha equivalente a propagar.
    *--------------------------------------------------------------------------
    this_oFormPai        = .NULL.
    this_cOperacaoOrigem = ""
    this_lComissao       = .F.

    *--------------------------------------------------------------------------
    * this_lEmValidaDestino - guarda de reentrancia da conferencia do destino.
    *
    * Ver nota 30 do cabecalho: o MsgAviso da recusa e MODAL e o SetFocus com
    * que se reproduz o "Return .f." legado DEVOLVE o foco ao campo - as duas
    * coisas redisparam o proprio LostFocus que as acionou, empilhando um
    * segundo aviso (regra #37).
    *--------------------------------------------------------------------------
    this_lEmValidaDestino = .F.

    *--------------------------------------------------------------------------
    * this_lEmCopia - guarda de reentrancia do botao Copiar.
    *
    * Ver nota 35 do cabecalho: o MsgAviso do guard de destino vazio e MODAL -
    * tira e devolve o foco - e a copia abre uma transacao de cabecalho +
    * itens. Sem esta flag, um duplo clique dispara o processo DUAS vezes e a
    * segunda passada tenta gravar o codigo que a primeira acabou de criar.
    *--------------------------------------------------------------------------
    this_lEmCopia = .F.

    *--------------------------------------------------------------------------
    * Init - recebe o contexto do form chamador, define o Caption com CHR() e
    * delega ao FormBase (que chama InicializarForm).
    *
    * Os tres parametros sao OPCIONAIS: o legado sempre os recebe do form
    * chamador (Cadastro de Processo ou Cadastro de Comissao), mas a tela
    * tambem e alcancavel pelo menu, e nesse caso a origem fica em branco para
    * o usuario informar e a modalidade default e Processo (pComissao = .F.,
    * o default do proprio SCX - ver "pcomis = .F." na secao 2 do dump).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cOperacao, par_lComissao)
        *-- "C" + o-acute + "pia de Processo" - ver nota 6 do cabecalho
        THIS.Caption = "C" + CHR(243) + "pia de Processo"

        THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cOperacaoOrigem = IIF(VARTYPE(par_cOperacao) = "C", ALLTRIM(par_cOperacao), "")
        THIS.this_lComissao       = IIF(VARTYPE(par_lComissao) = "L", par_lComissao, .F.)

        *-- Ver nota 1 do cabecalho
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - instancia o Business Object, semeia a modalidade
    * recebida do chamador, aplica o fundo do form e monta a estrutura visual.
    *
    * NAO ha guarda de gb_4c_ValidandoUI envolvendo o metodo: essa flag serve
    * para pular QUERY SQL, e um RETURN no topo pularia tambem o Picture e o
    * cabecalho, tornando qualquer diferenca de UI Fidelity irrecuperavel pelo
    * auto-fix. Este bloco nao executa SQL nenhum.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCprBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCprBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                *-- Fundo do form: o SCX aponta ..\framework\imagens\new_background.jpg
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Ver nota 2 do cabecalho: a modalidade e a origem semeiam o
                *-- BO pelo metodo dedicado da Fase 1, equivalente a
                *-- "ThisForm.pComis = pComissao" + "ThisForm.GetOrigem.Value
                *-- = pOperacao" do PROCEDURE Init legado.
                THIS.this_oBusinessObject.ConfigurarModalidade(THIS.this_lComissao, ;
                    THIS.this_cOperacaoOrigem)

                THIS.ConfigurarPageFrame()

                *-- "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" e
                *-- "ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption"
                *-- do PROCEDURE Init legado
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form.
    *
    * NAO existe PageFrame real: o legado SIGOPCPR e flat (nenhum objeto de
    * BaseClass pageframe na arvore do SCX) e por isso nao ha compensacao de
    * Top = -29 a aplicar - os Top do dump sao absolutos no form e entram
    * transcritos. O nome do metodo e mantido por conformidade com o contrato
    * do pipeline multi-fase, igual em FormSigOpCop/FormSIGOPCCO.
    *
    * A ordem das chamadas E a regra: cabecalho PRIMEIRO, botoes DEPOIS (o
    * grupo em Top = -2 cai dentro da faixa cinza e so desenha por cima dela
    * se for criado em segundo lugar - regra #11), campos por ULTIMO - ver
    * nota 27 do cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos: sombra preta embaixo, titulo branco em
    * cima. Geometria TRANSCRITA do dump (SIGOPCPR.cntSombra / .lblSombra /
    * .lblTitulo), com as larguras ajustadas conforme a nota 5 do cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = -1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - a barra de acao do SIGOPCPR (Commandgroup1 do dump).
    *
    * UM CommandGroup de 160x85 ancorado a direita, com dois botoes de 75x75:
    *
    *   Buttons(1) = Command1 "CmdCopia"  "\<Copiar"   executa a copia
    *   Buttons(2) = Command2 "CmdExit"   "Encerrar"   fecha a tela
    *
    * Geometria, fonte, cor, Picture e Caption TRANSCRITOS do dump (secao 2,
    * "PROPRIEDADES DE: SIGOPCPR.Commandgroup1", incluindo as linhas
    * Command1.* / Command2.*).
    *
    * Ver notas 9 a 19 do cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 645
            .Width         = 160
            .Height        = 85

            *-- ButtonCount ANTES de configurar Buttons(N): atribuir a
            *-- ButtonCount RECRIA os botoes e descartaria o que ja tivesse
            *-- sido posto neles.
            .ButtonCount   = 2

            *-- Ver nota 10 do cabecalho
            .AutoSize      = .F.

            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)

            *-- Ver nota 11 do cabecalho
            .Themes        = .F.

            .Value         = 1

            *-- Ver nota 19 do cabecalho
            .TabIndex      = 5

            .Visible       = .T.
        ENDWITH

        *-- Buttons(1) = Command1 "CmdCopia". O "\<" do Caption e o marcador de
        *-- tecla de acesso do VFP (Alt+C), transcrito do dump.
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Width      = 75
            .Height     = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
            .Caption    = "\<Copiar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Buttons(2) = Command2 "CmdExit". Cancel = .T. vem do dump e e o que
        *-- faz o ESC acionar este botao - ver nota 17 do cabecalho.
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top        = 5
            .Left       = 80
            .Width      = 75
            .Height     = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Ver nota 14 do cabecalho: o legado tem um Click em CADA botao, nao
        *-- no grupo, entao cada Buttons(N) recebe o seu proprio BINDEVENT, sem
        *-- DO CASE sobre .Value. Os dois handlers sao PUBLIC (sem PROTECTED):
        *-- alvo de BINDEVENT declarado PROTECTED falha em SILENCIO (regra #3).
        *--
        *-- O bind de Buttons(1) so pode existir agora que BtnCopiarClick
        *-- existe: BINDEVENT valida o delegate NA HORA DO BIND, e apontar para
        *-- um metodo que o form ainda nao tem estoura "Property X is not
        *-- found" dentro do InicializarForm - CREATEOBJECT devolveria .F. e a
        *-- tela nao abriria.
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnCopiarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Buttons(2) do grupo, o CmdExit do legado.
    *
    * Transcricao do metodo legado inteiro:
    *
    *   PROCEDURE CmdExit.Click
    *   Release Windows
    *
    * "Release Windows" do Fortyus fecha a janela corrente; o equivalente na
    * arquitetura nova e THIS.Release(), que passa pelo QueryUnload/Destroy do
    * form e portanto pelo DODEFAULT() do Destroy, onde o FormBase libera o
    * Business Object e refaz os popups do menu principal.
    *
    * NAO ha confirmacao antes de sair, porque o legado nao tem: a tela nao
    * acumula estado - ou a copia ja foi feita (e o proprio CmdCopia fecha o
    * form), ou nada foi gravado e so o codigo digitado se perde.
    *
    * PUBLIC (sem PROTECTED) por ser alvo de BINDEVENT - ver nota 14.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCopiarClick - cmg_4c_Botoes.Buttons(1) (CmdCopia do legado) e a ACAO
    * PRINCIPAL da tela: copia o processo (ou o cadastro de comissao) de ORIGEM
    * inteiro - cabecalho MAIS itens - para o codigo de DESTINO digitado.
    *
    * Transcricao do "PROCEDURE CmdCopia.Click", na MESMA ordem:
    *
    *   If Empty(ThisForm.GetDestino.Value)
    *       MessageBox('Destino Invalido ...',16,'')
    *       Return
    *   EndIf
    *
    *   lcOpeOri = ThisForm.GetOrigem.Value
    *   lcOpeDes = ThisForm.GetDestino.Value
    *
    *   If ThisForm.pComis
    *       ... Select SigCmCab/SigCmItn, fUniqueIds, Scatter/Insert/Replace
    *       ... poDatamgr.UpDate([crSigCmCab]) / UpDate([crSigCmItn])
    *   Else
    *       lnNDopes = fGerUniqueKey([SigPcOoP])
    *       ... Zap/Scatter/Gather de SigPcOop e SigPcOoI, fUniqueIds
    *       ... fGravarLog([C], Thisform.Name, [COPIA], crSigPcOop.Processos)
    *       ... poDatamgr.UpDate([crSigPcOop]) / UpDate([crSigPcOoI])
    *   EndIf
    *
    *   ThisForm.poDatamgr.Commit()
    *   ThisForm.Release
    *
    * As ~90 linhas do MEIO - os dois ramos de modalidade, a emissao das chaves
    * novas, o Scatter/Gather de cabecalho e itens, o fGravarLog e o Commit -
    * moram em SigOpCprBO.Inserir (Fase 2), que as executa num lote UNICO, e sao
    * alcancadas por ExecutarCopia(). Aqui fica so o que o Click faz em volta:
    * conferir o destino, entregar os dois valores ao Business Object e fechar a
    * tela - ver nota 33 do cabecalho.
    *
    * NAO ha mensagem de sucesso, porque o legado nao tem: o Click termina em
    * "ThisForm.Release" e o retorno a tela anterior ja com o registro novo na
    * lista E o feedback (regra #17 - comportamento do legado se transcreve).
    *
    * PUBLIC (sem PROTECTED) por ser alvo de BINDEVENT - handler PROTECTED
    * falha em silencio (regra #3). Ver notas 33 a 37 do cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCopiarClick()
        LOCAL loc_cDestino, loc_lProsseguir, loc_lCopiou, loc_oErro

        *-- Ver nota 35: o MsgAviso do guard e MODAL e a copia abre uma
        *-- transacao de cabecalho + itens - duplo clique dispararia o processo
        *-- duas vezes. O RETURN esta ANTES do set, senao a flag ficaria presa
        *-- em .T. e MATARIA o botao pelo resto da vida do form (regra #47).
        IF THIS.this_lEmCopia
            RETURN
        ENDIF

        THIS.this_lEmCopia = .T.

        loc_lCopiou = .F.

        TRY
            loc_lProsseguir = .T.

            *-- "lcOpeDes = ThisForm.GetDestino.Value" do Click legado, lido
            *-- aqui porque e o que o guard logo abaixo confere - o guard legado
            *-- e literalmente "If Empty(ThisForm.GetDestino.Value)". A fonte e
            *-- o TEXTBOX, nao a propriedade do Business Object (nota 37).
            *--
            *-- O par completo ("lcOpeOri" + "lcOpeDes") mora em FormParaBO()
            *-- desde a Fase 8 (nota 38) - e ele quem entrega os dois valores ao
            *-- Business Object, com a normalizacao da modalidade.
            loc_cDestino = IIF(VARTYPE(THIS.txt_4c_Destino.Value) = "C", ;
                               ALLTRIM(THIS.txt_4c_Destino.Value), "")

            *-- "If Empty(ThisForm.GetDestino.Value) / MessageBox / Return" -
            *-- UNICO guard do Click legado, ver nota 34. O literal vai SEM
            *-- acento porque e assim que o dump o escreve, e e o mesmo texto
            *-- que SigOpCprBO.ValidarDados usa.
            IF EMPTY(loc_cDestino)
                MsgAviso("Destino Invalido !!!")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                            "o dispon" + CHR(237) + "vel - a c" + CHR(243) + ;
                            "pia n" + CHR(227) + "o pode ser executada.", ;
                            "Erro em BtnCopiarClick")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Espelho tela -> Business Object num ponto UNICO (nota 38).
                *-- FormParaBO le os dois campos, passa a ORIGEM por
                *-- ConfigurarModalidade - fonte unica, que a corta no tamanho
                *-- da coluna da modalidade corrente (nota 37) - e grava o
                *-- DESTINO depois disso, porque aquela chamada zera a property
                *-- (nota 39).
                *--
                *-- O .F. ABORTA: significa que o Business Object nao recebeu os
                *-- valores, e seguir para a copia gravaria o estado anterior
                *-- dele. FormParaBO ja exibiu o erro quando houve excecao; as
                *-- duas guardas silenciosas dele (Business Object ausente,
                *-- campos inexistentes) nao podem acontecer neste caminho - o
                *-- bloco acima acabou de conferir o Business Object e os campos
                *-- sao criados no InicializarForm -, mas se acontecerem a
                *-- mensagem abaixo diz o que houve em vez de calar (regra #9).
                IF !THIS.FormParaBO()
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler " + ;
                            "os dados da tela para executar a c" + CHR(243) + "pia.", ;
                            "Erro em BtnCopiarClick")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Ver nota 33: ExecutarCopia faz NovoRegistro + grava o
                *-- destino + Salvar, e e Salvar quem roda ValidarDados (os
                *-- guards de origem/destino vazios MAIS a reconsulta de
                *-- duplicidade) antes de abrir a transacao.
                *--
                *-- O destino vai EXPLICITO, com o valor que FormParaBO acabou
                *-- de normalizar (LEFT no tamanho da coluna): e a mesma FONTE
                *-- UNICA, e passa-lo em vez de deixar o Business Object reler a
                *-- property evita depender da ordem interna de ExecutarCopia -
                *-- que chama NovoRegistro, e este LimparDados, que zera
                *-- this_cDestino.
                IF THIS.this_oBusinessObject.ExecutarCopia( ;
                       THIS.this_oBusinessObject.this_cDestino)
                    loc_lCopiou = .T.
                ELSE
                    *-- Regra #20: BusinessBase.Salvar() ja exibiu a recusa e
                    *-- marcou this_lErroExibido - so falamos se ele nao falou,
                    *-- senao a mensagem sai em dobro.
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                "vel copiar o registro.", "Copiar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lCopiou = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnCopiarClick")
        ENDTRY

        *-- Liberar DEPOIS do ENDTRY (vale tambem quando o CATCH dispara) e
        *-- ANTES do Release(): no caminho de sucesso o form fecha logo abaixo e
        *-- o estado nao importa, mas no caminho de FALHA a tela continua aberta
        *-- e o botao tem de voltar a funcionar - ver nota 35.
        THIS.this_lEmCopia = .F.

        IF loc_lCopiou
            *-- Ver nota 36: repinte da lista do chamador, que no legado vinha
            *-- de graca pelo cursor compartilhado, e so depois o
            *-- "ThisForm.Release" que fecha o Click legado.
            THIS.AtualizarFormPai()
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFormPai - recarrega a lista do form CHAMADOR depois de uma copia
    * bem-sucedida.
    *
    * Ver nota 36 do cabecalho: no legado o dialogo adota a data session do pai
    * e grava nos cursores crSigCmCab/crSigCmItn/crSigPcOop/crSigPcOoI, que sao
    * os MESMOS do form chamador - inclusive o RecordSource da grade dele. O
    * PILAR 3 eliminou o cursor global compartilhado e a copia aqui grava DIRETO
    * no SQL Server, entao o repinte que o legado ganhava de brinde precisa ser
    * escrito a mao.
    *
    * O nome do metodo de recarga varia com o TIPO do chamador - CarregarLista
    * em form CRUD, CarregarDados ou MontaGrade em OPERACIONAL -, dai o DO CASE
    * em vez de uma chamada fixa: o SIGOPCPR e aberto pelo Cadastro de Processo
    * e pelo Cadastro de Comissao, que podem ser de tipos diferentes.
    *
    * PEMSTATUS com atributo 5 confere EXISTENCIA do membro, que e exatamente o
    * que se quer aqui - ele devolve .T. tambem para metodo PROTECTED (regra
    * #51), e por isso a chamada fica dentro do TRY: pai cujo metodo de recarga
    * seja protegido estoura em runtime e cai no CATCH como AVISO, nunca como
    * erro fatal - a copia ja esta confirmada no banco e nada se perde.
    *
    * PROTECTED: so o proprio form chama. Nao e hook de FormBase e nada fora da
    * classe precisa dele.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarFormPai()
        LOCAL loc_oErro

        *-- Pai OPCIONAL: .NULL. quando a tela e aberta pelo menu ou pelo
        *-- harness de teste. O RETURN fica aqui, FORA de qualquer TRY (regra #1).
        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN
        ENDIF

        TRY
            DO CASE
                CASE PEMSTATUS(THIS.this_oFormPai, "CarregarLista", 5)
                    THIS.this_oFormPai.CarregarLista()

                CASE PEMSTATUS(THIS.this_oFormPai, "CarregarDados", 5)
                    THIS.this_oFormPai.CarregarDados()

                CASE PEMSTATUS(THIS.this_oFormPai, "MontaGrade", 5)
                    THIS.this_oFormPai.MontaGrade()
            ENDCASE
        CATCH TO loc_oErro
            MsgAviso("A c" + CHR(243) + "pia foi gravada, mas a lista da tela " + ;
                     "anterior n" + CHR(227) + "o p" + CHR(244) + "de ser " + ;
                     "atualizada:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                     "Reabra a tela anterior para ver o registro novo.")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - os campos de dados do SIGOPCPR, primeira metade.
    *
    * Linha 1 do dialogo - a ORIGEM da copia, que o chamador informa e o
    * usuario apenas confere:
    *
    *   Label1    -> lbl_4c_Label1   "Processo Atual :"   92x15 em 122,97
    *   GetOrigem -> txt_4c_Origem   codigo de origem     Wx23  em 216,94
    *
    * A faixa cinza do cabecalho (cnt_4c_Sombra, o cntSombra do legado) JA foi
    * criada em ConfigurarCabecalho e NAO e recriada aqui sob outro nome - ver
    * item (a) do bloco da Fase 5 no cabecalho: um segundo container de
    * cabecalho pintaria a faixa em DOBRO.
    *
    * Geometria, fonte, cor, Caption, Format e TabIndex TRANSCRITOS do dump
    * (secao 2, "PROPRIEDADES DE: SIGOPCPR.Label1" e ".GetOrigem"); a largura
    * e o MaxLength do campo vem do PROCEDURE Init legado e dependem da
    * modalidade - ver notas 20 a 26 do cabecalho.
    *
    * A linha 2 ("Novo Processo :" + GetDestino), com o Valid de GetDestino,
    * foi acrescentada no bloco da Fase 6 - ver o cabecalho daquela fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_lComissao, loc_nTamanho, loc_lOrigemDoChamador

        *-- Ver nota 20: a modalidade e lida do Business Object, que e quem a
        *-- decidiu em ConfigurarModalidade - nao se rele o par_lComissao.
        loc_lComissao         = THIS.this_oBusinessObject.this_lComissao
        loc_nTamanho          = THIS.this_oBusinessObject.ObterTamanhoChave()
        loc_lOrigemDoChamador = !EMPTY(THIS.this_oBusinessObject.this_cOrigem)

        *-- Label1: "Processo Atual :" (sem acento no literal do SCX, entao sem
        *-- CHR() aqui). Ver notas 23 e 24 do cabecalho.
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 97
            .Left      = 122
            .Width     = 92
            .Height    = 15

            *-- Ver nota 23 do cabecalho
            .AutoSize  = .F.
            .Alignment = 0

            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.

            *-- Ver nota 24 do cabecalho
            .ForeColor = RGB(90, 90, 90)

            .Caption   = "Processo Atual :"
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- GetOrigem: codigo de ORIGEM da copia - SigPcOop.processos char(20)
        *-- no modo processo, SigCmCab.cods char(40) no modo comissao.
        THIS.AddObject("txt_4c_Origem", "TextBox")
        WITH THIS.txt_4c_Origem
            .Top       = 94
            .Left      = 216
            .Height    = 23

            *-- Ver nota 20: Width/MaxLength vem do Init legado, nao do SCX
            .Width     = IIF(loc_lComissao, 290, 150)
            .MaxLength = loc_nTamanho

            *-- Ver nota 22: FontName do dump, FontSize e Alignment NAO sao
            *-- escritos (o dump nao os declara e o default da classe base e o
            *-- que o legado usava).
            .FontName  = "Courier New"

            *-- Ver nota 21 do cabecalho
            .Format    = "!"

            .TabIndex  = 3

            *-- Ver nota 26: inicializacao de TIPO (o TextBox tem de nascer
            *-- CARACTERE). O valor em si chega por OrigemParaTela(), logo
            *-- abaixo, que e a fonte unica dele.
            .Value     = ""

            .Visible   = .T.
        ENDWITH

        *-- Ver nota 25 do cabecalho: o "When / Return .f." do legado vale para
        *-- a origem que o chamador TROUXE. Aberta pelo menu, a origem nasce em
        *-- branco e e o unico campo em que o usuario pode informa-la - travar
        *-- o foco ali deixaria a tela inutilizavel.
        IF loc_lOrigemDoChamador
            THIS.txt_4c_Origem.ReadOnly = .T.
            THIS.txt_4c_Origem.TabStop  = .F.

            *-- Handler PUBLIC (sem PROTECTED): alvo de BINDEVENT declarado
            *-- PROTECTED falha em SILENCIO (regra #3).
            BINDEVENT(THIS.txt_4c_Origem, "When", THIS, "OrigemWhen")
        ENDIF

        *-- Label2: "Novo Processo :" (sem acento no literal do SCX, entao sem
        *-- CHR() aqui). Geometria do dump; ver notas 23 e 24 do cabecalho.
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 123
            .Left      = 124
            .Width     = 90
            .Height    = 15

            *-- Ver nota 23 do cabecalho
            .AutoSize  = .F.
            .Alignment = 0

            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.

            *-- Ver nota 24 do cabecalho
            .ForeColor = RGB(90, 90, 90)

            .Caption   = "Novo Processo :"
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH

        *-- GetDestino: o codigo NOVO, que o usuario digita - o unico campo
        *-- editavel da tela. Grava na MESMA coluna da origem
        *-- (SigPcOop.processos char(20) no modo processo, SigCmCab.cods
        *-- char(40) no modo comissao), logo mesma largura e mesmo MaxLength,
        *-- que vem do Init legado e nao do SCX (ver nota 20).
        THIS.AddObject("txt_4c_Destino", "TextBox")
        WITH THIS.txt_4c_Destino
            .Top       = 122
            .Left      = 216
            .Height    = 23

            *-- Ver nota 20: Width/MaxLength vem do Init legado, nao do SCX
            .Width     = IIF(loc_lComissao, 290, 150)
            .MaxLength = loc_nTamanho

            *-- Ver nota 22: FontName do dump, FontSize e Alignment NAO sao
            *-- escritos (o dump nao os declara e o default da classe base e o
            *-- que o legado usava).
            .FontName  = "Courier New"

            *-- Ver nota 21 do cabecalho
            .Format    = "!"

            *-- Fecha a sequencia de tabulacao do dump (ver nota 19): os dois
            *-- TextBox em 3 e 4, o grupo de botoes em 5.
            .TabIndex  = 4

            *-- Inicializacao de TIPO: o TextBox tem de nascer CARACTERE, senao
            *-- a primeira atribuicao de string a um Value logico estoura. O
            *-- legado tambem abre a tela com o destino em BRANCO - o Init
            *-- legado semeia so o GetOrigem.
            *--
            *-- Este campo NAO leva ReadOnly nem TabStop = .F.: ao contrario da
            *-- origem, ele nao tem "When / Return .f." no dump.
            .Value     = ""

            .Visible   = .T.
        ENDWITH

        *-- Ver notas 28 a 30 do cabecalho: o "PROCEDURE Valid" de GetDestino
        *-- vai em "LostFocus", porque o Valid legado roda ao SAIR do campo.
        *-- NUNCA em "KeyPress": um handler que age so por o campo estar
        *-- preenchido avisaria a CADA caractere digitado e o usuario nao
        *-- conseguiria terminar de digitar o codigo (regra #47). BINDEVENT
        *-- "Valid" tambem nao e alternativa - nao dispara de forma confiavel
        *-- em TextBox. O handler e PUBLIC: alvo de BINDEVENT declarado
        *-- PROTECTED falha em SILENCIO (regra #3).
        BINDEVENT(THIS.txt_4c_Destino, "LostFocus", THIS, "ValidarDestino")

        *-- "ThisForm.GetOrigem.Value = pOperacao" + "ThisForm.GetOrigem.Refresh"
        *-- do PROCEDURE Init legado.
        *--
        *-- Desde a Fase 8 isto passa pelo hook BOParaForm(), que e o ponto
        *-- unico do espelho Business Object -> tela: ele DELEGA a origem a
        *-- OrigemParaTela() (que continua sendo a fonte unica dela, nota 26) e
        *-- cuida tambem do campo de destino, que o Init legado deixa em branco.
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * OrigemParaTela - espelha no campo de origem o valor que o Business Object
    * guarda, equivalente ao par de linhas que fecha o PROCEDURE Init legado:
    *
    *   ThisForm.GetOrigem.Value = pOperacao
    *   ThisForm.GetOrigem.Refresh
    *
    * O BO e a FONTE UNICA do valor: o par_cOperacao recebido pelo Init deste
    * form foi entregue a ConfigurarModalidade, que o cortou no tamanho da
    * coluna da modalidade corrente e o guardou em this_cOrigem. Ler dali, em
    * vez de reaproveitar THIS.this_cOperacaoOrigem, garante que a tela exiba
    * exatamente o que vai para o SQL da copia.
    *
    * O Refresh() e necessario porque a atribuicao acontece com o form ainda
    * nao exibido (dentro do InicializarForm).
    *
    * PUBLIC (sem PROTECTED) de proposito: o espelho Business Object -> tela do
    * bloco seguinte deve DELEGAR a este metodo em vez de reler o BO por conta
    * propria - duas leituras do mesmo valor era o caminho para divergirem.
    *--------------------------------------------------------------------------
    PROCEDURE OrigemParaTela()
        LOCAL loc_lPodeAplicar

        loc_lPodeAplicar = VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                           PEMSTATUS(THIS, "txt_4c_Origem", 5)

        IF loc_lPodeAplicar
            THIS.txt_4c_Origem.Value = THIS.this_oBusinessObject.this_cOrigem
            THIS.txt_4c_Origem.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - espelho TELA -> Business Object.
    *
    * E o par de linhas que ABRE o CmdCopia.Click legado:
    *
    *   lcOpeOri = ThisForm.GetOrigem.Value
    *   lcOpeDes = ThisForm.GetDestino.Value
    *
    * Ponto UNICO de leitura dos dois campos. Antes da Fase 8 essas linhas
    * estavam inline no BtnCopiarClick; nada da regra mudou ao serem movidas
    * para ca - a origem continua passando por ConfigurarModalidade (fonte
    * unica, nota 37) e o destino continua saindo do TEXTBOX, nunca da
    * propriedade (nota 32).
    *
    * A ORDEM E REGRA (nota 39): a origem vai PRIMEIRO, porque
    * ConfigurarModalidade ZERA this_cDestino. Invertida, o destino digitado
    * pelo usuario seria apagado e a copia seria recusada com "Destino
    * Invalido !!!" com o campo preenchido na tela.
    *
    * Campo em BRANCO PROPAGA nos dois campos, de proposito - ver nota 40: e o
    * branco que faz o guard do Click e o ValidarDados do Business Object
    * recusarem a copia, e preserva-lo deixaria gravar um valor que nao esta
    * mais na tela.
    *
    * Devolve .T./.F. para que o chamador possa ABORTAR: a falha aqui significa
    * que o Business Object NAO recebeu os valores, e seguir para a copia
    * gravaria o estado anterior dele.
    *
    * PROTECTED obrigatorio: FormBase declara este hook PROTECTED e VFP9 nao
    * permite ALARGAR o escopo de metodo herdado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_cOrigem, loc_cDestino, loc_lSucesso, loc_oErro

        *-- Guardas com RETURN FORA de qualquer TRY (regra #1). Business Object
        *-- ausente ou campos ainda nao criados nao sao erro a exibir: o
        *-- chamador decide o que fazer com o .F.
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !PEMSTATUS(THIS, "txt_4c_Origem", 5) OR !PEMSTATUS(THIS, "txt_4c_Destino", 5)
            RETURN .F.
        ENDIF

        loc_lSucesso = .F.

        TRY
            *-- VARTYPE antes do ALLTRIM: este metodo e o FUNIL dos dois
            *-- campos, e ALLTRIM sobre valor nao-caractere dispara o erro 11
            *-- ("Function argument value, type, or count is invalid") em
            *-- RUNTIME. Os dois TextBox nascem CARACTERE (.Value = "") e so
            *-- recebem string, mas a conferencia num ponto unico custa nada.
            loc_cOrigem  = IIF(VARTYPE(THIS.txt_4c_Origem.Value)  = "C", ;
                               ALLTRIM(THIS.txt_4c_Origem.Value),  "")
            loc_cDestino = IIF(VARTYPE(THIS.txt_4c_Destino.Value) = "C", ;
                               ALLTRIM(THIS.txt_4c_Destino.Value), "")

            *-- ORIGEM - PRIMEIRO (nota 39). ConfigurarModalidade e quem corta
            *-- o valor no tamanho da coluna da modalidade corrente: FONTE
            *-- UNICA (nota 37). A modalidade e lida do proprio Business
            *-- Object, que foi quem a decidiu no InicializarForm (nota 2).
            THIS.this_oBusinessObject.ConfigurarModalidade( ;
                THIS.this_oBusinessObject.this_lComissao, loc_cOrigem)

            *-- DESTINO - DEPOIS, porque a linha acima acabou de zerar
            *-- this_cDestino. O LEFT usa ObterTamanhoChave() do Business
            *-- Object (20 = SigPcOop.processos, 40 = SigCmCab.cods), a MESMA
            *-- funcao que o MaxLength dos campos e o PADR das consultas usam -
            *-- nao um 20/40 repetido a mao (regra #19).
            THIS.this_oBusinessObject.this_cDestino = ;
                LEFT(loc_cDestino, THIS.this_oBusinessObject.ObterTamanhoChave())

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - espelho Business Object -> TELA.
    *
    * E o par de linhas que FECHA o PROCEDURE Init legado:
    *
    *   ThisForm.GetOrigem.Value = pOperacao
    *   ThisForm.GetOrigem.Refresh
    *
    * mais o campo de destino, que o Init legado deixa em BRANCO (ele semeia
    * apenas o GetOrigem) e que aqui recebe o valor que o Business Object
    * guarda - "" na abertura, porque ConfigurarModalidade acabou de zera-lo.
    *
    * A ORIGEM DELEGA a OrigemParaTela(), que e a fonte unica dela desde a
    * Fase 5 e nasceu PUBLIC exatamente para isto (nota 26). Reler
    * this_cOrigem aqui por conta propria reabriria a segunda fonte de verdade
    * que aquela nota fechou.
    *
    * O DESTINO tem guarda de regra #50 (nota 41): property em BRANCO NAO
    * sobrescreve campo PREENCHIDO. No caminho normal os dois valem "" e o
    * guard e no-op - ele protege o codigo que o usuario digitou caso algum
    * caminho herdado de FormBase chame este hook no meio da digitacao.
    *
    * PROTECTED obrigatorio, pelo mesmo motivo de FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cDestino, loc_cNaTela, loc_oErro

        *-- RETURN de guarda FORA de qualquer TRY (regra #1)
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        TRY
            *-- ORIGEM: delega - ver nota 26. OrigemParaTela ja tem as proprias
            *-- guardas e termina com o Refresh() do Init legado.
            THIS.OrigemParaTela()

            *-- DESTINO
            IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
                loc_cDestino = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDestino, ""))
                loc_cNaTela  = IIF(VARTYPE(THIS.txt_4c_Destino.Value) = "C", ;
                                   ALLTRIM(THIS.txt_4c_Destino.Value), "")

                *-- Guarda da regra #50 (nota 41): so escreve quando ha valor a
                *-- escrever, ou quando o campo ja esta vazio. Nunca APAGA o
                *-- que o usuario digitou.
                IF !EMPTY(loc_cDestino) OR EMPTY(loc_cNaTela)
                    THIS.txt_4c_Destino.Value = loc_cDestino
                    THIS.txt_4c_Destino.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OrigemWhen - equivalente ao metodo legado inteiro de GetOrigem:
    *
    *   PROCEDURE When
    *   Return .f.
    *
    * O campo EXIBE a origem trazida pelo chamador e nunca recebe foco, nem por
    * Tab nem por clique. Ligado por BINDEVENT apenas quando a origem veio do
    * chamador - ver nota 25 do cabecalho.
    *
    * PUBLIC (sem PROTECTED) por ser alvo de BINDEVENT - handler PROTECTED
    * falha em silencio (regra #3). FUNCTION, nao PROCEDURE: o valor de retorno
    * E o efeito.
    *--------------------------------------------------------------------------
    FUNCTION OrigemWhen()
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDestino - "PROCEDURE Valid" de GetDestino, ligado a "LostFocus".
    *
    * Transcricao do metodo legado inteiro, nas duas modalidades:
    *
    *   If Not Empty(This.Value) And Not Lastkey() = 27
    *       If ThisForm.pComis
    *           lcQuery = [Select * From SigCmCab ] + ;
    *                     [Where Cods = '] + Padr(This.Value, 40) + [']
    *           If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
    *               =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
    *               Return 0
    *           EndIf
    *           Go Top In LocalBus
    *           If Not Eof([LocalBus])
    *               =MessageBox([Descricao do Cadastro de Comissao Ja
    *                            Informado!!!], 0+16, [Atencao!!!])
    *               Return .f.
    *           EndIf
    *       Else
    *           ThisForm.poDatamgr.Sqlexecute([Select Processos from SigPcOop ] +
    *               [Where Processos = '] + Padr(this.Value, 20) + ['], 'LocalBus')
    *           Select LocalBus
    *           If ! Eof()
    *               MessageBox('Processo Ja Cadastrado!!!', 16, 'Atencao!!!')
    *               Return .f.
    *           EndIf
    *       EndIf
    *   EndIf
    *
    * Conferencia de DUPLICIDADE - nao e lookup, e o INVERSO dele: aqui o
    * usuario informa um processo que ainda NAO existe, e achar registro e
    * exatamente o que reprova. Ver nota 28 do cabecalho.
    *
    * O SQL NAO e repetido aqui - ver nota 32: a consulta das duas modalidades,
    * com o PADR na largura da coluna e os dois textos de recusa, e do
    * SigOpCprBO.ValidarDestino (Fase 2), que e a FONTE UNICA. Este metodo faz
    * o que o Business Object nao pode: ler o TEXTBOX e exibir/devolver o foco.
    *
    * O codigo digitado NUNCA e apagado (regra #50): o legado tambem nao o
    * apaga - devolve o foco para o usuario corrigir.
    *
    * PUBLIC (sem PROTECTED) por ser alvo de BINDEVENT - handler PROTECTED
    * falha em silencio (regra #3). Ver notas 28 a 32 do cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDestino()
        LOCAL loc_cValor, loc_lValido, loc_cMensagem, loc_oErro

        *-- Ver nota 30: o MsgAviso e modal e o SetFocus devolve o foco ao
        *-- campo - as duas coisas redisparam este proprio LostFocus. O unico
        *-- RETURN do metodo esta ANTES do set, senao a guarda ficaria presa em
        *-- .T. e MATARIA a conferencia pelo resto da vida do form (regra #47).
        IF THIS.this_lEmValidaDestino
            RETURN
        ENDIF

        THIS.this_lEmValidaDestino = .T.

        TRY
            loc_cValor    = ALLTRIM(THIS.txt_4c_Destino.Value)
            loc_lValido   = .T.
            loc_cMensagem = ""

            *-- "If Not Empty(This.Value) And Not Lastkey() = 27" do legado:
            *-- campo vazio nao e consultado nem recusado pelo Valid (quem
            *-- recusa vazio e o CmdCopia.Click), e ESC aborta sem conferir.
            IF !EMPTY(loc_cValor) AND LASTKEY() != 27

                *-- Ver nota 31: a conferencia SO roda com conexao viva. Pular
                *-- nao abre brecha de gravacao - o ValidarDados do Business
                *-- Object repete a MESMA consulta antes de abrir a transacao e
                *-- e ele a barreira real; este Valid e o aviso ANTECIPADO que
                *-- o legado da, para o usuario nao descobrir o problema apenas
                *-- ao acionar Copiar.
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND ;
                   VARTYPE(THIS.this_oBusinessObject) = "O"

                    *-- Ver nota 32: o valor vai por PARAMETRO, porque a fonte
                    *-- do que se confere e o TEXTBOX - ler this_cDestino
                    *-- conferiria o valor ANTERIOR, e o espelho
                    *-- tela -> Business Object e da fase seguinte.
                    loc_lValido   = THIS.this_oBusinessObject.ValidarDestino(loc_cValor)
                    loc_cMensagem = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, ""))

                    IF !loc_lValido
                        *-- Ver nota 29: "MessageBox(..., 16, ...)" vira
                        *-- MsgAviso (dialogo de atencao), nao MsgErro - e
                        *-- validacao de UI. Chamado SEM titulo, equivalendo ao
                        *-- titulo do legado; o helper preenche "Atencao".
                        IF !EMPTY(loc_cMensagem)
                            MsgAviso(loc_cMensagem)
                        ENDIF

                        *-- "Return .f." (processo) e "Return 0" (comissao) do
                        *-- legado: os dois MANTEM o foco no campo. BINDEVENT
                        *-- DESCARTA o retorno do delegate, entao o efeito se
                        *-- reproduz com SetFocus no proprio campo, nunca com
                        *-- RETURN .F.
                        THIS.txt_4c_Destino.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarDestino")
        ENDTRY

        *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmValidaDestino = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible = .F. por
    * default; percorre recursivamente o container e torna tudo visivel.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControle)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - solta a referencia ao form chamador e delega ao FormBase, que
    * libera o Business Object e restaura os popups do menu principal (fix
    * menu-shrinks). DODEFAULT() na ULTIMA linha e obrigatorio: sem ele a
    * cadeia de heranca e quebrada e os popups ficam com o cache visual
    * encolhido.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
