# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-12 20:54:33] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-12 20:54:33] [INFO] Config FPW: (nao fornecido)
[2026-11-12 20:54:33] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-12 20:54:33] [INFO] Timeout: 300 segundos
[2026-11-12 20:54:33] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahfgencr.prg
[2026-11-12 20:54:33] [INFO] Conteudo do wrapper:
[2026-11-12 20:54:33] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigoporc', 'C:\4c\tasks\task781', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigoporc', 'C:\4c\tasks\task781', 'OPERACIONAL'
QUIT

[2026-11-12 20:54:33] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahfgencr.prg
[2026-11-12 20:54:33] [INFO] VFP output esperado em: C:\4c\tasks\task781\vfp_output.txt
[2026-11-12 20:54:33] [INFO] Executando Visual FoxPro 9...
[2026-11-12 20:54:33] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahfgencr.prg
[2026-11-12 20:54:33] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahfgencr.prg
[2026-11-12 20:54:33] [INFO] Timeout configurado: 300 segundos
[2026-11-12 20:54:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-12 20:54:33] [INFO] VFP9 finalizado em 0.5311258 segundos
[2026-11-12 20:54:33] [INFO] Exit Code: 
[2026-11-12 20:54:33] [INFO] 
[2026-11-12 20:54:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-12 20:54:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ahfgencr.prg
[2026-11-12 20:54:33] [INFO] 
[2026-11-12 20:54:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-12 20:54:33] [INFO] * Auto-generated wrapper for parameters
[2026-11-12 20:54:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-12 20:54:33] [INFO] * Parameters: 'Formsigoporc', 'C:\4c\tasks\task781', 'OPERACIONAL'
[2026-11-12 20:54:33] [INFO] 
[2026-11-12 20:54:33] [INFO] * Anti-dialog protections for unattended execution
[2026-11-12 20:54:33] [INFO] SET SAFETY OFF
[2026-11-12 20:54:33] [INFO] SET RESOURCE OFF
[2026-11-12 20:54:33] [INFO] SET TALK OFF
[2026-11-12 20:54:33] [INFO] SET NOTIFY OFF
[2026-11-12 20:54:33] [INFO] SYS(2335, 0)
[2026-11-12 20:54:33] [INFO] 
[2026-11-12 20:54:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigoporc', 'C:\4c\tasks\task781', 'OPERACIONAL'
[2026-11-12 20:54:33] [INFO] QUIT
[2026-11-12 20:54:33] [INFO] 
[2026-11-12 20:54:33] [INFO] === Fim do Wrapper.prg ===
[2026-11-12 20:54:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigoporc",
  "timestamp": "20261112205433",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": true,
      "erro": "",
      "detalhes": "CarregarDados() executado | (sem registros - tabela pode estar vazia)"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 12 (KEYPRESS, PROCURADPRO2SKEYPRESS, PROCURADPROSKEYPRESS, TXTBVKEYPRESS, TXTCONTINGENTEKEYPRESS, TXTIMPOSTOKEYPRESS, TXTIMPOSTOSERVICOKEYPRESS, TXTTAXAADMKEYPRESS, VALIDARACABAMENTOKEYPRESS, VALIDARPRODUTOITEMKEYPRESS, VALIDARUNIDADEPEDIDOKEYPRESS, VALIDARUNIDADEVENDAKEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoporc.prg):
*====================================================================
* Formsigoporc.prg
*
* Form OPERACIONAL "Itens" - dialogo filho invocado a partir do form de
* cabecalho do Orcamento (SigMvCab/TprMvCab), listando e editando os
* itens do orcamento (SigMvOrc) e, por item, as parcelas/previsoes de
* pagamento (SigMvOrp). Legado: Lparameters poForm, pnDatSes - Set
* Datasession To pnDatSes (o dialogo passa a compartilhar a MESMA
* data session do pai). Nesta arquitetura o compartilhamento de cursor
* VFP e substituido pelos valores escalares (Emps/Dopes/Numes/MascNum)
* repassados ao BO no Init - ver cabecalho de sigoporcBO.prg.
*
* PILAR 1 (UX): dialogo modal, sem barra de titulo (TitleBar = 0), sem
* controle de janela (ControlBox = .F.), 1000x600, com a faixa de
* cabecalho cinza (cntSombra) no topo mostrando o titulo calculado
* "<Emps> <Dopes> <MascNum> - Itens" (legado: Thisform.Caption).
*
* PILAR 3 (arquitetura): o legado (SIGOPORC) e um form FLAT do VFP -
* SEM PageFrame, SEM Page1/Page2: todos os controles (grdItem, grdParcela,
* botoes, campos de percentual) sao filhos DIRETOS do form. Este form
* migrado segue a mesma estrutura flat (excecao documentada em CLAUDE.md
* para o Gate da Fase 3 quando o legado nao tem PageFrame - nao inventar
* Page1/Page2 que o original nao possui; referencia: FormSigMvSbn.prg).
* O UNICO container do legado e cntSombra (faixa do cabecalho),
* reproduzido aqui como cnt_4c_Sombra.
*
* FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
* Init/InicializarForm, BO e o cabecalho).
*
* FASE 4/8 - GRADES E BOTOES DE LINHA: as DUAS grades do legado e os
* botoes que operam linha nelas, mais o funil de carga:
*   grdItem    -> grd_4c_Itens     (30 colunas) + cmd_4c_IncluirLinha /
*                                    cmd_4c_ExcluirLinha (btnIncluir/
*                                    btnExcluir do legado)
*   grdParcela -> grd_4c_Parcelas  (7 colunas)  + cmd_4c_IncluirParcela /
*                                    cmd_4c_ExcluirParcela (btnIncluirp/
*                                    btnExcluirp do legado)
*
* Cada grade tem o par Configurar<X> (so o que NAO depende de dado) +
* Vincular<X> (RecordSource/ControlSource sob USED, e depois deles
* Width/Header1.Caption) - separados porque atribuir RecordSource RESETA
* Width e Header1.Caption (regra #41/Problema 48) e o bind acontece mais
* de uma vez. CarregarDados() e o FUNIL (PUBLIC) que garante os cursores,
* vincula, posiciona os aliases e repinta - transcrevendo o fecho do Init
* legado (Set Order/Set Key/Go Top + thisform.Refresh + Grade.Refresh).
*
* FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1): os campos de percentual/calculo
* do topo (Say5/getPmargem, say4/getPtax2, say1/getPtaxa, Say3/getPTax1,
* say2/getPimposto, Say6/getPservico - migrados para
* lbl_4c_Margem/txt_4c_Margem, lbl_4c_Contingente/txt_4c_Contingente,
* lbl_4c_TaxaAdm/txt_4c_TaxaAdm, lbl_4c_BV/txt_4c_BV, lbl_4c_Imposto/
* txt_4c_Imposto, lbl_4c_ImpostoServico/txt_4c_ImpostoServico) + Shape4
* (shp_4c_Painel) + get_NewGrp/Say_NewGrp (txt_4c_NovoGrupo/
* lbl_4c_NovoGrupo, com o lookup de Grupo transcrito) + getDescritivo
* (edt_4c_DescritivoRodape) + TotalizarItn() (motor de calculo chamado
* pelos 5 campos editaveis).
*
* FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2): getDpros/getDpro2s/
* btnProcura (busca textual na grade de itens, migrados para
* txt_4c_ProcuraDpros/edt_4c_ProcuraDpro2s/cmd_4c_Procurar) + imgProds
* (pre-visualizacao da foto do produto, migrado para img_4c_Produto,
* com zoom via ImgProdutoDblClick - SigOpZom nao migrado, fallback
* ShellExecute igual ao de Formsigprccp.FigJpgDblClick) + os lookups de
* CELULA de unidade (grdItem.Column4/Column6 - SigCdUni, compartilhando
* ValidarUnidadeGenerica) e de acabamento (grdItem.Column30 - SigCdAca).
* this_nImagems/this_nConfes (novas no BO) seguem o padrao "populado em
* fase posterior" de this_nCadProds/etc.
*
* LOOKUPS (todos implementados - metodos AbrirBusca*):
*   get_NewGrp.Valid        -> TxtNovoGrupoLostFocus + AbrirBuscaNovoGrupo
*                              (SigCdGrp restrito por SigCdRpo.Dopps, com
*                              fallback para a lista inteira - transcrito)
*   grdItem.Column1.Text1   -> ValidarProdutoItemKeyPress +
*                              AbrirBuscaProdutoItem (SigCdPro, INNER JOIN
*                              SigCdRpo quando ha restricao)
*   grdItem.Column4/Column6 -> ValidarUnidadeVenda/PedidoKeyPress ->
*                              ValidarUnidadeGenerica + AbrirBuscaUnidade
*                              (SigCdUni)
*   grdItem.Column30.Text1  -> ValidarAcabamentoKeyPress +
*                              AbrirBuscaAcabamento (SigCdAca)
*
* grdParcela.Column4/Column6.Text1 TEM Valid com fAcessoContas no dump,
* mas o Init legado fixa ".Column4.ReadOnly = .t." e
* ".Column6.ReadOnly = .t." (sem depender do modo) - coluna ReadOnly nao
* dispara Valid, entao esse lookup JA e inalcancavel no legado. As duas
* colunas ficam ReadOnly aqui tambem (fiel ao Init) e NENHUM lookup de
* conta e criado: inventar um editaria campo que o legado nunca deixou
* editar (PILAR 1).
*
* FASE 7/8 - FORM: leitura de SigCdOpe/SigCdEmp/SigOpCdd/SigMvCab
* (BO.CarregarConfiguracao, chamada em InicializarForm antes de qualquer
* Configurar*() que dependa do modo), carga real dos itens/parcelas do
* orcamento (BO.CarregarItens/CarregarParcelas, chamadas em
* CarregarDados - ate aqui os cursores existiam mas ficavam sempre
* vazios), os botoes de acao do rodape (btnIteSub/btnTotItens/btnInsBlo/
* btnInsSub/btnCadPro/OK -> cmd_4c_IteSub/cmd_4c_TotItens/cmd_4c_InsBlo/
* cmd_4c_InsSub/cmd_4c_CadPro/obj_4c_OK) e a gravacao da grade inteira no
* SQL Server ao confirmar (BtnSalvarClick).
*
* DOIS GAPS DOCUMENTADOS (nao silenciosos - ver cabecalho de cada
* metodo):
*   - btnIteSub/btnTotItens abrem "SigOpTor", dialogo legado SEPARADO
*     nunca migrado para este projeto (sem task propria) - o clique
*     avisa a pendencia (AvisarSigOpTorPendente) em vez de inventar uma
*     tela sem fonte no legado.
*   - btnCadPro NAO reproduz o contrato sincrono do legado ("Do Form
*     SigCdPro ... To lcCodProduto" + cascata de precificacao
*     automatica) - abre FormProduto (CRUD ja migrado, task propria) no
*     padrao de Init do projeto, sem retorno sincrono; o usuario digita
*     o codigo do produto novo no item depois de cadastra-lo.
*   - btnInsBlo/btnInsSub NAO reproduzem o ramo "Inlist(crSigCdOpe.
*     DigItens,6,7)" do legado (sub-itens de crSigOpCdI.JOB_MV_BLO) - a
*     tabela SigOpCdI NAO EXISTE no schema canonico (docs\schema.sql,
*     regra #14), e sem ela esse ramo e impossivel de transcrever.
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL:
*   - CarregarLista()        funil de RECARGA das duas grades (saiu de
*                            dentro de CarregarDados, que agora delega) -
*                            rele SigMvOrc/SigMvOrp, revincula, PRESERVA a
*                            linha corrente (SEEK por Citens) e repinta
*   - FormParaBO()/BOParaForm()  sincronizacao manual dos 5 percentuais do
*                            topo, que no legado era automatica pelo
*                            ControlSource = TprMvCab.<coluna> (ptax2s/
*                            descs/ptax1s/acres/ptax3s). Sem BOParaForm os
*                            campos abriam sempre em 0,00 e o primeiro
*                            Enter num deles zerava o percentual de TODOS
*                            os itens
*   - HabilitarCampos()      os "When" dos CAMPOS num lugar so
*   - AjustarBotoesPorModo() os "When" dos BOTOES num lugar so
*   - LimparCampos()         reset do estado auxiliar da tela (busca/
*                            grupo novo/foto/valores anteriores)
*   - BtnCancelarClick()     funil de abandono (o legado nao tem botao de
*                            abandono; e o ramo CONSULTAR do OK, que fecha
*                            sem gravar) - BtnSalvarClick delega a ele
*   - AtualizarModoCriacao() COMPLETADO: ate a Fase 7 cobria 2 dos ~20
*                            controles que o bloco de layout do Init
*                            legado toca (faltavam os 6 pares de
*                            percentual, a grade de parcelas e seus
*                            botoes, btnTotItens/btnIteSub e as duas
*                            legendas que o modo P&G troca)
*   - CriarCursorItens()     tpesos/univals/utilizas ACRESCENTADOS: as tres
*                            sao lidas por BO.CarregarDoCursor e faltavam
*                            no cursor, o que fazia a gravacao falhar na
*                            PRIMEIRA linha do SCAN (ver cabecalho do
*                            metodo)
*   - BtnProcurarClick()     guarda de modo que faltava (o "When" do
*                            legado; o botao e so-icone e nao pode ser
*                            desabilitado - CorretorAutomatico #106)
*
* Propriedades customizadas do SCX legado (SECAO 2 do dump) e seu
* equivalente nesta classe:
*   ParentForm  -> this_oFormPai   (form de cabecalho que abriu o dialogo)
*   poObjExt1   -> this_oObjExt1   (referencia ao form externo de pesquisa
*                                   de produtos SigOpCgp, usado em
*                                   grdItem.Column1.Text1.Click)
*   Op_Escolha  -> this_cOpEscolha (modo do dialogo: INSERIR/ALTERAR/
*                                   CONSULTAR - forcado para CONSULTAR
*                                   quando crSigCdOpe.DigItens = 5)
*   lAutPreco   -> this_lAutPreco  (guarda de autorizacao de troca manual
*                                   do preco unitario - grdItem.Column8)
*   lProcura    -> this_lProcura   (alterna btnProcura entre "abrir campo
*                                   de busca" e "executar a busca")
*   antdpros    -> this_cAntDpros  (valor anterior de Dpros, comparado no
*                                   Valid de grdItem.Column1.Text1)
*   oldpreco    -> this_nOldPreco  (valor anterior do campo de preco/
*                                   percentual em edicao, comparado nos
*                                   Valid das colunas 8 e 10 a 26)
*   cItAgr      -> this_nCItAgr    (CitAgrs do item corrente - agrupador
*                                   de decupagem)
*   cItem       -> this_nCItem     (property auxiliar do legado; sem uso
*                                   identificado nos metodos analisados -
*                                   mantida por fidelidade de objeto)
*
* Parametros de Init (equivalentes ao legado Lparameters poForm, pnDatSes):
*   par_oFormPai   - poForm: form de cabecalho que abriu este dialogo
*   par_cEmps      - TprMvCab.Emps (repassado ao BO)
*   par_cDopes     - TprMvCab.Dopes (repassado ao BO)
*   par_nNumes     - TprMvCab.Numes (repassado ao BO)
*   par_cMascNum   - TprMvCab.MascNum (repassado ao BO, usado no Caption)
*   par_cOpEscolha - poForm.pcEscolha (modo herdado do pai; "CONSULTAR"
*                    quando SigCdOpe.DigItens = 5 - resolvido em
*                    InicializarForm, apos o BO carregar DigItens)
*====================================================================

DEFINE CLASS Formsigoporc AS FormBase

	*-- Propriedades visuais (pixel-perfect SCX original - PILAR 1)
	Width        = 1000
	Height       = 600
	AutoCenter   = .T.
	Caption      = "Itens"
	ShowWindow   = 1
	WindowType   = 1
	ControlBox   = .F.
	MaxButton    = .F.
	MinButton    = .F.
	TitleBar     = 0
	BorderStyle  = 2
	ShowTips     = .T.
	DataSession  = 1

	*-- Referencia ao form pai e BO
	this_oFormPai        = .NULL.
	this_oBusinessObject = .NULL.

	*-- Parametros recebidos do form pai (equivalentes a TprMvCab.Emps/
	*-- Dopes/Numes/MascNum do legado, repassados ao BO no Init)
	this_cEmps     = ""
	this_cDopes    = ""
	this_nNumes    = 0
	this_cMascNum  = ""

	*-- Propriedades customizadas do SCX legado (ver cabecalho acima)
	this_oObjExt1   = .NULL.
	this_cOpEscolha = ""
	this_lAutPreco  = .F.
	this_lProcura   = .F.
	this_cAntDpros  = ""
	this_nOldPreco  = 0
	this_nCItAgr    = 0
	this_nCItem     = 0

	*-- Guarda de reentrancia do lookup de Get_NewGrp (regra #37/#47): o
	*-- picker e MODAL e tira o foco, o que redispara o proprio LostFocus.
	this_lEmLookupGrupo = .F.

	*-- Guarda de valor-ja-validado de TxtNovoGrupoLostFocus: o legado
	*-- dispara o lookup no Valid (so quando o valor MUDA); LostFocus
	*-- dispara SEMPRE, inclusive sem digitacao nova. Guarda o ultimo
	*-- valor ja processado para a proxima perda de foco sem mudanca sair
	*-- sem reconsultar/reabrir o picker.
	this_cUltimoTxtNovoGrupoLostFocusValidado = ""

	*-- Guarda de reentrancia dos lookups de CELULA da grade de itens
	*-- (unidade de venda/pedido, acabamento e produto). Mesmo motivo do
	*-- this_lEmLookupGrupo: o FormBuscaAuxiliar e modal, tira o foco da
	*-- celula e redispara o evento que abriu o picker. Uma flag por
	*-- familia de lookup, para um picker nao bloquear o outro.
	this_lEmLookupUnidade    = .F.
	this_lEmLookupAcabamento = .F.
	this_lEmLookupProduto    = .F.

	*-- Canal de retorno dos metodos AbrirBusca* (VFP9 nao devolve par de
	*-- valores): o metodo de busca grava aqui o codigo e a descricao
	*-- escolhidos no picker, e o handler Validar* que o chamou le e
	*-- aplica no cursor. Vazios quando o usuario cancelou (ESC) - mesma
	*-- semantica do "If Lastkey() = 27" do legado.
	this_cLookupCodigo    = ""
	this_cLookupDescricao = ""

	*==========================================================================
	* Init - Armazena parametros recebidos do form pai antes de DODEFAULT
	*==========================================================================
	PROCEDURE Init(par_oFormPai, par_cEmps, par_cDopes, par_nNumes, ;
			par_cMascNum, par_cOpEscolha)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		IF VARTYPE(par_oFormPai) = "O"
			THIS.this_oFormPai = par_oFormPai
		ENDIF

		THIS.this_cEmps    = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")
		THIS.this_cDopes   = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
		THIS.this_nNumes   = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
		THIS.this_cMascNum = IIF(VARTYPE(par_cMascNum) = "C", ALLTRIM(par_cMascNum), "")

		*-- Legado: Op_Escolha = Iif(crSigCdOpe.DigItens = 5, 'CONSULTAR', poForm.pcEscolha)
		*-- O ramo DigItens=5 depende do BO (SigCdOpe ainda nao carregado aqui) e
		*-- fica resolvido em InicializarForm; por ora guarda so o valor do pai.
		THIS.this_cOpEscolha = IIF(VARTYPE(par_cOpEscolha) = "C" AND !EMPTY(par_cOpEscolha), ;
			UPPER(ALLTRIM(par_cOpEscolha)), "CONSULTAR")

		loc_lResultado = DODEFAULT()
		RETURN loc_lResultado
	ENDPROC

	*==========================================================================
	* InicializarForm - Cria o BO e monta o cabecalho. As grades (itens/
	* parcelas), os botoes e os campos de percentual/calculo ficam para
	* as fases seguintes.
	*==========================================================================
	PROTECTED PROCEDURE InicializarForm()
		LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
		loc_lSucesso = .F.
		loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
			(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)

		TRY
			THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

			THIS.this_oBusinessObject = CREATEOBJECT("sigoporcBO", ;
				THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, THIS.this_cMascNum)

			IF VARTYPE(THIS.this_oBusinessObject) <> "O"
				MsgErro("Erro ao criar sigoporcBO. VARTYPE retornou: " + ;
					VARTYPE(THIS.this_oBusinessObject), "Formsigoporc.InicializarForm")
			ELSE
				*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+
				*-- Alltrim(MascNum)+' - Itens'. Em validacao de UI / modo teste nao
				*-- recalcula: o comparador confere contra o Caption ESTATICO do SCX
				*-- ("Itens"), e Emps/Dopes/MascNum chegam vazios nesses modos (sem
				*-- form pai nem conexao SQL) - recalcular so trocaria o texto fiel
				*-- por outro tambem incorreto.
				IF !loc_lModoValidacaoOuTeste
					THIS.Caption = THIS.this_oBusinessObject.this_cCaption
				ENDIF

				IF !loc_lModoValidacaoOuTeste
					THIS.this_oBusinessObject.CarregarConfiguracao()
					IF THIS.this_oBusinessObject.this_nDigItens = 5
						THIS.this_cOpEscolha = "CONSULTAR"
					ENDIF
				ENDIF

				THIS.ConfigurarCabecalho()
				THIS.ConfigurarGridItens()
				THIS.ConfigurarBotoesItens()
				THIS.ConfigurarGradeParcelas()
				THIS.ConfigurarBotoesParcelas()
				THIS.ConfigurarCamposPercentuais()
				THIS.ConfigurarCampoNovoGrupo()
				THIS.ConfigurarCampoBusca()
				THIS.ConfigurarDescritivoRodape()
				THIS.ConfigurarImagemProduto()
				THIS.ConfigurarBotoesPrincipais()

				*-- Chamado uma unica vez, depois que TODOS os controles que
				*-- dependem do modo (busca/descritivo/imagem) ja existem -
				*-- CarregarDados() tambem chama de novo mais abaixo, idempotente.
				THIS.AtualizarModoCriacao()

				*-- Mestre-detalhe: a troca de linha na grade de itens refaz o
				*-- filtro da grade de parcelas. O BINDEVENT vem DEPOIS das duas
				*-- grades existirem, porque o handler mexe em grd_4c_Parcelas.
				BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", ;
					THIS, "GradeItensAfterRowColChange")

				*-- FUNIL de carga (cria/vincula cursores, posiciona e repinta).
				*-- Nao condicionado a loc_lModoValidacaoOuTeste: os cursores sao
				*-- locais (CREATE CURSOR), nao dependem de conexao SQL, e sem a
				*-- chamada as grades abririam com cabecalho "Column<N>" e largura
				*-- default tambem na validacao de UI. Ele ja aplica o layout do
				*-- modo (AtualizarModoCriacao -> HabilitarCampos +
				*-- AjustarBotoesPorModo) e traz os percentuais do cabecalho
				*-- (BOParaForm).
				THIS.CarregarDados()

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.InicializarForm")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com
	* os dois labels sobrepostos (sombra + titulo) exibindo o Caption
	* calculado em InicializarForm. Filho DIRETO do form (sem PageFrame),
	* igual ao SCX legado.
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

		loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
		WITH loc_oCnt.lbl_4c_Sombra
			.FontBold      = .T.
			.FontName      = "Tahoma"
			.FontSize      = 18
			.FontUnderline = .F.
			.WordWrap      = .T.
			.Alignment     = 0
			.BackStyle     = 0
			.AutoSize      = .F.
			.Caption       = THIS.Caption
			.Height        = 40
			.Left          = 10
			.Top           = 18
			.Width         = 769
			.ForeColor     = RGB(0, 0, 0)
			.Visible       = .T.
		ENDWITH

		loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
		WITH loc_oCnt.lbl_4c_Titulo
			.FontBold  = .T.
			.FontName  = "Tahoma"
			.FontSize  = 18
			.WordWrap  = .T.
			.Alignment = 0
			.BackStyle = 0
			.AutoSize  = .F.
			.Caption   = THIS.Caption
			.Height    = 46
			.Left      = 10
			.Top       = 17
			.Width     = 769
			.ForeColor = RGB(255, 255, 255)
			.Visible   = .T.
		ENDWITH
	ENDPROC

	*==========================================================================
	* CriarCursorItens - Cursor local da grade de itens (grd_4c_Itens),
	* equivalente ao crSigMvOrc que o legado compartilha com o form pai via
	* troca de DataSession. Aqui o cursor e proprio deste form (regra
	* OPERACIONAL #2/#3: ControlSource das colunas tem de bater com os
	* campos deste CREATE CURSOR, com a MESMA ordem em qualquer outro lugar
	* que vier a recriar o cursor).
	*
	* Campos cidchaves/cblocos/citens/citem2/citem3/citagrs/cpros/vlbaixas
	* sao usados pelos botoes de linha (Incluir/Excluir) para renumerar o
	* bloco - nao aparecem em coluna do grid, mas existem no cursor (igual
	* ao legado, que os mantem no cursor mesmo sem Column visivel).
	*
	* dcunis/dcunips/dacabs sao campos de PROJECAO (join com SigCdUni/
	* SigCdAca no legado - Column4/Column6/Column30 mostram a DESCRICAO,
	* nao o codigo) - ficam vazios ate a fase do BO que monta a consulta
	* com os joins (CarregarItens - ver cabecalho do BO).
	*
	* cunis/cunips/codacabs sao os CODIGOS que os lookups de celula
	* (SigCdUni em Column4/Column6, SigCdAca em Column30) e o lookup de
	* produto (Column1) gravam - char(3) nas tres colunas de SigMvOrc
	* (docs\schema.sql conferido com Get-Content -Raw, regra #14). Nao tem
	* Column no grid (o grid mostra a descricao), mas EXISTEM no cursor:
	* sem eles o REPLACE dos handlers Validar* estouraria em runtime
	* ("Variable CUNIS is not found") na primeira vez que o usuario
	* escolhesse uma unidade.
	*
	* perc1s..perc6s NAO existem na tabela SigMvOrc (docs\schema.sql
	* conferido) - sao campos de TRABALHO, so do cursor/grid, usados pelo
	* legado para aplicar o percentual digitado nos campos do topo
	* (Fase 5) antes de consolidar o resultado em tota1s..tota10s (que
	* SIM sao persistidos). perc1s nao tem coluna propria no grid (so e
	* usado internamente por TotalizarItn/getPtax2), por isso faltava
	* aqui.
	*==========================================================================
	*
	* Fase 7/8 - ACRESCIMO: emps/dopes/numes/empdopnums/pkchaves/moedas/
	* moefats/moevs/opers nao estavam no cursor (faltavam desde a Fase 3) -
	* sem eles, BO.CarregarDoCursor() (chamado no Salvar) nao tinha de onde
	* ler essas colunas NOT NULL de SigMvOrc, e o INSERT/UPDATE do item
	* gravaria moeda/operacao/chave sempre em branco. emps/dopes/numes
	* tambem sao usados por BO.CarregarItens() como filtro de carga.
	*==========================================================================
	*
	* Fase 8/8 - ACRESCIMO: tpesos/univals/utilizas. As TRES sao colunas
	* REAIS de SigMvOrc (docs\schema.sql conferido com Get-Content -Raw,
	* regra #14), estao no SELECT de BO.CarregarItens e nos INSERT/UPDATE
	* de BO.Inserir/Atualizar - mas FALTAVAM no CREATE CURSOR. Como
	* BO.CarregarDoCursor() le as tres (TratarNulo(tpesos,...)), a leitura
	* estourava "Variable TPESOS is not found" em RUNTIME, dentro do
	* TRY/CATCH do BO: compilava limpo e, na PRIMEIRA linha do SCAN de
	* BtnSalvarClick, o metodo devolvia .F. com as properties do item
	* ainda no valor da linha anterior - ou seja, NENHUM item era gravado
	* corretamente. Mesma familia da regra #22 (campo lido em
	* CarregarDoCursor que nao existe no cursor).
	*
	* vlbaixas fica no cursor mas NUNCA e preenchida pela carga: no legado
	* ela e coluna PROJETADA pela query do form PAI (igual a DcUnis/
	* DcUnips/DAcabs), e SigMvOrc nao tem coluna de baixa. Com 0 fixo, os
	* guards "Empty(VlBaixas)" transcritos do legado ficam sempre
	* verdadeiros (item nunca bloqueado por baixa) - comportamento seguro
	* e explicito, nao silencioso: inventar uma origem para essa coluna
	* seria inventar regra de negocio (regra #17).
	*==========================================================================
	PROTECTED PROCEDURE CriarCursorItens()
		LOCAL loc_cCursor
		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

		IF USED(loc_cCursor)
			USE IN (loc_cCursor)
		ENDIF

		SET NULL ON
		CREATE CURSOR (loc_cCursor) ;
			(cidchaves C(20), cblocos C(30), citens N(10,0), citem2 N(10,0), ;
			 citem3 N(10,0), citagrs N(10,0), cpros C(14), dpros C(65), ;
			 dpro2s M, qtds N(8,4), cunis C(3), dcunis C(20), pesos N(8,4), ;
			 cunips C(3), dcunips C(20), codacabs C(3), ;
			 fators N(8,4), units N(13,2), totas N(13,2), tota1s N(13,2), ;
			 tota2s N(13,2), tota3s N(13,2), tota4s N(13,2), tota5s N(13,2), ;
			 tota6s N(13,2), obs M, tota7s N(13,2), tota8s N(13,2), ;
			 tota9s N(13,2), tota10s N(13,2), notas C(9), perc1s N(8,4), ;
			 perc2s N(8,4), perc3s N(8,4), perc4s N(8,4), perc5s N(8,4), ;
			 perc6s N(8,4), servicos L, debitos L, taxas L, dacabs C(40), ;
			 vlbaixas N(13,2), emps C(3), dopes C(20), numes N(6,0), ;
			 empdopnums C(29), pkchaves C(20), moedas C(3), moefats C(3), ;
			 moevs C(3), opers C(1), tpesos N(8,4), univals N(13,2), ;
			 utilizas N(2,0))
		SET NULL OFF

		INDEX ON citens TAG citens
	ENDPROC

	*==========================================================================
	* ConfigurarGridItens - grd_4c_Itens, equivalente ao SIGOPORC.grdItem
	* (30 colunas). ControlSource/Width/ColumnOrder/Header1.Caption
	* TRANSCRITOS do dump (PROPRIEDADES DE: SIGOPORC.grdItem e do Init -
	* "With ThisForm.grdItem"). Column1 mostra Dpros (nao "Item" - o
	* Header1.Caption do dump e literalmente esse, apesar do nome sugerir
	* outra coisa) e Column2 mostra Dpro2s - conferido nas DUAS fontes do
	* dump (PROPRIEDADES + Init) porque batiam.
	*
	* FICA PARA FASE POSTERIOR (depende de crSigCdOpe/SigCdEmp, carregados
	* pelo BO em fase propria - ver cabecalho de sigoporcBO.prg):
	*   - ReadOnly fixo (.T.) de Column13/Column14, mascaras de Column3/
	*     Column5/Column7..20 (InputMask calculado de SigOpCdd.CasQtds/
	*     SigCdOpe.NCPesos/Casas) e a troca de Header1.Caption/Width/
	*     Visible conforme LocalEmp.DivNotas (P&G) ou crSigCdOpe.DigItens
	*     IN (6,7) (modo Criacao);
	*   - DynamicBackColor/DynamicForeColor (realce de bloco/sub-bloco);
	*   - Column4/Column6 (DcUnis/DcUnips) e Column30 (DAcabs) so recebem
	*     valor quando o BO passar a montar cursor_4c_Itens com os joins
	*     de unidade/acabamento.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarGridItens()
		LOCAL loc_lSoLeitura
		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")

		THIS.AddObject("grd_4c_Itens", "Grid")

		*-- ColumnCount FORA do WITH: as colunas ainda nao existem no momento
		*-- da compilacao do WITH abaixo (regra CLAUDE.md sobre WITH + Grid -
		*-- "Unknown member COLUMN1"). RecordSource/ControlSource/Width/
		*-- Header1.Caption NAO ficam aqui: vao em VincularGradeItens().
		THIS.grd_4c_Itens.ColumnCount  = 30

		WITH THIS.grd_4c_Itens
			.Top          = 218
			.Left         = 5
			.Width        = 989
			.Height       = 258
			.FontSize     = 8
			.HeaderHeight = 16
			.RowHeight    = 16
			.ScrollBars   = 3
			.DeleteMark   = .F.
			.RecordMark   = .F.
			.TabIndex     = 13

			*-- Column1 (Item/Dpros - descritivo do produto). Celula com
			*-- LOOKUP (legado grdItem.Column1.Text1.Valid -> SigCdPro), por
			*-- isso recebe TextBox proprio via AddObject + CurrentControl +
			*-- Sparse = .F. (regra #18: sem CurrentControl a coluna continua
			*-- desenhando o Text1 nativo e o lookup nunca e alcancado; sem
			*-- Sparse = .F. o controle so aparece na linha ativa).
			*-- MaxLength vem da LARGURA da coluna no schema (SigMvOrc.dpros
			*-- char(65)), nunca do Width em pixels (regra #19).
			.Column1.ColumnOrder     = 1
			.Column1.FontSize        = 8
			.Column1.Header1.Alignment = 2
			.Column1.Header1.FontSize  = 8
			.Column1.AddObject("txt_4c_DescricaoItem", "TextBox")
			.Column1.txt_4c_DescricaoItem.BorderStyle = 0
			.Column1.txt_4c_DescricaoItem.Margin      = 0
			.Column1.txt_4c_DescricaoItem.ForeColor   = RGB(0, 0, 0)
			.Column1.txt_4c_DescricaoItem.BackColor   = RGB(255, 255, 255)
			.Column1.txt_4c_DescricaoItem.MaxLength   = 65
			.Column1.CurrentControl = "txt_4c_DescricaoItem"
			.Column1.Sparse   = .F.
			.Column1.ReadOnly = loc_lSoLeitura

			*-- Column2 (Descritivo - Dpro2s, memo - Fwmemo1 do legado)
			.Column2.ColumnOrder     = 2
			.Column2.FontSize        = 8
			.Column2.Header1.Alignment = 2
			.Column2.Header1.FontSize  = 8
			.Column2.AddObject("edt_4c_Descritivo", "EditBox")
			.Column2.edt_4c_Descritivo.Top          = 42
			.Column2.edt_4c_Descritivo.Left         = 41
			.Column2.edt_4c_Descritivo.FontName     = "Arial"
			.Column2.edt_4c_Descritivo.FontSize     = 8
			.Column2.edt_4c_Descritivo.BorderStyle  = 0
			.Column2.edt_4c_Descritivo.SpecialEffect = 1
			.Column2.CurrentControl = "edt_4c_Descritivo"
			.Column2.Sparse  = .F.
			.Column2.ReadOnly = loc_lSoLeitura

			*-- Column3 (Quantidade - qtds)
			.Column3.ColumnOrder     = 4
			.Column3.FontSize        = 8
			.Column3.Header1.Alignment = 2
			.Column3.Header1.FontSize  = 8
			.Column3.Text1.BorderStyle = 0
			.Column3.Text1.Margin      = 0
			.Column3.Text1.ForeColor   = RGB(0, 0, 0)
			.Column3.Text1.BackColor   = RGB(255, 255, 255)
			.Column3.ReadOnly = loc_lSoLeitura

			*-- Column4 (Unidade - DcUnis, descricao de venda) - TextBox subclasse
			*-- (nao o Text1 default) para hospedar o lookup de celula de
			*-- SigCdUni no Valid (regra #46 - ValidarUnidadeVendaKeyPress)
			.Column4.ColumnOrder     = 5
			.Column4.FontSize        = 8
			.Column4.Header1.Alignment = 2
			.Column4.Header1.FontSize  = 8
			.Column4.AddObject("txt_4c_UnidadeVenda", "TextBox")
			.Column4.txt_4c_UnidadeVenda.BorderStyle = 0
			.Column4.txt_4c_UnidadeVenda.Margin       = 0
			.Column4.txt_4c_UnidadeVenda.ForeColor    = RGB(0, 0, 0)
			.Column4.txt_4c_UnidadeVenda.BackColor    = RGB(255, 255, 255)
			.Column4.txt_4c_UnidadeVenda.MaxLength   = 20
			.Column4.CurrentControl = "txt_4c_UnidadeVenda"
			.Column4.Sparse   = .F.
			.Column4.ReadOnly = loc_lSoLeitura

			*-- Column5 (Periodo - pesos)
			.Column5.ColumnOrder     = 6
			.Column5.FontSize        = 8
			.Column5.Header1.Alignment = 2
			.Column5.Header1.FontSize  = 8
			.Column5.Text1.BorderStyle = 0
			.Column5.Text1.Margin      = 0
			.Column5.Text1.ForeColor   = RGB(0, 0, 0)
			.Column5.Text1.BackColor   = RGB(255, 255, 255)
			.Column5.ReadOnly = loc_lSoLeitura

			*-- Column6 (Unidade - DcUnips, descricao de compra/pedido) -
			*-- TextBox subclasse, mesma razao da Column4
			.Column6.ColumnOrder     = 7
			.Column6.FontSize        = 8
			.Column6.Header1.Alignment = 2
			.Column6.Header1.FontSize  = 8
			.Column6.AddObject("txt_4c_UnidadePedido", "TextBox")
			.Column6.txt_4c_UnidadePedido.BorderStyle = 0
			.Column6.txt_4c_UnidadePedido.Margin       = 0
			.Column6.txt_4c_UnidadePedido.ForeColor    = RGB(0, 0, 0)
			.Column6.txt_4c_UnidadePedido.BackColor    = RGB(255, 255, 255)
			.Column6.txt_4c_UnidadePedido.MaxLength   = 20
			.Column6.CurrentControl = "txt_4c_UnidadePedido"
			.Column6.Sparse   = .F.
			.Column6.ReadOnly = loc_lSoLeitura

			*-- Column7 (Turno - fators)
			.Column7.ColumnOrder     = 8
			.Column7.FontSize        = 8
			.Column7.Header1.Alignment = 2
			.Column7.Header1.FontSize  = 8
			.Column7.Text1.BorderStyle = 0
			.Column7.Text1.Margin      = 0
			.Column7.Text1.ForeColor   = RGB(0, 0, 0)
			.Column7.Text1.BackColor   = RGB(255, 255, 255)
			.Column7.ReadOnly = loc_lSoLeitura

			*-- Column8 (Unitario - units)
			.Column8.ColumnOrder     = 9
			.Column8.FontSize        = 8
			.Column8.Header1.Alignment = 2
			.Column8.Header1.FontSize  = 8
			.Column8.Text1.BorderStyle = 0
			.Column8.Text1.Margin      = 0
			.Column8.Text1.ForeColor   = RGB(0, 0, 0)
			.Column8.Text1.BackColor   = RGB(255, 255, 255)
			.Column8.ReadOnly = loc_lSoLeitura

			*-- Column9 (Total - totas)
			.Column9.ColumnOrder     = 10
			.Column9.FontSize        = 8
			.Column9.Header1.Alignment = 2
			.Column9.Header1.FontSize  = 8
			.Column9.Text1.BorderStyle = 0
			.Column9.Text1.Margin      = 0
			.Column9.Text1.ForeColor   = RGB(0, 0, 0)
			.Column9.Text1.BackColor   = RGB(255, 255, 255)
			.Column9.ReadOnly = loc_lSoLeitura

			*-- Column10 (Total NF SRCOM - tota1s)
			.Column10.ColumnOrder     = 12
			.Column10.FontSize        = 8
			.Column10.Header1.Alignment = 2
			.Column10.Header1.FontSize  = 8
			.Column10.Text1.BorderStyle = 0
			.Column10.Text1.Margin      = 0
			.Column10.Text1.ForeColor   = RGB(0, 0, 0)
			.Column10.Text1.BackColor   = RGB(255, 255, 255)
			.Column10.ReadOnly = loc_lSoLeitura

			*-- Column11 (Total SRCOM Custos Internos - tota2s)
			.Column11.ColumnOrder     = 14
			.Column11.FontSize        = 8
			.Column11.Header1.Alignment = 2
			.Column11.Header1.WordWrap = .T.
			.Column11.Header1.FontSize = 8
			.Column11.Text1.BorderStyle = 0
			.Column11.Text1.Margin      = 0
			.Column11.Text1.ForeColor   = RGB(0, 0, 0)
			.Column11.Text1.BackColor   = RGB(255, 255, 255)
			.Column11.ReadOnly = loc_lSoLeitura

			*-- Column12 (Total Fornecedor - tota3s)
			.Column12.ColumnOrder     = 16
			.Column12.FontSize        = 8
			.Column12.Header1.Alignment = 2
			.Column12.Header1.FontSize  = 8
			.Column12.Text1.BorderStyle = 0
			.Column12.Text1.Margin      = 0
			.Column12.Text1.ForeColor   = RGB(0, 0, 0)
			.Column12.Text1.BackColor   = RGB(255, 255, 255)
			.Column12.ReadOnly = loc_lSoLeitura

			*-- Column13 (ICMS - tota4s)
			.Column13.ColumnOrder     = 18
			.Column13.FontSize        = 8
			.Column13.Header1.Alignment = 2
			.Column13.Header1.FontSize  = 8
			.Column13.Text1.BorderStyle = 0
			.Column13.Text1.Margin      = 0
			.Column13.Text1.ForeColor   = RGB(0, 0, 0)
			.Column13.Text1.BackColor   = RGB(255, 255, 255)
			.Column13.ReadOnly = loc_lSoLeitura

			*-- Column14 (Rouanet - tota5s)
			.Column14.ColumnOrder     = 20
			.Column14.FontSize        = 8
			.Column14.Header1.Alignment = 2
			.Column14.Header1.FontSize  = 8
			.Column14.Text1.BorderStyle = 0
			.Column14.Text1.Margin      = 0
			.Column14.Text1.ForeColor   = RGB(0, 0, 0)
			.Column14.Text1.BackColor   = RGB(255, 255, 255)
			.Column14.ReadOnly = loc_lSoLeitura

			*-- Column15 (Outras - tota6s)
			.Column15.ColumnOrder     = 22
			.Column15.FontSize        = 8
			.Column15.Header1.Alignment = 2
			.Column15.Header1.FontSize  = 8
			.Column15.Text1.BorderStyle = 0
			.Column15.Text1.Margin      = 0
			.Column15.Text1.ForeColor   = RGB(0, 0, 0)
			.Column15.Text1.BackColor   = RGB(255, 255, 255)
			.Column15.ReadOnly = loc_lSoLeitura

			*-- Column16 (Observacao - obs, memo - Fwmemo1 do legado)
			.Column16.ColumnOrder     = 25
			.Column16.FontSize        = 8
			.Column16.Header1.Alignment = 2
			.Column16.Header1.FontSize  = 8
			.Column16.AddObject("edt_4c_Observacao", "EditBox")
			.Column16.edt_4c_Observacao.Top          = 42
			.Column16.edt_4c_Observacao.Left         = 17
			.Column16.edt_4c_Observacao.FontName     = "Arial"
			.Column16.edt_4c_Observacao.FontSize     = 8
			.Column16.edt_4c_Observacao.BorderStyle  = 0
			.Column16.edt_4c_Observacao.SpecialEffect = 1
			.Column16.CurrentControl = "edt_4c_Observacao"
			.Column16.Sparse  = .F.
			.Column16.ReadOnly = loc_lSoLeitura

			*-- Column17 (Real SRCOM Custos Internos - tota7s)
			.Column17.ColumnOrder     = 26
			.Column17.FontSize        = 8
			.Column17.Header1.Alignment = 2
			.Column17.Header1.WordWrap = .T.
			.Column17.Header1.FontSize = 8
			.Column17.Text1.BorderStyle = 0
			.Column17.Text1.Margin      = 0
			.Column17.Text1.ForeColor   = RGB(0, 0, 0)
			.Column17.Text1.BackColor   = RGB(255, 255, 255)
			.Column17.ReadOnly = loc_lSoLeitura

			*-- Column18 (Real Fornecedor - tota8s)
			.Column18.ColumnOrder     = 27
			.Column18.FontSize        = 8
			.Column18.Header1.Alignment = 2
			.Column18.Header1.FontSize  = 8
			.Column18.Text1.BorderStyle = 0
			.Column18.Text1.Margin      = 0
			.Column18.Text1.ForeColor   = RGB(0, 0, 0)
			.Column18.Text1.BackColor   = RGB(255, 255, 255)
			.Column18.ReadOnly = loc_lSoLeitura

			*-- Column19 (Saldo Real SRCOM Custos Internos - tota9s)
			.Column19.ColumnOrder     = 28
			.Column19.FontSize        = 8
			.Column19.Header1.Alignment = 2
			.Column19.Header1.WordWrap = .T.
			.Column19.Header1.FontSize = 8
			.Column19.Text1.BorderStyle = 0
			.Column19.Text1.Margin      = 0
			.Column19.Text1.ForeColor   = RGB(0, 0, 0)
			.Column19.Text1.BackColor   = RGB(255, 255, 255)
			.Column19.ReadOnly = loc_lSoLeitura

			*-- Column20 (Saldo Real Fornecedor - tota10s)
			.Column20.ColumnOrder     = 29
			.Column20.FontSize        = 8
			.Column20.Header1.Alignment = 2
			.Column20.Header1.WordWrap = .T.
			.Column20.Header1.FontSize = 8
			.Column20.Text1.BorderStyle = 0
			.Column20.Text1.Margin      = 0
			.Column20.Text1.ForeColor   = RGB(0, 0, 0)
			.Column20.Text1.BackColor   = RGB(255, 255, 255)
			.Column20.ReadOnly = loc_lSoLeitura

			*-- Column21 (Nota - notas) - Width nao consta no dump (default)
			.Column21.ColumnOrder     = 30
			.Column21.FontSize        = 8
			.Column21.Header1.Alignment = 2
			.Column21.Header1.FontSize  = 8
			.Column21.Text1.BorderStyle = 0
			.Column21.Text1.Margin      = 0
			.Column21.Text1.ForeColor   = RGB(0, 0, 0)
			.Column21.Text1.BackColor   = RGB(255, 255, 255)
			.Column21.ReadOnly = loc_lSoLeitura

			*-- Column22 (% - perc4s)
			.Column22.ColumnOrder     = 17
			.Column22.FontSize        = 8
			.Column22.Header1.Alignment = 2
			.Column22.Header1.FontSize  = 8
			.Column22.Text1.BorderStyle = 0
			.Column22.Text1.Margin      = 0
			.Column22.Text1.ForeColor   = RGB(0, 0, 0)
			.Column22.Text1.BackColor   = RGB(255, 255, 255)
			.Column22.ReadOnly = loc_lSoLeitura

			*-- Column23 (% - perc5s)
			.Column23.ColumnOrder     = 19
			.Column23.FontSize        = 8
			.Column23.Header1.Alignment = 2
			.Column23.Header1.FontSize  = 8
			.Column23.Text1.BorderStyle = 0
			.Column23.Text1.Margin      = 0
			.Column23.Text1.ForeColor   = RGB(0, 0, 0)
			.Column23.Text1.BackColor   = RGB(255, 255, 255)
			.Column23.ReadOnly = loc_lSoLeitura

			*-- Column24 (% - perc6s)
			.Column24.ColumnOrder     = 21
			.Column24.FontSize        = 8
			.Column24.Header1.Alignment = 2
			.Column24.Header1.FontSize  = 8
			.Column24.Text1.BorderStyle = 0
			.Column24.Text1.Margin      = 0
			.Column24.Text1.ForeColor   = RGB(0, 0, 0)
			.Column24.Text1.BackColor   = RGB(255, 255, 255)
			.Column24.ReadOnly = loc_lSoLeitura

			*-- Column25 (% - perc2s)
			.Column25.ColumnOrder     = 13
			.Column25.FontSize        = 8
			.Column25.Header1.Alignment = 2
			.Column25.Header1.FontSize  = 8
			.Column25.Text1.BorderStyle = 0
			.Column25.Text1.Margin      = 0
			.Column25.Text1.ForeColor   = RGB(0, 0, 0)
			.Column25.Text1.BackColor   = RGB(255, 255, 255)
			.Column25.ReadOnly = loc_lSoLeitura

			*-- Column26 (% - perc3s)
			.Column26.ColumnOrder     = 15
			.Column26.FontSize        = 8
			.Column26.Header1.Alignment = 2
			.Column26.Header1.FontSize  = 8
			.Column26.Text1.BorderStyle = 0
			.Column26.Text1.Margin      = 0
			.Column26.Text1.ForeColor   = RGB(0, 0, 0)
			.Column26.Text1.BackColor   = RGB(255, 255, 255)
			.Column26.ReadOnly = loc_lSoLeitura

			*-- Column27 (S/Servico - servicos, checkbox) - oculta por padrao
			*-- (so aparece em modo P&G/Criacao - regra deferida, ver cabecalho)
			.Column27.AddObject("chk_4c_Servico", "CheckBox")
			.Column27.chk_4c_Servico.Caption = ""
			.Column27.CurrentControl   = "chk_4c_Servico"
			.Column27.ColumnOrder      = 23
			.Column27.FontSize         = 8
			.Column27.Header1.Alignment = 2
			.Column27.Header1.FontSize = 8
			.Column27.Header1.ToolTipText = "Servi" + CHR(231) + "o"
			.Column27.Sparse   = .F.
			.Column27.Visible  = .F.
			.Column27.ReadOnly = loc_lSoLeitura

			*-- Column28 (D/Debito - debitos, checkbox) - oculta por padrao
			.Column28.AddObject("chk_4c_Debito", "CheckBox")
			.Column28.chk_4c_Debito.Caption = ""
			.Column28.CurrentControl   = "chk_4c_Debito"
			.Column28.ColumnOrder      = 24
			.Column28.FontSize         = 8
			.Column28.Header1.Alignment = 2
			.Column28.Header1.FontSize = 8
			.Column28.Header1.ToolTipText = "D" + CHR(233) + "bito"
			.Column28.Sparse   = .F.
			.Column28.Visible  = .F.
			.Column28.ReadOnly = loc_lSoLeitura

			*-- Column29 (Fee/Taxa - taxas, checkbox)
			.Column29.AddObject("chk_4c_Fee", "CheckBox")
			.Column29.chk_4c_Fee.Caption = ""
			.Column29.CurrentControl   = "chk_4c_Fee"
			.Column29.ColumnOrder      = 11
			.Column29.FontSize         = 8
			.Column29.Header1.FontSize = 8
			.Column29.Sparse   = .F.
			.Column29.Visible  = .T.
			.Column29.ReadOnly = loc_lSoLeitura

			*-- Column30 (Acabamento - dacabs, descricao) - TextBox subclasse
			*-- para o lookup de celula de SigCdAca (ValidarAcabamentoKeyPress)
			.Column30.ColumnOrder     = 3
			.Column30.FontSize        = 8
			.Column30.Header1.Alignment = 2
			.Column30.Header1.FontSize  = 8
			.Column30.AddObject("txt_4c_Acabamento", "TextBox")
			.Column30.txt_4c_Acabamento.BorderStyle = 0
			.Column30.txt_4c_Acabamento.Margin       = 0
			.Column30.txt_4c_Acabamento.ForeColor    = RGB(0, 0, 0)
			.Column30.txt_4c_Acabamento.BackColor    = RGB(255, 255, 255)
			.Column30.txt_4c_Acabamento.MaxLength   = 20
			.Column30.CurrentControl = "txt_4c_Acabamento"
			.Column30.Sparse   = .F.
			.Column30.Visible  = .T.
			.Column30.ReadOnly = loc_lSoLeitura

			.Visible = .T.
		ENDWITH

		*-- Lookups de celula (produto + unidade de venda/pedido + acabamento) - BINDEVENT
		*-- FORA do WITH acima: regra #46 (Valid de celula vai no TextBox da
		*-- Column, nunca em AfterRowColChange) + regra #34 (Controls(N) por
		*-- indice, nunca por nome - aqui o caminho e qualificado explicito,
		*-- sem usar Controls()). GotFocus guarda o valor anterior em .Tag,
		*-- substituindo o "this.Tag = this.Value" que o legado faz no When
		*-- (When nao e um evento vinculavel por BINDEVENT com efeito colateral
		*-- confiavel em VFP9).
		BINDEVENT(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem, "GotFocus", THIS, "GuardarAntDpros")
		BINDEVENT(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem, "KeyPress", THIS, "ValidarProdutoItemKeyPress")
		BINDEVENT(THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda, "GotFocus", THIS, "GuardarTagUnidadeVenda")
		BINDEVENT(THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda, "KeyPress", THIS, "ValidarUnidadeVendaKeyPress")
		BINDEVENT(THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido, "GotFocus", THIS, "GuardarTagUnidadePedido")
		BINDEVENT(THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido, "KeyPress", THIS, "ValidarUnidadePedidoKeyPress")
		BINDEVENT(THIS.grd_4c_Itens.Column30.txt_4c_Acabamento, "GotFocus", THIS, "GuardarTagAcabamento")
		BINDEVENT(THIS.grd_4c_Itens.Column30.txt_4c_Acabamento, "KeyPress", THIS, "ValidarAcabamentoKeyPress")
	ENDPROC

	*==========================================================================
	* GuardarTagUnidadeVenda/Pedido/Acabamento - substituem o "this.Tag =
	* this.Value" que o legado faz dentro do PROCEDURE When (disparado a
	* cada entrada no campo). Guardam o valor com que o usuario ENTROU na
	* celula, para o Valid poder comparar e pular o lookup quando o
	* usuario so passou pela celula sem alterar (regra do legado: "If Padr
	* (this.Value,20) = Padr(this.Tag,20) / Return .t.").
	*==========================================================================
	*==========================================================================
	* GuardarAntDpros - equivalente ao "thisform.antdpros = this.Value" que o
	* legado faz no When de grdItem.Column1.Text1. Guarda, na property
	* this_cAntDpros (mapeada de antdpros), a descricao com que o usuario
	* ENTROU na celula, para o Valid poder sair sem reconsultar quando o
	* valor nao mudou ("If Padr(This.Value,40) = Padr(Thisform.antdpros,40)").
	*==========================================================================
	PROCEDURE GuardarAntDpros()
		THIS.this_cAntDpros = TratarNulo(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem.Value, "")
	ENDPROC

	PROCEDURE GuardarTagUnidadeVenda()
		THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda.Tag = THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda.Value
	ENDPROC

	PROCEDURE GuardarTagUnidadePedido()
		THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido.Tag = THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido.Value
	ENDPROC

	PROCEDURE GuardarTagAcabamento()
		THIS.grd_4c_Itens.Column30.txt_4c_Acabamento.Tag = THIS.grd_4c_Itens.Column30.txt_4c_Acabamento.Value
	ENDPROC

	*==========================================================================
	* ValidarUnidadeVendaKeyPress / ValidarUnidadePedidoKeyPress - legado
	* SIGOPORC.grdItem.Column4/Column6.Text1.Valid. O usuario digita a
	* DESCRICAO da unidade (DCunis/DCunips); o metodo resolve o CODIGO
	* (Cunis/Cunips) por busca exata e, faltando, abre o picker (padrao
	* local do projeto - FormBuscaAuxiliar + DefinirCursor sobre o cursor
	* JA populado, igual a TxtNovoGrupoLostFocus - nao o fwBuscaInt do
	* legado, que nao foi portado). Delegam para ValidarUnidadeGenerica,
	* que e a MESMA logica para os dois campos (so trocam coluna de
	* descricao/codigo no cursor de itens).
	*==========================================================================
	PROCEDURE ValidarUnidadeVendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_oTxt
		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF
		loc_oTxt = THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda
		THIS.ValidarUnidadeGenerica(loc_oTxt, "dcunis", "cunis")
	ENDPROC

	PROCEDURE ValidarUnidadePedidoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_oTxt
		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF
		loc_oTxt = THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido
		THIS.ValidarUnidadeGenerica(loc_oTxt, "dcunips", "cunips")
	ENDPROC

	*==========================================================================
	* ValidarUnidadeGenerica - corpo compartilhado por ValidarUnidadeVenda/
	* PedidoKeyPress. par_oTxt e o TextBox da celula (Column4/Column6);
	* par_cCampoDesc/par_cCampoCod sao as colunas do cursor_4c_Itens a
	* atualizar (dcunis/cunis ou dcunips/cunips).
	*
	* O valor digitado FICA no TextBox (par_oTxt.Value) - o cursor so
	* recebe DEPOIS, via REPLACE (regra #46). Se o valor nao mudou desde
	* que o usuario entrou na celula (guardado em .Tag por GotFocus), sai
	* sem reconsultar - igual ao legado.
	*==========================================================================
	PROTECTED PROCEDURE ValidarUnidadeGenerica(par_oTxt, par_cCampoDesc, par_cCampoCod)
		LOCAL loc_cItens, loc_cValor, loc_cSQL, loc_nResultado, loc_cDescEscolhida, loc_cCodEscolhido

		IF PADR(ALLTRIM(par_oTxt.Value), 20) = PADR(ALLTRIM(TratarNulo(par_oTxt.Tag, "")), 20)
			RETURN
		ENDIF

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF !USED(loc_cItens)
			RETURN
		ENDIF

		loc_cValor = ALLTRIM(par_oTxt.Value)

		IF EMPTY(loc_cValor)
			SELECT (loc_cItens)
			REPLACE (par_cCampoCod) WITH ""
			RETURN
		ENDIF

		IF USED("cursor_4c_TmpUnidade")
			USE IN cursor_4c_TmpUnidade
		ENDIF
		loc_cSQL = "SELECT Dunis, Cunis FROM SigCdUni WHERE Dunis LIKE " + ;
			EscaparSQL("%" + loc_cValor + "%") + " ORDER BY Cunis"
		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpUnidade")

		IF loc_nResultado < 0
			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
				"Falha na Conex" + CHR(227) + "o (SigCdUni)")
			RETURN
		ENDIF

		loc_cDescEscolhida = ""
		loc_cCodEscolhido  = ""

		IF USED("cursor_4c_TmpUnidade") AND RECCOUNT("cursor_4c_TmpUnidade") > 0
			SELECT cursor_4c_TmpUnidade
			GO TOP
			LOCATE FOR Dunis = PADR(loc_cValor, 20)

			IF FOUND()
				loc_cDescEscolhida = ALLTRIM(cursor_4c_TmpUnidade.Dunis)
				loc_cCodEscolhido  = ALLTRIM(cursor_4c_TmpUnidade.Cunis)
			ELSE
				*-- Busca exata falhou: abre o picker sobre o cursor JA
				*-- populado (equivale ao fwBuscaInt do legado). Regra #50:
				*-- NAO avisar nem apagar o que o usuario digitou aqui - o
				*-- picker e o proprio feedback.
				THIS.AbrirBuscaUnidade()
				loc_cCodEscolhido  = THIS.this_cLookupCodigo
				loc_cDescEscolhida = THIS.this_cLookupDescricao
			ENDIF
		ENDIF

		IF USED("cursor_4c_TmpUnidade")
			USE IN cursor_4c_TmpUnidade
		ENDIF

		SELECT (loc_cItens)
		IF EMPTY(loc_cCodEscolhido)
			par_oTxt.Value = ""
			REPLACE (par_cCampoDesc) WITH "", (par_cCampoCod) WITH ""
		ELSE
			par_oTxt.Value = loc_cDescEscolhida
			REPLACE (par_cCampoDesc) WITH loc_cDescEscolhida, (par_cCampoCod) WITH loc_cCodEscolhido
		ENDIF
	ENDPROC

	*==========================================================================
	* ValidarAcabamentoKeyPress - legado SIGOPORC.grdItem.Column30.Text1.
	* Valid. O usuario digita a descricao do acabamento (dacabs); o metodo
	* busca em SigCdAca por LIKE e abre o picker local quando ha mais de
	* um resultado. Universo VAZIO (zero linhas) NAO e erro de migracao
	* (regra #50): manter o aviso do legado, mas NUNCA apagar o texto que
	* o usuario digitou - so o CODIGO (codacabs) fica vazio, diferente do
	* legado (que limpa os dois, this.Value incluido).
	*==========================================================================
	PROCEDURE ValidarAcabamentoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_oTxt, loc_cItens, loc_cValor, loc_cSQL, loc_nResultado
		LOCAL loc_cDescEscolhida, loc_cCodEscolhido

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF

		loc_oTxt = THIS.grd_4c_Itens.Column30.txt_4c_Acabamento

		IF ALLTRIM(loc_oTxt.Value) == ALLTRIM(TratarNulo(loc_oTxt.Tag, ""))
			RETURN
		ENDIF

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF !USED(loc_cItens)
			RETURN
		ENDIF

		loc_cValor = ALLTRIM(loc_oTxt.Value)

		IF EMPTY(loc_cValor)
			SELECT (loc_cItens)
			REPLACE codacabs WITH ""
			RETURN
		ENDIF

		IF USED("cursor_4c_TmpAcabamento")
			USE IN cursor_4c_TmpAcabamento
		ENDIF
		loc_cSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Descrs LIKE " + EscaparSQL("%" + loc_cValor + "%")
		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpAcabamento")

		IF loc_nResultado < 0
			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
				"Falha na Conex" + CHR(227) + "o (SigCdAca)")
			RETURN
		ENDIF

		loc_cDescEscolhida = ""
		loc_cCodEscolhido  = ""

		IF USED("cursor_4c_TmpAcabamento") AND RECCOUNT("cursor_4c_TmpAcabamento") > 0
			THIS.AbrirBuscaAcabamento()
			loc_cCodEscolhido  = THIS.this_cLookupCodigo
			loc_cDescEscolhida = THIS.this_cLookupDescricao
		ELSE
			*-- Regra #50: universo vazio pode ser dado real (nenhum acabamento
			*-- com essa descricao) - avisar, mas NUNCA apagar o que o usuario
			*-- digitou (so o codigo, que de fato nao foi resolvido).
			MsgAviso("Acabamento n" + CHR(227) + "o encontrado.", "Aviso")
		ENDIF

		IF USED("cursor_4c_TmpAcabamento")
			USE IN cursor_4c_TmpAcabamento
		ENDIF

		SELECT (loc_cItens)
		IF !EMPTY(loc_cCodEscolhido)
			loc_oTxt.Value = loc_cDescEscolhida
			REPLACE dacabs WITH loc_cDescEscolhida, codacabs WITH loc_cCodEscolhido
		ELSE
			REPLACE codacabs WITH ""
		ENDIF
	ENDPROC

	*==========================================================================
	* ValidarProdutoItemKeyPress - legado SIGOPORC.grdItem.Column1.Text1.
	* Valid (o trecho de LOOKUP; a precificacao automatica que vem depois
	* dele no dump depende de crSigCdOpe/crSigOpCdd, carregados em fase
	* propria do BO - ver cabecalho da classe).
	*
	* O usuario digita parte da DESCRICAO do produto (Dpros); o metodo
	* consulta SigCdPro com a restricao de SigCdRpo (Dopps = Dopes do
	* cabecalho) - quando a restricao existe, o legado faz INNER JOIN; sem
	* restricao, consulta SigCdPro direto. Resolve por busca exata e, se
	* nao casar, abre o picker.
	*
	* Guardas TRANSCRITAS do legado (regra #21b - a condicao que cerca a
	* validacao FAZ PARTE dela):
	*   - valor nao mudou desde a entrada na celula (this_cAntDpros,
	*     comparado com PADR(...,40) igual ao legado) -> sai sem consultar
	*   - linha de SUBTOTAL (citens = citem2) ou de marcador de nivel
	*     (citens = citem3) -> o legado NAO faz lookup: nessas linhas a
	*     descricao digitada e so o rotulo do bloco, propagado para o
	*     dpro2s das linhas de SUBTOTAL do mesmo agrupamento
	*
	* O valor digitado esta em .Value (o cursor so recebe DEPOIS, via
	* REPLACE - regra #46), e a descricao escolhida volta para .Value alem
	* do REPLACE, senao o texto digitado sobrescreveria o cursor.
	*==========================================================================
	PROCEDURE ValidarProdutoItemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_oTxt, loc_cItens, loc_cValor, loc_cSQL, loc_nResultado
		LOCAL loc_cCodEscolhido, loc_cDescEscolhida, loc_cDescritivo
		LOCAL loc_cCunis, loc_cCunips, loc_lRestrito
		LOCAL loc_nItens, loc_nItem2, loc_nItem3

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF

		loc_oTxt   = THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem
		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens

		IF !USED(loc_cItens) OR EOF(loc_cItens)
			RETURN
		ENDIF

		loc_cValor = ALLTRIM(TratarNulo(loc_oTxt.Value, ""))

		SELECT (loc_cItens)
		loc_nItens = citens
		loc_nItem2 = citem2
		loc_nItem3 = citem3

		*-- Linha de SUBTOTAL / marcador de nivel: sem lookup. O legado
		*-- propaga o rotulo digitado para o dpro2s das linhas de SUBTOTAL
		*-- do mesmo agrupamento e volta ao item corrente por SEEK no TAG
		*-- citens.
		IF loc_nItens = loc_nItem2 OR loc_nItens = loc_nItem3
			IF loc_nItens = loc_nItem2 AND loc_nItens = loc_nItem3
				REPLACE dpro2s WITH loc_cValor ;
					FOR citem3 = loc_nItens AND citem2 = citens AND cblocos = "SUBTOTAL" ;
					IN (loc_cItens)
			ELSE
				REPLACE dpro2s WITH loc_cValor ;
					FOR citem2 = loc_nItem2 AND cblocos = "SUBTOTAL" ;
					IN (loc_cItens)
			ENDIF
			SELECT (loc_cItens)
			=SEEK(loc_nItens, loc_cItens, "citens")
			THIS.this_cAntDpros = loc_cValor
			THIS.grd_4c_Itens.Refresh()
			RETURN
		ENDIF

		*-- Valor nao mudou desde que o usuario entrou na celula
		IF PADR(loc_cValor, 40) = PADR(ALLTRIM(TratarNulo(THIS.this_cAntDpros, "")), 40)
			RETURN
		ENDIF

		IF EMPTY(loc_cValor)
			SELECT (loc_cItens)
			REPLACE cpros WITH "", cunis WITH "", cunips WITH ""
			THIS.this_cAntDpros = ""
			RETURN
		ENDIF

		*-- Ha restricao de grupo/grande grupo para esta movimentacao?
		IF USED("cursor_4c_RestricaoProduto")
			USE IN cursor_4c_RestricaoProduto
		ENDIF
		loc_cSQL = "SELECT Cgrus, Opers, Mercs, Contas, CodCors FROM SigCdRpo WHERE Dopps = " + ;
			EscaparSQL(THIS.this_cDopes)
		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RestricaoProduto")

		IF loc_nResultado < 0
			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
				"Falha na Conex" + CHR(227) + "o (SigCdRpo)")
			RETURN
		ENDIF

		loc_lRestrito = (USED("cursor_4c_RestricaoProduto") AND ;
			RECCOUNT("cursor_4c_RestricaoProduto") > 0)

		IF USED("cursor_4c_RestricaoProduto")
			USE IN cursor_4c_RestricaoProduto
		ENDIF

		IF USED("cursor_4c_BuscaProduto")
			USE IN cursor_4c_BuscaProduto
		ENDIF

		loc_cSQL = "SELECT a.Cpros, a.Dpros, a.Dpro2s, a.Cunis, a.cUniPs," + ;
			" a.Situas, a.DtSituas, a.Cgrus, a.Mercs" + ;
			" FROM SigCdPro a"
		IF loc_lRestrito
			loc_cSQL = loc_cSQL + ;
				" INNER JOIN SigCdRpo b ON (a.Cgrus = b.Cgrus OR a.Mercs = b.Mercs)" + ;
				" AND b.Dopps = " + EscaparSQL(THIS.this_cDopes)
		ENDIF
		loc_cSQL = loc_cSQL + ;
			" WHERE a.DPros LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
			" ORDER BY a.Cpros, a.Cgrus"

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProduto")

		IF loc_nResultado < 0
			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
				"Falha na Conex" + CHR(227) + "o (SigCdPro)")
			RETURN
		ENDIF

		loc_cCodEscolhido  = ""
		loc_cDescEscolhida = ""
		loc_cDescritivo    = ""
		loc_cCunis         = ""
		loc_cCunips        = ""

		IF USED("cursor_4c_BuscaProduto") AND RECCOUNT("cursor_4c_BuscaProduto") > 0
			SELECT cursor_4c_BuscaProduto
			GO TOP
			LOCATE FOR ALLTRIM(UPPER(Dpros)) == UPPER(loc_cValor)

			IF !FOUND()
				*-- Busca exata falhou: picker sobre o cursor JA populado
				*-- (equivale ao fwBuscaInt do legado). Regra #50: sem aviso
				*-- e sem apagar o que o usuario digitou.
				THIS.AbrirBuscaProdutoItem()
				IF !EMPTY(THIS.this_cLookupCodigo) AND USED("cursor_4c_BuscaProduto")
					SELECT cursor_4c_BuscaProduto
					GO TOP
					LOCATE FOR ALLTRIM(Cpros) == ALLTRIM(THIS.this_cLookupCodigo)
				ENDIF
			ENDIF

			IF FOUND()
				loc_cCodEscolhido  = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Cpros, ""))
				loc_cDescEscolhida = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Dpros, ""))
				loc_cDescritivo    = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Dpro2s, ""))
				loc_cCunis         = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.Cunis, ""))
				loc_cCunips        = ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.cUniPs, ""))
			ENDIF
		ENDIF

		IF USED("cursor_4c_BuscaProduto")
			USE IN cursor_4c_BuscaProduto
		ENDIF

		SELECT (loc_cItens)
		IF !EMPTY(loc_cCodEscolhido)
			loc_oTxt.Value = loc_cDescEscolhida
			REPLACE cpros  WITH loc_cCodEscolhido, ;
				dpros  WITH loc_cDescEscolhida, ;
				dpro2s WITH IIF(EMPTY(ALLTRIM(TratarNulo(dpro2s, ""))), loc_cDescritivo, dpro2s), ;
				cunis  WITH loc_cCunis, ;
				cunips WITH loc_cCunips
			THIS.this_cAntDpros = loc_cDescEscolhida
		ENDIF

		THIS.grd_4c_Itens.Refresh()
	ENDPROC

	*==========================================================================
	* AbrirBuscaProdutoItem - picker do lookup de produto da celula
	* grd_4c_Itens.Column1 (legado: CreateObject([fwBuscaInt], [crTmpPro],
	* [Dpros], lcDPro, [Item], .t.) + os tres mAddColuna de DPros/CPros/
	* Dpro2s). Trabalha sobre cursor_4c_BuscaProduto, que o chamador JA
	* populou - mesmo contrato do fwBuscaInt legado, que recebe um cursor
	* local ja consultado.
	*
	* Devolve o par escolhido em this_cLookupCodigo/this_cLookupDescricao
	* (vazios quando o usuario cancelou - equivale ao "Lastkey() = 27" do
	* legado). Guarda de reentrancia porque o picker e MODAL (regra #37).
	*==========================================================================
	PROCEDURE AbrirBuscaProdutoItem()
		LOCAL loc_oBusca, loc_oErro

		THIS.this_cLookupCodigo    = ""
		THIS.this_cLookupDescricao = ""

		IF THIS.this_lEmLookupProduto OR !USED("cursor_4c_BuscaProduto")
			RETURN
		ENDIF
		THIS.this_lEmLookupProduto = .T.

		TRY
			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
			loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "Cpros", "Dpros", "Item")
			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
			loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")

			IF loc_oBusca.Mostrar()
				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
			ENDIF

			loc_oBusca.Release()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
				"Erro em Formsigoporc.AbrirBuscaProdutoItem")
		ENDTRY

		THIS.this_lEmLookupProduto = .F.
	ENDPROC

	*==========================================================================
	* AbrirBuscaUnidade - picker do lookup de unidade das celulas
	* grd_4c_Itens.Column4/Column6 (legado: CreateObject([fwBuscaInt],
	* [crTmpUni], [Dunis], lcDuni, [Unidade], .t.) + mAddColuna de DUnis e
	* CUnis). Trabalha sobre cursor_4c_TmpUnidade, que
	* ValidarUnidadeGenerica JA populou com SigCdUni.
	*
	* Devolve o par em this_cLookupCodigo/this_cLookupDescricao (vazios no
	* cancelamento). Guarda de reentrancia: o picker e MODAL (regra #37).
	*==========================================================================
	PROCEDURE AbrirBuscaUnidade()
		LOCAL loc_oBusca, loc_oErro

		THIS.this_cLookupCodigo    = ""
		THIS.this_cLookupDescricao = ""

		IF THIS.this_lEmLookupUnidade OR !USED("cursor_4c_TmpUnidade")
			RETURN
		ENDIF
		THIS.this_lEmLookupUnidade = .T.

		TRY
			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
			loc_oBusca.DefinirCursor("cursor_4c_TmpUnidade", "Cunis", "Dunis", "Unidade")
			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"

			IF loc_oBusca.Mostrar()
				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
			ENDIF

			loc_oBusca.Release()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
				"Erro em Formsigoporc.AbrirBuscaUnidade")
		ENDTRY

		THIS.this_lEmLookupUnidade = .F.
	ENDPROC

	*==========================================================================
	* AbrirBuscaAcabamento - picker do lookup de acabamento da celula
	* grd_4c_Itens.Column30 (legado: CreateObject([fwBuscaInt], [TmpCdAca],
	* [Descrs], Alltrim(this.Value), [Acabamento], .t.) + mAddColuna de
	* Descrs). Trabalha sobre cursor_4c_TmpAcabamento, que
	* ValidarAcabamentoKeyPress JA populou com SigCdAca.
	*
	* O legado declara apenas a coluna Descrs no picker; aqui o par
	* codigo/descricao e necessario porque e Cods que vai para codacabs -
	* a coluna de codigo entra junto (DefinirCursor exige as duas) e a
	* descricao continua sendo a chave visivel da escolha.
	*==========================================================================
	PROCEDURE AbrirBuscaAcabamento()
		LOCAL loc_oBusca, loc_oErro

		THIS.this_cLookupCodigo    = ""
		THIS.this_cLookupDescricao = ""

		IF THIS.this_lEmLookupAcabamento OR !USED("cursor_4c_TmpAcabamento")
			RETURN
		ENDIF
		THIS.this_lEmLookupAcabamento = .T.

		TRY
			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
			loc_oBusca.DefinirCursor("cursor_4c_TmpAcabamento", "Cods", "Descrs", "Acabamento")
			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"

			IF loc_oBusca.Mostrar()
				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
			ENDIF

			loc_oBusca.Release()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
				"Erro em Formsigoporc.AbrirBuscaAcabamento")
		ENDTRY

		THIS.this_lEmLookupAcabamento = .F.
	ENDPROC

	*==========================================================================
	* AbrirBuscaNovoGrupo - picker do lookup de Grupo de Produto do campo
	* txt_4c_NovoGrupo (legado get_NewGrp.Valid: CreateObject([fwBuscaInt],
	* [TmpCdGpr], [Cgrus], This.Value, [Grupos], .t.) + mAddColuna de
	* CGrus e DGrus). Trabalha sobre cursor_4c_BuscaGrupo, que
	* TxtNovoGrupoLostFocus JA populou - com a restricao de SigCdRpo e, se
	* ela nao devolver nada, com a lista inteira de SigCdGrp (fallback
	* transcrito do legado).
	*
	* A guarda de reentrancia desta familia (this_lEmLookupGrupo) e ligada
	* pelo CHAMADOR: este metodo nao a liga de novo, senao devolveria sem
	* abrir nada (regra #47 - o funil liga a flag UMA vez).
	*==========================================================================
	PROCEDURE AbrirBuscaNovoGrupo()
		LOCAL loc_oBusca, loc_oErro

		THIS.this_cLookupCodigo    = ""
		THIS.this_cLookupDescricao = ""

		IF !USED("cursor_4c_BuscaGrupo")
			RETURN
		ENDIF

		TRY
			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
			loc_oBusca.DefinirCursor("cursor_4c_BuscaGrupo", "Cgrus", "DGrus", ;
				"Grupo Para Cadastro de Produtos")
			loc_oBusca.this_aColunas[1, 3] = "Grupo"
			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"

			IF loc_oBusca.Mostrar()
				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
			ENDIF

			loc_oBusca.Release()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
				"Erro em Formsigoporc.AbrirBuscaNovoGrupo")
		ENDTRY
	ENDPROC

	*==========================================================================
	* VincularGradeItens - Liga grd_4c_Itens ao cursor de itens. SEPARADO de
	* ConfigurarGridItens de proposito: atribuir RecordSource RESETA
	* Column.Width e Column.Header1.Caption (regra #41 / Problema 48), entao
	* os dois tem de ser reaplicados DEPOIS de cada bind - e o bind acontece
	* mais de uma vez (toda vez que o cursor de itens e recriado pelo funil
	* CarregarDados). Ordem canonica: RecordSource -> ControlSource ->
	* Width -> Header1.Caption.
	*
	* O bind e CONDICIONADO a USED(cursor): instanciado sem cursor (harness de
	* teste), atribuir RecordSource estouraria "Alias is not found". Width e
	* Header1.Caption sao aplicados SEMPRE, com ou sem alias aberto - senao a
	* grade apareceria com cabecalho "Column1" e largura default.
	*==========================================================================
	PROTECTED PROCEDURE VincularGradeItens()
		LOCAL loc_cCursor
		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

		WITH THIS.grd_4c_Itens
			IF USED(loc_cCursor)
				.RecordSource = loc_cCursor

				.Column1.ControlSource = loc_cCursor + ".dpros"
				.Column2.ControlSource = loc_cCursor + ".dpro2s"
				.Column3.ControlSource = loc_cCursor + ".qtds"
				.Column4.ControlSource = loc_cCursor + ".dcunis"
				.Column5.ControlSource = loc_cCursor + ".pesos"
				.Column6.ControlSource = loc_cCursor + ".dcunips"
				.Column7.ControlSource = loc_cCursor + ".fators"
				.Column8.ControlSource = loc_cCursor + ".units"
				.Column9.ControlSource = loc_cCursor + ".totas"
				.Column10.ControlSource = loc_cCursor + ".tota1s"
				.Column11.ControlSource = loc_cCursor + ".tota2s"
				.Column12.ControlSource = loc_cCursor + ".tota3s"
				.Column13.ControlSource = loc_cCursor + ".tota4s"
				.Column14.ControlSource = loc_cCursor + ".tota5s"
				.Column15.ControlSource = loc_cCursor + ".tota6s"
				.Column16.ControlSource = loc_cCursor + ".obs"
				.Column17.ControlSource = loc_cCursor + ".tota7s"
				.Column18.ControlSource = loc_cCursor + ".tota8s"
				.Column19.ControlSource = loc_cCursor + ".tota9s"
				.Column20.ControlSource = loc_cCursor + ".tota10s"
				.Column21.ControlSource = loc_cCursor + ".notas"
				.Column22.ControlSource = loc_cCursor + ".perc4s"
				.Column23.ControlSource = loc_cCursor + ".perc5s"
				.Column24.ControlSource = loc_cCursor + ".perc6s"
				.Column25.ControlSource = loc_cCursor + ".perc2s"
				.Column26.ControlSource = loc_cCursor + ".perc3s"
				.Column27.ControlSource = loc_cCursor + ".servicos"
				.Column28.ControlSource = loc_cCursor + ".debitos"
				.Column29.ControlSource = loc_cCursor + ".taxas"
				.Column30.ControlSource = loc_cCursor + ".dacabs"
			ENDIF

			*-- Width/Header1.Caption SEMPRE depois do bind (RecordSource reseta
			*-- os dois para 90 / "Column<N>"). Transcritos do dump do legado.
			.Column1.Width           = 290
			.Column1.Header1.Caption = "Item"
			.Column2.Width           = 290
			.Column2.Header1.Caption = "Descritivo"
			.Column3.Width           = 122
			.Column3.Header1.Caption = "Quantidade"
			.Column4.Width           = 150
			.Column4.Header1.Caption = "Unidade"
			.Column5.Width           = 45
			.Column5.Header1.Caption = "Per" + CHR(237) + "odo"
			.Column6.Width           = 150
			.Column6.Header1.Caption = "Unidade"
			.Column7.Width           = 45
			.Column7.Header1.Caption = "Turno"
			.Column8.Width           = 122
			.Column8.Header1.Caption = "Unit" + CHR(225) + "rio"
			.Column9.Width           = 122
			.Column9.Header1.Caption = "Total"
			.Column10.Width           = 122
			.Column10.Header1.Caption = "Total NF SRCOM"
			.Column11.Width           = 122
			.Column11.Header1.Caption = "Total SRCOM Custos Internos"
			.Column12.Width           = 122
			.Column12.Header1.Caption = "Total Fornecedor"
			.Column13.Width           = 122
			.Column13.Header1.Caption = "ICMS"
			.Column14.Width           = 122
			.Column14.Header1.Caption = "Rouanet"
			.Column15.Width           = 122
			.Column15.Header1.Caption = "Outras"
			.Column16.Width           = 290
			.Column16.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
			.Column17.Width           = 122
			.Column17.Header1.Caption = "Real SRCOM Custos Internos"
			.Column18.Width           = 122
			.Column18.Header1.Caption = "Real Fornecedor"
			.Column19.Width           = 122
			.Column19.Header1.Caption = "Saldo Real SRCOM Custos Internos"
			.Column20.Width           = 122
			.Column20.Header1.Caption = "Saldo Real Fornecedor"
			*-- Column21: o dump do legado NAO declara Width (so no ramo P&G, com
			*-- Width = 0). Fixado no default 90 do VFP para que um rebind nao
			*-- altere a largura que a tela ja mostrava.
			.Column21.Width           = 90
			.Column21.Header1.Caption = "Nota"
			.Column22.Width           = 52
			.Column22.Header1.Caption = "%"
			.Column23.Width           = 52
			.Column23.Header1.Caption = "%"
			.Column24.Width           = 52
			.Column24.Header1.Caption = "%"
			.Column25.Width           = 52
			.Column25.Header1.Caption = "%"
			.Column26.Width           = 52
			.Column26.Header1.Caption = "%"
			.Column27.Width           = 17
			.Column27.Header1.Caption = "S"
			.Column28.Width           = 17
			.Column28.Header1.Caption = "D"
			.Column29.Width           = 22
			.Column29.Header1.Caption = "Fee"
			.Column30.Width           = 150
			.Column30.Header1.Caption = "Acabamento"
		ENDWITH

		*-- Reinstala as celulas de LOOKUP depois do bind: atribuir
		*-- RecordSource reseta Column.CurrentControl/Sparse/ReadOnly junto
		*-- com Width/Header1.Caption, e sem CurrentControl a coluna volta a
		*-- desenhar o Text1 nativo - o TextBox com o lookup existiria mas
		*-- nunca apareceria (regra #18), deixando a celula "sem lookup"
		*-- desde o primeiro recarregamento da grade.
		THIS.ReinstalarCelulasLookupItens()
	ENDPROC

	*==========================================================================
	* ReinstalarCelulasLookupItens - repoe CurrentControl/Sparse/ReadOnly das
	* quatro colunas de grd_4c_Itens que tem lookup (Column1 = produto,
	* Column4/Column6 = unidade, Column30 = acabamento). Chamado por
	* VincularGradeItens DEPOIS de cada bind.
	*
	* O TextBox de cada coluna e recriado quando nao existe mais: um rebind
	* que mexa em ColumnCount destroi os objetos de Column (regra #44), e
	* PEMSTATUS so devolve .T. enquanto o membro existe. O ReadOnly da
	* COLUNA vem DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve
	* (regra #46).
	*==========================================================================
	PROTECTED PROCEDURE ReinstalarCelulasLookupItens()
		LOCAL loc_lSoLeitura
		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")

		WITH THIS.grd_4c_Itens
			IF !PEMSTATUS(.Column1, "txt_4c_DescricaoItem", 5)
				.Column1.AddObject("txt_4c_DescricaoItem", "TextBox")
				.Column1.txt_4c_DescricaoItem.BorderStyle = 0
				.Column1.txt_4c_DescricaoItem.Margin      = 0
				.Column1.txt_4c_DescricaoItem.ForeColor   = RGB(0, 0, 0)
				.Column1.txt_4c_DescricaoItem.BackColor   = RGB(255, 255, 255)
				.Column1.txt_4c_DescricaoItem.MaxLength   = 65
				BINDEVENT(.Column1.txt_4c_DescricaoItem, "GotFocus", THIS, "GuardarAntDpros")
				BINDEVENT(.Column1.txt_4c_DescricaoItem, "KeyPress", THIS, "ValidarProdutoItemKeyPress")
			ENDIF
			.Column1.CurrentControl = "txt_4c_DescricaoItem"
			.Column1.Sparse         = .F.
			.Column1.ReadOnly       = loc_lSoLeitura

			IF !PEMSTATUS(.Column4, "txt_4c_UnidadeVenda", 5)
				.Column4.AddObject("txt_4c_UnidadeVenda", "TextBox")
				.Column4.txt_4c_UnidadeVenda.BorderStyle = 0
				.Column4.txt_4c_UnidadeVenda.Margin      = 0
				.Column4.txt_4c_UnidadeVenda.ForeColor   = RGB(0, 0, 0)
				.Column4.txt_4c_UnidadeVenda.BackColor   = RGB(255, 255, 255)
				.Column4.txt_4c_UnidadeVenda.MaxLength   = 20
				BINDEVENT(.Column4.txt_4c_UnidadeVenda, "GotFocus", THIS, "GuardarTagUnidadeVenda")
				BINDEVENT(.Column4.txt_4c_UnidadeVenda, "KeyPress", THIS, "ValidarUnidadeVendaKeyPress")
			ENDIF
			.Column4.CurrentControl = "txt_4c_UnidadeVenda"
			.Column4.Sparse         = .F.
			.Column4.ReadOnly       = loc_lSoLeitura

			IF !PEMSTATUS(.Column6, "txt_4c_UnidadePedido", 5)
				.Column6.AddObject("txt_4c_UnidadePedido", "TextBox")
				.Column6.txt_4c_UnidadePedido.BorderStyle = 0
				.Column6.txt_4c_UnidadePedido.Margin      = 0
				.Column6.txt_4c_UnidadePedido.ForeColor   = RGB(0, 0, 0)
				.Column6.txt_4c_UnidadePedido.BackColor   = RGB(255, 255, 255)
				.Column6.txt_4c_UnidadePedido.MaxLength   = 20
				BINDEVENT(.Column6.txt_4c_UnidadePedido, "GotFocus", THIS, "GuardarTagUnidadePedido")
				BINDEVENT(.Column6.txt_4c_UnidadePedido, "KeyPress", THIS, "ValidarUnidadePedidoKeyPress")
			ENDIF
			.Column6.CurrentControl = "txt_4c_UnidadePedido"
			.Column6.Sparse         = .F.
			.Column6.ReadOnly       = loc_lSoLeitura

			IF !PEMSTATUS(.Column30, "txt_4c_Acabamento", 5)
				.Column30.AddObject("txt_4c_Acabamento", "TextBox")
				.Column30.txt_4c_Acabamento.BorderStyle = 0
				.Column30.txt_4c_Acabamento.Margin      = 0
				.Column30.txt_4c_Acabamento.ForeColor   = RGB(0, 0, 0)
				.Column30.txt_4c_Acabamento.BackColor   = RGB(255, 255, 255)
				.Column30.txt_4c_Acabamento.MaxLength   = 20
				BINDEVENT(.Column30.txt_4c_Acabamento, "GotFocus", THIS, "GuardarTagAcabamento")
				BINDEVENT(.Column30.txt_4c_Acabamento, "KeyPress", THIS, "ValidarAcabamentoKeyPress")
			ENDIF
			.Column30.CurrentControl = "txt_4c_Acabamento"
			.Column30.Sparse         = .F.
			.Column30.ReadOnly       = loc_lSoLeitura
		ENDWITH
	ENDPROC

	*==========================================================================
	* CriarCursorParcelas - Cursor da grade de parcelas/previsoes de pagamento
	* (grd_4c_Parcelas), equivalente ao crSigMvOrp que o legado compartilha
	* com o form pai via troca de DataSession. Colunas conferidas em
	* docs\schema.sql (tabela SigMvOrp): cidchaves/citens/datas/dopes/
	* empdopnums/emps/numes/percs/valos/vlbaixas/borderos/ifors/valcreds.
	*
	* dfors NAO e coluna de SigMvOrp - e PROJECAO: o legado liga
	* grdParcela.Column6 a crSigMvOrp.Dfors, que e a razao social do
	* fornecedor (SigCdCli.RClis) trazida pelo join em Ifors. Fica vazia
	* ate a fase do BO que monta a consulta com o join.
	*
	* A ORDEM DOS CAMPOS deste CREATE CURSOR e a unica do form (regra
	* OPERACIONAL #2): qualquer outro ponto que venha a recriar o cursor
	* tem de chamar ESTE metodo, nunca repetir o CREATE CURSOR.
	*==========================================================================
	PROTECTED PROCEDURE CriarCursorParcelas()
		LOCAL loc_cCursor
		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas

		IF USED(loc_cCursor)
			USE IN (loc_cCursor)
		ENDIF

		SET NULL ON
		CREATE CURSOR (loc_cCursor) ;
			(cidchaves C(20), citens N(10,0), datas D, dopes C(29), ;
			 empdopnums C(29), emps C(3), numes N(6,0), percs N(5,2), ;
			 valos N(13,2), vlbaixas N(12,2), borderos N(10,0), ;
			 ifors C(10), valcreds N(13,2), dfors C(50))
		SET NULL OFF

		*-- Legado (fim do Init): Select crSigMvOrp / Set Order to / Set Order
		*-- to CItens - a grade de parcelas e sempre vista pela ordem do item,
		*-- porque e por essa chave que PosicionarParcelasDoItem filtra.
		INDEX ON citens TAG citens
	ENDPROC

	*==========================================================================
	* ConfigurarGradeParcelas - grd_4c_Parcelas, equivalente ao
	* SIGOPORC.grdParcela (7 colunas). Geometria/fonte/cor/ColumnOrder
	* TRANSCRITOS do dump ("PROPRIEDADES DE: SIGOPORC.grdParcela").
	*
	* Igual a grade de itens, aqui fica SO o que nao depende de dado;
	* RecordSource/ControlSource/Width/Header1.Caption vao em
	* VincularGradeParcelas().
	*
	* ReadOnly por coluna transcrito do Init legado ("With ThisForm.grdParcela"):
	* Column4 (Fornecedor), Column6 (Descricao) e Column7 (Credito) sao
	* ReadOnly = .T. SEMPRE - sao projecao/valor calculado, nao entrada; as
	* demais seguem o modo (CONSULTAR = somente leitura). O ReadOnly da
	* COLUNA vem DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve
	* (regra #46).
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarGradeParcelas()
		LOCAL loc_lSoLeitura
		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")

		THIS.AddObject("grd_4c_Parcelas", "Grid")

		*-- ColumnCount FORA do WITH (as Columns ainda nao existem dentro dele)
		THIS.grd_4c_Parcelas.ColumnCount = 7

		WITH THIS.grd_4c_Parcelas
			.Top          = 504
			.Left         = 6
			.Width        = 946
			.Height       = 92
			.FontName     = "Tahoma"
			.FontSize     = 8
			.ForeColor    = RGB(90, 90, 90)
			.HeaderHeight = 16
			.RowHeight    = 16
			.Panel        = 1
			.ScrollBars   = 3
			.DeleteMark   = .F.
			.RecordMark   = .F.
			.TabIndex     = 25
			.ReadOnly     = loc_lSoLeitura

			*-- Column1 (% - percs)
			.Column1.ColumnOrder       = 3
			.Column1.FontName          = "Tahoma"
			.Column1.FontSize          = 8
			.Column1.ForeColor         = RGB(90, 90, 90)
			.Column1.Header1.Alignment = 2
			.Column1.Header1.FontSize  = 8
			.Column1.ReadOnly          = loc_lSoLeitura

			*-- Column2 (Data - datas)
			.Column2.ColumnOrder       = 4
			.Column2.FontName          = "Tahoma"
			.Column2.FontSize          = 8
			.Column2.ForeColor         = RGB(90, 90, 90)
			.Column2.Header1.Alignment = 2
			.Column2.Header1.FontSize  = 8
			.Column2.ReadOnly          = loc_lSoLeitura

			*-- Column3 (Previsto - valos)
			.Column3.ColumnOrder       = 5
			.Column3.FontName          = "Tahoma"
			.Column3.FontSize          = 8
			.Column3.ForeColor         = RGB(90, 90, 90)
			.Column3.Header1.Alignment = 2
			.Column3.Header1.FontSize  = 8
			.Column3.ReadOnly          = loc_lSoLeitura

			*-- Column4 (Fornecedor - ifors) - ReadOnly fixo no legado
			.Column4.ColumnOrder       = 1
			.Column4.FontName          = "Tahoma"
			.Column4.FontSize          = 8
			.Column4.ForeColor         = RGB(90, 90, 90)
			.Column4.Header1.Alignment = 2
			.Column4.Header1.FontSize  = 8
			.Column4.ReadOnly          = .T.

			*-- Column5 (Realizado - vlbaixas)
			.Column5.ColumnOrder       = 6
			.Column5.FontName          = "Tahoma"
			.Column5.FontSize          = 8
			.Column5.ForeColor         = RGB(90, 90, 90)
			.Column5.Header1.Alignment = 2
			.Column5.Header1.FontSize  = 8
			.Column5.ReadOnly          = loc_lSoLeitura

			*-- Column6 (Descricao do fornecedor - dfors) - ReadOnly fixo
			.Column6.ColumnOrder       = 2
			.Column6.FontName          = "Tahoma"
			.Column6.FontSize          = 8
			.Column6.ForeColor         = RGB(90, 90, 90)
			.Column6.Header1.Alignment = 2
			.Column6.Header1.FontSize  = 8
			.Column6.ReadOnly          = .T.

			*-- Column7 (Credito - valcreds) - ReadOnly fixo. O dump nao
			*-- declara ColumnOrder desta coluna (fica na ordem natural, 7).
			.Column7.FontName          = "Tahoma"
			.Column7.FontSize          = 8
			.Column7.ForeColor         = RGB(90, 90, 90)
			.Column7.Header1.Alignment = 2
			.Column7.Header1.FontSize  = 8
			.Column7.ReadOnly          = .T.

			.Visible = .T.
		ENDWITH
	ENDPROC

	*==========================================================================
	* VincularGradeParcelas - Liga grd_4c_Parcelas ao cursor de parcelas.
	* Mesmo motivo da separacao em VincularGradeItens: RecordSource reseta
	* Width/Header1.Caption, entao os dois vem DEPOIS do bind e sao
	* aplicados SEMPRE, com ou sem alias aberto. Bind condicionado a
	* USED(cursor) para nao estourar "Alias is not found" no harness.
	* ControlSource transcrito do Init legado ("With ThisForm.grdParcela").
	*==========================================================================
	PROTECTED PROCEDURE VincularGradeParcelas()
		LOCAL loc_cCursor
		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas

		WITH THIS.grd_4c_Parcelas
			IF USED(loc_cCursor)
				.RecordSource = loc_cCursor

				.Column1.ControlSource = loc_cCursor + ".percs"
				.Column2.ControlSource = loc_cCursor + ".datas"
				.Column3.ControlSource = loc_cCursor + ".valos"
				.Column4.ControlSource = loc_cCursor + ".ifors"
				.Column5.ControlSource = loc_cCursor + ".vlbaixas"
				.Column6.ControlSource = loc_cCursor + ".dfors"
				.Column7.ControlSource = loc_cCursor + ".valcreds"
			ENDIF

			*-- Width/Header1.Caption SEMPRE depois do bind. Transcritos do
			*-- dump (PROPRIEDADES DE: SIGOPORC.grdParcela + o Header1 de cada
			*-- Column no layout do legado).
			.Column1.Width           = 70
			.Column1.Header1.Caption = "%"
			.Column2.Width           = 70
			.Column2.Header1.Caption = "Data"
			.Column3.Width           = 122
			.Column3.Header1.Caption = "Previsto"
			.Column4.Width           = 80
			.Column4.Header1.Caption = "Fornecedor"
			.Column5.Width           = 122
			.Column5.Header1.Caption = "Realizado"
			.Column6.Width           = 290
			.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
			.Column7.Width           = 122
			.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
		ENDWITH
	ENDPROC

	*==========================================================================
	* ConfigurarBotoesParcelas - btnIncluirp/btnExcluirp do legado (fwbtnp,
	* standalone, SOMENTE ICONE - Caption = "" no dump). Top/Left/Picture/
	* ToolTipText TRANSCRITOS do dump; fwbtnp mede 40x40 (medido no VFP9 e
	* ja registrado em FormSigOpLoc.prg), o que confere com o espacamento
	* de 40px entre os dois (Top 516 e 556).
	*
	* Botao SO-ICONE nunca recebe .Enabled = .F.: com Caption vazio o VFP9
	* deixa de desenhar o Picture e o botao vira um retangulo vazio (regra
	* do CorretorAutomatico #106). O "When" do legado
	* (Inlist(Op_Escolha,[INSERIR],[ALTERAR])) virou guarda no inicio do
	* proprio handler - BINDEVENT descarta o retorno do delegate, entao um
	* When ligado por BINDEVENT nao bloquearia nada.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarBotoesParcelas()
		THIS.AddObject("cmd_4c_IncluirParcela", "CommandButton")
		WITH THIS.cmd_4c_IncluirParcela
			.Top             = 516
			.Left            = 954
			.Height          = 40
			.Width           = 40
			.Caption         = ""
			.ToolTipText     = "Inserir linha"
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
			.TabIndex        = 26
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_IncluirParcela, "Click", THIS, "BtnIncluirParcelaClick")

		THIS.AddObject("cmd_4c_ExcluirParcela", "CommandButton")
		WITH THIS.cmd_4c_ExcluirParcela
			.Top             = 556
			.Left            = 954
			.Height          = 40
			.Width           = 40
			.Caption         = ""
			.ToolTipText     = "Exclui linha"
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
			.TabIndex        = 28
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_ExcluirParcela, "Click", THIS, "BtnExcluirParcelaClick")
	ENDPROC

	*==========================================================================
	* BtnIncluirParcelaClick - legado SIGOPORC.btnIncluirp.Click. Insere uma
	* parcela/previsao em branco para o ITEM CORRENTE da grade de itens.
	*
	* As tres condicoes do legado sao regra de negocio e vao transcritas
	* juntas (regra #21b): a parcela so existe para item NORMAL - nao para
	* linha de subtotal (Citens = Citem2), nao para item sem produto
	* (Empty(Cpros)) e nao para linha de marcador (cBlocos IN SUBTOTAL/
	* BRANCO/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/TOTALGERAL).
	*
	* Emps/Dopes/Numes vem das properties do form (equivalentes a
	* TprMvCab.Emps/Dopes/Numes do legado, que chegavam pela DataSession
	* compartilhada). Igual ao legado, a persistencia em SigMvOrp acontece
	* so na confirmacao do dialogo - aqui so o cursor e alterado.
	*==========================================================================
	PROCEDURE BtnIncluirParcelaClick()
		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_lPodeIncluir

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

		IF !USED(loc_cItens) OR !USED(loc_cParcelas) OR EOF(loc_cItens)
			RETURN
		ENDIF

		THIS.LockScreen = .T.

		SELECT (loc_cItens)
		loc_lPodeIncluir = (citens <> citem2) AND !EMPTY(cpros) AND ;
			!INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", ;
				"TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
		loc_nItem = citens

		IF loc_lPodeIncluir
			INSERT INTO (loc_cParcelas) ;
				(emps, dopes, numes, citens, datas, valos, vlbaixas) ;
				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
					loc_nItem, CTOD(""), 0, 0)

			SELECT (loc_cParcelas)
			GO BOTTOM
		ENDIF

		THIS.grd_4c_Parcelas.Refresh()
		THIS.LockScreen = .F.

		*-- Legado: thisform.grdParcela.column4.SetFocus()
		THIS.grd_4c_Parcelas.Column4.SetFocus()
	ENDPROC

	*==========================================================================
	* BtnExcluirParcelaClick - legado SIGOPORC.btnExcluirp.Click. Exclui a
	* parcela corrente, recusando a exclusao quando ela JA FOI BAIXADA
	* (VlBaixas preenchido) - a regra e a mensagem sao do legado.
	*
	* O legado usa "Return .f." dentro do IF; aqui a estrutura e IF/ELSE,
	* que produz o mesmo efeito sem RETURN no meio do metodo.
	*==========================================================================
	PROCEDURE BtnExcluirParcelaClick()
		LOCAL loc_cParcelas

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

		IF !USED(loc_cParcelas)
			RETURN
		ENDIF

		SELECT (loc_cParcelas)

		IF !EMPTY(vlbaixas)
			*-- Legado: "A parcela ja joi autorizada!" - o "joi" e erro de
			*-- digitacao do original, visivel ao usuario; aqui sai "foi",
			*-- sem mudar o sentido da mensagem.
			MsgAviso("A parcela j" + CHR(225) + " foi autorizada!", ;
				"Imposs" + CHR(237) + "vel excluir")
		ELSE
			THIS.LockScreen = .T.

			IF !EOF(loc_cParcelas)
				DELETE
				GO TOP
			ENDIF

			THIS.grd_4c_Parcelas.Refresh()
			THIS.LockScreen = .F.

			*-- Legado: thisform.grdParcela.column1.SetFocus()
			THIS.grd_4c_Parcelas.Column1.SetFocus()
		ENDIF
	ENDPROC

	*==========================================================================
	* ConfigurarCamposPercentuais - Shape4 (moldura decorativa) + os 6
	* campos de percentual do cabecalho (say5/getPmargem .. Say6/
	* getPservico do legado). TRANSCRITOS do dump (bloco "PROPRIEDADES
	* DE: SIGOPORC.<nome>"), pareados por proximidade de Top (label.Top =
	* textbox.Top + 3, conferido um a um):
	*
	*   Say5 "Margem :...%"            (96)  <-> getPmargem      (93)  - SEM ControlSource; When sempre .F. (resultado calculado por TotalizarItn, nunca digitado)
	*   say4 "Contingente :...%"       (116) <-> getPtax2        (113) - ControlSource = TprMvCab.ptax2s (Perc1s)
	*   say1 "Ta\<xa Adm. :...%"       (136) <-> getPtaxa        (133) - ControlSource = TprMvCab.descs  (Perc2s)
	*   Say3 "BV :...%"                (156) <-> getPTax1        (153) - ControlSource = TprMvCab.ptax1s (Perc3s)
	*   say2 "Im\<posto :...%"         (176) <-> getPimposto     (173) - ControlSource = TprMvCab.acres  (Perc4s, item nao-servico)
	*   Say6 "Imposto sem ISS :...%"   (196) <-> getPservico     (193) - ControlSource = TprMvCab.ptax3s (Perc4s, item servico)
	*
	* Nenhum dos 5 TextBoxes editaveis usa ControlSource aqui: TprMvCab e
	* cursor do FORM PAI no legado (nao existe neste dialogo), e os 5
	* valores correspondentes (this_nPTax2s/this_nDescs/this_nPTax1s/
	* this_nAcres/this_nPTax3s) sao escalares do BO, repassados uma unica
	* vez na abertura (nao mudam por item) - a sincronizacao e manual
	* (.Value lido/escrito direto), igual ao padrao ja usado para
	* this_cEmps/this_cDopes/etc.
	*
	* SIMPLIFICACAO DOCUMENTADA: o legado guarda This.PEAntValue (property
	* da classe fwget) e so executa a cascata de Replace quando
	* "this.Value <> this.peantvalue" (evita reprocessar se o usuario so
	* passou pelo campo sem alterar). Como a cascata e IDEMPOTENTE (mesmo
	* valor de entrada sempre produz o mesmo resultado), replicar esse
	* guard exigiria 5 handlers de GotFocus extras so para guardar o
	* valor anterior em .Tag - trocado aqui por executar a cascata sempre
	* que o valor NAO esta vazio, no Enter/Tab (regra "BINDEVENT Valid nao
	* funciona em TextBox - usar KeyPress ENTER/TAB"). Resultado final
	* identico; custo e, no maximo, um SCAN redundante quando o usuario
	* nao mudou o valor.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarCamposPercentuais()
		LOCAL loc_lPodeEditar
		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

		THIS.AddObject("shp_4c_Painel", "Shape")
		WITH THIS.shp_4c_Painel
			.Top          = 106
			.Left         = 577
			.Height       = 93
			.Width        = 163
			.BackStyle    = 0
			.BorderWidth  = 2
			.SpecialEffect = 0
			.BorderColor  = RGB(90, 90, 90)
			.Visible      = .T.
		ENDWITH

		*-- Margem (resultado calculado - sempre desabilitado, destaque amarelo)
		THIS.AddObject("lbl_4c_Margem", "Label")
		WITH THIS.lbl_4c_Margem
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Alignment = 1
			.AutoSize  = .F.
			.Caption   = "Margem :                     %"
			.Top       = 96
			.Left      = 261
			.Width     = 192
			.Height    = 15
			.ForeColor = RGB(90, 90, 90)
			.Visible   = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Margem", "TextBox")
		WITH THIS.txt_4c_Margem
			.Top           = 93
			.Left          = 380
			.Width         = 59
			.Height        = 21
			.Alignment     = 3
			.FontBold      = .T.
			.Format        = "K"
			.InputMask     = "999.99"
			.Margin        = 0
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.BackColor     = RGB(255, 255, 128)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = 0
			.ReadOnly      = .T.
			.Enabled       = .F.
			.Visible       = .T.
		ENDWITH

		*-- Contingente (Perc1s - TprMvCab.Ptax2s)
		THIS.AddObject("lbl_4c_Contingente", "Label")
		WITH THIS.lbl_4c_Contingente
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Alignment = 1
			.AutoSize  = .F.
			.Caption   = "Contingente :                     %"
			.Top       = 116
			.Left      = 261
			.Width     = 192
			.Height    = 15
			.ForeColor = RGB(90, 90, 90)
			.Visible   = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Contingente", "TextBox")
		WITH THIS.txt_4c_Contingente
			.Top           = 113
			.Left          = 380
			.Width         = 59
			.Height        = 21
			.Alignment     = 3
			.Format        = "K"
			.InputMask     = "999.99"
			.Margin        = 0
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = THIS.this_oBusinessObject.this_nPTax2s
			.Enabled       = loc_lPodeEditar
			.Visible       = .T.
		ENDWITH
		BINDEVENT(THIS.txt_4c_Contingente, "KeyPress", THIS, "TxtContingenteKeyPress")

		*-- Taxa Adm. (Perc2s - TprMvCab.Descs)
		THIS.AddObject("lbl_4c_TaxaAdm", "Label")
		WITH THIS.lbl_4c_TaxaAdm
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Alignment = 1
			.AutoSize  = .F.
			.Caption   = "Ta\<xa Adm. :                     %"
			.Top       = 136
			.Left      = 261
			.Width     = 192
			.Height    = 15
			.ForeColor = RGB(90, 90, 90)
			.Visible   = .T.
		ENDWITH

		THIS.AddObject("txt_4c_TaxaAdm", "TextBox")
		WITH THIS.txt_4c_TaxaAdm
			.Top           = 133
			.Left          = 380
			.Width         = 59
			.Height        = 21
			.Alignment     = 3
			.Format        = "K"
			.InputMask     = "999.99"
			.Margin        = 0
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = THIS.this_oBusinessObject.this_nDescs
			.Enabled       = loc_lPodeEditar
			.Visible       = .T.
		ENDWITH
		BINDEVENT(THIS.txt_4c_TaxaAdm, "KeyPress", THIS, "TxtTaxaAdmKeyPress")

		*-- BV (Perc3s - TprMvCab.Ptax1s)
		THIS.AddObject("lbl_4c_BV", "Label")
		WITH THIS.lbl_4c_BV
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Alignment = 1
			.AutoSize  = .F.
			.Caption   = "BV :                     %"
			.Top       = 156
			.Left      = 261
			.Width     = 192
			.Height    = 15
			.ForeColor = RGB(90, 90, 90)
			.Visible   = .T.
		ENDWITH

		THIS.AddObject("txt_4c_BV", "TextBox")
		WITH THIS.txt_4c_BV
			.Top           = 153
			.Left          = 380
			.Width         = 59
			.Height        = 21
			.Alignment     = 3
			.Format        = "K"
			.InputMask     = "999.99"
			.Margin        = 0
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = THIS.this_oBusinessObject.this_nPTax1s
			.Enabled       = loc_lPodeEditar
			.Visible       = .T.
		ENDWITH
		BINDEVENT(THIS.txt_4c_BV, "KeyPress", THIS, "TxtBVKeyPress")

		*-- Imposto cheio (Perc4s quando item NAO e servico - TprMvCab.Acres)
		THIS.AddObject("lbl_4c_Imposto", "Label")
		WITH THIS.lbl_4c_Imposto
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Alignment = 1
			.AutoSize  = .F.
			.Caption   = "Im\<posto :                     %"
			.Top       = 176
			.Left      = 261
			.Width     = 192
			.Height    = 15
			.ForeColor = RGB(90, 90, 90)
			.Visible   = .T.
		ENDWITH

		THIS.AddObject("txt_4c_Imposto", "TextBox")
		WITH THIS.txt_4c_Imposto
			.Top           = 173
			.Left          = 380
			.Width         = 59
			.Height        = 21
			.Alignment     = 3
			.Format        = "K"
			.InputMask     = "999.99"
			.Margin        = 0
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = THIS.this_oBusinessObject.this_nAcres
			.Enabled       = loc_lPodeEditar
			.Visible       = .T.
		ENDWITH
		BINDEVENT(THIS.txt_4c_Imposto, "KeyPress", THIS, "TxtImpostoKeyPress")

		*-- Imposto sem ISS (Perc4s quando item E servico - TprMvCab.Ptax3s)
		THIS.AddObject("lbl_4c_ImpostoServico", "Label")
		WITH THIS.lbl_4c_ImpostoServico
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Alignment = 1
			.AutoSize  = .F.
			.Caption   = "Imposto sem ISS :                     %"
			.Top       = 196
			.Left      = 260
			.Width     = 192
			.Height    = 15
			.ForeColor = RGB(90, 90, 90)
			.Visible   = .T.
		ENDWITH

		THIS.AddObject("txt_4c_ImpostoServico", "TextBox")
		WITH THIS.txt_4c_ImpostoServico
			.Top           = 193
			.Left          = 380
			.Width         = 59
			.Height        = 21
			.Alignment     = 3
			.Format        = "K"
			.InputMask     = "999.9999"
			.Margin        = 0
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = THIS.this_oBusinessObject.this_nPTax3s
			.Enabled       = loc_lPodeEditar
			.Visible       = .T.
		ENDWITH
		BINDEVENT(THIS.txt_4c_ImpostoServico, "KeyPress", THIS, "TxtImpostoServicoKeyPress")
	ENDPROC

	*==========================================================================
	* TxtContingenteKeyPress - legado SIGOPORC.getPtax2.Valid. Perc1s
	* ("Contingente") - aplicado em TODOS os itens quando P&G.
	*==========================================================================
	PROCEDURE TxtContingenteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cItens, loc_nItens, loc_nValor

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF
		IF EMPTY(THIS.txt_4c_Contingente.Value)
			RETURN
		ENDIF

		loc_nValor = THIS.txt_4c_Contingente.Value
		THIS.this_oBusinessObject.this_nPTax2s = loc_nValor

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
			SELECT (loc_cItens)
			loc_nItens = citens
			SCAN
				REPLACE perc1s WITH loc_nValor, ;
					tota1s WITH (totas * loc_nValor) / 100, ;
					tota2s WITH ((totas + tota1s) * perc2s) / 100, ;
					tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
			ENDSCAN
			= SEEK(loc_nItens, loc_cItens, "citens")
		ENDIF

		THIS.TotalizarItn()
	ENDPROC

	*==========================================================================
	* TxtTaxaAdmKeyPress - legado SIGOPORC.getPtaxa.Valid. Perc2s
	* ("Taxa Adm./Lucro") quando P&G; quando SRCOM, aplica Perc1s/Perc2s/
	* Perc3s so na linha de bloco TAXA (fee da produtora).
	*==========================================================================
	PROCEDURE TxtTaxaAdmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cItens, loc_nItens, loc_nValor

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF
		IF EMPTY(THIS.txt_4c_TaxaAdm.Value)
			RETURN
		ENDIF

		loc_nValor = THIS.txt_4c_TaxaAdm.Value
		THIS.this_oBusinessObject.this_nDescs = loc_nValor

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF USED(loc_cItens)
			SELECT (loc_cItens)
			loc_nItens = citens

			IF THIS.this_oBusinessObject.this_nDivNotas = 2
				SCAN
					REPLACE perc2s WITH loc_nValor, ;
						tota2s WITH ((totas + tota1s) * loc_nValor) / 100, ;
						tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
						tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
						tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
				ENDSCAN
			ELSE
				GO TOP
				LOCATE FOR ALLTRIM(cblocos) == "TAXA"
				IF FOUND()
					REPLACE perc1s WITH loc_nValor, perc2s WITH loc_nValor, perc3s WITH loc_nValor
				ENDIF
			ENDIF

			= SEEK(loc_nItens, loc_cItens, "citens")
		ENDIF

		THIS.TotalizarItn()
	ENDPROC

	*==========================================================================
	* TxtBVKeyPress - legado SIGOPORC.getPTax1.Valid. Perc3s ("BV") -
	* aplicado em TODOS os itens quando P&G.
	*==========================================================================
	PROCEDURE TxtBVKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cItens, loc_nItens, loc_nValor

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF
		IF EMPTY(THIS.txt_4c_BV.Value)
			RETURN
		ENDIF

		loc_nValor = THIS.txt_4c_BV.Value
		THIS.this_oBusinessObject.this_nPTax1s = loc_nValor

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
			SELECT (loc_cItens)
			loc_nItens = citens
			SCAN
				REPLACE perc3s WITH loc_nValor, ;
					tota3s WITH ((totas + tota1s + tota2s) * loc_nValor) / 100, ;
					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
			ENDSCAN
			= SEEK(loc_nItens, loc_cItens, "citens")
		ENDIF

		THIS.TotalizarItn()
	ENDPROC

	*==========================================================================
	* TxtImpostoKeyPress - legado SIGOPORC.getPimposto.Valid. Perc4s
	* (imposto cheio) - aplicado em TODOS os itens quando P&G.
	*==========================================================================
	PROCEDURE TxtImpostoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cItens, loc_nItens, loc_nValor

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF
		IF EMPTY(THIS.txt_4c_Imposto.Value)
			RETURN
		ENDIF

		loc_nValor = THIS.txt_4c_Imposto.Value
		THIS.this_oBusinessObject.this_nAcres = loc_nValor

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
			SELECT (loc_cItens)
			loc_nItens = citens
			SCAN
				REPLACE perc4s WITH loc_nValor, ;
					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
			ENDSCAN
			= SEEK(loc_nItens, loc_cItens, "citens")
		ENDIF

		THIS.TotalizarItn()
	ENDPROC

	*==========================================================================
	* TxtImpostoServicoKeyPress - legado SIGOPORC.getPservico.Valid.
	* Perc4s (imposto, variante "sem ISS") - aplicado SO nos itens
	* marcados como Servicos, quando P&G.
	*==========================================================================
	PROCEDURE TxtImpostoServicoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cItens, loc_nItens, loc_nValor

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF
		IF EMPTY(THIS.txt_4c_ImpostoServico.Value)
			RETURN
		ENDIF

		loc_nValor = THIS.txt_4c_ImpostoServico.Value
		THIS.this_oBusinessObject.this_nPTax3s = loc_nValor

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
			SELECT (loc_cItens)
			loc_nItens = citens
			SCAN FOR servicos
				REPLACE perc4s WITH loc_nValor, ;
					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
			ENDSCAN
			= SEEK(loc_nItens, loc_cItens, "citens")
		ENDIF

		THIS.TotalizarItn()
	ENDPROC

	*==========================================================================
	* TotalizarItn - legado SIGOPORC.TotalizarItn. Motor de calculo
	* chamado por calc_valite (fase posterior) e pelos 5 campos de
	* percentual (acima). TRANSCRITO LITERALMENTE do dump
	* (PROCEDURE totalizaritn): consolida Tota1s..Tota10s do item
	* corrente (P&G ou SRCOM), depois os subtotais por bloco (Citem2),
	* sub-bloco (Citem3) e total geral (TOTALGERAL/Decupagem), e por fim
	* propaga o resultado para as parcelas do item (crSigMvOrp/
	* cursor_4c_Parcelas) via Valos.
	*
	* As linhas marcadoras (SUBTOTAL/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/
	* TOTALGERAL) ainda nao sao criadas nesta fase (btnInsBlo/btnInsSub -
	* Fase 6): os LOCATE que as procuram nao encontram nada e os blocos
	* protegidos por "IF !EOF()"/"IF FOUND()" (que e exatamente como o
	* legado guarda esses trechos) ficam no-op em silencio, sem erro -
	* comportamento seguro e idempotente ate essas linhas existirem.
	*
	* perc1s..perc6s sao campos de TRABALHO do cursor (nao existem na
	* tabela SigMvOrc - ver comentario de CriarCursorItens); so
	* Tota1s..Tota10s sao persistidos pelo BO.
	*==========================================================================
	PROTECTED PROCEDURE TotalizarItn()
		LOCAL loc_cItens, loc_cParcelas, loc_nItens, loc_nItem2, loc_nItem3, loc_nItAgr, loc_nTaxa1, loc_nTaxa2, loc_nTaxa3, loc_nImpo1, loc_nImpo2, loc_nImpo3, loc_nSubtot

		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

		IF !USED(loc_cItens) OR EOF(loc_cItens)
			RETURN
		ENDIF

		THIS.LockScreen = .T.

		SELECT (loc_cItens)
		loc_nItens = citens
		loc_nItem2 = citem2
		loc_nItem3 = citem3
		loc_nItAgr = citagrs

		IF THIS.this_oBusinessObject.this_nDivNotas = 2
			*-- P&G
			REPLACE tota1s WITH IIF(perc1s = 0, tota1s, (totas * perc1s) / 100), ;
				tota2s WITH IIF(perc2s = 0, tota2s, ((totas + tota1s) * perc2s) / 100), ;
				tota3s WITH IIF(perc3s = 0, tota3s, ((totas + tota1s + tota2s) * perc3s) / 100)
			REPLACE tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s))
			REPLACE tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
		ELSE
			*-- SRCOM: total dos valores de NF SRCOM e fornecedor
			IF EMPTY(perc2s) AND EMPTY(perc3s)
				REPLACE tota1s WITH totas, tota2s WITH 0, tota3s WITH 0
			ELSE
				REPLACE tota1s WITH 0, tota2s WITH (perc2s * totas) / 100, tota3s WITH (perc3s * totas) / 100
			ENDIF

			*-- Incentivos conforme o percentual informado
			REPLACE tota4s WITH (totas * perc4s) / 100, tota5s WITH (totas * perc5s) / 100, tota6s WITH (totas * perc6s) / 100
			*-- Saldo real SRCOM custos internos / fornecedor
			REPLACE tota9s WITH IIF(!EMPTY(tota1s), tota1s - tota8s, tota2s) - tota7s, ;
				tota10s WITH IIF(!EMPTY(tota1s), 0, tota3s - tota8s)

			IF INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cConfigGers, 192, 1))) = 1
				*-- Decupagem
				GO TOP
				SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
						SUM(tota7s) AS tota7s, SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
					FROM (loc_cItens) WHERE citagrs = IIF(!EMPTY(loc_nItAgr), loc_nItAgr, loc_nItens) ;
					INTO CURSOR cursor_4c_TmpTotBlo

				IF !EOF("cursor_4c_TmpTotBlo") AND !EMPTY(cursor_4c_TmpTotBlo.totas)
					SELECT (loc_cItens)
					= SEEK(IIF(!EMPTY(loc_nItAgr), loc_nItAgr, loc_nItens), loc_cItens, "citens")

					REPLACE tota9s WITH IIF(!EMPTY(tota1s), tota1s - tota8s, tota2s) - tota7s, ;
						tota10s WITH IIF(!EMPTY(tota1s), 0, tota3s - tota8s)

					REPLACE tota9s WITH tota9s - cursor_4c_TmpTotBlo.tota7s, ;
						tota10s WITH tota10s - cursor_4c_TmpTotBlo.tota8s
				ENDIF
			ENDIF
		ENDIF

		SELECT (loc_cItens)
		GO TOP

		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
			FROM (loc_cItens) ;
			WHERE citem2 = loc_nItem2 AND !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
			GROUP BY citem2 INTO CURSOR cursor_4c_TmpTotBlo

		SELECT (loc_cItens)
		GO TOP
		LOCATE FOR citem2 = loc_nItem2 AND ALLTRIM(cblocos) == "SUBTOTAL"
		IF FOUND()
			REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
				tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
				tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
				tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
				tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
				tota10s WITH cursor_4c_TmpTotBlo.tota10s
		ENDIF

		SELECT (loc_cItens)
		GO TOP

		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
			FROM (loc_cItens) ;
			WHERE citem3 = loc_nItem3 AND !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
			GROUP BY citem3 INTO CURSOR cursor_4c_TmpTotBlo

		SELECT (loc_cItens)
		GO TOP
		LOCATE FOR citem3 = loc_nItem3 AND ALLTRIM(cblocos) == "SUBTOTAL" AND citens = citem2
		IF FOUND()
			REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
				tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
				tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
				tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
				tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
				tota10s WITH cursor_4c_TmpTotBlo.tota10s
		ENDIF

		SELECT (loc_cItens)
		GO TOP

		SELECT SUM(totas) AS totas, SUM(tota1s) AS tota1s, SUM(tota2s) AS tota2s, SUM(tota3s) AS tota3s, ;
				SUM(IIF(taxas, tota1s, 0)) AS tota1ts, SUM(IIF(taxas, tota2s, 0)) AS tota2ts, SUM(IIF(taxas, tota3s, 0)) AS tota3ts, ;
				SUM(tota4s) AS tota4s, SUM(tota5s) AS tota5s, SUM(tota6s) AS tota6s, SUM(tota7s) AS tota7s, ;
				SUM(tota8s) AS tota8s, SUM(tota9s) AS tota9s, SUM(tota10s) AS tota10s ;
			FROM (loc_cItens) ;
			WHERE !INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
			INTO CURSOR cursor_4c_TmpTotBlo

		IF THIS.this_oBusinessObject.this_nDivNotas = 2
			SELECT (loc_cItens)
			GO TOP
			LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
			IF FOUND() AND !EMPTY(cursor_4c_TmpTotBlo.totas)
				REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
					tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
					tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
					tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
					tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
					tota10s WITH cursor_4c_TmpTotBlo.tota10s

				THIS.txt_4c_Margem.Value = ((tota1s + tota2s) / tota5s) * 100
			ENDIF
		ELSE
			SELECT (loc_cItens)
			GO TOP
			LOCATE FOR ALLTRIM(cblocos) == "SUBTOTAIS"
			IF FOUND()
				REPLACE totas WITH cursor_4c_TmpTotBlo.totas, tota1s WITH cursor_4c_TmpTotBlo.tota1s, ;
					tota2s WITH cursor_4c_TmpTotBlo.tota2s, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
					tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
					tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
					tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
					tota10s WITH cursor_4c_TmpTotBlo.tota10s

				loc_nSubtot = tota1s

				*-- Avanca para a linha de TAXA (fee da produtora), imediatamente
				*-- apos o SUBTOTAIS - mesma premissa posicional do legado
				SKIP
				loc_nTaxa1 = IIF(perc1s = 0, 0, (cursor_4c_TmpTotBlo.tota1ts * perc1s) / 100)
				loc_nTaxa2 = IIF(perc2s = 0, 0, (cursor_4c_TmpTotBlo.tota2ts * perc2s) / 100)
				loc_nTaxa3 = IIF(perc3s = 0, 0, (cursor_4c_TmpTotBlo.tota3ts * perc3s) / 100)
				REPLACE tota1s WITH loc_nTaxa1, tota2s WITH loc_nTaxa2, tota3s WITH loc_nTaxa3

				*-- Avanca para o TOTAL = SUBTOTAIS + TAXA
				SKIP
				REPLACE tota1s WITH cursor_4c_TmpTotBlo.tota1s + loc_nTaxa1, tota2s WITH cursor_4c_TmpTotBlo.tota2s + loc_nTaxa2, tota3s WITH cursor_4c_TmpTotBlo.tota3s, ;
					tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
					tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
					tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
					tota10s WITH cursor_4c_TmpTotBlo.tota10s

				loc_nImpo1 = IIF(THIS.txt_4c_Imposto.Value = 0, 0, ((cursor_4c_TmpTotBlo.tota1s + loc_nTaxa1) * THIS.txt_4c_Imposto.Value) / 100)
				loc_nImpo2 = IIF(THIS.txt_4c_Imposto.Value = 0, 0, ((cursor_4c_TmpTotBlo.tota2s + loc_nTaxa2) * THIS.txt_4c_Imposto.Value) / 100)
				*-- Total Fornecedor: o imposto e apenas sobre o FEE da produtora
				loc_nImpo3 = IIF(THIS.txt_4c_Imposto.Value = 0, 0, (loc_nTaxa3 * THIS.txt_4c_Imposto.Value) / 100)

				*-- Avanca para o IMPOSTO
				SKIP
				REPLACE tota1s WITH loc_nImpo1, tota2s WITH loc_nImpo2, tota3s WITH loc_nImpo3

				*-- Avanca para o TOTAL GERAL
				SKIP
				REPLACE tota1s WITH cursor_4c_TmpTotBlo.tota1s + loc_nTaxa1 + loc_nImpo1, ;
					tota2s WITH cursor_4c_TmpTotBlo.tota2s + loc_nTaxa2 + loc_nImpo2, ;
					tota3s WITH cursor_4c_TmpTotBlo.tota3s + loc_nTaxa3 + loc_nImpo3, ;
					tota4s WITH cursor_4c_TmpTotBlo.tota4s, tota5s WITH cursor_4c_TmpTotBlo.tota5s, ;
					tota6s WITH cursor_4c_TmpTotBlo.tota6s, tota7s WITH cursor_4c_TmpTotBlo.tota7s, ;
					tota8s WITH cursor_4c_TmpTotBlo.tota8s, tota9s WITH cursor_4c_TmpTotBlo.tota9s, ;
					tota10s WITH cursor_4c_TmpTotBlo.tota10s
			ENDIF
		ENDIF

		SELECT (loc_cItens)
		= SEEK(loc_nItens, loc_cItens, "citens")

		IF USED(loc_cParcelas)
			SELECT (loc_cParcelas)
			SCAN
				IF !EMPTY(percs)
					*-- (Real SRCOM custos internos) * percentual + (real fornecedor) * percentual
					REPLACE valos WITH ((EVALUATE(loc_cItens + ".tota7s") * percs) / 100) + ((EVALUATE(loc_cItens + ".tota8s") * percs) / 100)
				ENDIF
			ENDSCAN
		ENDIF

		SELECT (loc_cItens)
		THIS.LockScreen = .F.
		THIS.grd_4c_Itens.Refresh()
	ENDPROC

	*==========================================================================
	* ConfigurarCampoNovoGrupo - Say_NewGrp/get_NewGrp do legado: grupo a
	* usar quando o produto novo cadastrado pelo btnCadPro (Fase 6) ainda
	* nao existe em SigCdPro. Geometria/MaxLength/ToolTipText TRANSCRITOS
	* do dump.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarCampoNovoGrupo()
		LOCAL loc_lPodeEditar
		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

		THIS.AddObject("lbl_4c_NovoGrupo", "Label")
		WITH THIS.lbl_4c_NovoGrupo
			.FontName  = "Tahoma"
			.FontSize  = 8
			.Caption   = "\<Grupo"
			.Top       = 129
			.Left      = 499
			.Width     = 31
			.Height    = 15
			.ForeColor = RGB(90, 90, 90)
			.Visible   = .T.
		ENDWITH

		THIS.AddObject("txt_4c_NovoGrupo", "TextBox")
		WITH THIS.txt_4c_NovoGrupo
			.Top           = 144
			.Left          = 495
			.Width         = 37
			.Height        = 23
			.FontBold      = .T.
			.MaxLength     = 3
			.SpecialEffect = 1
			.ToolTipText   = "Grupo Para Cadastro de Produtos"
			.ForeColor     = RGB(0, 0, 0)
			.BackColor     = RGB(255, 255, 232)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = ""
			.Enabled       = loc_lPodeEditar
			.Visible       = .T.
		ENDWITH
		BINDEVENT(THIS.txt_4c_NovoGrupo, "LostFocus", THIS, "TxtNovoGrupoLostFocus")
	ENDPROC

	*==========================================================================
	* TxtNovoGrupoLostFocus - legado SIGOPORC.get_NewGrp.Valid (+LostFocus,
	* que so move o foco - THIS.btnCadPro.SetFocus(), inalcancavel nesta
	* fase porque btnCadPro e Fase 6; por isso nao chamado aqui). Lookup
	* de Grupo de Produto, restrito por SigCdRpo (Dopps = Dopes do
	* cabecalho); se a restricao nao devolve nada, o legado cai para a
	* lista INTEIRA de SigCdGrp - transcrito literalmente.
	*
	* Regras #36/#37/#47: lookup em LostFocus (nao KeyPress), guarda de
	* reentrancia (o picker e modal), this_lAchouRegistro/Mostrar() ANTES
	* de decidir mostrar o dialogo, e NUNCA MsgAviso + apagar o digitado
	* quando a busca exata falha - so abre o picker (regra #50).
	*==========================================================================
	PROCEDURE TxtNovoGrupoLostFocus()
		LOCAL loc_cSQL, loc_nResultado, loc_cValorDigitado, loc_oErro

		IF THIS.this_lEmLookupGrupo
			RETURN
		ENDIF

		*-- LostFocus dispara SEMPRE (o Valid do legado so dispara quando o
		*-- valor MUDA) - sem esta guarda, so passar pelo campo sem digitar
		*-- nada reconsulta o SQL (ou reabre o picker) a cada perda de foco.
		loc_cValorDigitado = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
		IF loc_cValorDigitado == THIS.this_cUltimoTxtNovoGrupoLostFocusValidado
			RETURN
		ENDIF

		THIS.this_lEmLookupGrupo = .T.

		TRY
			IF !EMPTY(loc_cValorDigitado)
				IF USED("cursor_4c_BuscaGrupo")
					USE IN cursor_4c_BuscaGrupo
				ENDIF

				loc_cSQL = "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a" + ;
					" INNER JOIN SigCdRpo b ON (a.Cgrus = b.Cgrus OR a.Mercs = b.Mercs)" + ;
					" WHERE b.Dopps = " + EscaparSQL(THIS.this_cDopes)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

				IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_BuscaGrupo") = 0
					IF USED("cursor_4c_BuscaGrupo")
						USE IN cursor_4c_BuscaGrupo
					ENDIF
					loc_nResultado = SQLEXEC(gnConnHandle, "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a", "cursor_4c_BuscaGrupo")
				ENDIF

				IF loc_nResultado > 0 AND USED("cursor_4c_BuscaGrupo")
					SELECT cursor_4c_BuscaGrupo
					GO TOP
					LOCATE FOR ALLTRIM(Cgrus) == loc_cValorDigitado

					IF FOUND()
						THIS.txt_4c_NovoGrupo.Value = ALLTRIM(Cgrus)
					ELSE
						*-- Codigo digitado nao existe no universo restrito:
						*-- abre o picker (equivale ao fwBuscaInt do legado).
						*-- Regra #50: cancelando (ESC) o digitado PERMANECE,
						*-- nao se apaga o campo nem se exibe aviso.
						THIS.AbrirBuscaNovoGrupo()
						IF !EMPTY(THIS.this_cLookupCodigo)
							THIS.txt_4c_NovoGrupo.Value = THIS.this_cLookupCodigo
						ENDIF
					ENDIF

					USE IN cursor_4c_BuscaGrupo
				ENDIF
			ENDIF

			*-- Registra o valor final do campo (digitado, resolvido pela
			*-- busca exata ou escolhido no picker) como "ja validado" -
			*-- a proxima perda de foco sem mudanca sai pela guarda acima.
			THIS.this_cUltimoTxtNovoGrupoLostFocusValidado = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro em Formsigoporc.TxtNovoGrupoLostFocus")
		ENDTRY

		THIS.this_lEmLookupGrupo = .F.
	ENDPROC

	*==========================================================================
	* ConfigurarCampoBusca - getDpros/getDpro2s/btnProcura do legado: busca
	* textual na grade de itens, no rodape (mesma faixa Top=481 onde fica
	* edt_4c_DescritivoRodape - mutuamente exclusivos por this_nDigItens,
	* resolvido em AtualizarModoCriacao). Geometria/Picture TRANSCRITOS do
	* dump ("PROPRIEDADES DE: SIGOPORC.getDpros/getDpro2s/btnProcura").
	*
	* getDpros (TextBox/fwget) e getDpro2s (EditBox/fwmemo, mapeamento.json
	* confirma a classe) SO ficam editaveis quando this_lProcura = .T.
	* (legado: "PROCEDURE When / Return thisform.lProcura") - fora do modo
	* de busca espelham a descricao do item corrente, escritas por
	* GradeItensAfterRowColChange. .Enabled, nao .ReadOnly: reproduz o
	* efeito do When (campo nao alcancavel por Tab/clique) sem inventar
	* estado novo.
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarCampoBusca()
		THIS.AddObject("txt_4c_ProcuraDpros", "TextBox")
		WITH THIS.txt_4c_ProcuraDpros
			.Top           = 481
			.Left          = 16
			.Width         = 290
			.Height        = 21
			.FontSize      = 8
			.Alignment     = 3
			.Format        = "K"
			.Margin        = 0
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = ""
			.Enabled       = .F.
			.Visible       = .T.
		ENDWITH
		BINDEVENT(THIS.txt_4c_ProcuraDpros, "KeyPress", THIS, "ProcuraDprosKeyPress")
		BINDEVENT(THIS.txt_4c_ProcuraDpros, "LostFocus", THIS, "ProcuraDprosLostFocus")

		THIS.AddObject("edt_4c_ProcuraDpro2s", "EditBox")
		WITH THIS.edt_4c_ProcuraDpro2s
			.Top           = 481
			.Left          = 307
			.Width         = 290
			.Height        = 21
			.FontSize      = 8
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = ""
			.Enabled       = .F.
			.Visible       = .T.
		ENDWITH
		BINDEVENT(THIS.edt_4c_ProcuraDpro2s, "KeyPress", THIS, "ProcuraDpro2sKeyPress")
		BINDEVENT(THIS.edt_4c_ProcuraDpro2s, "LostFocus", THIS, "ProcuraDpro2sLostFocus")

		THIS.AddObject("cmd_4c_Procurar", "CommandButton")
		WITH THIS.cmd_4c_Procurar
			.Top             = 481
			.Left            = 600
			.Height          = 21
			.Width           = 40
			.Caption         = ""
			.ToolTipText     = "Procurar Item"
			.Picture         = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
			.Themes          = .T.
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")
	ENDPROC

	*==========================================================================
	* ProcuraDprosKeyPress / ProcuraDpro2sKeyPress - legado SIGOPORC.getDpros/
	* getDpro2s.Valid (disparado so com this_lProcura = .T., porque fora
	* disso os campos ficam Enabled = .F. e nao recebem KeyPress). Mesmo
	* comportamento do legado: LOCATE (sem SEEK/GO) move o registro
	* corrente da grade para a primeira linha cujo Dpros/Dpro2s contem o
	* texto digitado - o Refresh so repinta o que o LOCATE ja moveu.
	*==========================================================================
	PROCEDURE ProcuraDprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cItens, loc_cValor

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF

		loc_cValor = ALLTRIM(THIS.txt_4c_ProcuraDpros.Value)
		IF EMPTY(loc_cValor)
			RETURN
		ENDIF

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF USED(loc_cItens)
			SELECT (loc_cItens)
			GO TOP
			LOCATE FOR LIKE("*" + loc_cValor + "*", dpros)
			THIS.grd_4c_Itens.Refresh()
		ENDIF
	ENDPROC

	PROCEDURE ProcuraDpro2sKeyPress(par_nKeyCode, par_nShiftAltCtrl)
		LOCAL loc_cItens, loc_cValor

		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
			RETURN
		ENDIF

		loc_cValor = ALLTRIM(THIS.edt_4c_ProcuraDpro2s.Value)
		IF EMPTY(loc_cValor)
			RETURN
		ENDIF

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF USED(loc_cItens)
			SELECT (loc_cItens)
			GO TOP
			LOCATE FOR LIKE("*" + loc_cValor + "*", dpro2s)
			THIS.grd_4c_Itens.Refresh()
		ENDIF
	ENDPROC

	*==========================================================================
	* ProcuraDprosLostFocus / ProcuraDpro2sLostFocus - legado: "If !Empty
	* (this.Value) / thisform.btnprocura.SetFocus()". So move o foco (nao
	* dispara busca nenhuma) - a busca ja rodou no Enter/Tab acima.
	*==========================================================================
	PROCEDURE ProcuraDprosLostFocus()
		IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
			THIS.cmd_4c_Procurar.SetFocus()
		ENDIF
	ENDPROC

	PROCEDURE ProcuraDpro2sLostFocus()
		IF !EMPTY(THIS.edt_4c_ProcuraDpro2s.Value)
			THIS.cmd_4c_Procurar.SetFocus()
		ENDIF
	ENDPROC

	*==========================================================================
	* BtnProcurarClick - legado SIGOPORC.btnProcura.Click. Botao de DUAS
	* fases, igual ao legado: 1o clique entra em modo de busca (habilita
	* os dois campos, limpa e foca); clique seguinte (ja em modo de busca)
	* EXECUTA a busca pelo campo preenchido - Dpros tem prioridade sobre
	* Dpro2s quando os dois estao preenchidos (legado: "Iif(!Empty(getDpros.
	* Value), getDpros.Value, getDpro2s.Value)"). this_lProcura SO volta a
	* .F. quando a grade troca de linha (GradeItensAfterRowColChange) -
	* exatamente como no legado, que nunca reseta a flag aqui dentro.
	*==========================================================================
	PROCEDURE BtnProcurarClick()
		LOCAL loc_cItens, loc_nItem, loc_cProcura, loc_lPorDpros

		*-- "When" do legado (Inlist(Op_Escolha,[INSERIR],[ALTERAR])) como
		*-- guarda no handler: btnProcura e botao SO-ICONE (Caption = "" no
		*-- dump) e NAO pode receber .Enabled = .F. - com Caption vazio o
		*-- VFP9 deixa de desenhar o Picture e o botao vira um retangulo
		*-- vazio (CorretorAutomatico #106). BINDEVENT tambem descarta o
		*-- retorno do delegate, entao um When ligado por BINDEVENT nao
		*-- bloquearia nada.
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		IF !THIS.this_lProcura
			THIS.this_lProcura = .T.

			THIS.txt_4c_ProcuraDpros.Enabled  = .T.
			THIS.edt_4c_ProcuraDpro2s.Enabled = .T.
			THIS.txt_4c_ProcuraDpros.Value    = ""
			THIS.edt_4c_ProcuraDpro2s.Value   = ""

			THIS.txt_4c_ProcuraDpros.SetFocus()
		ELSE
			IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value) OR !EMPTY(THIS.edt_4c_ProcuraDpro2s.Value)
				loc_lPorDpros = !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
				loc_cProcura  = ALLTRIM(IIF(loc_lPorDpros, THIS.txt_4c_ProcuraDpros.Value, THIS.edt_4c_ProcuraDpro2s.Value))

				loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
				IF USED(loc_cItens)
					SELECT (loc_cItens)
					loc_nItem = citens
					IF !EOF()
						SKIP
					ENDIF
					IF loc_lPorDpros
						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpros) AND citens <> loc_nItem
					ELSE
						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpro2s) AND citens <> loc_nItem
					ENDIF
					THIS.grd_4c_Itens.Refresh()
				ENDIF
			ENDIF
		ENDIF
	ENDPROC

	*==========================================================================
	* ConfigurarImagemProduto - imgProds do legado: pre-visualizacao da foto
	* do produto do item corrente, oculta por padrao (Visible = .F. no
	* dump) - so aparece quando GradeItensAfterRowColChange encontra foto E
	* SigCdOpe.Imagems = 1 (this_nImagems, Fase posterior). Duplo clique
	* amplia (DblClick do legado - "Do Form SigOpZom"; SigOpZom nao foi
	* migrado, fallback ShellExecute igual ao de Formsigprccp.FigJpgDblClick).
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarImagemProduto()
		THIS.AddObject("img_4c_Produto", "Image")
		WITH THIS.img_4c_Produto
			.Top         = 108
			.Left        = 579
			.Width       = 159
			.Height      = 89
			.Stretch     = 1
			.ToolTipText = "Imagem do Produto [Duplo Click Para Zoom]"
			.Picture     = ""
			.Visible     = .F.
		ENDWITH
		BINDEVENT(THIS.img_4c_Produto, "DblClick", THIS, "ImgProdutoDblClick")
	ENDPROC

	*==========================================================================
	* ImgProdutoDblClick - legado SIGOPORC.imgProds.DblClick. Reextrai a
	* foto do PRODUTO CORRENTE para um arquivo temporario proprio e abre o
	* visualizador ampliado. Mesmo padrao canonico ja usado em
	* Formsigprccp.FigJpgDblClick (FormSigOpZom ainda nao foi migrado - o
	* fallback abre a imagem no visualizador do Windows via ShellExecute).
	*==========================================================================
	PROCEDURE ImgProdutoDblClick()
		LOCAL loc_cItens, loc_cCpros, loc_cDpros, loc_cSQL, loc_nResultado
		LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro, loc_lProsseguir
		loc_lProsseguir = .T.

		TRY
			loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
			IF !USED(loc_cItens) OR EOF(loc_cItens)
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				loc_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cpros"), ""))
				loc_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".dpros"), ""))
				IF EMPTY(loc_cCpros)
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				IF USED("cursor_4c_TmpFotoZom")
					USE IN cursor_4c_TmpFotoZom
				ENDIF
				loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoZom")

				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFotoZom") OR RECCOUNT("cursor_4c_TmpFotoZom") = 0
					loc_lProsseguir = .F.
				ENDIF
			ENDIF

			IF loc_lProsseguir
				SELECT cursor_4c_TmpFotoZom
				GO TOP
				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoZom.FigJpgs, "")
				USE IN cursor_4c_TmpFotoZom

				IF !EMPTY(loc_cFigJpgs)
					loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
					loc_cFoto = STRCONV( ;
						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
							"data:image/png;base64,", ""), ;
							"data:image/jpeg;base64,", ""), ;
							"data:image/jpg;base64,", ""), 14)
					STRTOFILE(loc_cFoto, loc_cArqTemp)

					IF FILE(loc_cArqTemp)
						loc_cCaption = "Produto : " + loc_cCpros + " - " + loc_cDpros

						IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
								FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
							DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
								WITH loc_cArqTemp, loc_cCaption, " "
						ELSE
							DECLARE INTEGER ShellExecute IN shell32.dll ;
								INTEGER hWnd, STRING lpOperation, STRING lpFile, ;
								STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
							ShellExecute(0, "open", loc_cArqTemp, "", "", 1)
						ENDIF
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_TmpFotoZom")
				USE IN cursor_4c_TmpFotoZom
			ENDIF
		CATCH TO loc_oErro
			IF USED("cursor_4c_TmpFotoZom")
				USE IN cursor_4c_TmpFotoZom
			ENDIF
			MsgErro("Erro ao ampliar a foto do produto:" + CHR(13) + ;
				loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro")
		ENDTRY
	ENDPROC

	*==========================================================================
	* ConfigurarDescritivoRodape - getDescritivo do legado: memo de rodape,
	* largura TOTAL, abaixo das duas grades. Por padrao (ControlSource =
	* TprMvCab.Obses, dado de cabecalho que esta fora do escopo deste BO)
	* o Init legado deixa INVISIVEL fora do modo Criacao - unico estado
	* alcancavel nesta fase, porque this_nDigItens so e preenchido em
	* fase posterior (SigCdOpe - ver cabecalho do BO). AtualizarModoCriacao
	* fica pronto para quando DigItens chegar: troca o ControlSource para
	* o Dpro2s do item corrente e mostra o campo (regra transcrita do
	* Init: "If Inlist(DigItens,6,7) ... thisform.getDescritivo.
	* ControlSource = [crSigMvOrc.Dpro2s] Else ... .Visible = .f.").
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarDescritivoRodape()
		THIS.AddObject("edt_4c_DescritivoRodape", "EditBox")
		WITH THIS.edt_4c_DescritivoRodape
			.Top           = 481
			.Left          = 5
			.Width         = 989
			.Height        = 115
			.FontSize      = 8
			.SpecialEffect = 1
			.ForeColor     = RGB(0, 0, 0)
			.DisabledBackColor = RGB(255, 255, 255)
			.BorderColor   = RGB(100, 100, 100)
			.Value         = ""
			.Enabled       = .F.
			.Visible       = .F.
		ENDWITH
	ENDPROC

	*==========================================================================
	* AtualizarModoCriacao - transcricao do bloco de LAYOUT do Init legado:
	* o ramo "Inlist(crSigCdOpe.DigItens,6,7)" (modo Criacao) e, no ramo
	* normal, a bifurcacao "LocalEmp.DIVNOTAS = 2" (P&G) / Else (SRCOM).
	* Decide QUEM APARECE e com que legenda/geometria; quem fica EDITAVEL e
	* decidido por HabilitarCampos()/AjustarBotoesPorModo() (os "When" do
	* legado). Chamado em InicializarForm e por CarregarDados - e
	* IDEMPOTENTE de proposito: cada controle recebe Visible nos DOIS
	* sentidos, nunca so no ramo que o esconde.
	*
	* Fase 8/8 - COMPLETADO: ate a fase anterior este metodo cobria apenas
	* edt_4c_DescritivoRodape e o trio de busca. O bloco legado toca ainda
	* say1..say6 + os 6 getP* (os seis pares label/campo de percentual),
	* grdParcela, btnIncluirp/btnExcluirp, btnTotItens e btnIteSub - todos
	* ficavam VISIVEIS em modo Criacao (onde o legado os esconde), e as
	* duas legendas que o P&G troca ("Lucro"/"Imposto Cheio") nunca eram
	* aplicadas. Mapa label->objeto do legado, conferido no dump:
	*   say5 -> lbl_4c_Margem          say4 -> lbl_4c_Contingente
	*   say1 -> lbl_4c_TaxaAdm         say3 -> lbl_4c_BV
	*   say2 -> lbl_4c_Imposto         say6 -> lbl_4c_ImpostoServico
	*
	* DESVIO DOCUMENTADO (geometria do ramo P&G): o legado faz
	* "grdItem.Height = 444" junto com "getDpros/getDpro2s/btnProcura.Top
	* = 570". Os dois numeros sao INCOMPATIVEIS entre si - com grdItem.Top
	* = 218, a altura 444 leva a grade ate 662, ou seja a grade cobriria a
	* linha de busca em 570 (e passaria do rodape do form, de 600). O SCX
	* nao declara Height do form (a secao de propriedades do form vem
	* VAZIA no dump), entao 444 nao e verificavel; 570 e, e cabe. Aqui
	* vale o 570 do legado (linha de busca encostada no rodape) e a grade
	* cresce ATE ela - Height = 350 (218 + 350 = 568) - em vez de 444.
	* Transcrever 444 ao pe da letra soterraria tres controles (regra #30:
	* controle recortado/coberto some sem erro e sem aparecer em
	* screenshot).
	*==========================================================================
	PROTECTED PROCEDURE AtualizarModoCriacao()
		LOCAL loc_cItens, loc_lModoCriacao, loc_lPG, loc_lMostraPerc, ;
			loc_lPercSoPG, loc_lMostraParcelas

		loc_cItens       = THIS.this_oBusinessObject.this_cCursorItens
		loc_lModoCriacao = INLIST(THIS.this_oBusinessObject.this_nDigItens, 6, 7)
		loc_lPG          = (THIS.this_oBusinessObject.this_nDivNotas = 2)

		*-- Os 6 percentuais somem inteiros no modo Criacao. Fora dele,
		*-- Margem/Contingente/BV/Imposto sem ISS so existem em P&G
		*-- (o Else SRCOM do legado esconde esses quatro); Taxa Adm. e
		*-- Imposto aparecem nos dois.
		loc_lMostraPerc = !loc_lModoCriacao
		loc_lPercSoPG   = loc_lMostraPerc AND loc_lPG

		*-- A grade de parcelas (e seus dois botoes) sai da tela tanto no
		*-- modo Criacao quanto em P&G - nos dois ramos o legado faz
		*-- "grdParcela.Visible = .f." + "btnIncluirp/btnExcluirp .Visible/
		*-- .Enabled = .f.". Previsao de pagamento so existe em SRCOM.
		loc_lMostraParcelas = !loc_lModoCriacao AND !loc_lPG

		*-- Pares label/campo dos percentuais
		THIS.lbl_4c_Margem.Visible         = loc_lPercSoPG
		THIS.txt_4c_Margem.Visible         = loc_lPercSoPG
		THIS.lbl_4c_Contingente.Visible    = loc_lPercSoPG
		THIS.txt_4c_Contingente.Visible    = loc_lPercSoPG
		THIS.lbl_4c_BV.Visible             = loc_lPercSoPG
		THIS.txt_4c_BV.Visible             = loc_lPercSoPG
		THIS.lbl_4c_ImpostoServico.Visible = loc_lPercSoPG
		THIS.txt_4c_ImpostoServico.Visible = loc_lPercSoPG

		THIS.lbl_4c_TaxaAdm.Visible        = loc_lMostraPerc
		THIS.txt_4c_TaxaAdm.Visible        = loc_lMostraPerc
		THIS.lbl_4c_Imposto.Visible        = loc_lMostraPerc
		THIS.txt_4c_Imposto.Visible        = loc_lMostraPerc

		*-- Legendas que o ramo P&G troca (say1/say2 do legado)
		IF loc_lPG
			THIS.lbl_4c_TaxaAdm.Caption = "Lucro :                %"
			THIS.lbl_4c_Imposto.Caption = "Imposto Cheio :                %"
		ELSE
			THIS.lbl_4c_TaxaAdm.Caption = "Ta\<xa Adm. :                     %"
			THIS.lbl_4c_Imposto.Caption = "Im\<posto :                     %"
		ENDIF

		*-- Grade de parcelas e seus botoes
		THIS.grd_4c_Parcelas.Visible       = loc_lMostraParcelas
		THIS.grd_4c_Parcelas.Enabled       = loc_lMostraParcelas
		THIS.cmd_4c_IncluirParcela.Visible = loc_lMostraParcelas
		THIS.cmd_4c_ExcluirParcela.Visible = loc_lMostraParcelas

		*-- Botoes do rodape que o modo Criacao esconde
		THIS.cmd_4c_TotItens.Visible = !loc_lModoCriacao
		THIS.cmd_4c_IteSub.Visible   = !loc_lModoCriacao

		IF loc_lModoCriacao
			*-- Criacao: o descritivo do rodape entra ligado ao item corrente
			*-- (legado: getDescritivo.ControlSource = [crSigMvOrc.Dpro2s]) e
			*-- a linha de busca sai inteira.
			THIS.edt_4c_DescritivoRodape.Visible = .T.
			IF USED(loc_cItens)
				THIS.edt_4c_DescritivoRodape.ControlSource = loc_cItens + ".dpro2s"
			ENDIF

			THIS.txt_4c_ProcuraDpros.Visible  = .F.
			THIS.edt_4c_ProcuraDpro2s.Visible = .F.
			THIS.cmd_4c_Procurar.Visible      = .F.
		ELSE
			THIS.edt_4c_DescritivoRodape.Visible = .F.

			THIS.txt_4c_ProcuraDpros.Visible  = .T.
			THIS.edt_4c_ProcuraDpro2s.Visible = .T.
			THIS.cmd_4c_Procurar.Visible      = .T.

			*-- Geometria do ramo P&G (ver DESVIO DOCUMENTADO no cabecalho):
			*-- sem a grade de parcelas, a grade de itens cresce ate a linha
			*-- de busca, que desce para o rodape.
			IF loc_lPG
				THIS.grd_4c_Itens.Height      = 350
				THIS.txt_4c_ProcuraDpros.Top  = 570
				THIS.edt_4c_ProcuraDpro2s.Top = 570
				THIS.cmd_4c_Procurar.Top      = 570
			ELSE
				THIS.grd_4c_Itens.Height      = 258
				THIS.txt_4c_ProcuraDpros.Top  = 481
				THIS.edt_4c_ProcuraDpro2s.Top = 481
				THIS.cmd_4c_Procurar.Top      = 481
			ENDIF
		ENDIF

		*-- Quem fica EDITAVEL (os "When" do legado) e assunto de
		*-- HabilitarCampos/AjustarBotoesPorModo - chamados aqui para o
		*-- estado ficar coerente a cada reaplicacao do layout.
		THIS.HabilitarCampos()
		THIS.AjustarBotoesPorModo()
	ENDPROC

	*==========================================================================
	* PosicionarParcelasDoItem - Reproduz o fecho do Init legado:
	*
	*   Select crSigMvOrp / Set Order to / Set Order to CItens
	*   Set Key to crSigMvOrc.CItens / Go Top
	*
	* O SET KEY e o que faz a grade de parcelas mostrar SO as parcelas do
	* item corrente (mestre-detalhe por Citens) - sem ele a grade exibiria
	* as parcelas de TODOS os itens. Trocar ordem/chave de um alias NAO
	* repinta a grade ligada a ele, por isso o Refresh fica no funil
	* CarregarDados e no handler de troca de linha (regra #21).
	*==========================================================================
	PROTECTED PROCEDURE PosicionarParcelasDoItem()
		LOCAL loc_cItens, loc_cParcelas, loc_nItem
		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

		IF USED(loc_cParcelas)
			loc_nItem = 0
			IF USED(loc_cItens) AND !EOF(loc_cItens)
				loc_nItem = EVALUATE(loc_cItens + ".citens")
			ENDIF

			SELECT (loc_cParcelas)
			SET ORDER TO
			SET ORDER TO TAG citens
			SET KEY TO loc_nItem
			GO TOP
		ENDIF
	ENDPROC

	*==========================================================================
	* CarregarDados - FUNIL de carga da tela. PUBLIC de proposito: alem de
	* ser chamado pelo InicializarForm, o harness de teste
	* (TesteAutomatico.prg) o invoca de FORA da classe - com PROTECTED a
	* chamada estoura "Property CARREGARDADOS is not found", porque
	* PEMSTATUS(...,5) devolve .T. tambem para metodo protegido (regra #3).
	*
	* Ordem (a mesma do Init legado): garantir os cursores -> aplicar o
	* layout do modo (AtualizarModoCriacao) -> CarregarLista (vincular as
	* duas grades, ler do banco, posicionar os aliases e repintar) ->
	* BOParaForm (percentuais do cabecalho na tela).
	*
	* Fase 8/8: a parte de RECARGA saiu daqui para CarregarLista(), que e
	* o funil chamado tambem pelas recargas posteriores - antes a leitura
	* do banco + bind + reposicionamento + Refresh existiam SO aqui, e
	* quem precisasse reler teria de duplicar a sequencia. CarregarDados
	* continua PUBLIC e continua sendo o ponto de entrada do InicializarForm
	* e do harness.
	*
	* Nao estoura quando os cursores ainda nao existem (caso do harness, que
	* instancia o form sem chamador): o resultado sai por flag e o RETURN e
	* unico, depois do ENDTRY (regra #1).
	*==========================================================================
	PROCEDURE CarregarDados()
		LOCAL loc_lSucesso, loc_oErro, loc_cItens, loc_cParcelas
		loc_lSucesso = .F.

		TRY
			loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
			loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

			IF !USED(loc_cItens)
				THIS.CriarCursorItens()
			ENDIF

			IF !USED(loc_cParcelas)
				THIS.CriarCursorParcelas()
			ENDIF

			*-- Layout (quem aparece) ANTES da carga: AtualizarModoCriacao
			*-- liga o ControlSource de edt_4c_DescritivoRodape ao cursor e
			*-- fecha chamando HabilitarCampos/AjustarBotoesPorModo.
			THIS.AtualizarModoCriacao()

			*-- Legado: AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...) no
			*-- Init. Vincular as grades, ler do banco, posicionar os aliases
			*-- e repintar ficam todos em CarregarLista (funil de recarga),
			*-- para a primeira carga e as recargas seguintes seguirem
			*-- exatamente o mesmo caminho.
			loc_lSucesso = THIS.CarregarLista()

			*-- Valores do cabecalho (percentuais) para a tela - no legado
			*-- vinham sozinhos pelo ControlSource = TprMvCab.<coluna>
			THIS.BOParaForm()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.CarregarDados")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* GradeItensAfterRowColChange - Troca de linha na grade de itens: refaz
	* o filtro da grade de parcelas (mestre-detalhe), espelha a descricao
	* do item nos campos de busca, reseta o modo de busca e atualiza a
	* pre-visualizacao da foto do produto. Ligado por BINDEVENT, por isso
	* declara o parametro do evento (regra #3: handler sem parametro
	* ligado a AfterRowColChange estoura).
	*
	* Uso CORRETO de AfterRowColChange - carregar o DETALHE da linha
	* corrente, SEM filtrar por coluna (regra #46). Validacao de celula nao
	* entra aqui: vai no Valid do TextBox da Column.
	*
	* O grdItem.AfterRowColChange do legado faz mais coisas, que dependem de
	* btnCadPro/Get_NewGrp (Fase 7 - precisam de SigCdOpe.CadProds/CadProDs,
	* ainda nao carregados) e da troca do DynamicForeColor pelo CitAgrs.
	*==========================================================================
	PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
		LOCAL loc_cItens, loc_cDpros, loc_cDpro2s

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens

		*-- Legado: thisform.cItAgr = crSigMvOrc.CitAgrs (agrupador da linha
		*-- corrente, usado pelo realce de decupagem)
		IF USED(loc_cItens) AND !EOF(loc_cItens)
			THIS.this_nCItAgr = EVALUATE(loc_cItens + ".citagrs")
		ENDIF

		*-- Legado: "thisform.lProcura = .f." + imgProds.Visible=.f./Picture=[]
		*-- no inicio do AfterRowColChange - toda troca de linha sai do modo
		*-- de busca e esconde a foto do produto anterior.
		THIS.this_lProcura = .F.
		THIS.img_4c_Produto.Visible = .F.
		THIS.img_4c_Produto.Picture = ""

		*-- Legado: "thisform.getDPros.Value = crSigMvOrc.Dpros" / "getDPro2s.
		*-- Value = crSigMvOrc.Dpro2s" - fora do modo de busca os dois campos
		*-- so espelham a descricao do item corrente (ficam Enabled = .F.,
		*-- ver AtualizarModoCriacao).
		loc_cDpros  = ""
		loc_cDpro2s = ""
		IF USED(loc_cItens) AND !EOF(loc_cItens)
			loc_cDpros  = TratarNulo(EVALUATE(loc_cItens + ".dpros"), "")
			loc_cDpro2s = TratarNulo(EVALUATE(loc_cItens + ".dpro2s"), "")
		ENDIF
		THIS.txt_4c_ProcuraDpros.Enabled  = .F.
		THIS.edt_4c_ProcuraDpro2s.Enabled = .F.
		THIS.txt_4c_ProcuraDpros.Value    = loc_cDpros
		THIS.edt_4c_ProcuraDpro2s.Value   = loc_cDpro2s

		THIS.CarregarImagemProdutoCorrente()

		*-- Fase 7/8 - legado: "With ThisForm.btnCadPro / llVis = (InList(
		*-- crSigCdOpe.CadProds,1,3,4,5)) And fChecaAcesso('SigCdPro',
		*-- 'INSERIR') And InList(ThisForm.Op_Escolha,'INSERIR','ALTERAR') /
		*-- .Enabled = llVis And Not Eof(...) And (...)". CadProDs do legado
		*-- e a MESMA coluna que CadProds (VFP e case-insensitive) - this_nCadProds
		*-- cobre as duas grafias.
		THIS.AtualizarEstadoCadastroProduto()

		THIS.PosicionarParcelasDoItem()
		THIS.grd_4c_Parcelas.Refresh()
	ENDPROC

	*==========================================================================
	* AtualizarEstadoCadastroProduto - Habilita/desabilita cmd_4c_CadPro
	* (btnCadPro) e o par txt_4c_NovoGrupo/lbl_4c_NovoGrupo conforme a linha
	* corrente da grade de itens e SigCdOpe.CadProds - transcrito do final
	* do AfterRowColChange legado (fica em metodo proprio, chamado tambem
	* de BtnCadastroProdutoClick depois de confirmar um produto novo).
	*==========================================================================
	PROCEDURE AtualizarEstadoCadastroProduto()
		LOCAL loc_cItens, loc_lVisivel, loc_cCpros, loc_nCitens, loc_nCitem2, loc_cBlocos, loc_lLinhaNormal

		IF !PEMSTATUS(THIS, "cmd_4c_CadPro", 5)
			RETURN
		ENDIF

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens

		loc_lVisivel = INLIST(THIS.this_oBusinessObject.this_nCadProds, 1, 3, 4, 5) AND ;
			fChecaAcesso("SigCdPro", "INSERIR") AND ;
			INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

		IF !USED(loc_cItens) OR EOF(loc_cItens)
			THIS.cmd_4c_CadPro.Enabled = .F.
			RETURN
		ENDIF

		loc_cCpros  = TratarNulo(EVALUATE(loc_cItens + ".cpros"), "")
		loc_nCitens = EVALUATE(loc_cItens + ".citens")
		loc_nCitem2 = EVALUATE(loc_cItens + ".citem2")
		loc_cBlocos = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cblocos"), ""))

		loc_lLinhaNormal = (loc_nCitens <> loc_nCitem2) AND ;
			!INLIST(loc_cBlocos, "SUBTOTAL", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "BRANCO", "TOTALGERAL")

		THIS.cmd_4c_CadPro.Enabled = loc_lVisivel AND ;
			( ;
				(EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.this_nCadProds = 1 AND loc_lLinhaNormal) OR ;
				(!EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.this_nCadProds = 3 AND loc_lLinhaNormal) OR ;
				INLIST(THIS.this_oBusinessObject.this_nCadProds, 4, 5) ;
			)

		IF THIS.this_oBusinessObject.this_nCadProds = 4
			THIS.txt_4c_NovoGrupo.Enabled = EMPTY(loc_cCpros)
			THIS.lbl_4c_NovoGrupo.Enabled = EMPTY(loc_cCpros)
			THIS.txt_4c_NovoGrupo.Value   = ""
		ENDIF
	ENDPROC

	*==========================================================================
	* CarregarImagemProdutoCorrente - legado: trecho final do AfterRowColChange
	* que consulta SigCdPro.FigJpgs do item corrente e mostra a foto SE
	* SigCdOpe.Imagems = 1 E Confes <> 1 (this_nImagems/this_nConfes - Fase
	* posterior; com o default 0 este metodo e no-op, igual ao
	* comportamento seguro ja documentado para DigItens/DivNotas). Decode
	* UNICO de base64->JPEG (regra: nunca aplicar STRCONV(...,14) duas vezes).
	*==========================================================================
	PROTECTED PROCEDURE CarregarImagemProdutoCorrente()
		LOCAL loc_cItens, loc_cCpros, loc_cSQL, loc_nResultado, loc_cFigJpgs, loc_cFoto, loc_cArqTemp, loc_oErro

		IF THIS.this_oBusinessObject.this_nImagems <> 1 OR THIS.this_oBusinessObject.this_nConfes = 1
			RETURN
		ENDIF

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF !USED(loc_cItens) OR EOF(loc_cItens)
			RETURN
		ENDIF

		loc_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cpros"), ""))
		IF EMPTY(loc_cCpros)
			RETURN
		ENDIF

		TRY
			IF USED("cursor_4c_TmpFotoItem")
				USE IN cursor_4c_TmpFotoItem
			ENDIF
			loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoItem")

			IF loc_nResultado >= 1 AND USED("cursor_4c_TmpFotoItem") AND RECCOUNT("cursor_4c_TmpFotoItem") > 0
				SELECT cursor_4c_TmpFotoItem
				GO TOP
				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoItem.FigJpgs, "")
				USE IN cursor_4c_TmpFotoItem

				IF !EMPTY(loc_cFigJpgs)
					loc_cArqTemp = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + "SigOpPro.jpg"
					loc_cFoto = STRCONV( ;
						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
							"data:image/png;base64,", ""), ;
							"data:image/jpeg;base64,", ""), ;
							"data:image/jpg;base64,", ""), 14)

					IF STRTOFILE(loc_cFoto, loc_cArqTemp) > 0
						THIS.img_4c_Produto.Picture = loc_cArqTemp
						THIS.img_4c_Produto.Visible = .T.
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_TmpFotoItem")
				USE IN cursor_4c_TmpFotoItem
			ENDIF
		CATCH TO loc_oErro
			IF USED("cursor_4c_TmpFotoItem")
				USE IN cursor_4c_TmpFotoItem
			ENDIF
			MsgErro(loc_oErro.Message, "Erro em Formsigoporc.CarregarImagemProdutoCorrente")
		ENDTRY
	ENDPROC

	*==========================================================================
	* ConfigurarBotoesItens - btnIncluir/btnExcluir do legado (fwbtnp,
	* standalone - NAO sao CommandGroup). Posicao/Picture/Caption/ToolTip
	* TRANSCRITOS do dump ("PROPRIEDADES DE: SIGOPORC.btnIncluir/btnExcluir").
	* Themes=.T. + DisabledPicture obrigatorios em standalone com Picture
	* (regra CLAUDE.md - sem isso o icone some quando Enabled=.F.).
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarBotoesItens()
		LOCAL loc_lPodeEditar
		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

		THIS.AddObject("cmd_4c_IncluirLinha", "CommandButton")
		WITH THIS.cmd_4c_IncluirLinha
			.Top            = 3
			.Left           = 700
			.Height         = 75
			.Width          = 75
			.FontBold       = .T.
			.FontItalic     = .T.
			.FontName       = "Comic Sans MS"
			.FontSize       = 8
			.WordWrap       = .F.
			.Caption        = "Inserir Linha"
			.ToolTipText    = "Inserir linha"
			.PicturePosition = 13
			.ForeColor      = RGB(90, 90, 90)
			.BackColor      = RGB(255, 255, 255)
			.Themes         = .T.
			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
			.Enabled        = loc_lPodeEditar
			.Visible        = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_IncluirLinha, "Click", THIS, "BtnIncluirLinhaClick")

		THIS.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
		WITH THIS.cmd_4c_ExcluirLinha
			.Top            = 3
			.Left           = 775
			.Height         = 75
			.Width          = 75
			.FontBold       = .T.
			.FontItalic     = .T.
			.FontName       = "Comic Sans MS"
			.FontSize       = 8
			.Caption        = "Excluir"
			.ToolTipText    = "Exclui linha"
			.ForeColor      = RGB(90, 90, 90)
			.BackColor      = RGB(255, 255, 255)
			.Themes         = .T.
			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
			.Enabled        = loc_lPodeEditar
			.Visible        = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
	ENDPROC

	*==========================================================================
	* BtnIncluirLinhaClick - legado SIGOPORC.btnIncluir.Click. Insere uma
	* linha em branco IMEDIATAMENTE DEPOIS do item corrente, renumerando
	* Citens/Citem2/Citem3/CitAgrs de todas as linhas seguintes (igual ao
	* legado). Transcrito 1-para-1 na parte que opera so sobre a grade de
	* itens (cursor_4c_Itens).
	*
	* FICA PARA FASE POSTERIOR (precisa de cursor_4c_Parcelas/SigOpCdd/
	* LocalEmp, ainda nao carregados nesta fase):
	*   - renumeracao espelhada em crSigMvOrp (parcelas do item deslocado);
	*   - ramo de decupagem (SigOpCdd.ConfigGers) e copia de percentuais
	*     default do cabecalho quando LocalEmp.DivNotas = 2 (P&G).
	* A persistencia em SQL (BO.Inserir) acontece so no fechamento/
	* confirmacao do dialogo (fase propria) - igual ao legado, que so
	* grava a grade inteira ao sair ("Zap In crTpmMvItn ... Insert into
	* crTpmMvItn from Memvar").
	*==========================================================================
	PROCEDURE BtnIncluirLinhaClick()
		LOCAL loc_cCursor, loc_nItem, loc_nItem2, loc_nItem3, loc_nItAgr, loc_cBloco

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
		IF !USED(loc_cCursor)
			RETURN
		ENDIF

		SELECT (loc_cCursor)
		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
			RETURN
		ENDIF

		THIS.LockScreen = .T.

		loc_nItem  = citens
		loc_nItem2 = citem2
		loc_nItem3 = citem3
		loc_nItAgr = citagrs
		loc_cBloco = cblocos

		*-- Legado: "Select crSigMvOrc / Set Order To" ANTES do Scan - sem
		*-- remover a ordem controladora, atualizar a propria chave (Citens)
		*-- durante o Scan faria o VFP reprocessar/pular registros.
		SET ORDER TO
		SCAN FOR citens > loc_nItem
			REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 1), ;
				citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 + 1), ;
				citens WITH citens + 1, ;
				citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItAgr, citagrs, citagrs + 1)
		ENDSCAN

		APPEND BLANK
		REPLACE citens WITH loc_nItem + 1, citem2 WITH loc_nItem2, citem3 WITH loc_nItem3, ;
			cblocos WITH loc_cBloco, taxas WITH .T.

		SET ORDER TO TAG citens
		= SEEK(loc_nItem + 1)

		THIS.grd_4c_Itens.Refresh()
		THIS.LockScreen = .F.
		THIS.grd_4c_Itens.Column1.SetFocus()
	ENDPROC

	*==========================================================================
	* BtnExcluirLinhaClick - legado SIGOPORC.btnExcluir.Click. Dois ramos,
	* igual ao legado: linha normal (Citens <> Citem2) e cabecalho de
	* BLOCO/SUB-BLOCO (Citens = Citem2). No cabecalho de bloco/sub-bloco so
	* remove o bloco inteiro quando ele NAO tem nenhum item real (!Empty
	* (cpros)) - caso contrario deixa como esta (igual ao legado: o IF
	* TmpTotBlo.NItem = 0 so entra quando nao ha produto algum no bloco).
	*
	* FICA PARA FASE POSTERIOR (cursor_4c_Parcelas/SigCdOpe.DigItens ainda
	* nao carregados): renumeracao espelhada em crSigMvOrp e a troca de TAG
	* de ordenacao (Citens x CitenCria) conforme modo Criacao.
	*==========================================================================
	PROCEDURE BtnExcluirLinhaClick()
		LOCAL loc_cCursor, loc_nItem, loc_nItem2, loc_nItem3, loc_nItAgr, loc_nTotalItens

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
		IF !USED(loc_cCursor)
			RETURN
		ENDIF

		SELECT (loc_cCursor)
		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
			RETURN
		ENDIF

		THIS.LockScreen = .T.

		IF citens = citem2
			*-- Cabecalho de BLOCO ou SUB-BLOCO
			loc_nItem  = citens
			loc_nItem2 = citem2
			loc_nItem3 = citem3

			IF loc_nItem = loc_nItem2 AND loc_nItem = loc_nItem3
				*-- BLOCO: so apaga se nao houver NENHUM item real dentro dele
				SELECT COUNT(1) AS nitem FROM (loc_cCursor) ;
					WHERE citem3 = loc_nItem3 ;
					AND !INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
					AND !EMPTY(cpros) ;
					GROUP BY citem3 INTO CURSOR cursor_4c_TmpBloco

				IF !USED("cursor_4c_TmpBloco") OR cursor_4c_TmpBloco.nitem = 0
					SELECT COUNT(1) AS nitem FROM (loc_cCursor) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpBloco
					loc_nTotalItens = cursor_4c_TmpBloco.nitem

					SELECT (loc_cCursor)
					DELETE FOR citem3 = loc_nItem3 ;
						AND !INLIST(ALLTRIM(NVL(cblocos, "")), "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")

					SET ORDER TO
					SCAN FOR citens > loc_nItem
						REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - loc_nTotalItens), ;
							citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - loc_nTotalItens), ;
							citens WITH citens - loc_nTotalItens, ;
							citagrs WITH citagrs - loc_nTotalItens
					ENDSCAN
				ENDIF
			ELSE
				*-- SUB-BLOCO: so apaga se nao houver NENHUM item real dentro dele
				SELECT COUNT(1) AS nitem FROM (loc_cCursor) ;
					WHERE citem2 = loc_nItem2 ;
					AND !INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
					AND !EMPTY(cpros) ;
					GROUP BY citem2 INTO CURSOR cursor_4c_TmpBloco

				IF !USED("cursor_4c_TmpBloco") OR cursor_4c_TmpBloco.nitem = 0
					SELECT COUNT(1) AS nitem FROM (loc_cCursor) WHERE citem2 = loc_nItem2 INTO CURSOR cursor_4c_TmpBloco
					loc_nTotalItens = cursor_4c_TmpBloco.nitem

					SELECT (loc_cCursor)
					DELETE FOR citem2 = loc_nItem2 ;
						AND !INLIST(ALLTRIM(NVL(cblocos, "")), "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")

					SET ORDER TO
					SCAN FOR citens > loc_nItem
						REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - loc_nTotalItens), ;
							citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - loc_nTotalItens), ;
							citens WITH citens - loc_nTotalItens, ;
							citagrs WITH citagrs - loc_nTotalItens
					ENDSCAN
				ENDIF
			ENDIF

			IF USED("cursor_4c_TmpBloco")
				USE IN cursor_4c_TmpBloco
			ENDIF

			SET ORDER TO TAG citens
			= SEEK(loc_nItem)
		ELSE
			*-- Item normal (nao e cabecalho de bloco/sub-bloco)
			loc_nItem  = citens
			loc_nItem2 = citem2
			loc_nItem3 = citem3

			IF !EMPTY(vlbaixas)
				THIS.LockScreen = .F.
				MsgAviso("Item possui parcela j" + CHR(225) + " autorizada!", "Imposs" + CHR(237) + "vel excluir")
				RETURN
			ENDIF

			DELETE FOR citens = loc_nItem

			SET ORDER TO
			SCAN FOR citens > loc_nItem
				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - 1), ;
					citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - 1), ;
					citens WITH citens - 1, ;
					citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItem, 0, citagrs - 1)
			ENDSCAN

			SET ORDER TO TAG citens
			= SEEK(loc_nItem)
		ENDIF

		THIS.grd_4c_Itens.Refresh()
		THIS.LockScreen = .F.
		THIS.grd_4c_Itens.Column1.SetFocus()
	ENDPROC

	*==========================================================================
	* ConfigurarBotoesPrincipais - Fase 7/8: os botoes de ACAO do rodape que
	* faltavam (btnIteSub/btnTotItens/btnInsBlo/btnInsSub/btnCadPro/OK do
	* legado). Posicao/Picture/Caption/ToolTipText TRANSCRITOS do dump
	* ("PROPRIEDADES DE: SIGOPORC.<nome>"). Mesma familia visual dos botoes
	* de linha ja criados em ConfigurarBotoesItens (Comic Sans MS, ForeColor
	* RGB(90,90,90), Themes=.T.+DisabledPicture - regra do standalone com
	* Picture).
	*
	* obj_4c_OK (CommandGroup, ButtonCount=1) e o unico botao de COMANDO DE
	* GRUPO desta tela - o legado usa commandgroup so para herdar o
	* comportamento de Cancel=.T. (ESC fecha o dialogo). BINDEVENT vai no
	* proprio Buttons(1) (regra: WITH .Buttons(N) DENTRO do WITH que abre o
	* grupo e seguro).
	*
	* btnTotItens NAO tem PROCEDURE When no dump (fica sempre habilitado,
	* mesmo em CONSULTAR - ver totais nao exige direito de edicao); os
	* demais repetem o guard INSERIR/ALTERAR ja usado pelos outros botoes de
	* acao desta tela. cmd_4c_CadPro nasce Enabled=.F. - o estado real
	* depende da linha corrente (AtualizarEstadoCadastroProduto, chamado
	* pelo AfterRowColChange e pelo CarregarDados).
	*==========================================================================
	PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
		LOCAL loc_lPodeEditar
		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

		THIS.AddObject("cmd_4c_TotItens", "CommandButton")
		WITH THIS.cmd_4c_TotItens
			.Top             = 3
			.Left            = 400
			.Height          = 75
			.Width           = 75
			.FontBold        = .T.
			.FontItalic      = .T.
			.FontName        = "Comic Sans MS"
			.FontSize        = 8
			.WordWrap        = .T.
			.Caption         = "Total"
			.ToolTipText     = "Total"
			.PicturePosition = 13
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
			.Enabled         = .T.
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_TotItens, "Click", THIS, "BtnTotalItensClick")

		THIS.AddObject("cmd_4c_IteSub", "CommandButton")
		WITH THIS.cmd_4c_IteSub
			.Top             = 3
			.Left            = 475
			.Height          = 75
			.Width           = 75
			.FontBold        = .T.
			.FontItalic      = .T.
			.FontName        = "Comic Sans MS"
			.FontSize        = 8
			.WordWrap        = .T.
			.Caption         = "Itens Subn" + CHR(237) + "vel"
			.ToolTipText     = ""
			.PicturePosition = 13
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
			.Enabled         = loc_lPodeEditar
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_IteSub, "Click", THIS, "BtnItensSubnivelClick")

		THIS.AddObject("cmd_4c_InsBlo", "CommandButton")
		WITH THIS.cmd_4c_InsBlo
			.Top             = 3
			.Left            = 550
			.Height          = 75
			.Width           = 75
			.FontBold        = .T.
			.FontItalic      = .T.
			.FontName        = "Comic Sans MS"
			.FontSize        = 8
			.WordWrap        = .F.
			.Caption         = "Inserir Bloco"
			.ToolTipText     = "Inserir linha"
			.PicturePosition = 13
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
			.Enabled         = loc_lPodeEditar
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_InsBlo, "Click", THIS, "BtnInserirBlocoClick")

		THIS.AddObject("cmd_4c_InsSub", "CommandButton")
		WITH THIS.cmd_4c_InsSub
			.Top             = 3
			.Left            = 625
			.Height          = 75
			.Width           = 75
			.FontBold        = .T.
			.FontItalic      = .T.
			.FontName        = "Comic Sans MS"
			.FontSize        = 8
			.WordWrap        = .T.
			.Caption         = "Inserir Sub-bloco"
			.ToolTipText     = "Inserir linha"
			.PicturePosition = 13
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
			.Enabled         = loc_lPodeEditar
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_InsSub, "Click", THIS, "BtnInserirSubBlocoClick")

		THIS.AddObject("cmd_4c_CadPro", "CommandButton")
		WITH THIS.cmd_4c_CadPro
			.Top             = 3
			.Left            = 850
			.Height          = 75
			.Width           = 75
			.FontBold        = .T.
			.FontItalic      = .T.
			.FontName        = "Comic Sans MS"
			.FontSize        = 8
			.WordWrap        = .T.
			.Caption         = "Cadastro de Produtos"
			.ToolTipText     = "Cadastro de Produtos"
			.PicturePosition = 13
			.ForeColor       = RGB(90, 90, 90)
			.BackColor       = RGB(255, 255, 255)
			.Themes          = .T.
			.Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
			.DisabledPicture = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
			.Enabled         = .F.
			.Visible         = .T.
		ENDWITH
		BINDEVENT(THIS.cmd_4c_CadPro, "Click", THIS, "BtnCadastroProdutoClick")

		THIS.AddObject("obj_4c_OK", "CommandGroup")
		WITH THIS.obj_4c_OK
			.ButtonCount = 1
			.Top         = -2
			.Left        = 920
			.Height      = 85
			.Width       = 85
			.BackStyle   = 0
			.BorderStyle = 0
			.Themes      = .T.
			WITH .Buttons(1)
				.Top             = 5
				.Left            = 5
				.Height          = 75
				.Width           = 75
				.FontBold        = .T.
				.FontItalic      = .T.
				.FontName        = "Comic Sans MS"
				.FontSize        = 8
				.WordWrap        = .T.
				.Cancel          = .T.
				.Caption         = "Retornar"
				.ToolTipText     = "[Esc] Voltar Para a Tela Principal da Opera" + CHR(231) + CHR(227) + "o"
				.PicturePosition = 13
				.ForeColor       = RGB(90, 90, 90)
				.BackColor       = RGB(255, 255, 255)
				.Themes          = .T.
				.Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
				.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
			ENDWITH
			.Visible = .T.
		ENDWITH
		BINDEVENT(THIS.obj_4c_OK.Buttons(1), "Click", THIS, "BtnSalvarClick")
	ENDPROC

	*==========================================================================
	* BtnSalvarClick - legado SIGOPORC.OK.btnSair.Click. Fora do modo
	* CONSULTAR, valida (percentuais de NF/incentivo <= 100%, previsao de
	* pagamento completa, decupagem com previsao batendo com o Real) e, se
	* tudo passar, APAGA as linhas em branco e GRAVA cada linha remanescente
	* no SQL Server.
	*
	* DIFERENCA ARQUITETURAL DOCUMENTADA: o legado acumula tudo num cursor
	* intermediario do FORM PAI (crTpmMvItn) e EXCLUI os marcadores de
	* bloco/subtotal dessa lista - a gravacao real em lote e feita pelo
	* pai, em outro momento. Esta migracao grava CADA linha direto no SQL
	* Server, sem cursor intermediario nem form pai para delegar o lote;
	* por isso TODAS as linhas remanescentes (inclusive marcadores) sao
	* persistidas aqui - sem isso, a estrutura de blocos/subtotais do
	* orcamento se perderia a cada vez que o dialogo fosse reaberto.
	*
	* Falha de gravacao NUNCA fecha o dialogo em silencio (regra #20/#1):
	* BO.Inserir/Atualizar ja exibem o erro; o loc_lContinuar=.F. so evita
	* chamadas em cascata e mantem o dialogo aberto para o usuario tentar
	* de novo.
	*==========================================================================
	PROCEDURE BtnSalvarClick()
		LOCAL loc_cItens, loc_cParcelas, loc_lContinuar, loc_oErro, loc_nItem, ;
			loc_cDpros, loc_lItemOk, loc_cSQL, loc_nResultado, loc_cChaveNova, ;
			loc_cPkChaveNova

		*-- Legado: fora de INSERIR/ALTERAR o Click pula TODO o bloco de
		*-- validacao/gravacao e cai direto em "ThisForm.release()" - e
		*-- exatamente o que BtnCancelarClick faz (saida sem persistir).
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			THIS.BtnCancelarClick()
			RETURN
		ENDIF

		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

		IF !USED(loc_cItens) OR !USED(loc_cParcelas)
			THIS.BtnCancelarClick()
			RETURN
		ENDIF

		*-- TELA -> BO antes de qualquer validacao/gravacao: no legado os 5
		*-- percentuais do topo chegavam ao cabecalho sozinhos (ControlSource
		*-- = TprMvCab.<coluna>); aqui a transferencia e manual e passa por
		*-- FormParaBO (ver cabecalho dele).
		IF !THIS.FormParaBO()
			RETURN
		ENDIF

		loc_lContinuar = .T.

		TRY
			*-- Legado: as validacoes abaixo SO correm fora do modo P&G
			*-- (LocalEmp.DivNotas <> 2)
			IF THIS.this_oBusinessObject.this_nDivNotas <> 2
				SELECT (loc_cItens)
				SET ORDER TO TAG citens
				GO TOP
				LOCATE FOR perc2s + perc3s > 100
				IF FOUND()
					MsgAviso("Existe item com percentual de NF maior que 100%.", "Aviso")
					THIS.grd_4c_Itens.Column25.SetFocus()
					loc_lContinuar = .F.
				ENDIF

				IF loc_lContinuar
					SELECT (loc_cItens)
					GO TOP
					LOCATE FOR perc4s + perc5s + perc6s > 100
					IF FOUND()
						MsgAviso("Existe item com percentual de incentivos maior que 100%.", "Aviso")
						THIS.grd_4c_Itens.Column22.SetFocus()
						loc_lContinuar = .F.
					ENDIF
				ENDIF

				IF loc_lContinuar
					*-- Previsao de pagamento incompleta - varre TODAS as
					*-- parcelas (nao so as do item corrente): desliga o SET
					*-- KEY temporariamente e restaura no final.
					SELECT (loc_cParcelas)
					SET ORDER TO TAG citens
					SET KEY TO
					GO TOP
					SCAN
						IF !(EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)) AND ;
								(EMPTY(ifors) OR EMPTY(percs) OR EMPTY(datas))
							loc_nItem  = citens
							loc_cDpros = ""
							IF SEEK(loc_nItem, loc_cItens, "citens")
								loc_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".dpros"), ""))
							ENDIF
							MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
								loc_cDpros + "' incompleta.", "Aviso")
							loc_lContinuar = .F.
							EXIT
						ENDIF
					ENDSCAN
					THIS.PosicionarParcelasDoItem()
				ENDIF

				IF loc_lContinuar AND INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cConfigGers, 192, 1))) = 1
					IF USED("cursor_4c_TmpTotPrev")
						USE IN cursor_4c_TmpTotPrev
					ENDIF
					SELECT a.citens, a.dpros, (a.tota7s + a.tota8s) AS totreal, ;
							SUM(NVL(b.valos, 0)) AS totprev ;
						FROM (loc_cItens) a LEFT JOIN (loc_cParcelas) b ON a.citens = b.citens ;
						WHERE !EMPTY(a.cpros) ;
						GROUP BY a.citens, a.dpros, 3 ;
						HAVING totreal > 0 AND (ISNULL(totprev) OR totprev <> totreal) ;
						INTO CURSOR cursor_4c_TmpTotPrev

					IF USED("cursor_4c_TmpTotPrev") AND RECCOUNT("cursor_4c_TmpTotPrev") > 0
						MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
							ALLTRIM(cursor_4c_TmpTotPrev.dpros) + "' " + CHR(13) + ;
							"n" + CHR(227) + "o informada ou com valor diferente do Real Custos Internos + Real Fornecedor", ;
							"Aviso")
						THIS.grd_4c_Itens.Column1.SetFocus()
						loc_lContinuar = .F.
					ENDIF

					IF USED("cursor_4c_TmpTotPrev")
						USE IN cursor_4c_TmpTotPrev
					ENDIF
				ENDIF
			ENDIF

			IF loc_lContinuar
				*-- Legado: "Delete For Empty(Dpros) And Citens<>Citem2 And cBlocos<>[BRANCO]"
				SELECT (loc_cItens)
				DELETE FOR EMPTY(dpros) AND citens <> citem2 AND ALLTRIM(cblocos) <> "BRANCO"

				*-- Legado: "Delete For Empty(Ifors) And Empty(Percs) And Empty(Datas)"
				SELECT (loc_cParcelas)
				SET KEY TO
				DELETE FOR EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)

				*-- Persiste TODOS os itens remanescentes (ver nota da
				*-- diferenca arquitetural no cabecalho do metodo)
				SELECT (loc_cItens)
				SET ORDER TO TAG citens
				GO TOP
				SCAN
					THIS.this_oBusinessObject.CarregarDoCursor(loc_cItens)
					THIS.this_oBusinessObject.this_cEmps  = THIS.this_cEmps
					THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
					THIS.this_oBusinessObject.this_nNumes = THIS.this_nNumes

					IF EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCidchaves, "")))
						loc_lItemOk = THIS.this_oBusinessObject.Inserir()
					ELSE
						loc_lItemOk = THIS.this_oBusinessObject.Atualizar()
					ENDIF

					IF !loc_lItemOk
						loc_lContinuar = .F.
						EXIT
					ENDIF

					loc_cChaveNova   = THIS.this_oBusinessObject.this_cCidchaves
					loc_cPkChaveNova = THIS.this_oBusinessObject.this_cPkchaves
					REPLACE cidchaves WITH loc_cChaveNova, pkchaves WITH loc_cPkChaveNova
				ENDSCAN
			ENDIF

			IF loc_lContinuar
				*-- Persiste as parcelas remanescentes (SigMvOrp) - este BO e
				*-- de SigMvOrc; parcela nao tem propriedades proprias (regra
				*-- ja documentada no cabecalho de BtnIncluirParcelaClick: a
				*-- persistencia so acontece aqui, na confirmacao do dialogo)
				SELECT (loc_cParcelas)
				SET ORDER TO TAG citens
				GO TOP
				SCAN
					IF EMPTY(ALLTRIM(NVL(cidchaves, "")))
						loc_cChaveNova = LEFT(fUniqueIds(), 20)

						loc_cSQL = "INSERT INTO SigMvOrp ("
						loc_cSQL = loc_cSQL + "cidchaves, citens, datas, dopes, empdopnums, emps,"
						loc_cSQL = loc_cSQL + " numes, percs, valos, vlbaixas, borderos, ifors, valcreds"
						loc_cSQL = loc_cSQL + ") VALUES ("
						loc_cSQL = loc_cSQL + EscaparSQL(loc_cChaveNova) + ","
						loc_cSQL = loc_cSQL + FormatarNumeroSQL(citens, 0) + ","
						loc_cSQL = loc_cSQL + FormatarDataSQL(datas) + ","
						loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 29)) + ","
						loc_cSQL = loc_cSQL + EscaparSQL(PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)) + ","
						loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmps) + ","
						loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
						loc_cSQL = loc_cSQL + FormatarNumeroSQL(percs, 2) + ","
						loc_cSQL = loc_cSQL + FormatarNumeroSQL(valos, 2) + ","
						loc_cSQL = loc_cSQL + FormatarNumeroSQL(vlbaixas, 2) + ","
						loc_cSQL = loc_cSQL + FormatarNumeroSQL(NVL(borderos, 0), 0) + ","
						loc_cSQL = loc_cSQL + EscaparSQL(LEFT(ifors, 10)) + ","
						loc_cSQL = loc_cSQL + FormatarNumeroSQL(NVL(valcreds, 0), 2) + ")"

						IF USED("cursor_4c_InsertParc")
							USE IN cursor_4c_InsertParc
						ENDIF
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsertParc")
						IF USED("cursor_4c_InsertParc")
							USE IN cursor_4c_InsertParc
						ENDIF

						IF loc_nResultado < 0
							MsgErro("Erro ao inserir previs" + CHR(227) + "o de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lContinuar = .F.
							EXIT
						ENDIF

						REPLACE cidchaves WITH loc_cChaveNova
					ELSE
						loc_cSQL = "UPDATE SigMvOrp SET"
						loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(citens, 0) + ","
						loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(datas) + ","
						loc_cSQL = loc_cSQL + " percs = " + FormatarNumeroSQL(percs, 2) + ","
						loc_cSQL = loc_cSQL + " valos = " + FormatarNumeroSQL(valos, 2) + ","
						loc_cSQL = loc_cSQL + " vlbaixas = " + FormatarNumeroSQL(vlbaixas, 2) + ","
						loc_cSQL = loc_cSQL + " ifors = " + EscaparSQL(LEFT(ifors, 10))
						loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(cidchaves, 20))

						IF USED("cursor_4c_UpdateParc")
							USE IN cursor_4c_UpdateParc
						ENDIF
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdateParc")
						IF USED("cursor_4c_UpdateParc")
							USE IN cursor_4c_UpdateParc
						ENDIF

						IF loc_nResultado < 0
							MsgErro("Erro ao atualizar previs" + CHR(227) + "o de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lContinuar = .F.
							EXIT
						ENDIF
					ENDIF
				ENDSCAN
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.BtnSalvarClick")
			loc_lContinuar = .F.
		ENDTRY

		IF !loc_lContinuar
			THIS.PosicionarParcelasDoItem()
			THIS.grd_4c_Parcelas.Refresh()
			THIS.grd_4c_Itens.Refresh()
			RETURN
		ENDIF

		*-- Legado: "ThisForm.ParentForm.totite = fTotalizarItn(...)" +
		*-- "ThisForm.ParentForm.atuatot()" - best-effort: o form de
		*-- cabecalho do Orcamento pode nao ter esse metodo ainda (fora do
		*-- escopo desta task) - a chamada so acontece se o metodo existir,
		*-- para nao impedir o fechamento do dialogo.
		IF VARTYPE(THIS.this_oFormPai) = "O"
			IF PEMSTATUS(THIS.this_oFormPai, "AtualizarTotaisOrcamento", 5)
				THIS.this_oFormPai.AtualizarTotaisOrcamento()
			ENDIF
		ENDIF

		THIS.Release()
	ENDPROC

	*==========================================================================
	* BtnInserirBlocoClick - legado SIGOPORC.btnInsBlo.Click. Insere um novo
	* BLOCO (par de linhas: cabecalho + SUBTOTAL) IMEDIATAMENTE DEPOIS do
	* subtotal do bloco atual (ou depois do item corrente, se o bloco ainda
	* nao tiver subtotal), renumerando Citens/Citem2/Citem3 de tudo que vem
	* depois (igual ao legado) e espelhando a renumeracao nas parcelas do
	* item deslocado (cursor_4c_Parcelas, via o mesmo truque de negativar/
	* voltar ao positivo que evita colisao de chave durante o SCAN).
	*
	* NAO PORTADO: o ramo "Inlist(crSigCdOpe.DigItens,6,7)" do legado insere
	* sub-itens lendo crSigOpCdI.JOB_MV_BLO - a tabela SigOpCdI NAO EXISTE
	* no schema canonico (docs\schema.sql, regra #14 - zero ocorrencias,
	* nao e falso-negativo de encoding). Sem a fonte de dados, esse ramo e
	* impossivel de transcrever; o bloco sempre nasce com as 2 linhas
	* (cabecalho + SUBTOTAL), igual ao caso "nao-Criacao" do legado.
	*==========================================================================
	PROCEDURE BtnInserirBlocoClick()
		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_nItem2, loc_nItem3, ;
			loc_cBloco, loc_nItAnt, loc_oErro

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

		IF !USED(loc_cItens) OR EOF(loc_cItens)
			RETURN
		ENDIF

		SELECT (loc_cItens)
		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
			RETURN
		ENDIF

		THIS.LockScreen = .T.

		TRY
			SET ORDER TO TAG citens

			loc_nItem  = IIF(EMPTY(citens), 0, citens)
			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
			loc_cBloco = cblocos

			SELECT MAX(citens) AS citens FROM (loc_cItens) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpSub
			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
					loc_nItem  = EVALUATE(loc_cItens + ".citens")
					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
					loc_cBloco = ""
				ENDIF
			ENDIF
			IF USED("cursor_4c_TmpSub")
				USE IN cursor_4c_TmpSub
			ENDIF

			SELECT (loc_cItens)
			SET ORDER TO
			SCAN FOR citens > loc_nItem
				loc_nItAnt = citens
				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 4), ;
					citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 + 4), ;
					citens WITH citens + 4

				SELECT (loc_cParcelas)
				SET ORDER TO
				GO TOP
				REPLACE ALL citens WITH (loc_nItAnt + 4) * (-1) FOR citens = loc_nItAnt
				SELECT (loc_cItens)
			ENDSCAN

			SELECT (loc_cParcelas)
			GO TOP
			REPLACE ALL citens WITH ABS(citens)

			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos) ;
				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 1, loc_nItem + 1, loc_nItem + 1, loc_cBloco)

			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros, dpro2s) ;
				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 4, loc_nItem + 4, loc_nItem + 1, "SUBTOTAL", "SUBTOTAL", loc_cBloco)

			IF THIS.this_oBusinessObject.this_nDivNotas = 2
				SELECT (loc_cItens)
				GO TOP
				LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
				IF !FOUND()
					SELECT MAX(citens) AS citens FROM (loc_cItens) INTO CURSOR cursor_4c_TmpSub
					IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub")
						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
								cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, "BRANCO", "")

						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
								cursor_4c_TmpSub.citens + 2, cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, "TOTALGERAL", "TOTAL GERAL")
					ENDIF
					IF USED("cursor_4c_TmpSub")
						USE IN cursor_4c_TmpSub
					ENDIF
				ENDIF
			ENDIF

			SELECT (loc_cItens)
			SET ORDER TO TAG citens
			= SEEK(loc_nItem + 1)

			THIS.PosicionarParcelasDoItem()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.BtnInserirBlocoClick")
		ENDTRY

		THIS.grd_4c_Itens.Refresh()
		THIS.grd_4c_Parcelas.Refresh()
		THIS.LockScreen = .F.
		THIS.grd_4c_Itens.Column1.SetFocus()
	ENDPROC

	*==========================================================================
	* BtnInserirSubBlocoClick - legado SIGOPORC.btnInsSub.Click. Mesma ideia
	* de BtnInserirBlocoClick, mas agrupando por SUB-BLOCO (Citem2) dentro
	* do bloco atual (Citem3) - desloca so +2 (cabecalho + SUBTOTAL do
	* sub-bloco), sem o +2 extra de JOB_MV_BLO que so existe no modo
	* Criacao - nao portado pelo mesmo motivo de BtnInserirBlocoClick
	* (SigOpCdI nao existe no schema).
	*==========================================================================
	PROCEDURE BtnInserirSubBlocoClick()
		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_nItem2, loc_nItem3, ;
			loc_cBloco, loc_nItAnt, loc_oErro

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

		IF !USED(loc_cItens) OR EOF(loc_cItens)
			RETURN
		ENDIF

		SELECT (loc_cItens)
		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
			RETURN
		ENDIF

		THIS.LockScreen = .T.

		TRY
			SET ORDER TO TAG citens

			loc_nItem  = IIF(EMPTY(citens), 0, citens)
			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
			loc_cBloco = cblocos

			SELECT MAX(citens) AS citens FROM (loc_cItens) ;
				WHERE citem3 = loc_nItem3 AND citem2 = loc_nItem2 AND ALLTRIM(cblocos) == "SUBTOTAL" ;
				INTO CURSOR cursor_4c_TmpSub
			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
					loc_nItem  = EVALUATE(loc_cItens + ".citens")
					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
					loc_cBloco = ""
				ENDIF
			ENDIF
			IF USED("cursor_4c_TmpSub")
				USE IN cursor_4c_TmpSub
			ENDIF

			SELECT (loc_cItens)
			SET ORDER TO
			SCAN FOR citens > loc_nItem
				loc_nItAnt = citens
				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 2), ;
					citem2 WITH citem2 + 2, ;
					citens WITH citens + 2

				SELECT (loc_cParcelas)
				SET ORDER TO
				GO TOP
				REPLACE ALL citens WITH (loc_nItAnt + 2) * (-1) FOR citens = loc_nItAnt
				SELECT (loc_cItens)
			ENDSCAN

			SELECT (loc_cParcelas)
			GO TOP
			REPLACE ALL citens WITH ABS(citens)

			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos) ;
				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 1, loc_nItem + 1, loc_nItem3, loc_cBloco)

			INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, loc_nItem + 2, loc_nItem + 1, loc_nItem3, "SUBTOTAL", "SUBTOTAL")

			IF THIS.this_oBusinessObject.this_nDivNotas = 2
				SELECT (loc_cItens)
				GO TOP
				LOCATE FOR ALLTRIM(cblocos) == "TOTALGERAL"
				IF !FOUND()
					SELECT MAX(citens) AS citens FROM (loc_cItens) INTO CURSOR cursor_4c_TmpSub
					IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub")
						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
								cursor_4c_TmpSub.citens + 1, cursor_4c_TmpSub.citens, cursor_4c_TmpSub.citens, "BRANCO", "")

						INSERT INTO (loc_cItens) (emps, dopes, numes, citens, citem2, citem3, cblocos, dpros) ;
							VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
								cursor_4c_TmpSub.citens + 2, cursor_4c_TmpSub.citens, cursor_4c_TmpSub.citens, "TOTALGERAL", "TOTAL GERAL")
					ENDIF
					IF USED("cursor_4c_TmpSub")
						USE IN cursor_4c_TmpSub
					ENDIF
				ENDIF
			ENDIF

			SELECT (loc_cItens)
			SET ORDER TO TAG citens
			= SEEK(loc_nItem + 1)

			THIS.PosicionarParcelasDoItem()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.BtnInserirSubBlocoClick")
		ENDTRY

		THIS.grd_4c_Itens.Refresh()
		THIS.grd_4c_Parcelas.Refresh()
		THIS.LockScreen = .F.
		THIS.grd_4c_Itens.Column1.SetFocus()
	ENDPROC

	*==========================================================================
	* BtnItensSubnivelClick / BtnTotalItensClick - legado SIGOPORC.btnIteSub/
	* btnTotItens.Click ("ThisForm.Enabled = .f. / Do Form SigOpTor With
	* ThisForm, ThisForm.DataSessionId[, 'I']"). SigOpTor e um dialogo
	* LEGADO SEPARADO (detalhe de itens em subnivel / totalizacao) que
	* NUNCA foi migrado para este projeto (sem task propria, sem
	* FormSigOpTor em nenhuma pasta de forms).
	*
	* NAO E POSSIVEL abrir algo que nao existe. Em vez de inventar um
	* dialogo substituto (violaria o PILAR 2/3 - arquitetura e
	* comportamento fabricados, sem fonte no legado) ou fingir sucesso
	* silenciosamente, o clique avisa explicitamente que a funcionalidade
	* depende de uma migracao propria (SigOpTor) ainda nao feita - mesmo
	* espirito do wrapper "NAO PORTADA" ja documentado no projeto (regra
	* #27), aqui para um FORM em vez de uma funcao global.
	*==========================================================================
	PROCEDURE BtnItensSubnivelClick()
		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF
		THIS.AvisarSigOpTorPendente("I")
	ENDPROC

	PROCEDURE BtnTotalItensClick()
		THIS.AvisarSigOpTorPendente("")
	ENDPROC

	*==========================================================================
	* AvisarSigOpTorPendente - ver cabecalho de BtnItensSubnivelClick/
	* BtnTotalItensClick. par_cModo = "I" (Itens em Subnivel) ou ""
	* (Total de Itens) - equivale ao 3o parametro do "Do Form SigOpTor" do
	* legado, sem uso aqui alem de escolher a mensagem.
	*==========================================================================
	PROTECTED PROCEDURE AvisarSigOpTorPendente(par_cModo)
		MsgAviso("Esta funcionalidade depende do dialogo SigOpTor (" + ;
			IIF(EMPTY(par_cModo), "Total de Itens", "Itens em Subn" + CHR(237) + "vel") + ;
			"), que ainda n" + CHR(227) + "o foi migrado para o sistema novo.", ;
			"Funcionalidade pendente")
	ENDPROC

	*==========================================================================
	* BtnCadastroProdutoClick - legado SIGOPORC.btnCadPro.Click. Resolve o
	* fornecedor padrao (conta de origem/destino conforme SigCdOpe.Opers/
	* Origems/Destinos) e o grupo do produto novo (do item corrente, se ja
	* tiver Cpros, ou de txt_4c_NovoGrupo), igual ao legado.
	*
	* ESCOPO REDUZIDO, DOCUMENTADO: o legado abre SigCdPro.Scx com SETE
	* parametros posicionais e RECEBE de volta o codigo do produto criado
	* na MESMA chamada ("Do Form ... To lcCodProduto"), para em seguida
	* rodar uma cascata de precificacao automatica (SigCdOpe.PrecoAuts/
	* PrecoPs) e preencher o item sozinho. FormProduto (CRUD ja migrado em
	* task propria) usa o padrao de Init PADRAO do projeto (sem
	* parametros, sem retorno sincrono) - mudar a assinatura de
	* FormProduto para aceitar esse contrato extenderia o escopo desta
	* task (781) para dentro da task de FormProduto.
	*
	* Por isso: valida o guard (igual ao legado), resolve e mostra o
	* grupo/fornecedor, abre FormProduto em modo INCLUIR normal e - depois
	* do form fechar - pede ao usuario para digitar o codigo do produto
	* recem-cadastrado no campo da grade (aciona ValidarProdutoItemKeyPress/
	* AbrirBuscaProdutoItem, ja existentes da Fase 6). A cascata de
	* precificacao automatica NAO RODA neste fluxo - o lookup normal
	* preenche Dpros/Cunis/CuniPs, mas nao a moeda/preco automatico que so
	* o retorno sincrono do legado disparava.
	*==========================================================================
	PROCEDURE BtnCadastroProdutoClick()
		LOCAL loc_cItens, loc_cCodFornec, loc_cGrupo, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro

		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
			RETURN
		ENDIF

		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
		IF !USED(loc_cItens) OR EOF(loc_cItens)
			RETURN
		ENDIF

		loc_cCodFornec = ""
		IF THIS.this_oBusinessObject.this_nOpers = 1 AND THIS.this_oBusinessObject.this_nOrigems = 1
			loc_cCodFornec = THIS.this_oBusinessObject.this_cContaOs
		ELSE
			IF THIS.this_oBusinessObject.this_nOpers = 2 AND THIS.this_oBusinessObject.this_nDestinos = 1
				loc_cCodFornec = THIS.this_oBusinessObject.this_cContaDs
			ELSE
				IF THIS.this_oBusinessObject.this_nOrigems = 1
					loc_cCodFornec = THIS.this_oBusinessObject.this_cContaOs
				ELSE
					IF THIS.this_oBusinessObject.this_nDestinos = 1
						loc_cCodFornec = THIS.this_oBusinessObject.this_cContaDs
					ENDIF
				ENDIF
			ENDIF
		ENDIF

		IF !INLIST(THIS.this_oBusinessObject.this_nCadProds, 0, 2)
			SELECT (loc_cItens)
			IF EMPTY(cpros) AND EMPTY(THIS.txt_4c_NovoGrupo.Value)
				MsgAviso("Informe o grupo de produto para ser cadastrado!", "Aviso")
				IF THIS.txt_4c_NovoGrupo.Enabled
					THIS.txt_4c_NovoGrupo.SetFocus()
				ENDIF
				RETURN
			ENDIF

			TRY
				loc_cGrupo = ""
				IF !EMPTY(cpros)
					IF USED("cursor_4c_TmpGruPro")
						USE IN cursor_4c_TmpGruPro
					ENDIF
					loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(cpros)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGruPro")
					IF loc_nResultado > 0 AND USED("cursor_4c_TmpGruPro") AND RECCOUNT("cursor_4c_TmpGruPro") > 0
						loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_TmpGruPro.Cgrus, ""))
					ENDIF
					IF USED("cursor_4c_TmpGruPro")
						USE IN cursor_4c_TmpGruPro
					ENDIF
				ELSE
					loc_cGrupo = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
				ENDIF

				MsgInfo("Grupo de produto: " + loc_cGrupo + CHR(13) + ;
					"Fornecedor padr" + CHR(227) + "o: " + loc_cCodFornec + CHR(13) + CHR(13) + ;
					"Ap" + CHR(243) + "s cadastrar, digite o c" + CHR(243) + "digo do produto novo no item da grade.", ;
					"Cadastro de Produtos")

				GarantirClasse("FormProduto")
				loc_oForm = CREATEOBJECT("FormProduto")
				IF VARTYPE(loc_oForm) = "O"
					loc_oForm.Show()
				ENDIF
			CATCH TO loc_oErro
				MsgErro(loc_oErro.Message, "Erro em Formsigoporc.BtnCadastroProdutoClick")
			ENDTRY
		ENDIF

		THIS.grd_4c_Itens.Column1.SetFocus()
	ENDPROC

	*==========================================================================
	* CarregarLista - FUNIL de RECARGA das duas grades a partir do banco.
	* PUBLIC de proposito (o harness TesteAutomatico.prg chama metodos de
	* carga de FORA da classe, e PROTECTED estouraria "Property
	* CARREGARLISTA is not found" - regra #3).
	*
	* Equivale ao par AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...)
	* do Init legado toda vez que ele e reexecutado: le de novo SigMvOrc/
	* SigMvOrp (BO.CarregarItens/CarregarParcelas, que usam cursor
	* temporario + ZAP + APPEND FROM DBF - nunca SQLEXEC direto no alias do
	* Grid), revincula as duas grades, reposiciona e repinta.
	*
	* PRESERVA A LINHA CORRENTE: guarda o Citens do item em que o usuario
	* estava e faz SEEK depois da recarga - sem isso toda recarga jogaria o
	* usuario de volta para o primeiro item. Cai em GO TOP quando a linha
	* nao existe mais (ex.: item recem-excluido) ou na primeira carga.
	*
	* O SET KEY do mestre-detalhe (PosicionarParcelasDoItem) e DESFEITO
	* antes da recarga e reposto depois: com filtro pendurado, a releitura
	* das parcelas enxergaria so a fatia do item corrente.
	*
	* Fecha com THIS.Refresh() + Refresh() das duas grades porque popular
	* cursor NAO repinta a grade ligada a ele, e trocar ordem/chave do
	* alias tampouco (regra #21).
	*==========================================================================
	PROCEDURE CarregarLista()
		LOCAL loc_lSucesso, loc_oErro, loc_cItens, loc_cParcelas, ;
			loc_nItemAtual, loc_lAchou, loc_lModoValidacaoOuTeste
		loc_lSucesso = .F.
		loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
			(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)

		TRY
			loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
			loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

			*-- Linha corrente, para reposicionar depois da recarga
			loc_nItemAtual = 0
			IF USED(loc_cItens) AND !EOF(loc_cItens)
				loc_nItemAtual = EVALUATE(loc_cItens + ".citens")
			ENDIF

			IF USED(loc_cParcelas)
				SELECT (loc_cParcelas)
				SET KEY TO
			ENDIF

			*-- Pulado em validacao de UI / modo teste: sem conexao SQL real
			*-- (os cursores existem, so ficam vazios - mesma decisao do
			*-- CarregarDados desde a Fase 4).
			IF !loc_lModoValidacaoOuTeste
				THIS.this_oBusinessObject.CarregarItens()
				THIS.this_oBusinessObject.CarregarParcelas()
			ENDIF

			*-- ZAP + APPEND FROM preserva estrutura/RecordSource/
			*-- CurrentControl, mas Width e Header1.Caption se perdem a cada
			*-- (re)atribuicao de RecordSource (regra #41) - os dois
			*-- Vincular* reaplicam tudo e sao idempotentes.
			THIS.VincularGradeItens()
			THIS.VincularGradeParcelas()

			loc_lAchou = .F.
			IF USED(loc_cItens)
				SELECT (loc_cItens)
				SET ORDER TO TAG citens
				IF loc_nItemAtual > 0
					loc_lAchou = SEEK(loc_nItemAtual, loc_cItens, "citens")
				ENDIF
				IF !loc_lAchou
					GO TOP
				ENDIF
			ENDIF

			THIS.PosicionarParcelasDoItem()
			THIS.AtualizarEstadoCadastroProduto()

			THIS.Refresh()
			THIS.grd_4c_Itens.Refresh()
			THIS.grd_4c_Parcelas.Refresh()

			loc_lSucesso = USED(loc_cItens)
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.CarregarLista")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* NumeroDoCampo - coercao defensiva de .Value de TextBox para NUMERICO.
	* Os 5 campos de percentual nascem com .Value = 0 (numerico), mas o
	* valor pode voltar como CARACTERE quando o usuario digita num campo
	* com Format/InputMask e o VFP devolve a string da mascara - e ai
	* qualquer aritmetica estoura "Operator/operand type mismatch". Mesma
	* defesa ja usada em TotalizarItn para os campos do topo.
	*==========================================================================
	PROTECTED FUNCTION NumeroDoCampo(par_uValor)
		LOCAL loc_nValor
		loc_nValor = 0

		DO CASE
			CASE VARTYPE(par_uValor) = "N"
				loc_nValor = par_uValor
			CASE VARTYPE(par_uValor) = "C"
				loc_nValor = VAL(ALLTRIM(par_uValor))
			CASE VARTYPE(par_uValor) = "L"
				loc_nValor = IIF(par_uValor, 1, 0)
		ENDCASE

		RETURN loc_nValor
	ENDFUNC

	*==========================================================================
	* FormParaBO - TELA -> BO. Transfere os campos que sao do DIALOGO (nao
	* da grade) para as properties do Business Object, e carrega nele o
	* item da linha corrente da grade.
	*
	* No legado esses 5 campos tem ControlSource apontando para o cursor de
	* CABECALHO do form PAI (conferido um a um no dump):
	*   getPtax2    -> TprMvCab.ptax2s  -> this_nPTax2s  (Contingente/Perc1s)
	*   getPtaxa    -> TprMvCab.descs   -> this_nDescs   (Taxa Adm./Lucro, Perc2s)
	*   getPTax1    -> TprMvCab.ptax1s  -> this_nPTax1s  (BV/Perc3s)
	*   getPimposto -> TprMvCab.acres   -> this_nAcres   (Imposto, Perc4s nao-servico)
	*   getPservico -> TprMvCab.ptax3s  -> this_nPTax3s  (Imposto sem ISS, Perc4s servico)
	* Com ControlSource a sincronizacao era automatica; aqui TprMvCab nao
	* existe (o dialogo nao compartilha data session - ver cabecalho do
	* arquivo) e os cinco valores sao escalares do BO, entao a
	* sincronizacao e MANUAL e passa por este metodo.
	*
	* getPmargem (txt_4c_Margem) NAO entra: nao tem ControlSource no dump e
	* o When dele e ".f." - e resultado calculado por TotalizarItn, nunca
	* digitado nem gravado.
	*
	* PERSISTENCIA DO CABECALHO - DIVERGENCIA FIEL AO LEGADO: nem o
	* OK.btnSair.Click nem nenhum outro metodo do SIGOPORC grava TprMvCab
	* (conferido no dump: nao ha TableUpdate/Insert/Update sobre esse
	* cursor). Quem persiste SigMvCab e o form de cabecalho - este dialogo
	* so devolve os valores em memoria. Por isso FormParaBO escreve nas
	* properties do BO e NAO emite UPDATE em SigMvCab: fazer isso aqui
	* duplicaria a responsabilidade do pai e poderia sobrescrever o que ele
	* tem em edicao.
	*==========================================================================
	FUNCTION FormParaBO()
		LOCAL loc_lSucesso, loc_oErro, loc_cItens
		loc_lSucesso = .F.

		IF VARTYPE(THIS.this_oBusinessObject) <> "O"
			RETURN .F.
		ENDIF

		TRY
			THIS.this_oBusinessObject.this_nPTax2s = THIS.NumeroDoCampo(THIS.txt_4c_Contingente.Value)
			THIS.this_oBusinessObject.this_nDescs  = THIS.NumeroDoCampo(THIS.txt_4c_TaxaAdm.Value)
			THIS.this_oBusinessObject.this_nPTax1s = THIS.NumeroDoCampo(THIS.txt_4c_BV.Value)
			THIS.this_oBusinessObject.this_nAcres  = THIS.NumeroDoCampo(THIS.txt_4c_Imposto.Value)
			THIS.this_oBusinessObject.this_nPTax3s = THIS.NumeroDoCampo(THIS.txt_4c_ImpostoServico.Value)

			*-- Item da linha corrente. CarregarDoCursor sobrescreve
			*-- emps/dopes/numes com o conteudo do cursor, por isso a chave
			*-- do movimento e reafirmada DEPOIS dele (o cursor pode ter
			*-- linha recem-inserida ainda sem esses campos).
			loc_cItens   = THIS.this_oBusinessObject.this_cCursorItens
			loc_lSucesso = .T.

			IF USED(loc_cItens) AND !EOF(loc_cItens)
				loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor(loc_cItens)
			ENDIF

			THIS.this_oBusinessObject.this_cEmps  = THIS.this_cEmps
			THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
			THIS.this_oBusinessObject.this_nNumes = THIS.this_nNumes
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.FormParaBO")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*==========================================================================
	* BOParaForm - BO -> TELA. Espelha nos 5 campos de percentual os valores
	* que o BO leu de SigMvCab em CarregarConfiguracao (acres/ptax1s/
	* ptax2s/ptax3s/descs), que no legado chegavam sozinhos pelo
	* ControlSource = TprMvCab.<coluna>.
	*
	* Fase 8/8 - SEM ESTE METODO os 5 campos abriam SEMPRE em 0,00, mesmo
	* com o cabecalho do orcamento tendo percentuais gravados: nada no
	* form lia essas properties do BO. Alem de exibir errado, isso
	* contaminava o calculo - os handlers Txt*KeyPress aplicam o valor do
	* CAMPO em perc1s..perc6s de cada item, entao o primeiro Enter num
	* campo zerado zeraria o percentual de todos os itens.
	*
	* Nao toca txt_4c_Margem (resultado calculado por TotalizarItn, ver
	* FormParaBO) nem a grade: os itens/parcelas vem por CarregarLista.
	*==========================================================================
	FUNCTION BOParaForm()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		IF VARTYPE(THIS.this_oBusinessObject) <> "O"
			RETURN .F.
		ENDIF

		TRY
			THIS.txt_4c_Contingente.Value    = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax2s)
			THIS.txt_4c_TaxaAdm.Value        = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nDescs)
			THIS.txt_4c_BV.Value             = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax1s)
			THIS.txt_4c_Imposto.Value        = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nAcres)
			THIS.txt_4c_ImpostoServico.Value = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax3s)

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.BOParaForm")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*==========================================================================
	* HabilitarCampos - centraliza o .Enabled dos CAMPOS do dialogo (os
	* botoes ficam em AjustarBotoesPorModo). Transcreve os "When" do dump:
	*
	*   getPtax2/getPtaxa/getPTax1/getPimposto/getPservico/get_NewGrp
	*                 -> Inlist(thisform.Op_Escolha,[INSERIR],[ALTERAR])
	*   getPmargem    -> Return .f.            (NUNCA editavel)
	*   getDpros/getDpro2s -> Return thisform.lProcura
	*   getDescritivo -> Inlist(Op_Escolha,[INSERIR],[ALTERAR]) And
	*                    <linha normal> And Empty(VlBaixas)
	*
	* par_lHabilitar e OPCIONAL: omitido, o estado sai do MODO do dialogo
	* (o que o legado faz nos When). Passado, forca os campos editaveis -
	* usado pelo harness e por quem precisa travar a tela durante uma
	* operacao longa. PCOUNT() distingue "nao passou" de "passou .F."
	* (VARTYPE de logico e "L" nos dois casos).
	*
	* .Enabled no lugar de .ReadOnly reproduz o efeito do When (campo nao
	* alcancavel por Tab nem por clique) sem inventar estado novo. As
	* CELULAS das duas grades seguem o ReadOnly por coluna aplicado em
	* ConfigurarGridItens/ConfigurarGradeParcelas (cada Column tem o seu
	* proprio When no legado, e varias admitem CONSULTAR) - nao sao
	* mexidas aqui.
	*==========================================================================
	PROCEDURE HabilitarCampos(par_lHabilitar)
		LOCAL loc_lPodeEditar, loc_lModoCriacao

		IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
			loc_lPodeEditar = par_lHabilitar
		ELSE
			loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
		ENDIF

		loc_lModoCriacao = INLIST(THIS.this_oBusinessObject.this_nDigItens, 6, 7)

		*-- Percentuais editaveis (When = Inlist(Op_Escolha,INSERIR,ALTERAR))
		THIS.txt_4c_Contingente.Enabled    = loc_lPodeEditar
		THIS.txt_4c_TaxaAdm.Enabled        = loc_lPodeEditar
		THIS.txt_4c_BV.Enabled             = loc_lPodeEditar
		THIS.txt_4c_Imposto.Enabled        = loc_lPodeEditar
		THIS.txt_4c_ImpostoServico.Enabled = loc_lPodeEditar

		*-- getPmargem.When = .f. - resultado calculado, nunca digitado
		THIS.txt_4c_Margem.Enabled = .F.

		*-- get_NewGrp (When = Inlist(Op_Escolha,INSERIR,ALTERAR)). O ramo
		*-- CadProds = 4 do AfterRowColChange legado refina isso por linha
		*-- (AtualizarEstadoCadastroProduto), por isso ele roda depois.
		THIS.txt_4c_NovoGrupo.Enabled = loc_lPodeEditar

		*-- getDpros/getDpro2s.When = thisform.lProcura (o par so abre
		*-- quando btnProcura entra em modo de busca). Em modo Criacao os
		*-- dois nem aparecem na tela (AtualizarModoCriacao).
		THIS.txt_4c_ProcuraDpros.Enabled  = loc_lPodeEditar AND THIS.this_lProcura AND !loc_lModoCriacao
		THIS.edt_4c_ProcuraDpro2s.Enabled = loc_lPodeEditar AND THIS.this_lProcura AND !loc_lModoCriacao

		*-- getDescritivo: so existe no modo Criacao e so edita em
		*-- INSERIR/ALTERAR (o refino por linha - linha normal e
		*-- Empty(VlBaixas) - fica no When da propria coluna da grade,
		*-- igual ao legado)
		THIS.edt_4c_DescritivoRodape.Enabled = loc_lPodeEditar AND loc_lModoCriacao

		*-- Refino por LINHA do botao/campo de cadastro de produto
		THIS.AtualizarEstadoCadastroProduto()
	ENDPROC

	*==========================================================================
	* AjustarBotoesPorModo - centraliza o .Enabled dos BOTOES, transcrevendo
	* o "When" de cada um no dump:
	*
	*   btnIncluir/btnExcluir       -> Inlist(Op_Escolha,[INSERIR],[ALTERAR])
	*   btnInsBlo/btnInsSub         -> Inlist(Op_Escolha,[INSERIR],[ALTERAR])
	*   btnIteSub                   -> InList(Op_Escolha,[INSERIR],[ALTERAR])
	*   btnCadPro                   -> InList(...,'INSERIR','ALTERAR') And
	*                                  !Eof('crSigMvOrc')   (+ o refino por
	*                                  linha do AfterRowColChange)
	*   btnTotItens                 -> SEM When: sempre habilitado
	*   OK (btnSair)                -> SEM When: sempre habilitado (em
	*                                  CONSULTAR o Click so fecha)
	*   btnIncluirp/btnExcluirp     -> Inlist(Op_Escolha,[INSERIR],[ALTERAR])
	*   btnProcura                  -> Inlist(Op_Escolha,[INSERIR],[ALTERAR])
	*
	* Os TRES botoes SO-ICONE (Caption = "" no dump: btnIncluirp,
	* btnExcluirp e btnProcura) NAO recebem .Enabled = .F.: com Caption
	* vazio o VFP9 deixa de desenhar o Picture e o botao vira um retangulo
	* vazio (regra do CorretorAutomatico #106). Para esses tres o "When"
	* virou guarda no inicio do proprio handler - BINDEVENT descarta o
	* retorno do delegate, entao um When ligado por BINDEVENT nao
	* bloquearia nada mesmo.
	*
	* PUBLIC de proposito: o harness chama AjustarBotoesPorModo de FORA da
	* classe (regra #3 - PEMSTATUS devolve .T. tambem para metodo
	* PROTECTED, entao a chamada compila e estoura em runtime).
	*==========================================================================
	PROCEDURE AjustarBotoesPorModo()
		LOCAL loc_lPodeEditar
		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")

		*-- Botoes de linha da grade de itens
		THIS.cmd_4c_IncluirLinha.Enabled = loc_lPodeEditar
		THIS.cmd_4c_ExcluirLinha.Enabled = loc_lPodeEditar

		*-- Botoes de estrutura (bloco / sub-bloco) e navegacao de subnivel
		THIS.cmd_4c_InsBlo.Enabled = loc_lPodeEditar
		THIS.cmd_4c_InsSub.Enabled = loc_lPodeEditar
		THIS.cmd_4c_IteSub.Enabled = loc_lPodeEditar

		*-- btnTotItens e o OK nao tem When no legado
		THIS.cmd_4c_TotItens.Enabled = .T.
		THIS.obj_4c_OK.Enabled       = .T.

		*-- btnCadPro depende do modo E da linha corrente: quem resolve as
		*-- duas coisas (incluindo CadProds/fChecaAcesso) e o metodo de
		*-- refino, que ja trata cursor ausente/EOF.
		THIS.AtualizarEstadoCadastroProduto()
	ENDPROC

	*==========================================================================
	* LimparCampos - devolve os campos do DIALOGO ao estado de abertura.
	*
	* Nao ha "novo registro" neste form: o legado SIGOPORC nao tem botao
	* Incluir de CABECALHO (o Incluir dele e de LINHA da grade, ver
	* BtnIncluirLinhaClick) - o dialogo sempre edita os itens de UM
	* orcamento que ja existe. Entao LimparCampos NAO zera as grades: os
	* itens/parcelas pertencem ao orcamento, nao a um registro em digitacao
	* (zerar seria perda silenciosa de dado). O que ele limpa e exatamente
	* o estado AUXILIAR da tela, o mesmo que o legado reseta ao trocar de
	* linha (AfterRowColChange) e ao ligar o modo de busca (btnProcura):
	*   - a linha de busca (getDpros/getDpro2s) e a flag lProcura
	*   - o campo de grupo novo (get_NewGrp)
	*   - a pre-visualizacao da foto do produto (imgProds)
	*   - os valores anteriores usados pelos Valid (antdpros/oldpreco) e o
	*     canal de retorno dos lookups
	* Os 5 percentuais voltam ao que o BO leu do cabecalho (BOParaForm), nao
	* a zero - zerar inventaria valor e, no primeiro Enter num deles,
	* zeraria o percentual de todos os itens.
	*==========================================================================
	PROCEDURE LimparCampos()
		LOCAL loc_oErro

		TRY
			*-- Linha de busca + flag do botao de duas fases
			THIS.this_lProcura = .F.
			THIS.txt_4c_ProcuraDpros.Value  = ""
			THIS.edt_4c_ProcuraDpro2s.Value = ""

			*-- Grupo do produto novo (legado: AfterRowColChange zera
			*-- Get_NewGrp.Value quando CadProds = 4)
			THIS.txt_4c_NovoGrupo.Value = ""

			*-- Foto do produto (legado: imgProds.Visible = .f. /
			*-- imgProds.Picture = [] no topo do AfterRowColChange)
			THIS.img_4c_Produto.Visible = .F.
			THIS.img_4c_Produto.Picture = ""

			*-- Valores anteriores comparados pelos Valid e canal de retorno
			*-- dos metodos AbrirBusca*
			THIS.this_cAntDpros        = ""
			THIS.this_nOldPreco        = 0
			THIS.this_lAutPreco        = .F.
			THIS.this_cLookupCodigo    = ""
			THIS.this_cLookupDescricao = ""

			*-- Percentuais voltam ao valor do cabecalho, nao a zero
			THIS.BOParaForm()

			*-- Reaplica Visible/Enabled (a flag lProcura mudou). O proprio
			*-- AtualizarModoCriacao fecha chamando HabilitarCampos e
			*-- AjustarBotoesPorModo.
			THIS.AtualizarModoCriacao()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.LimparCampos")
		ENDTRY
	ENDPROC

	*==========================================================================
	* BtnCancelarClick - FUNIL de ABANDONO: fecha o dialogo SEM persistir
	* nada e devolve o controle ao form pai.
	*
	* O SIGOPORC legado NAO TEM botao de abandono - o CommandGroup "OK" e
	* o unico botao de saida (ButtonCount = 1 no dump) e nenhum objeto do
	* SCX tem Caption/Picture de Cancelar. Por isso aqui NAO se cria botao
	* nenhum (inventar um violaria o PILAR 1): este metodo e o CAMINHO que
	* o legado ja percorre quando o dialogo esta em CONSULTAR - o
	* OK.btnSair.Click pula todo o bloco "If Inlist(op_escolha,[INSERIR],
	* [ALTERAR])" e cai direto em "ThisForm.release()", sem gravar nada.
	* BtnSalvarClick delega a ele exatamente nesse ramo, para o caminho de
	* saida sem gravacao existir num lugar so.
	*
	* Fechar os dois cursores aqui e o que DESCARTA as edicoes em memoria:
	* eles sao LOCAIS do dialogo (CREATE CURSOR em CriarCursorItens/
	* CriarCursorParcelas), nao aliases emprestados do chamador, e a
	* persistencia acontece unicamente em BtnSalvarClick - reabrir o
	* dialogo depois disso le tudo de novo de SigMvOrc/SigMvOrp. O SET KEY
	* do mestre-detalhe sai antes, para nao deixar filtro pendurado.
	*
	* NAO pede confirmacao: o legado nao pergunta nada em nenhum caminho de
	* saida, e inventar um dialogo de confirmacao mudaria a UX (PILAR 1).
	*==========================================================================
	PROCEDURE BtnCancelarClick()
		LOCAL loc_oErro, loc_cItens, loc_cParcelas

		TRY
			IF VARTYPE(THIS.this_oBusinessObject) = "O"
				loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
				loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas

				IF USED(loc_cParcelas)
					SELECT (loc_cParcelas)
					SET KEY TO
					USE IN (loc_cParcelas)
				ENDIF

				IF USED(loc_cItens)
					USE IN (loc_cItens)
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em Formsigoporc.BtnCancelarClick")
		ENDTRY

		*-- Devolve o controle ao pai (legado: "Procedure Unload" -
		*-- ThisForm.Parentform.Enabled = .t.). Destroy repete isso para
		*-- cobrir tambem o fechamento pela barra de janela; as duas
		*-- atribuicoes sao idempotentes.
		IF VARTYPE(THIS.this_oFormPai) = "O"
			IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
				THIS.this_oFormPai.Enabled = .T.
			ENDIF
		ENDIF

		THIS.Release()
	ENDPROC

	*==========================================================================
	* Destroy - Devolve o controle ao form pai (legado: "Procedure Unload" -
	* ThisForm.Parentform.Enabled = .t., desfazendo o ThisForm.Enabled = .f.
	* que o pai aplica antes de abrir este dialogo) e solta a referencia,
	* para o dialogo filho nao manter vivo quem o abriu.
	*
	* DODEFAULT() na ULTIMA linha e obrigatorio: e o FormBase.Destroy que
	* libera o Business Object e reconstroi os popups do menu principal.
	*
	* O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
	* decisao ja documentada em FormSigOpEnt.prg/FormSIGPRMEI.prg: fConfigGeral
	* era funcao GLOBAL do legado (sig.prg/SIGFUNCS.PRG) que nao veio no
	* acervo; o wrapper NO-OP em projeto\app\utils\fconfiggeral.prg existe so
	* para o p-code dos VCX legado continuar resolvendo o nome, e em codigo
	* NOSSO nunca se chama fConfigGeral.
	*==========================================================================
	PROCEDURE Destroy()
		LOCAL loc_oErro

		TRY
			IF VARTYPE(THIS.this_oFormPai) = "O"
				IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
					THIS.this_oFormPai.Enabled = .T.
				ENDIF
			ENDIF

			*-- Os dois cursores sao LOCAIS deste dialogo (CREATE CURSOR em
			*-- CriarCursorItens/CriarCursorParcelas), nao aliases emprestados
			*-- do chamador - por isso podem e devem ser fechados aqui. Antes
			*-- de fechar o de parcelas, desfaz o SET KEY aplicado por
			*-- PosicionarParcelasDoItem, para nao deixar filtro pendurado.
			IF VARTYPE(THIS.this_oBusinessObject) = "O"
				IF USED(THIS.this_oBusinessObject.this_cCursorParcelas)
					SELECT (THIS.this_oBusinessObject.this_cCursorParcelas)
					SET KEY TO
					USE IN (THIS.this_oBusinessObject.this_cCursorParcelas)
				ENDIF

				IF USED(THIS.this_oBusinessObject.this_cCursorItens)
					USE IN (THIS.this_oBusinessObject.this_cCursorItens)
				ENDIF
			ENDIF

			THIS.this_oFormPai = .NULL.
			THIS.this_oObjExt1 = .NULL.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro em Formsigoporc.Destroy")
		ENDTRY

		DODEFAULT()
	ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigoporcBO.prg):
*====================================================================
* sigoporcBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPORC" (grade de Itens de
* um Orcamento). O legado abre este form como filho do form de
* cabecalho do movimento (Lparameters poForm, pnDatSes - Set
* Datasession To pnDatSes, isto e, o filho passa a compartilhar a MESMA
* data session do pai, com os cursores crSigMvOrc/crSigMvOrp/TprMvCab/
* crSigCdOpe/LocalEmp ja abertos por ele).
*
* Tabelas envolvidas: SigMvOrc (itens do orcamento), SigMvOrp
* (parcelas/previsoes de pagamento do item), SigMvCab (cabecalho do
* movimento - espelhado no cursor temporario TprMvCab do pai), SigCdOpe
* (configuracao da operacao), SigCdEmp (configuracao da empresa).
*
* Referencias legado -> BO:
*   TprMvCab.Emps/Dopes/Numes/MascNum -> this_cEmps/this_cDopes/
*                                        this_nNumes/this_cMascNum
*   crSigCdOpe.DigItens/CadProds/Opers/Origems/Destinos/OpePads ->
*                                        this_nDigItens/this_nCadProds/
*                                        this_nOpers/this_nOrigems/
*                                        this_nDestinos/this_cOpePads
*   LocalEmp.DivNotas (CursorQuery de SigCdEmp) -> this_nDivNotas
*   TprMvCab.ContaOs/ContaDs -> this_cContaOs/this_cContaDs
*   TprMvCab.Acres/PTax1s/PTax2s/PTax3s/Descs -> this_nAcres/this_nPTax1s/
*                                          this_nPTax2s/this_nPTax3s/this_nDescs
*   SigOpCdd.ConfigGers -> this_cConfigGers
*   Thisform.Caption -> this_cCaption
*   crSigMvOrc (grade de itens) -> this_cCursorItens ("cursor_4c_Itens")
*   crSigMvOrp (grade de parcelas) -> this_cCursorParcelas
*                                     ("cursor_4c_Parcelas")
*
* Thisform.ParentForm, Thisform.poObjExt1 (referencia ao form externo de
* pesquisa de produtos SigOpCgp) e o controle de DataSession permanecem
* no FORM (sao referencias/estado de UI, fora da responsabilidade do
* Business Object).
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigCdOpe/SigCdEmp
* (DigItens/CadProds/Opers/Origems/Destinos/OpePads/DivNotas) e as
* colunas de TprMvCab (ContaOs/ContaDs/Acres/PTax1s/PTax2s/PTax3s) serao
* carregadas por metodo proprio em fase posterior - os valores abaixo
* ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para o ITEM de SigMvOrc (chave cidchaves), com RegistrarAuditoria()
* (herdado de BusinessBase) chamado em Inserir/Atualizar. cidchaves e
* pkchaves sao as duas chaves Fortyus (fUniqueIds(), regra #22) geradas
* no Inserir quando ainda vazias. Buscar() nao e sobrescrito aqui: a
* listagem de itens (SELECT com joins de produto/unidade) fica na fase do
* BO que monta o cursor da grade (CarregarItens), porque a consulta tem
* joins e nao cabe no Buscar() generico herdado de BusinessBase.
*
* Fase 7/8 - CarregarConfiguracao() (SigCdOpe/SigCdEmp/SigOpCdd/SigMvCab,
* equivalentes aos cursores que o FORM PAI legado ja tinha abertos -
* regra #35/cabecalho acima), CarregarItens()/CarregarParcelas() (leitura
* de SigMvOrc/SigMvOrp para as duas grades - o legado faz isso via
* AddCursor no Init; aqui e feito por SQLEXEC em cursor temporario +
* ZAP/APPEND no cursor ja ligado ao Grid, regra "SQLEXEC sobre alias de
* grid zera o ColumnCount").
*
* Modo Criacao do legado (SigCdOpe.DigItens IN (6,7), com sub-blocos
* lidos de SigOpCdI.JOB_MV_BLO em btnInsBlo/btnInsSub) NAO E PORTADO: a
* tabela SigOpCdI NAO EXISTE no schema canonico (conferido em
* docs\schema.sql, regra #14 - zero ocorrencias, nao e falso-negativo de
* encoding). This_nDigItens continua sendo lido e comparado (para nao
* quebrar os outros ramos que dependem dele, como DigItens=5->CONSULTAR),
* mas o ramo exclusivo de DigItens IN (6,7) que insere sub-itens de
* JOB_MV_BLO fica de fora em btnInsBlo/btnInsSub, com o motivo documentado
* la (nao e omissao silenciosa - rule "SEMPRE FUNCIONALIDADE COMPLETA",
* mas a fonte de dados do legado para essa sub-feature nao existe mais).
*====================================================================

DEFINE CLASS sigoporcBO AS BusinessBase

	*-- Parametros recebidos do form pai na abertura do dialogo (legado:
	*-- Lparameters poForm, pnDatSes). O form migrado repassa so os
	*-- valores escalares que identificam o cabecalho do movimento
	*-- (TprMvCab/SigMvCab); poForm (referencia de UI) e a troca de
	*-- DataSession ficam no Form.
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes)
	this_cMascNum = ""              && Mascara/numero formatado do documento (TprMvCab.MascNum) - usado no Caption "Itens"

	*-- Configuracao da operacao (SigCdOpe), referente ao Dopes acima.
	*-- Controla ramos de negocio usados pelos botoes/grades desta tela.
	*-- Populados em fase posterior (leitura via SQLEXEC); default abaixo.
	this_nDigItens = 0              && SigCdOpe.DigItens - 5 forca modo CONSULTAR independente do pai (Op_Escolha)
	this_nCadProds = 0              && SigCdOpe.CadProds - habilita o botao "Cadastro de Produtos" (btnCadPro)
	this_nOpers = 0                 && SigCdOpe.Opers - 1=Entrada/2=Saida, usado para resolver o fornecedor padrao
	this_nOrigems = 0               && SigCdOpe.Origems - .T. quando a conta de origem (TprMvCab.ContaOs) e obrigatoria
	this_nDestinos = 0              && SigCdOpe.Destinos - .T. quando a conta de destino (TprMvCab.ContaDs) e obrigatoria
	this_cOpePads = ""              && SigCdOpe.OpePads - padrao de operacao usado no cadastro de produtos
	this_nImagems = 0               && SigCdOpe.Imagems - habilita a pre-visualizacao da foto do produto no AfterRowColChange (grdItem.imgProds)
	this_nConfes = 0                && SigCdOpe.Confes - quando = 1, suprime a pre-visualizacao mesmo com Imagems = 1
	this_nPrecoAuts = 0             && SigCdOpe.PrecoAuts - autoriza a precificacao automatica em btnCadPro.Click
	this_nPrecoPs = 0               && SigCdOpe.PrecoPs - origem do preco automatico (1/10=venda ou ideal, 2=custo, 5=valors, 7=ultima compra, 8/9=custo medio, 11=custo total)
	this_nPrecops = 0               && SigCdOpe.Precops - moeda/fator de venda(1) ou custo(2) a copiar do cadastro de produto
	this_cCMoes = ""                && SigCdOpe.CMoes - moeda padrao da operacao (fallback quando nao ha precificacao automatica)

	*-- Configuracao da empresa (SigCdEmp), lida via Cemps = this_cEmps
	*-- (legado: CursorQuery([SigCdEmp],[LocalEmp],[Cemps],TprMvCab.Emps,[DivNotas])).
	*-- Populada em fase posterior; default abaixo.
	this_nDivNotas = 0              && SigCdEmp.DivNotas - 1=Preco&Gerencial(P&G) / 2=SRCOM - decide a formula de rateio dos percentuais do item

	*-- Contas de origem/destino do cabecalho (TprMvCab/SigMvCab), usadas
	*-- em btnCadPro.Click para resolver o fornecedor do produto novo.
	*-- Populadas em fase posterior; default abaixo.
	this_cContaOs = ""              && Conta de Origem (TprMvCab.ContaOs)
	this_cContaDs = ""              && Conta de Destino (TprMvCab.ContaDs)

	*-- Percentuais/indices do cabecalho (TprMvCab/SigMvCab), usados como
	*-- semente dos campos de percentual do item recem-incluido.
	*-- Populados em fase posterior; default abaixo.
	this_nAcres = 0                 && TprMvCab.Acres - imposto cheio (usado quando o item NAO e servico)
	this_nPTax1s = 0                && TprMvCab.PTax1s - percentual default de BV (Perc3s)
	this_nPTax2s = 0                && TprMvCab.PTax2s - percentual default de despesa operacional/contingente (Perc1s)
	this_nPTax3s = 0                && TprMvCab.PTax3s - percentual default de imposto de servico (Perc4s quando Servicos)
	this_nDescs = 0                 && TprMvCab.Descs - percentual default de lucro/"Taxa Adm." (Perc2s)

	*-- Mascara de configuracoes gerais da operacao (SigOpCdd.ConfigGers),
	*-- lida via Dopes = this_cDopes. Posicao 192 (1 char) = flag de
	*-- Decupagem (Int(Val(Substr(ConfigGers,192,1))) = 1), usada em
	*-- TotalizarItn(). Populada em fase posterior; default "" faz a
	*-- checagem de Decupagem avaliar sempre .F. (SUBSTR/VAL de string
	*-- vazia devolve 0), que e o comportamento seguro ate a config
	*-- chegar.
	this_cConfigGers = ""
	this_nChkIfors = 0              && SigOpCdd.ChkIfors - 1/2 habilita a resolucao de preco por SigPrFnc (tabela de fornecedor) antes do padrao de SigCdMoe

	*-- Titulo montado para a tela (legado: Thisform.Caption)
	this_cCaption = ""              && "<Emps> <Dopes> <MascNum> - Itens"

	*-- Nomes dos cursores que este BO popula/consome (constantes, para o
	*-- Form referenciar sem repetir literais - equivalentes aos aliases
	*-- globais do legado crSigMvOrc/crSigMvOrp)
	this_cCursorItens = "cursor_4c_Itens"        && Grade de itens do orcamento (SigMvOrc)
	this_cCursorParcelas = "cursor_4c_Parcelas"  && Grade de parcelas/previsoes do item selecionado (SigMvOrp)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela SigMvOrc -
	*-- um ITEM da grade de orcamento, chave cidchaves). this_cEmps/
	*-- this_cDopes/this_nNumes acima (recebidos no Init) JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cCblocos    = ""   && cblocos char(30) - marcador de linha (SUBTOTAL/BRANCO/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/TOTALGERAL ou vazio = item normal)
	this_nCitem2     = 0    && citem2 numeric(10,0) - item do bloco (subtotal pai)
	this_nCitens     = 0    && citens numeric(10,0) - numero do item (PK logica dentro do orcamento)
	this_cCpros      = ""   && cpros char(14) - codigo do produto
	this_cCunips     = ""   && cunips char(3) - unidade de compra/pedido
	this_cCunis      = ""   && cunis char(3) - unidade de venda
	this_cDpro2s     = ""   && dpro2s text NULL - descricao complementar do produto
	this_cDpros      = ""   && dpros char(65) - descricao do produto/bloco
	this_cEmpdopnums = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga o item ao cabecalho
	this_nFators     = 0    && fators numeric(8,4) - fator de conversao de unidade
	this_nPesos      = 0    && pesos numeric(8,4) - peso unitario
	this_cPkchaves   = ""   && pkchaves char(20) - chave unica Fortyus (fUniqueIds(), independente de cidchaves)
	this_nQtds       = 0    && qtds numeric(8,4) - quantidade
	this_nTotas      = 0    && totas numeric(13,2) - total do item
	this_nUnits      = 0    && units numeric(13,2) - valor unitario
	this_cCidchaves  = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_cMoedas     = ""   && moedas char(3) - moeda do total de custo
	this_cMoefats    = ""   && moefats char(3) - moeda de faturamento
	this_cMoevs      = ""   && moevs char(3) - moeda de venda
	this_cNotas      = ""   && notas char(9) - numero/mascara da nota associada
	this_cObs        = ""   && obs text NULL - observacao do item
	this_cOpers      = ""   && opers char(1) - tipo de operacao do item (distinto de this_nOpers, que e config de SigCdOpe)
	this_nTota1s     = 0    && tota1s numeric(13,2) - despesa operacional (Perc1s)
	this_nTota2s     = 0    && tota2s numeric(13,2) - lucro (Perc2s)
	this_nTota3s     = 0    && tota3s numeric(13,2) - BV (Perc3s)
	this_nTota4s     = 0    && tota4s numeric(13,2) - imposto/servico (Perc4s)
	this_nTota5s     = 0    && tota5s numeric(13,2) - incentivo 1 (Perc5s)
	this_nTota6s     = 0    && tota6s numeric(13,2) - incentivo 2 (Perc6s)
	this_nTota7s     = 0    && tota7s numeric(13,2) - custo interno SRCOM
	this_nTota8s     = 0    && tota8s numeric(13,2) - valor fornecedor
	this_nTota9s     = 0    && tota9s numeric(13,2) - saldo real custo interno SRCOM
	this_nTota10s    = 0    && tota10s numeric(13,2) - saldo real fornecedor
	this_nTpesos     = 0    && tpesos numeric(8,4) - peso total
	this_nUnivals    = 0    && univals numeric(13,2) - valor unitario de venda
	this_nUtilizas   = 0    && utilizas numeric(2,0) - controle de utilizacao (fluxo de preco autorizado)
	this_lServicos   = .F.  && servicos bit - item e servico (troca a regra de calculo do imposto)
	this_nCitagrs    = 0    && citagrs numeric(10,0) - item do agrupador (decupagem)
	this_nCitem3     = 0    && citem3 numeric(10,0) - item do sub-bloco (subtotal de 2o nivel)
	this_cCodacabs   = ""   && codacabs char(3) - codigo de acabamento (SigCdAca)
	this_lDebitos    = .F.  && debitos bit - item gerado a debito (bloqueia imposto cheio)
	this_lTaxas      = .F.  && taxas bit - item e taxa (fee)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters poForm, pnDatSes do Init do
	* form legado - o form migrado repassa so os valores escalares que
	* identificam o cabecalho do movimento (poForm/pnDatSes, que sao
	* referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cMascNum)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvOrc"
		THIS.this_cCampoChave = "cidchaves"

		IF VARTYPE(par_cEmps) = "C"
			THIS.this_cEmps = par_cEmps
		ENDIF

		IF VARTYPE(par_cDopes) = "C"
			THIS.this_cDopes = par_cDopes
		ENDIF

		IF VARTYPE(par_nNumes) = "N"
			THIS.this_nNumes = par_nNumes
		ENDIF

		IF VARTYPE(par_cMascNum) = "C"
			THIS.this_cMascNum = par_cMascNum
		ENDIF

		*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+Alltrim(MascNum)+' - Itens'
		THIS.this_cCaption = ALLTRIM(THIS.this_cEmps) + " " + ALLTRIM(THIS.this_cDopes) + ;
			" " + ALLTRIM(THIS.this_cMascNum) + " - Itens"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) do item
	* corrente, para uso em RegistrarAuditoria()
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de um item de SigMvOrc
	* (cursor_4c_Itens/crSigMvOrc) para as propriedades do BO. SEMPRE usar
	* SELECT (par_cAliasCursor) antes de acessar os campos (regra #8).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCblocos = TratarNulo(cblocos, "C")
				THIS.this_nCitem2 = TratarNulo(citem2, "N")
				THIS.this_nCitens = TratarNulo(citens, "N")
				THIS.this_cCpros = TratarNulo(cpros, "C")
				THIS.this_cCunips = TratarNulo(cunips, "C")
				THIS.this_cCunis = TratarNulo(cunis, "C")
				THIS.this_cDopes = TratarNulo(dopes, "C")
				THIS.this_cDpro2s = TratarNulo(dpro2s, "C")
				THIS.this_cDpros = TratarNulo(dpros, "C")
				THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
				THIS.this_cEmps = TratarNulo(emps, "C")
				THIS.this_nFators = TratarNulo(fators, "N")
				THIS.this_nNumes = TratarNulo(numes, "N")
				THIS.this_nPesos = TratarNulo(pesos, "N")
				THIS.this_cPkchaves = TratarNulo(pkchaves, "C")
				THIS.this_nQtds = TratarNulo(qtds, "N")
				THIS.this_nTotas = TratarNulo(totas, "N")
				THIS.this_nUnits = TratarNulo(units, "N")
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cMoedas = TratarNulo(moedas, "C")
				THIS.this_cMoefats = TratarNulo(moefats, "C")
				THIS.this_cMoevs = TratarNulo(moevs, "C")
				THIS.this_cNotas = TratarNulo(notas, "C")
				THIS.this_cObs = TratarNulo(obs, "C")
				THIS.this_cOpers = TratarNulo(opers, "C")
				THIS.this_nTota1s = TratarNulo(tota1s, "N")
				THIS.this_nTota2s = TratarNulo(tota2s, "N")
				THIS.this_nTota3s = TratarNulo(tota3s, "N")
				THIS.this_nTota4s = TratarNulo(tota4s, "N")
				THIS.this_nTota5s = TratarNulo(tota5s, "N")
				THIS.this_nTota6s = TratarNulo(tota6s, "N")
				THIS.this_nTota7s = TratarNulo(tota7s, "N")
				THIS.this_nTota8s = TratarNulo(tota8s, "N")
				THIS.this_nTota9s = TratarNulo(tota9s, "N")
				THIS.this_nTota10s = TratarNulo(tota10s, "N")
				THIS.this_nTpesos = TratarNulo(tpesos, "N")
				THIS.this_nUnivals = TratarNulo(univals, "N")
				THIS.this_nUtilizas = TratarNulo(utilizas, "N")
				IF VARTYPE(servicos) = "L"
					THIS.this_lServicos = servicos
				ELSE
					THIS.this_lServicos = (NVL(servicos, 0) = 1)
				ENDIF
				THIS.this_nCitagrs = TratarNulo(citagrs, "N")
				THIS.this_nCitem3 = TratarNulo(citem3, "N")
				THIS.this_cCodacabs = TratarNulo(codacabs, "C")
				IF VARTYPE(debitos) = "L"
					THIS.this_lDebitos = debitos
				ELSE
					THIS.this_lDebitos = (NVL(debitos, 0) = 1)
				ENDIF
				IF VARTYPE(taxas) = "L"
					THIS.this_lTaxas = taxas
				ELSE
					THIS.this_lTaxas = (NVL(taxas, 0) = 1)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo item (linha) em SigMvOrc
	* PK (cidchaves) e pkchaves gerados via fUniqueIds() se ainda vazios
	* (regra #22 - PK Fortyus NUNCA pode ser string vazia)
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(NVL(THIS.this_cPkchaves, "")))
				THIS.this_cPkchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo computado: Emps + Dopes + Numes (chave posicional que liga
			*-- o item ao cabecalho - regra #42, NUNCA ALLTRIM nas partes)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "INSERT INTO SigMvOrc ("
			loc_cSQL = loc_cSQL + "cblocos, citem2, citens, cpros, cunips, cunis, dopes, dpro2s,"
			loc_cSQL = loc_cSQL + "dpros, empdopnums, emps, fators, numes, pesos, pkchaves, qtds,"
			loc_cSQL = loc_cSQL + "totas, units, cidchaves, moedas, moefats, moevs, notas, obs,"
			loc_cSQL = loc_cSQL + "opers, tota10s, tota1s, tota2s, tota3s, tota4s, tota5s, tota6s,"
			loc_cSQL = loc_cSQL + "tota7s, tota8s, tota9s, tpesos, univals, utilizas, servicos, citagrs,"
			loc_cSQL = loc_cSQL + "citem3, codacabs, debitos, taxas"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lTaxas, "1", "0") + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza item existente em SigMvOrc (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo computado: Emps + Dopes + Numes (chave posicional - regra #42)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "UPDATE SigMvOrc SET"
			loc_cSQL = loc_cSQL + " cblocos = " + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + " citem2 = " + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " cunips = " + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + " cunis = " + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dpro2s = " + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + " dpros = " + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " fators = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + " pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + " qtds = " + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + " totas = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + " units = " + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + " moefats = " + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + " moevs = " + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + " obs = " + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + " tota10s = " + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + " tota1s = " + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + " tota2s = " + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + " tota3s = " + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + " tota4s = " + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + " tota5s = " + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + " tota6s = " + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + " tota7s = " + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + " tota8s = " + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + " tota9s = " + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + " tpesos = " + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + " univals = " + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + " utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + " servicos = " + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " citagrs = " + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + " citem3 = " + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + " codacabs = " + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + " debitos = " + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " taxas = " + IIF(THIS.this_lTaxas, "1", "0")
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - Le SigCdOpe (por Dopes), SigCdEmp (por Cemps -
	* regra SigCdEmp usa Cemps, NUNCA Cemps), SigOpCdd (por Dopes) e os
	* percentuais/contas do cabecalho em SigMvCab (por Emps+Dopes+Numes).
	* Equivalente ao bloco de cursores que o FORM PAI legado ja mantinha
	* abertos (crSigCdOpe/LocalEmp/crSigOpCdd/TprMvCab) - aqui cada valor e
	* lido direto do SQL Server, uma unica vez, na abertura do dialogo.
	*
	* Chamada em Formsigoporc.InicializarForm, logo apos CREATEOBJECT do
	* BO e ANTES de qualquer Configurar*() que dependa de this_cOpEscolha
	* (o Form recalcula this_cOpEscolha com this_nDigItens depois desta
	* chamada - regra do legado: DigItens=5 forca CONSULTAR).
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_lSucesso
		loc_lSucesso = .T.

		TRY
			*-- SigCdOpe (configuracao da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF
			loc_cSQL = "SELECT DigItens, CadProds, Opers, Origems, Destinos, OpePads,"
			loc_cSQL = loc_cSQL + " Imagems, Confes, PrecoAuts, PrecoPs, Precops, CMoes"
			loc_cSQL = loc_cSQL + " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") > 0 AND USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
				SELECT cursor_4c_CfgOpe
				THIS.this_nDigItens  = TratarNulo(DigItens, "N")
				THIS.this_nCadProds  = TratarNulo(CadProds, "N")
				THIS.this_nOpers     = TratarNulo(Opers, "N")
				THIS.this_nOrigems   = TratarNulo(Origems, "N")
				THIS.this_nDestinos  = TratarNulo(Destinos, "N")
				THIS.this_cOpePads   = TratarNulo(OpePads, "C")
				THIS.this_nImagems   = TratarNulo(Imagems, "N")
				THIS.this_nConfes    = TratarNulo(Confes, "N")
				THIS.this_nPrecoAuts = TratarNulo(PrecoAuts, "N")
				THIS.this_nPrecoPs   = TratarNulo(PrecoPs, "N")
				THIS.this_nPrecops   = TratarNulo(Precops, "N")
				THIS.this_cCMoes     = TratarNulo(CMoes, "C")
			ENDIF
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF

			*-- SigCdEmp (configuracao da empresa, chave Cemps)
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF
			loc_cSQL = "SELECT DivNotas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmps)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgEmp") > 0 AND USED("cursor_4c_CfgEmp") AND RECCOUNT("cursor_4c_CfgEmp") > 0
				THIS.this_nDivNotas = TratarNulo(cursor_4c_CfgEmp.DivNotas, "N")
			ENDIF
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF

			*-- SigOpCdd (configuracao-detalhe da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF
			loc_cSQL = "SELECT ConfigGers, ChkIfors FROM SigOpCdd WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpd") > 0 AND USED("cursor_4c_CfgOpd") AND RECCOUNT("cursor_4c_CfgOpd") > 0
				THIS.this_cConfigGers = TratarNulo(cursor_4c_CfgOpd.ConfigGers, "C")
				THIS.this_nChkIfors   = TratarNulo(cursor_4c_CfgOpd.ChkIfors, "N")
			ENDIF
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF

			*-- SigMvCab (cabecalho do movimento, chave Emps+Dopes+Numes) -
			*-- percentuais default (semente do item novo) e contas de
			*-- origem/destino (usadas por btnCadPro.Click)
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
			loc_cSQL = "SELECT Acres, PTax1s, PTax2s, PTax3s, Descs, ContaOs, ContaDs"
			loc_cSQL = loc_cSQL + " FROM SigMvCab WHERE Emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND Dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND Numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgCab") > 0 AND USED("cursor_4c_CfgCab") AND RECCOUNT("cursor_4c_CfgCab") > 0
				SELECT cursor_4c_CfgCab
				THIS.this_nAcres   = TratarNulo(Acres, "N")
				THIS.this_nPTax1s  = TratarNulo(PTax1s, "N")
				THIS.this_nPTax2s  = TratarNulo(PTax2s, "N")
				THIS.this_nPTax3s  = TratarNulo(PTax3s, "N")
				THIS.this_nDescs   = TratarNulo(Descs, "N")
				THIS.this_cContaOs = TratarNulo(ContaOs, "C")
				THIS.this_cContaDs = TratarNulo(ContaDs, "C")
			ENDIF
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarConfiguracao")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItens - Popula cursor_4c_Itens (grade de itens) a partir de
	* SigMvOrc, filtrado por Emps/Dopes/Numes e ordenado por Citens -
	* equivalente ao AddCursor('SigMvOrc','citens','CrSigMvOrc',...) do
	* Init legado. SQLEXEC vai para um cursor TEMPORARIO; cursor_4c_Itens
	* (ja ligado ao Grid, com colunas de lookup instaladas via AddObject)
	* e recarregado com ZAP + APPEND FROM DBF() - NUNCA SQLEXEC direto nele
	* (regra: SQLEXEC sobre alias de grid zera o ColumnCount).
	*====================================================================
	PROCEDURE CarregarItens()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF

			loc_cSQL = "SELECT o.cblocos, o.citem2, o.citens, o.cpros, o.cunips, o.cunis, o.dopes,"
			loc_cSQL = loc_cSQL + " o.dpro2s, o.dpros, o.empdopnums, o.emps, o.fators, o.numes, o.pesos,"
			loc_cSQL = loc_cSQL + " o.pkchaves, o.qtds, o.totas, o.units, o.cidchaves, o.moedas, o.moefats,"
			loc_cSQL = loc_cSQL + " o.moevs, o.notas, o.obs, o.opers, o.tota10s, o.tota1s, o.tota2s, o.tota3s,"
			loc_cSQL = loc_cSQL + " o.tota4s, o.tota5s, o.tota6s, o.tota7s, o.tota8s, o.tota9s, o.tpesos,"
			loc_cSQL = loc_cSQL + " o.univals, o.utilizas, o.servicos, o.citagrs, o.citem3, o.codacabs,"
			loc_cSQL = loc_cSQL + " o.debitos, o.taxas,"
			*-- Descricoes de lookup exibidas nas Columns 4/6/30 da grade de itens
			*-- (legado: crSigMvOrc.DcUnis/DcUnips/DAcabs - colunas PROJETADAS pela
			*-- query do form PAI, nao colunas de SigMvOrc). Sem estes tres joins a
			*-- grade abriria com Unidade/Unidade(pedido)/Acabamento em BRANCO,
			*-- mesmo com cunis/cunips/codacabs gravados.
			loc_cSQL = loc_cSQL + " NVL(uv.dunis, '')  AS dcunis,"
			loc_cSQL = loc_cSQL + " NVL(up.dunis, '')  AS dcunips,"
			loc_cSQL = loc_cSQL + " NVL(ac.descrs, '') AS dacabs"
			loc_cSQL = loc_cSQL + " FROM SigMvOrc o"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni uv ON RTRIM(uv.cunis) = RTRIM(o.cunis)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni up ON RTRIM(up.cunis) = RTRIM(o.cunips)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdAca ac ON RTRIM(ac.cods)  = RTRIM(o.codacabs)"
			loc_cSQL = loc_cSQL + " WHERE o.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND o.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND o.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY o.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar itens do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorItens)
					SELECT (THIS.this_cCursorItens)
					ZAP
					IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
						APPEND FROM DBF("cursor_4c_ItensTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarParcelas - Popula cursor_4c_Parcelas (grade de parcelas) a
	* partir de SigMvOrp, filtrado por Emps/Dopes/Numes e ordenado por
	* Citens - equivalente ao AddCursor('SigMvOrp','citens','CrSigMvOrp',
	* ...) do Init legado. dfors (descricao do fornecedor, Column6 de
	* grd_4c_Parcelas, SEMPRE ReadOnly) e projetado via LEFT JOIN em
	* SigCdCli.Iclis/Rclis - mesma tabela de conta usada pelo lookup
	* fAcessoContas do legado (ver cabecalho de ConfigurarGradeParcelas).
	* Mesmo padrao grid-safe de CarregarItens (cursor temporario + ZAP +
	* APPEND FROM DBF no cursor ja ligado ao Grid).
	*====================================================================
	PROCEDURE CarregarParcelas()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF

			loc_cSQL = "SELECT p.cidchaves, p.citens, p.datas, p.dopes, p.empdopnums,"
			loc_cSQL = loc_cSQL + " p.emps, p.numes, p.percs, p.valos, p.vlbaixas,"
			loc_cSQL = loc_cSQL + " p.borderos, p.ifors, p.valcreds,"
			loc_cSQL = loc_cSQL + " NVL(f.rclis, '') AS dfors"
			loc_cSQL = loc_cSQL + " FROM SigMvOrp p LEFT JOIN SigCdCli f ON f.iclis = p.ifors"
			loc_cSQL = loc_cSQL + " WHERE p.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND p.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND p.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY p.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParcelasTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar parcelas do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorParcelas)
					SELECT (THIS.this_cCursorParcelas)
					ZAP
					IF USED("cursor_4c_ParcelasTmp") AND RECCOUNT("cursor_4c_ParcelasTmp") > 0
						APPEND FROM DBF("cursor_4c_ParcelasTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarParcelas")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

