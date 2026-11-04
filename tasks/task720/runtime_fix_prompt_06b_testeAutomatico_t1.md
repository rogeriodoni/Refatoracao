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
[2026-10-31 10:30:51] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-31 10:30:51] [INFO] Config FPW: (nao fornecido)
[2026-10-31 10:30:51] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-31 10:30:51] [INFO] Timeout: 300 segundos
[2026-10-31 10:30:51] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tmzpu4fz.prg
[2026-10-31 10:30:51] [INFO] Conteudo do wrapper:
[2026-10-31 10:30:51] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigOpDet', 'C:\4c\tasks\task720', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpDet', 'C:\4c\tasks\task720', 'OPERACIONAL'
QUIT

[2026-10-31 10:30:51] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tmzpu4fz.prg
[2026-10-31 10:30:51] [INFO] VFP output esperado em: C:\4c\tasks\task720\vfp_output.txt
[2026-10-31 10:30:51] [INFO] Executando Visual FoxPro 9...
[2026-10-31 10:30:51] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tmzpu4fz.prg
[2026-10-31 10:30:51] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tmzpu4fz.prg
[2026-10-31 10:30:51] [INFO] Timeout configurado: 300 segundos
[2026-10-31 10:30:51] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-31 10:30:51] [INFO] VFP9 finalizado em 0.5614043 segundos
[2026-10-31 10:30:51] [INFO] Exit Code: 
[2026-10-31 10:30:51] [INFO] 
[2026-10-31 10:30:51] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-31 10:30:51] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tmzpu4fz.prg
[2026-10-31 10:30:51] [INFO] 
[2026-10-31 10:30:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-31 10:30:51] [INFO] * Auto-generated wrapper for parameters
[2026-10-31 10:30:51] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-31 10:30:51] [INFO] * Parameters: 'FormSigOpDet', 'C:\4c\tasks\task720', 'OPERACIONAL'
[2026-10-31 10:30:51] [INFO] 
[2026-10-31 10:30:51] [INFO] * Anti-dialog protections for unattended execution
[2026-10-31 10:30:51] [INFO] SET SAFETY OFF
[2026-10-31 10:30:51] [INFO] SET RESOURCE OFF
[2026-10-31 10:30:51] [INFO] SET TALK OFF
[2026-10-31 10:30:51] [INFO] SET NOTIFY OFF
[2026-10-31 10:30:51] [INFO] SYS(2335, 0)
[2026-10-31 10:30:51] [INFO] 
[2026-10-31 10:30:51] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigOpDet', 'C:\4c\tasks\task720', 'OPERACIONAL'
[2026-10-31 10:30:51] [INFO] QUIT
[2026-10-31 10:30:51] [INFO] 
[2026-10-31 10:30:51] [INFO] === Fim do Wrapper.prg ===
[2026-10-31 10:30:51] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigOpDet",
  "timestamp": "20261031103051",
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
      "detalhes": "CarregarLista() executado | (sem registros - tabela pode estar vazia)"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDet.prg):
*==============================================================================
* FormSigOpDet.prg - Dialogo de Selecao de Detalhes (Caracteristicas/
* Complementos de Produto) de um item de movimento - SIGOPDET
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - popup modal aberto a partir de um item de
*          movimento (SigMvCab/SigMvItn), para escolher Caracteristica e
*          Complemento de cada linha de SigMvFtc associada ao produto.
*
* Chamada: CREATEOBJECT("FormSigOpDet", par_cModoOperacao, par_cGrupo, ;
*              par_cCpros, par_cEmpDopNums)
*          (equivale ao legado "LParameters pCnx, pEscolha, pDopes, pProd,
*          pEDN" - sem pCnx, que nao existe mais neste ambiente, ja que o
*          BO usa o handle global gnConnHandle)
*
* Historico de fases:
*   Fase 1/2: SigOpDetBO.prg (propriedades + CRUD completo)
*   Fase 3:   FormSigOpDet.prg - estrutura base (Init, InicializarForm,
*             ConfigurarCabecalho, TornarControlesVisiveis, Destroy)
*   Fase 4:   Grade (Caracteristica/Complemento/Outros) ligada a
*             cursor_4c_Itens, CommandGroup cnt_4c_Botoes (Confirmar/
*             Cancelar) e cmg_4c_InserirExcluir (Inserir/Excluir linha).
*             Celulas da grade usam TextBoxCaracteristicaDet_4c/
*             TextBoxComplementoDet_4c/TextBoxOutrosDet_4c (TextBoxGridLookup.
*             prg), que delegam para os metodos PUBLIC deste form (regra #46:
*             Valid/When de Column.Text1 tem de estar EMBUTIDO na classe, nao
*             em BINDEVENT).
*   Fase 5:   nada a acrescentar - o SCX SIGOPDET nao tem campo de tela.
*             Os 3 "BaseClass: textbox" do dump sao o Text1 NATIVO das 3
*             Column da Grade (Parent SIGOPDET.Grade.ColumnN - regra #18),
*             ja entregues na Fase 4 como TextBox subclasse. Fora deles o
*             dump tem so a faixa do cabecalho (cntSombra + 2 Label), os 2
*             CommandGroup e a Grade: ZERO campo/Label solto, nenhum
*             AddObject/AddProperty em runtime, e os unicos ControlSource
*             do legado sao os das 3 colunas. Criar um metodo de pagina
*             de Dados aqui seria metodo vazio (proibido pela regra de
*             completude) e inventar campo violaria o PILAR 1. O
*             MaxLength = 20 das 3 celulas foi conferido no schema
*             canonico (sigmvftc.ccars, .ctits e .resps sao char(20) -
*             regra #19).
*   Fase 6:   CAMPOS RESTANTES - nada a acrescentar, pela mesma razao da
*             Fase 5 (confirmado em tasks\task720\analise.json, onde
*             campos/lookups/labels sao arrays VAZIOS: toda a superficie
*             de dados do SCX sao as 3 Column da Grade, entregues na
*             Fase 4). Inventar campo aqui violaria o PILAR 1 e criar um
*             ConfigurarPaginaDados seria metodo vazio (proibido pela
*             regra de completude).
*             LOOKUPS - os 2 lookups do legado (fwbuscaint no Valid de
*             Column1.Text1 sobre LocalCars e de Column2.Text1 sobre
*             LocalTits; Column3/"Outros" eh texto livre e nao tem lookup
*             nenhum no dump) foram PADRONIZADOS nesta fase: os funis
*             passaram a se chamar AbrirLookupCaracteristicaDet e
*             AbrirLookupComplementoDet, na familia AbrirLookup*/
*             AbrirBusca* que os sweeps do CorretorAutomatico (#114/#217)
*             reconhecem - com os nomes anteriores (LocalizarOuEscolher*)
*             o funil ficava invisivel a toda correcao futura de lookup,
*             que eh exatamente o defeito silencioso do item 6 da regra
*             #44 ("ancorar em NOME casa a FAMILIA, nunca o especime").
*             O CORPO nao mudou e continua fiel ao legado: o picker abre
*             SO quando o codigo digitado nao casa exato no universo, e
*             o caminho "nao achou" NAO tem MsgAviso - ele abre o picker,
*             que eh o proprio feedback (regra #50).
*             ATENCAO a uma sweep futura da regra #50: a celula FICA VAZIA
*             quando o usuario CANCELA o picker, e isso eh de proposito,
*             nao o defeito que a regra #50 descreve. O legado fecha os
*             dois Valid com "This.Value = LocalCars.cCars" / "= LocalTits
*             .ctits" INCONDICIONAL, ou seja a celula nunca guarda o texto
*             cru digitado - ela sempre recebe um codigo RELIDO do cursor
*             do universo. Manter o digitado invalido quebraria essa
*             invariante e deixaria gravar Caracteristica/Complemento
*             inexistente; vazio eh justamente o estado que o resto do
*             form ja trata como "linha ainda sem detalhe"
*             (GarantirLinhaVaziaGradeDet + SigOpDetBO.Validacao).
*             O universo e um cursor LOCAL
*             (cursor_4c_LocalFtc), nao tabela do SQL Server, por isso o
*             picker eh CREATEOBJECT("FormBuscaSimples", <cursor>, ...)
*             e NAO FormBuscaAuxiliar, que exige gnConnHandle + tabela do
*             banco (regra #36). Pela mesma razao os lookups entram pelo
*             Valid EMBUTIDO nas TextBox subclasses e nunca por BINDEVENT
*             KeyPress/DblClick (regra #46/#18): o modelo generico de
*             BINDEVENT + FormBuscaAuxiliar do template desta fase vale
*             para campo de Page2, nao para celula de grade - e ligar
*             lookup em "KeyPress" abriria o picker a CADA TECLA
*             (regra #47).
*   Fase 7:   EVENTOS PRINCIPAIS DOS BOTOES. Os quatro nomes do template
*             (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*             BtnExcluirClick) sao convencao de form CRUD e NAO entram
*             aqui - o SIGOPDET nao tem barra CRUD alguma, e isso foi
*             MEDIDO no dump, nao presumido:
*               - evidencia ESTRUTURAL: zero "frmcadastro" e zero
*                 "Grupo_Op" (o form eh "Class: form" puro);
*               - evidencia de NOME: zero
*                 "(btn|cmd|Command)(Incluir|Alterar|Visualizar)" e zero
*                 "<X>.Verbo.Click" - os objetos sao cntBotoes e
*                 cmdInsFtc, e o unico verbo CRUD do dump eh o
*                 "cmdExcluir" DENTRO do cmdInsFtc, que eh toolbar de
*                 LINHA de grade (par Inserir/Excluir, nao
*                 Incluir/Alterar/Visualizar/Excluir - CLAUDE.md regra
*                 das barras);
*               - "pcEscolha": as 6 ocorrencias vivas sao de modo
*                 RECEBIDO do chamador ("lParameters pCnx, pEscolha, ..."
*                 -> "ThisForm.pcEscolha = pEscolha"), nunca decidido
*                 aqui - o dialogo so usa o modo para liberar ou travar a
*                 edicao das celulas.
*             Inventar os quatro botoes violaria o PILAR 1 e cria-los
*             vazios violaria a regra de completude.
*             A superficie de botao do legado sao 4 botoes em 2
*             CommandGroup, e os 4 .Click correspondentes JA tem handler
*             completo (entregues na Fase 4, com os BINDEVENT em
*             Buttons(N) - regra #3):
*               btnSair.Click      -> BtnCancelarClick
*               btnConfirmar.Click -> BtnConfirmarClick
*               cmdInserir.Click   -> BtnInserirDetClick
*               cmdExcluir.Click   -> BtnExcluirDetClick
*             O que esta fase ACRESCENTOU foi a fidelidade de
*             COMPORTAMENTO desses botoes, que o dump declara e a Fase 4
*             nao trouxe: Form.ShowTips (sem ele os ToolTipText dos
*             botoes nunca aparecem), Form.Themes/Form.KeyPreview,
*             CommandGroup.Value/TabIndex/SpecialEffect/BorderColor/
*             Themes e o TabIndex/SpecialEffect de cada Buttons(N). O
*             TabIndex importa: o legado poe Confirmar em 1 e Cancelar em
*             2, logo o Tab entra primeiro no Confirmar. Unico valor do
*             dump deixado de fora, com razao escrita no proprio bloco:
*             o AutoSize = .T. dos dois CommandGroup (CLAUDE.md #31).
*             btnSair e btnConfirmar tem o MESMO corpo no legado
*             (Validacao + Release) e por isso os dois handlers delegam
*             ao mesmo ConfirmarSelecaoDetExec - ver a nota la sobre a
*             unica divergencia deliberada (o "PROCEDURE validacao" do
*             legado nao tem RETURN, entao o dialogo dele fecha sempre;
*             aqui ele permanece aberto quando falta Caracteristica
*             obrigatoria, que eh a intencao explicita do "llOk = .F." +
*             "Return .f." do Click legado).
*   Fase 8:   EVENTOS AUXILIARES E CONSOLIDACAO. A "ficha" desta tela eh a
*             LINHA CORRENTE DA GRADE (uma linha de SigMvFtc por
*             Caracteristica/Complemento), e eh dela que saem os tres
*             metodos canonicos que esta fase acrescentou:
*               CarregarLista() - funil UNICO de carga da grade
*               FormParaBO()    - linha corrente da grade -> BO
*               BOParaForm()    - BO -> linha corrente da grade
*             mais os auxiliares que eles exigem: VincularGradeDet/
*             VincularColunaDet (bind da grade em FONTE UNICA),
*             RepintarGradeDet (regra #21) e AjustarBotoesPorModo.
*
*             Por que CarregarLista nao eh mero apelido de
*             CarregarDadosGrade: SigOpDetBO.CarregarItens() FECHA e
*             RECRIA o alias cursor_4c_Itens (USE IN + SELECT ... INTO
*             CURSOR ... READWRITE). Derrubar o alias sob uma grade JA
*             bindada zera o ColumnCount e destroi os TextBox que as
*             Column receberam por AddObject - a grade viraria um
*             retangulo branco, sem erro e sem log. Por isso o funil
*             reaplica o bind INTEIRO depois de recarregar
*             (VincularGradeDet) e so entao repinta. Na PRIMEIRA carga
*             (dentro de ConfigurarPageFrame) a grade ainda nao existe e
*             o funil apenas popula o cursor - que eh justamente a ordem
*             que a regra #41 exige, porque Column.ControlSource estoura
*             se o cursor nao existir.
*
*             O bind deixou de morar no ConfigurarGrade e passou a
*             VincularGradeDet/VincularColunaDet (FONTE UNICA - regra
*             #44, item 6): RecordSource reseta Column.Width,
*             Header1.Caption, Sparse e CurrentControl (regra #48), entao
*             as duas chamadas (criacao e recarga) tem de aplicar o MESMO
*             bloco, na ordem ColumnCount -> RecordSource -> ControlSource
*             -> Width -> Header1.Caption. ColumnCount so eh tocado quando
*             esta diferente de 3, e cada TextBox de celula so eh recriado
*             quando a Column o perdeu (guarda PEMSTATUS): reatribuir
*             ColumnCount DESTROI os objetos Column e com eles os
*             controles postos por AddObject.
*
*             FormParaBO/BOParaForm sao o par de transferencia da linha, e
*             passaram a ser o caminho UNICO pelo qual os dois Valid de
*             celula gravam no cursor - no lugar dos REPLACE soltos que a
*             Fase 6 tinha espalhado em ValidarCaracteristicaDetExec e
*             ValidarComplementoDetExec. O comportamento eh o MESMO do
*             legado ("Replace CCars With This.Value in crSigMvFtc",
*             "Replace cTits ..." e o "Replace Resps With []" quando o
*             Complemento nao fica vazio); o que muda eh haver um lugar so
*             que escreve a linha. FormParaBO REAFIRMA o contexto do
*             dialogo (empdopnums/cpros) depois do CarregarDoCursor: o
*             contexto eh do FORM, nao da linha, e uma linha em branco
*             (placeholder) zeraria no BO justamente as duas chaves que
*             SigOpDetBO.GravarItens() usa no DELETE/INSERT de SigMvFtc.
*
*             ESCOPO dos metodos desta fase, medido no VFP9 em 2026-10-31
*             e nao presumido (PEMSTATUS(oForm, <nome>, 2), 2 = Protected):
*               CarregarLista .F. | AjustarBotoesPorModo .F.  -> PUBLICOS
*               FormParaBO    .T. | BOParaForm           .T.  -> PROTEGIDOS
*             CarregarLista e AjustarBotoesPorModo NAO existem em FormBase,
*             logo ficam publicos de verdade - e tem de ficar, porque o
*             harness de teste automatico os chama de FORA da classe
*             (regra #3). FormParaBO/BOParaForm, ao contrario, sao hooks
*             que FormBase.prg declara PROTECTED (linhas 285 e 280) e o
*             VFP9 NAO deixa a subclasse alargar escopo herdado (regra
*             #51): aqui eles levam PROTECTED EXPLICITO, porque omitir o
*             modificador nao os tornaria publicos - so esconderia o fato.
*             Todos os call sites deles neste form sao por THIS., de dentro
*             da classe; chamada de fora estoura "Property FORMPARABO is
*             not found" e, em harness headless, PENDURA o processo num
*             dialogo que ninguem fecha.
*
*             AjustarBotoesPorModo reproduz, no nivel da grade, o When que
*             o legado poe em cada celula (InList(pcEscolha,'INSERIR',
*             'ALTERAR')): Column.ReadOnly segue o modo e eh aplicado
*             DEPOIS do Grid.ReadOnly, que propaga e sobrescreveria
*             (regra #18). O Grid NUNCA fica ReadOnly - em VISUALIZAR o
*             legado continua deixando NAVEGAR entre as linhas, so nao
*             deixa editar. E os dois botoes de linha (cmdInserir/
*             cmdExcluir) NAO sao desabilitados por modo, de proposito
*             duas vezes: o legado tambem nao desabilita (o guard dele
*             esta DENTRO do Click, e esta reproduzido em
*             BtnInserirDetClick/BtnExcluirDetClick), e sao botoes
*             icon-only (Caption = "") - mexer em .Enabled em runtime
*             fa-los perder o icone e virar retangulo vazio
*             (CorretorAutomatico #106).
*
*             Nomes canonicos de form CRUD que NAO entram, cada um por
*             ausencia MEDIDA no dump e nao por presuncao:
*               BtnBuscarClick   - o dump nao tem botao de busca algum (os
*                                  4 botoes sao btnSair, btnConfirmar,
*                                  cmdInserir e cmdExcluir). A busca desta
*                                  tela eh o picker de celula, ja entregue
*                                  na Fase 6 (AbrirLookupCaracteristicaDet
*                                  e AbrirLookupComplementoDet).
*               BtnEncerrarClick - o botao que fecha eh o btnSair, ja
*                                  entregue como BtnCancelarClick (Cancel
*                                  = .T., ToolTipText "[Esc] Encerrar").
*                                  Um segundo handler seria duplicata do
*                                  mesmo Click do legado.
*               BtnSalvarClick   - o botao de acao do legado se chama
*                                  btnConfirmar e ja esta como
*                                  BtnConfirmarClick; renomear ou duplicar
*                                  violaria o PILAR 1.
*               HabilitarCampos  - nao ha campo FORA da grade (campos/
*                                  lookups/labels sao arrays VAZIOS em
*                                  tasks\task720\analise.json). O que o
*                                  modo habilita sao as CELULAS, e isso eh
*                                  exatamente o AjustarBotoesPorModo acima
*                                  - um segundo metodo so repetiria a
*                                  mesma atribuicao.
*               LimparCampos     - idem: sem campo de tela nao ha o que
*                                  limpar, e a grade nao se "limpa" nesta
*                                  tela (o legado purga as linhas em
*                                  branco dentro da validacao -
*                                  SigOpDetBO.Validacao - e fecha).
*             Criar qualquer um deles vazio violaria a regra de completude.
*
* O "PROCEDURE Load" do legado ("=fConfigGeral()") fica de fora: no Fortyus
* fConfigGeral era inicializacao GLOBAL da aplicacao, e na arquitetura nova
* isso ja aconteceu antes (config.prg + main.prg + os cursores do BO). O
* wrapper projeto\app\utils\fconfiggeral.prg existe APENAS para o p-code dos
* VCX legado - em codigo nosso essa funcao nunca eh chamada. Mesma decisao ja
* registrada em SigOpClpBO.prg para o mesmo construto do legado. Assim, cada
* metodo do dump tem contrapartida: validacao -> SigOpDetBO.Validacao,
* Release -> Destroy, Init -> Init, btnSair/btnConfirmar.Click ->
* BtnCancelarClick/BtnConfirmarClick, cmdInserir/cmdExcluir.Click ->
* BtnInserirDetClick/BtnExcluirDetClick, e os When/Valid/LostFocus das 3
* Column -> as TextBox subclasse de TextBoxGridLookup.prg.
*==============================================================================
DEFINE CLASS FormSigOpDet AS FormBase

    *-- Parametros de entrada recebidos no Init (contexto do item de
    *-- movimento pai, equivalente a pEscolha/pDopes/pProd/pEDN do legado)
    this_cModoOperacao = ""   && pEscolha - INSERIR/ALTERAR/VISUALIZAR/etc
    this_cGrupo        = ""   && pDopes - SigCdFtc.cgrus (grupo de caracteristicas)
    this_cCpros        = ""   && pProd - SigCdPro.Cpros (produto do item de movimento)
    this_cEmpDopNums   = ""   && pEDN - chave do item de movimento (SigMvCab/SigMvItn)

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPDET)
    Width        = 800
    Height       = 500
    AutoCenter   = .T.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    AlwaysOnTop  = .T.
    BorderStyle  = 2
    ClipControls = .F.
    FontName     = "Verdana"
    FontSize     = 8
    *-- ShowTips: sem ele os ToolTipText dos 4 botoes do legado
    *-- ("[Esc] Encerrar", "Confirmar a Selecao", "Inserir Composicao")
    *-- NUNCA aparecem - o dump declara ShowTips = .T. no SIGOPDET.
    ShowTips     = .T.
    Themes       = .F.
    *-- KeyPreview = .T. do dump: INERTE aqui, como no legado - o SCX nao
    *-- tem PROCEDURE KeyPress no form (conferido no dump inteiro) e o
    *-- FormBase tambem nao. Transcrito por fidelidade (PILAR 1), sem
    *-- mudar comportamento: quem trata [Esc] eh o Cancel = .T. do btnSair.
    KeyPreview   = .T.

    *--------------------------------------------------------------------------
    * Init - Armazena o contexto do item de movimento pai, cria o BO e
    * dispara FormBase.Init() (que chama THIS.InicializarForm() via
    * DODEFAULT).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cModoOperacao, par_cGrupo, par_cCpros, par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cModoOperacao = IIF(VARTYPE(par_cModoOperacao) = "C", ALLTRIM(par_cModoOperacao), "")
            THIS.this_cGrupo        = IIF(VARTYPE(par_cGrupo)        = "C", ALLTRIM(par_cGrupo),        "")
            THIS.this_cCpros        = IIF(VARTYPE(par_cCpros)        = "C", ALLTRIM(par_cCpros),        "")
            THIS.this_cEmpDopNums   = IIF(VARTYPE(par_cEmpDopNums)   = "C", ALLTRIM(par_cEmpDopNums),   "")

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpDetBO", ;
                THIS.this_cModoOperacao, THIS.this_cGrupo, THIS.this_cCpros, THIS.this_cEmpDopNums)
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SigOpDetBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpDet.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpDet.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base (cabecalho).
    * Chamado automaticamente por FormBase.Init() via DODEFAULT().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Caption identico ao legado ("Selecao de Detalhes")
            THIS.Caption = "Sele" + CHR(231) + CHR(227) + "o de Detalhes"

            THIS.ConfigurarPageFrame()

            *-- Propaga o titulo para os labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpDet.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de layout base.
    * SIGOPDET original eh flat OPERACIONAL (sem PageFrame nativo) - popup
    * modal aberto a partir de um item de movimento. Nome mantido por
    * convencao do orquestrador multi-fase. Cabecalho direto sobre o form;
    * dados da grade sao carregados ANTES do bind (regra #41: Column.
    * ControlSource exige o cursor ja existente), e so depois a Grade e os
    * CommandGroups sao montados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()

        *-- Carga pelo funil UNICO (CarregarLista). Aqui a grade ainda nao
        *-- existe, entao o funil so popula cursor_4c_Itens - e eh essa a
        *-- ordem correta: Column.ControlSource estoura se o cursor nao
        *-- existir (regra #41), e SigOpDetBO.CarregarItens() recria o
        *-- alias, o que derrubaria o bind se a grade ja estivesse pronta.
        THIS.CarregarLista()

        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoesConfirmar()
        THIS.ConfigurarBotoesInserirExcluir()

        *-- Grade pronta: GO TOP + Refresh, senao o cursor fica cheio e a
        *-- grade aparece vazia (regra #21)
        THIS.RepintarGradeDet()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrade - Popula cursor_4c_Itens (e cursor_4c_LocalFtc, o
    * universo de referencia) ANTES de a Grade ser montada. Em modo de
    * validacao de UI (sem conexao SQL - regra gb_4c_ValidandoUI), ou se a
    * carga real falhar, cria um cursor vazio com a MESMA estrutura (ordem
    * de campos identica - regra do CLAUDE.md para forms OPERACIONAIS), so
    * para a Grade conseguir bindar sem erro.
    *
    * Devolve .T. quando cursor_4c_Itens EXISTE no fim (com dado real ou
    * como placeholder): eh isso que o chamador precisa saber para decidir
    * se pode bindar a grade. Carga real que falha nao eh erro de fluxo -
    * SigOpDetBO.CarregarItens() ja exibiu a mensagem do SQL Server.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDadosGrade()
        LOCAL loc_lCarregou
        loc_lCarregou = .F.

        IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) ;
            AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lCarregou = THIS.this_oBusinessObject.CarregarItens()
        ENDIF

        IF !loc_lCarregou
            THIS.CriarCursorItensPlaceholder()
        ENDIF

        RETURN USED("cursor_4c_Itens")
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorItensPlaceholder - cursor_4c_Itens vazio, com a MESMA ordem
    * de campos usada em SigOpDetBO.CarregarItens()/GravarItens() (regra:
    * CREATE CURSOR com ordem identica em todos os locais)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorItensPlaceholder()
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Itens ;
            (cidchaves C(20), empdopnums C(29), cpros C(14), ;
             ccars C(20), ctits C(20), resps C(20), ordens N(6,0))
        SET NULL OFF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Grade de Caracteristica/Complemento/Outros (SIGOPDET.
    * Grade do legado). Aqui ficam SO as propriedades que nao dependem de
    * dado; todo o bind (ColumnCount/RecordSource/ControlSource/Width/
    * Header1.Caption/CurrentControl/Sparse/ReadOnly) mora em
    * VincularGradeDet, que eh FONTE UNICA compartilhada com CarregarLista
    * (regra #44, item 6) - duas copias do bind divergiriam em silencio na
    * primeira coluna nova.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrade

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrade = THIS.grd_4c_Dados
        WITH loc_oGrade
            .Top           = 88
            .Left          = 74
            .Width         = 600
            .Height        = 405
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        THIS.VincularGradeDet()
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGradeDet - Bind COMPLETO da grade a cursor_4c_Itens. FONTE
    * UNICA: chamado por ConfigurarGrade (criacao) e por CarregarLista
    * (recarga). Precisa ser reaplicado inteiro a cada recarga porque
    * RecordSource reseta Column.Width, Header1.Caption, Sparse e
    * CurrentControl (regra #48), e porque SigOpDetBO.CarregarItens() FECHA
    * e RECRIA o alias - o que zera o ColumnCount e destroi os TextBox das
    * Column.
    *
    * ColumnCount so eh tocado quando esta diferente de 3: reatribui-lo
    * DESTROI os objetos Column e com eles os controles postos por
    * AddObject (regra do CLAUDE.md sobre ColumnCount em Carregar*).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGradeDet()
        LOCAL loc_oGrade, loc_lSucesso
        loc_lSucesso = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Itens")
            loc_oGrade = THIS.grd_4c_Dados

            IF loc_oGrade.ColumnCount != 3
                loc_oGrade.ColumnCount = 3
            ENDIF

            loc_oGrade.RecordSource = "cursor_4c_Itens"

            *-- Column1 - Caracteristica | Column2 - Complemento
            *-- Column3 - Outros (coluna Resps - observacao livre)
            THIS.VincularColunaDet(loc_oGrade.Column1, "txt_4c_Caracteristica", ;
                "TextBoxCaracteristicaDet_4c", "cursor_4c_Itens.ccars", 155, "Caracteristica")
            THIS.VincularColunaDet(loc_oGrade.Column2, "txt_4c_Complemento", ;
                "TextBoxComplementoDet_4c", "cursor_4c_Itens.ctits", 155, "Complemento")
            THIS.VincularColunaDet(loc_oGrade.Column3, "txt_4c_Outros", ;
                "TextBoxOutrosDet_4c", "cursor_4c_Itens.resps", 255, "Outros")

            *-- Grid.ReadOnly/Column.ReadOnly por ULTIMO e na ordem certa
            *-- (regra #18) - o modo de operacao manda, nao um literal
            THIS.AjustarBotoesPorModo()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularColunaDet - Bind de UMA Column da grade de detalhes. O
    * TextBox de celula so eh recriado quando a Column o PERDEU (guarda
    * PEMSTATUS): AddObject com nome que ja existe estoura "Object is
    * already defined" e derrubaria o Init.
    *
    * A edicao de celula usa TextBox subclasse com When/Valid EMBUTIDOS
    * (TextBoxGridLookup.prg) instalada com AddObject + CurrentControl +
    * Sparse = .F. - sem CurrentControl a Column continua desenhando o
    * Text1 nativo e o controle nunca aparece (regra #18); e BINDEVENT em
    * Valid/When de Column.Text1 nao eh confiavel (regra #46).
    *
    * Ordem obrigatoria: ControlSource -> Width -> Header1.Caption (regra
    * #48 - mexer na fonte do dado reseta largura e cabecalho).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularColunaDet(par_oColuna, par_cNomeControle, ;
            par_cClasseControle, par_cControlSource, par_nWidth, par_cCaption)

        IF !PEMSTATUS(par_oColuna, par_cNomeControle, 5)
            par_oColuna.AddObject(par_cNomeControle, par_cClasseControle)
        ENDIF
        par_oColuna.CurrentControl = par_cNomeControle
        par_oColuna.Sparse         = .F.

        WITH par_oColuna
            .ControlSource     = par_cControlSource
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Width             = par_nWidth
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.Caption   = par_cCaption
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - FUNIL UNICO de carga da grade de detalhes: recarrega
    * cursor_4c_Itens, reaplica o bind e repinta. PUBLIC porque o harness
    * de teste automatico chama THIS.oForm.CarregarLista() de FORA da
    * classe (CLAUDE.md regra #3 - PROTECTED falharia em runtime com
    * "Property CARREGARLISTA is not found").
    *
    * O rebind depois da carga NAO eh zelo: SigOpDetBO.CarregarItens() faz
    * USE IN + SELECT ... INTO CURSOR ... READWRITE, isto eh FECHA e RECRIA
    * o alias que a grade usa como RecordSource. Com a grade ja bindada
    * isso zera o ColumnCount e destroi os TextBox das Column - a grade
    * vira um retangulo branco sem erro, sem log e para o RESTO da vida do
    * form. Na primeira chamada (ConfigurarPageFrame) a grade ainda nao
    * existe e o bloco de rebind eh pulado pela guarda do VincularGradeDet.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.CarregarDadosGrade()

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.VincularGradeDet()
            THIS.RepintarGradeDet()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RepintarGradeDet - GO TOP + Refresh da grade (regra #21: popular o
    * cursor NAO repinta a grade; sem isto o cursor fica cheio e a tela
    * aparece vazia, e o sintoma reportado - "a tela nao traz dados" -
    * manda o diagnostico para SQL/cursor/permissao).
    *
    * Usado SO nos caminhos que (re)populam o cursor. Os handlers de linha
    * (BtnInserirDetClick/BtnExcluirDetClick) tem posicionamento PROPRIO
    * no legado (Column1.SetFocus apos inserir, Go Bottom apos excluir) e
    * por isso mantem o Refresh deles - passar por aqui jogaria o ponteiro
    * para o topo e perderia a linha em que o usuario estava.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RepintarGradeDet()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Itens") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
            SELECT cursor_4c_Itens
            GO TOP
            THIS.grd_4c_Dados.Refresh()
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Aplica o modo de operacao recebido do form
    * chamador (pcEscolha do legado) a superficie editavel da tela. PUBLIC
    * porque o harness de teste automatico tambem o chama de fora da classe
    * (CLAUDE.md regra #3).
    *
    * O legado trava a edicao pelo When de CADA celula (InList(pcEscolha,
    * 'INSERIR','ALTERAR')) - reproduzido nas TextBox subclasses. Aqui a
    * mesma regra eh aplicada no nivel da Column, que eh o lugar onde o
    * rebind da grade a apaga: Grid.ReadOnly propaga para as colunas, logo
    * Column.ReadOnly tem de vir DEPOIS dele (regra #18).
    *
    * Grid.ReadOnly fica SEMPRE .F.: em VISUALIZAR o legado continua
    * deixando NAVEGAR entre as linhas, so nao deixa editar.
    *
    * A regra POR LINHA da coluna Outros (so editavel quando a linha nao
    * tem Complemento - Empty(crSigMvFtc.cTits) no When legado) NAO entra
    * aqui: ela depende da linha corrente e por isso continua no When da
    * celula (GradeDetOutrosEditavel). Column.ReadOnly eh por COLUNA e
    * travaria a coluna inteira.
    *
    * Os botoes de linha cmdInserir/cmdExcluir NAO sao desabilitados por
    * modo, por duas razoes somadas: o legado tambem nao os desabilita (o
    * guard dele esta DENTRO do Click, reproduzido em BtnInserirDetClick/
    * BtnExcluirDetClick), e sao botoes icon-only (Caption = "") - mexer em
    * .Enabled em runtime fa-los perder o icone e virar retangulo vazio
    * (CorretorAutomatico #106).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEditavel, loc_lSucesso
        loc_lSucesso = .F.

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.ColumnCount >= 3
            loc_lEditavel = THIS.GradeDetEditavel()

            THIS.grd_4c_Dados.ReadOnly         = .F.
            THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lEditavel
            THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lEditavel
            THIS.grd_4c_Dados.Column3.ReadOnly = !loc_lEditavel

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere a LINHA CORRENTE da grade (a "ficha" desta
    * tela) para as propriedades do BO.
    *
    * PROTECTED EXPLICITO, e nao por preferencia de estilo: FormBase.prg
    * declara "PROTECTED PROCEDURE FormParaBO" (linha 285) e em VFP9 a
    * subclasse NAO ALARGA escopo herdado - escrever sem modificador aqui
    * nao tornaria o metodo publico, so esconderia de quem le que ele
    * continua protegido (regra #51). MEDIDO neste form em 2026-10-31:
    * PEMSTATUS(oForm, "FormParaBO", 2) devolve .T. mesmo sem o modificador
    * no .prg. Logo: so chamar por THIS., de dentro da classe; chamada de
    * fora estoura "Property FORMPARABO is not found" e, em harness
    * headless, PENDURA o processo num dialogo que ninguem fecha.
    *
    * A linha corrente eh a fonte autoritativa porque os Valid das celulas
    * ja comitaram ali o valor digitado/escolhido (regra #46: dentro do
    * Valid o valor esta no .Value do TextBox e so DEPOIS chega ao cursor -
    * por isso quem escreve eh o proprio Valid, via BOParaForm).
    *
    * O CONTEXTO do dialogo (empdopnums + cpros) eh REAFIRMADO depois do
    * CarregarDoCursor: ele pertence ao FORM, nao a linha. Numa linha em
    * branco (placeholder criado sem conexao, ou linha recem-inserida ainda
    * sem dado) o cursor traria vazio e zeraria no BO justamente as duas
    * chaves que SigOpDetBO.GravarItens() usa no DELETE/INSERT de SigMvFtc
    * - o DELETE passaria a apontar para empdopnums vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                IF RECCOUNT("cursor_4c_Itens") > 0 AND !EOF("cursor_4c_Itens")
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Itens")

                    THIS.this_oBusinessObject.this_cEmpDopNums = THIS.this_cEmpDopNums
                    THIS.this_oBusinessObject.this_cCpros      = THIS.this_cCpros
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpDet.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere as propriedades do BO de volta para a LINHA
    * CORRENTE da grade.
    *
    * PROTECTED EXPLICITO pela mesma razao do FormParaBO acima:
    * FormBase.prg declara "PROTECTED PROCEDURE BOParaForm" (linha 280) e o
    * VFP9 nao deixa a subclasse alargar o escopo herdado (regra #51).
    *
    * Eh o caminho UNICO de escrita na linha: os dois Valid de celula
    * (ValidarCaracteristicaDetExec/ValidarComplementoDetExec) passam por
    * aqui no lugar de cada um ter o seu REPLACE, que eh o que o legado faz
    * em duas linhas soltas ("Replace CCars With This.Value in crSigMvFtc"
    * e "Replace cTits ...").
    *
    * Os valores vao para variaveis LOCAIS antes do REPLACE, sem bloco
    * WITH: WITH num REPLACE de varias colunas e' exatamente o caso em que
    * o escopo do ponto sequestra a resolucao e a propriedade do BO passa a
    * ser procurada no objeto errado (regra #33).
    *
    * LEFT(..., 20) acompanha o schema: sigmvftc.cidchaves, .ccars, .ctits
    * e .resps sao char(20) (regra #19 - o limite vem da largura da COLUNA,
    * nunca do Width do controle em pixels).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cIdChave, loc_cCCars, loc_cCTits, loc_cResps, loc_nOrdens
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                IF RECCOUNT("cursor_4c_Itens") > 0 AND !EOF("cursor_4c_Itens")
                    loc_cIdChave = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCIdChaves, "")), 20)
                    loc_cCCars   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCCars,     "")), 20)
                    loc_cCTits   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCTits,     "")), 20)
                    loc_cResps   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cResps,     "")), 20)
                    loc_nOrdens  = NVL(THIS.this_oBusinessObject.this_nOrdens, 0)

                    REPLACE cidchaves WITH loc_cIdChave, ;
                            ccars     WITH loc_cCCars,   ;
                            ctits     WITH loc_cCTits,   ;
                            resps     WITH loc_cResps,   ;
                            ordens    WITH loc_nOrdens   ;
                        IN cursor_4c_Itens

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpDet.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesConfirmar - cntBotoes do legado (CommandGroup com
    * btnSair/"Cancelar" e btnConfirmar/"Confirmar"). Os dois Click do dump
    * tem o MESMO corpo (Validacao + Release) - os dois handlers do form
    * delegam para o mesmo metodo (THIS.ConfirmarSelecaoDetExec).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesConfirmar()
        LOCAL loc_oGrp

        THIS.AddObject("cnt_4c_Botoes", "CommandGroup")
        loc_oGrp = THIS.cnt_4c_Botoes
        WITH loc_oGrp
            .Top           = -2
            .Left          = 642
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            *-- Value/TabIndex/SpecialEffect/BorderColor/Themes do dump
            *-- (SIGOPDET.cntBotoes). Value = 0 do legado: nenhum dos dois
            *-- botoes nasce como o "corrente" do grupo.
            .Value         = 0
            .TabIndex      = 2
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            *-- AutoSize = .T. do dump NAO transcrito de proposito: em
            *-- CommandGroup o AutoSize faz a geometria do botao INTERNO
            *-- DEFINIR a altura do grupo (CLAUDE.md #31, medido no VFP9),
            *-- e isso sobrescreveria o Width/Height 160x85 que o proprio
            *-- SCX declara e que a Fase 4 ja transcreveu.
        ENDWITH

        *-- Buttons(1) = btnSair ("Cancelar")
        WITH loc_oGrp.Buttons(1)
            .Top          = 5
            .Left         = 80
            .Height       = 75
            .Width        = 75
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Caption       = "\<Cancelar"
            .Cancel        = .T.
            .MousePointer  = 15
            .ToolTipText   = "[Esc] Encerrar"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            *-- TabIndex/SpecialEffect do dump (Command1 = btnSair). O
            *-- legado poe Confirmar em 1 e Cancelar em 2: o Tab entra
            *-- PRIMEIRO no Confirmar, nao no Cancelar.
            .TabIndex      = 2
            .SpecialEffect = 0
        ENDWITH

        *-- Buttons(2) = btnConfirmar ("Confirmar")
        WITH loc_oGrp.Buttons(2)
            .Top          = 5
            .Left         = 5
            .Height       = 75
            .Width        = 75
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption      = "\<Confirmar"
            .MousePointer = 15
            .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            *-- TabIndex do dump (Command2 = btnConfirmar): o legado NAO
            *-- declara SpecialEffect neste botao, por isso ele nao entra.
            .TabIndex     = 1
        ENDWITH

        BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnCancelarClick")
        BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnConfirmarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesInserirExcluir - cmdInsFtc do legado (CommandGroup com
    * cmdInserir/geral_adicao_26.jpg e cmdExcluir/cadastro_excluir_26.jpg,
    * icon-only - Caption = "" no dump, NUNCA setar .Enabled em runtime
    * nesses botoes - regra do CorretorAutomatico #106).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesInserirExcluir()
        LOCAL loc_oGrp

        THIS.AddObject("cmg_4c_InserirExcluir", "CommandGroup")
        loc_oGrp = THIS.cmg_4c_InserirExcluir
        WITH loc_oGrp
            .Top         = 272
            .Left        = 676
            .Width       = 50
            .Height      = 90
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            *-- Value/TabIndex do dump (SIGOPDET.cmdInsFtc). Value = 1 do
            *-- legado: o cmdInserir eh o botao corrente do grupo.
            *-- AutoSize = .T. do dump nao entra, pela mesma razao do
            *-- cnt_4c_Botoes (CLAUDE.md #31).
            .Value       = 1
            .TabIndex    = 2
        ENDWITH

        *-- Buttons(1) = cmdInserir
        WITH loc_oGrp.Buttons(1)
            .Top               = 5
            .Left              = 5
            .Height            = 40
            .Width             = 40
            .FontBold          = .T.
            .FontName          = "Small Fonts"
            .FontSize          = 7
            .WordWrap          = .T.
            .Picture           = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .Caption           = ""
            .ToolTipText       = "Inserir Composi" + CHR(231) + CHR(227) + "o"
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .DisabledForeColor = RGB(128, 128, 128)
            .Themes            = .F.
            *-- SpecialEffect do dump (Command1 = cmdInserir)
            .SpecialEffect     = 0
        ENDWITH

        *-- Buttons(2) = cmdExcluir
        WITH loc_oGrp.Buttons(2)
            .AutoSize  = .F.
            .Top       = 45
            .Left      = 5
            .Height    = 40
            .Width     = 40
            .FontBold  = .T.
            .FontName  = "Small Fonts"
            .FontSize  = 7
            .WordWrap  = .T.
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Caption       = ""
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            *-- SpecialEffect do dump (Command2 = cmdExcluir). O legado NAO
            *-- declara ToolTipText neste botao - nao inventar (PILAR 1).
            .SpecialEffect = 0
        ENDWITH

        BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnInserirDetClick")
        BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnExcluirDetClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDetEditavel - When de Column1/Column2 (legado: InList(pcEscolha,
    * 'INSERIR','ALTERAR')). PUBLIC - chamado via THISFORM pelas TextBox
    * subclasses da grade (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE GradeDetEditavel()
        RETURN INLIST(UPPER(ALLTRIM(THIS.this_cModoOperacao)), "INSERIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDetOutrosEditavel - When de Column3 (legado: Empty(crSigMvFtc.
    * cTits) and InList(pcEscolha,'INSERIR','ALTERAR') - a coluna Outros so
    * eh editavel quando a linha corrente NAO tem Complemento escolhido).
    *--------------------------------------------------------------------------
    PROCEDURE GradeDetOutrosEditavel()
        LOCAL loc_lEditavel
        loc_lEditavel = .F.

        IF USED("cursor_4c_Itens") AND THIS.GradeDetEditavel()
            loc_lEditavel = EMPTY(ALLTRIM(NVL(cursor_4c_Itens.ctits, "")))
        ENDIF

        RETURN loc_lEditavel
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCaracteristicaDetExec - Valid de Column1.txt_4c_Caracteristica
    * (legado: busca em LocalFtc; se nao achar exato, abre o picker sobre o
    * proprio universo - fwbuscaint no legado, FormBuscaSimples aqui, porque
    * o universo e um CURSOR local, nao uma tabela SQL Server). PUBLIC -
    * chamado via THISFORM pela TextBox subclass (regra #3/#46).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCaracteristicaDetExec(par_oTxt)
        LOCAL loc_cValor

        loc_cValor = UPPER(ALLTRIM(par_oTxt.Value))

        IF EMPTY(loc_cValor)
            par_oTxt.Value = ""
        ELSE
            IF USED("cursor_4c_SigOpDetLocalCars")
                USE IN cursor_4c_SigOpDetLocalCars
            ENDIF

            IF USED("cursor_4c_LocalFtc")
                SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                    INTO CURSOR cursor_4c_SigOpDetLocalCars READWRITE
            ENDIF

            par_oTxt.Value = THIS.AbrirLookupCaracteristicaDet(loc_cValor)
        ENDIF

        *-- Escrita na linha pelo par canonico de transferencia, no lugar do
        *-- REPLACE solto (legado: "Replace CCars With This.Value in
        *-- crSigMvFtc"). FormParaBO le a linha corrente, so a coluna desta
        *-- celula muda, e BOParaForm devolve a linha inteira ao cursor -
        *-- um lugar so escreve a linha (Fase 8).
        IF THIS.FormParaBO()
            THIS.this_oBusinessObject.this_cCCars = par_oTxt.Value
            THIS.BOParaForm()
        ENDIF

        par_oTxt.Refresh()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCaracteristicaDet - FUNIL do lookup da coluna
    * "Caracteristica" (legado: fwbuscaint sobre LocalCars no Valid de
    * Column1.Text1). Localiza o codigo digitado no universo e, so quando
    * nao casa exato, abre o picker - nunca avisa nem apaga o digitado
    * (regra #50). Nome na familia AbrirLookup*/AbrirBusca*: eh por esse
    * nome que os patterns do CorretorAutomatico (#114/#217) reconhecem um
    * funil de lookup - funil batizado fora da familia fica invisivel aos
    * sweeps (regra #44, item 6). Chamado so via THIS., logo PROTECTED eh
    * seguro (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupCaracteristicaDet(par_cValor)
        LOCAL loc_cResultado, loc_oBusca
        loc_cResultado = par_cValor

        IF USED("cursor_4c_SigOpDetLocalCars")
            SELECT cursor_4c_SigOpDetLocalCars
            GO TOP
            LOCATE FOR ccars = par_cValor
            IF FOUND()
                loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalCars.ccars)
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_SigOpDetLocalCars", "Caracteristicas")
                loc_oBusca.mAddColuna("ccars", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("desccars", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigOpDetLocalCars")
                    loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalCars.ccars)
                ELSE
                    *-- Cancelou: celula VAZIA de proposito, NAO eh o defeito
                    *-- da regra #50. O legado termina o Valid com
                    *-- "This.Value = LocalCars.cCars" INCONDICIONAL: a celula
                    *-- so guarda codigo RELIDO do universo, nunca o texto cru
                    *-- digitado. Devolver o digitado aqui deixaria gravar
                    *-- Caracteristica inexistente em sigmvftc.ccars.
                    loc_cResultado = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
            USE IN cursor_4c_SigOpDetLocalCars
        ENDIF

        RETURN loc_cResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarComplementoDetExec - Valid de Column2.txt_4c_Complemento
    * (legado: busca em LocalFtc filtrado pela Caracteristica da MESMA
    * linha; se o valor nao ficou vazio, zera a coluna Outros/Resps da
    * linha). PUBLIC - chamado via THISFORM (regra #3/#46).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarComplementoDetExec(par_oTxt)
        LOCAL loc_cValor, loc_cCCars

        loc_cCCars = ""
        IF USED("cursor_4c_Itens")
            loc_cCCars = ALLTRIM(NVL(cursor_4c_Itens.ccars, ""))
        ENDIF

        loc_cValor = UPPER(ALLTRIM(par_oTxt.Value))

        IF EMPTY(loc_cValor)
            par_oTxt.Value = ""
        ELSE
            IF USED("cursor_4c_SigOpDetLocalTits")
                USE IN cursor_4c_SigOpDetLocalTits
            ENDIF

            IF USED("cursor_4c_LocalFtc")
                SELECT DISTINCT ctits, descrs FROM cursor_4c_LocalFtc ;
                    WHERE ccars = loc_cCCars INTO CURSOR cursor_4c_SigOpDetLocalTits READWRITE
            ENDIF

            par_oTxt.Value = THIS.AbrirLookupComplementoDet(loc_cValor)
        ENDIF

        *-- Mesmo par canonico do Caracteristica acima (legado: "Replace
        *-- cTits With This.Value in crSigMvFtc" seguido de "If Not
        *-- Empty(This.Value) / Replace Resps With [] in crSigMvFtc" -
        *-- escolher Complemento ZERA a coluna Outros da linha, que eh a
        *-- invariante do When de Column3: Outros so com a linha sem
        *-- Complemento).
        IF THIS.FormParaBO()
            THIS.this_oBusinessObject.this_cCTits = par_oTxt.Value
            IF !EMPTY(par_oTxt.Value)
                THIS.this_oBusinessObject.this_cResps = ""
            ENDIF
            THIS.BOParaForm()
        ENDIF

        par_oTxt.Refresh()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupComplementoDet - FUNIL do lookup da coluna "Complemento"
    * (legado: fwbuscaint sobre LocalTits no Valid de Column2.Text1, com o
    * universo JA filtrado pela Caracteristica da mesma linha). Mesmo
    * contrato do AbrirLookupCaracteristicaDet acima: picker so quando nao
    * casa exato, sem aviso e sem apagar o digitado (regra #50); nome na
    * familia AbrirLookup* por causa dos sweeps (regra #44, item 6);
    * PROTECTED porque so eh chamado via THIS. (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupComplementoDet(par_cValor)
        LOCAL loc_cResultado, loc_oBusca
        loc_cResultado = par_cValor

        IF USED("cursor_4c_SigOpDetLocalTits")
            SELECT cursor_4c_SigOpDetLocalTits
            GO TOP
            LOCATE FOR ctits = par_cValor
            IF FOUND()
                loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalTits.ctits)
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_SigOpDetLocalTits", "Complementos")
                loc_oBusca.mAddColuna("ctits", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigOpDetLocalTits")
                    loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalTits.ctits)
                ELSE
                    *-- Cancelou: celula VAZIA de proposito (mesma razao do
                    *-- AbrirLookupCaracteristicaDet acima - o legado fecha o
                    *-- Valid com "This.Value = LocalTits.ctits" incondicional,
                    *-- logo a celula nunca guarda o texto cru digitado). NAO
                    *-- eh o defeito da regra #50.
                    loc_cResultado = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
            USE IN cursor_4c_SigOpDetLocalTits
        ENDIF

        RETURN loc_cResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirLinhaVaziaGradeDet - LostFocus de Column2/Column3 (legado:
    * com valor preenchido, garante que exista uma linha em branco no fim
    * da grade e desce o foco para ela). PUBLIC - chamado via THISFORM
    * (regra #3/#46).
    *--------------------------------------------------------------------------
    PROCEDURE GarantirLinhaVaziaGradeDet(par_oTxt)
        IF VARTYPE(par_oTxt) != "O" OR EMPTY(ALLTRIM(NVL(par_oTxt.Value, "")))
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !USED("cursor_4c_Itens")
            RETURN
        ENDIF

        SELECT cursor_4c_Itens
        LOCATE FOR EMPTY(ccars)
        IF EOF()
            THIS.this_oBusinessObject.InserirLinhaPadrao()
        ENDIF

        KEYBOARD "{DNARROW}"
        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirDetClick - cmdInserir.Click do legado (guard de modo +
    * garante linha em branco no fim + foca Column1)
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirDetClick()
        IF !THIS.GradeDetEditavel()
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.InserirLinhaPadrao()
        ENDIF

        THIS.grd_4c_Dados.Refresh()
        THIS.grd_4c_Dados.Column1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirDetClick - cmdExcluir.Click do legado (guard de modo +
    * remove a linha corrente)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirDetClick()
        IF !THIS.GradeDetEditavel()
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            *-- Carrega a linha no BO ANTES de remove-la: depois do DELETE o
            *-- ponteiro muda e nao ha mais como saber qual cidchaves saiu -
            *-- eh ele que ObterChavePrimaria()/RegistrarAuditoria usam.
            THIS.FormParaBO()
            THIS.this_oBusinessObject.ExcluirLinhaAtual()
        ENDIF

        THIS.grd_4c_Dados.SetFocus()
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick / BtnCancelarClick - btnConfirmar.Click e
    * btnSair.Click do legado. O dump tem o MESMO corpo nos dois (Validacao
    * + Release) - os dois handlers delegam para o mesmo metodo. PUBLIC
    * (BINDEVENT - regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        THIS.ConfirmarSelecaoDetExec()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.ConfirmarSelecaoDetExec()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarSelecaoDetExec - corpo comum de Confirmar/Cancelar: confere
    * as caracteristicas obrigatorias (Validacao), grava as linhas
    * sobreviventes em SigMvFtc (GravarItens) e fecha o dialogo.
    *
    * DIVERGENCIA DELIBERADA do legado, registrada aqui para nao ser "
    * consertada" por engano num sweep futuro: o "PROCEDURE validacao" do
    * SIGOPDET monta a mensagem e seta "llOk = .F." mas NAO TEM RETURN, e
    * em VFP9 procedure sem RETURN devolve .T. - logo o
    * "If Not ThisForm.Validacao() / Return .f." dos dois Click nunca
    * dispara e o dialogo legado FECHA mesmo faltando Caracteristica
    * obrigatoria (so deixa de purgar as linhas em branco). O par
    * "llOk = .F." + "Return .f." diz a intencao sem ambiguidade, entao
    * aqui o dialogo PERMANECE ABERTO nesse caso - do contrario o aviso
    * seria inutil, porque a tela se fecharia antes de o usuario poder
    * corrigir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfirmarSelecaoDetExec()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Sincroniza o BO com a linha corrente antes de validar e
                *-- gravar: o contexto (empdopnums/cpros) que GravarItens usa
                *-- no DELETE/INSERT de SigMvFtc sai daqui.
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.Validacao()
                    IF THIS.this_oBusinessObject.GravarItens()
                        THIS.Release()
                    ELSE
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar os detalhes selecionados.", "Erro")
                        *-- Validacao() ja apagou as linhas em branco do
                        *-- cursor; o dialogo continua aberto, entao a grade
                        *-- tem de ser repintada para refletir isso (regra
                        *-- #21 - mexer no cursor nao repinta a grade)
                        THIS.RepintarGradeDet()
                    ENDIF
                ELSE
                    *-- Falta Caracteristica obrigatoria: o BO ja avisou e o
                    *-- dialogo PERMANECE aberto (ver a divergencia
                    *-- deliberada documentada acima) - repintar devolve a
                    *-- grade ao topo para o usuario localizar a pendencia
                    THIS.RepintarGradeDet()
                ENDIF
            ELSE
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpDet.ConfirmarSelecaoDetExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria a faixa cinza superior com o titulo
    * (cntSombra do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Labels adicionados FORA do WITH do container: WITH aninhado com
        *-- AddObject ignora propriedades silenciosamente (CLAUDE.md #33)
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = ""
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = 769
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = ""
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria controles com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_p
                    FOR loc_p = 1 TO loc_oCtrl.PageCount
                        THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - fecha os cursores locais do dialogo (equivalente ao
    * PROCEDURE Release do legado, que fazia "Use In LocalFtc"). DODEFAULT()
    * por ultimo: FormBase.Destroy restaura os popups do menu principal
    * apos fechar form modal - sem isso por ultimo, o rendering dos popups
    * fica corrompido (CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_LocalFtc")
            USE IN cursor_4c_LocalFtc
        ENDIF
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpDetBO.prg):
*==============================================================================
* SigOpDetBO.prg - Business Object para o dialogo de Selecao de Detalhes
* (Caracteristicas/Complementos de Produto) - SIGOPDET
*
* Form OPERACIONAL de DIALOGO (WindowType = 1, TitleBar = 0, ControlBox = .F.,
* AutoCenter = .T., AlwaysOnTop = .T., Height = 500, Width = 800) aberto por um
* form PAI - o Init legado recebe "LParameters pCnx, pEscolha, pDopes, pProd,
* pEDN" (pCnx = ThisForm.poDataMgr, nao portado - este ambiente usa o handle
* global gnConnHandle).
*
* OBJETIVO DO DIALOGO
* --------------------
* Exibir, numa grade de 3 colunas (Caracteristica / Complemento / Outros), as
* linhas de SigMvFtc associadas a um item de movimento (par EmpDopNums+Cpros)
* e permitir ao usuario escolher, para cada linha, uma Caracteristica (coluna
* ccars, validada contra SigCrRap) e um Complemento (coluna ctits, validado
* contra SigPrCpP), alem de digitar uma observacao livre (coluna resps).
*
* O universo de Caracteristicas/Complementos permitido para o par
* Grupo (pDopes, equivale a SigCdFtc.cgrus) + Grande Grupo do produto
* (SigCdPro.Mercs) vem de SigCdFtc (filtrada por ntipos = 2), unida com
* SigCrRap (descricao + flag chkobrig - caracteristica obrigatoria) e
* SigPrCpP (descricao do complemento). Essa lista NAO tem tabela propria no
* dialogo - fica numa cursor de referencia (equivalente ao LocalFtc do
* legado), carregada por metodo a implementar na Fase 2.
*
* TABELA PRINCIPAL (persistida e editada por este dialogo): SigMvFtc
*   cidchaves  char(20) NOT NULL  - PK (fUniqueIds() por linha, regra #22)
*   empdopnums char(29) NOT NULL  - chave do movimento (par_cEmpDopNums)
*   cpros      char(14) NOT NULL  - codigo do produto (par_cCpros)
*   ccars      char(20) NOT NULL  - caracteristica selecionada na linha
*   ctits      char(20) NOT NULL  - complemento selecionado na linha
*   resps      char(20) NOT NULL  - observacao/resposta digitada na linha
*   ordens     numeric(6,0) NOT NULL - ordem da linha (sem DEFAULT no schema -
*                                      o legado nunca grava no INSERT da
*                                      cursor local; a Fase 2 precisa decidir
*                                      um valor antes do INSERT real na tabela
*                                      - regra #22)
*
* PARAMETROS RECEBIDOS DO FORM PAI (Init legado, sem o pCnx que nao existe
* mais neste ambiente):
*   this_cModoOperacao - pEscolha (INSERIR/ALTERAR/VISUALIZAR/etc) - decide se
*                        as colunas da grade aceitam edicao (When do legado:
*                        InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR'))
*   this_cGrupo        - pDopes (SigCdFtc.cgrus) - grupo de caracteristicas
*   this_cCpros        - pProd (SigCdPro.Cpros) - produto do item de movimento
*   this_cEmpDopNums   - pEDN (chave do item de movimento, SigMvCab/SigMvItn)
*
* DADO DE REFERENCIA CARREGADO A PARTIR DO PRODUTO (Fase 2):
*   this_cMercs - SigCdPro.Mercs (Grande Grupo do produto), obtido via
*                 CursorQuery/SQLEXEC em SigCdPro WHERE Cpros = this_cCpros.
*                 Usado para filtrar SigCrRap.cgrus = this_cMercs na consulta
*                 da lista de Caracteristicas/Complementos permitidos.
*
* PROPRIEDADES DA LINHA CORRENTE DA GRADE (SigMvFtc - uma linha por vez, no
* padrao de validacao de celula da grade - regra #46: Valid do TextBox da
* coluna, nunca AfterRowColChange):
*   this_cCIdChaves - cidchaves da linha corrente
*   this_cCCars     - ccars da linha corrente (Caracteristica)
*   this_cCTits     - ctits da linha corrente (Complemento)
*   this_cResps     - resps da linha corrente (observacao)
*   this_nOrdens    - ordens da linha corrente
*
* METODOS DE CARGA/PERSISTENCIA DA GRADE (Fase 4):
*   CarregarProduto()        - le SigCdPro para obter this_cMercs
*   CarregarListaReferencia() - popula cursor_4c_LocalFtc (equivalente ao
*                               LocalFtc do legado - join SigCdFtc+SigCrRap+
*                               SigPrCpP)
*   CarregarItens()          - orquestra CarregarProduto+CarregarListaReferencia
*                               e popula cursor_4c_Itens a partir de SigMvFtc
*                               (equivalente ao Init legado), garantindo uma
*                               linha para cada caracteristica obrigatoria
*   InserirLinhaPadrao()     - garante linha em branco no final da grade
*                               (cmdInserir.Click do legado)
*   ExcluirLinhaAtual()      - remove a linha corrente (cmdExcluir.Click)
*   Validacao()              - confere que toda Caracteristica obrigatoria
*                               (SigCrRap.chkobrig=1) tem linha preenchida;
*                               se ok, descarta as linhas em branco
*   GravarItens()            - persiste as linhas sobreviventes em SigMvFtc
*                               (Confirmar/Cancelar do legado - equivalente
*                               ao TABLEUPDATE automatico do cursor remoto
*                               buffered, que este ambiente nao possui)
*   ObterChavePrimaria()      - retorna this_cCIdChaves (ALLTRIM)
*
* Lookup de Caracteristica/Complemento (ValidarCaracteristica/
* ValidarComplemento, equivalentes ao fwbuscaint do legado) vivem no FORM
* (TextBoxGridLookup.prg - regra #46: Valid do TextBox da coluna), nao no BO,
* porque dependem diretamente do TextBox da celula.
*
* Este dialogo PERSISTE uma tabela propria (SigMvFtc, ao contrario de
* SigOpCtsBO/SigOpAutBO) via GravarItens()/Inserir().
*
* Fase 4/8 (atual): carga/persistencia completa da grade.
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpDetBO AS BusinessBase

    *-- Parametros recebidos do form pai na abertura (Init legado: pEscolha,
    *-- pDopes, pProd, pEDN - sem pCnx, que nao existe mais neste ambiente)
    this_cModoOperacao = ""    && pEscolha - INSERIR/ALTERAR/VISUALIZAR/etc
    this_cGrupo        = ""    && pDopes - SigCdFtc.cgrus (grupo de caracteristicas)
    this_cCpros        = ""    && pProd - SigCdPro.Cpros (produto do item de movimento)
    this_cEmpDopNums   = ""    && pEDN - chave do item de movimento (SigMvCab/SigMvItn)

    *-- Dado de referencia obtido a partir do produto (Fase 2:
    *-- CarregarProduto) - usado para filtrar o universo de Caracteristicas/
    *-- Complementos permitidos (SigCrRap.cgrus = this_cMercs)
    this_cMercs = ""            && SigCdPro.Mercs - Grande Grupo do produto

    *-- Propriedades da entidade (mapeamento para tabela SigMvFtc - linha
    *-- corrente da grade, uma linha por vez)
    this_cCIdChaves = ""         && cidchaves char(20) NOT NULL - PK
    this_cCCars     = ""         && ccars char(20) NOT NULL - Caracteristica
    this_cCTits     = ""         && ctits char(20) NOT NULL - Complemento
    this_cResps     = ""         && resps char(20) NOT NULL - observacao da linha
    this_nOrdens    = 0          && ordens numeric(6,0) NOT NULL - ordem da linha

    *====================================================================
    * Init - Inicializa Business Object
    * par_cModoOperacao - pEscolha do legado (INSERIR/ALTERAR/VISUALIZAR)
    * par_cGrupo        - pDopes do legado (SigCdFtc.cgrus)
    * par_cCpros        - pProd do legado (SigCdPro.Cpros)
    * par_cEmpDopNums   - pEDN do legado (chave do item de movimento)
    *====================================================================
    PROCEDURE Init(par_cModoOperacao, par_cGrupo, par_cCpros, par_cEmpDopNums)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvFtc"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cModoOperacao = IIF(VARTYPE(par_cModoOperacao) = "C", ;
                ALLTRIM(par_cModoOperacao), "")
            THIS.this_cGrupo        = IIF(VARTYPE(par_cGrupo) = "C", ;
                ALLTRIM(par_cGrupo), "")
            THIS.this_cCpros        = IIF(VARTYPE(par_cCpros) = "C", ;
                ALLTRIM(par_cCpros), "")
            THIS.this_cEmpDopNums   = IIF(VARTYPE(par_cEmpDopNums) = "C", ;
                ALLTRIM(par_cEmpDopNums), "")

            THIS.this_cMercs = ""

            THIS.this_cCIdChaves = ""
            THIS.this_cCCars     = ""
            THIS.this_cCTits     = ""
            THIS.this_cResps     = ""
            THIS.this_nOrdens    = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades da LINHA CORRENTE da grade
    * a partir de um cursor de SigMvFtc (regra #46: a validacao de celula
    * fica no Valid do TextBox da coluna, que le este metodo depois de
    * posicionar o cursor na linha da grade - nao em AfterRowColChange)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCIdChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCpros      = TratarNulo(cpros,      "C")
                THIS.this_cCCars      = TratarNulo(ccars,      "C")
                THIS.this_cCTits      = TratarNulo(ctits,      "C")
                THIS.this_cResps      = TratarNulo(resps,      "C")
                THIS.this_nOrdens     = TratarNulo(ordens,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna cidchaves da linha corrente (PK de
    * SigMvFtc), usada por RegistrarAuditoria em Inserir/Atualizar
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *====================================================================
    * Inserir - Insere uma nova linha (Caracteristica/Complemento/Resposta)
    * em SigMvFtc para o item de movimento corrente (this_cEmpDopNums +
    * this_cCpros, fixos para o dialogo inteiro - regra #22: cidchaves
    * gerado por fUniqueIds(), nunca string vazia, para nao colidir no
    * indice unico quando a grade tiver mais de uma linha)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCIdChaves)
                THIS.this_cCIdChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvFtc (cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens)
                VALUES (
                    <<EscaparSQL(THIS.this_cCIdChaves)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cCCars)>>,
                    <<EscaparSQL(THIS.this_cCTits)>>,
                    <<EscaparSQL(THIS.this_cResps)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarProduto - Le SigCdPro para obter this_cMercs (Grande Grupo
    * do produto), usado para filtrar o universo de Caracteristicas/
    * Complementos permitidos (equivale ao CursorQuery('SigCdPro',
    * 'crProduto','Cpros',ThisForm.pcPro,'Mercs, Cpros') do Init legado)
    *====================================================================
    PROTECTED PROCEDURE CarregarProduto()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SigOpDetProd")
                USE IN cursor_4c_SigOpDetProd
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT mercs FROM SigCdPro WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpDetProd")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SigOpDetProd") AND RECCOUNT("cursor_4c_SigOpDetProd") > 0
                    THIS.this_cMercs = TratarNulo(cursor_4c_SigOpDetProd.mercs, "C")
                ELSE
                    THIS.this_cMercs = ""
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar o produto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SigOpDetProd")
                USE IN cursor_4c_SigOpDetProd
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarListaReferencia - Monta cursor_4c_LocalFtc (equivalente ao
    * LocalFtc do legado): universo de Caracteristicas/Complementos
    * permitidos para o par Grupo (this_cGrupo = SigCdFtc.cgrus) + Grande
    * Grupo do produto (this_cMercs), com a descricao da caracteristica
    * (SigCrRap.descrs AS Desccars) e do complemento (SigPrCpP.descrs, SEM
    * alias - os nomes finais tem de bater com os das sub-consultas feitas
    * pelo Form em cima deste cursor: "Desccars" e "descrs")
    *====================================================================
    PROTECTED PROCEDURE CarregarListaReferencia()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalFtc")
                USE IN cursor_4c_LocalFtc
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.ccars, b.descrs AS Desccars, a.ctits, b.chkobrig, c.descrs, a.cgrus AS Dopes
                FROM SigCdFtc a
                INNER JOIN SigCrRap b ON a.ccars = b.codigos
                INNER JOIN SigPrCpP c ON a.ctits = c.codigos
                WHERE a.ntipos = 2
                AND a.cgrus = <<EscaparSQL(THIS.this_cGrupo)>>
                AND b.cgrus = <<EscaparSQL(THIS.this_cMercs)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFtc")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar a lista de caracter" + CHR(237) + "sticas/complementos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarListaReferencia")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarItens - Orquestra a carga completa do dialogo (equivalente
    * ao Init legado, do CursorQuery do produto em diante): CarregarProduto,
    * CarregarListaReferencia, popula cursor_4c_Itens (equivalente a
    * crSigMvFtc) a partir de SigMvFtc filtrado por this_cEmpDopNums +
    * this_cCpros, e garante uma linha para CADA caracteristica obrigatoria
    * (SigCrRap.chkobrig = 1) que ainda nao esteja representada
    * (regra do legado: "Insert Into crSigMvFtc (...) Values (...)" dentro
    * do SCAN de CarsObrigs).
    *
    * cursor_4c_Itens nasce de um alias TEMPORARIO + SELECT INTO CURSOR
    * READWRITE (SQLEXEC() sozinho cria cursor so-leitura - a grade do Form
    * precisa editar celulas).
    *====================================================================
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCarObrig, loc_nOrdem
        loc_lSucesso = .F.

        TRY
            IF !THIS.CarregarProduto()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.CarregarListaReferencia()
                    loc_lSucesso = .F.
                ELSE
                    IF USED("cursor_4c_SigOpDetItensTmp")
                        USE IN cursor_4c_SigOpDetItensTmp
                    ENDIF

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        SELECT cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens
                        FROM SigMvFtc
                        WHERE empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>
                        AND cpros = <<EscaparSQL(THIS.this_cCpros)>>
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpDetItensTmp")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao carregar os detalhes do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_Itens")
                            USE IN cursor_4c_Itens
                        ENDIF
                        SELECT * FROM cursor_4c_SigOpDetItensTmp INTO CURSOR cursor_4c_Itens READWRITE
                        IF USED("cursor_4c_SigOpDetItensTmp")
                            USE IN cursor_4c_SigOpDetItensTmp
                        ENDIF

                        *-- Garante uma linha para cada caracteristica obrigatoria
                        *-- ainda nao representada (legado: Insert dentro do Scan)
                        IF USED("cursor_4c_SigOpDetObrigs")
                            USE IN cursor_4c_SigOpDetObrigs
                        ENDIF
                        SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                            WHERE chkobrig = 1 INTO CURSOR cursor_4c_SigOpDetObrigs READWRITE

                        loc_nOrdem = 0
                        SELECT cursor_4c_Itens
                        GO TOP
                        LOCATE FOR !EMPTY(ccars)
                        IF !EOF()
                            loc_nOrdem = RECCOUNT("cursor_4c_Itens")
                        ENDIF

                        IF USED("cursor_4c_SigOpDetObrigs")
                            SELECT cursor_4c_SigOpDetObrigs
                            SCAN
                                loc_cCarObrig = ccars
                                SELECT cursor_4c_Itens
                                LOCATE FOR ccars = loc_cCarObrig
                                IF !FOUND()
                                    loc_nOrdem = loc_nOrdem + 1
                                    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ccars, ordens) ;
                                        VALUES (fUniqueIds(), THIS.this_cEmpDopNums, THIS.this_cCpros, loc_cCarObrig, loc_nOrdem)
                                ENDIF
                                SELECT cursor_4c_SigOpDetObrigs
                            ENDSCAN
                            USE IN cursor_4c_SigOpDetObrigs
                        ENDIF

                        SELECT cursor_4c_Itens
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirLinhaPadrao - Garante que exista uma linha em branco no final
    * de cursor_4c_Itens para o usuario preencher (equivalente ao
    * cmdInserir.Click do legado: so cria se nao houver NENHUMA linha com
    * CCars vazio)
    *====================================================================
    PROCEDURE InserirLinhaPadrao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                GO TOP
                LOCATE FOR EMPTY(ccars)
                IF EOF()
                    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ordens) ;
                        VALUES (fUniqueIds(), THIS.this_cEmpDopNums, THIS.this_cCpros, RECCOUNT("cursor_4c_Itens") + 1)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.InserirLinhaPadrao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Remove a linha corrente de cursor_4c_Itens
    * (equivalente ao cmdExcluir.Click do legado)
    *====================================================================
    PROCEDURE ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.ExcluirLinhaAtual")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Validacao - Confere que toda Caracteristica obrigatoria (SigCrRap.
    * chkobrig = 1) para o par Grupo/Grande Grupo tem uma linha preenchida
    * em cursor_4c_Itens; se faltar alguma, avisa e devolve .F. (mesma
    * mensagem do legado). Se tudo ok, apaga as linhas em branco (Delete
    * From crSigMvFtc where Empty(CCars) do legado) e devolve .T.
    *====================================================================
    FUNCTION Validacao()
        LOCAL loc_lOk, loc_cCarObrig, loc_cDescObrig, loc_cMsg
        loc_lOk  = .T.
        loc_cMsg = ""

        TRY
            IF USED("cursor_4c_SigOpDetObrigs")
                USE IN cursor_4c_SigOpDetObrigs
            ENDIF

            IF USED("cursor_4c_LocalFtc")
                SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                    WHERE chkobrig = 1 INTO CURSOR cursor_4c_SigOpDetObrigs READWRITE

                IF USED("cursor_4c_SigOpDetObrigs")
                    SELECT cursor_4c_SigOpDetObrigs
                    SCAN
                        loc_cCarObrig  = ccars
                        loc_cDescObrig = desccars

                        IF USED("cursor_4c_Itens")
                            SELECT cursor_4c_Itens
                            LOCATE FOR ccars = loc_cCarObrig
                            IF !FOUND()
                                loc_cMsg = loc_cMsg + ALLTRIM(loc_cDescObrig) + CHR(13) + CHR(10)
                                loc_lOk = .F.
                            ENDIF
                        ELSE
                            loc_cMsg = loc_cMsg + ALLTRIM(loc_cDescObrig) + CHR(13) + CHR(10)
                            loc_lOk = .F.
                        ENDIF

                        IF !loc_lOk
                            EXIT
                        ENDIF
                        SELECT cursor_4c_SigOpDetObrigs
                    ENDSCAN
                    USE IN cursor_4c_SigOpDetObrigs
                ENDIF
            ENDIF

            IF !loc_lOk
                MsgAviso("Existem Caracteristicas Obrigat" + CHR(243) + "rias e n" + CHR(227) + "o Foram Informadas." + CHR(13) + CHR(10) + ;
                    CHR(13) + CHR(10) + loc_cMsg + CHR(13) + CHR(10) + "Verifique.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Itens")
                    DELETE FROM cursor_4c_Itens WHERE EMPTY(ccars)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Validacao")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *====================================================================
    * GravarItens - Persiste as linhas sobreviventes de cursor_4c_Itens
    * (apos Validacao() ja ter descartado as em branco) em SigMvFtc. O
    * item de movimento (this_cEmpDopNums + this_cCpros) e gravado por
    * completo: apaga tudo que ja existia na tabela para o item e regrava
    * cada linha corrente do cursor - equivalente, para esta tela, ao
    * TABLEUPDATE automatico do cursor remoto buffered do legado
    * (crSigMvFtc), que este ambiente nao possui.
    *====================================================================
    PROCEDURE GravarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nOrdem
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvFtc
                WHERE empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>
                AND cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao limpar os detalhes anteriores do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
                loc_nOrdem = 0

                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    SCAN FOR !DELETED() AND !EMPTY(ccars)
                        loc_nOrdem = loc_nOrdem + 1

                        THIS.this_cCIdChaves = TratarNulo(cidchaves, "C")
                        THIS.this_cCCars     = TratarNulo(ccars,     "C")
                        THIS.this_cCTits     = TratarNulo(ctits,     "C")
                        THIS.this_cResps     = TratarNulo(resps,     "C")
                        THIS.this_nOrdens    = loc_nOrdem

                        IF EMPTY(THIS.this_cCIdChaves)
                            THIS.this_cCIdChaves = fUniqueIds()
                        ENDIF

                        IF !THIS.Inserir()
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_Itens
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.GravarItens")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

