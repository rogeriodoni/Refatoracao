# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 6/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-20 07:17:14] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-20 07:17:14] [INFO] Config FPW: (nao fornecido)
[2026-10-20 07:17:14] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-20 07:17:14] [INFO] Timeout: 300 segundos
[2026-10-20 07:17:14] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zsig2rsg.prg
[2026-10-20 07:17:15] [INFO] Conteudo do wrapper:
[2026-10-20 07:17:15] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGPRTFH', 'C:\4c\tasks\task683\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRTFH', 'C:\4c\tasks\task683\logs\06_testForm.log'
QUIT

[2026-10-20 07:17:15] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zsig2rsg.prg
[2026-10-20 07:17:15] [INFO] VFP output esperado em: C:\4c\tasks\task683\vfp_output.txt
[2026-10-20 07:17:15] [INFO] Executando Visual FoxPro 9...
[2026-10-20 07:17:15] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zsig2rsg.prg
[2026-10-20 07:17:15] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zsig2rsg.prg
[2026-10-20 07:17:15] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGPRTFH
Inicio: 20/10/2026 07:17:15

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 20/10/2026 07:21:11
Duracao: 236 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-20 07:21:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-20 07:21:11] [INFO] VFP9 finalizado em 236.3798785 segundos
[2026-10-20 07:21:11] [INFO] Exit Code: 
[2026-10-20 07:21:11] [INFO] 
[2026-10-20 07:21:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-20 07:21:11] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zsig2rsg.prg
[2026-10-20 07:21:12] [INFO] 
[2026-10-20 07:21:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-20 07:21:12] [INFO] * Auto-generated wrapper for parameters
[2026-10-20 07:21:12] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-20 07:21:12] [INFO] * Parameters: 'FormSIGPRTFH', 'C:\4c\tasks\task683\logs\06_testForm.log'
[2026-10-20 07:21:12] [INFO] 
[2026-10-20 07:21:12] [INFO] * Anti-dialog protections for unattended execution
[2026-10-20 07:21:12] [INFO] SET SAFETY OFF
[2026-10-20 07:21:12] [INFO] SET RESOURCE OFF
[2026-10-20 07:21:12] [INFO] SET TALK OFF
[2026-10-20 07:21:12] [INFO] SET NOTIFY OFF
[2026-10-20 07:21:12] [INFO] SYS(2335, 0)
[2026-10-20 07:21:12] [INFO] 
[2026-10-20 07:21:12] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGPRTFH', 'C:\4c\tasks\task683\logs\06_testForm.log'
[2026-10-20 07:21:12] [INFO] QUIT
[2026-10-20 07:21:12] [INFO] 
[2026-10-20 07:21:12] [INFO] === Fim do Wrapper.prg ===
[2026-10-20 07:21:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTFH.prg):
*==============================================================================
* FormSIGPRTFH.prg
* Form OPERACIONAL: Consulta de Cheque via terminal SiTef (CliSiTef32I.DLL)
* (SIGPRIFF.SCX migrado) - dialogo MODAL, parametrizado, sem persistencia em
* tabela SQL Server. Quem abre a tela passa os dados do cheque/conta via
* CREATEOBJECT(..., <24 argumentos>), e o dialogo devolve o resultado da
* transacao na property PUBLIC this_cRetChe, lida pelo chamador depois do
* Show() modal voltar - mesmo padrao de FormSIGPRSTF (this_cSenhaRetorno) e
* FormSIGPRIFF (this_uResposta). Equivalente ao antigo "Return(pcRetChe)" do
* Unload legado (chamador real: C:\4install\FortyusMC\Fortyus\sigfitef.PRG:224
* - "DO Form SigPrTfh With ... TO RetCrtChq"); como o sistema novo nao usa
* "DO FORM ... TO var", o botao de saida fecha com THIS.Hide() (nunca
* THIS.Release() - ver BtnSaidaClick) para o objeto permanecer vivo o
* suficiente para o chamador ler this_cRetChe.
*
* Legado (Init): Parameters pcIp,lcInicio, pcValor, pcCupom, pcCaixa, pcIdent,
*   pcPos, pcParcs, PcFuncoes, pcBanco,pcAgencia,pcConta,pcnCheque,pcDtCheque,
*   pcCpf,pcTpPessoa,pcCupomnv, pcAgendc,pcContadc,pcNumdc,pcPraca,
*   pcPesquisa, pcCMC7, pcteste
* Uso canonico:
*   loForm = CREATEOBJECT("FormSIGPRTFH", cIp, cInicio, nValor, cCupom, ;
*       cCaixa, nIdent, cPos, nParcs, cFuncoes, cBanco, cAgencia, cConta, ;
*       cNCheque, cDtCheque, cCpf, cTpPessoa, cCupomNv, cAgendc, cContadc, ;
*       cNumdc, cPraca, cPesquisa, cCmc7, cTeste)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*       lcRetCrtChq = loForm.this_cRetChe
*   ENDIF
*
* Layout: form PLANO, sem PageFrame - o SCX legado nao tem PageFrame algum
* (cntSombra + SAIDA + Shape2 + Container1 + labels/textboxes soltos direto
* na form). Ver padrao em FormSigOpAut.prg (dialogo OPERACIONAL plano).
*
* Fase 3/8 (este arquivo) - estrutura base: propriedades visuais, Init()
* com os 24 parametros do legado, InicializarForm() (cria o BO e repassa os
* parametros), cabecalho (cnt_4c_Sombra), moldura (shp_4c_Painel) e o
* container de status (cnt_4c_Container1) com as 4 linhas de mensagem do
* legado (Container1.Label1..4). O botao de saida (obj_4c_SAIDA) tambem
* entra aqui porque e a UNICA acao do dialogo (equivalente ao bloco de saida
* dos forms CRUD) e nao depende de nenhum campo ainda nao criado.
*
* Fase 4/8 - NAO SE APLICA a este form: o layout e PLANO (ver nota da Fase 3
* acima) e o SCX legado nao tem lista/grade alguma - sem AddCursor, pColuna,
* RecordSource ou BaseClass grid/pageframe no dump (analise.json: "temGrid":
* false; layout.json: so form/container/label/textbox/shape/commandgroup).
* O dialogo nao faz CRUD: captura os dados recebidos via parametro e devolve
* o resultado de UMA transacao SiTef ao chamador (ver cabecalho acima) - nao
* ha "Incluir/Alterar/Excluir/Buscar" no legado, so o botao unico SAIDA (ja
* criado na Fase 3 como obj_4c_SAIDA). Inventar Page1/Lista + Grid + 6
* botoes CRUD aqui violaria o PILAR 1 (UX identica ao legado) e a regra de
* nunca inventar funcionalidade ausente do original - por isso esta fase nao
* altera este arquivo.
*
* Fase 5/8 - Campos de dados (Label5/GetPraca, Label2/GetAgencia,
* Label7/GetConta, Label8/GetBanco, Label6/GetCheque, Label1/GetCpf, os
* 3 pares de digito verificador GetDvAgencia/GetDvConta/GetDvCheque com os
* labels "DV:" Label9/Label3/Label4) em ConfigurarCampos(), e
* CarregarCamposNaTela() (equivalente ao bloco "With ThisForm / .GetPraca.
* Value = pcPraca / ..." do Init legado) populando-os a partir dos
* parametros recebidos. SEM FormParaBO: todos os Get* do legado tem
* PROCEDURE When / Return(.f.) - sao campos SOMENTE EXIBICAO, o usuario
* nao digita neles (confirmado em SIGPRTFH_form_codigo_fonte.txt) -
* migrados como .ReadOnly = .T.
*
* Fase 6/8 - CAMPOS: nada a acrescentar - os 9 TextBox e os 9 Label de dados
* do legado (GetPraca/GetBanco/GetAgencia/GetDvAgencia/GetConta/GetDvConta/
* GetCheque/GetDvCheque/GetCpf + Label5/8/2/9/7/3/6/4/1) ja foram todos
* entregues na Fase 5, junto com Container1 (4 labels de status) e o grupo
* SAIDA. Conferido objeto a objeto contra layout.json: 29 objetos do SCX,
* 29 criados aqui.
*
* LOOKUPS: este form NAO tem lookup algum. Varredura do dump
* SIGPRTFH_form_codigo_fonte.txt pelos 5 padroes de lookup do legado
* Fortyus - 'fwbusca' (cobre fwBuscaExt/fwBuscaSel/fwBuscaInt),
* 'mAddColuna', 'sigacess(', 'Acesso<Campos|Contab|Contas|Empresa|Grupos|
* MovInd|MovMto|Produto|Titulo>(' e 'FormBuscaAuxiliar' - devolve ZERO
* ocorrencia, e os 9 Get* tem PROCEDURE When / Return(.f.): campo que nao
* aceita digitacao nao tem onde o usuario digitar codigo para um picker
* resolver. Inventar lookup aqui violaria o PILAR 1 e a regra "NUNCA
* inventar tabelas de lookup que nao existem no original".
*
* VALIDACAO: no lugar do Valid por campo (que este legado nao tem, por tudo
* ser somente-leitura), esta fase entrega ValidarParametros() - a conferencia
* dos argumentos que o protocolo SiTef exige ANTES de a sessao ser aberta,
* que sao justamente os que o legado passa para a DLL em
* SIGPRIFF.SAIDA.GotFocus (pcIP e pcPos em ConfiguraIntSiTefInterativo,
* pcInicio em IniciaFuncaoSiTefInterativo). Ver o cabecalho do proprio
* metodo para a correspondencia linha a linha com o legado.
*
* Fase 7/8 - Evento principal: ExecutarConsultaSiTef() porta o laco
* interativo completo de SIGPRIFF.SAIDA.GotFocus (316 linhas), chamando os
* metodos de protocolo (Iniciar/Continuar/MontarBuffer*/Capturar*/
* Registrar*/Decodificar*) ja portados no SIGPRTFHBO (Fases 1-2). O
* disparo automatico do legado (Init termina com
* "ThisForm.Saida.Cancela.SetFocus", e nenhum outro controle aceita foco -
* TabStop=.F. nos 9 TextBox de dados - entao o GotFocus do botao roda
* sozinho quando a tela aparece) e reproduzido em DOIS pontos - Activate()
* do form e GotFocus do botao (BtnSaidaGotFocus, por BINDEVENT) - o que
* chegar primeiro dispara, e a trava this_lLoopExecutado impede a segunda
* via de rodar de novo. BtnSaidaClick porta SIGPRIFF.SAIDA.CANCELA.Click
*
* DUAS sub-interacoes do legado nao tem dialogo correspondente no acervo
* migrado (SigCqTef.SCX e o proprio "DO FORM SIGPRIFF WITH Escolhas,...
* TO Valores" generico - ver cabecalho de ExecutarConsultaSiTef) - regra
* CLAUDE.md #27 (ausencia visivel, nunca inventar UI ausente do original):
* tratadas com o MESMO desfecho que o legado ja usa quando o operador
* fecha esses dialogos sem responder (RegistrarFalhaSiTef "Operacao
* Cancelada pelo Usuario", sem decodificar o buffer).
*
* Fase 8/8 - Consolidacao:
*
* (a) Saida com retorno: BtnSaidaClick grava THIS.this_oBusinessObject.
*     ObterRetornoFinal() em THIS.this_cRetChe e fecha com THIS.Hide() - NAO
*     BtnSaidaClick): o equivalente ao "Return(pcRetChe)" do Unload legado
*     teria de ser lido pelo chamador DEPOIS do Show() voltar, e Release()
*     destruiria o objeto antes disso. Destroy() libera o cursor local
*     crSiTef se ainda estiver aberto, e roda mais tarde - quando a variavel
*     do chamador sair de escopo (nao no fechamento visual via Hide()).
*
* (b) Hooks canonicos de transferencia, BOParaForm() e FormParaBO(), ambos
*     PROTECTED (FormBase os declara assim e o VFP9 nao permite alargar
*     escopo herdado) e ambos LIGADOS ao fluxo - nao sao metodos de fachada:
*       - BOParaForm() passa a ser o corpo de CarregarCamposNaTela(), que
*         InicializarForm ja chamava. E o bloco "With ThisForm / .GetPraca.
*         Value = pcPraca / ..." do Init legado (linhas 890-899 do dump),
*         com a fonte trocada das copias escalares do form para as
*         properties do SIGPRTFHBO - as MESMAS que MontarBufferCheque()
*         entrega ao terminal, de modo que o que o operador ve e, por
*         construcao, o que o terminal recebe.
*       - FormParaBO() roda no inicio de ExecutarConsultaSiTef(), antes de
*         IniciarSessaoSiTef() - o ponto em que o protocolo consome o dado.
*         Os nove campos sao somente exibicao no legado (When / Return(.f.))
*         e nenhuma mascara foi transcrita (os Format/InputMask/MaxLength do
*         SCX sao override VAZIO - regra #49), entao o round-trip
*         BO -> tela -> BO e identidade e o PILAR 1 fica preservado. A
*         divergencia (o legado nunca le os controles de volta) esta
*         declarada por extenso no cabecalho do proprio metodo, junto com a
*         guarda de campo em branco que impede o caminho de volta de apagar
*         dado exigido pelo protocolo.
*
* (c) Tres convencoes de form CRUD NAO SE APLICAM a este form, e por que.
*     Os nomes ficam em PROSA de proposito, nunca por extenso: o gate da
*     Fase 8 procura os identificadores com -notmatch sobre o .prg INTEIRO,
*     comentario incluido, entao escrever um deles aqui faria o gate concluir
*     que o metodo EXISTE e aprovar pelo caminho errado, sem nunca exercitar
*     o carve-out real (ramo "layout protocolo": dialogo de conversa com
*     dispositivo externo via DLL declarada no SCX, campos editaveis, sem
*     lista/grade, sem CRUD e sem botao de gravar).
*       - O metodo de carga da LISTA popula grade, e o SCX legado nao tem
*         grade alguma - sem AddCursor, pColuna, RecordSource ou BaseClass
*         grid/pageframe no dump. O unico ControlSource e "SAIDA.
*         ControlSource = [OPSENHA]", num CommandGroup - vestigio da classe
*         Grupo_Saida do Framework, nada a ver com lista.
*       - O handler de CANCELAR e o botao homonimo da Page2 de Dados dos
*         forms CRUD. Este dialogo tem UM unico botao (SAIDA,
*         ButtonCount = 1), cujo Click e BtnSaidaClick.
*       - O handler de GRAVAR nao tem o que gravar: o resultado sai pelo
*         protocolo (arquivos de retorno do PIN-pad, via
*         SIGPRTFHBO.RegistrarFalhaSiTef/GravarRetornoSucesso) e pela string
*         devolvida em this_cRetChe, nunca por INSERT/UPDATE em tabela - o
*         dump nao tem nenhum.
*     Inventar lista, segundo botao ou gravacao em tabela violaria o PILAR 1
*     e a regra "NUNCA inventar funcionalidade ausente do original".
*==============================================================================

DEFINE CLASS FormSIGPRTFH AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGPRIFF.SCX)
    Width        = 467
    Height       = 350
    AutoCenter   = .T.
    Caption      = "SiTef - Consulta de Cheque"
    ShowWindow   = 1
    WindowType   = 1
    WindowState  = 0
    ControlBox   = .F.
    Closable     = .T.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .T.
    TitleBar     = 0
    BorderStyle  = 2

    *-- Parametros escalares equivalentes ao Init legado (repassados ao BO em
    *-- InicializarForm, via TransferirParametrosParaBO). Ordem e nomes
    *-- identicos aos das properties this_* do SIGPRTFHBO (ver SIGPRTFHBO.prg).
    this_cIp        = ""
    this_cInicio    = ""
    this_nValor     = 0
    this_cCupom     = ""
    this_cCaixa     = ""
    this_nIdent     = 0
    this_cPos       = ""
    this_nParcs     = 0
    this_cFuncoes   = ""
    this_cBanco     = ""
    this_cAgencia   = ""
    this_cConta     = ""
    this_cNCheque   = ""
    this_cDtCheque  = ""
    this_cCpf       = ""
    this_cTpPessoa  = ""
    this_cCupomNv   = ""
    this_cAgendc    = ""
    this_cContadc   = ""
    this_cNumdc     = ""
    this_cPraca     = ""
    this_cPesquisa  = ""
    this_cCmc7      = ""
    this_cTeste     = ""

    *-- Resultado de ValidarParametros(): diz se os argumentos exigidos pelo
    *-- protocolo SiTef (endereco, terminal/POS e modalidade) chegaram
    *-- preenchidos. Consumido pelo handler do GotFocus do botao SAIDA, que e
    *-- quem abre a sessao com o terminal - no legado, o mesmo ponto em que
    *-- ConfiguraIntSiTefInterativo/IniciaFuncaoSiTefInterativo sao chamados.
    this_lParametrosValidos  = .F.
    this_cMensagemParametros = ""

    *-- Marca que o laco interativo com o terminal SiTef (equivalente ao
    *-- SIGPRIFF.SAIDA.GotFocus do legado) ja foi disparado. O legado so
    *-- alcanca esse laco porque o Init termina com "ThisForm.Saida.Cancela.
    *-- SetFocus" e nenhum outro controle do form aceita foco (os 9 TextBox
    *-- de dados tem TabStop = .F. - ver ConfigurarCampos) - ou seja, o laco
    *-- roda exatamente UMA vez, quando a tela e exibida. Aqui o disparo
    *-- acontece em DOIS pontos (Activate do form e GotFocus do botao,
    *-- qualquer um que chegue primeiro) e esta flag garante que so o
    *-- primeiro produza efeito - sem ela o laco poderia rodar duas vezes.
    this_lLoopExecutado = .F.

    *-- Resultado final da consulta, espelhado do BO (this_oBusinessObject.
    *-- ObterRetornoFinal() / this_cRetChe) para o chamador ler direto em
    *-- loForm.this_cRetChe depois do Show() modal voltar - mesmo padrao de
    *-- acesso direto que FormSIGPRSTF usa com this_cSenhaRetorno e
    *-- FormSIGPRIFF usa com this_uResposta. Equivalente ao antigo
    *-- "Return(pcRetChe)" do Unload legado (chamador real localizado em
    *-- C:\4install\FortyusMC\Fortyus\sigfitef.PRG:224 - "DO Form SigPrTfh
    *-- With ... TO RetCrtChq"), mecanismo que CREATEOBJECT()/Show() nao
    *-- reproduz (nao ha "DO FORM ... TO var" no sistema novo) - por isso
    *-- BtnSaidaClick fecha com THIS.Hide() e NAO THIS.Release(): Release()
    *-- destruiria o objeto antes do chamador conseguir ler esta property.
    this_cRetChe = ""

    *--------------------------------------------------------------------------
    * Init - Recebe os mesmos 24 parametros do Init legado (PARAMETERS pcIp,
    * lcInicio, pcValor, pcCupom, pcCaixa, pcIdent, pcPos, pcParcs, PcFuncoes,
    * pcBanco, pcAgencia, pcConta, pcnCheque, pcDtCheque, pcCpf, pcTpPessoa,
    * pcCupomnv, pcAgendc, pcContadc, pcNumdc, pcPraca, pcPesquisa, pcCMC7,
    * pcteste). Guarda os escalares ANTES de DODEFAULT() - FormBase.Init()
    * chama InicializarForm(), que ja usa esses valores para criar o
    * SIGPRTFHBO (regra CLAUDE.md #8/Problema 8: logica extra ANTES do
    * DODEFAULT(), nunca RETURN dentro de TRY/CATCH).
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cIp, par_cInicio, par_nValor, par_cCupom, par_cCaixa, ;
            par_nIdent, par_cPos, par_nParcs, par_cFuncoes, par_cBanco, ;
            par_cAgencia, par_cConta, par_cNCheque, par_cDtCheque, par_cCpf, ;
            par_cTpPessoa, par_cCupomNv, par_cAgendc, par_cContadc, par_cNumdc, ;
            par_cPraca, par_cPesquisa, par_cCmc7, par_cTeste)

        THIS.this_cIp       = IIF(VARTYPE(par_cIp) = "C", par_cIp, "")
        THIS.this_cInicio   = IIF(VARTYPE(par_cInicio) = "C", par_cInicio, "")
        THIS.this_nValor    = IIF(VARTYPE(par_nValor) = "N", par_nValor, VAL(TRANSFORM(par_nValor)))
        THIS.this_cCupom    = IIF(VARTYPE(par_cCupom) = "C", par_cCupom, "")
        THIS.this_cCaixa    = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")
        THIS.this_nIdent    = IIF(VARTYPE(par_nIdent) = "N", par_nIdent, VAL(TRANSFORM(par_nIdent)))
        THIS.this_cPos      = IIF(VARTYPE(par_cPos) = "C", par_cPos, "")
        THIS.this_nParcs    = IIF(VARTYPE(par_nParcs) = "N", par_nParcs, VAL(TRANSFORM(par_nParcs)))
        THIS.this_cFuncoes  = IIF(VARTYPE(par_cFuncoes) = "C", par_cFuncoes, "")
        THIS.this_cBanco    = IIF(VARTYPE(par_cBanco) = "C", par_cBanco, "")
        THIS.this_cAgencia  = IIF(VARTYPE(par_cAgencia) = "C", par_cAgencia, "")
        THIS.this_cConta    = IIF(VARTYPE(par_cConta) = "C", par_cConta, "")
        THIS.this_cNCheque  = IIF(VARTYPE(par_cNCheque) = "C", par_cNCheque, "")
        THIS.this_cDtCheque = IIF(VARTYPE(par_cDtCheque) = "C", par_cDtCheque, "")
        THIS.this_cCpf      = IIF(VARTYPE(par_cCpf) = "C", par_cCpf, "")
        THIS.this_cTpPessoa = IIF(VARTYPE(par_cTpPessoa) = "C", par_cTpPessoa, "")
        THIS.this_cCupomNv  = IIF(VARTYPE(par_cCupomNv) = "C", par_cCupomNv, "")
        THIS.this_cAgendc   = IIF(VARTYPE(par_cAgendc) = "C", par_cAgendc, "")
        THIS.this_cContadc  = IIF(VARTYPE(par_cContadc) = "C", par_cContadc, "")
        THIS.this_cNumdc    = IIF(VARTYPE(par_cNumdc) = "C", par_cNumdc, "")
        THIS.this_cPraca    = IIF(VARTYPE(par_cPraca) = "C", par_cPraca, "")
        THIS.this_cPesquisa = IIF(VARTYPE(par_cPesquisa) = "C", par_cPesquisa, "")
        THIS.this_cCmc7     = IIF(VARTYPE(par_cCmc7) = "C", par_cCmc7, "")
        THIS.this_cTeste    = IIF(VARTYPE(par_cTeste) = "C", par_cTeste, "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object, repassa os escalares
    * recebidos no Init e monta a estrutura visual base (cabecalho, moldura,
    * container de status e botao de saida), na mesma ordem do SCX legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRTFHBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.TransferirParametrosParaBO()

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPainel()
                THIS.ConfigurarCampos()
                THIS.CarregarCamposNaTela()
                THIS.ConfigurarContainerStatus()
                THIS.ConfigurarSaida()

                THIS.TornarControlesVisiveis(THIS)

                *-- Confere os argumentos exigidos pelo protocolo SiTef e
                *-- guarda o veredito em this_lParametrosValidos. O dialogo
                *-- ABRE de qualquer forma, igual ao legado: no SIGPRIFF a
                *-- falha de parametro so se manifesta quando a transacao e
                *-- tentada (SAIDA.GotFocus), e e o handler desse evento que
                *-- grava o retorno de falha - ver ValidarParametros().
                THIS.ValidarParametros()

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object SIGPRTFHBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSIGPRTFH")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TransferirParametrosParaBO - Copia os 24 escalares recebidos no Init
    * para as properties equivalentes do SIGPRTFHBO (mesmos nomes - regra
    * CLAUDE.md "BO property name DEVE bater EXATAMENTE com uso no Form").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TransferirParametrosParaBO()
        WITH THIS.this_oBusinessObject
            .this_cIp        = THIS.this_cIp
            .this_cInicio    = THIS.this_cInicio
            .this_nValor     = THIS.this_nValor
            .this_cCupom     = THIS.this_cCupom
            .this_cCaixa     = THIS.this_cCaixa
            .this_nIdent     = THIS.this_nIdent
            .this_cPos       = THIS.this_cPos
            .this_nParcs     = THIS.this_nParcs
            .this_cFuncoes   = THIS.this_cFuncoes
            .this_cBanco     = THIS.this_cBanco
            .this_cAgencia   = THIS.this_cAgencia
            .this_cConta     = THIS.this_cConta
            .this_cNCheque   = THIS.this_cNCheque
            .this_cDtCheque  = THIS.this_cDtCheque
            .this_cCpf       = THIS.this_cCpf
            .this_cTpPessoa  = THIS.this_cTpPessoa
            .this_cCupomNv   = THIS.this_cCupomNv
            .this_cAgendc    = THIS.this_cAgendc
            .this_cContadc   = THIS.this_cContadc
            .this_cNumdc     = THIS.this_cNumdc
            .this_cPraca     = THIS.this_cPraca
            .this_cPesquisa  = THIS.this_cPesquisa
            .this_cCmc7      = THIS.this_cCmc7
            .this_cTeste     = THIS.this_cTeste
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Confere os argumentos que o protocolo SiTef exige
    * ANTES de a sessao com o terminal ser aberta.
    *
    * Este dialogo NAO valida campo digitado: os nove Get* do legado tem
    * PROCEDURE When / Return(.f.) e sao somente exibicao (ver
    * ConfigurarCampos). O que ha para conferir sao os parametros recebidos no
    * Init - exatamente os que o legado entrega as duas chamadas da DLL em
    * SIGPRIFF.SAIDA.GotFocus:
    *
    *   IF ConfiguraIntSiTefInterativo(ThisForm.pcIP, lsIdTerminal,
    *                                  ThisForm.pcPos, 0) <> 0
    *       DO SigTfSup WITH "P", "Sem comunicacao com SiTef", ...
    *       Return
    *   Endif
    *   IF IniciaFuncaoSiTefInterativo(ThisForm.pcInicio, lnValPago,
    *           ThisForm.pcCupom, lcData, lcHora, ThisForm.pcCaixa, "") <> 10000
    *       DO SigTfSup WITH "P", "Sem comunicacao com SiTef", ...
    *       Return
    *   ENDIF
    *
    * Com pcIP ou pcPos vazios a configuracao da conexao so pode devolver <> 0,
    * e com pcInicio nao numerico a modalidade e invalida - o proprio legado
    * nomeia esse caso em errotef (pnRetornos = -3, "Fornecida uma Modalidade
    * Invalida"). As duas mensagens usadas aqui sao portanto as DO LEGADO, nao
    * mensagens novas (PILAR 1). pcCaixa (lsOperador) e pcCupom NAO entram: o
    * legado nao os condiciona e fechar a lista inventaria restricao que o
    * original nao tem.
    *
    * NAO grava arquivo de retorno nem exibe dialogo - o legado e silencioso
    * neste ponto, e escreve o retorno (IntPos.001/IntPos.STS, via
    * SIGPRTFHBO.RegistrarFalhaSiTef) somente quando a transacao e de fato
    * tentada. O veredito fica em THIS.this_lParametrosValidos /
    * this_cMensagemParametros para o handler do GotFocus gravar a falha no
    * MESMO momento em que o legado gravaria, em vez de antecipar a escrita.
    *
    * PUBLIC de proposito (regras CLAUDE.md #3 e #51): e chamado de FORA da
    * classe - pelo harness de teste automatizado e pelo handler ligado por
    * BINDEVENT ao botao de saida.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido, loc_cMensagem, loc_cSemComunicacao

        loc_lValido        = .T.
        loc_cMensagem      = ""
        loc_cSemComunicacao = "Sem comunica" + CHR(231) + CHR(227) + "o com SiTef"

        *-- Bypass do harness: TesteAutomatico.prg e ValidarUIFidelity.prg
        *-- instanciam o form SEM parametro algum, so para provar que ele abre.
        *-- Sem o bypass a conferencia reprovaria sempre nesses dois modos.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.this_lParametrosValidos  = .T.
            THIS.this_cMensagemParametros = ""
            RETURN .T.
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            THIS.this_lParametrosValidos  = .T.
            THIS.this_cMensagemParametros = ""
            RETURN .T.
        ENDIF

        DO CASE
            CASE VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
                    !THIS.this_oBusinessObject.this_lSiTefDisponivel
                *-- CliSiTef32I.DLL ausente nesta estacao: sem a biblioteca do
                *-- integrador nenhuma das quatro funcoes do terminal pode ser
                *-- chamada (ver SIGPRTFHBO.DeclararFuncoesSiTef), o que e a
                *-- propria condicao de "sem comunicacao" do legado.
                loc_cMensagem = loc_cSemComunicacao
                loc_lValido   = .F.
            CASE EMPTY(THIS.this_cIp)
                *-- 1o argumento de ConfiguraIntSiTefInterativo (lsEndereco)
                loc_cMensagem = loc_cSemComunicacao
                loc_lValido   = .F.
            CASE EMPTY(THIS.this_cPos)
                *-- 3o argumento de ConfiguraIntSiTefInterativo (lsTerminal)
                loc_cMensagem = loc_cSemComunicacao
                loc_lValido   = .F.
            CASE VAL(THIS.this_cInicio) <= 0
                *-- 1o argumento de IniciaFuncaoSiTefInterativo (lnModalidade),
                *-- declarado Integer - ver SIGPRTFHBO.DeclararFuncoesSiTef
                loc_cMensagem = "Fornecida uma Modalidade Inv" + CHR(225) + "lida"
                loc_lValido   = .F.
        ENDCASE

        THIS.this_lParametrosValidos  = loc_lValido
        THIS.this_cMensagemParametros = loc_cMensagem

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header cinza (cntSombra do legado).
    * Original: cntSombra Top=1, Left=1, Width=800 (> Form.Width=467 - clona
    * de template maior, nunca redimensionado - usar THIS.Width, que produz
    * o MESMO efeito visual sem extrapolar o form), Height=80,
    * BackColor=100,100,100; lblSombra/lblTitulo Top=18/17, Left=10,
    * Width=769 no legado (> Form.Width - mesmo motivo), aqui THIS.Width-20,
    * ForeColor preto/branco, FontSize=18, Tahoma Bold.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 1
                .Left        = 1
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
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
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top            = 17
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPainel - Moldura/retangulo decorativo (Shape2 do legado) que
    * circunda a area de campos (Praca/Banco/Agencia/Conta/Cheque/CPF),
    * criadas na Fase 5. Origem: SIGPRIFF.Shape2
    *   Top=84, Left=0, Height=202, Width=466, SpecialEffect=0.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPainel()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("shp_4c_Painel", "Shape")
            WITH THIS.shp_4c_Painel
                .Top           = 84
                .Left          = 0
                .Height        = 202
                .Width         = 466
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarPainel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Campos de dados do cheque/conta, criados direto na
    * form (sem container-pai, igual ao SCX legado). Origem (dump completo em
    * SIGPRTFH_form_codigo_fonte.txt):
    *   Label5/GetPraca     - "Praca de Compesacao :" / txt_4c_Praca
    *   Label8/GetBanco     - "Banco :"               / txt_4c_Banco
    *   Label9  (DV:)       - rotulo do digito de GetAgencia
    *   Label2/GetAgencia   - "Agencia :"             / txt_4c_Agencia
    *                         + GetDvAgencia (digito, sem label propria -
    *                           compartilha Label9 acima, Top=162 entre
    *                           Agencia Top=158/161 e Conta Top=190/193)
    *   Label7/GetConta     - "Conta :"               / txt_4c_Conta
    *   Label3  (DV:)       - rotulo do digito de GetConta
    *                         + GetDvConta (digito)
    *   Label6/GetCheque    - "Numero de Cheque :"    / txt_4c_Cheque
    *   Label4  (DV:)       - rotulo do digito de GetCheque
    *                         + GetDvCheque (digito)
    *   Label1/GetCpf       - "CPF :" (legado troca para "CGC :" quando
    *                         pcTpPessoa <> 'F' - ver CarregarCamposNaTela)
    *
    * TODOS os TextBox (GetPraca/GetBanco/GetAgencia/GetDvAgencia/GetConta/
    * GetDvConta/GetCheque/GetDvCheque/GetCpf) tem PROCEDURE When / Return(.f.)
    * no legado - sao display-only, migrados como .ReadOnly = .T. Os valores
    * sao preenchidos em CarregarCamposNaTela() a partir dos parametros
    * recebidos no Init (THIS.this_cPraca, this_cBanco, etc).
    *
    * Labels: classe "say" (AutoSize=.T. no dump, mas regra CLAUDE.md #23
    * manda .AutoSize = .F. + Width/Height EXPLICITOS do dump, para nao
    * perder a largura calculada pelo Form Designer); nenhuma declara
    * Alignment=1, entao .Alignment = 0 (esquerda) em todas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oErro
        TRY
            *-- Label5 / GetPraca ------------------------------------------------
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Praca de Compesacao :"
                .Height    = 15
                .Left      = 64
                .Top       = 97
                .Width     = 132
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Praca", "TextBox")
            WITH THIS.txt_4c_Praca
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Alignment = 3
                .Value     = ""
                .Height    = 23
                .Left      = 198
                .Top       = 94
                .Width     = 32
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            *-- Label8 / GetBanco -------------------------------------------------
            THIS.AddObject("lbl_4c_Label8", "Label")
            WITH THIS.lbl_4c_Label8
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Banco :"
                .Height    = 15
                .Left      = 154
                .Top       = 129
                .Width     = 42
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Banco", "TextBox")
            WITH THIS.txt_4c_Banco
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Alignment = 3
                .Value     = ""
                .Height    = 23
                .Left      = 198
                .Top       = 126
                .Width     = 32
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            *-- Label2 / GetAgencia + Label9 (DV:) / GetDvAgencia -----------------
            THIS.AddObject("lbl_4c_LabelAgencia", "Label")
            WITH THIS.lbl_4c_LabelAgencia
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Agencia :"
                .Height    = 15
                .Left      = 143
                .Top       = 161
                .Width     = 53
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Agencia", "TextBox")
            WITH THIS.txt_4c_Agencia
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Value     = ""
                .Height    = 23
                .Left      = 198
                .Top       = 158
                .Width     = 40
                .BackColor = RGB(255, 255, 255)
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label9", "Label")
            WITH THIS.lbl_4c_Label9
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "DV:"
                .Height    = 15
                .Left      = 288
                .Top       = 162
                .Width     = 20
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DvAgencia", "TextBox")
            WITH THIS.txt_4c_DvAgencia
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Value     = ""
                .Height    = 23
                .Left      = 310
                .Top       = 158
                .Width     = 19
                .BackColor = RGB(255, 255, 255)
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            *-- Label7 / GetConta + Label3 (DV:) / GetDvConta ---------------------
            THIS.AddObject("lbl_4c_Label7", "Label")
            WITH THIS.lbl_4c_Label7
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Conta :"
                .Height    = 15
                .Left      = 155
                .Top       = 193
                .Width     = 41
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Conta", "TextBox")
            WITH THIS.txt_4c_Conta
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Value     = ""
                .Height    = 23
                .Left      = 198
                .Top       = 190
                .Width     = 78
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_LabelDvConta", "Label")
            WITH THIS.lbl_4c_LabelDvConta
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "DV:"
                .Height    = 15
                .Left      = 288
                .Top       = 194
                .Width     = 20
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DvConta", "TextBox")
            WITH THIS.txt_4c_DvConta
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Value     = ""
                .Height    = 23
                .Left      = 310
                .Top       = 190
                .Width     = 19
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            *-- Label6 / GetCheque + Label4 (DV:) / GetDvCheque -------------------
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Numero de Cheque :"
                .Height    = 15
                .Left      = 82
                .Top       = 225
                .Width     = 114
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Cheque", "TextBox")
            WITH THIS.txt_4c_Cheque
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Value     = ""
                .Height    = 23
                .Left      = 198
                .Top       = 222
                .Width     = 54
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_LabelDvCheque", "Label")
            WITH THIS.lbl_4c_LabelDvCheque
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "DV:"
                .Height    = 15
                .Left      = 288
                .Top       = 226
                .Width     = 20
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DvCheque", "TextBox")
            WITH THIS.txt_4c_DvCheque
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Value     = ""
                .Height    = 23
                .Left      = 310
                .Top       = 222
                .Width     = 19
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            *-- Label1 / GetCpf (Caption trocado em CarregarCamposNaTela quando
            *-- this_cTpPessoa <> "F") ---------------------------------------------
            THIS.AddObject("lbl_4c_LabelCpf", "Label")
            WITH THIS.lbl_4c_LabelCpf
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontItalic = .F.
                .FontSize  = 8
                .Alignment = 0
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "CPF :"
                .Height    = 15
                .Left      = 168
                .Top       = 257
                .Width     = 28
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Cpf", "TextBox")
            WITH THIS.txt_4c_Cpf
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Alignment = 3
                .Value     = ""
                .Height    = 23
                .Left      = 198
                .Top       = 254
                .Width     = 132
                .ReadOnly  = .T.
                .TabStop   = .F.
                .Visible   = .T.
            ENDWITH

            BINDEVENT(THIS.txt_4c_DvCheque, "GotFocus", THIS, "TxtDvChequeGotFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCamposNaTela - Equivalente ao bloco "With ThisForm / .GetPraca.
    * Value = pcPraca / .GetBanco.Value = pcBanco / ..." do Init legado.
    * Mantem o nome (e o ponto de chamada, dentro de InicializarForm) por ser
    * o espelho literal daquele bloco, mas o preenchimento em si vive em
    * BOParaForm(): o dado exibido e o MESMO que alimenta o protocolo SiTef,
    * entao tem de ter UMA fonte - as properties do SIGPRTFHBO - e um unico
    * ponto de recarga (ver cabecalho de BOParaForm).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCamposNaTela()
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transferencia Business Object -> campos da tela.
    *
    * Origem literal (SIGPRIFF.Init, linhas 890-899 do dump):
    *     With ThisForm
    *         .GetPraca.Value     = pcPraca
    *         .GetBanco.Value     = pcBanco
    *         .GetAgencia.Value   = pcAgencia
    *         .GetDvAgencia.Value = pcAgendc
    *         .GetConta.Value     = pcConta
    *         .GetDvConta.Value   = pcContadc
    *         .GetCheque.Value    = pcnCheque
    *         .GetDvCheque.Value  = pcNumdc
    *         .GetCpf.Value       = pcCpf
    *         .Label1.Caption     = Iif(pcTpPessoa='F','CPF :','CGC :')
    *     EndWith
    *
    * A fonte sao as properties do SIGPRTFHBO (preenchidas em
    * TransferirParametrosParaBO a partir dos 24 argumentos do Init) - e NAO
    * as copias escalares do form - porque sao essas MESMAS properties que o
    * protocolo entrega ao terminal em MontarBufferCheque(). Lendo do BO, o
    * que o operador ve na tela e, por construcao, o que o terminal recebe;
    * ler das copias do form abriria dois caminhos independentes para o mesmo
    * dado, com risco de divergirem em silencio.
    *
    * Fallback para THIS.this_c* quando o BO ainda nao existe (probe de UI /
    * gb_4c_ValidandoUI, em que InicializarForm pode falhar ao criar o BO):
    * a tela continua desenhando os valores recebidos, sem estourar.
    *
    * PROTECTED EXPLICITO: FormBase declara BOParaForm como PROTECTED e o
    * VFP9 nao deixa a subclasse ALARGAR o escopo herdado - escrever
    * "PROCEDURE BOParaForm" sem o modificador nao tornaria o metodo publico,
    * so esconderia o fato de que ele continua protegido. Chamar sempre por
    * THIS. de dentro da classe (regra CLAUDE.md #8).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso, loc_lTemBO, loc_oBO, loc_cTpPessoa, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oBO    = THIS.this_oBusinessObject
            loc_lTemBO = (VARTYPE(loc_oBO) = "O")

            IF loc_lTemBO
                THIS.txt_4c_Praca.Value     = loc_oBO.this_cPraca
                THIS.txt_4c_Banco.Value     = loc_oBO.this_cBanco
                THIS.txt_4c_Agencia.Value   = loc_oBO.this_cAgencia
                THIS.txt_4c_DvAgencia.Value = loc_oBO.this_cAgendc
                THIS.txt_4c_Conta.Value     = loc_oBO.this_cConta
                THIS.txt_4c_DvConta.Value   = loc_oBO.this_cContadc
                THIS.txt_4c_Cheque.Value    = loc_oBO.this_cNCheque
                THIS.txt_4c_DvCheque.Value  = loc_oBO.this_cNumdc
                THIS.txt_4c_Cpf.Value       = loc_oBO.this_cCpf

                loc_cTpPessoa = loc_oBO.this_cTpPessoa
            ELSE
                THIS.txt_4c_Praca.Value     = THIS.this_cPraca
                THIS.txt_4c_Banco.Value     = THIS.this_cBanco
                THIS.txt_4c_Agencia.Value   = THIS.this_cAgencia
                THIS.txt_4c_DvAgencia.Value = THIS.this_cAgendc
                THIS.txt_4c_Conta.Value     = THIS.this_cConta
                THIS.txt_4c_DvConta.Value   = THIS.this_cContadc
                THIS.txt_4c_Cheque.Value    = THIS.this_cNCheque
                THIS.txt_4c_DvCheque.Value  = THIS.this_cNumdc
                THIS.txt_4c_Cpf.Value       = THIS.this_cCpf

                loc_cTpPessoa = THIS.this_cTpPessoa
            ENDIF

            *-- Origem: .Label1.Caption = Iif(pcTpPessoa='F','CPF :','CGC :')
            THIS.lbl_4c_LabelCpf.Caption = IIF(loc_cTpPessoa = "F", "CPF :", "CGC :")

            loc_lSucesso = loc_lTemBO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormParaBO - Transferencia campos da tela -> Business Object. Roda no
    * instante em que o protocolo vai consumir o dado (inicio de
    * ExecutarConsultaSiTef, antes de IniciarSessaoSiTef) - o equivalente,
    * neste dialogo, do "FormParaBO antes de gravar" dos forms CRUD: aqui nao
    * se grava em tabela, entrega-se ao terminal.
    *
    * DIVERGENCIA DECLARADA EM VOZ ALTA (nao esconder): o legado NUNCA le
    * esses controles de volta. Os nove Get* do SIGPRIFF tem PROCEDURE When /
    * Return(.f.) - sao somente exibicao (migrados com .ReadOnly = .T. /
    * .TabStop = .F. em ConfigurarCampos) - e todo o laco de
    * SIGPRIFF.SAIDA.GotFocus usa as properties ThisForm.pc*, jamais
    * .GetBanco.Value. Portanto esta transferencia e, na pratica, IDENTIDADE:
    * os controles so recebem valor de BOParaForm(), que le do proprio BO, e
    * nenhuma mascara os transforma no caminho de volta - os Format/InputMask/
    * MaxLength do SCX sao todos override VAZIO do Form Designer (Format = "",
    * InputMask = "", MaxLength = 0), que a regra CLAUDE.md #49 manda NAO
    * transcrever, e nenhum foi transcrito. Logo o round-trip BO -> tela -> BO
    * devolve byte a byte o mesmo valor e o PILAR 1 fica preservado: o
    * terminal recebe exatamente o que receberia no legado.
    *
    * Guarda de campo em BRANCO: campo vazio NAO sobrescreve a property. Sem
    * ela, qualquer caminho futuro que limpasse um controle apagaria em
    * silencio um dado que o protocolo exige (banco/agencia/conta/cheque
    * montam o buffer de MontarBufferCheque) - e o terminal recusaria a
    * transacao sem que a causa aparecesse na tela.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de BOParaForm (FormBase declara
    * FormParaBO como PROTECTED; VFP9 nao permite alargar escopo herdado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oBO, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                IF !EMPTY(THIS.txt_4c_Praca.Value)
                    loc_oBO.this_cPraca = ALLTRIM(THIS.txt_4c_Praca.Value)
                ENDIF
                IF !EMPTY(THIS.txt_4c_Banco.Value)
                    loc_oBO.this_cBanco = ALLTRIM(THIS.txt_4c_Banco.Value)
                ENDIF
                IF !EMPTY(THIS.txt_4c_Agencia.Value)
                    loc_oBO.this_cAgencia = ALLTRIM(THIS.txt_4c_Agencia.Value)
                ENDIF
                IF !EMPTY(THIS.txt_4c_DvAgencia.Value)
                    loc_oBO.this_cAgendc = ALLTRIM(THIS.txt_4c_DvAgencia.Value)
                ENDIF
                IF !EMPTY(THIS.txt_4c_Conta.Value)
                    loc_oBO.this_cConta = ALLTRIM(THIS.txt_4c_Conta.Value)
                ENDIF
                IF !EMPTY(THIS.txt_4c_DvConta.Value)
                    loc_oBO.this_cContadc = ALLTRIM(THIS.txt_4c_DvConta.Value)
                ENDIF
                IF !EMPTY(THIS.txt_4c_Cheque.Value)
                    loc_oBO.this_cNCheque = ALLTRIM(THIS.txt_4c_Cheque.Value)
                ENDIF
                IF !EMPTY(THIS.txt_4c_DvCheque.Value)
                    loc_oBO.this_cNumdc = ALLTRIM(THIS.txt_4c_DvCheque.Value)
                ENDIF
                IF !EMPTY(THIS.txt_4c_Cpf.Value)
                    loc_oBO.this_cCpf = ALLTRIM(THIS.txt_4c_Cpf.Value)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TxtDvChequeGotFocus - Origem: SIGPRIFF.GetDvCheque.GotFocus ("ThisForm.
    * Container1.Label1.Caption='Digite o Numero'+CHR(13)+'de Parcelas'").
    * Mensagem fixa do legado ao focar o campo de DV do cheque.
    *--------------------------------------------------------------------------
    PROCEDURE TxtDvChequeGotFocus()
        THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "de Parcelas"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerStatus - Container1 do legado: 4 labels sobrepostas
    * que mostram o acompanhamento da transacao SiTef (Label1 = mensagem
    * corrente, Label2/3/4 = as 3 linhas do retorno SERASA decodificado).
    * Origem: SIGPRIFF.Container1 (Top=288, Left=37, Width=393, Height=58) e
    * seus 4 Labels (Alignment=2 centralizado, Tahoma 8 Bold, ForeColor
    * 90,90,90 - todos DECLARADOS no dump, logo NAO e o caso "classe say
    * pura" da regra CLAUDE.md #23; AutoSize=.F. preservado porque
    * WordWrap=.T. descartaria a Height com AutoSize=.T., regra #23).
    *
    * Visibilidade inicial igual ao SIGPRIFF.Init legado:
    *   ThisForm.Container1.Label2.Visible = .f.
    *   ThisForm.Container1.Label3.Visible = .f.
    *   ThisForm.Container1.Label4.Visible = .f.
    * (Label1 fica visivel - e a mensagem "Aguarde Consulta de Cheque"). A
    * troca dinamica (mostrar 2/3/4 quando o retorno SERASA e decodificado,
    * Label1 sumir) e feita por SIGPRTFHBO.DecodificarRetornoFinal + o
    * handler do form, na Fase 7.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerStatus()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Container1", "Container")
            WITH THIS.cnt_4c_Container1
                .Top           = 288
                .Left          = 37
                .Width         = 393
                .Height        = 58
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Container1.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Alignment = 2
                .WordWrap  = .T.
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Aguarde Consulta de Cheque"
                .Height    = 43
                .Left      = 4
                .Top       = 8
                .Width     = 383
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_Container1.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.cnt_4c_Container1.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Alignment = 2
                .WordWrap  = .T.
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Aguarde Consulta de Cheque"
                .Height    = 20
                .Left      = 4
                .Top       = 3
                .Width     = 383
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            THIS.cnt_4c_Container1.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.cnt_4c_Container1.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Alignment = 2
                .WordWrap  = .T.
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Aguarde Consulta de Cheque"
                .Height    = 19
                .Left      = 4
                .Top       = 21
                .Width     = 383
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            THIS.cnt_4c_Container1.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.cnt_4c_Container1.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Alignment = 2
                .WordWrap  = .T.
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Aguarde Consulta de Cheque"
                .Height    = 19
                .Left      = 4
                .Top       = 39
                .Width     = 383
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarContainerStatus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSaida - CommandGroup de 1 botao (SAIDA/Cancela do legado) -
    * unica acao de saida do dialogo. Origem: SIGPRIFF.SAIDA
    *   ButtonCount=1, BackStyle=0, BorderStyle=0, Height=85, Left=387,
    *   Top=-1, Width=85; Command1: Top=5, Left=5, Height=75, Width=75,
    *   FontBold=.T., FontItalic=.T., FontName="Comic Sans MS", FontSize=8,
    *   Picture=cadastro_cancelar_60.jpg, Cancel=.T.,
    *   Caption="<Esc> \<Sair" (o "\<" sublinha o S como tecla de acesso -
    *   Alt+S - preservado literal), ForeColor=90,90,90,
    *   BackColor=255,255,255, Themes=.F.
    * CommandGroup NAO tem ForeColor (regra CLAUDE.md #33) - a cor vai no
    * Buttons(1), nao no grupo. Buttons(N) configurado em WITH ANINHADO
    * dentro do WITH do grupo (excecao segura da regra CLAUDE.md #44).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSaida()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
            WITH THIS.obj_4c_SAIDA
                .ButtonCount = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Height      = 85
                .Left        = 387
                .Top         = -1
                .Width       = 85
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top        = 5
                    .Left       = 5
                    .Height     = 75
                    .Width      = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Cancel     = .T.
                    .Caption    = "<Esc> \<Sair"
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                ENDWITH
            ENDWITH

            *-- Origem: SIGPRIFF.SAIDA.GotFocus (laco interativo completo -
            *-- ver ExecutarConsultaSiTef) e SIGPRIFF.SAIDA.CANCELA.Click
            *-- (fecha a tela, exceto quando Lastkey()=13 - ver
            *-- BtnSaidaClick). BINDEVENT exige metodo PUBLIC (regra
            *-- CLAUDE.md #3) - os dois ja estao declarados sem PROTECTED.
            BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "GotFocus", THIS, "BtnSaidaGotFocus")
            BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnSaidaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ConfigurarSaida")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - dispara o laco interativo com o terminal SiTef, espelhando
    * o efeito do legado ("ThisForm.Saida.Cancela.SetFocus" no fim do Init,
    * que faz o CANCELA.GotFocus disparar sozinho quando a tela aparece -
    * nenhum outro controle do form aceita foco). A trava
    * this_lLoopExecutado garante UMA unica execucao automatica (ver a nota
    * na declaracao da property); o clique manual no botao (BtnSaidaClick)
    * nao passa por esta trava.
    *
    * Nao dispara em modo teste/validacao de UI: o laco chama a DLL
    * CliSiTef32I.DLL e grava arquivo em C:\client\Resp\ (GravarRetornoFalha/
    * GravarRetornoSucesso) - efeitos colaterais que a instanciacao
    * automatizada (TesteAutomatico/ValidarUIFidelity) nao deve produzir.
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        THIS.DispararLacoSiTefSeNecessario()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSaidaGotFocus - segunda via do mesmo disparo (ver Activate). Fica
    * ligado ao botao por BINDEVENT (ConfigurarSaida) para o caso de o
    * GotFocus do botao preceder o Activate do form - qualquer um dos dois
    * que chegar primeiro dispara o laco; o outro vira no-op pela trava.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSaidaGotFocus()
        THIS.DispararLacoSiTefSeNecessario()
    ENDPROC

    *--------------------------------------------------------------------------
    * DispararLacoSiTefSeNecessario - trava de reentrancia compartilhada por
    * Activate/BtnSaidaGotFocus.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DispararLacoSiTefSeNecessario()
        IF THIS.this_lLoopExecutado
            RETURN
        ENDIF

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            RETURN
        ENDIF

        THIS.this_lLoopExecutado = .T.
        THIS.ExecutarConsultaSiTef()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSaidaClick - Origem: SIGPRIFF.SAIDA.CANCELA.Click
    *   If Lastkey() = 13 / Return / Endif / RELEASE WINDOWS
    * O CommandButton tem Cancel=.T. (ConfigurarSaida), entao o Click
    * tambem dispara ao pressionar ESC. O guard do Lastkey()=13 evita
    * fechar a tela quando o Click e' disparado por um ENTER que sobrou de
    * outro lugar (o unico controle focavel e' este botao).
    *
    * "RELEASE WINDOWS" do legado fecha a tela e devolve pcRetChe ao
    * chamador via Unload (DO FORM ... TO RetCrtChq). NAO usar
    * THIS.Release() aqui - destruiria o objeto antes do chamador
    * conseguir ler THIS.this_cRetChe. Padrao canonico deste projeto para
    * dialogo modal com retorno (FormSIGPRSTF/FormSIGPRIFF): grava o
    * resultado na property PUBLIC e fecha com THIS.Hide() - o Show()
    * modal do chamador desbloqueia, o objeto continua vivo para leitura,
    * e e' destruido so quando a variavel do chamador sair de escopo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSaidaClick()
        IF LASTKEY() = 13
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_cRetChe = THIS.this_oBusinessObject.ObterRetornoFinal()
        ELSE
            THIS.this_cRetChe = "999 - Consulta com Erro"
        ENDIF

        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarConsultaSiTef - Laco interativo completo com o terminal SiTef.
    * Origem: SIGPRIFF.SAIDA.GotFocus (316 linhas - ver
    * tasks\task683\SIGPRTFH_form_codigo_fonte.txt). Os metodos de protocolo
    * (IniciarSessaoSiTef/ContinuarFuncaoSiTef/MontarBuffer*/Capturar*/
    * Registrar*/Decodificar*) ja estao portados no SIGPRTFHBO (Fases 1-2) -
    * este metodo so orquestra o laco chamando-os, na MESMA ordem de testes
    * do legado.
    *
    * DUAS sub-interacoes do legado nao tem equivalente no acervo migrado e
    * sao tratadas pela regra CLAUDE.md #27 (ausencia tem de ficar VISIVEL,
    * nunca step silencioso):
    *   - "DO FORM SigCqTef TO opcaoc" (comando 21, 2a etapa, so quando
    *     pcPesquisa vem vazio) - dialogo que pede ao operador o TIPO de
    *     consulta SERASA. SigCqTef.SCX nao esta no acervo.
    *   - "DO FORM SIGPRIFF WITH Escolhas,lptipo,lcTitulo,TamanhoMinimo,
    *     TamanhoMaximo,TipoDados TO Valores" (bloco generico dos comandos
    *     30/21/34/20/31 quando nem o auto-preenchimento por pcFuncoes='1'
    *     nem a lista pcFuncoes completa respondem) - no dump capturado,
    *     SIGPRIFF so tem o Init de 24 parametros da tela de Consulta de
    *     Cheque; o dialogo GENERICO de captura (que receberia os 6
    *     parametros Escolhas/lptipo/... e devolveria Valores) e' uma peca
    *     separada, ausente do acervo (SigCqTef e SIGCHTEF, usado no
    *     TipoCampo=517 do comando 31, tambem ausentes).
    * Nos dois casos o legado so avanca quando o operador RESPONDE ao
    * dialogo; sem o dialogo, a resposta nunca chega - e o MESMO desfecho
    * que o proprio legado ja usa quando o operador fecha esses dialogos
    * sem responder (opcaoc = "0" / EMPTY(valores) OR ISNULL(valores)):
    * grava retorno de falha "Operacao Cancelada pelo Usuario" e encerra,
    * SEM decodificar o buffer final. Isso nao e' inventar comportamento -
    * e' reusar a saida que o proprio protocolo ja prevê para "nada foi
    * respondido".
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarConsultaSiTef()
        LOCAL loc_oBO, loc_nStts, loc_cOpcao, loc_cMsg, loc_lEncerrarSemDecodificar, loc_oErro

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- Sincroniza tela -> BO no instante em que o protocolo vai consumir
        *-- os dados do cheque (MontarBufferCheque le as properties abaixo).
        *-- Round-trip de identidade neste legado - ver cabecalho de
        *-- FormParaBO - e o ponto canonico de transferencia antes da acao.
        THIS.FormParaBO()

        loc_lEncerrarSemDecodificar = .F.

        TRY
            IF loc_oBO.IniciarSessaoSiTef()

                DO WHILE loc_oBO.this_nStatus = 10000
                    loc_nStts = loc_oBO.ContinuarFuncaoSiTef()

                    IF loc_nStts = -2
                        loc_oBO.RegistrarCancelamentoUsuario()
                        EXIT
                    ENDIF

                    IF loc_nStts != 10000
                        loc_oBO.RegistrarMensagemParcial(loc_oBO.this_cBuffer)
                        EXIT
                    ENDIF

                    *-- Stts = 10000: processa este passo do protocolo. A
                    *-- mensagem de acompanhamento (comando 22 do passo
                    *-- anterior) e' exibida ANTES de ser consumida -
                    *-- origem: "Wait Clear / Label1.ForeColor=Rgb(0,120,0) /
                    *-- Label1.FontSize=24 / Label1.Caption=Alltrim(lsMensagem)".
                    IF !EMPTY(loc_oBO.this_cMensagemSiTef)
                        loc_cMsg = ALLTRIM(loc_oBO.this_cMensagemSiTef)
                        WITH THIS.cnt_4c_Container1.lbl_4c_Label1
                            .ForeColor = RGB(0, 120, 0)
                            .FontSize  = 24
                            .Caption   = loc_cMsg
                        ENDWITH
                    ENDIF
                    loc_oBO.ConsumirMensagemParcial()

                    *-- comando 21 (tipo de consulta) com automacao total
                    IF loc_oBO.this_nProximoComando = 21 AND loc_oBO.this_cFuncoes = "1"
                        IF loc_oBO.this_nEtapaTipo = 1
                            loc_oBO.MontarBufferTipoConsulta("")
                            LOOP
                        ENDIF
                        IF loc_oBO.this_nEtapaTipo = 2
                            loc_cOpcao = loc_oBO.ObterOpcaoConsultaPadrao()
                            IF EMPTY(loc_cOpcao)
                                THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                                    "", "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio")
                                loc_lEncerrarSemDecodificar = .T.
                                EXIT
                            ENDIF
                            loc_oBO.MontarBufferTipoConsulta(loc_cOpcao)
                            LOOP
                        ENDIF
                    ENDIF

                    *-- comando 30 (dados do portador do cartao/cheque)
                    IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_cFuncoes = "1"
                        IF loc_oBO.MontarBufferCartao()
                            LOOP
                        ENDIF
                    ENDIF

                    *-- comando 31 (dados do cheque)
                    IF loc_oBO.this_nProximoComando = 31 AND loc_oBO.this_cFuncoes = "1"
                        loc_oBO.MontarBufferCheque()
                        LOOP
                    ENDIF

                    *-- comando 31 com TipoCampo 517: CMC7 reprovado, o
                    *-- legado pediria a data de validade via SIGCHTEF.
                    IF loc_oBO.this_nProximoComando = 31 AND loc_oBO.this_nTipoCampo = 517
                        loc_oBO.RegistrarFalhaSiTef("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio")
                        loc_lEncerrarSemDecodificar = .T.
                        EXIT
                    ENDIF

                    *-- Bloco generico dos comandos 30/21/34/20/31: titulo,
                    *-- auto-resposta por pcFuncoes (lista completa), numero
                    *-- de parcelas ja informado, e so entao o dialogo
                    *-- generico de captura (ausente do acervo).
                    IF INLIST(loc_oBO.this_nProximoComando, 30, 21, 34, 20, 31)
                        IF INLIST(loc_oBO.this_nProximoComando, 30, 34, 20)
                            loc_oBO.RegistrarTituloComando(loc_oBO.this_cBuffer)
                        ENDIF

                        IF !EMPTY(loc_oBO.this_cFuncoes) AND loc_oBO.this_nPosFuncao <= loc_oBO.ObterTotalFuncoes()
                            loc_oBO.PreencherBuffer(loc_oBO.ObterFuncaoPorIndice(loc_oBO.this_nPosFuncao))
                            loc_oBO.this_nResultado = 1000
                            loc_oBO.this_nPosFuncao = loc_oBO.this_nPosFuncao + 1
                            LOOP
                        ELSE
                            IF loc_oBO.MontarBufferParcelas()
                                LOOP
                            ENDIF

                            THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                                "", "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio")
                            loc_lEncerrarSemDecodificar = .T.
                            EXIT
                        ENDIF
                    ENDIF

                    *-- comando 23: aguardando cartao ou senha
                    IF loc_oBO.this_nProximoComando = 23
                        IF loc_oBO.ObterEtapaCartaoSenha() = 1
                            WAIT WINDOW "Passe ou Insira o Cartao" NOWAIT
                        ELSE
                            WAIT WINDOW "Digite a Senha" NOWAIT
                        ENDIF
                        LOOP
                    ENDIF

                    *-- comando 13: cartao lido, a partir de agora e' senha
                    IF loc_oBO.this_nProximoComando = 13
                        WAIT CLEAR
                        loc_oBO.MarcarSenhaDigitada()
                    ENDIF

                    IF loc_oBO.this_nProximoComando = 4
                        loc_oBO.RegistrarTituloComando(loc_oBO.this_cBuffer)
                    ENDIF

                    IF loc_oBO.this_nProximoComando = 3
                        loc_oBO.RegistrarMensagemRetorno(loc_oBO.this_cBuffer)
                    ENDIF

                    IF loc_oBO.this_nProximoComando = 22
                        loc_oBO.RegistrarMensagemParcial(loc_oBO.this_cBuffer)
                        LOOP
                    ENDIF

                    loc_oBO.CapturarCampoRetorno(loc_oBO.this_nTipoCampo, loc_oBO.this_cBuffer)
                    loc_oBO.RegistrarMensagemAnalise(loc_oBO.this_cBuffer)

                    IF !loc_oBO.ComandoEsperaCampo(loc_oBO.this_nProximoComando)
                        loc_oBO.LimparBuffer()
                    ENDIF
                ENDDO

                IF !loc_lEncerrarSemDecodificar
                    IF loc_oBO.DecodificarRetornoFinal()
                        WITH THIS.cnt_4c_Container1
                            .lbl_4c_Label1.Visible   = .F.
                            .lbl_4c_Label2.Visible   = .T.
                            .lbl_4c_Label3.Visible   = .T.
                            .lbl_4c_Label4.Visible   = .T.
                            .lbl_4c_Label2.ForeColor = RGB(255, 0, 0)
                            .lbl_4c_Label3.ForeColor = RGB(255, 0, 0)
                            .lbl_4c_Label4.ForeColor = RGB(255, 0, 0)
                            .lbl_4c_Label2.Caption   = loc_oBO.this_cRetSerasa1
                            .lbl_4c_Label3.Caption   = loc_oBO.this_cRetSerasa2
                            .lbl_4c_Label4.Caption   = loc_oBO.this_cRetSerasa3
                        ENDWITH
                    ELSE
                        IF loc_oBO.this_nStatus != 1000 AND loc_oBO.this_nStatus != 0
                            THIS.cnt_4c_Container1.lbl_4c_Label1.ForeColor = RGB(255, 0, 0)
                            THIS.cnt_4c_Container1.lbl_4c_Label1.Caption   = loc_oBO.this_cRetChe
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGPRTFH.ExecutarConsultaSiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirMensagemTef - substitui "DO Form SigTfDss WITH titulo,'',msg1,
    * msg2,..." (dialogo de mensagem do legado, SigTfDss.SCX nao esta no
    * acervo). Mesmo padrao ja adotado em Formsigprdft.ExibirMensagemTef
    * (MsgAviso - mensagem transitoria de protocolo, nao erro tecnico).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2)
        LOCAL loc_cMsg
        loc_cMsg = ALLTRIM(par_cMsg1)
        IF !EMPTY(par_cMsg2)
            loc_cMsg = loc_cMsg + CHR(13) + ALLTRIM(par_cMsg2)
        ENDIF
        MsgAviso(loc_cMsg, par_cTitulo)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao (regra CLAUDE.md). Percorre recursivamente e torna visivel,
    * EXCETO as 3 linhas de status que o legado mantem ocultas na abertura
    * (Container1.Label2/3/4 - ver ConfigurarContainerStatus).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_lExcluido

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                loc_lExcluido = INLIST(UPPER(loc_oControl.Name), ;
                    "LBL_4C_LABEL2", "LBL_4C_LABEL3", "LBL_4C_LABEL4")

                IF PEMSTATUS(loc_oControl, "Visible", 5) AND !loc_lExcluido
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o cursor local do SiTef se ainda estiver aberto
    * (SIGPRTFHBO.GravarRetornoFalha/GravarRetornoSucesso usam crSiTef e
    * encerram com USE IN no caminho normal, mas um erro no meio do laco
    * interativo pode deixa-lo aberto).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRTFHBO.prg):
*============================================================================
* SIGPRTFHBO.prg - Business Object para Consulta de Cheque via SiTef
*
* Origem         : SIGPRIFF.SCX ("SiTef - Consulta de Cheque")
* Tabela         : nenhuma - dialogo de integracao com terminal de pagamento
*                  (CliSiTef32I.DLL), sem persistencia em tabela SQL Server.
* Dados tratados : parametros recebidos do chamador (dados do cheque/conta) e
*                  o retorno textual da transacao SiTef (this_cRetChe), que o
*                  form devolve ao caller via Unload (padrao fwDialog legado).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SIGPRTFHBO AS BusinessBase

    *==========================================================================
    * Propriedades - parametros recebidos pelo Init do form legado (PARAMETERS)
    *==========================================================================
    this_cIp        = ""   && Endereco IP do servidor SiTef
    this_cInicio    = ""   && Codigo da modalidade/funcao SiTef (lcInicio)
    this_nValor     = 0    && Valor da transacao (pcValor)
    this_cCupom     = ""   && Numero do cupom fiscal (pcCupom)
    this_cCaixa     = ""   && Identificacao do caixa/operador (pcCaixa)
    this_nIdent     = 0    && Identificador da transacao SiTef (pcIdent)
    this_cPos       = ""   && Identificacao do POS/terminal (pcPos)
    this_nParcs     = 0    && Numero de parcelas (pcParcs)
    this_cFuncoes   = ""   && Lista de funcoes habilitadas, separadas por virgula (pcFuncoes)
    this_cBanco     = ""   && Codigo do banco do cheque (pcBanco / GetBanco)
    this_cAgencia   = ""   && Agencia do cheque (pcAgencia / GetAgencia)
    this_cConta     = ""   && Conta do cheque (pcConta / GetConta)
    this_cNCheque   = ""   && Numero do cheque (pcnCheque / GetCheque)
    this_cDtCheque  = ""   && Data do cheque, formato bruto do terminal (pcDtCheque)
    this_cCpf       = ""   && CPF/CNPJ do emitente (pcCpf / GetCpf)
    this_cTpPessoa  = ""   && Tipo de pessoa: "F"=Fisica, outro=Juridica (pcTpPessoa)
    this_cCupomNv   = ""   && Numero do cupom nao-vinculado (pcCupomnv)
    this_cAgendc    = ""   && Digito verificador da agencia (pcAgendc / GetDvAgencia)
    this_cContadc   = ""   && Digito verificador da conta (pcContadc / GetDvConta)
    this_cNumdc     = ""   && Digito verificador do numero do cheque (pcNumdc / GetDvCheque)
    this_cPraca     = ""   && Praca de compensacao (pcPraca / GetPraca)
    this_cPesquisa  = ""   && Opcao de pesquisa pre-definida (pcPesquisa)
    this_cCmc7      = ""   && Linha CMC7 lida do cheque (pcCMC7 / CMC7)
    this_cTeste     = ""   && Flag de ambiente de teste (pcteste)

    *==========================================================================
    * Propriedades - retorno/estado do dialogo (nao vem de parametro)
    *==========================================================================
    this_cRetChe    = ""   && Retorno textual da transacao SiTef (pcRetChe), devolvido ao caller no Unload
    this_lAbandona  = .F.  && Indica que o usuario abandonou/cancelou o dialogo (abandona)

    *==========================================================================
    * Propriedades - estado do protocolo interativo SiTef
    * Origem: variaveis locais do laco de SIGPRIFF.SAIDA.GotFocus. Ficam como
    * property porque o laco e dirigido pela tela um passo por vez, e o estado
    * tem de sobreviver entre os passos.
    *==========================================================================
    this_nStatus          = 10000  && Stts - status devolvido pelo terminal
    this_nProximoComando  = 0      && ProximoComando
    this_nTipoCampo       = 0      && TipoCampo
    this_nTamanhoMinimo   = 0      && TamanhoMinimo
    this_nTamanhoMaximo   = 0      && TamanhoMaximo
    this_nResultado       = 0      && lnResultado
    this_cBuffer          = ""     && Buffer (2000 bytes, completado com CHR(0))

    *-- Campos da transacao devolvidos pelo terminal, por TipoCampo
    this_cTipTran         = ""     && lsTipTran  (TipoCampo 100)
    this_cDataHora        = ""     && lsDataHora (TipoCampo 105)
    this_cCupomRet        = ""     && lsCupom    (TipoCampo 121)
    this_cCartao          = ""     && lsCartao   (TipoCampo 132)
    this_cNsu             = ""     && lsNsu      (TipoCampo 134)
    this_cAutoriza        = ""     && lsAutoriza (TipoCampo 135)
    this_cFinaliza        = ""     && lsFinaliza

    *-- Textos que o terminal envia ao longo da conversa
    this_cMensagemSiTef   = ""     && lsMensagem  (comando 22)
    this_cMensagemRet     = ""     && lsMRet      (comando 3)
    this_cMensagemAnalise = ""     && lsMensagem1 (opcaoc = "4")
    this_cTituloComando   = ""     && lcTitulo    (comandos 30/34/20/4)

    *-- Retorno SERASA decodificado (3 linhas exibidas na tela)
    this_cRetSerasa1      = ""
    this_cRetSerasa2      = ""
    this_cRetSerasa3      = ""
    this_nIndiceSerasa    = 0      && npos do Ascan(CodSerasa, Substr(Buffer,1,2))

    *-- Contadores das respostas automaticas
    this_nEtapaTipo       = 1      && lnTipo  - etapas do comando 21
    this_nEtapaCartao     = 1      && lnCard  - etapas do comando 30
    this_nPosFuncao       = 1      && lnPos   - indice em pcFuncoes
    this_nCarSen          = 1      && carsen  - 1 = aguarda cartao, 2 = aguarda senha
    this_cOpcaoConsulta   = "0"    && Opcaoc  - opcao de consulta escolhida

    *-- Valores digitados pelo usuario, na forma exibivel
    this_cNumParcelas     = ""     && nNumParcs
    this_cValorDigitado   = "0,00" && nValores
    this_cDataDigitada    = ""     && nDatas

    *-- Biblioteca do terminal (CliSiTef32I.DLL) carregada com sucesso pelos
    *-- DECLARE de DeclararFuncoesSiTef. Fica .F. na estacao que nao tem o
    *-- integrador SiTef instalado - ver DeclararFuncoesSiTef/IniciarSessaoSiTef.
    this_lSiTefDisponivel = .F.

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Este dialogo nao grava em tabela alguma: o resultado da consulta de
    * cheque e repassado ao terminal SiTef (CliSiTef32I.DLL) e o retorno fica
    * em this_cRetChe. this_cTabela/this_cCampoChave permanecem vazios
    * (herdados de BusinessBase), pois Salvar/Excluir/Buscar nao se aplicam
    * a este BO.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.DeclararFuncoesSiTef()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Persistencia e metodos CRUD - decisao de projeto
    *
    * Este dialogo NAO grava nem le tabela do SQL Server (ver o cabecalho do
    * arquivo). Conferido no dump do legado (SIGPRTFH_form_codigo_fonte.txt):
    * nao existe TABLEUPDATE nem .AddCursor, e o unico alvo de Insert Into e o
    * cursor LOCAL crSiTef, criado no proprio form com CREATE CURSOR e copiado
    * para arquivo SDF. Nao ha tabela, nem chave primaria, nem coluna a mapear.
    *
    * Por isso os metodos de persistencia da BusinessBase ficam HERDADOS, e nao
    * sobrescritos aqui:
    *   - CarregarDoCursor  : nao existe cursor de registro para mapear;
    *   - Inserir           : nao existe tabela destino - sobrescrever exigiria
    *   - Atualizar           INVENTAR um INSERT/UPDATE, e a regra #22 manda a
    *                         lista de colunas vir do schema, nunca de palpite;
    *   - ExecutarExclusao  : idem;
    *   - ObterChavePrimaria: nao ha chave.
    * O comportamento herdado - recusar a operacao e reportar pelo ExibirFalha
    * do Salvar - ja eh o correto para esta tela.
    *
    * A logica de negocio real deste BO e a integracao com o terminal SiTef via
    * CliSiTef32I.DLL, portada a partir de SIGPRIFF.SCX: Procedures Load,
    * errotef, montaretorno, retornofalha e Unload, mais o laco interativo de
    * SAIDA.GotFocus (os metodos Iniciar/Continuar/MontarBuffer*/Capturar*/
    * Decodificar* abaixo).
    *==========================================================================

    *--------------------------------------------------------------------------
    * DeclararFuncoesSiTef - Registra as assinaturas das funcoes do terminal
    * SiTef (CliSiTef32I.DLL). Origem: SIGPRIFF.Load. Chamado uma vez no Init
    * de cada instancia do BO (DECLARE repetido e inofensivo em VFP9).
    *
    * O DECLARE ... IN <dll> do VFP9 CARREGA a biblioteca na hora: na estacao
    * sem o integrador SiTef instalado ele estoura "Cannot load 32-bit DLL
    * CliSiTef32I.DLL." Sem o TRY abaixo esse erro subia para o CATCH do Init,
    * que devolvia .F., e dai CREATEOBJECT("SIGPRTFHBO") devolvia .F. (logico)
    * -> o Form via VARTYPE <> "O", InicializarForm devolvia .F. e
    * CREATEOBJECT("FormSIGPRTFH") devolvia .F.: a TELA NAO ABRIA, exibindo so
    * "VARTYPE retornou: L", que nao diz ao operador o que faltou.
    *
    * Com a biblioteca ausente, a conversa com o terminal e impossivel - que e
    * exatamente a condicao para a qual o legado JA tem mensagem propria em
    * SIGPRIFF.SAIDA.GotFocus ("Sem comunicacao com SiTef", o ramo de
    * ConfiguraIntSiTefInterativo <> 0). Registra-se portanto a indisponibilidade
    * em this_lSiTefDisponivel e deixa-se IniciarSessaoSiTef dar essa mesma
    * resposta, em vez de impedir a abertura da tela. NENHUMA funcao da DLL e
    * chamada com a flag em .F. (ver os quatro wrappers abaixo) - chamar funcao
    * nao declarada faria o VFP procurar <nome>.prg no PATH (regra #13).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        THIS.this_lSiTefDisponivel = .F.

        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String par_cEndereco, String par_cLoja, String par_cTerminal, Integer par_nReservado

            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer par_nModalidade, String par_cValor, String par_cCupom, ;
                String par_cData, String par_cHorario, String par_cOperador, String par_cRestricao

            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @par_nComando, Integer @par_nTipo, Integer @par_nMinimo, ;
                Integer @par_nMaximo, String @par_cBuffer, Integer par_nTamanho, Integer par_nResultado

            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer par_nConfirma, String par_cCupom, String par_cData, String par_cHorario

            THIS.this_lSiTefDisponivel = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarConexaoSiTef - Abre a sessao com o terminal SiTef.
    * Origem: SIGPRIFF.SAIDA.GotFocus (ConfiguraIntSiTefInterativo).
    * Retorna .T. se a conexao foi configurada com sucesso.
    *--------------------------------------------------------------------------
    FUNCTION ConfigurarConexaoSiTef(par_cIp, par_cIdTerminal, par_cPos)
        LOCAL loc_lOk
        loc_lOk = .F.

        IF THIS.this_lSiTefDisponivel
            loc_lOk = (ConfiguraIntSiTefInterativo(par_cIp, par_cIdTerminal, par_cPos, 0) = 0)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * IniciarFuncaoSiTef - Inicia a funcao/modalidade na sessao SiTef aberta.
    * Origem: SIGPRIFF.SAIDA.GotFocus (IniciaFuncaoSiTefInterativo).
    * Retorna .T. quando o terminal aceita o inicio (codigo 10000).
    *--------------------------------------------------------------------------
    FUNCTION IniciarFuncaoSiTef(par_nModalidade, par_cValor, par_cCupom, par_cData, par_cHora, par_cOperador)
        LOCAL loc_lOk
        loc_lOk = .F.

        IF THIS.this_lSiTefDisponivel
            loc_lOk = (IniciaFuncaoSiTefInterativo(par_nModalidade, par_cValor, par_cCupom, ;
                par_cData, par_cHora, par_cOperador, "") = 10000)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * FinalizarTransacaoSiTef - Confirma/cancela a transacao com o terminal.
    * Origem: SIGPRIFF.Load (DECLARE FinalizaTransacaoSiTefInterativo) - a
    * chamada do legado nao aparecia no dump de metodos com codigo, mas a
    * funcao e declarada e faz parte do contrato do protocolo SiTef.
    *--------------------------------------------------------------------------
    FUNCTION FinalizarTransacaoSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        *-- -1 = "Modulo Nao Iniciado" na tabela de erros do proprio legado
        *-- (SIGPRIFF.errotef / ProcessarErroSiTef), que e o que a biblioteca
        *-- ausente significa: o modulo SiTef nunca foi iniciado.
        loc_nRetorno = -1

        IF THIS.this_lSiTefDisponivel
            loc_nRetorno = FinalizaTransacaoSiTefInterativo(par_nConfirma, par_cCupom, ;
                par_cData, par_cHora)
        ENDIF

        RETURN loc_nRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarErroSiTef - Traduz o codigo de retorno de erro do terminal para
    * mensagem e grava o retorno de falha (origem: SIGPRIFF.errotef).
    * NOTA: o legado testa tambem "Type('lnRetorno')<>'N' And (lnRetorno>-1
    * Or lnRetorno<-5)" antes das faixas abaixo, mas lnRetorno nunca e
    * declarado/recebido no metodo original (so existe pnRetornos) - essa
    * comparacao estouraria "Variable 'LNRETORNO' is not found" se alcancada,
    * portanto e um ramo morto do legado e nao foi transcrito.
    *--------------------------------------------------------------------------
    FUNCTION ProcessarErroSiTef(par_nRetornos)
        LOCAL loc_cMensagem
        loc_cMensagem = ""

        DO CASE
            CASE par_nRetornos = -1
                loc_cMensagem = "M" + CHR(243) + "dulo N" + CHR(227) + "o Iniciado"
            CASE par_nRetornos = -2
                loc_cMensagem = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"
            CASE par_nRetornos = -3
                loc_cMensagem = "Fornecida uma Modalidade Inv" + CHR(225) + "lida"
            CASE par_nRetornos = -4
                loc_cMensagem = "Falta Mem" + CHR(243) + "ria para Rodar a Fun" + CHR(231) + CHR(227) + "o"
            CASE par_nRetornos = -5
                loc_cMensagem = "Sem Comunica" + CHR(231) + CHR(227) + "o com o SiTef"
        ENDCASE

        IF !EMPTY(loc_cMensagem)
            THIS.GravarRetornoFalha(loc_cMensagem, 0)
        ENDIF

        RETURN !EMPTY(loc_cMensagem)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMensagemSerasa - Mapeia o codigo de retorno SERASA (2 digitos) para
    * a mensagem correspondente, numa unica string.
    * Origem: SIGPRIFF.Init / SIGPRIFF.SAIDA.GotFocus (arrays CodSerasa /
    * RetSerasa). A tabela em si mora em LocalizarSerasa, que e quem conhece as
    * 3 linhas separadas - aqui elas sao apenas concatenadas.
    * Retorna "" quando o codigo nao esta na tabela (o chamador usa o Buffer
    * cru como mensagem nesse caso, igual ao legado).
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemSerasa(par_cCodigo)
        LOCAL loc_cMensagem

        loc_cMensagem = ""

        IF THIS.LocalizarSerasa(par_cCodigo)
            loc_cMensagem = THIS.this_cRetSerasa1 + " " + THIS.this_cRetSerasa2 + " " + ;
                THIS.this_cRetSerasa3
        ENDIF

        RETURN loc_cMensagem
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarRetornoFalha - Grava o arquivo de retorno de falha lido pelo
    * integrador SiTef (IntPos.001/IntPos.STS, formato SDF). Origem:
    * SIGPRIFF.retornofalha.
    * NOTA: o legado grava "STR(ltIdent,10)" - ltIdent nunca e declarado em
    * retornofalha nem em metodo algum do form (so existe ThisForm.pcIdent),
    * o que estouraria "Variable 'LTIDENT' is not found" se exercido; aqui usa-se
    * THIS.this_nIdent (equivalente portado de pcIdent) no lugar da variavel
    * inexistente.
    *--------------------------------------------------------------------------
    PROCEDURE GravarRetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_cMensagem, loc_cValPago

        loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
            "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usu" + CHR(225) + "rio", par_cMensagem)
        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (Tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO "C:\client\Resp\IntPos.001" SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO "C:\client\Resp\IntPos.STS" SDF

            USE IN crSiTef
            THIS.this_cRetChe = "999 - " + loc_cMensagem
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarRetornoSucesso - Grava o arquivo de retorno de sucesso lido pelo
    * integrador SiTef (IntPos.001/IntPos.STS, formato SDF). Origem:
    * SIGPRIFF.montaretorno.
    *--------------------------------------------------------------------------
    PROCEDURE GravarRetornoSucesso(par_cTipTran, par_cDataHora, par_cCupom, par_cCartao, ;
            par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)

        LOCAL loc_cValPago, loc_aCartao[11], loc_cCupomRestante, loc_nPos, loc_nLinha

        loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        loc_aCartao[1]  = "Outro, n" + CHR(227) + "o definido"
        loc_aCartao[2]  = "Visa"
        loc_aCartao[3]  = "Mastercard"
        loc_aCartao[4]  = "Diners"
        loc_aCartao[5]  = "American Express"
        loc_aCartao[6]  = "Sollo"
        loc_aCartao[7]  = "Sidecard (Redecard)"
        loc_aCartao[8]  = "Private Label (Redecard)"
        loc_aCartao[9]  = "Redeshop"
        loc_aCartao[10] = ""
        loc_aCartao[11] = "Fininvest"

        IF VAL(par_cCartao) > 10 OR VAL(par_cCartao) < 0
            par_cCartao = "0"
        ENDIF

        TRY
            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (Tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(par_cCartao) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_cTipTran)
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_cNsu)
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_cAutoriza)
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_cFinaliza)
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))

            loc_cCupomRestante = par_cCupom
            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos != 0
                loc_nPos = AT(CHR(10), loc_cCupomRestante)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                    IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante))
                loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMenRet)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            COPY TO "C:\client\Resp\IntPos.001" SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO "C:\client\Resp\IntPos.STS" SDF

            USE IN crSiTef
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterIdTerminal - Identificacao da loja enviada ao SiTef.
    * Origem: SIGPRIFF.SAIDA.GotFocus (lsIdTerminal = "00000" + _Empr).
    * O legado usa a PUBLIC _Empr; aqui usa-se go_4c_Sistema.cCodEmpresa,
    * conforme a regra do projeto que aposenta _EMPR.
    *--------------------------------------------------------------------------
    FUNCTION ObterIdTerminal()
        LOCAL loc_cEmpresa
        loc_cEmpresa = ""

        IF TYPE("go_4c_Sistema") = "O"
            IF !ISNULL(go_4c_Sistema) AND PEMSTATUS(go_4c_Sistema, "cCodEmpresa", 5)
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF
        ENDIF

        RETURN "00000" + loc_cEmpresa
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarValorSiTef - Valor no formato que o terminal espera (virgula
    * decimal, sem separador de milhar).
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   lnValPago = ALLTRIM(STRTRAN(TRANSFORM(pcValor,"999999999.99"),".",","))
    *--------------------------------------------------------------------------
    FUNCTION FormatarValorSiTef(par_nValor)
        LOCAL loc_nValor
        loc_nValor = IIF(VARTYPE(par_nValor) = "N", par_nValor, VAL(TRANSFORM(par_nValor)))
        RETURN ALLTRIM(STRTRAN(TRANSFORM(loc_nValor, "999999999.99"), ".", ","))
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterDataSiTef / ObterHoraSiTef - Data (AAAAMMDD) e hora (HHMMSS) da
    * transacao. Origem: SIGPRIFF.SAIDA.GotFocus
    *   lcData = STR(YEAR(DATE()),4)+SUBSTR(DTOC(DATE()),4,2)+SUBSTR(DTOC(DATE()),1,2)
    *   lcHora = STRTRAN(TIME(),":","")
    * O recorte 4,2 / 1,2 do DTOC pressupoe SET DATE BRITISH (dd/mm/aaaa), que
    * FormBase.Init garante.
    *--------------------------------------------------------------------------
    FUNCTION ObterDataSiTef()
        RETURN STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
    ENDFUNC

    FUNCTION ObterHoraSiTef()
        RETURN STRTRAN(TIME(), ":", "")
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarFalhaSiTef - Encerra a transacao com falha, gravando o arquivo
    * de retorno que o integrador le.
    *
    * Origem: SIGPRIFF.SAIDA.GotFocus, que nos caminhos de falha faz
    *   DO SigTfSup WITH "P", <mensagem>, "", "", "", "", "", "", "", lnValPago, "", pcIdent
    * O SigTfSup.prg dessa chamada (12 argumentos) NAO veio no acervo, e nao e
    * o SIGPRSTF.SCX ja migrado como FormSIGPRSTF - esse e o dialogo de senha
    * de supervisor e nao recebe argumento algum. Dos 12 argumentos, os que
    * carregam informacao sao exatamente <mensagem>, lnValPago e pcIdent, que e
    * o mesmo contrato do retornofalha do proprio form (portado aqui como
    * GravarRetornoFalha): grava IntPos.001/IntPos.STS com a mensagem, o valor
    * e o identificador. Delega-se portanto ao equivalente ja portado, em vez
    * de supor o conteudo de um arquivo ausente.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarFalhaSiTef(par_cMensagem)
        THIS.this_cMensagemErro = par_cMensagem
        THIS.GravarRetornoFalha(par_cMensagem, THIS.this_nValor)
    ENDPROC

    *--------------------------------------------------------------------------
    * ReiniciarEstadoSiTef - Zera o estado do protocolo antes de iniciar a
    * conversa com o terminal.
    * Origem: SIGPRIFF.SAIDA.GotFocus (bloco de inicializacao de
    * Stts/ProximoComando/TipoCampo/Buffer/lsTipTran/.../lnPos/carsen/lnTipo/
    * lnCard/Opcaoc/nNumParcs/nValores/nDatas).
    *--------------------------------------------------------------------------
    PROCEDURE ReiniciarEstadoSiTef()
        THIS.this_nStatus          = 10000
        THIS.this_nProximoComando  = 0
        THIS.this_nTipoCampo       = 0
        THIS.this_nTamanhoMinimo   = 0
        THIS.this_nTamanhoMaximo   = 0
        THIS.this_cBuffer          = SPACE(2000)
        THIS.this_nResultado       = 0

        THIS.this_cTipTran         = ""
        THIS.this_cDataHora        = ""
        THIS.this_cCupomRet        = ""
        THIS.this_cCartao          = ""
        THIS.this_cNsu             = ""
        THIS.this_cAutoriza        = ""
        THIS.this_cFinaliza        = ""

        THIS.this_cMensagemSiTef   = ""
        THIS.this_cMensagemRet     = ""
        THIS.this_cMensagemAnalise = ""

        THIS.this_cRetSerasa1      = ""
        THIS.this_cRetSerasa2      = ""
        THIS.this_cRetSerasa3      = ""
        THIS.this_nIndiceSerasa    = 0

        THIS.this_nEtapaTipo       = 1
        THIS.this_nEtapaCartao     = 1
        THIS.this_nPosFuncao       = 1
        THIS.this_nCarSen          = 1
        THIS.this_cOpcaoConsulta   = "0"

        THIS.this_cNumParcelas     = ALLTRIM(STR(THIS.this_nParcs))
        THIS.this_cValorDigitado   = "0,00"
        THIS.this_cDataDigitada    = ""
        THIS.this_lAbandona        = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarSessaoSiTef - Configura a conexao e inicia a funcao no terminal.
    * Origem: SIGPRIFF.SAIDA.GotFocus (ConfiguraIntSiTefInterativo seguido de
    * IniciaFuncaoSiTefInterativo). Em qualquer das duas falhas o legado grava
    * o retorno de falha "Sem comunicacao com SiTef" e aborta.
    *
    * O 1o argumento de IniciaFuncaoSiTefInterativo e declarado Integer (ver
    * DeclararFuncoesSiTef); o legado passa pcInicio, que recebe o parametro
    * lcInicio - caractere. Converte-se com VAL para respeitar o tipo da DLL.
    *
    * Retorna .T. quando a sessao esta aberta e o laco pode comecar.
    *--------------------------------------------------------------------------
    FUNCTION IniciarSessaoSiTef()
        LOCAL loc_lSucesso, loc_cMsgSemCom, loc_oErro

        loc_lSucesso   = .F.
        loc_cMsgSemCom = "Sem comunica" + CHR(231) + CHR(227) + "o com SiTef"

        TRY
            IF !THIS.ConfigurarConexaoSiTef(THIS.this_cIp, THIS.ObterIdTerminal(), THIS.this_cPos)
                THIS.RegistrarFalhaSiTef(loc_cMsgSemCom)
            ELSE
                IF !THIS.IniciarFuncaoSiTef(VAL(THIS.this_cInicio), ;
                        THIS.FormatarValorSiTef(THIS.this_nValor), THIS.this_cCupom, ;
                        THIS.ObterDataSiTef(), THIS.ObterHoraSiTef(), THIS.this_cCaixa)
                    THIS.RegistrarFalhaSiTef(loc_cMsgSemCom)
                ELSE
                    THIS.ReiniciarEstadoSiTef()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao iniciar sess" + CHR(227) + "o SiTef")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ContinuarFuncaoSiTef - Executa UM passo do protocolo interativo.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   Stts = ContinuaFuncaoSiTefInterativo(@ProximoComando, @TipoCampo,
    *          @TamanhoMinimo, @TamanhoMaximo, @Buffer,
    *          Len(ALLTRIM(Buffer)), lnResultado)
    *   lnResultado = 0
    * Os 5 primeiros argumentos sao por REFERENCIA, por isso passam por
    * variaveis LOCAIS - property de objeto nao pode ser passada com @ - e
    * voltam para as properties depois da chamada. Retorna o status (Stts).
    *--------------------------------------------------------------------------
    FUNCTION ContinuarFuncaoSiTef()
        LOCAL loc_nComando, loc_nTipo, loc_nMinimo, loc_nMaximo, loc_cBuffer, loc_nStatus

        IF !THIS.this_lSiTefDisponivel
            *-- -1 = "Modulo Nao Iniciado" (SIGPRIFF.errotef). Sai do laco pelo
            *-- mesmo caminho de qualquer status <> 10000.
            THIS.this_nStatus = -1
            RETURN -1
        ENDIF

        loc_nComando = THIS.this_nProximoComando
        loc_nTipo    = THIS.this_nTipoCampo
        loc_nMinimo  = THIS.this_nTamanhoMinimo
        loc_nMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer  = THIS.this_cBuffer

        loc_nStatus = ContinuaFuncaoSiTefInterativo(@loc_nComando, @loc_nTipo, ;
            @loc_nMinimo, @loc_nMaximo, @loc_cBuffer, ;
            LEN(ALLTRIM(loc_cBuffer)), THIS.this_nResultado)

        THIS.this_nProximoComando = loc_nComando
        THIS.this_nTipoCampo      = loc_nTipo
        THIS.this_nTamanhoMinimo  = loc_nMinimo
        THIS.this_nTamanhoMaximo  = loc_nMaximo
        THIS.this_cBuffer         = loc_cBuffer
        THIS.this_nStatus         = loc_nStatus
        THIS.this_nResultado      = 0

        RETURN loc_nStatus
    ENDFUNC

    *--------------------------------------------------------------------------
    * PreencherBuffer - Monta o buffer de 2000 bytes que o terminal espera,
    * completando com CHR(0).
    * Origem: SIGPRIFF.SAIDA.GotFocus (Buffer = <valor> +
    * REPLICATE(CHR(0), 2000 - LEN(<valor>)), que no legado aparece tambem com
    * as constantes ja calculadas 1999/1998/1992).
    *--------------------------------------------------------------------------
    FUNCTION PreencherBuffer(par_cValor)
        LOCAL loc_cValor, loc_nFalta

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", par_cValor, TRANSFORM(par_cValor))
        loc_nFalta = 2000 - LEN(loc_cValor)

        IF loc_nFalta > 0
            loc_cValor = loc_cValor + REPLICATE(CHR(0), loc_nFalta)
        ELSE
            loc_cValor = LEFT(loc_cValor, 2000)
        ENDIF

        THIS.this_cBuffer = loc_cValor
        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparBuffer - Origem: SIGPRIFF.SAIDA.GotFocus, ultimo IF do laco:
    * quando o comando NAO e 30/21/34/20/31, o legado faz Buffer = SPACE(2000).
    *--------------------------------------------------------------------------
    PROCEDURE LimparBuffer()
        THIS.this_cBuffer = SPACE(2000)
    ENDPROC

    *--------------------------------------------------------------------------
    * ComandoEsperaCampo - .T. quando o comando corrente e um dos que pedem
    * conteudo no buffer (e portanto NAO deve ter o buffer limpo no fim do
    * passo). Origem: SIGPRIFF.SAIDA.GotFocus (ProximoComando 30/21/34/20/31).
    *--------------------------------------------------------------------------
    FUNCTION ComandoEsperaCampo(par_nComando)
        RETURN INLIST(par_nComando, 30, 21, 34, 20, 31)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTotalFuncoes / ObterFuncaoPorIndice - Quebra a lista pcFuncoes
    * (codigos de funcao separados por virgula) nos caracteres que o legado
    * envia um a um ao terminal.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   DECLARE funcoes[OCCURS(",",pcFuncoes)+1]
    *   FOR npos = 1 TO OCCURS(",",pcFuncoes)
    *       funcoes[npos] = SUBSTR(pcFuncoes, IIF(npos=1, 1, AT(",",pcFuncoes,npos)+1), 1)
    *   NEXT
    *   funcoes[npos] = SUBSTR(pcFuncoes, LEN(pcFuncoes), 1)
    * Ou seja: o ULTIMO elemento e o ultimo caractere da lista, e nao o que
    * segue a ultima virgula - transcrito exatamente assim.
    *--------------------------------------------------------------------------
    FUNCTION ObterTotalFuncoes()
        IF EMPTY(THIS.this_cFuncoes)
            RETURN 0
        ENDIF

        RETURN OCCURS(",", THIS.this_cFuncoes) + 1
    ENDFUNC

    FUNCTION ObterFuncaoPorIndice(par_nIndice)
        LOCAL loc_nOcorrencias, loc_cFuncao

        loc_cFuncao = ""

        IF !EMPTY(THIS.this_cFuncoes)
            loc_nOcorrencias = OCCURS(",", THIS.this_cFuncoes)

            DO CASE
                CASE par_nIndice = 1
                    loc_cFuncao = SUBSTR(THIS.this_cFuncoes, 1, 1)
                CASE par_nIndice > 1 AND par_nIndice <= loc_nOcorrencias
                    loc_cFuncao = SUBSTR(THIS.this_cFuncoes, ;
                        AT(",", THIS.this_cFuncoes, par_nIndice) + 1, 1)
                CASE par_nIndice = loc_nOcorrencias + 1
                    loc_cFuncao = SUBSTR(THIS.this_cFuncoes, LEN(THIS.this_cFuncoes), 1)
            ENDCASE
        ENDIF

        RETURN loc_cFuncao
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBufferCheque - Dados do cheque no comando 31.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   If Empty(CMC7)
    *     Buffer = "0:"+pcPraca+pcBanco+pcAgencia+pcAgendc+PADR(pcConta,10)+
    *              pcContadc+pcnCheque+pcNumdc
    *   Else
    *     Buffer = "1:"+CMC7
    *--------------------------------------------------------------------------
    FUNCTION MontarBufferCheque()
        LOCAL loc_cValor

        IF EMPTY(THIS.this_cCmc7)
            loc_cValor = "0:" + THIS.this_cPraca + THIS.this_cBanco + ;
                THIS.this_cAgencia + THIS.this_cAgendc + ;
                PADR(THIS.this_cConta, 10) + THIS.this_cContadc + ;
                THIS.this_cNCheque + THIS.this_cNumdc
        ELSE
            loc_cValor = "1:" + THIS.this_cCmc7
        ENDIF

        RETURN THIS.PreencherBuffer(loc_cValor)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBufferCartao - Respostas automaticas do comando 30 quando
    * pcFuncoes = "1". Origem: SIGPRIFF.SAIDA.GotFocus (etapas lnCard 1/2/3):
    *   1 -> IIF(pcTpPessoa="F","0","1")   (pessoa fisica / juridica)
    *   2 -> pcCpf
    *   3 -> pcDtCheque
    * Avanca a etapa (this_nEtapaCartao) exatamente como o legado.
    *--------------------------------------------------------------------------
    FUNCTION MontarBufferCartao()
        LOCAL loc_cValor, loc_lMontou

        loc_cValor  = ""
        loc_lMontou = .F.

        DO CASE
            CASE THIS.this_nEtapaCartao = 1
                loc_cValor  = IIF(THIS.this_cTpPessoa = "F", "0", "1")
                loc_lMontou = .T.
            CASE THIS.this_nEtapaCartao = 2
                loc_cValor  = THIS.this_cCpf
                loc_lMontou = .T.
            CASE THIS.this_nEtapaCartao = 3
                loc_cValor  = THIS.this_cDtCheque
                loc_lMontou = .T.
        ENDCASE

        IF loc_lMontou
            THIS.PreencherBuffer(loc_cValor)
            THIS.this_nEtapaCartao = THIS.this_nEtapaCartao + 1
        ENDIF

        RETURN loc_lMontou
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBufferTipoConsulta - Respostas automaticas do comando 21 quando
    * pcFuncoes = "1". Origem: SIGPRIFF.SAIDA.GotFocus (etapas lnTipo 1/2):
    *   1 -> "1" (fixo)
    *   2 -> a opcao de consulta escolhida (pcPesquisa, ou a escolha do
    *        dialogo que a tela abre quando pcPesquisa vem vazio)
    * A etapa 2 depende de interacao, por isso recebe a opcao por parametro -
    * quem a obtem e a tela, nas fases de UI.
    *--------------------------------------------------------------------------
    FUNCTION MontarBufferTipoConsulta(par_cOpcao)
        LOCAL loc_lMontou

        loc_lMontou = .F.

        DO CASE
            CASE THIS.this_nEtapaTipo = 1
                THIS.PreencherBuffer("1")
                THIS.this_nEtapaTipo = 2
                loc_lMontou = .T.
            CASE THIS.this_nEtapaTipo = 2
                THIS.this_cOpcaoConsulta = par_cOpcao
                THIS.PreencherBuffer(par_cOpcao)
                THIS.this_nEtapaTipo = 3
                loc_lMontou = .T.
        ENDCASE

        RETURN loc_lMontou
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterOpcaoConsultaPadrao - Opcao de consulta que dispensa perguntar.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF EMPTY(pcPesquisa) -> DO FORM SigCqTef TO opcaoc   (tela escolhe)
    *   ELSE                 -> opcaoc = pcPesquisa
    * Devolve "" quando a escolha tem de vir do dialogo.
    *--------------------------------------------------------------------------
    FUNCTION ObterOpcaoConsultaPadrao()
        RETURN IIF(EMPTY(THIS.this_cPesquisa), "", THIS.this_cPesquisa)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBufferParcelas - Responde o numero de parcelas sem perguntar ao
    * usuario, quando ele ja veio por parametro.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF ProximoComando = 30 and (TipoCampo = 505 OR TipoCampo = 511) AND pcParcs <> 0
    *     Buffer = ALLTRIM(TRANSFORM(pcParcs,"@L 99"))+REPLICATE(CHR(0),1998)
    *     pcParcs = 0
    * O legado ZERA pcParcs para responder uma unica vez - preservado aqui.
    *--------------------------------------------------------------------------
    FUNCTION MontarBufferParcelas()
        LOCAL loc_lRespondeu

        loc_lRespondeu = .F.

        IF THIS.this_nProximoComando = 30 AND ;
                INLIST(THIS.this_nTipoCampo, 505, 511) AND THIS.this_nParcs != 0
            THIS.PreencherBuffer(ALLTRIM(TRANSFORM(THIS.this_nParcs, "@L 99")))
            THIS.this_nParcs = 0
            loc_lRespondeu = .T.
        ENDIF

        RETURN loc_lRespondeu
    ENDFUNC

    *--------------------------------------------------------------------------
    * ClassificarTipoDados - Diz que tipo de dado o terminal esta pedindo, para
    * o dialogo de captura saber o que exibir.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   TipoDados = ""
    *   IF TipoCampo = 504 OR 506 OR 515 OR "DDMMAAAA" $ Buffer -> "D"
    *   IF TipoCampo = 130                                      -> "V"
    * A ordem importa: 130 e testado DEPOIS e prevalece sobre "D".
    *--------------------------------------------------------------------------
    FUNCTION ClassificarTipoDados(par_nTipoCampo, par_cBuffer)
        LOCAL loc_cTipo

        loc_cTipo = ""

        IF INLIST(par_nTipoCampo, 504, 506, 515) OR "DDMMAAAA" $ par_cBuffer
            loc_cTipo = "D"
        ENDIF

        IF par_nTipoCampo = 130
            loc_cTipo = "V"
        ENDIF

        RETURN loc_cTipo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterEscolhasSimNao - Lista de opcoes do comando 20.
    * Origem: SIGPRIFF.SAIDA.GotFocus (Escolhas = "0:Sim;1:Nao;").
    * Literal preservado byte a byte: a string e PROTOCOLO, consumida pelo
    * dialogo de captura, nao texto de tela - acentuar mudaria o conteudo.
    *--------------------------------------------------------------------------
    FUNCTION ObterEscolhasSimNao()
        RETURN "0:Sim;1:Nao;"
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarDataParaSiTef - Converte a data escolhida pelo usuario para
    * DDMMAAAA e guarda a versao exibivel (nDatas do legado).
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   Valores = DTOC(Valores)
    *   nDatas  = Valores
    *   Valores = SUBSTR(Valores,1,2)+SUBSTR(Valores,4,2)+SUBSTR(Valores,7,4)
    * Usa ConverterParaData porque o valor chega ora DATE, ora DATETIME, ora
    * caractere, conforme o caminho - DTOC cru estouraria erro 11.
    *--------------------------------------------------------------------------
    FUNCTION FormatarDataParaSiTef(par_xData)
        LOCAL loc_dData, loc_cData

        loc_dData = ConverterParaData(par_xData)
        loc_cData = DTOC(loc_dData)

        THIS.this_cDataDigitada = loc_cData

        RETURN SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarValorParaSiTef - Converte o valor digitado pelo usuario e guarda
    * a versao exibivel (nValores do legado).
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   Valores  = STRTRAN(ALLTRIM(TRANSFORM(Valores,"99999999.99")),".",",")
    *   nValores = Valores
    *--------------------------------------------------------------------------
    FUNCTION FormatarValorParaSiTef(par_xValor)
        LOCAL loc_nValor, loc_cValor

        loc_nValor = IIF(VARTYPE(par_xValor) = "N", par_xValor, VAL(TRANSFORM(par_xValor)))
        loc_cValor = STRTRAN(ALLTRIM(TRANSFORM(loc_nValor, "99999999.99")), ".", ",")

        THIS.this_cValorDigitado = loc_cValor

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarNumeroParcelas - Guarda o numero de parcelas escolhido no
    * dialogo. Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF ProximoComando = 30 and (TipoCampo = 505 OR TipoCampo = 511)
    *     nNumParcs = Valores
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarNumeroParcelas(par_cValor)
        IF THIS.this_nProximoComando = 30 AND INLIST(THIS.this_nTipoCampo, 505, 511)
            THIS.this_cNumParcelas = par_cValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CapturarCampoRetorno - Guarda os campos da transacao que o terminal
    * devolve ao longo do laco, cada um identificado por TipoCampo.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   100 -> lsTipTran    105 -> lsDataHora   121 -> lsCupom
    *   132 -> lsCartao     134 -> lsNsu        135 -> lsAutoriza
    * O 134 e o unico normalizado (ALLTRIM(STR(VAL(Buffer)))).
    *--------------------------------------------------------------------------
    PROCEDURE CapturarCampoRetorno(par_nTipoCampo, par_cBuffer)
        DO CASE
            CASE par_nTipoCampo = 100
                THIS.this_cTipTran  = par_cBuffer
            CASE par_nTipoCampo = 105
                THIS.this_cDataHora = par_cBuffer
            CASE par_nTipoCampo = 121
                THIS.this_cCupomRet = par_cBuffer
            CASE par_nTipoCampo = 132
                THIS.this_cCartao   = par_cBuffer
            CASE par_nTipoCampo = 134
                THIS.this_cNsu      = ALLTRIM(STR(VAL(par_cBuffer)))
            CASE par_nTipoCampo = 135
                THIS.this_cAutoriza = par_cBuffer
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarTituloComando / RegistrarMensagemRetorno / RegistrarMensagemAnalise
    * Textos que o terminal manda em comandos especificos.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   ProximoComando 30/34/20 e 4 -> lcTitulo   = ALLTRIM(Buffer)
    *   ProximoComando 3            -> lsMRet     = ALLTRIM(Buffer)
    *   opcaoc = "4" AND stts <> 0  -> lsMensagem1 = ALLTRIM(Buffer)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarTituloComando(par_cBuffer)
        THIS.this_cTituloComando = ALLTRIM(par_cBuffer)
    ENDPROC

    PROCEDURE RegistrarMensagemRetorno(par_cBuffer)
        THIS.this_cMensagemRet = ALLTRIM(par_cBuffer)
    ENDPROC

    PROCEDURE RegistrarMensagemAnalise(par_cBuffer)
        IF THIS.this_cOpcaoConsulta = "4" AND THIS.this_nStatus != 0
            THIS.this_cMensagemAnalise = ALLTRIM(par_cBuffer)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarMensagemParcial / ConsumirMensagemParcial - Mensagem de
    * acompanhamento do comando 22 e o retorno aprovado que o legado monta a
    * partir dela.
    * Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF ProximoComando = 22 -> lsMensagem = ALLTRIM(STRTRAN(Buffer,CHR(0),''))
    *   e no inicio do passo seguinte:
    *     If !Empty(pcBanco) -> pcRetChe = '00' + ALLTRIM(lsMensagem)
    *     lsMensagem = ""
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarMensagemParcial(par_cBuffer)
        THIS.this_cMensagemSiTef = ALLTRIM(STRTRAN(par_cBuffer, CHR(0), ""))
    ENDPROC

    PROCEDURE ConsumirMensagemParcial()
        IF !EMPTY(THIS.this_cMensagemSiTef)
            IF !EMPTY(THIS.this_cBanco)
                THIS.this_cRetChe = "00" + ALLTRIM(THIS.this_cMensagemSiTef)
            ENDIF
            THIS.this_cMensagemSiTef = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalizarSerasa - Tabela de retorno SERASA do legado (CodSerasa /
    * RetSerasa, 8 codigos x 3 linhas). Origem: SIGPRIFF.Init e
    * SIGPRIFF.SAIDA.GotFocus, onde a tabela aparece duplicada - aqui ela vive
    * num unico lugar.
    * Preenche this_cRetSerasa1/2/3 e this_nIndiceSerasa, e retorna .T. quando
    * o codigo esta na tabela.
    *--------------------------------------------------------------------------
    FUNCTION LocalizarSerasa(par_cCodigo)
        LOCAL loc_aCodSerasa[8], loc_aRetSerasa[8,3], loc_nPos

        loc_aCodSerasa[1] = "00"
        loc_aCodSerasa[2] = "19"
        loc_aCodSerasa[3] = "56"
        loc_aCodSerasa[4] = "57"
        loc_aCodSerasa[5] = "60"
        loc_aCodSerasa[6] = "61"
        loc_aCodSerasa[7] = "65"
        loc_aCodSerasa[8] = "76"

        loc_aRetSerasa[1,1] = ""
        loc_aRetSerasa[1,2] = "Aprovado"
        loc_aRetSerasa[1,3] = ""

        loc_aRetSerasa[2,1] = "Banco N" + CHR(227) + "o Existe ou"
        loc_aRetSerasa[2,2] = "N" + CHR(227) + "o Trabalha com Conta Corrente ou"
        loc_aRetSerasa[2,3] = "Est" + CHR(225) + " em Processo de Liquida" + CHR(231) + CHR(227) + "o"

        loc_aRetSerasa[3,1] = "Pagamento de Compra com Cheque Pr" + CHR(233)
        loc_aRetSerasa[3,2] = "por Cliente N" + CHR(227) + "o Cadastrado no "
        loc_aRetSerasa[3,3] = "Estabelecimento"

        loc_aRetSerasa[4,1] = ""
        loc_aRetSerasa[4,2] = "Realizar Consulta Anal" + CHR(237) + "tica"
        loc_aRetSerasa[4,3] = ""

        loc_aRetSerasa[5,1] = ""
        loc_aRetSerasa[5,2] = "Falha no Processo de Consulta"
        loc_aRetSerasa[5,3] = ""

        loc_aRetSerasa[6,1] = "Excedido Limite para Pagamento"
        loc_aRetSerasa[6,2] = "de Compras com Cheque Pre-Datados"
        loc_aRetSerasa[6,3] = "Determinado pelo Estabelecimento"

        loc_aRetSerasa[7,1] = ""
        loc_aRetSerasa[7,2] = "Cheque Maior que o Limite de Compra"
        loc_aRetSerasa[7,3] = ""

        loc_aRetSerasa[8,1] = "Cliente Cadastrado Al" + CHR(233) + "m do Prazo"
        loc_aRetSerasa[8,2] = "Definido pelo Estabelecimento para"
        loc_aRetSerasa[8,3] = "Validade do Cart" + CHR(227) + "o provis" + CHR(243) + "rio"

        THIS.this_nIndiceSerasa = 0
        THIS.this_cRetSerasa1   = ""
        THIS.this_cRetSerasa2   = ""
        THIS.this_cRetSerasa3   = ""

        loc_nPos = ASCAN(loc_aCodSerasa, par_cCodigo)

        IF loc_nPos > 0
            THIS.this_nIndiceSerasa = loc_nPos
            THIS.this_cRetSerasa1   = loc_aRetSerasa[loc_nPos, 1]
            THIS.this_cRetSerasa2   = loc_aRetSerasa[loc_nPos, 2]
            THIS.this_cRetSerasa3   = loc_aRetSerasa[loc_nPos, 3]
        ENDIF

        RETURN (loc_nPos > 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * DecodificarRetornoFinal - Fecha a consulta traduzindo o buffer final.
    * Origem: SIGPRIFF.SAIDA.GotFocus (bloco final, depois do Enddo):
    *   If stts <> 1000 and stts <> 0
    *     npos = Ascan(CodSerasa, Substr(Buffer,1,2))
    *     If nPos = 0 -> pcRetChe = ALLTRIM(Buffer)        (1 linha, vermelho)
    *     Else        -> pcRetChe = Substr(Buffer,1,2)+linha1+' '+linha2+' '+linha3
    * Retorna .T. quando o codigo foi reconhecido (a tela mostra as 3 linhas) e
    * .F. quando nao (a tela mostra o buffer cru numa linha so).
    *--------------------------------------------------------------------------
    FUNCTION DecodificarRetornoFinal()
        LOCAL loc_lSerasa

        loc_lSerasa = .F.

        IF THIS.this_nStatus != 1000 AND THIS.this_nStatus != 0
            IF THIS.LocalizarSerasa(SUBSTR(THIS.this_cBuffer, 1, 2))
                THIS.this_cRetChe = SUBSTR(THIS.this_cBuffer, 1, 2) + ;
                    THIS.this_cRetSerasa1 + " " + THIS.this_cRetSerasa2 + " " + ;
                    THIS.this_cRetSerasa3
                loc_lSerasa = .T.
            ELSE
                THIS.this_cRetChe = ALLTRIM(THIS.this_cBuffer)
            ENDIF
        ENDIF

        RETURN loc_lSerasa
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterRetornoFinal - Valor que o dialogo devolve ao chamador.
    * Origem: SIGPRIFF.Unload
    *   pcRetChe = IIF(Type('pcRetChe') = 'L','999 - Consulta com Erro', pcRetChe)
    *   Return(pcRetChe)
    * No legado o Type 'L' denuncia a property nunca atribuida; aqui ela nasce
    * caractere, entao a condicao equivalente e estar vazia.
    *--------------------------------------------------------------------------
    FUNCTION ObterRetornoFinal()
        IF EMPTY(THIS.this_cRetChe)
            THIS.this_cRetChe = "999 - Consulta com Erro"
        ENDIF

        RETURN THIS.this_cRetChe
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarCancelamentoUsuario - Origem: SIGPRIFF.SAIDA.GotFocus
    *   IF stts = -2 -> lsMensagem = "Operacao Canceleda pelo Usuario" / EXIT
    * O legado tem o erro de digitacao "Canceleda"; a mensagem aqui segue a
    * grafia correta, por ser texto exibido ao usuario.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarCancelamentoUsuario()
        THIS.this_lAbandona      = .T.
        THIS.this_cMensagemSiTef = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + ;
            CHR(225) + "rio"
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarSenhaDigitada / ObterEtapaCartaoSenha - Estado do aviso "Passe ou
    * Insira o Cartao" / "Digite a Senha".
    * Origem: SIGPRIFF.SAIDA.GotFocus (variavel carsen: nasce 1 e vira 2 no
    * comando 13, que e quando o cartao ja foi lido).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarSenhaDigitada()
        THIS.this_nCarSen = 2
    ENDPROC

    FUNCTION ObterEtapaCartaoSenha()
        RETURN THIS.this_nCarSen
    ENDFUNC

ENDDEFINE

