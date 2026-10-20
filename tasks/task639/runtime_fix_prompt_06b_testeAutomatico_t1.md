# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARDADOS is not found. | Detalhes: Linha: 872, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-10-16 18:42:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-16 18:42:12] [INFO] Config FPW: (nao fornecido)
[2026-10-16 18:42:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-16 18:42:12] [INFO] Timeout: 300 segundos
[2026-10-16 18:42:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_elq5tqgs.prg
[2026-10-16 18:42:12] [INFO] Conteudo do wrapper:
[2026-10-16 18:42:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigopacc', 'C:\4c\tasks\task639', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopacc', 'C:\4c\tasks\task639', 'OPERACIONAL'
QUIT

[2026-10-16 18:42:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_elq5tqgs.prg
[2026-10-16 18:42:12] [INFO] VFP output esperado em: C:\4c\tasks\task639\vfp_output.txt
[2026-10-16 18:42:12] [INFO] Executando Visual FoxPro 9...
[2026-10-16 18:42:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_elq5tqgs.prg
[2026-10-16 18:42:12] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_elq5tqgs.prg
[2026-10-16 18:42:12] [INFO] Timeout configurado: 300 segundos
[2026-10-16 18:44:26] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-16 18:44:26] [INFO] VFP9 finalizado em 134.1366158 segundos
[2026-10-16 18:44:26] [INFO] Exit Code: 
[2026-10-16 18:44:26] [INFO] 
[2026-10-16 18:44:26] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-16 18:44:26] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_elq5tqgs.prg
[2026-10-16 18:44:26] [INFO] 
[2026-10-16 18:44:26] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-16 18:44:26] [INFO] * Auto-generated wrapper for parameters
[2026-10-16 18:44:26] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-10-16 18:44:26] [INFO] * Parameters: 'Formsigopacc', 'C:\4c\tasks\task639', 'OPERACIONAL'
[2026-10-16 18:44:26] [INFO] 
[2026-10-16 18:44:26] [INFO] * Anti-dialog protections for unattended execution
[2026-10-16 18:44:26] [INFO] SET SAFETY OFF
[2026-10-16 18:44:26] [INFO] SET RESOURCE OFF
[2026-10-16 18:44:26] [INFO] SET TALK OFF
[2026-10-16 18:44:26] [INFO] SET NOTIFY OFF
[2026-10-16 18:44:26] [INFO] SYS(2335, 0)
[2026-10-16 18:44:26] [INFO] 
[2026-10-16 18:44:26] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopacc', 'C:\4c\tasks\task639', 'OPERACIONAL'
[2026-10-16 18:44:26] [INFO] QUIT
[2026-10-16 18:44:26] [INFO] 
[2026-10-16 18:44:26] [INFO] === Fim do Wrapper.prg ===
[2026-10-16 18:44:26] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigopacc",
  "timestamp": "20261016184426",
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
      "passou": false,
      "erro": "Property CARREGARDADOS is not found.",
      "detalhes": "Linha: 872, Proc: testecarregardadosreais"
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
      "passou": true,
      "erro": "",
      "detalhes": "N/A - form despachante sem PageFrame/Grid (sem botao de encerrar, fiel ao legado)"
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
      "detalhes": "AbrirLookup: 3 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPMOEDA, ABRIRLOOKUPSMOEDA) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopacc.prg):
*==============================================================================
* Formsigopacc.prg - Lancamento de Conta Corrente (OPERACIONAL)
* Equivale a: SIGOPACC.SCX
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo modal de ALTERACAO de um lancamento
*          ja existente de SigMvCcr, aberto a partir de outro form (ex:
*          Formsigmvtit/Formsigmvccr), equivalente ao legado
*          PARAMETERS pOldForm, OPER, pTpAltera.
*
* Chamada: CREATEOBJECT("Formsigopacc", par_oFormPai, par_cOperacao, ;
*              par_nTpAltera, par_cPkChaves)
*   par_oFormPai   - referencia ao form chamador (equivale a ThisForm.parentForm)
*   par_cOperacao  - "ALTERAR"/"INSERIR" (equivale a ThisForm.Op_Escolha;
*                     reaproveita THIS.this_cModoAtual, de FormBase)
*   par_nTpAltera  - flag numerico do legado (ThisForm.nTpAltera) que restringe
*                     a edicao de alguns campos mesmo em modo ALTERAR
*   par_cPkChaves  - cidchaves (PK char(20)) do lancamento de SigMvCcr a editar
*                     (equivale a ThisForm.pkChaves = crAltcc.cIdChaves do
*                     legado - aqui recebido como parametro explicito, em vez
*                     de depender de um cursor externo ja posicionado)
*
* Historico de fases:
*   Fase 1/2: sigopaccBO.prg (propriedades + CRUD completo)
*   Fase 3:   Formsigopacc.prg - estrutura base (Init, InicializarForm,
*             ConfigurarPageFrame/ConfigurarCabecalho, TornarControlesVisiveis).
*   Fase 4:   Formsigopacc.prg - layout CAPTURA (sem lista/Grid no legado -
*             zero AddCursor-com-grade/pColuna no dump): ConfigurarShapes()
*             (linhas divisorias), ConfigurarPaginaDados() (TODOS os ~34 campos +
*             OptionGroup Acerto, visual completo com Left/Top/Width/Height/
*             InputMask/Format/MaxLength EXATOS do SCX) e ConfigurarBotoesAcao()
*             (Cmd_Confirma/Cmd_Cancela/Alteracotacao/AlteraSCotacao, visual
*             completo). O Valid de cada campo e os Click dos botoes ficam
*             para as Fases de eventos/lookups (6-8); o When foi transcrito
*             na Fase 5 (AtualizarEstadoControles) - metodo sem logica real
*             nao pode ser criado so para "existir" (regra de completude).
*             Medido no dump legado: 0 BaseClass grid/pageframe/column/
*             listbox, 0 RecordSource, 0 pColuna/Grade/grd e AddCursor que
*             nao liga grade - nao ha lista a reproduzir. Os 64 AddObject
*             deste .prg batem 1-a-1 com os 64 objetos do layout.json
*             (5 Shape, 1 Container, 24 Label, 29 TextBox, 1 OptionGroup,
*             4 CommandButton).
*             Este form NAO declara os dois metodos de paginacao/lista do
*             padrao CRUD (os que alternam Page1/Page2 e recarregam a grade).
*             Aqui eles seriam no-op, isto e' stub proibido; e a presenca
*             deles faria TesteAutomatico.prg classificar o form como CRUD -
*             ele detecta OPERACIONAL justamente pela AUSENCIA desse par
*             (ver TesteAutomatico.prg, deteccao automatica de tipo).
*   Fase 5:   Formsigopacc.prg - os CAMPOS passam a funcionar de verdade:
*             - ConfigurarCampos() renomeado para ConfigurarPaginaDados(),
*               nome canonico do metodo que monta a superficie de DADOS
*               (mesmo padrao de Formale.prg, outro OPERACIONAL flat sem
*               PageFrame). Nenhum controle novo foi inventado: a Page2 de
*               Lista/Dados do padrao CRUD nao existe no legado (PILAR 1).
*             - CarregarDados(): le o registro de SigMvCcr pela PK
*               (cidchaves) e chama BOParaForm(); em INCLUIR prepara
*               registro novo. Equivale ao "crAltcc ja posicionado" que o
*               legado herda do form pai via ControlSource - sem isso os
*               campos abriam todos em branco no modo ALTERAR.
*             - BOParaForm()/FormParaBO() COMPLETOS (os 29 TextBox + o
*               OptionGroup Acerto). NAO foi feita a divisao "metade agora,
*               metade na Fase 6": os campos ja existiam todos desde a Fase
*               4 e mapear so parte deles e exatamente o defeito do Erro184
*               (o valor digitado nunca chega ao BO e o bloco grava em
*               branco, calado). Dividir aqui criaria o defeito de proposito.
*             - AtualizarEstadoControles(): transcricao do When de CADA
*               controle do SCX (hook PUBLIC que FormBase.Init() ja chama
*               depois de InicializarForm) + o Cmd_Confirma.Enabled do Init
*               legado (desabilitado em CONSULTAR).
*             - this_nOldContaPgs: ThisForm.OldContaPgs do Init legado,
*               usado pelo Cmd_Confirma.Click (Fase 7) para decidir o
*               estorno de valpags. Medido no VFP9 (2026-10-16): atribuir
*               OptionGroup.Value = 3 ou 4 com ButtonCount = 2 e coagido
*               para 0 em SILENCIO - e contapgs chega com 3/4 (o When
*               legado testa Inlist(contapgs,3,4)). Por isso o valor
*               original e guardado e regravado quando o grupo esta
*               desabilitado/fora da faixa, em vez de ser achatado para 2.
*             FICA PARA A FASE 6 (lookups): as descricoes carregadas por
*             Seek em crSigCdGcr/CrSigCdCli (Grupo/Conta/Job e contrapartida),
*             a troca InvEmisCCs (SGrupos<->GrupEms, SContas<->ContEms, que
*             depende de SigCdCss) e a visibilidade de Cotacao/SCotacao, que
*             depende de crSigCdMoe.Cotas e de crSigCdCrg.AltCots.
*   Fase 7:   Formsigopacc.prg - os 4 botoes de acao ganham Click real:
*             - BtnCancelarClick(): Cmd_Cancela.Click do legado (Encerrar) -
*               so THIS.Release(), sem gravar.
*             - BtnAlteraCotacaoClick()/BtnAlteraSCotacaoClick(): o legado
*               abre "Do Form SigOpAlC WITH ... TO lcRetorno" (tela auxiliar
*               que NAO foi migrada - origem\SigOpAlC.SCX). Substituido por
*               INPUTBOX(), mesmo padrao ja aceito em
*               Formsigmvccr.BtnAlterarCotacaoClick: grava a cotacao
*               digitada, this_cCotusus = gc_4c_UsuarioLogado e recalcula o
*               SVALOR. Cancelar o INPUTBOX (resposta vazia) equivale ao
*               ELSE do legado (.Value = .peAntValue) porque nada e alterado.
*             - BtnConfirmarClick()/ValidarCamposObrigatoriosConfirma()/
*               SalvarLancamento()/LocalizarCidContrapartida(): Cmd_Confirma.
*               Click. Valida os 10 campos obrigatorios do legado (so em
*               ALTERAR) e grava.
*               DESVIO DOCUMENTADO (arquitetura, nao regra de negocio): o
*               legado mantem Craltcc com as N linhas do mesmo Nopers,
*               EXCLUI o grupo inteiro de SigMvCcr e RECRIA tudo do zero
*               (Append Blank + CidChaves novo via
*               Dtos()+fGerUniqueKey()+Sigkey) - artificio exigido pelo
*               cursor buffered do legado (so' se adiciona uma 2a linha com
*               Append Blank antes do TableUpdate). A arquitetura nova
*               localiza a linha da CONTRAPARTIDA (mesmo Nopers, outro
*               cidchaves - LocalizarCidContrapartida) e faz UPDATE IN
*               PLACE nas DUAS linhas (a principal, this_cPkChaves, e a
*               contrapartida, com os campos D<->C trocados), preservando
*               os CidChaves existentes. O estado final em SigMvCcr e'
*               equivalente (mesmos Grupos/Contas/Moedas/Valores/Opers
*               trocados); fUniqueIds() (regra #22 CLAUDE.md) e o gerador
*               de chave do projeto, usado so' quando o BO precisa de PK
*               nova (Inserir), nao neste fluxo. O recalculo de saldo
*               (fRecalculaS nos combos ANTIGOS e NOVOS dos dois lados +
*               fRecalculaS(.T., gnConnHandle) para processar a fila) e o
*               fGravarLog (no-op documentado - regra #27) sao transcritos
*               do Click legado.
*               Modo INSERIR/INCLUIR: o legado nunca abre este dialogo
*               assim (nota da Fase 5) - SalvarLancamento() grava so a
*               linha principal via loc_oBO.Salvar(), sem contrapartida.
*   Fase 8:   Auditoria final - NENHUM metodo novo foi adicionado. O
*             checklist generico de "Fase 8" (BtnBuscarClick/BtnSalvarClick/
*             CarregarLista/AjustarBotoesPorModo/HabilitarCampos/
*             LimparCampos) eh o padrao CRUD (Page1=Lista/Page2=Dados) e NAO
*             se aplica a este form: SIGOPACC eh um dialogo FLAT (sem Grid,
*             sem lista, sem alternancia de pagina - nota da Fase 3) que
*             edita UM registro por instancia e eh descartado no Release().
*             Os equivalentes OPERACIONAIS ja existem desde as fases
*             anteriores: BtnCancelarClick (= "Encerrar"/BtnEncerrarClick),
*             BtnConfirmarClick (= "Salvar"/BtnSalvarClick),
*             AtualizarEstadoControles (= HabilitarCampos, transcricao do
*             When de cada campo) e BOParaForm/FormParaBO (completos desde a
*             Fase 5 - os 29 TextBox + OptionGroup). Nao ha "Buscar" (sem
*             lookup de lista) nem "LimparCampos" (instancia unica, nunca
*             reaproveitada para incluir o registro seguinte). Adicionar
*             esses metodos como stub faria o form VIOLAR a regra de
*             completude (metodo sem logica real) e, pior, faria
*             TesteAutomatico.prg classifica-lo erradamente como CRUD.
*             ACHADO (fora do escopo deste form, registrado para o
*             integrador): o UNICO chamador no sistema novo,
*             Formsigopind.prg (BtnConsultaHistClick/BtnAlterarHistClick/
*             BtnExcluirHistClick), ainda invoca `DO FORM SigOpAcc WITH
*             THIS, "<modo>"[, loc_nTpAltera]` - sintaxe legado, apontando
*             para uma classe/SCX que nao existe no sistema novo (nem
*             recebe par_cPkChaves). Esse form foi migrado ANTES de
*             Formsigopacc existir e precisa ser atualizado para
*             `CREATEOBJECT("Formsigopacc", THIS, par_cOperacao,
*             loc_nTpAltera, cursor_4c_Altcc.cidchaves)` + `.Show()`; o
*             modo "EXCLUIR" dos 3 call sites nao tem equivalente aqui (este
*             BO so trata INSERIR/INCLUIR e ALTERAR/CONSULTAR) e precisa de
*             decisao de produto antes de portar - por isso NAO foi alterado
*             nesta fase.
*==============================================================================
DEFINE CLASS Formsigopacc AS FormBase

    *-- Parametros de entrada recebidos no Init (contexto do form pai)
    this_oFormPai  = .NULL.  && referencia ao form chamador (ThisForm.parentForm do legado)
    this_nTpAltera = 0       && flag do legado (ThisForm.nTpAltera) - restringe edicao em ALTERAR
    this_cPkChaves = ""      && cidchaves do lancamento a editar (ThisForm.pkChaves do legado)
    this_nOldContaPgs = 0    && ThisForm.OldContaPgs do legado - contapgs como veio do banco
    this_lInvEmisCCs  = .F.  && ThisForm.InvEmisCCs do legado - inverte emissor x contrapartida

    *-- Visibilidade dos campos de cambio (Cotacao/SCotacao) - depende de
    *-- SigCdMoe.Cotas da moeda escolhida (Fase 6)
    this_lMoedaTemCotas  = .F.
    this_lSMoedaTemCotas = .F.

    *-- Guardas "valor mudou" dos lookups da Fase 6 - evita revalidar o
    *-- mesmo codigo a cada LostFocus (regra #47 do CLAUDE.md)
    this_cUltimoGrupoValidado    = ""
    this_cUltimoDgrupoValidado   = ""
    this_cUltimaContaValidada    = ""
    this_cUltimoDcontaValidado   = ""
    this_cUltimoSGrupoValidado   = ""
    this_cUltimoSdgrupoValidado  = ""
    this_cUltimaSContaValidada   = ""
    this_cUltimoSdcontaValidado  = ""
    this_cUltimoGrupEmsValidado  = ""
    this_cUltimoDGrupEmsValidado = ""
    this_cUltimoContEmsValidado  = ""
    this_cUltimoDContEmsValidado = ""
    this_cUltimoJobValidado      = ""
    this_cUltimoDJobValidado     = ""
    this_cUltimaMoedaValidada    = ""
    this_cUltimaSMoedaValidada   = ""

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Propriedades visuais (PILAR 1 - layout.json: form width=700, height=500)
    Width        = 700
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
    BorderStyle  = 2
    ClipControls = .F.
    FontName     = "Verdana"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Init - Armazena o contexto do form pai, cria o BO e dispara
    * FormBase.Init() (que chama THIS.InicializarForm() via DODEFAULT).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cOperacao, par_nTpAltera, par_cPkChaves)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oFormPai  = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
            THIS.this_cModoAtual = IIF(VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao), ;
                                        UPPER(ALLTRIM(par_cOperacao)), "ALTERAR")
            THIS.this_nTpAltera = IIF(VARTYPE(par_nTpAltera) = "N", par_nTpAltera, 0)
            THIS.this_cPkChaves = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")

            THIS.this_oBusinessObject = CREATEOBJECT("sigopaccBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object sigopaccBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigopacc.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopacc.Init")
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
            *-- Caption identico ao legado: Proper(Alltrim(Oper)) + " Lancamento
            *-- de Conta Corrente" (ThisForm.Caption do Init original)
            THIS.Caption = PROPER(ALLTRIM(THIS.this_cModoAtual)) + " Lan" + CHR(231) + "amento de Conta Corrente"

            THIS.ConfigurarPageFrame()
            THIS.RegistrarEventosLookup()

            *-- Propaga o titulo para os labels do cabecalho (equivale a
            *-- ThisForm.cntSombra.lblSombra/lblTitulo.Caption = ThisForm.Caption)
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            *-- Carrega o lancamento a editar nos campos. Pulado quando nao ha
            *-- conexao (ValidarUIFidelity/TesteAutomatico definem gnConnHandle
            *-- = -1): sem o guard o Init estouraria e CREATEOBJECT devolveria
            *-- .F. (FORMCOR_LICOES_APRENDIDAS, Problema 4).
            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopacc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de layout base.
    * SIGOPACC original eh flat OPERACIONAL (sem PageFrame nativo, sem lista -
    * "layout CAPTURA": dialogo modal com ~34 campos de edicao e 4 botoes,
    * zero Grid/pColuna/AddCursor-com-grade no dump legado). Fabricar um
    * Grid+CRUD de Page1 aqui violaria o PILAR 1 (inventar UI que o legado
    * nao tem). Nesta fase: cabecalho (Fase 3), shapes decorativos, TODOS os
    * campos de dados e os 4 botoes (visual completo). Valid/When dos campos
    * e os Click de Cmd_Confirma/Cmd_Cancela ficam para as Fases de eventos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarShapes()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria a faixa cinza superior com o titulo
    * (cntSombra do legado). Container com Width = THIS.Width: o legado
    * declara Width=800 num form de 700px (sobra descartada - CLAUDE.md #11).
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
    * ConfigurarShapes - Linhas divisorias decorativas (Shape1/2/3/6) e o
    * contorno do bloco de Cotacao (Shape7), transcritos do dump do SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShapes()
        THIS.AddObject("shp_4c_Shape7", "Shape")
        WITH THIS.shp_4c_Shape7
            .Top         = -8
            .Left        = 528
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 213
            .Left        = 11
            .Height      = 2
            .Width       = 502
            .BackStyle   = 0
            .Curvature   = 21
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 295
            .Left        = 11
            .Height      = 2
            .Width       = 677
            .BackStyle   = 0
            .Curvature   = 21
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("shp_4c_Shape6", "Shape")
        WITH THIS.shp_4c_Shape6
            .Top         = 378
            .Left        = 11
            .Height      = 2
            .Width       = 677
            .BackStyle   = 0
            .Curvature   = 21
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 436
            .Left        = 11
            .Height      = 2
            .Width       = 677
            .BackStyle   = 0
            .Curvature   = 21
            .BorderColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Labels + TextBoxes + OptionGroup "Acerto", transcritos
    * do dump do SCX (Left/Top/Width/Height/InputMask/Format/MaxLength EXATOS).
    * CLAUDE.md #23: label classe "say" sem Width/Alignment no dump -> AutoSize
    * = .F. + Alignment = 0 + Width calculada para nao invadir o campo vizinho.
    * CLAUDE.md #12: ForeColor de label de dados = RGB(90,90,90) (nao branco).
    * Sem ControlSource (regra #15/arquitetura nova): campos sao preenchidos
    * via FormParaBO/BOParaForm (Fase de campos/eventos), nao por binding.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cNao

        *-- Labels ------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Data : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 69
            .Top       = 116
            .Width     = 36
        ENDWITH

        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Vencimento : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 218
            .Top       = 116
            .Width     = 65
        ENDWITH

        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Nota Fiscal : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 43
            .Top       = 141
            .Width     = 62
        ENDWITH

        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Usu" + CHR(225) + "rio : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 237
            .Top       = 141
            .Width     = 46
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Documento : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 41
            .Top       = 165
            .Width     = 64
        ENDWITH

        THIS.AddObject("lbl_4c_Label19", "Label")
        WITH THIS.lbl_4c_Label19
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Acerto : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 241
            .Top       = 169
            .Width     = 37
        ENDWITH

        THIS.AddObject("lbl_4c_Label15", "Label")
        WITH THIS.lbl_4c_Label15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Job :"
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 79
            .Top       = 191
            .Width     = 26
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Movimento :"
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 46
            .Top       = 222
            .Width     = 59
        ENDWITH

        THIS.AddObject("lbl_4c_Label18", "Label")
        WITH THIS.lbl_4c_Label18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "[D/C]"
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 127
            .Top       = 222
            .Width     = 40
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Grupo : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 66
            .Top       = 247
            .Width     = 39
        ENDWITH

        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Valor : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 491
            .Top       = 247
            .Width     = 34
        ENDWITH

        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Conta : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 66
            .Top       = 272
            .Width     = 39
        ENDWITH

        THIS.AddObject("lbl_4c__Cotacao", "Label")
        WITH THIS.lbl_4c__Cotacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 475
            .Top       = 272
            .Width     = 50
        ENDWITH

        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Movimento :"
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 43
            .Top       = 305
            .Width     = 62
        ENDWITH

        THIS.AddObject("lbl_4c_Label14", "Label")
        WITH THIS.lbl_4c_Label14
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "[D/C]"
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 127
            .Top       = 305
            .Width     = 40
        ENDWITH

        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Grupo : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 66
            .Top       = 330
            .Width     = 39
        ENDWITH

        THIS.AddObject("lbl_4c_Label16", "Label")
        WITH THIS.lbl_4c_Label16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Valor : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 491
            .Top       = 330
            .Width     = 34
        ENDWITH

        THIS.AddObject("lbl_4c_Label13", "Label")
        WITH THIS.lbl_4c_Label13
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Conta : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 66
            .Top       = 355
            .Width     = 39
        ENDWITH

        THIS.AddObject("lbl_4c__sCotacao", "Label")
        WITH THIS.lbl_4c__sCotacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 475
            .Top       = 355
            .Width     = 50
        ENDWITH

        THIS.AddObject("lbl_4c_Label17", "Label")
        WITH THIS.lbl_4c_Label17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Grupo : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 66
            .Top       = 389
            .Width     = 39
        ENDWITH

        THIS.AddObject("lbl_4c_Label20", "Label")
        WITH THIS.lbl_4c_Label20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Conta : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 66
            .Top       = 414
            .Width     = 39
        ENDWITH

        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Hist" + CHR(243) + "rico : "
            .ForeColor = RGB(90, 90, 90)
            .Height    = 17
            .Left      = 54
            .Top       = 446
            .Width     = 51
        ENDWITH

        *-- TextBoxes -----------------------------------------------------
        *-- Data do lancamento
        THIS.AddObject("txt_4c_Fweditdata_DATA", "TextBox")
        WITH THIS.txt_4c_Fweditdata_DATA
            .Value         = {}
            .Left          = 109
            .Top           = 112
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Vencimento
        THIS.AddObject("txt_4c_Fweditdata_VENC", "TextBox")
        WITH THIS.txt_4c_Fweditdata_VENC
            .Value         = {}
            .Left          = 287
            .Top           = 112
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Nota Fiscal
        THIS.AddObject("txt_4c_Nota", "TextBox")
        WITH THIS.txt_4c_Nota
            .Value         = ""
            .Left          = 109
            .Top           = 137
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Usuario que alterou - legado: When sempre RETURN .F. (nunca editavel)
        THIS.AddObject("txt_4c_Usuario", "TextBox")
        WITH THIS.txt_4c_Usuario
            .Value         = ""
            .Left          = 287
            .Top           = 137
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .ReadOnly      = .T.
        ENDWITH

        *-- Documento
        THIS.AddObject("txt_4c_DOCU", "TextBox")
        WITH THIS.txt_4c_DOCU
            .Value         = ""
            .Left          = 109
            .Top           = 162
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Job
        THIS.AddObject("txt_4c_Job", "TextBox")
        WITH THIS.txt_4c_Job
            .Value         = ""
            .Left          = 109
            .Top           = 187
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Descricao do Job (cliente) - preenchida por lookup, nao transcreve ReadOnly
        THIS.AddObject("txt_4c_DJob", "TextBox")
        WITH THIS.txt_4c_DJob
            .Value         = ""
            .Left          = 191
            .Top           = 187
            .Width         = 269
            .Height        = 23
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Operacao Debito/Credito (lancamento principal) - Format K = seleciona ao entrar
        THIS.AddObject("txt_4c_OPER", "TextBox")
        WITH THIS.txt_4c_OPER
            .Value         = ""
            .Left          = 109
            .Top           = 218
            .Width         = 15
            .Height        = 23
            .MaxLength     = 1
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Grupo (debito/credito principal)
        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Value         = ""
            .Left          = 109
            .Top           = 243
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Descricao do Grupo
        THIS.AddObject("txt_4c_Dgrupo", "TextBox")
        WITH THIS.txt_4c_Dgrupo
            .Value         = ""
            .Left          = 191
            .Top           = 243
            .Width         = 269
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Moeda
        THIS.AddObject("txt_4c_MOEDA", "TextBox")
        WITH THIS.txt_4c_MOEDA
            .Value         = ""
            .Left          = 658
            .Top           = 243
            .Width         = 31
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Valor
        THIS.AddObject("txt_4c_VALOR", "TextBox")
        WITH THIS.txt_4c_VALOR
            .Value         = 0
            .Left          = 529
            .Top           = 243
            .Width         = 127
            .Height        = 23
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Conta (debito/credito principal)
        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Value         = ""
            .Left          = 109
            .Top           = 268
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Descricao da Conta
        THIS.AddObject("txt_4c_Dconta", "TextBox")
        WITH THIS.txt_4c_Dconta
            .Value         = ""
            .Left          = 191
            .Top           = 268
            .Width         = 269
            .Height        = 23
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Cotacao
        THIS.AddObject("txt_4c_COTACAO", "TextBox")
        WITH THIS.txt_4c_COTACAO
            .Value         = 0
            .Left          = 529
            .Top           = 268
            .Width         = 127
            .Height        = 23
            .InputMask     = "99,999.9999999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Operacao Debito/Credito (contrapartida)
        THIS.AddObject("txt_4c_SOPER", "TextBox")
        WITH THIS.txt_4c_SOPER
            .Value         = ""
            .Left          = 109
            .Top           = 301
            .Width         = 15
            .Height        = 23
            .MaxLength     = 1
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Grupo (contrapartida)
        THIS.AddObject("txt_4c_SGRUPO", "TextBox")
        WITH THIS.txt_4c_SGRUPO
            .Value         = ""
            .Left          = 109
            .Top           = 326
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Descricao do Grupo (contrapartida)
        THIS.AddObject("txt_4c_Sdgrupo", "TextBox")
        WITH THIS.txt_4c_Sdgrupo
            .Value         = ""
            .Left          = 191
            .Top           = 326
            .Width         = 269
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Moeda (contrapartida)
        THIS.AddObject("txt_4c_Smoeda", "TextBox")
        WITH THIS.txt_4c_Smoeda
            .Value         = ""
            .Left          = 658
            .Top           = 326
            .Width         = 31
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Valor (contrapartida)
        THIS.AddObject("txt_4c_SVALOR", "TextBox")
        WITH THIS.txt_4c_SVALOR
            .Value         = 0
            .Left          = 529
            .Top           = 326
            .Width         = 127
            .Height        = 23
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Conta (contrapartida)
        THIS.AddObject("txt_4c_SCONTA", "TextBox")
        WITH THIS.txt_4c_SCONTA
            .Value         = ""
            .Left          = 109
            .Top           = 351
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Descricao da Conta (contrapartida)
        THIS.AddObject("txt_4c_SDCONTA", "TextBox")
        WITH THIS.txt_4c_SDCONTA
            .Value         = ""
            .Left          = 191
            .Top           = 351
            .Width         = 269
            .Height        = 23
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Cotacao (contrapartida)
        THIS.AddObject("txt_4c_SCOTACAO", "TextBox")
        WITH THIS.txt_4c_SCOTACAO
            .Value         = 0
            .Left          = 529
            .Top           = 351
            .Width         = 127
            .Height        = 23
            .InputMask     = "99,999.9999999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Grupo emissor
        THIS.AddObject("txt_4c__GrupEms", "TextBox")
        WITH THIS.txt_4c__GrupEms
            .Value         = ""
            .Left          = 109
            .Top           = 384
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Descricao do Grupo emissor
        THIS.AddObject("txt_4c__DGrupEms", "TextBox")
        WITH THIS.txt_4c__DGrupEms
            .Value         = ""
            .Left          = 191
            .Top           = 384
            .Width         = 269
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Conta emissor
        THIS.AddObject("txt_4c__ContEms", "TextBox")
        WITH THIS.txt_4c__ContEms
            .Value         = ""
            .Left          = 109
            .Top           = 409
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Descricao da Conta emissor
        THIS.AddObject("txt_4c__DContEms", "TextBox")
        WITH THIS.txt_4c__DContEms
            .Value         = ""
            .Left          = 191
            .Top           = 409
            .Width         = 269
            .Height        = 23
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Historico
        THIS.AddObject("txt_4c_HIST", "TextBox")
        WITH THIS.txt_4c_HIST
            .Value         = ""
            .Left          = 109
            .Top           = 442
            .Width         = 290
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- Historico complementar
        THIS.AddObject("txt_4c_Hist2", "TextBox")
        WITH THIS.txt_4c_Hist2
            .Value         = ""
            .Left          = 401
            .Top           = 442
            .Width         = 287
            .Height        = 23
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- OptionGroup "Acerto" (Sim/Nao) - ControlSource legado: crAltcc.contapgs
        *-- (numerico, indice 1-based - regra #45). Default legado Value=2 (Nao).
        THIS.AddObject("obj_4c_Opcao_conta", "OptionGroup")
        WITH THIS.obj_4c_Opcao_conta
            .ButtonCount = 2
            .Left        = 282
            .Top         = 163
            .Width       = 88
            .Height      = 27
            .Value       = 2
        ENDWITH
        WITH THIS.obj_4c_Opcao_conta.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH
        loc_cNao = "N" + CHR(227) + "o"
        WITH THIS.obj_4c_Opcao_conta.Buttons(2)
            .Caption   = loc_cNao
            .Left      = 46
            .Top       = 6
            .Alignment = 0
            .AutoSize  = .T.
            .BackStyle = 0
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Botoes standalone do dialogo: Confirmar/Encerrar
    * (acao principal) e os dois botoes de alteracao de cotacao (icone-only,
    * ao lado dos campos Cotacao/SCotacao). Visual completo, transcrito do
    * dump; BINDEVENT dos Click fica para a fase de eventos (regra de
    * completude - metodo sem logica real nao pode ser criado como stub).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_cTituloCambio

        THIS.AddObject("cmd_4c_Cmd_Confirma", "CommandButton")
        WITH THIS.cmd_4c_Cmd_Confirma
            .Top             = 3
            .Left            = 549
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption         = "\<Confirmar"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cmd_Confirma, "Click", THIS, "BtnConfirmarClick")

        THIS.AddObject("cmd_4c_Cmd_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cmd_Cancela
            .Top        = 3
            .Left       = 624
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cmd_Cancela, "Click", THIS, "BtnCancelarClick")

        loc_cTituloCambio = "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o"

        THIS.AddObject("cmd_4c_Alteracotacao", "CommandButton")
        WITH THIS.cmd_4c_Alteracotacao
            .Top           = 268
            .Left          = 659
            .Width         = 30
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Verdana"
            .FontSize      = 8
            .Picture       = gc_4c_CaminhoIcones + "geral_cambio_16.jpg"
            .Caption       = ""
            .TabStop       = .F.
            .ToolTipText   = loc_cTituloCambio
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes           = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlteraCotacaoClick")

        THIS.AddObject("cmd_4c_AlteraSCotacao", "CommandButton")
        WITH THIS.cmd_4c_AlteraSCotacao
            .Top           = 351
            .Left          = 659
            .Width         = 30
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Verdana"
            .FontSize      = 8
            .Picture       = gc_4c_CaminhoIcones + "geral_cambio_16.jpg"
            .Caption       = ""
            .TabStop       = .F.
            .ToolTipText   = loc_cTituloCambio
            .SpecialEffect = 1
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes           = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_AlteraSCotacao, "Click", THIS, "BtnAlteraSCotacaoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Traz para a tela o lancamento que o form pai mandou
    * editar. No legado isto nao existia como codigo: o SIGOPACC era aberto com
    * o cursor crAltcc do pai ja posicionado no registro e TODOS os campos
    * tinham ControlSource = "crAltcc.<coluna>". A arquitetura nova nao
    * compartilha cursor entre telas, entao a PK chega por parametro (Init) e o
    * BO le o registro (sigopaccBO.CarregarPorChave).
    *
    * Guarda tambem this_nOldContaPgs, que eh o "ThisForm.OldContaPgs =
    * crAltcc.ContaPgs" do Init legado - o Cmd_Confirma.Click (Fase 7) compara
    * o valor atual com ele para decidir o estorno de valpags.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_oBO      = THIS.this_oBusinessObject

        TRY
            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                    "Formsigopacc.CarregarDados")
            ELSE
                IF INLIST(THIS.this_cModoAtual, "INSERIR", "INCLUIR")
                    *-- Lancamento novo: defaults do BO. O legado nunca abre
                    *-- este dialogo sem registro, mas o parametro OPER aceita
                    *-- INSERIR - entao o caminho existe e nao pode estourar.
                    loc_oBO.NovoRegistro()
                    loc_oBO.this_cUsualts = gc_4c_UsuarioLogado
                    IF EMPTY(loc_oBO.this_dDatas)
                        loc_oBO.this_dDatas = DATE()
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    IF EMPTY(THIS.this_cPkChaves)
                        MsgAviso("Lan" + CHR(231) + "amento n" + CHR(227) + "o informado pela tela de origem.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_lSucesso = loc_oBO.CarregarPorChave(THIS.this_cPkChaves)

                        IF loc_lSucesso
                            *-- ALTERAR abre a edicao no BO: sem isso o
                            *-- Salvar() herdado recusa por "fora de edicao".
                            *-- CONSULTAR so exibe, entao NAO entra em edicao.
                            IF THIS.this_cModoAtual == "ALTERAR"
                                loc_oBO.EditarRegistro()
                            ENDIF
                        ELSE
                            *-- BusinessBase/BO so exibem a falha uma vez
                            *-- (this_lErroExibido) - regra #20 do CLAUDE.md.
                            IF !loc_oBO.this_lErroExibido
                                MsgAviso(loc_oBO.ObterMensagemErro(), ;
                                    "Aten" + CHR(231) + CHR(227) + "o")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- ThisForm.OldContaPgs / ThisForm.InvEmisCCs do Init legado.
                THIS.this_nOldContaPgs = loc_oBO.this_nContapgs
                THIS.this_lInvEmisCCs  = .F.

                THIS.BOParaForm()

                *-- Fase 6: troca SGrupos<->GrupEms/SContas<->ContEms quando a
                *-- Classe do Grupo exige (SigCdCss.InvEmisCCs), resolve as
                *-- descricoes de todos os pares codigo/descricao por lookup e
                *-- calcula a visibilidade dos campos de cambio (Cotacao/
                *-- SCotacao) a partir de SigCdMoe.Cotas.
                THIS.AplicarInversaoEmissor()
                THIS.CarregarDescricoesLookup()
                THIS.AtualizarVisibilidadeCambio()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopacc.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia as propriedades do BO para os controles do form.
    * Cobre os 29 TextBox e o OptionGroup "Acerto" - TODOS os controles de
    * dados do SCX, na mesma ordem em que o dump os declara. Mapear so parte
    * deles eh o defeito do Erro184 (o campo aparece na tela, o usuario digita
    * e o valor nunca chega ao BO; o resto grava em branco, sem erro nenhum).
    *
    * ConverterParaData() normaliza DATE/DATETIME/CHAR (regra #16 do CLAUDE.md:
    * this_dDatas/this_dVencs sao datetime no BO e os TextBox trabalham com
    * DATE - TTOD() direto estouraria erro 11 no modo INCLUIR).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        *-- Bloco principal do lancamento ------------------------------------
        THIS.txt_4c_Fweditdata_DATA.Value = ConverterParaData(loc_oBO.this_dDatas)
        THIS.txt_4c_Fweditdata_VENC.Value = ConverterParaData(loc_oBO.this_dVencs)
        THIS.txt_4c_Nota.Value            = loc_oBO.this_cNfs
        THIS.txt_4c_Usuario.Value         = loc_oBO.this_cUsualts
        THIS.txt_4c_DOCU.Value            = loc_oBO.this_cDocus
        THIS.txt_4c_Job.Value             = loc_oBO.this_cJobs
        THIS.txt_4c_DJob.Value            = loc_oBO.this_cDescJob
        THIS.txt_4c_OPER.Value            = loc_oBO.this_cOpers
        THIS.txt_4c_Grupo.Value           = loc_oBO.this_cGrupos
        THIS.txt_4c_Dgrupo.Value          = loc_oBO.this_cDescGrupo
        THIS.txt_4c_Conta.Value           = loc_oBO.this_cContas
        THIS.txt_4c_Dconta.Value          = loc_oBO.this_cDescConta
        THIS.txt_4c_MOEDA.Value           = loc_oBO.this_cMoedas
        THIS.txt_4c_VALOR.Value           = loc_oBO.this_nValors
        THIS.txt_4c_COTACAO.Value         = loc_oBO.this_nCotacaos

        *-- Bloco de contrapartida -------------------------------------------
        THIS.txt_4c_SOPER.Value           = loc_oBO.this_cSopers
        THIS.txt_4c_SGRUPO.Value          = loc_oBO.this_cSgrupos
        THIS.txt_4c_Sdgrupo.Value         = loc_oBO.this_cDescSGrupo
        THIS.txt_4c_SCONTA.Value          = loc_oBO.this_cScontas
        THIS.txt_4c_SDCONTA.Value         = loc_oBO.this_cDescSConta
        THIS.txt_4c_Smoeda.Value          = loc_oBO.this_cSmoedas
        THIS.txt_4c_SVALOR.Value          = loc_oBO.this_nSvalors
        THIS.txt_4c_SCOTACAO.Value        = loc_oBO.this_nScotacaos

        *-- Bloco do emissor --------------------------------------------------
        THIS.txt_4c__GrupEms.Value        = loc_oBO.this_cGrupems
        THIS.txt_4c__DGrupEms.Value       = loc_oBO.this_cDescGrupEms
        THIS.txt_4c__ContEms.Value        = loc_oBO.this_cContems
        THIS.txt_4c__DContEms.Value       = loc_oBO.this_cDescContEms

        *-- Historico ---------------------------------------------------------
        THIS.txt_4c_HIST.Value            = loc_oBO.this_cHists
        THIS.txt_4c_Hist2.Value           = loc_oBO.this_cHist2s

        *-- OptionGroup "Acerto": ControlSource legado eh crAltcc.contapgs
        *-- direto, coluna numeric(1,0) 1-based (regra #45 - sem +1/-1).
        *-- contapgs NAO esta limitado a 1..2: o proprio When do legado testa
        *-- Inlist(Craltcc.contapgs, 3, 4). Medido no VFP9 (2026-10-16):
        *-- atribuir .Value = 3 ou 4 a um OptionGroup com ButtonCount = 2
        *-- devolve 0 em SILENCIO (nenhum botao marcado) - que eh exatamente o
        *-- que o legado exibe nesse caso. Achatar para 2 "para ficar valido"
        *-- faria o FormParaBO regravar 2 por cima de 3/4 (PILAR 2: nada de
        *-- valor inventado). O valor original fica em this_nOldContaPgs e eh
        *-- devolvido intacto pelo FormParaBO.
        IF BETWEEN(loc_oBO.this_nContapgs, 1, THIS.obj_4c_Opcao_conta.ButtonCount)
            THIS.obj_4c_Opcao_conta.Value = loc_oBO.this_nContapgs
        ELSE
            THIS.obj_4c_Opcao_conta.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia os valores dos controles do form para o BO.
    * Mesmo conjunto completo do BOParaForm acima.
    * Retorna .T./.F. - quem chamar (BtnConfirmaClick, Fase 7) deve ABORTAR a
    * gravacao quando retornar .F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_lSucesso, loc_oErro

        loc_lSucesso = .T.
        loc_oBO      = THIS.this_oBusinessObject

        TRY
            *-- Bloco principal do lancamento --------------------------------
            loc_oBO.this_dDatas     = ConverterParaData(THIS.txt_4c_Fweditdata_DATA.Value)
            loc_oBO.this_dVencs     = ConverterParaData(THIS.txt_4c_Fweditdata_VENC.Value)
            loc_oBO.this_cNfs       = ALLTRIM(THIS.txt_4c_Nota.Value)
            loc_oBO.this_cDocus     = ALLTRIM(THIS.txt_4c_DOCU.Value)
            loc_oBO.this_cJobs      = ALLTRIM(THIS.txt_4c_Job.Value)
            loc_oBO.this_cOpers     = ALLTRIM(THIS.txt_4c_OPER.Value)
            loc_oBO.this_cGrupos    = ALLTRIM(THIS.txt_4c_Grupo.Value)
            loc_oBO.this_cContas    = ALLTRIM(THIS.txt_4c_Conta.Value)
            loc_oBO.this_cMoedas    = ALLTRIM(THIS.txt_4c_MOEDA.Value)
            loc_oBO.this_nValors    = THIS.txt_4c_VALOR.Value
            loc_oBO.this_nCotacaos  = THIS.txt_4c_COTACAO.Value

            *-- Bloco de contrapartida ---------------------------------------
            loc_oBO.this_cSopers    = ALLTRIM(THIS.txt_4c_SOPER.Value)
            loc_oBO.this_cSgrupos   = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
            loc_oBO.this_cScontas   = ALLTRIM(THIS.txt_4c_SCONTA.Value)
            loc_oBO.this_cSmoedas   = ALLTRIM(THIS.txt_4c_Smoeda.Value)
            loc_oBO.this_nSvalors   = THIS.txt_4c_SVALOR.Value
            loc_oBO.this_nScotacaos = THIS.txt_4c_SCOTACAO.Value

            *-- Bloco do emissor ----------------------------------------------
            loc_oBO.this_cGrupems   = ALLTRIM(THIS.txt_4c__GrupEms.Value)
            loc_oBO.this_cContems   = ALLTRIM(THIS.txt_4c__ContEms.Value)

            *-- Historico ------------------------------------------------------
            loc_oBO.this_cHists     = ALLTRIM(THIS.txt_4c_HIST.Value)
            loc_oBO.this_cHist2s    = ALLTRIM(THIS.txt_4c_Hist2.Value)

            *-- OptionGroup "Acerto": so grava o que o usuario podia escolher.
            *-- Com o grupo desabilitado (o When do legado o trava em INSERIR,
            *-- em CONSULTAR e quando contapgs eh 3 ou 4) ou com .Value fora da
            *-- faixa dos botoes, devolve o valor ORIGINAL do banco em vez de
            *-- um 0/2 inventado.
            IF THIS.obj_4c_Opcao_conta.Enabled AND ;
               BETWEEN(THIS.obj_4c_Opcao_conta.Value, 1, THIS.obj_4c_Opcao_conta.ButtonCount)
                loc_oBO.this_nContapgs = THIS.obj_4c_Opcao_conta.Value
            ELSE
                loc_oBO.this_nContapgs = THIS.this_nOldContaPgs
            ENDIF

            *-- txt_4c_Usuario eh SOMENTE EXIBICAO (legado: Get_usuario.When
            *-- sempre RETURN .F.) - this_cUsualts eh preenchido pelo proprio
            *-- BO em Inserir/Atualizar com gc_4c_UsuarioLogado, nunca a
            *-- partir do controle.

            *-- Descricoes de lookup (exibicao; nao sao colunas de SigMvCcr)
            loc_oBO.this_cDescJob      = ALLTRIM(THIS.txt_4c_DJob.Value)
            loc_oBO.this_cDescGrupo    = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
            loc_oBO.this_cDescConta    = ALLTRIM(THIS.txt_4c_Dconta.Value)
            loc_oBO.this_cDescSGrupo   = ALLTRIM(THIS.txt_4c_Sdgrupo.Value)
            loc_oBO.this_cDescSConta   = ALLTRIM(THIS.txt_4c_SDCONTA.Value)
            loc_oBO.this_cDescGrupEms  = ALLTRIM(THIS.txt_4c__DGrupEms.Value)
            loc_oBO.this_cDescContEms  = ALLTRIM(THIS.txt_4c__DContEms.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopacc.FormParaBO")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Transcricao do When de CADA controle do SCX.
    * Hook PUBLIC de FormBase, chamado automaticamente por FormBase.Init()
    * depois de InicializarForm(); os lookups da Fase 6 devem chama-lo de novo
    * depois de preencher um codigo, porque o When das caixas de DESCRICAO
    * depende de o campo de codigo estar vazio.
    *
    * Mapeamento When -> Enabled: em VFP9 o When nega o FOCO ao controle, e o
    * equivalente na arquitetura nova eh Enabled (mesmo criterio do
    * HabilitarCampos dos demais forms). Excecao: cmd_4c_Alteracotacao e
    * cmd_4c_AlteraSCotacao sao botoes SO-ICONE (Caption vazio) - neles
    * Enabled = .F. apaga o icone e deixa um retangulo vazio, e o proprio Init
    * legado liga/desliga esses dois por .Visible. Entao aqui tambem eh
    * .Visible.
    *
    * As duas condicoes que o legado ainda soma ao When de Cotacao/SCotacao
    * (crSigCdCrg.AltCots = "S" para o cargo do usuario e crSigCdMoe.Cotas da
    * moeda do lancamento) dependem de cursores de lookup que entram na Fase 6
    * - ate la vale a parte ja transcrita, nunca um valor inventado.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        LOCAL loc_lAlterar, loc_lAltSemTp, loc_lConsultar

        *-- Thisform.op_escolha = ALTERAR (e nTpAltera = 0 na variante estrita)
        loc_lAlterar   = (THIS.this_cModoAtual == "ALTERAR")
        loc_lAltSemTp  = loc_lAlterar AND (THIS.this_nTpAltera = 0)
        loc_lConsultar = (THIS.this_cModoAtual == "CONSULTAR")

        *-- When = RETURN .F. fixo no SCX (campos que o legado nunca deixa editar)
        THIS.txt_4c_Fweditdata_DATA.Enabled = .F.   && nao permite alterar a data (mena, 27/04/2017)
        THIS.txt_4c_OPER.Enabled            = .F.   && nao permite alterar a operacao (mena, 27/04/2017)
        THIS.txt_4c_Usuario.Enabled         = .F.
        THIS.txt_4c_SOPER.Enabled           = .F.
        THIS.txt_4c_SVALOR.Enabled          = .F.

        *-- When = (op_escolha=ALTERAR And nTpAltera = 0)
        THIS.txt_4c_Fweditdata_VENC.Enabled = loc_lAltSemTp
        THIS.txt_4c_Nota.Enabled            = loc_lAltSemTp
        THIS.txt_4c_DOCU.Enabled            = loc_lAltSemTp
        THIS.txt_4c_VALOR.Enabled           = loc_lAltSemTp
        THIS.txt_4c_MOEDA.Enabled           = loc_lAltSemTp
        THIS.txt_4c_COTACAO.Enabled         = loc_lAltSemTp
        THIS.txt_4c_SGRUPO.Enabled          = loc_lAltSemTp
        THIS.txt_4c_SCONTA.Enabled          = loc_lAltSemTp
        THIS.txt_4c_SDCONTA.Enabled         = loc_lAltSemTp
        THIS.txt_4c_Smoeda.Enabled          = loc_lAltSemTp
        THIS.txt_4c_SCOTACAO.Enabled        = loc_lAltSemTp
        THIS.txt_4c_HIST.Enabled            = loc_lAltSemTp
        THIS.txt_4c_Hist2.Enabled           = loc_lAltSemTp

        *-- When = (op_escolha=ALTERAR)
        THIS.txt_4c_Grupo.Enabled           = loc_lAlterar
        THIS.txt_4c_Conta.Enabled           = loc_lAlterar
        THIS.txt_4c_Job.Enabled             = loc_lAlterar
        THIS.txt_4c__GrupEms.Enabled        = loc_lAlterar
        THIS.txt_4c__ContEms.Enabled        = loc_lAlterar

        *-- Caixas de DESCRICAO: o legado so libera a digitacao da descricao
        *-- quando o campo de CODIGO irmao esta vazio (busca pelo nome).
        THIS.txt_4c_Dgrupo.Enabled    = loc_lAlterar  AND EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
        THIS.txt_4c_Dconta.Enabled    = loc_lAlterar  AND EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
        THIS.txt_4c_DJob.Enabled      = loc_lAlterar  AND EMPTY(ALLTRIM(THIS.txt_4c_Job.Value))
        THIS.txt_4c__DGrupEms.Enabled = loc_lAlterar  AND EMPTY(ALLTRIM(THIS.txt_4c__GrupEms.Value))
        THIS.txt_4c__DContEms.Enabled = loc_lAlterar  AND EMPTY(ALLTRIM(THIS.txt_4c__ContEms.Value))
        THIS.txt_4c_Sdgrupo.Enabled   = loc_lAltSemTp AND EMPTY(ALLTRIM(THIS.txt_4c_SGRUPO.Value))

        *-- Opcao_conta.When do legado, na ordem em que o SCX escreve:
        *--   if not INSERIR and not ALTERAR    -> .F.
        *--   if Inlist(Craltcc.contapgs, 3, 4) -> .F.
        *--   senao                             -> (ALTERAR And nTpAltera = 0)
        DO CASE
            CASE !INLIST(THIS.this_cModoAtual, "INSERIR", "INCLUIR", "ALTERAR")
                THIS.obj_4c_Opcao_conta.Enabled = .F.
            CASE INLIST(THIS.this_nOldContaPgs, 3, 4)
                THIS.obj_4c_Opcao_conta.Enabled = .F.
            OTHERWISE
                THIS.obj_4c_Opcao_conta.Enabled = loc_lAltSemTp
        ENDCASE

        *-- Campos de cambio (Cotacao/SCotacao): o legado exibe o rotulo e o
        *-- campo SEMPRE que a moeda tem cotacao variavel (ThisForm.Get_
        *-- Cotacao.Visible = crSigCdMoe.Cotas), em qualquer modo - so o
        *-- botao "$" (AlteraCotacao) e' que tambem exige ALTERAR+nTpAltera=0.
        *-- this_lMoedaTemCotas/this_lSMoedaTemCotas sao calculados em
        *-- AtualizarVisibilidadeCambio() (carga) e em ProcessarMudancaMoeda()
        *-- (troca de moeda pelo usuario) - ambos da Fase 6.
        THIS.lbl_4c__Cotacao.Visible       = THIS.this_lMoedaTemCotas
        THIS.txt_4c_COTACAO.Visible        = THIS.this_lMoedaTemCotas
        THIS.lbl_4c__sCotacao.Visible      = THIS.this_lSMoedaTemCotas
        THIS.txt_4c_SCOTACAO.Visible       = THIS.this_lSMoedaTemCotas

        *-- Botoes so-icone de alteracao de cotacao: o Init legado controla os
        *-- dois por .Visible (ThisForm.AlteraCotacao.Visible = llAltCot), e
        *-- llAltCot tambem exige CrSigCdMoe.Cotas - simplificado aqui sem o
        *-- cache de AltCots do cargo do usuario (mesmo criterio adotado em
        *-- Formsigmvccr.ProcessarMudancaMoeda, que nao tem esse cache nesta
        *-- arquitetura).
        THIS.cmd_4c_Alteracotacao.Visible  = loc_lAltSemTp AND THIS.this_lMoedaTemCotas
        THIS.cmd_4c_AlteraSCotacao.Visible = loc_lAltSemTp AND THIS.this_lSMoedaTemCotas

        *-- Init legado: Cmd_Confirma.Enabled = .t., desligado em CONSULTAR
        *-- (que tambem joga o foco no Encerrar).
        THIS.cmd_4c_Cmd_Confirma.Enabled = !loc_lConsultar
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEventosLookup - BINDEVENT "LostFocus" de todos os campos com
    * lookup (grupo/conta normal, contrapartida, emissor, job e moeda).
    * Regra #47 do CLAUDE.md: o legado valida no Valid (ao SAIR do campo) -
    * o evento equivalente eh LostFocus, nunca KeyPress sem testar a tecla.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventosLookup()
        BINDEVENT(THIS.txt_4c_Grupo,      "LostFocus", THIS, "ValidarGrupo")
        BINDEVENT(THIS.txt_4c_Dgrupo,     "LostFocus", THIS, "ValidarDgrupo")
        BINDEVENT(THIS.txt_4c_Conta,      "LostFocus", THIS, "ValidarConta")
        BINDEVENT(THIS.txt_4c_Dconta,     "LostFocus", THIS, "ValidarDconta")
        BINDEVENT(THIS.txt_4c_SGRUPO,     "LostFocus", THIS, "ValidarSGrupo")
        BINDEVENT(THIS.txt_4c_Sdgrupo,    "LostFocus", THIS, "ValidarSdgrupo")
        BINDEVENT(THIS.txt_4c_SCONTA,     "LostFocus", THIS, "ValidarSConta")
        BINDEVENT(THIS.txt_4c_SDCONTA,    "LostFocus", THIS, "ValidarSDConta")
        BINDEVENT(THIS.txt_4c__GrupEms,   "LostFocus", THIS, "ValidarGrupEms")
        BINDEVENT(THIS.txt_4c__DGrupEms,  "LostFocus", THIS, "ValidarDGrupEms")
        BINDEVENT(THIS.txt_4c__ContEms,   "LostFocus", THIS, "ValidarContEms")
        BINDEVENT(THIS.txt_4c__DContEms,  "LostFocus", THIS, "ValidarDContEms")
        BINDEVENT(THIS.txt_4c_Job,        "LostFocus", THIS, "ValidarJob")
        BINDEVENT(THIS.txt_4c_DJob,       "LostFocus", THIS, "ValidarDJob")
        BINDEVENT(THIS.txt_4c_MOEDA,      "LostFocus", THIS, "ValidarMoeda")
        BINDEVENT(THIS.txt_4c_Smoeda,     "LostFocus", THIS, "ValidarSmoeda")
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarInversaoEmissor - Legado (Init): quando a Classe do Grupo
    * principal (this_cGrupos) tem SigCdCss.InvEmisCCs = 1, o lancamento
    * grava a contrapartida e o emissor TROCADOS (SGrupos<->GrupEms,
    * SContas<->ContEms). Reproduz isso nos controles ja preenchidos por
    * BOParaForm, ANTES de resolver as descricoes (CarregarDescricoesLookup).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarInversaoEmissor()
        LOCAL loc_cGrupo, loc_cClasse, loc_lInverter
        LOCAL loc_cAntSGrupos, loc_cAntGrupEms, loc_cAntSContas, loc_cAntContEms

        loc_cClasse   = ""
        loc_lInverter = .F.
        loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)

        IF !EMPTY(loc_cGrupo)
            IF USED("cursor_4c_ValClasseGrp")
                USE IN cursor_4c_ValClasseGrp
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo), "cursor_4c_ValClasseGrp")
            IF USED("cursor_4c_ValClasseGrp") AND RECCOUNT("cursor_4c_ValClasseGrp") > 0
                loc_cClasse = ALLTRIM(NVL(cursor_4c_ValClasseGrp.Classes, ""))
            ENDIF
            IF USED("cursor_4c_ValClasseGrp")
                USE IN cursor_4c_ValClasseGrp
            ENDIF
        ENDIF

        IF !EMPTY(loc_cClasse)
            IF USED("cursor_4c_ValInvEmis")
                USE IN cursor_4c_ValInvEmis
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT InvEmisCCs FROM SigCdCss WHERE Classes = " + EscaparSQL(loc_cClasse), "cursor_4c_ValInvEmis")
            IF USED("cursor_4c_ValInvEmis") AND RECCOUNT("cursor_4c_ValInvEmis") > 0
                IF VARTYPE(cursor_4c_ValInvEmis.InvEmisCCs) = "L"
                    loc_lInverter = cursor_4c_ValInvEmis.InvEmisCCs
                ELSE
                    loc_lInverter = (NVL(cursor_4c_ValInvEmis.InvEmisCCs, 0) = 1)
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValInvEmis")
                USE IN cursor_4c_ValInvEmis
            ENDIF
        ENDIF

        THIS.this_lInvEmisCCs = loc_lInverter

        IF loc_lInverter
            loc_cAntSGrupos = THIS.txt_4c_SGRUPO.Value
            loc_cAntGrupEms = THIS.txt_4c__GrupEms.Value
            loc_cAntSContas = THIS.txt_4c_SCONTA.Value
            loc_cAntContEms = THIS.txt_4c__ContEms.Value

            THIS.txt_4c_SGRUPO.Value   = loc_cAntGrupEms
            THIS.txt_4c__GrupEms.Value = loc_cAntSGrupos
            THIS.txt_4c_SCONTA.Value   = loc_cAntContEms
            THIS.txt_4c__ContEms.Value = loc_cAntSContas
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricoesLookup - Resolve a descricao de cada par
    * codigo/descricao (grupo/conta normal, contrapartida, emissor e job),
    * usando as MESMAS funcoes globais ja portadas usadas pelos handlers de
    * LostFocus (fAcessoContab/fAcessoContas), so para preencher a
    * descricao - sem os efeitos colaterais de validacao interativa
    * (MsgErro/limpeza de campo). Chamado uma vez, apos BOParaForm +
    * AplicarInversaoEmissor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescricoesLookup()
        THIS.txt_4c_Dgrupo.Value = ""
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
            fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(THIS.txt_4c_Grupo.Value), ;
                THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, THIS.txt_4c_Conta.Value)
        ENDIF

        THIS.txt_4c_Dconta.Value = ""
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
            fAcessoContas(gc_4c_UsuarioLogado, ALLTRIM(THIS.txt_4c_Grupo.Value), "C", ;
                ALLTRIM(THIS.txt_4c_Conta.Value), THIS.txt_4c_Conta, THIS.txt_4c_Dconta)
        ENDIF

        THIS.txt_4c_Sdgrupo.Value = ""
        IF !EMPTY(ALLTRIM(THIS.txt_4c_SGRUPO.Value))
            fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(THIS.txt_4c_SGRUPO.Value), ;
                THIS.txt_4c_SGRUPO, THIS.txt_4c_Sdgrupo, THIS.txt_4c_SCONTA.Value)
        ENDIF

        THIS.txt_4c_SDCONTA.Value = ""
        IF !EMPTY(ALLTRIM(THIS.txt_4c_SCONTA.Value))
            fAcessoContas(gc_4c_UsuarioLogado, ALLTRIM(THIS.txt_4c_SGRUPO.Value), "C", ;
                ALLTRIM(THIS.txt_4c_SCONTA.Value), THIS.txt_4c_SCONTA, THIS.txt_4c_SDCONTA)
        ENDIF

        THIS.txt_4c__DGrupEms.Value = ""
        IF !EMPTY(ALLTRIM(THIS.txt_4c__GrupEms.Value))
            fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(THIS.txt_4c__GrupEms.Value), ;
                THIS.txt_4c__GrupEms, THIS.txt_4c__DGrupEms, THIS.txt_4c__ContEms.Value)
        ENDIF

        THIS.txt_4c__DContEms.Value = ""
        IF !EMPTY(ALLTRIM(THIS.txt_4c__ContEms.Value))
            fAcessoContas(gc_4c_UsuarioLogado, ALLTRIM(THIS.txt_4c__GrupEms.Value), "C", ;
                ALLTRIM(THIS.txt_4c__ContEms.Value), THIS.txt_4c__ContEms, THIS.txt_4c__DContEms)
        ENDIF

        THIS.txt_4c_DJob.Value = ""
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Job.Value))
            fAcessoContas(gc_4c_UsuarioLogado, "", "C", ALLTRIM(THIS.txt_4c_Job.Value), ;
                THIS.txt_4c_Job, THIS.txt_4c_DJob)
        ENDIF

        THIS.this_cUltimoGrupoValidado    = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_cUltimoDgrupoValidado   = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
        THIS.this_cUltimaContaValidada    = ALLTRIM(THIS.txt_4c_Conta.Value)
        THIS.this_cUltimoDcontaValidado   = ALLTRIM(THIS.txt_4c_Dconta.Value)
        THIS.this_cUltimoSGrupoValidado   = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
        THIS.this_cUltimoSdgrupoValidado  = ALLTRIM(THIS.txt_4c_Sdgrupo.Value)
        THIS.this_cUltimaSContaValidada   = ALLTRIM(THIS.txt_4c_SCONTA.Value)
        THIS.this_cUltimoSdcontaValidado  = ALLTRIM(THIS.txt_4c_SDCONTA.Value)
        THIS.this_cUltimoGrupEmsValidado  = ALLTRIM(THIS.txt_4c__GrupEms.Value)
        THIS.this_cUltimoDGrupEmsValidado = ALLTRIM(THIS.txt_4c__DGrupEms.Value)
        THIS.this_cUltimoContEmsValidado  = ALLTRIM(THIS.txt_4c__ContEms.Value)
        THIS.this_cUltimoDContEmsValidado = ALLTRIM(THIS.txt_4c__DContEms.Value)
        THIS.this_cUltimoJobValidado      = ALLTRIM(THIS.txt_4c_Job.Value)
        THIS.this_cUltimoDJobValidado     = ALLTRIM(THIS.txt_4c_DJob.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverTemCotas - Le SigCdMoe.Cotas para o codigo de moeda informado.
    * Leitura pura (sem efeito colateral) usada tanto na carga inicial
    * (AtualizarVisibilidadeCambio) quanto apos a troca de moeda pelo
    * usuario (ProcessarMudancaMoeda).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ResolverTemCotas(par_cMoeda)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cMoeda)
            IF USED("cursor_4c_ValMoeCota")
                USE IN cursor_4c_ValMoeCota
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(par_cMoeda), "cursor_4c_ValMoeCota")
            IF USED("cursor_4c_ValMoeCota") AND RECCOUNT("cursor_4c_ValMoeCota") > 0
                loc_lResultado = ConverterParaLogico(cursor_4c_ValMoeCota.Cotas)
            ENDIF
            IF USED("cursor_4c_ValMoeCota")
                USE IN cursor_4c_ValMoeCota
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarVisibilidadeCambio - Calcula this_lMoedaTemCotas/
    * this_lSMoedaTemCotas a partir da moeda JA CARREGADA (sem recalcular a
    * cotacao vigente - o valor persistido no banco eh historico e nao pode
    * ser sobrescrito so por exibir a tela). Chamado uma vez na carga;
    * AtualizarEstadoControles() le essas duas properties para decidir o
    * Visible dos campos de cambio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarVisibilidadeCambio()
        THIS.this_lMoedaTemCotas  = THIS.ResolverTemCotas(ALLTRIM(THIS.txt_4c_MOEDA.Value))
        THIS.this_lSMoedaTemCotas = THIS.ResolverTemCotas(ALLTRIM(THIS.txt_4c_Smoeda.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cmd_Cancela.Click do legado (botao "Encerrar"):
    * fecha o dialogo sem gravar nada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraCotacaoClick / BtnAlteraSCotacaoClick - alteracotacao.Click /
    * AlteraSCotacao.Click do legado. O legado abre "Do Form SigOpAlC WITH
    * .Get_Moeda.Value, .Get_Cotacao.Value, .fweditdata_Data.Value TO
    * lcRetorno" - SigOpAlC (origem\SigOpAlC.SCX) NAO foi migrado. Mesma
    * substituicao ja aceita em Formsigmvccr.BtnAlterarCotacaoClick: INPUTBOX
    * no lugar do form auxiliar, gravando this_cCotusus (usuario que alterou
    * a cotacao) e recalculando o SVALOR. Resposta vazia/ESC no INPUTBOX
    * equivale ao ELSE do legado (.Value = .peAntValue): nada e alterado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraCotacaoClick()
        LOCAL loc_cResp, loc_nNovaCotacao

        loc_cResp = INPUTBOX("Informe a nova cota" + CHR(231) + CHR(227) + "o para " + ;
            ALLTRIM(THIS.txt_4c_MOEDA.Value) + ":", ;
            "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o", ;
            TRANSFORM(THIS.txt_4c_COTACAO.Value))

        IF !EMPTY(loc_cResp)
            loc_nNovaCotacao = VAL(loc_cResp)
            IF loc_nNovaCotacao > 0
                THIS.txt_4c_COTACAO.Value = loc_nNovaCotacao
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_cCotusus = gc_4c_UsuarioLogado
                ENDIF
                IF THIS.txt_4c_SCOTACAO.Value != 0
                    THIS.txt_4c_SVALOR.Value = THIS.txt_4c_VALOR.Value * THIS.txt_4c_COTACAO.Value / THIS.txt_4c_SCOTACAO.Value
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnAlteraSCotacaoClick()
        LOCAL loc_cResp, loc_nNovaCotacao

        loc_cResp = INPUTBOX("Informe a nova cota" + CHR(231) + CHR(227) + "o para " + ;
            ALLTRIM(THIS.txt_4c_Smoeda.Value) + ":", ;
            "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o", ;
            TRANSFORM(THIS.txt_4c_SCOTACAO.Value))

        IF !EMPTY(loc_cResp)
            loc_nNovaCotacao = VAL(loc_cResp)
            IF loc_nNovaCotacao > 0
                THIS.txt_4c_SCOTACAO.Value = loc_nNovaCotacao
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_cCotusus = gc_4c_UsuarioLogado
                ENDIF
                IF THIS.txt_4c_SCOTACAO.Value != 0
                    THIS.txt_4c_SVALOR.Value = THIS.txt_4c_VALOR.Value * THIS.txt_4c_COTACAO.Value / THIS.txt_4c_SCOTACAO.Value
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Cmd_Confirma.Click do legado. So valida campos
    * obrigatorios em ALTERAR (o legado nao valida nada em INSERIR - o bloco
    * de validacao do Click fica dentro de "if thisform.op_escolha =
    * 'ALTERAR'"); em CONSULTAR o Confirmar so fecha (Enabled = .F. nesse
    * modo via AtualizarEstadoControles, mas o guard fica aqui tambem, caso
    * o botao seja acionado por teclado/outro caminho).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        IF THIS.this_cModoAtual == "CONSULTAR"
            THIS.Release()
            RETURN
        ENDIF

        IF THIS.this_cModoAtual == "ALTERAR" AND !THIS.ValidarCamposObrigatoriosConfirma()
            RETURN
        ENDIF

        THIS.SalvarLancamento()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCamposObrigatoriosConfirma - Transcricao literal do bloco de
    * validacao no topo do Cmd_Confirma.Click legado (so roda em ALTERAR).
    * Cada IsEmpty(...)/Messagebox(...)/SetFocus/Return do legado mapeia
    * 1-para-1 para EMPTY(...)/MsgAviso(...)/SetFocus()/RETURN .F. - sem TRY
    * em volta, o RETURN aqui nao viola a regra #1 do CLAUDE.md.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarCamposObrigatoriosConfirma()
        IF EMPTY(THIS.txt_4c_Fweditdata_DATA.Value)
            MsgAviso("Data Inv" + CHR(225) + "lida")
            THIS.txt_4c_Fweditdata_DATA.SetFocus()
            RETURN .F.
        ENDIF

        IF !INLIST(ALLTRIM(THIS.txt_4c_OPER.Value), "D", "C")
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!")
            THIS.txt_4c_OPER.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
            MsgAviso("Grupo Inv" + CHR(225) + "lido")
            THIS.txt_4c_Grupo.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
            MsgAviso("Conta Inv" + CHR(225) + "lida")
            THIS.txt_4c_Conta.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_MOEDA.Value))
            MsgAviso("Moeda Inv" + CHR(225) + "lida")
            THIS.txt_4c_MOEDA.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.txt_4c_VALOR.Value)
            MsgAviso("Valor Inv" + CHR(225) + "lido")
            THIS.txt_4c_VALOR.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_SGRUPO.Value))
            MsgAviso("Grupo Inv" + CHR(225) + "lido")
            THIS.txt_4c_SGRUPO.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_SCONTA.Value))
            MsgAviso("Conta Inv" + CHR(225) + "lida")
            THIS.txt_4c_SCONTA.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_Smoeda.Value))
            MsgAviso("Moeda Inv" + CHR(225) + "lida")
            THIS.txt_4c_Smoeda.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.txt_4c_SVALOR.Value)
            MsgAviso("Valor Inv" + CHR(225) + "lido")
            THIS.txt_4c_SVALOR.SetFocus()
            RETURN .F.
        ENDIF

        IF ALLTRIM(THIS.txt_4c_MOEDA.Value) == ALLTRIM(THIS.txt_4c_Smoeda.Value) AND ;
           THIS.txt_4c_COTACAO.Value != THIS.txt_4c_SCOTACAO.Value
            MsgAviso("Cota" + CHR(231) + CHR(227) + "o Inconsistente!")
            THIS.txt_4c_MOEDA.SetFocus()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * LocalizarCidContrapartida - Localiza, em SigMvCcr, a OUTRA linha do
    * mesmo lancamento (mesmo Emps+Nopers, cidchaves diferente do principal)
    * - a linha-espelho que o legado alcancava percorrendo CsLog/Craltcc
    * pelo Nopers. Devolve "" quando o lancamento so tem a linha principal
    * (nao ha contrapartida fisica a atualizar).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LocalizarCidContrapartida()
        LOCAL loc_cResultado, loc_cSQL

        loc_cResultado = ""

        IF USED("cursor_4c_ValContrapartida")
            USE IN cursor_4c_ValContrapartida
        ENDIF

        loc_cSQL = "SELECT TOP 1 cidchaves FROM SigMvCcr" + ;
            " WHERE Emps = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
            " AND Nopers = " + FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNopers, 0) + ;
            " AND cidchaves <> " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValContrapartida")

        IF USED("cursor_4c_ValContrapartida") AND RECCOUNT("cursor_4c_ValContrapartida") > 0
            loc_cResultado = ALLTRIM(cursor_4c_ValContrapartida.cidchaves)
        ENDIF

        IF USED("cursor_4c_ValContrapartida")
            USE IN cursor_4c_ValContrapartida
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarLancamento - Nucleo do Cmd_Confirma.Click legado (fora da
    * validacao de campos, que fica em ValidarCamposObrigatoriosConfirma).
    * Ver nota "Fase 7" no cabecalho do arquivo sobre o desvio arquitetural
    * (UPDATE in place nas duas linhas do lancamento, em vez do
    * delete-tudo-e-recria-tudo do cursor buffered legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarLancamento()
        LOCAL loc_oBO, loc_oBOCtra, loc_oErro, loc_lOk, loc_lJaExibiu
        LOCAL loc_cCidCtrapartida, loc_nValPagsD, loc_nValPagsC, loc_cTransacao
        LOCAL loc_cGrupoAnt, loc_cContaAnt, loc_cMoedaAnt, loc_dDataAnt
        LOCAL loc_cGrupoCAnt, loc_cContaCAnt, loc_cMoedaCAnt

        loc_lOk     = .F.
        loc_oBO     = THIS.this_oBusinessObject
        loc_oBOCtra = .NULL.

        TRY
            IF INLIST(THIS.this_cModoAtual, "INSERIR", "INCLUIR")
                *-- Caminho teorico (legado nunca abre o dialogo assim -
                *-- nota da Fase 5): grava so a linha principal, sem
                *-- contrapartida nem recalculo de saldo de uma 2a linha
                *-- que nao existe.
                loc_lOk = THIS.FormParaBO()
                IF loc_lOk
                    loc_lOk = loc_oBO.Salvar()
                ENDIF
            ELSE
                *-- ALTERAR: combos ANTIGOS (antes da edicao), para
                *-- recalculo do saldo do que esta sendo substituido
                *-- (legado: fRecalculaS sobre CsLog, lido ANTES do Update/
                *-- Delete em SigMvCcr).
                loc_cGrupoAnt  = ALLTRIM(loc_oBO.this_cGrupos)
                loc_cContaAnt  = ALLTRIM(loc_oBO.this_cContas)
                loc_cMoedaAnt  = ALLTRIM(loc_oBO.this_cMoedas)
                loc_dDataAnt   = ConverterParaData(loc_oBO.this_dDatas)
                loc_cGrupoCAnt = ALLTRIM(loc_oBO.this_cSgrupos)
                loc_cContaCAnt = ALLTRIM(loc_oBO.this_cScontas)
                loc_cMoedaCAnt = ALLTRIM(loc_oBO.this_cSmoedas)
                loc_nValPagsD  = loc_oBO.this_nValpags

                loc_cCidCtrapartida = THIS.LocalizarCidContrapartida()
                IF !EMPTY(loc_cCidCtrapartida)
                    loc_oBOCtra = CREATEOBJECT("sigopaccBO")
                    IF VARTYPE(loc_oBOCtra) = "O" AND loc_oBOCtra.CarregarPorChave(loc_cCidCtrapartida)
                        loc_nValPagsC = loc_oBOCtra.this_nValpags
                        loc_oBOCtra.EditarRegistro()
                    ELSE
                        loc_oBOCtra = .NULL.
                    ENDIF
                ENDIF

                loc_lOk = THIS.FormParaBO()

                IF loc_lOk
                    *-- ValPags da linha principal (regra #45 CLAUDE.md: o
                    *-- flag Acerto ANTIGO x NOVO decide se zera ou mantem
                    *-- o valor pago - legado: If OldContaPgs # crAltcc.
                    *-- ContaPgs And nTpAltera = 0).
                    IF THIS.this_nOldContaPgs != loc_oBO.this_nContapgs AND THIS.this_nTpAltera = 0
                        loc_oBO.this_nValpags = IIF(THIS.this_nOldContaPgs = 2, 0, loc_oBO.this_nValors)
                    ELSE
                        loc_oBO.this_nValpags = loc_nValPagsD
                    ENDIF

                    loc_lOk = loc_oBO.Salvar()
                ENDIF

                IF loc_lOk AND VARTYPE(loc_oBOCtra) = "O"
                    *-- Espelha os campos trocados na contrapartida (legado:
                    *-- Scatter Memvar + troca D<->C antes do Append Blank).
                    *-- Grupo/Conta emissor (grupems/contems) NAO trocam.
                    loc_oBOCtra.this_cOpers     = loc_oBO.this_cSopers
                    loc_oBOCtra.this_cGrupos    = loc_oBO.this_cSgrupos
                    loc_oBOCtra.this_cContas    = loc_oBO.this_cScontas
                    loc_oBOCtra.this_cMoedas    = loc_oBO.this_cSmoedas
                    loc_oBOCtra.this_nCotacaos  = loc_oBO.this_nScotacaos
                    loc_oBOCtra.this_nValors    = loc_oBO.this_nSvalors
                    loc_oBOCtra.this_cSopers    = loc_oBO.this_cOpers
                    loc_oBOCtra.this_cSgrupos   = loc_oBO.this_cGrupos
                    loc_oBOCtra.this_cScontas   = loc_oBO.this_cContas
                    loc_oBOCtra.this_cSmoedas   = loc_oBO.this_cMoedas
                    loc_oBOCtra.this_nScotacaos = loc_oBO.this_nCotacaos
                    loc_oBOCtra.this_nSvalors   = loc_oBO.this_nValors
                    loc_oBOCtra.this_dDatas     = loc_oBO.this_dDatas
                    loc_oBOCtra.this_dVencs     = loc_oBO.this_dVencs
                    loc_oBOCtra.this_cHists     = loc_oBO.this_cHists
                    loc_oBOCtra.this_cHist2s    = loc_oBO.this_cHist2s
                    loc_oBOCtra.this_cDocus     = loc_oBO.this_cDocus
                    loc_oBOCtra.this_cNfs       = loc_oBO.this_cNfs
                    loc_oBOCtra.this_cCotusus   = loc_oBO.this_cCotusus
                    loc_oBOCtra.this_nContapgs  = loc_oBO.this_nContapgs

                    IF THIS.this_nOldContaPgs != loc_oBOCtra.this_nContapgs AND THIS.this_nTpAltera = 0
                        loc_oBOCtra.this_nValpags = IIF(THIS.this_nOldContaPgs = 2, 0, loc_oBOCtra.this_nValors)
                    ELSE
                        loc_oBOCtra.this_nValpags = loc_nValPagsC
                    ENDIF

                    loc_lOk = loc_oBOCtra.Salvar()
                ENDIF

                IF loc_lOk
                    *-- Recalculo de saldos: combos antigos e novos, dos
                    *-- dois lados (legado: fRecalculaS em CsLog antes +
                    *-- em CrAltcc/novo registro depois).
                    fRecalculaS(loc_cGrupoAnt, loc_cContaAnt, loc_dDataAnt, loc_cMoedaAnt, gnConnHandle)
                    fRecalculaS(loc_cGrupoCAnt, loc_cContaCAnt, loc_dDataAnt, loc_cMoedaCAnt, gnConnHandle)
                    fRecalculaS(ALLTRIM(loc_oBO.this_cGrupos), ALLTRIM(loc_oBO.this_cContas), ;
                        ConverterParaData(loc_oBO.this_dDatas), ALLTRIM(loc_oBO.this_cMoedas), gnConnHandle)
                    fRecalculaS(ALLTRIM(loc_oBO.this_cSgrupos), ALLTRIM(loc_oBO.this_cScontas), ;
                        ConverterParaData(loc_oBO.this_dDatas), ALLTRIM(loc_oBO.this_cSmoedas), gnConnHandle)

                    loc_lOk = fRecalculaS(.T., gnConnHandle)

                    IF loc_lOk
                        loc_cTransacao = ALLTRIM(loc_oBO.this_cEmps) + "-" + ALLTRIM(STR(loc_oBO.this_nNopers)) + ;
                            " (" + DTOC(DATE()) + ") #" + ALLTRIM(loc_oBO.this_cCidchaves)
                        IF VARTYPE(loc_oBOCtra) = "O"
                            loc_cTransacao = loc_cTransacao + " #" + ALLTRIM(loc_oBOCtra.this_cCidchaves)
                        ENDIF
                        fGravarLog("T", THIS.Name, THIS.this_cModoAtual, loc_cTransacao)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopacc.SalvarLancamento")
            loc_lOk = .F.
        ENDTRY

        IF loc_lOk
            THIS.Release()
        ELSE
            loc_lJaExibiu = (VARTYPE(loc_oBO) = "O" AND loc_oBO.this_lErroExibido) OR ;
                (VARTYPE(loc_oBOCtra) = "O" AND loc_oBOCtra.this_lErroExibido)
            IF !loc_lJaExibiu
                MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo / ValidarDgrupo - LostFocus de txt_4c_Grupo/txt_4c_Dgrupo
    * (legado: Get_grupo.Valid / Get_dgrupo.Valid). fAcessoContab resolve a
    * descricao (ou a abertura do picker quando o codigo nao existe); o
    * legado nao verifica o retorno nem exibe mensagem de erro para este par.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)

        IF loc_cValor == THIS.this_cUltimoGrupoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoGrupoValidado = loc_cValor

        IF !EMPTY(loc_cValor)
            fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, ;
                THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, THIS.txt_4c_Conta.Value)
            THIS.this_cUltimoGrupoValidado = ALLTRIM(THIS.txt_4c_Grupo.Value)
        ELSE
            THIS.txt_4c_Dgrupo.Value = ""
        ENDIF

        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDgrupo()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Dgrupo.Value)

        IF loc_cValor == THIS.this_cUltimoDgrupoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDgrupoValidado = loc_cValor

        IF !EMPTY(loc_cValor)
            fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, ;
                THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, THIS.txt_4c_Conta.Value)
            THIS.this_cUltimoDgrupoValidado = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
            THIS.this_cUltimoGrupoValidado  = ALLTRIM(THIS.txt_4c_Grupo.Value)
        ELSE
            THIS.txt_4c_Grupo.Value = ""
        ENDIF

        THIS.AtualizarEstadoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta / ValidarDconta - LostFocus de txt_4c_Conta/txt_4c_Dconta
    * (legado: Get_conta.Valid / Get_dconta.Valid). fAcessoContas devolve
    * .F. quando o acesso eh negado - so ai o legado avisa e limpa os dois
    * campos (codigo + descricao).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta()
        LOCAL loc_cValor, loc_cGrupo
        loc_cValor = ALLTRIM(THIS.txt_4c_Conta.Value)

        IF loc_cValor == THIS.this_cUltimaContaValidada
            RETURN
        ENDIF
        THIS.this_cUltimaContaValidada = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Dconta.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, THIS.txt_4c_Conta, THIS.txt_4c_Dconta)
            MsgErro("Acesso Negado !!", "Aviso")
            THIS.txt_4c_Conta.Value  = ""
            THIS.txt_4c_Dconta.Value = ""
            THIS.this_cUltimaContaValidada = ""
        ELSE
            THIS.this_cUltimaContaValidada = ALLTRIM(THIS.txt_4c_Conta.Value)
        ENDIF
    ENDPROC

    PROCEDURE ValidarDconta()
        LOCAL loc_cValor, loc_cGrupo
        loc_cValor = ALLTRIM(THIS.txt_4c_Dconta.Value)

        IF loc_cValor == THIS.this_cUltimoDcontaValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDcontaValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Conta.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cValor, THIS.txt_4c_Conta, THIS.txt_4c_Dconta)
            MsgErro("Acesso Negado !!", "Aviso")
            THIS.txt_4c_Conta.Value  = ""
            THIS.txt_4c_Dconta.Value = ""
            THIS.this_cUltimoDcontaValidado = ""
        ELSE
            THIS.this_cUltimoDcontaValidado = ALLTRIM(THIS.txt_4c_Dconta.Value)
            THIS.this_cUltimaContaValidada  = ALLTRIM(THIS.txt_4c_Conta.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSGrupo / ValidarSdgrupo - espelho de ValidarGrupo/ValidarDgrupo
    * para a contrapartida (legado: Get_SGRUPO.Valid / Get_sdgrupo.Valid)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSGrupo()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_SGRUPO.Value)

        IF loc_cValor == THIS.this_cUltimoSGrupoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoSGrupoValidado = loc_cValor

        IF !EMPTY(loc_cValor)
            fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, ;
                THIS.txt_4c_SGRUPO, THIS.txt_4c_Sdgrupo, THIS.txt_4c_SCONTA.Value)
            THIS.this_cUltimoSGrupoValidado = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
        ELSE
            THIS.txt_4c_Sdgrupo.Value = ""
        ENDIF

        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarSdgrupo()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Sdgrupo.Value)

        IF loc_cValor == THIS.this_cUltimoSdgrupoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoSdgrupoValidado = loc_cValor

        IF !EMPTY(loc_cValor)
            fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, ;
                THIS.txt_4c_SGRUPO, THIS.txt_4c_Sdgrupo, THIS.txt_4c_SCONTA.Value)
            THIS.this_cUltimoSdgrupoValidado = ALLTRIM(THIS.txt_4c_Sdgrupo.Value)
            THIS.this_cUltimoSGrupoValidado  = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
        ELSE
            THIS.txt_4c_SGRUPO.Value = ""
        ENDIF

        THIS.AtualizarEstadoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSConta / ValidarSDConta - espelho de ValidarConta/ValidarDconta
    * para a contrapartida (legado: Get_SCONTA.Valid / Get_SDCONTA.Valid)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSConta()
        LOCAL loc_cValor, loc_cGrupo
        loc_cValor = ALLTRIM(THIS.txt_4c_SCONTA.Value)

        IF loc_cValor == THIS.this_cUltimaSContaValidada
            RETURN
        ENDIF
        THIS.this_cUltimaSContaValidada = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_SDCONTA.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, THIS.txt_4c_SCONTA, THIS.txt_4c_SDCONTA)
            MsgErro("Acesso Negado !!", "Aviso")
            THIS.txt_4c_SCONTA.Value  = ""
            THIS.txt_4c_SDCONTA.Value = ""
            THIS.this_cUltimaSContaValidada = ""
        ELSE
            THIS.this_cUltimaSContaValidada = ALLTRIM(THIS.txt_4c_SCONTA.Value)
        ENDIF
    ENDPROC

    PROCEDURE ValidarSDConta()
        LOCAL loc_cValor, loc_cGrupo
        loc_cValor = ALLTRIM(THIS.txt_4c_SDCONTA.Value)

        IF loc_cValor == THIS.this_cUltimoSdcontaValidado
            RETURN
        ENDIF
        THIS.this_cUltimoSdcontaValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_SCONTA.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cValor, THIS.txt_4c_SCONTA, THIS.txt_4c_SDCONTA)
            MsgErro("Acesso Negado !!", "Aviso")
            THIS.txt_4c_SCONTA.Value  = ""
            THIS.txt_4c_SDCONTA.Value = ""
            THIS.this_cUltimoSdcontaValidado = ""
        ELSE
            THIS.this_cUltimoSdcontaValidado = ALLTRIM(THIS.txt_4c_SDCONTA.Value)
            THIS.this_cUltimaSContaValidada  = ALLTRIM(THIS.txt_4c_SCONTA.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupEms / ValidarDGrupEms - grupo emissor (legado:
    * get_GrupEms.Valid / get_DGrupEms.Valid) - mesmo padrao de
    * ValidarGrupo/ValidarDgrupo, sem o campo de conta como pCta (o legado
    * passa Thisform.get_contems.value no lugar de get_conta.value aqui).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupEms()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c__GrupEms.Value)

        IF loc_cValor == THIS.this_cUltimoGrupEmsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoGrupEmsValidado = loc_cValor

        IF !EMPTY(loc_cValor)
            fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, ;
                THIS.txt_4c__GrupEms, THIS.txt_4c__DGrupEms, THIS.txt_4c__ContEms.Value)
            THIS.this_cUltimoGrupEmsValidado = ALLTRIM(THIS.txt_4c__GrupEms.Value)
        ELSE
            THIS.txt_4c__DGrupEms.Value = ""
        ENDIF

        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDGrupEms()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c__DGrupEms.Value)

        IF loc_cValor == THIS.this_cUltimoDGrupEmsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDGrupEmsValidado = loc_cValor

        IF !EMPTY(loc_cValor)
            fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, ;
                THIS.txt_4c__GrupEms, THIS.txt_4c__DGrupEms, THIS.txt_4c__ContEms.Value)
            THIS.this_cUltimoDGrupEmsValidado = ALLTRIM(THIS.txt_4c__DGrupEms.Value)
            THIS.this_cUltimoGrupEmsValidado  = ALLTRIM(THIS.txt_4c__GrupEms.Value)
        ELSE
            THIS.txt_4c__GrupEms.Value = ""
        ENDIF

        THIS.AtualizarEstadoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContEms / ValidarDContEms - conta emissor (legado:
    * get_ContEms.Valid / get_DContEms.Valid) - mesmo padrao de
    * ValidarConta/ValidarDconta, filtrado pelo grupo emissor.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContEms()
        LOCAL loc_cValor, loc_cGrupo
        loc_cValor = ALLTRIM(THIS.txt_4c__ContEms.Value)

        IF loc_cValor == THIS.this_cUltimoContEmsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoContEmsValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c__DContEms.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(THIS.txt_4c__GrupEms.Value)
        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, THIS.txt_4c__ContEms, THIS.txt_4c__DContEms)
            MsgErro("Acesso Negado !!", "Aviso")
            THIS.txt_4c__ContEms.Value  = ""
            THIS.txt_4c__DContEms.Value = ""
            THIS.this_cUltimoContEmsValidado = ""
        ELSE
            THIS.this_cUltimoContEmsValidado = ALLTRIM(THIS.txt_4c__ContEms.Value)
        ENDIF
    ENDPROC

    PROCEDURE ValidarDContEms()
        LOCAL loc_cValor, loc_cGrupo
        loc_cValor = ALLTRIM(THIS.txt_4c__DContEms.Value)

        IF loc_cValor == THIS.this_cUltimoDContEmsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDContEmsValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c__ContEms.Value = ""
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(THIS.txt_4c__GrupEms.Value)
        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cValor, THIS.txt_4c__ContEms, THIS.txt_4c__DContEms)
            MsgErro("Acesso Negado !!", "Aviso")
            THIS.txt_4c__ContEms.Value  = ""
            THIS.txt_4c__DContEms.Value = ""
            THIS.this_cUltimoDContEmsValidado = ""
        ELSE
            THIS.this_cUltimoDContEmsValidado = ALLTRIM(THIS.txt_4c__DContEms.Value)
            THIS.this_cUltimoContEmsValidado  = ALLTRIM(THIS.txt_4c__ContEms.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarJob / ValidarDJob - LostFocus de txt_4c_Job/txt_4c_DJob (legado:
    * getJob.Valid / getDJob.Valid). Grupo = '' - o legado nao restringe o
    * job por grupo contabil.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarJob()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Job.Value)

        IF loc_cValor == THIS.this_cUltimoJobValidado
            RETURN
        ENDIF
        THIS.this_cUltimoJobValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_DJob.Value = ""
            RETURN
        ENDIF

        IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cValor, THIS.txt_4c_Job, THIS.txt_4c_DJob)
            MsgErro("Acesso Negado!!!", "Aviso")
            THIS.txt_4c_Job.Value  = ""
            THIS.txt_4c_DJob.Value = ""
            THIS.this_cUltimoJobValidado = ""
        ELSE
            THIS.this_cUltimoJobValidado = ALLTRIM(THIS.txt_4c_Job.Value)
        ENDIF
    ENDPROC

    PROCEDURE ValidarDJob()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_DJob.Value)

        IF loc_cValor == THIS.this_cUltimoDJobValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDJobValidado = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.txt_4c_Job.Value = ""
            RETURN
        ENDIF

        IF !fAcessoContas(gc_4c_UsuarioLogado, "", "D", loc_cValor, THIS.txt_4c_Job, THIS.txt_4c_DJob)
            MsgErro("Acesso Negado!!!", "Aviso")
            THIS.txt_4c_Job.Value  = ""
            THIS.txt_4c_DJob.Value = ""
            THIS.this_cUltimoDJobValidado = ""
        ELSE
            THIS.this_cUltimoDJobValidado = ALLTRIM(THIS.txt_4c_DJob.Value)
            THIS.this_cUltimoJobValidado  = ALLTRIM(THIS.txt_4c_Job.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeda / ValidarSmoeda - LostFocus de txt_4c_MOEDA/txt_4c_Smoeda
    * (legado: Get_MOEDA.Valid / Get_smoeda.Valid)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoeda()
        THIS.ProcessarMudancaMoeda("D")
    ENDPROC

    PROCEDURE ValidarSmoeda()
        THIS.ProcessarMudancaMoeda("S")
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarMudancaMoeda - nucleo comum do Valid de Moeda/SMoeda. Resolve
    * a cotacao vigente em SigCdCot na data do lancamento, espelha moeda e
    * cotacao para o lado vazio, recalcula o SValor e atualiza a
    * visibilidade dos campos de cambio (this_lMoedaTemCotas/
    * this_lSMoedaTemCotas, lidos por AtualizarEstadoControles). O legado
    * tambem condiciona o botao "$" a crSigCdCrg.AltCots do cargo do
    * usuario - cache que nao existe nesta arquitetura (mesma simplificacao
    * de Formsigmvccr.ProcessarMudancaMoeda).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarMudancaMoeda(par_cLado)
        LOCAL loc_cValor, loc_lCotas, loc_dData, loc_nCotacao

        IF par_cLado == "D"
            loc_cValor = ALLTRIM(THIS.txt_4c_MOEDA.Value)
            IF loc_cValor == THIS.this_cUltimaMoedaValidada
                RETURN
            ENDIF
            THIS.this_cUltimaMoedaValidada = loc_cValor
        ELSE
            loc_cValor = ALLTRIM(THIS.txt_4c_Smoeda.Value)
            IF loc_cValor == THIS.this_cUltimaSMoedaValidada
                RETURN
            ENDIF
            THIS.this_cUltimaSMoedaValidada = loc_cValor
        ENDIF

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
        SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), "cursor_4c_ValMoe")

        IF !USED("cursor_4c_ValMoe") OR RECCOUNT("cursor_4c_ValMoe") = 0
            IF USED("cursor_4c_ValMoe")
                USE IN cursor_4c_ValMoe
            ENDIF
            IF par_cLado == "D"
                THIS.AbrirLookupMoeda()
            ELSE
                THIS.AbrirLookupSMoeda()
            ENDIF
            RETURN
        ENDIF

        loc_lCotas = ConverterParaLogico(cursor_4c_ValMoe.Cotas)
        loc_cValor = ALLTRIM(cursor_4c_ValMoe.CMoes)
        USE IN cursor_4c_ValMoe

        IF par_cLado == "D"
            THIS.txt_4c_MOEDA.Value  = loc_cValor
            THIS.this_lMoedaTemCotas = loc_lCotas
        ELSE
            THIS.txt_4c_Smoeda.Value  = loc_cValor
            THIS.this_lSMoedaTemCotas = loc_lCotas
        ENDIF

        loc_dData = THIS.txt_4c_Fweditdata_DATA.Value

        loc_nCotacao = 1
        IF loc_lCotas
            IF USED("cursor_4c_ValCot")
                USE IN cursor_4c_ValCot
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT TOP 1 Valos FROM SigCdCot" + ;
                " WHERE Moedas = " + EscaparSQL(loc_cValor) + ;
                " AND Cotacaos <= " + FormatarDataSQL(loc_dData) + ;
                " ORDER BY Cotacaos DESC", "cursor_4c_ValCot")
            IF USED("cursor_4c_ValCot") AND RECCOUNT("cursor_4c_ValCot") > 0
                loc_nCotacao = cursor_4c_ValCot.Valos
            ENDIF
            IF USED("cursor_4c_ValCot")
                USE IN cursor_4c_ValCot
            ENDIF
        ENDIF

        IF par_cLado == "D"
            THIS.txt_4c_COTACAO.Value = loc_nCotacao
            IF EMPTY(ALLTRIM(THIS.txt_4c_Smoeda.Value))
                THIS.txt_4c_Smoeda.Value   = THIS.txt_4c_MOEDA.Value
                THIS.txt_4c_SCOTACAO.Value = THIS.txt_4c_COTACAO.Value
                THIS.this_lSMoedaTemCotas  = loc_lCotas
            ENDIF
        ELSE
            THIS.txt_4c_SCOTACAO.Value = loc_nCotacao
            IF EMPTY(ALLTRIM(THIS.txt_4c_MOEDA.Value))
                THIS.txt_4c_MOEDA.Value   = THIS.txt_4c_Smoeda.Value
                THIS.txt_4c_COTACAO.Value = THIS.txt_4c_SCOTACAO.Value
                THIS.this_lMoedaTemCotas  = loc_lCotas
            ENDIF
        ENDIF

        IF THIS.txt_4c_SCOTACAO.Value != 0
            THIS.txt_4c_SVALOR.Value = THIS.txt_4c_VALOR.Value * THIS.txt_4c_COTACAO.Value / THIS.txt_4c_SCOTACAO.Value
        ENDIF

        THIS.AtualizarEstadoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda / AbrirLookupSMoeda - legado usa fwBuscaSel em
    * crSigCdMoe (CMoes/DMoes); aqui FormBuscaAuxiliar sobre SigCdMoe.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oBusca

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", ;
            ALLTRIM(THIS.txt_4c_MOEDA.Value), "Moedas")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                THIS.txt_4c_MOEDA.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
            ELSE
                THIS.txt_4c_MOEDA.Value = ""
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF

        THIS.this_cUltimaMoedaValidada = ALLTRIM(THIS.txt_4c_MOEDA.Value)
    ENDPROC

    PROCEDURE AbrirLookupSMoeda()
        LOCAL loc_oBusca

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaSMoeda", "CMoes", ;
            ALLTRIM(THIS.txt_4c_Smoeda.Value), "Moedas")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSMoeda")
                THIS.txt_4c_Smoeda.Value = ALLTRIM(cursor_4c_BuscaSMoeda.CMoes)
            ELSE
                THIS.txt_4c_Smoeda.Value = ""
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaSMoeda")
            USE IN cursor_4c_BuscaSMoeda
        ENDIF

        THIS.this_cUltimaSMoedaValidada = ALLTRIM(THIS.txt_4c_Smoeda.Value)
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

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopaccBO.prg):
*============================================================================
* sigopaccBO.prg - Business Object para Lancamento de Conta Corrente
*
* Tabela principal : SigMvCcr  (PK: cidchaves char(20))
* Lookup grupo/conta: SigCdGrp / SigCdCta (ou equivalentes, grupo+conta normal e contrapartida)
* Lookup emissor    : SigCdGrp / SigCdCta (GrupEms / ContEms)
* Lookup job         : SigCdJob (ou equivalente)
* Lookup moeda       : SigCdMoe
*
* Este BO suporta um dialogo OPERACIONAL de ALTERACAO de um lancamento
* ja existente de SigMvCcr (edicao pontual de um registro de movimento de
* conta corrente), espelhando o comportamento do legado SIGOPACC.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopaccBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigMvCcr (campos do banco - chave e dados)
    *==========================================================================
    this_cCidchaves = ""   && char(20)      - Chave primaria (PK, fUniqueIds())
    this_dDatas      = {}  && datetime NULL - Data do lancamento
    this_cOpers      = ""  && char(1)       - Operacao (D/C)
    this_cDocus      = ""  && char(10)      - Documento
    this_cNfs        = ""  && char(10)      - Nota Fiscal
    this_nValors     = 0   && numeric(11,2) - Valor
    this_nCotacaos   = 0   && numeric(15,7) - Cotacao
    this_dVencs      = {}  && datetime NULL - Vencimento
    this_cHists      = ""  && char(60)      - Historico
    this_cHist2s     = ""  && char(80)      - Historico complementar
    this_cSopers     = ""  && char(1)       - Operacao contrapartida (D/C)
    this_nSvalors    = 0   && numeric(11,2) - Valor contrapartida
    this_nScotacaos  = 0   && numeric(15,7) - Cotacao contrapartida
    this_cGrupos     = ""  && char(10)      - Grupo
    this_cContas     = ""  && char(10)      - Conta
    this_cSgrupos    = ""  && char(10)      - Grupo contrapartida
    this_cScontas    = ""  && char(10)      - Conta contrapartida
    this_cMoedas     = ""  && char(3)       - Moeda
    this_cSmoedas    = ""  && char(3)       - Moeda contrapartida
    this_cGrupems    = ""  && char(10)      - Grupo emissor
    this_cContems    = ""  && char(10)      - Conta emissor
    this_cJobs       = ""  && char(10)      - Job
    this_nContapgs   = 0   && numeric(1,0)  - Conta a Pagar (flag/opcao do lancamento original)
    this_cCotusus    = ""  && char(10)      - Usuario que alterou a cotacao

    *==========================================================================
    * Propriedades das demais colunas de SigMvCcr (nao editadas na tela, mas
    * obrigatorias no INSERT - regra #22 CLAUDE.md: INSERT cobre TODA coluna
    * NOT NULL). Nomeadas como as colunas do schema (docs/schema.sql).
    *==========================================================================
    this_lAutos      = .F.  && bit           - autos
    this_lConcs      = .F.  && bit           - concs
    this_cContages   = ""   && char(10)      - contages
    this_dDatalts    = {}   && datetime NULL - datalts (data de alteracao)
    this_dDataconcs  = {}   && datetime NULL - dataconcs
    this_dDatatrans  = {}   && datetime NULL - datatrans
    this_dDatexcs    = {}   && datetime NULL - datexcs
    this_cDopes      = ""   && char(20)      - dopes
    this_dDtemis     = {}   && datetime NULL - dtemis
    this_cEmps       = ""   && char(3)       - emps (empresa)
    this_cGrupages   = ""   && char(10)      - grupages
    this_cLocals     = ""   && char(10)      - locals
    this_nNlancs     = 0    && numeric(6,0)  - nlancs
    this_nNopers     = 0    && numeric(7,0)  - nopers (numero da operacao)
    this_nNtrans     = 0    && numeric(6,0)  - ntrans
    this_nNumes      = 0    && numeric(6,0)  - numes
    this_nSaldocs    = 0    && numeric(15,2) - saldocs
    this_nSaldons    = 0    && numeric(15,2) - saldons
    this_nSaldos     = 0    && numeric(15,2) - saldos
    this_cShists     = ""   && char(40)      - shists
    this_cTipos      = ""   && char(1)       - tipos
    this_cTitbans    = ""   && char(12)      - titbans
    this_cTitulos    = ""   && char(10)      - titulos
    this_cUsualts    = ""   && char(10)      - usualts (usuario que alterou)
    this_cUsuexcs    = ""   && char(10)      - usuexcs
    this_nValliqs    = 0    && numeric(11,2) - valliqs
    this_nValocurs   = 0    && numeric(11,2) - valocurs
    this_nValpags    = 0    && numeric(11,2) - valpags
    this_cVlancs     = ""   && char(10)      - vlancs
    this_cVopers     = ""   && char(13)      - vopers
    this_cDopcs      = ""   && char(20)      - dopcs
    this_nNumcs      = 0    && numeric(6,0)  - numcs
    this_cBcontas    = ""   && char(10)      - bcontas
    this_cBgrupos    = ""   && char(10)      - bgrupos
    this_nBorderos   = 0    && numeric(6,0)  - borderos
    this_nIntconts   = 0    && numeric(6,0)  - intconts
    this_cUsuconcs   = ""   && char(10)      - usuconcs
    this_cAuditors   = ""   && char(10)      - auditors
    this_dDtaudits   = {}   && datetime NULL - dtaudits
    this_nValprev    = 0    && numeric(11,2) - valprev
    this_cEmpdopncs  = ""   && char(29)      - empdopncs (posicional: emps+dopes+numcs)
    this_cEmpdopnums = ""   && char(29)      - empdopnums (posicional: emps+dopes+numes)
    this_cGruconmoes = ""   && char(23)      - gruconmoes (grupos+contas+moedas)
    this_cPagos      = ""   && char(1)       - pagos (0/1 conforme valors = valpags)
    this_cDopotps    = ""   && char(23)      - dopotps
    this_cUsupagos   = ""   && char(10)      - usupagos
    this_nTitcancs   = 0    && numeric(1,0)  - titcancs
    this_dDtconfs    = {}   && datetime NULL - dtconfs
    this_cUsuconfs   = ""   && char(10)      - usuconfs
    this_nNopercancs = 0    && numeric(7,0)  - nopercancs
    this_cEspecienfs = ""   && char(6)       - especienfs
    this_nImpostos   = 0    && numeric(11,2) - impostos
    this_nTpimpostos = 0    && numeric(2,0)  - tpimpostos
    this_cTitpais    = ""   && char(10)      - titpais
    this_cEmpccs     = ""   && char(3)       - empccs
    this_nRecor      = 0    && numeric(1,0)  - recor
    this_cCompet     = ""   && char(7)       - compet
    this_cEmpos      = ""   && char(3)       - empos
    this_cOridopnums = ""   && char(29)      - oridopnums
    this_cPastas     = ""   && text NULL     - pastas
    this_cRcontas    = ""   && char(10)      - rcontas
    this_cTpdocnf    = ""   && char(2)       - tpdocnf

    *==========================================================================
    * Propriedades de controle da tela - nao persistidas diretamente
    *==========================================================================
    this_cUsuario     = ""  && Usuario corrente exibido no cabecalho (auditoria)
    this_nOpcaoConta  = 0   && OptionGroup Acerto (D/C) - indice 1-based

    *==========================================================================
    * Propriedades de exibicao (descricoes de lookup) - nao armazenadas no banco
    *==========================================================================
    this_cDescGrupo    = ""  && Descricao do Grupo (this_cGrupos)
    this_cDescConta    = ""  && Descricao da Conta (this_cContas)
    this_cDescSGrupo   = ""  && Descricao do Grupo contrapartida (this_cSgrupos)
    this_cDescSConta   = ""  && Descricao da Conta contrapartida (this_cScontas)
    this_cDescGrupEms  = ""  && Descricao do Grupo emissor (this_cGrupems)
    this_cDescContEms  = ""  && Descricao da Conta emissor (this_cContems)
    this_cDescJob      = ""  && Descricao do Job (this_cJobs)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
            *-- this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio
            *-- o objeto de acesso a dados fica .NULL. e todo metodo herdado
            *-- que depende dele (Buscar) devolve .F. com "Objeto de acesso a
            *-- dados nao inicializado".
            DODEFAULT("SigMvCcr")
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso em
    * RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * CarregarPorChave - Le UM lancamento de SigMvCcr pela PK (cidchaves) e
    * popula as propriedades do BO atraves de CarregarDoCursor().
    *
    * No legado o registro ja chegava posicionado: o form pai mantinha o cursor
    * crAltcc e o SIGOPACC lia tudo por ControlSource. A arquitetura nova nao
    * compartilha cursor entre telas, entao quem abre o dialogo passa a PK e o
    * BO busca o registro.
    *
    * SQLEXEC direto (mesmo estilo de Inserir/Atualizar deste BO) em vez do
    * Buscar() herdado: aqui o nome do cursor e EXPLICITO, em vez de depender
    * do default interno do DataAccess ("cur" + tabela).
    *==========================================================================
    PROCEDURE CarregarPorChave(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCidchaves) != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
                THIS.this_cMensagemErro = "Chave do lan" + CHR(231) + "amento n" + CHR(227) + "o informada."
            ELSE
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvCcr" + ;
                    " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao ler o lan" + CHR(231) + "amento." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "sigopaccBO.CarregarPorChave")
                    THIS.this_lErroExibido = .T.
                ELSE
                    IF RECCOUNT("cursor_4c_Dados") = 0
                        THIS.this_cMensagemErro = "Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado."
                    ELSE
                        SELECT cursor_4c_Dados
                        GO TOP
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Dados")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "sigopaccBO.CarregarPorChave")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL (SELECT * FROM
    * SigMvCcr) para as propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor)
    * antes de acessar os campos (regra #8 CLAUDE.md).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cContems = TratarNulo(contems, "")
                THIS.this_nCotacaos = TratarNulo(cotacaos, 0)
                THIS.this_dDatalts = TratarNulo(datalts, {})
                THIS.this_dDatas = TratarNulo(datas, {})
                THIS.this_dDataconcs = TratarNulo(dataconcs, {})
                THIS.this_dDatatrans = TratarNulo(datatrans, {})
                THIS.this_dDatexcs = TratarNulo(datexcs, {})
                THIS.this_cDocus = TratarNulo(docus, "")
                THIS.this_cDopes = TratarNulo(dopes, "")
                THIS.this_dDtemis = TratarNulo(dtemis, {})
                THIS.this_cEmps = TratarNulo(emps, "")
                THIS.this_cGrupages = TratarNulo(grupages, "")
                THIS.this_cGrupems = TratarNulo(grupems, "")
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cHists = TratarNulo(hists, "")
                THIS.this_cLocals = TratarNulo(locals, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_cNfs = TratarNulo(nfs, "")
                THIS.this_nNlancs = TratarNulo(nlancs, 0)
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nNtrans = TratarNulo(ntrans, 0)
                THIS.this_nNumes = TratarNulo(numes, 0)
                THIS.this_cOpers = TratarNulo(opers, "")
                THIS.this_nSaldocs = TratarNulo(saldocs, 0)
                THIS.this_nSaldons = TratarNulo(saldons, 0)
                THIS.this_nSaldos = TratarNulo(saldos, 0)
                THIS.this_cScontas = TratarNulo(scontas, "")
                THIS.this_nScotacaos = TratarNulo(scotacaos, 0)
                THIS.this_cSgrupos = TratarNulo(sgrupos, "")
                THIS.this_cShists = TratarNulo(shists, "")
                THIS.this_cSmoedas = TratarNulo(smoedas, "")
                THIS.this_cSopers = TratarNulo(sopers, "")
                THIS.this_nSvalors = TratarNulo(svalors, 0)
                THIS.this_cTipos = TratarNulo(tipos, "")
                THIS.this_cTitbans = TratarNulo(titbans, "")
                THIS.this_cTitulos = TratarNulo(titulos, "")
                THIS.this_cUsualts = TratarNulo(usualts, "")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "")
                THIS.this_nValliqs = TratarNulo(valliqs, 0)
                THIS.this_nValocurs = TratarNulo(valocurs, 0)
                THIS.this_nValors = TratarNulo(valors, 0)
                THIS.this_nValpags = TratarNulo(valpags, 0)
                THIS.this_dVencs = TratarNulo(vencs, {})
                THIS.this_cVlancs = TratarNulo(vlancs, "")
                THIS.this_cVopers = TratarNulo(vopers, "")
                THIS.this_nContapgs = TratarNulo(contapgs, 0)
                THIS.this_cDopcs = TratarNulo(dopcs, "")
                THIS.this_nNumcs = TratarNulo(numcs, 0)
                THIS.this_cCotusus = TratarNulo(cotusus, "")
                THIS.this_cBcontas = TratarNulo(bcontas, "")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "")
                THIS.this_nBorderos = TratarNulo(borderos, 0)
                THIS.this_cHist2s = TratarNulo(hist2s, "")
                THIS.this_nIntconts = TratarNulo(intconts, 0)
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "")
                THIS.this_cAuditors = TratarNulo(auditors, "")
                THIS.this_dDtaudits = TratarNulo(dtaudits, {})
                THIS.this_nValprev = TratarNulo(valprev, 0)
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "")
                THIS.this_cPagos = TratarNulo(pagos, "")
                THIS.this_cDopotps = TratarNulo(dopotps, "")
                THIS.this_cUsupagos = TratarNulo(usupagos, "")
                THIS.this_nTitcancs = TratarNulo(titcancs, 0)
                THIS.this_dDtconfs = TratarNulo(dtconfs, {})
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "")
                THIS.this_nNopercancs = TratarNulo(nopercancs, 0)
                THIS.this_cEspecienfs = TratarNulo(especienfs, "")
                THIS.this_cJobs = TratarNulo(jobs, "")
                THIS.this_nImpostos = TratarNulo(impostos, 0)
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, 0)
                THIS.this_cTitpais = TratarNulo(titpais, "")
                THIS.this_cEmpccs = TratarNulo(empccs, "")
                THIS.this_nRecor = TratarNulo(recor, 0)
                THIS.this_cCompet = TratarNulo(compet, "")
                THIS.this_cEmpos = TratarNulo(empos, "")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "")
                THIS.this_cPastas = TratarNulo(pastas, "")
                THIS.this_cRcontas = TratarNulo(rcontas, "")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo lancamento em SigMvCcr
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(NVL(THIS.this_cEmps, "")))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            THIS.this_cUsualts = gc_4c_UsuarioLogado
            THIS.this_dDatalts = DATETIME()

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
            THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza lancamento existente em SigMvCcr (por cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts = gc_4c_UsuarioLogado
            THIS.this_dDatalts = DATETIME()

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
            THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

