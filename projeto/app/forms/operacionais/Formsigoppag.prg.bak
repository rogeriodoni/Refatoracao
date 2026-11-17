*====================================================================
* Formsigoppag.prg
*
* Form OPERACIONAL "Recebimento" - condicoes de pagamento/recebimento
* de um movimento (grade ligada a SigMvPar). O legado (SIGOPPAG) e
* aberto como FORM FILHO pelo form de cabecalho do movimento (Lparameters
* pForm, datses, plAltDireta, plAutomatico - Set Datasession To datses:
* o filho passa a compartilhar a MESMA data session do pai, reaproveitando
* os cursores que o pai ja tem abertos - xPar/TprMvCab/crSigCdOpe/
* crSigMvNfi/crSigCdCfo/crSigCdPam, regra #35/cabecalho). poForm (a
* referencia de UI) e a troca de DataSession ficam no FORM; o BO
* (sigoppagBO) so recebe os escalares Emps/Dopes/Numes extraidos do
* cabecalho do pai.
*
* Layout CUSTOM (grid de condicoes "Grade" + ~15 containers flutuantes
* por forma de pagamento - CntCheque/CntObs/CntCarne/CntCCreditoE/
* CntCCreditoS/cntnsu/cntApanhaChq/cntFundo.cntMascPgto/etc, todos com
* Visible=.F. no SCX e alternados por codigo). NAO segue o padrao
* Page1=Lista/Page2=Dados do CRUD - PILAR 3 arquitetural, mas o layout
* visual (PILAR 1) e flat como o legado.
*
* Fase 3/8 - estrutura base: propriedades, Init()/InicializarForm(),
* e so os containers estruturais do cabecalho/area de botoes (prova de
* "casca" exigida pelo gate da Fase 3 para form OPERACIONAL com
* Container no legado). Grid de condicoes, os containers flutuantes de
* forma de pagamento e os botoes de acao entram nas fases seguintes.
*
* Fase 4/8 - GRADE + BOTOES DE ACAO (layout FLAT, sem PageFrame):
*   1) ConfigurarGrid(): Grid legado "Grade" -> grd_4c_Condicoes, criado
*      direto em THIS (este form OPERACIONAL nao tem PageFrame, logo NAO
*      ha compensacao +29 de Top nem os metodos de pagina/alternancia do
*      padrao CRUD - exigi-los obrigaria a inventar um PageFrame que o
*      legado nao tem, violando o PILAR 1). As 6 colunas transcritas do
*      dump (Verdana 8, HeaderHeight 18, RowHeight 16, ReadOnly = .F.,
*      larguras 148/120/78/30/80/90, ColumnOrder de venc = 5, InputMask
*      de valor/cambio/desconto).
*   2) ConfigurarBotoesAcao(): os 5 CommandButton de acao que o legado
*      REALMENTE tem na barra superior - btnRetCash/Apaga/totite/Ok/
*      Cancela (Top 3, 75x75, Comic Sans MS 8 bold italic). NAO existem
*      no SIGOPPAG os botoes genericos Incluir/Visualizar/Alterar/
*      Excluir/Buscar do padrao CRUD, e inventa-los violaria o PILAR 1.
*   3) CarregarLista(): metodo UNICO de carga/repintura da grade, com o
*      bind canonico ColumnCount -> RecordSource -> ControlSource ->
*      Width -> Header1.Caption (RecordSource RESETA Width/Caption) e
*      fechando com GO TOP + Refresh (regra #21a: popular cursor NAO
*      repinta a grade).
*
* Fase 5/8 - CAMPOS PRINCIPAIS (PARTE 1/2):
*   ConfigurarCamposCondicao(): primeira metade dos campos soltos do
*   dump que ficam direto em SIGOPPAG (fora de qualquer container
*   flutuante) - o bloco "Condicao/Parcelas/Vencimento/Moeda/Valor
*   Original" que alimenta a linha da grade em edicao. Transcritos
*   Top/Left/Width/Height do dump; sem Format/InputMask porque o dump
*   nao declara nenhum para estes controles (regra #49 - "" no dump e
*   override vazio do Form Designer, nao se transcreve). A segunda
*   metade (bloco de Totais/Saldo/Variacao/checkboxes/avisos de porta)
*   entrou na Fase 6/8, abaixo.
*
* Fase 6/8 - CAMPOS RESTANTES (PARTE 2/2) E LOOKUPS:
*   ConfigurarCamposTotais(): segunda metade dos campos soltos do dump -
*   o bloco "Valores Totais/Saldo/Variacao/Desconto%/Cambio/Bonus" e os
*   checkboxes de atalho (Bot_TotForma/Bot_TotItem/Bot_Cotacoes/Bot_Cpg/
*   btnMascPgto/btnCash) e os 6 avisos de porta (AvisoPorta*), ainda fora
*   dos containers flutuantes de forma de pagamento (esses continuam na
*   Fase 7/8, junto com os Click/When/InteractiveChange).
*
*   ConfigurarLookups(): os DOIS lookups que o dump tem em controle
*   FILHO DIRETO do form - txt_4c_Modfpg (moeda da forma de pagamento,
*   SigCdMoe, legado Get_modfpg.Valid) e txt_4c_Fpg (forma de pagamento,
*   SigOpFp, legado Get_fpg.Valid). Os outros seis lookups do dump
*   (getModalidade/getFormas/getAdquirente/getbandeira/getGrupo do
*   container cntFundo.cntMascPgto e get_adquire do container cntnsu)
*   pertencem a controles de containers FLUTUANTES que a Fase 7/8 cria -
*   BINDEVENT em objeto que ainda nao existe estoura no proprio bind,
*   logo eles acompanham a criacao dos seus containers. Observacao fiel
*   ao legado: cntMascPgto.getGrupo tem "PROCEDURE When / Return .F.",
*   isto e, o campo nunca recebe foco e o Valid dele nunca dispara.
*
*   Arquitetura dos lookups (funil unico por campo, regra #47 + contrato
*   de nome AbrirBusca*/AbrirLookup* dos patterns #114/#215/#217 do
*   CorretorAutomatico):
*     Validar<X>LostFocus  - wrapper FINO da guarda this_lEmLookup<X>,
*                            ligado por BINDEVENT "LostFocus"; libera a
*                            flag DEPOIS do corpo, para que RETURN
*                            antecipado la dentro nao trave o lookup
*     Validar<X>Corpo      - decide (valor digitado + conexao viva) e
*                            chama o funil
*     Modfpg/FpgKeyPress   - F4/F5 com guarda de tecla (INLIST 115/116),
*                            save/restore da flag
*     Modfpg/FpgDblClick   - duplo clique, save/restore da flag
*     AbrirBusca<X>        - o PICKER (FormBuscaAuxiliar), metodo PUBLIC
*                            proprio; regra #36 (1o argumento e o handle
*                            gnConnHandle) e regra #37 (Show() so sob
*                            !this_lAchouRegistro, atribuicao so sob
*                            this_lSelecionou, USE IN + Release())
*   As quatro portas desaguam no MESMO AbrirBusca<X>, guardado pela
*   flag, entao nao ha risco de dois pickers empilhados. O lookup de
*   Fpg usa um cursor local filtrado (CarregarFormasPagamento(), porta
*   PARCIAL do mGetcsSigFpag legado - linha 4136 do dump): o filtro por
*   Empresa + Moeda e a exclusao da forma de pagamento padrao da
*   operacao (SigCdOpe.FpagOpCrs) sao aplicados; o filtro de GRUPO
*   EMPRESARIAL (crSigCdEmp.grupo) e o de MASCARA de cartao (plMasc,
*   ligado ao container flutuante cntFundo.cntMascPgto, Fase 7/8) ficam
*   fora - dependem de cursores/containers que so entram depois. A
*   extensa validacao de negocio que vem apos o lookup no Valid legado
*   (parcelas, CPF, tabela de desconto, bonus, autorizacao via
*   SigOpSen) e regra de GRAVACAO, nao de lookup - fica para a Fase 7/8.
*
* Fase 7/8 - EVENTOS DOS 5 BOTOES REAIS DE ACAO (cmd_4c_BtnRetCash/Apaga/
* Totite/Ok/Cancela - NAO os genericos Incluir/Alterar/Visualizar/Excluir
* do padrao CRUD, que este form OPERACIONAL nao tem, regra do cabecalho):
*   ConfigurarEventosBotoes(): BINDEVENT do Click dos 5 botoes a metodos
*   PUBLIC (regra #3). btnRetCash tambem tem When no dump, mas CommandButton
*   do VFP9 nao tem evento When nativo (era campo GET da base fwbutton do
*   legado) - BtnRetCashWhen() fica PUBLIC e disponivel, sem BINDEVENT, para
*   quando um futuro "AjustarBotoesPorModo" (regra #40) for escrito aqui.
*
*   BtnExcluirCondicaoClick()/BtnConfirmarClick()/BtnCancelarClick()/BtnTotalProdutosClick()/BtnRetCashClick() -
*   portas fieis das 5 Click do dump, com tres pendencias EXPLICITAS
*   (documentadas em cada metodo, nunca omitidas em silencio - REGRA
*   FUNDAMENTAL do CLAUDE.md):
*     1) totite ("Total dos Produtos") abre "DO FORM SigOpTot" no legado;
*        SigOpTot NAO foi migrado (fora do escopo desta task) e "DO FORM"
*        nunca abre dialogo filho no projeto novo - o Click avisa o usuario
*        em vez de tentar um stub silencioso;
*     2) btnRetCash ("Retorna Bonus") depende de ThisForm.parentform.OpenCash,
*        metodo do FORM PAI (cabecalho do movimento) que ainda nao existe -
*        nenhum form do acervo cria "Formsigoppag" ainda. O Click confere
*        PEMSTATUS antes de chamar (forward-compatible) e avisa quando
*        ausente, em vez de quebrar a regra #13;
*     3) Apaga/Ok dependem de pecas que outras fases ainda nao construiram:
*        os containers .Desconto/.Acrescimo, FSigOpFin_NF (imposto de
*        servico), ThisForm.ParentForm.Cotacao()/CalcServico()/CalcImposto()/
*        Procrateio()/Totpar() e a autorizacao via "DO FORM SigOpSen"
*        (gate de autorizacao ausente, mesma pendencia de outras tasks do
*        projeto). Cada bloco que falta fica comentado no proprio metodo,
*        com o recalculo SIMPLIFICADO (soma direta, sem conversao de
*        cotacao entre moedas) documentado como desvio.
*
*   BtnCancelarClick() chama VerifTef() (funcao GLOBAL do legado, sem definicao
*   no acervo - wrapper no-op documentado em utils\verifteF.prg, regra #27)
*   e fecha o dialogo; BtnConfirmarClick() valida TODAS as condicoes ja lancadas na
*   grade (cheque duplicado, situacao do cliente bloqueando desconto,
*   campos obrigatorios por forma de pagamento, percentual de SigCdTif),
*   persiste cada linha via THIS.this_oBusinessObject.Inserir()/Atualizar()
*   e so entao fecha - a montagem da linha a partir dos campos soltos
*   (txt_4c_Fpg/Npar/Vpar/DataVenc) pertence ao Valid de Dataget_venc no
*   legado (dump linha 7552), que NAO e um dos 5 botoes desta fase.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL:
*   AjustarBotoesPorModo(): centraliza o Enabled dos 5 botoes de acao
*   conforme this_cOpEscolha (regra #40 - quem desabilita no funil de
*   ida reabilita no de volta; aqui so ha "ida", chamado uma vez no
*   InicializarForm(), porque this_cOpEscolha nao muda durante a vida
*   deste dialogo modal).
*
*   HabilitarCampos()/LimparCampos(): portam os When() do dump que
*   dependem SO de this_cOpEscolha + preenchimento de Fpg (campos
*   totalizadores sao Return(.F.) no dump em QUALQUER modo). PENDENCIA
*   EXPLICITA (REGRA FUNDAMENTAL - nunca omitir em silencio): tres
*   When() do legado dependem de estado nao portado por fase alguma -
*   Thisform.Digpar (Get_npar), ThisForm.AplicaVariacao (Get_TVaria/
*   Get_pVaria) e o Seek em crSigCdCrg/CrSigCdMoe.Cotas (Get_COTACAO/
*   alteracotacao) - documentado dentro de HabilitarCampos(), nao
*   inventado.
*
*   FormParaBO()/BOParaForm() NAO SE APLICAM a este dialogo: o padrao
*   CRUD generico pressupoe UM registro em edicao espelhado 1-para-1
*   entre Form e BO, mas aqui cada linha da GRADE e uma condicao
*   independente, e o par funcional equivalente (BO.CarregarDoCursor()/
*   PersistirCondicoes(), Fase 2 e 7/8) ja transfere TODAS as colunas de
*   SigMvPar entre o cursor da grade e o BO a cada SCAN - inventar um
*   FormParaBO() que leia so os campos soltos (Fpg/Npar/Vpar/DataVenc)
*   duplicaria esse caminho sem cobrir as ~60 colunas que a grade nao
*   exibe (regra #22), e NAO seria chamado por nenhum fluxo real, dado
*   que a montagem da linha a partir dos campos soltos (Valid de
*   Dataget_venc, dump linha 7552) permanece fora de escopo (ver
*   BtnConfirmarClick, acima).
*
* Herda de: FormBase
*====================================================================

DEFINE CLASS Formsigoppag AS FormBase
    this_cMensagemErro = ""
	ShowWindow = 1

	*-- Propriedades visuais (dump do SCX legado - layout.json: Width
	*-- 1050, Height 615, Caption "Recebimento")
	Width = 1050
	Height = 615
	Caption = "Recebimento"
	WindowType = 1              && Modal - form filho do cabecalho do movimento
	AutoCenter = .T.
	BorderStyle = 2
	MaxButton = .F.
	MinButton = .F.

	*-- Referencia ao form pai (cabecalho do movimento) e a DataSession
	*-- compartilhada com ele (legado: Lparameters pForm, datses,
	*-- plAltDireta, plAutomatico - Set Datasession To datses). Mantidos
	*-- so no Form - o BO recebe apenas os escalares do cabecalho.
	this_oFormPai = .NULL.
	this_nDataSessionPai = 0
	this_lAltDireta = .F.        && plAltDireta - fluxo de alteracao direta da condicao
	this_lAutomatico = .F.       && plAutomatico - fluxo automatico (TEF/cartao via integracao)

	*-- Nome do cursor da grade de condicoes - mesmo nome usado pelo BO
	*-- (sigoppagBO.this_cCursorCondicoes)
	this_cCursorCondicoes = "cursor_4c_Condicoes"

	*-- Nome do cursor do LEGADO ao qual a grade se liga quando o form pai
	*-- ja o deixou aberto na DataSession compartilhada (dump:
	*-- Grade.RecordSource = "XPAR"). Enquanto ele nao existe (form aberto
	*-- isolado / modo de teste), a grade fica no cursor placeholder.
	this_cCursorLegado = "xPar"

	*-- Alias efetivamente ligado a grade na ultima carga (xPar ou o
	*-- cursor local de apoio) - usado pelos metodos de repintura.
	this_cAliasGrade = ""

	*-- Guardas de reentrancia dos lookups (regra #37/#47 - o picker e
	*-- MODAL e redispara o proprio LostFocus ao perder/retomar o foco)
	this_lEmLookupModfpg = .F.
	this_lEmLookupFpg = .F.

	*-- Cursor local filtrado para o lookup de forma de pagamento
	*-- (CarregarFormasPagamento - porta parcial de mGetcsSigFpag)
	this_cCursorFormasPagamento = "cursor_4c_FormasPagamento"

	*-- Modo do form PAI (legado: ThisForm.Op_Escolha = pForm.pcEscolha,
	*-- dump linha 4999) - gateia Apaga/Ok/BtnRetCash. Default seguro
	*-- "ALTERAR": o proprio comentario da Fase 6/8 (CarregarFormasPagamento,
	*-- acima) ja registra que "este form filho so abre" em INSERIR/ALTERAR;
	*-- nenhum form do acervo ainda cria "Formsigoppag" (grep confirmado -
	*-- zero CREATEOBJECT), entao nao ha, por ora, uma property real do pai
	*-- para ler - Init() tenta "pcEscolha" via PEMSTATUS e so sobrescreve o
	*-- default quando ela existir.
	this_cOpEscolha = "ALTERAR"

	*-- Guarda de reentrancia do fechamento do dialogo (Ok/Cancela) - evita
	*-- Release() duplicado se o usuario conseguir disparar os dois botoes
	*-- em sequencia muito rapida (ex.: Enter + Cancel do mesmo clique).
	this_lFechando = .F.

	*====================================================================
	* Init - recebe o form pai, a DataSession compartilhada por ele e as
	* duas flags de comportamento (equivalente ao Lparameters do Init
	* legado). DODEFAULT() aciona FormBase.Init(), que chama o hook
	*====================================================================
	PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_lAltDireta, par_lAutomatico)
		IF VARTYPE(par_oFormPai) = "O"
			THIS.this_oFormPai = par_oFormPai

			*-- Legado: ".Op_Escolha = pForm.pcEscolha" (dump linha 4999). So
			*-- sobrescreve o default "ALTERAR" quando o pai de fato expoe a
			*-- property - nenhum form do acervo ainda a declara.
			IF PEMSTATUS(par_oFormPai, "pcEscolha", 5) AND VARTYPE(par_oFormPai.pcEscolha) = "C" AND !EMPTY(par_oFormPai.pcEscolha)
				THIS.this_cOpEscolha = UPPER(ALLTRIM(par_oFormPai.pcEscolha))
			ENDIF
		ENDIF

		IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
			THIS.this_nDataSessionPai = par_nDataSessionPai
			SET DATASESSION TO (par_nDataSessionPai)
		ENDIF

		IF VARTYPE(par_lAltDireta) = "L"
			THIS.this_lAltDireta = par_lAltDireta
		ENDIF

		IF VARTYPE(par_lAutomatico) = "L"
			THIS.this_lAutomatico = par_lAutomatico
		ENDIF

		RETURN DODEFAULT()
	ENDPROC

	*====================================================================
	* InicializarForm - hook chamado por FormBase.Init(). Le os escalares
	* do cabecalho do movimento (TprMvCab, aberto pelo form pai na MESMA
	* DataSession), instancia o BO com eles e monta o layout.
	*====================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lSucesso, loc_cEmps, loc_cDopes, loc_nNumes

		loc_lSucesso = .F.
		loc_cEmps  = ""
		loc_cDopes = ""
		loc_nNumes = 0

		IF USED("TprMvCab")
			SELECT TprMvCab
			loc_cEmps  = TratarNulo(Emps, "")
			loc_cDopes = TratarNulo(Dopes, "")
			loc_nNumes = TratarNulo(Numes, 0)
		ENDIF

		THIS.this_oBusinessObject = CREATEOBJECT("sigoppagBO", loc_cEmps, loc_cDopes, ;
			loc_nNumes, THIS.this_lAltDireta, THIS.this_lAutomatico)

		*-- Regra OPERACIONAL #4/precedente do projeto: SET DELETED ON global
		*-- (start\config.prg) pode nao valer na DataSession deste form (ex.:
		*-- rodando isolado, antes do SET DATASESSION TO do pai) - reposto
		*-- aqui para que BtnExcluirCondicaoClick()/DELETE some da grade sem precisar de
		*-- PACK (Fase 7/8).
		SET DELETED ON

		IF VARTYPE(THIS.this_oBusinessObject) = "O"
			THIS.ConfigurarLayout()
			THIS.ConfigurarBotoesAcao()
			THIS.ConfigurarGrid()
			THIS.ConfigurarCamposCondicao()
			THIS.ConfigurarCamposTotais()
			THIS.ConfigurarLookups()
			THIS.ConfigurarEventosBotoes()

			*-- Fase 7/8: cabecalho do movimento (TprMvCab/SigMvCab) +
			*-- configuracao da operacao (SigCdOpe), usados pelos Click dos 5
			*-- botoes de acao. Roda tambem em modo de validacao de UI (so
			*-- faz leitura; sem gnConnHandle valido o SQLEXEC de SigCdOpe
			*-- simplesmente nao preenche as propriedades *Ope, que ficam no
			*-- default ja declarado).
			THIS.this_oBusinessObject.CarregarConfiguracao()

			*-- Fase 8/8: Enabled dos botoes de acao e dos campos soltos
			*-- (depende de this_oBusinessObject.this_nParAutosOpe, logo
			*-- roda SO depois de CarregarConfiguracao() acima).
			THIS.AjustarBotoesPorModo()
			THIS.HabilitarCampos()

			*-- So busca SigMvPar por conta propria quando xPar (o cursor do
			*-- form PAI) nao esta disponivel - replicar aqui com o pai
			*-- presente duplicaria/sobrescreveria o buffer compartilhado
			*-- dele (regra #21/comentario de CarregarLista abaixo).
			IF !USED(THIS.this_cCursorLegado)
				THIS.this_oBusinessObject.CarregarCondicoes()
			ENDIF

			*-- Primeira pintura da grade. NAO depende de gnConnHandle: a
			*-- carga aqui e so o bind do cursor que o form pai deixou
			*-- aberto (xPar) ou do placeholder - por isso roda tambem em
			*-- modo de validacao de UI.
			THIS.CarregarLista()

			loc_lSucesso = .T.
		ELSE
			THIS.this_cMensagemErro = "Falha ao instanciar sigoppagBO"
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfigurarLayout - casca do layout custom: faixa do cabecalho (com
	* o mesmo padrao visual do CRUD - BackColor RGB(100,100,100) + label
	* sombra/titulo) e o container que hospeda os botoes de acao.
	*
	* A faixa e o PRIMEIRO AddObject do form (regra #11): os containers de
	* botao ficam em Top = 0..80, DENTRO da area da faixa, e so desenham
	* por cima dela se criados DEPOIS.
	*====================================================================
	PROTECTED PROCEDURE ConfigurarLayout()
		THIS.AddObject("cnt_4c_Cabecalho", "Container")
		WITH THIS.cnt_4c_Cabecalho
			.Top = 0
			.Left = 0
			.Width = THIS.Width
			.Height = 80
			.BackStyle = 1
			.BackColor = RGB(100, 100, 100)
			.BorderWidth = 0
			.SpecialEffect = 0
			.Visible = .T.

			.AddObject("lbl_4c_Sombra", "Label")
			WITH .lbl_4c_Sombra
				.Top = 15
				.Left = 10
				.Width = THIS.Width
				.Height = 40
				.FontName = "Tahoma"
				.FontSize = 16
				.FontBold = .T.
				.ForeColor = RGB(0, 0, 0)
				.BackStyle = 0
				.AutoSize = .F.
				.Caption = THIS.Caption
				.Visible = .T.
			ENDWITH

			.AddObject("lbl_4c_Titulo", "Label")
			WITH .lbl_4c_Titulo
				.Top = 18
				.Left = 10
				.Width = THIS.Width
				.Height = 46
				.FontName = "Tahoma"
				.FontSize = 16
				.FontBold = .T.
				.ForeColor = RGB(255, 255, 255)
				.BackStyle = 0
				.AutoSize = .F.
				.Caption = THIS.Caption
				.Visible = .T.
			ENDWITH
		ENDWITH

		*-- Container dos botoes de acao. Transparente (BackStyle = 0) para
		*-- a faixa cinza aparecer por tras, e criado DEPOIS da faixa para
		*-- desenhar por cima dela. Left = 660 (1050 - 390) alinha o
		*-- container ao primeiro botao do legado (btnRetCash, Left = 672
		*-- absoluto -> 12 relativo); o ultimo (Cancela, 973 absoluto ->
		*-- 313 relativo) termina em 388, dentro dos 390 de largura.
		THIS.AddObject("cnt_4c_Botoes", "Container")
		WITH THIS.cnt_4c_Botoes
			.Top = 0
			.Left = THIS.Width - 390
			.Width = 390
			.Height = 80
			.BackStyle = 0
			.BorderWidth = 0
			.Visible = .T.
		ENDWITH
	ENDPROC

	*====================================================================
	* ConfigurarBotoesAcao - os 5 CommandButton da barra superior do
	* legado, transcritos do dump (todos Top = 3, 75x75, Comic Sans MS 8
	* bold italic, ForeColor 90,90,90, BackColor 255,255,255,
	* PicturePosition do dump).
	*
	* Left RELATIVO ao cnt_4c_Botoes (regra Erro143 - usar o Left absoluto
	* do SCX aqui jogaria o botao fora do form):
	*   btnRetCash 672 -> 12 | Apaga 748 -> 88 | totite 823 -> 163
	*   Ok         898 -> 238 | Cancela 973 -> 313
	*
	* .Picture transcrita do dump (regra #25 - NUNCA inventar o nome do
	* arquivo; os 5 .jpg conferidos em vbmp\). Themes = .T. +
	* DisabledPicture = a mesma imagem (Pattern #99): estes botoes sao
	* CommandButton standalone COM Picture e COM Caption, e o legado os
	* desabilita por modo (os When gateiam em INSERIR/ALTERAR) - com
	* Themes = .F. o icone desaparece ao ficar Enabled = .F.
	*
	* Os Click/When entram nas Fases 7-8 (esta fase entrega os controles).
	*====================================================================
	PROTECTED PROCEDURE ConfigurarBotoesAcao()
		LOCAL loc_oCnt

		loc_oCnt = THIS.cnt_4c_Botoes

		*-- btnRetCash "Retorna Bonus" - nasce INVISIVEL no legado
		*-- (Visible = .F. no dump); so aparece quando a operacao tem
		*-- bonus/cashback liberado.
		loc_oCnt.AddObject("cmd_4c_BtnRetCash", "CommandButton")
		WITH loc_oCnt.cmd_4c_BtnRetCash
			.Top = 3
			.Left = 12
			.Width = 75
			.Height = 75
			.FontName = "Comic Sans MS"
			.FontSize = 8
			.FontBold = .T.
			.FontItalic = .T.
			.ForeColor = RGB(90, 90, 90)
			.BackColor = RGB(255, 255, 255)
			.Themes = .T.
			.SpecialEffect = 0
			.AutoSize = .F.
			.WordWrap = .T.
			.MousePointer = 15
			.PicturePosition = 7
			.Picture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
			.Caption = "Retorna B" + CHR(244) + "nus"
			.ToolTipText = "Retorna B" + CHR(244) + "nus"
			.Visible = .F.
		ENDWITH

		*-- Apaga "Excluir Condicao" - remove a condicao selecionada na grade
		loc_oCnt.AddObject("cmd_4c_Apaga", "CommandButton")
		WITH loc_oCnt.cmd_4c_Apaga
			.Top = 3
			.Left = 88
			.Width = 75
			.Height = 75
			.FontName = "Comic Sans MS"
			.FontSize = 8
			.FontBold = .T.
			.FontItalic = .T.
			.ForeColor = RGB(90, 90, 90)
			.BackColor = RGB(255, 255, 255)
			.Themes = .T.
			.SpecialEffect = 0
			.AutoSize = .F.
			.WordWrap = .T.
			.PicturePosition = 7
			.Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
			.Caption = "Excluir Condi" + CHR(231) + CHR(227) + "o"
			.ToolTipText = "Apagar Condi" + CHR(231) + CHR(227) + "o de Pagamento"
			.Visible = .T.
		ENDWITH

		*-- totite "Total dos Produtos"
		loc_oCnt.AddObject("cmd_4c_Totite", "CommandButton")
		WITH loc_oCnt.cmd_4c_Totite
			.Top = 3
			.Left = 163
			.Width = 75
			.Height = 75
			.FontName = "Comic Sans MS"
			.FontSize = 8
			.FontBold = .T.
			.FontItalic = .T.
			.ForeColor = RGB(90, 90, 90)
			.BackColor = RGB(255, 255, 255)
			.Themes = .T.
			.SpecialEffect = 0
			.AutoSize = .F.
			.WordWrap = .T.
			.PicturePosition = 7
			.Picture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
			.Caption = "Total dos Produtos"
			.ToolTipText = "Total da Movimenta" + CHR(231) + CHR(227) + "o"
			.Visible = .T.
		ENDWITH

		*-- Ok "Confirmar" - o "\<" do dump e o marcador de tecla de acesso
		loc_oCnt.AddObject("cmd_4c_Ok", "CommandButton")
		WITH loc_oCnt.cmd_4c_Ok
			.Top = 3
			.Left = 238
			.Width = 75
			.Height = 75
			.FontName = "Comic Sans MS"
			.FontSize = 8
			.FontBold = .T.
			.FontItalic = .T.
			.ForeColor = RGB(90, 90, 90)
			.BackColor = RGB(255, 255, 255)
			.Themes = .T.
			.SpecialEffect = 0
			.AutoSize = .F.
			.PicturePosition = 13
			.Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
			.Caption = "\<Confirmar"
			.Cancel = .T.
			.Visible = .T.
		ENDWITH

		*-- Cancela "Encerrar" - criado DEPOIS do Ok de proposito: o dump
		*-- traz Cancel = .T. nos DOIS botoes e, em VFP9, o ultimo a
		*-- receber Cancel = .T. e quem responde ao ESC. Mantendo a ordem
		*-- do legado, o ESC continua fechando a tela ([ESC] Sair no
		*-- ToolTipText do proprio dump).
		loc_oCnt.AddObject("cmd_4c_Cancela", "CommandButton")
		WITH loc_oCnt.cmd_4c_Cancela
			.Top = 3
			.Left = 313
			.Width = 75
			.Height = 75
			.FontName = "Comic Sans MS"
			.FontSize = 8
			.FontBold = .T.
			.FontItalic = .T.
			.ForeColor = RGB(90, 90, 90)
			.BackColor = RGB(255, 255, 255)
			.Themes = .T.
			.SpecialEffect = 0
			.AutoSize = .F.
			.PicturePosition = 13
			.Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
			.Caption = "Encerrar"
			.Cancel = .T.
			.ToolTipText = "[ESC] Sair"
			.Visible = .T.
		ENDWITH
	ENDPROC

	*====================================================================
	* ConfigurarGrid - cria o cursor local de apoio da grade de condicoes e
	* o Grid que a exibe. Equivalente ao metodo de montagem da pagina de
	* lista do CRUD, mas este form NAO tem PageFrame (layout FLAT - o Grid
	* legado "Grade" fica direto no form, sem compensacao +29 de Top:
	* dump Top=107, Left=444, Width=573, Height=246).
	*
	* O cursor placeholder cobre as 6 colunas exibidas, a chave
	* (cidchaves), os identificadores do cabecalho (emps/dopes/numes) e as
	* 4 colunas que a expressao de DynamicForeColor do legado le
	* (inschs/numchqs/nidcheps/trocos) - sem elas a expressao estouraria
	* na primeira pintura. Tipos conferidos em docs\schema.sql (SigMvPar):
	* fpags char(12), valos numeric(11,2), vencs datetime, moefpgs
	* char(3), cotfpgs numeric(11,4), valdescs numeric(11,2), inschs bit,
	* numchqs char(8), nidcheps numeric(10,0), trocos numeric(1,0).
	*
	* SET NULL ON antes do CREATE CURSOR (regra OPERACIONAL #4): os
	* valores virao de SQLEXEC/SQL Server, que pode devolver NULL. Declarar
	* inschs como L aqui tambem NORMALIZA o bit do SQL Server (que chega
	* ora logico, ora numerico conforme o driver) na carga por
	* ZAP + APPEND FROM DBF() da Fase 7.
	*
	* As propriedades do Grid e das 6 colunas sao transcritas do dump
	* (Verdana 8 - NAO Tahoma; HeaderHeight 18; RowHeight 16;
	* ReadOnly = .F.). Column1 e a UNICA ReadOnly = .T., e isso e aplicado
	* DEPOIS do ReadOnly do Grid, que propaga para as colunas.
	*====================================================================
	PROTECTED PROCEDURE ConfigurarGrid()
		LOCAL loc_cCursor

		loc_cCursor = THIS.this_cCursorCondicoes

		IF !USED(loc_cCursor)
			SET NULL ON
			CREATE CURSOR (loc_cCursor) ;
				(cidchaves C(20) NULL, emps C(3) NULL, dopes C(20) NULL, ;
				 numes N(6, 0) NULL, fpags C(12) NULL, valos N(11, 2) NULL, ;
				 vencs T NULL, moefpgs C(3) NULL, cotfpgs N(11, 4) NULL, ;
				 valdescs N(11, 2) NULL, inschs L NULL, numchqs C(8) NULL, ;
				 nidcheps N(10, 0) NULL, trocos N(1, 0) NULL)
			SET NULL OFF
		ENDIF

		THIS.AddObject("grd_4c_Condicoes", "Grid")
		WITH THIS.grd_4c_Condicoes
			.Top = 107
			.Left = 444
			.Width = 573
			.Height = 246
			.FontName = "Verdana"
			.FontSize = 8
			.HeaderHeight = 18
			.RowHeight = 16
			.ReadOnly = .F.
			.RecordMark = .F.
			.DeleteMark = .F.
			.ChildOrder = ""
			.ScrollBars = 2
			.GridLines = 1
			.GridLineColor = RGB(238, 238, 238)
			.HighlightBackColor = RGB(255, 255, 255)
			.HighlightForeColor = RGB(15, 41, 104)
			.HighlightStyle = 2
			.Visible = .T.

			*-- Propriedades das colunas que NAO dependem do cursor. As que
			*-- dependem (ControlSource) e as que o RecordSource RESETA
			*-- (Width, Header1.Caption) ficam em CarregarLista().
			.Column1.FontName = "Verdana"
			.Column1.FontSize = 8
			.Column1.Movable = .F.
			.Column1.Resizable = .F.

			.Column2.FontName = "Verdana"
			.Column2.FontSize = 8
			.Column2.Movable = .F.
			.Column2.Resizable = .F.
			.Column2.InputMask = "999999,999.99"

			.Column3.FontName = "Verdana"
			.Column3.FontSize = 8
			.Column3.Movable = .F.
			.Column3.Resizable = .F.

			.Column4.FontName = "Verdana"
			.Column4.FontSize = 8
			.Column4.Movable = .F.
			.Column4.Resizable = .F.

			.Column5.FontName = "Verdana"
			.Column5.FontSize = 8
			.Column5.Movable = .F.
			.Column5.Resizable = .F.
			.Column5.InputMask = "999.9999"

			.Column6.FontName = "Verdana"
			.Column6.FontSize = 8
			.Column6.InputMask = "999999,999.99"

			*-- ReadOnly das colunas DEPOIS do ReadOnly do Grid (que
			*-- propaga e sobrescreveria): no dump so a coluna da condicao
			*-- (fpagto) e somente-leitura.
			.Column1.ReadOnly = .T.
			.Column2.ReadOnly = .F.
			.Column3.ReadOnly = .F.
			.Column4.ReadOnly = .F.
			.Column5.ReadOnly = .F.
			.Column6.ReadOnly = .F.
		ENDWITH
	ENDPROC

	*====================================================================
	* ConfigurarCamposCondicao - PARTE 1/2 dos campos soltos do dump que
	* ficam direto em SIGOPPAG (fora dos containers flutuantes de forma
	* de pagamento): o bloco "Condicao / Parcelas / Vencimento / Moeda /
	* Valor Original" que espelha a linha corrente da grade (xPar) em
	* edicao. Sem ControlSource/eventos ainda (Fases 7-8) - so os
	* controles, nas posicoes e tamanhos exatos do dump.
	*
	* Mapeamento (SCX legado -> migrado), Top/Left/Width/Height do dump:
	*   Say12          -> lbl_4c_Condicao     (147,96)  "Condicao :"
	*   Get_modfpg     -> txt_4c_Modfpg       (142,178,36,25)  numeric
	*   Get_fpg        -> txt_4c_Fpg          (142,218,147,25) char(12)
	*   Say13          -> lbl_4c_Parcelas     (174,119) "Parcelas :"
	*   Get_npar       -> txt_4c_Npar         (169,178,36,25)  numeric
	*   GetPorc        -> txt_4c_Porc         (169,218,147,25) numeric
	*   Say17          -> lbl_4c_Valor        (228,135) "Valor :"
	*   Get_vpar       -> txt_4c_Vpar         (223,178,186,25) numeric
	*   Say2           -> lbl_4c_Vencimento   (254,96)  "Vencimento :"
	*   Get_Dias       -> txt_4c_Dias         (250,178,36,25)  numeric
	*   Dataget_venc   -> txt_4c_DataVenc     (250,218,146,25) date
	*   Say20          -> lbl_4c_Moeda        (302,132) "Moeda :"
	*   Get_moeoper    -> txt_4c_MoeOper      (297,182,35,25)  char(3)
	*   Say24          -> lbl_4c_Original     (329,129) "Original :"
	*   Get_valinic    -> txt_4c_ValInic      (324,182,146,25) numeric
	*   Line1          -> lin_4c_Line1        (292,41,370,1)   divisor
	*   Shape1         -> shp_4c_Shape1       (9,640,1,27)     divisor
	*====================================================================
	PROTECTED PROCEDURE ConfigurarCamposCondicao()
		*-- Condicao (fpags - char(12)) + modalidade da forma de pgto
		THIS.AddObject("lbl_4c_Condicao", "Label")
		WITH THIS.lbl_4c_Condicao
			.Top = 147
			.Left = 96
			.Width = 78
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Condi" + CHR(231) + CHR(227) + "o :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Modfpg", "TextBox")
		WITH THIS.txt_4c_Modfpg
			.Top = 142
			.Left = 178
			.Width = 36
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Fpg", "TextBox")
		WITH THIS.txt_4c_Fpg
			.Top = 142
			.Left = 218
			.Width = 147
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = ""
			.Visible = .T.
		ENDWITH

		*-- Parcelas (nparcs) + % de variacao (pVarias)
		THIS.AddObject("lbl_4c_Parcelas", "Label")
		WITH THIS.lbl_4c_Parcelas
			.Top = 174
			.Left = 119
			.Width = 55
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Parcelas :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Npar", "TextBox")
		WITH THIS.txt_4c_Npar
			.Top = 169
			.Left = 178
			.Width = 36
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Porc", "TextBox")
		WITH THIS.txt_4c_Porc
			.Top = 169
			.Left = 218
			.Width = 147
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Valor da parcela (valos)
		THIS.AddObject("lbl_4c_Valor", "Label")
		WITH THIS.lbl_4c_Valor
			.Top = 228
			.Left = 135
			.Width = 39
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Valor :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Vpar", "TextBox")
		WITH THIS.txt_4c_Vpar
			.Top = 223
			.Left = 178
			.Width = 186
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Vencimento (vencs) + dias (Dias)
		THIS.AddObject("lbl_4c_Vencimento", "Label")
		WITH THIS.lbl_4c_Vencimento
			.Top = 254
			.Left = 96
			.Width = 78
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Vencimento :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Dias", "TextBox")
		WITH THIS.txt_4c_Dias
			.Top = 250
			.Left = 178
			.Width = 36
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_DataVenc", "TextBox")
		WITH THIS.txt_4c_DataVenc
			.Top = 250
			.Left = 218
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = {}
			.Visible = .T.
		ENDWITH

		*-- Moeda da operacao (Cmoes) + valor original (Valinis)
		THIS.AddObject("lbl_4c_Moeda", "Label")
		WITH THIS.lbl_4c_Moeda
			.Top = 302
			.Left = 132
			.Width = 46
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Moeda :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_MoeOper", "TextBox")
		WITH THIS.txt_4c_MoeOper
			.Top = 297
			.Left = 182
			.Width = 35
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = ""
			.Visible = .T.
		ENDWITH

		THIS.AddObject("lbl_4c_Original", "Label")
		WITH THIS.lbl_4c_Original
			.Top = 329
			.Left = 129
			.Width = 49
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Original :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_ValInic", "TextBox")
		WITH THIS.txt_4c_ValInic
			.Top = 324
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Divisores decorativos do dump (Line1/Shape1), sem funcao de
		*-- dado - so separam visualmente o bloco de condicao do restante
		THIS.AddObject("lin_4c_Line1", "Line")
		WITH THIS.lin_4c_Line1
			.Top = 292
			.Left = 41
			.Width = 370
			.Height = 1
			.Visible = .T.
		ENDWITH

		THIS.AddObject("shp_4c_Shape1", "Shape")
		WITH THIS.shp_4c_Shape1
			.Top = 9
			.Left = 640
			.Width = 1
			.Height = 27
			.Visible = .T.
		ENDWITH
	ENDPROC

	*====================================================================
	* ConfigurarCamposTotais - PARTE 2/2 dos campos soltos do dump que
	* ficam direto em SIGOPPAG: o bloco "Valores Totais / Saldo /
	* Variacao / Desconto % / Cambio / Bonus" mais os checkboxes de
	* atalho e os 6 avisos de porta. Sem ControlSource/eventos ainda
	* (Fases 7-8) - so os controles, nas posicoes e tamanhos exatos do
	* dump (layout.json).
	*
	* Mapeamento (SCX legado -> migrado), Top/Left/Width/Height do dump:
	*   Say6           -> lbl_4c_ValoresTotais (273,70,87,16) "Valores Totais"
	*   Get_TotServico -> txt_4c_TotServico    (351,182,146,25) numeric
	*   Say21          -> lbl_4c_Servicos      (356,124) "Servicos :"
	*   getValTrans    -> txt_4c_ValTrans      (378,182,146,25) numeric
	*   Say7           -> lbl_4c_Transporte    (383,108) "Transporte :"
	*   Get_Variacao   -> txt_4c_Variacao      (405,182,146,25) numeric
	*   Say5           -> lbl_4c_Variacao      (410,123) "Variacao :"
	*   Get_valtot     -> txt_4c_ValTot        (432,182,146,25) numeric
	*   Get_pVaria     -> txt_4c_PVaria        (513,182,146,25) numeric
	*   Say3           -> lbl_4c_DescontoPercent (514,90,88,16) "Desconto (%) :"
	*   Get_Saldo      -> txt_4c_Saldo         (486,182,146,25) numeric
	*   Say1           -> lbl_4c_Saldo         (491,134) "Saldo :"
	*   Get_TotForma   -> txt_4c_TotForma      (459,182,146,25) numeric
	*   Say4           -> lbl_4c_DescontoCifrao (545,95,83,16) "Desconto ($) :"
	*   Get_TVaria     -> txt_4c_TVaria        (540,182,146,25) numeric
	*   Get_pDescP     -> txt_4c_PDescP        (570,769,71,23) numeric
	*   Get_VDescP     -> txt_4c_VDescP        (570,858,111,23) numeric
	*   Label2         -> lbl_4c_PercentVDescP (575,750,16,15) "%"
	*   Label1         -> lbl_4c_CifraoVDescP  (575,845,10,15) "$"
	*   lblValUtiCsh   -> lbl_4c_ValUtiCsh     (86,758) "Bonus :"
	*   getValUtiCsh   -> txt_4c_ValUtiCsh     (82,805,117,25) numeric
	*   btnCash        -> chk_4c_BtnCash       (83,924,111,23) "Aplicar Bonus"
	*   Get_COTACAO    -> txt_4c_Cotacao       (196,178,100,25) numeric - oculto no dump
	*   alteracotacao  -> cmd_4c_AlteraCotacao (196,281,26,26) "\<C$" - oculto no dump
	*   Say_Cotacao    -> lbl_4c_Cambio        (201,123) "Cambio :" - oculto no dump
	*   Bot_Cpg        -> chk_4c_BotCpg        (142,368,26,26) "$"
	*   Bot_Cotacoes   -> chk_4c_BotCotacoes   (297,220,33,26)
	*   Bot_TotItem    -> chk_4c_BotTotItem    (324,331,33,26)
	*   Bot_TotForma   -> chk_4c_BotTotForma   (459,331,33,26)
	*   btnMascPgto    -> chk_4c_BtnMascPgto   (142,397,26,26) "..." - oculto no dump
	*   Say10          -> lbl_4c_Movimentacao  (437,90) "Movimentacao :"
	*   Say23          -> lbl_4c_Recebimento   (464,96) "Recebimento :"
	*   lbl_Mensagem   -> lbl_4c_Mensagem      (85,444,276,18) "Mensagem" - oculto no dump
	*   AvisoPortaS/M/T/C/A/K -> txt_4c_AvisoPorta<X> (108/132/156/180/204/228, 1020,20,23)
	*====================================================================
	PROTECTED PROCEDURE ConfigurarCamposTotais()
		*-- Titulo da secao "Valores Totais" (Say6 - classe say pura, sem
		*-- Width/Alignment declarados no dump, regra #23)
		THIS.AddObject("lbl_4c_ValoresTotais", "Label")
		WITH THIS.lbl_4c_ValoresTotais
			.Top = 273
			.Left = 70
			.Width = 87
			.Height = 16
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Valores Totais"
			.Visible = .T.
		ENDWITH

		*-- Total de servicos (Get_TotServico)
		THIS.AddObject("lbl_4c_Servicos", "Label")
		WITH THIS.lbl_4c_Servicos
			.Top = 356
			.Left = 124
			.Width = 55
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Servi" + CHR(231) + "os :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_TotServico", "TextBox")
		WITH THIS.txt_4c_TotServico
			.Top = 351
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Valor de transporte/frete (getValTrans)
		THIS.AddObject("lbl_4c_Transporte", "Label")
		WITH THIS.lbl_4c_Transporte
			.Top = 383
			.Left = 108
			.Width = 70
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Transporte :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_ValTrans", "TextBox")
		WITH THIS.txt_4c_ValTrans
			.Top = 378
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Variacao (desconto/acrescimo manual total - Get_Variacao)
		THIS.AddObject("lbl_4c_Variacao", "Label")
		WITH THIS.lbl_4c_Variacao
			.Top = 410
			.Left = 123
			.Width = 55
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Varia" + CHR(231) + CHR(227) + "o :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Variacao", "TextBox")
		WITH THIS.txt_4c_Variacao
			.Top = 405
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Valor total do movimento (Get_valtot)
		THIS.AddObject("txt_4c_ValTot", "TextBox")
		WITH THIS.txt_4c_ValTot
			.Top = 432
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Total das formas de pagamento ja lancadas (Get_TotForma)
		THIS.AddObject("txt_4c_TotForma", "TextBox")
		WITH THIS.txt_4c_TotForma
			.Top = 459
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Saldo a distribuir (Get_Saldo)
		THIS.AddObject("lbl_4c_Saldo", "Label")
		WITH THIS.lbl_4c_Saldo
			.Top = 491
			.Left = 134
			.Width = 39
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Saldo :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Saldo", "TextBox")
		WITH THIS.txt_4c_Saldo
			.Top = 486
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Desconto em percentual sobre a parcela corrente (Get_pVaria)
		THIS.AddObject("lbl_4c_DescontoPercent", "Label")
		WITH THIS.lbl_4c_DescontoPercent
			.Top = 514
			.Left = 90
			.Width = 88
			.Height = 16
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Desconto (%) :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_PVaria", "TextBox")
		WITH THIS.txt_4c_PVaria
			.Top = 513
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Desconto em valor sobre a parcela corrente (Get_TVaria)
		THIS.AddObject("lbl_4c_DescontoCifrao", "Label")
		WITH THIS.lbl_4c_DescontoCifrao
			.Top = 545
			.Left = 95
			.Width = 83
			.Height = 16
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Desconto ($) :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_TVaria", "TextBox")
		WITH THIS.txt_4c_TVaria
			.Top = 540
			.Left = 182
			.Width = 146
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Percentual e valor de desconto financeiro (Get_pDescP/Get_VDescP)
		THIS.AddObject("txt_4c_PDescP", "TextBox")
		WITH THIS.txt_4c_PDescP
			.Top = 570
			.Left = 769
			.Width = 71
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("lbl_4c_PercentVDescP", "Label")
		WITH THIS.lbl_4c_PercentVDescP
			.Top = 575
			.Left = 750
			.Width = 16
			.Height = 15
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "%"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_VDescP", "TextBox")
		WITH THIS.txt_4c_VDescP
			.Top = 570
			.Left = 858
			.Width = 111
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("lbl_4c_CifraoVDescP", "Label")
		WITH THIS.lbl_4c_CifraoVDescP
			.Top = 575
			.Left = 845
			.Width = 10
			.Height = 15
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "$"
			.Visible = .T.
		ENDWITH

		*-- Bonus/cashback disponivel (lblValUtiCsh/getValUtiCsh) + checkbox
		*-- "Aplicar Bonus" (btnCash)
		THIS.AddObject("lbl_4c_ValUtiCsh", "Label")
		WITH THIS.lbl_4c_ValUtiCsh
			.Top = 86
			.Left = 758
			.Width = 45
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "B" + CHR(244) + "nus :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_ValUtiCsh", "TextBox")
		WITH THIS.txt_4c_ValUtiCsh
			.Top = 82
			.Left = 805
			.Width = 117
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("chk_4c_BtnCash", "CheckBox")
		WITH THIS.chk_4c_BtnCash
			.Top = 83
			.Left = 924
			.Width = 111
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption = "Aplicar B" + CHR(244) + "nus"
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Cambio manual (Get_COTACAO/alteracotacao/Say_Cotacao) - OCULTOS
		*-- no dump (visible:false): so aparecem quando a moeda da forma de
		*-- pagamento exige cotacao manual (CrSigCdCrg.AltCots - Fase 7/8).
		THIS.AddObject("lbl_4c_Cambio", "Label")
		WITH THIS.lbl_4c_Cambio
			.Top = 201
			.Left = 123
			.Width = 45
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "C" + CHR(226) + "mbio :"
			.Visible = .F.
		ENDWITH

		THIS.AddObject("txt_4c_Cotacao", "TextBox")
		WITH THIS.txt_4c_Cotacao
			.Top = 196
			.Left = 178
			.Width = 100
			.Height = 25
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = 0
			.Visible = .F.
		ENDWITH

		THIS.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
		WITH THIS.cmd_4c_AlteraCotacao
			.Top = 196
			.Left = 281
			.Width = 26
			.Height = 26
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackColor = RGB(255, 255, 255)
			.Caption = "\<C$"
			.Visible = .F.
		ENDWITH

		*-- Checkboxes de atalho (Bot_TotForma/Bot_TotItem/Bot_Cotacoes/
		*-- Bot_Cpg) - togglers de grade auxiliar/modo de calculo, sem
		*-- Caption proprio no dump (so Bot_Cpg tem "$")
		THIS.AddObject("chk_4c_BotTotForma", "CheckBox")
		WITH THIS.chk_4c_BotTotForma
			.Top = 459
			.Left = 331
			.Width = 33
			.Height = 26
			.Caption = ""
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("chk_4c_BotTotItem", "CheckBox")
		WITH THIS.chk_4c_BotTotItem
			.Top = 324
			.Left = 331
			.Width = 33
			.Height = 26
			.Caption = ""
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("chk_4c_BotCotacoes", "CheckBox")
		WITH THIS.chk_4c_BotCotacoes
			.Top = 297
			.Left = 220
			.Width = 33
			.Height = 26
			.Caption = ""
			.Value = 0
			.Visible = .T.
		ENDWITH

		THIS.AddObject("chk_4c_BotCpg", "CheckBox")
		WITH THIS.chk_4c_BotCpg
			.Top = 142
			.Left = 368
			.Width = 26
			.Height = 26
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption = "$"
			.Value = 0
			.Visible = .T.
		ENDWITH

		*-- Mascara de cartao (btnMascPgto) - OCULTO no dump; abre o
		*-- container flutuante cntFundo.cntMascPgto (Fase 7/8)
		THIS.AddObject("chk_4c_BtnMascPgto", "CheckBox")
		WITH THIS.chk_4c_BtnMascPgto
			.Top = 142
			.Left = 397
			.Width = 26
			.Height = 26
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.Caption = "..."
			.Value = 0
			.Visible = .F.
		ENDWITH

		*-- Titulos "Movimentacao :" / "Recebimento :" (separadores de
		*-- secao da area de totais, classe say pura)
		THIS.AddObject("lbl_4c_Movimentacao", "Label")
		WITH THIS.lbl_4c_Movimentacao
			.Top = 437
			.Left = 90
			.Width = 90
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Movimenta" + CHR(231) + CHR(227) + "o :"
			.Visible = .T.
		ENDWITH

		THIS.AddObject("lbl_4c_Recebimento", "Label")
		WITH THIS.lbl_4c_Recebimento
			.Top = 464
			.Left = 96
			.Width = 85
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Recebimento :"
			.Visible = .T.
		ENDWITH

		*-- Mensagem de status (lbl_Mensagem) - OCULTO no dump; usado pelo
		*-- fluxo de confirmacao/erro de TEF (Fase 7/8)
		THIS.AddObject("lbl_4c_Mensagem", "Label")
		WITH THIS.lbl_4c_Mensagem
			.Top = 85
			.Left = 444
			.Width = 276
			.Height = 18
			.AutoSize = .F.
			.Alignment = 0
			.FontName = "Tahoma"
			.FontSize = 8
			.ForeColor = RGB(90, 90, 90)
			.BackStyle = 0
			.Caption = "Mensagem"
			.Visible = .F.
		ENDWITH

		*-- Avisos de porta aberta do leitor serial de cheques
		*-- (AvisoPortaS/M/T/C/A/K - readcomm, container deferido para
		*-- Fase 7/8; os 6 TextBox ficam direto no form no dump)
		THIS.AddObject("txt_4c_AvisoPortaS", "TextBox")
		WITH THIS.txt_4c_AvisoPortaS
			.Top = 108
			.Left = 1020
			.Width = 20
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = ""
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_AvisoPortaM", "TextBox")
		WITH THIS.txt_4c_AvisoPortaM
			.Top = 132
			.Left = 1020
			.Width = 20
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = ""
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_AvisoPortaT", "TextBox")
		WITH THIS.txt_4c_AvisoPortaT
			.Top = 156
			.Left = 1020
			.Width = 20
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = ""
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_AvisoPortaC", "TextBox")
		WITH THIS.txt_4c_AvisoPortaC
			.Top = 180
			.Left = 1020
			.Width = 20
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = ""
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_AvisoPortaA", "TextBox")
		WITH THIS.txt_4c_AvisoPortaA
			.Top = 204
			.Left = 1020
			.Width = 20
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = ""
			.Visible = .T.
		ENDWITH

		THIS.AddObject("txt_4c_AvisoPortaK", "TextBox")
		WITH THIS.txt_4c_AvisoPortaK
			.Top = 228
			.Left = 1020
			.Width = 20
			.Height = 23
			.FontName = "Tahoma"
			.FontSize = 8
			.Value = ""
			.Visible = .T.
		ENDWITH

		*-- Icone decorativo da secao "Valores Totais" (Image1 - dump nao
		*-- declara .Picture, regra #25: NUNCA inventar nome de arquivo)
		THIS.AddObject("img_4c_Imagem1", "Image")
		WITH THIS.img_4c_Imagem1
			.Top = 266
			.Left = 41
			.Width = 26
			.Height = 26
			.BorderStyle = 0
			.Visible = .T.
		ENDWITH
	ENDPROC

	*====================================================================
	* CarregarLista - metodo UNICO de carga/repintura da grade de
	* condicoes, chamado em TODO caminho que (re)popula o cursor (regra
	* #21a: popular o cursor NAO repinta a grade - o legado sempre fecha
	* com "Select xPar / Goto Top / Grade.Refresh").
	*
	* Fonte dos dados: o legado liga a grade ao cursor xPar que o form PAI
	* deixa aberto na DataSession compartilhada (dump:
	* Grade.RecordSource = "XPAR" e o bloco de rebind do Init, que repete
	* RecordSource + os 6 ControlSource + o DynamicForeColor + Refresh).
	* Reproduzimos isso: quando xPar existe, a grade se liga a ele; caso
	* contrario fica no cursor placeholder (form aberto isolado ou em
	* validacao de UI), de mesma estrutura.
	*
	* Ordem canonica obrigatoria (RecordSource RESETA Width e
	* Header1.Caption): ColumnCount -> RecordSource -> ControlSource ->
	* Width -> Header1.Caption. Por isso esse bloco vive AQUI e nao em
	* ConfigurarGrid: todo rebind precisa repeti-lo inteiro.
	*
	* PUBLIC de proposito (sem PROTECTED): o harness de teste e os
	* caminhos de recarga chamam THIS.CarregarLista() de FORA da classe
	* (regra #3 - PEMSTATUS nao verifica escopo e a chamada falharia em
	* runtime com "Property CARREGARLISTA is not found").
	*====================================================================
	PROCEDURE CarregarLista()
		LOCAL loc_lSucesso, loc_cAlias, loc_oGrid, loc_cDynFore, loc_oErro

		loc_lSucesso = .F.

		TRY
			*-- Fonte: xPar do form pai quando disponivel; senao o
			*-- cursor local de apoio, de mesma estrutura.
			loc_cAlias = THIS.this_cCursorLegado
			IF !USED(loc_cAlias)
				loc_cAlias = THIS.this_cCursorCondicoes
			ENDIF

			IF USED(loc_cAlias) AND PEMSTATUS(THIS, "grd_4c_Condicoes", 5)
				loc_oGrid = THIS.grd_4c_Condicoes

				SELECT (loc_cAlias)
				SET ORDER TO
				GO TOP

				WITH loc_oGrid
					*-- 1) ColumnCount (sempre antes do RecordSource, para o
					*-- Grid nao auto-expandir para todas as colunas do cursor)
					.ColumnCount = 6

					*-- 2) RecordSource
					.RecordSource = loc_cAlias

					*-- 3) ControlSource (dump: Fpags/Valos/Vencs/MoeFPgs/
					*-- CotFPgs/ValDescs)
					.Column1.ControlSource = loc_cAlias + ".fpags"
					.Column2.ControlSource = loc_cAlias + ".valos"
					.Column3.ControlSource = loc_cAlias + ".vencs"
					.Column4.ControlSource = loc_cAlias + ".moefpgs"
					.Column5.ControlSource = loc_cAlias + ".cotfpgs"
					.Column6.ControlSource = loc_cAlias + ".valdescs"

					*-- 4) Width (o RecordSource acima zera para o default 90)
					.Column1.Width = 148
					.Column2.Width = 120
					.Column3.Width = 78
					.Column4.Width = 30
					.Column5.Width = 80
					.Column6.Width = 90

					*-- 5) Header1.Caption (idem - resetado pelo RecordSource).
					*-- Alignment = 2 (centralizado) em todos, como no dump.
					.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
					.Column2.Header1.Caption = "Valor"
					.Column3.Header1.Caption = "Vencimento"
					.Column4.Header1.Caption = "Moe"
					.Column5.Header1.Caption = "C" + CHR(226) + "mbio"
					.Column6.Header1.Caption = "Desconto"

					.Column1.Header1.Alignment = 2
					.Column2.Header1.Alignment = 2
					.Column3.Header1.Alignment = 2
					.Column4.Header1.Alignment = 2
					.Column5.Header1.Alignment = 2
					.Column6.Header1.Alignment = 2

					.Column1.Header1.FontName = "Verdana"
					.Column2.Header1.FontName = "Verdana"
					.Column3.Header1.FontName = "Verdana"
					.Column4.Header1.FontName = "Verdana"
					.Column5.Header1.FontName = "Verdana"
					.Column6.Header1.FontName = "Verdana"

					.Column1.Header1.FontSize = 8
					.Column2.Header1.FontSize = 8
					.Column3.Header1.FontSize = 8
					.Column4.Header1.FontSize = 8
					.Column5.Header1.FontSize = 8
					.Column6.Header1.FontSize = 8

					*-- Ordem VISUAL do dump (venc e exibida por ULTIMO dos
					*-- campos de data/valor): fpagto 1, valor 2, moeda 3,
					*-- cotfpg 4, venc 5, desconto 6. Mover venc para 5 ja
					*-- desloca moeda/cotfpg para 3/4 - os outros dois
					*-- ColumnOrder do dump ficam satisfeitos por
					*-- consequencia. Aplicado por ULTIMO para nao interferir
					*-- com o bind acima.
					.Column3.ColumnOrder = 5
					.Column4.ColumnOrder = 3
					.Column5.ColumnOrder = 4
				ENDWITH

				*-- Cor dinamica da linha, transcrita do rebind do Init
				*-- legado, com o alias resolvido em runtime (vermelho =
				*-- cheque inserido ja identificado, azul = cheque/cartao
				*-- em protocolo, azul-escuro = troco, preto = normal).
				*-- So aplicada se as 4 colunas que a expressao le existirem
				*-- no alias ligado - expressao invalida em DynamicForeColor
				*-- estoura na PINTURA, longe daqui.
				IF TYPE(loc_cAlias + ".inschs") != "U" AND ;
				   TYPE(loc_cAlias + ".numchqs") != "U" AND ;
				   TYPE(loc_cAlias + ".nidcheps") != "U" AND ;
				   TYPE(loc_cAlias + ".trocos") != "U"

					loc_cDynFore = "IIF(" + loc_cAlias + ".inschs, " + ;
						"IIF(!EMPTY(" + loc_cAlias + ".numchqs), RGB(255,0,0), RGB(0,0,255)), " + ;
						"IIF(EMPTY(" + loc_cAlias + ".nidcheps), " + ;
						"IIF(" + loc_cAlias + ".trocos = 1, RGB(0,0,160), RGB(0,0,0)), " + ;
						"RGB(0,0,255)))"

					loc_oGrid.SetAll("DynamicForeColor", loc_cDynFore, "Column")
				ENDIF

				*-- Repintura (regra #21a): sem GO TOP + Refresh a grade
				*-- fica visualmente vazia com o cursor cheio.
				SELECT (loc_cAlias)
				GO TOP
				loc_oGrid.Refresh()

				THIS.this_cAliasGrade = loc_cAlias
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar a grade de condi" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfigurarLookups - liga os DOIS lookups identificados no dump
	* (analise.json) em "LostFocus" (regra #47 - o legado valida os dois
	* no Valid do TextBox, ao SAIR do campo; nunca em "KeyPress" sem
	* testar a tecla).
	*====================================================================
	PROTECTED PROCEDURE ConfigurarLookups()
		*-- Porta principal: o legado valida no Valid, isto e, ao SAIR do
		*-- campo (regra #47 - nunca "KeyPress" sem testar a tecla).
		BINDEVENT(THIS.txt_4c_Modfpg, "LostFocus", THIS, "ValidarModfpgLostFocus")
		BINDEVENT(THIS.txt_4c_Fpg, "LostFocus", THIS, "ValidarFpgLostFocus")

		*-- Portas auxiliares do padrao do projeto para abrir o picker com o
		*-- campo ainda vazio: F4/F5 (com guarda de tecla) e duplo clique.
		BINDEVENT(THIS.txt_4c_Modfpg, "KeyPress", THIS, "ModfpgKeyPress")
		BINDEVENT(THIS.txt_4c_Modfpg, "DblClick", THIS, "ModfpgDblClick")
		BINDEVENT(THIS.txt_4c_Fpg, "KeyPress", THIS, "FpgKeyPress")
		BINDEVENT(THIS.txt_4c_Fpg, "DblClick", THIS, "FpgDblClick")
	ENDPROC

	*====================================================================
	* ValidarModfpgLostFocus - lookup da MOEDA da forma de pagamento
	* (txt_4c_Modfpg -> SigCdMoe.cmoes/dmoes), porta de
	* SIGOPPAG.Get_modfpg.Valid (dump linha ~9032): o legado tenta match
	* exato via fwbuscaext e so abre o picker se nao achar; aqui o
	* proprio Init do FormBuscaAuxiliar (regra #36) ja faz o match exato,
	* e o Show() so roda em cima dele quando necessario.
	*
	* Este metodo e o WRAPPER FINO da guarda de reentrancia: o picker e
	* MODAL, tira o foco e redispara o proprio LostFocus, entao a flag
	* this_lEmLookupModfpg tem de ser liberada DEPOIS do corpo - por isso
	* o corpo mora em ValidarModfpgCorpo(), onde os RETURN antecipados
	* nao conseguem travar a flag ligada.
	*
	* PUBLIC (regra #3 - BINDEVENT so dispara metodo PUBLIC).
	*====================================================================
	PROCEDURE ValidarModfpgLostFocus()
		IF THIS.this_lEmLookupModfpg
			RETURN
		ENDIF

		THIS.this_lEmLookupModfpg = .T.
		THIS.ValidarModfpgCorpo()
		THIS.this_lEmLookupModfpg = .F.
	ENDPROC

	*====================================================================
	* ValidarModfpgCorpo - decide se ha o que buscar (legado: o Valid
	* inteiro esta dentro de "If Not Empty(This.Value)") e chama o funil
	* do picker. gnConnHandle > 0 e guarda do modo de teste/UI, onde o
	* handle vale -1 (regra do gb_4c_ValidandoUI).
	*====================================================================
	PROCEDURE ValidarModfpgCorpo()
		IF EMPTY(ALLTRIM(TRANSFORM(THIS.txt_4c_Modfpg.Value)))
			RETURN
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN
		ENDIF

		THIS.AbrirBuscaMoeda()
	ENDPROC

	*====================================================================
	* ModfpgKeyPress - F4/F5 abrem o picker com o campo ainda vazio.
	* Guarda de tecla OBRIGATORIA (regra #47 - handler ligado a
	* "KeyPress" sem testar a tecla abre o dialogo a CADA caractere e o
	* usuario nao consegue terminar de digitar o codigo).
	*
	* A flag usa save/restore (nao set/clear): este handler e um IRMAO do
	* funil e pode ser alcancado de dentro dele.
	*====================================================================
	PROCEDURE ModfpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_lEmLookupAnt

		IF !INLIST(par_nKeyCode, 115, 116)
			RETURN
		ENDIF

		IF THIS.this_lEmLookupModfpg
			RETURN
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN
		ENDIF

		loc_lEmLookupAnt = THIS.this_lEmLookupModfpg
		THIS.this_lEmLookupModfpg = .T.
		THIS.AbrirBuscaMoeda()
		THIS.this_lEmLookupModfpg = loc_lEmLookupAnt
	ENDPROC

	*====================================================================
	* ModfpgDblClick - duplo clique abre o picker (mesmo funil).
	*====================================================================
	PROCEDURE ModfpgDblClick()
		LOCAL loc_lEmLookupAnt

		IF THIS.this_lEmLookupModfpg
			RETURN
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN
		ENDIF

		loc_lEmLookupAnt = THIS.this_lEmLookupModfpg
		THIS.this_lEmLookupModfpg = .T.
		THIS.AbrirBuscaMoeda()
		THIS.this_lEmLookupModfpg = loc_lEmLookupAnt
	ENDPROC

	*====================================================================
	* AbrirBuscaMoeda - FUNIL UNICO do picker de moeda da forma de
	* pagamento. Porta de SIGOPPAG.Get_modfpg.Valid (dump linha ~9032):
	*
	*   xBrox = CreateObject('fwbuscaext', ..., 'SigCdMoe',
	*                        'CrListaRemota', 'CMOES', This.Value, ...)
	*   If Not xBrox.plAchouRegistro
	*       xBrox.mAddColuna('CMOES','XXXXXX','Codigo',.t.)
	*       xBrox.mAddColuna('DMOES','','Descricao',.T.)
	*       xBrox.Show()
	*   EndIf
	*
	* O Init do FormBuscaAuxiliar (regra #36 - 1o argumento e o HANDLE
	* gnConnHandle) ja faz o match exato e marca this_lAchouRegistro,
	* exatamente como o plAchouRegistro do fwbuscaext; o Show() so roda
	* em cima dele (regra #37).
	*
	* DESVIO DELIBERADO do legado, por causa da regra #37: o legado
	* atribui "This.value = evaluate('CrListaRemota.CMOES')" FORA de
	* qualquer guarda, o que ZERA o campo quando o usuario dispensa o
	* picker sem escolher. Aqui a atribuicao fica sob this_lSelecionou e
	* o codigo digitado e PRESERVADO (regra #50 - universo vazio nao e
	* erro: sem aviso e sem apagar o que o usuario digitou).
	*
	* PUBLIC - e o funil chamado pelas quatro portas.
	*====================================================================
	PROCEDURE AbrirBuscaMoeda()
		LOCAL loc_cValor, loc_oBusca, loc_oErro

		loc_cValor = ALLTRIM(TRANSFORM(THIS.txt_4c_Modfpg.Value))

		TRY
			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
				"SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
				"Sele" + CHR(231) + CHR(227) + "o")

			IF VARTYPE(loc_oBusca) = "O"
				IF !loc_oBusca.this_lAchouRegistro
					loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
					loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
					loc_oBusca.Show()
				ENDIF

				IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
					SELECT cursor_4c_BuscaMoeda
					THIS.txt_4c_Modfpg.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
				ENDIF

				IF USED("cursor_4c_BuscaMoeda")
					USE IN cursor_4c_BuscaMoeda
				ENDIF

				loc_oBusca.Release()
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao localizar moeda:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY

		*-- Legado: "This.refresh" no fim do Valid
		THIS.txt_4c_Modfpg.Refresh()
	ENDPROC

	*====================================================================
	* ValidarFpgLostFocus - lookup da FORMA DE PAGAMENTO (txt_4c_Fpg ->
	* SigOpFp.fpags/descrs/moefpgs/fparcs), porta de
	* SIGOPPAG.Get_fpg.Valid (dump linha 6914): Thisform.mGetcsSigFpag()
	* seguido de Seek/fwbuscasel sobre csSigOpFp - aqui,
	* CarregarFormasPagamento() (porta parcial de mGetcsSigFpag) + SEEK
	* no cursor local + FormBuscaAuxiliar Pattern A (DefinirCursor sobre
	* cursor JA filtrado, regra #37 "FALLBACK MANUAL").
	*
	* Como no irmao Modfpg, este metodo e so o WRAPPER FINO da guarda de
	* reentrancia - o corpo mora em ValidarFpgCorpo() para que RETURN
	* antecipado nao deixe a flag presa em .T. (regra #47).
	*
	* PUBLIC (regra #3 - BINDEVENT so dispara metodo PUBLIC).
	*====================================================================
	PROCEDURE ValidarFpgLostFocus()
		IF THIS.this_lEmLookupFpg
			RETURN
		ENDIF

		THIS.this_lEmLookupFpg = .T.
		THIS.ValidarFpgCorpo()
		THIS.this_lEmLookupFpg = .F.
	ENDPROC

	*====================================================================
	* ValidarFpgCorpo - decide e chama o funil. O legado envolve todo o
	* bloco em "If !Empty( This.Value )" (dump: Get_fpg.Valid).
	*====================================================================
	PROCEDURE ValidarFpgCorpo()
		IF EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))
			RETURN
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN
		ENDIF

		THIS.AbrirBuscaFormaPagamento()
	ENDPROC

	*====================================================================
	* FpgKeyPress - F4/F5, com guarda de tecla obrigatoria (regra #47).
	* Flag em save/restore porque este handler e irmao do funil.
	*====================================================================
	PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_lEmLookupAnt

		IF !INLIST(par_nKeyCode, 115, 116)
			RETURN
		ENDIF

		IF THIS.this_lEmLookupFpg
			RETURN
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN
		ENDIF

		loc_lEmLookupAnt = THIS.this_lEmLookupFpg
		THIS.this_lEmLookupFpg = .T.
		THIS.AbrirBuscaFormaPagamento()
		THIS.this_lEmLookupFpg = loc_lEmLookupAnt
	ENDPROC

	*====================================================================
	* FpgDblClick - duplo clique abre o picker (mesmo funil).
	*====================================================================
	PROCEDURE FpgDblClick()
		LOCAL loc_lEmLookupAnt

		IF THIS.this_lEmLookupFpg
			RETURN
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN
		ENDIF

		loc_lEmLookupAnt = THIS.this_lEmLookupFpg
		THIS.this_lEmLookupFpg = .T.
		THIS.AbrirBuscaFormaPagamento()
		THIS.this_lEmLookupFpg = loc_lEmLookupAnt
	ENDPROC

	*====================================================================
	* AbrirBuscaFormaPagamento - FUNIL UNICO do picker de forma de
	* pagamento. Porta de SIGOPPAG.Get_fpg.Valid (dump linha 6914):
	*
	*   Thisform.mGetcsSigFpag()
	*   If !Seek( This.Value, 'csSigOpFp', 'FPags' )
	*       loBrowse = CreateObject('fwbuscasel','csSigOpFp','FPags',...)
	*       loBrowse.AddColuna( 'FPags',  '', 'Codigo',    .t., 'FPags' )
	*       loBrowse.AddColuna( 'Descrs', '', 'Descricao', ... )
	*       ...
	*
	* Como o legado busca num cursor LOCAL ja filtrado (csSigOpFp, feito
	* por mGetcsSigFpag), aqui o padrao e o Pattern A da regra #37:
	* CarregarFormasPagamento() monta o cursor, SEEK tenta o match exato
	* e o FormBuscaAuxiliar recebe o cursor por DefinirCursor (sem SQL
	* automatica, porque o universo ja esta filtrado).
	*
	* Regra #50: quando o SEEK falha, NAO ha MsgAviso nem limpeza do
	* campo - o picker aberto JA e o retorno visual, e o codigo digitado
	* e preservado como filtro. Se o usuario dispensar o picker, o valor
	* digitado permanece (o legado tambem nao o apaga aqui).
	*
	* PUBLIC - e o funil chamado pelas quatro portas.
	*====================================================================
	PROCEDURE AbrirBuscaFormaPagamento()
		LOCAL loc_cValor, loc_oBusca, loc_oErro

		loc_cValor = ALLTRIM(THIS.txt_4c_Fpg.Value)

		TRY
			THIS.CarregarFormasPagamento()

			IF USED(THIS.this_cCursorFormasPagamento)
				IF !EMPTY(loc_cValor) AND ;
				   SEEK(loc_cValor, THIS.this_cCursorFormasPagamento, "fpags")
					SELECT (THIS.this_cCursorFormasPagamento)
					THIS.txt_4c_Fpg.Value = ALLTRIM(EVALUATE(THIS.this_cCursorFormasPagamento + ".fpags"))
				ELSE
					loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

					IF VARTYPE(loc_oBusca) = "O"
						loc_oBusca.DefinirCursor(THIS.this_cCursorFormasPagamento, ;
							"fpags", "descrs", "Cadastro de Forma de Pagamento")

						*-- DefinirCursor usa o NOME do campo como titulo das
						*-- duas primeiras colunas; zerar o contador faz
						*-- mAddColuna remontar a lista com os titulos e as
						*-- mascaras do legado (AddColuna de Get_fpg.Valid,
						*-- dump linhas 6931-6934).
						loc_oBusca.this_nColunas = 0
						loc_oBusca.mAddColuna("fpags", "", "C" + CHR(243) + "digo")
						loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
						loc_oBusca.mAddColuna("moefpgs", "XXXXX", "Moeda")
						loc_oBusca.mAddColuna("fparcs", "99", " #")

						IF loc_oBusca.Mostrar()
							THIS.txt_4c_Fpg.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
						ENDIF

						loc_oBusca.Release()
					ENDIF
				ENDIF

				IF USED(THIS.this_cCursorFormasPagamento)
					USE IN (THIS.this_cCursorFormasPagamento)
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao localizar forma de pagamento:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY

		*-- Fase 8/8: Npar/Vpar/Porc/DataVenc dependem de Fpg preenchido
		*-- (ver HabilitarCampos()) - reavaliar agora que o lookup pode ter
		*-- alterado o valor, independente de qual das quatro portas
		*-- (LostFocus/KeyPress/DblClick) chamou este funil.
		THIS.HabilitarCampos()

		THIS.txt_4c_Fpg.Refresh()
	ENDPROC

	*====================================================================
	* CarregarFormasPagamento - porta PARCIAL de mGetcsSigFpag (dump
	* linha 4136), ramo INSERIR/ALTERAR (regra #35/cabecalho - este form
	* filho so abre nesses dois modos). Filtra SigOpFp por Empresa +
	* Moeda (ja digitada em txt_4c_Modfpg) e exclui a forma de pagamento
	* padrao/credito da operacao (SigCdOpe.FpagOpCrs).
	*
	* FORA de escopo nesta fase (ficam para a Fase 7/8, quando os
	* cursores/containers correspondentes existirem):
	*   - filtro de GRUPO EMPRESARIAL (crSigCdEmp.grupo);
	*   - filtro de MASCARA de cartao (plMasc, ligado ao container
	*     flutuante cntFundo.cntMascPgto);
	*   - exclusao de formas ja usadas em xPar / bloqueio por desconto
	*     financeiro (SigMvItd) - regra de GRAVACAO, nao de lookup.
	*
	* PROTECTED - chamado so internamente por ValidarFpgLostFocus().
	*====================================================================
	PROTECTED PROCEDURE CarregarFormasPagamento()
		LOCAL loc_cEmps, loc_cDopes, loc_cMoeda, loc_cSQL, loc_nResultado

		IF USED(THIS.this_cCursorFormasPagamento)
			USE IN (THIS.this_cCursorFormasPagamento)
		ENDIF

		loc_cEmps  = THIS.this_oBusinessObject.this_cEmps
		loc_cDopes = THIS.this_oBusinessObject.this_cDopes
		loc_cMoeda = ALLTRIM(TRANSFORM(THIS.txt_4c_Modfpg.Value))

		TEXT TO loc_cSQL TEXTMERGE NOSHOW
			SELECT a.fpags, a.descrs, a.moefpgs, a.fparcs, a.situas
			FROM SigOpFp a
			WHERE a.emps IN (<<EscaparSQL(loc_cEmps)>>, '   ')
			<<IIF(!EMPTY(loc_cMoeda), " AND a.moefpgs = " + EscaparSQL(loc_cMoeda), "")>>
			<<IIF(!EMPTY(loc_cDopes), " AND a.fpags <> ISNULL((SELECT fpagopcrs FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cDopes) + "), '')", "")>>
			ORDER BY a.fpags
		ENDTEXT

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormasPagamento)

		IF loc_nResultado >= 0 AND USED(THIS.this_cCursorFormasPagamento)
			SELECT (THIS.this_cCursorFormasPagamento)
			INDEX ON fpags TAG fpags
			GO TOP
		ENDIF

		RETURN (loc_nResultado >= 0)
	ENDPROC

	*====================================================================
	* ConfigurarEventosBotoes - liga o Click dos 5 CommandButton REAIS de
	* acao (regra #3 - BINDEVENT so dispara metodo PUBLIC) aos handlers da
	* Fase 7/8. btnRetCash.When do dump NAO e ligado aqui: CommandButton do
	* VFP9 nao tem evento When nativo (ver BtnRetCashWhen() abaixo).
	*====================================================================
	PROTECTED PROCEDURE ConfigurarEventosBotoes()
		LOCAL loc_oCnt

		loc_oCnt = THIS.cnt_4c_Botoes

		BINDEVENT(loc_oCnt.cmd_4c_BtnRetCash, "Click", THIS, "BtnRetCashClick")
		BINDEVENT(loc_oCnt.cmd_4c_Apaga, "Click", THIS, "BtnExcluirCondicaoClick")
		BINDEVENT(loc_oCnt.cmd_4c_Totite, "Click", THIS, "BtnTotalProdutosClick")
		BINDEVENT(loc_oCnt.cmd_4c_Ok, "Click", THIS, "BtnConfirmarClick")
		BINDEVENT(loc_oCnt.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
	ENDPROC

	*====================================================================
	* AjustarBotoesPorModo - Fase 8/8: centraliza o Enabled dos 5 botoes de
	* acao conforme THIS.this_cOpEscolha (equivalente ao modo pcEscolha do
	* form pai, regra #40 do CLAUDE.md - quem desabilita no funil de ida
	* tem de reabilitar no de volta). So o btnRetCash tem When() explicito
	* no dump (dump linha 6448, ja portado em BtnRetCashWhen()); os demais
	* gateiam a ACAO dentro do proprio Click (INLIST(this_cOpEscolha,...),
	* desde a Fase 7/8) - aqui o Enabled do CONTROLE passa a refletir a
	* MESMA condicao, para o botao aparecer cinza em vez de clicavel-mas-
	* inerte quando a tela abrir em modo CONSULTAR.
	*
	* this_cOpEscolha e fixado em Init() (regra #35/cabecalho - replica
	* ThisForm.Op_Escolha = pForm.pcEscolha) e nao muda durante a vida
	* deste dialogo modal - por isso uma unica chamada em InicializarForm()
	* basta; o metodo e mantido PUBLIC para reaproveitamento caso um dia
	* exista um caminho que troque o modo em runtime.
	*====================================================================
	PROCEDURE AjustarBotoesPorModo()
		LOCAL loc_oCnt, loc_lEdicao

		IF !PEMSTATUS(THIS, "cnt_4c_Botoes", 5)
			RETURN
		ENDIF

		loc_oCnt    = THIS.cnt_4c_Botoes
		loc_lEdicao = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

		*-- btnRetCash: Enabled pelo proprio When ja portado (3 valores no
		*-- Click do dump - linha 6432 - contra 2 no When do botao; sao
		*-- regras DIFERENTES do mesmo controle, nao inconsistencia).
		loc_oCnt.cmd_4c_BtnRetCash.Enabled = THIS.BtnRetCashWhen()

		*-- Apaga/Ok: o Click dos dois exige INSERIR/ALTERAR (regra #40) -
		*-- refletir no Enabled evita o clique inerte em modo CONSULTAR.
		loc_oCnt.cmd_4c_Apaga.Enabled = loc_lEdicao
		loc_oCnt.cmd_4c_Ok.Enabled    = loc_lEdicao

		*-- Totite (sem When no dump) e Cancela (precisa fechar a tela
		*-- mesmo em CONSULTAR) ficam sempre habilitados.
		loc_oCnt.cmd_4c_Totite.Enabled  = .T.
		loc_oCnt.cmd_4c_Cancela.Enabled = .T.
	ENDPROC

	*====================================================================
	* HabilitarCampos - Fase 8/8: habilita/desabilita os campos soltos do
	* bloco "Condicao" conforme o modo do form pai e o preenchimento da
	* forma de pagamento, portando os When() do dump que dependem SO desse
	* par (this_cOpEscolha + Fpg preenchido):
	*   Get_modfpg.When / Get_fpg.When: "Inlist(...,'INSERIR','ALTERAR')
	*                                    And CrSigCdOpe.ParAutos <> 5"
	*   GetPorc.When / Get_npar.When / Get_vpar.When (parte comum):
	*                                    "Inlist(...) And
	*                                    !Empty(Thisform.Get_fpg.Value)"
	*
	* PENDENCIA EXPLICITA (REGRA FUNDAMENTAL - nunca omitir em silencio):
	* tres When() do dump dependem de estado que NENHUMA fase anterior
	* portou, e este metodo NAO inventa valor para eles:
	*   - Get_npar.When tambem exige "Thisform.Digpar" (flag setada DENTRO
	*     de Get_fpg.Valid, conforme o catalogo SigOpFp x SigOpFpo x
	*     SigCdEmp.grupo - mesma limitacao de "filtro de GRUPO
	*     EMPRESARIAL" ja documentada em CarregarFormasPagamento, Fase
	*     6/8) - aqui txt_4c_Npar so segue a condicao comum (modo + Fpg);
	*   - Get_TVaria.When/Get_pVaria.When exigem "CrSigOpFp.pVarias > 0
	*     And ThisForm.AplicaVariacao" - AplicaVariacao nunca e setada
	*     nesta migracao, logo os dois continuam Enabled = .F.;
	*   - Get_COTACAO.When/alteracotacao.When exigem Seek em crSigCdCrg
	*     (cargo do usuario logado) e CrSigCdMoe.Cotas - nenhum dos dois
	*     cursores existe no projeto novo; txt_4c_Cotacao/
	*     cmd_4c_AlteraCotacao seguem Visible = .F., como no dump (Fase
	*     6/8), e nao sao tocados aqui.
	*
	* PUBLIC - chamado por InicializarForm() e por AbrirBuscaFormaPagamento()
	* (o valor de Fpg so e conhecido depois do lookup resolver) e por
	* LimparCampos() (abaixo).
	*====================================================================
	PROCEDURE HabilitarCampos()
		LOCAL loc_lEdicao, loc_lTemFpg

		loc_lEdicao = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") AND ;
			THIS.this_oBusinessObject.this_nParAutosOpe != 5
		loc_lTemFpg = !EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))

		THIS.txt_4c_Modfpg.Enabled = loc_lEdicao
		THIS.txt_4c_Fpg.Enabled    = loc_lEdicao

		THIS.txt_4c_Npar.Enabled     = loc_lEdicao AND loc_lTemFpg
		THIS.txt_4c_Vpar.Enabled     = loc_lEdicao AND loc_lTemFpg
		THIS.txt_4c_Porc.Enabled     = loc_lEdicao AND loc_lTemFpg
		THIS.txt_4c_DataVenc.Enabled = loc_lEdicao AND loc_lTemFpg

		*-- Dias (Get_Dias) e sempre resultado de calculo entre Vencimento
		*-- e a data base do movimento - nao ha Valid/When habilitando
		*-- digitacao direta nele no dump.
		THIS.txt_4c_Dias.Enabled = .F.

		*-- Campos totalizadores/computados - When() = "Return(.F.)" no
		*-- dump para TODOS (Get_valtot/Get_Saldo/Get_TotForma/
		*-- Get_valinic/Get_pDescP/Get_VDescP/Get_moeoper/getValTrans):
		*-- nunca digitaveis, em qualquer modo.
		THIS.txt_4c_MoeOper.Enabled    = .F.
		THIS.txt_4c_ValInic.Enabled    = .F.
		THIS.txt_4c_TotServico.Enabled = .F.
		THIS.txt_4c_ValTrans.Enabled   = .F.
		THIS.txt_4c_Variacao.Enabled   = .F.
		THIS.txt_4c_ValTot.Enabled     = .F.
		THIS.txt_4c_TotForma.Enabled   = .F.
		THIS.txt_4c_Saldo.Enabled      = .F.
		THIS.txt_4c_PDescP.Enabled     = .F.
		THIS.txt_4c_VDescP.Enabled     = .F.
	ENDPROC

	*====================================================================
	* LimparCampos - Fase 8/8: funil UNICO de limpeza dos campos soltos do
	* bloco Condicao apos excluir uma linha (BtnExcluirCondicaoClick, que
	* antes desta fase limpava so 5 campos em linha, inline) ou apos
	* qualquer outro caminho que precise devolver a tela ao estado
	* "nenhuma condicao em edicao". NAO toca na grade (CarregarLista() e
	* quem repinta) nem nos totalizadores ja recalculados por
	* AtualizarTotaisPosExclusao() (Saldo/TotForma), para nao desfazer o
	* recalculo que o chamador acabou de fazer.
	*
	* Termina chamando HabilitarCampos(): com Fpg vazio, Npar/Vpar/Porc/
	* DataVenc tem de voltar a ficar desabilitados (regra #40 - quem
	* limpa o campo tem de refletir isso no Enabled tambem).
	*
	* PUBLIC - mesma razao de CarregarLista() (regra #3): reaproveitavel
	* por qualquer caminho de limpeza, dentro ou fora da classe.
	*====================================================================
	PROCEDURE LimparCampos()
		THIS.txt_4c_Fpg.Value      = ""
		THIS.txt_4c_Modfpg.Value   = 0
		THIS.txt_4c_Npar.Value     = 0
		THIS.txt_4c_Vpar.Value     = 0
		THIS.txt_4c_Porc.Value     = 0
		THIS.txt_4c_Dias.Value     = 0
		THIS.txt_4c_DataVenc.Value = {}
		THIS.txt_4c_Cotacao.Value  = 0

		THIS.HabilitarCampos()
	ENDPROC

	*====================================================================
	* BtnRetCashWhen - porta de SIGOPPAG.btnRetCash.When (dump linha 6448).
	* CommandButton do VFP9 nao tem evento When nativo (era campo GET da
	* base fwbutton do legado) - nao ha como BINDEVENT isto a um disparo
	* automatico. Metodo mantido PUBLIC e funcional para quando um futuro
	* "AjustarBotoesPorModo" (regra #40 do CLAUDE.md) for escrito para este
	* form e precisar consultar esta condicao antes de habilitar o botao.
	*====================================================================
	PROCEDURE BtnRetCashWhen()
		RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
	ENDPROC

	*====================================================================
	* BtnRetCashClick - porta de SIGOPPAG.btnRetCash.Click (dump linha
	* 6428) - "Retorna Bonus": abre o dialogo de utilizacao de bonus/
	* cashback do cliente, que vive no FORM PAI:
	*
	*   =ThisForm.parentform.OpenCash(TprMvCab.Contads, .T.)
	*   If ThisForm.BlqPossuiBonus
	*       ThisForm.getValUtiCsh.Value = 0
	*   EndIf
	*
	* PENDENCIA EXPLICITA: OpenCash() e um metodo do FORM PAI (cabecalho do
	* movimento). Nenhum form do acervo migrado ainda cria
	* CREATEOBJECT("Formsigoppag") - o pai nem esta wireado para abrir este
	* filho - logo OpenCash() nao existe em lugar nenhum do projeto hoje.
	* Chamar um metodo inexistente quebraria a regra #13 (nunca chamar
	* helper nao definido) e derrubaria a tela (regra #29). O PEMSTATUS
	* abaixo deixa o Click FORWARD-COMPATIVEL: se um dia o pai ganhar
	* OpenCash(), este botao passa a funcionar sem precisar tocar aqui de
	* novo; enquanto isso, avisa o usuario em vez de quebrar.
	*
	* "ThisForm.BlqPossuiBonus" (flag setada no Init legado, dump linha
	* 5045) tambem nao foi portado - depende do mesmo Init gigantesco do
	* form pai citado no cabecalho deste arquivo. Sem ela, o zeramento
	* condicional de getValUtiCsh fica fora desta fase (documentado, nao
	* omitido em silencio).
	*====================================================================
	PROCEDURE BtnRetCashClick()
		LOCAL loc_oErro

		*-- Legado: "If Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR',
		*-- 'CONSULTAR' )" (dump linha 6432) - TRES valores aqui, diferente
		*-- do When() (regra de guarda do proprio botao, so 2 valores).
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
			RETURN
		ENDIF

		TRY
			IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "OpenCash", 5)
				THIS.this_oFormPai.OpenCash(THIS.this_oBusinessObject.this_cContaDsCab, .T.)
				THIS.txt_4c_ValUtiCsh.Refresh()
			ELSE
				MsgAviso("A devolu" + CHR(231) + CHR(227) + "o de B" + CHR(244) + "nus depende da tela de cabe" + CHR(231) + CHR(227) + "o do movimento," + CHR(13) + ;
					"que ainda n" + CHR(227) + "o disponibiliza esta integra" + CHR(231) + CHR(227) + "o no sistema novo.", "Funcionalidade Pendente")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao retornar b" + CHR(244) + "nus:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BtnTotalProdutosClick - porta de SIGOPPAG.totite.Click (dump linha 8791) -
	* "Total dos Produtos":
	*
	*   Thisform.enabled=.f.
	*   do form SigOpTot with thisform,Thisform.datasessionId
	*
	* PENDENCIA EXPLICITA (fora do escopo da task782): SigOpTot NAO foi
	* migrado para o projeto novo (zero arquivos "SigOpTot*" em
	* projeto\app) e "DO FORM" nunca abre dialogo filho no sistema novo
	* (memoria do projeto). Em vez de um stub silencioso ou de tentar
	* reproduzir o DO FORM literal (o que quebraria a tela), avisa o
	* usuario que a funcionalidade ainda nao esta disponivel.
	*====================================================================
	PROCEDURE BtnTotalProdutosClick()
		MsgAviso("A tela de Total dos Produtos (SigOpTot) ainda n" + CHR(227) + "o foi migrada para o sistema novo." + CHR(13) + ;
			"Esta funcionalidade ser" + CHR(225) + " disponibilizada em uma pr" + CHR(243) + "xima atualiza" + CHR(231) + CHR(227) + "o.", "Funcionalidade Pendente")
	ENDPROC

	*====================================================================
	* BtnExcluirCondicaoClick - porta de SIGOPPAG.Apaga.Click (dump linha 6655) -
	* "Excluir Condicao": remove a linha CORRENTE de xPar/
	* cursor_4c_Condicoes, com os mesmos bloqueios do legado (forma
	* automatica, InsChs em ALTERAR, InsChs com cheque sem banco OU forma
	* igual a FPagOpCrs, InsChs com ParAutos=4, cupom nao fiscal).
	*
	* PENDENCIAS desta fase (documentadas, nao silenciadas - REGRA
	* FUNDAMENTAL do CLAUDE.md):
	*   - recalculo de Desconto/Acrescimo (containers .Desconto/.Acrescimo
	*     ainda nao criados) e dos impostos de servico (FSigOpFin_NF -
	*     funcao global do legado nao portada);
	*   - ThisForm.ParentForm.Cotacao()/CalcServico()/CalcImposto() e
	*     "getValUtiCsh = ParentForm.OpenValorLimiteCash" - metodos do FORM
	*     PAI, ainda nao wireado a este filho (mesma pendencia do
	*     BtnRetCashClick). AtualizarTotaisPosExclusao() (abaixo) soma
	*     this_nValos direto, SEM a conversao de cotacao entre moedas que
	*     ThisForm.ParentForm.Cotacao() fazia - desvio documentado.
	*====================================================================
	PROCEDURE BtnExcluirCondicaoClick()
		LOCAL loc_cAlias, loc_cMsg, loc_cCaption, loc_cFpagAtual, loc_lInschsAtual, ;
			loc_cCidchavesAtual, loc_cNumChqsAtual, loc_cBancosAtual, loc_cOperAutos, ;
			loc_cSQL, loc_nResultado, loc_lFechou, loc_oErro

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cAlias = THIS.this_cAliasGrade
		IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
			loc_cAlias = THIS.this_cCursorCondicoes
		ENDIF

		IF !USED(loc_cAlias) OR EOF(loc_cAlias)
			MsgAviso("Nenhuma Condi" + CHR(231) + CHR(227) + "o de Pagamento Selecionada para Apagar ... ", "Nada a Fazer")
			RETURN
		ENDIF

		loc_cMsg     = ""
		loc_cCaption = ""
		loc_lFechou  = .F.

		SELECT (loc_cAlias)
		loc_cFpagAtual      = TratarNulo(fpags, "")
		loc_lInschsAtual    = ConverterParaLogico(inschs)
		loc_cCidchavesAtual = TratarNulo(cidchaves, "")
		loc_cNumChqsAtual   = IIF(TYPE(loc_cAlias + ".numchqs") != "U", TratarNulo(numchqs, ""), "")
		loc_cBancosAtual    = IIF(TYPE(loc_cAlias + ".bancos")  != "U", TratarNulo(bancos, ""),  "")

		TRY
			loc_cOperAutos = ""

			IF USED("cursor_4c_ApagaFp")
				USE IN cursor_4c_ApagaFp
			ENDIF

			IF !EMPTY(loc_cFpagAtual)
				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT operautos FROM SigOpFp WHERE fpags = <<EscaparSQL(loc_cFpagAtual)>>
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ApagaFp")
				IF loc_nResultado >= 0 AND USED("cursor_4c_ApagaFp") AND !EOF("cursor_4c_ApagaFp")
					loc_cOperAutos = TratarNulo(cursor_4c_ApagaFp.operautos, "")
				ENDIF

				IF USED("cursor_4c_ApagaFp")
					USE IN cursor_4c_ApagaFp
				ENDIF
			ENDIF

			DO CASE
			CASE !EMPTY(loc_cOperAutos) AND loc_cFpagAtual == loc_cOperAutos
				loc_cMsg     = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Autom" + CHR(225) + "tica ... "
				loc_cCaption = "Exclus" + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Permitida"

			CASE loc_lInschsAtual AND THIS.this_cOpEscolha == "ALTERAR"
				loc_cMsg     = "Condi" + CHR(231) + CHR(245) + "es de Pagamento Com Baixa Autom" + CHR(225) + "tica ... "
				loc_cCaption = "Exclus" + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Permitida"

			CASE loc_lInschsAtual AND ((!EMPTY(loc_cNumChqsAtual) AND EMPTY(loc_cBancosAtual)) OR ;
					(!EMPTY(THIS.this_oBusinessObject.this_cFPagOpCrsOpe) AND loc_cFpagAtual == ALLTRIM(THIS.this_oBusinessObject.this_cFPagOpCrsOpe)))
				loc_cMsg     = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Autom" + CHR(225) + "tica ... "
				loc_cCaption = "Exclus" + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Permitida"

			CASE loc_lInschsAtual AND THIS.this_oBusinessObject.this_nParAutosOpe = 4
				loc_cMsg     = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Autom" + CHR(225) + "tica ... "
				loc_cCaption = "Exclus" + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Permitida"

			CASE THIS.this_oBusinessObject.this_nCupfisOpe = 3
				*-- Legado: "Delete All" + "thisform.cancela.Click()" (zera a
				*-- forma inteira para o usuario recomecar, mena 06/10/2016).
				*-- Aqui o fechamento mora em FecharDialogo() - DESVIO
				*-- deliberado do literal "continuar executando o metodo
				*-- apos o Release()" do legado, que nesta arquitetura
				*-- estouraria ao tentar usar THIS depois de liberado.
				SELECT (loc_cAlias)
				SCAN
					IF !EMPTY(cidchaves)
						THIS.this_oBusinessObject.ExcluirCondicao(cidchaves)
					ENDIF
				ENDSCAN

				SELECT (loc_cAlias)
				ZAP

				loc_lFechou = .T.
			ENDCASE

			IF !loc_lFechou
				IF !EMPTY(loc_cMsg)
					MsgAviso(loc_cMsg, loc_cCaption)
				ELSE
					IF !EMPTY(loc_cCidchavesAtual)
						THIS.this_oBusinessObject.ExcluirCondicao(loc_cCidchavesAtual)
					ENDIF

					SELECT (loc_cAlias)
					DELETE

					THIS.AtualizarTotaisPosExclusao(loc_cAlias)

					*-- Fase 8/8: funil unico de limpeza (ver LimparCampos()) -
					*-- substitui o clear inline de 5 campos desta fase.
					THIS.LimparCampos()

					THIS.CarregarLista()
					THIS.txt_4c_Fpg.SetFocus()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY

		IF loc_lFechou
			THIS.FecharDialogo()
		ENDIF
	ENDPROC

	*====================================================================
	* AtualizarTotaisPosExclusao - recalculo SIMPLIFICADO do total das
	* formas de pagamento ja lancadas, apos BtnExcluirCondicaoClick() remover uma linha.
	* Legado: soma xpar.valos * (xpar.cotfpgs * indice) / cotacao-da-moeda-
	* da-operacao (ThisForm.ParentForm.Cotacao()), com troco subtraindo em
	* vez de somar. ParentForm.Cotacao() nao existe ainda (pendencia
	* documentada em BtnExcluirCondicaoClick()) - aqui a soma e DIRETA em this_nValos,
	* sem conversao entre moedas.
	*====================================================================
	PROTECTED PROCEDURE AtualizarTotaisPosExclusao(par_cAlias)
		LOCAL loc_nTotForma, loc_oErro

		loc_nTotForma = 0

		TRY
			IF USED("cursor_4c_ApagaTot")
				USE IN cursor_4c_ApagaTot
			ENDIF

			SELECT SUM(IIF(trocos = 1, -valos, valos)) AS total FROM (par_cAlias) INTO CURSOR cursor_4c_ApagaTot

			IF USED("cursor_4c_ApagaTot")
				loc_nTotForma = TratarNulo(cursor_4c_ApagaTot.total, 0)
				USE IN cursor_4c_ApagaTot
			ENDIF

			THIS.txt_4c_TotForma.Value = loc_nTotForma
			THIS.txt_4c_Saldo.Value    = THIS.txt_4c_ValTot.Value - loc_nTotForma
		CATCH TO loc_oErro
			MsgErro("Erro ao recalcular totais da condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
	ENDPROC

	*====================================================================
	* BtnConfirmarClick - porta de SIGOPPAG.Ok.Click (dump linha 7869) - "Confirmar":
	* valida TODAS as condicoes de pagamento JA lancadas na grade e, se
	* nenhuma falhar, persiste cada uma via BO e fecha o dialogo.
	*
	* PENDENCIAS desta fase (documentadas em cada helper abaixo - REGRA
	* FUNDAMENTAL do CLAUDE.md, nunca omitir em silencio):
	*   1) ThisForm.plFPagObrigs (obrigatoriedade de forma de pagamento)
	*      depende do catalogo SigOpFp x SigOpFpo x SigCdEmp.grupo que
	*      CarregarFormasPagamento() (Fase 6/8) ja documentou como fora de
	*      escopo (mesma limitacao - "filtro de GRUPO EMPRESARIAL... fica
	*      fora");
	*   2) o bloco "AlterouGrade" (limite maximo por forma, SigOpFpI + DO
	*      FORM SigOpSen para autorizacao) - SigOpSen nao foi migrado (gate
	*      de autorizacao ausente, mesma pendencia de outras tasks do
	*      projeto). Nao ha rastreamento de "a grade foi alterada" nesta
	*      fase, logo este bloco fica inerte por ora;
	*   3) ThisForm.ParentForm.CalcServico()/CalcImposto()/Procrateio()/
	*      Totpar()/Cotacao() - metodos do FORM PAI, ainda nao wireado a
	*      este filho (mesma pendencia do BtnRetCashClick/BtnExcluirCondicaoClick);
	*   4) a montagem da linha de condicao a partir dos campos soltos
	*      (txt_4c_Fpg/Npar/Vpar/DataVenc/...) pertence ao Valid de
	*      Dataget_venc no legado (dump linha 7552) - NAO e um dos 5
	*      botoes desta fase; este Click so valida+persiste as linhas que
	*      JA existem na grade.
	*
	* Sem TRY/CATCH aqui (regra #1): cada helper tem o proprio TRY/CATCH e
	* devolve .T./.F. - o encadeamento usa IF aninhado, nunca AND/OR, porque
	* VFP9 nao faz short-circuit e chamaria os helpers seguintes mesmo apos
	* uma falha.
	*====================================================================
	PROCEDURE BtnConfirmarClick()
		LOCAL loc_cAlias, loc_lOk

		loc_lOk = .F.

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cAlias = THIS.this_cAliasGrade
		IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
			loc_cAlias = THIS.this_cCursorCondicoes
		ENDIF

		IF THIS.ValidarSituacaoClienteBloqueiaDesconto()
			IF THIS.ValidarChequesDuplicados(loc_cAlias)
				IF THIS.ValidarCondicoesLancadas(loc_cAlias)
					IF THIS.PersistirCondicoes(loc_cAlias)
						THIS.CarregarLista()
						loc_lOk = .T.
					ENDIF
				ENDIF
			ENDIF
		ENDIF

		IF loc_lOk
			THIS.FecharDialogo()
		ENDIF
	ENDPROC

	*====================================================================
	* ValidarSituacaoClienteBloqueiaDesconto - porta do bloco inicial do
	* Ok.Click (dump linhas 7873-7893): com TprMvCab.ValVars < 0 (desconto
	* negativo no movimento), verifica se a situacao da conta de destino
	* (ou, na falta, a de origem) bloqueia desconto (SigCdCli.Situas ->
	* SigCdCst.BlqDescs = 1). Devolve .F. quando bloqueado (mensagem ja
	* exibida); .T. caso contrario.
	*====================================================================
	PROTECTED PROCEDURE ValidarSituacaoClienteBloqueiaDesconto()
		LOCAL loc_lOk

		loc_lOk = .T.

		IF THIS.this_oBusinessObject.this_nValVarsCab < 0
			IF THIS.ContaTemDescontoBloqueado(THIS.this_oBusinessObject.this_cContaDsCab)
				loc_lOk = .F.
			ELSE
				IF !EMPTY(THIS.this_oBusinessObject.this_cContaOsCab)
					IF THIS.ContaTemDescontoBloqueado(THIS.this_oBusinessObject.this_cContaOsCab)
						loc_lOk = .F.
					ENDIF
				ENDIF
			ENDIF
		ENDIF

		RETURN loc_lOk
	ENDPROC

	*====================================================================
	* ContaTemDescontoBloqueado - SigCdCli.Situas -> SigCdCst.BlqDescs,
	* consulta direta via SQLEXEC (substitui o
	* ThisForm.parentform.PoDataMgr.CursorQuery do legado, que nao existe
	* no projeto novo). Exibe o MsgAviso do proprio legado quando bloqueado.
	*====================================================================
	PROTECTED PROCEDURE ContaTemDescontoBloqueado(par_cConta)
		LOCAL loc_lBloqueado, loc_cSQL, loc_nResultado, loc_oErro

		loc_lBloqueado = .F.

		IF EMPTY(par_cConta)
			RETURN loc_lBloqueado
		ENDIF

		TRY
			IF USED("cursor_4c_SituacaoCliente")
				USE IN cursor_4c_SituacaoCliente
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT c.descrs, c.blqdescs
				FROM SigCdCli a
				INNER JOIN SigCdCst c ON c.codigos = a.situas
				WHERE a.iclis = <<EscaparSQL(par_cConta)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SituacaoCliente")

			IF loc_nResultado >= 0 AND USED("cursor_4c_SituacaoCliente") AND !EOF("cursor_4c_SituacaoCliente")
				IF cursor_4c_SituacaoCliente.blqdescs = 1
					loc_lBloqueado = .T.
					MsgAviso(ALLTRIM(TratarNulo(cursor_4c_SituacaoCliente.descrs, "")) + CHR(13) + ;
						"Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o a Conta", "Situa" + CHR(231) + CHR(227) + "o")
				ENDIF
			ENDIF

			IF USED("cursor_4c_SituacaoCliente")
				USE IN cursor_4c_SituacaoCliente
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar situa" + CHR(231) + CHR(227) + "o do cliente:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lBloqueado
	ENDPROC

	*====================================================================
	* ValidarChequesDuplicados - porta literal do bloco "Select
	* Bancos+Agencias+Contas+Numeros..." do Ok.Click (dump linhas 7895-
	* 7904). Campos bancos/agencias/contas/numeros so existem no xPar
	* completo do form pai - no cursor placeholder (modo de teste) o TYPE()
	* devolve "U" e a checagem e pulada (sem crash, sem falso bloqueio).
	*====================================================================
	PROTECTED PROCEDURE ValidarChequesDuplicados(par_cAlias)
		LOCAL loc_lOk, loc_oErro

		loc_lOk = .T.

		IF TYPE(par_cAlias + ".bancos") == "U" OR TYPE(par_cAlias + ".agencias") == "U" OR ;
				TYPE(par_cAlias + ".contas") == "U" OR TYPE(par_cAlias + ".numeros") == "U"
			RETURN loc_lOk
		ENDIF

		TRY
			IF USED("cursor_4c_VerChq")
				USE IN cursor_4c_VerChq
			ENDIF

			SELECT bancos + agencias + contas + numeros AS cheque, COUNT(1) AS ntotal ;
				FROM (par_cAlias) ;
				WHERE !EMPTY(bancos + agencias + contas + numeros) ;
				INTO CURSOR cursor_4c_VerChq ;
				GROUP BY 1

			IF USED("cursor_4c_VerChq")
				SELECT cursor_4c_VerChq
				LOCATE FOR ntotal > 1
				IF FOUND()
					loc_lOk = .F.
					MsgAviso("Existem Cheques Lan" + CHR(231) + CHR(227) + "ados em Duplicidade Nessa Movimenta" + CHR(231) + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
				ENDIF
				USE IN cursor_4c_VerChq
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar cheques duplicados:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lOk
	ENDPROC

	*====================================================================
	* ValidarCondicoesLancadas - porta do SCAN principal do Ok.Click (dump
	* linhas 7906-7978): vencimento obrigatorio, # do credito (EmiVales=3),
	* observacao obrigatoria (Obs=3), autorizacao/adquirente (Autoriza=3),
	* NSU/adquirente (nsu=3), e o percentual de SigCdTif (Sim/Nao). O
	* catalogo de formas usadas e buscado de UMA vez so (nao por linha,
	* como o legado) - mesma adaptacao de CarregarFormasPagamento (Fase
	* 6/8) para o padrao de consulta unica deste projeto.
	*
	* PENDENCIA documentada: plFPagObrigs (obrigatoriedade de forma) nao
	* entra aqui - depende do catalogo SigOpFp x SigOpFpo x
	* SigCdEmp.grupo, fora de escopo (ver cabecalho de BtnConfirmarClick).
	*====================================================================
	PROTECTED PROCEDURE ValidarCondicoesLancadas(par_cAlias)
		LOCAL loc_lOk, loc_cFpagsIn, loc_cSQL, loc_nResultado, loc_nTotSim, ;
			loc_nTotNao, loc_nTtMaxSim, loc_nTtMaxNao, loc_oErro

		loc_lOk     = .T.
		loc_nTotSim = 0
		loc_nTotNao = 0

		TRY
			loc_cFpagsIn = ""

			IF USED("cursor_4c_FormasUsadas")
				USE IN cursor_4c_FormasUsadas
			ENDIF

			SELECT DISTINCT fpags FROM (par_cAlias) WHERE !EMPTY(fpags) INTO CURSOR cursor_4c_FormasUsadas

			IF USED("cursor_4c_FormasUsadas") AND RECCOUNT("cursor_4c_FormasUsadas") > 0
				SELECT cursor_4c_FormasUsadas
				SCAN
					loc_cFpagsIn = loc_cFpagsIn + IIF(EMPTY(loc_cFpagsIn), "", ",") + EscaparSQL(ALLTRIM(fpags))
				ENDSCAN
				USE IN cursor_4c_FormasUsadas
			ENDIF

			IF USED("cursor_4c_SigOpFpAtual")
				USE IN cursor_4c_SigOpFpAtual
			ENDIF

			IF !EMPTY(loc_cFpagsIn)
				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT fpags, emivales, obs, autoriza, nsu, opcsnas
					FROM SigOpFp
					WHERE fpags IN (<<loc_cFpagsIn>>)
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFpAtual")
				IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpFpAtual")
					SELECT cursor_4c_SigOpFpAtual
					INDEX ON fpags TAG fpags
				ENDIF
			ENDIF

			SELECT (par_cAlias)
			SCAN
				IF !EMPTY(fpags) AND EMPTY(vencs)
					loc_lOk = .F.
					MsgAviso("Vencimento Inv" + CHR(225) + "lido !", "Aten" + CHR(231) + CHR(227) + "o")
					EXIT
				ENDIF

				IF USED("cursor_4c_SigOpFpAtual") AND SEEK(ALLTRIM(fpags), "cursor_4c_SigOpFpAtual", "fpags")
					IF cursor_4c_SigOpFpAtual.emivales = 3 AND TYPE(par_cAlias + ".outros") != "U" AND EMPTY(EVALUATE(par_cAlias + ".outros"))
						loc_lOk = .F.
						MsgAviso("Obrigat" + CHR(243) + "rio Informar # do Cr" + CHR(233) + "dito Utilizado", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
						EXIT
					ENDIF

					IF cursor_4c_SigOpFpAtual.obs = 3 AND TYPE(par_cAlias + ".obs") != "U" AND EMPTY(EVALUATE(par_cAlias + ".obs"))
						loc_lOk = .F.
						MsgAviso("Obrigat" + CHR(243) + "rio Digitar Observa" + CHR(231) + CHR(227) + "o", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
						EXIT
					ENDIF

					IF cursor_4c_SigOpFpAtual.autoriza = 3 AND TYPE(par_cAlias + ".autoriza") != "U" AND TYPE(par_cAlias + ".adquirente") != "U" AND ;
							(EMPTY(EVALUATE(par_cAlias + ".autoriza")) OR EMPTY(EVALUATE(par_cAlias + ".adquirente")))
						loc_lOk = .F.
						MsgAviso("Obrigat" + CHR(243) + "rio Digitar N" + CHR(250) + "meros Autoriza" + CHR(231) + CHR(227) + "o/Adquirente do Cart" + CHR(227) + "o", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
						EXIT
					ENDIF

					IF cursor_4c_SigOpFpAtual.nsu = 3 AND TYPE(par_cAlias + ".nsu") != "U" AND TYPE(par_cAlias + ".adquirente") != "U" AND ;
							(EMPTY(EVALUATE(par_cAlias + ".nsu")) OR EMPTY(EVALUATE(par_cAlias + ".adquirente")))
						loc_lOk = .F.
						MsgAviso("Obrigat" + CHR(243) + "rio Digitar N" + CHR(250) + "meros NSU/Adquirente do Cart" + CHR(227) + "o", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
						EXIT
					ENDIF

					loc_nTotSim = loc_nTotSim + IIF(cursor_4c_SigOpFpAtual.opcsnas = 1, valos, 0)
					loc_nTotNao = loc_nTotNao + IIF(cursor_4c_SigOpFpAtual.opcsnas = 2, valos, 0)
				ENDIF

				SELECT (par_cAlias)
			ENDSCAN

			IF loc_lOk AND !EMPTY(THIS.this_oBusinessObject.this_cTpFatsCab)
				IF USED("cursor_4c_SigCdTifAtual")
					USE IN cursor_4c_SigCdTifAtual
				ENDIF

				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT pvalors, opcsnas FROM SigCdTif WHERE codigos = <<EscaparSQL(THIS.this_oBusinessObject.this_cTpFatsCab)>>
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTifAtual")

				IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdTifAtual") AND !EOF("cursor_4c_SigCdTifAtual")
					IF cursor_4c_SigCdTifAtual.pvalors != 0 AND INLIST(cursor_4c_SigCdTifAtual.opcsnas, 1, 2) AND ;
							INLIST(THIS.this_oBusinessObject.this_nAptpfatsOpe, 2, 6)

						loc_nTtMaxSim = ROUND(THIS.this_oBusinessObject.this_nValosCab * cursor_4c_SigCdTifAtual.pvalors / 100, 2)
						loc_nTtMaxNao = ROUND(THIS.this_oBusinessObject.this_nValosCab * (100 - cursor_4c_SigCdTifAtual.pvalors) / 100, 2)

						IF ABS(loc_nTtMaxSim - loc_nTotSim) > 1 OR ABS(loc_nTtMaxNao - loc_nTotNao) > 1
							loc_lOk = .F.
							MsgAviso("Valores divergentes para condi" + CHR(231) + CHR(227) + "o de Pagamento Sim / N" + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
						ENDIF
					ENDIF
				ENDIF

				IF USED("cursor_4c_SigCdTifAtual")
					USE IN cursor_4c_SigCdTifAtual
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
			loc_lOk = .F.
		ENDTRY

		IF USED("cursor_4c_FormasUsadas")
			USE IN cursor_4c_FormasUsadas
		ENDIF
		IF USED("cursor_4c_SigOpFpAtual")
			USE IN cursor_4c_SigOpFpAtual
		ENDIF
		IF USED("cursor_4c_SigCdTifAtual")
			USE IN cursor_4c_SigCdTifAtual
		ENDIF

		RETURN loc_lOk
	ENDPROC

	*====================================================================
	* PersistirCondicoes - grava cada linha de par_cAlias em SigMvPar via
	* THIS.this_oBusinessObject (Inserir() quando cidchaves ainda esta
	* vazio - linha nova; Atualizar() quando ja existe). A base ja exibe
	* MsgErro em qualquer falha de SQL (regra #20) - sem ELSE aqui.
	*====================================================================
	PROTECTED PROCEDURE PersistirCondicoes(par_cAlias)
		LOCAL loc_lOk, loc_nRecno

		loc_lOk    = .T.
		loc_nRecno = 0

		SELECT (par_cAlias)
		IF !EOF() AND !BOF()
			loc_nRecno = RECNO()
		ENDIF

		SELECT (par_cAlias)
		SCAN WHILE loc_lOk
			IF THIS.this_oBusinessObject.CarregarDoCursor(par_cAlias)
				IF EMPTY(THIS.this_oBusinessObject.this_cCidchaves)
					loc_lOk = THIS.this_oBusinessObject.Inserir()
				ELSE
					loc_lOk = THIS.this_oBusinessObject.Atualizar()
				ENDIF
			ELSE
				loc_lOk = .F.
			ENDIF

			SELECT (par_cAlias)
		ENDSCAN

		IF loc_nRecno > 0 AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cAlias))
			SELECT (par_cAlias)
			GOTO loc_nRecno
		ENDIF

		RETURN loc_lOk
	ENDPROC

	*====================================================================
	* BtnCancelarClick - porta literal de SIGOPPAG.Cancela.Click (dump linha
	* 8468): confirma/libera a transacao TEF em aberto (VerifTef - funcao GLOBAL do
	* legado sem definicao no acervo migrado; wrapper no-op documentado em
	* utils\verifteF.prg, regra #27), reabilita o form pai e fecha este
	* dialogo.
	*====================================================================
	PROCEDURE BtnCancelarClick()
		THIS.FecharDialogo()
	ENDPROC

	*====================================================================
	* FecharDialogo - funil unico de fechamento (Ok/Cancela), com guarda de
	* reentrancia (this_lFechando) contra Release() duplicado. Legado:
	*
	*   Cancela.Click:  =VerifTef(thisform.parentform)
	*                   Thisform.parentform.enabled = .T.
	*                   Thisform.release
	*   Ok.Click:       (termina com "ThisForm.Return" - metodo de uma
	*                   classe-base do VCX legado que nao esta no acervo;
	*                   aqui o fechamento segue o MESMO padrao observavel
	*                   do Cancela - reabilita o pai e libera a tela -
	*                   desvio documentado, nao uma transcricao literal).
	*====================================================================
	PROTECTED PROCEDURE FecharDialogo()
		LOCAL loc_oErro

		IF THIS.this_lFechando
			RETURN
		ENDIF

		THIS.this_lFechando = .T.

		TRY
			VerifTef(THIS.this_oFormPai)

			IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
				THIS.this_oFormPai.Enabled = .T.
			ENDIF

			THIS.Release()
		CATCH TO loc_oErro
			MsgErro("Erro ao encerrar a tela de condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + loc_oErro.Message, "Erro")
			THIS.this_lFechando = .F.
		ENDTRY
	ENDPROC

	*====================================================================
	* Destroy - DODEFAULT() OBRIGATORIO (FormBase.Destroy restaura o
	* menu principal apos form filho fechar - regra do "menu encolhendo").
	* Fecha apenas o cursor placeholder criado por este form: xPar pertence
	* ao form PAI (DataSession compartilhada) e NAO pode ser fechado aqui.
	*====================================================================
	PROCEDURE Destroy()
		IF USED(THIS.this_cCursorCondicoes)
			USE IN (THIS.this_cCursorCondicoes)
		ENDIF

		IF USED(THIS.this_cCursorFormasPagamento)
			USE IN (THIS.this_cCursorFormasPagamento)
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE
