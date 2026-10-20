# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: [18/10/2026 09:38:52] Falha na Conexão (TmpEmpMail): Conta de e-mail não cadastrada para a empresa.


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[18/10/2026 09:38:52] Falha na Conexão (TmpEmpMail): Conta de e-mail não cadastrada para a empresa.


### LOG DA ETAPA (06_testForm):
[2026-10-18 09:35:27] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-18 09:35:27] [INFO] Config FPW: (nao fornecido)
[2026-10-18 09:35:27] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-18 09:35:27] [INFO] Timeout: 300 segundos
[2026-10-18 09:35:27] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n3arozzk.prg
[2026-10-18 09:35:27] [INFO] Conteudo do wrapper:
[2026-10-18 09:35:28] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigprpdf', 'C:\4c\tasks\task664\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprpdf', 'C:\4c\tasks\task664\logs\06_testForm.log'
QUIT

[2026-10-18 09:35:28] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n3arozzk.prg
[2026-10-18 09:35:28] [INFO] VFP output esperado em: C:\4c\tasks\task664\vfp_output.txt
[2026-10-18 09:35:28] [INFO] Executando Visual FoxPro 9...
[2026-10-18 09:35:28] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n3arozzk.prg
[2026-10-18 09:35:28] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n3arozzk.prg
[2026-10-18 09:35:28] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigprpdf
Inicio: 18/10/2026 09:35:28

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 18/10/2026 09:38:52
Duracao: 204 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-18 09:38:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-18 09:38:53] [INFO] VFP9 finalizado em 204.8049676 segundos
[2026-10-18 09:38:53] [INFO] Exit Code: 
[2026-10-18 09:38:53] [INFO] 
[2026-10-18 09:38:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-18 09:38:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_n3arozzk.prg
[2026-10-18 09:38:53] [INFO] 
[2026-10-18 09:38:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-18 09:38:53] [INFO] * Auto-generated wrapper for parameters
[2026-10-18 09:38:53] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-18 09:38:54] [INFO] * Parameters: 'Formsigprpdf', 'C:\4c\tasks\task664\logs\06_testForm.log'
[2026-10-18 09:38:54] [INFO] 
[2026-10-18 09:38:54] [INFO] * Anti-dialog protections for unattended execution
[2026-10-18 09:38:54] [INFO] SET SAFETY OFF
[2026-10-18 09:38:54] [INFO] SET RESOURCE OFF
[2026-10-18 09:38:54] [INFO] SET TALK OFF
[2026-10-18 09:38:54] [INFO] SET NOTIFY OFF
[2026-10-18 09:38:54] [INFO] SYS(2335, 0)
[2026-10-18 09:38:54] [INFO] 
[2026-10-18 09:38:54] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigprpdf', 'C:\4c\tasks\task664\logs\06_testForm.log'
[2026-10-18 09:38:55] [INFO] QUIT
[2026-10-18 09:38:55] [INFO] 
[2026-10-18 09:38:55] [INFO] === Fim do Wrapper.prg ===
[2026-10-18 09:38:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprpdf.prg):
*==============================================================================
* Formsigprpdf.prg
* Form OPERACIONAL: Geracao de PDF e E-mail
* Migrado de SIGPRPDF.SCX
* Herda de: FormBase
*
* SIGPRPDF e' um DIALOGO FILHO (WindowType = 1, modal) instanciado por outro
* form (par_oFormPai, equivalente a poformParent/ThisForm.oParentForm do
* legado) para o usuario escolher o nome/tipo do arquivo de saida (PDF ou
* XLS) e, opcionalmente, os dados do e-mail de envio. Form OPERACIONAL FLAT
* (sem PageFrame Page1/Page2 - o SCX legado nao tem PageFrame, so controles
* direto no form - ver tasks\task664\layout.json).
*
* Parametros do Init (equivalentes a poformParent/pcAssunto do legado):
*   par_oFormPai - form chamador (equivalente a ThisForm.oParentForm). E' nele
*                  que Cmd_GerarPDF/Cmd_SAIR gravam pcArqEmail/oEMAIL de volta
*                  (ver sigprpdfBO.MontarDadosEnvioEmail) e de onde se le o
*                  e-mail inicial (par_oFormPai.Contaemail).
*   par_cAssunto - assunto inicial do e-mail (equivalente a pcAssunto),
*                  guardado em this_cAssunto para a Fase que criar
*                  CtnSaida_Email.txtEmail_Assunto o usar como .Value inicial.
*
* NAO PORTADO (documentado para a ausencia ser auditavel, nao esquecimento):
*   "Set datasession to thisform.oParentForm.DatasessionId" - o legado
*   sincroniza a data session do dialogo com a do form pai porque ambos sao
*   private data session (DataSession = 2) e precisam compartilhar cursores
*   VFP locais abertos no pai. Na arquitetura nova nao ha cursor local
*   compartilhado entre este dialogo e o form pai - a unica troca de dados e'
*   via PROPRIEDADES (par_oFormPai.Contaemail na leitura, pcArqEmail/oEMAIL na
*   escrita) e o unico cursor que este form abre (cursor_4c_TmpEmpMail, via
*   sigprpdfBO.ObterDadosContaEmail) usa gnConnHandle/SQLEXEC direto, que nao
*   e' escopado por data session privada. Replicar o SET DATASESSION sem um
*   cursor compartilhado para proteger seria copiar sintaxe sem a razao que a
*   justifica.
*   "poDataMgr = CreateObject('fSqlConector', ...)" - cada form legado cria a
*   propria conexao; na arquitetura nova a conexao e' UNICA e global
*   (gnConnHandle, aberta uma vez no startup por start\config.prg) - por isso
*   sigprpdfBO.ObterDadosContaEmail usa gnConnHandle direto, sem objeto de
*   conexao proprio por form.
*
* Historico de fases:
*   Fase 1/2: sigprpdfBO.prg (propriedades + metodos de negocio completos)
*   Fase 3:   Formsigprpdf.prg - estrutura base (heranca, propriedades
*             visuais, Init recebendo par_oFormPai/par_cAssunto,
*             InicializarForm criando o BO/validando conexao/resolvendo
*             this_cDiretorio, ConfigurarCabecalho equivalente ao cntSombra,
*             TornarControlesVisiveis, Destroy). A colisao de Height
*             (ThisForm.Height = This.Height - This.CtnSaida_Email.Height,
*             equivalente ao colapso do bloco de e-mail quando
*             CtnSaida_Email.Visible = .F.) e' tratada na fase que criar
*             Chk_EMAIL/CtnSaida_Email - ainda nao existem controles para
*             aplicar esse calculo nesta fase.
*   Fase 4:   Formsigprpdf.prg - SUPERFICIE DE ACAO + painel de e-mail (este
*             arquivo). Ver a nota "POR QUE A FASE 4 NAO TEM GRID NEM BOTOES
*             CRUD" logo abaixo. Entregue aqui:
*               ConfigurarPainelEmail      - cnt_4c_CtnSaida_Email (o CONTAINER
*                                            colapsavel, vazio: os campos De/
*                                            Para/CC/Assunto/Texto que moram
*                                            dentro dele sao da Fase 5/6)
*               ConfigurarBarraAcao        - obj_4c_OptArquivo (PDF/Excel),
*                                            chk_4c_Chk_EMAIL,
*                                            cmd_4c_Cmd_GerarPDF e
*                                            cmd_4c_Cmd_SAIR (a fileira de
*                                            Top = 3, que e' a barra de acao
*                                            deste dialogo)
*               ConfigurarAreaArquivoSaida - lbl_4c_Lbl_SalvarEm,
*                                            txt_4c_TxtNomeArqSaida (ReadOnly),
*                                            cmd_4c_CmdGetFile e
*                                            cmd_4c_BtnPastasA
*               AplicarTipoArquivoPadrao / AplicarNomeArquivoPadrao /
*               AlternarPainelEmail        - os defaults e o colapso do Init
*                                            legado (resolve a pendencia que a
*                                            Fase 3 deixou anotada sobre
*                                            "ThisForm.Height = This.Height -
*                                            This.CtnSaida_Email.Height")
*               CarregarContaEmailEmpresa  - a consulta a SigCdEmp do Init
*                                            legado (via BO), que e' o dado por
*                                            tras do Chk_EMAIL criado aqui
*               ChkEmailClick / OptArquivoClick / CmdGetFileClick /
*               BtnPastasAClick / CmdSairClick - os Click legado que dependem
*                                            SO de controles desta fase, logo
*                                            portados COMPLETOS aqui.
*   Fase 5:   Formsigprpdf.prg - PRIMEIRA METADE dos campos de dentro de
*             cnt_4c_CtnSaida_Email (De / Para / CC), em ConfigurarCamposEmail:
*               lbl_4c_Label1 / txt_4c_TxtEmail_EnviarDE       (De - ReadOnly)
*               lbl_4c_Lbl_EmailPara / obj_4c_TxtEmail_EnviarPara (Para)
*               lbl_4c_LblEmail_CC / obj_4c_TxtEmail_CC           (CC)
*             txtEmail_EnviarPara/txtEmail_CC sao EDITBOX no legado (confirmado
*             no layout.json), nao TextBox, apesar do nome "txt". Valor inicial
*             de Para replicado do Init legado ("txtEmail_EnviarPara.Value =
*             thisform.oParentForm.Contaemail", via PEMSTATUS porque Contaemail
*             e' property do form chamador). O valor de De passou a ser escrito
*             em CarregarContaEmailEmpresa() (agora que o campo existe),
*             exatamente onde o legado faz essa atribuicao - DEPOIS da consulta
*             a SigCdEmp, nao no Init.
*   Fase 6:   Formsigprpdf.prg - SEGUNDA METADE dos campos de dentro de
*             cnt_4c_CtnSaida_Email, no MESMO ConfigurarCamposEmail:
*               lbl_4c_LblEmail_Assunto / txt_4c_TxtEmail_Assunto (Assunto)
*               lbl_4c_LblEmail_Corpo   / obj_4c_EdtEmail_Corpo   (Texto)
*             Com isso o painel de e-mail esta COMPLETO (os 5 campos + os 5
*             labels do SCX) e o valor inicial do Assunto passou a ser escrito
*             aqui, replicando o Init legado ("txtEmail_Assunto.Value =
*             Iif(Type([pcAssunto]) = [C], pcAssunto, [])") a partir de
*             this_cAssunto, que o Init do form ja normaliza.
*               SincronizarCamposParaBO - espelho TELA -> BO de todos os
*                                       controles de entrada do dialogo. O
*                                       legado le o .Value dos controles
*                                       DIRETO dentro do Cmd_GerarPDF.Click,
*                                       logo o CONTROLE e' a fonte unica do
*                                       valor; este metodo e' o unico lugar
*                                       que faz essa leitura.
*               ValidarDadosEnvio       - as checagens BLOQUEANTES que o
*                                       Cmd_GerarPDF.Click legado faz sobre
*                                       esses campos (arquivo de saida, 'DE:'
*                                       e 'PARA:'), com a mesma mensagem, a
*                                       mesma ordem e o mesmo SetFocus. A regra
*                                       mora no BO (ValidarDadosConfirmacao);
*                                       aqui fica so o que o BO nao pode fazer
*                                       - ler a tela antes de validar e dar o
*                                       foco ao campo recusado.
*             LOOKUP: este legado NAO tem nenhum. Conferido no dump
*             (tasks\task664\sigprpdf_form_codigo_fonte.txt): zero fwBuscaExt /
*             fwBuscaSel / fwBuscaInt / mAddColuna / sigacess() / AcessoXxx(),
*             zero "PROCEDURE Valid", zero "PROCEDURE When" e zero "PROCEDURE
*             LostFocus" - os unicos metodos do SCX inteiro sao Init e Click.
*             Nenhum dos 5 campos referencia tabela alguma: Assunto/Texto/CC
*             sao texto livre, De vem da consulta a SigCdEmp (ReadOnly) e Para
*             vem do form chamador. O unico "seletor" da tela e' o GetFile() do
*             cmd_4c_CmdGetFile, que e' dialogo de ARQUIVO do proprio VFP9 (ja
*             portado na Fase 4), nao busca em tabela. Criar AbrirLookupXxx
*             aqui significaria inventar tabela de lookup que o legado nunca
*             consultou - proibido pelo PILAR 1 e pela regra "NUNCA inventar
*             tabelas de lookup".
*
*   Fase 7/8: Formsigprpdf.prg - CmdGerarPDFClick, o Click do cmd_4c_Cmd_GerarPDF
*             (botao criado na Fase 4; BINDEVENT ligado agora em
*             ConfigurarBarraAcao). Usa o que as fases anteriores ja deixaram
*             pronto: THIS.ValidarDadosEnvio() (sincroniza a tela com o BO,
*             valida e da o foco ao campo recusado) e, no BO,
*             this_lContaEmailCarregada + ObterMensagemContaEmailIndisponivel()
*             para o aviso que NAO bloqueia o fechamento e
*             MontarDadosEnvioEmail() para o objeto de envio que vai para
*             par_oFormPai.oEMAIL. A unica saida da tela (cmd_4c_Cmd_SAIR,
*             Cancel = .T.) ja estava ligada desde a Fase 4, entao o dialogo
*             nunca ficou sem como fechar. Com isto, todos os Click do SCX
*             legado (Init/Click de Cmd_GerarPDF, Cmd_SAIR, Chk_EMAIL,
*             optArquivo, cmdGetFile, btnPastasA) estao portados - o dump
*             (tasks\task664\sigprpdf_form_codigo_fonte.txt) nao tem mais
*             nenhum PROCEDURE alem de Init, e Init e' o deste form.
*   Fase 8:   Consolidacao final - sem codigo novo de comportamento (ver
*             "POR QUE A FASE 8 NAO TEM Btn*/FormParaBO/BOParaForm/
*             HabilitarCampos/LimparCampos/CarregarLista/
*             AjustarBotoesPorModo" logo abaixo). Confirmado de novo contra
*             o dump que nao sobrou PROCEDURE do legado sem equivalente
*             neste arquivo - a migracao do COMPORTAMENTO fecha aqui.
*
* POR QUE A FASE 8 NAO TEM BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
* BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/
* CarregarLista/AjustarBotoesPorModo
* ------------------------------------------------------------------------
* O texto generico da Fase 8 pede os metodos de consolidacao do padrao CRUD
* (FormCargo/FormCor): Buscar/Encerrar/Salvar/Cancelar ligados a um
* cnt_4c_Botoes, FormParaBO/BOParaForm por modo, HabilitarCampos por modo
* (INCLUIR/ALTERAR/VISUALIZAR), LimparCampos para reusar a MESMA tela em
* registros diferentes, CarregarLista+AjustarBotoesPorModo para a Page1 de
* lista. SIGPRPDF nao tem NENHUM desses conceitos - e' um dialogo de
* CAPTURA DE UM UNICO VALOR (CREATEOBJECT + Show() + Release(), sempre uma
* instancia NOVA por chamada, nunca reaberto/reusado), sem registro, sem
* tabela propria e sem Page1/Page2 (ver "POR QUE A FASE 4 NAO TEM GRID NEM
* BOTOES CRUD" acima). O equivalente de cada metodo generico ja foi
* entregue nas fases anteriores, com o nome do botao do PROPRIO legado (nao
* um nome generico inventado):
*   BtnSalvarClick    -> CmdGerarPDFClick (Fase 7) - confirma e fecha
*   BtnCancelarClick /
*   BtnEncerrarClick  -> CmdSairClick (Fase 7) - UNICA saida da tela
*                        (TitleBar = 0, ControlBox = .F.); o legado nao tem
*                        Confirmar+Encerrar de form CRUD, so Cmd_GerarPDF e
*                        Cmd_SAIR
*   BtnBuscarClick    -> N/A - zero lookup no legado, conferido no dump e
*                        documentado na Fase 6
*   FormParaBO        -> SincronizarCamposParaBO (Fase 6) - TELA -> BO,
*                        chamada por ValidarDadosEnvio()/CmdGerarPDFClick
*   BOParaForm        -> nao existe como metodo unico porque o legado nao
*                        tem ALTERAR/VISUALIZAR (nao ha registro para
*                        carregar de volta); o UNICO sentido BO -> Form do
*                        legado e' escrito exatamente onde o legado escreve:
*                        CarregarContaEmailEmpresa() grava this_cEmailDe em
*                        TxtEmail_EnviarDE (Fase 5/7) e ConfigurarCamposEmail
*                        grava this_cEmailPara/this_cEmailAssunto nos
*                        valores iniciais de Para/Assunto (Fase 5/6)
*   HabilitarCampos   -> N/A - nao ha modo INCLUIR/ALTERAR/VISUALIZAR; os
*                        unicos campos ReadOnly (TxtEmail_EnviarDE,
*                        TxtNomeArqSaida) sao FIXOS do SCX, nao variam por
*                        estado da tela
*   LimparCampos      -> N/A - a instancia NAO e' reaproveitada: cada
*                        chamador faz um CREATEOBJECT novo e o dialogo se
*                        libera (Release()) ao confirmar OU ao cancelar; nao
*                        ha "proximo registro" para limpar os campos
*   CarregarLista /
*   AjustarBotoesPorModo -> N/A - nao ha grid nem Page1 (ver nota da Fase 4)
* Escrever esses metodos vazios ou com MsgAviso("...sera implementado...")
* so para casar com o texto generico seria o "stub disfarcado" que a regra
* de completude do projeto proibe, e inventaria um fluxo de cadastro
* (registro/modo/lista) que SIGPRPDF nunca teve - o oposto de fidelidade ao
* legado (PILAR 1). "Completo" aqui significa cobrir TODO o dump do legado,
* nao reproduzir metodos de um padrao que o legado nao tem.
*
* POR QUE A FASE 4 NAO TEM GRID NEM BOTOES CRUD
* ---------------------------------------------
* A Fase 4 pede, no texto generico, "ConfigurarPaginaLista() com Grid completo +
* cnt_4c_Botoes com 6 botoes CRUD + AlternarPagina()". Conferido o dump do
* legado (tasks\task664\sigprpdf_form_codigo_fonte.txt e layout.json), SIGPRPDF
* nao tem NADA disso: zero "BaseClass: grid", zero "BaseClass: pageframe", zero
* AddCursor/pColuna/RecordSource/ControlSource e nenhum botao Incluir/
* Visualizar/Alterar/Excluir/Buscar - e' um dialogo MODAL de CAPTURA (800x360,
* TitleBar = 0, ControlBox = .F.) que coleta o nome do arquivo de saida e os
* dados do e-mail e devolve tudo ao form chamador. Inventar um PageFrame
* Lista/Dados com grade e 6 botoes CRUD violaria o PILAR 1 (UX fiel ao legado) e
* a regra "NUNCA inventar"; escrever ConfigurarPaginaLista/AlternarPagina vazios
* so para casar com o texto da fase seria o "stub disfarcado" que a regra de
* completude proibe. O que esta fase acrescenta, entao, e' a superficie que este
* legado DE FATO tem e que a Fase 3 (estrutura base) ainda nao tinha: a barra de
* acao, a area do arquivo de saida e o container colapsavel de e-mail.
*
* DIVERGENCIAS DELIBERADAS DO SCX (registradas para serem auditaveis)
* ------------------------------------------------------------------
*   SIGPRPDF.REGISTRY1 (classe "registry" do framework.vcx) e a cadeia
*   "optArquivo.option1.Enabled = Registry1.IsKey('PDFCreator.clsPDFCreator') Or
*   Registry1.IsKey('PDFCreatorBeta.JobQueue')" - NAO PORTADOS, pela mesma razao
*   ja registrada no form irmao Formsigprema.prg: a geracao do PDF via COM do
*   PDFCreator esta fora do escopo deste acervo - quem gera o arquivo e' o form
*   CHAMADOR (ver cabecalho de sigprpdfBO.prg), este dialogo so escolhe o nome.
*   Copiar a deteccao sem a funcionalidade que ela protege DESABILITARIA a opcao
*   PDF em toda maquina sem PDFCreator instalado - isto e', mataria justamente o
*   que a tela existe para fazer ("Geracao de PDF e E-mail"), sendo pior que o
*   legado em vez de fiel a ele. A EXPRESSAO do legado foi transcrita: o
*   Enabled de Buttons(1) e o Value default saem de
*   this_oBusinessObject.this_lPdfCreatorDisponivel (o campo que o BO declarou
*   justamente para esta decisao), resolvido aqui como .T. Trocar essa property
*   por uma deteccao real e' o UNICO ponto a mexer no futuro.
*   Consequencia conhecida: o ValidarUIFidelity vai acusar obj_4c_REGISTRY1
*   ausente - e' esta divergencia, nao esquecimento.
*
*   .Themes = .T. + .DisabledPicture nos CommandButton com .Picture
*   (cmd_4c_Cmd_SAIR, cmd_4c_Cmd_GerarPDF, cmd_4c_BtnPastasA), onde o SCX
*   declara Themes = .F. - padrao canonico do sistema novo para botao
*   standalone com icone (sem isso o icone nao renderiza se o botao for
*   desabilitado). O CorretorAutomatico (pattern #99) aplica essa troca de
*   qualquer forma em cada bloco "WITH THIS.cmd_4c_*" que tenha .Picture, entao
*   o codigo ja e' emitido no formato final. cmd_4c_CmdGetFile NAO tem .Picture
*   e por isso mantem o Themes = .F. do legado.
*
*   fundo_cad_1003.jpg - o CorretorAutomatico (pattern #168) emite AVISO de que
*   este form nao usa essa textura. NAO se aplica aqui: fundo_cad_1003.jpg e' o
*   fundo das Pages de form CRUD, e este e' um dialogo OPERACIONAL FLAT cujo
*   SCX declara "Picture = ..\framework\imagens\new_background.jpg" - que e'
*   justamente o que o InicializarForm atribui. Trocar seria desviar do legado.
*
*   AutoCenter - o legado faz "Thisform.AutoCenter = .F." no fim do Init, DEPOIS
*   de encolher a tela, so para o colapso/expansao do painel de e-mail nao
*   recentralizar a janela. Aqui o AutoCenter fica .T. durante o Init (para o
*   dialogo JA COLAPSADO nascer centralizado quando o Show() acontecer, que no
*   sistema novo e' depois do Init) e e' desligado dentro de
*   AlternarPainelEmail, na primeira vez que a altura muda com a tela visivel -
*   mesmo efeito pratico, mesma protecao.
*==============================================================================
DEFINE CLASS Formsigprpdf AS FormBase

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos no Init (equivalentes a poformParent/pcAssunto)
    this_oFormPai = .NULL.   && poformParent / ThisForm.oParentForm
    this_cAssunto = ""       && pcAssunto - usado pela fase que criar CtnSaida_Email.txtEmail_Assunto

    *-- Estado do bloco de e-mail no que diz respeito a ALTURA do form.
    *-- Comeca .T. porque o Height = 360 declarado acima e' o do SCX, e o SCX
    *-- desenha a tela COM o painel ocupando Top 148..333 - isto e', o tamanho
    *-- de projeto JA CONTA o painel. E' justamente por isso que o Init legado
    *-- precisa encolher a tela ("Thisform.Height = This.Height -
    *-- This.CtnSaida_Email.Height" -> 360 - 185 = 175).
    *-- NAO usar cnt_4c_CtnSaida_Email.Visible como esse estado: o container
    *-- nasce Visible = .F. (fiel ao SCX) enquanto a ALTURA ainda esta na de
    *-- projeto, entao os dois nao coincidem no comeco - medido no VFP9 em
    *-- 2026-10-18: com o Visible como guarda, o colapso do Init virava no-op
    *-- em silencio e o dialogo abria 185px mais alto, com uma faixa vazia.
    this_lPainelEmailVisivel = .T.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX legado)
    Top         = 0
    Left        = 0
    Height      = 360
    Width       = 800
    BorderStyle = 2
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Caption     = "Gera" + CHR(231) + CHR(227) + "o de PDF e E-mail"
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Init - Recebe os parametros equivalentes a poformParent/pcAssunto do
    * legado (Lparameters poformParent, pcAssunto)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cAssunto)
        THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cAssunto = IIF(VARTYPE(par_cAssunto) = "C", par_cAssunto, "")

        *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT. Equivalente ao
    * PROCEDURE Init legado: cria o BO (no lugar do poDataMgr/fSqlConector
    * proprio do legado), confere a conexao global (equivalente a
    * "If .poDataMgr.pnIdconn > 0 / Else MessageBox(...)"), resolve
    * this_cDiretorio (equivalente a "ThisForm.Diretorio =
    * goSistema.DirFiscais"), monta a tela e aplica os defaults.
    *
    * A ORDEM de criacao importa: cnt_4c_Sombra (faixa cinza, Top = 0..80,
    * Width = 1100) vem PRIMEIRO; a barra de acao (Top = 3..78) e' criada
    * DEPOIS para desenhar POR CIMA dela. E ConfigurarPainelEmail vem antes da
    * barra porque AlternarPainelEmail le a .Height daquele container para
    * encolher o form, que e' a primeira coisa que o Init legado faz.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cDiretorio
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprpdfBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigprpdfBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigprpdf.InicializarForm")
            ELSE
                *-- Equivalente a "If (.poDataMgr.pnIdconn > 0) ... Else
                *-- Messagebox('Impossivel Efetuar Conexao...')" do legado -
                *-- a conexao agora e' a global gnConnHandle (criada uma vez
                *-- no startup), nao uma por form.
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                                "o Com o Servidor de Banco de Dados...", ;
                                "CreateObject")
                    ENDIF
                ENDIF

                *-- Repassa a referencia ao form pai para o BO (ele existe so
                *-- para o Form usar - ver cabecalho de sigprpdfBO.prg)
                THIS.this_oBusinessObject.this_oFormPai = THIS.this_oFormPai

                *-- Equivalente a "ThisForm.Diretorio = goSistema.DirFiscais".
                *-- DirFiscais e' property DINAMICA (SigReIdtBO a cria via
                *-- AddProperty em runtime quando um relatorio informa
                *-- diretorio alternativo) - NAO existe no AddProperty fixo de
                *-- start\config.prg, entao ler sem PEMSTATUS estouraria
                *-- "Property DIRFISCAIS is not found" (mesmo guard usado em
                *-- FormSigReIdt.prg).
                loc_cDiretorio = ""
                IF TYPE("go_4c_Sistema") = "O" AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
                    loc_cDiretorio = ALLTRIM(TratarNulo(go_4c_Sistema.DirFiscais, ""))
                ENDIF
                THIS.this_oBusinessObject.this_cDiretorio = loc_cDiretorio

                *-- Imagem de fundo (legado: Picture = ..\framework\imagens\new_background.jpg)
                IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                ENDIF

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPainelEmail()
                THIS.ConfigurarCamposEmail()
                THIS.ConfigurarBarraAcao()
                THIS.ConfigurarAreaArquivoSaida()

                THIS.TornarControlesVisiveis(THIS)

                *-- Defaults do Init legado (optArquivo.option1.Enabled +
                *-- optArquivo.Value + txtNomeArqSaida.Value)
                THIS.AplicarTipoArquivoPadrao()

                *-- Colapso inicial: "Thisform.Height = This.Height -
                *-- This.CtnSaida_Email.Height" + "CtnSaida_Email.Visible = .F."
                THIS.AlternarPainelEmail(.F.)

                *-- Consulta de dados da conta de e-mail da empresa (o
                *-- "Select ... From SigCdEmp Where CEmps = ..." do Init
                *-- legado). Falha aqui IMPEDE a abertura da tela, igual ao
                *-- "Return .f." do legado.
                loc_lSucesso = THIS.CarregarContaEmailEmpresa()
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Constroi a faixa cinza superior do form
    * (equivalente ao cntSombra do SCX legado, com lblSombra/lblTitulo).
    * Forms OPERACIONAIS nao usam PageFrame CRUD - o cabecalho e' um container
    * direto no form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = 1100
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BackStyle   = 1
                .BorderWidth = 0

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top       = 18
                    .Left      = 10
                    *-- Canonico do sistema novo: os labels da faixa acompanham
                    *-- a largura do FORM (o SCX declara 769). O
                    *-- CorretorAutomatico (HEADER-WIDTH-TOTAL) aplica esta
                    *-- troca de qualquer forma, entao ja fica no formato final -
                    *-- NAO reverter para 769. Inerte visualmente: o label e'
                    *-- BackStyle = 0 com Alignment = 0, logo o texto continua
                    *-- desenhando da esquerda.
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Caption   = THIS.Caption
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top       = 17
                    .Left      = 10
                    *-- Canonico do sistema novo: os labels da faixa acompanham
                    *-- a largura do FORM (o SCX declara 769). O
                    *-- CorretorAutomatico (HEADER-WIDTH-TOTAL) aplica esta
                    *-- troca de qualquer forma, entao ja fica no formato final -
                    *-- NAO reverter para 769. Inerte visualmente: o label e'
                    *-- BackStyle = 0 com Alignment = 0, logo o texto continua
                    *-- desenhando da esquerda.
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = THIS.Caption
                ENDWITH

                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPainelEmail - Cria o container colapsavel do bloco de e-mail
    * (equivalente a SIGPRPDF.CtnSaida_Email). Geometria e propriedades
    * transcritas do dump do SCX; o BorderWidth = 0 vem do PROCEDURE Init do
    * proprio container no legado ("This.BorderWidth = 0"). Container NAO tem
    * BorderStyle no VFP9 - so BorderWidth.
    *
    * Nasce Visible = .F. igual ao legado - quem o mostra/esconde e' o
    * Chk_EMAIL, via AlternarPainelEmail(). Os controles de DENTRO dele - De/
    * Para/CC e os respectivos labels foram criados em ConfigurarCamposEmail
    * (Fase 5); Assunto/Texto ficam para a Fase 6.
    *
    * Criado ANTES da barra de acao de proposito: AlternarPainelEmail le a
    * .Height deste container para encolher/esticar o form, e o Init legado faz
    * esse calculo na primeira coisa que executa.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPainelEmail()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_CtnSaida_Email", "Container")
            WITH THIS.cnt_4c_CtnSaida_Email
                .Top         = 148
                .Left        = 155
                .Width       = 480
                .Height      = 185
                .BackStyle   = 0
                .BorderWidth = 0
                .TabIndex    = 7
                .Visible     = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.ConfigurarPainelEmail")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposEmail - Cria os CINCO campos do painel de e-mail (De /
    * Para / CC / Assunto / Texto, dentro de cnt_4c_CtnSaida_Email) com os
    * respectivos labels. Geometria e propriedades transcritas do dump do SCX
    * legado (SIGPRPDF.CtnSaida_Email.*), controle a controle:
    *
    *   Label1           "De:"       Top=8   Left=47 W=19 H=15  TabIndex=1
    *   txtEmail_EnviarDE  (TextBox) Top=5   Left=68 W=404 H=23 TabIndex=2 ReadOnly
    *   lbl_EmailPara    "Para:"     Top=38  Left=38 W=28 H=15  TabIndex=3
    *   txtEmail_EnviarPara (EditBox) Top=35 Left=68 W=404 H=23 TabIndex=4
    *   lblEmail_CC      "CC:"       Top=68  Left=46 W=20 H=15  TabIndex=5
    *   txtEmail_CC      (EditBox)   Top=65  Left=68 W=404 H=23 TabIndex=6
    *   lblEmail_Assunto "Assunto:"  Top=99  Left=21 W=45 H=15  TabIndex=7
    *   txtEmail_Assunto (TextBox)   Top=95  Left=68 W=404 H=23 TabIndex=8
    *   lblEmail_Corpo   "Texto:"    Top=127 Left=32 W=34 H=15  TabIndex=9
    *   EdtEmail_Corpo   (EditBox)   Top=125 Left=68 W=404 H=53 TabIndex=10
    *
    * O ultimo controle termina em Top 125 + 53 = 178, dentro do Height = 185
    * do container - nada estoura a area do pai (que recortaria o controle sem
    * erro algum, so sumindo da tela).
    *
    * CADA label e' criado ANTES do campo da sua linha: o label tem
    * BackStyle = 0 (caixa transparente) e, se viesse depois, essa caixa ficaria
    * POR CIMA do campo e bloquearia o clique nele.
    *
    * Nomes com "txt" no legado que sao EDITBOX, nao TextBox (confirmado no
    * layout.json: baseClass = editbox) - txtEmail_EnviarPara e txtEmail_CC.
    * Os dois tem ScrollBars = 0 no SCX (comportam-se como campo de uma linha,
    * mas sem o SpecialEffect/visual de TextBox).
    *
    * Valores iniciais (equivalentes ao Init legado):
    *   thisform.ctnSaida_Email.txtEmail_EnviarPara.Value = thisform.oParentForm.Contaemail
    *   thisform.ctnSaida_Email.txtEmail_Assunto.Value = Iif(Type([pcAssunto]) = [C], pcAssunto, [])
    * Contaemail e' property do FORM CHAMADOR (fora deste acervo) - PEMSTATUS
    * antes de ler, mesmo padrao do CmdSairClick com pcArqEmail/oEmail. O
    * Assunto vem de this_cAssunto, que o Init do form ja resolveu com o mesmo
    * teste de tipo do legado (IIF(VARTYPE(par_cAssunto) = "C", par_cAssunto, "")),
    * entao aqui a atribuicao e' direta.
    * txtEmail_EnviarDE.Value (De) NAO e' preenchido aqui: no legado ele so
    * recebe valor DEPOIS da consulta a SigCdEmp (Thisform.CtnSaida_Email.
    * TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(TmpEmpMail.PadEmails,[])))),
    * que roda em CarregarContaEmailEmpresa() - escrito la, nao aqui, porque a
    * esta altura this_oBusinessObject.this_cEmailDe ainda esta vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposEmail()
        LOCAL loc_oErro, loc_cContaEmailPai, loc_oPainel

        TRY
            *-- AddObject SEMPRE fora de qualquer WITH, e cada WITH abaixo usa
            *-- o CAMINHO COMPLETO (nunca ".filho" aninhado dentro de outro
            *-- WITH) - WITH aninhado relativo apos AddObject falha em
            *-- resolver propriedade de Label/TextBox/EditBox em SILENCIO no
            *-- VFP9 (sem exception; Caption/ForeColor/Value nao sao
            *-- aplicados - ver licao sobre WITH aninhado em Container criado
            *-- por AddObject).
            loc_oPainel = THIS.cnt_4c_CtnSaida_Email

            *-- Label1 ("De:")
            loc_oPainel.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPainel.lbl_4c_Label1
                .Top       = 8
                .Left      = 47
                .Width     = 19
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "De:"
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 1
            ENDWITH

            *-- txtEmail_EnviarDE (De) - ReadOnly: preenchido so pela
            *-- consulta a SigCdEmp (CarregarContaEmailEmpresa)
            loc_oPainel.AddObject("txt_4c_TxtEmail_EnviarDE", "TextBox")
            WITH loc_oPainel.txt_4c_TxtEmail_EnviarDE
                .Top               = 5
                .Left              = 68
                .Width             = 404
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(239, 239, 239)
                .ToolTipText       = "Menu - Cadastro - Empresas ( Campo Email )"
                .TabIndex          = 2
                .Value             = ""
            ENDWITH

            *-- lbl_EmailPara ("Para:")
            loc_oPainel.AddObject("lbl_4c_Lbl_EmailPara", "Label")
            WITH loc_oPainel.lbl_4c_Lbl_EmailPara
                .Top       = 38
                .Left      = 38
                .Width     = 28
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Para:"
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 3
            ENDWITH

            *-- txtEmail_EnviarPara (Para) - EDITBOX (ScrollBars = 0)
            loc_oPainel.AddObject("obj_4c_TxtEmail_EnviarPara", "EditBox")
            WITH loc_oPainel.obj_4c_TxtEmail_EnviarPara
                .Top           = 35
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .TabIndex      = 4
                .Value         = ""
            ENDWITH

            *-- lblEmail_CC ("CC:")
            loc_oPainel.AddObject("lbl_4c_LblEmail_CC", "Label")
            WITH loc_oPainel.lbl_4c_LblEmail_CC
                .Top       = 68
                .Left      = 46
                .Width     = 20
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "CC:"
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 5
            ENDWITH

            *-- txtEmail_CC (CC) - EDITBOX (ScrollBars = 0)
            loc_oPainel.AddObject("obj_4c_TxtEmail_CC", "EditBox")
            WITH loc_oPainel.obj_4c_TxtEmail_CC
                .Top           = 65
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .TabIndex      = 6
                .Value         = ""
            ENDWITH

            *-- lblEmail_Assunto ("Assunto:")
            loc_oPainel.AddObject("lbl_4c_LblEmail_Assunto", "Label")
            WITH loc_oPainel.lbl_4c_LblEmail_Assunto
                .Top       = 99
                .Left      = 21
                .Width     = 45
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Assunto:"
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 7
            ENDWITH

            *-- txtEmail_Assunto (Assunto) - TEXTBOX de verdade no legado
            *-- (BaseClass: textbox no dump), ao contrario de Para/CC. Editavel:
            *-- o SCX nao declara ReadOnly aqui, so em EnviarDE.
            *-- Sem MaxLength e sem Format/InputMask de proposito: o SCX nao
            *-- declara nenhum dos tres, e o assunto nao vai para coluna de
            *-- tabela (entra no objeto de envio montado em memoria), logo nao
            *-- existe largura de schema de onde tirar um limite - inventar um
            *-- cortaria assunto longo que o legado aceita.
            loc_oPainel.AddObject("txt_4c_TxtEmail_Assunto", "TextBox")
            WITH loc_oPainel.txt_4c_TxtEmail_Assunto
                .Top           = 95
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .TabIndex      = 8
                .Value         = ""
            ENDWITH

            *-- lblEmail_Corpo ("Texto:")
            loc_oPainel.AddObject("lbl_4c_LblEmail_Corpo", "Label")
            WITH loc_oPainel.lbl_4c_LblEmail_Corpo
                .Top       = 127
                .Left      = 32
                .Width     = 34
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Texto:"
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 9
            ENDWITH

            *-- EdtEmail_Corpo (Texto) - EDITBOX de varias linhas (H = 53).
            *-- E' o UNICO EditBox do painel em que o SCX NAO declara
            *-- ScrollBars = 0, entao fica com o default do VFP9 (2 =
            *-- vertical) - nao se escreve a propriedade aqui justamente para
            *-- reproduzir a ausencia dela no dump: o corpo do e-mail e' o
            *-- campo que de fato precisa rolar.
            loc_oPainel.AddObject("obj_4c_EdtEmail_Corpo", "EditBox")
            WITH loc_oPainel.obj_4c_EdtEmail_Corpo
                .Top           = 125
                .Left          = 68
                .Width         = 404
                .Height        = 53
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .TabIndex      = 10
                .Value         = ""
            ENDWITH

            *-- "thisform.ctnSaida_Email.txtEmail_EnviarPara.Value =
            *-- thisform.oParentForm.Contaemail" - Contaemail e' property do
            *-- form CHAMADOR (fora deste acervo), por isso PEMSTATUS antes de
            *-- ler (mesmo padrao usado com pcArqEmail/oEmail em CmdSairClick)
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF PEMSTATUS(THIS.this_oFormPai, "Contaemail", 5)
                    loc_cContaEmailPai = ALLTRIM(TratarNulo(THIS.this_oFormPai.Contaemail, ""))
                    THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_EnviarPara.Value = loc_cContaEmailPai
                    THIS.this_oBusinessObject.this_cEmailPara                  = loc_cContaEmailPai
                ENDIF
            ENDIF

            *-- "thisform.ctnSaida_Email.txtEmail_Assunto.Value =
            *-- Iif(Type([pcAssunto]) = [C], pcAssunto, [])" - this_cAssunto ja
            *-- foi normalizado no Init do form com o mesmo teste de tipo
            THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_Assunto.Value = THIS.this_cAssunto
            THIS.this_oBusinessObject.this_cEmailAssunto             = THIS.this_cAssunto
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.ConfigurarCamposEmail")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBarraAcao - Cria a fileira de botoes de acao do topo direito
    * (Top = 3 no legado): optArquivo (PDF/Excel), Chk_EMAIL, Cmd_GerarPDF e
    * Cmd_SAIR. Estruturalmente e' o que o cnt_4c_Botoes e' num form CRUD, mas
    * aqui os controles ficam DIRETO no form, como no SCX legado (sem container
    * agrupador - ver layout.json).
    *
    * Criada DEPOIS de ConfigurarCabecalho de proposito: a faixa cinza
    * (cnt_4c_Sombra) ocupa Top = 0..80 com Width = 1100, logo estes controles
    * (Top = 3..78, Left = 420..800) ficam DENTRO da area dela e so aparecem se
    * forem criados depois - AddObject empilha o ultimo objeto por cima.
    *
    * Propriedades vindas da CLASSE fwoption (framework.vcx, lida como DBF) e
    * nao declaradas no SCX: no grupo, BackStyle = 0 e BorderStyle = 0; nos dois
    * OptionButton, BackStyle = 0, FontSize = 8 e DisabledForeColor =
    * 128,128,128. O SCX declara AutoSize = .T. no grupo, mas AutoSize e' no-op
    * em controle criado por AddObject - os Width = 161 / Height = 85 do SCX JA
    * SAO o auto-size que o Form Designer calculou (5 + 75 + 5 = 85), entao
    * fixa-los com AutoSize = .F. e' reproducao fiel, nao desvio. OptionGroup
    * NAO tem ForeColor: a cor mora em cada Buttons(N).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBarraAcao()
        LOCAL loc_oErro

        TRY
            *-- optArquivo: tipo do arquivo de saida (1 = PDF, 2 = XLS).
            *-- OptionGroup.Value e' INDICE 1-based, nunca booleano.
            THIS.AddObject("obj_4c_OptArquivo", "OptionGroup")
            WITH THIS.obj_4c_OptArquivo
                .Top         = -2
                .Left        = 420
                .Width       = 161
                .Height      = 85
                .ButtonCount = 2
                .AutoSize    = .F.
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .T.
                .TabIndex    = 1
                .Value       = 1

                WITH .Buttons(1)
                    .Top               = 5
                    .Left              = 5
                    .Width             = 75
                    .Height            = 75
                    .Style             = 1
                    .FontBold          = .T.
                    .FontItalic        = .T.
                    .FontName          = "Comic Sans MS"
                    .FontSize          = 8
                    .Caption           = "PDF"
                    .Picture           = gc_4c_CaminhoIcones + "pdf_60.png"
                    .DisabledPicture   = gc_4c_CaminhoIcones + "pdf_60.png"
                    .BackStyle         = 0
                    .BackColor         = RGB(255, 255, 255)
                    .ForeColor         = RGB(90, 90, 90)
                    .DisabledForeColor = RGB(128, 128, 128)
                    .Themes            = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top               = 5
                    .Left              = 81
                    .Width             = 75
                    .Height            = 75
                    .Style             = 1
                    .FontBold          = .T.
                    .FontItalic        = .T.
                    .FontName          = "Comic Sans MS"
                    .FontSize          = 8
                    .Caption           = "Excel"
                    .Picture           = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
                    .DisabledPicture   = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
                    .BackStyle         = 0
                    .BackColor         = RGB(255, 255, 255)
                    .ForeColor         = RGB(90, 90, 90)
                    .DisabledForeColor = RGB(128, 128, 128)
                    .Themes            = .F.
                ENDWITH
            ENDWITH
            BINDEVENT(THIS.obj_4c_OptArquivo, "Click", THIS, "OptArquivoClick")

            *-- Chk_EMAIL: liga/desliga o bloco de e-mail. CheckBox GRAFICO
            *-- (Style = 1) - .Value e' NUMERICO (0/1), nunca .T./.F.
            THIS.AddObject("chk_4c_Chk_EMAIL", "CheckBox")
            WITH THIS.chk_4c_Chk_EMAIL
                .Top        = 3
                .Left       = 575
                .Width      = 75
                .Height     = 75
                .Style      = 1
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Alignment  = 0
                .Caption    = "Email"
                .Picture    = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .TabIndex   = 2
                .Value      = 0
            ENDWITH
            BINDEVENT(THIS.chk_4c_Chk_EMAIL, "Click", THIS, "ChkEmailClick")

            *-- Cmd_GerarPDF: botao de confirmacao do dialogo. O Click dele e'
            *-- da fase de eventos; as checagens que ele faz sobre os campos do
            *-- painel de e-mail estao prontas em THIS.ValidarDadosEnvio() -
            *-- ver o roteiro das fases no cabecalho do arquivo.
            *-- O .Tag guarda o Caption de origem, igual ao
            *-- "Cmd_GerarPDF.Init: This.Tag = This.Caption" do legado.
            THIS.AddObject("cmd_4c_Cmd_GerarPDF", "CommandButton")
            WITH THIS.cmd_4c_Cmd_GerarPDF
                .Top             = 3
                .Left            = 650
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .F.
                .Alignment       = 6
                .PicturePosition = 13
                .Caption         = "   Gravar"
                .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .TabIndex        = 3
                .Tag             = .Caption
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Cmd_GerarPDF, "Click", THIS, "CmdGerarPDFClick")

            *-- Cmd_SAIR: Cancel = .T. faz o ESC aciona-lo. Como este form tem
            *-- TitleBar = 0 e ControlBox = .F., ele e' a UNICA saida da tela -
            *-- por isso o Click dele e' portado JA nesta fase.
            THIS.AddObject("cmd_4c_Cmd_SAIR", "CommandButton")
            WITH THIS.cmd_4c_Cmd_SAIR
                .Top             = 3
                .Left            = 725
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .ToolTipText     = "[ESC] - Sair"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .TabIndex        = 8
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Cmd_SAIR, "Click", THIS, "CmdSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.ConfigurarBarraAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAreaArquivoSaida - Cria a linha "Salvar em:" com o caminho do
    * arquivo de saida (lbl_SalvarEm + txtNomeArqSaida + cmdGetFile +
    * btnPastasA no legado).
    *
    * txt_4c_TxtNomeArqSaida e' ReadOnly = .T. no SCX: o caminho NAO e'
    * digitado, ele e' escrito pelo optArquivo (default) ou pelo GetFile() do
    * cmd_4c_CmdGetFile. Por isso o legado declara DisabledBackColor =
    * 255,255,255 (branco) - para o campo travado nao parecer desabilitado. O
    * SCX nao declara Format nem InputMask neste campo (nao ha o que
    * transcrever), e MaxLength tambem nao: e' caminho de arquivo, nao coluna
    * de tabela - inventar um limite aqui cortaria caminho longo.
    *
    * lbl_4c_Lbl_SalvarEm: o SCX declara AutoSize = .T. com Width = 53 /
    * Height = 15. AutoSize e' no-op em Label criado por AddObject, entao
    * transcreve-se AutoSize = .F. + os Width/Height do dump, que JA SAO o
    * auto-size calculado pelo Form Designer. Alignment = 0 e
    * ForeColor = 90,90,90 saem do legado (classe "say": texto a esquerda,
    * cinza - branco ficaria invisivel sobre o new_background.jpg claro).
    *
    * cmd_4c_BtnPastasA (classe fwbtnp do framework.vcx, lida como DBF):
    * MousePointer = 15, WordWrap = .T. e BackColor = 255,255,255 vem da
    * classe; Caption = "" e 40x32 sao os overrides do SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaArquivoSaida()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Lbl_SalvarEm", "Label")
            WITH THIS.lbl_4c_Lbl_SalvarEm
                .Top       = 109
                .Left      = 150
                .Width     = 53
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Salvar em:"
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 4
            ENDWITH

            THIS.AddObject("txt_4c_TxtNomeArqSaida", "TextBox")
            WITH THIS.txt_4c_TxtNomeArqSaida
                .Top               = 105
                .Left              = 205
                .Width             = 383
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(255, 255, 255)
                .TabIndex          = 5
                .Value             = ""
            ENDWITH

            *-- cmdGetFile: ". . ." - abre o GetFile(). Sem .Picture no legado,
            *-- por isso mantem Themes = .F. (o padrao canonico de
            *-- Themes = .T. vale para botao standalone COM icone).
            THIS.AddObject("cmd_4c_CmdGetFile", "CommandButton")
            WITH THIS.cmd_4c_CmdGetFile
                .Top        = 104
                .Left       = 589
                .Width      = 30
                .Height     = 25
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Caption    = ". . ."
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .TabIndex   = 6
            ENDWITH
            BINDEVENT(THIS.cmd_4c_CmdGetFile, "Click", THIS, "CmdGetFileClick")

            THIS.AddObject("cmd_4c_BtnPastasA", "CommandButton")
            WITH THIS.cmd_4c_BtnPastasA
                .Top             = 100
                .Left            = 619
                .Width           = 40
                .Height          = 32
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = ""
                .PicturePosition = 13
                .MousePointer    = 15
                .ToolTipText     = "Abrir o Diret" + CHR(243) + "rio / Pasta de Arquivos"
                .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .TabIndex        = 82
            ENDWITH
            BINDEVENT(THIS.cmd_4c_BtnPastasA, "Click", THIS, "BtnPastasAClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.ConfigurarAreaArquivoSaida")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarTipoArquivoPadrao - Reproduz as duas linhas do Init legado que
    * definem o tipo de arquivo inicial:
    *   thisform.optArquivo.option1.Enabled = <PDFCreator instalado?>
    *   thisform.optArquivo.Value = Iif(thisform.optArquivo.option1.Enabled,1,2)
    * A EXPRESSAO e' a do legado; o que mudou e' a ORIGEM do "PDFCreator
    * instalado?", que agora e' this_lPdfCreatorDisponivel do BO, resolvido
    * como .T. (ver "DIVERGENCIAS DELIBERADAS DO SCX" no cabecalho - a deteccao
    * por Registro/COM nao foi portada porque a geracao do PDF nao esta neste
    * acervo, e desabilitar PDF aqui mataria a tela).
    *--------------------------------------------------------------------------
    PROCEDURE AplicarTipoArquivoPadrao()
        LOCAL loc_lPdfDisponivel

        *-- Ponto UNICO a trocar se a deteccao real do PDFCreator for portada
        THIS.this_oBusinessObject.this_lPdfCreatorDisponivel = .T.
        loc_lPdfDisponivel = THIS.this_oBusinessObject.this_lPdfCreatorDisponivel

        THIS.obj_4c_OptArquivo.Buttons(1).Enabled = loc_lPdfDisponivel
        THIS.obj_4c_OptArquivo.Value              = IIF(loc_lPdfDisponivel, 1, 2)

        THIS.AplicarNomeArquivoPadrao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarNomeArquivoPadrao - Escreve no campo o nome default do arquivo de
    * saida para o tipo selecionado, equivalente ao
    *   thisform.txtNomeArqSaida.Value = ThisForm.Diretorio + [FORTYUSPDF.PDF]
    *                                  / ThisForm.Diretorio + [FORTYUSEXCEL.XLS]
    * do PROCEDURE Click do optArquivo legado. A montagem do nome fica no BO
    * (ObterNomeArquivoPadrao), que e' quem conhece o diretorio - fonte UNICA
    * para o Init e para o Click; o valor tambem e' guardado em
    * this_cArquivoSaida, que e' o que o Cmd_GerarPDF devolve ao form pai.
    *
    * Nota de fidelidade: o Init legado monta o nome com uma expressao um pouco
    * diferente do Click - "Diretorio + [FORTYUSPDF.] + Iif(Value = 1,[PDF],
    * [XLS])", isto e', no Init o XLS sairia como FORTYUSPDF.XLS e no Click como
    * FORTYUSEXCEL.XLS. Com o default Value = 1 as duas expressoes dao o MESMO
    * resultado (FORTYUSPDF.PDF), logo usar a do Click aqui nao muda nada hoje;
    * a divergencia so apareceria se a opcao PDF nascesse desabilitada, o que
    * depende da deteccao do PDFCreator que nao foi portada (ver cabecalho).
    *--------------------------------------------------------------------------
    PROCEDURE AplicarNomeArquivoPadrao()
        LOCAL loc_cArquivo

        THIS.this_oBusinessObject.this_nTipoArquivo = THIS.obj_4c_OptArquivo.Value

        loc_cArquivo = THIS.this_oBusinessObject.ObterNomeArquivoPadrao( ;
                           THIS.this_oBusinessObject.this_nTipoArquivo)

        THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
        THIS.txt_4c_TxtNomeArqSaida.Value            = loc_cArquivo
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPainelEmail - Mostra/esconde o bloco de e-mail esticando ou
    * encolhendo o form na ALTURA DO CONTAINER, equivalente ao PROCEDURE Click
    * do Chk_EMAIL legado:
    *   ThisForm.LockScreen = .T.
    *   If This.Value = 1
    *       ThisForm.Cmd_GerarPDF.Caption = "Enviar Email"
    *       ThisForm.Height = ThisForm.Height + ThisForm.CtnSaida_Email.Height
    *       ThisForm.CtnSaida_Email.Visible = .T.
    *   Else
    *       ThisForm.Cmd_GerarPDF.Caption = [\<Gravar]
    *       ThisForm.Height = ThisForm.Height - ThisForm.CtnSaida_Email.Height
    *       ThisForm.CtnSaida_Email.Visible = .F.
    *   EndIf
    *   ThisForm.Refresh() / ThisForm.LockScreen = .F.
    * e tambem ao colapso inicial do Init ("Thisform.Height = This.Height -
    * This.CtnSaida_Email.Height" + "CtnSaida_Email.Visible = .F."), que e' a
    * pendencia que a Fase 3 deixou anotada. O mesmo metodo serve aos dois
    * porque o legado faz exatamente a mesma conta nos dois lugares (360 - 185
    * = 175 colapsado; 175 + 185 = 360 expandido).
    *
    * A troca do Caption do Cmd_GerarPDF NAO esta aqui, e sim no
    * ChkEmailClick: no legado ela existe SO dentro do Chk_EMAIL.Click - o
    * colapso do Init nao mexe no Caption. Com a troca aqui dentro, o Init
    * (que chama este metodo com .F.) sobrescrevia "   Gravar" por "\<Gravar"
    * e a tela ja abria com o rotulo do estado alternado, perdendo os espacos
    * que alinham o texto com o icone - medido no VFP9 em 2026-10-18.
    *
    * A altura so muda quando o estado REALMENTE muda - chamar duas vezes
    * seguidas com o mesmo valor nao encolhe a tela duas vezes (o legado nao
    * precisava desse cuidado porque o Click so dispara quando o usuario
    * alterna, mas aqui o Init tambem chama). O estado comparado e'
    * this_lPainelEmailVisivel, que nasce .T. por refletir a ALTURA DE PROJETO
    * do SCX - e NAO o cnt_4c_CtnSaida_Email.Visible, que nasce .F. (ver a
    * declaracao da property: usar o Visible como guarda transforma o colapso
    * do Init em no-op silencioso).
    *
    * Caption: o Else legado restaura o literal "\<Gravar" (com o "\<" de tecla
    * de atalho do VFP), e NAO o Caption de origem "   Gravar" - a alternativa
    * via Tag esta comentada no proprio fonte legado ("&&ThisForm.Cmd_OK.Tag").
    * Transcrito como esta no legado, inclusive a perda dos espacos de
    * alinhamento com o icone.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPainelEmail(par_lMostrar)
        LOCAL loc_lMostrar, loc_nAlturaPainel, loc_oErro

        loc_lMostrar = IIF(VARTYPE(par_lMostrar) = "L", par_lMostrar, .F.)

        TRY
            IF loc_lMostrar != THIS.this_lPainelEmailVisivel
                loc_nAlturaPainel = THIS.cnt_4c_CtnSaida_Email.Height

                THIS.LockScreen = .T.

                *-- Protege o que o legado protege com "AutoCenter = .F." no
                *-- fim do Init: a janela nao deve se recentralizar a cada
                *-- colapso/expansao do painel. SO com a tela ja visivel: se
                *-- fosse desligado durante o Init (onde Visible ainda e' .F.,
                *-- porque o Show() vem depois), o dialogo JA COLAPSADO nasceria
                *-- em Top = 0 / Left = 0 em vez de centralizado.
                IF THIS.Visible
                    THIS.AutoCenter = .F.
                ENDIF

                IF loc_lMostrar
                    THIS.Height                        = THIS.Height + loc_nAlturaPainel
                    THIS.cnt_4c_CtnSaida_Email.Visible = .T.
                ELSE
                    THIS.Height                        = THIS.Height - loc_nAlturaPainel
                    THIS.cnt_4c_CtnSaida_Email.Visible = .F.
                ENDIF

                THIS.this_lPainelEmailVisivel = loc_lMostrar

                *-- Equivalente a "ThisForm.Chk_EMAIL.Value = 1" que o
                *-- Cmd_GerarPDF.Click legado consulta para decidir se monta o
                *-- objeto de envio
                THIS.this_oBusinessObject.this_lEnviarEmail = loc_lMostrar

                THIS.Refresh()
                THIS.LockScreen = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.AlternarPainelEmail")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarContaEmailEmpresa - Equivalente ao trecho final do Init legado:
    *   lcQuery = [Select PadEmails, PadServs, PadSenhas, pastas, PadPortas
    *              From SigCdEmp Where CEmps = '] + _EMPR + [']
    *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEmpMail') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexao (TmpEmpMail)')
    *       Return .f.
    *   Endif
    * A consulta propriamente dita esta no BO (ObterDadosContaEmail), que ja
    * trata o cursor e mapeia as colunas em CarregarDoCursor. A empresa vem de
    * go_4c_Sistema.cCodEmpresa - a global legada _EMPR NUNCA deve ser usada.
    *
    * Retorna .F. quando a consulta falha, reproduzindo o "Return .f." do
    * legado - isto e', a tela NAO abre, porque sem os dados de SMTP o envio de
    * e-mail nao teria como funcionar. Em modo de validacao de UI (sem conexao
    * SQL) a consulta e' pulada e o retorno e' .T., senao nenhuma validacao
    * conseguiria instanciar o form.
    *
    * O preenchimento visual que o legado faz em seguida
    * ("CtnSaida_Email.TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(
    * TmpEmpMail.PadEmails,[])))") agora fica aqui: txt_4c_TxtEmail_EnviarDE
    * (criado em ConfigurarCamposEmail, que roda ANTES deste metodo no
    * InicializarForm) recebe this_cEmailDe so DEPOIS da consulta - exatamente
    * como no legado, onde a atribuicao vem depois do
    * "SqlExecute(lcQuery, 'TmpEmpMail')".
    *--------------------------------------------------------------------------
    PROCEDURE CarregarContaEmailEmpresa()
        LOCAL loc_lSucesso, loc_cEmpresa

        loc_lSucesso = .T.

        IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
            loc_cEmpresa = ""
            IF TYPE("go_4c_Sistema") = "O"
                loc_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF

            IF !THIS.this_oBusinessObject.ObterDadosContaEmail(loc_cEmpresa)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Falha na Conex" + CHR(227) + "o (TmpEmpMail)")
                loc_lSucesso = .F.
            ELSE
                THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_EnviarDE.Value = ;
                    THIS.this_oBusinessObject.this_cEmailDe
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarCamposParaBO - Espelha TELA -> BO todos os controles de entrada
    * do dialogo. PUBLIC: chamado por ValidarDadosEnvio() e pela fase de eventos
    * (o Click do cmd_4c_Cmd_GerarPDF, que precisa dos valores no BO para
    * MontarDadosEnvioEmail()).
    *
    * Por que o CONTROLE e' a fonte unica do valor: o Cmd_GerarPDF.Click legado
    * nao consulta estado guardado em lugar nenhum, ele le o .Value na hora -
    *   ThisForm.oParentForm.pcArqEmail = Alltrim(Nvl(This.Parent.TxtNomeArqSaida.Value, ""))
    *   lcFrom = AllTrim(Nvl(ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.Value,   ""))
    *   lcTO   = AllTrim(Nvl(ThisForm.CtnSaida_Email.txtEmail_EnviarPara.Value, ""))
    *   ...AddProperty("cCC",      AllTrim(Nvl(...txtEmail_CC.Value, "")))
    *   ...AddProperty("cAssunto", AllTrim(Nvl(...txtEmail_Assunto.Value, "")))
    *   ...AddProperty("cCorpo",   AllTrim(Nvl(...EdtEmail_Corpo.Value, "")))
    *   If ThisForm.Chk_EMAIL.Value = 1
    * Validar contra a property do BO sem reler a tela antes validaria o valor
    * ANTIGO - o usuario limparia o campo 'PARA:' e a tela aprovaria o e-mail
    * que estava la na abertura. O ALLTRIM/TratarNulo reproduz o Alltrim(Nvl())
    * de cada linha acima.
    *
    * Chk_EMAIL.Value e' NUMERICO (CheckBox criado por AddObject): compara-se
    * com 1 para virar o Logico this_lEnviarEmail - atribuir o numero direto a
    * uma property declarada .F. faria o proximo AND no BO estourar.
    * obj_4c_OptArquivo.Value e' o INDICE 1-based do OptionGroup (1 = PDF,
    * 2 = XLS), nunca booleano.
    *--------------------------------------------------------------------------
    PROCEDURE SincronizarCamposParaBO()
        LOCAL loc_oBO, loc_oPainel

        loc_oBO     = THIS.this_oBusinessObject
        loc_oPainel = THIS.cnt_4c_CtnSaida_Email

        loc_oBO.this_cArquivoSaida = ALLTRIM(TratarNulo(THIS.txt_4c_TxtNomeArqSaida.Value, ""))
        loc_oBO.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
        loc_oBO.this_lEnviarEmail  = (THIS.chk_4c_Chk_EMAIL.Value = 1)

        loc_oBO.this_cEmailDe      = ALLTRIM(TratarNulo(loc_oPainel.txt_4c_TxtEmail_EnviarDE.Value, ""))
        loc_oBO.this_cEmailPara    = ALLTRIM(TratarNulo(loc_oPainel.obj_4c_TxtEmail_EnviarPara.Value, ""))
        loc_oBO.this_cEmailCC      = ALLTRIM(TratarNulo(loc_oPainel.obj_4c_TxtEmail_CC.Value, ""))
        loc_oBO.this_cEmailAssunto = ALLTRIM(TratarNulo(loc_oPainel.txt_4c_TxtEmail_Assunto.Value, ""))
        loc_oBO.this_cEmailCorpo   = ALLTRIM(TratarNulo(loc_oPainel.obj_4c_EdtEmail_Corpo.Value, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosEnvio - Reproduz as checagens BLOQUEANTES que o
    * Cmd_GerarPDF.Click legado faz sobre os campos desta tela, na mesma ordem,
    * com a mesma mensagem e o mesmo SetFocus:
    *   If Empty( ThisForm.oParentForm.pcArqEmail)
    *       MessageBox([Selecione um nome para o arquivo!], 48, [Atencao])
    *       This.Parent.CmdGetFile.SetFocus() / Return
    *   If ThisForm.Chk_EMAIL.Value = 1
    *       If Empty( lcFrom )
    *           MessageBox("O campo 'DE:' nao foi preenchido.", 48, "Atencao")
    *           ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.SetFocus() / Return
    *       If Empty( lcTO )
    *           MessageBox("O campo 'PARA:' nao foi preenchido.", 48, "Atencao")
    *           ThisForm.CtnSaida_Email.txtEmail_EnviarPara.SetFocus() / Return
    * Devolve .T. quando passou e .F. quando recusou (ja tendo exibido a
    * mensagem e dado o foco), para a fase de eventos escrever
    * "IF !THIS.ValidarDadosEnvio() / RETURN / ENDIF" no Click do botao.
    *
    * PUBLIC porque e' chamado de fora (pelo handler do cmd_4c_Cmd_GerarPDF).
    *
    * FONTE UNICA DA REGRA: o texto e a ORDEM das tres checagens moram em
    * sigprpdfBO.ValidarDadosConfirmacao(), que e' quem para na PRIMEIRA falha e
    * devolve this_cMensagemErro + this_cCampoInvalido. Aqui fica so o que o BO
    * nao pode fazer: ler a tela ANTES de validar (SincronizarCamposParaBO) e
    * dar o foco ao campo recusado.
    *
    * MsgAviso, nao MsgErro: o legado usa MessageBox(..., 48, ...), isto e',
    * icone de AVISO - e sao recusas de preenchimento (validacao de tela), nao
    * falha tecnica. MESSAGEBOX direto e' proibido (nao se suprime em teste).
    *
    * O QUE NAO E' REPRODUZIDO AQUI, e por que: o legado envolve as checagens de
    * 'DE:'/'PARA:' num gate a mais - "If Used('TmpEmpMail') And
    * RecCount('TmpEmpMail') > 0" - e, SEM a conta de e-mail da empresa, nao
    * valida os dois campos: cai no Else, exibe "Problemas na selecao de dados
    * do email..." (sem Return) e fecha o dialogo. Esse ramo e' inalcancavel na
    * arquitetura nova: a consulta a SigCdEmp roda no InicializarForm
    * (CarregarContaEmailEmpresa) e, falhando, devolve .F. - o form NAO ABRE,
    * igual ao "Return .f." do Init legado. Ou seja, com a tela aberta
    * this_lContaEmailCarregada e' sempre .T. e o gate e' sempre verdadeiro. O
    * aviso nao-bloqueante continua existindo e e' da fase de eventos, que ja
    * tem no BO ObterMensagemContaEmailIndisponivel() + this_lContaEmailCarregada
    * para exibi-lo sem impedir o fechamento.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDadosEnvio()
        LOCAL loc_lValido, loc_oBO, loc_oErro

        loc_lValido = .F.

        TRY
            THIS.SincronizarCamposParaBO()

            loc_oBO     = THIS.this_oBusinessObject
            loc_lValido = loc_oBO.ValidarDadosConfirmacao()

            IF !loc_lValido
                MsgAviso(loc_oBO.this_cMensagemErro, ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                THIS.FocarCampoInvalido(loc_oBO.this_cCampoInvalido)
            ENDIF
        CATCH TO loc_oErro
            loc_lValido = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.ValidarDadosEnvio")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarCampoInvalido - Devolve o foco ao controle recusado pela validacao,
    * traduzindo o this_cCampoInvalido que o BO preenche para o controle
    * correspondente da tela. Os tres destinos sao os do legado:
    *   ARQUIVO    -> This.Parent.CmdGetFile.SetFocus()
    *                 (o legado foca o BOTAO de escolha, nao o campo - o campo
    *                 e' ReadOnly, nao ha o que digitar nele)
    *   EMAIL_DE   -> ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.SetFocus()
    *   EMAIL_PARA -> ThisForm.CtnSaida_Email.txtEmail_EnviarPara.SetFocus()
    *
    * Os dois destinos do painel so sao alcancados quando this_lEnviarEmail =
    * .T., caso em que o painel esta expandido; o IF .Visible esta aqui porque
    * SetFocus em controle dentro de container oculto estoura em runtime, e
    * perder o foco nunca pode custar a mensagem de validacao que o usuario
    * precisa ler.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarCampoInvalido(par_cCampo)
        LOCAL loc_cCampo, loc_oPainel

        loc_cCampo  = UPPER(ALLTRIM(TratarNulo(par_cCampo, "")))
        loc_oPainel = THIS.cnt_4c_CtnSaida_Email

        DO CASE
            CASE loc_cCampo == "ARQUIVO"
                THIS.cmd_4c_CmdGetFile.SetFocus()
            CASE loc_cCampo == "EMAIL_DE"
                IF loc_oPainel.Visible
                    loc_oPainel.txt_4c_TxtEmail_EnviarDE.SetFocus()
                ENDIF
            CASE loc_cCampo == "EMAIL_PARA"
                IF loc_oPainel.Visible
                    loc_oPainel.obj_4c_TxtEmail_EnviarPara.SetFocus()
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGerarPDFClick - PROCEDURE Click do Cmd_GerarPDF legado:
    *   ThisForm.oParentForm.pcArqEmail = Alltrim(Nvl(This.Parent.TxtNomeArqSaida.Value, ""))
    *   If Empty(ThisForm.oParentForm.pcArqEmail)
    *       MessageBox([Selecione um nome para o arquivo!], 48, [Atencao])
    *       This.Parent.CmdGetFile.SetFocus() / Return
    *   EndIf
    *   If ThisForm.Chk_EMAIL.Value = 1
    *       If Used("TmpEmpMail") And RecCount("TmpEmpMail") > 0
    *           ** valida 'DE:'/'PARA:', monta o objeto de envio (AddProperty) e
    *           ** grava em ThisForm.oParentForm.oEMAIL
    *       Else
    *           MessageBox("Problemas na selecao de dados do email...", 48, "Atencao")
    *           ** SEM Return - o legado fecha o dialogo mesmo assim
    *       EndIf
    *   EndIf
    *   ThisForm.Release()
    * PUBLIC (alvo de BINDEVENT).
    *
    * As duas checagens bloqueantes do legado (arquivo vazio / 'DE:'-'PARA:'
    * vazios quando Chk_EMAIL esta marcado) sao as mesmas que
    * THIS.ValidarDadosEnvio() ja reproduz - ela sincroniza a tela com o BO,
    * chama ValidarDadosConfirmacao() e da o foco ao campo recusado.
    * Falhando, o RETURN aqui e' o equivalente aos dois "Return" do legado -
    * ANTES do TRY, nunca dentro (RETURN dentro de TRY/CATCH e' proibido).
    *
    * O terceiro caso do legado ("Used('TmpEmpMail') And RecCount('TmpEmpMail')
    * > 0" = .F.) NAO bloqueia: exibe o aviso e fecha o dialogo mesmo assim.
    * Na arquitetura nova esse ramo e' praticamente inalcancavel com a tela
    * aberta (this_lContaEmailCarregada e' sempre .T. - a consulta que o
    * alimenta roda no InicializarForm e, falhando, o form nao abre - ver nota
    * em ValidarDadosEnvio), mas o aviso nao-bloqueante e' reproduzido do
    * mesmo jeito via ObterMensagemContaEmailIndisponivel(), para o caso
    * defensivo de this_lContaEmailCarregada estar .F. com a tela ja visivel.
    *
    * pcArqEmail/oEmail sao properties do form PAI (fora deste acervo) - mesmo
    * padrao de PEMSTATUS usado em CmdSairClick: so se escreve se existirem.
    *--------------------------------------------------------------------------
    PROCEDURE CmdGerarPDFClick()
        LOCAL loc_oPai, loc_oBO, loc_oEmail, loc_oErro

        IF !THIS.ValidarDadosEnvio()
            RETURN
        ENDIF

        TRY
            loc_oPai = THIS.this_oFormPai
            loc_oBO  = THIS.this_oBusinessObject

            IF VARTYPE(loc_oPai) = "O"
                IF PEMSTATUS(loc_oPai, "pcArqEmail", 5)
                    loc_oPai.pcArqEmail = loc_oBO.this_cArquivoSaida
                ENDIF

                IF loc_oBO.this_lEnviarEmail
                    IF loc_oBO.this_lContaEmailCarregada
                        loc_oEmail = loc_oBO.MontarDadosEnvioEmail()
                        IF PEMSTATUS(loc_oPai, "oEmail", 5)
                            loc_oPai.oEmail = loc_oEmail
                        ENDIF
                    ELSE
                        MsgAviso(loc_oBO.ObterMensagemContaEmailIndisponivel(), ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.CmdGerarPDFClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkEmailClick - PROCEDURE Click do Chk_EMAIL legado. PUBLIC (alvo de
    * BINDEVENT). CheckBox.Value e' NUMERICO: compara-se com 1, nunca com .T.
    *
    * O Caption do Cmd_GerarPDF e' trocado AQUI porque no legado ele so muda
    * dentro deste Click (o colapso do Init nao o toca - ver nota em
    * AlternarPainelEmail). O literal "\<Gravar" do ramo Else e' transcrito como
    * esta no legado, inclusive sem os espacos de alinhamento do Caption de
    * origem "   Gravar" e com o "\<" de tecla de atalho do VFP - o proprio
    * fonte legado deixa a alternativa via Tag COMENTADA ("&&ThisForm.Cmd_OK.Tag").
    *--------------------------------------------------------------------------
    PROCEDURE ChkEmailClick()
        LOCAL loc_lMarcado

        loc_lMarcado = (THIS.chk_4c_Chk_EMAIL.Value = 1)

        THIS.cmd_4c_Cmd_GerarPDF.Caption = IIF(loc_lMarcado, "Enviar Email", "\<Gravar")

        THIS.AlternarPainelEmail(loc_lMarcado)
    ENDPROC

    *--------------------------------------------------------------------------
    * OptArquivoClick - PROCEDURE Click do optArquivo legado: trocar entre PDF
    * e Excel reescreve o nome default do arquivo de saida. PUBLIC (alvo de
    * BINDEVENT). O parametro existe porque o Click de OptionGroup pode receber
    * o indice do botao acionado (handler de BINDEVENT declara os parametros do
    * evento).
    *--------------------------------------------------------------------------
    PROCEDURE OptArquivoClick(par_nIndiceBotao)
        THIS.AplicarNomeArquivoPadrao()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGetFileClick - PROCEDURE Click do cmdGetFile legado:
    *   lcTpArq    = Iif(thisform.optArquivo.Value = 1,[PDF],[XLS])
    *   lcArqSaida = GetFile( lcTpArq, [Arquivo:],[Selecionar],0,[Selecione o arquivo])
    *   If isEmpty( lcArqSaida ) / Return / EndIf
    *   If JUSTEXT(lcArqSaida) $ lcTpArq / ** extensao valida
    *   Else / lcArqSaida = ForceExt(lcArqSaida, Left( lcTpArq, 3 )) / EndIf
    *   ThisForm.TxtNomeArqSaida.Value = Alltrim( lcArqSaida )
    * PUBLIC (alvo de BINDEVENT).
    *
    * O "isEmpty" do legado e' funcao global do framework Fortyus; em codigo
    * nosso usa-se EMPTY() direto (ISEMPTY nao existe no VFP9 - o wrapper
    * utils\isempty.prg existe so para o p-code dos VCX legado). JUSTEXT e
    * FORCEEXT sao nativas do VFP9, nao helpers do legado.
    *
    * Cancelar o dialogo de arquivo NAO limpa o campo: o legado so devolve sem
    * mexer, mantendo o caminho que ja estava la. O early "Return" do legado
    * virou o IF !EMPTY(...) porque RETURN dentro de TRY/CATCH e' proibido.
    *--------------------------------------------------------------------------
    PROCEDURE CmdGetFileClick()
        LOCAL loc_cTipoArq, loc_cArqSaida, loc_oErro

        TRY
            loc_cTipoArq  = IIF(THIS.obj_4c_OptArquivo.Value = 1, "PDF", "XLS")
            loc_cArqSaida = GETFILE(loc_cTipoArq, "Arquivo:", "Selecionar", 0, ;
                                    "Selecione o arquivo")

            IF !EMPTY(loc_cArqSaida)
                *-- Extensao diferente da escolhida no optArquivo: forca a certa
                IF !(JUSTEXT(loc_cArqSaida) $ loc_cTipoArq)
                    loc_cArqSaida = FORCEEXT(loc_cArqSaida, LEFT(loc_cTipoArq, 3))
                ENDIF

                loc_cArqSaida = ALLTRIM(loc_cArqSaida)

                THIS.txt_4c_TxtNomeArqSaida.Value            = loc_cArqSaida
                THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArqSaida
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.CmdGetFileClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPastasAClick - PROCEDURE Click do btnPastasA legado: abre o diretorio
    * de saida no Explorer.
    *   lcDir = ThisForm.Diretorio
    *   If Not Empty(lcDir)
    *       If Not Directory(lcDir) / MessageBox([Diretorio nao Localizado],0+64,[Atencao])
    *       Else / loApp = CreateObject([Shell.Application]) / loApp.Open(lcDir) / EndIf
    *   EndIf
    * PUBLIC (alvo de BINDEVENT). O diretorio vem de this_cDiretorio do BO
    * (equivalente a ThisForm.Diretorio, resolvido no InicializarForm a partir
    * de go_4c_Sistema.DirFiscais).
    *
    * A mensagem de diretorio ausente e' validacao de tela, logo MsgAviso -
    * MESSAGEBOX direto e' proibido (nao se suprime em teste automatizado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnPastasAClick()
        LOCAL loc_cDir, loc_oShell, loc_oErro

        TRY
            loc_cDir = ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cDiretorio, ""))

            IF !EMPTY(loc_cDir)
                IF !DIRECTORY(loc_cDir)
                    MsgAviso("Diret" + CHR(243) + "rio n" + CHR(227) + "o Localizado", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_oShell = CREATEOBJECT("Shell.Application")
                    loc_oShell.Open(loc_cDir)
                    loc_oShell = .NULL.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.BtnPastasAClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - PROCEDURE Click do Cmd_SAIR legado:
    *   thisform.oparentform.pcArqEmail = []
    *   thisform.oparentform.oEmail = Null
    *   ThisForm.Release()
    * PUBLIC (alvo de BINDEVENT). Cancelar o dialogo LIMPA o resultado no form
    * pai - e' assim que o chamador distingue "cancelou" de "confirmou" (o
    * Cmd_GerarPDF e' que grava o caminho e o objeto de envio).
    *
    * As duas properties sao do form PAI (pcArqEmail / oEmail), criadas por
    * ele; so se escreve nelas se existirem. O PEMSTATUS aqui nao mascara
    * defeito nosso - e' nao assumir a superficie de um form que nao faz parte
    * deste acervo (este dialogo e' chamado por varios).
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        LOCAL loc_oPai, loc_oErro

        TRY
            loc_oPai = THIS.this_oFormPai

            IF VARTYPE(loc_oPai) = "O"
                IF PEMSTATUS(loc_oPai, "pcArqEmail", 5)
                    loc_oPai.pcArqEmail = ""
                ENDIF
                IF PEMSTATUS(loc_oPai, "oEmail", 5)
                    loc_oPai.oEmail = .NULL.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Formsigprpdf.CmdSairClick")
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles do form,
    * percorrendo containers e paginas de PageFrame recursivamente. AddObject
    * cria controles com Visible = .F. por padrao.
    *
    * cnt_4c_CtnSaida_Email e' container FLUTUANTE (nasce oculto e e' alternado
    * pelo Chk_EMAIL): o .Visible DELE nao pode ser ligado aqui. Mas a recursao
    * TEM de acontecer mesmo assim, para os filhos dele ficarem com
    * Visible = .T. - senao, quando o usuario marca Email, o painel aparece
    * VAZIO (os campos continuariam invisiveis para sempre).
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Container flutuante: recursa nos filhos, NAO liga o proprio
                IF UPPER(ALLTRIM(loc_oObjeto.Name)) == "CNT_4C_CTNSAIDA_EMAIL"
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * Destroy - Libera o Business Object (que por sua vez libera o cursor de
    * trabalho aberto - ver sigprpdfBO.Destroy)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprpdfBO.prg):
*==============================================================================
* SIGPRPDFBO.PRG
* Business Object do formulario Formsigprpdf (Geracao de PDF e E-mail)
* Herda de: BusinessBase
*
* SIGPRPDF e um DIALOGO FILHO (WindowType = 1, modal), instanciado por outro
* form (par_oFormPai, equivalente a poformParent/ThisForm.oParentForm do
* legado) para o usuario escolher o nome/tipo do arquivo de saida (PDF ou
* XLS) e, opcionalmente, os dados do e-mail de envio. O proprio SIGPRPDF
* NAO gera o PDF/XLS nem envia o e-mail - o Cmd_GerarPDF.Click legado (linhas
* 749-823 do fonte original) apenas:
*   1) grava o caminho escolhido em ThisForm.oParentForm.pcArqEmail;
*   2) quando Chk_EMAIL.Value = 1, monta um objeto CUSTOM
*      (ThisForm.oParentForm.oEMAIL) com os dados de SMTP/mensagem via
*      AddProperty, e devolve esse objeto ao form PAI;
*   3) fecha o dialogo (ThisForm.Release()).
* Quem efetivamente gera o arquivo e dispara o envio e o form chamador
* (fora do escopo desta migracao - nao faz parte do acervo de SIGPRPDF).
*
* POR QUE this_cTabela/this_cCampoChave FICAM VAZIOS
* ---------------------------------------------------
* Nao ha CRUD nem PK proprios: a UNICA leitura ao SQL Server no Init legado
* e "Select PadEmails, PadServs, PadSenhas, pastas, PadPortas From SigCdEmp
* Where CEmps = <empresa>" (dados da conta de e-mail da empresa, colunas
* reais conferidas em docs/schema.sql - tabela sigcdemp: pademails,
* padservs, padsenhas, pastas, padportas). Nao ha Insert/Update/Delete em
* tabela nenhuma - por isso este BO (como o sigpremaBO irmao) nao sobrescreve
* Inserir()/Atualizar()/ExecutarExclusao(): o comportamento padrao herdado de
* BusinessBase (recusar a operacao) ja e o correto para esta tela.
*
* REGISTRY1 / PDFCREATOR (optArquivo.Option1.Enabled) - DECISAO DEFERIDA
* ------------------------------------------------------------------------
* O legado habilita a opcao "PDF" conforme
* "ThisForm.Registry1.IsKey('PDFCreator.clsPDFCreator') Or
* ThisForm.Registry1.IsKey('PDFCreatorBeta.JobQueue')" (deteccao de instalacao
* do PDFCreator via COM/Registro do Windows). O form irmao Formsigprema ja
* documentou a mesma checagem como NAO PORTADA (ver cabecalho de
* Formsigprema.prg) porque a geracao do PDF via PDFCreator esta fora do
* escopo do acervo migrado. A property this_lPdfCreatorDisponivel fica
* declarada aqui para a fase de Form decidir como resolve-la (registro real,
* sempre .T., ou configuravel) - Fase 1 so declara, nao decide.
*==============================================================================

DEFINE CLASS sigprpdfBO AS BusinessBase

    *-- Referencia ao form que instanciou este dialogo (equivalente a
    *-- ThisForm.oParentForm / par_oFormPai do legado) - usado para devolver
    *-- o caminho do arquivo escolhido (pcArqEmail) e os dados de envio
    *-- (oEMAIL) de volta ao chamador, e para ler o e-mail de destino inicial
    *-- (par_oFormPai.Contaemail)
    this_oFormPai = .NULL.

    *-- Diretorio padrao de saida (equivalente a ThisForm.Diretorio =
    *-- goSistema.DirFiscais), usado tanto para montar o nome default do
    *-- arquivo (FORTYUSPDF.PDF / FORTYUSEXCEL.XLS) quanto para abrir a
    *-- pasta via btnPastasA (CreateObject('Shell.Application').Open)
    this_cDiretorio = ""

    *-- Tipo de arquivo de saida (equivalente a optArquivo.Value - indice
    *-- 1-based do OptionGroup, NUNCA booleano): 1 = PDF, 2 = XLS
    this_nTipoArquivo = 1

    *-- .T. quando o PDFCreator (COM) esta disponivel na maquina
    *-- (equivalente a optArquivo.Option1.Enabled, resolvido via
    *-- Registry1.IsKey no legado - ver nota no cabecalho deste arquivo).
    *-- Resolucao definitiva fica para a fase do Form.
    this_lPdfCreatorDisponivel = .F.

    *-- Caminho completo do arquivo escolhido pelo usuario (equivalente a
    *-- txtNomeArqSaida.Value) - e o valor devolvido como
    *-- ThisForm.oParentForm.pcArqEmail ao confirmar (Cmd_GerarPDF.Click) e
    *-- tambem o anexo do e-mail (cAnexo) quando o envio esta habilitado
    this_cArquivoSaida = ""

    *-- .T. quando o usuario marcou a opcao de enviar e-mail (equivalente a
    *-- Chk_EMAIL.Value = 1) - controla a exibicao de CtnSaida_Email e se
    *-- Cmd_GerarPDF.Click monta o objeto de envio (oEMAIL) no form pai
    this_lEnviarEmail = .F.

    *-- Campos do bloco de e-mail (CtnSaida_Email), equivalentes a
    *-- cFrom/cTO/cCC/cAssunto/cCorpo do objeto oEMAIL montado no legado
    this_cEmailDe       = ""   && txtEmail_EnviarDE.Value (ReadOnly - preenchido com this_cEmpPadEmails)
    this_cEmailPara     = ""   && txtEmail_EnviarPara.Value (inicial: par_oFormPai.Contaemail)
    this_cEmailCC       = ""   && txtEmail_CC.Value
    this_cEmailAssunto  = ""   && txtEmail_Assunto.Value (inicial: par_cAssunto recebido no Init do form)
    this_cEmailCorpo    = ""   && EdtEmail_Corpo.Value

    *-- Dados da conta de e-mail da empresa (SigCdEmp.Cemps = empresa
    *-- corrente), equivalentes ao cursor TmpEmpMail do legado - colunas
    *-- reais conferidas em docs/schema.sql: pademails, padservs, padsenhas,
    *-- pastas, padportas
    this_cEmpPadEmails = ""   && pademails - conta remetente/usuario SMTP (cSendUserName/cFrom)
    this_cEmpPadServs  = ""   && padservs - servidor SMTP (cSmtpServer)
    this_cEmpPadSenhas = ""   && padsenhas - senha SMTP (cSendPassWord)
    this_cEmpPastas    = ""   && pastas - selecionada pelo legado (TmpEmpMail.pastas) mas nunca referenciada depois do Select; mantida so para rastrear a mesma consulta
    this_nEmpPadPortas = 0    && padportas - porta SMTP (nSmtpServerPort)

    *-- .T. apos ObterDadosContaEmail() carregar com sucesso os dados de
    *-- SigCdEmp (equivalente a "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0"
    *-- checado no Cmd_GerarPDF.Click legado antes de montar o objeto oEMAIL)
    this_lContaEmailCarregada = .F.

    *-- Identifica qual campo falhou na ultima chamada a
    *-- ValidarDadosConfirmacao() - "ARQUIVO" | "EMAIL_DE" | "EMAIL_PARA" |
    *-- "EMAIL_CONTA" | "" (sem falha). O Form usa isto so para decidir o
    *-- SetFocus, igual ao This.Parent.CmdGetFile.SetFocus() /
    *-- TxtEmail_EnviarDE.SetFocus() / txtEmail_EnviarPara.SetFocus() do
    *-- Cmd_GerarPDF.Click legado - a mensagem em si vai em this_cMensagemErro
    *-- (ja declarada em BusinessBase)
    this_cCampoInvalido = ""

    *==========================================================================
    * Init - Construtor
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()

            *-- SIGPRPDF nao tem tabela/PK propria (ver cabecalho do arquivo)
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_oFormPai = .NULL.
            THIS.this_cDiretorio = ""

            THIS.this_nTipoArquivo          = 1
            THIS.this_lPdfCreatorDisponivel = .F.
            THIS.this_cArquivoSaida         = ""
            THIS.this_lEnviarEmail          = .F.

            THIS.this_cEmailDe      = ""
            THIS.this_cEmailPara    = ""
            THIS.this_cEmailCC      = ""
            THIS.this_cEmailAssunto = ""
            THIS.this_cEmailCorpo   = ""

            THIS.this_cEmpPadEmails = ""
            THIS.this_cEmpPadServs  = ""
            THIS.this_cEmpPadSenhas = ""
            THIS.this_cEmpPastas    = ""
            THIS.this_nEmpPadPortas = 0

            THIS.this_lContaEmailCarregada = .F.
            THIS.this_cCampoInvalido       = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigprpdfBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor da conta de e-mail da
    * empresa (SigCdEmp) para as properties deste BO. Eh o hook canonico do
    * BusinessBase e o UNICO ponto do BO que le colunas de cursor - chamado por
    * ObterDadosContaEmail() depois do SQLEXEC, e tambem utilizavel pelo Form
    * quando o cursor TmpEmpMail/equivalente ja estiver aberto.
    *
    * As conversoes sao as do Init / Cmd_GerarPDF.Click legado, coluna a coluna
    * (linhas 652 e 801-804 do fonte original) - LOWER + ALLTRIM em PadEmails e
    * PadServs, so ALLTRIM em PadSenhas, Nvl(...,0) em PadPortas:
    *   TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(TmpEmpMail.PadEmails, [])))
    *   "cSmtpServer"     <- Lower(Alltrim(Nvl(TmpEmpMail.PadServs,  "")))
    *   "nSmtpServerPort" <-            Nvl(TmpEmpMail.PadPortas, 0)
    *   "cSendUserName"   <- Lower(Alltrim(Nvl(TmpEmpMail.PadEmails, "")))
    *   "cSendPassWord"   <-       Alltrim(Nvl(TmpEmpMail.PadSenhas, "")))
    * Tipos conferidos em docs/schema.sql (tabela sigcdemp): pademails char(50),
    * padservs char(50), padsenhas char(30), pastas char(50), padportas
    * numeric(3,0) - por isso padportas vai para a property NUMERICA
    * this_nEmpPadPortas e as demais para properties de caractere.
    *
    * Marca this_lContaEmailCarregada, que eh o equivalente migrado de
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" checado no
    * Cmd_GerarPDF.Click legado antes de montar o objeto de envio.
    *
    * par_cAliasCursor: alias do cursor a ler. Retorna .T. se leu a linha.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_nAreaAnterior

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()
        loc_cAlias        = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        THIS.this_lContaEmailCarregada = .F.

        TRY
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de dados da conta de e-mail " + ;
                                          "indispon" + CHR(237) + "vel."
            ELSE
                *-- Alias dinamico: SELECT (var) + acesso DIRETO aos campos.
                *-- NUNCA campo, que eh sintaxe invalida em VFP9.
                SELECT (loc_cAlias)
                GO TOP

                IF EOF(loc_cAlias)
                    THIS.this_cMensagemErro = "Conta de e-mail n" + CHR(227) + "o " + ;
                                              "cadastrada para a empresa."
                ELSE
                    *-- Existencia de campo em CURSOR se testa com TYPE(),
                    *-- NUNCA com PEMSTATUS (que exige objeto no 1o argumento)
                    IF TYPE(loc_cAlias + ".PadEmails") != "U"
                        THIS.this_cEmpPadEmails = LOWER(ALLTRIM(TratarNulo(PadEmails, "")))
                    ENDIF

                    IF TYPE(loc_cAlias + ".PadServs") != "U"
                        THIS.this_cEmpPadServs = LOWER(ALLTRIM(TratarNulo(PadServs, "")))
                    ENDIF

                    IF TYPE(loc_cAlias + ".PadSenhas") != "U"
                        THIS.this_cEmpPadSenhas = ALLTRIM(TratarNulo(PadSenhas, ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".Pastas") != "U"
                        THIS.this_cEmpPastas = ALLTRIM(TratarNulo(Pastas, ""))
                    ENDIF

                    *-- padportas eh numeric(3,0) no schema: NVL numerico, sem
                    *-- ALLTRIM/STR (ALLTRIM sobre numerico dispara o erro 11)
                    IF TYPE(loc_cAlias + ".PadPortas") != "U"
                        THIS.this_nEmpPadPortas = NVL(PadPortas, 0)
                    ENDIF

                    *-- Init legado: TxtEmail_EnviarDE.Value recebe PadEmails
                    THIS.this_cEmailDe = THIS.this_cEmpPadEmails

                    THIS.this_lContaEmailCarregada = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.CarregarDoCursor")
        ENDTRY

        *-- Restaura a work area do chamador (o SELECT acima a trocou)
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosContaEmail - Carrega os dados da conta de e-mail parametrizada
    * para a empresa em SigCdEmp (equivalente a "Select PadEmails, PadServs,
    * PadSenhas, pastas, PadPortas From SigCdEmp Where CEmps = <empresa>"
    * no Init legado, que populava o cursor TmpEmpMail). par_cCodEmpresa deve
    * vir de go_4c_Sistema.cCodEmpresa (CLAUDE.md: NUNCA usar a legada _EMPR).
    *
    * Tambem repete o que o Init legado fazia com o resultado -
    * THIS.this_cEmailDe recebe PadEmails em minusculo/trim, equivalente a
    * "Thisform.CtnSaida_Email.TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(
    * TmpEmpMail.PadEmails, [])))".
    *
    * Retorna .T. se a consulta foi executada com sucesso. Em caso de falha,
    * reproduz a mensagem do legado ("Favor Reinicializar o Processo!!!") em
    * this_cMensagemErro - o Form decide como exibir (MsgErro).
    *==========================================================================
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.
        THIS.this_lContaEmailCarregada = .F.
        THIS.this_cMensagemErro        = ""

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, Pastas, PadPortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(TratarNulo(par_cCodEmpresa, "")))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                *-- A leitura das colunas fica num lugar so (CarregarDoCursor),
                *-- que eh o hook canonico do BusinessBase para esse mapeamento
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_TmpEmpMail")

                IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.ObterDadosContaEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterNomeArquivoPadrao - Monta o nome/caminho default do arquivo de
    * saida, equivalente a:
    *   Init legado:        ThisForm.Diretorio + [FORTYUSPDF.] + Iif(... ,[PDF],[XLS])
    *   optArquivo.Click:   ThisForm.Diretorio + [FORTYUSPDF.PDF] / [FORTYUSEXCEL.XLS]
    * par_nTipoArquivo: 1 = PDF, 2 = XLS (THIS.this_nTipoArquivo - indice
    * 1-based do OptionGroup, NUNCA booleano - CLAUDE.md regra sobre
    * ControlSource numerico).
    *==========================================================================
    PROCEDURE ObterNomeArquivoPadrao(par_nTipoArquivo)
        LOCAL loc_cDir

        loc_cDir = ALLTRIM(TratarNulo(THIS.this_cDiretorio, ""))
        IF !EMPTY(loc_cDir) AND RIGHT(loc_cDir, 1) != "\"
            loc_cDir = loc_cDir + "\"
        ENDIF

        RETURN loc_cDir + IIF(par_nTipoArquivo = 1, "FORTYUSPDF.PDF", "FORTYUSEXCEL.XLS")
    ENDPROC

    *==========================================================================
    * ValidarDadosConfirmacao - Reproduz, na ordem, as DUAS checagens
    * BLOQUEANTES do Cmd_GerarPDF.Click legado - as unicas que fazem Return
    * antecipado (o dialogo NAO fecha):
    *   1) nome do arquivo de saida preenchido (senao, igual ao legado,
    *      MessageBox + This.Parent.CmdGetFile.SetFocus());
    *   2) quando this_lEnviarEmail = .T. (Chk_EMAIL.Value = 1):
    *      2a) campo 'DE:' preenchido (TxtEmail_EnviarDE.SetFocus());
    *      2b) campo 'PARA:' preenchido (txtEmail_EnviarPara.SetFocus()).
    *
    * A terceira checagem do legado (conta de e-mail da empresa ausente -
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0") NAO bloqueia: o
    * Else so exibe MessageBox('Problemas na selecao de dados do email...')
    * SEM Return, e o fluxo segue at? ThisForm.Release() (o dialogo fecha
    * mesmo assim, so sem montar o objeto de envio). Por isso essa checagem
    * fica fora deste metodo - o Form consulta THIS.this_lContaEmailCarregada
    * direto para decidir se exibe o aviso antes de chamar
    * MontarDadosEnvioEmail(), sem impedir o fechamento.
    *
    * Retorna .T. se passou nas duas checagens bloqueantes. Em caso de
    * falha, preenche this_cMensagemErro (texto IDENTICO ao MessageBox
    * legado) e this_cCampoInvalido (para o Form decidir o SetFocus) e para
    * na PRIMEIRA falha, igual ao Return antecipado do legado.
    *==========================================================================
    PROCEDURE ValidarDadosConfirmacao()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro  = ""
        THIS.this_cCampoInvalido = ""

        TRY
            IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cArquivoSaida, "")))
                THIS.this_cMensagemErro  = "Selecione um nome para o arquivo!"
                THIS.this_cCampoInvalido = "ARQUIVO"
            ELSE
                IF !THIS.this_lEnviarEmail
                    loc_lValido = .T.
                ELSE
                    IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmailDe, "")))
                        THIS.this_cMensagemErro  = "O campo 'DE:' n" + CHR(227) + "o foi preenchido."
                        THIS.this_cCampoInvalido = "EMAIL_DE"
                    ELSE
                        IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmailPara, "")))
                            THIS.this_cMensagemErro  = "O campo 'PARA:' n" + CHR(227) + "o foi preenchido."
                            THIS.this_cCampoInvalido = "EMAIL_PARA"
                        ELSE
                            loc_lValido = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.ValidarDadosConfirmacao")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ObterMensagemContaEmailIndisponivel - Mensagem a exibir (sem bloquear o
    * fechamento do dialogo) quando this_lEnviarEmail = .T. mas
    * this_lContaEmailCarregada = .F. - equivalente ao Else sem Return de
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" no Cmd_GerarPDF.Click
    * legado. Ver nota em ValidarDadosConfirmacao sobre por que esta checagem
    * NAO entra na cadeia bloqueante.
    *==========================================================================
    PROCEDURE ObterMensagemContaEmailIndisponivel()
        RETURN "Problemas na sele" + CHR(231) + CHR(227) + "o de dados do email. Favor enviar novamente."
    ENDPROC

    *==========================================================================
    * MontarDadosEnvioEmail - Monta a estrutura de envio equivalente ao
    * objeto CUSTOM que o Cmd_GerarPDF.Click legado cria em
    * ThisForm.oParentForm.oEMAIL via AddProperty (cSmtpServer, nSmtpServerPort,
    * cSendUserName, cSendPassWord, cFrom, cTO, cCC, cAssunto, cCorpo, cAnexo).
    * Devolve um objeto CUSTOM com as mesmas properties, na mesma grafia, para
    * o Form atribuir direto a par_oFormPai.oEMAIL - este BO nao conhece o
    * form pai, so monta o objeto (THIS.this_oFormPai existe so para o Form
    * usar, nunca eh referenciado por este BO).
    *
    * Chamar APENAS depois de ValidarDadosConfirmacao() retornar .T. E
    * this_lContaEmailCarregada = .T. - este metodo nao revalida. Sem os
    * dados da conta (this_lContaEmailCarregada = .F.), devolve .NULL.,
    * equivalente ao legado NAO atribuir ThisForm.oParentForm.oEMAIL quando
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" falha.
    *==========================================================================
    PROCEDURE MontarDadosEnvioEmail()
        LOCAL loc_oEmail

        IF !THIS.this_lContaEmailCarregada
            RETURN .NULL.
        ENDIF

        loc_oEmail = CREATEOBJECT("Empty")

        ADDPROPERTY(loc_oEmail, "cSmtpServer",     THIS.this_cEmpPadServs)
        ADDPROPERTY(loc_oEmail, "nSmtpServerPort", THIS.this_nEmpPadPortas)
        ADDPROPERTY(loc_oEmail, "cSendUserName",   THIS.this_cEmpPadEmails)
        ADDPROPERTY(loc_oEmail, "cSendPassWord",   THIS.this_cEmpPadSenhas)
        ADDPROPERTY(loc_oEmail, "cFrom",           ALLTRIM(TratarNulo(THIS.this_cEmailDe, "")))
        ADDPROPERTY(loc_oEmail, "cTO",             ALLTRIM(TratarNulo(THIS.this_cEmailPara, "")))
        ADDPROPERTY(loc_oEmail, "cCC",             ALLTRIM(TratarNulo(THIS.this_cEmailCC, "")))
        ADDPROPERTY(loc_oEmail, "cAssunto",        ALLTRIM(TratarNulo(THIS.this_cEmailAssunto, "")))
        ADDPROPERTY(loc_oEmail, "cCorpo",           ALLTRIM(TratarNulo(THIS.this_cEmailCorpo, "")))
        ADDPROPERTY(loc_oEmail, "cAnexo",           THIS.this_cArquivoSaida)

        RETURN loc_oEmail
    ENDPROC

    *==========================================================================
    * Destroy - Libera o cursor de trabalho aberto por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

