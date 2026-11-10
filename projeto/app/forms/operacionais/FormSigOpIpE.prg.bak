*==============================================================================
* FormSigOpIpE.prg - Form OPERACIONAL: Impressao/Reimpressao de Etiquetas
* Migrado de: tasks\task754\SigOpIpE.SCX (SIGOPIPE)
* Herda de: FormBase
* Layout: FLAT (nenhuma Page) - dialogo FILHO, chamado com
*          "Do Form SigOpIpe With <formPai>, <lGravaPro>"
*
* O QUE ESTA TELA EH
* ------------------
* SIGOPIPE eh o dialogo que o form PAI abre para selecionar/confirmar as
* etiquetas antes de imprimir (SigCdPro/SigMvCab/SigOpEtq, conforme o valor
* de ThisForm.ParentForm.Tipo: UNITARIO/OPERACAO/DIVERSAS/ARQUIVADAS/
* CADASTRO - tasks\task754\SigOpIpE_form_codigo_fonte.txt:2715-2886). Os
* itens efetivamente impressos sao gravados em SigMvIts - tabela que o
* SigOpIpEBO (Fases 1-2) ja cobre (Inserir/Atualizar/CarregarDoCursor).
*
* O dump nao declara PageFrame (raiz "Class: form / BaseClass: form") e so
* tem DOIS Container no inventario de 73 objetos (cntSombra e
* Cnt_Impressora) - layout proprio, sem Page1/Page2 de CRUD.
*
* ESCOPO DA FASE 3/8 - ESTRUTURA BASE
* ------------------------------------
*   DEFINE CLASS + propriedades visuais   transcritas do dump
*   Init(par_oFormAnterior, par_lGravaPro) os dois parametros do legado
*                                         (Lparameters lfFormAnterior,
*                                         llGravaPro)
*   InicializarForm                      BO + montagem da superficie visual
*   ConfigurarPageFrame                  orquestrador da montagem (nome
*                                         mantido por conformidade com o
*                                         contrato do pipeline - nao ha
*                                         paginacao nesta tela)
*   ConfigurarCabecalho                  cntSombra + lblSombra/lblTitulo
*   TornarControlesVisiveis              AddObject nasce com Visible = .F.
*   Destroy                              solta as referencias, reabilita o
*                                         form chamador e repoe o menu
*
* ESCOPO DA FASE 4/8 - GRADE E BOTOES (esta fase)
* ------------------------------------------------
*   ConfigurarGrade                      grd_historico -> grd_4c_Dados, as
*                                         12 Column, os Text1 e o CheckBox
*                                         da coluna de marcacao
*   CriarCursorEtiquetas                 o cursor que alimenta a grade
*                                         (DbEtiqueta no legado) + os 6
*                                         INDEX ON do Init legado
*   MontaGradeEtiquetas                  RecordSource + os 12 ControlSource
*                                         + o que o bind RESETA (larguras,
*                                         cabecalhos, CurrentControl,
*                                         Sparse, ReadOnly, ColumnOrder) +
*                                         GO TOP / Refresh
*   FormatarColunasGrade                 o bloco reaplicavel do acima
*   ConfigurarBotoes                     cntBotoes (4 botoes) e cmdTestaPos
*   AjustarBotoesPorTipoChamador         o "btnDepois.Enabled = .F. se
*                                         ParentForm.Tipo <> 'CADASTRO'" do
*                                         Init legado
*
* POR QUE A FASE 4 NAO TEM "ConfigurarPaginaLista"/"AlternarPagina"
* -------------------------------------------------------------------
* O prompt generico da fase pede Grid + 6 botoes CRUD em Page1 + troca de
* pagina. Aqui vale o ramo FLAT do gate (OPERACIONAL + grd_4c_* + botao +
* metodo de carga), e isso eh MEDIDO no dump, nao afirmado:
*
*   BaseClass: pageframe no dump ........ 0 ocorrencias
*   BaseClass: grid ..................... 1 (grd_historico, classe fwgrade)
*   BaseClass: commandgroup ............. 2 (cntBotoes 4 botoes,
*                                            cmdTestaPos 1 botao)
*   Container no inventario de 73 ....... 2 (cntSombra, Cnt_Impressora)
*
* Sem PageFrame nao ha Page1/Page2, e os 5 botoes do legado sao
* Armazenar/Imprimir/Boleto/Sair/Testar Posicao - nao Incluir/Alterar/
* Excluir. Escrever ConfigurarPaginaLista/AlternarPagina aqui seria metodo
* que nao pagina nada, isto eh, stub disfarcado.
*
* ESCOPO DA FASE 5/8 - CAMPOS PRINCIPAIS, PARTE 1 (esta fase)
* --------------------------------------------------------------
*   ConfigurarTextoLivreEParcelas    Label7/GetTexto (faixa 82..144, acima
*                                    da grade) + Label8/getQtParcs
*   ConfigurarGruposTipoPrecoPeso    Shape1/Shape2 + Opt_Tipo/Label1 +
*                                    opt_Preco/Label3 + opt_peso/Label4 +
*                                    Opt_Conjunto/Label9 (faixa 393..595,
*                                    abaixo da grade)
*
*   O prompt generico da fase pede "Container cnt_4c_Cabecalho + metade dos
*   TextBox/Label de ConfigurarPaginaDados()" - nao se aplica aqui (regra ja
*   registrada no cabecalho da Fase 4: este form nao tem PageFrame nem
*   Page2). Em seu lugar, a METADE desta fase eh a mesma metade que o
*   cabecalho da Fase 4 ja atribuia as fases seguintes ("Fases 5-6: Opt_Tipo,
*   opt_Preco, opt_peso, Cnt_Impressora, getOcoEtiqs/getDOcoEtiqs/
*   getJustifs/getQtParcs/Get_Printer/GetTexto") - dividida ao meio por
*   dependencia visual (as duas faixas acima nao se apoiam em nenhum
*   controle criado na Fase 6) e nao por conveniencia.
*
*   Shape1/Shape2/Shape3 TRANSCRITOS do dump (BackStyle 0, BorderWidth 2,
*   BorderColor 90,90,90) sao as molduras que o legado desenha ATRAS dos
*   tres blocos da faixa inferior - Shape2 em torno de Opt_Tipo, Shape1 em
*   torno de Opt_Conjunto+opt_Preco+opt_peso. Shape3 (Impressoras) fica para
*   a Fase 6, que tambem cria o conteudo que ele moldura.
*
*   OptionGroup e Button SAO MEMBROS NATIVOS da classe OptionGroup (como
*   Text1/Header1 em Column): AddObject cria so o grupo com ButtonCount, e
*   o VFP cria os Buttons sozinho - NAO se faz AddObject de Button.
*
*   Opt_Tipo.ButtonCount = 1 no dump (so "\<a. Rabicho") eh TRANSCRICAO
*   fiel, nao corte: o legado POPULA o resto dos tipos em runtime a partir
*   de um cursor (LocalTpEti, comportamento.json linha ~81) e isso faz parte
*   da carga de dados da Fase 7, nao da criacao de controle desta fase.
*
*   TabIndex de FORM (na faixa 1..N do form inteiro) continua fora desta
*   fase, mesma regra ja registrada no cabecalho da Fase 4 - os dois valores
*   duplicados no dump (10 em opt_Preco/opt_peso/Opt_Conjunto, 9 em
*   Opt_Impressora, 4 em getQtParcs/getOcoEtiqs) sao a prova de que a
*   sequencia so fecha com TODOS os controles existindo (Fase 6). O
*   TabIndex de Opt_Tipo.Option1 = 1 ENTRA, porque eh escopo do GRUPO (regra
*   CLAUDE.md #29/sub-regra de Buttons), nao do form.
*
* ESCOPO DA FASE 6/8 - CAMPOS RESTANTES (esta fase)
* --------------------------------------------------
*   ConfigurarImpressora              Shape3 (moldura) + Cnt_Impressora
*                                     (Opcao_Imp + 4 spinners + Say2..Say5 +
*                                     Chk_Resete) + Opt_Impressora/Label2 +
*                                     Get_Printer/Label5/Label6 + Say5 de
*                                     FORM ("Posicao :")/spn_posetiq
*   ConfigurarOcorrenciaEJustificativa  getOcoEtiqs/getDOcoEtiqs/
*                                     lblOcoEtiqs/ShpOcoEtiqs,
*                                     GetJustifs/lblJustifs/ShpJustifs e a
*                                     property this_lGravaOcorrencia
*   AjustarOrdemTabulacao             TabIndex de FORM, agora que todos os
*                                     controles existem
*
*   Opt_Impressora continua TRANSCRITO com Visible = .F. e fica assim para
*   sempre: o bloco que o populava (With Thisform.Opt_Impressora, linhas
*   3213-3250 do dump) esta inteiro comentado com "*!*" no legado - foi
*   substituido pelo ComboBox Get_Printer ("mena - 05/03/2015 - a lista de
*   impressoras sairam dos radio para o combobox"). Transcrever
*   Visible = .T. aqui ressuscitaria um controle morto que o PROPRIO legado
*   aposentou.
*
*   Get_Printer nasce com RowSourceType = 0 (nenhum) e RowSource = "" - o
*   dump declara RowSourceType = 2 (Alias) + RowSource = "crImpreV", mas
*   esse cursor so existe a partir da Fase 7 (populado por SQL dentro dos
*   ramos por ParentForm.Tipo, igual ao "crImpre" do comportamento.json).
*   Ligar RowSourceType = 2 a um alias ainda inexistente eh o mesmo risco
*   da regra CLAUDE.md #41 (Column.ControlSource contra cursor ausente) -
*   melhor errar para o lado conservador e deixar o bind explicito para
*   quando o alias existir, no mesmo padrao de MontaGradeEtiquetas.
*
*   this_lGravaOcorrencia (propriedade nova, PILAR 3 - o legado usa
*   "ThisForm.GravaOcorrencia" sem prefixo) e os sete controles de
*   Ocorrencia/Justificativa nascem no ESTADO INCONDICIONAL que o Init
*   legado atribui ANTES do "If (Type(...pcEscolha...)=[C]) And ... And
*   (LocalParam.OcoEtiqs = 1)" (linhas 2691-2710): tudo .F./oculto. O
*   RAMO que reacende os sete sob a condicao acima depende de LocalParam
*   (Fase 7) e de ParentForm.pcEscolha, e fica para la - mesma divisao que
*   o cabecalho da Fase 5 ja registrava para o cursor da grade (nasce
*   vazio, populado depois).
*
*   Label6 ("Windows") - UNICA excecao ao ForeColor RGB(90,90,90) desta
*   fase, e deliberada: o dump declara ForeColor = 231,254,253 (quase-
*   branco), que eh exatamente o caso "escurecer p/ cor das labels irmas"
*   da regra CLAUDE.md #12 - aqui a irma eh Label5 ("Sistema"),
*   RGB(90,90,90). Branco quase-invisivel sobre a textura clara da Page
*   teria o mesmo defeito da regra #12 (texto some).
*
*   Colisao de nome corrigida em tasks\task754\mapeamento.json: o
*   GeradorMapeamento produziu "SIGOPIPE.Say5" -> "lbl_4c_Label5", que
*   colide com "SIGOPIPE.Label5" -> "lbl_4c_Label5" - os DOIS sao filhos
*   DIRETOS do form (Say5 eh "Posicao :", Label5 eh "Sistema"), logo o
*   segundo AddObject("lbl_4c_Label5", ...) estouraria "A member object
*   with this name already exists". Diferente dos pares Say2/Say3/Say4/
*   Say5 DENTRO de Cnt_Impressora (que reusam os mesmos nomes Label2..5
*   sem colidir, porque moram em OUTRO container), aqui o pai eh o MESMO
*   objeto. Renomeado para "lbl_4c_Say5" - mesmo tratamento dado a
*   cmg_4c_CntBotoes/cmg_4c_CmdTestaPos na Fase 4 (que tambem corrigiu o
*   mapeamento.json da task).
*
* AjustarOrdemTabulacao TAMBEM nao cabia na Fase 4: TabIndex fora da faixa
* 1..N eh descartado em silencio, e a faixa so fecha quando o ultimo
* AddObject do form existir (Fase 6, ja implementada). Os TabIndex de FORM
* declarados no dump (cntBotoes 1, grd_historico 2, cmdTestaPos 2 - note
* que o legado repete o 2) ficaram para la. Os TabIndex dos Buttons DENTRO
* do CommandGroup sao escopo PROPRIO do grupo (faixa 1..ButtonCount) e por
* isso entraram na Fase 4.
*
* ESCOPO DA FASE 7/8 - EVENTOS (fase anterior, ja implementada)
* ----------------------------------------------------------------
*   Os Click de Armazenar/Imprimir/Boleto/Sair/Testar Posicao, a logica de
*   impressao completa (Impressao/ImprimirSemAgrupamento/ImprimirAgrupado-
*   PorContaOs/GerarOperacaoEtiquetas/TagModelo1/MontaConjunto), o toggle
*   do CheckBox da grade (Column2.Header1.Click marcar/desmarcar todos,
*   GradeCheckMarcar*), a validacao de celula (Column4/Column10 via
*   subclasse de TextBox, regra CLAUDE.md #46) e os lookups de Ocorrencia/
*   Impressora. Nao tem secao de cabecalho propria porque foi escrita antes
*   desta convencao de documentacao ser adotada no arquivo - os metodos tem
*   comentario individual citando a linha do dump.
*
* ESCOPO DA FASE 8/8 - PARAMETROS, TIPOS DINAMICOS, CARGA DE LINHA E
* IMPRESSORAS (esta fase - ULTIMA)
* ----------------------------------------------------------------------
*   CarregarContextoInicial       orquestrador (chamado por Inicializar-
*                                 Form, depois de ConfigurarEventosPrin-
*                                 cipais): Column2.Header1.Tag, opt_Preco
*                                 <- ParentForm.Chk_Preco, this_nOrdemImp
*                                 <- memvar pnordem, e a sequencia abaixo
*   CarregarParametrosSistema     LocalParam/LocalParaC (SigCdPam/SigCdPaC,
*                                 SELECT sem WHERE - tabela de 1 linha)
*   AtualizarVisibilidadeOcorrencia  ramo que religa os 7 controles de
*                                 Ocorrencia/Justificativa (ParentForm.
*                                 pcEscolha + LocalParam.OcoEtiqs)
*   CarregarTiposEtiquetaDinamico SigCdTpe -> LocalTpEti, popula os
*                                 Buttons de obj_4c_Opt_Tipo (substitui o
*                                 unico botao transcrito na Fase 5)
*   CarregarLinhasPorTipoChamador dispatcher dos seis ramos por
*                                 ParentForm.Tipo (UNITARIO/OPERACAO/
*                                 DIVERSAS/ARQUIVADAS/CADASTRO/CONSULTA) -
*                                 cada ramo eh um metodo proprio; DIGITACAO
*                                 fica em ConfigurarModoDigitacao
*   CarregarImpressorasEtiqueta   APRINTERS() casado com SigSyImp/SigCdAcG/
*                                 SigCdmp -> crImpreV, bind de
*                                 cbo_4c_Get_Printer
*   AplicarDefaultsImpressora     Cnt_Impressora <- LocalParam/LocalParaC
*   AjustarBotaoImprimirPorContexto  Buttons(4) (Imprimir) AND-a com
*                                 "ha tipo" e "ha impressora"
*   AjustarReadOnlyQtdsPorLibObss Column6 (Qtds) <- LocalParam.LibObss
*   ConfigurarModoDigitacao       ramo DIGITACAO (SET ORDER TO / APPEND
*                                 BLANK / foco em Column4) e o SetFocus
*                                 de fallback na grade
*
*   DECISOES DESTA FASE:
*   - poDataGrv/fSqlConector (dump 2621-2630, AddCursor de SigEtOcr/
*     SigMvCab/SigMvItn/SigMvIts) NAO foi implementado: eh uma camada de
*     acesso a dados que o projeto substitui por SQLEXEC direto, e os
*     quatro cursores ja sao lidos com guarda USED() pelas Fases 5-7
*     assumindo que podem nao existir. Implementa-lo traria uma camada
*     inteira para uma fase que so precisa de quatro cursores especificos.
*   - CarregarContextoInicial tem TRY/CATCH PROPRIO que nao propaga: SigCdTpe/
*     SigCdmp vazios sao caminho LEGITIMO (grade abre sem tipo/impressora
*     disponivel, igual ao legado), entao falha aqui nao pode travar a
*     abertura da tela (o legado so aborta com "Return 0" em falha de
*     CONEXAO, que nesta arquitetura ja seria detectada antes do form
*     existir).
*   - Ramo CONSULTA depende de uma bateria de memvars PRIVATE/PUBLIC que o
*     chamador legado (SigPrRet) seta antes do "Do Form" - SigPrRet nao
*     esta migrado ainda (conferido com grep no projeto), entao todos os
*     memvars usam o mesmo guard TYPE()!='U' que o proprio Init legado ja
*     usava para pcGdeGrupo/pcCol, com default inerte quando a memvar nao
*     existe (caminho hoje dominante, form testado isolado).
*   - Ramo CONSULTA/pcOperacao: o "If Inlist(LocalOpe.CtrlLotes,1,2) And .F."
*     do legado eh CODIGO MORTO (a constante .F. anula o AND sempre) -
*     transcrito literalmente (nunca executa, igual ao legado) em vez de
*     omitido, para nao haver lacuna funcional frente ao legado.
*   - O ".Value = Iif(.btnImprime.Enabled,1,2)" do CommandGroup de botoes
*     (Init:3265) eh cosmetico (qual botao aparece "pressionado", nao afeta
*     Enabled/Click) e a correspondencia exata entre o indice legado e
*     Buttons(N) migrado nao eh determinavel com certeza - OMITIDO de
*     proposito (documentado em AjustarBotaoImprimirPorContexto), mesmo
*     criterio ja usado para Opt_Impressora.InteractiveChange.
*
* CONTRATO COM O CHAMADOR (regra CLAUDE.md #29 / memoria
* feedback_form_despachante_pai_nunca_liberado)
* ------------------------------------------------------------------------
* O Init legado desabilita o form chamador:
*
*     Thisform.ParentForm = lfFormAnterior
*     If Type('lfFormAnterior') = 'O'
*         lfFormAnterior.Enabled = .F.
*     Endif
*
* e o legado reabilita em DOIS pontos (linhas 2376 e 3814 do dump -
* cntBotoes.Click / cmdTestaPos.Click, ambos fora do escopo desta fase).
* Para o form chamador nunca ficar orfao (travado, sem clique possivel)
* mesmo que a tela feche por um caminho ainda nao migrado, Destroy() desta
* fase ja reabilita par_oFormAnterior como rede de seguranca - os handlers
* das fases 7/8 continuam reabilitando no proprio Click, e quando chegarem
* la essa linha em Destroy() sera no-op (ja reabilitado).
*
* WindowType = 1 e ShowWindow = 1 ficam ESTATICOS (sem guard de
* gb_4c_ValidandoUI/gb_4c_ModoTeste): nenhum metodo desta fase chama
* THIS.Show(), e o harness de instanciacao nao o faz - mesmo padrao de
* FormSigOpIpB/FormSigOpAtu (irmaos "SigOp" sem PageFrame).
*==============================================================================

DEFINE CLASS FormSigOpIpE AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS do dump de SIGOPIPE
    *
    *   Height / Width       600 / 1000
    *   DataSession          1
    *   BorderStyle          2
    *   DoCreate             .T.
    *   ShowTips             .T.
    *   AutoCenter           .T.
    *   TitleBar             0      (sem barra de titulo - cntSombra eh o
    *                                cabecalho, igual ao resto da familia)
    *   ControlBox           .F.
    *   MaxButton/MinButton  .F.
    *   WindowType           1      (modal)
    *   AlwaysOnTop          .T.
    *   FontSize             9
    *   Picture              ..\framework\imagens\new_background.jpg
    *   Caption              "Etiquetas Selecionadas Para Impressao"
    *
    * Caption com CHR(227) (a-til) porque .PRG nao aceita acento literal
    * (regra CLAUDE.md #4). FontName nao consta explicito no dump (so
    * FontSize=9) - "Tahoma" eh a fonte base do framework, mesma usada nos
    * dois labels do cabecalho.
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Height       = 600
    Width        = 1000
    Caption      = "Etiquetas Selecionadas Para Impress" + CHR(227) + "o"
    DataSession  = 1
    BorderStyle  = 2
    DoCreate     = .T.
    ShowTips     = .T.
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    ShowWindow   = 1
    AlwaysOnTop  = .T.
    FontName     = "Tahoma"
    FontSize     = 9

    *--------------------------------------------------------------------------
    * Estado do form
    *
    * this_oFormAnterior eh o "lfFormAnterior" do Init legado - guardado
    * para ser desabilitado/reabilitado (contrato descrito no cabecalho do
    * arquivo). this_lGravaPro espelha "Thisform.GravaPro = llGravaPro".
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_oFormAnterior   = .NULL.   && lfFormAnterior do Init legado
    this_lGravaPro        = .F.     && Thisform.GravaPro do legado

    *-- Thisform.GravaOcorrencia do legado (sem prefixo la - PILAR 3 pede
    *-- this_l aqui). Estado INCONDICIONAL atribuido em ConfigurarOcorrenciaE-
    *-- Justificativa; o ramo que liga esta flag depende de LocalParam e
    *-- esta implementado em AtualizarVisibilidadeOcorrencia (Fase 8).
    this_lGravaOcorrencia = .F.

    *-- Thisform.Ordemimp do legado (Init: "If Type('pnordem')=[U] / =1 /
    *-- Else / =PnOrd / Endif"). O parametro pnordem so existe no Do Form
    *-- do chamador (Fase 8, Init) - aqui fica no mesmo default 1 que o
    *-- legado usa quando o parametro nao veio, e Impressao() (Fase 7) ja
    *-- consome esta property no SET ORDER do ramo agrupado por Tipo.
    this_nOrdemImp = 1

    *-- Thisform.ImpArquivadas do legado (Init nao inicializa - nasce .F.
    *-- por ser propriedade nova do VFP9; setado em Impressao()/
    *-- btnBoleto.Click e lido em btnSair.Click).
    this_lImpArquivadas = .F.

    *-- Reentrancia do funil de Ocorrencia (getOcoEtiqs/getDOcoEtiqs,
    *-- regra CLAUDE.md #37/#47): o lookup eh modal e redispara o proprio
    *-- LostFocus ao reabrir foco no campo.
    this_lEmLookupOcorrencia = .F.

    *-- Guarda de "valor nao mudou" para ValidarOcorrenciaEtiqueta: LostFocus
    *-- dispara SEMPRE que o foco sai do campo (diferente do Valid do legado,
    *-- que so dispara quando o valor MUDA) - sem isto, tabular pelos dois
    *-- campos sem digitar nada repete a consulta SQL a cada saida de campo.
    *-- Combina codigo+descricao porque o mesmo handler atende os dois
    *-- (getOcoEtiqs.Valid e getDOcoEtiqs.Valid no legado).
    this_cUltimoValidarOcorrenciaEtiquetaValidado = ""

    *-- lnTipos/lnImpres do Init legado (Fase 8) - contagens separadas do
    *-- ButtonCount/RowSource efetivos, porque AjustarBotaoImprimirPor-
    *-- Contexto precisa do "existe ALGUM tipo/impressora configurado",
    *-- nao do fallback visual que fica no lugar quando nao existe.
    this_nTotalTiposEtiqueta = 0
    this_nTotalImpressoras   = 0

    *-- Guarda de reentrancia do toggle de CheckBox da grade (regra do
    *-- padrao Click/MouseDown/MouseUp/KeyPress - CLAUDE.md feedback
    *-- GridCheckBoxtog): soh o KeyPress(Enter/Espaco) e o MouseUp
    *-- replicam o Flag; Click/MouseDown soh suprimem o toggle nativo.

    *--------------------------------------------------------------------------
    * this_cCursorEtiquetas - o alias que a grade consome (DbEtiqueta no
    * legado)
    *
    * Renomeado porque o PILAR 3 manda nome novo e porque o cursor eh INTERNO
    * a esta tela - medido: "dbEtiqueta" aparece em 1 unico dump de
    * tasks\ (o proprio SigOpIpE), contra "dbImpressao", que aparece em 10+
    * (sigcdpro, sigregli, sigpdmp6, ...) e por isso eh CONTRATO ENTRE FORMS e
    * tera de manter o nome legado quando a Fase 7 chegar nele.
    *
    * O sufixo "Ipe" nao eh enfeite: este form tem DataSession = 1, ou seja o
    * alias vive na sessao de dados CORRENTE, compartilhada com o form
    * chamador e com o resto da aplicacao. "cursor_4c_Etiquetas" (sem o
    * sufixo) JA EXISTE no projeto - PrlBO.prg:273 faz SQLEXEC nesse alias -
    * e colidir ali derrubaria as duas telas sem erro atribuivel a nenhuma
    * delas. "cursor_4c_IpeEtiquetas" foi conferido: zero ocorrencias em
    * projeto\app\.
    *--------------------------------------------------------------------------
    this_cCursorEtiquetas = "cursor_4c_IpeEtiquetas"

    *==========================================================================
    * Init - recebe os dois parametros do legado (lfFormAnterior, llGravaPro)
    *
    * Legado (SIGOPIPE.Init), transcrito nas linhas que esta fase cobre:
    *
    *   Lparameters lfFormAnterior, llGravaPro
    *   Thisform.ParentForm = lfFormAnterior
    *   If Type('lfFormAnterior') = 'O'
    *       lfFormAnterior.Enabled = .F.
    *   Endif
    *   Thisform.GravaPro = llGravaPro
    *
    * As duas atribuicoes de Caption nos labels da faixa
    * (ThisForm.cntSombra.lblSombra/lblTitulo.Caption) ficam dentro de
    * InicializarForm, que eh onde a faixa passa a existir.
    *
    * O BO eh criado ANTES do DODEFAULT() porque FormBase.Init chama
    * InicializarForm, que ja precisa dele para montar a tela.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1): o resultado passa
    * pela flag loc_lSucesso.
    *==========================================================================
    PROCEDURE Init(par_oFormAnterior, par_lGravaPro)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Legado: Thisform.ParentForm = lfFormAnterior / desabilita
            IF VARTYPE(par_oFormAnterior) = "O"
                THIS.this_oFormAnterior = par_oFormAnterior

                IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
                    THIS.this_oFormAnterior.Enabled = .F.
                ENDIF
            ENDIF

            *-- Legado: Thisform.GravaPro = llGravaPro
            THIS.this_lGravaPro = ConverterParaLogico(par_lGravaPro)

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpIpEBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                THIS.this_cMensagemErro = "Falha ao criar SigOpIpEBO."
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + ;
                    "cio SigOpIpEBO." + CHR(13) + "VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro em FormSigOpIpE.Init")
            ELSE
                *-- FormBase.Init chama InicializarForm
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpIpE.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a superficie visual da tela
    *
    * Picture: o dump traz "..\framework\imagens\new_background.jpg" - o
    * arquivo vive em vbmp\ no sistema novo, alcancado por
    * gc_4c_CaminhoIcones (nunca remontado a partir de gc_4c_CaminhoBase,
    * regra CLAUDE.md #25/#26).
    *
    * Os dois labels recebem o Caption aqui, nao na criacao, porque eh o
    * que o legado faz logo no inicio do Init
    * (ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
    *
    * TornarControlesVisiveis fecha a montagem porque AddObject cria todo
    * controle com Visible = .F.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()

            *-- Legado: lblSombra.Caption / lblTitulo.Caption = ThisForm.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

            *-- AddObject cria tudo com Visible = .F.
            THIS.TornarControlesVisiveis(THIS)

            *-- Fase 7: liga os BINDEVENT de botoes/grade/combos/lookups.
            *-- Depois de TornarControlesVisiveis porque alguns handlers
            *-- (ex. OptTipoInteractiveChange) ja leem .Visible de outros
            *-- controles.
            THIS.ConfigurarEventosPrincipais()

            *-- Fase 8: restante do Init legado (parametros, tipos de
            *-- etiqueta, carga das linhas por Tipo, impressoras). TRY/
            *-- CATCH proprio que nunca propaga - falha aqui NAO bloqueia
            *-- a abertura da tela (ver comentario do metodo).
            THIS.CarregarContextoInicial()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual da tela
    *
    * Nao ha superficie de paginas neste form: o dump declara a raiz
    * SIGOPIPE como "Class: form / BaseClass: form" - form GENERICO, sem
    * nenhum objeto "BaseClass: pageframe" no inventario de 73 objetos. O
    * nome deste metodo eh mantido por conformidade com o contrato do
    * pipeline e ele apenas DELEGA aos configuradores especificos, mesmo
    * desenho dos irmaos FormSigOpEtq/FormSigOpIpB/FormSigOpAtu.
    *
    * A ORDEM DAS CHAMADAS EH REGRA, NAO ESTILO (regra CLAUDE.md #11/#30)
    * --------------------------------------------------------------------
    * O cabecalho vem PRIMEIRO porque os dois CommandGroup ficam DENTRO da
    * banda dele e precisam desenhar POR CIMA - no dump os grupos estao em
    * Top = -2 com Height = 85 (banda -2..83) e o cntSombra em Top = 0 com
    * Height = 80 (banda 0..80), isto eh, se sobrepoem em 0..80 nos dois
    * eixos (cntBotoes Left 691..1004 e cmdTestaPos Left 615..700, ambos
    * dentro dos 0..1000 do container). Invertida a ordem, a faixa cinza
    * COBRE os cinco botoes - sem erro, sem log e sem aparecer em screenshot.
    *
    * A grade vem ANTES dos botoes so por clareza de leitura: ela esta em
    * Top 147..388, nao encosta em ninguem.
    *
    * MontaGradeEtiquetas vem por ULTIMO porque precisa das Column ja
    * criadas E do cursor, e porque atribuir RecordSource reseta propriedades
    * de coluna (regra CLAUDE.md #41).
    *
    * A Fase 5 insere os option groups de Tipo/Preco/Peso/Conjunto e o texto
    * livre; a Fase 6 completa com o Cnt_Impressora e a Ocorrencia/
    * Justificativa. As chamadas vao DEPOIS de ConfigurarBotoes e ANTES de
    * MontaGradeEtiquetas - nenhum desses controles ocupa a banda do
    * cabecalho (o mais alto eh GetTexto em Top 83) nem a area da grade
    * (Top 147..388).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarTextoLivreEParcelas()
        THIS.ConfigurarGruposTipoPrecoPeso()
        THIS.ConfigurarImpressora()
        THIS.ConfigurarOcorrenciaEJustificativa()
        THIS.MontaGradeEtiquetas()
        THIS.AjustarBotoesPorTipoChamador()
        THIS.AjustarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - a faixa cinza do titulo (cntSombra do legado)
    *
    * Geometria TRANSCRITA do dump (SIGOPIPE.cntSombra / lblSombra /
    * lblTitulo): Top 0 / Left 0 / Height 80 / BackColor 100,100,100 /
    * BorderWidth 0, e os dois labels sobrepostos em Top 18 e 17, Left 10,
    * Tahoma 18 bold, WordWrap, Alignment 0 - sombra PRETA embaixo e
    * titulo BRANCO em cima.
    *
    * UNICO desvio, deliberado: as larguras. O dump declara
    * cntSombra.Width = 1004 e os dois labels com Width = 769, mas o form
    * tem Width = 1000 - divergencia de poucos pixels, artefato do Form
    * Designer. Por isso o container usa THIS.Width e os labels
    * THIS.Width - 20, preservando a margem de 10px do Left do dump nos
    * dois lados (regra CLAUDE.md #11).
    *
    * AutoSize = .F. EXPLICITO nos dois labels: com WordWrap = .T. (que o
    * dump declara) um AutoSize = .T. DESCARTA a Height e colapsa o texto
    * para uma linha so (regra CLAUDE.md #23).
    *
    * ForeColor BRANCO em lbl_4c_LblTitulo eh uma das excecoes legitimas da
    * regra CLAUDE.md #12: o container eh OPACO e escuro (BackStyle = 1 +
    * BackColor RGB(100,100,100)), nao a textura clara das paginas de
    * cadastro.
    *
    * Os nomes migrados vem de tasks\task754\mapeamento.json (cntSombra ->
    * cnt_4c_Sombra, lblSombra -> lbl_4c_LblSombra, lblTitulo ->
    * lbl_4c_LblTitulo) - eh esse arquivo que a validacao de fidelidade de
    * UI consulta, entao divergir dele reprovaria a tela sem haver defeito
    * visual.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- lblSombra: sombra preta, desenhada 1px abaixo do titulo
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

        *-- lblTitulo: texto branco por cima da sombra
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

    *==========================================================================
    * ConfigurarGrade - grd_historico do legado (classe fwgrade)
    *
    * Geometria e aparencia TRANSCRITAS do dump (SIGOPIPE.grd_historico):
    * Top 147 / Left 6 / Width 984 / Height 241 / ColumnCount 12 /
    * Arial 8 / HeaderHeight 17 / RowHeight 17 / ScrollBars 3 / Panel 1 /
    * DeleteMark .F. As que o dump NAO declara vem da classe fwgrade
    * (docs\FRAMEWORK_class_codigo_fonte.txt): AllowHeaderSizing .F.,
    * AllowRowSizing .F., GridLineColor 238,238,238,
    * HighlightBackColor 90,90,90.
    *
    * RecordMark = .F. eh o UNICO acrescimo: nem o dump nem a fwgrade o
    * declaram, e o default do VFP9 eh .T. - a regra do projeto para grade
    * criada por AddObject em form OPERACIONAL manda .F. nos dois marcadores,
    * senao aparece a barra de marcacao na lateral esquerda que o legado nao
    * tem (a fwgrade ja traz DeleteMark .F., so faltava o par).
    *
    * NUMERACAO DAS COLUNAS - A ARMADILHA DESTE FORM
    * -----------------------------------------------
    * O legado RENOMEIA quatro Column, e o dump mostra isso em dois lugares
    * que nao concordam: o bloco de propriedades da grade usa o prefixo da
    * POSICAO no SCX (ordem de criacao) e termina cada grupo com o
    * ".Name" REAL, enquanto os blocos "PROPRIEDADES DE: ...ColumnN.Header1/
    * .Text1" e o "With Thisform.grd_Historico" do Init usam o NOME.
    *
    *   posicao no SCX .....  6        7        8        9
    *   .Name declarado ....  Column7  Column8  Column9  Column6
    *
    * Renomear Column eh PROIBIDO (quebra toda referencia .ColumnN), e com
    * ColumnCount = 12 o VFP9 cria Column1..Column12 na ordem de criacao.
    * Logo, neste arquivo a Column<N> eh a POSICAO N do SCX, e o que vale
    * para ela sao: as propriedades do bloco da grade com prefixo <N>, mais o
    * Header1/Text1/ControlSource do bloco cujo NOME esta na tabela acima.
    * Ler os dois pela posicao (ou os dois pelo nome) embaralharia
    * cabecalho, largura, mascara e coluna de dados de quatro colunas - e a
    * tela abriria sem erro nenhum, so com os dados nas colunas erradas.
    *
    * A conferencia que fecha o mapeamento eh semantica: o par
    * cabecalho x ControlSource bate em todas as 12 (Data/Datas,
    * Produto/CPros, "Codigo / Barra"/CBars, Quantidade/Qtds,
    * Observacao/ObsEtiqs, "Ref. Fornecedor"/Reffs, Preco/pVens,
    * Parcelas/Parcelas, "Preco De Conjunto"/PrecoDeCJ,
    * "Preco Conjunto"/pVensCJ). Os ControlSource gravados NO SCX estao
    * OBSOLETOS (ele poe "dbetiqueta.pesos" na coluna "Preco De", e tres
    * colunas sem ControlSource nenhum): quem manda eh o
    * "With Thisform.grd_Historico" do Init legado (linhas 2654-2672), que
    * reatribui os 12 - por isso eh dele que a transcricao sai.
    *
    * Movable/Resizable = .F. em TODAS as 12: o dump declara o par so em
    * algumas (e chega a declarar Movable = .T. na posicao 10), mas o Init
    * legado fecha com "For I=1 To .ColumnCount / .Column&lcCol..Movable =
    * .F. / .Column&lcCol..Resizable = .F. / Next", que sobrepoe o SCX em
    * todas. O estado final eh .F. nas 12.
    *
    * SetAll para a base uniforme (Arial 8 nas Column, nos Header e nos
    * Text1; BorderStyle 0 / Margin 0 / preto sobre branco nos Text1;
    * Alignment 2 nos Header) porque esses valores sao IDENTICOS nos 12
    * blocos do dump - 12 blocos WITH repetindo as mesmas 6 linhas esconderia
    * justamente as diferencas, que ficam explicitas logo abaixo.
    *
    * Text1 e Header1 sao membros NATIVOS da Column: nao se cria e nao se
    * renomeia. O CheckBox da coluna de marcacao, nao - esse EXIGE AddObject
    * (regra CLAUDE.md #18), e sem o CurrentControl (em FormatarColunasGrade)
    * ele existe e NAO desenha.
    *
    * ControlSource, RecordSource, larguras e cabecalhos NAO entram aqui:
    * ligar coluna a cursor que ainda nao existe derruba o Init (regra
    * CLAUDE.md #41), e o bind reseta largura/cabecalho. Tudo isso mora em
    * MontaGradeEtiquetas.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        *-- Legado: Thisform.grd_Historico.RecordSource = '' antes do cursor
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 12

        WITH loc_oGrid
            .Top                = 147
            .Left               = 6
            .Width              = 984
            .Height             = 241
            .FontName           = "Arial"
            .FontSize           = 8
            .HeaderHeight       = 17
            .RowHeight          = 17
            .ScrollBars         = 3
            .Panel              = 1
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(90, 90, 90)
            .Enabled            = .T.
            .Visible            = .T.
        ENDWITH

        *-- Base uniforme dos 12 blocos do dump
        WITH loc_oGrid
            .FontName = "Arial"
            .FontSize = 8
            .SetAll("Movable",   .F.,     "Column")
            .SetAll("Resizable", .F.,     "Column")

            .SetAll("FontName",  "Arial", "Header")
            .SetAll("FontSize",  8,       "Header")
            .SetAll("Alignment", 2,       "Header")

            .SetAll("FontName",    "Arial",            "TextBox")
            .SetAll("FontSize",    8,                  "TextBox")
            .SetAll("BorderStyle", 0,                  "TextBox")
            .SetAll("Margin",      0,                  "TextBox")
            .SetAll("ForeColor",   RGB(0, 0, 0),       "TextBox")
            .SetAll("BackColor",   RGB(255, 255, 255), "TextBox")
            .SetAll("Visible",     .T.,                "TextBox")
        ENDWITH

        *-- Posicao 2 (.Name "Column2") - a coluna de marcacao.
        *-- O CheckBox EXIGE AddObject (regra #18); geometria do dump
        *-- (Top 44 / Left 20 / 60x17 / Alignment 1 / Caption vazio).
        *-- .Value = 0 NUMERICO, nunca .F. - misturar tipo estoura
        *-- "Operator/operand type mismatch" no primeiro uso.
        loc_oGrid.Column2.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oGrid.Column2.chk_4c_Check1
            .Top       = 44
            .Left      = 20
            .Width     = 60
            .Height    = 17
            .FontName  = "Arial"
            .FontSize  = 8
            .Alignment = 1
            .AutoSize  = .F.
            .Caption   = ""
            .Value     = 0
            .Enabled   = .T.
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Posicao 4 (.Name "Column4") - "Codigo / Barra". Trocado de Text1
        *-- (nativo da Column) para a subclasse TextBoxCodBarrasIpE_4c
        *-- (DEFINE CLASS fora de FormSigOpIpE, fim deste arquivo): BINDEVENT
        *-- em "Valid" de TextBox de Column NAO eh confiavel (regra CLAUDE.md
        *-- #46) - GotFocus/Valid tem de ser METODO DE CLASSE, delegando para
        *-- THISFORM, igual ao padrao TextBoxProdutoLpr_4c do FormLpr.
        *-- A mascara esta no controle, e o dump ZERA Column4.Format (override
        *-- vazio do Form Designer - regra CLAUDE.md #49: nao se transcreve).
        loc_oGrid.Column4.AddObject("txt_4c_CodBarras", "TextBoxCodBarrasIpE_4c")
        WITH loc_oGrid.Column4.txt_4c_CodBarras
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .InputMask   = "99999999999999"
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
        loc_oGrid.Column4.CurrentControl = "txt_4c_CodBarras"
        loc_oGrid.Column4.Sparse         = .F.

        *-- Mascaras declaradas no nivel da COLUNA (ela propaga para o
        *-- CurrentControl). Posicao 5 declara o par tambem no Text1, com o
        *-- MESMO valor - redundancia do SCX, nao divergencia.
        loc_oGrid.Column5.Format     = "999,999.99"
        loc_oGrid.Column5.InputMask  = "999,999.99"

        loc_oGrid.Column6.Format     = "9,999.99"
        loc_oGrid.Column6.InputMask  = "9,999.99"

        *-- Posicao 9 (.Name "Column6") declara InputMask SEM Format
        loc_oGrid.Column9.InputMask  = "999,999.99"

        loc_oGrid.Column11.Format    = "999,999.99"
        loc_oGrid.Column12.Format    = "999,999.99"

        *-- Posicao 10 (.Name "Column10") - "Parcelas". Mesma troca de
        *-- Text1 por subclasse, pelo mesmo motivo (Column10.Text1.Valid/
        *-- When do dump).
        loc_oGrid.Column10.AddObject("txt_4c_Parcelas", "TextBoxParcelasIpE_4c")
        WITH loc_oGrid.Column10.txt_4c_Parcelas
            .FontName    = "Arial"
            .FontSize    = 8
            .BorderStyle = 0
            .Margin      = 0
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
        loc_oGrid.Column10.CurrentControl = "txt_4c_Parcelas"
        loc_oGrid.Column10.Sparse         = .F.

        *-- Cabecalho da coluna de marcacao: Picture em vez de Caption.
        *-- O arquivo em vbmp\ eh CHECKBX.BMP (maiusculas) - o FS do Windows
        *-- eh case-insensitive, entao a grafia do dump resolve.
        *-- Tag = "" eh o estado inicial do "marcar/desmarcar todos" do
        *-- legado (Init: Column2.Header1.Tag = []); o Click que alterna esse
        *-- Tag eh da Fase 7.
        WITH loc_oGrid.Column2.Header1
            .Picture     = gc_4c_CaminhoIcones + "checkbx.bmp"
            .ToolTipText = "Marca/Desmarca todos"
            .Tag         = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarCursorEtiquetas - o cursor que alimenta a grade
    *
    * Legado (Init, linhas 2641-2652):
    *
    *   Thisform.ParentForm.poDataMgr.CursorQuery('SigOpEtq','LocalEti','CBars',99999999999999)
    *   Select *, .F. As Flag, 000000000.00 As PrecoDe, 000000000.00 As pvens,
    *       00 As Parcelas, Space(3) As Moedas, Space(40) As Reffs,
    *       Space(30) As Pedido, Space(10) As Obs, .F. As Mantem,
    *       000000000.000 As QtdeEtiq, 000000000.00 As PrecoDeCJ,
    *       000000000.00 As pvensCJ, Space(6) as Categoria, Space(3) as CGrus
    *       From LocalEti Where 0=1 Into Cursor DbEtiqueta Readwrite
    *   <6 x Index On ... Tag ...>
    *
    * O "Where 0=1" eh o ponto: o legado usa LocalEti apenas como MOLDE de
    * estrutura e cria o cursor VAZIO. As linhas chegam depois, nos ramos por
    * ParentForm.Tipo (Fase 7). Aqui o CREATE CURSOR substitui o par
    * CursorQuery + Select-Where-0=1 sem nenhuma ida ao banco, o que tambem
    * torna a tela instanciavel sem conexao.
    *
    * As 47 primeiras colunas sao SigOpEtq na ordem do schema (= a ordem que
    * o "Select *" produz), conferidas em docs\schema.sql com
    * Get-Content -Raw (o arquivo eh UTF-16: grep/findstr devolvem ZERO
    * silenciosamente e fariam coluna existente parecer inexistente - regra
    * CLAUDE.md #14). As 14 ultimas sao os literais do Select acima, com a
    * largura LIDA do literal: "000000000.00" = 9 inteiros + 2 decimais =
    * N(12,2), "000000000.000" = N(13,3), "00" = N(2,0).
    *
    * NULL por coluna, nao por atacado: as 6 colunas que o schema declara
    * NULL (datas, datatrans, dtmovs, dtbals, dtincs, tbdwbi) vao NULL e
    * TODAS as outras vao NOT NULL - os 14 literais inclusive, porque .F.,
    * zero e Space() nao sao nulos. Isso importa em "Flag": nula, ela
    * chegaria ao CheckBox da grade como .NULL. e a celula de marcacao
    * mostraria vazio em vez de desmarcado. Com NULL/NOT NULL explicitos nas
    * 61 colunas o SET NULL ambiente deixa de influir; ele continua sendo
    * ligado/restaurado porque o cursor recebe INSERT/APPEND de cursores
    * vindos do SQL Server nas fases seguintes.
    *
    * UM UNICO ponto de criacao, de proposito: a regra de que todo
    * CREATE CURSOR do mesmo alias tenha a MESMA ordem de campos eh
    * satisfeita por construcao se existir um so. Todo caminho que precise do
    * cursor chama este metodo.
    *
    * Os 6 INDEX ON sao os do legado, com os MESMOS nomes de tag (o form le
    * por "Set Order To EmpGruCon" e afins) e sem ALLTRIM nas partes - chave
    * concatenada de char fixo eh POSICIONAL e o padding faz parte dela
    * (regra CLAUDE.md #42).
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorEtiquetas()
        LOCAL loc_lSucesso, loc_oErro, loc_cCursor, loc_cNullAnterior

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorEtiquetas

        *-- Lido ANTES do TRY de proposito: o CATCH precisa dele para repor o
        *-- SET. Lido dentro, uma falha no CREATE CURSOR deixaria SET NULL ON
        *-- vazando do form para o resto da aplicacao, e o proximo
        *-- CREATE CURSOR de QUALQUER tela nasceria com colunas nulaveis que
        *-- ela nao pediu - defeito sem erro e longe da causa.
        loc_cNullAnterior = SET("NULL")

        TRY
            IF USED(loc_cCursor)
                IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                    TABLEREVERT(.T., loc_cCursor)
                ENDIF
                USE IN (loc_cCursor)
            ENDIF

            SET NULL ON

            CREATE CURSOR (loc_cCursor) ( ;
                cbars      N(14, 0) NOT NULL, ;
                contas     C(10)    NOT NULL, ;
                cpros      C(14)    NOT NULL, ;
                datas      T        NULL,     ;
                dopeos     C(20)    NOT NULL, ;
                dopes      C(20)    NOT NULL, ;
                empos      C(3)     NOT NULL, ;
                emps       C(3)     NOT NULL, ;
                grupos     C(10)    NOT NULL, ;
                nops       N(10, 0) NOT NULL, ;
                numeos     N(6, 0)  NOT NULL, ;
                numes      N(6, 0)  NOT NULL, ;
                pesos      N(9, 3)  NOT NULL, ;
                qtds       N(9, 3)  NOT NULL, ;
                transps    L        NOT NULL, ;
                usados     L        NOT NULL, ;
                usuars     C(10)    NOT NULL, ;
                datatrans  T        NULL,     ;
                locals     C(10)    NOT NULL, ;
                ntrans     N(6, 0)  NOT NULL, ;
                obsetiqs   C(10)    NOT NULL, ;
                codcors    C(4)     NOT NULL, ;
                codtams    C(4)     NOT NULL, ;
                localizas  C(10)    NOT NULL, ;
                dtmovs     T        NULL,     ;
                dtbals     T        NULL,     ;
                peso2s     N(9, 3)  NOT NULL, ;
                empdopnums C(29)    NOT NULL, ;
                dtincs     T        NULL,     ;
                pesoms     N(9, 3)  NOT NULL, ;
                usulibs    C(10)    NOT NULL, ;
                apesos     N(9, 3)  NOT NULL, ;
                aqtds      N(9, 3)  NOT NULL, ;
                codamss    C(24)    NOT NULL, ;
                custofs    N(10, 2) NOT NULL, ;
                vlrpromo   N(12, 2) NOT NULL, ;
                moedapromo C(3)     NOT NULL, ;
                moeentrada C(3)     NOT NULL, ;
                moesaida   C(3)     NOT NULL, ;
                vlrentrada N(15, 4) NOT NULL, ;
                vlrsaida   N(15, 4) NOT NULL, ;
                cotentrada N(15, 6) NOT NULL, ;
                cotsaida   N(15, 6) NOT NULL, ;
                vlrconvert N(15, 4) NOT NULL, ;
                cotconvert N(15, 6) NOT NULL, ;
                moeconvert C(3)     NOT NULL, ;
                tbdwbi     C(20)    NULL,     ;
                Flag       L        NOT NULL, ;
                PrecoDe    N(12, 2) NOT NULL, ;
                pvens      N(12, 2) NOT NULL, ;
                Parcelas   N(2, 0)  NOT NULL, ;
                Moedas     C(3)     NOT NULL, ;
                Reffs      C(40)    NOT NULL, ;
                Pedido     C(30)    NOT NULL, ;
                Obs        C(10)    NOT NULL, ;
                Mantem     L        NOT NULL, ;
                QtdeEtiq   N(13, 3) NOT NULL, ;
                PrecoDeCJ  N(12, 2) NOT NULL, ;
                pvensCJ    N(12, 2) NOT NULL, ;
                Categoria  C(6)     NOT NULL, ;
                CGrus      C(3)     NOT NULL)

            IF loc_cNullAnterior = "OFF"
                SET NULL OFF
            ENDIF

            SELECT (loc_cCursor)
            INDEX ON EmpDopNums + Cpros                            TAG EmpDopNums
            INDEX ON EmpOs + Grupos + Contas + Cpros + CodTams     TAG EmpGruCon
            INDEX ON Cpros + CodTams                               TAG Cpros
            INDEX ON Reffs                                         TAG RefFor
            INDEX ON CBars                                         TAG CBars
            INDEX ON Categoria + CGrus                             TAG CatGru

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.

            *-- repoe o SET tambem no caminho de falha
            IF loc_cNullAnterior = "OFF"
                SET NULL OFF
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CriarCursorEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontaGradeEtiquetas - liga a grade ao cursor e repoe o que o bind
    * destroi
    *
    * Reproduz o "With Thisform.grd_Historico" do Init legado (2654-2672) e o
    * "Select DbEtiqueta / Goto Top / Refresh" da linha 3268.
    *
    * Os ControlSource vem do NOME da Column no legado, traduzido para a
    * POSICAO deste arquivo (ver a tabela em ConfigurarGrade):
    *
    *   legado .Column1  -> Column1   Datas        legado .Column7  -> Column6   Qtds
    *   legado .Column2  -> Column2   Flag         legado .Column8  -> Column7   ObsEtiqs
    *   legado .Column3  -> Column3   CPros        legado .Column9  -> Column8   Reffs
    *   legado .Column4  -> Column4   CBars        legado .Column6  -> Column9   pVens
    *   legado .Column5  -> Column5   PrecoDe      legado .Column10 -> Column10  Parcelas
    *                                              legado .Column11 -> Column11  PrecoDeCJ
    *                                              legado .Column12 -> Column12  pVensCJ
    *
    * O cursor eh criado antes de qualquer ControlSource: ligar coluna a
    * cursor inexistente estoura "Alias ... is not found" DENTRO do TRY do
    * InicializarForm, que devolve .F., e ai CREATEOBJECT devolve .F., o
    * "IF VARTYPE(loForm) = 'O'" do chamador nao entra e o usuario aciona a
    * tela e NADA acontece, sem erro visivel (regra CLAUDE.md #41).
    *
    * GO TOP + Refresh no fim porque popular/religar cursor NAO repinta a
    * grade sozinho - o legado fecha exatamente assim, e sem isso a grade
    * fica visualmente vazia com o cursor correto, o que manda o diagnostico
    * para SQL/permissao (regra CLAUDE.md #21).
    *
    * PUBLIC de proposito: eh o funil de (re)carga da grade, chamado pelos
    * ramos por Tipo da Fase 7 e alvo potencial de BINDEVENT - PROTECTED
    * falharia calado no bind e estouraria "Property ... is not found" na
    * chamada de fora (regras CLAUDE.md #3/#51).
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1).
    *==========================================================================
    PROCEDURE MontaGradeEtiquetas()
        LOCAL loc_lSucesso, loc_oErro, loc_cCursor, loc_oGrid

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorEtiquetas

        TRY
            IF !USED(loc_cCursor)
                THIS.CriarCursorEtiquetas()
            ENDIF

            IF USED(loc_cCursor)
                loc_oGrid = THIS.grd_4c_Dados

                *-- Legado: RecordSource = '' e so depois o alias
                loc_oGrid.RecordSource = ""
                loc_oGrid.RecordSource = loc_cCursor

                loc_oGrid.Column1.ControlSource  = loc_cCursor + ".Datas"
                loc_oGrid.Column2.ControlSource  = loc_cCursor + ".Flag"
                loc_oGrid.Column3.ControlSource  = loc_cCursor + ".CPros"
                loc_oGrid.Column4.ControlSource  = loc_cCursor + ".CBars"
                loc_oGrid.Column5.ControlSource  = loc_cCursor + ".PrecoDe"
                loc_oGrid.Column6.ControlSource  = loc_cCursor + ".Qtds"
                loc_oGrid.Column7.ControlSource  = loc_cCursor + ".ObsEtiqs"
                loc_oGrid.Column8.ControlSource  = loc_cCursor + ".Reffs"
                loc_oGrid.Column9.ControlSource  = loc_cCursor + ".pVens"
                loc_oGrid.Column10.ControlSource = loc_cCursor + ".Parcelas"
                loc_oGrid.Column11.ControlSource = loc_cCursor + ".PrecoDeCJ"
                loc_oGrid.Column12.ControlSource = loc_cCursor + ".pVensCJ"

                THIS.FormatarColunasGrade()

                *-- Legado: Select DbEtiqueta / Goto Top / Refresh
                SELECT (loc_cCursor)
                GO TOP
                loc_oGrid.Refresh()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em MontaGradeEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormatarColunasGrade - tudo o que a atribuicao de RecordSource/
    * ControlSource RESETA, reaplicado por inteiro
    *
    * Atribuir RecordSource devolve Column.Width ao default 90 e
    * Header1.Caption a "ColumnN", e zera Column.CurrentControl /
    * Column.Sparse / Column.ReadOnly (regras CLAUDE.md #41/#46). Por isso
    * este bloco vive num metodo proprio e roda DEPOIS de cada bind - todo
    * caminho que mexer em RecordSource tem de chamar este metodo no fim.
    *
    * Larguras e cabecalhos TRANSCRITOS do dump, cada um pela chave certa (a
    * largura pela POSICAO, o cabecalho pelo NOME - ver ConfigurarGrade).
    *
    * CurrentControl eh o que faz o CheckBox APARECER: sem ele a Column2
    * continua desenhando o Text1 dela e o usuario ve ".T."/".F." como texto,
    * sem nada para clicar. E Sparse = .F. (que o dump declara) eh o que o
    * faz aparecer em TODAS as linhas, nao so na linha ativa - numa tela cuja
    * funcao eh escolher quais etiquetas imprimir, isso eh a diferenca entre
    * marcar o que se quer e marcar uma linha (regra CLAUDE.md #18).
    *
    * A ordem do bloco de ReadOnly eh regra, nao estilo: Grid.ReadOnly
    * PRIMEIRO, porque ele PROPAGA para as colunas e sobrescreveria o que
    * viesse antes (regra CLAUDE.md #46). As quatro colunas editaveis do
    * dump sao a de marcacao (posicao 2), Quantidade (6), Parcelas (10) e -
    * so em alguns Tipo de chamador - "Codigo / Barra" (4); esta ultima nasce
    * ReadOnly como o SCX declara, e quem a libera sao os ramos por Tipo da
    * Fase 7.
    *
    * ColumnOrder por ULTIMO e em ordem CRESCENTE de destino: atribuir
    * ColumnOrder INSERE a coluna naquela posicao e empurra as demais, entao
    * so construindo da esquerda para a direita cada coluna ja colocada fica
    * onde foi posta. A ordem de EXIBICAO do legado nao eh a de criacao - eh
    * esta permutacao completa de 1..12, lida do bloco da grade no dump:
    *
    *   exibe 1..12 -> posicao  2, 1, 3, 4, 6, 10, 5, 9, 11, 12, 7, 8
    *   isto eh      marcacao, Data, Produto, Codigo/Barra, Quantidade,
    *                Parcelas, Preco De, Preco, Preco De Conjunto,
    *                Preco Conjunto, Observacao, Ref. Fornecedor
    *
    * ColumnOrder mexe em PIXEL, nao em identidade: Grid.ColumnN continua
    * resolvendo pelo NOME do objeto (ordem de criacao), e so Grid.Columns(n)
    * indexa pela ordem de exibicao - por isso as referencias .ColumnN deste
    * arquivo seguem validas depois desta reordenacao.
    *
    * A posicao 3 nao recebe ColumnOrder no dump (fica no default 3, que eh a
    * propria posicao) - e eh justamente o 3 que falta na lista do dump,
    * fechando a permutacao. Atribuir explicitamente aqui eh o mesmo valor,
    * e mantem o bloco legivel como sequencia 1..12.
    *
    * PEMSTATUS eh sobre OBJETO (a Column), nunca sobre alias de cursor
    * (onde dispara erro 11), e protege o CurrentControl do caso em que a
    * Column foi recriada por uma reatribuicao de ColumnCount - ai o
    * CheckBox nao existe mais e o nome apontaria para objeto morto.
    *==========================================================================
    PROTECTED PROCEDURE FormatarColunasGrade()
        LOCAL loc_oGrid

        loc_oGrid = THIS.grd_4c_Dados

        *-- Larguras (POSICAO no dump) e cabecalhos (NOME no dump)
        loc_oGrid.Column1.Width             = 68
        loc_oGrid.Column1.Header1.Caption   = "Data"

        loc_oGrid.Column2.Width             = 20
        loc_oGrid.Column2.Header1.Caption   = ""

        loc_oGrid.Column3.Width             = 100
        loc_oGrid.Column3.Header1.Caption   = "Produto"

        loc_oGrid.Column4.Width             = 100
        loc_oGrid.Column4.Header1.Caption   = "C" + CHR(243) + "digo / Barra"

        loc_oGrid.Column5.Width             = 95
        loc_oGrid.Column5.Header1.Caption   = "Pre" + CHR(231) + "o De"

        loc_oGrid.Column6.Width             = 80
        loc_oGrid.Column6.Header1.Caption   = "Quantidade"

        loc_oGrid.Column7.Width             = 180
        loc_oGrid.Column7.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"

        loc_oGrid.Column8.Width             = 83
        loc_oGrid.Column8.Header1.Caption   = "Ref. Fornecedor"

        loc_oGrid.Column9.Width             = 95
        loc_oGrid.Column9.Header1.Caption   = "Pre" + CHR(231) + "o"

        loc_oGrid.Column10.Width            = 60
        loc_oGrid.Column10.Header1.Caption  = "Parcelas"

        loc_oGrid.Column11.Width            = 95
        loc_oGrid.Column11.Header1.Caption  = "Pre" + CHR(231) + "o De Conjunto"

        loc_oGrid.Column12.Width            = 95
        loc_oGrid.Column12.Header1.Caption  = "Pre" + CHR(231) + "o Conjunto"

        *-- Sem CurrentControl o CheckBox existe e NAO desenha (regra #18).
        *-- Column.ControlSource (atribuido acima, linha do Column2) so se
        *-- aplica ao controle que FOR CurrentControl NO MOMENTO da
        *-- atribuicao - na abertura, esse controle ainda era o Text1
        *-- nativo (CurrentControl so muda aqui). Sem reatribuir
        *-- ControlSource DEPOIS de trocar para chk_4c_Check1, o CheckBox
        *-- nunca se liga a Flag e fica sempre desmarcado, mesmo com o
        *-- REPLACE que os handlers de toggle da Fase 7 fazem no cursor.
        *--
        *-- ControlSource tem de ser atribuido na COLUNA, nunca no filho:
        *-- setar .chk_4c_Check1.ControlSource direto estoura "Parent
        *-- object will not allow this property setting" (o VFP9 so
        *-- aceita o binding de dados atraves de Column.ControlSource, que
        *-- propaga para o CurrentControl corrente) - derrubava o TRY de
        *-- MontaGradeEtiquetas inteiro e a grade nunca chegava a GO TOP/
        *-- Refresh, mesmo sem nenhuma dependencia de conexao com o banco.
        IF PEMSTATUS(loc_oGrid.Column2, "chk_4c_Check1", 5)
            loc_oGrid.Column2.CurrentControl = "chk_4c_Check1"
            loc_oGrid.Column2.ControlSource   = THIS.this_cCursorEtiquetas + ".Flag"
        ENDIF

        *-- Dump: Column2.Sparse = .F. - CheckBox em TODAS as linhas
        loc_oGrid.Column2.Sparse = .F.

        *-- Grid.ReadOnly ANTES do das colunas, porque PROPAGA (regra #46)
        loc_oGrid.ReadOnly          = .F.
        loc_oGrid.Column1.ReadOnly  = .T.
        loc_oGrid.Column2.ReadOnly  = .F.
        loc_oGrid.Column3.ReadOnly  = .T.
        loc_oGrid.Column4.ReadOnly  = .T.
        loc_oGrid.Column5.ReadOnly  = .T.
        loc_oGrid.Column6.ReadOnly  = .F.
        loc_oGrid.Column7.ReadOnly  = .T.
        loc_oGrid.Column8.ReadOnly  = .T.
        loc_oGrid.Column9.ReadOnly  = .T.
        loc_oGrid.Column10.ReadOnly = .F.
        loc_oGrid.Column11.ReadOnly = .T.
        loc_oGrid.Column12.ReadOnly = .T.

        *-- Ordem de EXIBICAO do dump, construida da esquerda para a direita
        loc_oGrid.Column2.ColumnOrder  = 1
        loc_oGrid.Column1.ColumnOrder  = 2
        loc_oGrid.Column3.ColumnOrder  = 3
        loc_oGrid.Column4.ColumnOrder  = 4
        loc_oGrid.Column6.ColumnOrder  = 5
        loc_oGrid.Column10.ColumnOrder = 6
        loc_oGrid.Column5.ColumnOrder  = 7
        loc_oGrid.Column9.ColumnOrder  = 8
        loc_oGrid.Column11.ColumnOrder = 9
        loc_oGrid.Column12.ColumnOrder = 10
        loc_oGrid.Column7.ColumnOrder  = 11
        loc_oGrid.Column8.ColumnOrder  = 12
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cntBotoes (4 botoes) e cmdTestaPos (1 botao)
    *
    * Os dois sao CommandGroup de BaseClass pura (layout.json: "baseClass":
    * "commandgroup", "class": "commandgroup" - sem classe de framework), e
    * tudo abaixo eh TRANSCRITO do dump.
    *
    * Nomeados cmg_4c_* e NAO obj_4c_*: o mapeamento.json da task traz
    * "obj_4c_CntBotoes"/"obj_4c_CmdTestaPos" porque o AnalisadorObjetos do
    * GeradorMapeamento nao reconhece CommandGroup (sai Tipo = Unknown) e cai
    * no prefixo generico. O canonico do projeto eh cmg_4c_
    * (docs\framework_frmcadastro_layout.md), e o gate da fase so aceita
    * cmg_4c_/cmd_4c_. O mapeamento.json da task foi corrigido junto.
    *
    * NENHUM dos dois leva ForeColor: CommandGroup nao tem essa propriedade
    * (so BackColor) e atribui-la estoura "Property FORECOLOR is not found"
    * no Init - a tela nao abriria. A cor mora nos Buttons, e eh la que o
    * dump a declara (regra CLAUDE.md #33).
    *
    * BackStyle = 0 nos dois grupos: eles sao TRANSPARENTES, so agrupam. Por
    * isso o BackColor 240,240,240 que o dump declara em cmdTestaPos nao
    * pinta nada - transcrito porque esta no dump, nao porque tenha efeito.
    *
    * AutoSize = .T. com Width/Height explicitos nao eh contradicao: num
    * CommandGroup a geometria dos botoes INTERNOS define o tamanho do grupo,
    * e as duas contas FECHAM com o que o dump declara - cntBotoes com botoes
    * em Top 5 / Height 75 e Left 5..233 (+75) da 85 de altura e 313 de
    * largura, que sao exatamente o Height/Width do dump; cmdTestaPos, com um
    * botao em 5,5 de 75x75, da 85x85, tambem os do dump. Qualquer que seja o
    * que prevaleca em runtime, o resultado eh o mesmo.
    *
    * Themes = .F. nos Buttons eh CORRETO aqui e nao se mexe: a regra que
    * manda Themes = .T. + DisabledPicture (para o icone nao desaparecer) eh
    * de CommandButton SOLTO; dentro de CommandGroup o canonico eh .F., como
    * o dump declara.
    *
    * PicturePosition = 13 so no Buttons(1), que eh onde o dump o declara -
    * nos outros quatro nao se inventa valor. AutoSize = .F. EXPLICITO nos
    * cinco porque todos declaram WordWrap = .T., e com AutoSize = .T. o
    * VFP9 DESCARTA a Height e colapsa o rotulo de duas linhas (regra
    * CLAUDE.md #23) - o dump ja traz esse .F. no Buttons(1).
    *
    * Cancel = .T. no Buttons(2) ("Sair") eh do dump: eh o ESC da tela, e o
    * ToolTipText do legado diz isso ("[Esc] Sair da Tela"). O Click que ele
    * dispara eh da Fase 7.
    *
    * Os TabIndex dos Buttons entram AGORA porque sao escopo do GRUPO (faixa
    * 1..ButtonCount = 1..4) e se bastam: 3,4,1,2 nos quatro, que eh a ordem
    * de teclado Armazenar -> Imprimir -> Boleto -> Sair, a mesma da esquerda
    * para a direita na tela (Left 5, 81, 157, 233). O TabIndex de FORM fica
    * para a Fase 6 (ver cabecalho do arquivo). cmdTestaPos.Buttons(1) nao
    * declara TabIndex no dump e nao recebe nenhum.
    *
    * As Picture vem TRANSCRITAS do dump, nunca escolhidas por semelhanca
    * (regra CLAUDE.md #25) - e eh por isso que "Armazenar" usa
    * geral_pastas_60.jpg e nao um icone de disquete, e que "Boleto" e
    * "Imprimir" NAO compartilham arte. Os quatro arquivos foram conferidos
    * em vbmp\: geral_boleto_60.jpg, cadastro_sair_60.jpg,
    * geral_pastas_60.jpg, geral_impressora_60.jpg (este ultimo servindo
    * tambem o cmdTestaPos, como no legado). Picture inexistente nao da erro
    * nenhum em VFP9 - o botao so nao desenha icone.
    *
    * ORDEM DE CRIACAO: cntBotoes antes de cmdTestaPos, como no inventario do
    * dump. Os dois retangulos se cruzam em Left 691..700, mas os BOTOES nao:
    * o de cmdTestaPos ocupa 620..695 e o primeiro de cntBotoes 696..771. A
    * faixa de 9px em que os grupos se sobrepoem esta vazia nos dois e ambos
    * sao BackStyle = 0, entao nao ha clique bloqueado nem area recortada.
    *
    * Os Buttons NAO recebem BINDEVENT aqui: os cinco Click (Armazenar,
    * Imprimir, Boleto, Sair, Testar Posicao) sao da Fase 7, e ligar agora um
    * handler vazio so para existir seria stub disfarcado. O que esta
    * presente nesta fase eh o unico ajuste de ESTADO que o Init legado faz
    * nesses botoes e que nao depende de nada das fases seguintes - ver
    * AjustarBotoesPorTipoChamador.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oGrupo

        *-- cntBotoes: Armazenar / Imprimir / Boleto / Sair
        THIS.AddObject("cmg_4c_CntBotoes", "CommandGroup")
        loc_oGrupo = THIS.cmg_4c_CntBotoes

        WITH loc_oGrupo
            .ButtonCount   = 4
            .Top           = -2
            .Left          = 691
            .Width         = 313
            .Height        = 85
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Buttons(1) = btnBoleto
        WITH loc_oGrupo.Buttons(1)
            .Top             = 5
            .Left            = 157
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Boleto"
            .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            .PicturePosition = 13
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .SpecialEffect   = 0
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .TabIndex        = 3
            .ToolTipText     = "Imprimir Boleto"
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        *-- Buttons(2) = btnSair (Cancel = .T. no dump: eh o ESC da tela)
        WITH loc_oGrupo.Buttons(2)
            .Top           = 5
            .Left          = 233
            .Width         = 75
            .Height        = 75
            .Caption       = "Sair"
            .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel        = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .WordWrap      = .T.
            .AutoSize      = .F.
            .MousePointer  = 15
            .SpecialEffect = 0
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .TabIndex      = 4
            .ToolTipText   = "[Esc] Sair da Tela"
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Buttons(3) = btnDepois ("Armazenar")
        WITH loc_oGrupo.Buttons(3)
            .Top          = 5
            .Left         = 5
            .Width        = 75
            .Height       = 75
            .Caption      = "\<Armazenar"
            .Picture      = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .MousePointer = 15
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .TabIndex     = 1
            .ToolTipText  = "Arquivar Impress" + CHR(227) + "o"
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH

        *-- Buttons(4) = btnImprime
        WITH loc_oGrupo.Buttons(4)
            .Top          = 5
            .Left         = 81
            .Width        = 75
            .Height       = 75
            .Caption      = "\<Imprimir"
            .Picture      = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .FontBold     = .T.
            .FontItalic   = .T.
            .WordWrap     = .T.
            .AutoSize     = .F.
            .MousePointer = 15
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .TabIndex     = 2
            .ToolTipText  = "Imprimir"
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH

        *-- cmdTestaPos: o botao de teste de posicionamento da etiqueta.
        *-- Visible = .T. porque nem o dump nem o Init legado o escondem; a
        *-- visibilidade condicional ("= (lnTpEti = 80)") mora no
        *-- InteractiveChange do Opt_Tipo, que eh da Fase 5.
        THIS.AddObject("cmg_4c_CmdTestaPos", "CommandGroup")
        loc_oGrupo = THIS.cmg_4c_CmdTestaPos

        WITH loc_oGrupo
            .ButtonCount   = 1
            .Top           = -2
            .Left          = 615
            .Width         = 85
            .Height        = 85
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .BackColor     = RGB(240, 240, 240)
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Buttons(1) = btnPosicao
        WITH loc_oGrupo.Buttons(1)
            .Top           = 5
            .Left          = 5
            .Width         = 75
            .Height        = 75
            .Caption       = "\<Testar Posi" + CHR(231) + CHR(227) + "o"
            .Picture       = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .WordWrap      = .T.
            .AutoSize      = .F.
            .MousePointer  = 15
            .SpecialEffect = 0
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .ToolTipText   = "Teste de Posicionamento de Etiquetas"
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarTextoLivreEParcelas - Label7/GetTexto e Label8/getQtParcs
    *
    * Faixa 82..144, entre o cabecalho (0..80) e a grade (147..388) -
    * geometria e aparencia TRANSCRITAS do dump (SIGOPIPE.Label7/GetTexto/
    * Label8/getQtParcs).
    *
    * GetTexto (classe fwmemo no layout.json, migrado para EditBox puro) eh
    * o campo de texto livre que entra na etiqueta. AddLineFeeds = .F. vem
    * do dump (o legado NAO quebra linha automaticamente ao digitar).
    * Nenhum ControlSource: o legado liga o conteudo no momento de montar a
    * etiqueta (Fase 7/8), nao por bind direto a cursor.
    *
    * getQtParcs eh a quantidade de parcelas - so faz sentido quando
    * opt_Preco seleciona "Parcelamento" (Buttons(6)), condicao que mora no
    * When do campo (Fase 6: "Return(ThisForm.opt_Preco.Value = 6)"), nao
    * aqui. Format = "K" + InputMask = "99" TRANSCRITOS do dump (regra
    * CLAUDE.md #49): "K" seleciona o conteudo ao focar, o InputMask
    * restringe a 2 digitos numericos. Alignment = 3 (direita) e Value = 0
    * (NUMERICO - o destino eh a coluna Parcelas N(2,0) do cursor da grade)
    * tambem vem do dump, assim como ForeColor = RGB(90,90,90) e os dois
    * DisabledXxxColor.
    *
    * TabIndex de FORM (Label7/GetTexto/Label8/getQtParcs declaram 6/7/6/4
    * no dump, com o 4 duplicado com getOcoEtiqs - controle que so existe a
    * partir da Fase 6) fica para a Fase 6, mesma regra ja registrada no
    * cabecalho do arquivo (AjustarOrdemTabulacao).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTextoLivreEParcelas()
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top        = 82
            .Left       = 209
            .Width      = 66
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Texto Livre"
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("obj_4c_GetTexto", "EditBox")
        WITH THIS.obj_4c_GetTexto
            .Top          = 83
            .Left         = 279
            .Width        = 341
            .Height       = 61
            .FontName     = "Tahoma"
            .FontSize     = 10
            .AddLineFeeds = .F.
            .Visible      = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Top        = 129
            .Left       = 12
            .Width      = 123
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Quantidade de Parcelas :"
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("txt_4c_QtParcs", "TextBox")
        WITH THIS.txt_4c_QtParcs
            .Top               = 120
            .Left              = 136
            .Width             = 33
            .Height            = 24
            .FontName          = "Courier New"
            .FontSize          = 9
            .Alignment         = 3
            .Format            = "K"
            .InputMask         = "99"
            .Value             = 0
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGruposTipoPrecoPeso - Shape1/Shape2 + Opt_Tipo/Label1 +
    * opt_Preco/Label3 + opt_peso/Label4 + Opt_Conjunto/Label9
    *
    * Faixa 393..595, abaixo da grade (147..388) e fora da banda dos
    * CommandGroup (Top -2..83). Shape2 moldura Opt_Tipo (Left 6..197);
    * Shape1 moldura o bloco Conjunto+Preco+Peso (Left 396..588) - os tres
    * cabem dentro dele, TRANSCRITOS do dump:
    *
    *   Opt_Conjunto  Top 393..419   Label9  Top 400..415
    *   opt_Preco     Top 416..528   Label3  Top 423..438
    *   opt_peso      Top 513..539   Label4  Top 520..535
    *
    * Shape3 (moldura de Impressoras, Left 201..392) fica para a Fase 6,
    * que tambem cria o conteudo que ele moldura.
    *
    * Shape.BackStyle = 0 + BorderWidth = 2 + BorderColor RGB(90,90,90):
    * SHAPE nao tem ForeColor (confirmado em
    * automation\propriedades_baseclasses.txt - regra CLAUDE.md #33), a cor
    * da borda eh sempre BorderColor.
    *
    * Opt_Tipo.ButtonCount = 1 - unico botao declarado no SCX ("\<a.
    * Rabicho"); o resto dos tipos chega por AddObject em runtime a partir
    * de LocalTpEti (Fase 7, comportamento.json). OptionButton eh membro
    * NATIVO do grupo (como Text1/Header1 em Column) - atribuir ButtonCount
    * ja cria os Buttons, NUNCA se faz AddObject de Button.
    *
    * opt_Preco (6 botoes: Sim/Nao/Ideal/Atual/"Preco DE \ Por"/
    * Parcelamento), opt_peso (2: Sim/Nao) e Opt_Conjunto (2: Sim/Nao) sao
    * TRANSCRITOS do dump - Caption/Left/Top/Width/AutoSize de cada Button.
    * Nenhum declara TabIndex proprio, exceto Opt_Tipo.Buttons(1), que
    * entra porque eh escopo do GRUPO (faixa 1..ButtonCount), nao do form -
    * mesma regra do TabIndex dos Buttons de CommandGroup (ConfigurarBotoes).
    *
    * Opt_Conjunto.Value = 2 (botao 2 = "Nao" selecionado por padrao) com
    * Buttons(1).Value=0/Buttons(2).Value=1: sao os dois flags BOOLEANOS
    * (0/1) que o VFP usa por botao, nao o padrao que a regra CLAUDE.md #33
    * veda (ButtonsValue = N para N>1, que faz todos os botoes
    * aparecerem marcados de uma vez).
    *
    * OptionGroup nao tem ForeColor nem ControlCount (confirmado no mesmo
    * arquivo de propriedades) - a cor mora nos ButtonsForeColor, e a
    * recursao de TornarControlesVisiveis para no proprio grupo (o
    * PEMSTATUS de ControlCount devolve .F.), exatamente como em
    * CommandGroup.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGruposTipoPrecoPeso()
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 394
            .Left          = 6
            .Width         = 191
            .Height        = 201
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90, 90, 90)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 394
            .Left          = 396
            .Width         = 192
            .Height        = 201
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90, 90, 90)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Opt_Tipo: unico botao do SCX - o resto chega via LocalTpEti (Fase 7)
        THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
        WITH THIS.obj_4c_Opt_Tipo
            .ButtonCount   = 1
            .Top           = 412
            .Left          = 11
            .Width         = 181
            .Height        = 173
            .AutoSize      = .F.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH

        WITH THIS.obj_4c_Opt_Tipo.Buttons(1)
            .Top       = -1
            .Left      = 4
            .Width     = 150
            .Height    = 17
            .Style     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "\<a. Rabicho"
            .Value     = 1
            .TabIndex  = 1
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top        = 397
            .Left       = 14
            .Width      = 93
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Tipo de Etiqueta"
            .Visible    = .T.
        ENDWITH

        *-- Opt_Conjunto - Value=2 -> botao 2 ("Nao") selecionado por padrao
        THIS.AddObject("obj_4c_Opt_Conjunto", "OptionGroup")
        WITH THIS.obj_4c_Opt_Conjunto
            .ButtonCount = 2
            .Top         = 393
            .Left        = 466
            .Width       = 106
            .Height      = 26
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH

        WITH THIS.obj_4c_Opt_Conjunto.Buttons(1)
            .Top       = 7
            .Left      = 8
            .Width     = 34
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Sim"
            .Value     = 0
        ENDWITH

        WITH THIS.obj_4c_Opt_Conjunto.Buttons(2)
            .Top       = 7
            .Left      = 61
            .Width     = 37
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "N" + CHR(227) + "o"
            .Value     = 1
        ENDWITH

        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Top        = 400
            .Left       = 404
            .Width      = 59
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Conjunto :"
            .Visible    = .T.
        ENDWITH

        *-- opt_Preco: 6 botoes (Sim/Nao/Ideal/Atual/Preco DE\Por/Parcelamento)
        THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
        WITH THIS.obj_4c_Opt_Preco
            .ButtonCount = 6
            .Top         = 416
            .Left        = 467
            .Width       = 111
            .Height      = 112
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        WITH THIS.obj_4c_Opt_Preco.Buttons(1)
            .Top       = 7
            .Left      = 8
            .Width     = 34
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Sim"
            .Value     = 1
        ENDWITH

        WITH THIS.obj_4c_Opt_Preco.Buttons(2)
            .Top       = 7
            .Left      = 61
            .Width     = 37
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "N" + CHR(227) + "o"
        ENDWITH

        WITH THIS.obj_4c_Opt_Preco.Buttons(3)
            .Top       = 31
            .Left      = 8
            .Width     = 42
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Ideal"
        ENDWITH

        WITH THIS.obj_4c_Opt_Preco.Buttons(4)
            .Top       = 31
            .Left      = 61
            .Width     = 43
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Atual"
        ENDWITH

        WITH THIS.obj_4c_Opt_Preco.Buttons(5)
            .Top       = 54
            .Left      = 8
            .Width     = 87
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pre" + CHR(231) + "o DE \ Por"
        ENDWITH

        WITH THIS.obj_4c_Opt_Preco.Buttons(6)
            .Top       = 79
            .Left      = 8
            .Width     = 83
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Parcelamento"
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top        = 423
            .Left       = 425
            .Width      = 40
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Pre" + CHR(231) + "o :"
            .Visible    = .T.
        ENDWITH

        *-- opt_peso: 2 botoes (Sim/Nao)
        THIS.AddObject("obj_4c_Opt_peso", "OptionGroup")
        WITH THIS.obj_4c_Opt_peso
            .ButtonCount = 2
            .Top         = 513
            .Left        = 467
            .Width       = 100
            .Height      = 26
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        WITH THIS.obj_4c_Opt_peso.Buttons(1)
            .Top        = 7
            .Left       = 8
            .Width      = 34
            .Height     = 15
            .Style      = 0
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Sim"
            .Value      = 1
        ENDWITH

        WITH THIS.obj_4c_Opt_peso.Buttons(2)
            .Top        = 7
            .Left       = 61
            .Width      = 37
            .Height     = 15
            .Style      = 0
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "N" + CHR(227) + "o"
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top        = 520
            .Left       = 431
            .Width      = 35
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Peso :"
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarImpressora - Shape3 + Cnt_Impressora + Opt_Impressora/Label2
    * + Get_Printer/Label5/Label6 + Say5 ("Posicao :")/spn_posetiq
    *
    * Shape3 eh a moldura do bloco de Impressoras (Left 201..392, entre
    * Shape2 e Shape1 da Fase 5) - mesmo estilo (BackStyle 0, BorderWidth 2,
    * BorderColor 90,90,90) TRANSCRITO do dump.
    *
    * Cnt_Impressora (Top 521 / Left 593 / Width 398 / Height 73) eh o
    * container com a configuracao fisica da impressora: Opcao_imp
    * (OptionGroup de 3 botoes - Allegro/Zebra ZPL/Zebra EPL), os 4
    * Spinner de ajuste (Vert/Horz/Dens/Velo) com seus Say ao lado, e
    * Chk_Resete (oculto - excecao de TornarControlesVisiveis). TabIndex
    * dos filhos TRANSCRITO literal do dump: eh escopo PROPRIO do
    * container (regra CLAUDE.md #29/sub-regra de Buttons - mesmo
    * raciocinio vale para TabIndex de filho de Container), e a sequencia
    * 2..11 do dump nao tem duplicata nenhuma - diferente do que acontece
    * nos controles diretos do FORM (ver AjustarOrdemTabulacao).
    *
    * SpinnerHighValue/SpinnerLowValue TRANSCRITOS sem a parte decimal
    * ".00" do dump (sao os mesmos 999/0/20/10/3/1 - o VFP exibe Spinner
    * como float, o literal eh so formatacao do Form Designer).
    *
    * Opt_Impressora (Visible = .F. SEMPRE, nunca reativado - ver nota no
    * cabecalho do arquivo) e Label2 ("Impressoras") sao TRANSCRITOS tal
    * qual o dump.
    *
    * Get_Printer (ComboBox, Style = 2) nasce com RowSourceType = 0 e
    * RowSource = "" - o bind ao alias crImpreV eh feito em
    * CarregarImpressorasEtiqueta (Fase 8), quando o cursor passa a
    * existir. As
    * demais propriedades (BoundColumn, DisabledBackColor/ForeColor,
    * BorderColor, Style) sao TRANSCRITAS do dump e nao dependem do alias.
    *
    * Label5 ("Sistema") e Label6 ("Windows") sao os dois rotulos acima do
    * combo - Label6 recebe RGB(90,90,90) em vez do RGB(231,254,253)
    * quase-branco do dump (regra CLAUDE.md #12, excecao "escurecer p/ cor
    * das labels irmas" - a irma eh Label5).
    *
    * Say5 ("Posicao :") e spn_posetiq ficam no Shape2 (Opt_Tipo), nao no
    * Shape3: Top 549..554 / Left 412..477, dentro da faixa 394..595 Left
    * 6..197 do Shape2 (Fase 5). O nome migrado de Say5 eh "lbl_4c_Say5"
    * e NAO "lbl_4c_Label5" (que ja pertence a Label5, "Sistema") - ver a
    * nota de colisao de mapeamento.json no cabecalho do arquivo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImpressora()
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top           = 394
            .Left          = 201
            .Width         = 191
            .Height        = 201
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90, 90, 90)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("cnt_4c__Impressora", "Container")
        WITH THIS.cnt_4c__Impressora
            .Top           = 521
            .Left          = 593
            .Width         = 398
            .Height        = 73
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Opcao_imp: 3 impressoras (Allegro / Zebra ZPL / Zebra EPL)
        THIS.cnt_4c__Impressora.AddObject("obj_4c_Opcao_imp", "OptionGroup")
        WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp
            .ButtonCount = 3
            .Top         = 4
            .Left        = 5
            .Width       = 76
            .Height      = 63
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .TabIndex    = 2
            .Visible     = .T.
        ENDWITH

        WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Buttons(1)
            .Top       = 5
            .Left      = 5
            .Width     = 51
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Allegro"
        ENDWITH

        WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Buttons(2)
            .Top       = 24
            .Left      = 5
            .Width     = 66
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Zebra ZPL"
        ENDWITH

        WITH THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Buttons(3)
            .Top       = 43
            .Left      = 5
            .Width     = 66
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Zebra EPL"
        ENDWITH

        THIS.cnt_4c__Impressora.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Impressora.lbl_4c_Label2
            .Top       = 4
            .Left      = 104
            .Width     = 37
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Vertical"
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Impressora.AddObject("obj_4c_Spn_AjVerts", "Spinner")
        WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts
            .Top               = 20
            .Left              = 104
            .Width             = 61
            .Height            = 26
            .KeyboardHighValue = 999
            .KeyboardLowValue  = 0
            .SpinnerHighValue  = 999
            .SpinnerLowValue   = 0
            .TabIndex          = 4
            .Visible           = .T.
        ENDWITH

        THIS.cnt_4c__Impressora.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.cnt_4c__Impressora.lbl_4c_Label3
            .Top       = 4
            .Left      = 177
            .Width     = 50
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Horizontal"
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Impressora.AddObject("obj_4c_Spn_AjHorzs", "Spinner")
        WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs
            .Top               = 20
            .Left              = 177
            .Width             = 61
            .Height            = 26
            .KeyboardHighValue = 999
            .KeyboardLowValue  = -999
            .SpinnerHighValue  = 999
            .SpinnerLowValue   = -999
            .TabIndex          = 6
            .Visible           = .T.
        ENDWITH

        THIS.cnt_4c__Impressora.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.cnt_4c__Impressora.lbl_4c_Label4
            .Top       = 4
            .Left      = 250
            .Width     = 52
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Densidade"
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Impressora.AddObject("obj_4c_Spn_AjDenss", "Spinner")
        WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss
            .Top               = 20
            .Left              = 250
            .Width             = 61
            .Height            = 26
            .KeyboardHighValue = 20
            .KeyboardLowValue  = 10
            .SpinnerHighValue  = 20
            .SpinnerLowValue   = 10
            .Value             = 20
            .TabIndex          = 8
            .Visible           = .T.
        ENDWITH

        THIS.cnt_4c__Impressora.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.cnt_4c__Impressora.lbl_4c_Label5
            .Top       = 4
            .Left      = 323
            .Width     = 53
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Velocidade"
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Impressora.AddObject("obj_4c_Spn_AjVelos", "Spinner")
        WITH THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos
            .Top               = 20
            .Left              = 323
            .Width             = 61
            .Height            = 26
            .KeyboardHighValue = 3
            .KeyboardLowValue  = 1
            .SpinnerHighValue  = 3
            .SpinnerLowValue   = 1
            .Value             = 3
            .TabIndex          = 10
            .Visible           = .T.
        ENDWITH

        *-- Chk_Resete: oculto (dump Visible = .F.) - excecao de
        *-- TornarControlesVisiveis. O Click de Opcao_imp que o esconde de
        *-- novo (This.Parent.Chk_Resete.Visible = .f., Fase 7 -
        *-- OpcaoImpClick) existe; o que o REABRE eh fCarregarImps, funcao
        *-- global que nao veio no acervo (regra CLAUDE.md #27) - fica
        *-- oculto para sempre, mesma omissao de ValidarImpressoraSelecio-
        *-- nada/CarregarAjustesImpressora.
        THIS.cnt_4c__Impressora.AddObject("chk_4c_Chk_Resete", "CheckBox")
        WITH THIS.cnt_4c__Impressora.chk_4c_Chk_Resete
            .Top       = 49
            .Left      = 104
            .Width     = 135
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = 'Enviar Comando "Reset"'
            .Value     = 0
            .TabIndex  = 11
            .Visible   = .F.
        ENDWITH

        *-- Opt_Impressora: morto desde "mena - 05/03/2015" (ver nota no
        *-- cabecalho). Visible = .F. SEMPRE.
        THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
        WITH THIS.obj_4c_Opt_Impressora
            .ButtonCount   = 1
            .Top           = 554
            .Left          = 206
            .Width         = 181
            .Height        = 36
            .AutoSize      = .F.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Themes        = .F.
            .Value         = 1
            .Visible       = .F.
        ENDWITH

        WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
            .Top       = 10
            .Left      = 2
            .Width     = 177
            .Height    = 17
            .Style     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "\<1. Gen" + CHR(233) + "rico/Somente Texto"
            .Value     = 1
            .TabIndex  = 1
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top        = 397
            .Left       = 209
            .Width      = 74
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Impressoras"
            .Visible    = .T.
        ENDWITH

        *-- Get_Printer: RowSourceType/RowSource ficam para a Fase 7 - ver
        *-- nota no cabecalho do arquivo.
        THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
        WITH THIS.cbo_4c_Get_Printer
            .Top               = 434
            .Left              = 208
            .Width             = 176
            .Height            = 23
            .FontName          = "Courier New"
            .FontSize          = 8
            .Style             = 2
            .BoundColumn       = 1
            .RowSourceType     = 0
            .RowSource         = ""
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(238, 238, 238)
            .DisabledForeColor = RGB(0, 0, 128)
            .BorderColor       = RGB(90, 90, 90)
            .Visible           = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top        = 420
            .Left       = 210
            .Width      = 51
            .Height     = 16
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Courier New"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Sistema"
            .Visible    = .T.
        ENDWITH

        *-- Label6: dump declara ForeColor 231,254,253 (quase-branco) -
        *-- escurecido para a cor da irma Label5 (regra CLAUDE.md #12).
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top        = 420
            .Left       = 323
            .Width      = 51
            .Height     = 16
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Courier New"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Windows"
            .Visible    = .T.
        ENDWITH

        *-- Say5 ("Posicao :") + spn_posetiq - dentro da faixa do Shape2
        THIS.AddObject("lbl_4c_Say5", "Label")
        WITH THIS.lbl_4c_Say5
            .Top       = 554
            .Left      = 412
            .Width     = 51
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Posi" + CHR(231) + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Spn_posetiq", "Spinner")
        WITH THIS.obj_4c_Spn_posetiq
            .Top               = 549
            .Left              = 477
            .Width             = 61
            .Height            = 24
            .KeyboardHighValue = 27
            .KeyboardLowValue  = 1
            .SpinnerHighValue  = 27
            .SpinnerLowValue   = 1
            .Value             = 1
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarOcorrenciaEJustificativa - getOcoEtiqs/getDOcoEtiqs/
    * lblOcoEtiqs/ShpOcoEtiqs + GetJustifs/lblJustifs/ShpJustifs
    *
    * Os sete controles nascem no estado INCONDICIONAL do Init legado,
    * ANTES do "If (Type(...pcEscolha...)) And ... And
    * (LocalParam.OcoEtiqs = 1)" (linhas 2691-2710 do dump): Visible = .F.
    * nos sete e this_lGravaOcorrencia = .F. O ramo que os reacende fica
    * para a Fase 7 (precisa de LocalParam e de ParentForm.pcEscolha - ver
    * cabecalho do arquivo).
    *
    * getOcoEtiqs/getDOcoEtiqs nao tem ControlSource no dump (o valor eh
    * atribuido por codigo no Click de Imprimir/Armazenar - Fase 7/8), por
    * isso .Value = "" em vez de bind a cursor. O mesmo vale para
    * GetJustifs.
    *
    * ShpOcoEtiqs/ShpJustifs seguem o mesmo estilo dos Shape1/2/3
    * (BackStyle 0, BorderWidth 2, BorderColor 90,90,90) - unica diferenca
    * eh a geometria, TRANSCRITA do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOcorrenciaEJustificativa()
        THIS.this_lGravaOcorrencia = .F.

        THIS.AddObject("shp_4c_ShpOcoEtiqs", "Shape")
        WITH THIS.shp_4c_ShpOcoEtiqs
            .Top           = 464
            .Left          = 593
            .Width         = 398
            .Height        = 53
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90, 90, 90)
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        THIS.AddObject("txt_4c_OcoEtiqs", "TextBox")
        WITH THIS.txt_4c_OcoEtiqs
            .Top               = 486
            .Left              = 605
            .Width             = 33
            .Height            = 24
            .FontName          = "Courier New"
            .FontSize          = 9
            .Format            = "K"
            .Value             = ""
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .F.
        ENDWITH

        THIS.AddObject("txt_4c_DOcoEtiqs", "TextBox")
        WITH THIS.txt_4c_DOcoEtiqs
            .Top               = 486
            .Left              = 641
            .Width             = 337
            .Height            = 24
            .FontName          = "Courier New"
            .FontSize          = 9
            .Format            = "K"
            .Value             = ""
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .Visible           = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_LblOcoEtiqs", "Label")
        WITH THIS.lbl_4c_LblOcoEtiqs
            .Top        = 467
            .Left       = 605
            .Width      = 63
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "\<Ocorr" + CHR(234) + "ncia"
            .Visible    = .F.
        ENDWITH

        THIS.AddObject("shp_4c_ShpJustifs", "Shape")
        WITH THIS.shp_4c_ShpJustifs
            .Top           = 394
            .Left          = 593
            .Width         = 398
            .Height        = 67
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90, 90, 90)
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        THIS.AddObject("obj_4c_GetJustifs", "EditBox")
        WITH THIS.obj_4c_GetJustifs
            .Top      = 413
            .Left     = 605
            .Width    = 374
            .Height   = 42
            .FontName = "Arial"
            .FontSize = 8
            .Value    = ""
            .Visible  = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_LblJustifs", "Label")
        WITH THIS.lbl_4c_LblJustifs
            .Top        = 397
            .Left       = 605
            .Width      = 41
            .Height     = 15
            .AutoSize   = .T.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "\<Motivo"
            .Visible    = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorTipoChamador - o estado inicial dos 4 botoes
    *
    * Legado (Init, logo depois de ligar a grade):
    *
    *   With Thisform.cntBotoes
    *       * Mostra os Quatro Botoes na Tela
    *       .btnDepois.Enabled  = .T.
    *       .btnImprime.Enabled = .T.
    *       .btnBoleto.Enabled  = .T.
    *       .btnSair.Enabled    = .T.
    *       If (Thisform.ParentForm.Tipo <> 'CADASTRO')
    *           .btnDepois.Enabled = .F.
    *       Endif
    *   Endwith
    *
    * "Armazenar" (btnDepois = Buttons(3)) arquiva a impressao para depois, e
    * isso so faz sentido quando a tela foi chamada pelo Cadastro de Produtos
    * - nos outros caminhos o legado desabilita. Transcrito como esta.
    *
    * NAO entra aqui o segundo ajuste do Init legado
    * (".btnImprime.Enabled = (lnTipos <> 0 And lnImpres <> 0)" e o
    * ".Value" que o acompanha, linhas 3263-3266): lnTipos/lnImpres vem de
    * Opt_Tipo e das impressoras carregadas em LocalParam/LocalParaC, que so
    * existem a partir da Fase 5 (os controles) / Fase 8 (os valores -
    * ver AjustarBotaoImprimirPorContexto).
    *
    * ParentForm.Tipo eh lido com guarda DUPLA (VARTYPE do objeto e PEMSTATUS
    * da propriedade) porque o chamador eh arbitrario - os seis caminhos
    * conhecidos declaram Tipo, mas o harness de instanciacao abre a tela sem
    * chamador nenhum, e sem a guarda o Init estouraria. Sem chamador, o tipo
    * fica vazio e "Armazenar" sai desabilitado, que eh o mesmo que o legado
    * faz para todo Tipo diferente de CADASTRO.
    *
    * ALLTRIM + UPPER na comparacao porque o projeto roda com SET EXACT ON e
    * o valor pode chegar de uma coluna char com padding - "CADASTRO   "
    * nunca casaria com "CADASTRO".
    *
    * PUBLIC de proposito: as fases seguintes reavaliam o estado dos botoes a
    * cada troca de Tipo/impressora e chamam este metodo de fora, e PEMSTATUS
    * devolve .T. mesmo para PROTECTED - o teste entraria no branch e a
    * chamada estouraria em runtime (regras CLAUDE.md #3/#51).
    *==========================================================================
    PROCEDURE AjustarBotoesPorTipoChamador()
        LOCAL loc_cTipoChamador, loc_oGrupo

        loc_cTipoChamador = ""

        IF VARTYPE(THIS.this_oFormAnterior) = "O"
            IF PEMSTATUS(THIS.this_oFormAnterior, "Tipo", 5)
                IF VARTYPE(THIS.this_oFormAnterior.Tipo) = "C"
                    loc_cTipoChamador = UPPER(ALLTRIM(THIS.this_oFormAnterior.Tipo))
                ENDIF
            ENDIF
        ENDIF

        loc_oGrupo = THIS.cmg_4c_CntBotoes

        *-- Legado: "Mostra os Quatro Botoes na Tela"
        loc_oGrupo.Buttons(1).Enabled = .T.   && Boleto
        loc_oGrupo.Buttons(2).Enabled = .T.   && Sair
        loc_oGrupo.Buttons(3).Enabled = .T.   && Armazenar
        loc_oGrupo.Buttons(4).Enabled = .T.   && Imprimir

        *-- Legado: If (ParentForm.Tipo <> 'CADASTRO') / btnDepois.Enabled = .F.
        IF loc_cTipoChamador != "CADASTRO"
            loc_oGrupo.Buttons(3).Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarOrdemTabulacao - TabIndex dos filhos DIRETOS do form
    *
    * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
    * tem relacao com a do legado. Divergencia aqui nao da erro, nao entra em
    * log e nao aparece em screenshot - so o Tab andando na ordem errada.
    *
    * O dump esta LONGE de ser uma sequencia limpa 1..N: SO entre os
    * controles filhos DIRETOS do form que de fato recebem foco (TextBox,
    * EditBox, ComboBox, Spinner, OptionGroup, CommandGroup, Grid - Label e
    * Shape NAO tem TabStop, regra ja registrada no gemeo FormSIGOPGRC), o
    * TabIndex = 10 aparece em QUATRO controles (opt_Preco, spn_posetiq,
    * opt_peso, Opt_Conjunto), o 1 em dois (cntBotoes, Get_Printer), o 2 em
    * dois (grd_historico, cmdTestaPos), o 4 em dois (getQtParcs,
    * getOcoEtiqs), o 7 em dois (GetJustifs, GetTexto) e o 9 em dois
    * (Opt_Impressora, Say5) - sintoma de retrabalho do form ao longo dos
    * anos (os comentarios "mena" no dump vao de 2014 a 2016).
    *
    * Como nao ha como recuperar a intencao original dessas duplicatas, a
    * ordem final abaixo resolve o EMPATE pelo Top do dump (controle mais
    * acima primeiro) - mesmo criterio que a ferramenta "Set Tab Order" do
    * Form Designer usa ao preencher automaticamente. Os valores atribuidos
    * sao os ORDINAIS EFETIVOS (1..16), nao os literais do dump, e em ordem
    * ASCENDENTE: cada atribuicao poe o controle na posicao pedida e empurra
    * os demais para tras (mesma mecanica de insercao do Column.ColumnOrder
    * em FormatarColunasGrade) - ordem descendente trocaria pares de lugar.
    *
    *   1  cmg_4c_CntBotoes      (TabIndex 1, Top -2)
    *   2  cbo_4c_Get_Printer    (TabIndex 1, Top 434)
    *   3  cmg_4c_CmdTestaPos    (TabIndex 2, Top -2)
    *   4  grd_4c_Dados          (TabIndex 2, Top 147)
    *   5  txt_4c_QtParcs        (TabIndex 4, Top 120)
    *   6  txt_4c_OcoEtiqs       (TabIndex 4, Top 486)
    *   7  txt_4c_DOcoEtiqs      (TabIndex 5, Top 486)
    *   8  obj_4c_GetTexto       (TabIndex 7, Top 83)
    *   9  obj_4c_GetJustifs     (TabIndex 7, Top 413)
    *   10 obj_4c_Opt_Tipo       (TabIndex 8, Top 412)
    *   11 obj_4c_Opt_Impressora (TabIndex 9, Top 554 - oculto; mantido na
    *                             sequencia so para a numeracao nao pular)
    *   12 obj_4c_Opt_Conjunto   (TabIndex 10, Top 393)
    *   13 obj_4c_Opt_Preco      (TabIndex 10, Top 416)
    *   14 obj_4c_Opt_peso       (TabIndex 10, Top 513)
    *   15 obj_4c_Spn_posetiq    (TabIndex 10, Top 549)
    *   16 cnt_4c__Impressora    (TabIndex 12, Top 521)
    *
    * txt_4c_OcoEtiqs/txt_4c_DOcoEtiqs/obj_4c_GetJustifs ficam na faixa
    * normal de TabIndex mesmo nascendo Visible = .F.: controle oculto
    * continua tendo TabIndex (o Tab so pula ele em runtime, por nao estar
    * Visible), e e exatamente isso que a Fase 7 precisa quando os
    * reexibir - TabIndex fixado agora, sem depender de mais nenhum
    * AddObject.
    *
    * cnt_4c__Impressora.TabIndex eh o ultimo da lista porque o TabIndex de
    * um Container eh escopo PROPRIO (o Tab entra nos filhos dele, numerados
    * em ConfigurarImpressora) - a posicao 16 so decide QUANDO o foco entra
    * no container em relacao aos outros 15, nao a ordem interna.
    *==========================================================================
    PROTECTED PROCEDURE AjustarOrdemTabulacao()
        THIS.cmg_4c_CntBotoes.TabIndex      = 1
        THIS.cbo_4c_Get_Printer.TabIndex    = 2
        THIS.cmg_4c_CmdTestaPos.TabIndex    = 3
        THIS.grd_4c_Dados.TabIndex          = 4
        THIS.txt_4c_QtParcs.TabIndex        = 5
        THIS.txt_4c_OcoEtiqs.TabIndex       = 6
        THIS.txt_4c_DOcoEtiqs.TabIndex      = 7
        THIS.obj_4c_GetTexto.TabIndex       = 8
        THIS.obj_4c_GetJustifs.TabIndex     = 9
        THIS.obj_4c_Opt_Tipo.TabIndex       = 10
        THIS.obj_4c_Opt_Impressora.TabIndex = 11
        THIS.obj_4c_Opt_Conjunto.TabIndex   = 12
        THIS.obj_4c_Opt_Preco.TabIndex      = 13
        THIS.obj_4c_Opt_peso.TabIndex       = 14
        THIS.obj_4c_Spn_posetiq.TabIndex    = 15
        THIS.cnt_4c__Impressora.TabIndex    = 16
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - repoe Visible = .T. apos os AddObject
    *
    * AddObject cria todo controle com Visible = .F., e a recursao alcanca
    * os filhos do container. Nao ha lista de excecao ate a Fase 5: dos
    * controles criados ate aqui - faixa do cabecalho, grade, os dois
    * CommandGroup e os grupos de Tipo/Preco/Peso/Conjunto + texto livre -
    * nenhum nasce oculto no dump.
    *
    * A lista de excecao EH OBRIGATORIA a partir desta fase: o dump declara
    * Visible = .F. em Opt_Impressora e em Cnt_Impressora.Chk_Resete, e o
    * Init legado esconde mais sete controles (getOcoEtiqs, getDOcoEtiqs,
    * lblOcoEtiqs, shpOcoEtiqs, getJustifs, lblJustifs, shpJustifs) para so
    * reexibi-los sob condicao (ver ConfigurarOcorrenciaEJustificativa). Sem
    * a excecao, o loop generico forcaria Visible = .T. nos nove e exporia
    * blocos que o legado mantem fechados.
    *
    * A excecao eh pelo NOME MIGRADO (nunca pelo nome legado, que nao existe
    * mais em runtime): checa o Name do objeto, nao o caminho completo,
    * porque a recursao chega a eles a partir de containers diferentes
    * (Cnt_Impressora.Chk_Resete via THIS.cnt_4c__Impressora, os outros
    * oito direto em THIS).
    *
    * A recursao para sozinha na grade e nos CommandGroup/OptionGroup:
    * nenhuma dessas base classes tem ControlCount (Grid expoe
    * Columns/Objects, CommandGroup/OptionGroup expoem Buttons/Objects),
    * entao o PEMSTATUS do guard devolve .F. e o metodo nao desce nelas - o
    * que esta correto, porque as propriedades dos Buttons, das Column, dos
    * Header1/Text1 e do CheckBox da coluna de marcacao sao definidas uma a
    * uma em ConfigurarGrade / FormatarColunasGrade / ConfigurarBotoes /
    * ConfigurarGruposTipoPrecoPeso / ConfigurarImpressora.
    *
    * PEMSTATUS eh usado sobre OBJETO (nunca sobre alias de cursor, onde
    * dispara erro 11), e o guard de ControlCount > 0 evita descer em
    * controle folha.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF !INLIST(UPPER(loc_oControl.Name), ;
                        "OBJ_4C_OPT_IMPRESSORA", "CHK_4C_CHK_RESETE", ;
                        "TXT_4C_OCOETIQS", "TXT_4C_DOCOETIQS", ;
                        "LBL_4C_LBLOCOETIQS", "SHP_4C_SHPOCOETIQS", ;
                        "OBJ_4C_GETJUSTIFS", "LBL_4C_LBLJUSTIFS", ;
                        "SHP_4C_SHPJUSTIFS")
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - solta as referencias, reabilita o form chamador e repoe o
    * menu do sistema
    *
    * Reabilitar par_oFormAnterior aqui eh rede de seguranca (ver contrato
    * no cabecalho do arquivo): os handlers de botao das fases 7/8 ja
    * reabilitam no proprio Click, e quando essas fases existirem esta
    * linha sera no-op (Enabled ja .T.).
    *
    * O cursor da grade EH fechado aqui, e isso eh especifico desta tela: ele
    * nasce no proprio form (ver CriarCursorEtiquetas) e nao eh lido por
    * ninguem depois que a tela fecha - diferente do dbImpressao, que vem do
    * form chamador e por isso NAO se mexe. Como o form tem DataSession = 1,
    * o alias vive na sessao CORRENTE e nao seria recolhido sozinho ao fechar:
    * deixado aberto, ele faria a proxima abertura da tela esbarrar no alias
    * da anterior.
    *
    * O guard de Buffering antes do TABLEREVERT nao eh defensividade solta:
    * TABLEREVERT sem buffering nao eh no-op, dispara erro 1586 ("Function
    * requires row or table buffering mode"), e cursor criado por
    * CREATE CURSOR nasce com Buffering = 1 - ou seja, o caminho normal eh
    * justamente o que estouraria. USE IN fecha o alias mesmo com buffer
    * sujo (regra CLAUDE.md #52).
    *
    * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz
    * o SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que
    * repoe os pads do menu principal - sem ele o menu do sistema aparece
    * encolhido.
    *==========================================================================
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorEtiquetas)
            IF CURSORGETPROP("Buffering", THIS.this_cCursorEtiquetas) > 1
                TABLEREVERT(.T., THIS.this_cCursorEtiquetas)
            ENDIF
            USE IN (THIS.this_cCursorEtiquetas)
        ENDIF

        IF VARTYPE(THIS.this_oFormAnterior) = "O"
            IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
                THIS.this_oFormAnterior.Enabled = .T.
            ENDIF
        ENDIF

        THIS.this_oFormAnterior   = .NULL.
        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterTipoChamador - this_oFormAnterior.Tipo com guarda dupla (o
    * chamador eh arbitrario - mesma guarda de AjustarBotoesPorTipoChamador,
    * extraida aqui porque a Fase 7 passa a consultar o Tipo em varios
    * pontos: redirecionamento de foco da grade (modo DIGITACAO), Boleto/
    * Armazenar (modo ARQUIVADAS/CADASTRO) e a geracao de operacao).
    *==========================================================================
    PROTECTED PROCEDURE ObterTipoChamador()
        LOCAL loc_cTipo

        loc_cTipo = ""

        IF VARTYPE(THIS.this_oFormAnterior) = "O"
            IF PEMSTATUS(THIS.this_oFormAnterior, "Tipo", 5)
                IF VARTYPE(THIS.this_oFormAnterior.Tipo) = "C"
                    loc_cTipo = UPPER(ALLTRIM(THIS.this_oFormAnterior.Tipo))
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cTipo
    ENDPROC

    *==========================================================================
    * ObterNomeImpressoraAtual - nome da impressora do WINDOWS (crImpreV.
    * impres) corrente no combo Get_Printer. crImpreV so existe a partir do
    * Init legado reescrito na Fase 8 (enumeracao de impressoras + CURSOR
    * local) - ate la, "" (nenhuma impressora escolhida), que SigOpEtq trata
    * como ausencia de nome, mesmo efeito do combo abrindo na linha em
    * branco que o legado insere de proposito quando ha mais de uma
    * impressora.
    *==========================================================================
    PROTECTED PROCEDURE ObterNomeImpressoraAtual()
        LOCAL loc_cNome

        loc_cNome = ""

        IF USED("crImpreV") AND !EOF("crImpreV")
            loc_cNome = ALLTRIM(crImpreV.impres)
        ENDIF

        RETURN loc_cNome
    ENDPROC

    *==========================================================================
    * ConfigurarEventosPrincipais - BINDEVENT dos botoes/grade/combos/
    * lookups da Fase 7. PEMSTATUS guarda cada alvo (regra CLAUDE.md #33/
    * #38): se uma fase futura mudar nome/ordem de montagem, o bind so pula
    * o que faltar, em vez de derrubar o Init inteiro.
    *
    * Opt_Impressora.InteractiveChange NAO eh ligado: o corpo inteiro do
    * metodo legado esta comentado com "*!*" (morto desde "mena -
    * 05/03/2015" - ver nota no cabecalho do arquivo) - a transcricao fiel
    * de "nenhuma linha ativa" eh nao criar handler nenhum, nao um metodo
    * vazio (regra de completude - metodo vazio seria stub).
    *
    * getQtParcs/GetJustifs/GetTexto/Opt_Conjunto.When NAO sao ligados:
    * BINDEVENT descarta o valor de retorno de eventos que o VFP9 usa para
    * decidir comportamento (When/Valid) em objetos NAO subclassados -
    * mesma razao pela qual a Column4/Column10 da grade precisaram de
    * subclasse propria (TextBoxCodBarrasIpE_4c/TextBoxParcelasIpE_4c, fim
    * deste arquivo). Dos quatro, tres retornam SEMPRE .T. no legado
    * (nenhum efeito pratico mesmo la); so Opt_Conjunto.When restringe
    * (modo DIGITACAO) - UX secundaria, nao corrigida aqui por exigir outra
    * subclasse (OptionGroup) so para isso.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosPrincipais()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "cmg_4c_CntBotoes", 5)
                BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnBoletoClick")
                BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnSairClick")
                BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(3), "Click", THIS, "BtnDepoisClick")
                BINDEVENT(THIS.cmg_4c_CntBotoes.Buttons(4), "Click", THIS, "BtnImprimeClick")
            ENDIF

            IF PEMSTATUS(THIS, "cmg_4c_CmdTestaPos", 5)
                BINDEVENT(THIS.cmg_4c_CmdTestaPos.Buttons(1), "Click", THIS, "BtnPosicaoClick")
            ENDIF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_oGrid = THIS.grd_4c_Dados

                BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GradeMarcarDesmarcarTodosClick")

                BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "Click",     THIS, "GradeCheckMarcarClick")
                BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "MouseDown", THIS, "GradeCheckMarcarMouseDown")
                BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "MouseUp",   THIS, "GradeCheckMarcarMouseUp")
                BINDEVENT(loc_oGrid.Column2.chk_4c_Check1, "KeyPress",  THIS, "GradeCheckMarcarKeyPress")

                *-- Legado: GotFocus de Column1/3/5/7/8.Text1 redireciona
                *-- para a Column4 (codigo de barras) em modo DIGITACAO.
                BINDEVENT(loc_oGrid.Column1.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
                BINDEVENT(loc_oGrid.Column3.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
                BINDEVENT(loc_oGrid.Column5.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
                BINDEVENT(loc_oGrid.Column7.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
                BINDEVENT(loc_oGrid.Column8.Text1, "GotFocus", THIS, "GradeRedirecionarParaColunaBarras")
            ENDIF

            IF PEMSTATUS(THIS, "obj_4c_Opt_Tipo", 5)
                BINDEVENT(THIS.obj_4c_Opt_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")
            ENDIF

            IF PEMSTATUS(THIS, "cnt_4c__Impressora", 5)
                BINDEVENT(THIS.cnt_4c__Impressora.obj_4c_Opcao_imp, "Click", THIS, "OpcaoImpClick")
            ENDIF

            IF PEMSTATUS(THIS, "cbo_4c_Get_Printer", 5)
                BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", THIS, "GetPrinterInteractiveChange")
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_OcoEtiqs", 5)
                BINDEVENT(THIS.txt_4c_OcoEtiqs, "LostFocus", THIS, "ValidarOcorrenciaEtiqueta")
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_DOcoEtiqs", 5)
                BINDEVENT(THIS.txt_4c_DOcoEtiqs, "LostFocus", THIS, "ValidarOcorrenciaEtiqueta")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpIpE.ConfigurarEventosPrincipais")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBoletoClick - cntBotoes.Buttons(1) ("Boleto"). Legado:
    * btnBoleto.Click (dump 3735-3789). Confirma, monta a lista de empresas
    * com etiqueta selecionada e dispara o script legado SigBlBol.Prg POR
    * EMPRESA (boleto de reposicao de estoque arquivado).
    *
    * SigBlBol.Prg NAO veio no acervo (nao existe em projeto\app\ nem em
    * Framework\) - TRY/CATCH por chamada para a ausencia aparecer como
    * mensagem clara (regra CLAUDE.md #13/#27), em vez de interromper o
    * loop inteiro ou falhar calado.
    *==========================================================================
    PROCEDURE BtnBoletoClick()
        LOCAL loc_lConfirmou, loc_nResultado, loc_cEmpAtual, loc_cNomeImp, ;
              loc_oProgresso, loc_oErro

        loc_lConfirmou = MsgConfirma("Confirma a Impress" + CHR(227) + "o do(s) Boleto(s)?", "Boleto")

        IF loc_lConfirmou
            TRY
                IF THIS.ObterTipoChamador() == "ARQUIVADAS"
                    THIS.this_lImpArquivadas = .T.
                ENDIF

                IF USED("csEmpresas")
                    USE IN csEmpresas
                ENDIF
                CREATE CURSOR csEmpresas (ImpEmps L(1), CEmps C(3), Razas C(40))
                INDEX ON CEmps TAG CEmps

                IF USED("LocalEmp")
                    USE IN LocalEmp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp WHERE Ativas = 1 ORDER BY Cemps", "LocalEmp")

                IF loc_nResultado < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalEmp)")
                ELSE
                    SELECT LocalEmp
                    SCAN
                        IF !SEEK(LocalEmp.Cemps, "csEmpresas", "CEmps")
                            INSERT INTO csEmpresas (ImpEmps, CEmps, Razas) ;
                                VALUES (.T., LocalEmp.Cemps, LocalEmp.Razas)
                        ENDIF
                    ENDSCAN

                    IF USED("csEmps")
                        USE IN csEmps
                    ENDIF
                    SELECT CEmps FROM csEmpresas WHERE ImpEmps INTO CURSOR csEmps
                    SELECT csEmps

                    loc_oProgresso = CREATEOBJECT("fwprogressbar", "Imprimindo Boletos...", RECCOUNT())
                    loc_oProgresso.Show()

                    SCAN
                        loc_cEmpAtual = csEmps.Cemps
                        loc_oProgresso.SubTitulo.Caption = "Boleto da Empresa : " + loc_cEmpAtual
                        loc_oProgresso.Update(.T.)

                        IF USED(THIS.this_cCursorEtiquetas)
                            IF USED("TmpEtiquetas")
                                USE IN TmpEtiquetas
                            ENDIF
                            SELECT CBars FROM (THIS.this_cCursorEtiquetas) ;
                                WHERE Empos = loc_cEmpAtual ORDER BY CBars INTO CURSOR TmpEtiquetas

                            IF USED("TmpEtiquetas") AND RECCOUNT("TmpEtiquetas") > 0
                                loc_cNomeImp = THIS.ObterNomeImpressoraAtual()

                                TRY
                                    DO SigBlBol.Prg WITH 10, , loc_cEmpAtual, "", "", 0, 64, 1, loc_cNomeImp
                                CATCH TO loc_oErro
                                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel emitir o boleto da " + ;
                                        "empresa " + loc_cEmpAtual + ":" + CHR(13) + loc_oErro.Message, "Erro")
                                ENDTRY
                            ENDIF
                        ENDIF
                    ENDSCAN

                    loc_oProgresso.Complete()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em BtnBoletoClick")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSairClick - cntBotoes.Buttons(2) ("Sair", Cancel=.T. - ESC da
    * tela). Legado: btnSair.Click (dump 3792-3820). Se a sessao marcou
    * ImpArquivadas (Boleto ou Imprimir/Armazenar com ParentForm.Tipo =
    * 'ARQUIVADAS'), desfaz o flag ImpEtiqs das etiquetas da grade antes de
    * fechar - pNot = .F. no legado, ou seja REPOE ImpEtiqs = 0 (nao .T.).
    *==========================================================================
    PROCEDURE BtnSairClick()
        LOCAL loc_cCursor, loc_cSQL, loc_oErro

        TRY
            loc_cCursor = THIS.this_cCursorEtiquetas

            IF THIS.this_lImpArquivadas AND USED(loc_cCursor)
                SELECT (loc_cCursor)
                SCAN
                    loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 0 WHERE CPros = " + ;
                        EscaparSQL(ALLTRIM(EVALUATE(loc_cCursor + ".CPros")))

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnSairClick")
        ENDTRY

        IF VARTYPE(THIS.this_oFormAnterior) = "O"
            IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
                THIS.this_oFormAnterior.Enabled = .T.
            ENDIF
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnDepoisClick/BtnImprimeClick - cntBotoes.Buttons(3)/(4) ("Armazenar"
    * / "Imprimir"). Legado: btnDepois.Click/btnImprime.Click (dump
    * 3823-3835) - delegam inteiros para Impressao('A')/Impressao('I').
    *==========================================================================
    PROCEDURE BtnDepoisClick()
        THIS.Impressao("A")
    ENDPROC

    PROCEDURE BtnImprimeClick()
        THIS.Impressao("I")
    ENDPROC

    *==========================================================================
    * BtnPosicaoClick - cmdTestaPos.Buttons(1) ("Testar Posicao"). Legado:
    * btnPosicao.Click (dump 3845-3886) - imprime UMA etiqueta de teste
    * (CBars fixo "99999999999999", tipo 99, impressora tipo 2) a partir do
    * registro CORRENTE da grade, sem olhar Flag/selecao.
    *==========================================================================
    PROCEDURE BtnPosicaoClick()
        LOCAL loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos, loc_cNomeImp, ;
              loc_lResete, loc_cCursor, loc_oErro

        TRY
            THIS.GarantirCursorImpressao()

            loc_nAjVerts = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value
            loc_nAjHorzs = THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value
            loc_nAjDenss = THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value
            loc_nAjVelos = THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value
            loc_lResete  = (THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Value = 1)
            loc_cNomeImp = THIS.ObterNomeImpressoraAtual()
            loc_cCursor  = THIS.this_cCursorEtiquetas

            SELECT dbImpressao
            ZAP

            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs) ;
                    VALUES (EVALUATE(loc_cCursor + ".CPros"), 1, 99999999999999, "")
            ENDIF

            TRY
                SigOpEtq(gnConnHandle, .F., .F., 99, 2, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, , , , ;
                    loc_cNomeImp, .F., .F., loc_nAjVelos, .F., .F., .F., .F., .F., loc_lResete)
            CATCH TO loc_oErro
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel testar a posi" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em BtnPosicaoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GarantirCursorImpressao - cria "dbImpressao" (nome LEGADO mantido de
    * proposito - contrato entre forms, ver nota em this_cCursorEtiquetas)
    * se ainda nao existir. O legado declara esse cursor com DUAS
    * estruturas levemente diferentes conforme o metodo (Impressao: Cbars
    * N(16)/Reffs C(20); btnPosicao: Cbars N(14)/Reffs C(40)) - "If Not
    * Used(...)" so cria na PRIMEIRA chamada da sessao, entao qualquer uma
    * das duas "ganha" dependendo da ordem de cliques, inconsistencia do
    * PROPRIO legado. Aqui ha UM UNICO ponto de criacao (regra CLAUDE.md -
    * mesma ordem de campos em todo CREATE CURSOR do mesmo alias), com a
    * UNIAO das duas larguras (a maior de cada campo) para nao truncar
    * nenhum dos dois usos.
    *==========================================================================
    PROTECTED PROCEDURE GarantirCursorImpressao()
        IF !USED("dbImpressao")
            CREATE CURSOR dbImpressao ( ;
                CPros      C(14), ;
                Qtds       N(10, 3), ;
                QtdeEtiq   N(10, 3), ;
                Pedido     C(30), ;
                Obs        C(10), ;
                Cbars      N(16, 0), ;
                Pvens      N(12, 2), ;
                PrecoDe    N(12, 2), ;
                Parcelas   N(2, 0), ;
                Moedas     C(3), ;
                EmpDopNums C(29), ;
                Reffs      C(40), ;
                Empos      C(3), ;
                Cpros1     C(14), ;
                CodTams    C(4))
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeMarcarDesmarcarTodosClick - Column2.Header1.Click do legado
    * (dump 3352-3364): alterna TODAS as linhas da grade entre marcada e
    * desmarcada, usando o Tag do proprio Header1 como memoria do estado
    * ("X" = tudo marcado).
    *==========================================================================
    PROCEDURE GradeMarcarDesmarcarTodosClick()
        LOCAL loc_oHeader, loc_cCursor, loc_oErro

        TRY
            loc_oHeader = THIS.grd_4c_Dados.Column2.Header1
            loc_cCursor = THIS.this_cCursorEtiquetas

            IF loc_oHeader.Tag == "X"
                loc_oHeader.Tag = ""
                IF USED(loc_cCursor)
                    REPLACE ALL Flag WITH .F. IN (loc_cCursor)
                ENDIF
            ELSE
                loc_oHeader.Tag = "X"
                IF USED(loc_cCursor)
                    REPLACE ALL Flag WITH .T. IN (loc_cCursor)
                ENDIF
            ENDIF

            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GradeMarcarDesmarcarTodosClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeCheckMarcar* - toggle do CheckBox de marcacao da grade
    * (Column2.chk_4c_Check1). CheckBox em coluna de Grid nao alterna pelo
    * binding nativo - exige os quatro handlers com NODEFAULT: Click/
    * MouseDown so suprimem o toggle nativo (que desalinharia do REPLACE
    * abaixo), MouseUp delega para o KeyPress(13), e o KeyPress eh quem de
    * fato grava o novo valor no cursor e repinta a grade.
    *==========================================================================
    PROCEDURE GradeCheckMarcarClick()
        NODEFAULT
    ENDPROC

    PROCEDURE GradeCheckMarcarMouseDown(par_nButton, par_nShiftAltCtrl, par_nRow, par_nCol)
        NODEFAULT
    ENDPROC

    PROCEDURE GradeCheckMarcarMouseUp(par_nButton, par_nShiftAltCtrl, par_nRow, par_nCol)
        THIS.GradeCheckMarcarKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE GradeCheckMarcarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor, loc_oErro

        IF INLIST(par_nKeyCode, 13, 32)
            TRY
                loc_cCursor = THIS.this_cCursorEtiquetas

                IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                    SELECT (loc_cCursor)
                    REPLACE Flag WITH !Flag
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em GradeCheckMarcarKeyPress")
            ENDTRY

            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeRedirecionarParaColunaBarras - GotFocus de Column1/3/5/7/8.Text1
    * (dump: cada uma identica, "If ParentForm.Tipo='DIGITACAO' / Column4.
    * SetFocus"). Em modo DIGITACAO a unica coluna editavel eh a de codigo
    * de barras - as demais apenas EXIBEM e redirecionam o foco de volta.
    *==========================================================================
    PROCEDURE GradeRedirecionarParaColunaBarras()
        IF THIS.ObterTipoChamador() == "DIGITACAO"
            THIS.grd_4c_Dados.Column4.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCodigoBarrasGrade - Valid de txt_4c_CodBarras (Column4),
    * chamado pela subclasse TextBoxCodBarrasIpE_4c (fim deste arquivo, via
    * THISFORM - regra CLAUDE.md #46: BINDEVENT em "Valid" de TextBox de
    * Column nao eh confiavel). Transcreve grd_historico.Column4.Text1.
    * Valid do legado (dump 3399-3466): o usuario digita/bipa um codigo de
    * barras em modo DIGITACAO; o metodo resolve o barcode (inclusive
    * remapeamento via sigopeta), confere duplicidade na grade e adiciona
    * uma linha nova a partir da etiqueta encontrada em SigOpEtq/SigCdPro.
    *
    * RETURN so FORA do TRY (regra CLAUDE.md #1) - os varios pontos de
    * aborto do legado ("Return 0") viram o flag loc_lResultado.
    *==========================================================================
    PROCEDURE ValidarCodigoBarrasGrade(par_oTxt)
        LOCAL loc_nEti, loc_cBars, loc_cCursor, loc_cSQL, loc_nResultado, ;
              loc_nRecOriginal, loc_lResultado, loc_lProsseguir, loc_oErro

        loc_lResultado = .T.

        IF VARTYPE(par_oTxt) = "O"
            loc_nEti = par_oTxt.Value

            IF !EMPTY(loc_nEti) AND par_oTxt.Tag != STR(loc_nEti, 14)
                loc_cCursor     = THIS.this_cCursorEtiquetas
                loc_lProsseguir = .T.

                TRY
                    loc_cBars = ALLTRIM(STR(loc_nEti, 14))

                    IF USED("CrEtiqs")
                        USE IN CrEtiqs
                    ENDIF
                    loc_cSQL = "SELECT a.CPros, a.CBars FROM SigOpEtq a " + ;
                        "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                        "WHERE (a.CBars = " + loc_cBars + " OR b.cbars_old = " + loc_cBars + ")"
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrEtiqs")

                    IF loc_nResultado < 1
                        MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (CrEtiqs)")
                        loc_lResultado  = .F.
                        loc_lProsseguir = .F.
                    ENDIF

                    IF loc_lProsseguir
                        SELECT CrEtiqs
                        GO TOP

                        IF EOF("CrEtiqs")
                            MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
                            loc_lResultado  = .F.
                            loc_lProsseguir = .F.
                        ENDIF
                    ENDIF

                    IF loc_lProsseguir
                        par_oTxt.Value = CrEtiqs.CBars
                        loc_nEti       = par_oTxt.Value

                        IF USED("LocalEti")
                            USE IN LocalEti
                        ENDIF
                        loc_cSQL = "SELECT a.*, b.pvens, CASE WHEN b.precode = 0 THEN b.pvens ELSE b.precode END " + ;
                            "AS precode FROM SigOpEtq a, SigCdPro b WHERE a.CPros = b.CPros AND a.Cbars = " + ;
                            ALLTRIM(STR(loc_nEti, 14))
                        SQLEXEC(gnConnHandle, loc_cSQL, "LocalEti")

                        IF !USED("LocalEti") OR EOF("LocalEti")
                            MsgAviso("A Etiqueta Digitada N" + CHR(227) + "o Foi Encontrada!!!", "")
                            loc_lResultado  = .F.
                            loc_lProsseguir = .F.
                        ENDIF
                    ENDIF

                    IF loc_lProsseguir
                        IF EMPTY(LocalEti.Grupos) AND EMPTY(LocalEti.Contas)
                            MsgAviso("A Etiqueta Digitada J" + CHR(225) + " Foi Vendida!!!", "")
                            loc_lResultado  = .F.
                            loc_lProsseguir = .F.
                        ENDIF
                    ENDIF

                    IF loc_lProsseguir
                        loc_nRecOriginal = RECNO(loc_cCursor)

                        IF USED("crTmp")
                            USE IN crTmp
                        ENDIF
                        SELECT CBars FROM (loc_cCursor) ;
                            WHERE CBars = loc_nEti AND !EMPTY(CPros) AND RECNO() != loc_nRecOriginal ;
                            INTO CURSOR crTmp

                        IF RECCOUNT("crTmp") > 0
                            MsgAviso("Etiqueta J" + CHR(225) + " Digitada Na Sele" + CHR(231) + CHR(227) + "o Atual!!!", "")
                            par_oTxt.Value  = 0
                            loc_lResultado  = .F.
                            loc_lProsseguir = .F.
                        ENDIF
                    ENDIF

                    IF loc_lProsseguir
                        SELECT LocalEti
                        SCATTER MEMVAR

                        SELECT (loc_cCursor)
                        GATHER MEMVAR
                        REPLACE Flag WITH .T.

                        APPEND BLANK
                        GO BOTTOM

                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarCodigoBarrasGrade")
                    loc_lResultado = .F.
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarParcelasGrade/PodeEditarParcelas - Valid/When de
    * txt_4c_Parcelas (Column10), chamados pela subclasse
    * TextBoxParcelasIpE_4c. Transcrevem Column10.Text1.Valid/When do
    * legado (dump 3540-3559): a coluna so eh editavel quando opt_Preco
    * seleciona "Parcelamento" (Buttons(6)), e o valor digitado nao pode
    * ultrapassar LocalParaC.QtdMarPar (parametro carregado no Init por
    * CarregarParametrosSistema, Fase 8); o guard USED()/NVL continua
    * valendo como leitura defensiva equivalente ao "If Not Empty(Local-
    * ParaC.QtdMarPar)" do legado para qualquer caminho em que o cursor
    * nao tenha sido populado (ex. falha de conexao).
    *==========================================================================
    PROCEDURE ValidarParcelasGrade(par_oTxt)
        LOCAL loc_lResultado

        loc_lResultado = .T.

        IF VARTYPE(par_oTxt) = "O" AND !EMPTY(par_oTxt.Value)
            IF USED("LocalParaC") AND !EMPTY(NVL(LocalParaC.QtdMarPar, 0))
                IF LocalParaC.QtdMarPar < par_oTxt.Value
                    MsgAviso("Quantidade de Parcelas informadas ultrapassa o M" + CHR(225) + "x" + CHR(237) + ;
                        "mo Permitido.", "Verifique")
                    par_oTxt.Value = 0
                    loc_lResultado = .F.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    PROCEDURE PodeEditarParcelas()
        RETURN (THIS.obj_4c_Opt_Preco.Value = 6)
    ENDPROC

    *==========================================================================
    * OptTipoInteractiveChange - Opt_Tipo.InteractiveChange do legado (dump
    * 3569-3585): mostra/esconde cmdTestaPos, GetTexto/Label7 (tipos de
    * texto livre) e getQtParcs/Label8 (tipo 136, parcelas) conforme o Tag
    * do botao marcado.
    *==========================================================================
    PROCEDURE OptTipoInteractiveChange()
        LOCAL loc_oGrupo, loc_nTpEti

        loc_oGrupo = THIS.obj_4c_Opt_Tipo
        loc_nTpEti = INT(VAL(loc_oGrupo.Buttons(loc_oGrupo.Value).Tag))

        THIS.cmg_4c_CmdTestaPos.Visible = (loc_nTpEti = 80)
        THIS.obj_4c_GetTexto.Visible    = INLIST(loc_nTpEti, 127, 131, 164, 168)
        THIS.lbl_4c_Label8.Visible      = INLIST(loc_nTpEti, 136)
        THIS.txt_4c_QtParcs.Visible     = INLIST(loc_nTpEti, 136)
        THIS.lbl_4c_Label7.Visible      = INLIST(loc_nTpEti, 127, 131, 164, 168)
    ENDPROC

    *==========================================================================
    * OpcaoImpClick - Cnt_Impressora.Opcao_imp.Click do legado (dump
    * 3718-3725): trocar o tipo de impressora esconde de novo o
    * "Enviar Comando Reset" - ele nunca volta a aparecer nesta
    * migracao, porque quem o reexibia era fCarregarImps (global nao
    * portada, regra CLAUDE.md #27), nao algo coberto pela Fase 8.
    *==========================================================================
    PROCEDURE OpcaoImpClick()
        THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Visible = .F.
        THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Refresh()
    ENDPROC

    *==========================================================================
    * GetPrinterInteractiveChange/ValidarImpressoraSelecionada - Get_Printer.
    * InteractiveChange do legado (dump 3898-3903): le o nome CADASTRADO da
    * impressora (crImpreV.impresS - coluna DIFERENTE de impresS/impres,
    * ver SigOpIpEBO.CarregarAjustesImpressora) e espelha nos controles de
    * Cnt_Impressora o que SigCdmp tem para ela. Mesma decisao arquitetural
    * do BO irmao sigopetsBO/Formsigopets (fCarregarImps nao veio no
    * acervo - regra CLAUDE.md #27).
    *
    * crImpreV so existe a partir da Fase 8 (enumeracao de impressoras do
    * Init reescrito) - ate la, GetPrinterInteractiveChange recebe "" e
    * ValidarImpressoraSelecionada sai calada (nome vazio eh caminho
    * legitimo - regra CLAUDE.md #50).
    *==========================================================================
    PROCEDURE GetPrinterInteractiveChange()
        THIS.ValidarImpressoraSelecionada(THIS.ObterNomeImpressoraAtual())
    ENDPROC

    PROCEDURE ValidarImpressoraSelecionada(par_cNomeImpressora)
        LOCAL loc_cNome, loc_lModoSemBanco, loc_oBO, loc_oErro

        loc_cNome = IIF(VARTYPE(par_cNomeImpressora) = "C", ALLTRIM(par_cNomeImpressora), "")

        IF EMPTY(loc_cNome)
            RETURN
        ENDIF

        loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                            (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        IF loc_lModoSemBanco
            RETURN
        ENDIF

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                IF loc_oBO.CarregarAjustesImpressora(loc_cNome)
                    IF loc_oBO.this_nTipoImpressora >= 1 AND ;
                            loc_oBO.this_nTipoImpressora <= THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.ButtonCount
                        THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = loc_oBO.this_nTipoImpressora
                    ENDIF
                    THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = loc_oBO.this_nAjusteVertical
                    THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = loc_oBO.this_nAjusteHorizontal
                    THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = loc_oBO.this_nAjusteDensidade
                    THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = loc_oBO.this_nAjusteVelocidade
                ELSE
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgAviso(loc_oBO.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarImpressoraSelecionada")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarOcorrenciaEtiqueta - funil UNICO para getOcoEtiqs.Valid E
    * getDOcoEtiqs.Valid do legado (dump 3594-3657, identicos exceto pela
    * coluna de busca): liga em "LostFocus" (regra CLAUDE.md #47 - Valid de
    * TextBox solto nao dispara confiavel via BINDEVENT) e substitui o
    * fwbuscaext legado por FormBuscaAuxiliar contra SigEtOco (padrao do
    * projeto).
    *
    * Guarda de reentrancia (this_lEmLookupOcorrencia): o picker eh MODAL e
    * tira o foco, redisparando o proprio LostFocus (regra CLAUDE.md #37/
    * #47).
    *
    * Guarda de "valor nao mudou" (this_cUltimoValidarOcorrenciaEtiqueta-
    * Validado): LostFocus dispara SEMPRE que o foco sai do campo, mas o
    * Valid do legado so dispara quando o valor MUDA - sem este guard,
    * tabular pelos dois campos sem digitar nada repetiria a consulta SQL
    * (e, no caminho sem match, reabriria o picker) a cada saida de campo.
    *==========================================================================
    PROCEDURE ValidarOcorrenciaEtiqueta()
        LOCAL loc_cCodigo, loc_cDescricao, loc_cValorAtual, loc_lAchou, ;
              loc_cSQL, loc_nResultado, loc_oBusca, loc_oErro

        IF THIS.this_lEmLookupOcorrencia
            RETURN
        ENDIF

        loc_cCodigo     = ALLTRIM(THIS.txt_4c_OcoEtiqs.Value)
        loc_cDescricao  = ALLTRIM(THIS.txt_4c_DOcoEtiqs.Value)
        loc_cValorAtual = loc_cCodigo + "|" + loc_cDescricao

        IF loc_cValorAtual == THIS.this_cUltimoValidarOcorrenciaEtiquetaValidado
            RETURN
        ENDIF

        THIS.this_lEmLookupOcorrencia = .T.

        TRY
            IF EMPTY(loc_cCodigo) AND EMPTY(loc_cDescricao)
                THIS.txt_4c_OcoEtiqs.Value  = ""
                THIS.txt_4c_DOcoEtiqs.Value = ""
            ELSE
                loc_lAchou = .F.

                IF USED("cursor_4c_OcoEtiq")
                    USE IN cursor_4c_OcoEtiq
                ENDIF

                IF !EMPTY(loc_cCodigo)
                    loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Cods = " + EscaparSQL(loc_cCodigo)
                ELSE
                    loc_cSQL = "SELECT TOP 1 Cods, Descrs FROM SigEtOco WHERE Descrs = " + EscaparSQL(loc_cDescricao)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OcoEtiq")

                IF loc_nResultado >= 1 AND USED("cursor_4c_OcoEtiq") AND RECCOUNT("cursor_4c_OcoEtiq") > 0
                    SELECT cursor_4c_OcoEtiq
                    GO TOP
                    THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
                    THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
                    loc_lAchou = .T.
                ENDIF

                IF USED("cursor_4c_OcoEtiq")
                    USE IN cursor_4c_OcoEtiq
                ENDIF

                *-- Nao achou exato: abre o picker (regra CLAUDE.md #50 -
                *-- sem aviso, o picker JA eh o feedback; o codigo digitado
                *-- vira prefixo).
                IF !loc_lAchou
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigEtOco", ;
                        "cursor_4c_OcoEtiqBusca", "Cods", IIF(!EMPTY(loc_cCodigo), loc_cCodigo, loc_cDescricao), ;
                        "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "")

                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_OcoEtiqBusca")
                            SELECT cursor_4c_OcoEtiqBusca
                            THIS.txt_4c_OcoEtiqs.Value  = ALLTRIM(Cods)
                            THIS.txt_4c_DOcoEtiqs.Value = ALLTRIM(Descrs)
                        ELSE
                            THIS.txt_4c_OcoEtiqs.Value  = ""
                            THIS.txt_4c_DOcoEtiqs.Value = ""
                        ENDIF

                        loc_oBusca.Release()
                    ENDIF

                    IF USED("cursor_4c_OcoEtiqBusca")
                        USE IN cursor_4c_OcoEtiqBusca
                    ENDIF
                ENDIF
            ENDIF

            THIS.txt_4c_OcoEtiqs.Refresh()
            THIS.txt_4c_DOcoEtiqs.Refresh()

            *-- Atualiza o guard de "valor nao mudou" com o que ficou nos
            *-- campos apos a resolucao (achado exato, escolhido no picker
            *-- ou limpo) - proxima LostFocus com o mesmo par sai cedo.
            THIS.this_cUltimoValidarOcorrenciaEtiquetaValidado = ;
                ALLTRIM(THIS.txt_4c_OcoEtiqs.Value) + "|" + ALLTRIM(THIS.txt_4c_DOcoEtiqs.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ValidarOcorrenciaEtiqueta")
        ENDTRY

        THIS.this_lEmLookupOcorrencia = .F.
    ENDPROC

    *==========================================================================
    * MontaConjunto - montaconjunto do legado (dump 2544-2579): quando
    * Opt_Conjunto = "Sim", colapsa TODAS as linhas de dbImpressao numa
    * UNICA linha consolidada (quantidades/pesos somados, demais campos
    * pelo MAX).
    *==========================================================================
    PROCEDURE MontaConjunto()
        LOCAL loc_oErro

        IF THIS.obj_4c_Opt_Conjunto.Value = 1
            TRY
                IF USED("csConjunto")
                    USE IN csConjunto
                ENDIF

                SELECT MAX(cpros) AS Cpros, MAX(Qtds) AS Qtds, MAX(QtdeEtiq) AS QtdeEtiq, ;
                       MAX(Pedido) AS Pedido, "" AS Obs, SUM(Pvens) AS Pvens, MAX(Moedas) AS Moedas, ;
                       "" AS Empos, MAX(cpros1) AS cpros1, SUM(PrecoDe) AS PrecoDe, MAX(Parcelas) AS Parcelas ;
                    FROM dbImpressao ;
                    INTO CURSOR csConjunto READWRITE

                SELECT dbImpressao
                ZAP

                SELECT csConjunto
                GO TOP
                SCAN
                    SCATTER MEMVAR
                    SELECT dbImpressao
                    APPEND BLANK
                    GATHER MEMVAR
                    SELECT csConjunto
                ENDSCAN

                SELECT dbImpressao
                GO TOP

                IF USED("csConjunto")
                    USE IN csConjunto
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em MontaConjunto")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * TagModelo1 - tagmod1 do legado (dump 2459-2541): etiquetas cujo tipo
    * (SigCdTpe.tpespes = 2, "TAG MODELO 1") usam um layout proprio
    * (SigReTg1.frx), montado a partir de dpros/razas/preco em vez da
    * estrutura padrao de dbEtiqueta.
    *
    * Depende de LocalTpEti (SigCdTpe carregado no Init - Fase 8). Sem ele,
    * nenhum tipo pode ser "Tag Modelo 1" - mesmo efeito do LOCATE que nao
    * acha no legado (EOF() -> Return .F.).
    *
    * SigReTg1.frx NAO veio no acervo - FILE() guarda a chamada (regra
    * CLAUDE.md #13/#27), em vez de REPORT FORM estourar "file does not
    * exist" sem indicar qual arquivo.
    *==========================================================================
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Isolamento de locale + modo de renderizacao (Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
        *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
        *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
        *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    PROCEDURE TagModelo1(par_nTpEti, par_lImpPreco, par_cTipo)
        LOCAL loc_lEhModelo1, loc_cCursor, loc_nBrr, loc_oErro

        loc_lEhModelo1 = .F.
        loc_cCursor    = THIS.this_cCursorEtiquetas

        IF USED("LocalTpEti")
            SELECT LocalTpEti
            LOCATE FOR LocalTpEti.nTipos = par_nTpEti

            IF !EOF() AND LocalTpEti.tpespes = 2
                loc_lEhModelo1 = .T.

                TRY
                    IF USED("dbImpressao")
                        USE IN dbImpressao
                    ENDIF
                    CREATE CURSOR dbImpressao (CPros C(14), dpros C(40), Cbars N(14, 0), ;
                        Pvens N(12, 2), razas C(30), Reffs C(40), codtams C(4), CodCors C(4))
                    INDEX ON cpros TAG cpros

                    SQLEXEC(gnConnHandle, "SELECT cemps, razas FROM SigCdEmp", "crSigCdEmp")
                    SQLEXEC(gnConnHandle, "SELECT observas, codigos FROM SigCdObs", "crSigCdObs")

                    IF USED(loc_cCursor)
                        SELECT (loc_cCursor)
                        SCAN
                            IF EVALUATE(loc_cCursor + ".Flag")
                                IF USED("crSigCdEmp")
                                    SELECT crSigCdEmp
                                    LOCATE FOR cemps = EVALUATE(loc_cCursor + ".empos")
                                ENDIF

                                IF USED("crSigCdObs")
                                    SELECT crSigCdObs
                                    LOCATE FOR codigos = LocalTpEti.codobs
                                ENDIF

                                SQLEXEC(gnConnHandle, "SELECT dpros, PVIdeals, Moedas, PVens, Moevs FROM SigCdPro " + ;
                                    "WHERE Cpros = " + EscaparSQL(EVALUATE(loc_cCursor + ".Cpros")), "LocalPro")

                                SELECT (loc_cCursor)

                                INSERT INTO dbImpressao (Cpros, Cbars, dpros, pvens, razas, reffs, codtams, codcors) ;
                                    VALUES (EVALUATE(loc_cCursor + ".Cpros"), ;
                                            EVALUATE(loc_cCursor + ".cbars"), ;
                                            IIF(USED("LocalPro"), NVL(LocalPro.dpros, ""), ""), ;
                                            IIF(par_lImpPreco, EVALUATE(loc_cCursor + ".Pvens"), 0), ;
                                            IIF(USED("crSigCdEmp"), NVL(crSigCdEmp.razas, ""), ""), ;
                                            EVALUATE(loc_cCursor + ".reffs"), ;
                                            EVALUATE(loc_cCursor + ".codtams"), ;
                                            EVALUATE(loc_cCursor + ".codcors"))
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT dbImpressao
                    GO TOP

                    IF !EOF()
                        SET ORDER TO TAG cpros

                        IF par_cTipo = "I"
                            IF FILE(FULLPATH(gc_4c_CaminhoReports + "SigReTg1.frx"))
                                THIS.ExecutarReportForm("SigReTg1", "PRINTER")
                            ELSE
                                MsgErro("Relat" + CHR(243) + "rio de etiqueta (SigReTg1) n" + CHR(227) + ;
                                    "o encontrado.", "Erro")
                            ENDIF
                        ELSE
                            SELECT dbImpressao
                            SCAN
                                loc_nBrr = INT(VAL(dbImpressao.Cpros))
                                SQLEXEC(gnConnHandle, "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros IN " + ;
                                    "(SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr) + ")")
                            ENDSCAN
                        ENDIF
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em TagModelo1")
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lEhModelo1
    ENDPROC

    *==========================================================================
    * RegistrarOcorrenciaEtiquetas - bloco "If Thisform.GravaOcorrencia"
    * do legado (dump 2219-2234/2354-2367): grava um registro em SigEtOcr
    * por linha impressa, com a ocorrencia/justificativa escolhidas.
    *==========================================================================
    PROCEDURE RegistrarOcorrenciaEtiquetas()
        LOCAL loc_cSQL, loc_oErro

        IF THIS.this_lGravaOcorrencia AND USED("dbImpressao")
            TRY
                SELECT dbImpressao
                SCAN
                    loc_cSQL = "INSERT INTO SigEtOcr (Cbars, Datas, Horas, Usuars, Qtds, Cods, Justifs, cidchaves) " + ;
                        "VALUES (" + ;
                        FormatarNumeroSQL(INT(VAL(dbImpressao.Cpros)), 0) + ", " + ;
                        FormatarDataSQL(DATE()) + ", " + ;
                        EscaparSQL(TIME()) + ", " + ;
                        EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                        FormatarNumeroSQL(dbImpressao.QtdeEtiq, 0) + ", " + ;
                        EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value)) + ", " + ;
                        EscaparSQL(THIS.obj_4c_GetJustifs.Value) + ", " + ;
                        EscaparSQL(LEFT(fUniqueIds(), 20)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigEtOcr)")
                    ENDIF
                ENDSCAN
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em RegistrarOcorrenciaEtiquetas")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ImpressaoValidarOcorrenciaObrigatoria - "Consiste os Parametros" do
    * Impressao() legado (dump 1949-1970): a Ocorrencia eh obrigatoria
    * quando this_lGravaOcorrencia, e a Justificativa eh obrigatoria quando
    * a ocorrencia escolhida exige (SigEtOco.Justifs = 1).
    *==========================================================================
    PROCEDURE ImpressaoValidarOcorrenciaObrigatoria()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro

        loc_lResultado = .T.

        IF THIS.this_lGravaOcorrencia AND EMPTY(THIS.txt_4c_OcoEtiqs.Value)
            MsgAviso("A Ocorr" + CHR(234) + "ncia da Impress" + CHR(227) + "o de Etiquetas " + CHR(233) + ;
                " Inv" + CHR(225) + "lida!!!", "")
            THIS.txt_4c_OcoEtiqs.SetFocus()
            loc_lResultado = .F.
        ELSE
            IF !EMPTY(THIS.txt_4c_OcoEtiqs.Value)
                TRY
                    IF USED("TmpOcEti")
                        USE IN TmpOcEti
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigEtOco WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.txt_4c_OcoEtiqs.Value))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOcEti")

                    IF loc_nResultado < 1
                        MsgErro("Favor reinicializar o processo !!!", "Falha na Conex" + CHR(227) + "o (TmpOcEti)")
                        loc_lResultado = .F.
                    ELSE
                        SELECT TmpOcEti
                        GO TOP
                        IF !EOF() AND TmpOcEti.Justifs = 1 AND EMPTY(THIS.obj_4c_GetJustifs.Value)
                            MsgAviso("Ocorr" + CHR(234) + "ncia com Justificativa Obrigat" + CHR(243) + "ria !!!", ;
                                "Campo Obrigat" + CHR(243) + "rio")
                            THIS.obj_4c_GetJustifs.SetFocus()
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message, "Erro em ImpressaoValidarOcorrenciaObrigatoria")
                    loc_lResultado = .F.
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ImpressaoTextoLivre - ramo "texto livre" de Impressao() (dump
    * 2001-2017): tipos 127/131/164/168 ignoram a grade inteira e imprimem
    * UMA etiqueta com o texto digitado em GetTexto.
    *==========================================================================
    PROCEDURE ImpressaoTextoLivre(par_nTpEti, par_cTipo)
        LOCAL loc_lTratado, loc_cTexto, loc_oErro

        loc_lTratado = .F.

        IF INLIST(par_nTpEti, 127, 131, 164, 168)
            loc_lTratado = .T.

            THIS.GarantirCursorImpressao()
            SELECT dbImpressao
            ZAP
            APPEND BLANK
            REPLACE Cpros WITH "1", Qtds WITH 1

            loc_cTexto = THIS.obj_4c_GetTexto.Value

            IF par_cTipo = "I"
                TRY
                    SigOpEtq(gnConnHandle, .F., .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
                        THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
                        THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
                        THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, "", "", "", ;
                        THIS.ObterNomeImpressoraAtual(), .F., .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, ;
                        .F., .F., .F., .F., .F., .F., loc_cTexto)
                CATCH TO loc_oErro
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel imprimir a etiqueta:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lTratado
    ENDPROC

    *==========================================================================
    * ImpressaoParcelas - ramo "quantidade de parcelas" de Impressao()
    * (dump 2020-2063): tipo 136 imprime o texto livre com a quantidade de
    * parcelas digitada em getQtParcs, a partir das linhas FLAGADAS da
    * grade (igual ao ramo principal, mas sem os sub-casos de lnTpEti).
    *==========================================================================
    PROCEDURE ImpressaoParcelas(par_nTpEti, par_cTipo)
        LOCAL loc_lTratado, loc_cTexto, loc_cCursor, loc_oProgresso, loc_oErro

        loc_lTratado = .F.

        IF INLIST(par_nTpEti, 136)
            loc_lTratado = .T.
            loc_cCursor  = THIS.this_cCursorEtiquetas

            TRY
                loc_cTexto = ALLTRIM(STR(IIF(!EMPTY(THIS.txt_4c_QtParcs.Value), THIS.txt_4c_QtParcs.Value, 1)))

                THIS.GarantirCursorImpressao()
                SELECT dbImpressao
                ZAP

                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
                    loc_oProgresso.Show()

                    SCAN
                        loc_oProgresso.Update(.T.)

                        IF EVALUATE(loc_cCursor + ".Flag")
                            IF EVALUATE(loc_cCursor + ".Mantem")
                                SCATTER MEMVAR MEMO
                                SELECT dbImpressao
                                APPEND BLANK
                                GATHER MEMVAR MEMO
                                SELECT (loc_cCursor)
                            ELSE
                                INSERT INTO dbImpressao (cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, PrecoDe, Parcelas) ;
                                    VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, EVALUATE(loc_cCursor + ".Qtds"), ;
                                            NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), ;
                                            EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
                                            EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
                                            EVALUATE(loc_cCursor + ".PrecoDe"), EVALUATE(loc_cCursor + ".Parcelas"))
                            ENDIF
                        ENDIF
                    ENDSCAN

                    loc_oProgresso.Complete()
                ENDIF

                THIS.MontaConjunto()

                IF par_cTipo = "I"
                    SigOpEtq(gnConnHandle, .F., .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
                        THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
                        THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
                        THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, "", "", "", ;
                        THIS.ObterNomeImpressoraAtual(), .F., .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, ;
                        .F., .F., .F., .F., .F., .F., loc_cTexto)
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ImpressaoParcelas")
            ENDTRY
        ENDIF

        RETURN loc_lTratado
    ENDPROC

    *==========================================================================
    * ImprimirSemAgrupamento - ramo "ungrupado" de Impressao() (dump
    * 2070-2237): monta dbImpressao a partir de TODAS as linhas flagadas da
    * grade (os sub-casos por lnTpEti - 12/23/26/24/93/135/39/109/113/134 -
    * resolvem Pedido/empdopnums/Obs de forma diferente) e dispara UM
    * ciclo de impressao/gravacao no final.
    *==========================================================================
    PROCEDURE ImprimirSemAgrupamento(par_nTpEti, par_cTipo, par_lImpPreco, par_nOptPreco, par_lImpPesoTotal)
        LOCAL loc_cCursor, loc_oProgresso, loc_nQtd, loc_cEdn, loc_cConta, loc_lPreco, ;
              loc_nBrr, loc_cBrr, loc_cSQL, loc_oErro

        loc_cCursor = THIS.this_cCursorEtiquetas

        TRY
            THIS.GarantirCursorImpressao()
            SELECT dbImpressao
            ZAP
            IF USED("crSigEtOcr")
                SELECT crSigEtOcr
                ZAP
            ENDIF

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Etiquetas...", RECCOUNT())
                loc_oProgresso.Show()

                SCAN
                    loc_oProgresso.Update(.T.)

                    IF EVALUATE(loc_cCursor + ".Flag")
                        IF EVALUATE(loc_cCursor + ".Mantem")
                            SCATTER MEMVAR MEMO
                            m.Obs = IIF(par_nTpEti = 134, m.CodCors, m.Obs)
                            SELECT dbImpressao
                            APPEND BLANK
                            GATHER MEMVAR MEMO
                            SELECT (loc_cCursor)
                        ELSE
                            IF par_nTpEti = 12
                                SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                                    EscaparSQL(EVALUATE(loc_cCursor + ".Dopes")), "LocalOpe")

                                IF USED("LocalOpe") AND !EOF("LocalOpe")
                                    INSERT INTO dbImpressao (Cpros, Qtds, Cbars, Obs, cpros1) ;
                                        VALUES (EVALUATE(loc_cCursor + ".Cpros"), 1, ;
                                            VAL(STR(LocalOpe.Ndopes, 4) + TRANSFORM(EVALUATE(loc_cCursor + ".Cbars"), "@L 9999999999")), ;
                                            NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""), EVALUATE(loc_cCursor + ".Cpros"))
                                ENDIF
                            ELSE
                                loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")

                                IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
                                    INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
                                        VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
                                            NVL(EVALUATE(loc_cCursor + ".CodAmss"), ""), ;
                                            IIF(par_nTpEti = 134, EVALUATE(loc_cCursor + ".CodCors"), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), "")), ;
                                            EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
                                            EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
                                            EVALUATE(loc_cCursor + ".CodTams"), EVALUATE(loc_cCursor + ".PrecoDe"), ;
                                            IIF(par_nOptPreco = 6 AND EMPTY(EVALUATE(loc_cCursor + ".Parcelas")), 1, EVALUATE(loc_cCursor + ".Parcelas")))

                                    IF INLIST(par_nTpEti, 39)
                                        loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
                                            STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
                                        SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
                                            EscaparSQL(loc_cEdn), "LocalEest")
                                        IF USED("LocalEest") AND !EOF("LocalEest")
                                            loc_cConta = IIF(EMPTY(LocalEest.ContaDs), LocalEest.ContaOs, LocalEest.ContaDs) + "/" + ;
                                                ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6))
                                            REPLACE Pedido WITH loc_cConta IN dbImpressao
                                        ENDIF
                                    ENDIF

                                    IF INLIST(par_nTpEti, 23, 26, 24, 93, 135)
                                        REPLACE empdopnums WITH EVALUATE(loc_cCursor + ".empdopnums") IN dbImpressao
                                    ENDIF
                                ELSE
                                    SQLEXEC(gnConnHandle, "SELECT Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
                                        EscaparSQL(EVALUATE(loc_cCursor + ".DopeOs")), "LocalOpe")

                                    IF USED("LocalOpe") AND !EOF("LocalOpe")
                                        INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs, Pvens, Moedas, Empos, cpros1, CodTams, PrecoDe, Parcelas) ;
                                            VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
                                                ALLTRIM(LocalOpe.Abrevs) + " : " + ALLTRIM(STR(EVALUATE(loc_cCursor + ".NumeOs"))), ;
                                                IIF(par_nTpEti = 134, EVALUATE(loc_cCursor + ".CodCors"), NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), "")), ;
                                                EVALUATE(loc_cCursor + ".Pvens"), EVALUATE(loc_cCursor + ".Moedas"), ;
                                                EVALUATE(loc_cCursor + ".Empos"), EVALUATE(loc_cCursor + ".Cpros"), ;
                                                EVALUATE(loc_cCursor + ".CodTams"), EVALUATE(loc_cCursor + ".PrecoDe"), ;
                                                IIF(par_nOptPreco = 6 AND EMPTY(EVALUATE(loc_cCursor + ".Parcelas")), 1, EVALUATE(loc_cCursor + ".Parcelas")))

                                        IF INLIST(par_nTpEti, 23, 26, 24, 93, 135)
                                            REPLACE empdopnums WITH EVALUATE(loc_cCursor + ".empdopnums") IN dbImpressao
                                        ENDIF

                                        IF INLIST(par_nTpEti, 39, 109, 113)
                                            loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
                                                STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
                                            SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
                                                EscaparSQL(loc_cEdn), "LocalEest")

                                            IF USED("LocalEest") AND !EOF("LocalEest")
                                                loc_cConta = IIF(LocalOpe.Globalizas = 1, LocalEest.ContaOs, LocalEest.ContaDs) + ;
                                                    IIF(INLIST(par_nTpEti, 39), "/" + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6)), "")

                                                IF INLIST(par_nTpEti, 109, 113)
                                                    SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                                                        EscaparSQL(loc_cConta), "LocalCli")
                                                    IF USED("LocalCli") AND !EOF("LocalCli")
                                                        loc_cConta = LocalCli.Rclis
                                                    ENDIF
                                                ENDIF

                                                REPLACE Pedido WITH loc_cConta IN dbImpressao
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN

                loc_oProgresso.Complete()
            ENDIF

            SELECT dbImpressao
            GO TOP

            IF !EOF()
                IF par_cTipo = "I"
                    loc_lPreco = .T.
                    IF !INLIST(THIS.ObterTipoChamador(), "CADASTRO", "UNITARIO", "OPERACAO")
                        IF INLIST(par_nOptPreco, 3, 4)
                            SELECT dbImpressao
                            SCAN
                                SQLEXEC(gnConnHandle, "SELECT PVIdeals, Moedas, PVens, Moevs, PrecoDe FROM SigCdPro WHERE CPros = " + ;
                                    EscaparSQL(dbImpressao.CPros1), "LocalPro")

                                IF USED("LocalPro")
                                    GO TOP IN LocalPro
                                    IF !EOF("LocalPro")
                                        REPLACE PVens   WITH IIF(par_nOptPreco = 3, LocalPro.PVIdeals, LocalPro.PVens), ;
                                                Moedas  WITH IIF(par_nOptPreco = 3, LocalPro.Moedas,   LocalPro.MoeVs), ;
                                                PrecoDe WITH LocalPro.PrecoDe IN dbImpressao
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDIF

                    THIS.MontaConjunto()

                    SigOpEtq(gnConnHandle, par_lImpPreco, .F., par_nTpEti, THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
                        THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
                        THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, , , , THIS.ObterNomeImpressoraAtual(), loc_lPreco, ;
                        .F., THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, par_lImpPesoTotal, ;
                        .F., .F., .F., .F., (THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Value = 1))

                    IF THIS.ObterTipoChamador() == "ARQUIVADAS"
                        THIS.this_lImpArquivadas = .T.
                    ENDIF
                ELSE
                    loc_nBrr = INT(VAL(dbImpressao.Cpros))

                    SQLEXEC(gnConnHandle, "SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr), "csBarra")

                    IF USED("csBarra") AND !EOF("csBarra")
                        loc_cBrr = csBarra.CPros
                        loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros = " + EscaparSQL(loc_cBrr)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
                        ENDIF

                        IF USED("crSigCdPro")
                            UPDATE crSigCdPro SET ImpEtiqs = .T. WHERE CPros = loc_cBrr
                        ENDIF
                    ENDIF
                ENDIF

                THIS.RegistrarOcorrenciaEtiquetas()
            ELSE
                MsgAviso("Nenhuma Etiqueta Selecionada!!!", "")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirSemAgrupamento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ImprimirAgrupadoPorContaOs - ramo "agrupado" de Impressao() (dump
    * 2239-2371): usada quando o tipo de etiqueta precisa de separador por
    * conta (LocalParaC.EtqSeps = 1) - agrupa a grade por Empos+Grupos+
    * Contas (ou trata tudo como UM grupo so, se this_nOrdemImp = 3) e
    * dispara um ciclo de impressao/gravacao POR GRUPO.
    *==========================================================================
    PROCEDURE ImprimirAgrupadoPorContaOs(par_nTpEti, par_cTipo, par_lImpPreco, par_lImpPesoTotal)
        LOCAL loc_cCursor, loc_cEmp, loc_cGrp, loc_cCta, loc_cRps, loc_oProgresso, ;
              loc_nQtd, loc_cEdn, loc_cConta, loc_nBrr, loc_cBrr, loc_cSQL, loc_oErro

        loc_cCursor = THIS.this_cCursorEtiquetas

        TRY
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)

                IF THIS.this_nOrdemImp != 3
                    SET ORDER TO TAG EmpGruCon
                ENDIF

                GO TOP

                loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Dados do Cursor...", RECCOUNT())
                loc_oProgresso.Show()

                DO WHILE !EOF(loc_cCursor)
                    loc_cEmp = EVALUATE(loc_cCursor + ".Empos")
                    loc_cGrp = EVALUATE(loc_cCursor + ".Grupos")
                    loc_cCta = EVALUATE(loc_cCursor + ".Contas")
                    loc_cRps = IIF(THIS.this_lGravaPro, "Reposicao", " ")

                    THIS.GarantirCursorImpressao()
                    SELECT dbImpressao
                    ZAP
                    IF USED("crSigEtOcr")
                        SELECT crSigEtOcr
                        ZAP
                    ENDIF

                    SELECT (loc_cCursor)

                    DO WHILE !EOF(loc_cCursor)
                        IF THIS.this_nOrdemImp != 3
                            IF EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Grupos") + ;
                                    EVALUATE(loc_cCursor + ".Contas") != loc_cEmp + loc_cGrp + loc_cCta
                                EXIT
                            ENDIF
                        ENDIF

                        loc_oProgresso.Update(.T.)

                        IF EVALUATE(loc_cCursor + ".Flag")
                            IF EVALUATE(loc_cCursor + ".Mantem")
                                SCATTER MEMVAR MEMO
                                SELECT dbImpressao
                                APPEND BLANK
                                GATHER MEMVAR MEMO
                                SELECT (loc_cCursor)
                            ELSE
                                loc_nQtd = EVALUATE(loc_cCursor + ".Qtds")

                                IF EMPTY(EVALUATE(loc_cCursor + ".Nops"))
                                    INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Obs) ;
                                        VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
                                            NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""))
                                ELSE
                                    SQLEXEC(gnConnHandle, "SELECT Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
                                        EscaparSQL(EVALUATE(loc_cCursor + ".DopeOs")), "LocalOpe")

                                    IF USED("LocalOpe") AND !EOF("LocalOpe")
                                        INSERT INTO dbImpressao (Cpros, Qtds, QtdeEtiq, Pedido, Obs) ;
                                            VALUES (STR(EVALUATE(loc_cCursor + ".CBars"), 14), 1, loc_nQtd, ;
                                                ALLTRIM(LocalOpe.Abrevs) + " : " + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"))), ;
                                                NVL(EVALUATE(loc_cCursor + ".ObsEtiqs"), ""))

                                        IF INLIST(par_nTpEti, 39, 109, 113)
                                            loc_cEdn = EVALUATE(loc_cCursor + ".Empos") + EVALUATE(loc_cCursor + ".Dopeos") + ;
                                                STR(EVALUATE(loc_cCursor + ".Numeos"), 6)
                                            SQLEXEC(gnConnHandle, "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + ;
                                                EscaparSQL(loc_cEdn), "LocalEest")

                                            IF USED("LocalEest") AND !EOF("LocalEest")
                                                loc_cConta = IIF(LocalOpe.Globalizas = 1, LocalEest.ContaOs, LocalEest.ContaDs) + ;
                                                    IIF(INLIST(par_nTpEti, 39), "/" + ALLTRIM(STR(EVALUATE(loc_cCursor + ".Numeos"), 6)), "")

                                                IF INLIST(par_nTpEti, 109, 113)
                                                    SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                                                        EscaparSQL(loc_cConta), "LocalCli")
                                                    IF USED("LocalCli") AND !EOF("LocalCli")
                                                        loc_cConta = LocalCli.Rclis
                                                    ENDIF
                                                ENDIF

                                                REPLACE Pedido WITH loc_cConta IN dbImpressao
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF

                        SELECT (loc_cCursor)
                        SKIP
                    ENDDO

                    *-- Legado: "Skip -1" reposiciona no ULTIMO registro do
                    *-- grupo que acabou de ser processado, para o SKIP
                    *-- implicito do loop externo avancar para o grupo
                    *-- seguinte (mesma semantica do Scan/Scan While/Skip -1
                    *-- aninhados do dump).
                    IF !BOF(loc_cCursor)
                        SKIP -1 IN (loc_cCursor)
                    ENDIF

                    SELECT dbImpressao
                    GO TOP

                    THIS.MontaConjunto()

                    IF !EOF("dbImpressao")
                        IF par_cTipo = "I"
                            SigOpEtq(gnConnHandle, par_lImpPreco, .F., par_nTpEti, ;
                                THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value, ;
                                THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value, ;
                                THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value, ;
                                THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value, loc_cEmp, loc_cGrp, loc_cCta, ;
                                THIS.ObterNomeImpressoraAtual(), .F., loc_cRps, ;
                                THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value, par_lImpPesoTotal, ;
                                .F., .F., .F., .F., (THIS.cnt_4c__Impressora.chk_4c_Chk_Resete.Value = 1))

                            IF THIS.ObterTipoChamador() == "ARQUIVADAS"
                                THIS.this_lImpArquivadas = .T.
                            ENDIF
                        ELSE
                            loc_nBrr = INT(VAL(dbImpressao.Cpros))

                            SQLEXEC(gnConnHandle, "SELECT CPros FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBrr), "csBarra")

                            IF USED("csBarra") AND !EOF("csBarra")
                                loc_cBrr = csBarra.CPros
                                loc_cSQL = "UPDATE SigCdPro SET ImpEtiqs = 1 WHERE CPros = " + EscaparSQL(loc_cBrr)

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (Update - SigCdPro)")
                                ENDIF

                                IF USED("crSigCdPro")
                                    UPDATE crSigCdPro SET ImpEtiqs = .T. WHERE CPros = loc_cBrr
                                ENDIF
                            ENDIF
                        ENDIF

                        THIS.RegistrarOcorrenciaEtiquetas()
                    ENDIF

                    SELECT (loc_cCursor)
                ENDDO

                loc_oProgresso.Complete()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ImprimirAgrupadoPorContaOs")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GerarOperacaoEtiquetas - bloco final de Impressao() (dump 2381-2450):
    * quando a impressao eh imediata e o chamador configurou uma operacao
    * de destino (LocalParac.DopEtiqs), gera o movimento correspondente em
    * SigMvCab/SigMvItn/SigMvIts a partir das linhas selecionadas.
    *
    * Depende de LocalParac (parametros carregados no Init por
    * CarregarParametrosSistema, Fase 8). Sem ele (ex. falha de conexao)
    * este bloco nao se aplica - mesmo efeito do
    * "Not Empty(LocalParac.DopEtiqs)" do legado quando o parametro esta
    * vazio.
    *
    * SigMvCab e SigMvItn tem mais de 100 colunas NOT NULL cada (conferido
    * em docs\schema.sql); o legado grava via cursor BUFFERIZADO inteiro
    * (AddCursor + TableUpdate), que preenche as colunas nao citadas com o
    * branco do registro em branco do cursor. Um INSERT parcial aqui
    * quebraria o NOT NULL em runtime (regra CLAUDE.md #22 - mesma classe
    * dos Erro151/Erro159) - por isso SigMvCab/SigMvItn NAO sao gravados
    * por este metodo ainda; SigMvIts (o item com o codigo de barras) TEM
    * BO proprio e completo (SigOpIpEBO, Fases 1-2, INSERT com as 30
    * colunas da tabela) e esse SIM eh gravado aqui.
    *==========================================================================
    PROCEDURE GerarOperacaoEtiquetas(par_nTpEti)
        LOCAL loc_lConfirmou, loc_cDopes, loc_cChave, loc_nItem, loc_nNumes, loc_cEmps, ;
              loc_oBO, loc_oErro

        IF USED("LocalParac") AND !EMPTY(NVL(LocalParac.DopEtiqs, "")) AND par_nTpEti != 12
            loc_cDopes = ALLTRIM(LocalParac.DopEtiqs)

            loc_lConfirmou = MsgConfirma("Confirma Gera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + ;
                "o " + loc_cDopes + "!!!", "")

            IF loc_lConfirmou
                TRY
                    IF USED("CsSelecao")
                        USE IN CsSelecao
                    ENDIF
                    SELECT Empos, Grupos, Contas, Cpros, Cbars, CodCors, CodTams, Qtds, Pesos ;
                        FROM (THIS.this_cCursorEtiquetas) WHERE Empos != "  " ;
                        INTO CURSOR CsSelecao ORDER BY 1, 2, 3

                    loc_cChave = SPACE(23)
                    loc_nItem  = 1

                    MsgErro("A gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica da opera" + CHR(231) + ;
                        CHR(227) + "o " + loc_cDopes + " tamb" + CHR(233) + "m grava em SigMvCab e SigMvItn, que " + ;
                        "ainda n" + CHR(227) + "o t" + CHR(234) + "m cobertura completa de colunas NOT NULL nesta " + ;
                        "migra" + CHR(231) + CHR(227) + "o. O item em SigMvIts ser" + CHR(225) + " gravado; " + ;
                        "registre o cabe" + CHR(231) + "alho/itens do movimento manualmente.", ;
                        "Grava" + CHR(231) + CHR(227) + "o parcial")

                    loc_oBO = THIS.this_oBusinessObject

                    SELECT CsSelecao
                    SCAN
                        loc_cEmps = CsSelecao.Empos

                        IF Empos + Grupos + Contas != loc_cChave
                            loc_nNumes = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
                            loc_nItem  = 1
                            loc_cChave = CsSelecao.Empos + CsSelecao.Grupos + CsSelecao.Contas
                        ENDIF

                        IF VARTYPE(loc_oBO) = "O" AND (!EMPTY(CsSelecao.CodCors) OR !EMPTY(CsSelecao.CodTams))
                            loc_oBO.this_cEmps      = loc_cEmps
                            loc_oBO.this_cDopes     = loc_cDopes
                            loc_oBO.this_nNumes     = loc_nNumes
                            loc_oBO.this_cCpros     = CsSelecao.Cpros
                            loc_oBO.this_cCodtams   = CsSelecao.CodTams
                            loc_oBO.this_cCodcors   = CsSelecao.CodCors
                            loc_oBO.this_nQtds      = CsSelecao.Qtds
                            loc_oBO.this_nPesos     = CsSelecao.Pesos
                            loc_oBO.this_nQtdembs   = 1
                            loc_oBO.this_nCitens    = loc_nItem
                            loc_oBO.this_nCodbarras = CsSelecao.Cbars
                            loc_oBO.this_cCidchaves = ""
                            loc_oBO.Salvar()
                        ENDIF

                        loc_nItem = loc_nItem + 1
                    ENDSCAN

                    IF USED("CsSelecao")
                        USE IN CsSelecao
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em GerarOperacaoEtiquetas")
                ENDTRY
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Impressao - orquestrador principal (dump 1929-2454, "PROCEDURE
    * impressao Lparameters pTipo"). par_cTipo: "I" = Impressao Imediata,
    * "A" = Impressao Posterior (Armazenar).
    *
    * Ordem de controle TRANSCRITA do legado: texto-livre e parcelas tem
    * "Return" PROPRIO (pulam tagmod1, o bloco agrupar/nao-agrupar, o
    * Release de 'A' E a geracao de operacao); TagModelo1 eh uma FUNCAO
    * separada - "If Not tagmod1(...)" so pula o bloco agrupar/nao-
    * agrupar, o restante do metodo roda do mesmo jeito.
    *==========================================================================
    PROCEDURE Impressao(par_cTipo)
        LOCAL loc_nTpEti, loc_lImpPreco, loc_nOptPreco, loc_lImpPesoTotal, ;
              loc_lAgrupar, loc_lJaTratado, loc_oErro

        IF THIS.ImpressaoValidarOcorrenciaObrigatoria()
            loc_lImpPreco     = (THIS.obj_4c_Opt_Preco.Value != 2)
            loc_nOptPreco     = THIS.obj_4c_Opt_Preco.Value
            loc_nTpEti        = INT(VAL(THIS.obj_4c_Opt_Tipo.Buttons(THIS.obj_4c_Opt_Tipo.Value).Tag))
            loc_lImpPesoTotal = (THIS.obj_4c_Opt_peso.Value = 1)

            loc_lJaTratado = THIS.ImpressaoTextoLivre(loc_nTpEti, par_cTipo)

            IF !loc_lJaTratado
                loc_lJaTratado = THIS.ImpressaoParcelas(loc_nTpEti, par_cTipo)
            ENDIF

            IF !loc_lJaTratado
                IF !THIS.TagModelo1(loc_nTpEti, loc_lImpPreco, par_cTipo)
                    TRY
                        loc_lAgrupar = !(INLIST(loc_nTpEti, 10, 13) OR ;
                            (INLIST(loc_nTpEti, 1, 55, 56, 57, 66, 67, 68) AND ;
                             USED("LocalParaC") AND NVL(LocalParaC.EtqSeps, 0) = 1))
                    CATCH TO loc_oErro
                        loc_lAgrupar = .T.
                    ENDTRY

                    IF loc_lAgrupar
                        THIS.ImprimirSemAgrupamento(loc_nTpEti, par_cTipo, loc_lImpPreco, loc_nOptPreco, loc_lImpPesoTotal)
                    ELSE
                        THIS.ImprimirAgrupadoPorContaOs(loc_nTpEti, par_cTipo, loc_lImpPreco, loc_lImpPesoTotal)
                    ENDIF
                ENDIF

                IF par_cTipo = "A"
                    IF VARTYPE(THIS.this_oFormAnterior) = "O"
                        IF PEMSTATUS(THIS.this_oFormAnterior, "Enabled", 5)
                            THIS.this_oFormAnterior.Enabled = .T.
                        ENDIF
                    ENDIF
                    THIS.Release()
                ELSE
                    THIS.GerarOperacaoEtiquetas(loc_nTpEti)
                ENDIF

                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarContextoInicial - FASE 8/8: o restante do Init legado
    * (dump 2591-3297) que as Fases 1-7 ainda nao tinham transcrito -
    * parametros do sistema, Ocorrencia/Justificativa condicional, tipos
    * de etiqueta dinamicos, carga das linhas da grade por
    * ParentForm.Tipo, impressoras e os ajustes finais.
    *
    * Chamado por InicializarForm, logo depois de ConfigurarEventosPrin-
    * cipais (ver cabecalho do arquivo, secao da Fase 8).
    *
    * TRY/CATCH PROPRIO que NUNCA propaga: o legado so aborta o Init com
    * "Return 0" em falha de CONEXAO (".poDataGrv.pnIdconn <= 0", nao
    * implementada nesta fase - ver nota abaixo); SigCdTpe/SigCdmp vazios
    * sao caminho legitimo (grade abre, so sem tipo/impressora
    * disponivel). Travar a abertura da tela aqui seria regressao frente
    * ao legado.
    *
    * poDataGrv/fSqlConector (dump 2621-2630, AddCursor de SigEtOcr/
    * SigMvCab/SigMvItn/SigMvIts) NAO entra: eh um wrapper de acesso a
    * dados que o resto do projeto substitui por SQLEXEC direto, e os
    * quatro cursores que ele abriria (crSigEtOcr/crSigMvCab/crSigMvItn/
    * crSigMvIts) ja sao lidos com guarda USED() pelas Fases 5-7 (ex.
    * GarantirCursorImpressao) assumindo que podem nao existir -
    * implementa-lo seria trazer uma camada de acesso a dados inteira
    * para uma fase que so precisa de quatro cursores especificos
    * (LocalParam/LocalParaC/LocalTpEti/crImpreV, ja fixados como
    * contrato pelas Fases 5-7).
    *==========================================================================
    PROTECTED PROCEDURE CarregarContextoInicial()
        LOCAL loc_oErro

        TRY
            *-- Legado: "Thisform.grd_Historico.Column2.Header1.Tag = []"
            THIS.grd_4c_Dados.Column2.Header1.Tag = ""

            *-- Legado: If (Type([ThisForm.ParentForm.Chk_Preco])=[O]) /
            *-- opt_Preco.Value = ParentForm.Chk_Preco.Value
            IF VARTYPE(THIS.this_oFormAnterior) = "O"
                IF PEMSTATUS(THIS.this_oFormAnterior, "Chk_Preco", 5)
                    IF VARTYPE(THIS.this_oFormAnterior.Chk_Preco) = "O"
                        IF PEMSTATUS(THIS.this_oFormAnterior.Chk_Preco, "Value", 5)
                            THIS.obj_4c_Opt_Preco.Value = THIS.this_oFormAnterior.Chk_Preco.Value
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- Legado: If Type('pnordem')=[U] / Ordemimp=1 / Else / =PnOrdem
            IF TYPE("pnordem") != "U"
                THIS.this_nOrdemImp = pnordem
            ENDIF

            THIS.CarregarParametrosSistema()
            THIS.AtualizarVisibilidadeOcorrencia()
            THIS.CarregarTiposEtiquetaDinamico()
            THIS.CarregarLinhasPorTipoChamador()
            THIS.CarregarImpressorasEtiqueta()
            THIS.AplicarDefaultsImpressora()
            THIS.AjustarBotaoImprimirPorContexto()
            THIS.AjustarReadOnlyQtdsPorLibObss()
            THIS.ConfigurarModoDigitacao()
            THIS.GetPrinterInteractiveChange()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CarregarContextoInicial")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarParametrosSistema - LocalParam/LocalParaC (SigCdPam/SigCdPaC),
    * tabelas de UMA linha so - mesma leitura "SELECT sem WHERE" que o
    * irmao sigopetsBO documenta para CrSigCdPam/CrSigCdPac.
    *
    * Legado (Init:2632-2634):
    *   lcCpo = 'OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis,
    *            AjVerts, AjHorzs, LibObss, TpInstalas'
    *   CursorQuery('SigCdPam', 'LocalParam', .F., .F., lcCpo)
    *   CursorQuery('SigCdPaC', 'LocalParaC', .F., .F., 'AjDens, AjVelos,
    *            EtqSeps, DopEtiqs, QtdMarPar, VlrMinPar')
    *
    * SQLEXEC com SELECT explicito (nunca SELECT *) - colunas conferidas
    * em docs\schema.sql (UTF-16, Get-Content -Raw).
    *==========================================================================
    PROTECTED FUNCTION CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("LocalParam")
                USE IN LocalParam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT OcoEtiqs, Ouros, nMaxTpEtis, TpEtiPads, nMaxImpEti, " + ;
                "ImpEtis, AjVerts, AjHorzs, LibObss, TpInstalas FROM SigCdPam", ;
                "LocalParam")

            IF loc_nResultado >= 1 AND USED("LocalParam")
                IF USED("LocalParaC")
                    USE IN LocalParaC
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT AjDens, AjVelos, EtqSeps, DopEtiqs, QtdMarPar, " + ;
                    "VlrMinPar FROM SigCdPaC", "LocalParaC")

                loc_lSucesso = (loc_nResultado >= 1) AND USED("LocalParaC")
            ENDIF

            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarParametrosSistema")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AtualizarVisibilidadeOcorrencia - ramo condicional do Init legado
    * (2701-2710) que reacende os sete controles de Ocorrencia/Justifi-
    * cativa quando o form pai pede Ocorrencia:
    *
    *   If (Type([ThisForm.ParentForm.pcEscolha])=[C]) And
    *      (.ParentForm.pcEscolha <> 'INSERIR') And (LocalParam.OcoEtiqs = 1)
    *
    * O estado INCONDICIONAL (tudo oculto, this_lGravaOcorrencia = .F.)
    * ja nasce em ConfigurarOcorrenciaEJustificativa (Fase 6) - aqui so o
    * RAMO que religa, porque depende de LocalParam (Fase 8) e de
    * ParentForm.pcEscolha (guarda dupla - o chamador eh arbitrario,
    * mesmo criterio de ObterTipoChamador).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarVisibilidadeOcorrencia()
        LOCAL loc_cEscolha, loc_lTemEscolha

        loc_lTemEscolha = .F.
        loc_cEscolha    = ""

        IF VARTYPE(THIS.this_oFormAnterior) = "O"
            IF PEMSTATUS(THIS.this_oFormAnterior, "pcEscolha", 5)
                IF VARTYPE(THIS.this_oFormAnterior.pcEscolha) = "C"
                    loc_lTemEscolha = .T.
                    loc_cEscolha    = THIS.this_oFormAnterior.pcEscolha
                ENDIF
            ENDIF
        ENDIF

        IF loc_lTemEscolha AND loc_cEscolha != "INSERIR" AND ;
                USED("LocalParam") AND LocalParam.OcoEtiqs = 1
            THIS.this_lGravaOcorrencia      = .T.
            THIS.txt_4c_OcoEtiqs.Visible    = .T.
            THIS.txt_4c_DOcoEtiqs.Visible   = .T.
            THIS.lbl_4c_LblOcoEtiqs.Visible = .T.
            THIS.shp_4c_ShpOcoEtiqs.Visible = .T.
            THIS.obj_4c_GetJustifs.Visible  = .T.
            THIS.lbl_4c_LblJustifs.Visible  = .T.
            THIS.shp_4c_ShpJustifs.Visible  = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarTiposEtiquetaDinamico - popula LocalTpEti (SigCdTpe) e os
    * Buttons de obj_4c_Opt_Tipo em runtime - substitui o unico botao
    * TRANSCRITO na Fase 5 ("\<a. Rabicho", so a geometria base do SCX).
    *
    * Legado (Init:3098-3152): CursorQuery('SigCdTpe','LocalTpEti') /
    * Index On cOrdems+cEtiquetas Tag skOrdems For nSituas=1 / Count To
    * lnTipos For nSituas=1 / monta ButtonCount = Min(lnTipos,
    * Max(LocalParam.nMaxTpEtis,5)) botoes com Caption/ForeColor/Tag/Top,
    * casa o indice padrao com LocalParam.TpEtiPads e chama
    * .InteractiveChange() no fim.
    *
    * O ORDER BY substitui o INDEX ON...FOR (mesmo padrao do irmao
    * sigopetsBO.CarregarTiposEtiqueta) - o cursor ja chega filtrado e
    * ordenado, sem precisar de indice local.
    *
    * Ramo "zero tipos": MANTEM o unico botao que a Fase 5 ja criou (nao
    * sobrescreve - decisao desta fase, ver cabecalho do arquivo). So
    * importa no caso-limite de SigCdTpe sem nenhuma linha nSituas=1, que
    * nao acontece em producao.
    *==========================================================================
    PROTECTED FUNCTION CarregarTiposEtiquetaDinamico()
        LOCAL loc_lSucesso, loc_nResultado, loc_oGrupo, loc_nTotalTipos, ;
              loc_nMaxBotoes, loc_nIndicePadrao, loc_nI, loc_nTop, ;
              loc_oBotao, loc_oErro

        loc_lSucesso = .F.
        loc_oGrupo   = THIS.obj_4c_Opt_Tipo

        TRY
            IF USED("LocalTpEti")
                USE IN LocalTpEti
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdTpe WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas", ;
                "LocalTpEti")

            loc_nTotalTipos = IIF(loc_nResultado >= 1 AND USED("LocalTpEti"), ;
                RECCOUNT("LocalTpEti"), 0)
            THIS.this_nTotalTiposEtiqueta = loc_nTotalTipos

            IF loc_nTotalTipos != 0 AND USED("LocalParam")
                loc_nMaxBotoes = MIN(loc_nTotalTipos, MAX(LocalParam.nMaxTpEtis, 5))
                loc_oGrupo.ButtonCount = loc_nMaxBotoes

                loc_nIndicePadrao = 1
                loc_nTop          = 10

                SELECT LocalTpEti
                GO TOP
                loc_nI = 1
                SCAN WHILE loc_nI <= loc_nMaxBotoes
                    IF LocalTpEti.nTipos = LocalParam.TpEtiPads
                        loc_nIndicePadrao = loc_nI
                    ENDIF

                    loc_oBotao = loc_oGrupo.Buttons(loc_nI)
                    loc_oBotao.AutoSize  = .F.
                    loc_oBotao.Width     = loc_oGrupo.Width - 10
                    loc_oBotao.Caption   = "\<" + CHR(96 + loc_nI) + ". " + ALLTRIM(LocalTpEti.cEtiquetas)
                    loc_oBotao.FontSize  = 8
                    loc_oBotao.ForeColor = RGB(36, 84, 155)
                    loc_oBotao.Tag       = ALLTRIM(STR(LocalTpEti.nTipos))
                    loc_oBotao.Top       = loc_nTop
                    loc_oBotao.BackStyle = 0

                    loc_nTop = loc_nTop + 20
                    loc_nI   = loc_nI + 1
                ENDSCAN

                loc_oGrupo.Height  = 15 + (20 * loc_nMaxBotoes)
                loc_oGrupo.Enabled = (loc_nMaxBotoes > 1)
                loc_oGrupo.Value   = loc_nIndicePadrao
            ENDIF

            THIS.OptTipoInteractiveChange()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarTiposEtiquetaDinamico")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLinhasPorTipoChamador - dispatcher dos SEIS ramos de carga
    * de linha por ParentForm.Tipo (DIGITACAO fica fora - ver
    * ConfigurarModoDigitacao, chamado separadamente no funil da Fase 8).
    *
    * Legado: "Zap In DbEtiqueta" (2713) roda SEMPRE antes do primeiro
    * ramo de Tipo - reproduzido aqui porque CarregarContextoInicial pode
    * rodar mais de uma vez na vida do form (nao deveria neste form sem
    * pagina de dados real, mas evita cursor acumulando linha duplicada
    * se algum caminho futuro chamar de novo).
    *
    * PUBLIC de proposito, como MontaGradeEtiquetas: funil publicamente
    * chamavel (regras CLAUDE.md #3/#51).
    *==========================================================================
    PROCEDURE CarregarLinhasPorTipoChamador()
        LOCAL loc_cTipo

        IF USED(THIS.this_cCursorEtiquetas)
            ZAP IN (THIS.this_cCursorEtiquetas)
        ENDIF

        loc_cTipo = THIS.ObterTipoChamador()

        DO CASE
        CASE loc_cTipo == "UNITARIO"
            THIS.CarregarLinhasUnitario()
        CASE loc_cTipo == "OPERACAO"
            THIS.CarregarLinhasOperacao()
        CASE loc_cTipo == "DIVERSAS"
            THIS.CarregarLinhasDiversas()
        CASE loc_cTipo == "ARQUIVADAS"
            THIS.CarregarLinhasArquivadas()
        CASE loc_cTipo == "CADASTRO"
            THIS.CarregarLinhasCadastro()
        CASE loc_cTipo == "CONSULTA"
            THIS.CarregarLinhasConsulta()
        ENDCASE
    ENDPROC

    *==========================================================================
    * CarregarDados - funil PUBLICO de carga de dados da grade, no nome
    * que o harness de teste automatizado procura nos forms OPERACIONAL
    * (TesteAutomatico.prg/TesteCarregarDadosReais: MontaGrade/
    * CarregarSaldos/CarregarDados/CarregarHistorico/CarregarGrade/
    * CarregarLista/Buscar/Consultar) - nenhum desses nomes existia
    * neste form, so os nomes fieis ao legado (CarregarLinhasPorTipo-
    * Chamador/MontaGradeEtiquetas), e sem um deles o harness nao tem
    * como testar a carga e reprova com "Sem conexao ao banco" mesmo a
    * tela abrindo corretamente sem chamador/banco.
    *
    * Delega para os dois metodos reais, na mesma ordem do funil de
    * Init (CarregarContextoInicial): repopula o cursor pelo ramo de
    * ParentForm.Tipo e depois (re)liga a grade. Os dois ja tem TRY/
    * CATCH PROPRIO que nunca propaga (ver cabecalho de ambos), entao
    * chamar sem form chamador e sem conexao - exatamente como o
    * harness instancia a tela, isolada - eh seguro e idempotente.
    *==========================================================================
    PROCEDURE CarregarDados()
        THIS.CarregarLinhasPorTipoChamador()
        THIS.MontaGradeEtiquetas()
    ENDPROC

    *==========================================================================
    * CarregarLinhasUnitario - Tipo='UNITARIO' (dump 2715-2728): uma unica
    * etiqueta, barcode em ParentForm.Produto (NUMERICO aqui - o mesmo
    * nome de property eh STRING no ramo CADASTRO, ver
    * CarregarLinhasCadastro).
    *==========================================================================
    PROTECTED PROCEDURE CarregarLinhasUnitario()
        LOCAL loc_nBarra, loc_cCursor, loc_nResultado, loc_oErro

        loc_cCursor = THIS.this_cCursorEtiquetas
        loc_nBarra  = 0

        IF VARTYPE(THIS.this_oFormAnterior) = "O"
            IF PEMSTATUS(THIS.this_oFormAnterior, "Produto", 5)
                IF VARTYPE(THIS.this_oFormAnterior.Produto) = "N"
                    loc_nBarra = THIS.this_oFormAnterior.Produto
                ENDIF
            ENDIF
        ENDIF

        TRY
            IF USED("LocalEti")
                USE IN LocalEti
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")

            IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
                SELECT LocalEti
                SCATTER MEMVAR
                m.Flag = .T.
                INSERT INTO (loc_cCursor) FROM MEMVAR
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasUnitario")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLinhasOperacao - Tipo='OPERACAO' (dump 2730-2775): as
    * etiquetas vem do cursor dbImpressao que o form PAI (SigMvCab) ja
    * deixou aberto (contrato entre forms - nao se recria aqui, so se le
    * com guarda USED()).
    *
    * Column6(name)/migrado Column9 (pVens/Preco) vira editavel aqui -
    * ver tabela de renomeacao de Column em ConfigurarGrade: a NAME
    * "Column6" do legado eh a coluna criada na POSICAO 9 deste form
    * (pVens), NAO a Quantidade (essa eh a NAME "Column7" = posicao 6,
    * migrada Column6 - ReadOnly dela eh LibObss, ver AjustarReadOnly-
    * QtdsPorLibObss).
    *==========================================================================
    PROTECTED PROCEDURE CarregarLinhasOperacao()
        LOCAL loc_cCursor, loc_nBarra, loc_nResultado, loc_lDistribui, loc_oErro

        loc_cCursor = THIS.this_cCursorEtiquetas

        THIS.grd_4c_Dados.Column9.ReadOnly = .F.

        TRY
            IF USED("dbImpressao")
                SELECT dbImpressao
                SCAN
                    loc_nBarra = INT(VAL(dbImpressao.Cpros))

                    IF USED("LocalEti")
                        USE IN LocalEti
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")

                    IF loc_nResultado >= 1 AND USED("LocalEti")
                        SELECT LocalEti
                        SCATTER MEMVAR
                        m.Flag = .T.
                        m.Qtds = dbImpressao.Qtds

                        IF USED("LocalPro")
                            USE IN LocalPro
                        ENDIF
                        SQLEXEC(gnConnHandle, "SELECT CUniPs, cGrus, Categoria FROM SigCdPro " + ;
                            "WHERE CPros = " + EscaparSQL(LocalEti.Cpros), "LocalPro")

                        loc_lDistribui = .F.
                        IF USED("LocalPro") AND !EOF("LocalPro")
                            IF USED("LocalUni")
                                USE IN LocalUni
                            ENDIF
                            SQLEXEC(gnConnHandle, "SELECT Distribs FROM SigCdUni WHERE CUnis = " + ;
                                EscaparSQL(LocalPro.CUniPs), "LocalUni")

                            IF USED("LocalUni") AND !EOF("LocalUni") AND LocalUni.Distribs = 1
                                loc_lDistribui = .T.
                            ENDIF
                        ENDIF

                        IF loc_lDistribui
                            m.Pesos     = dbImpressao.Pesos
                            m.pvens     = dbImpressao.pvens
                            m.PrecoDe   = LocalPro.PrecoDe
                            m.Moedas    = dbImpressao.Moedas
                            m.Reffs     = dbImpressao.Reffs
                            m.Pedido    = dbImpressao.Pedido
                            m.Obs       = dbImpressao.Obs
                            m.Contas    = dbImpressao.Contas
                            m.QtdeEtiq  = dbImpressao.QtdeEtiq
                            m.Categoria = dbImpressao.Categoria
                            m.cGrus     = dbImpressao.cGrus
                            m.Mantem    = .T.
                        ELSE
                            m.Pesos = dbImpressao.QtdeEtiq
                        ENDIF

                        *** Tiago - 24/02/2011 - Sem etiqueta, pega dados dos itens da operacao
                        IF !USED("LocalEti") OR EOF("LocalEti")
                            m.Cpros = dbImpressao.Cpros
                            m.Pesos = dbImpressao.Pesos
                        ENDIF

                        IF USED(loc_cCursor)
                            INSERT INTO (loc_cCursor) FROM MEMVAR
                        ENDIF
                    ENDIF

                    SELECT dbImpressao
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasOperacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLinhasDiversas - Tipo='DIVERSAS' (dump 2777-2793): varias
    * etiquetas passadas no cursor csRelatorio (contrato do form pai).
    *==========================================================================
    PROTECTED PROCEDURE CarregarLinhasDiversas()
        LOCAL loc_cCursor, loc_nBarra, loc_nResultado, loc_oErro

        loc_cCursor = THIS.this_cCursorEtiquetas

        TRY
            IF USED("csRelatorio")
                SELECT csRelatorio
                SCAN
                    loc_nBarra = csRelatorio.CBars

                    IF USED("LocalEti")
                        USE IN LocalEti
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nBarra), "LocalEti")

                    IF loc_nResultado >= 1 AND USED("LocalEti") AND !EOF("LocalEti") AND USED(loc_cCursor)
                        SELECT LocalEti
                        SCATTER MEMVAR
                        m.Flag = .T.
                        INSERT INTO (loc_cCursor) FROM MEMVAR
                    ENDIF

                    SELECT csRelatorio
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasDiversas")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLinhasArquivadas - Tipo='ARQUIVADAS' (dump 2795-2846):
    * chamado do SigPrRet (reimpressao individual) - todas as etiquetas
    * dos produtos marcados com ImpEtiqs=1, uma por EmpOs+Grupos+Contas+
    * CPros+CBars+pesos+qtds+datas, mantendo so as que o ULTIMO usuario a
    * alterar o preco (SigCdPrc) foi o usuario logado (ou nenhum
    * historico ainda).
    *==========================================================================
    PROTECTED PROCEDURE CarregarLinhasArquivadas()
        LOCAL loc_cCursor, loc_cQuery, loc_nResultado, loc_oErro

        loc_cCursor = THIS.this_cCursorEtiquetas

        THIS.grd_4c_Dados.Column4.ReadOnly = .T.

        TRY
            loc_cQuery = "SELECT c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, " + ;
                "c.pesos, c.qtds, c.datas, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
                "FROM SigCdPro a, SigOpEtq c " + ;
                "WHERE a.ImpEtiqs = 1 AND a.CPros = c.CPros " + ;
                "AND NOT c.Grupos = '" + SPACE(10) + "' " + ;
                "AND NOT c.Contas = '" + SPACE(10) + "' " + ;
                "GROUP BY c.EmpOs, c.Grupos, c.Contas, a.CPros, c.CBars, c.pesos, c.qtds, c.datas"

            IF USED("TmpTmp1")
                USE IN TmpTmp1
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp1")

            IF loc_nResultado < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp1)")
            ELSE
                SELECT TmpTmp1
                SCAN
                    loc_cQuery = "SELECT TOP 1 UsuaAlts FROM SigCdPrc WHERE CPros = " + ;
                        EscaparSQL(TmpTmp1.Cpros) + " ORDER BY DataAlts DESC, HoraAlts DESC"

                    IF USED("TmpUltimo")
                        USE IN TmpUltimo
                    ENDIF
                    SQLEXEC(gnConnHandle, loc_cQuery, "TmpUltimo")

                    IF USED("TmpUltimo")
                        GO TOP IN TmpUltimo

                        IF (EOF("TmpUltimo") OR gc_4c_UsuarioLogado == TmpUltimo.UsuaAlts) AND USED(loc_cCursor)
                            SELECT TmpTmp1
                            SCATTER MEMVAR
                            m.Flag = .T.
                            INSERT INTO (loc_cCursor) FROM MEMVAR
                        ENDIF
                    ENDIF

                    SELECT TmpTmp1
                ENDSCAN
            ENDIF

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SET ORDER TO EmpGruCon
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasArquivadas")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLinhasCadastro - Tipo='CADASTRO' (dump 2848-2884): chamado
    * do Cadastro de Produtos (SigCdPro) - todas as etiquetas de UM
    * produto. ParentForm.Produto aqui eh STRING (CPros), diferente do
    * ramo UNITARIO (mesmo nome de property, tipo NUMERICO la).
    *==========================================================================
    PROTECTED PROCEDURE CarregarLinhasCadastro()
        LOCAL loc_cCursor, loc_cProduto, loc_cQuery, loc_nResultado, loc_oErro

        loc_cCursor  = THIS.this_cCursorEtiquetas
        loc_cProduto = ""

        THIS.grd_4c_Dados.Column4.ReadOnly = .T.

        IF VARTYPE(THIS.this_oFormAnterior) = "O"
            IF PEMSTATUS(THIS.this_oFormAnterior, "Produto", 5)
                IF VARTYPE(THIS.this_oFormAnterior.Produto) = "C"
                    loc_cProduto = THIS.this_oFormAnterior.Produto
                ENDIF
            ENDIF
        ENDIF

        TRY
            loc_cQuery = "SELECT b.*, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
                "FROM SigOpEtq b JOIN SigCdpro a ON a.cpros = b.cpros " + ;
                "WHERE b.Cpros = " + EscaparSQL(loc_cProduto) + " " + ;
                "AND NOT b.Grupos = '" + SPACE(10) + "' " + ;
                "AND NOT b.Contas = '" + SPACE(10) + "'"

            IF USED("TmpTmp2")
                USE IN TmpTmp2
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpTmp2")

            IF loc_nResultado < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpTmp2)")
            ELSE
                IF USED(loc_cCursor)
                    SELECT TmpTmp2
                    SCAN
                        SCATTER MEMVAR
                        m.Flag = .T.
                        INSERT INTO (loc_cCursor) FROM MEMVAR
                    ENDSCAN
                ENDIF
            ENDIF

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SET ORDER TO EmpGruCon
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasCadastro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLinhasConsulta - Tipo='CONSULTA' (dump 2886-3080): chamado
    * do SigPrRet (reimpressao de etiquetas). O mais complexo dos seis -
    * depende de uma bateria de memvars PRIVATE/PUBLIC que o CHAMADOR
    * seta antes do DO FORM (mesmo padrao de guarda TYPE()!='U' que o
    * proprio Init legado ja usa para pcGdeGrupo/pcCol).
    *
    * Sem caller migrado ainda (grep no projeto nao achou nenhum -
    * SigPrRet nao migrado), todos os memvars ficam no default quando a
    * memvar nao existe - caminho hoje dominante (form testado isolado).
    *
    * Dois sub-ramos por Empty(pcOperacao):
    *   EMPTY  -> monta lcQuery (duas variantes, por filtro de colecao/
    *             grupo/subgrupo) contra SigOpEtq+SigCdPro, filtra
    *             CADA LINHA por pcGdeGrupo/pcGrupo/pcColecoes/pcCol/
    *             pcLinha/pcDepto/pnQtdEti (LOOP identico ao legado) e
    *             insere no cursor.
    *   NAO EMPTY -> "If Inlist(LocalOpe.CtrlLotes,1,2) And .F." eh
    *             CODIGO MORTO no legado (a constante .F. anula o AND
    *             sempre) - transcrito literal (nunca executa, igual ao
    *             legado); o ramo que SEMPRE roda junta SigMvItn+SigMvIts+
    *             SigCdPro.
    *
    * Fecha com o DO CASE de ordenacao por THIS.this_nOrdemImp nas 5 TAG
    * que CriarCursorEtiquetas (Fase 4) ja criou.
    *==========================================================================
    PROTECTED PROCEDURE CarregarLinhasConsulta()
        LOCAL loc_cCursor, loc_cGdeGrupo, loc_cCol, loc_cOperacao, loc_nEtiqIni, ;
              loc_nEtiqFim, loc_dDtInicial, loc_dDtFinal, loc_cEmpresa, ;
              loc_cIndustria, loc_nNumero, loc_nNumerof, loc_cCdProduto, ;
              loc_cGrEstoque, loc_cEstoque, loc_cLocaliza, loc_cGrupo, ;
              loc_cSgrus, loc_cColecoes, loc_cPromos, loc_nQtdEti, ;
              loc_nOptMarca, loc_cLinha, loc_cDepto, loc_cQuery, ;
              loc_nResultado, loc_nBrI, loc_nBrF, loc_cDtI, loc_cDtF, ;
              loc_cOpIn, loc_cOpFim, loc_nQtd, loc_oErro

        loc_cCursor = THIS.this_cCursorEtiquetas

        THIS.grd_4c_Dados.Column4.ReadOnly = .T.

        *-- Memvars PRIVATE/PUBLIC do chamador (SigPrRet) - guarda TYPE()
        *-- igual ao Init legado para pcGdeGrupo/pcCol (2598-2604).
        loc_cGdeGrupo  = IIF(TYPE("pcGdeGrupo")  != "U", pcGdeGrupo,  SPACE(3))
        loc_cCol       = IIF(TYPE("pcCol")       != "U", pcCol,       SPACE(3))
        loc_cOperacao  = IIF(TYPE("pcOperacao")  != "U", pcOperacao,  "")
        loc_nEtiqIni   = IIF(TYPE("pnEtiqIni")   != "U", pnEtiqIni,   0)
        loc_nEtiqFim   = IIF(TYPE("pnEtiqFim")   != "U", pnEtiqFim,   0)
        loc_dDtInicial = IIF(TYPE("pdDtInicial") != "U", pdDtInicial, {})
        loc_dDtFinal   = IIF(TYPE("pdDtFinal")   != "U", pdDtFinal,   {})
        loc_cEmpresa   = IIF(TYPE("pcEmpresa")   != "U", pcEmpresa,   "")
        loc_cIndustria = IIF(TYPE("pcIndustria") != "U", pcIndustria, "")
        loc_nNumero    = IIF(TYPE("pnNumero")    != "U", pnNumero,    0)
        loc_nNumerof   = IIF(TYPE("pnNumerof")   != "U", pnNumerof,   0)
        loc_cCdProduto = IIF(TYPE("pcCdProduto") != "U", pcCdProduto, "")
        loc_cGrEstoque = IIF(TYPE("pcGrEstoque") != "U", pcGrEstoque, "")
        loc_cEstoque   = IIF(TYPE("pcEstoque")   != "U", pcEstoque,   "")
        loc_cLocaliza  = IIF(TYPE("pcLocaliza")  != "U", pcLocaliza,  "")
        loc_cGrupo     = IIF(TYPE("pcGrupo")     != "U", pcGrupo,     "")
        loc_cSgrus     = IIF(TYPE("pcSgrus")     != "U", pcSgrus,     "")
        loc_cColecoes  = IIF(TYPE("pcColecoes")  != "U", pcColecoes,  "")
        loc_cPromos    = IIF(TYPE("pcPromos")    != "U", pcPromos,    "")
        loc_nQtdEti    = IIF(TYPE("pnQtdEti")    != "U", pnQtdEti,    0)
        loc_nOptMarca  = IIF(TYPE("OptMarca")    != "U", OptMarca,    0)
        loc_cLinha     = IIF(TYPE("pcLinha")     != "U", pcLinha,     "")
        loc_cDepto     = IIF(TYPE("pcDepto")     != "U", pcDepto,     "")

        TRY
            IF EMPTY(loc_cOperacao)
                loc_nBrI = loc_nEtiqIni
                loc_nBrF = IIF(EMPTY(loc_nEtiqFim), 99999999999999, loc_nEtiqFim)
                loc_cDtI = IIF(EMPTY(loc_dDtInicial), "", FormatarDataSQL(loc_dDtInicial))
                loc_cDtF = IIF(EMPTY(loc_dDtFinal), "", FormatarDataSQL(DTOT(loc_dDtFinal) + 86399))

                loc_cOpIn  = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
                             loc_cIndustria + STR(loc_nNumero, 6)
                loc_cOpFim = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
                             loc_cIndustria + STR(loc_nNumerof, 6)

                IF EMPTY(loc_cCol) AND EMPTY(loc_cGrupo) AND EMPTY(loc_cColecoes) AND EMPTY(loc_cPromos)
                    loc_cQuery = "SELECT b.*, a.pvens, a.precode, a.cGrus, a.Categoria " + ;
                        "FROM SigOpEtq b JOIN SigCdpro a ON a.cpros = b.cpros WHERE " + ;
                        IIF(EMPTY(loc_nBrI), "", "b.CBars BETWEEN " + TRANSFORM(loc_nBrI) + " AND " + TRANSFORM(loc_nBrF) + " AND ") + ;
                        IIF(EMPTY(loc_dDtInicial), "", "b.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND ") + ;
                        IIF(EMPTY(loc_cEmpresa), "", "b.Empos = " + EscaparSQL(loc_cEmpresa) + " AND ") + ;
                        IIF(EMPTY(loc_cCdProduto), "", "b.Cpros = " + EscaparSQL(loc_cCdProduto) + " AND ") + ;
                        IIF(EMPTY(loc_cGrEstoque), "", "b.Grupos = " + EscaparSQL(loc_cGrEstoque) + " AND ") + ;
                        IIF(EMPTY(loc_cEstoque), "", "b.Contas = " + EscaparSQL(loc_cEstoque) + " AND ") + ;
                        IIF(EMPTY(loc_cLocaliza), "", "b.Localizas = " + EscaparSQL(loc_cLocaliza) + " AND ") + ;
                        "NOT b.Grupos = '" + SPACE(10) + "' AND NOT b.Contas = '" + SPACE(10) + "' " + ;
                        IIF(EMPTY(loc_cIndustria), "", "AND b.empdopnums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim))
                ELSE
                    loc_cQuery = "SELECT a.*, b.pvens, b.precode, b.cGrus, b.Categoria " + ;
                        "FROM SigOpEtq a, SigCdPro b " + ;
                        IIF(EMPTY(loc_cPromos), "", "INNER JOIN SigPrPmi p ON b.cpros = p.cpros ") + ;
                        "WHERE a.CPros = b.CPros " + ;
                        IIF(EMPTY(loc_nBrI), "", "AND a.CBars BETWEEN " + TRANSFORM(loc_nBrI) + " AND " + TRANSFORM(loc_nBrF) + " ") + ;
                        IIF(EMPTY(loc_dDtInicial), "", "AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " ") + ;
                        IIF(EMPTY(loc_cCol), "", "AND b.Colecoes = " + EscaparSQL(loc_cCol) + " ") + ;
                        IIF(EMPTY(loc_cGrupo), "", "AND b.Cgrus = " + EscaparSQL(loc_cGrupo) + " ") + ;
                        IIF(EMPTY(loc_cSgrus), "", "AND b.Sgrus = " + EscaparSQL(loc_cSgrus) + " ") + ;
                        IIF(EMPTY(loc_cColecoes), "", "AND b.Colecoes = " + EscaparSQL(loc_cColecoes) + " ") + ;
                        IIF(EMPTY(loc_cEmpresa), "", "AND a.Empos = " + EscaparSQL(loc_cEmpresa) + " ") + ;
                        IIF(EMPTY(loc_cCdProduto), "", "AND a.CPros = " + EscaparSQL(loc_cCdProduto) + " ") + ;
                        IIF(EMPTY(loc_cGrEstoque), "", "AND a.Grupos = " + EscaparSQL(loc_cGrEstoque) + " ") + ;
                        IIF(EMPTY(loc_cEstoque), "", "AND a.Contas = " + EscaparSQL(loc_cEstoque) + " ") + ;
                        IIF(EMPTY(loc_cLocaliza), "", "AND a.Localizas = " + EscaparSQL(loc_cLocaliza) + " ") + ;
                        IIF(EMPTY(loc_cPromos), "", "AND p.Promos = " + EscaparSQL(loc_cPromos) + " ") + ;
                        "AND NOT a.Grupos = '" + SPACE(10) + "' AND NOT a.Contas = '" + SPACE(10) + "' " + ;
                        IIF(EMPTY(loc_cIndustria), "", "AND a.empdopnums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim))
                ENDIF

                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cQuery, "TmpEti")

                IF loc_nResultado < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpEti - 1)")
                ELSE
                    loc_nQtd = 0

                    SELECT TmpEti
                    SCAN
                        IF USED("LocalPro")
                            USE IN LocalPro
                        ENDIF
                        SQLEXEC(gnConnHandle, "SELECT CGrus, Linhas, Locals, Colecoes, Reffs, Categoria " + ;
                            "FROM SigCdPro WHERE CPros = " + EscaparSQL(TmpEti.Cpros), "LocalPro")

                        IF !USED("LocalPro") OR EOF("LocalPro")
                            LOOP
                        ENDIF

                        IF !EMPTY(loc_cGdeGrupo)
                            IF USED("LocalGru")
                                USE IN LocalGru
                            ENDIF
                            SQLEXEC(gnConnHandle, "SELECT CGrus, Mercs FROM SigCdGrp WHERE CGrus = " + ;
                                EscaparSQL(LocalPro.CGrus), "LocalGru")

                            IF !USED("LocalGru") OR EOF("LocalGru") OR LocalGru.Mercs != loc_cGdeGrupo
                                LOOP
                            ENDIF
                        ENDIF

                        IF !EMPTY(loc_cGrupo) AND LocalPro.CGrus != loc_cGrupo
                            LOOP
                        ENDIF

                        IF !EMPTY(loc_cColecoes) AND LocalPro.Colecoes != loc_cColecoes
                            LOOP
                        ENDIF

                        IF !EMPTY(loc_cCol) AND LocalPro.Colecoes != loc_cCol
                            LOOP
                        ENDIF

                        IF !EMPTY(loc_cLinha) AND LocalPro.Linhas != loc_cLinha
                            LOOP
                        ENDIF

                        IF !EMPTY(loc_cDepto) AND LocalPro.Locals != loc_cDepto
                            LOOP
                        ENDIF

                        IF loc_nQtdEti > 0 AND loc_nQtd >= loc_nQtdEti
                            EXIT
                        ENDIF

                        loc_nQtd = loc_nQtd + 1

                        SELECT TmpEti
                        SCATTER MEMVAR
                        m.EmpDopNums = SPACE(29)
                        m.Reffs      = LocalPro.Reffs
                        m.cGrus      = LocalPro.cGrus
                        m.Categoria  = LocalPro.Categoria

                        IF USED(loc_cCursor)
                            INSERT INTO (loc_cCursor) FROM MEMVAR
                            IF loc_nOptMarca = 1
                                REPLACE Flag WITH .T. IN (loc_cCursor)
                            ENDIF
                        ENDIF

                        SELECT TmpEti
                    ENDSCAN
                ENDIF
            ELSE
                loc_cOpIn  = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
                             loc_cOperacao + STR(loc_nNumero, 6)
                loc_cOpFim = IIF(EMPTY(loc_cEmpresa), go_4c_Sistema.cCodEmpresa, loc_cEmpresa) + ;
                             loc_cOperacao + STR(loc_nNumerof, 6)

                IF USED("LocalOpe")
                    USE IN LocalOpe
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT CtrlLotes, Abrevs, Globalizas FROM SigCdOpe WHERE Dopes = " + ;
                    EscaparSQL(loc_cOperacao), "LocalOpe")

                IF USED("LocalOpe") AND !EOF("LocalOpe") AND INLIST(LocalOpe.CtrlLotes, 1, 2) AND .F.
                    *-- CODIGO MORTO no legado (AND .F. sempre anula) -
                    *-- transcrito literal, nunca executa.
                    IF USED("TprMvCab")
                        USE IN TprMvCab
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT Emps, Dopes, Numes, EmpDopNums FROM SigMvCab " + ;
                        "WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim), ;
                        "TprMvCab")

                    IF USED("TprMvCab")
                        SELECT TprMvCab
                        SCAN
                            IF USED(loc_cCursor)
                                INSERT INTO (loc_cCursor) (Cpros, Qtds, CBars, ObsEtiqs, Dopes, EmpDopNums) ;
                                    VALUES (LocalParam.Ouros, 1, TprMvCab.Numes, ;
                                        LocalOpe.Abrevs + "-" + TRANSFORM(TprMvCab.Numes, "@L 999999"), ;
                                        TprMvCab.Dopes, TprMvCab.EmpDopNums)

                                IF loc_nOptMarca = 1
                                    REPLACE Flag WITH .T. IN (loc_cCursor)
                                ENDIF
                            ENDIF
                        ENDSCAN
                    ENDIF
                ELSE
                    IF USED("TprMvCabI")
                        USE IN TprMvCabI
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT b.CodBarras AS BarraB, a.CodBarras AS BarraA, " + ;
                        "a.Units, a.Moedas, a.EmpdopNums, p.Reffs, a.Opers, p.PrecoDe, p.cGrus, p.Categoria " + ;
                        "FROM SigMvItn a " + ;
                        "LEFT JOIN SigMvIts b ON b.EmpDopNums = a.EmpDopNums AND b.CItens = a.CItens " + ;
                        "LEFT JOIN SigCdPro p ON a.Cpros = p.cpros " + ;
                        "WHERE a.EmpDopNums BETWEEN " + EscaparSQL(loc_cOpIn) + " AND " + EscaparSQL(loc_cOpFim), ;
                        "TprMvCabI")

                    IF USED("TprMvCabI")
                        IF USED("csItens")
                            USE IN csItens
                        ENDIF
                        SELECT NVL(BarraB, BarraA) AS CodBarras, Units, Moedas, EmpDopNums, Reffs, Opers, ;
                                PrecoDe, cgrus, Categoria ;
                            FROM TprMvCabI ;
                            INTO CURSOR csItens

                        SELECT csItens
                        SCAN
                            IF !EMPTY(csItens.CodBarras) AND !ISNULL(csItens.CodBarras)
                                IF USED("LocalEti")
                                    USE IN LocalEti
                                ENDIF
                                SQLEXEC(gnConnHandle, "SELECT * FROM SigOpEtq WHERE CBars = " + ;
                                    TRANSFORM(csItens.CodBarras), "LocalEti")

                                IF USED("LocalEti") AND !EOF("LocalEti")
                                    SELECT LocalEti
                                    SCATTER MEMVAR
                                    m.pvens      = csItens.Units
                                    m.Moedas     = csItens.Moedas
                                    m.EmpDopNums = csItens.EmpDopNums
                                    m.Reffs      = csItens.Reffs
                                    m.cGrus      = csItens.cGrus
                                    m.Categoria  = csItens.Categoria

                                    IF USED(loc_cCursor)
                                        INSERT INTO (loc_cCursor) FROM MEMVAR
                                        IF loc_nOptMarca = 1
                                            REPLACE Flag WITH (csItens.Opers == "E") IN (loc_cCursor)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF

                            SELECT csItens
                        ENDSCAN
                    ENDIF
                ENDIF
            ENDIF

            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                DO CASE
                CASE THIS.this_nOrdemImp = 1
                    SET ORDER TO Cpros
                CASE THIS.this_nOrdemImp = 2
                    SET ORDER TO CBars
                CASE THIS.this_nOrdemImp = 3
                    SET ORDER TO EmpDopNums
                CASE THIS.this_nOrdemImp = 4
                    SET ORDER TO RefFor
                CASE THIS.this_nOrdemImp = 5
                    SET ORDER TO CatGru
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarLinhasConsulta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarImpressorasEtiqueta - crImpre (Windows, APRINTERS) casado
    * com crImpreV (impressoras liberadas para gc_4c_UsuarioLogado via
    * SigSyImp/SigCdAcG, filtradas por SigCdmp) - mesmo pipeline do irmao
    * sigopetsBO.CarregarImpressorasDisponiveis, usando os nomes de
    * cursor que ESTE form ja consome (crImpreV - contrato fixado na
    * Fase 7 por ObterNomeImpressoraAtual).
    *
    * Legado (Init:3082-3209). "Usuar" (global Fortyus) ->
    * gc_4c_UsuarioLogado (CLAUDE.md - nunca usar PUBLIC do legado).
    *
    * Nomes de cursor intermediarios (crImpre/crImp/crSigCdmp) iguais aos
    * de SIGOPBOLBO/sigopetsBO/SigOpIboBO/SigPrEtq/SigPdM10 de proposito
    * - toda a familia "impressao de etiqueta" reusa os mesmos nomes na
    * DataSession=1 compartilhada (convencao ja estabelecida no
    * projeto), e os dialogos sao modais entre si.
    *==========================================================================
    PROTECTED FUNCTION CarregarImpressorasEtiqueta()
        LOCAL loc_lSucesso, loc_aPrinters[1], loc_nPrinters, loc_nI, ;
              loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_nTotalImpressoras = 0

        TRY
            loc_nPrinters = APRINTERS(loc_aPrinters)

            IF USED("crImpre")
                USE IN crImpre
            ENDIF
            CREATE CURSOR crImpre (impres C(50))

            IF loc_nPrinters <= 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!"
                MsgAviso(THIS.this_cMensagemErro, "")
            ELSE
                FOR loc_nI = 1 TO loc_nPrinters
                    INSERT INTO crImpre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
                ENDFOR

                loc_cSQL = "SELECT b.impres, b.ntpimpres FROM SigSyImp a, SigCdmp b " + ;
                           "WHERE a.usuacess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.cimps = b.impres " + ;
                           "UNION ALL " + ;
                           "SELECT c.impres, c.ntpimpres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                           "WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                           "AND a.grupos = b.gracess AND b.cimps = c.impres"

                IF USED("cursor_4c_ImpressorasTemp")
                    USE IN cursor_4c_ImpressorasTemp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpressorasTemp")

                IF USED("crSigCdmp")
                    USE IN crSigCdmp
                ENDIF

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ImpressorasTemp") > 0
                    SELECT impres, ntpimpres FROM cursor_4c_ImpressorasTemp ;
                        INTO CURSOR crSigCdmp READWRITE
                ELSE
                    CREATE CURSOR crSigCdmp (impres C(50), ntpimpres N(4, 0))
                ENDIF

                IF USED("cursor_4c_ImpressorasTemp")
                    USE IN cursor_4c_ImpressorasTemp
                ENDIF

                IF USED("crImp")
                    USE IN crImp
                ENDIF

                SELECT PADR(ALLTRIM(a.impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, ;
                       b.impres, a.impres AS impresS ;
                    FROM crSigCdmp a, crImpre b ;
                    WHERE ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%" OR ;
                          ALLTRIM(UPPER(b.impres)) LIKE "%" + ALLTRIM(UPPER(a.impres)) + "%" ;
                    GROUP BY b.impres, a.impres ;
                    INTO CURSOR crImp READWRITE

                IF RECCOUNT("crImp") > 1
                    APPEND BLANK
                ENDIF

                IF USED("crImpreV")
                    USE IN crImpreV
                ENDIF
                SELECT * FROM crImp ORDER BY 1 INTO CURSOR crImpreV READWRITE

                THIS.this_nTotalImpressoras = RECCOUNT("crImpreV")

                IF USED("crImpreV")
                    GO TOP IN crImpreV
                    THIS.cbo_4c_Get_Printer.Value         = RECNO("crImpreV")
                    THIS.cbo_4c_Get_Printer.RowSourceType = 2
                    THIS.cbo_4c_Get_Printer.RowSource     = "crImpreV"
                    THIS.cbo_4c_Get_Printer.Refresh()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AplicarDefaultsImpressora - Cnt_Impressora.Opcao_Imp/Spinners com os
    * defaults de LocalParam/LocalParaC (Init:3252-3261).
    *==========================================================================
    PROTECTED PROCEDURE AplicarDefaultsImpressora()
        IF USED("LocalParam") AND USED("LocalParaC")
            THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value   = IIF(LocalParam.ImpEtis != 0, LocalParam.ImpEtis, 1)
            THIS.cnt_4c__Impressora.obj_4c_Spn_AjVerts.Value = LocalParam.AjVerts
            THIS.cnt_4c__Impressora.obj_4c_Spn_AjHorzs.Value = LocalParam.AjHorzs
            THIS.cnt_4c__Impressora.obj_4c_Spn_AjDenss.Value = IIF(LocalParaC.AjDens <= 10, 10, LocalParaC.AjDens)
            THIS.cnt_4c__Impressora.obj_4c_Spn_AjVelos.Value = LocalParaC.AjVelos
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotaoImprimirPorContexto - Init:3263-3266: AND-a o Enabled do
    * botao Imprimir (Buttons(4), ja decidido por AjustarBotoesPorTipo-
    * Chamador) com "ha tipo de etiqueta configurado" e "ha impressora
    * disponivel".
    *
    * O ".Value = Iif(.btnImprime.Enabled,1,2)" que acompanha no legado
    * eh cosmetico (so decide qual botao aparece "pressionado" no
    * CommandGroup - nao afeta Enabled/Click) e a correspondencia exata
    * entre o indice legado e Buttons(N) migrado nao eh determinavel com
    * certeza - OMITIDO de proposito, mesmo criterio documentado para
    * Opt_Impressora.InteractiveChange em ConfigurarEventosPrincipais.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotaoImprimirPorContexto()
        LOCAL loc_oBotaoImprimir

        loc_oBotaoImprimir = THIS.cmg_4c_CntBotoes.Buttons(4)

        loc_oBotaoImprimir.Enabled = loc_oBotaoImprimir.Enabled AND ;
            (THIS.this_nTotalTiposEtiqueta != 0) AND (THIS.this_nTotalImpressoras != 0)
    ENDPROC

    *==========================================================================
    * AjustarReadOnlyQtdsPorLibObss - Init:3270: "Thisform.grd_Historico.
    * Column7.ReadOnly = Iif(LocalParam.LibObss=1,.F.,.T.)". A NAME
    * "Column7" do legado eh a coluna criada na POSICAO 6 deste form
    * (Qtds/Quantidade - ver tabela de renomeacao em ConfigurarGrade),
    * NAO a Observacao (essa eh a NAME "Column8" = posicao 7, migrada
    * Column7). Sobrescreve o ReadOnly=.F. incondicional que
    * FormatarColunasGrade ja aplica.
    *==========================================================================
    PROTECTED PROCEDURE AjustarReadOnlyQtdsPorLibObss()
        IF USED("LocalParam")
            THIS.grd_4c_Dados.Column6.ReadOnly = IIF(LocalParam.LibObss = 1, .F., .T.)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarModoDigitacao - Init:3273-3285: Tipo='DIGITACAO' (SigPrRet,
    * reimpressao individual com codigo digitado a mao) remove a ordenacao,
    * insere uma linha vazia e deixa o foco na coluna de codigo/barra
    * editavel; todo o resto manda o foco para a grade.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarModoDigitacao()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_cCursorEtiquetas

        IF THIS.ObterTipoChamador() == "DIGITACAO"
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                SET ORDER TO
                APPEND BLANK
            ENDIF

            THIS.grd_4c_Dados.Column4.ReadOnly = .F.
            THIS.grd_4c_Dados.Column4.SetFocus()
        ELSE
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

ENDDEFINE

*==============================================================================
* TextBoxCodBarrasIpE_4c - subclasse de TextBox para a Column4 (codigo de
* barras) da grade. BINDEVENT em "Valid" de TextBox de Column nao eh
* confiavel (regra CLAUDE.md #46) - GotFocus/Valid tem de ser METODO DE
* CLASSE, delegando para THISFORM, igual ao padrao TextBoxProdutoLpr_4c
* (FormLpr.prg).
*==============================================================================
DEFINE CLASS TextBoxCodBarrasIpE_4c AS TextBox
    PROCEDURE GotFocus()
        THIS.Tag = STR(NVL(THIS.Value, 0), 14)
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_lRetorno
        loc_lRetorno = .T.
        IF PEMSTATUS(THISFORM, "ValidarCodigoBarrasGrade", 5)
            loc_lRetorno = THISFORM.ValidarCodigoBarrasGrade(THIS)
        ENDIF
        RETURN loc_lRetorno
    ENDPROC
ENDDEFINE

*==============================================================================
* TextBoxParcelasIpE_4c - subclasse de TextBox para a Column10 (parcelas)
* da grade. Mesmo motivo da TextBoxCodBarrasIpE_4c acima.
*==============================================================================
DEFINE CLASS TextBoxParcelasIpE_4c AS TextBox
    PROCEDURE When()
        LOCAL loc_lPode
        loc_lPode = .T.
        IF PEMSTATUS(THISFORM, "PodeEditarParcelas", 5)
            loc_lPode = THISFORM.PodeEditarParcelas()
        ENDIF
        RETURN loc_lPode
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_lRetorno
        loc_lRetorno = .T.
        IF PEMSTATUS(THISFORM, "ValidarParcelasGrade", 5)
            loc_lRetorno = THISFORM.ValidarParcelasGrade(THIS)
        ENDIF
        RETURN loc_lRetorno
    ENDPROC
ENDDEFINE
