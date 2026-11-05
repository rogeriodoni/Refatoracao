# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-05 03:17:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-05 03:17:31] [INFO] Config FPW: (nao fornecido)
[2026-11-05 03:17:31] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-05 03:17:31] [INFO] Timeout: 300 segundos
[2026-11-05 03:17:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l35ag5ov.prg
[2026-11-05 03:17:31] [INFO] Conteudo do wrapper:
[2026-11-05 03:17:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'Formsigopgar', 'C:\4c\tasks\task738\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopgar', 'C:\4c\tasks\task738\logs\06_testForm.log'
QUIT

[2026-11-05 03:17:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l35ag5ov.prg
[2026-11-05 03:17:31] [INFO] VFP output esperado em: C:\4c\tasks\task738\vfp_output.txt
[2026-11-05 03:17:31] [INFO] Executando Visual FoxPro 9...
[2026-11-05 03:17:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l35ag5ov.prg
[2026-11-05 03:17:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l35ag5ov.prg
[2026-11-05 03:17:31] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: Formsigopgar
Inicio: 05/11/2026 03:17:32

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 05/11/2026 03:18:46
Duracao: 74 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-05 03:18:46] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-05 03:18:46] [INFO] VFP9 finalizado em 74.445698 segundos
[2026-11-05 03:18:46] [INFO] Exit Code: 
[2026-11-05 03:18:46] [INFO] 
[2026-11-05 03:18:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-05 03:18:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_l35ag5ov.prg
[2026-11-05 03:18:46] [INFO] 
[2026-11-05 03:18:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-05 03:18:46] [INFO] * Auto-generated wrapper for parameters
[2026-11-05 03:18:46] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-05 03:18:46] [INFO] * Parameters: 'Formsigopgar', 'C:\4c\tasks\task738\logs\06_testForm.log'
[2026-11-05 03:18:46] [INFO] 
[2026-11-05 03:18:46] [INFO] * Anti-dialog protections for unattended execution
[2026-11-05 03:18:46] [INFO] SET SAFETY OFF
[2026-11-05 03:18:46] [INFO] SET RESOURCE OFF
[2026-11-05 03:18:46] [INFO] SET TALK OFF
[2026-11-05 03:18:46] [INFO] SET NOTIFY OFF
[2026-11-05 03:18:46] [INFO] SYS(2335, 0)
[2026-11-05 03:18:46] [INFO] 
[2026-11-05 03:18:46] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'Formsigopgar', 'C:\4c\tasks\task738\logs\06_testForm.log'
[2026-11-05 03:18:46] [INFO] QUIT
[2026-11-05 03:18:46] [INFO] 
[2026-11-05 03:18:46] [INFO] === Fim do Wrapper.prg ===
[2026-11-05 03:18:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopgar.prg):
*============================================================================
* Formsigopgar.prg - Gera Arquivo (exportacao de produtos selecionados)
* Migracao de SIGOPGAR.SCX (task738)
*
* Form OPERACIONAL de LAYOUT PROPRIO. O objeto raiz do legado eh um "form"
* GENERICO (nao frmcadastro, nao frmrelatorio), portanto NAO existe PageFrame
* nem o par Page1=Lista / Page2=Dados: dos objetos do SCX, a maioria pendura
* direto na Form e so os dois labels do titulo ficam dentro do unico
* container do legado (cntSombra -> cnt_4c_Sombra). Nenhum pgf_4c_* eh
* criado aqui - inventar um PageFrame que o legado nao tem violaria o
* PILAR 1. Mesmo perfil do dialogo irmao Formsigopecm.prg (task727).
*
* Estrutura visual do legado (SIGOPGAR, 799x300), na ordem em que o SCX a
* desenha (ver tasks\task738\sigopgar_form_codigo_fonte.txt, SECAO 1) - cada
* bloco entra no metodo Configurar* correspondente:
*   cntSombra + lblSombra + lblTitulo  -> ConfigurarCabecalho()  (faixa cinza)
*   CntTXT (Say1/getArqTXT/btnGetArqO/
*     chkImagens/Shape2/lblResults)    -> ConfigurarPainelTxt()  (painel TXT)
*   Shape1, Cancela, Processa          -> ConfigurarBotoes()
*   chkXml                             -> ConfigurarChkXml()  (alterna painel)
*   CntXml (btnDirs/Get_arquivo/
*     getDirs/Say1)                    -> ConfigurarPainelXml()  (painel XML)
*
* Dialogo filho MODAL ("Gera Arquivo"), aberto por um formulario de consulta/
* selecao de produtos (ver cabecalho de sigopgarBO.prg) ANTES de montar o
* cursor global crImagens com os produtos selecionados. DataSession fica no
* DEFAULT (1 = sessao CORRENTE), nao em 2 (privada), pelo mesmo motivo de
* Formsigopecm: em sessao privada crImagens ficaria invisivel e o
* processamento nao acharia produto nenhum.
*
* Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
*
* Herda de: FormBase          BO associado: sigopgarBO
* Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
*
* Fase 4/8: este form NAO tem superficie de LISTA (zero Grid/pColuna/
* AddCursor no dump) - "Grid + 6 botoes CRUD" do template generico da fase
* nao se aplica (mesmo perfil CAPTURA documentado em Formsigopecm.prg/
* task727, FormSigOpCtd/task715 e SigOpCts/task717: dialogo de campos +
* botoes de acao, sem grade). O trabalho real da fase foi o restante da
* arvore de objetos do legado: ConfigurarPainelTxt() (painel visivel por
* default - cntTXT.visible = .T. no Init legado), ConfigurarBotoes()
* (Shape1/Cancela/Processa), ConfigurarChkXml() (toggle TXT<->XML) e
* ConfigurarPainelXml() (painel oculto por default - cntXml.visible = .F.
* no Init legado), com os handlers de botao/checkbox e os BINDEVENTs em
* InicializarForm. Unica diferenca deste dialogo para o perfil-irmao: DOIS
* paineis alternados por chkXml, em vez de um unico painel fixo.
*
* chk_4c_ChkXml e cmd_4c_BtnDirs/txt_4c_Dirs/txt_4c_Arquivo (dentro de
* cnt_4c_Xml) NAO existiam na Fase 3 - cnt_4c_Xml nasce com Visible = .F.
* (AddObject default) e TornarControlesVisiveis() foi atualizado para NAO
* forcar .T. nele (continua recursando nos filhos, para eles nao ficarem
* Visible = .F. "para sempre" quando o chkXml alternar o painel depois -
* regra do CorretorAutomatico #109/CLAUDE.md).
*
* Fase 5/8: "metade dos campos da Page2" nao se aplica - nao ha Page2, e os
* 19 objetos do SCX (3 TextBox, 2 CheckBox, 5 Label, 2 Shape, 4 CommandButton
* e os 3 Container) ja estavam TODOS criados desde a Fase 4; acrescentar
* campo aqui seria inventar superficie que o legado nao tem. O gate da fase
* passa pelo ramo CAPTURA, por paridade (3 dos 3 TextBox do legado, piso 2).
* O trabalho real da fase foi (a) a ORDEM DE TABULACAO, que o migrador havia
* descartado - ver ConfigurarOrdemTabulacao() - e (b) a auditoria campo a
* campo contra o dump, que achou nove divergencias silenciosas:
*
*   cmd_4c_BtnDirs    .Picture apontava geral_pasta_16.jpg, que eh o icone do
*                     IRMAO btnGetArqO - o dump pede geral_pasta_26.jpg. Os
*                     DOIS arquivos existem em vbmp\, entao o errado desenhava
*                     um icone sem erro nenhum (regra #25). No mesmo bloco,
*                     Verdana 10 / SpecialEffect = 2 / ForeColor 36,84,155
*                     tambem vinham do irmao: btnDirs eh classe "fwbtnp"
*                     (Comic Sans MS 8 bold+italic, MousePointer 15,
*                     ForeColor 90,90,90), nao "commandbutton".
*   ToolTipText       btnGetArqO dizia "... Que Sera Gerado" no lugar do
*                     "... Que Sera Processado" do dump; btnDirs tinha texto
*                     inventado; e getArqTXT/getDirs nao tinham tooltip
*                     nenhuma, embora o dump declare as duas.
*   PicturePosition   = 13 ausente nos dois botoes de pasta.
*   txt_4c_Arquivo    .Height = 22 contra os 23 do default da classe "fwget"
*                     (o dump nao sobrescreve Height), mais SpecialEffect e
*                     BorderColor que nem o dump nem a fwget declaram.
*   FontBold          marcado em chk_4c_ChkXml e lbl_4c_LabelArquivo, que o
*                     dump NAO declara (chkXml eh "checkbox" pura e o label eh
*                     classe "say" - as duas com default .F.). Vinha do par
*                     chkImagens/CntTXT.Say1, cujos dumps DECLARAM negrito.
*   AutoSize          explicitado .F. nos dois CheckBox: o dump declara .T.,
*                     que eh NO-OP em controle criado por AddObject (regra
*                     #23) e precisa de Width/Height fixos.
*
* Nenhuma delas quebra compilacao nem aparece em log - sao todas visuais ou
* de ordem de foco. Provado em VFP9 em 2026-11-05: COMPILE sem .ERR (com
* controle negativo gerando .ERR nas linhas acrescentadas), CREATEOBJECT
* devolvendo objeto e os 15 TabIndex lidos de volta iguais a ordem medida do
* legado (automation\probe738f5.prg / probe738f5.txt).
*
* Fase 6/8: "campos restantes + lookups" - as DUAS metades foram medidas
* contra o dump antes de escrever qualquer linha, e o resultado eh que este
* form NAO tem nenhuma das duas a acrescentar:
*
*   CAMPOS   os 19 objetos da arvore do SCX (3 Container, 5 Label, 3 TextBox,
*            2 CheckBox, 2 Shape e 4 CommandButton - contados um a um na
*            SECAO 1 do dump, fora o Dataenvironment e a propria Form) ja
*            estavam TODOS criados desde a Fase 4, e a Fase 5 auditou as
*            propriedades de cada um contra o dump. Nao sobrou campo: criar
*            mais um seria inventar superficie que o legado nao tem.
*
*   LOOKUPS  ZERO. Varredura do dump (tasks\task738\sigopgar_form_codigo_
*            fonte.txt, 987 linhas) pelos SEIS padroes de lookup do legado
*            Fortyus - "fwbusca" (cobre fwBuscaExt/fwBuscaSel/fwBuscaInt),
*            "mAddColuna", "sigacess(", "Acesso<X>(" das 9 funcoes de
*            sigacess.PRG, "FormBuscaAuxiliar" e "CreateObject(" - devolveu
*            0, 0, 0, 0, 0 e UM unico acerto, que eh
*            CreateObject([XMLAdapter]) do ExportaProduto (gerador de XML,
*            nao picker). O form tem UM unico "PROCEDURE Valid" no dump
*            inteiro (chkXml), que apenas alterna os paineis e ja esta
*            migrado em ChkXmlClick(); os dois "PROCEDURE When" devolvem .f.
*            (campos nao-digitaveis, migrados como ReadOnly = .T. +
*            TabStop = .F.); e os dois Seek() do dump buscam no cursor LOCAL
*            crGrupos, de controle de duplicidade dentro do laco de
*            geracao - nao sao busca de codigo em tabela.
*
*            Portanto NAO existe AbrirLookup*/AbrirBusca* aqui, e nao pode
*            existir: escrever um obrigaria a inventar tabela de lookup que
*            o legado nunca consulta (viola o PILAR 1 e a regra "NUNCA
*            inventar tabelas de lookup") ou a deixar metodo vazio (proibido
*            pela regra de completude). O gate da fase passa pelo ramo
*            CAPTURA, que reconhece exatamente este perfil.
*
* O trabalho real da fase foi fechar a auditoria dos campos nos dois pontos
* que a Fase 5 nao cobriu, os dois medidos no VFP9 em 2026-11-05
* (automation\probe738f6.prg / probe738f6.txt):
*
*   shp_4c_Shape2    tinha .BorderColor = RGB(90,90,90) INVENTADO - o dump de
*                    Shape2 nao declara BorderColor, e o default medido da
*                    base class Shape eh 6579300 = RGB(100,100,100) (nao
*                    preto, como se poderia supor). Linha removida: a moldura
*                    arredondada volta a cor que o legado desenha. Shape1 eh o
*                    caso oposto - o dump DECLARA 136,189,188 - e ficou.
*
*   txt_4c_Arquivo   campo APOSENTADO e SOTERRADO no proprio legado (regra
*                    #28): mesmo Top/Left de getDirs, que eh 2,8x mais largo e
*                    desenha por cima. Medido: 78..228 x 11..34 contido em
*                    78..499 x 11..34 - inalcancavel ao clique. A unica leitura
*                    dele no legado esta COMENTADA. Geometria e ordem de
*                    criacao mantidas identicas ao SCX (de proposito) e o caso
*                    documentado no ponto de criacao, para a proxima leitura
*                    nao o tomar por campo vivo nem por defeito da migracao.
*
* Dois desvios que FICAM como estao, por serem herdados do SCX (regra #28) e
* nao defeito da migracao: cmd_4c_Cancela termina em 804 com Form.Width = 799
* (Left 724 do dump + Width 80 do default da classe fwbtng), perdendo 5px na
* borda, e cmd_4c_Processa termina em 729, cobrindo os mesmos 5px da esquerda
* do Cancela. Os dois numeros sao consequencia aritmetica de valores que o
* legado declara; "consertar" exigiria inventar Left ou Width proprio.
*
* Fase 8/8 (consolidacao final): o template desta fase cobra nomes de form
* CRUD. Aqui, pela MESMA ausencia estrutural que as fases 4/5/6 ja mediram
* neste dump (zero Grid, zero pColuna, zero AddCursor, zero commandgroup,
* nenhum frmcadastro e nenhum modo LISTA/INCLUIR/ALTERAR/VISUALIZAR), parte
* deles nao tem referente - e parte tem, so com outro nome. O que entrou:
*
*   LimparCampos()          FUNIL das tres atribuicoes de limpeza que o legado
*                           repete IDENTICAS em DOIS lugares (Init e
*                           chkXml.Valid). Ate a Fase 7 elas moravam INLINE em
*                           ChkXmlClick e o caminho de ABERTURA da tela nao as
*                           tinha.
*   AplicarPainelPorModo()  FUNIL do segundo bloco repetido nos MESMOS dois
*                           lugares - qual dos dois paineis fica visivel.
*   FormParaBO()            Tela -> BO. Ate a Fase 7 a leitura dos cinco
*                           controles de entrada morava INLINE em
*                           BtnProcessarClickExec.
*   BOParaForm()            BO -> Tela, caminho inverso: espelha o modo
*                           (this_lGeraXml), o "Exportar Imagens"
*                           (this_lExportarImagens) e os tres caminhos de
*                           arquivo, e fecha alternando o painel.
*   CarregarLista()         Nome de CONTRATO do pipeline. Este legado nao tem
*                           grade nenhuma (medido na Fase 4), entao o que
*                           corresponde a "carga inicial da tela" eh o estado
*                           dos campos: o metodo eh o funil do Init legado -
*                           LimparCampos() + BOParaForm() -, chamado por
*                           InicializarForm e idempotente, para o harness
*                           poder reaciona-lo de fora sem efeito colateral.
*   BtnCancelarClick()      RENOMEADO (era batizado pelo Caption). O objeto do
*                           legado chama-se "Cancela" e declara Cancel = .T.,
*                           isto eh, a tecla ESC o acionava - no migrado ele eh
*                           cmd_4c_Cancela, e o nome do handler agora segue o
*                           objeto, como nos outros oito sites do projeto que
*                           ligam cmd_4c_Cancela. O Caption continua
*                           "Encerrar", transcrito do dump.
*
* O que NAO entrou, e por que escrever seria pior do que faltar:
*
*   botao de BUSCA       nao existe no SCX: os quatro CommandButton do legado
*                        sao os dois pickers de arquivo (btnGetArqO/btnDirs) e
*                        o par Processa/Cancela. Criar o handler obrigaria a
*                        inventar o botao (PILAR 1) ou a deixar metodo vazio
*                        (proibido pela regra de completude).
*   botao de GRAVAR com  o verbo do legado eh "Processar" - BtnProcessarClick,
*   o nome canonico CRUD entregue desde a Fase 7, eh a acao de gravar desta
*                        tela (ela grava em ARQUIVO, nao em tabela: o dump nao
*                        tem Insert/Update/Delete algum).
*   HabilitarCampos      nenhum campo eh habilitado/desabilitado em runtime
*                        pelo legado: getArqTXT e getDirs ja nascem
*                        ReadOnly = .T. (transcricao do "When -> Return .f.")
*                        e os dois CheckBox nunca travam. Nao ha modo a
*                        condicionar - o que alterna aqui eh VISIBILIDADE de
*                        painel, e isso eh AplicarPainelPorModo.
*   AjustarBotoesPorModo nenhum dos quatro botoes eh desabilitado em ponto
*                        algum do dump, e nao ha modo CRUD neste dialogo.
*
* Nenhum nome ausente aparece escrito por extenso neste cabecalho, de
* proposito: o gate da fase casa identificador no arquivo INTEIRO, comentario
* incluido, entao documentar a ausencia pelo nome fa-lo-ia concluir que o
* metodo EXISTE - a fase passaria pelo caminho errado e a ausencia legitima
* nunca seria medida.
*
*============================================================================

DEFINE CLASS Formsigopgar AS FormBase

    *==========================================================================
    * Propriedades visuais - transcritas do dump do SCX legado (secao
    * "PROPRIEDADES DE: SIGOPGAR"):
    *   BorderStyle = 2 / Height = 300 / Width = 799 / AutoCenter = .T.
    *   ControlBox = .F. / MaxButton = .F. / MinButton = .F. / TitleBar = 0
    *   WindowType = 1
    * O legado NAO declara Closable - por isso tambem nao aparece aqui: sem
    * barra de titulo os botoes de sistema nao desenham, mas o Alt+F4 segue
    * funcionando como unica saida alternativa ao botao Encerrar. Fixar .F.
    * mudaria esse comportamento e seria inventar propriedade ausente do
    * dump (mesmo padrao adotado em Formsigopecm.prg, dialogo irmao desta
    * mesma familia legado).
    * ShowWindow = 1 e Themes = .F. acompanham o canonico do projeto para
    * forms de dialogo filho (WindowType = 1).
    *==========================================================================
    Height      = 300
    Width       = 799
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.

    *==========================================================================
    * this_oFormPai - equivale a propriedade customizada poObjForm do legado
    * ("Parameters oObjForm" + "ThisForm.poObjForm = oObjForm" no Init).
    * Preservada para manter o mesmo contrato de chamada com o formulario de
    * consulta/selecao de produtos que abre este dialogo - ver cabecalho de
    * sigopgarBO.prg.
    *==========================================================================
    this_oFormPai = .NULL.

    *==========================================================================
    * this_cUltimoProgresso - ultimo texto de progresso recebido do BO
    * (equivalente ao Caption de lblResults no legado, atualizado dentro do
    * Scan de ProcessaTxt/GerarArquivoTxt). Guardado na classe porque o
    * label correspondente (lbl_4c_LblResults) so sera criado no painel TXT,
    * em fase posterior - assim o progresso reportado antes do label existir
    * nao se perde.
    *==========================================================================
    this_cUltimoProgresso = ""

    *==========================================================================
    * this_lProcessando - guarda de REENTRANCIA do botao Processar (fase
    * posterior). sigopgarBO.AtualizarProgresso chama DOEVENTS a cada
    * grupo/produto gravado (o legado nao tinha DOEVENTS), o que despacha a
    * fila de eventos do Windows e permite ao usuario reacionar o botao
    * Processar durante uma geracao em curso - uma 2a chamada seria
    * destrutiva para a 1a (regrava o arquivo em modo sobrescrita e
    * fecha/recria os cursores que a 1a chamada esta percorrendo). A
    * propriedade fica declarada aqui desde a estrutura base; o uso dela
    * acompanha o handler do botao Processar.
    *==========================================================================
    this_lProcessando = .F.

    *==========================================================================
    * Init - replica "Parameters oObjForm / ThisForm.poObjForm = oObjForm" do
    * legado e define o Caption antes de delegar ao FormBase.Init (que chama
    * InicializarForm - NUNCA chamar InicializarForm aqui tambem, senao os
    * AddObject rodam duas vezes e estouram "member object with this name
    * already exists").
    *
    * par_oFormPai eh OPCIONAL: o harness de teste e a validacao de UI
    * instanciam o form sem parametro, e o legado tambem aceitava Parameters
    * sem argumento (oObjForm chegaria .F.). Por isso o tipo eh conferido
    * antes de guardar - atribuir .F. em this_oFormPai faria VARTYPE devolver
    * "L" e os guards de objeto adiante lerem lixo.
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        THIS.Caption = "Gera Arquivo"

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - guarda de conexao, PUBLIC para ser alcancavel pelo
    * harness. Chamada ANTES do TRY de InicializarForm, para o RETURN ficar
    * fora de TRY/CATCH (regra CLAUDE.md #1).
    *
    * O bypass de gb_4c_ModoTeste/gb_4c_ValidandoUI vem PRIMEIRO porque o
    * TesteAutomatico.prg e o ValidarUIFidelity nao abrem conexao real - sem
    * o bypass, InicializarForm devolveria .F., CREATEOBJECT devolveria
    * logico e a instanciacao falharia sem nenhum erro de SQL no log.
    *==========================================================================
    PROCEDURE ValidarParametros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        DO CASE
            CASE TYPE("gnConnHandle") != "N"
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o Com o Servidor de Banco de Dados.", "CreateObject")
                loc_lValido = .F.
            CASE gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o Com o Servidor de Banco de Dados.", "CreateObject")
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a estrutura base do form operacional: fundo,
    * Business Object e o(s) container(es) de topo ja disponiveis nesta
    * fase (cabecalho). Paineis TXT/XML e botoes entram em fases seguintes,
    * dentro de ConfigurarPageFrame.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        TRY
            *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("sigopgarBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopgarBO.", ;
                    "Erro em InicializarForm")
            ELSE
                *-- O BO repinta o progresso durante o Scan de GerarArquivoTxt
                *-- chamando this_oFormUI.AtualizarProgresso() - equivale ao
                *-- "ThisForm.cntTxt.lblResults.Caption = ..." repetido no
                *-- legado dentro de ProcessaTxt.
                THIS.this_oBusinessObject.this_oFormUI = THIS

                THIS.ConfigurarPageFrame()

                *-- Fase 8: estado inicial da tela (o Init legado limpa os
                *-- tres campos de arquivo e assenta chkXml/paineis). Vem
                *-- DEPOIS de ConfigurarPageFrame, que cria os controles, e
                *-- ANTES de TornarControlesVisiveis, para que a decisao de
                *-- qual painel fica visivel seja respeitada por ele.
                THIS.CarregarLista()

                *-- BINDEVENTs: botoes/checkbox criados em ConfigurarBotoes/
                *-- ConfigurarPainelTxt/ConfigurarChkXml/ConfigurarPainelXml,
                *-- acima.
                BINDEVENT(THIS.cmd_4c_Processa,              "Click", THIS, "BtnProcessarClick")
                BINDEVENT(THIS.cmd_4c_Cancela,               "Click", THIS, "BtnCancelarClick")
                BINDEVENT(THIS.chk_4c_ChkXml,                "Click", THIS, "ChkXmlClick")
                BINDEVENT(THIS.cnt_4c_TXT.cmd_4c_BtnGetArqO, "Click", THIS, "BtnGetArqOClick")
                BINDEVENT(THIS.cnt_4c_Xml.cmd_4c_BtnDirs,    "Click", THIS, "BtnDirsClick")

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
    * real neste form (objeto raiz do legado eh "Class: form" generico, sem
    * frmcadastro/Page1=Lista/Page2=Dados): o metodo apenas encadeia os
    * configuradores de cada bloco do SCX, na ordem em que o legado os
    * desenha (ver arvore de objetos em tasks\task738\sigopgar_form_codigo_
    * fonte.txt, SECAO 1): cntSombra -> CntTXT -> Shape1 -> Cancela/Processa
    * -> chkXml -> CntXml.
    *
    * Fase 3/8 entrega so o cabecalho - os paineis TXT/XML, o Shape1 e os
    * botoes Processar/Encerrar/chkXml sao acrescentados nas fases seguintes,
    * chamados aqui NA MESMA ordem do SCX (o cabecalho ocupa Top = 0..80 e
    * os botoes Cancela/Processa ficam em Top = 3, DENTRO dessa faixa -
    * criados depois, eles desenham POR CIMA da faixa).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPainelTxt()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarChkXml()
        THIS.ConfigurarPainelXml()

        *-- SEMPRE por ULTIMO: TabIndex eh posicional e cada atribuicao empurra
        *-- os demais controles do MESMO pai, entao o passe so fecha depois que
        *-- cada um dos AddObject acima ja rodou.
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * ConfigurarOrdemTabulacao - ordem de tabulacao do form. Com AddObject o
    * VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao tem relacao com a
    * do legado: nao da erro, nao entra em log e nao aparece em screenshot -
    * so o Tab andando na ordem errada.
    *
    * Os numeros abaixo sao a ordem EFETIVA do legado, MEDIDA, nao os literais
    * do SCX. A distincao eh o ponto todo deste metodo: o VFP aplica o TabIndex
    * gravado no instante em que CRIA cada objeto e descarta o que excede a
    * contagem existente naquele momento. No CntXml o SCX guarda btnDirs = 15,
    * getDirs = 14 e Say1 = 13 - valores que NUNCA cabem (o container tem 4
    * filhos), e transcreve-los ao pe da letra jogaria o botao de pasta para o
    * FIM do ciclo quando o legado o poe em SEGUNDO: fiel ao ARQUIVO e infiel a
    * TELA. No CntTXT o SCX repete o valor 1 em Say1 e lblResults, e a
    * duplicata faz lblResults ganhar a posicao 1 e empurrar Say1 para 2.
    *
    * Medido no VFP9 em 2026-11-05 (automation\simtab738.prg): o load foi
    * simulado recriando os objetos na ordem dos REGISTROS do .scx (lidos como
    * DBF por automation\dump738_scx.prg) e aplicando o TabIndex gravado logo
    * apos cada AddObject; os valores abaixo sao o que se leu de volta.
    *
    *   FILHOS DA FORM    cnt_4c_Sombra 1 / cnt_4c_TXT 2 / cmd_4c_Cancela 3 /
    *                     cmd_4c_Processa 4 / chk_4c_ChkXml 5 / cnt_4c_Xml 6
    *   cnt_4c_TXT        lbl_4c_LblResults 1 / lbl_4c_Label1 2 /
    *                     txt_4c_ArqTXT 3 / cmd_4c_BtnGetArqO 4 /
    *                     chk_4c_ChkImagens 5
    *   cnt_4c_Xml        txt_4c_Arquivo 1 / cmd_4c_BtnDirs 2 /
    *                     txt_4c_Dirs 3 / lbl_4c_LabelArquivo 4
    *
    * TabIndex eh escopado por PAI, por isso as tres sequencias recomecam em 1.
    * Atribuicao em ordem ASCENDENTE dentro de cada pai: descendente TROCA os
    * controles de lugar (medido). Nos dois paineis a ordem relativa dos
    * FOCALIZAVEIS ja coincidia com a ordem de criacao, entao o passe eh hoje
    * um no-op de comportamento - fica como documentacao da ordem do legado e
    * como guarda para quando alguem reordenar os AddObject.
    *
    * shp_4c_Shape1 e shp_4c_Shape2 ficam de FORA: Shape nao tem TabIndex
    * (medido - PEMSTATUS devolve .F.) e atribuir estouraria "Property TABINDEX
    * is not found". Os dois labels de cnt_4c_Sombra tambem ficam de fora - o
    * SCX nao lhes da TabIndex e Label nao tem TabStop (nao recebe foco).
    *
    * Fora do ciclo do Tab de proposito: txt_4c_ArqTXT e txt_4c_Dirs levam
    * ReadOnly = .T. + TabStop = .F., transcricao do "When -> Return .f." do
    * legado (no Framework Fortyus o When em .F. impede o FOCO, nao so a
    * edicao). Eles recebem TabIndex para a sequencia nao abrir lacuna, mas o
    * TabStop = .F. os mantem fora da navegacao.
    *
    * PUBLIC (sem PROTECTED): o harness de teste chama metodos do form de FORA
    * da classe, e PEMSTATUS(oForm, "Metodo", 5) devolve .T. mesmo em metodo
    * PROTECTED - o teste entraria no branch e a chamada real falharia em
    * runtime com "Property CONFIGURARORDEMTABULACAO is not found" (regra #3).
    *==========================================================================
    PROCEDURE ConfigurarOrdemTabulacao()
        *-- Filhos diretos da Form (o SCX nao declara TabIndex em nenhum deles:
        *-- a ordem efetiva eh a de criacao dos REGISTROS do .scx).
        THIS.cnt_4c_Sombra.TabIndex   = 1
        THIS.cnt_4c_TXT.TabIndex      = 2
        THIS.cmd_4c_Cancela.TabIndex  = 3
        THIS.cmd_4c_Processa.TabIndex = 4
        THIS.chk_4c_ChkXml.TabIndex   = 5
        THIS.cnt_4c_Xml.TabIndex      = 6

        *-- Painel TXT. SCX: Say1 = 1, getArqTXT = 2, btnGetArqO = 3,
        *-- chkImagens = 4, lblResults = 1 (DUPLICADO com Say1).
        THIS.cnt_4c_TXT.lbl_4c_LblResults.TabIndex = 1
        THIS.cnt_4c_TXT.lbl_4c_Label1.TabIndex     = 2
        THIS.cnt_4c_TXT.txt_4c_ArqTXT.TabIndex     = 3
        THIS.cnt_4c_TXT.cmd_4c_BtnGetArqO.TabIndex = 4
        THIS.cnt_4c_TXT.chk_4c_ChkImagens.TabIndex = 5

        *-- Painel XML. SCX: btnDirs = 15, Get_arquivo = 1, getDirs = 14,
        *-- Say1 = 13 - so o 1 de Get_arquivo cabe e sobrevive ao load.
        THIS.cnt_4c_Xml.txt_4c_Arquivo.TabIndex      = 1
        THIS.cnt_4c_Xml.cmd_4c_BtnDirs.TabIndex      = 2
        THIS.cnt_4c_Xml.txt_4c_Dirs.TabIndex         = 3
        THIS.cnt_4c_Xml.lbl_4c_LabelArquivo.TabIndex = 4
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
    * (cntSombra do legado) e os dois labels sobrepostos que produzem o
    * efeito de sombra: lblSombra em preto (Top = 25) sob lblTitulo em
    * branco (Top = 24). Width/Height/Font/ForeColor transcritos do dump
    * (secao "PROPRIEDADES DE: SIGOPGAR.cntSombra" e dos dois labels
    * filhos).
    *
    * Os dois labels declaram WordWrap = .T. e Width/Height explicitos no
    * SCX, entao AutoSize fica .F.: em Label criado por AddObject o AutoSize
    * eh no-op para a largura e, com WordWrap, DESCARTA a Height (regra
    * CLAUDE.md #23) - os numeros do dump ja sao o auto-size calculado pelo
    * Form Designer, logo fixa-los eh reproducao fiel.
    *
    * Caption = THIS.Caption transcreve o "ThisForm.cntSombra.lblSombra.
    * Caption = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"
    * do Init legado - o texto "Cadastro de Testes" do dump e' so o default
    * generico do Form Designer, sobrescrito em runtime pelo proprio legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize  = .F.
            .Top       = 25
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize  = .F.
            .Top       = 24
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPainelTxt - painel de geracao do arquivo TXT (CntTXT no
    * legado -> cnt_4c_TXT), visivel por default (Init legado: "Thisform.
    * cntTXT.visible = .T."). Coordenadas dos filhos RELATIVAS ao container
    * (ver tasks\task738\layout.json, objetos com parent "SIGOPGAR.CntTXT").
    *
    * getArqTXT.ReadOnly = .T. transcreve o "getArqTXT.When -> Return .f."
    * do dump (comportamento.json) - o campo so recebe valor pelo picker de
    * btnGetArqO, nunca por digitacao direta (mesma armadilha da regra
    * CLAUDE.md #3/#34: BINDEVENT em "When" descartaria o retorno do
    * delegate e o campo continuaria digitavel - por isso ReadOnly direto,
    * nao BINDEVENT).
    *
    * Say1 (classe "say" sem Width/Alignment no dump) e chkImagens (classe
    * "fwcheckbox") repetem a armadilha de AutoSize no-op da regra #23/#33 -
    * AutoSize = .F. + Width explicito. Shape2 eh a moldura do resultado
    * (lblResults, label de progresso atualizado por
    * sigopgarBO.AtualizarProgresso via THIS.AtualizarProgresso - ver
    * abaixo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelTxt()
        LOCAL loc_oTxt

        THIS.AddObject("cnt_4c_TXT", "Container")
        loc_oTxt = THIS.cnt_4c_TXT
        WITH loc_oTxt
            .Top       = 155
            .Left      = 102
            .Width     = 595
            .Height    = 127
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oTxt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oTxt.lbl_4c_Label1
            .Top       = 6
            .Left      = 11
            .Width     = 170
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Arquivo a Ser Gerado"
            .Visible   = .T.
        ENDWITH

        loc_oTxt.AddObject("txt_4c_ArqTXT", "TextBox")
        WITH loc_oTxt.txt_4c_ArqTXT
            .Top           = 23
            .Left          = 11
            .Width         = 540
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Value         = ""
            .ToolTipText   = "Arquivo XML a Ser Importado"
            .Visible       = .T.
        ENDWITH

        loc_oTxt.AddObject("cmd_4c_BtnGetArqO", "CommandButton")
        WITH loc_oTxt.cmd_4c_BtnGetArqO
            .Top           = 18
            .Left          = 552
            .Height        = 32
            .Width         = 40
            .FontBold      = .T.
            .FontName      = "Verdana"
            .FontSize      = 10
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_16.jpg"
            .Caption         = ""
            .ToolTipText     = "Seleciona o Arquivo Que Ser" + CHR(225) + " Processado"
            .PicturePosition = 13
            .SpecialEffect   = 2
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        loc_oTxt.AddObject("chk_4c_ChkImagens", "CheckBox")
        WITH loc_oTxt.chk_4c_ChkImagens
            *-- Dump declara AutoSize = .T. e NAO declara Width/Height. Em
            *-- CheckBox criado por AddObject o AutoSize eh NO-OP (regra #23,
            *-- medida tambem para CheckBox): ficaria nos 100x17 do default e
            *-- cortaria "Exportar Imagens". Por isso AutoSize = .F. explicito
            *-- + Width que caiba o texto; Height = 17 eh o da classe
            *-- fwcheckbox (docs/FRAMEWORK_class_codigo_fonte.txt).
            .AutoSize      = .F.
            .Top           = 53
            .Left          = 11
            .Width         = 150
            .Height        = 17
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .SpecialEffect = 1
            .Caption       = "Exportar Imagens"
            .Value         = 1
            .Visible       = .T.
        ENDWITH

        loc_oTxt.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oTxt.shp_4c_Shape2
            .Top         = 77
            .Left        = 11
            .Width       = 560
            .Height      = 36
            .BackStyle   = 0
            .BorderStyle = 6
            .BorderWidth = 1
            .Curvature   = 12
            *-- BorderColor NAO entra: o dump de Shape2 declara BackStyle/
            *-- BorderStyle/BorderWidth/Curvature e NAO declara BorderColor,
            *-- entao a moldura arredondada do legado sai na cor DEFAULT da
            *-- base class Shape. Medido no VFP9 em 2026-11-05 (automation\
            *-- probe738f6.prg): esse default eh 6579300 = RGB(100,100,100),
            *-- NAO preto - o RGB(90,90,90) que estava aqui era invencao
            *-- (5921370), copiada do padrao de label de dados. Diferenca de
            *-- 10 tons que nao quebra nada e nao aparece em log algum.
            *-- Shape1 eh o caso OPOSTO: o dump DECLARA BorderColor =
            *-- 136,189,188, e por isso lah a propriedade entra.
            .Visible     = .T.
        ENDWITH

        loc_oTxt.AddObject("lbl_4c_LblResults", "Label")
        WITH loc_oTxt.lbl_4c_LblResults
            .Top       = 88
            .Left      = 19
            .Width     = 543
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Shape1 (moldura decorativa) + os dois botoes de
    * acao do legado (Cancela -> cmd_4c_Cancela / Processa -> cmd_4c_
    * Processa), ambos classe fwbtng (framework.vcx). O dump so sobrescreve
    * Top/Left/Picture/Caption (e Cancel em Cancela) - Height/Width/Font*/
    * WordWrap/MousePointer/ForeColor/BackColor/Themes vem do DEFAULT da
    * classe fwbtng (docs/FRAMEWORK_class_codigo_fonte.txt), mesmo padrao
    * usado em ConfigurarBotoes() de Formsigopecm.prg (dialogo-irmao).
    *
    * "\<Processar" preserva o marcador de tecla de acesso (Alt+P) do VFP9 -
    * sintaxe nativa, nao removida na migracao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 7
            .Left          = 615
            .Width         = 173
            .Height        = 110
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top          = 3
            .Left         = 724
            .Height       = 100
            .Width        = 80
            .Cancel       = .T.
            .Caption      = "Encerrar"
            .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .MousePointer = 15
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .Visible      = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top          = 3
            .Left         = 649
            .Height       = 100
            .Width        = 80
            .Caption      = "\<Processar"
            .Picture      = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .WordWrap     = .T.
            .MousePointer = 15
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .T.
            .Visible      = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarChkXml - checkbox que alterna entre o painel TXT (default) e
    * o painel XML (chkXml -> chk_4c_ChkXml). Classe "checkbox" PURA no dump
    * (nao "fwcheckbox", diferente de chk_4c_ChkImagens) - sem default de
    * framework para herdar, entao a transcricao fica so no que o dump
    * declara (Top/Left/Width/Height/Caption), com Font/ForeColor no padrao
    * de label de dados do projeto (CLAUDE.md regra #12) por nao haver
    * override proprio.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarChkXml()
        THIS.AddObject("chk_4c_ChkXml", "CheckBox")
        WITH THIS.chk_4c_ChkXml
            *-- AutoSize = .F. pelo mesmo motivo de chk_4c_ChkImagens (no-op em
            *-- AddObject) - aqui o dump JA traz Width/Height explicitos.
            *-- FontBold NAO entra: o dump de chkXml nao o declara e a classe eh
            *-- "checkbox" PURA (default .F.) - diferente de chkImagens, que eh
            *-- "fwcheckbox" e cujo dump declara FontBold = .T. Marcar negrito
            *-- aqui engrossaria uma legenda que o legado desenha fina.
            .AutoSize  = .F.
            .Top       = 90
            .Left      = 108
            .Width     = 152
            .Height    = 15
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivo em XML"
            .Value     = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPainelXml - painel de geracao do arquivo XML (CntXml no
    * legado -> cnt_4c_Xml), OCULTO por default (Init legado: "Thisform.
    * cntXml.visible = .F."). Fica SEM atribuir .Visible aqui (AddObject ja
    * cria Visible = .F.) - o toggle real eh feito por ChkXmlClick(), e
    * TornarControlesVisiveis() foi ajustado para NAO sobrescrever este
    * container com .T. (continua recursando nos filhos dele).
    *
    * Get_arquivo (txt_4c_Arquivo) eh classe "fwget" com Format = "K!" no
    * legado - transcrito aqui porque eh so um CODIGO informativo
    * (this_cCodArquivo no BO, char(20)); getDirs (txt_4c_Dirs) eh o campo
    * do CAMINHO completo, ReadOnly = .T. pelo mesmo motivo de getArqTXT
    * (getDirs.When -> Return .f. no dump).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelXml()
        LOCAL loc_oXml

        THIS.AddObject("cnt_4c_Xml", "Container")
        loc_oXml = THIS.cnt_4c_Xml
        WITH loc_oXml
            .Top       = 109
            .Left      = 102
            .Width     = 595
            .Height    = 47
            .BackStyle = 0
        ENDWITH

        loc_oXml.AddObject("lbl_4c_LabelArquivo", "Label")
        WITH loc_oXml.lbl_4c_LabelArquivo
            .Top        = 15
            .Left       = 30
            .Width      = 45
            .Height     = 15
            .AutoSize   = .F.
            .Alignment  = 0
            .BackStyle  = 0
            *-- FontBold = .F.: o dump de CntXml.Say1 declara FontItalic/
            *-- FontName/FontSize/ForeColor e NAO declara FontBold, e a classe
            *-- "say" tambem nao (default .F. - ver
            *-- docs/FRAMEWORK_class_codigo_fonte.txt). Nao confundir com
            *-- CntTXT.Say1, cujo dump DECLARA FontBold = .T.
            .FontBold   = .F.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Arquivo :"
            .Visible    = .T.
        ENDWITH

        *-- CAMPO APOSENTADO E SOTERRADO no proprio legado (regra #28).
        *-- Get_arquivo e getDirs tem o MESMO Top (11) e o MESMO Left (78) no
        *-- SCX, e o segundo eh quase tres vezes mais largo: medido no VFP9 em
        *-- 2026-11-05 (automation\probe738f6.prg), txt_4c_Arquivo ocupa
        *-- 78..228 x 11..34 e txt_4c_Dirs ocupa 78..499 x 11..34 - o primeiro
        *-- cabe INTEIRO dentro do segundo, que eh criado DEPOIS e desenha por
        *-- cima. O campo portanto nao aparece e nao recebe clique nenhum.
        *--
        *-- Isso NAO eh defeito da migracao: eh herdado do SCX, e a prova de
        *-- que o legado tambem o abandonou esta no proprio dump - a UNICA
        *-- leitura de Get_arquivo no codigo legado esta COMENTADA
        *-- ("*!* lcArquivo = Thisform.cntXml.Get_Arquivo.Value", em
        *-- Processamento), junto com o SELECT em SigOpGcp que a usava. O
        *-- campo nao tem Valid, nao tem When e nao tem KeyPress.
        *--
        *-- Por isso a ordem de criacao (Arquivo ANTES de Dirs) e a geometria
        *-- ficam IDENTICAS ao SCX: mexer nelas para "desenterrar" o campo
        *-- mostraria na tela algo que o legado nunca mostrou (PILAR 1), e
        *-- esconder com Visible = .F. exigiria mais uma excecao em
        *-- TornarControlesVisiveis() sem mudar nada para o usuario - ele ja
        *-- eh inalcancavel. Consequencia a conhecer: this_cCodArquivo chega
        *-- SEMPRE vazio ao BO (o usuario nao tem onde digitar), e por isso
        *-- nenhum metodo de sigopgarBO o consome - exatamente como no legado.
        loc_oXml.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oXml.txt_4c_Arquivo
            .Top       = 11
            .Left      = 78
            .Width     = 150
            *-- Height = 23 (NAO 22): o dump de Get_arquivo nao declara Height,
            *-- entao vale o default da classe "fwget", que eh 23. SpecialEffect
            *-- e BorderColor NAO entram - nem o dump nem a fwget os declaram
            *-- (sao do IRMAO getArqTXT, textbox PURA, cujo dump declara os
            *-- dois); inventa-los mudaria a moldura do campo.
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Format    = "K!"
            .MaxLength = 20
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oXml.AddObject("txt_4c_Dirs", "TextBox")
        WITH loc_oXml.txt_4c_Dirs
            .Top           = 11
            .Left          = 78
            .Width         = 421
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            *-- BorderColor NAO entra: nao esta no dump de getDirs nem na classe
            *-- "fwget" (vinha copiada do irmao getArqTXT).
            *-- ZOrderSet = 4 do dump fica DE FORA de proposito - eh property so
            *-- do Form Designer, nao existe em runtime (regra #33).
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Value         = ""
            .ToolTipText   = "Diret" + CHR(243) + "rio / Pasta de grava" + ;
                             CHR(231) + CHR(227) + "o do Arquivo"
            .Visible       = .T.
        ENDWITH

        *-- btnDirs eh classe "fwbtnp" (NAO "commandbutton" como o irmao
        *-- btnGetArqO): Font*/WordWrap/MousePointer/ForeColor/BackColor vem do
        *-- DEFAULT da classe (docs/FRAMEWORK_class_codigo_fonte.txt:
        *-- Comic Sans MS 8 bold+italic, MousePointer 15, ForeColor 90,90,90),
        *-- porque o dump de btnDirs sobrescreve so Top/Left/Height/Width/
        *-- Picture/Caption/ToolTipText/PicturePosition. Verdana 10 /
        *-- SpecialEffect = 2 / ForeColor 36,84,155 pertencem ao IRMAO
        *-- btnGetArqO, cujo dump os declara - copia-los para ca era invencao.
        loc_oXml.AddObject("cmd_4c_BtnDirs", "CommandButton")
        WITH loc_oXml.cmd_4c_BtnDirs
            .Top             = 6
            .Left            = 500
            .Height          = 32
            .Width           = 40
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .MousePointer    = 15
            *-- geral_pasta_26.jpg (com 26, NAO 16): o 16 eh o icone do IRMAO
            *-- btnGetArqO. Os DOIS arquivos existem em vbmp\, entao o nome
            *-- errado desenharia um icone sem erro nenhum (regra #25).
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .Caption         = ""
            .ToolTipText     = "Carregar o Diret" + CHR(243) + "rio / Pasta de Grava" + ;
                               CHR(231) + CHR(227) + "o do Arquivo"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F.; este metodo percorre a arvore e os exibe. EXCECAO:
    * cnt_4c_Xml (painel XML) nasce Visible = .F. de proposito (Init
    * legado: "Thisform.cntXml.visible = .F.") e so eh mostrado por
    * ChkXmlClick() quando o usuario marca chk_4c_ChkXml - por isso este
    * metodo PULA a atribuicao de .Visible no proprio container, mas
    * continua RECURSANDO nos filhos dele (regra do CorretorAutomatico
    * #109: pular so o container e nao recursar deixaria os filhos
    * Visible = .F. para sempre, e o painel apareceria vazio quando
    * alternado para visivel).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF UPPER(loc_oControl.Name) = "CNT_4C_XML"
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FASE 8 - LimparCampos: zera os TRES campos de caminho/codigo de arquivo
    * dos dois paineis. Transcricao do bloco que o legado repete IDENTICO em
    * DOIS lugares - no Init ("Thisform.cntXml.getDirs.Value = [] / Thisform.
    * cntXml.Get_arquivo.Value = [] / Thisform.cntTxt.getArqTXT.Value = []") e
    * nas tres primeiras linhas de chkXml.Valid, letra por letra iguais.
    *
    * Eh justamente por serem DUAS copias no legado que o metodo existe: ate a
    * Fase 7 as tres atribuicoes moravam INLINE em ChkXmlClick, e o caminho de
    * ABERTURA da tela nao as tinha - duas copias da mesma regra divergiriam no
    * primeiro campo novo (CLAUDE.md #44, item 6).
    *
    * Zera TAMBEM as tres properties correspondentes do BO, nao so os
    * controles: BOParaForm (abaixo) espelha BO -> tela, entao limpar so a tela
    * deixaria o BO com o caminho velho e o proximo espelhamento o TRARIA DE
    * VOLTA ao campo que o usuario acabou de ver limpo. O legado nao corria
    * esse risco porque nao havia BO - o controle era a unica copia do valor.
    *
    * PROTECTED EXPLICITO - nao eh estilo, eh o escopo REAL: FormBase declara
    * "PROTECTED PROCEDURE LimparCampos" e o VFP9 NAO deixa a subclasse ALARGAR
    * escopo herdado (regra #51). Por isso eh chamado so por THIS., de dentro
    * da classe (regra #8) - nunca de fora, nem pelo harness.
    *==========================================================================
    PROTECTED FUNCTION LimparCampos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cArquivoTxt = ""
            THIS.this_oBusinessObject.this_cArquivoXml = ""
            THIS.this_oBusinessObject.this_cCodArquivo = ""
        ENDIF

        IF VARTYPE(THIS.cnt_4c_TXT) = "O" AND VARTYPE(THIS.cnt_4c_Xml) = "O"
            THIS.cnt_4c_TXT.txt_4c_ArqTXT.Value  = ""
            THIS.cnt_4c_Xml.txt_4c_Dirs.Value    = ""
            THIS.cnt_4c_Xml.txt_4c_Arquivo.Value = ""
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FASE 8 - AplicarPainelPorModo: alterna qual dos dois paineis fica
    * visivel, conforme chk_4c_ChkXml (1 = XML, 0 = TXT). Segundo bloco que o
    * legado repete nos MESMOS dois lugares de LimparCampos: o IF de
    * chkXml.Valid e as duas linhas finais do Init ("Thisform.cntXml.visible =
    * .F. / Thisform.cntTXT.visible = .T.", que sao exatamente este estado com
    * chkXml.Value = 0).
    *
    * Le o CHECKBOX, nao uma copia do modo: o controle eh a fonte unica do que
    * o usuario escolheu (mesmo criterio do campo de filtro da regra #35b) -
    * guardar o modo numa property e consultar ela aqui criaria a segunda copia
    * que este metodo existe para evitar.
    *
    * PUBLIC (sem PROTECTED): o harness de teste chama metodos do form de FORA
    * da classe, e PEMSTATUS(oForm, "Metodo", 5) devolve .T. mesmo em metodo
    * PROTECTED - o teste entraria no branch e a chamada real falharia em
    * runtime com "Property APLICARPAINELPORMODO is not found" (regra #3).
    * Chamar de fora eh seguro: o metodo so LE o checkbox e escreve .Visible,
    * logo eh idempotente.
    *==========================================================================
    PROCEDURE AplicarPainelPorModo()
        IF VARTYPE(THIS.chk_4c_ChkXml) != "O" OR ;
           VARTYPE(THIS.cnt_4c_TXT) != "O" OR ;
           VARTYPE(THIS.cnt_4c_Xml) != "O"
            RETURN .F.
        ENDIF

        IF THIS.chk_4c_ChkXml.Value = 1
            THIS.cnt_4c_Xml.Visible = .T.
            THIS.cnt_4c_TXT.Visible = .F.
        ELSE
            THIS.cnt_4c_Xml.Visible = .F.
            THIS.cnt_4c_TXT.Visible = .T.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FASE 8 - FormParaBO: Tela -> BO. Transfere os CINCO controles de ENTRADA
    * do dialogo para as properties que sigopgarBO.GerarArquivo() consome. Ate
    * a Fase 7 essa leitura morava INLINE em BtnProcessarClickExec; trazida
    * para o hook canonico de FormBase para ficar FONTE UNICA - um segundo
    * caminho que precisasse dos mesmos valores releria o controle em vez de
    * confiar numa copia que ja pode ter ficado velha (CLAUDE.md #44, item 6).
    *
    * "TODOS os campos" (cobranca da Fase 8) esta satisfeito por construcao: o
    * dump tem exatamente TRES TextBox e DOIS CheckBox, e os cinco aparecem
    * aqui. Os dois TextBox de caminho (txt_4c_ArqTXT e txt_4c_Dirs) sao
    * ReadOnly = .T. - o valor so chega pelo picker do botao de pasta vizinho -
    * e txt_4c_Arquivo eh o campo soterrado documentado em
    * ConfigurarPainelXml(), que por isso chega SEMPRE vazio ao BO. Os tres sao
    * lidos de qualquer forma: decidir quais campos consumir eh do BO, nao
    * deste hook, e omitir um aqui esconderia a informacao de quem reler o par.
    *
    * PROTECTED EXPLICITO pelo MESMO motivo de LimparCampos, acima (regra #51).
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.chk_4c_ChkXml) = "O" AND ;
           VARTYPE(THIS.cnt_4c_TXT) = "O" AND ;
           VARTYPE(THIS.cnt_4c_Xml) = "O"
            THIS.this_oBusinessObject.this_lGeraXml         = (THIS.chk_4c_ChkXml.Value = 1)
            THIS.this_oBusinessObject.this_cArquivoTxt      = ALLTRIM(THIS.cnt_4c_TXT.txt_4c_ArqTXT.Value)
            THIS.this_oBusinessObject.this_lExportarImagens = (THIS.cnt_4c_TXT.chk_4c_ChkImagens.Value = 1)
            THIS.this_oBusinessObject.this_cArquivoXml      = ALLTRIM(THIS.cnt_4c_Xml.txt_4c_Dirs.Value)
            THIS.this_oBusinessObject.this_cCodArquivo      = ALLTRIM(THIS.cnt_4c_Xml.txt_4c_Arquivo.Value)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FASE 8 - BOParaForm: BO -> Tela, caminho inverso do hook acima. Espelha
    * nos controles o modo de geracao (this_lGeraXml), o "Exportar Imagens"
    * (this_lExportarImagens) e os tres caminhos de arquivo, e fecha chamando
    * AplicarPainelPorModo() - o painel visivel eh CONSEQUENCIA do modo, nao um
    * terceiro estado a manter a mao.
    *
    * Existe por FONTE UNICA, nao por simetria decorativa: sem este hook os
    * defaults da tela ficariam escritos DUAS vezes - uma em
    * sigopgarBO.this_lExportarImagens / this_lGeraXml e outra nos ".Value = 1"
    * e ".Value = 0" de ConfigurarPainelTxt/ConfigurarChkXml. As duas copias
    * divergiriam no primeiro ajuste de default: quem mudasse o default no BO
    * veria a tela continuar abrindo como antes. Os ".Value" daqueles blocos
    * FICAM - sao transcricao fiel do que o dump declara (chkImagens.Value = 1;
    * chkXml sem Value, isto eh 0) - e este hook, que roda DEPOIS deles, eh
    * quem tem a ultima palavra.
    *
    * Conversao EXPLICITA logico -> numerico com IIF: CheckBox.Value eh
    * NUMERICO e atribuir .T./.F. direto o converteria para logico, estourando
    * "Operator/operand type mismatch" no primeiro LimparCampos (que grava 0).
    *
    * PROTECTED EXPLICITO pelo MESMO motivo de LimparCampos, acima (regra #51).
    *==========================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.chk_4c_ChkXml) = "O" AND ;
           VARTYPE(THIS.cnt_4c_TXT) = "O" AND ;
           VARTYPE(THIS.cnt_4c_Xml) = "O"
            THIS.chk_4c_ChkXml.Value                = IIF(THIS.this_oBusinessObject.this_lGeraXml, 1, 0)
            THIS.cnt_4c_TXT.chk_4c_ChkImagens.Value = IIF(THIS.this_oBusinessObject.this_lExportarImagens, 1, 0)
            THIS.cnt_4c_TXT.txt_4c_ArqTXT.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cArquivoTxt)
            THIS.cnt_4c_Xml.txt_4c_Dirs.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cArquivoXml)
            THIS.cnt_4c_Xml.txt_4c_Arquivo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodArquivo)

            THIS.AplicarPainelPorModo()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FASE 8 - CarregarLista: nome de CONTRATO do pipeline para "carregar o
    * estado inicial da tela". Num form CRUD esse estado eh a grade da pagina
    * Lista; ESTE legado nao tem grade NENHUMA - medido na Fase 4 e reconferido
    * aqui no dump (zero "BaseClass: grid", zero AddCursor, zero pColuna, zero
    * RecordSource/ControlSource) -, entao o estado inicial dele sao os CAMPOS.
    *
    * O corpo eh exatamente o Init legado, na MESMA ordem em que ele o escreve:
    * limpa os tres campos de arquivo e so depois assenta o modo e o painel
    * (chkXml.Value = 0 -> cntXml invisivel, cntTXT visivel). As duas metades
    * ja sao os funis acima, entao este metodo nao repete regra nenhuma - ele
    * so nomeia a sequencia e lhe da um unico ponto de chamada, usado por
    * InicializarForm().
    *
    * Idempotente de proposito: chamar de novo reconstroi o MESMO estado, sem
    * efeito colateral e sem tocar o banco - o harness de teste alcanca este
    * metodo de fora da classe e precisa poder reaciona-lo. Por isso tambem eh
    * PUBLIC (regra #3: PEMSTATUS nao distingue escopo, e um PROTECTED aqui
    * passaria o teste e falharia em runtime).
    *
    * O nome NAO reclassifica o form no pipeline, conferido em
    * TesteAutomatico.prg: a deteccao automatica que chamaria este form de CRUD
    * por achar o metodo (o IF que exige a AUSENCIA dele e da troca de pagina)
    * so roda quando NAO vem hint do pipeline, e o orquestrador passa o
    * FormType do task_state.json - aqui OPERACIONAL -, que entra antes dela.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = THIS.LimparCampos()

        IF !THIS.BOParaForm()
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - equivale a SIGOPGAR.Processa.Click -> ThisForm.
    * Processamento. PUBLIC porque BINDEVENT exige metodo publico (regra
    * #3). Guarda de reentrancia (this_lProcessando) pelo mesmo motivo
    * documentado em Formsigopecm.prg: sigopgarBO.AtualizarProgresso chama
    * DOEVENTS a cada grupo/produto, o que despacha a fila de eventos do
    * Windows e permite reacionar o botao durante uma geracao em curso.
    *
    * O corpo fica em BtnProcessarClickExec() para a liberacao da flag no
    * FINALLY sobreviver ao RETURN antecipado de "usuario cancelou o
    * MsgConfirma" (regra #47) - e para o Release() (abaixo) so acontecer
    * DEPOIS que a flag ja foi liberada, nunca enquanto o TRY/FINALLY ainda
    * esta no ar.
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro, loc_lConfirmou
        loc_lConfirmou = .F.

        IF THIS.this_lProcessando
            RETURN
        ENDIF

        THIS.this_lProcessando = .T.

        TRY
            loc_lConfirmou = THIS.BtnProcessarClickExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnProcessarClick")
        FINALLY
            THIS.this_lProcessando = .F.
        ENDTRY

        *-- Transcricao literal do legado (Processa.Click: "Thisform.
        *-- Processamento() / Thisform.Release", SEM condicionar ao
        *-- resultado) - o dialogo fecha sempre que o usuario CONFIRMOU a
        *-- geracao, mesmo quando ela falha (o aviso de erro ja foi
        *-- exibido dentro do Exec, acima). So NAO fecha quando o usuario
        *-- desistiu no MsgConfirma.
        IF loc_lConfirmou
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarClickExec - corpo real do Processar. Passa os campos dos
    * dois paineis ao BO pelo hook FormParaBO() (Fase 8 - antes disso a
    * leitura dos cinco controles morava INLINE aqui) e despacha
    * sigopgarBO.GerarArquivo(), que ja escolhe entre GerarArquivoXml()/
    * GerarArquivoTxt() por this_lGeraXml.
    *
    * Retorno: .T. se o usuario CONFIRMOU a geracao (independente do
    * resultado dela) - usado por BtnProcessarClick para decidir se fecha o
    * dialogo; .F. se desistiu no MsgConfirma (dialogo continua aberto).
    *
    * Ha um TERCEIRO retorno .F., sem contraparte no legado: FormParaBO()
    * recusando a leitura da tela. Nao pode acontecer em uso normal (os
    * cinco controles nascem em InicializarForm, sem o qual o form nao
    * existe), e o dialogo fica ABERTO de proposito - com os valores nao
    * lidos, gerar o arquivo escreveria conteudo errado em silencio, e
    * fechar depois do aviso tiraria do usuario a chance de repetir.
    *
    * Contrato de erro do BO (ver cabecalho de GerarArquivoXml/
    * GerarArquivoTxt): falha de validacao preenche this_cMensagemErro SEM
    * MsgErro previo - este handler exibe com MsgAviso (regra #20: a falha
    * de SQL o proprio BO ja exibe, nao repetir). Sucesso do ramo XML ja
    * mostra o proprio MsgInfo dentro de GerarArquivoXml - este handler so
    * complementa a mensagem final do ramo TXT, que o BO deixa em
    * this_cMensagemProgresso sem exibir.
    *==========================================================================
    PROCEDURE BtnProcessarClickExec()
        IF !MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?", ;
                "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
            RETURN .F.
        ENDIF

        *-- Fase 8: a leitura dos cinco controles de entrada passou a
        *-- morar em FormParaBO() - FONTE UNICA (ver a nota la).
        IF !THIS.FormParaBO()
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os dados da tela.", ;
                "Erro em BtnProcessarClickExec")
            RETURN .F.
        ENDIF

        IF THIS.this_oBusinessObject.GerarArquivo()
            IF !THIS.this_oBusinessObject.this_lGeraXml AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemProgresso)
                IF THIS.this_oBusinessObject.this_nQtdProdutos > 0
                    MsgInfo(THIS.this_oBusinessObject.this_cMensagemProgresso, "Processamento Finalizado")
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemProgresso, "Processamento Finalizado")
                ENDIF
            ENDIF
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o!!!")
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - equivale a SIGOPGAR.Cancela.Click -> ThisForm.
    * Release. O dialogo nao devolve resultado nenhum ao form chamador (so
    * gera o arquivo em disco, igual ao irmao Formsigopecm), entao
    * Release() eh fiel ao legado. PUBLIC pelo mesmo motivo de
    * BtnProcessarClick.
    *
    * Fase 8: renomeado - o handler era batizado pelo CAPTION do botao e
    * agora segue o OBJETO, como nos outros oito sites do projeto que ligam
    * um cmd_4c_Cancela. O objeto do legado chama-se "Cancela" e declara
    * Cancel = .T. (a tecla ESC o aciona), entao "cancelar" descreve o papel
    * dele melhor do que o Caption, que o dump traz como "Encerrar" e que
    * segue transcrito tal e qual em ConfigurarBotoes(). O canonico
    * cmd_4c_Encerrar da CLAUDE.md #10 eh do bloco de saida dos forms CRUD -
    * nao deste dialogo, cujo botao tem nome proprio no SCX.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnGetArqOClick - equivale a SIGOPGAR.CntTXT.btnGetArqO.Click: abre o
    * picker nativo GETFILE() e, se o usuario nao cancelar, grava o caminho
    * escolhido em cnt_4c_TXT.txt_4c_ArqTXT.Value (transcricao literal do
    * "GetFile([TXT], [Arquivo TXT:], [Criar], 0, [Informe o Nome do
    * Arquivo TXT])" do legado - nenhum dos literais tem acento).
    *==========================================================================
    PROCEDURE BtnGetArqOClick()
        LOCAL loc_cArquivo

        loc_cArquivo = GETFILE("TXT", "Arquivo TXT:", "Criar", 0, "Informe o Nome do Arquivo TXT")

        IF !EMPTY(loc_cArquivo)
            THIS.cnt_4c_TXT.txt_4c_ArqTXT.Value = ALLTRIM(loc_cArquivo)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnDirsClick - equivale a SIGOPGAR.CntXml.btnDirs.Click: abre o
    * picker nativo PUTFILE() (o legado comenta um GetDir() de diretorio e
    * usa PUTFILE() de fato - transcricao do que o dump executa, nao do
    * que esta comentado) e grava o caminho escolhido em
    * cnt_4c_Xml.txt_4c_Dirs.Value. A leitura inicial de getDirs.Value no
    * dump ("lcDir = Alltrim(ThisForm.cntXml.getDirs.Value)") eh codigo
    * morto - PUTFILE nao recebe esse valor como parametro e o sobrescreve
    * de imediato - por isso nao reproduzida aqui.
    *==========================================================================
    PROCEDURE BtnDirsClick()
        LOCAL loc_cDir

        loc_cDir = PUTFILE("", "", "XML")

        IF !EMPTY(loc_cDir)
            THIS.cnt_4c_Xml.txt_4c_Dirs.Value = ALLTRIM(loc_cDir)
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkXmlClick - equivale a SIGOPGAR.chkXml.Valid: limpa os tres campos
    * de arquivo/diretorio dos dois paineis e alterna qual painel fica
    * visivel, conforme o Value do checkbox (1 = XML, 0 = TXT). Ligado em
    * "Click" (nao em "Valid" - BINDEVENT em TextBox/CheckBox "Valid" nao
    * dispara de forma confiavel, regra CLAUDE.md #3/#46); no CheckBox,
    * Click dispara DEPOIS do toggle de .Value, entao ler THIS.chk_4c_
    * ChkXml.Value aqui ja reflete a escolha do usuario, igual ao This.
    * Value do Valid legado.
    *==========================================================================
    PROCEDURE ChkXmlClick()
        *-- Fase 8: as duas metades sao os funis compartilhados com o
        *-- caminho de abertura da tela (CarregarLista) - o legado escreve
        *-- as MESMAS linhas aqui e no Init.
        THIS.LimparCampos()
        THIS.AplicarPainelPorModo()

        THIS.chk_4c_ChkXml.Refresh()
    ENDPROC

    *==========================================================================
    * AtualizarProgresso - contrato com sigopgarBO.AtualizarProgresso, que
    * chama este metodo a cada grupo/produto processado (equivale ao
    * "ThisForm.cntTxt.lblResults.Caption = ..." repetido dentro do Scan de
    * ProcessaTxt no legado). PUBLIC porque quem chama eh o BO, de fora da
    * classe.
    *
    * O texto eh sempre guardado em this_cUltimoProgresso e so entao
    * exibido, se o label de resultado do painel TXT ja existir - assim o
    * progresso reportado antes de o painel entrar em cena nao se perde
    * (mesmo padrao de Formsigopecm.AtualizarProgresso).
    *==========================================================================
    PROCEDURE AtualizarProgresso(par_cTexto)
        LOCAL loc_cTexto

        loc_cTexto = IIF(VARTYPE(par_cTexto) = "C", par_cTexto, "")
        THIS.this_cUltimoProgresso = loc_cTexto

        IF PEMSTATUS(THIS, "cnt_4c_TXT", 5) AND PEMSTATUS(THIS.cnt_4c_TXT, "lbl_4c_LblResults", 5)
            THIS.cnt_4c_TXT.lbl_4c_LblResults.Caption = loc_cTexto
            THIS.cnt_4c_TXT.lbl_4c_LblResults.Refresh()
            DOEVENTS
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - libera o Business Object e os cursores auxiliares que
    * sigopgarBO.GerarArquivoXml/GerarArquivoTxt abrem durante a geracao,
    * cobrindo o caso de a tela ser fechada no meio do processamento.
    * DODEFAULT() por ULTIMO, para FormBase.Destroy reconstruir os popups do
    * menu principal (regra CLAUDE.md "PROCEDURE Destroy DEVE chamar
    * DODEFAULT() como ULTIMA linha").
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_oFormUI = .NULL.
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.this_oFormPai = .NULL.

        IF USED("cursor_4c_ArqXmlProd")
            USE IN cursor_4c_ArqXmlProd
        ENDIF
        IF USED("cursor_4c_ArqXml")
            USE IN cursor_4c_ArqXml
        ENDIF
        IF USED("cursor_4c_GruposSelec")
            USE IN cursor_4c_GruposSelec
        ENDIF
        IF USED("cursor_4c_ProdutosGrupo")
            USE IN cursor_4c_ProdutosGrupo
        ENDIF
        IF USED("cursor_4c_ControleGrupos")
            USE IN cursor_4c_ControleGrupos
        ENDIF
        IF USED("cursor_4c_DadosGrupo")
            USE IN cursor_4c_DadosGrupo
        ENDIF
        IF USED("cursor_4c_DadosProduto")
            USE IN cursor_4c_DadosProduto
        ENDIF
        IF USED("cursor_4c_Caracteristicas")
            USE IN cursor_4c_Caracteristicas
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopgarBO.prg):
*==============================================================================
* sigopgarBO.prg
*
* Business Object para sigopgar (Gera Arquivo)
* Dialogo filho MODAL ("Gera Arquivo"), aberto por um formulario de consulta/
* selecao de produtos para exportar os produtos SELECIONADOS para um arquivo
* em disco, em um de dois formatos escolhidos pelo usuario (chkXml):
*
*   - chkXml.Value = 1 (XML): gera um XML via XMLAdapter com os produtos do
*     cursor de origem (Produto/Descricao/Grupo/Unidade/Modelo/Foto/DataAlt),
*     salvando no arquivo/diretorio escolhido em CntXml.getDirs.
*   - chkXml.Value = 0 (TXT, default): gera um arquivo TXT de largura fixa
*     (protocolo proprio "td01"/"td03") com um registro por Grupo distinto e
*     um registro por Produto, mais a exportacao de cada foto (FigJpgs) como
*     .jpg separado na mesma pasta do TXT (ProcessaTxt/ExportaProduto no
*     legado), usando o arquivo escolhido em CntTXT.getArqTXT.
*
* Nao possui tabela principal propria: a origem dos produtos e o cursor
* global CrImagens, populado pelo formulario pai ANTES de abrir este dialogo
* (equivalente ao parametro oObjForm do Init legado - aqui this_cCursorOrigem
* documenta o nome do cursor recebido). A gravacao real deste BO e em ARQUIVO
* (StrToFile), nao em tabela do SQL Server - os unicos SQLEXEC existentes sao
* leituras auxiliares (SigCdGrp/SigCdPro/SigPrCar+SigCrRap) para montar o
* conteudo exportado.
*
* Criado na Fase 1 (propriedades e Init). Completo a partir da Fase 2 com
* os metodos que GERAM O ARQUIVO (GerarArquivo/GerarArquivoXml/
* GerarArquivoTxt/ExportarXml) - os "metodos CRUD" deste BO, ja que nao
* ha Inserir()/Atualizar() de tabela neste dialogo (ver acima).
*==============================================================================

DEFINE CLASS sigopgarBO AS BusinessBase

    *-- Cursor de origem dos produtos selecionados (equivalente a CrImagens
    *-- no legado), recebido do formulario pai antes de abrir este dialogo
    this_cCursorOrigem      = ""    && char - nome do cursor com os produtos selecionados (colunas Cpros/Cgrus/Cunis/FigJpgs)

    *-- Modo de geracao escolhido pelo usuario (chkXml.Valid no legado)
    this_lGeraXml           = .F.   && logical - .T. = gera arquivo XML (CntXml visivel) / .F. = gera arquivo TXT (CntTXT visivel), default .F.

    *-- Painel XML (CntXml) - visivel quando this_lGeraXml = .T.
    this_cCodArquivo        = ""    && char(20) - CntXml.Get_arquivo.Value ("Arquivo :") - codigo informativo do arquivo XML (Format "K!" no legado)
    this_cArquivoXml        = ""    && char - CntXml.getDirs.Value - caminho completo do arquivo XML de destino (extensao .xml obrigatoria)

    *-- Painel TXT (CntTXT) - visivel quando this_lGeraXml = .F. (default)
    this_cArquivoTxt        = ""    && char - CntTXT.getArqTXT.Value - caminho completo do arquivo TXT de destino
    this_lExportarImagens   = .T.   && logical - CntTXT.chkImagens.Value - exporta as fotos (FigJpgs) dos produtos como .jpg junto ao TXT, default .T. (Value=1 no SCX)

    *-- Progresso exibido durante a geracao do TXT (CntTXT.lblResults.Caption
    *-- no legado - atualizado a cada grupo/produto processado)
    this_cMensagemProgresso = ""    && char/memo - texto de progresso ("Processando N Grupo(s) / Produtos Gerados : M")
    this_nQtdGrupos         = 0     && numeric - total de grupos distintos no cursor de origem (lnQtd no legado)
    this_nQtdProdutos       = 0     && numeric - total de produtos efetivamente gravados no TXT (lnCnt no legado)

    *-- Referencia opcional ao form para repintar o progresso durante
    *-- GerarArquivoTxt (equivalente ao "ThisForm.cntTxt.lblResults.Caption
    *-- = ..." repetido dentro do Scan de ProcessaTxt no legado). Fica
    *-- .NULL. quando o BO eh usado sem interface (ex.: teste automatizado).
    this_oFormUI            = .NULL.

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object. Sem tabela principal propria (a
    * gravacao efetiva eh em arquivo, nao em tabela do SQL Server - ver
    * cabecalho da classe).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        *-- Cursor global montado pelo formulario pai antes de abrir este
        *-- dialogo (equivalente a CrImagens, citado direto por nome no
        *-- Init/Processamento/ProcessaTxt do legado - nao e parametro do
        *-- Init legado). Mantido como property (em vez de literal fixo)
        *-- para permitir que o Form troque o nome, se precisar.
        THIS.this_cCursorOrigem = "crImagens"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel. Este dialogo nao tem tabela/cursor
    * de registro unico: a origem dos dados eh this_cCursorOrigem (cursor
    * externo populado pelo formulario pai), percorrido inteiro pelo metodo
    * de geracao do arquivo, nao carregado campo a campo numa property.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel. A persistencia deste dialogo eh em ARQUIVO
    * (StrToFile do XML/TXT gerado), nao em INSERT no SQL Server.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel, pelo mesmo motivo de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel: sem tabela nem chave primaria
    * propria neste dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: sem gravacao em tabela do SQL
    * Server neste dialogo, nao ha operacao para auditar aqui.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

    *==========================================================================
    * METODOS DE PROCESSAMENTO (equivalentes as operacoes de gravacao deste
    * dialogo - ver cabecalho da classe: a persistencia real e em ARQUIVO,
    * nunca em INSERT/UPDATE de tabela, entao os "metodos CRUD" deste BO sao
    * os que GERAM O ARQUIVO, nao Inserir()/Atualizar() de BusinessBase
    * (mesmo padrao adotado em sigopecmBO.prg para forms operacionais sem
    * tabela propria).
    *==========================================================================

    *--------------------------------------------------------------------------
    * AtualizarProgresso - Repinta o andamento do processamento (equivalente
    * ao "ThisForm.cntTxt.lblResults.Caption = ..." repetido dentro do Scan
    * de ProcessaTxt no legado). Delega para um metodo PUBLIC do form
    * (THIS.this_oFormUI.AtualizarProgresso(cTexto)), que o Form (Fase 3)
    * implementa para repintar o label dele e fazer Refresh(). Nao faz nada
    * quando this_oFormUI esta .NULL. (BO usado sem interface).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarProgresso(par_nQtdGrupos, par_nQtdProdutos)
        LOCAL loc_cTexto

        loc_cTexto = "Processando " + ALLTRIM(STR(par_nQtdGrupos, 10)) + " Grupo" + ;
            IIF(par_nQtdGrupos = 1, "", "s") + " / " + ;
            "Produtos Gerados : " + ALLTRIM(STR(par_nQtdProdutos, 10))

        THIS.this_cMensagemProgresso = loc_cTexto

        IF VARTYPE(THIS.this_oFormUI) = "O" AND PEMSTATUS(THIS.this_oFormUI, "AtualizarProgresso", 5)
            THIS.this_oFormUI.AtualizarProgresso(loc_cTexto)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivo - Ponto de entrada do processamento (equivalente a
    * SIGOPGAR.Processamento no legado). Fecha o cursor auxiliar de XML
    * (equivalente ao "If Used([csArqXMl]) / Use In csArqXMl" do topo do
    * legado) e despacha para GerarArquivoXml() ou GerarArquivoTxt()
    * conforme this_lGeraXml (chkXml.Value).
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivo()
        IF USED("cursor_4c_ArqXml")
            USE IN cursor_4c_ArqXml
        ENDIF

        IF THIS.this_lGeraXml
            RETURN THIS.GerarArquivoXml()
        ELSE
            RETURN THIS.GerarArquivoTxt()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoXml - Gera o arquivo XML com os produtos do cursor de
    * origem (equivalente ao ramo "Else" de Processamento + ExportaProduto
    * no legado - chkXml.Value = 1).
    *
    * Pre-requisitos (setados pelo Form antes de chamar):
    *   THIS.this_cArquivoXml   - caminho completo do .xml de destino
    *   THIS.this_cCursorOrigem - nome do cursor com os produtos
    *                             selecionados (default "crImagens", ver Init)
    *
    * Contrato de erro: falha de validacao (arquivo vazio/extensao errada/
    * sem produtos selecionados) preenche this_cMensagemErro e retorna .F.
    * SEM exibir MsgErro - quem exibe eh o Form (BtnProcessarClickExec,
    * com MsgAviso), igual ao legado, que devolve .F. e deixa a
    * MessageBox para o chamador. O SetFocus que o legado faz nesses
    * ramos (btnDirs no XML, btnGetArqO no TXT, Cancela no fim de
    * ProcessaTxt) NAO foi reproduzido de proposito: Processa.Click
    * executa "Thisform.Processamento() / Thisform.Release" SEM
    * condicionar ao retorno, entao o dialogo fecha logo depois e o
    * foco recem-posto nunca chega a ser visto. Reproduzi-lo seria
    * acrescentar linha inobservavel; o que importa para o PILAR 1 -
    * mensagem identica e dialogo fechando - esta reproduzido.
    * Falha de SQL exibe o proprio MsgErro aqui, igual ao resto da classe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarArquivoXml()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cCursorOrigem, loc_cProduto, loc_cSQL, loc_nResultado

        loc_lResultado          = .F.
        THIS.this_cMensagemErro = ""
        loc_cArquivo            = ALLTRIM(NVL(THIS.this_cArquivoXml, ""))
        loc_cCursorOrigem       = ALLTRIM(NVL(THIS.this_cCursorOrigem, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "Arquivo n" + CHR(227) + "o informado!!!"
            ELSE
                IF UPPER(JUSTEXT(loc_cArquivo)) != "XML"
                    THIS.this_cMensagemErro = "Arquivo com Extens" + CHR(227) + "o inv" + CHR(225) + "lida!!!"
                ELSE
                    IF EMPTY(loc_cCursorOrigem) OR !USED(loc_cCursorOrigem)
                        THIS.this_cMensagemErro = "Nenhum produto selecionado para exportar."
                    ELSE
                        IF USED("cursor_4c_ArqXml")
                            USE IN cursor_4c_ArqXml
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR cursor_4c_ArqXml (Produto C(14), Descricao C(254), Grupo C(3), Unidade C(3), Modelo C(3), Foto W, DataAlt T)
                        SET NULL OFF
                        INDEX ON Produto TAG Produto

                        loc_lResultado = .T.

                        SELECT (loc_cCursorOrigem)
                        GO TOP
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cProduto = EVALUATE(loc_cCursorOrigem + ".Cpros")

                            loc_cSQL = "SELECT a.DPro3s, a.CodFinP, b.DataAlts" + ;
                                " FROM SigCdPro a JOIN SigCdPrc b ON a.cpros = b.cpros" + ;
                                " WHERE a.cpros = " + EscaparSQL(loc_cProduto)

                            IF USED("cursor_4c_ArqXmlProd")
                                USE IN cursor_4c_ArqXmlProd
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArqXmlProd")

                            IF loc_nResultado < 0
                                MsgErro("Falha na Gera" + CHR(231) + CHR(227) + "o do Arquivo. Reinicie o Processo...", "Select (crTProd)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            INSERT INTO cursor_4c_ArqXml (Produto, Descricao, Grupo, Unidade, Modelo, Foto, DataAlt) VALUES ( ;
                                PADR(loc_cProduto, 14), ;
                                "", ;
                                EVALUATE(loc_cCursorOrigem + ".Cgrus"), ;
                                EVALUATE(loc_cCursorOrigem + ".Cunis"), ;
                                "", ;
                                NVL(EVALUATE(loc_cCursorOrigem + ".FigJpgs"), ""), ;
                                CTOD(""))

                            IF USED("cursor_4c_ArqXmlProd") AND RECCOUNT("cursor_4c_ArqXmlProd") > 0
                                SELECT cursor_4c_ArqXml
                                REPLACE Descricao WITH ALLTRIM(LEFT(TratarNulo(cursor_4c_ArqXmlProd.DPro3s, ""), 254)), ;
                                        Modelo    WITH TratarNulo(cursor_4c_ArqXmlProd.CodFinP, ""), ;
                                        DataAlt   WITH cursor_4c_ArqXmlProd.DataAlts
                            ENDIF

                            IF USED("cursor_4c_ArqXmlProd")
                                USE IN cursor_4c_ArqXmlProd
                            ENDIF

                            SELECT (loc_cCursorOrigem)
                        ENDSCAN

                        IF loc_lResultado
                            SELECT cursor_4c_ArqXml
                            GO TOP

                            THIS.ExportarXml(loc_cArquivo)

                            IF FILE(loc_cArquivo)
                                MsgInfo("Arquivo Gerado com Sucesso", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo XML: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.
        FINALLY
            IF USED("cursor_4c_ArqXmlProd")
                USE IN cursor_4c_ArqXmlProd
            ENDIF
            IF USED("cursor_4c_ArqXml")
                USE IN cursor_4c_ArqXml
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarXml - Grava em disco o arquivo XML com o conteudo do cursor
    * cursor_4c_ArqXml (equivalente a ExportaProduto() no legado - usa
    * XMLAdapter para serializar o cursor e grava a string resultante com
    * StrToFile).
    *
    * NOTA: XMLAdapter.ToXML() recebe o NOME da variavel de saida (como
    * string) e preenche essa variavel por substituicao - igual ao legado
    * (.ToXML([lcStr]) seguido de StrToFile(lcStr, ...)). Passar o VALOR de
    * loc_cStr no lugar do nome "loc_cStr" produziria XML vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExportarXml(par_cArquivo)
        LOCAL loc_oXml, loc_cStr
        loc_cStr = ""

        loc_oXml = CREATEOBJECT("XMLAdapter")

        WITH loc_oXml
            .RespectCursorCP = .T.
            .RespectNesting  = .T.
            .UTF8Encoded     = .T.
            .FormattedOutput = .T.
            .XMLName         = STRCONV("cpros", 12)

            .AddTableSchema("cursor_4c_ArqXml")
            .ToXML("loc_cStr")
        ENDWITH

        STRTOFILE(loc_cStr, par_cArquivo, 0)

        loc_oXml = .NULL.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoTxt - Gera o arquivo TXT de largura fixa (protocolo
    * "td01"/"td03") com um registro por Grupo distinto e um registro por
    * Produto do cursor de origem, mais a exportacao de cada foto (FigJpgs)
    * como .jpg separado na mesma pasta do TXT (equivalente a ProcessaTxt
    * no legado - chkXml.Value <> 1).
    *
    * Pre-requisitos (setados pelo Form antes de chamar):
    *   THIS.this_cArquivoTxt   - caminho completo do .txt a ser gerado
    *   THIS.this_cCursorOrigem - nome do cursor com os produtos
    *                             selecionados (default "crImagens", ver Init)
    *   THIS.this_oFormUI       - opcional, para repintar o progresso
    *
    * this_lExportarImagens NAO entra aqui: este metodo nao a le, porque o
    * legado tambem nao - CntTXT.chkImagens aparece so na arvore de objetos
    * e nas propriedades do SCX, nunca referenciado dentro de ProcessaTxt.
    * Acrescentar essa checagem seria inventar restricao que o legado nao
    * tem (PILAR 1 / CLAUDE.md regra #49) - a imagem e exportada sempre que
    * SigCdPro.FigJpgs estiver preenchido, independente da caixa marcada.
    *
    * Contrato de erro: igual a GerarArquivoXml() - falha de validacao
    * preenche this_cMensagemErro e retorna .F. sem MsgErro; falha de SQL
    * exibe o proprio MsgErro aqui.
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo que
    * nenhum produto tenha sido gerado - igual ao legado, que so muda a
    * mensagem final, nunca o retorno); .F. em falha de validacao ou de SQL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarArquivoTxt()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cCursorOrigem, loc_cChr, loc_cSQL, loc_nResultado
        LOCAL loc_nQtdGrupos, loc_nQtdProdutos
        LOCAL loc_cGru, loc_cDes, loc_cUni, loc_cStr
        LOCAL loc_cRef, loc_cDat, loc_cSit, loc_cPes, loc_cIpi, loc_cIcm, loc_cClf, loc_cTri, loc_cVal, loc_cPre
        LOCAL loc_cGvd, loc_cGr1, loc_cDe1, loc_cUn1
        LOCAL loc_cImg, loc_cFoto

        loc_lResultado = .F.
        THIS.this_cMensagemErro      = ""
        THIS.this_nQtdGrupos         = 0
        THIS.this_nQtdProdutos       = 0
        THIS.this_cMensagemProgresso = ""

        loc_cArquivo      = ALLTRIM(NVL(THIS.this_cArquivoTxt, ""))
        loc_cCursorOrigem = ALLTRIM(NVL(THIS.this_cCursorOrigem, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "O Arquivo a Ser Gerado N" + CHR(227) + "o Foi Informado!!!"
            ELSE
                *-- Testa se o arquivo pode ser criado (igual ao legado)
                STRTOFILE("", loc_cArquivo, 0)

                IF !FILE(loc_cArquivo)
                    THIS.this_cMensagemErro = "O Arquivo N" + CHR(227) + "o Pode Ser Criado!!!"
                ELSE
                    IF EMPTY(loc_cCursorOrigem) OR !USED(loc_cCursorOrigem)
                        THIS.this_cMensagemErro = "Nenhum produto selecionado para exportar."
                    ELSE
                        loc_cChr = CHR(13) + CHR(10)

                        IF USED("cursor_4c_GruposSelec")
                            USE IN cursor_4c_GruposSelec
                        ENDIF
                        SELECT DISTINCT Cgrus FROM (loc_cCursorOrigem) ;
                            INTO CURSOR cursor_4c_GruposSelec ;
                            ORDER BY Cgrus

                        IF USED("cursor_4c_ControleGrupos")
                            USE IN cursor_4c_ControleGrupos
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR cursor_4c_ControleGrupos (Grupo N(8))
                        SET NULL OFF
                        INDEX ON Grupo TAG Grupo

                        loc_nQtdGrupos   = RECCOUNT("cursor_4c_GruposSelec")
                        loc_nQtdProdutos = 0

                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                        loc_lResultado = .T.

                        SELECT cursor_4c_GruposSelec
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cSQL = "SELECT Cgrus, Dgrus, Ids" + ;
                                " FROM SigCdGrp" + ;
                                " WHERE Cgrus = " + EscaparSQL(cursor_4c_GruposSelec.Cgrus) + ;
                                "   AND Ids > 0"

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosGrupo")

                            IF loc_nResultado < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalGrupo)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            SELECT cursor_4c_DadosGrupo
                            GO TOP

                            IF !EOF("cursor_4c_DadosGrupo")
                                loc_cGru = PADL(cursor_4c_DadosGrupo.Ids, 8, "0")
                                loc_cDes = PADR(ALLTRIM(cursor_4c_DadosGrupo.Dgrus), 40)
                                loc_cUni = PADR("", 4)

                                *-- td01 - Tabela de Grupos
                                loc_cStr = "td01" + ;           && Tipo - "td01" - Constante - Caracter(4)
                                    loc_cGru + ;                && ID - Numerico(8)
                                    loc_cDes + ;                && Descricao - Caracter(40)
                                    loc_cUni + loc_cChr         && Unidade - Caracter(4)

                                STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                IF !SEEK(cursor_4c_DadosGrupo.Ids, "cursor_4c_ControleGrupos", "Grupo")
                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (cursor_4c_DadosGrupo.Ids)
                                ENDIF

                                *-- Produtos distintos do grupo (crPros do legado)
                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                                SELECT DISTINCT Cpros FROM (loc_cCursorOrigem) ;
                                    WHERE Cgrus = cursor_4c_GruposSelec.Cgrus ;
                                    INTO CURSOR cursor_4c_ProdutosGrupo ;
                                    ORDER BY Cpros

                                SELECT cursor_4c_ProdutosGrupo
                                SCAN
                                    loc_cSQL = "SELECT Cpros, Dpros, Cunis, DtIncs, Situas, PesoMs, Icms," + ;
                                        " AliqIpis, ClFiscals, SitTrIcms, Pvens, FigJpgs" + ;
                                        " FROM SigCdPro" + ;
                                        " WHERE Cpros = " + EscaparSQL(cursor_4c_ProdutosGrupo.Cpros)

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")

                                    IF loc_nResultado < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalProds)")
                                        loc_lResultado = .F.
                                        EXIT
                                    ENDIF

                                    SELECT cursor_4c_DadosProduto
                                    GO TOP

                                    IF !EOF("cursor_4c_DadosProduto")
                                        loc_cRef = PADR(CHRTRAN(cursor_4c_DadosProduto.Cpros, [ */\:?"'<>|], []), 25)
                                        loc_cDes = PADR(ALLTRIM(cursor_4c_DadosProduto.Dpros), 60)
                                        loc_cUni = PADR(ALLTRIM(cursor_4c_DadosProduto.Cunis), 3)
                                        loc_cDat = DTOC(TTOD(cursor_4c_DadosProduto.DtIncs))
                                        loc_cSit = IIF(cursor_4c_DadosProduto.Situas = 2, "i", "a")
                                        *-- PADL direto na COLUNA (nao em variavel) converte o
                                        *-- numero com as decimais DECLARADAS no SQL Server
                                        *-- (pesoms numeric(8,3), pvens numeric(11,5)); em
                                        *-- variavel usaria SET DECIMALS (regra CLAUDE.md #42
                                        *-- / sigopecmBO.GerarArquivoExportacao).
                                        loc_cPes = STRTRAN(PADL(cursor_4c_DadosProduto.PesoMs, 8, "0"), ".", ",")
                                        loc_cIpi = PADL(INT(cursor_4c_DadosProduto.AliqIpis), 2, "0")
                                        loc_cIcm = PADL(INT(cursor_4c_DadosProduto.Icms), 2, "0")
                                        loc_cClf = PADR(CHRTRAN(cursor_4c_DadosProduto.ClFiscals, [ .], []), 8)
                                        loc_cTri = PADR(cursor_4c_DadosProduto.SitTrIcms, 3)
                                        loc_cVal = STRTRAN(PADL(cursor_4c_DadosProduto.Pvens, 8, "0"), ".", ",")
                                        loc_cPre = PADR("00000000" + loc_cVal + "0000^", 400)

                                        loc_cGvd = ""

                                        *-- Colecoes/caracteristicas do produto (SigPrCar + SigCrRap)
                                        loc_cSQL = "SELECT b.Descrs, b.Ordens" + ;
                                            " FROM SigPrCar a, SigCrRap b" + ;
                                            " WHERE a.Cpros = " + EscaparSQL(cursor_4c_DadosProduto.Cpros) + ;
                                            "   AND a.Codigos = b.Codigos"

                                        IF USED("cursor_4c_Caracteristicas")
                                            USE IN cursor_4c_Caracteristicas
                                        ENDIF
                                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Caracteristicas")

                                        IF loc_nResultado < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalCaracs)")
                                            loc_lResultado = .F.
                                            EXIT
                                        ENDIF

                                        SELECT cursor_4c_Caracteristicas
                                        SCAN
                                            IF !EMPTY(cursor_4c_Caracteristicas.Ordens)
                                                IF !SEEK(cursor_4c_Caracteristicas.Ordens, "cursor_4c_ControleGrupos", "Grupo")
                                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (cursor_4c_Caracteristicas.Ordens)

                                                    loc_cGr1 = PADL(cursor_4c_Caracteristicas.Ordens, 8, "0")
                                                    loc_cDe1 = PADR(ALLTRIM(cursor_4c_Caracteristicas.Descrs), 40)
                                                    loc_cUn1 = PADR("", 4)

                                                    *-- td01 - Tabela de Grupos (colecao)
                                                    loc_cStr = "td01" + loc_cGr1 + loc_cDe1 + loc_cUn1 + loc_cChr

                                                    STRTOFILE(loc_cStr, loc_cArquivo, .T.)
                                                ENDIF
                                                loc_cGvd = loc_cGvd + ALLTRIM(STR(cursor_4c_Caracteristicas.Ordens, 8)) + "^"
                                            ENDIF
                                        ENDSCAN
                                        loc_cGvd = PADR(ALLTRIM(loc_cGvd), 60)

                                        *-- td03 - Tabela de Produtos
                                        loc_cStr = "td03" + ;               && Tipo - "td03" - Constante - Caracter(4)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            loc_cRef + ;                    && Referencia - Caracter(25)
                                            loc_cDes + ;                    && Descricao - Caracter(60)
                                            loc_cUni + ;                    && Unidade - Caracter(3)
                                            loc_cGru + ;                    && ID Grupo - Numerico(8)
                                            "00000000" + ;                  && ID Subgrupo - Numerico(8)
                                            loc_cDat + ;                    && Data do produto - Data(10)
                                            " " + ;                         && Alternativo - Caracter(1)
                                            "001" + ;                       && Multiplicador - Numerico(3)
                                            PADR(loc_cRef, 20) + ;          && Nome Foto Sem Extensao - Caracter(20)
                                            loc_cSit + ;                    && Status Produto a=ativo/i=inativo - Caracter(1)
                                            "00000000" + ;                  && Desconto Maximo em % - Numerico(8)
                                            "00" + ;                        && Tabela - Caracter(2)
                                            loc_cPes + ;                    && Peso - Numerico(8)
                                            " " + ;                         && Status Foto - Caracter(1)
                                            " " + ;                         && Lancamento - Caracter(1)
                                            loc_cIpi + ;                    && % do IPI - Numerico(2)
                                            "00000000" + ;                  && Valor IPI - Numerico(8)
                                            loc_cIcm + ;                    && % ICMS - Numerico(2)
                                            "00000000" + ;                  && Valor ICMS - Numerico(8)
                                            loc_cClf + ;                    && Classificacao Fiscal - Caracter(8)
                                            loc_cTri + ;                    && Situacao Tributaria - Caracter(3)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            "00000000" + ;                  && Estoque - Numerico(8)
                                            loc_cPre + ;                    && Lista(8)+Preco(8)+QtdeMinima(4)+^ - Caracter(400)
                                            SPACE(20) + ;                   && Codigo de Barras - Caracter(20)
                                            SPACE(64) + ;                   && RESERVADO - Caracter(64)
                                            SPACE(400) + ;                  && Caracteristicas (separador CHR(13)) - Caracter(400)
                                            loc_cGvd + loc_cChr             && Material/Complemento - Caracter(60)

                                        STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                        loc_nQtdProdutos = loc_nQtdProdutos + 1
                                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                                        *-- Exportando a imagem. O legado NAO consulta
                                        *-- chkImagens aqui - ver nota de
                                        *-- this_lExportarImagens no cabecalho do metodo.
                                        IF !EMPTY(cursor_4c_DadosProduto.FigJpgs) AND !ISNULL(cursor_4c_DadosProduto.FigJpgs)
                                            loc_cImg  = ALLTRIM(JUSTPATH(loc_cArquivo)) + "\" + ALLTRIM(loc_cRef) + ".Jpg"
                                            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_DadosProduto.FigJpgs, ;
                                                "data:image/png;base64,", ""), ;
                                                "data:image/jpeg;base64,", ""), ;
                                                "data:image/jpg;base64,", ""), 14)
                                            STRTOFILE(loc_cFoto, loc_cImg)
                                        ENDIF
                                    ENDIF

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    IF USED("cursor_4c_Caracteristicas")
                                        USE IN cursor_4c_Caracteristicas
                                    ENDIF
                                ENDSCAN

                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                        ENDSCAN

                        THIS.this_nQtdGrupos   = loc_nQtdGrupos
                        THIS.this_nQtdProdutos = loc_nQtdProdutos

                        IF loc_lResultado
                            IF loc_nQtdProdutos > 0
                                THIS.this_cMensagemProgresso = "Arquivo de Produtos Gerado Com Sucesso!!!"
                            ELSE
                                THIS.this_cMensagemProgresso = "Aten" + CHR(231) + CHR(227) + "o!!! Arquivo Gerado Sem Produtos!!!"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo TXT: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.
        FINALLY
            IF USED("cursor_4c_GruposSelec")
                USE IN cursor_4c_GruposSelec
            ENDIF
            IF USED("cursor_4c_ProdutosGrupo")
                USE IN cursor_4c_ProdutosGrupo
            ENDIF
            IF USED("cursor_4c_ControleGrupos")
                USE IN cursor_4c_ControleGrupos
            ENDIF
            IF USED("cursor_4c_DadosGrupo")
                USE IN cursor_4c_DadosGrupo
            ENDIF
            IF USED("cursor_4c_DadosProduto")
                USE IN cursor_4c_DadosProduto
            ENDIF
            IF USED("cursor_4c_Caracteristicas")
                USE IN cursor_4c_Caracteristicas
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

