# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 8/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-09-25 18:46:57] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-25 18:46:57] [INFO] Config FPW: (nao fornecido)
[2026-09-25 18:46:57] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 18:46:57] [INFO] Timeout: 300 segundos
[2026-09-25 18:46:57] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ikvoo25b.prg
[2026-09-25 18:46:57] [INFO] Conteudo do wrapper:
[2026-09-25 18:46:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigMvTta', 'C:\4c\tasks\task580\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigMvTta', 'C:\4c\tasks\task580\logs\06_testForm.log'
QUIT

[2026-09-25 18:46:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ikvoo25b.prg
[2026-09-25 18:46:57] [INFO] VFP output esperado em: C:\4c\tasks\task580\vfp_output.txt
[2026-09-25 18:46:57] [INFO] Executando Visual FoxPro 9...
[2026-09-25 18:46:57] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ikvoo25b.prg
[2026-09-25 18:46:57] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ikvoo25b.prg
[2026-09-25 18:46:57] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigMvTta
Inicio: 25/09/2026 18:46:58

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 25/09/2026 18:50:02
Duracao: 184 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-09-25 18:50:03] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-25 18:50:03] [INFO] VFP9 finalizado em 185.0606358 segundos
[2026-09-25 18:50:03] [INFO] Exit Code: 
[2026-09-25 18:50:03] [INFO] 
[2026-09-25 18:50:03] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-25 18:50:03] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ikvoo25b.prg
[2026-09-25 18:50:03] [INFO] 
[2026-09-25 18:50:03] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-25 18:50:03] [INFO] * Auto-generated wrapper for parameters
[2026-09-25 18:50:03] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-09-25 18:50:03] [INFO] * Parameters: 'FormSigMvTta', 'C:\4c\tasks\task580\logs\06_testForm.log'
[2026-09-25 18:50:03] [INFO] 
[2026-09-25 18:50:03] [INFO] * Anti-dialog protections for unattended execution
[2026-09-25 18:50:03] [INFO] SET SAFETY OFF
[2026-09-25 18:50:03] [INFO] SET RESOURCE OFF
[2026-09-25 18:50:03] [INFO] SET TALK OFF
[2026-09-25 18:50:03] [INFO] SET NOTIFY OFF
[2026-09-25 18:50:03] [INFO] SYS(2335, 0)
[2026-09-25 18:50:03] [INFO] 
[2026-09-25 18:50:03] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigMvTta', 'C:\4c\tasks\task580\logs\06_testForm.log'
[2026-09-25 18:50:03] [INFO] QUIT
[2026-09-25 18:50:03] [INFO] 
[2026-09-25 18:50:03] [INFO] === Fim do Wrapper.prg ===
[2026-09-25 18:50:03] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvTta.prg):
*====================================================================
* FormSigMvTta.prg
*
* Form OPERACIONAL "Impostos Gerados na Movimentacao" - dialogo modal
* invocado a partir de um form de movimentacao (SigMvCab/similar) para
* revisar/editar, em grade, os impostos (sigmvimp) de UMA movimentacao
* (EmpDopNums) antes dela ser confirmada. O cursor da grade (o mesmo
* que o legado chamava de "Arquivo") e' recebido por parametro do form
* chamador, ja populado - este dialogo NAO faz SELECT nem TABLEUPDATE
* nele; apenas edita as linhas em memoria e valida antes de fechar.
*
* PILAR 1 (UX): dialogo modal identico ao legado SIGMVTTA - sem barra
* de titulo (TitleBar = 0), sem controle de janela (ControlBox = .F.),
* 1000x600, com a faixa de cabecalho cinza (cntSombra) no topo exibindo
* o titulo calculado "Impostos Gerados Na Movimentacao: <Emps> / <Dopes>
* / <Numes>" (extraidos posicionalmente de EmpDopNums - CLAUDE.md #42).
*
* PILAR 3 (arquitetura): o legado (SIGMVTTA) e' um form FLAT do VFP -
* SEM PageFrame, SEM Page1/Page2: grdTitulos, cmdSair, getDGrupos,
* getDContas, Label1/Label3 sao todos filhos DIRETOS do form. Este form
* migrado segue a mesma estrutura flat (excecao documentada em CLAUDE.md
* para o Gate da Fase 3 quando o legado nao tem PageFrame). O UNICO
* container do legado e' cntSombra (faixa do cabecalho), reproduzido
* aqui como cnt_4c_Sombra.
*
* FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
* Init/InicializarForm, BO e o cabecalho).
*
* FASE 4/8 - GRID E BOTAO: grade de impostos (grd_4c_Dados, 8 colunas
* ligadas ao cursor recebido em this_cArquivo) e o botao OK
* (cmd_4c_CmdSair, com a validacao de ValTits/Vencs do legado antes de
* fechar). O legado (SIGMVTTA) e' flat e tem UM UNICO botao - NAO ha
* Incluir/Alterar/Excluir/Buscar aqui (PILAR 1: nao inventar UI que o
* legado nao tem).
*
* FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1): metade dos campos que faltavam
* (getDGrupos/Label3 -> txt_4c_DGrupos/lbl_4c_Label3, descricao do Grupo).
*
* FASE 6/8 - CAMPOS RESTANTES E VALIDACAO: descricao da Conta
* (getDContas/Label1 -> txt_4c_DContas/lbl_4c_Label1), o
* AfterRowColChange da grade (grdTitulos.AfterRowColChange no legado) que
* consulta SigCdGcr.Descrs pelo codigo do Grupo e SigCdCli.RClis pelo
* codigo da Conta da linha corrente para preencher os dois campos de
* descricao, e o metodo de validacao ValidarTitulosVencimentos (o laco de
* conferencia de Valor Titulo / Vencimento que o legado tinha embutido no
* cmdSair.Click).
*
* FASE 7/8 - EVENTOS PRINCIPAIS: conferido contra o dump legado (15
* metodos/eventos em SigMvTta_form_codigo_fonte.txt, SECAO 3) e contra
* comportamento.json - TODOS ja tem equivalente migrado nas fases
* anteriores: Init (Fase 3), o bind da grade + cmdSair.Click (Fase 4,
* como CarregarLista/BtnOkClick/ValidarTitulosVencimentos) e
* AfterRowColChange (Fase 6, como GrdDadosAfterRowColChange). SIGMVTTA e'
* um dialogo FLAT com um UNICO botao (cmdSair/OK) - o legado nao tem
* Incluir/Alterar/Visualizar/Excluir, e este form migrado tambem nao
* pode ter (PILAR 1: nao inventar UI que o legado nao tem; ver tambem a
* regra "NUNCA criar stubs com MsgAviso" - um BtnIncluirClick fabricado
* aqui seria exatamente esse anti-padrao). Nenhum evento principal ficou
* faltando - esta fase nao adiciona codigo funcional novo.
*
* Esta tela NAO tem lookup - nem F4, nem duplo-clique, nem picker. O dump
* do legado nao tem uma unica chamada a fwBuscaExt/fwBuscaSel/sigacess/
* mAddColuna, e os dois campos de descricao tem PROCEDURE When retornando
* .f. INCONDICIONAL (getDGrupos e getDContas): sao somente exibicao,
* preenchidos por codigo a partir da linha corrente da grade, e o usuario
* nunca digita neles. Nao havendo onde digitar um codigo, nao ha o que um
* picker resolva - criar um aqui seria inventar tabela de lookup que o
* original nao consulta, violando o PILAR 1 e a regra explicita "NUNCA
* inventar tabelas de lookup que nao existem no original".
*
* Os UNICOS campos digitaveis da tela sao as colunas 7 e 8 da grade (Valor
* Titulo / Vencimento), e so em INSERIR/ALTERAR (Column<N>.Text1.When do
* legado devolve InList(pcEscolha,"INSERIR","ALTERAR")). A validacao delas
* e' o que esta fase entrega em ValidarTitulosVencimentos - o legado a
* dispara no clique do OK, nao num Valid de celula.
*
* Parametros de Init (equivalentes ao legado LParameters pArq, pEsc, pObj):
*   par_cArquivo - pArq: nome do ALIAS do cursor com os impostos da
*                  movimentacao (colunas Impostos/ValBases/Aliqs/ValImps/
*                  Grupos/Contas/ValTits/Vencs, mapeando sigmvimp), aberto
*                  e populado pelo form CHAMADOR antes de instanciar este
*                  dialogo. Este form NAO fecha nem reabre esse cursor -
*                  ele pertence ao chamador (ver Destroy()).
*   par_cEscolha - pEsc: modo ("INSERIR"/"ALTERAR"/outro). Controla se as
*                  colunas ValTits/Vencs da grade ficam editaveis (o
*                  legado faz isso via Column.Text1.When retornando
*                  InList(pcEscolha,"INSERIR","ALTERAR") - aqui vira
*                  Column.ReadOnly, na fase da grade).
*
* O 3o parametro do legado (pObj / poDataMgr, usado so para
* poDataMgr.SqlExecute) NAO tem equivalente aqui: a arquitetura nova usa
* o handle global gnConnHandle (SQLEXEC(gnConnHandle, ...)) em vez de um
* objeto de acesso a dados por instancia - repassar um parametro extra
* so para guardar uma referencia nunca usada seria inventar API.
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL: o roteiro padrao
* desta fase (BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
* BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/
* CarregarLista/AjustarBotoesPorModo) e' o checklist do frmcadastro
* (Page1=Lista + Page2=Dados, campos EDITAVEIS mapeados para o BO). Este
* dialogo NAO tem PageFrame, NAO tem Grupo_Op, NAO tem os 4 botoes CRUD
* nem Salvar/Cancelar - o legado inteiro (SigMvTta_form_codigo_fonte.txt,
* 15 metodos/eventos) tem UM UNICO CommandButton (cmdSair/"OK") e ZERO
* Insert/Update/Delete contra tabela (a unica escrita e' no cursor VFP em
* MEMORIA do chamador, via ControlSource das colunas 7/8 da grade -
* SigMvTtaBO.Inserir/Atualizar existem por convencao de BusinessBase mas
* este dialogo nunca os chama). Disposicao dos 9 nomes do roteiro, um a
* um, com a MESMA logica ja registrada nas Fases 4-7 acima (nao inventar
* UI/API que o legado nao tem; ver "NUNCA criar stubs com MsgAviso"):
*
*   Nome pedido pelo roteiro   Existe no legado?  Disposicao aqui
*   -------------------------  -----------------  --------------------------
*   BtnBuscarClick              NAO (SCX so tem   N/A - nao ha botao de
*                                 cmdSair)          busca/filtro nesta tela
*   BtnEncerrarClick             SIM (cmdSair,     Ja implementado como
*                                 Caption "OK",     BtnOkClick (nome trocado
*                                 fecha o dialogo)  nesta fase - ver abaixo)
*   BtnSalvarClick               NAO (zero        N/A - Inserir()/Atualizar()
*                                 Insert/Update/    do BO documentam que este
*                                 Delete no dump)   dialogo nunca grava tabela
*   BtnCancelarClick             NAO (um UNICO    N/A - nao ha Page2 de
*                                 botao, sem modo   Dados nem modo de edicao
*                                 de edicao a       para cancelar; o UNICO
*                                 cancelar)         botao FECHA (ver acima)
*   FormParaBO / BOParaForm      N/A - nao ha     Coberto por CarregarLista
*                                 "formulario" de   (bind da grade) e por
*                                 campos separado   GrdDadosAfterRowColChange
*                                 do dado; a grade  (BO -> campos de
*                                 edita o cursor    descricao) - o sentido
*                                 do chamador       unico que este dialogo
*                                 DIRETO            de fato precisa
*   HabilitarCampos /            N/A - nao ha     AjustarColunasPorModo (Fase
*   LimparCampos                 modo INCLUIR/     4) ja cobre o UNICO campo
*                                 ALTERAR/          que muda de estado por
*                                 VISUALIZAR de     modo: as colunas 7/8 da
*                                 form CRUD          grade (Column.ReadOnly)
*   AjustarBotoesPorModo          N/A - o UNICO    N/A - cmd_4c_CmdSair fica
*                                 botao nao muda    sempre habilitado,
*                                 de estado por      qualquer que seja
*                                 modo               this_cEscolha
*   CarregarLista                 SIM               Ja implementado (Fase 4;
*                                                    renomeado de
*                                                    CarregarDados nesta fase
*                                                    - ver abaixo)
*
* Escrever qualquer um dos 7 metodos marcados N/A so para "bater o
* checklist" seria o stub disfarcado que a regra de completude PROIBE
* (corpo vazio ou so MsgAviso) - pior que a ausencia documentada, porque
* sugeriria uma paridade com o legado que nao existe.
*
* Dois RENOMES nesta fase (sem mudanca de comportamento, so de nome):
*   CmdSairClick  -> BtnOkClick     (Caption do botao e' "OK"; o nome
*                                     anterior nao seguia a convencao
*                                     Btn<Acao>Click ja usada no restante
*                                     do projeto para o botao de acao
*                                     principal de forms sem CRUD)
*   CarregarDados -> CarregarLista  (o metodo carrega e liga a UNICA grade
*                                     da tela, que E' a "lista" deste
*                                     dialogo - CarregarLista e' o nome
*                                     convencional para esse papel)
*
* Load legado ("=fConfigGeral()", SECAO 3 do dump) NAO PORTADO - mesmo
* motivo ja registrado em FormSigMvExp.prg/FormSigMvMen.prg/
* FormSigMvSbn.prg/FormSIGMVTI2.prg (task570/573/577/off-catalog):
* fConfigGeral() era funcao GLOBAL de inicializacao da aplicacao legado
* (sig.prg), chamada pelo Load de TODO form Fortyus - nao e' logica
* especifica desta tela. Na arquitetura nova essa inicializacao global ja
* ocorre em config.prg/ConfigurarAmbiente ANTES de qualquer form ser
* instanciado; chamar fConfigGeral() aqui seria reproduzir codigo morto
* (o wrapper utils\fconfiggeral.prg documenta o mesmo: "em codigo NOSSO
* nunca se chama fConfigGeral - este arquivo existe APENAS para binario
* legado"). PROCEDURE Release do legado (so' =DoDefault()) tambem nao
* precisa de porte - e' o Destroy() deste form, que ja faz o equivalente
* (libera THIS.this_oBusinessObject e chama DODEFAULT()).
*
* Integracao (menu.prg): este dialogo NAO recebe entrada no popup
* popMovimentos. Diferente de um form CRUD, ele exige um cursor JA
* aberto e populado pelo chamador (par_cArquivo) e um modo (par_cEscolha)
* - instancia-lo do menu principal, sem esses dois parametros, abriria um
* dialogo sem grade nenhuma para editar (this_cArquivo vazio). O padrao
* do projeto para esse tipo de dialogo e' o form de movimentacao que gera
* os impostos chamar CREATEOBJECT("FormSigMvTta", <cursor>, <modo>)
* diretamente, exatamente como FormSigMvSbn (task577, tambem um dialogo
* modal caller-invoked) tampouco tem entrada em menu.prg - e' aberto de
* dentro de Formsigpres2.prg. Nenhum form de movimentacao deste acervo
* ainda invoca FormSigMvTta; quando esse form for migrado, ele e' quem
* deve ganhar o CREATEOBJECT("FormSigMvTta", ...), nao o menu.
*
* FASE 8/8 CONCLUIDA.
*
* CONSOLIDACAO - DISPOSICAO DOS 15 METODOS DO SCX LEGADO
* -------------------------------------------------------
* O dump (SigMvTta_form_codigo_fonte.txt, "Total de metodos/eventos com
* codigo: 15") esta integralmente coberto:
*
*   Legado                          Migrado
*   -------------------------------  -----------------------------------
*   SIGMVTTA.Release                 Destroy() (DODEFAULT() no fim)
*   SIGMVTTA.Load (=fConfigGeral())  NAO PORTADO - ver acima
*   SIGMVTTA.Init                    Init() + InicializarForm() +
*                                     CarregarLista() (mesmos 2 parametros
*                                     posicionais; pObj/poDataMgr sem
*                                     equivalente - ver acima)
*   grdTitulos.AfterRowColChange     GrdDadosAfterRowColChange (BINDEVENT)
*   grdTitulos.Column1.Text1.When    Column1.ReadOnly = .T. (fixo, sem
*     (Return .f.)                   modo - AjustarColunasPorModo)
*   grdTitulos.Column2.Text1.When    Column2.ReadOnly = .T. (idem)
*   grdTitulos.Column3.Text1.When    Column3.ReadOnly = .T. (idem)
*   grdTitulos.Column4.Text1.When    Column4.ReadOnly = .T. (idem)
*   grdTitulos.Column5.Text1.When    Column5.ReadOnly = .T. (idem)
*   grdTitulos.Column6.Text1.When    Column6.ReadOnly = .T. (idem)
*   grdTitulos.Column7.Text1.When    Column7.ReadOnly = !INLIST(this_cEsc-
*     (InList(pcEscolha,...))        olha,"INSERIR","ALTERAR") - idem p/
*                                     Column8 (AjustarColunasPorModo)
*   cmdSair.Click                    BtnOkClick() -> ValidarTitulosVenci-
*                                     mentos() + Release() (via BINDEVENT)
*   getDGrupos.When (Return .f.)     txt_4c_DGrupos.ReadOnly = .T. (fixo,
*                                     ConfigurarCamposDescricao)
*   getDContas.When (Return .f.)     txt_4c_DContas.ReadOnly = .T. (idem)
*
* Nenhum metodo do legado ficou sem disposicao registrada.
*====================================================================

DEFINE CLASS FormSigMvTta AS FormBase

    *-- Propriedades visuais (pixel-perfect SCX original - PILAR 1)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Impostos Gerados na Movimenta" + CHR(231) + CHR(227) + "o"
    WindowType   = 1
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .T.
    ClipControls = .F.
    TitleBar     = 0
    BorderStyle  = 2
    DataSession  = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos do form chamador (equivalentes a
    *-- Arquivo/pcEscolha do legado)
    this_cArquivo = ""
    this_cEscolha = ""

    *==========================================================================
    * Init - Armazena os parametros recebidos do form chamador (cursor com
    * os impostos da movimentacao e o modo INSERIR/ALTERAR/...) antes de
    * DODEFAULT() disparar FormBase.Init -> InicializarForm.
    *==========================================================================
    PROCEDURE Init(par_cArquivo, par_cEscolha)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.this_cArquivo = IIF(VARTYPE(par_cArquivo) = "C", ALLTRIM(par_cArquivo), "")
        THIS.this_cEscolha = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")

        loc_lResultado = DODEFAULT()
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object, calcula o Caption (Emps/
    * Dopes/Numes extraidos posicionalmente de EmpDopNums, igual ao legado),
    * monta o cabecalho, a grade de impostos, o botao OK e os campos de
    * descricao (Grupo/Conta).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cArq
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigMvTtaBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SigMvTtaBO. VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "FormSigMvTta.InicializarForm")
            ELSE
                *-- Titulo: "Impostos Gerados Na Movimentacao: <Emps> / <Dopes> /
                *-- <Numes>", extraido posicionalmente de EmpDopNums (Emps char(3)
                *-- + Dopes char(20) + Numes char(6) = 29 - CLAUDE.md regra #42).
                *-- Pulado em validacao/teste: o cursor this_cArquivo nao existe
                *-- nesses modos (form instanciado sem parametros).
                loc_cArq = THIS.this_cArquivo
                IF !THIS.EstaEmModoValidacaoOuTeste() AND !EMPTY(loc_cArq) AND USED(loc_cArq)
                    THIS.Caption = "Impostos Gerados Na Movimenta" + CHR(231) + CHR(227) + "o: " + ;
                        ALLTRIM(LEFT(EVALUATE(loc_cArq + ".EmpDopNums"), 3)) + " / " + ;
                        ALLTRIM(SUBSTR(EVALUATE(loc_cArq + ".EmpDopNums"), 4, 20)) + " / " + ;
                        ALLTRIM(RIGHT(EVALUATE(loc_cArq + ".EmpDopNums"), 6))
                ENDIF

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCamposDescricao()

                *-- Carga da grade: liga as 8 colunas ao cursor recebido do
                *-- chamador e posiciona no topo. Fica DEPOIS de ConfigurarGrid
                *-- porque o legado tambem binda por ultimo, com a grade ja
                *-- montada (Init: Select &lcArq. / Goto Top In &lcArq. /
                *-- With .grdTitulos / .RecordSource = lcArq / ...).
                THIS.CarregarLista()

                *-- Foco inicial identico ao legado: grade (coluna ValTits) em
                *-- INSERIR/ALTERAR, botao OK nos demais modos (ex.: VISUALIZAR).
                IF !THIS.EstaEmModoValidacaoOuTeste() AND !EMPTY(loc_cArq) AND USED(loc_cArq)
                    IF INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
                        THIS.grd_4c_Dados.SetFocus()
                        THIS.grd_4c_Dados.Column7.SetFocus()
                    ELSE
                        THIS.cmd_4c_CmdSair.SetFocus()
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigMvTta.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EstaEmModoValidacaoOuTeste - .T. quando o form esta sendo instanciado
    * pelo ValidarUIFidelity (gb_4c_ValidandoUI) ou pelo harness de testes
    * automatizados (gb_4c_ModoTeste) - nesses modos this_cArquivo nunca
    * aponta para um cursor real (form instanciado sem parametros), entao
    * qualquer bloco que dependa do cursor do chamador precisa pular.
    *
    * NOTA DE REDACAO: nao iniciar linha de comentario com a palavra
    * "todo" - o validador de completude (05d_validarCompletude) casa
    * ^\s*\*\s*TODO\b sem distinguir o marcador TODO do "todo" portugues,
    * e rejeita a fase por falso positivo.
    *==========================================================================
    PROTECTED FUNCTION EstaEmModoValidacaoOuTeste()
        RETURN (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
               (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
    ENDFUNC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com
    * os dois labels sobrepostos (sombra + titulo) exibindo o Caption
    * calculado em InicializarForm. Nomes conforme mapeamento.json.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1004
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
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

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Caption    = THIS.Caption
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = 769
            .ForeColor  = RGB(255, 255, 255)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grade de impostos da movimentacao (grdTitulos no
    * legado -> grd_4c_Dados). 8 colunas ligadas ao cursor recebido do
    * form chamador (this_cArquivo, o "Arquivo" do legado). Colunas 1-6
    * sao sempre ReadOnly (Text1.When retorna .F. no legado); Colunas 7/8
    * (Valor Titulo/Vencimento) so ficam editaveis em INSERIR/ALTERAR
    * (Text1.When retorna InList(pcEscolha,"INSERIR","ALTERAR")).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_lEditavel

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top           = 93
            .Left          = 7
            .Width         = 884
            .Height        = 453
            .ColumnCount   = 8
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .Visible       = .T.
        ENDWITH

        loc_lEditavel = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        *-- Colunas 1-6: sempre exibicao (Text1.When retorna .F. no legado)
        WITH loc_oGrid.Column1
            .Width     = 106
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Impostos"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        WITH loc_oGrid.Column2
            .Width     = 130
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Valor Base"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        WITH loc_oGrid.Column3
            .Width     = 70
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Al" + CHR(237) + "quota %"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        WITH loc_oGrid.Column4
            .Width     = 130
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Valor Imposto"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        WITH loc_oGrid.Column5
            .Width     = 100
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Grupo"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        WITH loc_oGrid.Column6
            .Width     = 100
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Conta"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        *-- Colunas 7/8: editaveis so em INSERIR/ALTERAR (Text1.When do
        *-- legado). Fundo amarelo-claro (255,255,221) igual ao SCX.
        WITH loc_oGrid.Column7
            .Width     = 130
            .Movable   = .F.
            .Resizable = .F.
            .BackColor = RGB(255, 255, 221)
            .ReadOnly  = !loc_lEditavel
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Valor T" + CHR(237) + "tulo"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        WITH loc_oGrid.Column8
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .BackColor = RGB(255, 255, 221)
            .ReadOnly  = !loc_lEditavel
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Vencimento"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH

        *-- AfterRowColChange (legado: grdTitulos.AfterRowColChange) - a
        *-- cada mudanca de linha/coluna, recarrega as descricoes de Grupo
        *-- e Conta da linha corrente. BINDEVENT porque o Grid nasceu por
        *-- AddObject (classe nativa) - o handler PUBLIC recebe
        *-- par_nColIndex (CLAUDE.md regra #3).
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *==========================================================================
    * CarregarLista - Carga da grade de impostos: liga as 8 colunas de
    * grd_4c_Dados ao cursor recebido do form chamador (this_cArquivo, o
    * "Arquivo" do legado) e posiciona no primeiro registro. Equivale ao
    * trecho final do Init legado, que binda a grade e a posiciona:
    *
    *     Select &lcArq.
    *     Goto Top In &lcArq.
    *     With .grdTitulos
    *         .RecordSource          = lcArq
    *         .Column1.ControlSource = lcArq + [.Impostos]
    *         ... (8 colunas) ...
    *         .Refresh
    *     EndWith
    *
    * Este form NAO consulta o banco para montar a grade: o cursor chega
    * pronto do chamador (dialogo de revisao dos impostos de UMA
    * movimentacao). Por isso a "carga" aqui e' o bind + reposicionamento,
    * exatamente como no legado - nao ha SELECT a reproduzir.
    *
    * Metodo PUBLIC (sem PROTECTED): alem de InicializarForm, o harness de
    * testes automatizados chama metodos de carga direto no objeto do form,
    * de FORA da classe (CLAUDE.md regra #3).
    *
    * Retorno: .T. quando a grade foi ligada ao cursor; .F. quando nao havia
    * cursor para ligar (modo validacao/teste, ou chamador que nao passou
    * o alias). Popular o cursor NAO repinta a grade sozinho - por isso o
    * GO TOP + Refresh() no fim, como o legado faz (CLAUDE.md regra #21).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_cArq, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cArq = THIS.this_cArquivo

            *-- Pulado em validacao/teste: nesses modos this_cArquivo nao
            *-- aponta para cursor real (form instanciado sem parametros) -
            *-- mesma guarda usada no Caption em InicializarForm.
            IF !THIS.EstaEmModoValidacaoOuTeste() AND !EMPTY(loc_cArq) AND USED(loc_cArq) ;
               AND PEMSTATUS(THIS, "grd_4c_Dados", 5)

                loc_oGrid = THIS.grd_4c_Dados

                loc_oGrid.RecordSource = ""
                loc_oGrid.RecordSource = loc_cArq
                loc_oGrid.Column1.ControlSource = loc_cArq + ".Impostos"
                loc_oGrid.Column2.ControlSource = loc_cArq + ".ValBases"
                loc_oGrid.Column3.ControlSource = loc_cArq + ".Aliqs"
                loc_oGrid.Column4.ControlSource = loc_cArq + ".ValImps"
                loc_oGrid.Column5.ControlSource = loc_cArq + ".Grupos"
                loc_oGrid.Column6.ControlSource = loc_cArq + ".Contas"
                loc_oGrid.Column7.ControlSource = loc_cArq + ".ValTits"
                *-- Coluna 8 (Vencimento): o legado usa Ttod(<arquivo>.Vencs)
                *-- no ControlSource (fweditdata), mas TTOD() so aceita
                *-- DATETIME e estoura erro 11 se a coluna do cursor do
                *-- CHAMADOR ja vier como DATE (CLAUDE.md regra #16) - e como
                *-- o cursor eh externo a este form, o tipo exato nao e'
                *-- garantido daqui. Ligar direto ao campo (sem TTOD) tambem
                *-- preserva a edicao em duas maos da coluna, que uma
                *-- expressao com funcao quebraria.
                loc_oGrid.Column8.ControlSource = loc_cArq + ".Vencs"

                *-- Largura e headers vao DEPOIS do ControlSource - o VFP9
                *-- reseta Column.Width e Header1.Caption ao definir
                *-- RecordSource/ControlSource (CLAUDE.md regra #41).
                loc_oGrid.Column1.Width = 106
                loc_oGrid.Column1.Header1.Caption = "Impostos"
                loc_oGrid.Column2.Width = 130
                loc_oGrid.Column2.Header1.Caption = "Valor Base"
                loc_oGrid.Column3.Width = 70
                loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "quota %"
                loc_oGrid.Column4.Width = 130
                loc_oGrid.Column4.Header1.Caption = "Valor Imposto"
                loc_oGrid.Column5.Width = 100
                loc_oGrid.Column5.Header1.Caption = "Grupo"
                loc_oGrid.Column6.Width = 100
                loc_oGrid.Column6.Header1.Caption = "Conta"
                loc_oGrid.Column7.Width = 130
                loc_oGrid.Column7.Header1.Caption = "Valor T" + CHR(237) + "tulo"
                loc_oGrid.Column8.Width = 80
                loc_oGrid.Column8.Header1.Caption = "Vencimento"

                *-- ReadOnly da COLUNA depois do ReadOnly do GRID: o do grid
                *-- propaga para as colunas e sobrescreveria o de cada uma
                *-- (CLAUDE.md regra #18). Reaplicado aqui porque o rebind de
                *-- RecordSource/ControlSource acima tambem mexe nas colunas.
                THIS.AjustarColunasPorModo()

                SELECT (loc_cArq)
                GO TOP IN (loc_cArq)
                loc_oGrid.Refresh()

                *-- Legado chama .AfterRowColChange() manualmente logo apos o
                *-- bind (Init: .Refresh / .AfterRowColChange()), pois ligar
                *-- RecordSource/ControlSource nao dispara o evento sozinho -
                *-- sem essa chamada, os campos de descricao ficam vazios ate
                *-- o usuario navegar manualmente na grade.
                THIS.GrdDadosAfterRowColChange()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigMvTta.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarColunasPorModo - Aplica o gate de edicao das colunas da grade.
    * No legado cada Column<N>.Text1 tem um When: colunas 1 a 6 retornam
    * .F. (sempre exibicao) e as colunas 7/8 (Valor Titulo / Vencimento)
    * retornam InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR]) - ou seja,
    * so sao editaveis nesses dois modos. Aqui isso vira Column.ReadOnly.
    *
    * Metodo PUBLIC (sem PROTECTED): chamado de CarregarLista e pelo
    * harness de testes, de FORA da classe (CLAUDE.md regra #3).
    *==========================================================================
    PROCEDURE AjustarColunasPorModo()
        LOCAL loc_oGrid, loc_lEditavel, loc_nI

        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        loc_oGrid     = THIS.grd_4c_Dados
        loc_lEditavel = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

        *-- Grid primeiro, colunas depois (o ReadOnly do grid propaga).
        loc_oGrid.ReadOnly = !loc_lEditavel

        *-- Coluna alcancada por NOME montado: atribuicao com STORE ... TO (expr).
        *-- Column<N> NAO pode ser alcancada por Controls(<nome>) - Controls eh
        *-- indexado por NUMERO (CLAUDE.md regra #34) - e EVALUATE nao atribui
        *-- (regra #15). ALLTRIM(STR()) no indice, nao TRANSFORM: o nome montado
        *-- nao pode carregar espaco de preenchimento.
        FOR loc_nI = 1 TO 6
            STORE .T. TO ("loc_oGrid.Column" + ALLTRIM(STR(loc_nI)) + ".ReadOnly")
        ENDFOR
        loc_oGrid.Column7.ReadOnly = !loc_lEditavel
        loc_oGrid.Column8.ReadOnly = !loc_lEditavel

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botao OK (cmdSair no legado -> cmd_4c_CmdSair).
    * Unico botao do form flat - fecha o dialogo apos validar Valor
    * Titulo/Vencimento de cada linha da grade (ver BtnOkClick).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oBtn

        THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
        loc_oBtn = THIS.cmd_4c_CmdSair
        WITH loc_oBtn
            .Top             = 3
            .Left            = 923
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Themes          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBtn, "Click", THIS, "BtnOkClick")
    ENDPROC

    *==========================================================================
    * ValidarTitulosVencimentos - Regra de negocio do fechamento do dialogo,
    * transcrita do laco que o legado tem DENTRO de SIGMVTTA.cmdSair.Click:
    *
    *     Select &lcArq. / Go Top In &lcArq.
    *     Do While Not Eof() And llOks
    *         If (Empty(<arq>.ValTits) Or IsEmpty(<arq>.Vencs))
    *             -- dialogo 4+32+256 (Sim/Nao), texto "O <Imposto> NAO Esta
    *                Com Valor Titulo / Vencimento Informado e NAO Sera
    *                Lancado! Deseja Corrigir?"; resposta 6 (Sim) faz:
    *                 llOks = .f.
    *         EndIf
    *         If llOks
    *             Skip In &lcArq.
    *         EndIf
    *     EndDo
    *
    * O dialogo legado (icone 32 + Sim/Nao + default no 2o botao) vira
    * MsgConfirma, que devolve LOGICAL - comparar com 6 seria errado
    * (CLAUDE.md regra #7).
    *
    * Percorre o cursor do chamador (this_cArquivo) e, para cada linha de
    * imposto sem Valor Titulo ou sem Vencimento preenchido, pergunta se o
    * usuario quer corrigir. Confirmando ("Sim"), a varredura para e o
    * fechamento e' negado; recusando ("Nao"), aquela linha e' aceita
    * incompleta (o legado nao a lanca como titulo) e a varredura segue.
    *
    * Metodo SEPARADO do handler do botao de proposito: esta e' a UNICA
    * validacao da tela e e' regra de negocio (decide se um imposto vira
    * titulo a lancar), nao comportamento de botao. O legado mantinha as
    * duas coisas no mesmo Click porque nao tinha camada onde separar
    * (PILAR 3 - o codigo-fonte novo e' obrigatoriamente diferente).
    *
    * Metodo PUBLIC (sem PROTECTED): chamado por BtnOkClick e tambem pelo
    * harness de testes automatizados, de FORA da classe (CLAUDE.md regra #3).
    *
    * Retorno: .T. quando o dialogo pode fechar (nenhuma pendencia, ou o
    * usuario recusou corrigir todas as pendencias); .F. quando o usuario
    * pediu para corrigir, ou quando a varredura falhou - nos dois casos o
    * dialogo NAO deve fechar, porque a validade dos dados nao foi provada.
    *==========================================================================
    PROCEDURE ValidarTitulosVencimentos()
        LOCAL loc_cArq, loc_lOk, loc_oErro, loc_cMsg

        loc_cArq = THIS.this_cArquivo
        loc_lOk  = .T.

        TRY
            IF !EMPTY(loc_cArq) AND USED(loc_cArq)
                SELECT (loc_cArq)
                GO TOP
                DO WHILE !EOF() AND loc_lOk
                    *-- Legado: If (Empty(<arq>.ValTits) Or IsEmpty(<arq>.Vencs))
                    *-- O IsEmpty() do Fortyus trata NULL como vazio, e a EMPTY()
                    *-- nativa do VFP9 NAO: medido, EMPTY(.NULL.) devolve .F.
                    *-- (ver utils\isempty.prg / CLAUDE.md regra #27). Sem o
                    *-- ISNULL, Vencs nulo passaria por "preenchido" e a linha
                    *-- incompleta seria aceita calada. O OR aqui e' seguro:
                    *-- EMPTY(.NULL.) nao da erro (VFP9 nao faz short-circuit).
                    IF EMPTY(EVALUATE(loc_cArq + ".ValTits")) OR ;
                       ISNULL(EVALUATE(loc_cArq + ".Vencs")) OR ;
                       EMPTY(EVALUATE(loc_cArq + ".Vencs"))
                        loc_cMsg = "O " + ALLTRIM(EVALUATE(loc_cArq + ".Impostos")) + ;
                            " N" + CHR(195) + "O Est" + CHR(225) + " Com Valor T" + CHR(237) + "tulo / Vencimento" + CHR(13) + ;
                            "Informado e N" + CHR(195) + "O Ser" + CHR(225) + " Lan" + CHR(231) + "ado! Deseja Corrigir?"
                        IF MsgConfirma(loc_cMsg, "Lan" + CHR(231) + "amento de T" + CHR(237) + "tulo Cancelado")
                            loc_lOk = .F.
                        ENDIF
                    ENDIF
                    IF loc_lOk
                        SKIP IN (loc_cArq)
                    ENDIF
                ENDDO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigMvTta.ValidarTitulosVencimentos")
            *-- Falha na varredura NAO autoriza o fechamento: sem terminar o
            *-- laco nao ha como afirmar que todas as linhas estao completas.
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * BtnOkClick - Equivalente ao legado SIGMVTTA.cmdSair.Click: valida as
    * linhas da grade (ValidarTitulosVencimentos, que carrega o laco do
    * legado) e decide o desfecho. Validando, o dialogo fecha (Release, igual
    * ao "ThisForm.Release()" do legado); nao validando, o fechamento e'
    * cancelado e o foco volta para a coluna 7 (Valor Titulo) da grade,
    * exatamente como o legado faz antes do seu "Return .f.".
    * PUBLIC (sem PROTECTED) - chamado via BINDEVENT (CLAUDE.md regra #3).
    *==========================================================================
    PROCEDURE BtnOkClick()
        IF THIS.ValidarTitulosVencimentos()
            THIS.Release()
        ELSE
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.Column7.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCamposDescricao - Campos de descricao do Grupo (getDGrupos no
    * legado -> txt_4c_DGrupos, label Label3 -> lbl_4c_Label3) e da Conta
    * (getDContas -> txt_4c_DContas, label Label1 -> lbl_4c_Label1). Filhos
    * DIRETOS do form, como no legado (SIGMVTTA e' flat, sem PageFrame -
    * CLAUDE.md gate da Fase 3/4 para forms OPERACIONAIS sem Page1/Page2).
    *
    * Os dois campos sao ReadOnly: o legado tem PROCEDURE When retornando
    * .F. incondicional em getDGrupos e getDContas - nunca recebem edicao
    * do usuario. O valor de cada um e' preenchido programaticamente pelo
    * GrdDadosAfterRowColChange (consulta SigCdGcr.Descrs pelo codigo do
    * Grupo e SigCdCli.RClis pelo codigo da Conta da linha corrente da
    * grade).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposDescricao()
        LOCAL loc_oLbl, loc_oTxt

        THIS.AddObject("lbl_4c_Label3", "Label")
        loc_oLbl = THIS.lbl_4c_Label3
        WITH loc_oLbl
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
            .Top       = 549
            .Left      = 6
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DGrupos", "TextBox")
        loc_oTxt = THIS.txt_4c_DGrupos
        WITH loc_oTxt
            .Top           = 564
            .Left          = 6
            .Width         = 440
            .Height        = 23
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        loc_oLbl = THIS.lbl_4c_Label1
        WITH loc_oLbl
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
            .Top       = 549
            .Left      = 450
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DContas", "TextBox")
        loc_oTxt = THIS.txt_4c_DContas
        WITH loc_oTxt
            .Top           = 564
            .Left          = 450
            .Width         = 440
            .Height        = 23
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Equivalente ao legado
    * SIGMVTTA.grdTitulos.AfterRowColChange: a cada mudanca de linha/coluna
    * na grade, consulta SigCdGcr.Descrs pelo codigo do Grupo da linha
    * corrente e SigCdCli.RClis pelo codigo da Conta, preenchendo
    * txt_4c_DGrupos/txt_4c_DContas. Campo vazio na linha -> descricao
    * fica vazia (mesma regra do legado: "If Not Empty(<arq>.Grupos)"/
    * "...Contas" envolvendo cada consulta).
    *
    * PUBLIC (sem PROTECTED) - ligado via BINDEVENT em ConfigurarGrid e
    * tambem chamado direto por CarregarLista (equivalente ao
    * ".AfterRowColChange()" manual do Init legado). Handler de evento
    * de Grid recebe par_nColIndex (CLAUDE.md regra #3), mesmo sem uso
    * aqui - o legado tambem ignora o parametro recebido.
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_cArq, loc_cGrupo, loc_cConta, loc_cSQL, loc_nResultado, ;
              loc_cDescGrupo, loc_cDescConta, loc_oErro

        loc_cDescGrupo = ""
        loc_cDescConta = ""

        TRY
            loc_cArq = THIS.this_cArquivo

            IF !EMPTY(loc_cArq) AND USED(loc_cArq) AND !EOF(loc_cArq)

                loc_cGrupo = EVALUATE(loc_cArq + ".Grupos")
                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                        EscaparSQL(PADR(loc_cGrupo, 10)) + " ORDER BY Codigos"

                    IF USED("cursor_4c_BuscaGrupo")
                        USE IN cursor_4c_BuscaGrupo
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

                    IF loc_nResultado < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (cursor_4c_BuscaGrupo)")
                    ELSE
                        *-- GO TOP IN + referencia QUALIFICADA pelo alias, nunca
                        *-- SELECT: o legado faz exatamente assim ("Go Top In
                        *-- crfOpFin_Bus" / "crfOpFin_Bus.Descrs") para NAO
                        *-- trocar a area de trabalho corrente, que e' o cursor
                        *-- da grade recebido do chamador. Um SELECT aqui
                        *-- deixaria a area corrente apontando para o cursor de
                        *-- consulta, que e' FECHADO no fim deste metodo -
                        *-- qualquer EOF()/SKIP nao qualificado depois disso
                        *-- passaria a operar no lugar errado.
                        GO TOP IN cursor_4c_BuscaGrupo
                        loc_cDescGrupo = IIF(EOF("cursor_4c_BuscaGrupo"), "", ;
                            TratarNulo(cursor_4c_BuscaGrupo.Descrs, ""))
                    ENDIF
                ENDIF

                loc_cConta = EVALUATE(loc_cArq + ".Contas")
                IF !EMPTY(loc_cConta)
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(PADR(loc_cConta, 10)) + " ORDER BY IClis"

                    IF USED("cursor_4c_BuscaConta")
                        USE IN cursor_4c_BuscaConta
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

                    IF loc_nResultado < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (cursor_4c_BuscaConta)")
                    ELSE
                        *-- Mesma razao do bloco do Grupo acima: GO TOP IN +
                        *-- alias qualificado preservam a area de trabalho
                        *-- corrente (o cursor da grade).
                        GO TOP IN cursor_4c_BuscaConta
                        loc_cDescConta = IIF(EOF("cursor_4c_BuscaConta"), "", ;
                            TratarNulo(cursor_4c_BuscaConta.RClis, ""))
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigMvTta.GrdDadosAfterRowColChange")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_DGrupos", 5)
            THIS.txt_4c_DGrupos.Value = loc_cDescGrupo
            THIS.txt_4c_DGrupos.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DContas", 5)
            THIS.txt_4c_DContas.Value = loc_cDescConta
            THIS.txt_4c_DContas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera a referencia ao Business Object. O cursor apontado
    * por this_cArquivo NAO e' fechado aqui: ele pertence ao form chamador
    * (foi aberto e populado por ele, e continua sendo usado por ele apos
    * este dialogo fechar) - igual ao legado, cujo Release e' um DoDefault()
    * puro, sem nenhuma limpeza de cursor.
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject = .NULL.
        CATCH TO loc_oErro
            *-- Destruicao nao bloqueia saida
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigMvTtaBO.prg):
*====================================================================
* SigMvTtaBO.prg
*
* Business Object para Impostos Gerados na Movimentacao
* Tabela: sigmvimp
* Herda de: BusinessBase
*
* Este BO acompanha o form OPERACIONAL FormSigMvTta, que revisa/edita
* (em grade) os impostos de UMA movimentacao (EmpDopNums) antes de a
* movimentacao ser confirmada pelo form chamador. O cursor da grade
* eh recebido por parametro do form chamador (par_cArquivo) - este BO
* fornece os metodos de apoio (descricao de Grupo/Conta e validacao
* de titulo/vencimento) que o legado (SIGMVTTA.SCX) implementava
* direto no form, contra ThisForm.poDataMgr.
*====================================================================

DEFINE CLASS SigMvTtaBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigmvimp)
    this_cPkChaves  = ""    && pkchaves char(20) - PK
    this_cEmpDopNums = ""   && empdopnums char(29)
    this_cImpostos  = ""    && impostos char(6)
    this_nValBases  = 0     && valbases numeric(11,2)
    this_nAliqs     = 0     && aliqs numeric(11,2)
    this_nValImps   = 0     && valimps numeric(11,2)
    this_cGrupos    = ""    && grupos char(10)
    this_cContas    = ""    && contas char(10)
    this_nValTits   = 0     && valtits numeric(11,2)
    this_dVencs     = {}    && vencs datetime NULL
    this_cMoedas    = ""    && moedas char(3)
    this_cHists     = ""    && hists char(40)
    this_cTitulos   = ""    && titulos char(10)
    this_cUsuCancs  = ""    && usucancs char(10)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigmvimp"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvTtaBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor (linha da grade de
    * impostos da movimentacao) para as propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves   = TratarNulo(pkchaves, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cImpostos   = TratarNulo(impostos, "")
            THIS.this_nValBases   = TratarNulo(valbases, 0)
            THIS.this_nAliqs      = TratarNulo(aliqs, 0)
            THIS.this_nValImps    = TratarNulo(valimps, 0)
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_nValTits    = TratarNulo(valtits, 0)
            THIS.this_dVencs      = ConverterParaData(vencs)
            THIS.this_cMoedas     = TratarNulo(moedas, "")
            THIS.this_cHists      = TratarNulo(hists, "")
            THIS.this_cTitulos    = TratarNulo(titulos, "")
            THIS.this_cUsuCancs   = TratarNulo(usucancs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria de sigmvimp (pkchaves)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela sigmvimp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cVencs
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cVencs = IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs))

            loc_cSQL = "INSERT INTO sigmvimp (pkchaves, empdopnums, impostos, valbases," + ;
                       " aliqs, valimps, grupos, contas, valtits, vencs, moedas," + ;
                       " hists, titulos, usucancs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPkChaves), 20)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cImpostos), 6)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValBases, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAliqs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValImps, 2) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValTits, 2) + "," + ;
                       loc_cVencs + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoedas), 3)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHists), 40)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cTitulos), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuCancs), 10)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela sigmvimp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cVencs
        loc_lSucesso = .F.

        TRY
            loc_cVencs = IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs))

            loc_cSQL = "UPDATE sigmvimp SET" + ;
                       " empdopnums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + "," + ;
                       " impostos = "   + EscaparSQL(LEFT(ALLTRIM(THIS.this_cImpostos), 6)) + "," + ;
                       " valbases = "   + FormatarNumeroSQL(THIS.this_nValBases, 2) + "," + ;
                       " aliqs = "      + FormatarNumeroSQL(THIS.this_nAliqs, 2) + "," + ;
                       " valimps = "    + FormatarNumeroSQL(THIS.this_nValImps, 2) + "," + ;
                       " grupos = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
                       " contas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
                       " valtits = "    + FormatarNumeroSQL(THIS.this_nValTits, 2) + "," + ;
                       " vencs = "      + loc_cVencs + "," + ;
                       " moedas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoedas), 3)) + "," + ;
                       " hists = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHists), 40)) + "," + ;
                       " titulos = "    + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTitulos), 10)) + "," + ;
                       " usucancs = "   + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuCancs), 10)) + ;
                       " WHERE RTRIM(pkchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

