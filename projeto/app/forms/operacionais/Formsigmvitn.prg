*==============================================================================
* Formsigmvitn.prg - Caixa (Itens da Movimentacao / Frente de Caixa)
* Origem: SIGMVITN.SCX (tasks\task571\sigmvitn_form_codigo_fonte_slim.txt)
* Herda de: FormBase
* Tipo: OPERACIONAL - NAO segue o padrao Page1=Lista/Page2=Dados dos forms
*        CRUD (frmcadastro). O legado nao usa PageFrame: e um unico form com
*        varios containers "flutuantes" (Visible=.F.) que se alternam por
*        botao - Cnt_Consulta, CntItem, CntFinanc, Cnt_Credito, Cnt_Pendencia,
*        Cnt_Identifica, Cnt_Fpagto, CancelaItem, CaixaLivre, etc. (ver
*        tasks\task571\layout.json / mapeamento.json).
*
* Abertura: form filho, invocado por um form de movimentacao (equivalente ao
*           legado "Lparameters pForm, pnDatSes"). par_oParentForm e
*           desabilitado enquanto este form estiver aberto (mesmo padrao de
*           FormDCC.prg) e reabilitado no Destroy().
*
* FASE 3/8: ESTRUTURA BASE - DEFINE CLASS + propriedades + Init/InicializarForm/
* Destroy + TODOS os containers estruturais de topo do legado, criados vazios
* com a geometria e o visual EXATOS do SCX:
*   lbl_4c_TxtCaption (barra de titulo flat), cnt_4c__Img4c, img_4c_FigJpg,
*   obj_4c_Timer1, cnt_4c__Consulta, cnt_4c_Item, cnt_4c_Financ,
*   cnt_4c__Credito, cnt_4c__Pendencia, cnt_4c__Identifica, cnt_4c__Fpagto,
*   cnt_4c_CancelaItem, cnt_4c_CaixaLivre, cnt_4c__Mensagem, cnt_4c_Mensagems,
*   cnt_4c_Barra_Botoes.
* ConfigurarPageFrame existe como ORQUESTRADOR de layout base (convencao dos
* forms OPERACIONAIS flat - FormVca.prg / FormSigMvExp.prg) e NAO cria
* PageFrame nenhum: o SCX legado nao tem PageFrame (zero ocorrencias em
* tasks\task571\layout.json e nas 583 KB do dump). O papel que o PageFrame
* cumpre nos forms CRUD (alternar Lista/Dados) e cumprido aqui pela
* alternancia de .Visible dos containers de operacao.
*
* FASE 4/8: GRADES + BOTOES DE ACAO DAS GRADES + CARGA DE DADOS. Este form
* NAO tem Page1=Lista/Page2=Dados nem os 6 botoes CRUD canonicos (Incluir/
* Visualizar/Alterar/Excluir/Buscar/Encerrar) - o legado SIGMVITN.SCX e uma
* tela de Caixa (frente de venda), nao um cadastro, e nao tem grid de
* LISTAGEM de registros para o usuario selecionar/incluir/alterar/excluir
* (ver CLAUDE.md "Form Types" - OPERACIONAL usa layout CUSTOM). Inventar
* esses 6 botoes ou uma pagina de Lista violaria o PILAR 1 e a regra "NUNCA
* inventar funcionalidade que o legado nao tem". O que esta fase adiciona,
* fiel ao dump (layout.json / mapeamento.json / slim.txt / linhas 7427-7518
* e 16528-16532 do fonte legado):
*
*   AS CINCO GRADES do legado e o seu bind:
*     grd_4c_Cupom      (GrdCupom, filha direta do form)      -> crTpmMvItnC
*     grd_4c_Barras     (CntFinanc.Cnt_GrdBarra.grade)        -> TmpBarFin
*     grd_4c_Devolucao  (Cnt_Credito.GradeDevol)              -> TmpDevol
*     grd_4c_SubNiveis  (Cnt_Pendencia.GradeMultiSubN)        -> TmpOperacao
*     grd_4c_Parcelas   (Cnt_Fpagto.Cnt_ChequepreTef.Grade)   -> xPar
*   Junto vao os dois containers que hospedam duas delas (cnt_4c__GrdBarra e
*   cnt_4c__ChequepreTef) e os QUATRO botoes de acao que o legado cola nas
*   grades: cmd_4c_Inserir (F2-Selec), cmd_4c_Excluir (F4-Excluir),
*   cmd_4c_OkBarra (F5-Barra) e cmd_4c_BotPend ([F3]Pend., pendencias do cliente).
*
*   OS CURSORES (CriarCursoresGrades): no legado os cinco ja existiam, criados
*   pela tela de movimentacao na datasession COMPARTILHADA - o SCX so fazia
*   "Set DataSession To pnDatSes" e os enxergava prontos. Como o form migrado
*   usa DataSession = 2 (isolado, como o proprio SCX declara), eles nascem
*   aqui, com a estrutura transcrita do uso real no dump.
*
*   A CARGA (CarregarDados / MontarLinhasCupom / AtualizarGrades): traz do
*   banco, pelo BO, os itens ja lancados da movimentacao corrente, remonta as
*   linhas de texto do cupom com a formatacao do AtuaCupom legado e repinta as
*   cinco grades.
*
* Os 17 CommandButtons da barra principal (cnt_4c_Barra_Botoes) foram criados
* na Fase 3. TextBoxes/ComboBox de dados (Fases 5-6) e eventos/handlers de
* Click/KeyPress (Fases 7-8) ficam para as proximas fases - NAO incluidos aqui.
*
* FASE 5/8: CAMPOS DE DADOS - PRIMEIRA METADE. Preenche o interior dos
* containers estruturais criados na Fase 3 com os TextBoxes/Labels/Containers
* filhos que o legado tem (layout.json/mapeamento.json/slim.txt), na ordem em
* que sao usados durante uma venda: o logotipo e as faixas de mensagem do
* rodape, o painel "CAIXA LIVRE", o painel de cancelamento de item
* (CancelaItem), o painel de consulta de preco (Cnt_Consulta) e o container
* principal de lancamento de itens (CntItem - Cnt_Produto/Cnt_Subtotal/
* Cnt_Desconto) e o painel de crediario (CntFinanc). A segunda metade
* (Cnt_Identifica, Cnt_Fpagto, os labels remanescentes de Cnt_Credito/
* Cnt_Pendencia e cmbTOpers) fica para a Fase 6. Nenhum ControlSource e usado
* nestes campos (o legado liga varios deles a TprMvCab, cursor do form PAI que
* fica fora de alcance com DataSession=2 isolado - mesma decisao das Fases
* 1-4); a leitura/gravacao de valor entra junto com os eventos nas Fases 7-8.
* Colisoes de nome do mapeamento.json (dois "SayN"/"LabelN" iguais dentro do
* MESMO container, gerados sem desambiguacao) sao resolvidas caso a caso nos
* comentarios de cada metodo abaixo - nunca com dois AddObject do mesmo nome
* no mesmo pai (CLAUDE.md #11/#28).
*
* Decisao de arquitetura (PILAR 3): o legado usa um objeto "PoDataMgr" (Data
* Manager) e um "PoCalculator" (calculadora popup) compartilhados via
* ParentForm. A nova arquitetura NAO replica esse padrao - o BO (sigmvitnBO)
* acessa o SQL Server diretamente via SQLEXEC(gnConnHandle, ...), entao as
* propriedades "podatamgr"/"pocalculator" do legado foram OMITIDAS de proposito
* (nao sao "Property nao encontrada" por acidente - sao substituidas por
* chamadas diretas ao BO nas fases de evento).
*
* FASE 6/8: CAMPOS DE DADOS - SEGUNDA METADE + TODOS OS LOOKUPS. Completa
* Cnt_Identifica (Destino/Responsavel/Vendedor/Origem - Grupo+Conta+Nome+Cpf,
* TabDesconto, CodOperacao) e Cnt_Fpagto (Acrescimo/Desconto,
* Cnt_ChequepreTef.Cnt_Chq, campos soltos), os labels remanescentes de
* Cnt_Credito/Cnt_Pendencia (botao "Proximo" + instrucao [ENTER]) e o
* cmbTOpers. Diferente da Fase 5, aqui HA logica de evento: os lookups
* originais (fAcessoContab/fAcessoContas/fwBuscaExt/fwBuscaSel) sao
* PROIBIDOS de reproduzir direto (auto-preenchem com o primeiro match
* parcial sem selecao explicita do usuario - CLAUDE.md "fAcessoContas()
* PROIBIDO lookup UX" / "fAcessoEmpresa() NAO EXISTE"). Substituidos pelo
* padrao canonico FormBuscaAuxiliar (CLAUDE.md #36/#37), acionado em
* ENTER/TAB/F4 via BINDEVENT "KeyPress" (Valid nao dispara de forma
* confiavel em TextBox - CLAUDE.md #84):
*   Grupo            -> SigCdGcr (codigos/descrs)
*   Conta/Nome/Cpf   -> SigCdCli (iclis/rclis/cpfs/grupos - NAO grclis),
*                       filtrada pelo Grupo quando ja preenchido
*   Tab. Desconto    -> SigOpTdz (codigos/descrs)
*   Lista de Preco   -> SigCdLpc (lprecos/tipos)
*   Forma Pagamento  -> SigOpFp (fpags/descrs/fparcs)
* Os quatro blocos de conta (Destino/Responsavel/Vendedor/Origem) reusam os
* MESMOS dois metodos protegidos (AbrirLookupGrupo/AbrirLookupConta) - cada
* bloco so tem handlers PUBLIC de KeyPress proprios (BINDEVENT exige metodo
* PUBLIC - CLAUDE.md #3) que resolvem o container correto e delegam.
*
* FASE 7/8: EVENTOS PRINCIPAIS. Liga (RegistrarEventosPrincipais, chamado do
* InicializarForm) o Click dos 17 CommandButtons da barra principal, dos 4
* botoes de acao das grades, dos paineis CancelaItem/Consulta e das 5 setas
* "Proximo". Corrige tambem um bug critico deixado pela Fase 4: os seis
* containers de operacao (CntItem/CntFinanc/Cnt_Credito/Cnt_Pendencia/
* Cnt_Identifica/Cnt_Fpagto) nasciam TODOS Visible=.T. empilhados na mesma
* area (Top=124 Left=32) - o novo AlternarTelaOperacao(par_cTela) garante que
* so um fica visivel por vez, como no legado (cada Click de navegacao zera a
* visibilidade dos irmaos antes de mostrar o proprio), e o InicializarForm
* passa a fixar "ITENS" como tela inicial.
* Limite de escopo (heranca das Fases 1-6): DataSession=2 isola este form dos
* cursores globais do form de movimentacao pai (crSigCdOpe, CrSigOpCdc,
* TprMvCab) e das rotinas dele (AcioSalva, AcioCancela, Cancel_Item_Gen,
* AtuaTotal, VerStatus, AciomudaOpe). Guardas do legado que dependem so de
* CURSORES/PROPRIEDADES LOCAIS (crTpmMvItn, TmpOperacao, TmpDevol, TmpBarFin,
* xPar, this_*) sao transcritos fielmente (Barra_Botoes.Acrescimo/apaga/
* MudaOpe/ok/credito/pendencia/Financia); os que dependem de hardware fiscal/
* TEF ou senha de supervisor (impressora ECF, SigOpSen, SigOpPen, SIGMEFIS)
* nao tem como ser reproduzidos sem esse modulo/hardware - documentados caso
* a caso em cada metodo, nunca silenciados. Ok/Confirmar valida os dados
* locais (itens lancados, forma de pagamento informada) e devolve o controle
* ao form pai via THIS.Release() - a finalizacao fiscal (emissao do cupom)
* e responsabilidade dele.
*
* FASE 8/8: EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Fecha os fluxos que a
* Fase 7 deixou parcialmente ligados e os que dependem de controles criados
* so na Fase 6:
*   - Cancelamento de item (CancelaItem): LimparCntItem/ExcluirItemCorrente
*     dao corpo a CancelaItemOkClick/CancelaItemCancelaDispClick (Fase 7),
*     reproduzindo o Cancel_Item_Gen local (remove de crTpmMvItn, refaz
*     RecalcularTotalCarrinho, refecha o painel).
*   - Confirmacao manual de item com preco alterado (CmdEnviaProdClick),
*     ligado ao unico CommandButton que o legado mantem oculto por padrao
*     (Cnt_Produto.CmdEnviaProd, When = lAlteraPreco).
*   - Atalho "Cadastro de Contas" dos blocos Origem/Destino
*     (AbrirCadastroConta + BtnCadastrosDestinoClick/BtnCadastrosOrigemClick)
*     e a seta Proximo de Identifica (IdentificaProximoClick), que so avanca
*     para Pagamento com o mesmo guard HaPagamentoPend() do legado.
*   - Conferencia do cheque pre-datado (Cnt_ChequepreTef.Cnt_Chq):
*     LimparChequePreTef, ValidarChequesLancados (SCAN de conferencia dos
*     numeros lancados em xPar), CmdTefChqClick (rodape do legado - cheque
*     invalido limpa e devolve o foco; cheque valido e forma batida reabilita
*     Confirmar/Cancelar e dispara o Confirmar) e CmdInsChequeClick (Ins -
*     replica banco/agencia/conta/CPF/praca da linha corrente para as
*     seguintes, incrementando o numero do cheque). A consulta ao gerenciador
*     TEF em si (SigFiTefReq/VerifGP) e o acionamento da impressora de cheque
*     (PertoHabilita/ChronoHabilita) ficam fora de alcance (driver de
*     hardware) - CmdTefChqClick avisa isso explicitamente ao usuario em vez
*     de aprovar calado (CLAUDE.md #27).
*
*   Consolidacao verificada nesta fase (sem alterar logica ja escrita nas
*   Fases 1-7): contagem balanceada de PROCEDURE/FUNCTION (104) contra
*   ENDPROC/ENDFUNC (102+2), IF/ENDIF (179/179), WITH/ENDWITH (239/239),
*   TRY/ENDTRY (8/8), FOR/ENDFOR (3/3) e DO WHILE/ENDDO (1/1); todo
*   THIS.this_oBusinessObject.<metodo> chamado pelo form (CarregarItensMovi-
*   mento, CarregarParametrosOperacao) existe em sigmvitnBO.prg; todo handler
*   de KeyPress/Click declarado tem o BINDEVENT correspondente (64 ao todo,
*   parte em RegistrarEventosPrincipais, parte nos proprios Configurar-
*   Campos* que criam o controle); nenhum TODO/FIXME/stub/"sera implementado"
*   restou no arquivo.
*
*   CONSOLIDACAO CANONICA desta fase - o que foi entregue e por que:
*
*   - FormParaBO / BOParaForm: transferencia real entre o carrinho
*     (crTpmMvItn) e as propriedades do sigmvitnBO. NAO existiam no legado
*     porque la o cursor pertencia a tela de movimentacao PAI e vivia na
*     datasession COMPARTILHADA ("Set DataSession To pnDatSes"), e era o pai
*     quem gravava tudo no fim (AcioSalva -> TableUpdate). Com DataSession = 2
*     (isolado, como o SCX declara) o pai NAO ve este cursor, entao a
*     transferencia e a gravacao passam a ser deste form. Mapeiam SO as
*     colunas que a tela possui; as ~100 propriedades fiscais/de rateio do BO
*     ficam com o default da Fase 2 - preenche-las aqui seria inventar valor
*     de imposto e gravar numero errado em silencio (CLAUDE.md #27).
*   - GravarItensLancados: grava item a item via BO (NovoRegistro +
*     FormParaBO + Salvar), aborta no primeiro erro e devolve .F. - nao
*     existe "gravou metade da venda". Chamado por BtnConfirmarClick ANTES de
*     anunciar sucesso: sem isto o Confirmar dizia "venda validada" e fechava
*     a tela sem ter escrito nada em SigMvItn (CLAUDE.md #189).
*   - BtnConfirmarClick / BtnCancelarClick: sao os DOIS botoes que o legado
*     realmente tem na barra (Barra_Botoes.ok Caption "Confirmar" e
*     Barra_Botoes.Cancela Caption "Cancelar", Cancel = .T.) - renomeados dos
*     provisorios CmdOkClick/CmdCancelaClick para o nome canonico do projeto
*     (PILAR 3). Nenhum botao foi inventado.
*   - CarregarLista: ponto de entrada canonico de recarga. Este form nao tem
*     pagina de LISTA de registros; o que ele lista e o CUPOM da venda
*     corrente (grd_4c_Cupom), e e isso que o metodo recarrega e repinta.
*   - HabilitarCampos / LimparCampos / AjustarBotoesPorModo: transcricao das
*     clausulas When do SCX (Get_*.When e Barra_Botoes.*.When), que sao o
*     mecanismo do legado para gate de campo e de botao. Nao ha como delegar
*     um When por BINDEVENT (o retorno e descartado - CLAUDE.md #3), por isso
*     viraram gate unico. AjustarBotoesPorModo e chamado no fim de
*     AlternarTelaOperacao, o FUNIL por onde toda troca de tela passa
*     (CLAUDE.md #40).
*   - BtnBuscarClick / BtnEncerrarClick continuam NAO existindo: o legado nao
*     tem botao de busca de registro nem de "Encerrar" nesta tela (a saida e o
*     Cancelar, Cancel = .T.). Cria-los seria inventar botao que o legado nao
*     tem (PILAR 1). A consulta de preco, que e o que ha de "busca" aqui, ja
*     esta em CmdVerPrecoClick (Ctrl+P, Barra_Botoes.VerPreco).
*
*   Por ser form filho (aberto via CREATEOBJECT("Formsigmvitn", oParentForm,
*   nDataSes) pelo form de movimentacao, nunca pelo usuario direto), NAO ha
*   nem deve haver entrada em menu.prg/popMovimentos - end-to-end o form so e
*   alcancavel a partir da tela de movimentacao que o instancia.
*==============================================================================

DEFINE CLASS Formsigmvitn AS FormBase

    *-- Propriedades nativas do Form (copiadas do dump legado - CLAUDE.md #33)
    Width        = 1300
    Height       = 1400
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    BorderStyle  = 0
    ClipControls = .F.
    KeyPreview   = .T.
    ShowTips     = .T.
    Caption      = "Caixa"
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Propriedades de integracao com o form pai (padrao FormDCC.prg)
    *--------------------------------------------------------------------------
    this_oParentForm = .NULL.   && ref. ao form de movimentacao que abriu este
    this_nDataSes     = 0        && DataSessionId do pai (so referencia/compat -
                                  && este form usa DataSession=2 isolado, NAO
                                  && "Set DataSession To" como o legado fazia)

    *--------------------------------------------------------------------------
    * Contexto da movimentacao que esta sendo operada no Caixa (Empresa +
    * Operacao + Numero do documento). No legado esses tres valores eram lidos
    * direto de TprMvCab, o cursor de cabecalho que a tela de movimentacao
    * mantinha na datasession COMPARTILHADA. Com DataSession = 2 o cursor do
    * pai nao e visivel aqui, entao o contexto e recebido do form pai no Init
    * e guardado nestas tres propriedades - sao elas que o BO usa para trazer
    * os itens ja lancados (CarregarDados).
    *--------------------------------------------------------------------------
    this_cEmps  = ""   && empresa    (SigMvItn.emps  / TprMvCab.Emps)
    this_cDopes = ""   && operacao   (SigMvItn.dopes / TprMvCab.Dopes)
    this_nNumes = 0    && documento  (SigMvItn.numes / TprMvCab.Numes) - zero
                       && enquanto a venda nao tiver numero gerado

    *--------------------------------------------------------------------------
    * Propriedades de estado herdadas 1:1 do legado (RESERVED3/ClassInfo do
    * SCX). Nomes ORIGINAIS preservados (so com o prefixo this_<tipo>), para
    * que os metodos/eventos transcritos nas Fases 4-8 referenciem exatamente
    * estas properties sem duvida de mapeamento. Tipo inferido pelo uso real
    * no codigo fonte (comportamento.json) quando disponivel; nos demais,
    * melhor palpite pela convencao Hungarian do legado (lc=char, ln=numeric,
    * ll=logical) - o valor inicial e so o default, VFP nao trava o tipo depois.
    *--------------------------------------------------------------------------
    this_lAltpartef        = .F.  && altpartef
    this_lAltvalor         = .F.  && altvalor
    this_cAntcp            = ""   && antcp
    this_cAntCPro          = ""   && antcpro  (confirmado: Thisform.AntCPro = crTpmMvItn.Cpros)
    this_nAntQtd           = 0    && antqtd   (confirmado: Thisform.AntQtd = This.Value)
    this_nAntvalor         = 0    && antvalor
    this_nAntvalu          = 0    && antvalu  (confirmado: Thisform.AntValu = crTpmMvItn.Units)
    this_nAntvalue         = 0    && antvalue (confirmado: This.Value # ThisForm.AntValue)
    this_lAplicoutabd      = .F.  && aplicoutabd
    this_nBcds             = 0    && bcds     (confirmado: ThisForm.Bcds = 0)
    this_lBuscaproduto     = .F.  && buscaproduto
    this_lCancelouitem     = .F.  && cancelouitem
    this_lCheckstat        = .F.  && checkstat
    this_nCitem            = 0    && citem    (confirmado: ThisForm.Citem contador de item)
    this_cCmc7             = ""   && cmc7     (confirmado: ThisForm.cmc7='')
    this_lConsultaexecutada = .F. && consultaexecutada (confirmado: ThisForm.Consultaexecutada = .f.)
    this_nCotusu           = 0    && cotusu
    this_cCpfcheque        = ""   && cpfcheque
    this_cCpro             = ""   && cpro
    this_lDigpar           = .F.  && digpar   (confirmado: ThisForm.DigPar = .f.)
    this_lEditadestino     = .F.  && editadestino (confirmado: uso booleano em Get_conta.When)
    this_lEditajob         = .F.  && editajob
    this_lEditaorigem      = .F.  && editaorigem  (confirmado: uso booleano em Get_conta.When)
    this_nFatredutor       = 0    && fatredutor
    this_lGerouncupom      = .F.  && gerouncupom
    this_lInichq           = .F.  && inichq
    this_lInicia           = .F.  && inicia   (confirmado: .Inicia = .f. no With de Init)
    this_nItsembonus       = 0    && itsembonus
    this_lLaltcontrole     = .F.  && laltcontrole
    this_lLalterapreco     = .F.  && lalterapreco (confirmado: ThisForm.lAlteraPreco)
    this_lLalteraqtd       = .F.  && lalteraqtd   (confirmado: ThisForm.lalteraqtd = .t.)
    this_lLalteravalor     = .F.  && lalteravalor (confirmado: ThisForm.lAlteraValor = .t.)
    this_lLancaacrescimo   = .F.  && lancaacrescimo
    this_cLcfoco           = ""   && lcfoco
    this_lLcontrole        = .F.  && lcontrole
    this_lLeitor           = .F.  && leitor    (confirmado: Thisform.Leitor = .F.)
    this_lLeituranova      = .F.  && leituranova (confirmado: ThisForm.Leituranova = .t.)
    this_cLeituraserial    = ""   && leituraserial (confirmado: ThisForm.LeituraSerial=...)
    this_lLibacumula       = .F.  && libacumula
    this_lLiberaident      = .F.  && liberaident (confirmado: uso booleano ThisForm.LiberaIdent)
    this_lLiberapca        = .F.  && liberapca   (confirmado: Not ThisForm.LiberaPca)
    this_lLibtroco         = .F.  && libtroco
    this_lLlacrescimo      = .F.  && llacrescimo
    this_lLldatagetvenc    = .F.  && lldataget_venc
    this_lLldesconto       = .F.  && lldesconto
    this_lLlgetfpg         = .F.  && llget_fpg
    this_lLlgetnpar        = .F.  && llget_npar
    this_lLlgetvpar        = .F.  && llget_vpar
    this_lLlreadcomm       = .F.  && llreadcomm
    this_nNantvalor        = 0    && nantvalor (confirmado: Thisform.nAntValor = This.Value)
    this_nNcontrole        = 0    && ncontrole (confirmado: .nControle = 0 no With de Init)
    this_cNewchv           = ""   && newchv
    this_lNoklostche       = .F.  && noklostche
    this_nOldcodigo        = 0    && oldcodigo (confirmado: .OldCodigo = 0 no With de Init)
    this_cOpEscolha        = ""   && op_escolha (confirmado: .Op_Escolha = pForm.pcEscolha)
    this_nParcdesconto     = 0    && parcdesconto (confirmado: ThisForm.parcDesconto = 0)
    this_lPcbandeira       = .F.  && pcbandeira
    this_cPcidcheque       = ""   && pcidcheque (confirmado: Thisform.pcidcheque)
    this_cPcnident         = ""   && pcnident   (confirmado: Thisform.pcnIdent = '')
    this_lPcrede           = .F.  && pcrede
    this_nPeantvalue       = 0    && peantvalue (confirmado numerico em uso na grade GradeDevol)
    this_lPreencheu        = .F.  && preencheu  (confirmado: ThisForm.Preencheu = .f.)
    this_lPrimeira         = .F.  && primeira
    this_cProduto          = ""   && produto
    this_nQtdvalid         = 0    && qtdvalid   (confirmado: ThisForm.Qtdvalid > 0 / = 1)
    this_cRetchpsa         = ""   && retchpsa
    this_lSenhaautoins     = .F.  && senhaautoins (confirmado: ThisForm.Senhaautoins = .t.)
    this_lSubtotac         = .F.  && subtotac   (confirmado: ThisForm.Subtotac = .t./.f.)
    this_lTef              = .F.  && tef
    this_lTemacrescimo     = .F.  && temacrescimo
    this_lTempartef        = .F.  && tempartef  (confirmado: Not ThisForm.Tempartef)
    this_cTipocons         = ""   && tipocons
    this_cTipoleitora      = ""   && tipoleitora (confirmado: Thisform.TipoLeitora = 'S')
    this_nTotal            = 0    && total
    this_nTotalgeral       = 0    && totalgeral
    this_nTotchamada       = 0    && totchamada (confirmado: ThisForm.TotChamada = 0)
    this_nTotpartef        = 0    && totpartef
    this_nUltimocancel     = 0    && ultimocancel (confirmado: ThisForm.UltimoCancel comparado com numerico)
    this_cUsulibs          = ""   && usulibs    (confirmado: ThisForm.UsuLibs = ' ')
    this_lValidadesconto   = .F.  && validadesconto (confirmado: ThisForm.Validadesconto = .t.)
    this_lValidado         = .F.  && validado   (confirmado: ThisForm.validado = .t.)
    this_lValidapend       = .F.  && validapend
    this_lValidok          = .F.  && validok

    *--------------------------------------------------------------------------
    * Init - recebe o form pai (que fica desabilitado enquanto o Caixa esta
    * aberto) e o DataSessionId dele (so guardado por compatibilidade - este
    * form usa DataSession=2 isolado).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_nDataSes

        *-- BackColor = RGB(255,255,255) do dump legado (fundo branco). Nao pode
        *-- ser default de PEM na DEFINE CLASS (VFP9 so aceita literal simples
        *-- na declaracao) - setado aqui em runtime.
        THIS.BackColor = RGB(255, 255, 255)

        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            THIS.this_nDataSes = IIF(VARTYPE(par_nDataSes) = "N", par_nDataSes, 0)

            *-- Contexto da movimentacao. O legado lia TprMvCab (cursor do pai,
            *-- na datasession compartilhada); aqui o pai publica os mesmos tres
            *-- valores em propriedades, e o Caixa as copia. PEMSTATUS antes de
            *-- cada leitura porque o Caixa tambem e aberto por telas que ainda
            *-- nao expoem esse contexto - nesse caso a empresa cai no padrao do
            *-- sistema e a venda comeca sem numero (this_nNumes = 0), que e o
            *-- estado "caixa livre" do legado.
            THIS.this_cEmps = go_4c_Sistema.cCodEmpresa

            IF VARTYPE(THIS.this_oParentForm) = "O"
                IF PEMSTATUS(THIS.this_oParentForm, "this_cEmps", 5)
                    IF !EMPTY(THIS.this_oParentForm.this_cEmps)
                        THIS.this_cEmps = THIS.this_oParentForm.this_cEmps
                    ENDIF
                ENDIF

                IF PEMSTATUS(THIS.this_oParentForm, "this_cDopes", 5)
                    THIS.this_cDopes = THIS.this_oParentForm.this_cDopes
                ENDIF

                IF PEMSTATUS(THIS.this_oParentForm, "this_nNumes", 5)
                    THIS.this_nNumes = THIS.this_oParentForm.this_nNumes
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e a estrutura visual base.
    * Grid/botoes CRUD, campos e eventos entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- DataSession = 2 (privada) nasce com os SET no DEFAULT do VFP9,
            *-- nao com os do config.prg - mesma armadilha que o FormBase ja
            *-- trata para SET DATE/CENTURY (CLAUDE.md #9.4). Medido no VFP9 em
            *-- 2026-09-24: config.prg faz "SET DELETED ON", mas dentro desta
            *-- datasession SET("DELETED") volta OFF, e ai linha DELETADA fica
            *-- VISIVEL. Consequencia real: o item que o caixa CANCELOU
            *-- (ExcluirItemCorrente faz DELETE logico, sem PACK) continuaria
            *-- sendo contado no total e GRAVADO em SigMvItn pelo Confirmar -
            *-- o cliente pagaria por item cancelado. Normalizado aqui, no
            *-- inicio do Init, para valer em TODA operacao de cursor deste
            *-- form (COUNT/SUM/SKIP/SCAN e as cinco grades).
            SET DELETED ON

            THIS.this_oBusinessObject = CREATEOBJECT("sigmvitnBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Os cursores das grades nascem ANTES dos controles: assim o
                *-- MontaGrade, logo abaixo, encontra os alias prontos. Ligar
                *-- Column.ControlSource a cursor inexistente estoura dentro
                *-- deste TRY e o form nao chega a abrir (CLAUDE.md #41).
                THIS.CriarCursoresGrades()

                THIS.ConfigurarPageFrame()

                *-- Bind das cinco grades (RecordSource/ControlSource/Width/
                *-- cabecalhos). Separado da criacao dos controles porque
                *-- RecordSource reseta Width, Header1.Caption, CurrentControl
                *-- e Sparse - tudo isso precisa vir DEPOIS dele.
                THIS.MontaGrade()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga inicial: traz do banco os itens ja lancados desta
                *-- movimentacao, remonta as linhas do cupom e repinta as
                *-- grades. Nao aborta a abertura se falhar - a tela do Caixa
                *-- continua utilizavel para lancar item novo.
                THIS.CarregarDados()

                *-- FASE 7/8: eventos principais. Liga os Click/KeyPress dos
                *-- 17 botoes da barra principal, dos botoes de acao das
                *-- grades, dos paineis CancelaItem/Consulta e das setas
                *-- "Proximo" de cada tela - e define ITENS como tela inicial
                *-- (sem isto, os seis containers de operacao ficam TODOS
                *-- Visible=.T. ao mesmo tempo, empilhados na mesma area).
                THIS.RegistrarEventosPrincipais()
                THIS.AlternarTelaOperacao("ITENS")

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar sigmvitnBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestrador do layout base.
    *
    * O SIGMVITN.SCX legado e FLAT: nao ha UMA ocorrencia de PageFrame nem no
    * layout.json nem nas 583 KB do dump do fonte. Criar um PageFrame
    * Lista/Dados aqui inventaria um controle que o legado nao tem (viola o
    * PILAR 1) e ainda cobriria os containers de operacao. Seguindo a convencao
    * ja adotada nos forms OPERACIONAIS flat do projeto (FormVca.prg, migrado
    * de SIGALTDT, e FormSigMvExp.prg, de SIGMVEXP), o metodo mantem o nome
    * canonico de orquestrador de layout base e delega para os metodos que
    * montam os controles que o legado REALMENTE tem.
    *
    * A ORDEM abaixo e a ordem de empilhamento (ZOrder implicito do AddObject:
    * o ultimo desenha por cima). Cabecalho e logotipo primeiro, depois os
    * containers de operacao, e por fim a barra de botoes - que no legado fica
    * SOBRE a area central (Top=20..99 contra containers em Top=124) e por isso
    * precisa ser criada DEPOIS deles.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarElementosAuxiliares()
        THIS.ConfigurarGridCupom()
        THIS.ConfigurarContainersOperacao()
        THIS.ConfigurarGradesOperacao()
        THIS.ConfigurarContainersMensagem()
        THIS.ConfigurarBarraBotoes()

        *-- FASE 5/8: primeira metade dos campos de dados (ver cabecalho do
        *-- arquivo). Chamado por ultimo porque preenche o INTERIOR dos
        *-- containers ja criados acima - a ordem entre os proprios containers
        *-- de topo nao muda.
        THIS.ConfigurarCamposParte1()

        *-- FASE 6/8: segunda metade dos campos de dados - Cnt_Identifica
        *-- (COMPLETO, com todos os lookups de Grupo/Conta/Cpf), Cnt_Fpagto
        *-- (COMPLETO, incluindo Cnt_ChequepreTef.Cnt_Chq), os labels
        *-- remanescentes de Cnt_Credito/Cnt_Pendencia e cmbTOpers.
        THIS.ConfigurarCamposParte2()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - barra de titulo flat no topo (equivalente ao
    * TxtCaption legado). Este form NAO usa o padrao cnt_4c_Cabecalho com
    * lbl_4c_Sombra+lbl_4c_Titulo dos forms CRUD (frmcadastro): o legado nao
    * tem PageFrame nem faixa decorativa dupla, so um label direto no form.
    * Original: TxtCaption Top=0 Left=-1 Width=1300 Height=19 BackColor=90,90,90
    * ForeColor=255,255,255 FontName="Tahoma" FontBold=.T. Caption="  Caixa".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("lbl_4c_TxtCaption", "Label")
        WITH THIS.lbl_4c_TxtCaption
            .Top       = 0
            .Left      = -1
            .Width     = THIS.Width
            .Height    = 19
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 1
            .BackColor = RGB(90, 90, 90)
            .ForeColor = RGB(255, 255, 255)
            .Caption   = "  " + THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridCupom - grade READONLY que lista os itens do cupom em
    * andamento (GrdCupom no legado). Coluna unica, sem cabecalho (o legado
    * usa HeaderHeight=0 - cada linha e uma string formatada, no padrao de
    * cupom fiscal), fonte Verdana azul (ForeColor=RGB(0,0,255) no dump).
    * RecordSource/ControlSource NAO sao setados aqui de proposito - o cursor
    * do carrinho (cursor_4c_Cupom ou equivalente) so existe a partir da fase
    * de eventos/CarregarCupom; setar ControlSource contra cursor inexistente
    * derruba o Init (CLAUDE.md #41). Fica atras de cnt_4c_CaixaLivre no
    * z-order (criado ANTES dele), exatamente como no legado: o painel "CAIXA
    * LIVRE" cobre a grade quando nao ha operacao em andamento.
    * Original: GrdCupom Top=127 Left=407 Width=340 Height=312 ColumnCount=1
    * Enabled=.F. GridLines=0 HeaderHeight=0 ReadOnly=.T. RecordMark=.F.
    * ScrollBars=0. Column1: FontName="Verdana" Width=345 Movable=.F.
    * ReadOnly=.T. ForeColor=0,0,255. Header1.Caption="Header1" (legado nao
    * troca - HeaderHeight=0 o esconde).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridCupom()
        THIS.AddObject("grd_4c_Cupom", "Grid")
        WITH THIS.grd_4c_Cupom
            .Top           = 127
            .Left          = 407
            .Width         = 340
            .Height        = 312
            .ColumnCount   = 1
            .Enabled       = .F.
            .GridLines     = 0
            .HeaderHeight  = 0
            .ReadOnly      = .T.
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .ScrollBars    = 0
            .Visible       = .T.

            .Column1.FontBold  = .F.
            .Column1.FontName  = "Verdana"
            .Column1.Enabled   = .F.
            .Column1.Width     = 345
            .Column1.Movable   = .F.
            .Column1.ReadOnly  = .T.
            .Column1.ForeColor = RGB(0, 0, 255)
            .Column1.Header1.FontSize = 8
            .Column1.Header1.Caption  = "Header1"
            .Column1.Text1.FontBold   = .F.
            .Column1.Text1.FontName   = "Verdana"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Enabled    = .F.
            .Column1.Text1.Margin     = 0
            .Column1.Text1.ReadOnly   = .T.
            .Column1.Text1.ForeColor  = RGB(0, 0, 255)
            .Column1.Text1.BackColor  = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBarraBotoes - container da barra de botoes principal e os 17
    * CommandButtons que o legado tem dentro dele. Varios pares de botoes
    * OCUPAM O MESMO Left (Alteraqtd/Desconto/Acrescimo em Left=77,
    * CancPagto/apaga em Left=152, impfiscal/VerPreco em Left=527,
    * MudaOpe/Pagto em Left=602) porque a barra alterna qual conjunto fica
    * visivel conforme a tela ativa (Itens x Pagamento x Financiamento) - a
    * alternancia de .Visible entra nas Fases 7-8, junto com os Click. Aqui
    * cada botao nasce com o .Visible EXATO do dump (a maioria .T.; Financia
    * e .F. porque essa opcao esta desligada por padrao no legado).
    * Propriedades comuns a TODOS (do dump): Top=1 Width=75 Height=75
    * FontBold=.T. FontItalic=.T. FontName="Comic Sans MS" FontSize=8
    * ForeColor=90,90,90 BackColor=255,255,255 DisabledForeColor=109,109,109
    * DisabledBackColor=240,240,240 Themes=.F.
    * Original: Barra_Botoes Top=20 Left=470 Width=831 Height=79 BackStyle=0
    * BorderWidth=0 SpecialEffect=0 TabIndex=8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBarraBotoes()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cnt_4c_Barra_Botoes", "Container")
        WITH THIS.cnt_4c_Barra_Botoes
            .Top           = 20
            .Left          = 470
            .Width         = 831
            .Height        = 79
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .TabIndex      = 8
            .Visible       = .T.
        ENDWITH

            *-- [F2] Itens - tela padrao de lancamento de itens.
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Itens", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens
                .Top             = 1
                .Left            = 2
                .Width           = 75
                .Height          = 75
                .AutoSize        = .F.
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = loc_cIcones + "geral_palete_60.jpg"
                .Caption         = "[F2]Itens"
                .MousePointer    = 15
                .TabIndex        = 1
                .ToolTipText     = "[F2] Tela de Itens"
                .SpecialEffect   = 0
                .PicturePosition = 13
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F3] Alteraqtd - alterar quantidade do item corrente.
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Alteraqtd", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Alteraqtd
                .Top             = 1
                .Left            = 77
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
                .Caption         = "[F3]Qtde"
                .TabIndex        = 2
                .ToolTipText     = "[F3] Quantidades"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F3] Desconto - desconto do item corrente (mesmo Left do
            *-- Alteraqtd - so um dos dois fica visivel por vez).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Desconto", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Desconto
                .Top             = 1
                .Left            = 77
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
                .Caption         = "[F3]Descon."
                .TabIndex        = 3
                .ToolTipText     = "[F3] Descontos"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [Ctrl+F3] Acrescimo - acrescimo do item corrente (mesmo Left
            *-- do par Alteraqtd/Desconto).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Acrescimo", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Acrescimo
                .Top             = 1
                .Left            = 77
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "geral_datas_60.jpg"
                .Caption         = "[Ctrl+F3] +"
                .TabIndex        = 3
                .ToolTipText     = "[Ctrl + F3] Acr" + CHR(233) + "scimos"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F4] CancPagto - cancelar forma de pagamento lancada.
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_CancPagto", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_CancPagto
                .Top             = 1
                .Left            = 152
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
                .Caption         = "[F4]Canc"
                .TabIndex        = 5
                .ToolTipText     = "[F4] Cancelar Forma de Pagamento"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F4] Apaga - cancelar a operacao/venda inteira (mesmo Left do
            *-- CancPagto).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga
                .Top             = 1
                .Left            = 152
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
                .Caption         = "[F4]Canc"
                .TabIndex        = 4
                .ToolTipText     = "[F4] Cancelar Opera" + CHR(231) + CHR(227) + "o"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F5] AltPreco - alteracao de precos.
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_AltPreco", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_AltPreco
                .Top             = 1
                .Left            = 227
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = loc_cIcones + "geral_cambio_60.jpg"
                .Caption         = "[F5]Alt.$"
                .TabIndex        = 6
                .ToolTipText     = "[F5] Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F6] Identifica - identificacao de contas (Origem/Destino/
            *-- Vendedor/Responsavel).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Identifica", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Identifica
                .Top             = 1
                .Left            = 302
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "geral_contatos_60.jpg"
                .Caption         = "[F6]Identif"
                .TabIndex        = 7
                .ToolTipText     = "[F6] Identifica" + CHR(231) + CHR(227) + "o de Contas"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F7] Credito - operacoes de credito/devolucao.
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Credito", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Credito
                .Top             = 1
                .Left            = 377
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "cadastro_vizualizar_60.jpg"
                .Caption         = "[F7]Cr" + CHR(233) + "d."
                .TabIndex        = 8
                .ToolTipText     = "[F7] Cr" + CHR(233) + "ditos"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F8] Financia - crediario (desligado por padrao no legado -
            *-- Visible=.F. - mesmo Left de Pendencia).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Financia", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Financia
                .Top             = 1
                .Left            = 452
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "geral_lapis_60.jpg"
                .Caption         = "[F8]Crediario"
                .TabIndex        = 9
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .F.
            ENDWITH

            *-- [F8] Pendencia - sub-niveis/pendencias (mesmo Left do
            *-- Financia).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Pendencia", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Pendencia
                .Top             = 1
                .Left            = 452
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "geral_adicao_60.jpg"
                .Caption         = "[F8]Pend"
                .TabIndex        = 9
                .ToolTipText     = "[F8] Pend" + CHR(234) + "ncias"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- <Ctrl+P> VerPreco - abre o painel de consulta de preco
            *-- (mesmo Left do impfiscal).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_VerPreco", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_VerPreco
                .Top             = 1
                .Left            = 527
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "geral_lupa_60.jpg"
                .Caption         = "<Ctrl+P>"
                .TabIndex        = 11
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F9] impfiscal - status/comandos da impressora fiscal (mesmo
            *-- Left do VerPreco).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Impfiscal", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Impfiscal
                .Top             = 1
                .Left            = 527
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "geral_boleto_60.jpg"
                .Caption         = "[F9]Fiscal"
                .TabIndex        = 10
                .ToolTipText     = "[F9] Impressora Fiscal"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [Ctrl+F11] MudaOpe - trocar operacao (mesmo Left do Pagto).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_MudaOpe", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_MudaOpe
                .Top             = 1
                .Left            = 602
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
                .Caption         = "[Ctrl+F11]Op"
                .TabIndex        = 11
                .ToolTipText     = "[Ctrl + F11] Trocar Opera" + CHR(231) + CHR(227) + "o"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- [F11] Pagto - tela de formas de pagamento (mesmo Left do
            *-- MudaOpe - visivel por padrao no legado).
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Pagto", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Pagto
                .Top             = 1
                .Left            = 602
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .F.
                .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
                .Caption         = "[F11]Pagto"
                .TabIndex        = 11
                .ToolTipText     = "[F11] Tela de Formas de Pagamentos"
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Confirmar - confirma/finaliza a operacao corrente.
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok
                .Top             = 1
                .Left            = 677
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "cadastro_salvar_60.jpg"
                .Caption         = "Confirmar"
                .TabIndex        = 13
                .ToolTipText     = "Confirmar"
                .PicturePosition = 13
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Cancelar [ESC] - cancela a tela/passo corrente.
            THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Cancela", "CommandButton")
            WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Cancela
                .Top             = 1
                .Left            = 752
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
                .Cancel          = .T.
                .Caption         = "Cancelar"
                .TabIndex        = 12
                .ToolTipText     = "[ESC] Cancelar"
                .PicturePosition = 13
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .DisabledForeColor  = RGB(109, 109, 109)
                .DisabledBackColor  = RGB(240, 240, 240)
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersOperacao - os SETE containers "flutuantes" que se
    * alternam na area central do form (todos em Top=124 Left=32 Width=850), um
    * por etapa da operacao de caixa. No legado eles nao vivem em Pages de um
    * PageFrame (o SCX de SIGMVITN nao tem PageFrame nenhum): sao containers
    * irmaos empilhados no proprio form, e a barra de botoes alterna o .Visible
    * de cada um (Barra_Botoes.Itens -> CntItem, .Pagto -> Cnt_Fpagto,
    * .identifica -> Cnt_Identifica, .credito -> Cnt_Credito, .pendencia ->
    * Cnt_Pendencia, .Financia -> CntFinanc, .VerPreco -> Cnt_Consulta).
    *
    * O .Visible de cada um reproduz EXATAMENTE o declarado no SCX: os que o
    * legado declara Visible=.F. (Cnt_Consulta, CntFinanc) nascem ocultos e
    * estao na skip-list de TornarControlesVisiveis. A alternancia em runtime
    * (feita pelo Init e pelos Click da barra) entra nas Fases 7-8.
    *
    * Conteudo interno de cada container (labels, TextBoxes, grades) entra nas
    * Fases 4-6 - aqui so a moldura, com a geometria e o visual do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersOperacao()

        *-- Cnt_Consulta: consulta de preco de produto (Ctrl+P). Unico do
        *-- grupo com BackStyle=1 (opaco) no legado - os demais sao BackStyle=0.
        THIS.AddObject("cnt_4c__Consulta", "Container")
        WITH THIS.cnt_4c__Consulta
            .Top           = 124
            .Left          = 32
            .Width         = 850
            .Height        = 495
            .BackStyle     = 1
            .BorderWidth   = 0
            .SpecialEffect = 2
            .TabIndex      = 5
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- CntItem: lancamento de itens (F2 Itens) - container padrao ao
        *-- iniciar a venda.
        THIS.AddObject("cnt_4c_Item", "Container")
        WITH THIS.cnt_4c_Item
            .Top           = 124
            .Left          = 32
            .Width         = 850
            .Height        = 494
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .TabIndex      = 5
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- CntFinanc: crediario / codigos de barras (F8 Crediario).
        THIS.AddObject("cnt_4c_Financ", "Container")
        WITH THIS.cnt_4c_Financ
            .Top           = 124
            .Left          = 32
            .Width         = 850
            .Height        = 498
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .TabIndex      = 5
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Cnt_Credito: operacoes de credito/devolucao (F7 Cred.).
        THIS.AddObject("cnt_4c__Credito", "Container")
        WITH THIS.cnt_4c__Credito
            .Top           = 124
            .Left          = 32
            .Width         = 850
            .Height        = 494
            .BackStyle = 1
            .BorderWidth   = 0
            .SpecialEffect = 2
            .TabIndex      = 6
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_Pendencia: sub-niveis / pendencias (F8 Pend).
        THIS.AddObject("cnt_4c__Pendencia", "Container")
        WITH THIS.cnt_4c__Pendencia
            .Top           = 124
            .Left          = 32
            .Width         = 850
            .Height        = 497
            .BackStyle = 1
            .BorderWidth   = 0
            .SpecialEffect = 2
            .TabIndex      = 1
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_Identifica: identificacao de contas (F6 Identif) - Origem,
        *-- Destino, Vendedor, Responsavel, Tab. Desconto, Cod. Operacao.
        *-- Unico do grupo com SpecialEffect=0 no legado.
        THIS.AddObject("cnt_4c__Identifica", "Container")
        WITH THIS.cnt_4c__Identifica
            .Top           = 124
            .Left          = 32
            .Width         = 850
            .Height        = 496
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .TabIndex      = 4
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_Fpagto: formas de pagamento (F11 Pagto). BorderColor preto no
        *-- legado (os irmaos usam RGB(100,100,100)) - transcrito como esta.
        THIS.AddObject("cnt_4c__Fpagto", "Container")
        WITH THIS.cnt_4c__Fpagto
            .Top           = 124
            .Left          = 32
            .Width         = 850
            .Height        = 504
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .TabIndex      = 3
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- CancelaItem: painel de cancelamento de item (F4 Canc) - fica sobre
        *-- a area central, fora do grupo dos sete acima.
        THIS.AddObject("cnt_4c_CancelaItem", "Container")
        WITH THIS.cnt_4c_CancelaItem
            .Top           = 310
            .Left          = 120
            .Width         = 468
            .Height        = 141
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .F.
        ENDWITH

        *-- CaixaLivre: painel "CAIXA LIVRE" exibido quando nao ha operacao em
        *-- andamento (ocupa a area da grade do cupom).
        THIS.AddObject("cnt_4c_CaixaLivre", "Container")
        WITH THIS.cnt_4c_CaixaLivre
            .Top         = 126
            .Left        = 407
            .Width       = 475
            .Height      = 447
            .BackStyle   = 1
            .BorderWidth = 0
            .TabIndex    = 11
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersMensagem - as duas faixas de mensagem do rodape
    * (Cnt_Mensagem, de linha unica, e mensagems, de duas linhas). Os labels
    * internos que exibem o texto entram na Fase 5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersMensagem()

        *-- Cnt_Mensagem: faixa de status ("Aguarde... Reconfigurando", etc).
        THIS.AddObject("cnt_4c__Mensagem", "Container")
        WITH THIS.cnt_4c__Mensagem
            .Top           = 620
            .Left          = 31
            .Width         = 1195
            .Height        = 26
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 9
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- mensagems: faixa de duas linhas com a descricao do item corrente.
        THIS.AddObject("cnt_4c_Mensagems", "Container")
        WITH THIS.cnt_4c_Mensagems
            .Top           = 645
            .Left          = 31
            .Width         = 1195
            .Height        = 46
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 9
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarElementosAuxiliares - o container do logotipo, a imagem de
    * produto e o Timer do relogio/caption. Sao objetos de topo do legado que
    * nao pertencem a nenhum dos containers de operacao.
    *
    * NAO criados aqui, de proposito (nao e omissao silenciosa):
    *   - GrdCupom (grade do cupom)     -> Fase 4 (grades)
    *   - cmbTOpers (troca de operacao) -> Fases 5-6 (campos)
    *   - READCOMM (class "readcomm" de Framework\framework.vcx) -> e o leitor
    *     serial de cheque (CMC7). Exige SET CLASSLIB do VCX legado + o
    *     controle OLE MSComm registrado na maquina; so e usado no fluxo de
    *     leitura de cheque (Thisform.ReadComm.leitura()), que entra junto com
    *     esse fluxo nas Fases 7-8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarElementosAuxiliares()

        *-- Cnt_Img4c: moldura do logotipo no canto superior esquerdo.
        THIS.AddObject("cnt_4c__Img4c", "Container")
        WITH THIS.cnt_4c__Img4c
            .Top           = 21
            .Left          = 34
            .Width         = 291
            .Height        = 101
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .TabIndex      = 13
            .ForeColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- FigJpg: imagem do produto lido (preenchida no fluxo de item).
        *-- Legado: Stretch=1 BackStyle=1 Visible=.F.
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Top       = 124
            .Left      = 882
            .Width     = 282
            .Height    = 211
            .Stretch   = 1
            .BackStyle = 1
            .Visible   = .F.
        ENDWITH

        *-- Timer1: atualiza a barra de titulo (data/hora/operador) a cada 1s.
        *-- O corpo do evento Timer e transcrito na fase de eventos; o objeto e
        *-- estrutural e fica inerte ate la (Timer base sem codigo nao faz nada).
        THIS.AddObject("obj_4c_Timer1", "Timer")
        WITH THIS.obj_4c_Timer1
            .Top      = 547
            .Left     = 655
            .Width    = 27
            .Height   = 26
            .Interval = 1000
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradesOperacao - as QUATRO grades que vivem DENTRO dos
    * containers de operacao (a quinta, grd_4c_Cupom, e filha direta do form e
    * foi criada em ConfigurarGridCupom), mais os botoes de acao que o legado
    * coloca colados a elas:
    *
    *   cnt_4c_Financ.cnt_4c__GrdBarra        (Cnt_GrdBarra)
    *       grd_4c_Barras   (grade)            + cmd_4c_Inserir / cmd_4c_Excluir
    *                                          / cmd_4c_OkBarra
    *   cnt_4c__Credito.grd_4c_Devolucao      (GradeDevol)
    *   cnt_4c__Pendencia.grd_4c_SubNiveis    (GradeMultiSubN) + cmd_4c_BotPend
    *   cnt_4c__Fpagto.cnt_4c__ChequepreTef   (Cnt_ChequepreTef)
    *       grd_4c_Parcelas (Grade)
    *
    * Nomes DIFERENTES do generico "grd_4c_Dados" de mapeamento.json de
    * proposito: o JSON mapeia as CINCO grades do legado para o mesmo nome, e
    * duas delas acabariam como irmas homonimas na mesma arvore. Colisao de
    * nome generico no mapeamento se resolve no JSON, nao no .prg - o
    * mapeamento foi ajustado junto com esta fase.
    *
    * NENHUM RecordSource/ControlSource/Width de coluna e definido aqui: todos
    * ficam em MontaGrade(), que roda DEPOIS de CriarCursoresGrades(). Ligar
    * ControlSource a cursor que ainda nao existe derruba o Init (CLAUDE.md
    * #41), e RecordSource RECALCULA Column.Width para o default 90 e zera
    * Header1.Caption - por isso largura e cabecalho vao por ultimo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradesOperacao()
        LOCAL loc_cIcones, loc_oCnt, loc_oGrd
        loc_cIcones = gc_4c_CaminhoIcones

        *======================================================================
        * 1) CntFinanc.Cnt_GrdBarra - painel do crediario (codigos de barras)
        *======================================================================
        THIS.cnt_4c_Financ.AddObject("cnt_4c__GrdBarra", "Container")
        loc_oCnt = THIS.cnt_4c_Financ.cnt_4c__GrdBarra
        WITH loc_oCnt
            .Top           = 183
            .Left          = 4
            .Width         = 368
            .Height        = 164
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- Grade dos codigos de barras lidos (TmpBarFin).
        loc_oCnt.AddObject("grd_4c_Barras", "Grid")
        WITH loc_oCnt.grd_4c_Barras
            .Top         = 4
            .Left        = 2
            .Width       = 364
            .Height      = 129
            .ColumnCount = 4
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .Visible     = .T.
        ENDWITH

        *-- F2-Selec: posiciona na grade para digitar um novo par de barras
        *-- (legado: Grade.Column1.SetFocus).
        loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Inserir
            .Top             = 131
            .Left            = 3
            .Width           = 80
            .Height          = 30
            .FontBold        = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = loc_cIcones + "a_misc7.bmp"
            .Caption         = "F2-\<Selec"
            .TabIndex        = 77
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        *-- F4-Excluir: apaga a linha corrente de TmpBarFin.
        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
            .Top             = 131
            .Left = 230
            .Width           = 80
            .Height          = 30
            .FontBold        = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = loc_cIcones + "a_delete1.bmp"
            .Caption         = "F4-\<Excluir"
            .TabIndex        = 77
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        *-- F5-Barra: devolve o foco ao campo do primeiro codigo de barras.
        *-- Nome do legado e "ok"; aqui cmd_4c_OkBarra, para nao colidir com os
        *-- outros dois "ok" do form (Barra_Botoes.ok e CancelaItem.ok).
        loc_oCnt.AddObject("cmd_4c_OkBarra", "CommandButton")
        WITH loc_oCnt.cmd_4c_OkBarra
            .Top             = 131
            .Left            = 161
            .Width           = 80
            .Height          = 30
            .FontBold        = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = loc_cIcones + "smmail.bmp"
            .Caption         = "F5-\<Barra"
            .TabIndex        = 40
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        *======================================================================
        * 2) Cnt_Credito.GradeDevol - operacoes de credito/devolucao (TmpDevol)
        *======================================================================
        *-- ZOrderSet do dump legado NAO e transcrito: e propriedade so do Form
        *-- Designer (indice de z-order gravado no SCX) e nao existe em runtime
        *-- (CLAUDE.md #33) - atribui-la derrubaria o Init.
        THIS.cnt_4c__Credito.AddObject("grd_4c_Devolucao", "Grid")
        loc_oGrd = THIS.cnt_4c__Credito.grd_4c_Devolucao
        WITH loc_oGrd
            .Top          = 64
            .Left         = 10
            .Width        = 355
            .Height       = 325
            .ColumnCount  = 3
            .FontName     = "Courier New"
            .HeaderHeight = 16
            .RowHeight    = 16
            .ScrollBars   = 2
            .TabIndex     = 4
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .BackColor    = RGB(254, 255, 232)
            .Visible      = .T.
        ENDWITH

        *-- A Column1 do legado nao usa o Text1 nativo: tem um TextBox proprio
        *-- (get_Devol), por onde o usuario digita o numero da operacao de
        *-- credito. Column.AddObject sozinho NAO faz o controle aparecer - a
        *-- coluna segue desenhando o Text1 ate receber CurrentControl
        *-- (CLAUDE.md #18). CurrentControl e Sparse ficam no MontaGrade,
        *-- porque RecordSource reseta os dois.
        loc_oGrd.Column1.AddObject("txt_4c__Devol", "TextBox")
        WITH loc_oGrd.Column1.txt_4c__Devol
            .FontName  = "Courier New"
            .Margin    = 0
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(254, 255, 232)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * 3) Cnt_Pendencia.GradeMultiSubN - sub-niveis/pendencias (TmpOperacao)
        *======================================================================
        THIS.cnt_4c__Pendencia.AddObject("grd_4c_SubNiveis", "Grid")
        WITH THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
            .Top          = 8
            .Left         = 14
            .Width        = 274
            .Height       = 397
            .ColumnCount  = 3
            .FontName     = "Verdana"
            .HeaderHeight = 16
            .RowHeight    = 16
            .ScrollBars   = 2
            .TabIndex     = 3
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(254, 255, 232)
            .Visible      = .T.
        ENDWITH

        *-- [F3]Pend. - abre a tela de pendencias do cliente (SigOpPen no
        *-- legado). Fica ao lado da grade, dentro do mesmo container.
        THIS.cnt_4c__Pendencia.AddObject("cmd_4c_BotPendentes", "CommandButton")
        WITH THIS.cnt_4c__Pendencia.cmd_4c_BotPendentes
            .Top         = 9
            .Left        = 300
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = loc_cIcones + "date2.ico"
            .Caption     = "[F3]Pend."
            .TabIndex    = 4
            .ToolTipText = "Abre Tela de Pend" + CHR(234) + "ncias"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .RightToLeft = .T.
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *======================================================================
        * 4) Cnt_Fpagto.Cnt_ChequepreTef.Grade - parcelas/cheques (xPar)
        *======================================================================
        THIS.cnt_4c__Fpagto.AddObject("cnt_4c__ChequepreTef", "Container")
        loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef
        WITH loc_oCnt
            .Top           = 358
            .Left          = 2
            .Width         = 371
            .Height        = 139
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 13
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .F.
        ENDWITH

        loc_oCnt.AddObject("grd_4c_Parcelas", "Grid")
        WITH loc_oCnt.grd_4c_Parcelas
            .Top          = 58
            .Left         = 5
            .Width        = 362
            .Height       = 79
            .ColumnCount  = 4
            .FontName     = "Tahoma"
            .FontSize     = 8
            .HeaderHeight = 12
            .RowHeight    = 16
            .ScrollBars   = 2
            .TabIndex     = 11
            .ReadOnly     = .F.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .Visible      = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresGrades - cria, VAZIOS, os cursores locais que alimentam as
    * cinco grades. No legado eles ja existiam: a tela de movimentacao (form
    * PAI) os montava na datasession COMPARTILHADA, e o SIGMVITN.SCX apenas
    * fazia "Set DataSession To pnDatSes" e os enxergava prontos. O form
    * migrado usa DataSession = 2 (isolado, como o SCX declara), entao os
    * cursores precisam nascer aqui.
    *
    * Roda ANTES de qualquer RecordSource/ControlSource: ligar coluna a alias
    * inexistente estoura "Alias is not found" dentro do TRY do InicializarForm
    * e o form simplesmente nao abre (CLAUDE.md #41).
    *
    * SET NULL ON antes do CREATE CURSOR porque estes cursores recebem dados do
    * SQL Server via APPEND FROM DBF() - coluna nullable do servidor recusa o
    * append num cursor declarado NOT NULL. O estado anterior e restaurado no
    * fim, para nao vazar SET para o resto da datasession.
    *
    * Estruturas transcritas do uso real no dump legado. Nomes de campo
    * PRESERVADOS: sao chave de ControlSource e aparecem literalmente nas
    * expressoes Locate/Replace/Seek das fases de evento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresGrades()
        LOCAL loc_cNullAnt
        loc_cNullAnt = SET("NULL")
        SET NULL ON

        *-- crTpmMvItn: o carrinho - copia local dos itens de SigMvItn da
        *-- movimentacao em andamento. As 23 primeiras colunas sao as de
        *-- SigMvItn que o legado referencia; ImpCupFis e LPrecos NAO existem
        *-- na tabela - sao campos de CONTROLE do cursor local (marcam item ja
        *-- impresso no cupom fiscal e a lista de preco aplicada).
        IF !USED("crTpmMvItn")
            CREATE CURSOR crTpmMvItn ( ;
                citens     N(10, 0) NULL, ;
                cpros      C(14)    NULL, ;
                dpros      C(65)    NULL, ;
                cunis      C(3)     NULL, ;
                codbarras  N(14, 0) NULL, ;
                codlprecs  N(6, 0)  NULL, ;
                empdopnums C(29)    NULL, ;
                etiesps    L        NULL, ;
                fators     N(8, 3)  NULL, ;
                fatvals    N(15, 6) NULL, ;
                moedas     C(3)     NULL, ;
                moefats    C(3)     NULL, ;
                moevals    N(15, 6) NULL, ;
                notas      C(6)     NULL, ;
                opers      C(1)     NULL, ;
                pesos      N(9, 3)  NULL, ;
                qtds       N(9, 3)  NULL, ;
                totas      N(11, 2) NULL, ;
                units      N(15, 6) NULL, ;
                univals    N(15, 6) NULL, ;
                utilizas   N(4, 0)  NULL, ;
                valdescs   N(9, 2)  NULL, ;
                obs        M        NULL, ;
                ImpCupFis  L        NULL, ;
                LPrecos    N(6, 0)  NULL)
            INDEX ON STR(citens, 10) TAG citens
            INDEX ON cpros TAG cpros
            SET ORDER TO
        ENDIF

        *-- crTpmMvItnC: as LINHAS de texto do cupom mostradas na grade do
        *-- cupom. Texto ate 90 chars (a linha mais longa do legado tem 85:
        *-- "@Z 9999" + identificacao(14) + descricao(65) + separadores).
        *-- Cores e o indice lido pelo DynamicForeColor (0 item .. 4 troco).
        IF !USED("crTpmMvItnC")
            CREATE CURSOR crTpmMvItnC ( ;
                cItens N(10, 0), ;
                Linha  N(2, 0), ;
                Texto  C(90), ;
                Cores  N(1, 0))
            *-- O legado procura a linha do item com Seek(Str(cItens, 4)),
            *-- entao a chave do indice e a MESMA expressao.
            INDEX ON STR(cItens, 4) TAG cItens
        ENDIF

        *-- TmpOperacao: sub-niveis/pendencias vinculados a esta movimentacao.
        IF !USED("TmpOperacao")
            CREATE CURSOR TmpOperacao ( ;
                Emps      C(3)     NULL, ;
                Dopes     C(20)    NULL, ;
                Numes     N(6, 0)  NULL, ;
                Codigos   N(10, 0) NULL, ;
                Notas     C(6)     NULL, ;
                Valos     N(11, 2) NULL, ;
                VlValVars N(11, 2) NULL, ;
                EmpSubns  C(29)    NULL, ;
                ChkSubn   L        NULL, ;
                Validado  L        NULL, ;
                Saida     L        NULL)
            INDEX ON STR(Codigos, 10) TAG Codigos
            SET ORDER TO
        ENDIF

        *-- TmpDevol: operacoes de credito/devolucao aproveitadas na venda.
        IF !USED("TmpDevol")
            CREATE CURSOR TmpDevol ( ;
                Emps      C(3)     NULL, ;
                Dopes     C(20)    NULL, ;
                Numes     N(6, 0)  NULL, ;
                Codigos   N(10, 0) NULL, ;
                TpCodigos N(1, 0)  NULL, ;
                Saida     L        NULL)
            INDEX ON STR(Codigos, 10) TAG Codigos
            SET ORDER TO
        ENDIF

        *-- TmpBarFin: pares de codigo de barras do crediario/carne. nEmps,
        *-- nDopes e nNumes sao NUMERICOS de proposito: o legado os extrai do
        *-- proprio codigo de barras com Val(Left(...)) / Val(Substr(...)).
        IF !USED("TmpBarFin")
            CREATE CURSOR TmpBarFin ( ;
                nBarra1 N(18, 0), ;
                nBarra2 N(18, 0), ;
                nEmps   N(3, 0), ;
                nDopes  N(5, 0), ;
                nNumes  N(6, 0), ;
                nParcs  N(2, 0), ;
                ValPs   N(11, 2), ;
                VencPs  D)
            INDEX ON STR(nBarra1, 18) + STR(nBarra2, 18) TAG barras
            SET ORDER TO
        ENDIF

        *-- xPar: as parcelas/formas de pagamento lancadas. Espelha as colunas
        *-- de SigMvPar que o legado referencia, MAIS cinco que so existem no
        *-- cursor local (nao estao na tabela): nChaves (agrupador da forma de
        *-- pagamento), Infos e Acumulas (copias do cadastro da forma,
        *-- SigOpFp), pDescs (percentual de desconto aplicado) e Bcds (bonus/
        *-- credito acumulado na parcela).
        IF !USED("xPar")
            CREATE CURSOR xPar ( ;
                Emps       C(3)     NULL, ;
                Dopes      C(20)    NULL, ;
                Numes      N(6, 0)  NULL, ;
                Datas      D        NULL, ;
                Parcs      N(2, 0)  NULL, ;
                tParcs     N(2, 0)  NULL, ;
                Vencs      D        NULL, ;
                Valos      N(11, 2) NULL, ;
                VPags      N(11, 2) NULL, ;
                ValDescs   N(11, 2) NULL, ;
                pDescs     N(9, 4)  NULL, ;
                FPags      C(12)    NULL, ;
                MoeFPgs    C(3)     NULL, ;
                CotFPgs    N(11, 4) NULL, ;
                Trocos     N(1, 0)  NULL, ;
                Infos      C(1)     NULL, ;
                Acumulas   N(1, 0)  NULL, ;
                InsChs     L        NULL, ;
                Empos      C(3)     NULL, ;
                EmpDopNums C(29)    NULL, ;
                Outros     C(20)    NULL, ;
                Obs        M        NULL, ;
                Bancos     C(3)     NULL, ;
                Agencias   C(4)     NULL, ;
                Contas     C(10)    NULL, ;
                Numeros    C(6)     NULL, ;
                NumChqs    C(8)     NULL, ;
                DigAgencs  C(1)     NULL, ;
                DigChqs    C(1)     NULL, ;
                DigContas  C(1)     NULL, ;
                Pracas     C(3)     NULL, ;
                Cpfs       C(20)    NULL, ;
                cnIdTefs   C(10)    NULL, ;
                nIdCheps   N(10, 0) NULL, ;
                nChaves    N(6, 0)  NULL, ;
                Bcds       N(11, 2) NULL)
            INDEX ON STR(nChaves, 6) + FPags TAG chaves
            SET ORDER TO
        ENDIF

        IF loc_cNullAnt = "OFF"
            SET NULL OFF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaGrade - liga as cinco grades aos seus cursores e (re)aplica TUDO o
    * que o VFP reseta quando RecordSource muda: Column.Width, Header1.Caption,
    * CurrentControl e Sparse. Por isso a ordem dentro de cada WITH e sempre a
    * mesma e NAO pode ser trocada:
    *
    *   RecordSource -> CurrentControl/Sparse -> ControlSource ->
    *   demais props da coluna -> Width -> Header1.Caption
    *
    * Definir Width antes do RecordSource faz o VFP jogar todas as colunas para
    * o default 90 e os cabecalhos para "Header1". O bloco roda de novo a cada
    * recarga (CarregarDados chama este metodo), exatamente como o legado
    * refazia o bind ao trocar de cursor.
    *
    * Os RecordSource/ControlSource sao os do Init legado (dump linhas
    * 7427-7446 e 7503-7518 de sigmvitn_form_codigo_fonte.txt) e do proprio
    * SCX (Cnt_ChequepreTef.Grade, RecordSource = "XPAR").
    *
    * PUBLIC (sem PROTECTED) e com parametro OPCIONAL nao utilizado: o
    * harness TesteAutomatico.prg (TesteCarregarDadosReais) chama
    * THIS.oForm.MontaGrade(...) diretamente de fora da classe, como faz com
    * o "MontaGrade" de outros forms OPERACIONAIS que recebem um grupo de
    * filtro. PEMSTATUS devolve .T. mesmo com PROTECTED (so verifica
    * existencia, nao escopo - CLAUDE.md #3) e a chamada real quebrava com
    * "Property MONTAGRADE is not found"; sem o parametro opcional, a mesma
    * chamada quebraria com "Too many actual parameters" (VFP9 nao aceita
    * argumento extra em metodo sem PARAMETERS/LPARAMETERS). As chamadas
    * internas deste form (THIS.MontaGrade()) continuam sem argumento.
    *--------------------------------------------------------------------------
    PROCEDURE MontaGrade(par_cParamTeste)
        LOCAL loc_oGrd, loc_cDyn

        *======================================================================
        * Grade do CUPOM (crTpmMvItnC) - coluna unica, sem cabecalho visivel
        * (HeaderHeight = 0), fonte Courier New como o legado troca em runtime.
        *======================================================================
        IF USED("crTpmMvItnC")
            loc_oGrd = THIS.grd_4c_Cupom
            loc_oGrd.RecordSource = "crTpmMvItnC"
            WITH loc_oGrd
                .Column1.ControlSource = "crTpmMvItnC.Texto"
                .Column1.Enabled       = .F.
                .Column1.FontBold      = .T.
                .Column1.FontName      = "Courier New"
                .Column1.Movable       = .F.
                .Column1.ReadOnly      = .T.
                .Column1.ForeColor     = RGB(0, 0, 255)

                .Column1.Text1.Enabled   = .F.
                .Column1.Text1.FontBold  = .T.
                .Column1.Text1.FontName  = "Courier New"
                .Column1.Text1.ReadOnly  = .T.
                .Column1.Text1.ForeColor = RGB(0, 0, 255)
                .Column1.Text1.Width     = 345

                .Column1.Width = 345
                .Column1.Header1.Caption = ""
            ENDWITH

            *-- DynamicForeColor do legado: a cor de cada linha do cupom vem do
            *-- campo Cores (0 item, 1 totalizador, 2 forma de pagamento,
            *-- 3 valor recebido, 4 troco/estorno). Montado em variavel para
            *-- caber em linha e aplicado com SetAll, como no legado.
            loc_cDyn = "(IIF(crTpmMvItnC.Cores=0, RGB(0,0,255), " + ;
                       "IIF(crTpmMvItnC.Cores=1, RGB(0,0,160), " + ;
                       "IIF(crTpmMvItnC.Cores=2, RGB(0,0,64), " + ;
                       "IIF(crTpmMvItnC.Cores=3, RGB(64,0,64), RGB(255,0,0))))))"
            loc_oGrd.SetAll("DynamicForeColor", loc_cDyn, "Column")
        ENDIF

        *======================================================================
        * Grade das PENDENCIAS / sub-niveis (TmpOperacao)
        *======================================================================
        IF USED("TmpOperacao")
            loc_oGrd = THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
            loc_oGrd.RecordSource = "TmpOperacao"
            WITH loc_oGrd
                .Column1.ControlSource = "TmpOperacao.Codigos"
                .Column1.FontName      = "Verdana"
                .Column1.InputMask     = "9999999999"
                .Column1.Movable       = .F.
                .Column1.Resizable     = .F.
                .Column1.ForeColor     = RGB(36, 84, 155)
                .Column1.BackColor     = RGB(254, 255, 232)
                .Column1.Text1.FontName  = "Verdana"
                .Column1.Text1.Margin    = 0
                .Column1.Text1.ForeColor = RGB(36, 84, 155)
                .Column1.Text1.BackColor = RGB(254, 255, 232)

                .Column2.ControlSource = "TmpOperacao.Notas"
                .Column2.FontName      = "Verdana"
                .Column2.Movable       = .F.
                .Column2.Resizable     = .F.
                .Column2.ForeColor     = RGB(36, 84, 155)
                .Column2.BackColor     = RGB(254, 255, 232)
                .Column2.Text1.FontName    = "Verdana"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(36, 84, 155)
                .Column2.Text1.BackColor   = RGB(254, 255, 232)

                .Column3.ControlSource = "TmpOperacao.Valos"
                .Column3.FontName      = "Verdana"
                .Column3.ForeColor     = RGB(36, 84, 155)
                .Column3.BackColor     = RGB(254, 255, 232)
                .Column3.Text1.FontName    = "Verdana"
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ForeColor   = RGB(36, 84, 155)
                .Column3.Text1.BackColor   = RGB(254, 255, 232)

                .Column1.Width = 80
                .Column2.Width = 80
                .Column3.Width = 90

                .Column1.Header1.FontBold  = .T.
                .Column1.Header1.FontName  = "Verdana"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Pend" + CHR(234) + "ncias"

                .Column2.Header1.FontBold  = .T.
                .Column2.Header1.FontName  = "Verdana"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Notas"

                .Column3.Header1.FontBold  = .T.
                .Column3.Header1.FontName  = "Verdana"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.Caption   = "Valor"
            ENDWITH
        ENDIF

        *======================================================================
        * Grade dos CREDITOS / devolucoes (TmpDevol)
        *======================================================================
        IF USED("TmpDevol")
            loc_oGrd = THIS.cnt_4c__Credito.grd_4c_Devolucao
            loc_oGrd.RecordSource = "TmpDevol"
            WITH loc_oGrd
                *-- CurrentControl DEPOIS do RecordSource (que o devolve para
                *-- "Text1") e Sparse = .F. para o TextBox proprio aparecer em
                *-- TODAS as linhas, nao so na corrente (CLAUDE.md #18).
                .Column1.CurrentControl = "txt_4c__Devol"
                .Column1.Sparse         = .F.

                .Column1.ControlSource = "TmpDevol.Codigos"
                .Column1.FontName      = "Courier New"
                .Column1.InputMask     = "9999999999"
                .Column1.Movable       = .F.
                .Column1.Resizable     = .F.
                .Column1.BackColor     = RGB(254, 255, 232)
                .Column1.txt_4c__Devol.FontName  = "Courier New"
                .Column1.txt_4c__Devol.InputMask = "9999999999"
                .Column1.txt_4c__Devol.Margin    = 0
                .Column1.txt_4c__Devol.ForeColor = RGB(0, 0, 0)
                .Column1.txt_4c__Devol.BackColor = RGB(254, 255, 232)

                .Column2.ControlSource = "TmpDevol.Dopes"
                .Column2.FontName      = "Courier New"
                .Column2.Movable       = .F.
                .Column2.Resizable     = .F.
                .Column2.BackColor     = RGB(254, 255, 232)
                .Column2.Text1.FontName    = "Courier New"
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(254, 255, 232)

                .Column3.ControlSource = "TmpDevol.Numes"
                .Column3.BackColor     = RGB(254, 255, 232)
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(254, 255, 232)

                .Column1.Width = 82
                .Column2.Width = 180
                .Column3.Width = 70

                .Column1.Header1.FontBold  = .T.
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Op. Cr" + CHR(233) + "dito"

                .Column2.Header1.FontBold  = .T.
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"

                .Column3.Header1.FontBold  = .T.
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.Caption   = "Documento"
            ENDWITH
        ENDIF

        *======================================================================
        * Grade dos CODIGOS DE BARRAS do crediario (TmpBarFin)
        *======================================================================
        IF USED("TmpBarFin")
            loc_oGrd = THIS.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras
            loc_oGrd.RecordSource = "TmpBarFin"
            WITH loc_oGrd
                .Column1.ControlSource = "TmpBarFin.nBarra2"
                .Column2.ControlSource = "TmpBarFin.nParcs"
                .Column3.ControlSource = "TmpBarFin.ValPs"
                .Column4.ControlSource = "TmpBarFin.VencPs"

                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)
                .Column3.Text1.BorderStyle = 0
                .Column3.Text1.Margin      = 0
                .Column3.Text1.ForeColor   = RGB(0, 0, 0)
                .Column3.Text1.BackColor   = RGB(255, 255, 255)
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                .Column1.Width = 120
                .Column2.Width = 50
                .Column3.Width = 80
                .Column4.Width = 80

                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "C" + CHR(243) + "digo de Barra"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Parcela"
                .Column3.Header1.Alignment = 2
                .Column3.Header1.Caption   = "Valor"
                .Column4.Header1.Alignment = 2
                .Column4.Header1.Caption   = "Vencimento"
            ENDWITH
        ENDIF

        *======================================================================
        * Grade das PARCELAS / cheques pre-datados (xPar)
        *======================================================================
        IF USED("xPar")
            loc_oGrd = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas
            loc_oGrd.RecordSource = "xPar"
            WITH loc_oGrd
                *-- Column1 (Condicao) e a unica ReadOnly: o legado deixa
                *-- alterar valor, vencimento e moeda da parcela, mas nunca a
                *-- forma de pagamento ja escolhida. Column.ReadOnly vem DEPOIS
                *-- de Grid.ReadOnly, senao o do grid sobrescreve o da coluna.
                .Column1.ControlSource = "xPar.FPags"
                .Column1.FontName      = "Tahoma"
                .Column1.FontSize      = 8
                .Column1.Movable       = .F.
                .Column1.Resizable     = .F.
                .Column1.ReadOnly      = .T.
                .Column1.Text1.FontName    = "Tahoma"
                .Column1.Text1.FontSize    = 8
                .Column1.Text1.BorderStyle = 0
                .Column1.Text1.Margin      = 0
                .Column1.Text1.ReadOnly    = .T.
                .Column1.Text1.ForeColor   = RGB(0, 0, 0)
                .Column1.Text1.BackColor   = RGB(255, 255, 255)

                .Column2.ControlSource = "xPar.Valos"
                .Column2.FontName      = "Tahoma"
                .Column2.FontSize      = 8
                .Column2.Movable       = .F.
                .Column2.Resizable     = .F.
                .Column2.ReadOnly      = .F.
                .Column2.InputMask     = "999999,999.99"
                .Column2.Text1.FontName    = "Tahoma"
                .Column2.Text1.FontSize    = 8
                .Column2.Text1.BorderStyle = 0
                .Column2.Text1.Margin      = 0
                .Column2.Text1.ReadOnly    = .F.
                .Column2.Text1.ForeColor   = RGB(0, 0, 0)
                .Column2.Text1.BackColor   = RGB(255, 255, 255)

                .Column3.ControlSource = "xPar.Vencs"
                .Column3.FontName      = "Tahoma"
                .Column3.FontSize      = 8
                .Column3.Movable       = .F.
                .Column3.Resizable     = .F.
                .Column3.ReadOnly      = .F.
                .Column3.Text1.FontName        = "Tahoma"
                .Column3.Text1.FontSize        = 8
                .Column3.Text1.BorderStyle     = 0
                .Column3.Text1.Margin          = 0
                .Column3.Text1.ReadOnly        = .F.
                .Column3.Text1.StrictDateEntry = 0
                .Column3.Text1.Format          = "E"
                .Column3.Text1.InputMask       = "99/99/9999"
                .Column3.Text1.MaxLength       = 10
                .Column3.Text1.ForeColor       = RGB(0, 0, 0)
                .Column3.Text1.BackColor       = RGB(255, 255, 255)

                .Column4.ControlSource = "xPar.MoeFPgs"
                .Column4.FontName      = "Tahoma"
                .Column4.FontSize      = 8
                .Column4.Movable       = .F.
                .Column4.Resizable     = .F.
                .Column4.ReadOnly      = .F.
                .Column4.Text1.FontName    = "Tahoma"
                .Column4.Text1.FontSize    = 8
                .Column4.Text1.BorderStyle = 0
                .Column4.Text1.Margin      = 0
                .Column4.Text1.ForeColor   = RGB(0, 0, 0)
                .Column4.Text1.BackColor   = RGB(255, 255, 255)

                .Column1.Width = 120
                .Column2.Width = 110
                .Column3.Width = 78
                .Column4.Width = 30

                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column1.Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o"

                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Valor"

                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column3.Header1.Caption   = "Vencimento"

                .Column4.Header1.FontName  = "Tahoma"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column4.Header1.Caption   = "Moe"
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - carga inicial (e recarga) das grades.
    *
    * 1) Le do banco, pelo BO, os itens ja gravados da movimentacao corrente e
    *    despeja no carrinho (crTpmMvItn). A leitura vai SEMPRE para um cursor
    *    TEMPORARIO e so dali entra no cursor da grade, por ZAP + APPEND FROM
    *    DBF(): SQLEXEC direto no alias da grade recria o cursor e destroi as
    *    colunas e o binding.
    * 2) Remonta as linhas de texto do cupom (crTpmMvItnC) a partir da carga,
    *    com a mesma formatacao do AtuaCupom legado.
    * 3) Refaz o bind (MontaGrade) e, como o legado sempre faz, posiciona no
    *    topo e manda cada grade se repintar - popular cursor NAO repinta a
    *    grade sozinho, e sem isso a tela parece vazia com o cursor cheio.
    *
    * Movimentacao SEM numero ainda (venda nova, this_nNumes = 0) nao tem item
    * gravado: o carrinho fica vazio, o painel CAIXA LIVRE continua visivel e
    * as grades sao repintadas vazias - que e exatamente o estado inicial do
    * legado quando o caixa abre sem operacao em andamento.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.CriarCursoresGrades()

            IF THIS.this_nNumes > 0 AND !EMPTY(THIS.this_cDopes) AND ;
                    TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF THIS.this_oBusinessObject.CarregarItensMovimento( ;
                        THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
                        "cursor_4c_ItensTmp")

                    SELECT crTpmMvItn
                    ZAP
                    IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
                        APPEND FROM DBF("cursor_4c_ItensTmp")
                    ENDIF

                    *-- Numero do proximo item = ultimo lancado, como o legado
                    *-- faz no fim do Init (Goto Bottom / CItem = cItens).
                    SELECT crTpmMvItn
                    GO BOTTOM
                    THIS.this_nCitem = IIF(RECCOUNT("crTpmMvItn") > 0, ;
                        NVL(crTpmMvItn.citens, 0), 0)

                    THIS.MontarLinhasCupom()

                    IF USED("cursor_4c_ItensTmp")
                        USE IN cursor_4c_ItensTmp
                    ENDIF
                ENDIF
            ENDIF

            THIS.MontaGrade()
            THIS.AtualizarGrades()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarLinhasCupom - transcreve o trecho do AtuaCupom legado que monta as
    * linhas de texto de cada item no cupom, percorrendo a carga recem-feita.
    *
    *   linha 1: numero do item + identificacao do produto + descricao
    *   linha 2: quantidade + unidade + valor unitario + total. Havendo
    *            desconto/acrescimo o legado quebra em DUAS - a de quantidade
    *            x valor ORIGINAL e a do ajuste com o total liquido.
    *
    * Regras de identificacao e descricao, iguais as do legado:
    *   - IdentPro = 1 e OpCrs <> 4 -> descricao = 1a linha da Descricao
    *     Fiscal do produto, truncada em 40 (fLimpaTexto tira acentuacao e
    *     caracteres de controle, como no legado).
    *   - caso contrario -> identifica pelo codigo de barras do item; nao
    *     havendo, usa o numero da nota (quando OpCrs = 4 e a nota esta no
    *     formato de 6 digitos) e, em ultimo caso, o codigo de barras do
    *     cadastro do produto.
    *   - a Descricao para ECF (SigCdPro.DescEcfs), quando preenchida, tem
    *     precedencia sobre as duas anteriores.
    * Produto sem codigo de barras em lugar nenhum e identificado pelo proprio
    * codigo do produto - e o que o legado exibe quando o caixa opera sem
    * impressora fiscal.
    *
    * Le do cursor TEMPORARIO da carga (cursor_4c_ItensTmp) porque e nele que
    * vem, no mesmo SELECT, os campos do cadastro do produto; o carrinho
    * (crTpmMvItn) so tem as colunas da tabela de itens, como no legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarLinhasCupom()
        LOCAL loc_nIdentPro, loc_nOpCrs, loc_cDescr, loc_nCodBarra, loc_cIdent
        LOCAL loc_nNotas, loc_cTexto, loc_nAreaAnt, loc_lProsseguir

        loc_lProsseguir = USED("cursor_4c_ItensTmp") AND USED("crTpmMvItnC")

        IF loc_lProsseguir
            loc_nAreaAnt = SELECT()

            *-- Parametros da operacao (no legado, cursores globais CrSigOpCdd
            *-- e CrSigCdOpe montados pela tela de movimentacao).
            loc_nIdentPro = 0
            loc_nOpCrs    = 0
            IF THIS.this_oBusinessObject.CarregarParametrosOperacao( ;
                    THIS.this_cDopes, "cursor_4c_ParOperacao")
                IF USED("cursor_4c_ParOperacao") AND RECCOUNT("cursor_4c_ParOperacao") > 0
                    SELECT cursor_4c_ParOperacao
                    GO TOP
                    loc_nIdentPro = NVL(cursor_4c_ParOperacao.identpro, 0)
                    loc_nOpCrs    = NVL(cursor_4c_ParOperacao.opcrs, 0)
                ENDIF
                IF USED("cursor_4c_ParOperacao")
                    USE IN cursor_4c_ParOperacao
                ENDIF
            ENDIF

            SELECT crTpmMvItnC
            ZAP

            SELECT cursor_4c_ItensTmp
            SCAN
                loc_cDescr    = NVL(cursor_4c_ItensTmp.dpros, "")
                loc_nCodBarra = 0

                IF loc_nIdentPro = 1 AND loc_nOpCrs <> 4
                    loc_cDescr = PADR(fLimpaTexto( ;
                        MLINE(NVL(cursor_4c_ItensTmp.prodescfis, ""), 1)), 40)
                ELSE
                    IF NVL(cursor_4c_ItensTmp.codbarras, 0) <> 0
                        loc_nCodBarra = NVL(cursor_4c_ItensTmp.codbarras, 0)
                    ELSE
                        loc_nNotas = VAL(NVL(cursor_4c_ItensTmp.notas, ""))
                        IF loc_nOpCrs = 4 ;
                                AND !EMPTY(ALLTRIM(NVL(cursor_4c_ItensTmp.notas, ""))) ;
                                AND TRANSFORM(loc_nNotas, "@L 999999") = ;
                                    NVL(cursor_4c_ItensTmp.notas, "")
                            loc_nCodBarra = loc_nNotas
                        ELSE
                            loc_nCodBarra = NVL(cursor_4c_ItensTmp.procbars, 0)
                        ENDIF
                    ENDIF
                ENDIF

                IF !EMPTY(NVL(cursor_4c_ItensTmp.prodescecf, ""))
                    loc_cDescr = NVL(cursor_4c_ItensTmp.prodescecf, "")
                ENDIF

                loc_cIdent = IIF(loc_nCodBarra = 0, ;
                    NVL(cursor_4c_ItensTmp.cpros, ""), ;
                    PADL(loc_nCodBarra, 14, "0"))

                *-- Linha 1: item + identificacao + descricao.
                loc_cTexto = TRANSFORM(NVL(cursor_4c_ItensTmp.citens, 0), "@Z 9999") + ;
                    " " + PADR(loc_cIdent, 14) + " " + ALLTRIM(loc_cDescr)
                INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                    VALUES (NVL(cursor_4c_ItensTmp.citens, 0), 1, loc_cTexto, 0)

                IF NVL(cursor_4c_ItensTmp.valdescs, 0) <> 0
                    loc_cTexto = "    " + ;
                        TRANSFORM(NVL(cursor_4c_ItensTmp.qtds, 0), "@Z 999.99") + " " + ;
                        NVL(cursor_4c_ItensTmp.cunis, "") + " X  " + ;
                        TRANSFORM(NVL(cursor_4c_ItensTmp.univals, 0), "@Z 999,999,999.99") + ;
                        " " + TRANSFORM(NVL(cursor_4c_ItensTmp.univals, 0) * ;
                            NVL(cursor_4c_ItensTmp.qtds, 0), "@Z 999,999,999.99")
                    INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                        VALUES (NVL(cursor_4c_ItensTmp.citens, 0), 2, loc_cTexto, 0)

                    loc_cTexto = "    " + ;
                        IIF(NVL(cursor_4c_ItensTmp.valdescs, 0) < 0, "Acrescimo", "Desconto ") + ;
                        TRANSFORM(NVL(cursor_4c_ItensTmp.valdescs, 0) * (-1), ;
                            "@Z 999,999,999.99") + " " + ;
                        TRANSFORM(NVL(cursor_4c_ItensTmp.totas, 0), "@Z 999,999,999.99")
                    INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                        VALUES (NVL(cursor_4c_ItensTmp.citens, 0), 2, loc_cTexto, 0)
                ELSE
                    loc_cTexto = "    " + ;
                        TRANSFORM(NVL(cursor_4c_ItensTmp.qtds, 0), "@Z 999.99") + " " + ;
                        NVL(cursor_4c_ItensTmp.cunis, "") + " X  " + ;
                        TRANSFORM(NVL(cursor_4c_ItensTmp.units, 0), "@Z 999,999,999.99") + ;
                        " " + TRANSFORM(NVL(cursor_4c_ItensTmp.totas, 0), "@Z 999,999,999.99")
                    INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
                        VALUES (NVL(cursor_4c_ItensTmp.citens, 0), 2, loc_cTexto, 0)
                ENDIF
            ENDSCAN

            IF loc_nAreaAnt > 0
                SELECT (loc_nAreaAnt)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGrades - posiciona TODOS os cursores das grades no topo e manda
    * cada grade se repintar. Popular um cursor NAO repinta a grade ligada a
    * ele: sem este passo a tela aparece vazia com o cursor cheio, e o sintoma
    * ("a tela nao traz dados") manda o diagnostico para o SQL, que esta certo.
    * O legado fecha assim toda carga - "Go Top In <cursor>" + "<grade>.Refresh".
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarGrades()
        IF USED("crTpmMvItnC")
            GO TOP IN crTpmMvItnC
            THIS.grd_4c_Cupom.Refresh()
        ENDIF

        IF USED("TmpOperacao")
            GO TOP IN TmpOperacao
            THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Refresh()
        ENDIF

        IF USED("TmpDevol")
            GO TOP IN TmpDevol
            THIS.cnt_4c__Credito.grd_4c_Devolucao.Refresh()
        ENDIF

        IF USED("TmpBarFin")
            GO TOP IN TmpBarFin
            THIS.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.Refresh()
        ENDIF

        IF USED("xPar")
            GO TOP IN xPar
            THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas.Refresh()
        ENDIF

        *-- O painel "CAIXA LIVRE" cobre a grade do cupom enquanto nao ha item
        *-- lancado, exatamente como no legado (o AtuaCupom comeca escondendo-o
        *-- assim que o primeiro item entra).
        THIS.cnt_4c_CaixaLivre.Visible = (RECCOUNT("crTpmMvItnC") = 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna visiveis os controles criados via
    * AddObject (que nascem Visible=.F.), recursivamente. Containers
    * flutuantes do legado (Visible=.F. por padrao, alternados por botao nas
    * proximas fases) sao PULADOS aqui - mas seus FILHOS sao recursados mesmo
    * assim, para nao ficarem presos ocultos quando o container for exibido
    * depois (regra da skip+recursao - ver docs/CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_lOculto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Controles que o SCX legado declara Visible=.F. e que sao
                *-- exibidos sob demanda (botao/fluxo) nas Fases 7-8. Ficam
                *-- ocultos, mas seus FILHOS sao recursados mesmo assim.
                loc_lOculto = INLIST(UPPER(loc_oObjeto.Name), ;
                    "CNT_4C__CONSULTA", "CNT_4C_FINANC", ;
                    "CNT_4C__CHEQUEPRETEF", "CNT_4C__CHQ", ;
                    "CNT_4C_ACRESCIMO", "CNT_4C_DESCONTO", ;
                    "CBO_4C_CMBTOPERS", "CNT_4C_CANCELAITEM", "IMG_4C_FIGJPG", ;
                    "OBJ_4C_GETOBS", "LBL_4C_OBS", "CMD_4C_FINANCIA", ;
                    "CMD_4C_CMDENVIAPROD")

                IF loc_lOculto
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - fecha os cursores locais das grades, reabilita o form pai (se
    * houver) e libera BO/menu (DODEFAULT chama FormBase.Destroy, que ja cuida
    * do fix menu-shrinks).
    *
    * Os cursores sao fechados um a um porque o form vive numa DataSession
    * propria mas os alias sao compartilhaveis por nome: deixar TmpOperacao /
    * TmpDevol / xPar abertos faria a proxima abertura do Caixa reaproveitar o
    * cursor da venda anterior (o IF !USED de CriarCursoresGrades nao recriaria
    * nada) e a tela comecaria com os dados da venda que ja terminou.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro, loc_nI, loc_cAlias, loc_aCursores[7]

        loc_aCursores[1] = "crTpmMvItn"
        loc_aCursores[2] = "crTpmMvItnC"
        loc_aCursores[3] = "TmpOperacao"
        loc_aCursores[4] = "TmpDevol"
        loc_aCursores[5] = "TmpBarFin"
        loc_aCursores[6] = "xPar"
        loc_aCursores[7] = "cursor_4c_ItensTmp"

        TRY
            FOR loc_nI = 1 TO ALEN(loc_aCursores)
                loc_cAlias = loc_aCursores[loc_nI]
                IF USED(loc_cAlias)
                    USE IN (loc_cAlias)
                ENDIF
            ENDFOR

            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            * cursor ou form pai ja liberado - o Destroy nao pode falhar aqui,
            * senao o menu principal nao e reconstruido no DODEFAULT abaixo.
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposParte1 - primeira metade dos campos de dados do form
    * (FASE 5/8). Cobre os elementos auxiliares de topo (logotipo, faixas de
    * mensagem), o painel "CAIXA LIVRE", o painel de cancelamento de item, o
    * painel de consulta de preco (Ctrl+P) e os dois containers que ficam
    * visiveis por padrao ao abrir o Caixa (CntItem e CntFinanc). A segunda
    * metade (Cnt_Identifica, Cnt_Fpagto, os labels remanescentes de
    * Cnt_Credito/Cnt_Pendencia e cmbTOpers) fica para a Fase 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposParte1()
        THIS.ConfigurarCamposLogotipo()
        THIS.ConfigurarCamposMensagens()
        THIS.ConfigurarCamposCaixaLivre()
        THIS.ConfigurarCamposCancelaItem()
        THIS.ConfigurarCamposConsulta()
        THIS.ConfigurarCamposItem()
        THIS.ConfigurarCamposFinanc()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposLogotipo - imagem do logotipo dentro de cnt_4c__Img4c
    * (container criado na Fase 3, ainda vazio).
    * Original: SIGMVITN.Cnt_Img4c.figjpg - Picture=..\framework\imagens\
    * 4Control_logo2.png Stretch=1 BackStyle=1 Height=218 Left=-22 Top=-59
    * Width=331 BorderColor=36,84,155.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposLogotipo()
        THIS.cnt_4c__Img4c.AddObject("img_4c_Figjpg", "Image")
        WITH THIS.cnt_4c__Img4c.img_4c_Figjpg
            .Top         = -59
            .Left        = -22
            .Width       = 331
            .Height      = 218
            .Stretch     = 1
            .BackStyle   = 1
            .Picture     = gc_4c_CaminhoIcones + "4Control_logo2.png"
            .BorderColor = RGB(36, 84, 155)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposMensagens - labels das duas faixas de mensagem do
    * rodape (cnt_4c__Mensagem e cnt_4c_Mensagems, containers criados na
    * Fase 3). O texto e atualizado em runtime pelos eventos das proximas
    * fases - nasce vazio, como o proprio Cnt_Mensagem do legado (Caption="").
    * Original Cnt_Mensagem.Mensagem: AutoSize=.T. FontBold=.T. FontName=
    * "Verdana" FontSize=10 BackStyle=0 Height=18 Left=3 Top=2 Width=2
    * ForeColor=36,84,155.
    * Original Cnt_Mensagem.Abertura: AutoSize=.F., mesma fonte/cor, Height=19
    * Left=317 Top=3 Width=55.
    * Original mensagems.Mensage1/Mensage2: AutoSize=.F. FontBold=.T.
    * FontName="Tahoma" BackStyle=0 Left=6 ForeColor=90,90,90 (Mensage1
    * FontSize=13 Top=1 Height=23 Width=709; Mensage2 FontSize=16 Top=19
    * Height=26 Width=709).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposMensagens()
        THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Mensagem", "Label")
        WITH THIS.cnt_4c__Mensagem.lbl_4c_Mensagem
            .Top       = 2
            .Left      = 3
            .Width     = 2
            .Height    = 18
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 10
            .BackStyle = 0
            .Caption   = ""
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Abertura", "Label")
        WITH THIS.cnt_4c__Mensagem.lbl_4c_Abertura
            .Top       = 3
            .Left      = 317
            .Width     = 55
            .Height    = 19
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 10
            .BackStyle = 0
            .Caption   = ""
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Mensagems.AddObject("lbl_4c_Mensage1", "Label")
        WITH THIS.cnt_4c_Mensagems.lbl_4c_Mensage1
            .Top       = 1
            .Left      = 6
            .Width     = 709
            .Height    = 23
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = ""
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Mensagems.AddObject("lbl_4c_Mensage2", "Label")
        WITH THIS.cnt_4c_Mensagems.lbl_4c_Mensage2
            .Top       = 19
            .Left      = 6
            .Width     = 709
            .Height    = 26
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .BackStyle = 0
            .Caption   = ""
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposCaixaLivre - os dois labels sobrepostos do painel
    * "CAIXA LIVRE" (cnt_4c_CaixaLivre, container ja criado). CaixaLivre2 fica
    * 3px deslocado de CaixaLivre e com cor diferente - efeito de sombra do
    * legado, reproduzido na mesma ordem de criacao (Z-order) do dump.
    * Original CaixaLivre: FontBold=.T. FontName="Tahoma" FontSize=60
    * WordWrap=.T. Alignment=2 BackStyle=0 Caption="CAIXA LIVRE" Height=216
    * Left=67 Top=117 Width=336 ForeColor=255,128,64.
    * Original CaixaLivre2: idem, Left=64 Top=120 ForeColor=0,64,183.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposCaixaLivre()
        THIS.cnt_4c_CaixaLivre.AddObject("lbl_4c_CaixaLivre", "Label")
        WITH THIS.cnt_4c_CaixaLivre.lbl_4c_CaixaLivre
            .Top        = 117
            .Left       = 67
            .Width      = 336
            .Height     = 216
            .FontBold   = .T.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 60
            .WordWrap   = .T.
            .Alignment  = 2
            .BackStyle  = 0
            .Caption    = "CAIXA LIVRE"
            .ForeColor  = RGB(255, 128, 64)
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_CaixaLivre.AddObject("lbl_4c_CaixaLivre2", "Label")
        WITH THIS.cnt_4c_CaixaLivre.lbl_4c_CaixaLivre2
            .Top        = 120
            .Left       = 64
            .Width      = 336
            .Height     = 216
            .FontBold   = .T.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 60
            .WordWrap   = .T.
            .Alignment  = 2
            .BackStyle  = 0
            .Caption    = "CAIXA LIVRE"
            .ForeColor  = RGB(0, 64, 183)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposCancelaItem - conteudo do painel de cancelamento de item
    * (cnt_4c_CancelaItem, container oculto criado na Fase 3 - acionado por
    * cmd_4c_Apaga/cmd_4c_Excluir nas Fases 7-8). Mostra o item, produto,
    * codigo de barras e descricao do item a cancelar; ok confirma e
    * CancelaDisp desiste.
    * Original (dump slim.txt, SIGMVITN.CancelaItem.*):
    *   Label1 "CANCELAMENTO DE ITEM" Alignment=2 FontSize=10 Height=19 Left=1
    *     Top=2 Width=467 ForeColor=255,255,255 BackColor=90,90,90
    *   Get_Produto Format="K!" InputMask=14x"!" Height=23 Left=78 Top=56
    *     Width=105 BackColor=255,255,185 ForeColor=90,90,90
    *   Label2 "ITEM :" Left=38 Top=33 Width=36
    *   Label3 "PRODUTO :" Left=12 Top=58 Width=62
    *   Label4 "BARRA :" Left=27 Top=84 Width=47
    *   Get_item InputMask="999" MaxLength=3 Height=23 Left=78 Top=31
    *     Width=31 BackColor=255,255,185
    *   Get_Cbarra InputMask="99999999" MaxLength=8 Height=23 Left=78 Top=81
    *     Width=79 BackColor=255,255,185
    *   get_dpro Height=23 Left=183 Top=56 Width=281 BackColor=255,255,185
    *   ok Top=89 Left=368 W=45 H=45 Picture=mouse4.ico ToolTipText="Confirmar"
    *   CancelaDisp Top=89 Left=414 W=45 H=45 Picture="shut down.ico"
    *     Cancel=.T. ToolTipText="Cancelar"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposCancelaItem()
        LOCAL loc_cIcones, loc_oCnt
        loc_cIcones = gc_4c_CaminhoIcones
        loc_oCnt    = THIS.cnt_4c_CancelaItem

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top            = 2
            .Left           = 1
            .Width          = 467
            .Height         = 19
            .FontBold       = .T.
            .FontName       = "Tahoma"
            .FontSize       = 10
            .FontUnderline  = .F.
            .Alignment      = 2
            .BackStyle      = 1
            .Caption        = "CANCELAMENTO DE ITEM"
            .ForeColor      = RGB(255, 255, 255)
            .BackColor      = RGB(90, 90, 90)
            .Visible        = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Produto", "TextBox")
        WITH loc_oCnt.txt_4c_Produto
            .Top           = 56
            .Left          = 78
            .Width         = 105
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .InputMask     = "!!!!!!!!!!!!!!"
            .MaxLength     = 14
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 185)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top       = 33
            .Left      = 38
            .Width     = 36
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "ITEM :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Top       = 58
            .Left      = 12
            .Width     = 62
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "PRODUTO :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Top       = 84
            .Left      = 27
            .Width     = 47
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "BARRA :"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Item", "TextBox")
        WITH loc_oCnt.txt_4c_Item
            .Top           = 31
            .Left          = 78
            .Width         = 31
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999"
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 185)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cbarra", "TextBox")
        WITH loc_oCnt.txt_4c_Cbarra
            .Top           = 81
            .Left          = 78
            .Width         = 79
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99999999"
            .MaxLength     = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 185)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__dpro", "TextBox")
        WITH loc_oCnt.txt_4c__dpro
            .Top           = 56
            .Left          = 183
            .Width         = 281
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 185)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Ok", "CommandButton")
        WITH loc_oCnt.cmd_4c_Ok
            .Top         = 89
            .Left        = 368
            .Width       = 45
            .Height      = 45
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Picture     = loc_cIcones + "mouse4.ico"
            .Cancel      = .F.
            .Caption     = ""
            .ToolTipText = "Confirmar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
        WITH loc_oCnt.cmd_4c_CancelaDisp
            .Top         = 89
            .Left        = 414
            .Width       = 45
            .Height      = 45
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Picture     = loc_cIcones + "shut down.ico"
            .Cancel      = .T.
            .Caption     = ""
            .ToolTipText = "Cancelar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposConsulta - conteudo do painel de consulta de preco
    * (cnt_4c__Consulta, container oculto - acionado por cmd_4c_VerPreco nas
    * Fases 7-8). O usuario digita o codigo do produto, confirma e a tela
    * mostra descricao + preco em cnt_4c__Resultado.
    * Colisao de nome no mapeamento.json: Say1 ("Preco Unitario") e Label1
    * ("Consulta Preco do Produto") sao FILHOS DIRETOS do mesmo container e o
    * gerador automatico mapeou os dois para "lbl_4c_Label1" (colide com AS
    * DUAS pattern SayN/LabelN -> LabelN). Resolvido aqui com lbl_4c_Say1 para
    * o primeiro, lbl_4c_Label1 (nome do proprio legado) para o segundo.
    * Original (dump slim.txt, SIGMVITN.Cnt_Consulta.*):
    *   Say1 "Pre?o Unit?rio" FontSize=25 Left=34 Top=277 ForeColor=90,90,90
    *   Cnt_Produto (Top=62 Left=7 W=361 H=64 BackStyle=1 BorderWidth=1
    *     SpecialEffect=2 BackColor=255,255,255):
    *       Get_Produto Format="K!" InputMask=13x"!" FontSize=15 Height=30
    *         Left=39 Top=28 Width=178
    *       Say7 "Produto" FontSize=15 Left=40 Top=4
    *   Cnt_Resultado (Top=142 Left=7 W=361 H=123 BackStyle=1 BorderWidth=2
    *     SpecialEffect=2 BackColor=255,255,255):
    *       Mensage1 FontSize=14 Height=31 Left=4 Top=6 Width=353
    *       Mensage2 FontSize=16 WordWrap=.T. Height=64 Left=4 Top=49 Width=353
    *   Label1 "Consulta Pre?o do Produto" AutoSize=.T. FontSize=16 Height=27
    *     Left=32 Top=14 Width=281
    *   Command1 "Sair" Top=399 Left=227 H=39 W=91 Cancel=.T.
    *   Get_Unit Alignment=3 Value=0 FontSize=23 InputMask="9,999,999.99"
    *     Height=46 Left=37 Top=318 Width=249 BorderColor=100,100,100
    *   Proximo Top=319 Left=319 W=45 H=45 Picture=b_arrow2.bmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposConsulta()
        LOCAL loc_cIcones, loc_oCnt, loc_oSub
        loc_cIcones = gc_4c_CaminhoIcones
        loc_oCnt    = THIS.cnt_4c__Consulta

        loc_oCnt.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oCnt.lbl_4c_Say1
            .Top       = 277
            .Left      = 34
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 25
            .Caption   = "Pre" + CHR(231) + "o Unit" + CHR(225) + "rio"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("cnt_4c__Produto", "Container")
        loc_oSub = loc_oCnt.cnt_4c__Produto
        WITH loc_oSub
            .Top           = 62
            .Left          = 7
            .Width         = 361
            .Height        = 64
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Produto", "TextBox")
        WITH loc_oSub.txt_4c_Produto
            .Top       = 28
            .Left      = 39
            .Width     = 178
            .Height    = 30
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Format    = "K!"
            .InputMask = "!!!!!!!!!!!!!"
            .MaxLength = 13
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oSub.lbl_4c_Label7
            .Top       = 4
            .Left      = 40
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Caption   = "Produto"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("cnt_4c__Resultado", "Container")
        loc_oSub = loc_oCnt.cnt_4c__Resultado
        WITH loc_oSub
            .Top           = 142
            .Left          = 7
            .Width         = 361
            .Height        = 123
            .BackStyle     = 1
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Mensage1", "Label")
        WITH loc_oSub.lbl_4c_Mensage1
            .Top       = 6
            .Left      = 4
            .Width     = 353
            .Height    = 31
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 14
            .BackStyle = 0
            .Caption   = ""
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Mensage2", "Label")
        WITH loc_oSub.lbl_4c_Mensage2
            .Top       = 49
            .Left      = 4
            .Width     = 353
            .Height    = 64
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .WordWrap  = .T.
            .BackStyle = 0
            .Caption   = ""
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top      = 14
            .Left     = 32
            .Width    = 281
            .Height   = 27
            .AutoSize = .T.
            .FontBold = .T.
            .FontItalic = .F.
            .FontName = "Tahoma"
            .FontSize = 16
            .BackStyle = 0
            .Caption  = "Consulta Pre" + CHR(231) + "o do Produto"
            .ForeColor = RGB(90, 90, 90)
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Command1", "CommandButton")
        WITH loc_oCnt.cmd_4c_Command1
            .Top     = 399
            .Left    = 227
            .Width   = 91
            .Height  = 39
            .Cancel  = .T.
            .Caption = "Sair"
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Unit", "TextBox")
        WITH loc_oCnt.txt_4c_Unit
            .Top           = 318
            .Left          = 37
            .Width         = 249
            .Height        = 46
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 23
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "9,999,999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH loc_oCnt.cmd_4c_Proximo
            .Top           = 319
            .Left          = 319
            .Width         = 45
            .Height        = 45
            .FontName      = "Verdana"
            .FontSize      = 8
            .Picture       = loc_cIcones + "b_arrow2.bmp"
            .Caption       = ""
            .ToolTipText   = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
            .SpecialEffect = 0
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposItem - conteudo do container principal de lancamento de
    * itens (cnt_4c_Item, visivel por padrao ao abrir o Caixa): codigo do
    * produto + quantidade, subtotal, bloco de desconto/acrescimo e total do
    * item.
    * Colisao de nome no mapeamento.json: CntItem tem DOIS "Say8" - um dentro
    * de Cnt_Produto ("Quantidade") e outro filho direto do container
    * ("TOTAL") - ambos mapeados para "lbl_4c_Label8". Resolvido aqui com
    * lbl_4c_Label8 para o de dentro de Cnt_Produto (unico na sua sub-arvore)
    * e lbl_4c_Total (nome descritivo) para o filho direto do container.
    * Original (dump slim.txt, SIGMVITN.CntItem.*):
    *   Get_total Alignment=3 Value=0 FontSize=22 InputMask="9,999,999.99"
    *     Height=46 Left=62 Top=369 Width=249 BackColor=255,255,255
    *   Cnt_Produto (Top=8 Left=7 W=360 H=92 BackStyle=1 BorderWidth=1
    *     SpecialEffect=2 BackColor=255,255,255):
    *       Get_Produto Format="K!" InputMask=14x"!" FontSize=15 Height=30
    *         Left=24 Top=26 Width=178 ForeColor=90,90,90
    *       Get_Qtds Alignment=3 Value=0 FontSize=15 InputMask="999.999"
    *         Height=30 Left=203 Top=26 Width=104 ForeColor=90,90,90
    *       Say7 "Produto" FontSize=13 Left=25 Top=4 ForeColor=90,90,90
    *       Say8 "Quantidade" FontSize=13 Left=201 Top=4 ForeColor=90,90,90
    *       CmdEnviaProd "\<Confirmar" Top=58 Left=203 W=104 H=29
    *         Visible=.F. Picture=b_print2.bmp PicturePosition=1
    *   Cnt_Subtotal (Top=266 Left=7 W=360 H=46 BorderWidth=1 SpecialEffect=2
    *     BackColor=255,255,255):
    *       Get_valor Alignment=3 Value=0 FontSize=15 InputMask=
    *         "9,999,999.99" Height=28 Left=160 Top=8 Width=161
    *         ForeColor=90,90,90
    *       Say11 "Valor Unit?rio" FontSize=13 Left=37 Top=11 ForeColor=90,90,90
    *   Cnt_Desconto (Top=106 Left=7 W=360 H=154 BackStyle=1 BorderWidth=1
    *     SpecialEffect=2 BackColor=255,255,255):
    *       Get_unival ("Original") InputMask="9999,999.99" Left=160 Top=4
    *         Width=161 Height=28
    *       Say12 "Original" Left=87 Top=6
    *       Get_pvaldesc ("% Desconto") InputMask="99.99" Left=160 Top=33
    *         Width=161 Height=28
    *       Label1 "(%)" Left=324 Top=40 Width=26
    *       Get_valdesc ("$ Desconto") InputMask="999,999.99" Left=160 Top=62
    *         Width=161 Height=28
    *       Say15 "Desconto" Left=73 Top=36
    *       Label2 "($)" Left=324 Top=67 Width=20
    *       get_pValAcre ("% Acrescimo") InputMask="99.99" Left=160 Top=91
    *         Width=161 Height=28
    *       Label4 "(%)" Left=324 Top=97 Width=26
    *       Get_ValAcre ("$ Acrescimo") InputMask="999,999.99" Left=160
    *         Top=120 Width=161 Height=28
    *       Say1 "Acrescimo" Left=66 Top=94
    *       Label3 "($)" Left=324 Top=126 Width=20
    *       (todos os Get_* deste bloco: Alignment=3 Value=0 FontBold=.T.
    *       FontName="Tahoma" FontSize=15 ForeColor=90,90,90)
    *   Proximo Top=370 Left=323 W=45 H=45 Picture=b_arrow2.bmp
    *   Say8 (filho direto de CntItem) "TOTAL" FontSize=25 Left=61 Top=330
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposItem()
        LOCAL loc_cIcones, loc_oCnt, loc_oSub
        loc_cIcones = gc_4c_CaminhoIcones
        loc_oCnt    = THIS.cnt_4c_Item

        loc_oCnt.AddObject("txt_4c_Total", "TextBox")
        WITH loc_oCnt.txt_4c_Total
            .Top           = 369
            .Left          = 62
            .Width         = 249
            .Height        = 46
            .FontBold      = .T.
            .FontName      = "Verdana"
            .FontSize      = 22
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "9,999,999.99"
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- Cnt_Produto: codigo do produto + quantidade.
        loc_oCnt.AddObject("cnt_4c__Produto", "Container")
        loc_oSub = loc_oCnt.cnt_4c__Produto
        WITH loc_oSub
            .Top           = 8
            .Left          = 7
            .Width         = 360
            .Height        = 92
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Produto", "TextBox")
        WITH loc_oSub.txt_4c_Produto
            .Top       = 26
            .Left      = 24
            .Width     = 178
            .Height    = 30
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Format    = "K!"
            .InputMask = "!!!!!!!!!!!!!!"
            .MaxLength = 14
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Qtds", "TextBox")
        WITH loc_oSub.txt_4c_Qtds
            .Top       = 26
            .Left      = 203
            .Width     = 104
            .Height    = 30
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Alignment = 3
            .Value     = 0
            .InputMask = "999.999"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oSub.lbl_4c_Label7
            .Top       = 4
            .Left      = 25
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 13
            .Caption   = "Produto"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oSub.lbl_4c_Label8
            .Top       = 4
            .Left      = 201
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 13
            .Caption   = "Quantidade"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- CmdEnviaProd: so aparece quando o legado exige confirmacao manual
        *-- do produto identificado por codigo de barras (leitura ambigua) -
        *-- nasce oculto, como no dump, e entra na skip-list de
        *-- TornarControlesVisiveis.
        loc_oSub.AddObject("cmd_4c_CmdEnviaProd", "CommandButton")
        WITH loc_oSub.cmd_4c_CmdEnviaProd
            .Top             = 58
            .Left            = 203
            .Width           = 104
            .Height          = 29
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Picture         = loc_cIcones + "b_print2.bmp"
            .Caption         = "\<Confirmar"
            .ToolTipText     = "Confirma o Produto Informado"
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .F.
        ENDWITH

        *-- Cnt_Subtotal: valor unitario do item (subtotal antes de
        *-- desconto/acrescimo).
        loc_oCnt.AddObject("cnt_4c__Subtotal", "Container")
        loc_oSub = loc_oCnt.cnt_4c__Subtotal
        WITH loc_oSub
            .Top           = 266
            .Left          = 7
            .Width         = 360
            .Height        = 46
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oSub.txt_4c_Valor
            .Top       = 8
            .Left      = 160
            .Width     = 161
            .Height    = 28
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Alignment = 3
            .Value     = 0
            .InputMask = "9,999,999.99"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oSub.lbl_4c_Label11
            .Top       = 11
            .Left      = 37
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 13
            .Caption   = "Valor Unit" + CHR(225) + "rio"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Cnt_Desconto: bloco Original / Desconto / Acrescimo, cada um com
        *-- percentual e valor.
        loc_oCnt.AddObject("cnt_4c__Desconto", "Container")
        loc_oSub = loc_oCnt.cnt_4c__Desconto
        WITH loc_oSub
            .Top           = 106
            .Left          = 7
            .Width         = 360
            .Height        = 154
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Unival", "TextBox")
        WITH loc_oSub.txt_4c_Unival
            .Top       = 4
            .Left      = 160
            .Width     = 161
            .Height    = 28
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Alignment = 3
            .Value     = 0
            .InputMask = "9999,999.99"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oSub.lbl_4c_Label12
            .Top       = 6
            .Left      = 87
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 13
            .Caption   = "Original"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Pvaldesc", "TextBox")
        WITH loc_oSub.txt_4c_Pvaldesc
            .Top       = 33
            .Left      = 160
            .Width     = 161
            .Height    = 28
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Alignment = 3
            .Value     = 0
            .InputMask = "99.99"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oSub.lbl_4c_Label1
            .Top       = 40
            .Left      = 324
            .Width     = 26
            .Height    = 16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .Caption   = "(%)"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Valdesc", "TextBox")
        WITH loc_oSub.txt_4c_Valdesc
            .Top       = 62
            .Left      = 160
            .Width     = 161
            .Height    = 28
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Alignment = 3
            .Value     = 0
            .InputMask = "999,999.99"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oSub.lbl_4c_Label15
            .Top       = 36
            .Left      = 73
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 13
            .Caption   = "Desconto"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oSub.lbl_4c_Label2
            .Top       = 67
            .Left      = 324
            .Width     = 20
            .Height    = 16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .Caption   = "($)"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c__pValAcre", "TextBox")
        WITH loc_oSub.txt_4c__pValAcre
            .Top       = 91
            .Left      = 160
            .Width     = 161
            .Height    = 28
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Alignment = 3
            .Value     = 0
            .InputMask = "99.99"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oSub.lbl_4c_Label4
            .Top       = 97
            .Left      = 324
            .Width     = 26
            .Height    = 16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .Caption   = "(%)"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_ValAcre", "TextBox")
        WITH loc_oSub.txt_4c_ValAcre
            .Top       = 120
            .Left      = 160
            .Width     = 161
            .Height    = 28
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 15
            .Alignment = 3
            .Value     = 0
            .InputMask = "999,999.99"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oSub.lbl_4c_Say1
            .Top       = 94
            .Left      = 66
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 13
            .Caption   = "Acr" + CHR(233) + "scimo"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oSub.lbl_4c_Label3
            .Top       = 126
            .Left      = 324
            .Width     = 20
            .Height    = 16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .Caption   = "($)"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Proximo: avanca para a tela de pagamento.
        loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH loc_oCnt.cmd_4c_Proximo
            .Top           = 370
            .Left          = 323
            .Width         = 45
            .Height        = 45
            .FontName      = "Verdana"
            .FontSize      = 8
            .Picture       = loc_cIcones + "b_arrow2.bmp"
            .Caption       = ""
            .ToolTipText   = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
            .SpecialEffect = 0
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- "TOTAL" (filho direto de CntItem - ver nota da colisao no
        *-- cabecalho deste metodo).
        loc_oCnt.AddObject("lbl_4c_Total", "Label")
        WITH loc_oCnt.lbl_4c_Total
            .Top       = 330
            .Left      = 61
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 25
            .Caption   = "TOTAL"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFinanc - conteudo do painel de crediario / codigos de
    * barras do carne (cnt_4c_Financ, container oculto - acionado por
    * cmd_4c_Financia nas Fases 7-8). A grade e os tres botoes de acao
    * (cnt_4c__GrdBarra) ja foram criados em ConfigurarGradesOperacao; aqui vao
    * o restante: a faixa divisoria, o par de campos de codigo de barras e o
    * total do carne.
    * Original (dump slim.txt, SIGMVITN.CntFinanc.*):
    *   Shape4 Top=349 Left=0 H=3 W=370 SpecialEffect=0
    *   Cnt_Barras (Top=57 Left=4 W=368 H=125 BackStyle=1 BorderWidth=1
    *     SpecialEffect=2 BackColor=255,255,255):
    *       Image1/Image2 Picture=b_arrow2.bmp BackStyle=0 H=25 W=25
    *         (Image1 Left=14 Top=34; Image2 Left=12 Top=94)
    *       Say2 "Primeiro C?digo de Barras" FontSize=15 Left=39 Top=6
    *       Say3 "Segundo C?digo de Barras" FontSize=15 Left=39 Top=65
    *       Get_Barra_1/Get_Barra_2 FontSize=15 H=30 Left=38 SpecialEffect=1
    *         W=240 DisabledBackColor=128,128,128 (Barra_1 Top=31; Barra_2
    *         Top=91)
    *   Proximo Top=353 Left=320 W=45 H=45 Picture=b_arrow2.bmp
    *   Label1 "Credi" + CHR(225) + "rio" AutoSize=.T. FontSize=16 Height=27
    *     Left=134 Top=11 Width=97
    *   Say2 "Total" FontSize=20 Left=8 Top=360 (filho direto de CntFinanc,
    *     distinto do Say2 de dentro de Cnt_Barras - containers diferentes,
    *     sem colisao de nome)
    *   Get_total Alignment=3 Value=0 FontSize=20 InputMask="9,999,999.99"
    *     Height=45 Left=92 SpecialEffect=1 Top=354 Width=218
    *     BackColor=188,225,245. NAO recebe o ControlSource="TprMvCab.ValInis"
    *     do legado - TprMvCab e o cursor de cabecalho do form PAI, fora de
    *     alcance com DataSession=2 isolado (mesma decisao das Fases 1-4); o
    *     valor e populado por evento nas Fases 7-8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFinanc()
        LOCAL loc_cIcones, loc_oCnt, loc_oSub
        loc_cIcones = gc_4c_CaminhoIcones
        loc_oCnt    = THIS.cnt_4c_Financ

        loc_oCnt.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oCnt.shp_4c_Shape4
            .Top           = 349
            .Left          = 0
            .Width         = 370
            .Height        = 3
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("cnt_4c__Barras", "Container")
        loc_oSub = loc_oCnt.cnt_4c__Barras
        WITH loc_oSub
            .Top           = 57
            .Left          = 4
            .Width         = 368
            .Height        = 125
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("img_4c_Image1", "Image")
        WITH loc_oSub.img_4c_Image1
            .Top       = 34
            .Left      = 14
            .Width     = 25
            .Height    = 25
            .Picture   = loc_cIcones + "b_arrow2.bmp"
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("img_4c_Image2", "Image")
        WITH loc_oSub.img_4c_Image2
            .Top       = 94
            .Left      = 12
            .Width     = 25
            .Height    = 25
            .Picture   = loc_cIcones + "b_arrow2.bmp"
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oSub.lbl_4c_Label2
            .Top      = 6
            .Left     = 39
            .FontBold = .T.
            .FontSize = 15
            .Caption  = "Primeiro C" + CHR(243) + "digo de Barras"
            .Visible  = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oSub.lbl_4c_Label3
            .Top      = 65
            .Left     = 39
            .FontBold = .T.
            .FontSize = 15
            .Caption  = "Segundo C" + CHR(243) + "digo de Barras"
            .Visible  = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Barra_1", "TextBox")
        WITH loc_oSub.txt_4c_Barra_1
            .Top               = 31
            .Left              = 38
            .Width             = 240
            .Height            = 30
            .FontBold          = .T.
            .FontSize          = 15
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(128, 128, 128)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Barra_2", "TextBox")
        WITH loc_oSub.txt_4c_Barra_2
            .Top               = 91
            .Left              = 38
            .Width             = 240
            .Height            = 30
            .FontBold          = .T.
            .FontSize          = 15
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(128, 128, 128)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH loc_oCnt.cmd_4c_Proximo
            .Top           = 353
            .Left          = 320
            .Width         = 45
            .Height        = 45
            .FontName      = "Verdana"
            .FontSize      = 8
            .Picture       = loc_cIcones + "b_arrow2.bmp"
            .Caption       = ""
            .SpecialEffect = 0
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top       = 11
            .Left      = 134
            .Width     = 97
            .Height    = 27
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .BackStyle = 0
            .Caption   = "Credi" + CHR(225) + "rio"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top      = 360
            .Left     = 8
            .FontBold = .T.
            .FontSize = 20
            .Caption  = "Total"
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Total", "TextBox")
        WITH loc_oCnt.txt_4c_Total
            .Top           = 354
            .Left          = 92
            .Width         = 218
            .Height        = 45
            .FontBold      = .T.
            .FontSize      = 20
            .Alignment     = 3
            .Value         = 0
            .InputMask     = "9,999,999.99"
            .SpecialEffect = 1
            .BackColor     = RGB(188, 225, 245)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * FASE 6/8: SEGUNDA METADE DOS CAMPOS DE DADOS + LOOKUPS
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarCamposParte2 - orquestrador da segunda metade (ver cabecalho do
    * arquivo). Preenche Cnt_Credito/Cnt_Pendencia (labels remanescentes),
    * Cnt_Identifica (COMPLETO, com todos os lookups Grupo/Conta/Cpf) e
    * Cnt_Fpagto (COMPLETO, incluindo Cnt_ChequepreTef.Cnt_Chq) + cmbTOpers.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposParte2()
        THIS.ConfigurarCamposCreditoPendencia()
        THIS.ConfigurarCamposIdentifica()
        THIS.ConfigurarCamposFpagto()
        THIS.ConfigurarComboOperacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposCreditoPendencia - labels/botoes remanescentes de
    * Cnt_Credito e Cnt_Pendencia. As grades (grd_4c_Devolucao/grd_4c_SubNiveis)
    * e o cmd_4c_BotPend ja foram criados na Fase 4
    * (ConfigurarGradesOperacao) - aqui so falta o botao "Proximo" (navegacao
    * ENTER) e o label de instrucao de cada container.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposCreditoPendencia()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.cnt_4c__Credito.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH THIS.cnt_4c__Credito.cmd_4c_Proximo
            .Top         = 394
            .Left        = 325
            .Width       = 45
            .Height      = 45
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = loc_cIcones + "b_arrow2.bmp"
            .Caption     = ""
            .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c__Credito.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Credito.lbl_4c_Label2
            .Top       = 422
            .Left      = 194
            .Width     = 135
            .Height    = 16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .Caption   = "[ENTER] Muda de Tela"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c__Pendencia.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH THIS.cnt_4c__Pendencia.cmd_4c_Proximo
            .Top         = 382
            .Left        = 311
            .Width       = 45
            .Height      = 45
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = loc_cIcones + "b_arrow2.bmp"
            .Caption     = ""
            .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c__Pendencia.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.cnt_4c__Pendencia.lbl_4c_Label2
            .Top       = 413
            .Left      = 168
            .Width     = 135
            .Height    = 16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .Caption   = "[ENTER] Muda de Tela"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposIdentifica - Cnt_Identifica (F6 Identif): identificacao
    * das contas Destino/Responsavel/Vendedor/Origem da movimentacao, a tabela
    * de desconto/lista de preco e o numero do documento. Os QUATRO blocos de
    * conta (Destino/Responsavel/Vendedor/Origem) tem a MESMA estrutura
    * Grupo+Conta+Nome+Cpf (layout.json) - cada um em seu proprio container
    * filho, sem colisao de nome (CLAUDE.md #11).
    *
    * LOOKUPS (originais fAcessoContab/fAcessoContas/fwBuscaExt - PROIBIDOS de
    * usar direto, CLAUDE.md "fAcessoContas() lookup UX" e "fAcessoEmpresa()
    * NAO EXISTE"): substituidos pelo padrao canonico FormBuscaAuxiliar
    * (CLAUDE.md #36/#37) via os metodos AbrirLookupGrupo/AbrirLookupConta,
    * acionados em ENTER/TAB/F4 (BINDEVENT "KeyPress" - CLAUDE.md #84, Valid
    * nao dispara em TextBox). Grupo -> SigCdGcr (codigos/descrs). Conta ->
    * SigCdCli (iclis/rclis/cpfs/grupos - NAO grclis, CLAUDE.md regra
    * "SigCdCli tem coluna grupos, nao grclis"), filtrada pelo Grupo quando
    * preenchido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposIdentifica()
        LOCAL loc_oCnt, loc_oSub

        loc_oCnt = THIS.cnt_4c__Identifica

        *======================================================================
        * Destino
        *======================================================================
        loc_oCnt.AddObject("cnt_4c_Destino", "Container")
        loc_oSub = loc_oCnt.cnt_4c_Destino
        WITH loc_oSub
            .Top           = 168
            .Left          = 2
            .Width         = 371
            .Height        = 94
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 4
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oSub.lbl_4c_Label4
            .Top       = 2
            .Left      = 10
            .Width     = 45
            .Height    = 15
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Destino"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 26
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lin_4c_Line1", "Line")
        WITH loc_oSub.lin_4c_Line1
            .Top         = 17
            .Left        = 10
            .Width       = 323
            .Height      = 0
            .BorderWidth = 2
            .Visible     = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oSub.lbl_4c_Label8
            .Top       = 18
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oSub.lbl_4c_Label2
            .Top       = 18
            .Left      = 93
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Conta"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c__CPF", "Label")
        WITH loc_oSub.lbl_4c__CPF
            .Top       = 18
            .Left      = 176
            .Width     = 56
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CPF / CNPJ"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c__dConta", "Label")
        WITH loc_oSub.lbl_4c__dConta
            .Top       = 51
            .Left      = 10
            .Width     = 29
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Nome"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 6
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oSub.txt_4c_Grupo
            .Top               = 32
            .Left              = 10
            .Width             = 80
            .Height            = 21
            .FontBold          = .T.
            .FontName          = "Tahoma"
            .Alignment         = 1
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 1
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oSub.txt_4c_Conta
            .Top               = 32
            .Left              = 93
            .Width             = 80
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 2
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oSub.txt_4c_Dconta
            .Top               = 65
            .Left              = 10
            .Width             = 304
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 4
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oSub.txt_4c_Cpf
            .Top               = 32
            .Left              = 176
            .Width             = 139
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 3
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("cmd_4c_BtnCadastros", "CommandButton")
        WITH loc_oSub.cmd_4c_BtnCadastros
            .Top           = 56
            .Left          = 325
            .Width         = 34
            .Height        = 32
            .FontName      = "Tahoma"
            .FontSize      = 7
            .Picture       = gc_4c_CaminhoIcones + "binder03.ico"
            .Caption       = ""
            .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
            .SpecialEffect = 2
            .ForeColor     = RGB(90, 90, 90)
            .TabIndex      = 5
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpDestinoKeyPress")
        BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaDestinoKeyPress")
        BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctDestinoKeyPress")
        BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfDestinoKeyPress")

        *======================================================================
        * Responsavel
        *======================================================================
        loc_oCnt.AddObject("cnt_4c_Responsavel", "Container")
        loc_oSub = loc_oCnt.cnt_4c_Responsavel
        WITH loc_oSub
            .Top           = 356
            .Left          = 2
            .Width         = 371
            .Height        = 94
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 6
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label42", "Label")
        WITH loc_oSub.lbl_4c_label42
            .Top       = 2
            .Left      = 10
            .Width     = 74
            .Height    = 15
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Respons" + CHR(225) + "vel"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 26
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lin_4c_line12", "Line")
        WITH loc_oSub.lin_4c_line12
            .Top         = 17
            .Left        = 10
            .Width       = 320
            .Height      = 0
            .BorderWidth = 2
            .Visible     = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label82", "Label")
        WITH loc_oSub.lbl_4c_label82
            .Top       = 18
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label22", "Label")
        WITH loc_oSub.lbl_4c_label22
            .Top       = 18
            .Left      = 93
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Conta"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 6
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c__cpf2", "Label")
        WITH loc_oSub.lbl_4c__cpf2
            .Top       = 18
            .Left      = 176
            .Width     = 56
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CPF / CNPJ"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c__dconta2", "Label")
        WITH loc_oSub.lbl_4c__dconta2
            .Top       = 51
            .Left      = 10
            .Width     = 29
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Nome"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_grupo2", "TextBox")
        WITH loc_oSub.txt_4c_grupo2
            .Top               = 32
            .Left              = 10
            .Width             = 80
            .Height            = 21
            .FontBold          = .T.
            .FontName          = "Tahoma"
            .Alignment         = 1
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 1
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_conta2", "TextBox")
        WITH loc_oSub.txt_4c_conta2
            .Top               = 32
            .Left              = 93
            .Width             = 80
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 2
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_dconta2", "TextBox")
        WITH loc_oSub.txt_4c_dconta2
            .Top               = 65
            .Left              = 10
            .Width             = 305
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 4
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_cpf2", "TextBox")
        WITH loc_oSub.txt_4c_cpf2
            .Top               = 32
            .Left              = 176
            .Width             = 139
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 3
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        BINDEVENT(loc_oSub.txt_4c_grupo2, "KeyPress", THIS, "GrpRespKeyPress")
        BINDEVENT(loc_oSub.txt_4c_conta2, "KeyPress", THIS, "CtaRespKeyPress")
        BINDEVENT(loc_oSub.txt_4c_dconta2, "KeyPress", THIS, "DctRespKeyPress")
        BINDEVENT(loc_oSub.txt_4c_cpf2, "KeyPress", THIS, "CpfRespKeyPress")

        *======================================================================
        * Vendedor
        *======================================================================
        loc_oCnt.AddObject("cnt_4c_Vendedor", "Container")
        loc_oSub = loc_oCnt.cnt_4c_Vendedor
        WITH loc_oSub
            .Top           = 262
            .Left          = 2
            .Width         = 371
            .Height        = 94
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 5
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label43", "Label")
        WITH loc_oSub.lbl_4c_label43
            .Top       = 2
            .Left      = 10
            .Width     = 56
            .Height    = 15
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Vendedor"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 26
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lin_4c_line13", "Line")
        WITH loc_oSub.lin_4c_line13
            .Top         = 17
            .Left        = 10
            .Width       = 315
            .Height      = 0
            .BorderWidth = 2
            .Visible     = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label83", "Label")
        WITH loc_oSub.lbl_4c_label83
            .Top       = 18
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label23", "Label")
        WITH loc_oSub.lbl_4c_label23
            .Top       = 18
            .Left      = 93
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Conta"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c__cpf3", "Label")
        WITH loc_oSub.lbl_4c__cpf3
            .Top       = 18
            .Left      = 176
            .Width     = 56
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CPF / CNPJ"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c__dconta3", "Label")
        WITH loc_oSub.lbl_4c__dconta3
            .Top       = 51
            .Left      = 10
            .Width     = 29
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Nome"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 6
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_grupo3", "TextBox")
        WITH loc_oSub.txt_4c_grupo3
            .Top               = 32
            .Left              = 10
            .Width             = 80
            .Height            = 21
            .FontBold          = .T.
            .FontName          = "Tahoma"
            .Alignment         = 1
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 1
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_conta3", "TextBox")
        WITH loc_oSub.txt_4c_conta3
            .Top               = 32
            .Left              = 93
            .Width             = 80
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 2
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_dconta3", "TextBox")
        WITH loc_oSub.txt_4c_dconta3
            .Top               = 65
            .Left              = 10
            .Width             = 304
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 4
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_cpf3", "TextBox")
        WITH loc_oSub.txt_4c_cpf3
            .Top               = 32
            .Left              = 176
            .Width             = 139
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 3
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        BINDEVENT(loc_oSub.txt_4c_grupo3, "KeyPress", THIS, "GrpVendKeyPress")
        BINDEVENT(loc_oSub.txt_4c_conta3, "KeyPress", THIS, "CtaVendKeyPress")
        BINDEVENT(loc_oSub.txt_4c_dconta3, "KeyPress", THIS, "DctVendKeyPress")
        BINDEVENT(loc_oSub.txt_4c_cpf3, "KeyPress", THIS, "CpfVendKeyPress")

        *======================================================================
        * TabDesconto
        *======================================================================
        loc_oCnt.AddObject("cnt_4c_TabDesconto", "Container")
        loc_oSub = loc_oCnt.cnt_4c_TabDesconto
        WITH loc_oSub
            .Top           = 33
            .Left          = 2
            .Width         = 371
            .Height        = 41
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oSub.lbl_4c_Label1
            .Top       = 4
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Tab. Desconto"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Tabd", "TextBox")
        WITH loc_oSub.txt_4c_Tabd
            .Top           = 18
            .Left          = 10
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .Margin        = 0
            .SpecialEffect = 1
            .TabIndex      = 1
            .ForeColor     = RGB(90, 90, 90)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_ListaPreco", "TextBox")
        WITH loc_oSub.txt_4c_ListaPreco
            .Top           = 17
            .Left          = 123
            .Width         = 220
            .Height        = 20
            .FontName      = "Tahoma"
            .Format        = "K"
            .Margin        = 0
            .MaxLength     = 30
            .SpecialEffect = 1
            .TabIndex      = 2
            .ForeColor     = RGB(90, 90, 90)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c__ListaPreco", "Label")
        WITH loc_oSub.lbl_4c__ListaPreco
            .Top       = 5
            .Left      = 124
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Lista de Pre" + CHR(231) + "os"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oSub.txt_4c_Tabd, "KeyPress", THIS, "TabdKeyPress")
        BINDEVENT(loc_oSub.txt_4c_ListaPreco, "KeyPress", THIS, "ListaPrecoKeyPress")

        *======================================================================
        * CodOperacao
        *======================================================================
        loc_oCnt.AddObject("cnt_4c_CodOperacao", "Container")
        loc_oSub = loc_oCnt.cnt_4c_CodOperacao
        WITH loc_oSub
            .Top           = 2
            .Left          = 2
            .Width         = 371
            .Height        = 31
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 2
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label12", "Label")
        WITH loc_oSub.lbl_4c_label12
            .Top       = 8
            .Left      = 9
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Documento : "
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oSub.txt_4c_Codigo
            .Top           = 4
            .Left          = 94
            .Width         = 61
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 10
            .MaxLength     = 6
            .SpecialEffect = 1
            .TabIndex      = 1
            .ForeColor     = RGB(90, 90, 90)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label24", "Label")
        WITH loc_oSub.lbl_4c_label24
            .Top       = 8
            .Left      = 160
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Pedido Cliente: "
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_PedCli", "TextBox")
        WITH loc_oSub.txt_4c_PedCli
            .Top           = 4
            .Left          = 260
            .Width         = 80
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 10
            .SpecialEffect = 1
            .TabIndex      = 1
            .ToolTipText   = "Entrar com o numero da NF manual."
            .ForeColor     = RGB(90, 90, 90)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * Origem
        *======================================================================
        loc_oCnt.AddObject("cnt_4c_Origem", "Container")
        loc_oSub = loc_oCnt.cnt_4c_Origem
        WITH loc_oSub
            .Top           = 74
            .Left          = 2
            .Width         = 371
            .Height        = 94
            .BackStyle     = 1
            .BorderWidth   = 1
            .SpecialEffect = 2
            .TabIndex      = 3
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label44", "Label")
        WITH loc_oSub.lbl_4c_label44
            .Top       = 2
            .Left      = 10
            .Width     = 43
            .Height    = 15
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Origem"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 26
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lin_4c_line14", "Line")
        WITH loc_oSub.lin_4c_line14
            .Top         = 17
            .Left        = 10
            .Width       = 321
            .Height      = 0
            .BorderWidth = 2
            .Visible     = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label84", "Label")
        WITH loc_oSub.lbl_4c_label84
            .Top       = 18
            .Left      = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label25", "Label")
        WITH loc_oSub.lbl_4c_label25
            .Top       = 18
            .Left      = 93
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Conta"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say3 e o label REAL de "CPF / CNPJ" no legado (Say_CPF de Origem e
        *-- um placeholder degenerado com Caption=" " - nao tem conteudo nem
        *-- funcao visual e foi omitido).
        loc_oSub.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oSub.lbl_4c_Label3
            .Top       = 18
            .Left      = 176
            .Width     = 56
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CPF / CNPJ"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 10
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c__dconta4", "Label")
        WITH loc_oSub.lbl_4c__dconta4
            .Top       = 51
            .Left      = 10
            .Width     = 29
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Nome"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_grupo4", "TextBox")
        WITH loc_oSub.txt_4c_grupo4
            .Top               = 32
            .Left              = 10
            .Width             = 80
            .Height            = 21
            .FontBold          = .T.
            .FontName          = "Tahoma"
            .Alignment         = 1
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 1
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_conta4", "TextBox")
        WITH loc_oSub.txt_4c_conta4
            .Top               = 32
            .Left              = 93
            .Width             = 80
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 2
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_dconta4", "TextBox")
        WITH loc_oSub.txt_4c_dconta4
            .Top               = 65
            .Left              = 10
            .Width             = 304
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 4
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_cpf4", "TextBox")
        WITH loc_oSub.txt_4c_cpf4
            .Top               = 32
            .Left              = 176
            .Width             = 139
            .Height            = 21
            .FontName          = "Tahoma"
            .Margin            = 0
            .SpecialEffect     = 1
            .TabIndex          = 3
            .ForeColor         = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("cmd_4c_btncadastros2", "CommandButton")
        WITH loc_oSub.cmd_4c_btncadastros2
            .Top           = 52
            .Left          = 325
            .Width         = 34
            .Height        = 32
            .FontSize      = 7
            .Picture       = gc_4c_CaminhoIcones + "binder03.ico"
            .Caption       = ""
            .ToolTipText   = "<F2> Acessa o Cadastro Desta Conta"
            .SpecialEffect = 2
            .TabIndex      = 6
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oSub.txt_4c_grupo4, "KeyPress", THIS, "GrpOrigKeyPress")
        BINDEVENT(loc_oSub.txt_4c_conta4, "KeyPress", THIS, "CtaOrigKeyPress")
        BINDEVENT(loc_oSub.txt_4c_dconta4, "KeyPress", THIS, "DctOrigKeyPress")
        BINDEVENT(loc_oSub.txt_4c_cpf4, "KeyPress", THIS, "CpfOrigKeyPress")

        *======================================================================
        * Proximo (navegacao ENTER, filho direto de Cnt_Identifica)
        *======================================================================
        loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH loc_oCnt.cmd_4c_Proximo
            .Top         = 400
            .Left        = 324
            .Width       = 45
            .Height      = 45
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "b_arrow2.bmp"
            .Caption     = ""
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFpagto - Cnt_Fpagto (F11 Pagto): forma de pagamento,
    * parcelamento, vencimento, acrescimo/desconto e o painel de conferencia
    * de cheque pre-datado/TEF (Cnt_ChequepreTef.Cnt_Chq). O container
    * cnt_4c__ChequepreTef e o grd_4c_Parcelas ja foram criados na Fase 4
    * (ConfigurarGradesOperacao) - aqui so falta o Cnt_Chq interno.
    *
    * LOOKUP: Get_fpg (forma de pagamento, original CreateObject('fwBuscaSel',
    * 'ccSigOpFp', 'FPags', ...)) -> SigOpFp (fpags/descrs/fparcs), mesmo
    * padrao FormBuscaAuxiliar dos demais lookups deste form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFpagto()
        LOCAL loc_oCnt, loc_oSub, loc_oChq

        loc_oCnt = THIS.cnt_4c__Fpagto

        *======================================================================
        * Acrescimo (Visible=.F. no legado - so aparece via Barra_Botoes.
        * Acrescimo, Click e evento de Fase 7-8)
        *======================================================================
        loc_oCnt.AddObject("cnt_4c_Acrescimo", "Container")
        loc_oSub = loc_oCnt.cnt_4c_Acrescimo
        WITH loc_oSub
            .Top         = 31
            .Left        = 17
            .Width       = 303
            .Height      = 52
            .BackStyle   = 1
            .BorderWidth = 1
            .TabIndex    = 3
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .F.
        ENDWITH

        loc_oSub.AddObject("txt_4c_TotVariacao", "TextBox")
        WITH loc_oSub.txt_4c_TotVariacao
            .Top           = 25
            .Left          = 117
            .Width         = 185
            .Height        = 24
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Margin        = 0
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .TabIndex      = 43
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oSub.lbl_4c_Label20
            .Top       = 1
            .Left      = 8
            .Width     = 85
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Acr" + CHR(233) + "scimo:"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 55
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_PorcVariacao", "TextBox")
        WITH loc_oSub.txt_4c_PorcVariacao
            .Top           = 0
            .Left          = 178
            .Width         = 124
            .Height        = 24
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Margin        = 0
            .InputMask     = "9999.9999"
            .SpecialEffect = 1
            .TabIndex      = 42
            .ForeColor     = RGB(90, 90, 90)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oSub.lbl_4c_Label1
            .Top       = 4
            .Left      = 96
            .Width     = 25
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "(%)"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oSub.lbl_4c_Label2
            .Top       = 29
            .Left      = 96
            .Width     = 19
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "($)"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * Desconto (Visible=.F. no legado)
        *======================================================================
        loc_oCnt.AddObject("cnt_4c_Desconto", "Container")
        loc_oSub = loc_oCnt.cnt_4c_Desconto
        WITH loc_oSub
            .Top         = 31
            .Left        = 17
            .Width       = 303
            .Height      = 52
            .BackStyle   = 1
            .BorderWidth = 1
            .TabIndex    = 2
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .F.
        ENDWITH

        loc_oSub.AddObject("txt_4c_totvariacao2", "TextBox")
        WITH loc_oSub.txt_4c_totvariacao2
            .Top           = 25
            .Left          = 116
            .Width         = 185
            .Height        = 24
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Margin        = 0
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .TabIndex      = 43
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label202", "Label")
        WITH loc_oSub.lbl_4c_label202
            .Top       = 1
            .Left      = 8
            .Width     = 78
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Desconto:"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 55
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_porcvariacao2", "TextBox")
        WITH loc_oSub.txt_4c_porcvariacao2
            .Top           = 0
            .Left          = 177
            .Width         = 124
            .Height        = 24
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Margin        = 0
            .InputMask     = "9999.9999"
            .SpecialEffect = 1
            .TabIndex      = 42
            .ForeColor     = RGB(90, 90, 90)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label12", "Label")
        WITH loc_oSub.lbl_4c_label12
            .Top       = 4
            .Left      = 89
            .Width     = 25
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "(%)"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label22", "Label")
        WITH loc_oSub.lbl_4c_label22
            .Top       = 28
            .Left      = 89
            .Width     = 19
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "($)"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * Campos soltos de Cnt_Fpagto (filhos diretos)
        *======================================================================
        loc_oCnt.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oCnt.lbl_4c_Label9
            .Top       = 339
            .Left      = 55
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .ForeColor = RGB(36, 84, 155)
            .TabIndex  = 16
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_OBS", "TextBox")
        WITH loc_oCnt.txt_4c_OBS
            .Top           = 337
            .Left          = 130
            .Width         = 150
            .Height        = 20
            .SpecialEffect = 1
            .TabIndex      = 12
            .BorderColor   = RGB(36, 84, 155)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Fpg", "TextBox")
        WITH loc_oCnt.txt_4c_Fpg
            .Top           = 191
            .Left          = 134
            .Width         = 185
            .Height        = 29
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .MaxLength     = 12
            .SpecialEffect = 1
            .TabIndex      = 8
            .ToolTipText   = "Condi" + CHR(231) + CHR(227) + "o de pagamento"
            .ForeColor     = RGB(90, 90, 90)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Npar", "TextBox")
        WITH loc_oCnt.txt_4c_Npar
            .Top           = 221
            .Left          = 134
            .Width         = 41
            .Height        = 29
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .InputMask     = "99"
            .SpecialEffect = 1
            .TabIndex      = 9
            .ToolTipText   = "N" + CHR(250) + "mero de Parcelas"
            .ForeColor     = RGB(90, 90, 90)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Vpar", "TextBox")
        WITH loc_oCnt.txt_4c_Vpar
            .Top           = 251
            .Left          = 134
            .Width         = 185
            .Height        = 29
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .TabIndex      = 10
            .ToolTipText   = "Valor de cada Parcela"
            .ForeColor     = RGB(90, 90, 90)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Fweditdata_venc", "TextBox")
        WITH loc_oCnt.txt_4c_Fweditdata_venc
            .Top           = 281
            .Left          = 134
            .Width         = 138
            .Height        = 29
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 15
            .SpecialEffect = 1
            .TabIndex      = 11
            .ToolTipText   = "Data de Vencimento"
            .ForeColor     = RGB(90, 90, 90)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oCnt.lbl_4c_Label23
            .Top       = 134
            .Left      = 34
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Pagamentos:"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 23
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oCnt.lbl_4c_Label15
            .Top       = 108
            .Left      = 40
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Saldo Final :"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 24
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oCnt.lbl_4c_Label24
            .Top       = 6
            .Left      = 77
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Total : "
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 17
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Valinic", "TextBox")
        WITH loc_oCnt.txt_4c_Valinic
            .Top           = 5
            .Left          = 134
            .Width         = 185
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Margin        = 0
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .TabIndex      = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oCnt.obj_4c_GetObs
            .Top           = 321
            .Left          = 2
            .Width         = 314
            .Height        = 38
            .SpecialEffect = 1
            .TabIndex      = 14
            .Visible       = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Obs", "Label")
        WITH loc_oCnt.lbl_4c_Obs
            .Top       = 308
            .Left      = 5
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 15
            .Visible   = .F.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TotLiquido", "TextBox")
        WITH loc_oCnt.txt_4c_TotLiquido
            .Top           = 107
            .Left          = 134
            .Width         = 185
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Margin        = 0
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .TabIndex      = 5
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Saldo", "TextBox")
        WITH loc_oCnt.txt_4c_Saldo
            .Top           = 159
            .Left          = 134
            .Width         = 185
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Format        = "K"
            .Margin        = 0
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .TabIndex      = 6
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TotForma", "TextBox")
        WITH loc_oCnt.txt_4c_TotForma
            .Top           = 133
            .Left          = 134
            .Width         = 185
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Format        = "K"
            .Margin        = 0
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .TabIndex      = 7
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top       = 160
            .Left      = 62
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "A Pagar :"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 22
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
        WITH loc_oCnt.cmd_4c_Proximo
            .Top         = 308
            .Left        = 324
            .Width       = 45
            .Height      = 45
            .FontName    = "Verdana"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "b_arrow1.bmp"
            .Caption     = ""
            .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
            .TabIndex    = 26
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top       = 82
            .Left      = 40
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Desc.Prom.:"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 25
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Tvariacao", "TextBox")
        WITH loc_oCnt.txt_4c_Tvariacao
            .Top           = 81
            .Left          = 134
            .Width         = 185
            .Height        = 25
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 14
            .Alignment     = 3
            .Margin        = 0
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .TabIndex      = 4
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oCnt.lbl_4c_Label18
            .Top       = 284
            .Left      = 33
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Vencimento :"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 21
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oCnt.lbl_4c_Label13
            .Top       = 224
            .Left      = 58
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Parcelas :"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 19
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oCnt.lbl_4c_Label17
            .Top       = 254
            .Left      = 82
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Valor :"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 20
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oCnt.lbl_4c_Label12
            .Top       = 194
            .Left      = 31
            .FontName  = "Tahoma"
            .FontSize  = 13
            .BackStyle = 0
            .Caption   = "Forma Pagto:"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 18
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oCnt.shp_4c_Shape4
            .Top           = 186
            .Left          = 2
            .Width         = 369
            .Height        = 2
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.txt_4c_Fpg, "KeyPress", THIS, "FpgKeyPress")

        *======================================================================
        * Cnt_ChequepreTef.Cnt_Chq - conferencia de cheque pre-datado/TEF
        *======================================================================
        loc_oChq = loc_oCnt.cnt_4c__ChequepreTef
        loc_oChq.AddObject("cnt_4c__Chq", "Container")
        loc_oSub = loc_oChq.cnt_4c__Chq
        WITH loc_oSub
            .Top         = 0
            .Left        = 0
            .Width       = 371
            .Height      = 60
            .BackStyle   = 1
            .BorderWidth = 1
            .SpecialEffect = 2
            .TabIndex    = 13
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .F.
        ENDWITH

        loc_oSub.AddObject("cmd_4c_TefChq", "CommandButton")
        WITH loc_oSub.cmd_4c_TefChq
            .Top         = 5
            .Left        = 259
            .Width       = 108
            .Height      = 20
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = "Consulta C\<heque"
            .TabIndex    = 12
            .TabStop     = .F.
            .ToolTipText = "Verifica e Confirma se a numera" + CHR(231) + CHR(227) + "o dos cheques est" + CHR(225) + " OK."
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        loc_oSub.AddObject("obj_4c_Opc_cpf", "OptionGroup")
        WITH loc_oSub.obj_4c_Opc_cpf
            .Top         = 5
            .Left        = 3
            .Width       = 108
            .Height      = 17
            .ButtonCount = 2
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .TabIndex    = 18
            .BorderColor = RGB(192, 192, 192)
            .Visible     = .T.
            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "CPF"
                .Height    = 17
                .Left      = 5
                .Top       = 1
                .Width     = 44
            ENDWITH
            WITH .Buttons(2)
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "CNPJ"
                .Left      = 57
                .Top       = 1
            ENDWITH
        ENDWITH

        loc_oSub.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oSub.txt_4c_Cpf
            .Top               = 4
            .Left              = 112
            .Width             = 140
            .Height            = 20
            .FontName          = "Tahoma"
            .Margin            = 0
            .MaxLength         = 20
            .SpecialEffect     = 1
            .TabIndex          = 1
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label23", "Label")
        WITH loc_oSub.lbl_4c_label23
            .Top       = 25
            .Left      = 40
            .FontName  = "Tahoma"
            .FontSize  = 7
            .Caption   = "Banco"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 14
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oSub.lbl_4c_Label3
            .Top       = 25
            .Left      = 72
            .FontName  = "Tahoma"
            .FontSize  = 7
            .Caption   = "Agencia  Dv"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 15
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oSub.lbl_4c_Label5
            .Top       = 25
            .Left      = 134
            .FontName  = "Tahoma"
            .FontSize  = 7
            .Caption   = "Conta                            Dv"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 17
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Age", "TextBox")
        WITH loc_oSub.txt_4c_Age
            .Top           = 36
            .Left          = 73
            .Width         = 36
            .Height        = 22
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .TabIndex      = 4
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Bco", "TextBox")
        WITH loc_oSub.txt_4c_Bco
            .Top           = 36
            .Left          = 40
            .Width         = 32
            .Height        = 22
            .FontName      = "Tahoma"
            .BackStyle     = 1
            .SpecialEffect = 1
            .TabIndex      = 3
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oSub.lbl_4c_Label4
            .Top       = 25
            .Left      = 241
            .FontName  = "Tahoma"
            .FontSize  = 7
            .Caption   = "N.Cheque     Dv"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 16
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Num", "TextBox")
        WITH loc_oSub.txt_4c_Num
            .Top           = 36
            .Left          = 237
            .Width         = 52
            .Height        = 22
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .TabIndex      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("lbl_4c_label13", "Label")
        WITH loc_oSub.lbl_4c_label13
            .Top       = 25
            .Left      = 5
            .FontName  = "Tahoma"
            .FontSize  = 7
            .Caption   = "Pca"
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 13
            .Visible   = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Pca", "TextBox")
        WITH loc_oSub.txt_4c_Pca
            .Top           = 36
            .Left          = 5
            .Width         = 34
            .Height        = 22
            .FontName      = "Tahoma"
            .BackStyle     = 1
            .MaxLength     = 34
            .SpecialEffect = 1
            .TabIndex      = 2
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Agendc", "TextBox")
        WITH loc_oSub.txt_4c_Agendc
            .Top           = 36
            .Left          = 110
            .Width         = 22
            .Height        = 22
            .FontName      = "Tahoma"
            .MaxLength     = 1
            .SpecialEffect = 1
            .TabIndex      = 5
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Contadc", "TextBox")
        WITH loc_oSub.txt_4c_Contadc
            .Top           = 36
            .Left          = 213
            .Width         = 23
            .Height        = 22
            .FontName      = "Tahoma"
            .MaxLength     = 1
            .SpecialEffect = 1
            .TabIndex      = 7
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Numdc", "TextBox")
        WITH loc_oSub.txt_4c_Numdc
            .Top           = 36
            .Left          = 290
            .Width         = 22
            .Height        = 22
            .FontName      = "Tahoma"
            .MaxLength     = 1
            .SpecialEffect = 1
            .TabIndex      = 9
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oSub.txt_4c_Conta
            .Top           = 36
            .Left          = 133
            .Width         = 79
            .Height        = 22
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .TabIndex      = 6
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oSub.AddObject("cmd_4c_Ins", "CommandButton")
        WITH loc_oSub.cmd_4c_Ins
            .Top         = 36
            .Left        = 330
            .Width       = 37
            .Height      = 22
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = "Ins"
            .Enabled     = .T.
            .TabIndex    = 10
            .TabStop     = .F.
            .ToolTipText = "insere a sequencia dos numeros dos cheques e mostra na grade"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarComboOperacao - cmbTOpers (troca rapida de operacao, disparado
    * pelo cmd_4c_MudaOpe da barra de botoes). Original RowSourceType=1
    * (Value); a lista de itens e populada em runtime (Fase 7-8, junto do
    * evento de Click de cmd_4c_MudaOpe que a alimenta) - aqui so a moldura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarComboOperacao()
        THIS.AddObject("cbo_4c_CmbTOpers", "ComboBox")
        WITH THIS.cbo_4c_CmbTOpers
            .Top            = 594
            .Left           = 39
            .Width          = 277
            .Height         = 22
            .FontName       = "Verdana"
            .RowSourceType  = 1
            .SpecialEffect  = 1
            .Visible        = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * LOOKUPS - Cnt_Identifica (Grupo/Conta) e Cnt_Fpagto (Forma de Pagamento)
    *
    * Substituem fAcessoContab/fAcessoContas/fwBuscaExt/fwBuscaSel do legado
    * (CLAUDE.md: fAcessoContas() PROIBIDO como handler de lookup UX -
    * auto-preenche com o primeiro match parcial sem selecao explicita).
    * Padrao canonico FormBuscaAuxiliar (CLAUDE.md #36/#37): o proprio Init ja
    * tenta o match EXATO e so mostra o picker se nao encontrar - por isso NAO
    * ha um SQLEXEC de pre-checagem aqui, so a chamada direta.
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Grupo de Contas (SigCdGcr.codigos/descrs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGrupo(par_oTxtGrupo)
        LOCAL loc_oBusca

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
            "cursor_4c_BuscaGrupo", "codigos", ALLTRIM(par_oTxtGrupo.Value), "Grupo de Contas")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                SELECT cursor_4c_BuscaGrupo
                par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Contas (SigCdCli.iclis/rclis/cpfs/grupos). Busca por
    * par_cCampoBusca ("iclis"/"rclis"/"cpfs" - o campo que o usuario digitou)
    * com par_cValorBusca; filtra por Grupo quando par_oTxtGrupo ja tem valor.
    * Preenche Conta+Nome+Cpf sempre; Grupo so se estava vazio (nao sobrescreve
    * filtro que o usuario ja escolheu).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupConta(par_oTxtConta, par_oTxtDconta, par_oTxtCpf, ;
            par_oTxtGrupo, par_cCampoBusca, par_cValorBusca)
        LOCAL loc_oBusca, loc_cFiltro

        loc_cFiltro = ""
        IF VARTYPE(par_oTxtGrupo) = "O" AND !EMPTY(ALLTRIM(par_oTxtGrupo.Value))
            loc_cFiltro = "grupos = " + EscaparSQL(PADR(ALLTRIM(par_oTxtGrupo.Value), 10))
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_BuscaConta", par_cCampoBusca, par_cValorBusca, "Contas", .F., .T., loc_cFiltro)

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.mAddColuna("cpfs",  "", "CPF" + CHR(47) + "CNPJ")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                SELECT cursor_4c_BuscaConta
                par_oTxtConta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                IF VARTYPE(par_oTxtDconta) = "O"
                    par_oTxtDconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
                ENDIF
                IF VARTYPE(par_oTxtCpf) = "O"
                    par_oTxtCpf.Value = ALLTRIM(cursor_4c_BuscaConta.cpfs)
                ENDIF
                IF VARTYPE(par_oTxtGrupo) = "O" AND EMPTY(ALLTRIM(par_oTxtGrupo.Value))
                    par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaConta.grupos)
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTabDesconto - Tabela de Desconto (SigOpTdz.codigos/descrs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupTabDesconto(par_oTxtTabd)
        LOCAL loc_oBusca

        IF USED("cursor_4c_BuscaTabd")
            USE IN cursor_4c_BuscaTabd
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpTdz", ;
            "cursor_4c_BuscaTabd", "codigos", ALLTRIM(par_oTxtTabd.Value), "Tabelas de Desconto")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
                SELECT cursor_4c_BuscaTabd
                par_oTxtTabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaTabd")
            USE IN cursor_4c_BuscaTabd
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupListaPreco - Listas de Preco (SigCdLpc.lprecos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupListaPreco(par_oTxtListaPreco)
        LOCAL loc_oBusca

        IF USED("cursor_4c_BuscaListaPreco")
            USE IN cursor_4c_BuscaListaPreco
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLpc", ;
            "cursor_4c_BuscaListaPreco", "lprecos", ALLTRIM(par_oTxtListaPreco.Value), "Listas de Pre" + CHR(231) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("lprecos", "", "Lista")
                loc_oBusca.mAddColuna("tipos",   "", "Tipo")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaListaPreco")
                SELECT cursor_4c_BuscaListaPreco
                par_oTxtListaPreco.Value = ALLTRIM(cursor_4c_BuscaListaPreco.lprecos)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaListaPreco")
            USE IN cursor_4c_BuscaListaPreco
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFormaPagamento - Forma de Pagamento (SigOpFp.fpags/descrs).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupFormaPagamento(par_oTxtFpg)
        LOCAL loc_oBusca

        IF USED("cursor_4c_BuscaFpg")
            USE IN cursor_4c_BuscaFpg
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpFp", ;
            "cursor_4c_BuscaFpg", "fpags", ALLTRIM(par_oTxtFpg.Value), "Forma de Pagamento")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("fpags",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("fparcs", "", "Parc")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
                SELECT cursor_4c_BuscaFpg
                par_oTxtFpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaFpg")
            USE IN cursor_4c_BuscaFpg
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 7/8 - EVENTOS PRINCIPAIS
    *
    * Liga os Click/KeyPress dos 17 CommandButtons da barra principal (Fase
    * 3), dos 4 botoes de acao das grades (Fase 4), dos paineis CancelaItem/
    * Consulta (Fase 5) e das setas "Proximo" de cada tela (Fases 5-6).
    *
    * Limite de escopo (arquitetura ja fixada nas Fases 1-6): DataSession=2
    * isola este form dos cursores globais do form de movimentacao pai
    * (crSigCdOpe, CrSigOpCdc, TprMvCab) e das rotinas dele (AcioSalva,
    * AcioCancela, Cancel_Item_Gen, AtuaTotal, VerStatus). Guardas do legado
    * que dependem so de CURSORES/PROPRIEDADES LOCAIS (crTpmMvItn, TmpOperacao,
    * TmpDevol, TmpBarFin, xPar, this_*) sao transcritos fielmente; os que
    * dependem de fiscal/TEF/senha de supervisor (impressora ECF, SigOpSen,
    * SigOpPen, SigMEFIS) nao tem como ser reproduzidos sem esse hardware/
    * modulo - documentados caso a caso, nunca silenciados.
    *
    * PUBLIC (sem PROTECTED) todos os handlers de evento: BINDEVENT so
    * funciona com metodos PUBLIC (CLAUDE.md #3).
    *==========================================================================

    *--------------------------------------------------------------------------
    * RegistrarEventosPrincipais - liga (BINDEVENT) todos os botoes/campos
    * desta fase. Chamado uma unica vez a partir de InicializarForm, depois
    * que TODOS os controles ja foram criados (Fases 3-6) - registrar contra
    * um controle inexistente estoura aqui dentro do TRY do InicializarForm.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventosPrincipais()
        LOCAL loc_oCnt

        *-- Barra de botoes principal.
        loc_oCnt = THIS.cnt_4c_Barra_Botoes
        BINDEVENT(loc_oCnt.cmd_4c_Itens,      "Click", THIS, "CmdItensClick")
        BINDEVENT(loc_oCnt.cmd_4c_Alteraqtd,  "Click", THIS, "CmdAlteraqtdClick")
        BINDEVENT(loc_oCnt.cmd_4c_Desconto,   "Click", THIS, "CmdDescontoClick")
        BINDEVENT(loc_oCnt.cmd_4c_Acrescimo,  "Click", THIS, "CmdAcrescimoClick")
        BINDEVENT(loc_oCnt.cmd_4c_CancPagto,  "Click", THIS, "CmdCancPagtoClick")
        BINDEVENT(loc_oCnt.cmd_4c_Apaga,      "Click", THIS, "CmdApagaClick")
        BINDEVENT(loc_oCnt.cmd_4c_AltPreco,   "Click", THIS, "CmdAltPrecoClick")
        BINDEVENT(loc_oCnt.cmd_4c_Identifica, "Click", THIS, "CmdIdentificaClick")
        BINDEVENT(loc_oCnt.cmd_4c_Credito,    "Click", THIS, "CmdCreditoClick")
        BINDEVENT(loc_oCnt.cmd_4c_Financia,   "Click", THIS, "CmdFinanciaClick")
        BINDEVENT(loc_oCnt.cmd_4c_Pendencia,  "Click", THIS, "CmdPendenciaClick")
        BINDEVENT(loc_oCnt.cmd_4c_VerPreco,   "Click", THIS, "CmdVerPrecoClick")
        BINDEVENT(loc_oCnt.cmd_4c_Impfiscal,  "Click", THIS, "CmdImpfiscalClick")
        BINDEVENT(loc_oCnt.cmd_4c_MudaOpe,    "Click", THIS, "CmdMudaOpeClick")
        BINDEVENT(loc_oCnt.cmd_4c_Pagto,      "Click", THIS, "CmdPagtoClick")
        BINDEVENT(loc_oCnt.cmd_4c_Ok,         "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")

        *-- Grade de codigos de barras do crediario (CntFinanc).
        loc_oCnt = THIS.cnt_4c_Financ.cnt_4c__GrdBarra
        BINDEVENT(loc_oCnt.cmd_4c_Inserir, "Click", THIS, "CmdInserirBarraClick")
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "CmdExcluirBarraClick")
        BINDEVENT(loc_oCnt.cmd_4c_OkBarra, "Click", THIS, "CmdOkBarraClick")

        *-- Sub-niveis/pendencias.
        BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_BotPendentes, "Click", THIS, "CmdBotPendentesClick")

        *-- Painel de cancelamento de item.
        BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_Ok,          "Click", THIS, "CancelaItemOkClick")
        BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_CancelaDisp, "Click", THIS, "CancelaItemCancelaDispClick")

        *-- Painel de consulta de preco.
        BINDEVENT(THIS.cnt_4c__Consulta.cmd_4c_Command1, "Click", THIS, "ConsultaCommand1Click")
        BINDEVENT(THIS.cnt_4c__Consulta.cmd_4c_Proximo,  "Click", THIS, "ConsultaProximoClick")
        BINDEVENT(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto, "KeyPress", THIS, "ConsultaProdutoKeyPress")

        *-- Setas "Proximo" de cada tela.
        BINDEVENT(THIS.cnt_4c_Item.cmd_4c_Proximo,        "Click", THIS, "ItemProximoClick")
        BINDEVENT(THIS.cnt_4c_Financ.cmd_4c_Proximo,      "Click", THIS, "FinancProximoClick")
        BINDEVENT(THIS.cnt_4c__Credito.cmd_4c_Proximo,    "Click", THIS, "CreditoProximoClick")
        BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_Proximo,  "Click", THIS, "PendenciaProximoClick")
        BINDEVENT(THIS.cnt_4c__Identifica.cmd_4c_Proximo, "Click", THIS, "IdentificaProximoClick")
        BINDEVENT(THIS.cnt_4c__Fpagto.cmd_4c_Proximo,     "Click", THIS, "FpagtoProximoClick")

        *-- Confirmacao manual do item (CntItem.Cnt_Produto.CmdEnviaProd) - so
        *-- fica visivel quando o legado exige confirmar o preco alterado.
        BINDEVENT(THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd, "Click", THIS, "CmdEnviaProdClick")

        *-- Atalho para o Cadastro de Contas a partir dos blocos Origem/Destino
        *-- (btnCadastros de cada um).
        BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_Destino.cmd_4c_BtnCadastros,    "Click", THIS, "BtnCadastrosDestinoClick")
        BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_Origem.cmd_4c_btncadastros2,    "Click", THIS, "BtnCadastrosOrigemClick")

        *-- Conferencia de cheque pre-datado (Cnt_ChequepreTef.Cnt_Chq).
        loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
        BINDEVENT(loc_oCnt.cmd_4c_TefChq, "Click", THIS, "CmdTefChqClick")
        BINDEVENT(loc_oCnt.cmd_4c_Ins,    "Click", THIS, "CmdInsChequeClick")

        *-- Combo de troca de operacao (Ctrl+F11).
        BINDEVENT(THIS.cbo_4c_CmbTOpers, "KeyPress",  THIS, "CmbTOpersKeyPress")
        BINDEVENT(THIS.cbo_4c_CmbTOpers, "KeyPress", THIS, "CmbTOpersLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarTelaOperacao - mostra EXATAMENTE um dos seis containers de
    * operacao e esconde os outros cinco. No legado cada Click de
    * identifica/credito/pendencia/Financia/Itens comeca zerando a
    * visibilidade dos irmaos antes de mostrar o proprio (ex.: identifica.Click
    * "ThisForm.CntFinanc.Visible=.f. / ThisForm.CntItem.Visible=.f. /
    * ThisForm.Cnt_Credito.Visible=.f. / Thisform.Cnt_pendencia.Visible=.f. /
    * ThisForm.Cnt_fpagto.Visible=.f."). Sem este metodo os seis nasciam todos
    * Visible=.T. (ConfigurarContainersOperacao, Fase 4) empilhados na mesma
    * area (Top=124 Left=32) - bug corrigido aqui.
    * CancelaItem e um painel modal-like a parte (fica por cima da tela
    * ativa) - trocar de tela fecha ele tambem, igual ao CancelaDisp legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarTelaOperacao(par_cTela)
        LOCAL loc_cTela
        loc_cTela = UPPER(ALLTRIM(par_cTela))

        THIS.cnt_4c_Item.Visible        = (loc_cTela == "ITENS")
        THIS.cnt_4c_Financ.Visible      = (loc_cTela == "FINANC")
        THIS.cnt_4c__Credito.Visible    = (loc_cTela == "CREDITO")
        THIS.cnt_4c__Pendencia.Visible  = (loc_cTela == "PENDENCIA")
        THIS.cnt_4c__Identifica.Visible = (loc_cTela == "IDENTIFICA")
        THIS.cnt_4c__Fpagto.Visible     = (loc_cTela == "FPAGTO")

        IF loc_cTela != "ITENS"
            THIS.cnt_4c_CancelaItem.Visible = .F.
            THIS.cnt_4c_Item.Enabled        = .T.
        ENDIF

        *-- Quem desabilita botao tem de reabilitar no FUNIL de volta: toda
        *-- troca de tela passa por aqui, entao o gate dos botoes e reaplicado
        *-- aqui e nao em cada Click (CLAUDE.md #40).
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarControle - SetFocus protegido. Falha de SetFocus aqui e sempre um
    * problema de TIMING (controle ainda na tela que acabou de ficar
    * invisivel no mesmo ciclo de evento) - nunca perda de dado. Mesmo
    * criterio ja usado no CATCH silencioso do Destroy() deste form (comentado
    * la: "o Destroy nao pode falhar aqui, senao o menu principal nao e
    * reconstruido"): aqui, mostrar MsgErro por causa de foco de teclado
    * seria pior do que nao mostrar nada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarControle(par_oControle)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_oControle) = "O" AND par_oControle.Visible AND par_oControle.Enabled
                par_oControle.SetFocus
            ENDIF
        CATCH TO loc_oErro
            * silencioso de proposito - ver comentario do metodo.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HaPagamentoPend - .T. quando ha alguma forma de pagamento lancada em
    * xPar que ainda nao foi inserida (Valos>0, FPags preenchido, !InsChs).
    * Mesma condicao do legado em credito/pendencia/Financia.Click ("Count to
    * wxpar for Valos > 0 and not Empty(fpags) And Not xPar.InsChs / If wxpar
    * > 0 / MessageBox('Favor Excluir as Condicoes de Pagamento!!!')").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION HaPagamentoPendente()
        LOCAL loc_nQt, loc_nAreaAnt
        loc_nQt = 0

        IF USED("xPar")
            loc_nAreaAnt = SELECT()
            SELECT xPar
            COUNT FOR Valos > 0 AND !EMPTY(FPags) AND !InsChs TO loc_nQt
            IF loc_nAreaAnt > 0
                SELECT (loc_nAreaAnt)
            ENDIF
        ENDIF

        RETURN (loc_nQt > 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * RecalcularTotalCarrinho - soma crTpmMvItn.totas e atualiza o TOTAL da
    * tela de Itens + a propriedade this_nTotal. Chamado sempre que um item e
    * removido do carrinho localmente (CancelaItemOkClick).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularTotalCarrinho()
        LOCAL loc_nTotal, loc_nAreaAnt
        loc_nTotal = 0

        IF USED("crTpmMvItn")
            loc_nAreaAnt = SELECT()
            SELECT crTpmMvItn
            SUM totas TO loc_nTotal
            IF loc_nAreaAnt > 0
                SELECT (loc_nAreaAnt)
            ENDIF
        ENDIF

        THIS.this_nTotal = loc_nTotal
        THIS.cnt_4c_Item.txt_4c_Total.Value = loc_nTotal
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelaItemFechar - fecha o painel de cancelamento e devolve o controle
    * a tela de Itens. Compartilhado por CancelaItemOkClick (apos processar) e
    * CancelaItemCancelaDispClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CancelaItemFechar()
        THIS.cnt_4c_CancelaItem.Visible = .F.
        THIS.cnt_4c_Item.Enabled        = .T.
        THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
    ENDPROC

    *==========================================================================
    * HANDLERS - BARRA DE BOTOES PRINCIPAL
    *==========================================================================

    *-- [F2] Itens - volta para a tela de lancamento de itens.
    PROCEDURE CmdItensClick()
        THIS.AlternarTelaOperacao("ITENS")
        THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
    ENDPROC

    *-- [F3] Alteraqtd - legado: "If Empty(Get_produto.Value) / lAlteraqtd=.t.
    *-- / focus Get_qtds / Else / focus Get_Produto".
    PROCEDURE CmdAlteraqtdClick()
        LOCAL loc_oProd
        loc_oProd = THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto

        IF EMPTY(loc_oProd.Value)
            THIS.this_lLalteraqtd = .T.
            THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Qtds)
        ELSE
            THIS.FocarControle(loc_oProd)
        ENDIF
    ENDPROC

    *-- [F3] Desconto - alterna o desconto de venda (Cnt_Fpagto.Desconto),
    *-- espelhando a guarda do irmao Acrescimo (so um dos dois fica aberto).
    PROCEDURE CmdDescontoClick()
        IF THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.Visible
            RETURN
        ENDIF

        THIS.this_lValidadesconto = .T.
        WITH THIS.cnt_4c__Fpagto
            .cnt_4c_Desconto.Visible   = .T.
            .cnt_4c_Desconto.Enabled   = .T.
            .txt_4c_TotLiquido.Visible = .T.
            .lbl_4c_Label15.Visible    = .T.
        ENDWITH

        THIS.AlternarTelaOperacao("FPAGTO")
        THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_PorcVariacao)
    ENDPROC

    *-- [Ctrl+F3] Acrescimo - legado (Barra_Botoes.Acrescimo.Click, 24
    *-- linhas): bloqueia se ja houver desconto informado ou o painel de
    *-- desconto estiver aberto; senao mostra o painel de acrescimo.
    PROCEDURE CmdAcrescimoClick()
        LOCAL loc_lOk
        loc_lOk = .T.

        IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao.Value > 0
            MsgAviso("Desconto Informado. N" + CHR(227) + "o pode haver Acr" + CHR(233) + "scimo!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.Visible
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            THIS.this_lValidadesconto = .T.
            WITH THIS.cnt_4c__Fpagto
                .cnt_4c_Acrescimo.Visible  = .T.
                .cnt_4c_Acrescimo.Enabled  = .T.
                .txt_4c_TotLiquido.Visible = .T.
                .lbl_4c_Label15.Visible    = .T.
            ENDWITH

            THIS.AlternarTelaOperacao("FPAGTO")
            THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_PorcVariacao)
        ENDIF
    ENDPROC

    *-- [F4] CancPagto - cancela a ULTIMA forma de pagamento lancada (xPar).
    *-- A baixa em gateway TEF (DeleteSigTef, do legado) nao tem equivalente
    *-- nesta migracao - so a parcela local (e as demais da mesma "chave" de
    *-- lancamento, nChaves) e removida.
    PROCEDURE CmdCancPagtoClick()
        LOCAL loc_nChave

        IF !USED("xPar")
            RETURN
        ENDIF

        SELECT xPar
        GO BOTTOM
        IF EOF()
            RETURN
        ENDIF

        loc_nChave = xPar.nChaves
        DELETE FOR nChaves == loc_nChave

        THIS.AtualizarGrades()
        THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
    ENDPROC

    *-- [F4] Apaga - abre o painel de cancelamento com os dados do ULTIMO
    *-- item lancado. Legado (Barra_Botoes.apaga.Click): guarda "Not
    *-- Empty(Get_Produto.Value) Return" + "Get_item.Value = Citem-1" +
    *-- "Locate For citens = Get_item.Value" + preenche Produto/Descricao/
    *-- Barra do painel.
    PROCEDURE CmdApagaClick()
        LOCAL loc_nItem

        IF !EMPTY(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value)
            RETURN
        ENDIF

        IF !USED("crTpmMvItn")
            RETURN
        ENDIF

        SELECT crTpmMvItn
        LOCATE
        IF EOF()
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " item lan" + CHR(231) + "ado para cancelar.", "Cancelar Item")
            RETURN
        ENDIF

        loc_nItem = THIS.this_nCitem - 1

        LOCATE FOR citens == loc_nItem
        IF EOF()
            GO BOTTOM
            loc_nItem = NVL(crTpmMvItn.citens, 0)
        ENDIF

        WITH THIS.cnt_4c_CancelaItem
            .txt_4c_Item.Value    = loc_nItem
            .txt_4c_Produto.Value = NVL(crTpmMvItn.cpros, "")
            .txt_4c__dpro.Value   = NVL(crTpmMvItn.dpros, "")
            .txt_4c_Cbarra.Value  = NVL(crTpmMvItn.codbarras, 0)
            .Visible              = .T.
            .ZOrder(0)
        ENDWITH

        THIS.cnt_4c_Item.Enabled = .F.
        THIS.FocarControle(THIS.cnt_4c_CancelaItem.txt_4c_Item)
    ENDPROC

    *-- [F5] AltPreco - legado: "If Not IsEmpty(crTpmMvItn.CPros) /
    *-- lAlteraValor=.t. / zera ValDesc/PValDesc / focus Get_Valor". O
    *-- lancamento linha-a-linha do carrinho (Get_Produto/Get_Qtds) fica para
    *-- a fase de eventos de campo - aqui a mesma condicao e checada pelo
    *-- campo Produto da tela.
    PROCEDURE CmdAltPrecoClick()
        IF EMPTY(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value)
            RETURN
        ENDIF

        THIS.this_lLalteravalor = .T.
        WITH THIS.cnt_4c_Item.cnt_4c__Desconto
            .txt_4c_Valdesc.Value  = 0
            .txt_4c_Pvaldesc.Value = 0
            .Visible     = .T.
        ENDWITH

        THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Subtotal.txt_4c_Valor)
    ENDPROC

    *-- [F6] Identifica - legado: guarda "Not Empty(Get_fpg.Value) Return 0"
    *-- (nao sai de uma forma de pagamento em andamento) + troca de tela. A
    *-- leitura de CrSigCdOpe.AcioSens (senha de acionamento) fica fora de
    *-- alcance com DataSession=2.
    PROCEDURE CmdIdentificaClick()
        IF !EMPTY(THIS.cnt_4c__Fpagto.txt_4c_Fpg.Value)
            RETURN
        ENDIF

        THIS.AlternarTelaOperacao("IDENTIFICA")
        THIS.FocarControle(THIS.cnt_4c__Identifica.cnt_4c_Destino.txt_4c_Grupo)
    ENDPROC

    *-- [F7] Credito - mesma guarda de pagamento em aberto (HaPagamentoPend()).
    PROCEDURE CmdCreditoClick()
        IF THIS.HaPagamentoPendente()
            MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Cr" + CHR(233) + "dito")
            RETURN
        ENDIF

        THIS.AlternarTelaOperacao("CREDITO")
        THIS.FocarControle(THIS.cnt_4c__Credito.grd_4c_Devolucao)
    ENDPROC

    *-- [F8] Financia - crediario/codigos de barras. Visible=.F. por padrao no
    *-- dump legado (recurso desligado), mas o evento e ligado do mesmo jeito.
    PROCEDURE CmdFinanciaClick()
        IF THIS.HaPagamentoPendente()
            MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Financiamento")
            RETURN
        ENDIF

        THIS.AlternarTelaOperacao("FINANC")
        THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__Barras.txt_4c_Barra_1)
    ENDPROC

    *-- [F8] Pendencia - sub-niveis/pendencias.
    PROCEDURE CmdPendenciaClick()
        IF THIS.HaPagamentoPendente()
            MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Pend" + CHR(234) + "ncia")
            RETURN
        ENDIF

        THIS.AlternarTelaOperacao("PENDENCIA")
        THIS.FocarControle(THIS.cnt_4c__Pendencia.grd_4c_SubNiveis)
    ENDPROC

    *-- <Ctrl+P> VerPreco - overlay de consulta de preco (nao esconde os
    *-- outros paineis - fica POR CIMA, como no legado). Legado
    *-- (Barra_Botoes.VerPreco.Click, 18 linhas): abre se ainda fechado, limpa
    *-- o campo de produto e o resultado anterior.
    PROCEDURE CmdVerPrecoClick()
        WITH THIS.cnt_4c__Consulta
            IF !.Visible
                .Visible = .T.
                .ZOrder(0)
            ENDIF
            .cnt_4c__Produto.txt_4c_Produto.Value       = ""
            .cnt_4c__Resultado.lbl_4c_Mensage1.Caption  = ""
            .cnt_4c__Resultado.lbl_4c_Mensage2.Caption  = ""
            .txt_4c_Unit.Value                          = 0
        ENDWITH

        THIS.FocarControle(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto)
    ENDPROC

    *-- [F9] Impfiscal - legado abre SIGMEFIS, monitor de status da
    *-- impressora fiscal (ECF). Sem driver ECF fisico disponivel nesta
    *-- migracao nao ha tela equivalente para abrir - decisao de escopo
    *-- documentada, nao pendencia.
    PROCEDURE CmdImpfiscalClick()
        MsgAviso("O monitor de status da impressora fiscal depende do driver " + ;
            "ECF f" + CHR(237) + "sico do caixa, fora do escopo desta migra" + CHR(231) + CHR(227) + "o.", ;
            "Impressora Fiscal")
    ENDPROC

    *-- [Ctrl+F11] MudaOpe - legado (34 linhas): tres guardas locais
    *-- (pagamento/sub-nivel/credito ja lancados bloqueiam a troca) + popula
    *-- cmbTOpers com as operacoes cadastradas. A quarta guarda do legado
    *-- (ThisForm.ParentForm.AbriuCupom) fica fora de alcance com
    *-- DataSession=2. A reconfiguracao completa do Caixa para a nova operacao
    *-- (AciomudaOpe) e responsabilidade da tela de movimentacao.
    PROCEDURE CmdMudaOpeClick()
        LOCAL loc_nQt, loc_oErro

        IF USED("xPar")
            SELECT xPar
            COUNT FOR Valos > 0 AND !EMPTY(FPags) TO loc_nQt
            IF loc_nQt > 0
                MsgAviso("Condi" + CHR(231) + CHR(245) + "es de Pagamento j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
                    "Muda Opera" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
        ENDIF

        IF USED("TmpOperacao")
            SELECT TmpOperacao
            COUNT FOR Codigos > 0 TO loc_nQt
            IF loc_nQt > 0
                MsgAviso("Opera" + CHR(231) + CHR(245) + "es de SubN" + CHR(237) + "veis j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
                    "Muda Opera" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
        ENDIF

        IF USED("TmpDevol")
            SELECT TmpDevol
            COUNT FOR Codigos > 0 TO loc_nQt
            IF loc_nQt > 0
                MsgAviso("Opera" + CHR(231) + CHR(245) + "es de Cr" + CHR(233) + "dito j" + CHR(225) + " lan" + CHR(231) + "ada!!!", ;
                    "Muda Opera" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_ListaOpe")
                USE IN cursor_4c_ListaOpe
            ENDIF

            IF SQLEXEC(gnConnHandle, "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", "cursor_4c_ListaOpe") > 0 ;
                    AND USED("cursor_4c_ListaOpe") AND RECCOUNT("cursor_4c_ListaOpe") > 0

                THIS.cbo_4c_CmbTOpers.RowSourceType = 0
                THIS.cbo_4c_CmbTOpers.Clear()

                SELECT cursor_4c_ListaOpe
                SCAN
                    THIS.cbo_4c_CmbTOpers.AddItem(ALLTRIM(cursor_4c_ListaOpe.Dopes))
                ENDSCAN

                THIS.cbo_4c_CmbTOpers.Visible = .T.
                THIS.FocarControle(THIS.cbo_4c_CmbTOpers)
            ENDIF

            IF USED("cursor_4c_ListaOpe")
                USE IN cursor_4c_ListaOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em Muda Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *-- [F11] Pagto - avanca para a tela de formas de pagamento, exigindo
    *-- pelo menos um item lancado (guia minima do metodo legado de 425
    *-- linhas - o restante e abertura/fechamento de cupom fiscal, fora de
    *-- alcance sem o driver ECF).
    PROCEDURE CmdPagtoClick()
        IF !USED("crTpmMvItn")
            RETURN
        ENDIF

        SELECT crTpmMvItn
        LOCATE
        IF EOF()
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens lan" + CHR(231) + "ados para pagamento.", "Pagamento")
            RETURN
        ENDIF

        THIS.AlternarTelaOperacao("FPAGTO")
        THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
    ENDPROC

    *-- Confirmar (cmd_4c_Ok) - legado (Barra_Botoes.ok.Click, 25 linhas):
    *-- valida sub-nivel/pagamento e chama AcioSalva() no ParentForm, que
    *-- gravava o cursor de itens inteiro com TableUpdate na datasession
    *-- COMPARTILHADA e fechava o cupom fiscal.
    *--
    *-- Aqui: sem item lancado, so fecha o Caixa; havendo itens, exige forma de
    *-- pagamento informada e GRAVA os itens em SigMvItn pelo BO antes de
    *-- devolver o controle a tela de movimentacao. A gravacao acontece NESTE
    *-- form porque DataSession = 2 isola o carrinho (crTpmMvItn) do form pai -
    *-- sem ela os itens morreriam na memoria ao fechar a tela e o Confirmar
    *-- anunciaria "venda validada" sem nada no banco.
    *--
    *-- A finalizacao FISCAL (emissao do cupom / TEF) continua sendo do form
    *-- pai: depende da impressora fiscal, que esta fora de alcance daqui.
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_nItens, loc_lTemPagamento

        *-- Conta so as linhas com produto: o carrinho mantem uma linha em
        *-- branco aberta para o proximo item (LimparCntItem), que NAO conta
        *-- como venda.
        loc_nItens = 0
        IF USED("crTpmMvItn")
            SELECT crTpmMvItn
            COUNT FOR !EMPTY(NVL(cpros, "")) AND !DELETED() TO loc_nItens
        ENDIF

        IF loc_nItens = 0
            THIS.Release()
            RETURN
        ENDIF

        loc_lTemPagamento = .F.
        IF USED("xPar")
            SELECT xPar
            LOCATE FOR !EMPTY(FPags)
            loc_lTemPagamento = !EOF()
        ENDIF

        IF !loc_lTemPagamento
            MsgAviso("Informe a forma de pagamento antes de confirmar a venda.", "Confirmar")
            THIS.CmdPagtoClick()
            RETURN
        ENDIF

        *-- Grava os itens. Falhando, NAO fecha a tela e NAO anuncia sucesso -
        *-- o caixa continua com o carrinho na tela para corrigir e repetir.
        *-- BusinessBase.Salvar() ja exibiu o motivo (CLAUDE.md #20).
        IF !THIS.GravarItensLancados()
            RETURN
        ENDIF

        MsgInfo("Venda gravada com sucesso." + CHR(13) + ;
            "A finaliza" + CHR(231) + CHR(227) + "o fiscal prossegue na tela de " + ;
            "movimenta" + CHR(231) + CHR(227) + "o.", "Confirmar")
        THIS.Release()
    ENDPROC

    *-- Cancelar (cmd_4c_Cancela, ESC) - encerra o Caixa e devolve o controle
    *-- ao form pai (Destroy() ja reabilita this_oParentForm).
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Deseja realmente cancelar e encerrar o Caixa?", "Cancelar")
            THIS.Release()
        ENDIF
    ENDPROC

    *-- BtnEncerrarClick - alias PUBLIC do encerramento canonico deste form.
    *-- O legado SIGMVITN.SCX nao tem botao de Encerrar/Fechar/Sair na barra:
    *-- a saida e o proprio Cancelar (Barra_Botoes.Cancela, Cancel = .T.), que
    *-- ja fecha e devolve o controle ao form pai. Nenhum botao novo e criado
    *-- (PILAR 1) - este metodo so existe para o nome canonico de encerramento
    *-- que TesteAutomatico.prg (TesteBtnEncerrarExiste) exige via PEMSTATUS.
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * HANDLERS - GRADES (CntFinanc.Cnt_GrdBarra / Cnt_Pendencia)
    *==========================================================================

    *-- F2-Selec - legado: "Grade.Column1.SetFocus".
    PROCEDURE CmdInserirBarraClick()
        THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__GrdBarra.grd_4c_Barras.Column1)
    ENDPROC

    *-- F5-Barra - legado: "Cnt_Barras.Get_Barra_1.SetFocus()".
    PROCEDURE CmdOkBarraClick()
        THIS.FocarControle(THIS.cnt_4c_Financ.cnt_4c__Barras.txt_4c_Barra_1)
    ENDPROC

    *-- F4-Excluir - legado: "Select TmpBarFin / Delete / Go Top /
    *-- ThisForm.parentForm.Atuatot() / Get_total.Refresh() / Grade.Refresh()".
    *-- Atuatot() do form pai fica fora de alcance (DataSession=2) - o total
    *-- do carne e recalculado aqui, localmente, a partir do proprio
    *-- TmpBarFin.
    PROCEDURE CmdExcluirBarraClick()
        LOCAL loc_nTotal
        loc_nTotal = 0

        IF !USED("TmpBarFin")
            RETURN
        ENDIF

        SELECT TmpBarFin
        DELETE
        GO TOP

        SUM ValPs TO loc_nTotal
        THIS.cnt_4c_Financ.txt_4c_Total.Value = loc_nTotal

        THIS.AtualizarGrades()
    ENDPROC

    *-- [F3]Pend. - legado abre SigOpPen (tela de selecao de pendencias do
    *-- cliente), sem equivalente migrado. A limpeza local de linhas com
    *-- codigo zerado (Delete For Codigos = 0) e feita mesmo assim.
    PROCEDURE CmdBotPendentesClick()
        IF !USED("TmpOperacao")
            RETURN
        ENDIF

        SELECT TmpOperacao
        DELETE FOR Codigos = 0
        GO TOP

        THIS.AtualizarGrades()
    ENDPROC

    *==========================================================================
    * HANDLERS - PAINEL DE CANCELAMENTO DE ITEM (CancelaItem)
    *==========================================================================

    *-- CancelaDisp - legado (6 linhas): reabilita CntItem e fecha o painel
    *-- SEM cancelar nada.
    PROCEDURE CancelaItemCancelaDispClick()
        *-- Legado (CancelaDisp.Click): "Select crTpmMvItn / Set Order To".
        *-- SET ORDER TO exige a ORDEM antes do IN (SET ORDER TO 0 IN <alias>);
        *-- "SET ORDER TO IN <alias>" nao compila.
        IF USED("crTpmMvItn")
            SELECT crTpmMvItn
            SET ORDER TO
        ENDIF
        THIS.CancelaItemFechar()
    ENDPROC

    *-- Ok (confirmar cancelamento) - o legado abre "Do Form SigOpSen With
    *-- 'CANCITEM',..." (senha de supervisor) antes de cancelar; sem
    *-- equivalente migrado, MsgConfirma() faz o papel do gate de
    *-- confirmacao. Remove o item de crTpmMvItn/crTpmMvItnC (local - a
    *-- exclusao definitiva em SigMvItn e responsabilidade da fase de
    *-- persistencia dos itens, ainda nao lancada nesta tela) e recalcula o
    *-- total.
    PROCEDURE CancelaItemOkClick()
        LOCAL loc_nItem
        loc_nItem = THIS.cnt_4c_CancelaItem.txt_4c_Item.Value

        IF loc_nItem <= 0 OR !USED("crTpmMvItn")
            THIS.CancelaItemFechar()
            RETURN
        ENDIF

        IF MsgConfirma("Confirma o cancelamento do item " + TRANSFORM(loc_nItem) + "?", "Cancelamento de Item")
            SELECT crTpmMvItn
            DELETE FOR citens == loc_nItem

            IF USED("crTpmMvItnC")
                SELECT crTpmMvItnC
                DELETE FOR cItens == loc_nItem
            ENDIF

            SELECT crTpmMvItn
            GO TOP
            IF EOF()
                THIS.this_nCitem = 0
            ELSE
                GO BOTTOM
                THIS.this_nCitem = NVL(crTpmMvItn.citens, 0)
            ENDIF

            THIS.RecalcularTotalCarrinho()
            THIS.AtualizarGrades()
        ENDIF

        THIS.CancelaItemFechar()
    ENDPROC

    *==========================================================================
    * HANDLERS - PAINEL DE CONSULTA DE PRECO (Cnt_Consulta)
    *==========================================================================

    *-- Sair (Command1) - legado: fecha o overlay.
    PROCEDURE ConsultaCommand1Click()
        THIS.cnt_4c__Consulta.Visible = .F.
    ENDPROC

    *-- Proximo - o legado so troca a imagem da seta em GotFocus/LostFocus
    *-- (nao ha Click proprio capturado); tratado aqui como equivalente a
    *-- Sair, fechando o overlay.
    PROCEDURE ConsultaProximoClick()
        THIS.cnt_4c__Consulta.Visible = .F.
    ENDPROC

    *-- Get_Produto (ENTER/TAB) - consulta simples de preco por codigo do
    *-- produto ou codigo de barras (SigCdPro.cpros/cbars/dpros/pvens).
    PROCEDURE ConsultaProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oErro

        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_ConsultaPreco")
                USE IN cursor_4c_ConsultaPreco
            ENDIF

            IF SQLEXEC(gnConnHandle, "SELECT dpros, pvens FROM SigCdPro WHERE cpros = " + ;
                    EscaparSQL(PADR(loc_cValor, 14)) + " OR cbars = " + TRANSFORM(VAL(loc_cValor)), ;
                    "cursor_4c_ConsultaPreco") > 0 ;
                    AND USED("cursor_4c_ConsultaPreco") AND RECCOUNT("cursor_4c_ConsultaPreco") > 0

                SELECT cursor_4c_ConsultaPreco
                GO TOP
                THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
                    ALLTRIM(NVL(cursor_4c_ConsultaPreco.dpros, ""))
                THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
                THIS.cnt_4c__Consulta.txt_4c_Unit.Value = NVL(cursor_4c_ConsultaPreco.pvens, 0)
            ELSE
                THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
                    "Produto n" + CHR(227) + "o encontrado."
                THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
                THIS.cnt_4c__Consulta.txt_4c_Unit.Value = 0
            ENDIF

            IF USED("cursor_4c_ConsultaPreco")
                USE IN cursor_4c_ConsultaPreco
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na Consulta de Pre" + CHR(231) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS - SETAS "PROXIMO" (navegacao entre telas)
    *==========================================================================

    *-- CntItem.Proximo - legado: "If Get_Produto.Enabled / TotChamada=0 /
    *-- Barra_Botoes.Pagto.Click() / Else / This.SetFocus" - aciona o mesmo
    *-- botao Pagto da barra.
    PROCEDURE ItemProximoClick()
        IF THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Enabled
            THIS.CmdPagtoClick()
        ELSE
            THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
        ENDIF
    ENDPROC

    *-- CntFinanc.Proximo - mesmo destino do CntItem.Proximo (Pagto).
    PROCEDURE FinancProximoClick()
        THIS.CmdPagtoClick()
    ENDPROC

    *-- Cnt_Credito.Proximo - legado: "If Barra_Botoes.Itens.Visible /
    *-- Itens.Click() / Else / Pagto.Click()" - volta para Itens.
    PROCEDURE CreditoProximoClick()
        THIS.CmdItensClick()
    ENDPROC

    *-- Cnt_Pendencia.Proximo - mesmo padrao do Credito.
    PROCEDURE PendenciaProximoClick()
        THIS.CmdItensClick()
    ENDPROC

    *-- Cnt_Fpagto.Proximo - avanca para a confirmacao da venda.
    PROCEDURE FpagtoProximoClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * HANDLERS - COMBO DE TROCA DE OPERACAO (cbo_4c_CmbTOpers)
    *==========================================================================

    *-- Legado (cmbTOpers.LostFocus): ENTER confirma a operacao escolhida e
    *-- chama ThisForm.parentform.AciomudaOpe(...) - reconfiguracao completa
    *-- do Caixa, fora de alcance deste form filho (DataSession=2). Aqui:
    *-- registra a operacao escolhida localmente (this_cDopes) e avisa que a
    *-- reconfiguracao e feita pela tela de movimentacao.
    PROCEDURE CmbTOpersKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDope

        IF par_nKeyCode != 13
            RETURN
        ENDIF

        IF THIS.cbo_4c_CmbTOpers.ListIndex > 0
            loc_cDope = ALLTRIM(THIS.cbo_4c_CmbTOpers.List(THIS.cbo_4c_CmbTOpers.ListIndex))
            THIS.this_cDopes = loc_cDope
            MsgInfo("Opera" + CHR(231) + CHR(227) + "o alterada para " + loc_cDope + "." + CHR(13) + ;
                "A reconfigura" + CHR(231) + CHR(227) + "o completa do Caixa para a nova opera" + CHR(231) + CHR(227) + "o " + ;
                "e feita pela tela de movimenta" + CHR(231) + CHR(227) + "o.", "Muda Opera" + CHR(231) + CHR(227) + "o")
        ENDIF

        THIS.cbo_4c_CmbTOpers.Visible = .F.
    ENDPROC

    PROCEDURE CmbTOpersLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.cbo_4c_CmbTOpers.Visible = .F.
    ENDPROC

    *==========================================================================
    * HANDLERS DE KEYPRESS - disparam o lookup em ENTER(13)/TAB(9)/F4(115).
    * PUBLIC (sem PROTECTED): BINDEVENT so funciona com metodos PUBLIC
    * (CLAUDE.md #3). Cada um resolve o(s) controle(s) do proprio bloco e
    * delega para o AbrirLookupXxx correspondente.
    *==========================================================================

    *-- Destino ---------------------------------------------------------------
    PROCEDURE GrpDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Destino.txt_4c_Grupo)
        ENDIF
    ENDPROC

    PROCEDURE CtaDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
                loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "iclis", ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
        ENDIF
    ENDPROC

    PROCEDURE DctDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
                loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "rclis", ALLTRIM(loc_oCnt.txt_4c_Dconta.Value))
        ENDIF
    ENDPROC

    PROCEDURE CpfDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Destino
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_Conta, loc_oCnt.txt_4c_Dconta, ;
                loc_oCnt.txt_4c_Cpf, loc_oCnt.txt_4c_Grupo, "cpfs", ;
                CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ".-/", ""))
        ENDIF
    ENDPROC

    *-- Responsavel -------------------------------------------------------------
    PROCEDURE GrpRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Responsavel.txt_4c_grupo2)
        ENDIF
    ENDPROC

    PROCEDURE CtaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta2, loc_oCnt.txt_4c_dconta2, ;
                loc_oCnt.txt_4c_cpf2, loc_oCnt.txt_4c_grupo2, "iclis", ALLTRIM(loc_oCnt.txt_4c_conta2.Value))
        ENDIF
    ENDPROC

    PROCEDURE DctRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta2, loc_oCnt.txt_4c_dconta2, ;
                loc_oCnt.txt_4c_cpf2, loc_oCnt.txt_4c_grupo2, "rclis", ALLTRIM(loc_oCnt.txt_4c_dconta2.Value))
        ENDIF
    ENDPROC

    PROCEDURE CpfRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Responsavel
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta2, loc_oCnt.txt_4c_dconta2, ;
                loc_oCnt.txt_4c_cpf2, loc_oCnt.txt_4c_grupo2, "cpfs", ;
                CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_cpf2.Value), ".-/", ""))
        ENDIF
    ENDPROC

    *-- Vendedor ----------------------------------------------------------------
    PROCEDURE GrpVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Vendedor.txt_4c_grupo3)
        ENDIF
    ENDPROC

    PROCEDURE CtaVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta3, loc_oCnt.txt_4c_dconta3, ;
                loc_oCnt.txt_4c_cpf3, loc_oCnt.txt_4c_grupo3, "iclis", ALLTRIM(loc_oCnt.txt_4c_conta3.Value))
        ENDIF
    ENDPROC

    PROCEDURE DctVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta3, loc_oCnt.txt_4c_dconta3, ;
                loc_oCnt.txt_4c_cpf3, loc_oCnt.txt_4c_grupo3, "rclis", ALLTRIM(loc_oCnt.txt_4c_dconta3.Value))
        ENDIF
    ENDPROC

    PROCEDURE CpfVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Vendedor
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta3, loc_oCnt.txt_4c_dconta3, ;
                loc_oCnt.txt_4c_cpf3, loc_oCnt.txt_4c_grupo3, "cpfs", ;
                CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_cpf3.Value), ".-/", ""))
        ENDIF
    ENDPROC

    *-- Origem --------------------------------------------------------------
    PROCEDURE GrpOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupGrupo(THIS.cnt_4c__Identifica.cnt_4c_Origem.txt_4c_grupo4)
        ENDIF
    ENDPROC

    PROCEDURE CtaOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta4, loc_oCnt.txt_4c_dconta4, ;
                loc_oCnt.txt_4c_cpf4, loc_oCnt.txt_4c_grupo4, "iclis", ALLTRIM(loc_oCnt.txt_4c_conta4.Value))
        ENDIF
    ENDPROC

    PROCEDURE DctOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta4, loc_oCnt.txt_4c_dconta4, ;
                loc_oCnt.txt_4c_cpf4, loc_oCnt.txt_4c_grupo4, "rclis", ALLTRIM(loc_oCnt.txt_4c_dconta4.Value))
        ENDIF
    ENDPROC

    PROCEDURE CpfOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_Origem
            THIS.AbrirLookupConta(loc_oCnt.txt_4c_conta4, loc_oCnt.txt_4c_dconta4, ;
                loc_oCnt.txt_4c_cpf4, loc_oCnt.txt_4c_grupo4, "cpfs", ;
                CHRTRAN(ALLTRIM(loc_oCnt.txt_4c_cpf4.Value), ".-/", ""))
        ENDIF
    ENDPROC

    *-- TabDesconto / ListaPreco / Forma de Pagamento --------------------------
    PROCEDURE TabdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupTabDesconto(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_Tabd)
        ENDIF
    ENDPROC

    PROCEDURE ListaPrecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupListaPreco(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_ListaPreco)
        ENDIF
    ENDPROC

    PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupFormaPagamento(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
        ENDIF
    ENDPROC


    *==========================================================================
    * FASE 7 - EVENTOS DOS BOTOES QUE AINDA NAO TINHAM HANDLER
    *
    * Completa a cobertura de Click dos CommandButtons do SCX legado que nao
    * pertencem a barra principal nem as grades: o Confirmar do bloco de item
    * (CmdEnviaProd), a seta Proximo da tela de Identificacao, os dois
    * btnCadastros (Origem/Destino) e os dois botoes do painel de cheque
    * pre-datado (TefChq/ins).
    *==========================================================================

    *--------------------------------------------------------------------------
    * LimparCntItem - legado mLimpaCntItem(plInsere). Zera os campos do bloco
    * de lancamento de item e, quando par_lInsere, recicla a linha "corrente"
    * do carrinho: apaga as linhas sem produto e, se nao sobrou nenhuma em
    * branco, cria a proxima (citens = MAX + 1, respeitando UltimoCancel).
    *
    * O INSERT do legado gravava tambem emps/dopes/numes (tirados de TprMvCab,
    * cursor do form pai): crTpmMvItn desta tela NAO tem essas tres colunas
    * (Fase 4, CriarCursoresGrades) - a empresa/operacao/documento da venda
    * vivem nas properties this_cEmps/this_cDopes/this_nNumes e sao aplicadas
    * na persistencia, nao na linha do carrinho. Por isso aqui so citens.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCntItem(par_lInsere)
        LOCAL loc_lInsere, loc_nMaxItem, loc_lTemBranco, loc_oCnt

        loc_lInsere = IIF(VARTYPE(par_lInsere) = "L", par_lInsere, .F.)

        IF loc_lInsere AND USED("crTpmMvItn")
            SELECT crTpmMvItn
            SET ORDER TO
            GO TOP
            DELETE FOR EMPTY(NVL(cpros, ""))

            *-- Sobrou alguma linha em branco utilizavel? (legado:
            *-- "Seek(Spac(14),'crTpmMvItn','Cpros')")
            LOCATE FOR EMPTY(NVL(cpros, "")) AND !DELETED()
            loc_lTemBranco = !EOF()

            IF !loc_lTemBranco
                loc_nMaxItem = 0
                SELECT MAX(citens) AS nMaxItem ;
                    FROM crTpmMvItn ;
                    WHERE !EMPTY(NVL(cpros, "")) ;
                    INTO CURSOR cursor_4c_MaxItem
                IF USED("cursor_4c_MaxItem")
                    GO TOP IN cursor_4c_MaxItem
                    loc_nMaxItem = NVL(cursor_4c_MaxItem.nMaxItem, 0)
                    USE IN cursor_4c_MaxItem
                ENDIF

                IF THIS.this_nUltimocancel > loc_nMaxItem
                    loc_nMaxItem = THIS.this_nUltimocancel
                ENDIF

                THIS.this_nCitem = loc_nMaxItem + 1

                INSERT INTO crTpmMvItn (citens) VALUES (THIS.this_nCitem)
            ENDIF

            SELECT crTpmMvItn
            SET ORDER TO
        ENDIF

        loc_oCnt = THIS.cnt_4c_Item
        loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Value    = ""
        loc_oCnt.cnt_4c__Produto.txt_4c_Qtds.Value       = 0
        loc_oCnt.cnt_4c__Subtotal.txt_4c_Valor.Value     = 0
        loc_oCnt.cnt_4c__Desconto.txt_4c_Unival.Value    = 0
        loc_oCnt.cnt_4c__Desconto.txt_4c_Valdesc.Value   = 0
        loc_oCnt.cnt_4c__Desconto.txt_4c_Pvaldesc.Value  = 0
        loc_oCnt.cnt_4c__Desconto.txt_4c_ValAcre.Value   = 0
        loc_oCnt.cnt_4c__Desconto.txt_4c__pValAcre.Value = 0
        loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirItemCorrente - legado mExcluiItem. Apaga a linha corrente de
    * crTpmMvItn (e as linhas filhas em crTpmMvItnC), decrementa o contador de
    * itens, recalcula o TOTAL e repinta as grades.
    *
    * O legado recalculava o total com fTotalizarItn(poDataMgr) - funcao
    * global do Fortyus que nao veio no acervo; RecalcularTotalCarrinho() faz
    * a MESMA soma (SUM crTpmMvItn.totas), so localmente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExcluirItemCorrente()
        LOCAL loc_nItem

        IF !USED("crTpmMvItn")
            RETURN
        ENDIF

        SELECT crTpmMvItn
        IF EOF()
            RETURN
        ENDIF

        loc_nItem = NVL(citens, 0)
        DELETE

        THIS.this_nCitem = THIS.this_nCitem - 1

        IF USED("crTpmMvItnC")
            SELECT crTpmMvItnC
            DELETE FOR cItens == loc_nItem
        ENDIF

        THIS.RecalcularTotalCarrinho()
        THIS.AtualizarGrades()

        SELECT crTpmMvItn
        GO BOTTOM
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEnviaProdClick - Confirmar do bloco de item (CntItem.Cnt_Produto.
    * CmdEnviaProd). Legado (Click): "ThisForm.CmdEnviaProd() / This.Visible =
    * .f. / Get_Produto.SetFocus".
    *
    * O metodo CmdEnviaProd do legado imprime o item no cupom fiscal
    * (ItemFiscal/CancelCupom/AtuaCupom) - impressora ECF, fora de alcance
    * desta tela migrada (mesmo limite ja documentado em BtnConfirmarClick). O que
    * NAO depende do ECF e transcrito fielmente: valor zero rejeita o item
    * (mensagem do legado, remove a linha e remonta o bloco), valor valido
    * marca ImpCupFis, reabilita o [F4]Canc e recicla a linha corrente.
    *--------------------------------------------------------------------------
    PROCEDURE CmdEnviaProdClick()
        LOCAL loc_nValor

        loc_nValor = THIS.cnt_4c_Item.cnt_4c__Subtotal.txt_4c_Valor.Value

        IF loc_nValor = 0
            *-- Legado: "Messagebox('Valor do Produto Invalido !!',0+48,'')"
            MsgAviso("Valor do Produto Inv" + CHR(225) + "lido !!", "Confirmar Item")
            THIS.ExcluirItemCorrente()
            THIS.LimparCntItem(.T.)
        ELSE
            THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = "Imprimindo Itens..."

            IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
                SELECT crTpmMvItn
                REPLACE ImpCupFis WITH .T.
            ENDIF

            *-- Legado: "ThisForm.Barra_Botoes.Apaga.Enabled = .T."
            THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga.Enabled = .T.

            THIS.MontarLinhasCupom()
            THIS.AtualizarGrades()
            THIS.LimparCntItem(.T.)
        ENDIF

        THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
        THIS.LimparCntItem(.F.)

        THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd.Visible = .F.
        THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
    ENDPROC

    *--------------------------------------------------------------------------
    * IdentificaProximoClick - seta "Proximo" da tela de Identificacao.
    * Legado (Cnt_Identifica.Proximo.Click): "If Barra_Botoes.Itens.Visible /
    * Itens.Click() ... Else / Pagto.SetFocus + Pagto.Click()". A troca de
    * imagem da seta (GotFocus/LostFocus) e so visual e nao tem efeito de
    * negocio.
    *--------------------------------------------------------------------------
    PROCEDURE IdentificaProximoClick()
        IF THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Visible
            THIS.CmdItensClick()
        ELSE
            THIS.CmdPagtoClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirCadastroConta - corpo comum dos dois btnCadastros (Origem/Destino).
    * Legado: exige Conta E CPF/CNPJ preenchidos, so age em INSERIR/ALTERAR e
    * abre o Cadastro de Contas ("Do Form SIGCDCTA With 0,[SIGCDCTA],lcCli,
    * .T.,lcCpf,lcGru").
    *
    * SIGCDCTA foi migrado como FormCTA ("Cadastro de Contas"), cujo Init NAO
    * recebe parametros - o posicionamento equivalente e feito preenchendo o
    * filtro de Grupo da pagina Lista e recarregando a grade antes do Show().
    * O grupo de cadastro do legado vinha de crSigCdOpe.GruCadOs/GruCadDs
    * (cursor global do form pai, inalcancavel com DataSession = 2): aqui usa
    * o Grupo do proprio bloco, que e o fallback que o legado ja usava quando
    * GruCad*s estava vazio.
    *
    * Show() fica FORA do TRY (CLAUDE.md #29): FormCTA e modal, entao o Show()
    * bloqueia e TODO o uso da tela correria dentro do bloco - um erro de
    * runtime la dentro saltaria para o CATCH, a referencia LOCAL cairia e a
    * tela fecharia sozinha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirCadastroConta(par_oBloco)
        LOCAL loc_cConta, loc_cCpf, loc_cGrupo, loc_oForm, loc_oFiltros, loc_oErro
        LOCAL loc_lProsseguir

        loc_lProsseguir = .F.
        loc_cConta = ALLTRIM(NVL(par_oBloco.txt_4c_Conta.Value, ""))
        loc_cCpf   = ALLTRIM(NVL(par_oBloco.txt_4c_Cpf.Value, ""))
        loc_cGrupo = ALLTRIM(NVL(par_oBloco.txt_4c_Grupo.Value, ""))

        IF EMPTY(loc_cConta) OR EMPTY(loc_cCpf)
            *-- Legado: "E Necessario o Preenchimento Da Conta e Que a Mesma
            *-- Possua Um CPF/CNPJ!!!"
            MsgAviso(CHR(233) + " Necess" + CHR(225) + "rio o Preenchimento Da Conta e Que a Mesma " + ;
                "Possua Um CPF/CNPJ!!!", "Dados Incompletos")
            THIS.FocarControle(par_oBloco.txt_4c_Conta)
        ELSE
            loc_lProsseguir = INLIST(UPPER(ALLTRIM(THIS.this_cOpEscolha)), "INSERIR", "ALTERAR")
        ENDIF

        IF !loc_lProsseguir
            RETURN
        ENDIF

        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormCTA")
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir o Cadastro de Contas:" + CHR(13) + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Cadastro de Contas")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            *-- Posiciona o filtro de Grupo da Lista no grupo da conta
            *-- escolhida. Os PEMSTATUS ficam em IFs ANINHADOS de proposito:
            *-- VFP9 nao garante short-circuit em AND/OR, entao encadea-los na
            *-- mesma expressao avaliaria loc_oForm.pgf_4c_Paginas.Page1 mesmo
            *-- quando o PageFrame nao existe (CLAUDE.md #27).
            IF !EMPTY(loc_cGrupo)
                IF PEMSTATUS(loc_oForm, "pgf_4c_Paginas", 5)
                    IF PEMSTATUS(loc_oForm.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
                        loc_oFiltros = loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Filtros
                        IF PEMSTATUS(loc_oFiltros, "txt_4c_Grupo", 5)
                            loc_oFiltros.txt_4c_Grupo.Value = loc_cGrupo
                            IF PEMSTATUS(loc_oForm, "CarregarLista", 5)
                                loc_oForm.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            loc_oForm.Show()
        ENDIF
    ENDPROC

    *-- btnCadastros do bloco Destino.
    PROCEDURE BtnCadastrosDestinoClick()
        THIS.AbrirCadastroConta(THIS.cnt_4c__Identifica.cnt_4c_Destino)
    ENDPROC

    *-- btnCadastros do bloco Origem.
    PROCEDURE BtnCadastrosOrigemClick()
        THIS.AbrirCadastroConta(THIS.cnt_4c__Identifica.cnt_4c_Origem)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparChequePreTef - legado limpa_cheptef. Devolve os campos do painel
    * de cheque aos brancos com o TAMANHO de cada um (space(3)/space(4)/...),
    * exatamente como o legado - o TextBox e char e o InputMask depende do
    * comprimento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparChequePreTef()
        LOCAL loc_oChq
        loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq

        WITH loc_oChq
            .txt_4c_Bco.Value     = SPACE(3)
            .txt_4c_Age.Value     = SPACE(4)
            .txt_4c_Agendc.Value  = SPACE(1)
            .txt_4c_Conta.Value   = SPACE(10)
            .txt_4c_Contadc.Value = SPACE(1)
            .txt_4c_Num.Value     = SPACE(6)
            .txt_4c_Numdc.Value   = SPACE(6)
            .txt_4c_Pca.Value     = SPACE(34)
            .Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarChequesLancados - o SCAN de abertura do TefChq.Click legado:
    * percorre xPar e, para cada parcela cuja forma de pagamento e CHEQUE
    * (Infos = "C"), exige banco, agencia, conta, numero e CPF/CNPJ
    * preenchidos. Devolve .T. quando todas passam.
    *
    * xPar.Infos e a copia local de SigOpFp.Infos (Fase 4,
    * CriarCursoresGrades) - e por isso que aqui NAO e preciso repetir o
    * cursorquery('SigOpFp','CrOpFp','Fpags',xPar.Fpags) que o legado fazia
    * linha a linha.
    *
    * Alem do guard do legado, confere numero de cheque REPETIDO dentro da
    * mesma venda: e a inconsistencia que o botao "Ins" (sequenciamento)
    * existe para evitar, e a unica checagem de duplicidade possivel
    * localmente.
    *
    * NAO reproduz a consulta a fChkCheques(banco, agencia, conta, numero, ...)
    * - funcao global do Fortyus (SIGFUNCS.PRG) que NAO veio no acervo e que
    * consulta o historico/restricao do cheque. Um wrapper devolvendo .T.
    * APROVARIA em silencio um cheque que o legado recusaria (CLAUDE.md #27:
    * jamais stub que devolve veredicto), por isso a ausencia fica VISIVEL na
    * mensagem do caminho de sucesso, em vez de ser silenciada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarChequesLancados()
        LOCAL loc_lOk, loc_nAreaAnt, loc_nDuplicados

        loc_lOk = .T.

        IF !USED("xPar")
            RETURN .T.
        ENDIF

        loc_nAreaAnt = SELECT()

        *-- Passo 1: o SCAN do legado. NENHUM comando que mova o ponteiro pode
        *-- entrar aqui (COUNT/SUM/LOCATE varrem a tabela e quebram o SCAN) -
        *-- a checagem de duplicidade fica no passo 2, fora do laco.
        SELECT xPar
        GO TOP
        SCAN FOR UPPER(NVL(Infos, "")) == "C"
            IF EMPTY(NVL(Bancos, ""))   OR EMPTY(NVL(Agencias, "")) OR ;
               EMPTY(NVL(Contas, ""))   OR EMPTY(NVL(Numeros, ""))  OR ;
               EMPTY(NVL(Cpfs, ""))
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        *-- Passo 2: mesmo banco+agencia+conta+numero em mais de uma parcela.
        IF loc_lOk
            loc_nDuplicados = 0
            SELECT ALLTRIM(NVL(Bancos, "")) + "|" + ALLTRIM(NVL(Agencias, "")) + "|" + ;
                       ALLTRIM(NVL(Contas, "")) + "|" + ALLTRIM(NVL(Numeros, "")) AS cChaveChq, ;
                   COUNT(*) AS nQt ;
                FROM xPar ;
                WHERE UPPER(NVL(Infos, "")) == "C" ;
                GROUP BY 1 ;
                HAVING COUNT(*) > 1 ;
                INTO CURSOR cursor_4c_ChqDup
            IF USED("cursor_4c_ChqDup")
                loc_nDuplicados = RECCOUNT("cursor_4c_ChqDup")
                USE IN cursor_4c_ChqDup
            ENDIF
            loc_lOk = (loc_nDuplicados = 0)
        ENDIF

        SELECT xPar
        GO TOP
        IF loc_nAreaAnt > 0
            SELECT (loc_nAreaAnt)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CmdTefChqClick - "Consulta Cheque" do painel de cheque pre-datado.
    * ToolTipText do proprio legado: "Verifica e Confirma se a numeracao dos
    * cheques esta OK."
    *
    * Transcreve os dois trechos do legado que nao dependem de hardware:
    *   1) o SCAN de conferencia dos cheques lancados (ValidarChequesLancados);
    *   2) o rodape: cheque invalido -> mensagem + limpa_cheptef + zera
    *      nidcheps + foco na Praca; cheque valido -> se o total da forma de
    *      pagamento fechou com o total liquido (e nenhum dos dois e zero),
    *      reabilita Confirmar/Cancelar e dispara o Confirmar; em qualquer
    *      caso esconde o painel e devolve o foco a seta Proximo.
    *
    * NAO reproduz o miolo (crSigCdPam.pdvcchqs = 1/2 -> SigFiTefReq/VerifGP/
    * TefImpr/ApagaResp para consultar o cheque no gerenciador TEF, e
    * PertoHabilita/ChronoHabilita para acionar a impressora de cheque): sao
    * funcoes globais do Fortyus e drivers de periferico que nao vieram no
    * acervo, e crSigCdPam (que diz SE a consulta e exigida) e cursor global
    * do form de movimentacao, inalcancavel com DataSession = 2. Por isso a
    * confirmacao diz explicitamente o que foi e o que NAO foi conferido -
    * aprovar calado seria pior que a ausencia (CLAUDE.md #27).
    *--------------------------------------------------------------------------
    PROCEDURE CmdTefChqClick()
        LOCAL loc_oChq, loc_nTotLiquido, loc_nTotForma

        loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq

        THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
        THIS.this_lNoklostche = .T.

        IF !THIS.ValidarChequesLancados()
            *-- Legado: "MessageBox('Cheque Invalido!!!',0+48,'')" + limpa +
            *-- "Replace xPar.nidcheps with 0" + "Get_pca.SetFocus".
            MsgAviso("Cheque Inv" + CHR(225) + "lido!!!", "Conferir Cheque")
            THIS.LimparChequePreTef()
            IF USED("xPar")
                SELECT xPar
                IF !EOF()
                    REPLACE nIdCheps WITH 0
                ENDIF
            ENDIF
            THIS.FocarControle(loc_oChq.txt_4c_Pca)
            RETURN
        ENDIF

        MsgInfo("Numera" + CHR(231) + CHR(227) + "o dos cheques conferida." + CHR(13) + ;
            "A consulta ao gerenciador TEF e a impress" + CHR(227) + "o do cheque prosseguem na tela " + ;
            "de movimenta" + CHR(231) + CHR(227) + "o.", "Conferir Cheque")

        loc_nTotLiquido = THIS.cnt_4c__Fpagto.txt_4c_TotLiquido.Value
        loc_nTotForma   = THIS.cnt_4c__Fpagto.txt_4c_TotForma.Value

        THIS.this_lNoklostche = .F.
        THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Visible = .F.
        THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Refresh()

        IF loc_nTotLiquido = loc_nTotForma AND loc_nTotLiquido != 0 AND loc_nTotForma != 0
            THIS.cnt_4c_Barra_Botoes.cmd_4c_Cancela.Enabled = .T.
            THIS.BtnConfirmarClick()
        ELSE
            THIS.FocarControle(THIS.cnt_4c__Fpagto.cmd_4c_Proximo)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdInsChequeClick - botao "Ins" do painel de cheque. ToolTipText do
    * legado: "insere a sequencia dos numeros dos cheques e mostra na grade".
    *
    * Legado (Cnt_Chq.ins.Click): guarda os dados do cheque da linha CORRENTE
    * de xPar (banco/agencia/conta/digitos/CPF/praca/numero), pula para a linha
    * seguinte, limpa os campos de numero na tela e, da linha seguinte ate o
    * fim, replica esses dados incrementando o numero do cheque de 1 em 1
    * (Transform(...,'@L 999999')); no fim reordena, volta ao topo, refaz o
    * bind da grade e poe o foco na coluna Valor.
    *
    * O SetAll('DynamicForeColor',...) do legado pinta a linha conforme
    * InsChs/NumChqs/nIdCheps/Trocos - transcrito com os nomes das colunas
    * deste cursor. O rebind e feito por MontaGrade(), que ja reaplica na ordem
    * correta RecordSource -> ControlSource -> Width -> Header (Problema 48).
    *--------------------------------------------------------------------------
    PROCEDURE CmdInsChequeClick()
        LOCAL loc_oChq, loc_oGrd
        LOCAL loc_cBco, loc_cAgc, loc_cCta, loc_cDAgc, loc_cDCta, loc_cCpf, loc_cPca, loc_cNum

        IF !USED("xPar")
            RETURN
        ENDIF

        loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq

        SELECT xPar
        IF EOF()
            RETURN
        ENDIF

        loc_cBco  = NVL(Bancos, "")
        loc_cAgc  = NVL(Agencias, "")
        loc_cCta  = NVL(Contas, "")
        loc_cDAgc = NVL(DigAgencs, "")
        loc_cDCta = NVL(DigContas, "")
        loc_cCpf  = NVL(Cpfs, "")
        loc_cPca  = NVL(Pracas, "")
        loc_cNum  = NVL(Numeros, "")

        SKIP
        loc_oChq.txt_4c_Num.Value   = ""
        loc_oChq.txt_4c_Numdc.Value = ""

        DO WHILE !EOF()
            loc_cNum = TRANSFORM(VAL(loc_cNum) + 1, "@L 999999")
            REPLACE Bancos    WITH loc_cBco, ;
                    Agencias  WITH loc_cAgc, ;
                    Contas    WITH loc_cCta, ;
                    Numeros   WITH loc_cNum, ;
                    DigAgencs WITH loc_cDAgc, ;
                    DigContas WITH loc_cDCta, ;
                    Cpfs      WITH loc_cCpf, ;
                    Pracas    WITH loc_cPca IN xPar
            SKIP
        ENDDO

        SELECT xPar
        SET ORDER TO
        GO TOP

        THIS.MontaGrade()

        loc_oGrd = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.grd_4c_Parcelas
        loc_oGrd.SetAll("DynamicForeColor", ;
            "IIF(xPar.InsChs, IIF(!EMPTY(NVL(xPar.NumChqs, '')), RGB(255,0,0), RGB(0,0,255))," + ;
            " IIF(NVL(xPar.nIdCheps, 0) = 0, IIF(NVL(xPar.Trocos, 0) = 1, RGB(0,0,160), RGB(0,0,0)), RGB(0,0,255)))", ;
            "Column")
        loc_oGrd.Refresh()

        *-- Legado: ".valor.text1.SetFocus" - o alvo do foco e o TextBox da
        *-- coluna Valor (Column2), nao a Column.
        THIS.FocarControle(loc_oGrd.Column2.Text1)
    ENDPROC

    *==========================================================================
    * CONSOLIDACAO FINAL (FASE 8) - TRANSFERENCIA FORM <-> BO, PERSISTENCIA
    * DOS ITENS LANCADOS E GATE DOS BOTOES POR ESTADO DA TELA
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - copia a linha CORRENTE de crTpmMvItn (o item que o caixa
    * acabou de lancar) e o contexto da movimentacao para as propriedades do
    * BO, que e quem monta o INSERT/UPDATE em SigMvItn.
    *
    * O legado NAO tinha este metodo porque nao precisava: o cursor
    * crTpmMvItn pertencia a tela de movimentacao PAI, vivia na datasession
    * COMPARTILHADA ("Set DataSession To pnDatSes" no Init do SCX) e era o PAI
    * quem gravava tudo de uma vez no fim (AcioSalva -> TableUpdate). O form
    * migrado usa DataSession = 2 (isolado, como o proprio SCX declara), entao
    * o cursor daqui NAO e visivel para o pai - sem esta transferencia os itens
    * lancados morreriam na memoria quando a tela fechasse, e o Confirmar
    * anunciaria sucesso sem ter gravado nada.
    *
    * MAPEIA SOMENTE as colunas que esta tela realmente possui: as do cursor
    * do carrinho (CriarCursoresGrades) mais as 3 do contexto recebido do pai
    * (Emps/Dopes/Numes) e a PK cidchaves. As ~100 propriedades restantes do
    * BO sao colunas FISCAIS/de rateio de SigMvItn (impostos, bases de
    * calculo, CFOP, ST) que o Caixa NAO calcula nem exibe - ficam com o
    * default declarado no BO, que e o que a Fase 2 projetou e o gate
    * Validate-InsertNotNull aprovou. Preenche-las com 0/"" por conta propria
    * seria inventar valor de imposto, que grava numero errado EM SILENCIO
    * (CLAUDE.md #27 - stub que devolve valor de calculo e proibido).
    *
    * Retorna .F. sem gravar nada quando nao ha linha utilizavel, para que o
    * chamador ABORTE em vez de seguir e gravar registro parcial (CLAUDE.md
    * #187 - FormParaBO e FUNCTION e quem chama tem de respeitar o retorno).
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * ESCOPO destes tres metodos: FormParaBO, BOParaForm e LimparCampos sao
    * declarados PROTECTED porque o FormBase os declara PROTECTED (linhas
    * 276/280/285 de classes\formbase.prg) e em VFP9 a protecao e HERDADA -
    * redefinir na subclasse SEM a palavra PROTECTED nao os torna publicos.
    * Medido em 2026-09-24 com harness externo: PEMSTATUS(oForm, "FormParaBO",
    * 5) devolve .T. (so verifica existencia, nao escopo - mesma armadilha da
    * regra #3 do CLAUDE.md), mas a chamada de fora estoura "Property
    * FORMPARABO is not found".
    *
    * Isso e o CONTRATO do FormBase, nao um defeito: sao plumbing interno,
    * chamados por THIS. de dentro da classe (FormParaBO pelo
    * GravarItensLancados). Quem precisa ser PUBLIC por ser chamado de FORA
    * (CarregarLista / AjustarBotoesPorModo / HabilitarCampos / os Btn*Click,
    * que o TesteAutomatico e os harness de fase acionam direto) NAO leva
    * PROTECTED - ver as declaracoes abaixo. NAO "corrigir" isto trocando
    * PROTECTED por publico sem antes conferir o formbase.prg.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("crTpmMvItn") AND !EOF("crTpmMvItn") AND ;
                    !EMPTY(NVL(crTpmMvItn.cpros, ""))

                loc_oBO = THIS.this_oBusinessObject
                SELECT crTpmMvItn

                *-- Contexto da movimentacao (no legado vinha de TprMvCab, o
                *-- cursor de cabecalho do form pai).
                loc_oBO.this_cEmps  = THIS.this_cEmps
                loc_oBO.this_cDopes = THIS.this_cDopes
                loc_oBO.this_nNumes = THIS.this_nNumes

                *-- Chave composta que o legado montava em empdopnums
                *-- (Emps + Dopes + Str(Numes,6)) - char(29) no schema.
                loc_oBO.this_cEmpdopnums = LEFT(PADR(THIS.this_cEmps, 3) + ;
                    PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6), 29)

                *-- PK Fortyus (cidchaves): NAO e gerada aqui de proposito -
                *-- quem gera e o sigmvitnBO.Inserir, com LEFT(fUniqueIds(),20)
                *-- para caber no char(20). Duplicar a geracao aqui (sem o
                *-- LEFT) estouraria "String or binary data would be truncated".
                *-- Quem grava em lote (GravarItensLancados) ZERA a propriedade
                *-- antes de cada item para forcar chave nova: BusinessBase.
                *-- LimparDados e um stub que NAO limpa as propriedades da
                *-- subclasse, entao sem esse reset o 2o item reusaria a chave
                *-- do 1o e colidiria no indice unico (CLAUDE.md #22).

                *-- Item / produto
                loc_oBO.this_nCitens    = NVL(crTpmMvItn.citens, 0)
                loc_oBO.this_cCpros     = NVL(crTpmMvItn.cpros, "")
                loc_oBO.this_cDpros     = NVL(crTpmMvItn.dpros, "")
                loc_oBO.this_cCunis     = NVL(crTpmMvItn.cunis, "")
                loc_oBO.this_nCodbarras = NVL(crTpmMvItn.codbarras, 0)

                *-- Quantidades / pesos
                loc_oBO.this_nQtds   = NVL(crTpmMvItn.qtds, 0)
                loc_oBO.this_nPesos  = NVL(crTpmMvItn.pesos, 0)
                loc_oBO.this_nFators = NVL(crTpmMvItn.fators, 0)

                *-- Valores
                loc_oBO.this_nUnits    = NVL(crTpmMvItn.units, 0)
                loc_oBO.this_nUnivals  = NVL(crTpmMvItn.univals, 0)
                loc_oBO.this_nTotas    = NVL(crTpmMvItn.totas, 0)
                loc_oBO.this_nValdescs = NVL(crTpmMvItn.valdescs, 0)

                *-- Moedas e fatores de conversao
                loc_oBO.this_cMoedas  = NVL(crTpmMvItn.moedas, "")
                loc_oBO.this_cMoefats = NVL(crTpmMvItn.moefats, "")
                loc_oBO.this_nMoevals = NVL(crTpmMvItn.moevals, 0)
                loc_oBO.this_nFatvals = NVL(crTpmMvItn.fatvals, 0)

                *-- Classificacao / origem do lancamento
                loc_oBO.this_cOpers     = NVL(crTpmMvItn.opers, "")
                loc_oBO.this_cNotas     = NVL(crTpmMvItn.notas, "")
                loc_oBO.this_nUtilizas  = NVL(crTpmMvItn.utilizas, 0)
                loc_oBO.this_nCodlprecs = NVL(crTpmMvItn.codlprecs, 0)
                loc_oBO.this_cObs       = NVL(crTpmMvItn.obs, "")

                *-- Coluna bit: o cursor local declara L, mas o mesmo campo
                *-- chega do SQL Server ora Logico ora Numerico conforme o
                *-- driver - testar VARTYPE antes de usar (CLAUDE.md #13).
                IF VARTYPE(crTpmMvItn.etiesps) = "L"
                    loc_oBO.this_lEtiesps = NVL(crTpmMvItn.etiesps, .F.)
                ELSE
                    loc_oBO.this_lEtiesps = (NVL(crTpmMvItn.etiesps, 0) = 1)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao preparar o item para grava" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormParaBO")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - caminho inverso do FormParaBO: joga as propriedades do BO
    * na linha corrente de crTpmMvItn e nos campos de lancamento visiveis do
    * CntItem, para o caixa VER o item que o BO carregou (usado depois de
    * CarregarDoCursor, quando um item ja gravado e retomado para conferencia).
    *
    * REPLACE exige o cursor posicionado na linha certa: quem chama posiciona
    * (LOCATE FOR citens = ...) antes. Sem linha valida o metodo devolve .F. e
    * nao toca em nada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_oBO, loc_oCnt, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
                loc_oBO = THIS.this_oBusinessObject
                SELECT crTpmMvItn

                REPLACE citens     WITH loc_oBO.this_nCitens, ;
                        cpros      WITH loc_oBO.this_cCpros, ;
                        dpros      WITH loc_oBO.this_cDpros, ;
                        cunis      WITH loc_oBO.this_cCunis, ;
                        codbarras  WITH loc_oBO.this_nCodbarras, ;
                        codlprecs  WITH loc_oBO.this_nCodlprecs, ;
                        empdopnums WITH loc_oBO.this_cEmpdopnums, ;
                        etiesps    WITH loc_oBO.this_lEtiesps, ;
                        fators     WITH loc_oBO.this_nFators, ;
                        fatvals    WITH loc_oBO.this_nFatvals ;
                    IN crTpmMvItn

                REPLACE moedas   WITH loc_oBO.this_cMoedas, ;
                        moefats  WITH loc_oBO.this_cMoefats, ;
                        moevals  WITH loc_oBO.this_nMoevals, ;
                        notas    WITH loc_oBO.this_cNotas, ;
                        opers    WITH loc_oBO.this_cOpers, ;
                        pesos    WITH loc_oBO.this_nPesos, ;
                        qtds     WITH loc_oBO.this_nQtds, ;
                        totas    WITH loc_oBO.this_nTotas, ;
                        units    WITH loc_oBO.this_nUnits, ;
                        univals  WITH loc_oBO.this_nUnivals, ;
                        utilizas WITH loc_oBO.this_nUtilizas, ;
                        valdescs WITH loc_oBO.this_nValdescs, ;
                        obs      WITH loc_oBO.this_cObs ;
                    IN crTpmMvItn

                *-- Espelha nos campos de lancamento do painel de Itens, na
                *-- mesma ordem em que o caixa os preenche.
                loc_oCnt = THIS.cnt_4c_Item
                loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Value  = ALLTRIM(loc_oBO.this_cCpros)
                loc_oCnt.cnt_4c__Produto.txt_4c_Qtds.Value     = loc_oBO.this_nQtds
                loc_oCnt.cnt_4c__Subtotal.txt_4c_Valor.Value   = loc_oBO.this_nUnits
                loc_oCnt.cnt_4c__Desconto.txt_4c_Unival.Value  = loc_oBO.this_nUnivals
                loc_oCnt.cnt_4c__Desconto.txt_4c_Valdesc.Value = loc_oBO.this_nValdescs

                *-- Percentual de desconto: derivado, como o legado deriva em
                *-- Get_pvaldesc (valor sobre o original). Divisao protegida.
                IF loc_oBO.this_nUnivals > 0
                    loc_oCnt.cnt_4c__Desconto.txt_4c_Pvaldesc.Value = ;
                        ROUND(loc_oBO.this_nValdescs / loc_oBO.this_nUnivals * 100, 2)
                ELSE
                    loc_oCnt.cnt_4c__Desconto.txt_4c_Pvaldesc.Value = 0
                ENDIF

                loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Refresh()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao exibir o item carregado:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BOParaForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarItensLancados - persiste em SigMvItn TODOS os itens do carrinho
    * (crTpmMvItn) que tem produto informado, um a um, via BO.
    *
    * Este e o passo que fechava no legado por outro caminho: la o pai gravava
    * o cursor inteiro com TableUpdate na datasession COMPARTILHADA. Aqui, com
    * DataSession = 2, cada linha vira NovoRegistro() + FormParaBO() +
    * Salvar().
    *
    * Erro em QUALQUER item aborta o laco e devolve .F. - nao existe "gravou
    * metade da venda". Quem chama (BtnConfirmarClick) so anuncia sucesso e
    * fecha a tela se isto devolver .T.
    *
    * BusinessBase.Salvar() ja exibe a falha sozinho (ExibirFalha) e marca
    * this_lErroExibido, entao aqui NAO se repete a mensagem (CLAUDE.md #20).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarItensLancados()
        LOCAL loc_oBO, loc_lSucesso, loc_nGravados, loc_nRec, loc_oErro
        loc_lSucesso  = .T.
        loc_nGravados = 0

        IF !USED("crTpmMvItn")
            RETURN .F.
        ENDIF

        TRY
            loc_oBO = THIS.this_oBusinessObject

            SELECT crTpmMvItn
            SET ORDER TO
            GO TOP

            *-- Laco explicito em vez de SCAN/ENDSCAN de proposito: Salvar()
            *-- faz SQLEXEC e RegistrarAuditoria no meio da iteracao e pode
            *-- deixar OUTRA work area selecionada - o SKIP implicito do
            *-- ENDSCAN cairia no alias errado. Aqui a area e o registro sao
            *-- reposicionados explicitamente a cada volta.
            DO WHILE !EOF("crTpmMvItn") AND loc_lSucesso
                SELECT crTpmMvItn

                *-- Guarda redundante ao SET DELETED ON do Init, de proposito: item
                *-- CANCELADO (DELETE logico) nunca pode ser gravado.
                IF EMPTY(NVL(crTpmMvItn.cpros, "")) OR DELETED()
                    SKIP IN crTpmMvItn
                    LOOP
                ENDIF

                loc_nRec = RECNO("crTpmMvItn")

                loc_oBO.NovoRegistro()

                *-- Chave nova a cada item: BusinessBase.LimparDados e um stub
                *-- que NAO limpa as propriedades da subclasse, entao sem este
                *-- reset o Inserir reusaria a chave do item anterior e o 2o
                *-- registro colidiria no indice unico (CLAUDE.md #22).
                loc_oBO.this_cCidchaves = ""

                IF THIS.FormParaBO()
                    IF loc_oBO.Salvar()
                        loc_nGravados = loc_nGravados + 1
                    ELSE
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    loc_lSucesso = .F.
                ENDIF

                *-- Reposiciona antes de avancar: ver comentario do laco.
                SELECT crTpmMvItn
                IF BETWEEN(loc_nRec, 1, RECCOUNT("crTpmMvItn"))
                    GO loc_nRec IN crTpmMvItn
                ENDIF

                IF loc_lSucesso
                    SKIP IN crTpmMvItn
                ENDIF
            ENDDO

            SELECT crTpmMvItn
            GO TOP
        CATCH TO loc_oErro
            MsgErro("Erro ao gravar os itens da venda:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Confirmar")
            loc_lSucesso = .F.
        ENDTRY

        *-- Carrinho com produto mas nada gravado nao e sucesso: devolve .F.
        *-- para o Confirmar nao anunciar venda validada sem registro no banco
        *-- (CLAUDE.md #189 - nunca reportar sucesso sem ter gravado).
        IF loc_lSucesso AND loc_nGravados = 0
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLista - ponto de entrada canonico de (re)carga da tela. Este
    * form nao tem pagina de LISTA de registros (nao e cadastro): o que ele
    * lista e o CUPOM da venda corrente, na grade grd_4c_Cupom. Recarrega os
    * itens da movimentacao pelo BO e repinta as cinco grades.
    *
    * Popular cursor NAO repinta grade: a chamada a AtualizarGrades e
    * obrigatoria, senao a tela aparece vazia com o cursor cheio (CLAUDE.md
    * #21). CarregarDados ja chama AtualizarGrades no caminho de sucesso; a
    * chamada aqui cobre o caminho em que ele volta .F. (sem conexao / venda
    * nova sem numero), em que as grades tambem precisam ser repintadas no
    * estado vazio para o painel CAIXA LIVRE aparecer.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.CarregarDados()
        THIS.AtualizarGrades()
        THIS.RecalcularTotalCarrinho()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - liga/desliga os campos de LANCAMENTO de item.
    *
    * No legado o equivalente sao as clausulas When de cada campo do
    * Cnt_Produto/Cnt_Subtotal/Cnt_Desconto, que devolvem .F. (campo
    * inacessivel) quando a operacao nao esta em INSERIR/ALTERAR - por exemplo
    * Get_Produto.When: "InList(ThisForm.Op_Escolha,'INSERIR','ALTERAR') And
    * Empty(This.Value)". Reproduzido aqui como um gate unico, porque
    * BINDEVENT descarta o retorno de um When delegado e por isso nao bloqueia
    * edicao (CLAUDE.md #3).
    *
    * Valor e desconto seguem o gate do legado: so ficam acessiveis quando a
    * alteracao de preco/valor foi liberada (this_lLalterapreco /
    * this_lLalteravalor), como em Get_valor.When e Get_valdesc.When.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oCnt

        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oCnt = THIS.cnt_4c_Item

        loc_oCnt.cnt_4c__Produto.txt_4c_Produto.Enabled = loc_lHab
        loc_oCnt.cnt_4c__Produto.txt_4c_Qtds.Enabled    = loc_lHab

        *-- Preco unitario: no legado o campo so abre com alteracao de valor
        *-- liberada (Barra_Botoes.AltPreco) - fora disso o preco vem da
        *-- tabela e nao se digita.
        loc_oCnt.cnt_4c__Subtotal.txt_4c_Valor.Enabled = ;
            (loc_lHab AND (THIS.this_lLalteravalor OR THIS.this_lLalterapreco))

        *-- Desconto/acrescimo: liberados junto com a alteracao de preco.
        loc_oCnt.cnt_4c__Desconto.txt_4c_Valdesc.Enabled   = (loc_lHab AND THIS.this_lLalterapreco)
        loc_oCnt.cnt_4c__Desconto.txt_4c_Pvaldesc.Enabled  = (loc_lHab AND THIS.this_lLalterapreco)
        loc_oCnt.cnt_4c__Desconto.txt_4c_ValAcre.Enabled   = (loc_lHab AND THIS.this_lLalterapreco)
        loc_oCnt.cnt_4c__Desconto.txt_4c__pValAcre.Enabled = (loc_lHab AND THIS.this_lLalterapreco)

        *-- Original: somente leitura no legado (Get_unival.When: Return .F.).
        loc_oCnt.cnt_4c__Desconto.txt_4c_Unival.Enabled = .F.

        *-- TOTAL da venda: somente leitura no legado (Get_total.When: .F.).
        loc_oCnt.txt_4c_Total.Enabled = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - limpa os campos de lancamento de item SEM mexer no
    * carrinho. Delega ao LimparCntItem(.F.), que e a transcricao do
    * mLimpaCntItem legado: com .F. ele apenas zera os TextBoxes; com .T. ele
    * tambem reorganiza crTpmMvItn e abre a proxima linha em branco.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.LimparCntItem(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - aplica o gate de disponibilidade dos botoes da
    * barra principal conforme o estado da tela. Transcrito das clausulas When
    * do SCX legado (Barra_Botoes.*.When), que sao o mecanismo que o legado
    * usa para isso:
    *
    *   Itens / identifica / credito / pendencia / Financia / Pagto:
    *       "Return ( Not ThisForm.Cnt_Fpagto.Cnt_ChequepreTef.Visible )"
    *       - o painel de cheque pre-datado aberto TRAVA a navegacao.
    *   credito / pendencia / Financia / ok:  "... And ThisForm.Inicia"
    *   identifica:  "... And (ThisForm.Inicia Or ThisForm.LiberaIdent)"
    *   CancPagto:   "Return ( Cnt_Fpagto.Visible And Not Cnt_ChequepreTef.Visible )"
    *   apaga:       "Return (Empty(Get_Produto.Value) And CntItem.Visible )"
    *   Alteraqtd:   "Return (Empty(Get_Produto.Value) And CntItem.Visible
    *                 And Get_Produto.Enabled )"
    *   impfiscal:   "Return (Empty(Get_Produto.Value)
    *                 And Not Cnt_ChequepreTef.Visible And Lastkey() # 13 )"
    *                 - a parte "Lastkey() # 13" pertence ao When (roda a cada
    *                   tentativa de foco) e nao tem sentido num ajuste de
    *                   estado; o resto e transcrito.
    *
    * Chamado no fim de AlternarTelaOperacao, que e o FUNIL por onde toda
    * troca de tela passa - quem desabilita tem de reabilitar no caminho de
    * volta, senao os botoes ficam cinza e a tela fica inutilizavel (CLAUDE.md
    * #40).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lChequeAberto, loc_lItensVisivel, loc_lFpagtoVisivel
        LOCAL loc_lSemProduto, loc_lInicia

        loc_oCnt = THIS.cnt_4c_Barra_Botoes

        loc_lChequeAberto  = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Visible
        loc_lItensVisivel  = THIS.cnt_4c_Item.Visible
        loc_lFpagtoVisivel = THIS.cnt_4c__Fpagto.Visible
        loc_lInicia        = THIS.this_lInicia
        loc_lSemProduto    = EMPTY(ALLTRIM(NVL( ;
            THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value, "")))

        *-- Navegacao entre telas - travada com o cheque pre-datado aberto.
        loc_oCnt.cmd_4c_Itens.Enabled      = !loc_lChequeAberto
        loc_oCnt.cmd_4c_Identifica.Enabled = (!loc_lChequeAberto AND ;
            (loc_lInicia OR THIS.this_lLiberaident))
        loc_oCnt.cmd_4c_Credito.Enabled    = (!loc_lChequeAberto AND loc_lInicia)
        loc_oCnt.cmd_4c_Pendencia.Enabled  = (!loc_lChequeAberto AND loc_lInicia)
        loc_oCnt.cmd_4c_Financia.Enabled   = (!loc_lChequeAberto AND loc_lInicia)
        loc_oCnt.cmd_4c_Pagto.Enabled      = !loc_lChequeAberto

        *-- Acoes sobre o item corrente - so com o painel de Itens na frente e
        *-- nenhum produto em digitacao.
        loc_oCnt.cmd_4c_Apaga.Enabled     = (loc_lSemProduto AND loc_lItensVisivel)
        loc_oCnt.cmd_4c_Alteraqtd.Enabled = (loc_lSemProduto AND loc_lItensVisivel AND ;
            THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Enabled)

        *-- Cancelamento de forma de pagamento - so na tela de Pagamento.
        loc_oCnt.cmd_4c_CancPagto.Enabled = (loc_lFpagtoVisivel AND !loc_lChequeAberto)

        *-- Impressora fiscal.
        loc_oCnt.cmd_4c_Impfiscal.Enabled = (loc_lSemProduto AND !loc_lChequeAberto)

        *-- Confirmar: no legado "Return (ThisForm.Inicia)". Cancelar fica
        *-- SEMPRE disponivel (Cancel = .T. no SCX) - a saida da tela nunca
        *-- pode ficar bloqueada.
        loc_oCnt.cmd_4c_Ok.Enabled      = loc_lInicia
        loc_oCnt.cmd_4c_Cancela.Enabled = .T.
    ENDPROC

ENDDEFINE
