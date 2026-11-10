# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigopinf.prg] Marcador: *     TODO

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg):
*==============================================================================
* Formsigopinf.prg - Informacoes Gerais da Operacao
* Origem: SIGOPINF.SCX (task751)
* Herda de: FormBase
* Tipo: OPERACIONAL (layout FLAT - o dump do SCX nao declara PageFrame nenhum;
*       cntSombra e a unica faixa de titulo, e todos os demais containers -
*       cntBotoes, cmdCotacao, cmdEntrega, cntVolumes, cntObservacao,
*       cntProtocolo, cntEntrega, cntCodigos, cntDocumentos, cntEcfs, cntNemps,
*       cntEmiss, cntEntregas, cntRecepcaos, cntPrzEnts, cntPedido, CntObs2,
*       cntLivre - penduram DIRETO no Form, lado a lado)
*
* Esta tela e um DIALOGO FILHO aberto pela tela de movimentacao/operacao, que
* lhe passa 4 parametros no Init:
*   Lparameters pForm, pData, plAltDireta, plAutomatico
* Ela edita um SUBCONJUNTO de colunas do cursor de trabalho do form pai
* (TprMvCab, equivalente a SigMvCab) - a maioria dos controles escreve direto
* nesse cursor via ControlSource no legado, e o UNICO caminho de gravacao
* SQL direta desta tela e o UPDATE pontual de Obses em modo CONSULTAR com
* acesso ALTINFO liberado (ver sigopinfBO.Atualizar(), das Fases 1-2).
*
* FASE 3/8 - ESTRUTURA BASE. Entrega:
*   - DEFINE CLASS sobre FormBase com as propriedades visuais do dump
*     (Width/Height/Caption/BackColor/FontName/FontSize - analise.json)
*   - Init(): recebe os 4 parametros do form pai na MESMA ordem posicional do
*     Lparameters legado, guarda-os e delega a FormBase.Init() por
*     DODEFAULT(), que chama InicializarForm()
*   - InicializarForm(): instancia o sigopinfBO das Fases 1-2 e monta a casca
*     visual (cabecalho)
*   - SincronizarEscolhaPai(): copia o modo do form pai (this_cModoAtual), tal
*     como o Init legado faz com ".pcEscolha = ThisForm.ParentForm.pcEscolha"
*     - leitura UNICA no momento da abertura, nao referencia viva
*   - DesabilitarFormPai()/ReabilitarFormPai(): o
*     "ThisForm.ParentForm.Enabled = .f." do Init legado e o reverso no
*     fechamento - este dialogo nao e modal (WindowType nao declarado no
*     dump), e o legado impede a interacao com o pai manualmente
*   - ConfigurarCabecalho(): a faixa cinza do topo (cntSombra do legado) com
*     o titulo duplicado - sombra preta atras, texto branco por cima
*   - TornarControlesVisiveis() e Destroy()
*
* FASE 4/8 - BOTOES DE ACAO. Entrega:
*   - ConfigurarBotoesAcao(): os 3 CommandGroup de botao unico que o dump
*     pendura direto no Form (cntBotoes/cmdCotacao/cmdEntrega ->
*     obj_4c_CntBotoes/obj_4c_CmdCotacao/obj_4c_CmdEntrega), criados DEPOIS
*     do cabecalho para desenhar por cima da faixa (Top=-2)
*   - CmdCotacaoClick()/CmdEntregaClick(): logica COMPLETA (abrem os
*     dialogos JA MIGRADOS FormSigPrCtc/FormSigOpEnt, transcricao de
*     cmdCotacao.Valid/cmdEntrega.Valid do legado) - nao dependem de
*     nenhum container criado em fase posterior
*   - AtualizarVisibilidadeCmdEntrega(): "cmdEntrega.Visible =
*     InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(pcEscolha,'INSERIR',
*     'EXCLUIR')" do Init legado - crSigCdOpe ainda nao e carregado nesta
*     fase (CursorQuery do Init legado, fases seguintes), entao o botao
*     comeca oculto (falso seguro) at? alguma fase futura popular o cursor
*     e chamar este metodo de novo
*   - obj_4c_CntBotoes ("Salvar") e criado so visualmente: o Click dele
*     (SIGOPINF.cntBotoes.Click, 170 linhas) depende de containers
*     (cntObservacao/cntEmiss/cntEntregas/cntRecepcaos/cntEcfs/cntNemps)
*     e cursores (crSigCdOpe/CrSigOpCdc/xPar/crTpmMvItn) ainda nao
*     existentes - a acao principal da tela fica para a Fase 8
*
* FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1). Entrega a primeira metade dos
* containers de dados que pendulam direto no Form (layout.json), todos
* COM ControlSource = "TprMvCab.<col>" (igual ao legado - estes controles
* escrevem direto no cursor de trabalho do form pai, nao no BO):
*   - ConfigurarCamposDocumentos(): cntCodigos/cntDocumentos/cntEcfs/
*     cntNemps (mapeamento.json: cnt_4c_Codigos/cnt_4c_Documentos/
*     cnt_4c_Ecfs/cnt_4c_Nemps). getCodigos.When sempre .F. (campo nunca
*     editavel - MascNum e so exibicao); getDocumentos/GetNumeroNota.When
*     depende de crSigCdOpe (cursor do Init legado, ainda nao portado -
*     falso seguro ate existir); getNemps.Valid consulta SIGFIMPF via
*     fDecriptografar (wrapper utils/fdecriptografar.prg)
*   - ConfigurarCamposDatas(): cntEmiss/cntEntregas/cntRecepcaos/
*     cntPrzEnts (cnt_4c_Emiss/cnt_4c_Entregas/cnt_4c_Recepcaos/
*     cnt_4c_PrzEnts). Os 4 compartilham o mesmo Valid (data minima
*     01/01/1900) via ValidarDataMinima(); getEntregas.When e o UNICO
*     que so libera em INSERIR (os outros tres liberam em INSERIR E
*     ALTERAR) - Prz. Entrega so e alteravel depois pelo cmdEntrega
*     (Fase 4, CmdEntregaClick)
* FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2). Entrega os 7 containers
* que faltavam (todos ainda com ControlSource = "TprMvCab.<col>", como no
* legado):
*   - ConfigurarVolumes(): cntVolumes (5 campos de transporte), When
*     compartilhado (VolumesWhen)
*   - ConfigurarObservacao(): cntObservacao - getCodObs com o lookup
*     completo do legado (faixa ObsIni/ObsFins de SigCdOpe, fallback
*     FormBuscaAuxiliar em SigCdObs), getDesObs com o gate ALTINFO
*     (fChecaAcesso) e btnMultObs (abre SigOpIns - fora do acervo,
*     AvisarLegadoNaoPortado)
*   - ConfigurarProtocolo(): cntProtocolo (reaproveita PadraoIncluirAlterarWhen)
*   - ConfigurarEntrega(): cntEntrega - getContas/getDConta/getCpfs com o
*     lookup de conta em SigCdCli (checagem de acesso via fAcessoContas em
*     modo BACKEND - sem pSt1/pSt2 - regra do projeto contra auto-load de
*     UI, FormBuscaAuxiliar para o restante) e cmdEntrega ("Local de
*     Entrega", abre SigCdEnd - fora do acervo, AvisarLegadoNaoPortado)
*   - ConfigurarPedido()/ConfigurarObs2()/ConfigurarLivre(): cntPedido,
*     CntObs2 (abre SigOpIns - fora do acervo) e cntLivre
*   - KeyPress do Form (F2/F3 do legado) para os dois botoes de navegacao
*     por atalho, agora que cntEntrega.cmd_4c_CmdEntrega existe
*
* FASE 7/8 - EVENTOS PRINCIPAIS DO CICLO DE VIDA. Este dialogo NAO tem
* botoes de Incluir/Alterar/Visualizar/Excluir (nao e form CRUD - ver
* comentario de cabecalho acima, "Tipo: OPERACIONAL"); o template generico
* de Fase 7 (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
* BtnExcluirClick) nao se aplica aqui e NAO foi criado - inventar esses
* quatro metodos seria codigo morto, sem botao nenhum para dispara-los, e
* violaria o PILAR 1 (o legado nao tem essas acoes nesta tela). Os
* "eventos principais" reais desta tela sao o que falta do Init legado
* (205 linhas) para o form deixar de operar em modo falso-seguro. Entrega:
*   - CarregarCursoresOperacao(): "With ThisForm.ParentForm.poDataMgr /
*     .Cursorquery('SigCdOpe','CrSigCdOpe','Dopes',TprMvCab.Dopes) /
*     .Cursorquery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes) /
*     .Cursorquery('SigOpCdd','CrSigOpCdd','Dopes',TprMvCab.Dopes)" do Init
*     legado (a 4a CursorQuery, SigCdEmp/CrEmp, fica de fora - so e usada
*     no bloco "Carrega Dados da Conta", que depende de
*     ThisForm.ParentForm.pEmps, propriedade do form pai fora do escopo
*     desta tela). Chamada ANTES de ConfigurarBotoesAcao() para que
*     AtualizarVisibilidadeCmdEntrega() (Fase 4) ja tenha crSigCdOpe
*     carregado na primeira passada.
*   - AtualizarVisibilidadePorOperacao(): o corpo do Init legado que liga
*     Visible/Caption de cada container ao tipo de operacao (DigObs,
*     DtEntrs, CupFis, DadosNotas, PedClis, EditProts, DigDoc, DtEmis,
*     DigRecs, PrzLjs, ConfigGers). Chamada DEPOIS de
*     TornarControlesVisiveis(THIS) - este ultimo reescreve Visible=.T. em
*     TODO AddObject recursivamente, entao aplicar a regra de negocio
*     ANTES dele seria desfeita; depois dele e que a visibilidade real do
*     tipo de operacao prevalece. Reaplica AtualizarVisibilidadeCmdEntrega()
*     no fim, pela mesma razao.
*   - CarregarPrazoEntregaPadrao(): "PROCEDURE carregaprzent" do legado -
*     sugere data de entrega padrao (hoje, ou hoje + prazo minimo/maximo
*     do tipo de operacao, ou hoje + prazo de entrega cadastrado na conta
*     em SigCdCli.PrazoEnts) quando o campo ainda esta vazio ou e hoje.
*   - AjustarPosicaoCampos(): "PROCEDURE ajustaobjs" do legado - reflui os
*     containers da 1a/2a linha e os de baixo (Observacao/Entrega/Volumes)
*     preenchendo o espaco dos que ficaram ocultos pela visibilidade
*     calculada acima - mesma formula, Left/Top acumulados a partir da
*     origem de cnt_4c_Codigos.
*
* DELIBERADAMENTE FORA DESTA FASE (falso seguro documentado nos proprios
* metodos novos, nao omitido em silencio):
*   - Bloco "Carrega Dados da Conta" do Init (crSigCdOpe.Opers=2): le
*     ThisForm.ParentForm.Pagina.Dados.pgfprincipal.pgcontas.Destino.
*     Get_Conta/Get_DConta/Get_Cpf e o cursor TmpOperacao (grade de itens
*     do movimento) - nenhum dos dois pertence a este dialogo nem esta
*     disponivel nele.
*   - Override do ObsPads por CFOP (SigCdOop + crSigMvNfi.CfoSubs/Cfis):
*     so se aplica quando CrSigOpCdd.ChkCFOP <> 2; sem crSigMvNfi (grade
*     de itens, fora desta tela), a observacao padrao usa direto
*     crSigCdOpe.ObsPads - que E o comportamento do legado quando
*     ChkCFOP = 2, entao nao e invencao, e uma reproducao parcial e fiel.
* SigCdEnd e SigOpIns (Do Form do legado) NAO vieram no acervo desta
* migracao - AvisarLegadoNaoPortado() tenta de verdade (CREATEOBJECT) e so
* avisa (MsgAviso) se a classe realmente nao existir, igual ao padrao de
* FormSigOpChi/FormSigOpCpo/Formsigopfis.
*
* As checagens que dependem de crSigCdOpe/CrSigOpCdc (situacao da conta,
* faixa de observacoes, PedClis=5, ALTINFO) seguem o "falso seguro" ja
* estabelecido na Fase 5: USED() guarda cada bloco, e sem o cursor a
* checagem extra fica de fora (a tela nao bloqueia por um dado que ainda
* nao existe nela) - esses CursorQuery pertencem ao Init legado.
*
* FASE 8/8 - ACAO PRINCIPAL (SALVAR) E ENCERRAMENTO. Entrega:
*   - BtnSalvarClick(): transcricao de "PROCEDURE btnSelItens.Click" (170
*     linhas) - as validacoes de INSERIR/ALTERAR (observacao obrigatoria,
*     data de emissao, prazo de entrega minimo/maximo com liberacao via
*     SigOpSen, recepcao, cupom fiscal/ECF) e, no ramo ELSE (CONSULTAR),
*     o UPDATE pontual de Obses via sigopinfBO.Atualizar() (Fases 1-2) sob
*     o mesmo gate ALTINFO (fChecaAcesso) de DesObsWhen (Fase 6). Termina
*     chamando THIS.FecharDialogo() - identico ao "ThisForm.Return" do
*     final de cada ramo legado.
*   - SolicitarLiberacaoPrazoEntrega(): "Do Form SigOpSen With 'LIBPRZENT',
*     ... To _Retorno" repetido para os limites Minimo/Maximo - SigOpSen
*     NAO existe na nova arquitetura (memoria
*     feedback_sigopsen_ausente_gate_autorizacao); tratado FAIL-CLOSED,
*     mesmo padrao canonico de FormSigOpEnt.SolicitarLiberacaoPrazo.
*   - RecalcularVencimentosParcelas()/CarregarFeriados()/
*     AvancarAlemDosFeriados(): laco de feriados do btnSelItens.Click
*     (recalculo de vencimento das parcelas em "xPar" quando o Prazo de
*     Entrega muda), mesmo padrao de FormSigOpFpg.CarregarFeriados -
*     guardado por USED("xPar"): esse cursor pertence ao form PAI (grade
*     de parcelas da operacao), que nao existe no acervo desta migracao
*     (nenhum caller de Formsigopinf - ver DataSession abaixo); sem ele o
*     recalculo fica de fora, falso seguro documentado.
*   - FecharDialogo(): "PROCEDURE return" do legado - propaga
*     this_lValidOk ao form pai (thisform.parentform.validok) e fecha com
*     THIS.Release() (nao Hide(): esta classe nao isola DataSession, ver
*     comentario abaixo, entao Release() e seguro e fiel ao
*     "ThisForm.release" legado). A reabilitacao do pai ja acontece em
*     Destroy() (Fase 3) - Release() dispara Destroy() antes de destruir
*     o objeto.
*   - ProcessarLancamentoDireto(): ramo "If ThisForm.Direta" do "PROCEDURE
*     return" legado (empilha TprMvCab em CrSigMvCab para commit em lote
*     + recalculo de SigMvPar). CrSigMvCab e o commit em lote (antigo
*     ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
*     form PAI/orquestrador da operacao, inexistente no acervo - guardado
*     por USED("CrSigMvCab"), falso seguro documentado (nao se arrisca
*     ZAP em TprMvCab sem ter onde o lote foi persistido).
*
* NAO ha ConfigurarPageFrame/ConfigurarPaginaLista/ConfigurarPaginaDados nem
* AlternarPagina aqui: o SCX legado nao declara PageFrame (nenhuma linha
* "BaseClass: pageframe" no dump) e portanto nao ha pagina para configurar
* nem para alternar. Inventar Page1=Lista/Page2=Dados que o legado nao tem
* violaria o PILAR 1. O layout e FLAT: todos os containers penduram DIRETO
* no Form, como no dump (layout.json).
*
* DataSession: o Init legado faz "Set DataSession To pData" para operar na
* MESMA sessao do form pai (edita o cursor TprMvCab dele). Esta classe NAO
* sobrescreve DataSession (fica no default VFP9 = 1, "Default"), que e o
* equivalente OOP mais proximo - o form nasce na sessao ativa de quem o
* instancia, normalmente o proprio form pai. O numero pData recebido e
* guardado em this_nDataSessionPai so para as fases seguintes decidirem como
* alcancar o cursor do pai (o sigopinfBO.CarregarDoCursor(par_cAliasCursor)
* das Fases 1-2 ja recebe o NOME do alias, nao um numero de sessao).
*==============================================================================

DEFINE CLASS Formsigopinf AS FormBase
	ShowWindow = 1
	WindowType = 1

    *--------------------------------------------------------------------------
    * PROPRIEDADES VISUAIS - transcritas do dump (analise.json/layout.json)
    *--------------------------------------------------------------------------
    Width       = 1000
    Height      = 600
    BackColor   = RGB(100, 100, 100)
    FontName    = "Tahoma"
    FontSize    = 8
    Caption     = "Informa" + CHR(231) + CHR(245) + "es Gerais"
    KeyPreview  = .T.    && dump: KeyPreview = .T. - Form intercepta F2/F3 antes dos controles (Fase 6, KeyPress)

    *--------------------------------------------------------------------------
    * REFERENCIA AO FORM PAI (pForm do Lparameters legado)
    *
    * E relacao de UI, nao dado de negocio - por isso fica como propriedade
    * permanente do Form (nao transita para o BO). Fica .NULL. quando o form
    * e instanciado sem pai (harness de teste, probe headless), e todo uso
    * dela e guardado por VARTYPE.
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * ESTADO DE WORKFLOW copiado do form pai no momento da abertura
    *
    *   this_cPcEscolha   <- ThisForm.ParentForm.pcEscolha (legado)
    *   this_lDireta      <- plAltDireta -> ThisForm.Direta (legado)
    *   this_lAutomatico  <- plAutomatico -> ThisForm.Automatico (legado)
    *
    * O legado consulta ThisForm.pcEscolha em varios When/Valid ao longo do
    * form (ex.: "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')").
    * Aqui ela e copiada UMA vez em SincronizarEscolhaPai(), nao referenciada
    * ao vivo no form pai - identico ao comportamento legado.
    *--------------------------------------------------------------------------
    this_cPcEscolha  = ""
    this_lDireta     = .F.
    this_lAutomatico = .F.

    *--------------------------------------------------------------------------
    * CARREGADOR DO PARAMETRO DE SESSAO (transiente)
    *
    * pData e numero de DataSession no legado (procedural). Guardado aqui so
    * para as fases seguintes decidirem como alcancar o cursor TprMvCab do
    * form pai - ver comentario de cabecalho do arquivo.
    *--------------------------------------------------------------------------
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * this_lValidOk - "thisform.validok" do legado (Fase 8, BtnSalvarClick/
    * SolicitarLiberacaoPrazoEntrega): marca que o usuario JA liberou o
    * prazo de entrega fora da faixa minima/maxima via SigOpSen NESTA
    * gravacao, para nao abrir o dialogo de senha duas vezes (uma para o
    * minimo, outra para o maximo) quando a mesma liberacao cobre os dois.
    * Propagado para this_oFormPai.this_lValidOk em FecharDialogo(), igual a
    * "thisform.parentform.validok = thisform.validok" do legado.
    *
    * this_cFeriadosCache/this_lFeriadosCarregados - cache de SigCdFer
    * ("|AAAAMMDD|...") usado por AvancarAlemDosFeriados()/
    * CarregarFeriados(), mesmo padrao de FormSigOpFpg.CarregarFeriados -
    * evita um SELECT por parcela dentro do laco de recalculo de
    * vencimentos (RecalcularVencimentosParcelas, Fase 8).
    *--------------------------------------------------------------------------
    this_lValidOk            = .F.
    this_cFeriadosCache      = "|"
    this_lFeriadosCarregados = .F.

    *==========================================================================
    * Init - Recebe os 4 parametros do form pai e delega a FormBase.Init()
    *
    * A ordem posicional e IDENTICA ao Lparameters do legado
    *   (pForm, pData, plAltDireta, plAutomatico)
    * para que a chamada da tela de movimentacao
    *   CREATEOBJECT("Formsigopinf", THIS, <sessao>, <direta>, <automatico>)
    * seja transcricao direta do "Do Form SIGOPINF With ..." legado.
    *
    * Todos os argumentos sao OPCIONAIS: o harness de teste e os probes
    * headless instanciam o form sem nenhum deles, e nesse caso cada
    * propriedade mantem o default declarado acima.
    *
    * par_lDireta/par_lAutomatico usam PCOUNT() no guard, nao so VARTYPE: em
    * VFP9 parametro declarado e NAO passado chega como .F. LOGICO, de modo
    * que VARTYPE(par_lDireta) = "L" e verdade tanto para "nao passou" quanto
    * para "passou .F." - com default .F. o resultado coincide, mas o PCOUNT
    * deixa a intencao explicita e protege de uma futura troca de default.
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_lDireta, par_lAutomatico)

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_nDataSessionPai) = "N"
            THIS.this_nDataSessionPai = par_nDataSessionPai
        ENDIF

        IF PCOUNT() >= 3 AND VARTYPE(par_lDireta) = "L"
            THIS.this_lDireta = par_lDireta
        ENDIF

        IF PCOUNT() >= 4 AND VARTYPE(par_lAutomatico) = "L"
            THIS.this_lAutomatico = par_lAutomatico
        ENDIF

        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e monta a casca visual base
    *
    * Equivale ao trecho inicial do Init legado (captions do cabecalho,
    * ParentForm.Enabled = .f. e LockScreen) - a parte de CursorQuery/SQL do
    * Init legado pertence as fases de dados (4 em diante).
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
    * TRY/CATCH e proibido em VFP9.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.LockScreen = .T.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopinfBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar sigopinfBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "Formsigopinf.InicializarForm")
            ELSE
                THIS.SincronizarEscolhaPai()
                THIS.DesabilitarFormPai()
                THIS.CarregarCursoresOperacao()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarCamposDocumentos()
                THIS.ConfigurarCamposDatas()
                THIS.ConfigurarVolumes()
                THIS.ConfigurarObservacao()
                THIS.ConfigurarProtocolo()
                THIS.ConfigurarEntrega()
                THIS.ConfigurarPedido()
                THIS.ConfigurarObs2()
                THIS.ConfigurarLivre()
                THIS.TornarControlesVisiveis(THIS)
                THIS.AtualizarVisibilidadePorOperacao()
                THIS.AjustarPosicaoCampos()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopinf.InicializarForm")
        ENDTRY
        THIS.LockScreen = .F.

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SincronizarEscolhaPai - copia this_cModoAtual do form pai, reproduzindo
    * ".pcEscolha = ThisForm.ParentForm.pcEscolha" do Init legado. Guardado
    * por PEMSTATUS porque o form pai e OPCIONAL (probe headless) e porque
    * nesta arquitetura o nome da propriedade de modo e this_cModoAtual
    * (FormBase), nao o "pcEscolha" literal do legado.
    *==========================================================================
    PROTECTED PROCEDURE SincronizarEscolhaPai()
        IF VARTYPE(THIS.this_oFormPai) = "O" ;
           AND PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
            THIS.this_cPcEscolha = THIS.this_oFormPai.this_cModoAtual
        ENDIF
    ENDPROC

    *==========================================================================
    * DesabilitarFormPai - "ThisForm.ParentForm.Enabled = .f." do Init legado.
    * Este dialogo nao e modal (o dump nao declara WindowType = 1), e o
    * legado impede a interacao com o pai desabilitando-o manualmente
    * enquanto a tela de informacoes esta aberta. Revertido em
    * ReabilitarFormPai(), chamado no Destroy().
    *==========================================================================
    PROTECTED PROCEDURE DesabilitarFormPai()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * ReabilitarFormPai - reverso de DesabilitarFormPai, chamado no Destroy().
    *==========================================================================
    PROTECTED PROCEDURE ReabilitarFormPai()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
    * titulo do form desenhado duas vezes: lblSombra em preto atras e
    * lblTitulo em branco por cima, 1px acima, o que produz o relevo -
    * exatamente como o Init legado faz nas duas primeiras linhas:
    *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
    *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
    *
    * Geometria transcrita do dump (layout.json), com UMA correcao
    * deliberada de Width: o SCX declara cntSombra.Width = 1100 e os dois
    * labels com Width = 769, enquanto o proprio Form tem Width = 1000 - o
    * container do cabecalho foi desenhado no Form Designer mais largo que a
    * janela (sobreposicao herdada do SCX, regra #28/#30). Copiar os
    * literais deixaria uma faixa clara exposta a direita ou cortaria o
    * titulo. Por isso o container acompanha THIS.Width e os labels ficam em
    * THIS.Width - 20, que com Left = 10 fecha exatamente na borda.
    * Top/Height/Font/ForeColor/Alignment/BackStyle seguem o dump.
    *
    * AutoSize = .F. explicito: o dump declara WordWrap = .T. nos dois
    * labels, e AutoSize em Label criado por AddObject e no-op para a
    * largura e, com WordWrap, chega a DESCARTAR a Height - a legenda
    * colapsaria para uma linha (regra #23). Width e Height vem do dump, que
    * ja sao o auto-size calculado pelo Form Designer.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Left      = 10
            .Top       = 18
            .Width     = THIS.Width - 20
            .Height    = 40
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Left      = 10
            .Top        = 17
            .Width     = THIS.Width - 20
            .Height    = 46
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Os tres CommandGroup de botao unico que o dump
    * pendura direto no Form, ao lado do cabecalho (cntBotoes/cmdCotacao/
    * cmdEntrega - layout.json: Top=-2, Left 920/845/770, Width/Height=85,
    * ButtonCount=1). Mapeamento (mapeamento.json): obj_4c_CntBotoes/
    * obj_4c_CmdCotacao/obj_4c_CmdEntrega. Criados DEPOIS do cabecalho para
    * desenhar por cima da faixa (Top=-2 cobre a borda superior dela).
    *
    * obj_4c_CntBotoes (legado: Command1.Name = "btnSelItens", Caption
    * "\<Salvar") e a acao principal da tela - 170 linhas de validacao e
    * gravacao em SIGOPINF.cntBotoes.Click, implementadas em
    * BtnSalvarClick() (Fase 8) depois que os containers que ela usa
    * (cntObservacao/cntEmiss/cntEntregas/cntRecepcaos/cntEcfs/cntNemps)
    * ja existem (Fases 5-6) e os cursores do Init legado ja sao carregados
    * (crSigCdOpe/CrSigOpCdc, Fase 7).
    *
    * obj_4c_CmdCotacao e obj_4c_CmdEntrega abrem dialogos JA MIGRADOS
    * (FormSigPrCtc/FormSigOpEnt) e tem Click com logica COMPLETA nesta
    * fase - nao dependem de nenhum container criado em fase posterior.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oGrp

        *-- obj_4c_CntBotoes: botao "Salvar" (Click -> BtnSalvarClick, Fase 8)
        THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
        loc_oGrp = THIS.obj_4c_CntBotoes
        WITH loc_oGrp
            .Top           = -2
            .Left          = 920
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrp.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption         = "\<Salvar"
            .MousePointer    = 15
            .ToolTipText     = "Gravar os Dados Informados"
            .SpecialEffect   = 0
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
        ENDWITH
        BINDEVENT(loc_oGrp, "Click", THIS, "BtnSalvarClick")

        *-- obj_4c_CmdCotacao: abre FormSigPrCtc (cmdCotacao.Valid legado)
        THIS.AddObject("obj_4c_CmdCotacao", "CommandGroup")
        loc_oGrp = THIS.obj_4c_CmdCotacao
        WITH loc_oGrp
            .Top           = -2
            .Left          = 845
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrp.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
            .Caption         = "\<Cota" + CHR(231) + CHR(227) + "o"
            .MousePointer    = 15
            .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(227) + "o Informativa"
            .SpecialEffect   = 0
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
        ENDWITH
        BINDEVENT(loc_oGrp, "Click", THIS, "CmdCotacaoClick")

        *-- obj_4c_CmdEntrega: abre FormSigOpEnt (cmdEntrega.Valid legado)
        THIS.AddObject("obj_4c_CmdEntrega", "CommandGroup")
        loc_oGrp = THIS.obj_4c_CmdEntrega
        WITH loc_oGrp
            .Top           = -2
            .Left          = 770
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oGrp.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
            .Caption         = "\<Entrega"
            .MousePointer    = 15
            .ToolTipText     = "Alterar Prazo de Entrega <F3>"
            .SpecialEffect   = 0
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
        ENDWITH
        BINDEVENT(loc_oGrp, "Click", THIS, "CmdEntregaClick")

        THIS.AtualizarVisibilidadeCmdEntrega()
    ENDPROC

    *==========================================================================
    * ConfigurarCamposDocumentos - cntCodigos/cntDocumentos/cntEcfs/cntNemps
    * (layout.json/mapeamento.json: cnt_4c_Codigos/cnt_4c_Documentos/
    * cnt_4c_Ecfs/cnt_4c_Nemps). Geometria e propriedades transcritas do
    * dump (SECAO 2 de sigopinf_form_codigo_fonte.txt) - containers com
    * BackStyle = 0 (transparentes, mostram o BackColor cinza do Form) e
    * labels classe "say" com ForeColor = RGB(90,90,90) EXPLICITO no dump
    * (nao e o default inferido da regra #12 - aqui o legado DECLARA esse
    * valor, entao e so transcricao).
    *
    * Todos os TextBox tem ControlSource = "TprMvCab.<col>" - igual ao
    * legado, estes controles escrevem direto no cursor de trabalho do
    * form pai. Sem TprMvCab aberto (harness/probe headless), a atribuicao
    * de ControlSource e pulada (regra: Alias inexistente estoura ao
    * atribuir ControlSource, nao so ao exibir) e os campos ficam sem
    * binding, inofensivo fora do fluxo real.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposDocumentos()
        LOCAL loc_oCnt, loc_lTemCursorPai
        loc_lTemCursorPai = USED("TprMvCab")

        *-- cnt_4c_Codigos (legado: cntCodigos) -----------------------------
        THIS.AddObject("cnt_4c_Codigos", "Container")
        loc_oCnt = THIS.cnt_4c_Codigos
        WITH loc_oCnt
            .Top         = 96
            .Left        = 2
            .Width       = 67
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblCodigos", "Label")
        WITH loc_oCnt.lbl_4c_LblCodigos
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "C" + CHR(243) + "digo "
            .Left      = 3
            .Top       = 3
            .Width     = 61
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oCnt.txt_4c_Codigos
            .FontBold      = .T.
            .FontSize      = 8
            .Left          = 3
            .Top           = 20
            .Width         = 61
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Codigos.ControlSource = "TprMvCab.mascnum"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Codigos, "When", THIS, "CodigosWhen")

        *-- cnt_4c_Documentos (legado: cntDocumentos) -----------------------
        THIS.AddObject("cnt_4c_Documentos", "Container")
        loc_oCnt = THIS.cnt_4c_Documentos
        WITH loc_oCnt
            .Top         = 96
            .Left        = 69
            .Width       = 170
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblDocumentos", "Label")
        WITH loc_oCnt.lbl_4c_LblDocumentos
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Documento"
            .Left      = 3
            .Top       = 3
            .Width     = 56
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Documentos", "TextBox")
        WITH loc_oCnt.txt_4c_Documentos
            .Left          = 3
            .Top           = 20
            .Width         = 67
            .Margin        = 0
            .MaxLength     = 6
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Documentos.ControlSource = "TprMvCab.notas"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Nota"
            .Left      = 73
            .Top       = 3
            .Width     = 25
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_NumeroNota", "TextBox")
        WITH loc_oCnt.txt_4c_NumeroNota
            .Left          = 73
            .Top           = 20
            .Width         = 94
            .Height        = 23
            .Margin        = 0
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_NumeroNota.ControlSource = "TprMvCab.NumeroNota"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_NumeroNota, "When", THIS, "DocumentosWhen")

        *-- cnt_4c_Ecfs (legado: cntEcfs) ------------------------------------
        THIS.AddObject("cnt_4c_Ecfs", "Container")
        loc_oCnt = THIS.cnt_4c_Ecfs
        WITH loc_oCnt
            .Top         = 96
            .Left        = 240
            .Width       = 65
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEcfs", "Label")
        WITH loc_oCnt.lbl_4c_LblEcfs
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "ECF  "
            .Left      = 3
            .Top       = 3
            .Width     = 27
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Ecfs", "TextBox")
        WITH loc_oCnt.txt_4c_Ecfs
            .Left          = 3
            .Top           = 20
            .Width         = 59
            .Height        = 23
            .Margin        = 0
            .InputMask     = "9999999"
            .MaxLength     = 7
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Ecfs.ControlSource = "TprMvCab.ecfs"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Ecfs, "When", THIS, "PadraoIncluirAlterarWhen")

        *-- cnt_4c_Nemps (legado: cntNemps) ----------------------------------
        THIS.AddObject("cnt_4c_Nemps", "Container")
        loc_oCnt = THIS.cnt_4c_Nemps
        WITH loc_oCnt
            .Top         = 96
            .Left        = 305
            .Width       = 156
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblNemps", "Label")
        WITH loc_oCnt.lbl_4c_LblNemps
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "N" + CHR(186) + " S" + CHR(233) + "rie Imp."
            .Left      = 3
            .Top       = 3
            .Width     = 66
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Nemps", "TextBox")
        WITH loc_oCnt.txt_4c_Nemps
            .Left          = 3
            .Top           = 20
            .Width         = 150
            .Height        = 23
            .Margin        = 0
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Nemps.ControlSource = "TprMvCab.nemps"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Nemps, "When",      THIS, "PadraoIncluirAlterarWhen")
        BINDEVENT(loc_oCnt.txt_4c_Nemps, "LostFocus",  THIS, "NempsLostFocus")
    ENDPROC

    *==========================================================================
    * CodigosWhen - "Return .f." do legado (getCodigos.When): o campo
    * Codigo/MascNum e so exibicao, nunca editavel em nenhum modo.
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION CodigosWhen()
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * DocumentosWhen - "Return ( Inlist( ThisForm.pcEscolha, 'INSERIR',
    * 'ALTERAR' ) And Not InList(crSigCdOpe.NFiscals,1,2) And Not
    * InList(CrSigCdOpe.DigDoc,4,5) )" do legado - compartilhado por
    * getDocumentos.When e GetNumeroNota.When (texto identico no dump).
    * crSigCdOpe e o cursor que o CursorQuery do Init legado popula (ainda
    * nao portado - fases seguintes); sem ele, falso seguro (campo fica
    * nao-editavel).
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION DocumentosWhen()
        LOCAL loc_lPermite
        loc_lPermite = .F.

        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("crSigCdOpe")
            loc_lPermite = !INLIST(crSigCdOpe.NFiscals, 1, 2) ;
                AND !INLIST(crSigCdOpe.DigDoc, 4, 5)
        ENDIF

        RETURN loc_lPermite
    ENDFUNC

    *==========================================================================
    * PadraoIncluirAlterarWhen - "Return Inlist(ThisForm.pcEscolha,
    * 'INSERIR', 'ALTERAR')" do legado - texto IDENTICO em getEcfs.When,
    * getNemps.When, getEmiss.When, getRecepcaos.When e getPrzEnts.When
    * (compartilhado pelos cinco).
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION PadraoIncluirAlterarWhen()
        RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
    ENDFUNC

    *==========================================================================
    * NempsLostFocus - "If Not Empty(This.Value) / lnNoFabr = This.Value /
    * lcImpf = fDecriptografar(alltrim(lnNoFabr)) / lcWhere = [Select *
    * From SIGFIMPF Where cimpfabs = ?lcImpf ] / ... MessageBox / Return
    * .f." do legado (getNemps.Valid). fDecriptografar e o wrapper de
    * utils/fdecriptografar.prg (regra #27 - algoritmo original fora do
    * acervo, pass-through seguro). Equivalente ao "ao sair do campo" do
    * Valid legado - ver regra #47 (lookup/validacao de TextBox solto vai
    * em LostFocus, nao em KeyPress).
    *
    * PUBLIC: alvo de BINDEVENT("LostFocus").
    *==========================================================================
    PROCEDURE NempsLostFocus()
        LOCAL loc_oTxt, loc_cImpf, loc_cSQL, loc_nErro, loc_oErro

        loc_oTxt = THIS.cnt_4c_Nemps.txt_4c_Nemps

        IF !EMPTY(loc_oTxt.Value)
            TRY
                loc_cImpf = fDecriptografar(ALLTRIM(loc_oTxt.Value))
                loc_cSQL  = "SELECT * FROM SIGFIMPF WHERE cimpfabs = " + EscaparSQL(loc_cImpf)
                loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")

                IF loc_nErro < 1
                    MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (SIGFIMPF)", "Erro")
                ELSE
                    IF RECCOUNT("cursor_4c_SigFiMpF") = 0
                        MsgAviso("Impressora Fiscal n" + CHR(227) + "o Cadastrada!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                    IF USED("cursor_4c_SigFiMpF")
                        USE IN cursor_4c_SigFiMpF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao validar N" + CHR(186) + " S" + CHR(233) + "rie")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCamposDatas - cntEmiss/cntEntregas/cntRecepcaos/cntPrzEnts
    * (cnt_4c_Emiss/cnt_4c_Entregas/cnt_4c_Recepcaos/cnt_4c_PrzEnts).
    * Classe "fweditdata" no legado -> TextBox com NullDisplay = "//" (data
    * vazia exibe barras, nao branco - propriedade nativa do TextBox,
    * confirmada em automation/propriedades_baseclasses.txt).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposDatas()
        LOCAL loc_oCnt, loc_lTemCursorPai
        loc_lTemCursorPai = USED("TprMvCab")

        *-- cnt_4c_Emiss (legado: cntEmiss) ----------------------------------
        THIS.AddObject("cnt_4c_Emiss", "Container")
        loc_oCnt = THIS.cnt_4c_Emiss
        WITH loc_oCnt
            .Top         = 147
            .Left        = 2
            .Width       = 86
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEmiss", "Label")
        WITH loc_oCnt.lbl_4c_LblEmiss
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Data Emiss" + CHR(227) + "o "
            .Left      = 3
            .Top       = 3
            .Width     = 80
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Emiss", "TextBox")
        WITH loc_oCnt.txt_4c_Emiss
            .Left          = 3
            .Top           = 20
            .Width         = 80
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .NullDisplay   = "//"
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Emiss.ControlSource = "TprMvCab.dtemis"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Emiss, "When",      THIS, "PadraoIncluirAlterarWhen")
        BINDEVENT(loc_oCnt.txt_4c_Emiss, "LostFocus",  THIS, "EmissLostFocus")

        *-- cnt_4c_Entregas (legado: cntEntregas) ----------------------------
        THIS.AddObject("cnt_4c_Entregas", "Container")
        loc_oCnt = THIS.cnt_4c_Entregas
        WITH loc_oCnt
            .Top         = 147
            .Left        = 88
            .Width       = 86
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
        WITH loc_oCnt.lbl_4c_LblEntregas
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Prz. Entrega "
            .Left      = 3
            .Top       = 3
            .Width     = 80
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Entregas", "TextBox")
        WITH loc_oCnt.txt_4c_Entregas
            .Left          = 3
            .Top           = 20
            .Width         = 80
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .NullDisplay   = "//"
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Entregas.ControlSource = "TprMvCab.prazoents"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Entregas, "When",     THIS, "EntregasWhen")
        BINDEVENT(loc_oCnt.txt_4c_Entregas, "LostFocus", THIS, "EntregasLostFocus")

        *-- cnt_4c_Recepcaos (legado: cntRecepcaos) --------------------------
        THIS.AddObject("cnt_4c_Recepcaos", "Container")
        loc_oCnt = THIS.cnt_4c_Recepcaos
        WITH loc_oCnt
            .Top         = 147
            .Left        = 174
            .Width       = 86
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblRecepcaos", "Label")
        WITH loc_oCnt.lbl_4c_LblRecepcaos
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Recep" + CHR(231) + CHR(227) + "o "
            .Left      = 3
            .Top       = 3
            .Width     = 80
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Recepcaos", "TextBox")
        WITH loc_oCnt.txt_4c_Recepcaos
            .Left          = 3
            .Top           = 20
            .Width         = 80
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .NullDisplay   = "//"
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Recepcaos.ControlSource = "TprMvCab.dtrecs"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "When",     THIS, "PadraoIncluirAlterarWhen")
        BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "LostFocus", THIS, "RecepcaosLostFocus")

        *-- cnt_4c_PrzEnts (legado: cntPrzEnts) ------------------------------
        THIS.AddObject("cnt_4c_PrzEnts", "Container")
        loc_oCnt = THIS.cnt_4c_PrzEnts
        WITH loc_oCnt
            .Top         = 147
            .Left        = 260
            .Width       = 86
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblPrzEnts", "Label")
        WITH loc_oCnt.lbl_4c_LblPrzEnts
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Dt. Prometida"
            .Left      = 3
            .Top       = 3
            .Width     = 80
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PrzEnts", "TextBox")
        WITH loc_oCnt.txt_4c_PrzEnts
            .Left          = 3
            .Top           = 20
            .Width         = 80
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .NullDisplay   = "//"
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_PrzEnts.ControlSource = "TprMvCab.PRZCLIS"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "When",     THIS, "PadraoIncluirAlterarWhen")
        BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "LostFocus", THIS, "PrzEntsLostFocus")
    ENDPROC

    *==========================================================================
    * EntregasWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR')" do
    * legado (getEntregas.When) - UNICO dos 4 campos de data desta fase que
    * so libera em INSERIR (os outros liberam INSERIR E ALTERAR). Depois do
    * registro incluido, Prz. Entrega so muda pelo cmdEntrega (Fase 4,
    * CmdEntregaClick), que grava TprMvCab.PrazoEnts e espelha no campo.
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION EntregasWhen()
        RETURN INLIST(THIS.this_cPcEscolha, "INSERIR")
    ENDFUNC

    *==========================================================================
    * ValidarDataMinima - "If Not IsEmpty(This.Value) And This.Value <
    * Ctod('01/01/1900') / MessageBox('Data incorreta. Informe uma data
    * Valida!!!!',0+16,'') / Return .f. / Endif" do legado - texto IDENTICO
    * em getEmiss.Valid, getEntregas.Valid, getRecepcaos.Valid e
    * getPrzEnts.Valid (compartilhado pelos quatro). MESSAGEBOX legado ->
    * MsgAviso (validacao de UI, nao erro tecnico - regra do projeto).
    *
    * PROTECTED: chamado pelos handlers de LostFocus abaixo, nunca alvo
    * direto de BINDEVENT.
    *==========================================================================
    PROTECTED FUNCTION ValidarDataMinima(par_oTxt)
        LOCAL loc_lValido
        loc_lValido = .T.

        IF !EMPTY(par_oTxt.Value) AND par_oTxt.Value < CTOD("01/01/1900")
            MsgAviso("Data incorreta. Informe uma data v" + CHR(225) + "lida!!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * EmissLostFocus/EntregasLostFocus/RecepcaosLostFocus/PrzEntsLostFocus -
    * equivalentes ao Valid legado (ao sair do campo - regra #47), cada um
    * delegando a ValidarDataMinima() com o TextBox correspondente.
    *
    * PUBLIC: alvo de BINDEVENT("LostFocus").
    *==========================================================================
    PROCEDURE EmissLostFocus()
        THIS.ValidarDataMinima(THIS.cnt_4c_Emiss.txt_4c_Emiss)
    ENDPROC

    PROCEDURE EntregasLostFocus()
        THIS.ValidarDataMinima(THIS.cnt_4c_Entregas.txt_4c_Entregas)
    ENDPROC

    PROCEDURE RecepcaosLostFocus()
        THIS.ValidarDataMinima(THIS.cnt_4c_Recepcaos.txt_4c_Recepcaos)
    ENDPROC

    PROCEDURE PrzEntsLostFocus()
        THIS.ValidarDataMinima(THIS.cnt_4c_PrzEnts.txt_4c_PrzEnts)
    ENDPROC

    *==========================================================================
    * AvisarLegadoNaoPortado - mesmo padrao de FormSigOpChi/Formsigopfis: a
    * acao depende de um "Do Form"/funcao do legado que nao veio no acervo
    * desta migracao. Usado so DEPOIS de tentar de verdade (CREATEOBJECT no
    * CATCH, ou guarda explicita) - nunca no lugar da tentativa.
    *==========================================================================
    PROTECTED PROCEDURE AvisarLegadoNaoPortado(par_cDependencia, par_cAcao)
        MsgAviso("Esta a" + CHR(231) + CHR(227) + "o depende de " + ;
            ALLTRIM(par_cDependencia) + ", que n" + CHR(227) + "o veio no " + ;
            "acervo migrado." + CHR(13) + CHR(13) + ;
            "N" + CHR(227) + "o realizado: " + ALLTRIM(par_cAcao) + ".", ;
            "Recurso Indispon" + CHR(237) + "vel")
    ENDPROC

    *==========================================================================
    * ConfigurarVolumes - cntVolumes (cnt_4c_Volumes): "Transporte" - 5
    * campos de peso/volume do movimento. Geometria do dump (layout.json/
    * sigopinf_form_codigo_fonte.txt SECAO 2). Todos com Alignment = 3
    * (automatico - numerico alinha a direita) e ControlSource direto em
    * TprMvCab, como no legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarVolumes()
        LOCAL loc_oCnt, loc_lTemCursorPai
        loc_lTemCursorPai = USED("TprMvCab")

        THIS.AddObject("cnt_4c_Volumes", "Container")
        loc_oCnt = THIS.cnt_4c_Volumes
        WITH loc_oCnt
            .Top         = 264
            .Left        = 488
            .Width       = 509
            .Height      = 66
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oCnt.lbl_4c_Label16
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Transporte"
            .Left      = 3
            .Top       = 3
            .Width     = 100
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblQtds", "Label")
        WITH loc_oCnt.lbl_4c_LblQtds
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Qtde."
            .Left      = 3
            .Top        = 23
            .Width     = 50
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Qtds", "TextBox")
        WITH loc_oCnt.txt_4c_Qtds
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "999999"
            .MaxLength     = 6
            .Left          = 3
            .Top           = 40
            .Width         = 51
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Qtds.ControlSource = "TprMvCab.Qtdes"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")

        loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
        WITH loc_oCnt.lbl_4c_LblEspes
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Esp" + CHR(233) + "cie"
            .Left      = 57
            .Top       = 23
            .Width     = 85
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Espes", "TextBox")
        WITH loc_oCnt.txt_4c_Espes
            .Alignment     = 3
            .MaxLength     = 10
            .Left          = 57
            .Top           = 40
            .Width         = 87
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Espes.ControlSource = "TprMvCab.Espes"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")

        loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
        WITH loc_oCnt.lbl_4c_LblPLiqs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Peso L" + CHR(237) + "quido"
            .Left      = 147
            .Top       = 23
            .Width     = 75
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PLiqs", "TextBox")
        WITH loc_oCnt.txt_4c_PLiqs
            .Alignment     = 3
            .InputMask     = "99,999.99"
            .Left          = 147
            .Top           = 40
            .Width         = 73
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_PLiqs.ControlSource = "TprMvCab.PLiqs"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")

        loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
        WITH loc_oCnt.lbl_4c_LblPBrus
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Peso Bruto"
            .Left      = 223
            .Top       = 23
            .Width     = 75
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PBrus", "TextBox")
        WITH loc_oCnt.txt_4c_PBrus
            .Alignment     = 3
            .InputMask     = "99,999.99"
            .Left          = 223
            .Top           = 40
            .Width         = 73
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_PBrus.ControlSource = "TprMvCab.PBrus"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Valor Transporte"
            .Left      = 299
            .Top       = 23
            .Width     = 100
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_ValTrans", "TextBox")
        WITH loc_oCnt.txt_4c_ValTrans
            .Alignment     = 3
            .InputMask     = "999,999.99"
            .Left          = 299
            .Top           = 40
            .Width         = 90
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_ValTrans.ControlSource = "TprMvCab.ValTrans"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_ValTrans, "When", THIS, "VolumesWhen")
    ENDPROC

    *==========================================================================
    * VolumesWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')"
    * do legado, texto IDENTICO nos 5 campos de cntVolumes (getQtds/getEspes/
    * getPLiqs/getPBrus/getValTrans.When). Mesmo texto de PadraoIncluirAlterarWhen,
    * mas com nome proprio para documentar a origem (grep direto pelo nome do
    * container na auditoria).
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION VolumesWhen()
        RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
    ENDFUNC

    *==========================================================================
    * ConfigurarObservacao - cntObservacao (cnt_4c_Observacao): campo de
    * codigo/texto da observacao do movimento + botao de multiplas
    * observacoes. Geometria do dump.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarObservacao()
        LOCAL loc_oCnt, loc_lTemCursorPai
        loc_lTemCursorPai = USED("TprMvCab")

        THIS.AddObject("cnt_4c_Observacao", "Container")
        loc_oCnt = THIS.cnt_4c_Observacao
        WITH loc_oCnt
            .Top         = 228
            .Left        = 12
            .Width       = 528
            .Height      = 303
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblObservas", "Label")
        WITH loc_oCnt.lbl_4c_LblObservas
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Left      = 3
            .Top       = 23
            .Width     = 85
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
        WITH loc_oCnt.txt_4c_CodObs
            .Alignment     = 3
            .InputMask     = "999"
            .Left          = 92
            .Top           = 19
            .Width         = 32
            .Height        = 23
            .Margin        = 0
            .Value         = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_CodObs.ControlSource = "TprMvCab.CodObs"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_CodObs, "GotFocus",  THIS, "CodObsGotFocus")
        BINDEVENT(loc_oCnt.txt_4c_CodObs, "LostFocus", THIS, "CodObsLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_CodObs, "When",      THIS, "CodObsWhen")

        loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
        WITH loc_oCnt.obj_4c_GetDesObs
            .FontSize      = 8
            .Left          = 3
            .Top           = 46
            .Width         = 453
            .Height        = 254
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
        ENDIF
        BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")

        loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnMultObs
            .Top          = 5
            .Left         = 135
            .Width        = 24
            .Height       = 24
            .Caption      = ""
            .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
            .Themes       = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsObservacaoClick")
    ENDPROC

    *==========================================================================
    * CodObsGotFocus - "This.Tag = Str(This.Value, 10)" do legado (getCodObs.
    * GotFocus): guarda o valor de entrada no Tag para o LostFocus saber se
    * o usuario realmente alterou o codigo (evita reabrir o lookup so por
    * entrar/sair do campo sem digitar nada).
    *
    * PUBLIC: alvo de BINDEVENT("GotFocus").
    *==========================================================================
    PROCEDURE CodObsGotFocus()
        LOCAL loc_oTxt
        loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs
        loc_oTxt.Tag = STR(loc_oTxt.Value, 10)
    ENDPROC

    *==========================================================================
    * CodObsWhen - "ThisForm.Antvalu = This.Value / Return Inlist(
    * ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')" do legado (getCodObs.When).
    * Antvalu e bookkeeping do legado (ClassInfo do SIGOPINF - SECAO 4 do
    * dump) sem nenhum consumidor nas secoes de codigo transcritas nesta
    * migracao - a parte que importa (o gate INSERIR/ALTERAR, igual ao dos
    * demais campos) e a unica preservada.
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION CodObsWhen()
        RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
    ENDFUNC

    *==========================================================================
    * CodObsLostFocus - equivalente ao getCodObs.Valid legado (regra #47 -
    * lookup de TextBox vai em LostFocus, nao em Valid/KeyPress):
    *
    *   If Not Empty(This.Value) And Not (This.Tag = Str(This.Value, 10))
    *       <monta faixa ObsIni/ObsFins de SigCdOpe/SigCdOop>
    *       <Select Codigos, Descrs From SigCdObs Where Codigos Between ...>
    *       Set Near On / If Not Seek(...) -> fwBuscaSel / Set Near Off
    *       This.Value = crLocalObs.Codigos
    *       ThisForm.MontaObs(...)
    *   EndIf
    *
    * A faixa SigCdOop (override por CFOP, dependente de crSigMvNfi/
    * crSigOpCdd) nao esta disponivel nesta tela ainda (cursores de fases
    * seguintes) - falso seguro: a faixa fica so com o ObsIni/ObsFins de
    * SigCdOpe. fwBuscaSel -> FormBuscaAuxiliar (padrao do projeto).
    *
    * PUBLIC: alvo de BINDEVENT("LostFocus").
    *==========================================================================
    PROCEDURE CodObsLostFocus()
        LOCAL loc_oTxt, loc_nPIni, loc_nPFim, loc_cSQL, loc_nErro, ;
              loc_oBusca, loc_oErro, loc_lAchou

        loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs

        IF EMPTY(loc_oTxt.Value) OR loc_oTxt.Tag == STR(loc_oTxt.Value, 10)
            RETURN
        ENDIF

        loc_nPIni = 0
        loc_nPFim = 999
        IF USED("TprMvCab")
            loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
                "WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
            loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")

            IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_LocalOpe") > 0
                loc_nPIni = IIF(!EMPTY(cursor_4c_LocalOpe.ObsInis), cursor_4c_LocalOpe.ObsInis, 0)
                loc_nPFim = IIF(!EMPTY(cursor_4c_LocalOpe.ObsFins), cursor_4c_LocalOpe.ObsFins, 999)
            ENDIF
            IF USED("cursor_4c_LocalOpe")
                USE IN cursor_4c_LocalOpe
            ENDIF
        ENDIF

        loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos BETWEEN " + ;
            FormatarNumeroSQL(loc_nPIni, 0) + " AND " + FormatarNumeroSQL(loc_nPFim, 0)
        loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalObs")

        IF loc_nErro < 1
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (cursor_4c_LocalObs)", "Erro")
            RETURN
        ENDIF

        loc_lAchou = .F.
        IF USED("cursor_4c_LocalObs")
            SELECT cursor_4c_LocalObs
            LOCATE FOR Codigos = loc_oTxt.Value
            loc_lAchou = FOUND()
        ENDIF

        IF !loc_lAchou
            loc_oBusca = .NULL.
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdObs", "cursor_4c_BuscaObs", "Codigos", ;
                    TRANSFORM(loc_oTxt.Value), "Observa" + CHR(231) + CHR(245) + "es", ;
                    .F., .F., ;
                    "Codigos BETWEEN " + FormatarNumeroSQL(loc_nPIni, 0) + " AND " + ;
                        FormatarNumeroSQL(loc_nPFim, 0))
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao abrir busca de observa" + CHR(231) + CHR(245) + "es")
                loc_oBusca = .NULL.
            ENDTRY

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "999", "C" + CHR(243) + "d.")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou
                    loc_oTxt.Value = VAL(loc_oBusca.cCodigoSelecionado)
                ELSE
                    loc_oTxt.Value = 0
                ENDIF

                IF USED("cursor_4c_BuscaObs")
                    USE IN cursor_4c_BuscaObs
                ENDIF
                loc_oBusca.Release()
            ENDIF
        ENDIF

        IF USED("cursor_4c_LocalObs")
            USE IN cursor_4c_LocalObs
        ENDIF

        IF !EMPTY(loc_oTxt.Value)
            THIS.MontarObservacaoPadrao(loc_oTxt.Value)
        ENDIF
    ENDPROC

    *==========================================================================
    * MontarObservacaoPadrao - "ThisForm.MontaObs(ThisForm.ParentForm.
    * poDataMgr)" do legado: le SigCdObs.Observas do codigo escolhido e
    * grava em getDesObs. As 4 macros (# $ % !) do legado completam o texto
    * com dados da grade de itens do movimento (TmpOperacao, equivalente a
    * fMontaObs() - regra CLAUDE.md #27) - a grade ainda nao existe nesta
    * tela (fases seguintes); sem ela, o texto CRU (sem expansao) e gravado
    * e o usuario e avisado, nunca silenciosamente vazio.
    *
    * PROTECTED: chamado so por CodObsLostFocus.
    *==========================================================================
    PROTECTED PROCEDURE MontarObservacaoPadrao(par_nCodObs)
        LOCAL loc_cSQL, loc_nErro, loc_cObs, loc_oTxtDesc

        loc_cSQL = "SELECT Codigos, Observas FROM SigCdObs WHERE Codigos = " + ;
            FormatarNumeroSQL(par_nCodObs, 0)
        loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdObs")

        IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SigCdObs") > 0
            loc_cObs     = ALLTRIM(TratarNulo(cursor_4c_SigCdObs.Observas, "C"))
            loc_oTxtDesc = THIS.cnt_4c_Observacao.obj_4c_GetDesObs

            IF "#" $ loc_cObs OR "$" $ loc_cObs OR "%" $ loc_cObs OR "!" $ loc_cObs
                THIS.AvisarLegadoNaoPortado("fMontaObs() / grade de itens (TmpOperacao)", ;
                    "completar a observa" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o com os dados da grade")
            ENDIF

            loc_oTxtDesc.Value = loc_cObs
            loc_oTxtDesc.Refresh()
        ENDIF

        IF USED("cursor_4c_SigCdObs")
            USE IN cursor_4c_SigCdObs
        ENDIF
    ENDPROC

    *==========================================================================
    * DesObsWhen - getDesObs.When legado:
    *   IF fChecaAcesso( padl(crSigCdOpe.nDopes,8,'0'), 'ALTINFO' )
    *       Return !InList(ThisForm.pcEscolha,'EXCLUIR')
    *   Else
    *       Dodefault()     && equivalente ao When padrao do fwmemo -
    *                          mesmo texto dos demais campos (INSERIR/ALTERAR)
    *   Endif
    * Sem crSigCdOpe (cursor do Init legado, fases seguintes), cai direto
    * no ramo "Dodefault()" - e exatamente o que o legado faria se a
    * checagem nao pudesse ser avaliada.
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION DesObsWhen()
        IF USED("crSigCdOpe") AND fChecaAcesso(PADL(TRANSFORM(crSigCdOpe.nDopes), 8, "0"), "ALTINFO")
            RETURN !INLIST(THIS.this_cPcEscolha, "EXCLUIR")
        ENDIF

        RETURN THIS.VolumesWhen()
    ENDFUNC

    *==========================================================================
    * BtnMultObsObservacaoClick - btnMultObs.Valid de cntObservacao (evento
    * "Valid" num fwbtnp - mesma convencao ja adotada na Fase 4 para
    * cmdCotacao/cmdEntrega: bind no "Click", nao no "Valid"):
    *
    *   If (TprMvCab.CodObs > 0)
    *       MessageBox('Para Selecionar Multiplas Observacoes Nao Pode Ser
    *                    Informado o Codigo de Observacao')
    *       ThisForm.cntObservacao.getCodObs.SetFocus
    *       Return .f.
    *   EndIf
    *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr
    *   ThisForm.cntObservacao.getDesObs.Refresh
    *
    * SigOpIns nao veio no acervo - AvisarLegadoNaoPortado().
    *
    * PUBLIC: alvo de BINDEVENT("Click").
    *==========================================================================
    PROCEDURE BtnMultObsObservacaoClick()
        LOCAL loc_oTxtCod
        loc_oTxtCod = THIS.cnt_4c_Observacao.txt_4c_CodObs

        IF loc_oTxtCod.Value > 0
            MsgAviso("Para Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es N" + CHR(227) + "o " + ;
                "Pode Ser Informado o C" + CHR(243) + "digo de Observa" + CHR(231) + CHR(227) + "o", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oTxtCod.SetFocus()
            RETURN
        ENDIF

        THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Observa" + CHR(231) + CHR(245) + "es (SigOpIns)", ;
            "selecionar m" + CHR(250) + "ltiplas observa" + CHR(231) + CHR(245) + "es")
    ENDPROC

    *==========================================================================
    * ConfigurarProtocolo - cntProtocolo (cnt_4c_Protocolo): campo unico de
    * protocolo. When identico ao texto de PadraoIncluirAlterarWhen (regra
    * #47/Fase5) - reaproveitado sem duplicar.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarProtocolo()
        LOCAL loc_oCnt, loc_lTemCursorPai
        loc_lTemCursorPai = USED("TprMvCab")

        THIS.AddObject("cnt_4c_Protocolo", "Container")
        loc_oCnt = THIS.cnt_4c_Protocolo
        WITH loc_oCnt
            .Top         = 96
            .Left        = 461
            .Width       = 61
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblProtocolos", "Label")
        WITH loc_oCnt.lbl_4c_LblProtocolos
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Protocolo"
            .Left      = 3
            .Top       = 3
            .Width     = 55
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Protocolos", "TextBox")
        WITH loc_oCnt.txt_4c_Protocolos
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "999999"
            .MaxLength     = 6
            .Left          = 3
            .Top           = 20
            .Width         = 55
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Protocolos.ControlSource = "TprMvCab.protats"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Protocolos, "When", THIS, "PadraoIncluirAlterarWhen")
    ENDPROC

    *==========================================================================
    * ConfigurarEntrega - cntEntrega (cnt_4c_Entrega): conta/nome/cpf-cnpj
    * do destinatario da entrega + botao "Local de Entrega". Os tres campos
    * de conta sao intercambiaveis no legado (preencher um resolve os
    * outros dois) - ver ContasLostFocus/DContaLostFocus/CpfsLostFocus.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEntrega()
        LOCAL loc_oCnt, loc_lTemCursorPai
        loc_lTemCursorPai = USED("TprMvCab")

        THIS.AddObject("cnt_4c_Entrega", "Container")
        loc_oCnt = THIS.cnt_4c_Entrega
        WITH loc_oCnt
            .Top         = 192
            .Left        = 489
            .Width       = 504
            .Height      = 66
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
        WITH loc_oCnt.lbl_4c_LblEntregas
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Entrega"
            .Left      = 3
            .Top       = 3
            .Width     = 85
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblContas", "Label")
        WITH loc_oCnt.lbl_4c_LblContas
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Conta"
            .Left      = 3
            .Top       = 23
            .Width     = 70
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblCpfs", "Label")
        WITH loc_oCnt.lbl_4c_LblCpfs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "CPF / CNPJ"
            .Left      = 77
            .Top       = 23
            .Width     = 56
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblDConta", "Label")
        WITH loc_oCnt.lbl_4c_LblDConta
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Nome"
            .Left      = 210
            .Top       = 23
            .Width     = 29
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Contas", "TextBox")
        WITH loc_oCnt.txt_4c_Contas
            .MaxLength     = 10
            .Left          = 3
            .Top           = 40
            .Width         = 72
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Contas.ControlSource = "TprMvCab.contaes"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Contas, "LostFocus", THIS, "ContasLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_Contas, "When",      THIS, "PadraoIncluirAlterarWhen")

        loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
        WITH loc_oCnt.txt_4c_Cpfs
            .Left          = 77
            .Top           = 40
            .Width         = 131
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Cpfs, "LostFocus", THIS, "CpfsLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_Cpfs, "When",      THIS, "EntregaCamposLiberadosWhen")

        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .Left          = 210
            .Top           = 40
            .Width         = 285
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "When",      THIS, "EntregaCamposLiberadosWhen")

        loc_oCnt.AddObject("cmd_4c_CmdEntrega", "CommandButton")
        WITH loc_oCnt.cmd_4c_CmdEntrega
            .Top             = 0
            .Left            = 455
            .Width           = 24
            .Height          = 24
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
            .ToolTipText     = "Local de Entrega"
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_CmdEntrega, "Click", THIS, "EntregaLocalClick")
    ENDPROC

    *==========================================================================
    * ContasLostFocus/DContaLostFocus/CpfsLostFocus - equivalentes ao Valid/
    * LostFocus legado de getContas/getDConta/getCpfs (regra #47). Os tres
    * campos sao intercambiaveis: preencher QUALQUER um localiza a conta em
    * SigCdCli e preenche os outros dois.
    *
    * fAcessoContas(..., pSt1=.NULL., pSt2=.NULL.) - modo BACKEND (regra do
    * projeto: AcessoContas() NUNCA em modo lookup-UI, que auto-popula com o
    * PRIMEIRO registro que contem o valor digitado - aqui ele so confere
    * ACESSO, sem objeto de TextBox nenhum).
    *
    * PUBLIC: alvo de BINDEVENT("LostFocus").
    *==========================================================================
    PROCEDURE ContasLostFocus()
        LOCAL loc_oTxt, loc_cValor

        loc_oTxt   = THIS.cnt_4c_Entrega.txt_4c_Contas
        loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

        IF EMPTY(loc_cValor)
            THIS.LimparContaEntrega()
            RETURN
        ENDIF

        IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cValor, .NULL., .NULL.)
            MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.LimparContaEntrega()
            RETURN
        ENDIF

        IF !THIS.BuscarContaEntrega("IClis", loc_cValor)
            THIS.AbrirBuscaContaEntrega(loc_cValor, "IClis")
        ENDIF
    ENDPROC

    PROCEDURE DContaLostFocus()
        LOCAL loc_oTxt, loc_cValor

        loc_oTxt   = THIS.cnt_4c_Entrega.txt_4c_DConta
        loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF !fAcessoContas(gc_4c_UsuarioLogado, "", "D", loc_cValor, .NULL., .NULL.)
            MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.LimparContaEntrega()
            RETURN
        ENDIF

        IF !THIS.BuscarContaEntrega("RClis", loc_cValor)
            THIS.AbrirBuscaContaEntrega(loc_cValor, "RClis")
        ENDIF
    ENDPROC

    PROCEDURE CpfsLostFocus()
        LOCAL loc_oTxt, loc_cCgc, loc_cCgcFmt

        loc_oTxt = THIS.cnt_4c_Entrega.txt_4c_Cpfs
        loc_cCgc = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(loc_oTxt.Value)), ".", ""), "-", ""), "/", "")

        IF EMPTY(loc_cCgc)
            RETURN
        ENDIF

        loc_cCgcFmt = IIF(LEN(loc_cCgc) <> 14, TRANSFORM(loc_cCgc, "@R 999.999.999-99"), ;
            TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99"))
        loc_oTxt.Value = loc_cCgcFmt

        IF !THIS.BuscarContaEntrega("Cpfs", loc_cCgcFmt)
            THIS.AbrirBuscaContaEntrega(loc_cCgcFmt, "Cpfs")
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarContaEntrega - match EXATO em SigCdCli pelo campo informado
    * (Iclis/Rclis/Cpfs) - equivalente ao "Cursorquery('SigCdCli', 'CrTmpCli',
    * <campo>, <valor>)" do legado. Devolve .T. se achou (e ja preencheu os
    * tres campos, sob as checagens de ValidarContaEntregaEncontrada).
    *
    * PROTECTED: chamado so pelos LostFocus acima.
    *==========================================================================
    PROTECTED FUNCTION BuscarContaEntrega(par_cCampo, par_cValor)
        LOCAL loc_cSQL, loc_nErro, loc_lAchou
        loc_lAchou = .F.

        loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs, Situas FROM SigCdCli WHERE " + ;
            par_cCampo + " = " + EscaparSQL(par_cValor)
        loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaEntrega")

        IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_BuscaContaEntrega") > 0
            IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
                THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
                    ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
            ELSE
                THIS.LimparContaEntrega()
            ENDIF
            loc_lAchou = .T.
        ENDIF

        IF USED("cursor_4c_BuscaContaEntrega")
            USE IN cursor_4c_BuscaContaEntrega
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * AbrirBuscaContaEntrega - sem match exato, abre o picker canonico
    * (regra #36/#37) com busca parcial pelo mesmo campo.
    *
    * PROTECTED: chamado so pelos LostFocus acima.
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaContaEntrega(par_cValor, par_cCampo)
        LOCAL loc_oBusca, loc_oErro

        loc_oBusca = .NULL.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaContaEntrega", par_cCampo, par_cValor, ;
                "Conta de Entrega")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de contas")
            loc_oBusca = .NULL.
        ENDTRY

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Nome")
                loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaEntrega")
                IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
                    THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
                        ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
                ELSE
                    THIS.LimparContaEntrega()
                ENDIF
            ELSE
                THIS.LimparContaEntrega()
            ENDIF

            IF USED("cursor_4c_BuscaContaEntrega")
                USE IN cursor_4c_BuscaContaEntrega
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarContaEntregaEncontrada - as duas checagens extras do legado
    * ("If crSigCdOpe.ExibSits=4" - situacao da conta em SigCdCst, e
    * "If CrSigOpCdc.ChCtEntrs" - conta de entrega tem que ser diferente da
    * conta de origem/destino). Ambas dependem de cursores que esta tela
    * ainda nao carrega (CursorQuery do Init legado, fases seguintes) -
    * falso seguro: sem o cursor, a checagem fica de fora e a conta e
    * aceita (mesmo criterio ja usado em DocumentosWhen/AtualizarVisibilidade
    * CmdEntrega para dado ainda indisponivel).
    *
    * PROTECTED: chamado por BuscarContaEntrega/AbrirBuscaContaEntrega.
    *==========================================================================
    PROTECTED FUNCTION ValidarContaEntregaEncontrada(par_cCursor)
        LOCAL loc_lAceita, loc_cSituas, loc_cMsg, loc_cSQL, loc_nErro, loc_cIClis
        loc_lAceita = .T.

        IF USED("crSigCdOpe") AND crSigCdOpe.ExibSits = 4 AND USED(par_cCursor)
            loc_cSituas = ALLTRIM(TratarNulo(EVALUATE(par_cCursor + ".Situas"), "C"))

            IF !EMPTY(loc_cSituas)
                loc_cSQL = "SELECT Codigos, Descrs, Descr2s, DispMovs, BlqMovs, BlqDescs FROM SigCdCst " + ;
                    "WHERE Codigos = " + EscaparSQL(loc_cSituas)
                loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SituacaoConta")

                IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SituacaoConta") > 0
                    IF cursor_4c_SituacaoConta.DispMovs = 1
                        loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
                            cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
                        MsgAviso(loc_cSituas + " - " + loc_cMsg, "Situa" + CHR(231) + CHR(227) + "o")

                        IF cursor_4c_SituacaoConta.BlqMovs = 1
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o Bloqueada pela Situa" + CHR(231) + CHR(227) + "o da Conta...", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                            loc_lAceita = .F.
                        ENDIF
                    ENDIF

                    IF loc_lAceita AND USED("TprMvCab") AND TprMvCab.ValVars < 0 AND cursor_4c_SituacaoConta.BlqDescs = 1
                        loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
                            cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
                        MsgAviso(loc_cSituas + " - " + loc_cMsg + CHR(13) + ;
                            "Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o da Conta", "Situa" + CHR(231) + CHR(227) + "o")
                        loc_lAceita = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_SituacaoConta")
                    USE IN cursor_4c_SituacaoConta
                ENDIF
            ENDIF
        ENDIF

        IF loc_lAceita AND USED("crSigOpCdc") AND USED("TprMvCab") AND USED(par_cCursor)
            loc_cIClis = ALLTRIM(TratarNulo(EVALUATE(par_cCursor + ".IClis"), "C"))

            IF (crSigOpCdc.ChCtEntrs = 1 AND loc_cIClis == ALLTRIM(TprMvCab.ContaDs)) ;
               OR (crSigOpCdc.ChCtEntrs = 2 AND loc_cIClis == ALLTRIM(TprMvCab.ContaOs))
                MsgAviso("Conta de Entrega Tem que ser diferente da Conta de " + ;
                    IIF(crSigOpCdc.ChCtEntrs = 1, "Destino", "Origem"), "Aten" + CHR(231) + CHR(227) + "o")
                loc_lAceita = .F.
            ENDIF
        ENDIF

        RETURN loc_lAceita
    ENDFUNC

    *==========================================================================
    * PreencherContaEntrega/LimparContaEntrega - preenche/limpa os tres
    * campos do container E a propria TprMvCab.ContaEs (os tres campos
    * sincronizados, igual ao ".Refresh" dos tres no final de cada Valid
    * legado).
    *
    * PROTECTED: chamados pelos metodos de busca acima.
    *==========================================================================
    PROTECTED PROCEDURE PreencherContaEntrega(par_cIClis, par_cRClis, par_cCpfs)
        THIS.cnt_4c_Entrega.txt_4c_Contas.Value = par_cIClis
        THIS.cnt_4c_Entrega.txt_4c_DConta.Value = par_cRClis
        THIS.cnt_4c_Entrega.txt_4c_Cpfs.Value   = par_cCpfs

        IF USED("TprMvCab")
            REPLACE ContaEs WITH par_cIClis IN TprMvCab
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE LimparContaEntrega()
        THIS.cnt_4c_Entrega.txt_4c_Contas.Value = ""
        THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ""
        THIS.cnt_4c_Entrega.txt_4c_Cpfs.Value   = ""

        IF USED("TprMvCab")
            REPLACE ContaEs WITH "" IN TprMvCab
        ENDIF
    ENDPROC

    *==========================================================================
    * EntregaCamposLiberadosWhen - "Return Inlist(ThisForm.pcEscolha,
    * 'INSERIR', 'ALTERAR') And Empty(ThisForm.cntEntrega.getContas.Value)"
    * do legado - texto IDENTICO em getDConta.When e getCpfs.When: so
    * liberados quando a Conta (codigo) ainda nao foi preenchida (os tres
    * campos sao intercambiaveis, mas o legado da preferencia ao codigo).
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION EntregaCamposLiberadosWhen()
        RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") ;
            AND EMPTY(THIS.cnt_4c_Entrega.txt_4c_Contas.Value)
    ENDFUNC

    *==========================================================================
    * EntregaLocalClick - cntEntrega.cmdEntrega.Valid legado ("Local de
    * Entrega" - mesma convencao da Fase 4 de ligar "Valid" de fwbtnp a
    * "Click"), com o guard do When embutido (CommandButton nao tem When em
    * VFP9 nativo - "Return InList(pcEscolha,'INSERIR','ALTERAR',
    * 'CONSULTAR')" do legado vira guard no topo do handler):
    *
    *   Cursorquery('SigCdCli','crDCompCli','Iclis',TprMvCab.ContaEs,
    *       'Grupos, IClis, RClis')
    *   Do Form SigCdEnd With ..., TprMvCab.LocalEnts
    *   If InList(pcEscolha,'INSERIR','ALTERAR')
    *       fEndEntrega(@laArray, poDataMgr) -> Replace LocalEnts
    *   EndIf
    *
    * SigCdEnd nao veio no acervo - AvisarLegadoNaoPortado() no CATCH da
    * tentativa real. fEndEntrega() resolveria LocalEnts a partir do
    * RESULTADO de SigCdEnd - sem a tela, nao ha resultado confiavel para
    * gravar (o aviso acima ja cobre a ausencia).
    *
    * PUBLIC: alvo de BINDEVENT("Click").
    *==========================================================================
    PROCEDURE EntregaLocalClick()
        LOCAL loc_cSQL, loc_nErro, loc_cGrupos, loc_cIClis, loc_cRClis, loc_oDlg, loc_oErro

        IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR", "CONSULTAR") ;
           OR !USED("TprMvCab")
            RETURN
        ENDIF

        loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = " + ;
            EscaparSQL(ALLTRIM(TprMvCab.ContaEs))
        loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DCompCli")

        IF loc_nErro < 1 OR RECCOUNT("cursor_4c_DCompCli") = 0
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (SigCdCli)", "Erro")
        ELSE
            loc_cGrupos = ALLTRIM(cursor_4c_DCompCli.Grupos)
            loc_cIClis  = ALLTRIM(cursor_4c_DCompCli.IClis)
            loc_cRClis  = ALLTRIM(cursor_4c_DCompCli.RClis)

            TRY
                loc_oDlg = CREATEOBJECT("FormSigCdEnd", loc_cGrupos, loc_cIClis, loc_cRClis, ;
                    THIS.this_cPcEscolha, TprMvCab.LocalEnts)
                IF VARTYPE(loc_oDlg) = "O"
                    loc_oDlg.Show()
                ENDIF
            CATCH TO loc_oErro
                THIS.AvisarLegadoNaoPortado("Tela de Endere" + CHR(231) + "o de Entrega (SigCdEnd)", ;
                    "informar/alterar o local de entrega")
            ENDTRY
        ENDIF

        IF USED("cursor_4c_DCompCli")
            USE IN cursor_4c_DCompCli
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPedido - cntPedido (cnt_4c_Pedido): numero do pedido do
    * cliente.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPedido()
        LOCAL loc_oCnt, loc_lTemCursorPai
        loc_lTemCursorPai = USED("TprMvCab")

        THIS.AddObject("cnt_4c_Pedido", "Container")
        loc_oCnt = THIS.cnt_4c_Pedido
        WITH loc_oCnt
            .Top         = 96
            .Left        = 522
            .Width       = 61
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
        WITH loc_oCnt.lbl_4c_LblPedido
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Pedido"
            .Left      = 3
            .Top       = 3
            .Width     = 55
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Pedido", "TextBox")
        WITH loc_oCnt.txt_4c_Pedido
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "999999"
            .MaxLength     = 6
            .Left          = 3
            .Top           = 20
            .Width         = 55
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_Pedido.ControlSource = "TprMvCab.nPedClis"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_Pedido, "When", THIS, "PedidoWhen")
    ENDPROC

    *==========================================================================
    * PedidoWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
    * And Not (crSigCdOpe.PedClis = 5)" do legado (getPedido.When). Sem
    * crSigCdOpe (fases seguintes), falso seguro - mesmo criterio de
    * DocumentosWhen (bloqueia at? o dado confirmar que pode liberar).
    *
    * PUBLIC: alvo de BINDEVENT("When").
    *==========================================================================
    FUNCTION PedidoWhen()
        LOCAL loc_lPermite
        loc_lPermite = .F.

        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("crSigCdOpe")
            loc_lPermite = !(crSigCdOpe.PedClis = 5)
        ENDIF

        RETURN loc_lPermite
    ENDFUNC

    *==========================================================================
    * ConfigurarObs2 - CntObs2 (cnt_4c_Obs2): "Finalidade" - botao que abre
    * a mesma tela de multiplas observacoes (SigOpIns), mas gravando em
    * CodObs2 em vez de CodObs.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarObs2()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Obs2", "Container")
        loc_oCnt = THIS.cnt_4c_Obs2
        WITH loc_oCnt
            .Top         = 96
            .Left        = 582
            .Width       = 66
            .Height      = 64
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
        WITH loc_oCnt.lbl_4c_LblPedido
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Finalidade"
            .Left      = 3
            .Top       = 3
            .Width     = 60
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnMultObs
            .Top             = 20
            .Left            = 3
            .Width           = 24
            .Height          = 24
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
            .Themes          = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsFinalidadeClick")
    ENDPROC

    *==========================================================================
    * BtnMultObsFinalidadeClick - CntObs2.btnMultObs.Valid legado:
    *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr, TprMvCab.CodObs2
    *   replace CodObs2 with ALLTRIM(listaObs) in TprMvCab
    * SigOpIns nao veio no acervo - sem a tela (e sem a lista que ela
    * devolveria em listaObs), nao ha resultado para gravar em CodObs2.
    *
    * PUBLIC: alvo de BINDEVENT("Click").
    *==========================================================================
    PROCEDURE BtnMultObsFinalidadeClick()
        THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Finalidade (SigOpIns)", ;
            "selecionar a finalidade da opera" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * ConfigurarLivre - cntLivre (cnt_4c_Livre): numero do lacre.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLivre()
        LOCAL loc_oCnt, loc_lTemCursorPai
        loc_lTemCursorPai = USED("TprMvCab")

        THIS.AddObject("cnt_4c_Livre", "Container")
        loc_oCnt = THIS.cnt_4c_Livre
        WITH loc_oCnt
            .Top         = 189
            .Left        = 2
            .Width       = 352
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblNLivDg", "Label")
        WITH loc_oCnt.lbl_4c_LblNLivDg
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Caption   = "Lacre"
            .Left      = 3
            .Top       = 3
            .Width     = 60
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_NLivDg", "TextBox")
        WITH loc_oCnt.txt_4c_NLivDg
            .Alignment     = 3
            .MaxLength     = 15
            .Value         = 0
            .Left          = 3
            .Top           = 20
            .Width         = 169
            .Height        = 23
            .Margin        = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        IF loc_lTemCursorPai
            loc_oCnt.txt_4c_NLivDg.ControlSource = "TprMvCab.NLivDg"
        ENDIF
        BINDEVENT(loc_oCnt.txt_4c_NLivDg, "When", THIS, "PadraoIncluirAlterarWhen")
    ENDPROC

    *==========================================================================
    * AtualizarVisibilidadeCmdEntrega - "ThisForm.cmdEntrega.Visible =
    * InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(ThisForm.pcEscolha,
    * 'INSERIR','EXCLUIR')" do Init legado (linha 2100). crSigCdOpe e
    * carregado pelo CursorQuery do Init legado, ainda nao portado (fases
    * seguintes) - sem o cursor, o botao fica oculto (falso seguro); quem
    * popular crSigCdOpe numa fase posterior deve chamar este metodo de
    * novo para o botao assumir o estado real.
    *
    * PUBLIC: reutilizavel por fases/metodos futuros que alterem
    * this_cPcEscolha ou recarreguem crSigCdOpe.
    *==========================================================================
    PROCEDURE AtualizarVisibilidadeCmdEntrega()
        LOCAL loc_lVisivel
        loc_lVisivel = .F.

        IF USED("crSigCdOpe")
            loc_lVisivel = INLIST(crSigCdOpe.DtEntrs, 1, 4, 6) ;
                AND !INLIST(THIS.this_cPcEscolha, "INSERIR", "EXCLUIR")
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5)
            THIS.obj_4c_CmdEntrega.Visible = loc_lVisivel
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdCotacaoClick - "Do Form SigPrCtc With Thisform, ThisForm.DataSessionId,
    * ThisForm.pcescolha, TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes" do
    * legado (cmdCotacao.Valid). FormSigPrCtc.Init ja descarta o
    * DataSessionId (arquitetura nova nao precisa dele): assinatura e
    * (par_oFormPai, par_cEscolha, par_cEmps, par_cDopes, par_nNumes).
    * FormSigPrCtc.BtnSairClick fecha com THIS.Release() - nao ha nada a
    * ler nem a liberar depois do Show() aqui.
    *
    * PUBLIC: alvo de BINDEVENT("Click").
    *==========================================================================
    PROCEDURE CmdCotacaoClick()
        LOCAL loc_oDlg, loc_oErro
        loc_oDlg = .NULL.

        IF !USED("TprMvCab")
            RETURN
        ENDIF

        TRY
            loc_oDlg = CREATEOBJECT("FormSigPrCtc", THIS, THIS.this_cPcEscolha, ;
                TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao abrir Cota" + CHR(231) + CHR(227) + "o")
            loc_oDlg = .NULL.
        ENDTRY

        IF VARTYPE(loc_oDlg) = "O"
            loc_oDlg.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdEntregaClick - "Local ldDat, lnMin, ldEst / ldDat = Iif(IsEmpty(
    * TprMvCab.PrazoEnts), Date(), TprMvCab.PrazoEnts) / lnMin = Iif(IsEmpty(
    * crSigOpCdc.NMinEnts), 0, crSigOpCdc.NMinEnts) / lnMax = Iif(IsEmpty(
    * CrSigOpCdc.nMaxEnts), 0, CrSigOpCdc.nMaxEnts) / ldEst = Ttod(fDtoSQL(
    * Nvl(TprMvCab.Datas, Date()))) / Do Form SigOpEnt With TprMvCab.Emps,
    * TprMvCab.Dopes, TprMvCab.Numes, ldDat, ThisForm, lnMin, ldEst, .f.,
    * lnMax" do legado (cmdEntrega.Valid). FormSigOpEnt fecha com Hide()
    * (FecharDialogo) e devolve o resultado por ObterPrazoConfirmado() -
    * ver comentario daquele metodo em FormSigOpEnt.prg. O campo "Entregas"
    * (cnt_4c_Entregas.txt_4c_Entregas) e criado numa fase posterior - a
    * atribuicao e guardada por PEMSTATUS/VARTYPE e nao falha enquanto o
    * container nao existir.
    *
    * PUBLIC: alvo de BINDEVENT("Click").
    *==========================================================================
    PROCEDURE CmdEntregaClick()
        LOCAL loc_oDlg, loc_oErro, loc_dAtual, loc_nMin, loc_nMax, loc_dEst, ;
              loc_dConfirmado

        IF !USED("TprMvCab")
            RETURN
        ENDIF

        loc_dAtual = IIF(EMPTY(TprMvCab.PrazoEnts), DATE(), TprMvCab.PrazoEnts)

        loc_nMin = 0
        loc_nMax = 0
        IF USED("crSigOpCdc")
            loc_nMin = IIF(EMPTY(crSigOpCdc.NMinEnts), 0, crSigOpCdc.NMinEnts)
            loc_nMax = IIF(EMPTY(crSigOpCdc.NMaxEnts), 0, crSigOpCdc.NMaxEnts)
        ENDIF
        loc_dEst = TTOD(fDtoSQL(NVL(TprMvCab.Datas, DATE())))

        loc_oDlg = .NULL.
        TRY
            loc_oDlg = CREATEOBJECT("FormSigOpEnt", TprMvCab.Emps, TprMvCab.Dopes, ;
                TprMvCab.Numes, loc_dAtual, THIS, loc_nMin, loc_dEst, .F., loc_nMax)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao abrir Prazo de Entrega")
            loc_oDlg = .NULL.
        ENDTRY

        IF VARTYPE(loc_oDlg) = "O"
            loc_oDlg.Show()

            loc_dConfirmado = loc_oDlg.ObterPrazoConfirmado()
            IF !EMPTY(loc_dConfirmado)
                REPLACE PrazoEnts WITH loc_dConfirmado IN TprMvCab

                IF PEMSTATUS(THIS, "cnt_4c_Entregas", 5) AND VARTYPE(THIS.cnt_4c_Entregas) = "O"
                    IF PEMSTATUS(THIS.cnt_4c_Entregas, "txt_4c_Entregas", 5) ;
                       AND VARTYPE(THIS.cnt_4c_Entregas.txt_4c_Entregas) = "O"
                        THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dConfirmado
                        THIS.cnt_4c_Entregas.txt_4c_Entregas.Refresh()
                    ENDIF
                ENDIF
            ENDIF

            loc_oDlg.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarCursoresOperacao - "With ThisForm.ParentForm.poDataMgr /
    * .Cursorquery('SigCdOpe','CrSigCdOpe','Dopes',TprMvCab.Dopes) /
    * .Cursorquery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes) /
    * .Cursorquery('SigOpCdd','CrSigOpCdd','Dopes',TprMvCab.Dopes)" do Init
    * legado - os tres cursores que destravam os varios "falso seguro"
    * espalhados pelas Fases 4/5/6 (USED("crSigCdOpe")/USED("CrSigOpCdc")).
    * A 4a CursorQuery do legado (SigCdEmp/CrEmp) fica de fora - so e usada
    * no bloco "Carrega Dados da Conta", fora do escopo desta fase (ver
    * comentario de cabecalho do arquivo).
    *
    * PROTECTED: chamado uma unica vez, por InicializarForm().
    *==========================================================================
    PROTECTED PROCEDURE CarregarCursoresOperacao()
        LOCAL loc_cSQL, loc_nErro

        IF !USED("TprMvCab")
            RETURN
        ENDIF

        IF USED("crSigCdOpe")
            USE IN crSigCdOpe
        ENDIF
        loc_cSQL  = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
        loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
        IF loc_nErro < 1
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (SigCdOpe)", "Erro")
        ENDIF

        IF USED("CrSigOpCdc")
            USE IN CrSigOpCdc
        ENDIF
        loc_cSQL  = "SELECT * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
        loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdc")
        IF loc_nErro < 1
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (SigOpCdc)", "Erro")
        ENDIF

        IF USED("CrSigOpCdd")
            USE IN CrSigOpCdd
        ENDIF
        loc_cSQL  = "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
        loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdd")
        IF loc_nErro < 1
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o (SigOpCdd)", "Erro")
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarPrazoEntregaPadrao - "PROCEDURE carregaprzent" do legado:
    * sugere data de entrega padrao QUANDO o campo ainda esta vazio ou
    * ainda e hoje - nunca sobrescreve um prazo que o usuario ja moveu.
    *
    *   If (InList(crSigCdOpe.DtEntrs,1,4,6) And InList(pcEscolha,
    *      'INSERIR','ALTERAR') And (IsEmpty(PrazoEnts) Or
    *      Dtos(PrazoEnts)=Dtos(Date())))
    *       lcCta = Iif(crSigCdOpe.COpers=1, ContaDs, ContaOs)
    *       If IsEmpty(PrazoEnts)
    *           ldDat = Date()
    *           If NMinEnts = NMaxEnts -> ldDat = Date()+NMinEnts
    *       Else
    *           ldDat = <PrazoEnts atual>
    *       CursorQuery('SigCdCli','LocalCli','IClis',lcCta,'PrazoEnts')
    *       If LocalCli.PrazoEnts > 0 -> ldDat = ldDat + LocalCli.PrazoEnts
    *   EndIf
    *
    * PROTECTED: chamado so por AtualizarVisibilidadePorOperacao().
    *==========================================================================
    PROTECTED PROCEDURE CarregarPrazoEntregaPadrao()
        LOCAL loc_cConta, loc_dPrazo, loc_cSQL, loc_nErro

        IF !USED("TprMvCab") OR !USED("crSigCdOpe")
            RETURN
        ENDIF

        IF !INLIST(crSigCdOpe.DtEntrs, 1, 4, 6) ;
           OR !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") ;
           OR (!EMPTY(TprMvCab.PrazoEnts) ;
               AND DTOS(ConverterParaData(TprMvCab.PrazoEnts)) <> DTOS(DATE()))
            RETURN
        ENDIF

        loc_cConta = ALLTRIM(IIF(crSigCdOpe.COpers = 1, TprMvCab.ContaDs, TprMvCab.ContaOs))

        IF EMPTY(TprMvCab.PrazoEnts)
            loc_dPrazo = DATE()
            IF USED("CrSigOpCdc") AND CrSigOpCdc.NMinEnts = CrSigOpCdc.NMaxEnts
                loc_dPrazo = DATE() + CrSigOpCdc.NMinEnts
                REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
            ENDIF
        ELSE
            loc_dPrazo = ConverterParaData(TprMvCab.PrazoEnts)
        ENDIF

        IF !EMPTY(loc_cConta)
            loc_cSQL  = "SELECT PrazoEnts FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
            loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrazoCliente")

            IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_PrazoCliente") > 0 ;
               AND cursor_4c_PrazoCliente.PrazoEnts > 0
                loc_dPrazo = loc_dPrazo + cursor_4c_PrazoCliente.PrazoEnts
                REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
            ENDIF

            IF USED("cursor_4c_PrazoCliente")
                USE IN cursor_4c_PrazoCliente
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarVisibilidadePorOperacao - o corpo do Init legado que liga
    * Visible/Caption de cada container ao tipo de operacao corrente
    * (crSigCdOpe/CrSigOpCdc/CrSigOpCdd, carregados por
    * CarregarCursoresOperacao()). Chamada DEPOIS de
    * TornarControlesVisiveis(THIS): esse metodo reescreve Visible = .T.
    * em TODO AddObject recursivamente, entao a regra de negocio desta
    * tela so vale se for aplicada POR CIMA dele, nao antes.
    *
    * PUBLIC: reutilizavel por fases/metodos futuros que recarreguem os
    * cursores de operacao (mesmo padrao de AtualizarVisibilidadeCmdEntrega,
    * Fase 4) - chamada de novo no final daqui pela mesma razao.
    *==========================================================================
    PROCEDURE AtualizarVisibilidadePorOperacao()
        LOCAL loc_lFiscal

        IF !USED("TprMvCab") OR !USED("crSigCdOpe")
            RETURN
        ENDIF

        *** Digita Observacao / Digita Entrega / CntObs2
        THIS.cnt_4c_Observacao.Visible = INLIST(crSigCdOpe.DigObs, 1, 3)
        THIS.cnt_4c_Entrega.Visible    = INLIST(crSigCdOpe.DtEntrs, 3, 4, 5, 6)

        IF USED("CrSigOpCdd") AND PEMSTATUS(THIS, "cnt_4c_Obs2", 5)
            THIS.cnt_4c_Obs2.Visible = (INT(VAL(SUBSTR(CrSigOpCdd.ConfigGers, 209, 1))) = 1)
        ENDIF

        *** Digita Dados Fiscais
        loc_lFiscal = (crSigCdOpe.CupFis = 4)
        THIS.cnt_4c_Ecfs.Visible  = loc_lFiscal
        THIS.cnt_4c_Nemps.Visible = loc_lFiscal

        THIS.cnt_4c_Volumes.Visible = (crSigCdOpe.DadosNotas = 1)
        THIS.cnt_4c_Pedido.Visible  = INLIST(crSigCdOpe.PedClis, 1, 3, 4, 5)

        IF USED("CrSigOpCdc")
            THIS.cnt_4c_Protocolo.Visible = (CrSigOpCdc.EditProts = 1)
        ENDIF

        *-- Carrega Dados da Conta (crSigCdOpe.Opers = 2): o legado busca o
        *-- valor inicial em ThisForm.ParentForm.Pagina.Dados.pgfprincipal.
        *-- pgcontas.Destino.Get_Conta (pagina do form pai) e no cursor
        *-- TmpOperacao (grade de itens) - nenhum dos dois pertence a este
        *-- dialogo. Falso seguro parcial: ao menos confirma/preenche
        *-- Nome e CPF/CNPJ a partir do codigo JA presente em
        *-- TprMvCab.ContaEs, igual ao "lcCliente = TprMvCab.ContaEs /
        *-- CursorQuery(...) / getDConta.Value = ... / getCpfs.Value = ..."
        *-- que fecha esse trecho do Init legado.
        IF !EMPTY(TprMvCab.ContaEs)
            THIS.BuscarContaEntrega("IClis", ALLTRIM(TprMvCab.ContaEs))
        ENDIF

        *** Digita Documento / Data de Emissao
        THIS.cnt_4c_Documentos.Visible = INLIST(crSigCdOpe.DigDoc, 1, 3, 4, 5)
        THIS.cnt_4c_Emiss.Visible      = INLIST(crSigCdOpe.DtEmis, 1, 3)
        IF EMPTY(TprMvCab.DtEmis)
            REPLACE DtEmis WITH TprMvCab.Datas IN TprMvCab
        ENDIF

        *** Digita Data de Entrega
        THIS.cnt_4c_Entregas.Visible = INLIST(crSigCdOpe.DtEntrs, 1, 4, 6)
        THIS.cnt_4c_Entregas.lbl_4c_LblEntregas.Caption = "Prz. Entrega "
        IF USED("CrSigOpCdc") ;
           AND (CrSigOpCdc.DckPrze = 1 OR CrSigOpCdc.ChkPrzEnts = 1) ;
           AND !EMPTY(CrSigOpCdc.DocPrzE)
            THIS.cnt_4c_Entregas.lbl_4c_LblEntregas.Caption = ALLTRIM(PROPER(CrSigOpCdc.DocPrzE))
        ENDIF

        *** Digita Data de Recepcao
        THIS.cnt_4c_Recepcaos.Visible = (crSigCdOpe.DigRecs = 1)

        *** Digita Data Prometida
        IF USED("CrSigOpCdd")
            THIS.cnt_4c_PrzEnts.Visible = (CrSigOpCdd.PrzLjs = 1)
            THIS.cnt_4c_PrzEnts.lbl_4c_LblPrzEnts.Caption = ;
                IIF(!EMPTY(CrSigOpCdd.DocPrzLjs), CrSigOpCdd.DocPrzLjs, "Dt. Prometida")
        ENDIF

        THIS.CarregarPrazoEntregaPadrao()

        *-- Reaplica por cima do que ConfigurarBotoesAcao (Fase 4) ja tinha
        *-- calculado antes dos cursores existirem - e o que faz a
        *-- visibilidade real do botao de atalho de Prazo de Entrega valer
        *-- depois do TornarControlesVisiveis.
        THIS.AtualizarVisibilidadeCmdEntrega()
    ENDPROC

    *==========================================================================
    * AjustarPosicaoCampos - "PROCEDURE ajustaobjs" do legado: reflui os
    * containers da 1a linha (Ecfs/Nemps/Protocolo/Pedido, a partir de
    * cnt_4c_Codigos+cnt_4c_Documentos), da 2a linha (Emiss/Entregas/
    * Recepcaos/PrzEnts/Livre) e dos containers empilhados por baixo
    * (Observacao/Entrega/Volumes), preenchendo o espaco dos que a
    * AtualizarVisibilidadePorOperacao() acabou de ocultar. Chamada por
    * ultimo em InicializarForm(), com a visibilidade ja definitiva.
    *
    * PROTECTED: chamado uma unica vez, por InicializarForm().
    *==========================================================================
    PROTECTED PROCEDURE AjustarPosicaoCampos()
        LOCAL loc_nLf0, loc_nTp0, loc_nLft, loc_nTop

        loc_nLf0 = THIS.cnt_4c_Codigos.Left
        loc_nTp0 = THIS.cnt_4c_Codigos.Top

        *-- Ajustando Primeira Linha de Campos
        loc_nLft = loc_nLf0 + THIS.cnt_4c_Documentos.Width + THIS.cnt_4c_Codigos.Width
        loc_nTop = loc_nTp0

        IF THIS.cnt_4c_Ecfs.Visible
            THIS.cnt_4c_Ecfs.Left = loc_nLft
            THIS.cnt_4c_Ecfs.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_Ecfs.Width
        ENDIF

        IF THIS.cnt_4c_Nemps.Visible
            THIS.cnt_4c_Nemps.Left = loc_nLft
            THIS.cnt_4c_Nemps.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_Nemps.Width
        ENDIF

        IF THIS.cnt_4c_Protocolo.Visible
            THIS.cnt_4c_Protocolo.Left = loc_nLft
            THIS.cnt_4c_Protocolo.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_Protocolo.Width
        ENDIF

        IF THIS.cnt_4c_Pedido.Visible
            THIS.cnt_4c_Pedido.Left = loc_nLft
            THIS.cnt_4c_Pedido.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_Pedido.Width
        ENDIF

        loc_nLft = loc_nLf0
        loc_nTop = loc_nTp0 + THIS.cnt_4c_Codigos.Height + 1

        *-- Ajustando Segunda Linha de Campos
        IF THIS.cnt_4c_Emiss.Visible
            THIS.cnt_4c_Emiss.Left = loc_nLft
            THIS.cnt_4c_Emiss.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_Emiss.Width
        ENDIF

        IF THIS.cnt_4c_Entregas.Visible
            THIS.cnt_4c_Entregas.Left = loc_nLft
            THIS.cnt_4c_Entregas.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_Entregas.Width
        ENDIF

        IF THIS.cnt_4c_Recepcaos.Visible
            THIS.cnt_4c_Recepcaos.Left = loc_nLft
            THIS.cnt_4c_Recepcaos.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_Recepcaos.Width
        ENDIF

        IF THIS.cnt_4c_PrzEnts.Visible
            THIS.cnt_4c_PrzEnts.Left = loc_nLft
            THIS.cnt_4c_PrzEnts.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_PrzEnts.Width
        ENDIF

        IF THIS.cnt_4c_Livre.Visible
            THIS.cnt_4c_Livre.Left = loc_nLft
            THIS.cnt_4c_Livre.Top  = loc_nTop
            loc_nLft = loc_nLft + THIS.cnt_4c_Livre.Width
        ENDIF

        loc_nLft = loc_nLf0
        IF THIS.cnt_4c_Emiss.Visible OR THIS.cnt_4c_Entregas.Visible ;
           OR THIS.cnt_4c_Recepcaos.Visible OR THIS.cnt_4c_PrzEnts.Visible ;
           OR THIS.cnt_4c_Livre.Visible
            loc_nTop = loc_nTop + THIS.cnt_4c_Codigos.Height + 1
        ENDIF

        *-- Ajustando Conteiner da Observacao
        IF THIS.cnt_4c_Observacao.Visible
            THIS.cnt_4c_Observacao.Left = loc_nLft
            THIS.cnt_4c_Observacao.Top  = loc_nTop
            loc_nTop = loc_nTop + THIS.cnt_4c_Observacao.Height + 1
        ENDIF

        *-- Ajustando Conteiner da Entrega
        IF THIS.cnt_4c_Entrega.Visible
            THIS.cnt_4c_Entrega.Left = loc_nLft
            THIS.cnt_4c_Entrega.Top  = loc_nTop
            loc_nTop = loc_nTop + THIS.cnt_4c_Entrega.Height + 1
        ENDIF

        *-- Ajustando Conteiner de Volumes
        IF THIS.cnt_4c_Volumes.Visible
            THIS.cnt_4c_Volumes.Left = loc_nLft
            THIS.cnt_4c_Volumes.Top  = loc_nTop
        ENDIF
    ENDPROC

    *==========================================================================
    * KeyPress - "Lparameters nKeyCode, nShiftAltCtrl / If ThisForm.cntEntrega.
    * cmdEntrega.Visible And (nKeyCode = -1) -> SetFocus + Keyboard '{ENTER}'
    * NoDefault / If ThisForm.cmdEntrega.Visible And (nKeyCode = -2) ->
    * SetFocus + Keyboard '{ENTER}' NoDefault" do legado - F2 aciona o botao
    * "Local de Entrega" (cnt_4c_Entrega.cmd_4c_CmdEntrega) e F3 aciona o
    * botao "Entrega" (obj_4c_CmdEntrega, Prazo de Entrega, Fase 4). Em vez
    * de SetFocus + Keyboard '{ENTER}' (fragil em execucao headless/teste),
    * chama o Click do botao direto - mesmo efeito observavel.
    *
    * KeyPreview = .T. (propriedade do Form, ver cabecalho da classe) faz o
    * Form receber o KeyPress ANTES dos controles - exigido para capturar
    * F2/F3 em qualquer campo focado, como no legado.
    *==========================================================================
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF PEMSTATUS(THIS, "cnt_4c_Entrega", 5) AND VARTYPE(THIS.cnt_4c_Entrega) = "O"
            IF THIS.cnt_4c_Entrega.cmd_4c_CmdEntrega.Visible AND par_nKeyCode = -1
                THIS.EntregaLocalClick()
                NODEFAULT
                RETURN
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5) AND VARTYPE(THIS.obj_4c_CmdEntrega) = "O"
            IF THIS.obj_4c_CmdEntrega.Visible AND par_nKeyCode = -2
                THIS.CmdEntregaClick()
                NODEFAULT
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
    * criados por AddObject (que nascem com Visible = .F.). Percorre tambem
    * Pages de eventuais PageFrames filhos (nenhum nesta tela, mas o metodo
    * fica generico para as proximas fases).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) ;
                   AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
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

    *==========================================================================
    * Destroy - Reabilita o form pai (ver DesabilitarFormPai) e segue para o
    * fechamento canonico do FormBase (restauracao do menu principal).
    *==========================================================================
    PROCEDURE Destroy()
        THIS.ReabilitarFormPai()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - "PROCEDURE btnSelItens.Click" do legado (170 linhas):
    *
    *   If Inlist(pcEscolha,'INSERIR','ALTERAR')
    *       [observacao obrigatoria / data de emissao / prazo de entrega +
    *        recalculo de vencimentos + liberacao Min/Max / recepcao /
    *        cupom fiscal-ECF / EditDocs=4]
    *   Else
    *       If fChecaAcesso(..., 'ALTINFO') And pcEscolha = 'CONSULTAR'
    *           Update SigMvCab Set obses = ... Where CidChaves = ...
    *       Endif
    *   Endif
    *   ThisForm.Return
    *
    * Cada "Return"/"Return .f." do legado (saida ANTECIPADA, sem gravar) e
    * um RETURN bare deste metodo - so o CAMINHO FELIZ (fim de qualquer dos
    * dois ramos) chama THIS.FecharDialogo(), equivalente ao "ThisForm.
    * Return" final do legado.
    *
    * Guard de topo: sem TprMvCab/crSigCdOpe (cursores do form pai/Init
    * legado) nao ha o que validar nem gravar - mesmo "falso seguro" das
    * Fases 5-7 (CarregarPrazoEntregaPadrao, AtualizarVisibilidadePorOperacao).
    *
    * PUBLIC: alvo de BINDEVENT("Click") em ConfigurarBotoesAcao (Fase 4).
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_dLimiteMin, loc_dLimiteMax, loc_dData, loc_cHora

        IF !USED("TprMvCab") OR !USED("crSigCdOpe")
            RETURN
        ENDIF

        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

            *-- Observacao obrigatoria (DigObs = 3)
            IF crSigCdOpe.DigObs = 3 AND (EMPTY(TprMvCab.CodObs) OR EMPTY(TprMvCab.Obses))
                MsgAviso("Obrigat" + CHR(243) + "rio Informar " + ;
                    IIF(EMPTY(TprMvCab.CodObs), "C" + CHR(243) + "digo da ", "") + ;
                    "Observa" + CHR(231) + CHR(227) + "o para essa Opera" + CHR(231) + ;
                    CHR(227) + "o ... ", ;
                    "Observa" + CHR(231) + CHR(227) + "o " + CHR(233) + " Informa" + ;
                    CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                IF EMPTY(TprMvCab.CodObs)
                    THIS.cnt_4c_Observacao.txt_4c_CodObs.SetFocus()
                ELSE
                    THIS.cnt_4c_Observacao.obj_4c_GetDesObs.SetFocus()
                ENDIF
                RETURN
            ENDIF

            *-- Data de Emissao obrigatoria (DtEmis = 3)
            IF EMPTY(TprMvCab.DtEmis) AND crSigCdOpe.DtEmis = 3
                MsgAviso("Data de Emiss" + CHR(227) + "o do Documento precisa ser " + ;
                    "informada ... ", ;
                    "Data de Emiss" + CHR(227) + "o : Informa" + CHR(231) + CHR(227) + ;
                    "o Obrigat" + CHR(243) + "ria")
                THIS.cnt_4c_Emiss.txt_4c_Emiss.SetFocus()
                RETURN
            ENDIF

            *-- Prazo de Entrega preenchido: grava com hora + recalcula
            *-- vencimentos das parcelas (xPar - cursor do form pai, falso
            *-- seguro via USED() dentro de RecalcularVencimentosParcelas)
            IF !EMPTY(TprMvCab.PrazoEnts)
                loc_dData = ConverterParaData(TprMvCab.PrazoEnts)
                loc_cHora = TIME(TprMvCab.PrazoEnts)
                REPLACE PrazoEnts WITH fDtoSQL(loc_dData, loc_cHora) IN TprMvCab
                THIS.cnt_4c_Entregas.txt_4c_Entregas.Refresh()

                THIS.RecalcularVencimentosParcelas("xPar", .F.)
            ENDIF

            *-- Prazo de Entrega: obrigatoriedade + faixa Minima/Maxima
            IF INLIST(crSigCdOpe.DtEntrs, 1, 4, 6)
                IF EMPTY(TprMvCab.PrazoEnts)
                    MsgAviso("Prazo de Entrega deve ser informado...", "")
                    THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
                    RETURN
                ENDIF

                IF ConverterParaData(TprMvCab.PrazoEnts) < ConverterParaData(TprMvCab.Datas)
                    MsgAviso("Prazo de Entrega deve ser maior que a Data da " + ;
                        "Movimenta" + CHR(231) + CHR(227) + "o...", "")
                    THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
                    RETURN
                ENDIF

                IF USED("CrSigOpCdc") AND CrSigOpCdc.NMinEnts > 0 AND !THIS.this_lValidOk
                    loc_dLimiteMin = ConverterParaData(TprMvCab.Datas) + CrSigOpCdc.NMinEnts
                    IF ConverterParaData(TprMvCab.PrazoEnts) < loc_dLimiteMin
                        IF !THIS.SolicitarLiberacaoPrazoEntrega(loc_dLimiteMin, ;
                                ConverterParaData(TprMvCab.PrazoEnts), "M" + CHR(237) + "nimo")
                            THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dLimiteMin
                            THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
                            RETURN
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("CrSigOpCdc") AND CrSigOpCdc.NMaxEnts > 0 AND !THIS.this_lValidOk
                    loc_dLimiteMax = ConverterParaData(TprMvCab.Datas) + CrSigOpCdc.NMaxEnts
                    IF ConverterParaData(TprMvCab.PrazoEnts) > loc_dLimiteMax
                        IF !THIS.SolicitarLiberacaoPrazoEntrega(loc_dLimiteMax, ;
                                ConverterParaData(TprMvCab.PrazoEnts), "M" + CHR(225) + "ximo")
                            THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dLimiteMax
                            THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
                            RETURN
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- Data de Recepcao obrigatoria (DigRecs = 1)
            IF crSigCdOpe.DigRecs = 1
                IF EMPTY(TprMvCab.DtRecs)
                    MsgAviso("Data de Recep" + CHR(231) + CHR(227) + "o deve ser " + ;
                        "informada ...", "")
                    THIS.cnt_4c_Recepcaos.txt_4c_Recepcaos.SetFocus()
                    RETURN
                ENDIF
            ENDIF

            *-- Cupom Fiscal/ECF obrigatorios (CupFis = 4)
            IF crSigCdOpe.CupFis = 4
                IF EMPTY(TprMvCab.Ecfs)
                    MsgAviso("N" + CHR(250) + "mero do ECF Precisa Ser Informado...", "")
                    THIS.cnt_4c_Ecfs.txt_4c_Ecfs.SetFocus()
                    RETURN
                ENDIF
                IF EMPTY(TprMvCab.Nemps)
                    MsgAviso("N" + CHR(250) + "mero de S" + CHR(233) + "rie da " + ;
                        "Impressora Precisa Ser Informado...", "")
                    THIS.cnt_4c_Nemps.txt_4c_Nemps.SetFocus()
                    RETURN
                ENDIF
            ENDIF

            *-- EditDocs = 4: numero da nota reformatado na grade de itens do
            *-- movimento (crTpmMvItn) - cursor do form pai, falso seguro:
            *-- sem ele (nenhum caller desta tela no acervo) fica de fora.
            IF crSigCdOpe.EditDocs = 4 AND USED("crTpmMvItn")
                REPLACE ALL Notas WITH TRANSFORM(VAL(TprMvCab.Notas), "@L 999999") IN crTpmMvItn
            ENDIF

        ELSE
            *-- CONSULTAR com acesso ALTINFO liberado: confirma a observacao
            *-- (mesmo gate de DesObsWhen, Fase 6)
            IF fChecaAcesso(PADL(TRANSFORM(crSigCdOpe.nDopes), 8, "0"), "ALTINFO") ;
               AND THIS.this_cPcEscolha = "CONSULTAR"
                THIS.this_oBusinessObject.this_cObses     = ALLTRIM(TprMvCab.Obses)
                THIS.this_oBusinessObject.this_cCidChaves = TprMvCab.CidChaves
                IF !THIS.this_oBusinessObject.Atualizar()
                    RETURN
                ENDIF
            ENDIF
        ENDIF

        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * SolicitarLiberacaoPrazoEntrega - "Do Form SigOpSen With 'LIBPRZENT',
    * 'Libera Prazo de Entrega' To _Retorno" do btnSelItens.Click legado,
    * repetido para o limite Minimo e para o Maximo (so o rotulo/valor
    * mudam):
    *
    *   Do Form SigOpSen With 'LIBPRZENT', 'Libera Prazo de Entrega' To _Retorno
    *   llOk = ( Left( _Retorno, 1 ) = "*" )
    *   lcUsuLib = Substr( _Retorno, 2 )
    *   If !llOk -> Messagebox(...) / Return .f.
    *   Else -> thisform.validok = .t. / fGravarLog('T', Dopes, 'LIBPRZENT', ...)
    *
    * SigOpSen NAO existe na nova arquitetura - sigopsen.SCX so existe em
    * C:\4install\FortyusMC\Fortyus\, fora do SET PATH (memoria
    * feedback_sigopsen_ausente_gate_autorizacao). Por ser gate de
    * AUTORIZACAO, a falha e tratada FAIL-CLOSED: dialogo indisponivel =
    * NAO autorizado, nunca substituido por MsgConfirma/skip (regra
    * CLAUDE.md #27). O TRY cobre SO a chamada do "Do Form" (regra #29);
    * avaliacao do retorno e o fGravarLog ficam FORA do bloco. Mesmo
    * padrao canonico de FormSigOpEnt.SolicitarLiberacaoPrazo.
    *
    * Sucesso marca THIS.this_lValidOk = .T. ("thisform.validok = .t."), que
    * os dois guards (Minimo/Maximo) de BtnSalvarClick consultam antes de
    * abrir o dialogo de novo na MESMA gravacao.
    *
    * PROTECTED: so BtnSalvarClick, desta mesma classe, chama.
    *==========================================================================
    PROTECTED FUNCTION SolicitarLiberacaoPrazoEntrega(par_dLimite, par_dValor, par_cRotulo)
        LOCAL loc_cRetorno, loc_lDialogoAbriu, loc_cFalhaDialogo, loc_lAutorizado
        LOCAL loc_cUsuarioLib, loc_cTransacao, loc_oErroSen

        loc_cRetorno      = ""
        loc_cFalhaDialogo = ""
        loc_lDialogoAbriu = .F.

        TRY
            DO FORM SigOpSen WITH "LIBPRZENT", "Libera Prazo de Entrega" TO loc_cRetorno
            loc_lDialogoAbriu = .T.
        CATCH TO loc_oErroSen
            loc_cFalhaDialogo = loc_oErroSen.Message
        ENDTRY

        CLEAR TYPEAHEAD

        loc_lAutorizado = (loc_lDialogoAbriu AND LEFT(ALLTRIM(NVL(loc_cRetorno, "")), 1) = "*")

        IF loc_lAutorizado
            loc_cUsuarioLib = SUBSTR(loc_cRetorno, 2)
            loc_cTransacao  = "Emp: " + go_4c_Sistema.cCodEmpresa + ;
                " N" + CHR(186) + " Oper: " + STR(TprMvCab.Numes, 6) + ;
                " - Prazo " + par_cRotulo + ": " + DTOC(par_dLimite) + ;
                " Prazo Liberado " + DTOC(par_dValor)

            =fGravarLog("T", TprMvCab.Dopes, "LIBPRZENT", loc_cTransacao, loc_cUsuarioLib)

            THIS.this_lValidOk = .T.
        ELSE
            IF loc_lDialogoAbriu
                MsgAviso("Prazo de Entrega " + par_cRotulo + " " + CHR(233) + " " + ;
                    DTOC(par_dLimite) + "...", "")
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela " + ;
                    "de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen)." + CHR(13) + ;
                    "O prazo de entrega N" + CHR(195) + "O foi liberado." + CHR(13) + ;
                    CHR(13) + "Detalhe: " + loc_cFalhaDialogo, "Libera Prazo de Entrega")
            ENDIF
        ENDIF

        RETURN loc_lAutorizado
    ENDFUNC

    *==========================================================================
    * RecalcularVencimentosParcelas - laco de recalculo de vencimentos do
    * btnSelItens.Click legado (disparado quando o Prazo de Entrega muda):
    *
    *   Select xPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
    *       =CursorQuery('SigOpFp','LocalFpag','fpags',xPar.Fpags,
    *           [TpVencs,Entradas,Dias,tVens])
    *       If LocalFpag.TpVencs = 2
    *           DVenc = (Ttod(TprMvCab.PrazoEnts) + LocalFpag.Entradas)
    *           Scan While Fpags=_lcFpg And cnIdTefs=_lcIdT
    *               [laco de feriados] / Replace Vencs With DVenc
    *               DVenc = Iif(TVen='F', GoMonth(DVenc,1), DVenc+NDia)
    *           EndScan
    *           Skip -1
    *       Endif
    *   EndScan
    *
    * par_cCursor: alias do cursor de parcelas a recalcular, agrupado por
    * Fpags+CnIdTefs (colunas Fpags/CnIdTefs/Parcs/Vencs/CidChaves). "xPar"
    * (parcelas do lancamento corrente, BtnSalvarClick) e "LocalPar"
    * (parcelas de SigMvPar no lancamento direto, ProcessarLancamentoDireto)
    * usam este MESMO metodo - layout de colunas identico, so a origem
    * difere. Falso seguro: sem o cursor (par_cCursor), nao ha o que
    * recalcular.
    *
    * par_lAtualizarBanco = .T. (LocalPar) tambem grava o vencimento no SQL
    * Server ("Update SigMvPar Set Vencs = ... Where CidChaves = ..."),
    * como o legado faz nesse caminho; .F. (xPar) e so cursor em memoria do
    * form pai, igual ao legado.
    *
    * Feriados: AvancarAlemDosFeriados()/CarregarFeriados() reproduzem o
    * MESMO padrao e a MESMA razao de FormSigOpFpg (decisao documentada
    * la: SEEK string-sobre-data do legado nao e reproduzivel ao vivo,
    * reescrito preservando a condicao de parada original).
    *
    * PROTECTED: chamado so por BtnSalvarClick() e ProcessarLancamentoDireto().
    *==========================================================================
    PROTECTED PROCEDURE RecalcularVencimentosParcelas(par_cCursor, par_lAtualizarBanco)
        LOCAL loc_dVenc, loc_nDias, loc_cTipoVenc, loc_cFpgAtual, loc_cIdTefAtual
        LOCAL loc_cSQLFpg, loc_nErro, loc_cSQLUpdate, loc_cCidChave

        IF !USED(par_cCursor) OR !USED("TprMvCab") OR EMPTY(TprMvCab.PrazoEnts)
            RETURN
        ENDIF

        SELECT (par_cCursor)
        INDEX ON Fpags + CnIdTefs + STR(Parcs, 2) TAG FpagV
        SCAN
            loc_cFpgAtual = Fpags

            IF USED("cursor_4c_FpgVenc")
                USE IN cursor_4c_FpgVenc
            ENDIF
            loc_cSQLFpg = "SELECT TpVencs, Entradas, Dias, tVens FROM SigOpFp " + ;
                "WHERE Fpags = " + EscaparSQL(loc_cFpgAtual)
            loc_nErro   = SQLEXEC(gnConnHandle, loc_cSQLFpg, "cursor_4c_FpgVenc")
            SELECT (par_cCursor)

            IF loc_nErro >= 1 AND USED("cursor_4c_FpgVenc") AND cursor_4c_FpgVenc.TpVencs = 2
                loc_dVenc       = ConverterParaData(TprMvCab.PrazoEnts) + cursor_4c_FpgVenc.Entradas
                loc_nDias       = cursor_4c_FpgVenc.Dias
                loc_cTipoVenc   = cursor_4c_FpgVenc.tVens
                loc_cFpgAtual   = Fpags
                loc_cIdTefAtual = CnIdTefs

                SCAN WHILE Fpags = loc_cFpgAtual AND CnIdTefs = loc_cIdTefAtual
                    loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)
                    REPLACE Vencs WITH loc_dVenc IN (par_cCursor)

                    IF par_lAtualizarBanco
                        loc_cCidChave  = CidChaves
                        loc_cSQLUpdate = "UPDATE SigMvPar SET Vencs = " + ;
                            FormatarDataSQL(loc_dVenc) + " WHERE CidChaves = " + ;
                            EscaparSQL(loc_cCidChave)
                        IF SQLEXEC(gnConnHandle, loc_cSQLUpdate) < 1
                            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                                "Falha na conex" + CHR(227) + "o (Update SigMvPar)", "Erro")
                        ENDIF
                    ENDIF

                    loc_dVenc = IIF(loc_cTipoVenc = "F", GOMONTH(loc_dVenc, 1), loc_dVenc + loc_nDias)
                ENDSCAN
                SKIP -1
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_FpgVenc")
            USE IN cursor_4c_FpgVenc
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriadosCache
    * ("|AAAAMMDD|..."), mesmo padrao de FormSigOpFpg.CarregarFeriados -
    * evita um SELECT por parcela dentro do laco de recalculo.
    *==========================================================================
    PROTECTED PROCEDURE CarregarFeriados()
        LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro

        IF THIS.this_lFeriadosCarregados
            RETURN .T.
        ENDIF

        loc_cLista = "|"

        TRY
            IF USED("cursor_4c_FerLoad")
                USE IN SELECT("cursor_4c_FerLoad")
            ENDIF

            loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")

            IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
                SELECT cursor_4c_FerLoad
                SCAN
                    IF !ISNULL(datas) AND !EMPTY(datas)
                        loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
                    ENDIF
                ENDSCAN
                USE IN SELECT("cursor_4c_FerLoad")
            ENDIF

            THIS.this_cFeriadosCache      = loc_cLista
            THIS.this_lFeriadosCarregados = .T.
        CATCH TO loc_oErro
            THIS.this_cFeriadosCache = "|"
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AvancarAlemDosFeriados - laco de feriados do btnSelItens.Click legado:
    *
    *   lnFer = 0 / Verd = .t.
    *   Seek Dtos(DVenc) in crSigCdFer order Datas
    *   Do While Verd .and. !Eof()
    *       lnFer = lnFer + 1 / Skip
    *       If DVenc+lnFer # crSigCdFer.Datas .or.
    *          Dow(DVenc+lnFer)=1 .or. Dow(DVenc+lnFer)=7
    *           Verd = .f.
    *       Endif
    *   Enddo
    *   DVenc = DVenc + lnFer
    *
    * Mesma reescrita (e mesma razao) de FormSigOpFpg.AvancarAlemDosFeriados:
    * o SEEK do dump busca por STRING (Dtos) num indice de coluna DATE/
    * DATETIME, combinacao sem leitura inequivoca fora do VFP9 ao vivo.
    * Preserva a condicao de parada original (incluindo o teste de fim de
    * semana DENTRO do laco de feriados): anda dia a dia enquanto o PROXIMO
    * dia estiver no cache de feriados (CarregarFeriados) e NAO for
    * sabado/domingo.
    *==========================================================================
    PROTECTED FUNCTION AvancarAlemDosFeriados(par_dVencimento)
        LOCAL loc_nFer, loc_dProxima, loc_lContinua

        THIS.CarregarFeriados()

        loc_nFer      = 0
        loc_lContinua = .T.

        DO WHILE loc_lContinua
            loc_dProxima = par_dVencimento + loc_nFer + 1

            IF ("|" + DTOS(loc_dProxima) + "|") $ THIS.this_cFeriadosCache AND ;
                    DOW(loc_dProxima) != 1 AND DOW(loc_dProxima) != 7
                loc_nFer = loc_nFer + 1
            ELSE
                loc_lContinua = .F.
            ENDIF
        ENDDO

        RETURN par_dVencimento + loc_nFer
    ENDFUNC

    *==========================================================================
    * FecharDialogo - "PROCEDURE return" do legado:
    *
    *   If ThisForm.Direta
    *       [ver ProcessarLancamentoDireto()]
    *   Endif
    *   ThisForm.parentform.enabled = .T.
    *   thisform.parentform.validok = thisform.validok
    *   ThisForm.parentform.pagina.dados.dados.setfocus
    *   ThisForm.release
    *
    * "ThisForm.parentform.enabled = .T." ja acontece em Destroy()
    * (ReabilitarFormPai(), Fase 3) - Release() dispara Destroy() antes de
    * destruir o objeto, entao nao duplicado aqui.
    *
    * "ThisForm.parentform.pagina.dados.dados.setfocus" refere-se a um
    * controle especifico do form pai (frmcadastro legado) sem equivalente
    * conhecido nesta migracao - nenhum caller de Formsigopinf existe no
    * acervo (ver cabecalho do arquivo) para definir esse equivalente.
    * Omitido, documentado, nao inventado.
    *
    * THIS.Release() (nao Hide()): esta classe NAO isola DataSession (fica
    * no default = 1, ver comentario de cabecalho "DataSession") - ao
    * contrario de FormSigOpFpg (DataSession = 2), nao ha razao para
    * sobreviver ao fechamento, e Release() e transcricao fiel do
    * "ThisForm.release" legado.
    *
    * PUBLIC: alvo de chamada de BtnSalvarClick() (fim de cada ramo) e do
    * form pai, se precisar fechar o dialogo por codigo.
    *==========================================================================
    PROCEDURE FecharDialogo()
        THIS.ProcessarLancamentoDireto()

        IF VARTYPE(THIS.this_oFormPai) = "O" ;
           AND PEMSTATUS(THIS.this_oFormPai, "this_lValidOk", 5)
            THIS.this_oFormPai.this_lValidOk = THIS.this_lValidOk
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * ProcessarLancamentoDireto - ramo "If ThisForm.Direta" do "PROCEDURE
    * return" legado:
    *
    *   Select CrSigMvCab / Zap / Select TprMvCab / Scatter Memvar memo /
    *   Select CrSigMvCab / Append Blank / Gather Memvar Memo
    *   lcSql = Select a.*, b.TpVencs,b.Entradas,b.dias,b.tVens From SigMvPar a,
    *       SigOpFp b where a.EmpDopNums = <TprMvCab.EmpDopNums> And a.Fpags = b.fpags
    *   Select LocalPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
    *       [recalculo de vencimentos + Update SigMvPar - ver
    *        RecalcularVencimentosParcelas]
    *   EndScan
    *   llOk = UpDate('CrSigMvCab') And Commit() > 0 / If !llOk -> RollBack()
    *   Select TprMvCab / Zap
    *
    * CrSigMvCab (cursor de BATCH do lancamento direto) e o commit em lote
    * (ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
    * form PAI/orquestrador da operacao, inexistente nesta migracao (nenhum
    * caller de Formsigopinf no acervo - ver cabecalho do arquivo). Falso
    * seguro: sem CrSigMvCab, o bloco INTEIRO fica de fora - inclusive o
    * recalculo de SigMvPar (que so faz sentido acoplado ao commit em lote)
    * e o "Select TprMvCab / Zap" final, que SEM o lote persistido em outro
    * lugar destruiria os dados do usuario (regra CLAUDE.md #17 - nao
    * reproduzir so a metade de uma formula/fluxo que depende do resto).
    *
    * PROTECTED: so FecharDialogo(), desta mesma classe, chama.
    *==========================================================================
    PROTECTED PROCEDURE ProcessarLancamentoDireto()
        LOCAL loc_cSQL, loc_nErro

        IF !THIS.this_lDireta OR !USED("CrSigMvCab") OR !USED("TprMvCab")
            RETURN
        ENDIF

        IF EMPTY(TprMvCab.EmpDopNums)
            RETURN
        ENDIF

        IF USED("LocalPar")
            USE IN LocalPar
        ENDIF
        loc_cSQL = "SELECT a.*, b.TpVencs, b.Entradas, b.Dias, b.tVens " + ;
            "FROM SigMvPar a, SigOpFp b " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(TprMvCab.EmpDopNums) + " " + ;
            "AND a.Fpags = b.Fpags"
        loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")
        IF loc_nErro < 1
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                "Falha na conex" + CHR(227) + "o ( LocalPar )", "Erro")
            RETURN
        ENDIF

        THIS.RecalcularVencimentosParcelas("LocalPar", .T.)

        IF USED("LocalPar")
            USE IN LocalPar
        ENDIF

        *-- Commit em lote (CrSigMvCab) fora do escopo desta migracao - ver
        *-- comentario de cabecalho do metodo.
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopinfBO.prg):
*====================================================================
* sigopinfBO.prg
*
* Business Object para o dialogo "Informacoes Gerais" (SIGOPINF)
* Entidade base: SigMvCab (cabecalho do movimento/operacao)
* Herda de: BusinessBase
*
* NOTA: SIGOPINF e um dialogo FILHO, aberto pelo form de cabecalho da
* operacao (ParentForm) e que edita um SUBCONJUNTO de colunas do cursor
* TprMvCab (cursor de trabalho do pai, equivalente a SigMvCab). Este BO
* nao persiste diretamente em SigMvCab - quem grava o cabecalho e o
* form pai, quando a operacao principal e salva (os controles desta
* tela ja escrevem direto em TprMvCab via ControlSource).
*
* O UNICO caminho de gravacao direta no legado (SIGOPINF.cntBotoes.Click,
* ramo Else) acontece em modo CONSULTAR, quando o usuario tem acesso
* ALTINFO liberado: um UPDATE pontual da coluna Obses, pela chave
* CidChaves. E esse caminho que Atualizar() reproduz aqui.
*
* Nomes de coluna confirmados em docs/schema.sql (UTF-16) e no dump
* SIGOPINF.ControlSource (tasks/task751/sigopinf_form_codigo_fonte.txt):
*   cntVolumes.getQtds      -> Qtdes       (numeric)
*   cntVolumes.getEspes     -> Espes       (char)
*   cntVolumes.getPLiqs     -> PLiqs       (numeric)
*   cntVolumes.getPBrus     -> PBrus       (numeric)
*   cntVolumes.getValTrans  -> ValTrans    (numeric)
*   cntObservacao.getCodObs -> CodObs      (numeric)
*   cntObservacao.getDesObs -> Obses       (text/memo)
*   CntObs2.btnMultObs      -> CodObs2     (char)
*   cntProtocolo.getProtocolos -> Protats  (numeric)
*   cntEntrega.getContas    -> ContaEs     (char)
*   cntCodigos.getCodigos   -> MascNum     (char)
*   cntDocumentos.getDocumentos -> Notas   (char)
*   cntDocumentos.GetNumeroNota -> NumeroNota (char)
*   cntEcfs.getEcfs         -> Ecfs        (char)
*   cntNemps.getNemps       -> Nemps       (char)
*   cntEmiss.getEmiss       -> DtEmis      (datetime)
*   cntEntregas.getEntregas -> PrazoEnts   (datetime)
*   cntRecepcaos.getRecepcaos -> DtRecs    (datetime)
*   cntPrzEnts.getPrzEnts   -> PrzClis     (datetime)
*   cntPedido.getPedido     -> nPedClis    (numeric)
*   cntLivre.getNLivDg      -> NLivDg      (numeric)
*====================================================================

DEFINE CLASS sigopinfBO AS BusinessBase

    *-- Identificacao do movimento (TprMvCab - chave posicional)
    this_cEmps        = ""    && TprMvCab.Emps char(3) - empresa
    this_cDopes       = ""    && TprMvCab.Dopes char(20) - tipo de documento/operacao
    this_nNumes       = 0     && TprMvCab.Numes numeric - numero do documento
    this_cEmpDopNums  = ""    && TprMvCab.EmpDopNums char(29) - chave posicional (Emps + Dopes + Str(Numes,6))
    this_cCidChaves   = ""    && TprMvCab.CidChaves char - chave do registro, usada no UPDATE pontual de Obses (modo CONSULTAR + acesso ALTINFO)

    *-- Datas (containers cntEmiss/cntEntregas/cntPrzEnts/cntRecepcaos)
    this_dDatas       = {}    && TprMvCab.Datas - data do movimento (usada em validacoes de prazo; nao editavel nesta tela)
    this_dDtEmis      = {}    && TprMvCab.DtEmis - data de emissao do documento
    this_dPrazoEnts   = {}    && TprMvCab.PrazoEnts - prazo de entrega
    this_dPrzClis     = {}    && TprMvCab.PrzClis - data prometida ao cliente
    this_dRecepcaos   = {}    && TprMvCab.DtRecs - data de recepcao

    *-- Contas (container cntEntrega - conta/nome/cpf-cnpj da entrega)
    this_cContaDs     = ""    && TprMvCab.ContaDs - conta (duplicata)
    this_cContaOs     = ""    && TprMvCab.ContaOs - conta (ordem de servico)
    this_cContaEs     = ""    && TprMvCab.ContaEs - conta de entrega
    this_cDescContaEs = ""    && Nome/razao social da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)
    this_cCpfContaEs  = ""    && CPF/CNPJ da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)

    *-- Observacoes (container cntObservacao/CntObs2)
    this_nCodObs      = 0     && TprMvCab.CodObs - codigo da observacao (crSigCdObs.Codigos)
    this_cObses       = ""    && TprMvCab.Obses - texto da observacao (memo)
    this_cCodObs2     = ""    && TprMvCab.CodObs2 - codigos de observacoes de finalidade (lista concatenada)

    *-- Entrega/protocolo/documentos
    this_nLocalEnts   = 0     && TprMvCab.LocalEnts numeric - codigo do endereco alternativo de entrega (SigCdCee.Codigos)
    this_nProtocolos  = 0     && TprMvCab.Protats numeric - protocolo
    this_cCodigos     = ""    && TprMvCab.MascNum - mascara/codigo de referencia da tela (cntCodigos)
    this_cDocumentos  = ""    && TprMvCab.Notas - numero do documento
    this_cNumeroNota  = ""    && TprMvCab.NumeroNota - numero da nota fiscal
    this_cEcfs        = ""    && TprMvCab.Ecfs - identificacao do ECF
    this_cNemps       = ""    && TprMvCab.Nemps - numero de serie da impressora fiscal (criptografado)
    this_nPedido      = 0     && TprMvCab.nPedClis numeric - numero do pedido
    this_nNLivDg      = 0     && TprMvCab.NLivDg numeric - numero do lacre

    *-- Volumes/transporte (container cntVolumes)
    this_nQtds        = 0     && TprMvCab.Qtdes - quantidade de volumes
    this_cEspes       = ""    && TprMvCab.Espes - especie do volume
    this_nPLiqs       = 0     && TprMvCab.PLiqs - peso liquido
    this_nPBrus       = 0     && TprMvCab.PBrus - peso bruto
    this_nValTrans    = 0     && TprMvCab.ValTrans - valor do transporte

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "CidChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave do registro corrente (TprMvCab.CidChaves)
    * Usada por RegistrarAuditoria() apos o UPDATE pontual de Obses.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir do cursor
    * de trabalho do form pai (TprMvCab). Cada campo e lido sob guarda de
    * TYPE() porque o alias recebido pode trazer so um subconjunto das
    * colunas (ex.: cursor de teste automatizado).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Identificacao do movimento
                IF TYPE("Emps") != "U"
                    THIS.this_cEmps = TratarNulo(Emps, "C")
                ENDIF
                IF TYPE("Dopes") != "U"
                    THIS.this_cDopes = TratarNulo(Dopes, "C")
                ENDIF
                IF TYPE("Numes") != "U"
                    THIS.this_nNumes = TratarNulo(Numes, "N")
                ENDIF
                IF TYPE("EmpDopNums") != "U"
                    THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                ENDIF
                IF TYPE("CidChaves") != "U"
                    THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                ENDIF

                *-- Datas
                IF TYPE("Datas") != "U"
                    THIS.this_dDatas = TratarNulo(Datas, "D")
                ENDIF
                IF TYPE("DtEmis") != "U"
                    THIS.this_dDtEmis = TratarNulo(DtEmis, "D")
                ENDIF
                IF TYPE("PrazoEnts") != "U"
                    THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
                ENDIF
                IF TYPE("PrzClis") != "U"
                    THIS.this_dPrzClis = TratarNulo(PrzClis, "D")
                ENDIF
                IF TYPE("DtRecs") != "U"
                    THIS.this_dRecepcaos = TratarNulo(DtRecs, "D")
                ENDIF

                *-- Contas
                IF TYPE("ContaDs") != "U"
                    THIS.this_cContaDs = TratarNulo(ContaDs, "C")
                ENDIF
                IF TYPE("ContaOs") != "U"
                    THIS.this_cContaOs = TratarNulo(ContaOs, "C")
                ENDIF
                IF TYPE("ContaEs") != "U"
                    THIS.this_cContaEs = TratarNulo(ContaEs, "C")
                ENDIF

                *-- Observacoes
                IF TYPE("CodObs") != "U"
                    THIS.this_nCodObs = TratarNulo(CodObs, "N")
                ENDIF
                IF TYPE("Obses") != "U"
                    THIS.this_cObses = TratarNulo(Obses, "C")
                ENDIF
                IF TYPE("CodObs2") != "U"
                    THIS.this_cCodObs2 = TratarNulo(CodObs2, "C")
                ENDIF

                *-- Entrega/protocolo/documentos
                IF TYPE("LocalEnts") != "U"
                    THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                ENDIF
                IF TYPE("Protats") != "U"
                    THIS.this_nProtocolos = TratarNulo(Protats, "N")
                ENDIF
                IF TYPE("MascNum") != "U"
                    THIS.this_cCodigos = TratarNulo(MascNum, "C")
                ENDIF
                IF TYPE("Notas") != "U"
                    THIS.this_cDocumentos = TratarNulo(Notas, "C")
                ENDIF
                IF TYPE("NumeroNota") != "U"
                    THIS.this_cNumeroNota = TratarNulo(NumeroNota, "C")
                ENDIF
                IF TYPE("Ecfs") != "U"
                    THIS.this_cEcfs = TratarNulo(Ecfs, "C")
                ENDIF
                IF TYPE("Nemps") != "U"
                    THIS.this_cNemps = TratarNulo(Nemps, "C")
                ENDIF
                IF TYPE("nPedClis") != "U"
                    THIS.this_nPedido = TratarNulo(nPedClis, "N")
                ENDIF
                IF TYPE("NLivDg") != "U"
                    THIS.this_nNLivDg = TratarNulo(NLivDg, "N")
                ENDIF

                *-- Volumes/transporte
                IF TYPE("Qtdes") != "U"
                    THIS.this_nQtds = TratarNulo(Qtdes, "N")
                ENDIF
                IF TYPE("Espes") != "U"
                    THIS.this_cEspes = TratarNulo(Espes, "C")
                ENDIF
                IF TYPE("PLiqs") != "U"
                    THIS.this_nPLiqs = TratarNulo(PLiqs, "N")
                ENDIF
                IF TYPE("PBrus") != "U"
                    THIS.this_nPBrus = TratarNulo(PBrus, "N")
                ENDIF
                IF TYPE("ValTrans") != "U"
                    THIS.this_nValTrans = TratarNulo(ValTrans, "N")
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir - Nao aplicavel a este dialogo. O cabecalho do movimento
    * (SigMvCab) e criado pelo form PAI (operacao principal) quando a
    * operacao e salva; SIGOPINF so edita colunas do cursor TprMvCab
    * (ja atualizado em memoria pelos proprios controles via
    * ControlSource) e devolve o controle com ThisForm.Return.
    *====================================================================
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *====================================================================
    * Atualizar - Reproduz o UNICO caminho de gravacao direta do legado
    * (SIGOPINF.cntBotoes.Click, ramo Else): em modo CONSULTAR, com
    * acesso ALTINFO liberado, confirma apenas a observacao (Obses) do
    * cabecalho, pela chave CidChaves. O Form e quem decide, antes de
    * chamar Salvar()/Atualizar(), se o acesso ALTINFO permite a acao -
    * este metodo so executa a gravacao em si.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave do registro n" + CHR(227) + "o informada."
            ELSE
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Obses = " + EscaparSQL(ALLTRIM(THIS.this_cObses)) + " " + ;
                           "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Erro ao atualizar a observa" + CHR(231) + CHR(227) + "o do movimento."
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    THIS.RegistrarAuditoria("A")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

