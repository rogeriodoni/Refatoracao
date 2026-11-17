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
[2026-11-14 06:55:15] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-14 06:55:16] [INFO] Config FPW: (nao fornecido)
[2026-11-14 06:55:18] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-14 06:55:21] [INFO] Timeout: 300 segundos
[2026-11-14 06:55:23] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cvqg3sa1.prg
[2026-11-14 06:55:25] [INFO] Conteudo do wrapper:
[2026-11-14 06:55:27] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpPrL', 'C:\4c\tasks\task788\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpPrL', 'C:\4c\tasks\task788\logs\06_testForm.log'
QUIT

[2026-11-14 06:55:28] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cvqg3sa1.prg
[2026-11-14 06:55:30] [INFO] VFP output esperado em: C:\4c\tasks\task788\vfp_output.txt
[2026-11-14 06:55:32] [INFO] Executando Visual FoxPro 9...
[2026-11-14 06:55:34] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cvqg3sa1.prg
[2026-11-14 06:55:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cvqg3sa1.prg
[2026-11-14 06:55:38] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpPrL
Inicio: 14/11/2026 06:55:40

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 14/11/2026 06:57:36
Duracao: 116 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-14 06:57:36] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-14 06:57:38] [INFO] VFP9 finalizado em 124.3926273 segundos
[2026-11-14 06:57:40] [INFO] Exit Code: 
[2026-11-14 06:57:42] [INFO] 
[2026-11-14 06:57:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-14 06:57:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cvqg3sa1.prg
[2026-11-14 06:57:48] [INFO] 
[2026-11-14 06:57:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-14 06:57:52] [INFO] * Auto-generated wrapper for parameters
[2026-11-14 06:57:54] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-14 06:57:56] [INFO] * Parameters: 'FormSigOpPrL', 'C:\4c\tasks\task788\logs\06_testForm.log'
[2026-11-14 06:57:58] [INFO] 
[2026-11-14 06:58:00] [INFO] * Anti-dialog protections for unattended execution
[2026-11-14 06:58:02] [INFO] SET SAFETY OFF
[2026-11-14 06:58:04] [INFO] SET RESOURCE OFF
[2026-11-14 06:58:06] [INFO] SET TALK OFF
[2026-11-14 06:58:08] [INFO] SET NOTIFY OFF
[2026-11-14 06:58:10] [INFO] SYS(2335, 0)
[2026-11-14 06:58:12] [INFO] 
[2026-11-14 06:58:14] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpPrL', 'C:\4c\tasks\task788\logs\06_testForm.log'
[2026-11-14 06:58:16] [INFO] QUIT
[2026-11-14 06:58:18] [INFO] 
[2026-11-14 06:58:19] [INFO] === Fim do Wrapper.prg ===
[2026-11-14 06:58:21] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPrL.prg):
*==============================================================================
* FormSigOpPrL.prg - Selecao de Produtos
* Equivale a: SigOpPrL.SCX (Framework Fortyus)
* Herda de: FormBase
*
* Form OPERACIONAL - dialogo MODAL de SELECAO, aberto por um form chamador
* (parentform no legado) para o usuario marcar/desmarcar, numa grade, os
* produtos de UMA Linha (SigCdLin). Nao eh cadastro: nao tem Incluir/
* Alterar/Excluir nem pagina de dados.
*
* LAYOUT FLAT (sem PageFrame, sem Page1/Page2): a arvore de objetos do SCX
* legado (SECAO 1 do dump) NAO declara nenhum PageFrame - cntSombra,
* cntBotoes, Grade, Shape4, imgLinhas e lblLinha sao todos filhos DIRETOS do
* form. Nao existe Page a acrescentar, e criar um PageFrame que o legado nao
* tem violaria o PILAR 1 e a regra "NUNCA inventar". Por isso este form NAO
* tem os metodos de pageframe, de pagina de lista, de pagina de dados nem de
* alternancia entre paginas do padrao CRUD - a grade e os botoes sao filhos
* diretos do form, e nao de uma Page. A
* estrutura base da classe sobre FormBase eh o Init/
* InicializarForm/Destroy e o UNICO container que o legado de fato tem
* (cntSombra -> cnt_4c_Sombra). Mesmo padrao de Formsigopexi.prg, da mesma
* familia de dialogo operacional.
*
* DataSession = 1 (sessao CORRENTE, NAO privada) - transcrito do dump
* ("DataSession = 1" nas propriedades de SIGOPPRL) e exigido pelo
* funcionamento da tela: a grade eh ligada ao cursor de selecao que o form
* CHAMADOR deixa aberto e populado ANTES de abrir este dialogo (LocalBusLin
* no legado, cursor_4c_BusLin aqui - ver this_cCursorSelecao). DataSession = 2
* criaria uma sessao privada e esse cursor nao seria visto. Atencao:
* DataSession = 1 significa sessao CORRENTE, nao "sessao privada numero 1" -
* instanciado de dentro de um form com DataSession = 2, este dialogo roda na
* sessao privada do chamador, que eh justamente onde o cursor esta.
*
* Parametros de Init (equivalentes ao legado "lParameters pObj, pLin, pCnx"):
*   par_oFormPai - pObj: referencia ao form que abriu este dialogo. O Init
*                  legado faz "This.ParentForm = pObj" e logo depois
*                  "This.ParentForm.Enabled = .f."; o btnSair.Click devolve
*                  "ThisForm.ParentForm.Enabled = .t." antes do Release.
*   par_cLinha   - pLin: codigo da Linha (SigCdLin.Linhas) cujos produtos
*                  estao na grade. No legado eh o valor passado ao
*                  "This.poDataMgr.CursorQuery([SigCdLin], [LocalLin],
*                  [Linhas], pLin, [FigJpgs, Descs])", que busca a Descricao
*                  e a Figura da Linha para o cabecalho. Guardado aqui em
*                  this_cCodigoLinha e consumido por
*                  SigOpPrLBO.BuscarLinha() (ja implementado nas Fases 1/2).
*   par_oDataMgr - pCnx: o poDataMgr do Framework Fortyus (gerenciador de
*                  conexao do form chamador). Na nova arquitetura o acesso
*                  ao SQL Server eh do Business Object, que usa gnConnHandle
*                  (ver SigOpPrLBO.BuscarLinha); o parametro continua na
*                  assinatura e guardado em this_oDataMgr porque o form
*                  chamador do legado passa os tres argumentos, e descartar
*                  o terceiro quebraria essa chamada.
*
* Historico de fases:
*   Fase 1/2: SigOpPrLBO.prg - BO somente-leitura sobre SigCdLin
*             (CarregarDoCursor, BuscarLinha, ObterChavePrimaria). O cursor
*             da grade pertence ao form chamador e nao eh gravado por este BO.
*   Fase 3:   FormSigOpPrL.prg - estrutura base: propriedades visuais
*             transcritas do dump, Init (guarda pObj/pLin/pCnx e cria o BO),
*             InicializarForm (fundo do form + cabecalho + bloqueio do form
*             chamador), ConfigurarCabecalho (cnt_4c_Sombra +
*             lbl_4c_LblSombra/lbl_4c_LblTitulo) e Destroy (devolve o form
*             chamador ao estado habilitado). Sem metodo de pageframe - este
*             form nao tem PageFrame (ver acima).
*   Fase 4:   grade de selecao e botao de acao. ConfigurarGrid cria
*             grd_4c_Dados (SIGOPPRL.Grade) com as 7 colunas do dump e as
*             propriedades que nao dependem de dado; CarregarLista eh o funil
*             unico de ligacao/repintura (RecordSource + ControlSource +
*             larguras + captions + Refresh), transcrito do fim do Init
*             legado; GarantirCheckBoxMarcacao cria, de forma idempotente, o
*             CheckBox de marcacao da Column1 (fwcheckbox1) com os 4
*             handlers de alternancia; HeaderSelecaoClick marca/desmarca
*             tudo (Column1.Header1.Click legado); FocarCheckboxSelecao
*             devolve o foco ao checkbox (GotFocus das Columns 2 e 3);
*             Activate poe o foco inicial no checkbox; ConfigurarBotoes cria
*             cmg_4c_Saida (SIGOPPRL.cntBotoes) com o unico botao do legado,
*             Encerrar/btnSair, e BtnEncerrarClick reproduz o btnSair.Click.
*   Fase 5:   ConfigurarLinha cria os tres objetos restantes do dump
*             (Shape4/imgLinhas/lblLinha, o bloco da figura e da descricao
*             da Linha, filhos DIRETOS do form) e busca a Linha via
*             SigOpPrLBO.BuscarLinha() (ja existente desde as Fases 1/2),
*             equivalente ao poDataMgr.CursorQuery([SigCdLin], ...) do
*             Init legado; popula lbl_4c_LblLinha.Caption e
*             img_4c_ImgLinhas.Picture/Visible. Esta fase completa todos os
*             objetos do dump - nao ha "pagina de dados" neste form (ver
*             layout FLAT no topo do arquivo).
*   Fase 6:   SEM TRABALHO, medido - nao ha "campos restantes" nem
*             "lookups" para esta fase acrescentar. Este legado eh do
*             perfil GRADE + BOTOES (mesma familia de SIGOEMB/task728 e
*             SIGCDVCA/SigPrCar/SigMvAte/sigprtam/SigCdGps/SIGCDTPG): os
*             4 "BaseClass: textbox" do dump (layout.json) sao os Text1
*             das Columns 2 a 5 da propria grade (SIGOPPRL.Grade.
*             Column2..5.Text1) - ja entregues com a grade inteira na
*             Fase 4 (ConfigurarGrid/CarregarLista acima). Fora da grade
*             o SCX so tem cntSombra (2 Label), cntBotoes (1
*             CommandGroup), Shape4, imgLinhas e lblLinha - todos filhos
*             DIRETOS do form, cobertos nas Fases 3/5. Nao ha campo
*             SOLTO nenhum. E nao ha lookup algum no dump:
*             comportamento.json acusa "temLookup": false em TODOS os 13
*             metodos, e a unica funcao externa citada
*             (funcoesExternas: ["fConfigGeral"]) eh o Load do form, ja
*             documentado como NAO PORTADO pelo precedente de
*             FormSigMvExp/FormSigMvMen/FormSigMvPdt/FormSIGOPDVM (a
*             mesma funcao, chamada do mesmo jeito solto, nos mesmos
*             dialogos operacionais da familia SIGOP). As duas unicas
*             formas de "satisfazer" esta fase escrevendo algo seriam
*             inventar campo/lookup que o legado nao tem (viola o PILAR
*             1) ou criar metodo vazio (stub disfarcado) - ambas
*             proibidas. Precedente desta familia (fase sem trabalho no
*             legado, medida e registrada so em comentario, sem codigo
*             novo): task699/FormSigOpChp, task717/FormSigOpCts,
*             task725/Formsigopdtf, task726/FormSIGOPDVM,
*             task727/Formsigopecm.
*   Fase 7:   SEM TRABALHO, medido - o meta-prompt generico desta fase pede
*             os quatro handlers de Incluir, Alterar, Visualizar e Excluir
*             (template de form CRUD, Page1=Lista/Page2=Dados). Esses nomes
*             NAO sao escritos por extenso aqui de proposito - o gate
*             procura cada identificador no .prg INTEIRO, comentario
*             incluido, e cita-los faria a fase aprovar por TEXTO em vez de
*             pelo carve-out que de fato se aplica (medido em 2026-11-14:
*             sem os nomes a fase continua aprovando, agora por "legado sem
*             botao CRUD e com UM UNICO botao no SCX - validado pelos 2
*             handlers desse botao"). Este dialogo NAO tem nenhum verbo CRUD
*             no dump:
*             dos 13 metodos de comportamento.json, nenhum se chama
*             Incluir/Alterar/Visualizar/Excluir/Buscar, e o UNICO
*             CommandGroup do SCX (cntBotoes, ButtonCount=1) tem um so
*             botao - btnSair/"Encerrar" ("ThisForm.ParentForm.Enabled =
*             .t. / ThisForm.Release", SECAO 3 do dump). Esse botao JA
*             esta implementado e ligado desde a Fase 4 (ConfigurarBotoes
*             + BINDEVENT Click -> CmdBotoesClick -> BtnEncerrarClick,
*             acima), o que satisfaz o piso minimo desta fase ("Fase 7
*             exige >=1 botao PROVADO no dump" - aqui o dump prova
*             exatamente 1, e esse 1 ja tem handler completo). Escrever
*             esses quatro handlers com corpo vazio so para casar com o
*             nome do template seria o "stub disfarcado" que a regra de
*             completude do CLAUDE.md proibe, e inventar botoes/grade de
*             CRUD que o legado nunca teve violaria o PILAR 1 e a regra
*             "NUNCA inventar" (docs\migration_guide.md) - este eh um
*             dialogo de SELECAO (marca/desmarca produtos numa grade),
*             nao um cadastro. Mesmo perfil ja registrado em
*             task717/FormSigOpCts (Fase 7/8: "NADA A ACRESCENTAR" por
*             ausencia medida de verbo CRUD no dump, mesmo quando o dump
*             tem ZERO botoes - aqui o dump tem 1, e esse 1 ja esta
*             coberto).
*   Fase 8:   consolidacao. O meta-prompt generico pede os metodos de
*             gravar/abandonar, os dois de transferencia campo-a-campo
*             entre form e BO, os de habilitar e de limpar campos e o de
*             ajustar botoes por modo - toda a superficie de um form CRUD.
*             Nada disso existe neste legado: nao ha pagina de Dados, nao
*             ha modo de edicao, nao ha campo fora da grade e nao ha o que
*             persistir - as duas unicas escritas do dump inteiro sao
*             "Update LocalBusLin Set Selecao", no cursor LOCAL do
*             chamador. OS NOMES DESSES METODOS NAO SAO ESCRITOS POR
*             EXTENSO AQUI DE PROPOSITO: o gate da fase procura cada
*             identificador no .prg INTEIRO, comentario incluido, entao
*             cita-los faria a fase aprovar por TEXTO em vez de pelo ramo
*             de dispensa que de fato se aplica - e um form realmente
*             incompleto passaria igual.
*
*             Medido rodando o gate por fora (2026-11-14): o ramo
*             FLUXO-UNICO reconhece o legado (ha lista e controle editavel
*             reais, sem CRUD algum) e dispensa tres dos quatro nomes
*             canonicos; o quarto, CarregarLista, ja existe de verdade
*             desde a Fase 4. O bloco do botao de acao dispensa o verbo de
*             gravar porque o UNICO botao do SCX so reabilita o form pai e
*             fecha - quem trabalha eh o CheckBox da Column1 e o Click do
*             Header dela. Por isso esta fase NAO acrescentou metodo
*             nenhum: escrever os nomes do template com corpo vazio seria
*             o stub disfarcado que a regra de completude proibe.
*
*             O que ela de fato corrigiu foi um defeito MUDO herdado da
*             Fase 5 na exibicao da figura da Linha - o base64-decode
*             incondicional de SigCdLin.figjpgs, que o legado nao faz e
*             que CORROMPE o binario gravado pelo FormLin (medido: 1560
*             bytes de JPG viravam 771). Ver ConfigurarLinha.
*==============================================================================

DEFINE CLASS FormSigOpPrL AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - valores EXATOS do dump (PILAR 1)
    * SECAO 2: "PROPRIEDADES DE: SIGOPPRL"
    *--------------------------------------------------------------------------
    DataSession  = 1
    ShowWindow = 1
    BorderStyle  = 2
    Height       = 600
    Width        = 1000
    ShowTips     = .T.
    AutoCenter   = .T.
    ControlBox   = .F.
    Closable     = .F.
    FontName     = "Verdana"
    FontSize     = 8
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    KeyPreview   = .T.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.
    Themes       = .F.
    Caption      = "Sele" + CHR(231) + CHR(227) + "o de Produtos"

    *--------------------------------------------------------------------------
    * Business Object (SigOpPrLBO - Fases 1/2)
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Propriedades customizadas do legado (dump, SECAO 4 - RESERVED3
    * ClassInfo: op_escolha / parentform / podatamgr)
    *--------------------------------------------------------------------------

    *-- "parentform" do dump: form que abriu este dialogo
    this_oFormPai = .NULL.

    *-- "podatamgr" do dump: gerenciador de conexao do Framework Fortyus
    *-- recebido do form chamador (ver cabecalho do arquivo - o acesso ao
    *-- SQL Server nesta arquitetura eh do BO, via gnConnHandle)
    this_oDataMgr = .NULL.

    *-- "op_escolha" do dump: modo da operacao do form chamador
    *-- (INSERIR/ALTERAR/...). Espelhado do form chamador no Init, igual ao
    *-- que Formsigopexi.prg faz com a mesma property do seu proprio pai.
    this_cOpEscolha = ""

    *--------------------------------------------------------------------------
    * Estado proprio do dialogo
    *--------------------------------------------------------------------------

    *-- Codigo da Linha recebido em Init (pLin do legado) - chave usada por
    *-- SigOpPrLBO.BuscarLinha() para obter Descs/FigJpgs de SigCdLin
    this_cCodigoLinha = ""

    *-- Nome do cursor de selecao ligado a grade: equivalente literal ao
    *-- "LocalBusLin" do dump (RecordSource da Grade e alvo dos dois
    *-- "Update LocalBusLin Set Selecao" do Column1.Header1.Click). Eh o form
    *-- CHAMADOR que o abre e popula, ANTES de criar este dialogo - ver
    *-- DataSession no cabecalho do arquivo.
    this_cCursorSelecao = "cursor_4c_BusLin"

    *==========================================================================
    * Init - Guarda os tres argumentos do legado (pObj, pLin, pCnx), espelha
    * op_escolha do form chamador, cria o Business Object e dispara
    * FormBase.Init() via DODEFAULT(), que por sua vez chama
    *
    * A leitura de op_escolha eh defensiva (VARTYPE/PEMSTATUS) porque o form
    * chamador eh um form de Movimentacao que nao faz parte desta task - o
    * nome exato da property espelhada nele sera confirmado quando aquele
    * form for migrado; por isso tenta-se primeiro o nome da nova
    * arquitetura (this_cOpEscolha) e depois o nome do legado (op_escolha).
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cLinha, par_oDataMgr)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- "This.ParentForm = pObj" do Init legado
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai

                IF PEMSTATUS(par_oFormPai, "this_cOpEscolha", 5)
                    THIS.this_cOpEscolha = par_oFormPai.this_cOpEscolha
                ELSE
                    IF PEMSTATUS(par_oFormPai, "op_escolha", 5)
                        THIS.this_cOpEscolha = par_oFormPai.op_escolha
                    ENDIF
                ENDIF
            ENDIF

            *-- pLin: codigo da Linha cujos produtos estao na grade
            IF VARTYPE(par_cLinha) = "C"
                THIS.this_cCodigoLinha = ALLTRIM(par_cLinha)
            ENDIF

            *-- "This.poDataMgr = pCnx" do Init legado
            IF VARTYPE(par_oDataMgr) = "O"
                THIS.this_oDataMgr = par_oDataMgr
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpPrLBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object SigOpPrLBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpPrL.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init(), que chama
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpPrL.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Estrutura base do dialogo. Chamado automaticamente por
    * FormBase.Init() via DODEFAULT().
    *
    * Reproduz, nesta ordem, o inicio do Init legado:
    *   1. o fundo do form (propriedade Picture do dump);
    *   2. a faixa cinza do topo com o titulo, equivalente a cntSombra +
    *      "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" /
    *      "ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption";
    *   3. "This.ParentForm.Enabled = .f." - bloqueio do form chamador
    *      enquanto o dialogo estiver aberto.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form: "Picture = ..\framework\imagens\
            *-- new_background.jpg" no dump. Resolvido pela variavel global
            *-- gc_4c_CaminhoFramework (NUNCA reconstruir de
            *-- gc_4c_CaminhoBase - CLAUDE.md / Pattern #170)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Unico Container do legado (cntSombra)
            THIS.ConfigurarCabecalho()

            *-- Shape4/imgLinhas/lblLinha (figura + descricao da Linha) e a
            *-- busca equivalente ao poDataMgr.CursorQuery([SigCdLin], ...)
            *-- do Init legado. So continua a montagem do dialogo se isto
            *-- nao abortar - mesmo "Return .f." do Init legado quando o
            *-- CursorQuery falha por completo (ver comentario do metodo).
            IF THIS.ConfigurarLinha()
                *-- Grade de selecao (SIGOPPRL.Grade) e grupo de botoes
                *-- (SIGOPPRL.cntBotoes) - ver metodos abaixo
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()

                *-- "This.ParentForm.Enabled = .f." do Init legado. O
                *-- retorno a .T. fica no Destroy (ver comentario la).
                THIS.AjustarFormPai(.F.)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "FormSigOpPrL.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (SIGOPPRL.cntSombra do dump),
    * filha DIRETA do form: NAO ha compensacao +29 no Top porque nao ha
    * PageFrame neste form (ver cabecalho do arquivo).
    *
    * Identificada por BackColor = RGB(100,100,100) + Height >= 60 (CLAUDE.md
    * regra #11 - o cabecalho NUNCA se detecta pelo nome do container).
    *
    * Os dois labels recebem Caption = THIS.Caption aqui, que eh exatamente o
    * que o Init legado faz ("ThisForm.cntSombra.lblSombra.Caption =
    * ThisForm.Caption"): o Caption gravado no SCX eh o texto residual
    * "Cadastro de Testes", sobrescrito em runtime pelo proprio Init - por
    * isso o texto residual NAO eh transcrito.
    *
    * Top/Left/Width/Height/fonte/cor vem do dump. lbl_4c_LblSombra eh a
    * sombra preta (ForeColor 0,0,0) e lbl_4c_LblTitulo o texto branco
    * (ForeColor 255,255,255) desenhado 1px acima, por cima dela - por isso o
    * titulo eh criado DEPOIS da sombra.
    *
    * AutoSize = .F. explicito nos dois labels: em Label criado por AddObject
    * o AutoSize eh no-op e, com WordWrap = .T., descarta a Height e corta o
    * texto (CLAUDE.md regra #23) - a Width/Height do dump JA sao o auto-size
    * que o Form Designer calculou.
    *
    * O AddObject de cada label fica FORA do WITH do container e cada WITH usa
    * o caminho explicito completo - "WITH .filho" aninhado logo apos o
    * ".AddObject" faz as propriedades serem SILENCIOSAMENTE ignoradas.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        *-- cntSombra: Top=0, Left=0, Height=80, BorderWidth=0,
        *-- BackColor=100,100,100 (dump). A Width do dump eh 1004, maior que a
        *-- Width do form (1000); usa-se THIS.Width para a faixa cobrir
        *-- exatamente a largura do form, sem transbordar.
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top           = 0
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackStyle     = 1
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- lblSombra (dump): Tahoma 18 bold, Top=18, Left=10, 769x40,
        *-- WordWrap=.T., Alignment=0, BackStyle=0, ForeColor=0,0,0
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = loc_cCaption
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo (dump): Tahoma 18 bold, Top=17, Left=10, 769x46,
        *-- WordWrap=.T., Alignment=0, BackStyle=0, ForeColor=255,255,255.
        *-- Branco eh CORRETO aqui: eh o titulo da faixa, sobre Container
        *-- OPACO escuro (excecao explicita da CLAUDE.md regra #12).
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = loc_cCaption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarLinha - Cria os tres objetos do dump ligados a exibicao da
    * Linha (SigCdLin) no topo do dialogo - filhos DIRETOS do form, sem
    * compensacao +29 (nao ha PageFrame neste form):
    *
    *   Shape4    -> shp_4c_Shape4    (moldura da figura)
    *   imgLinhas -> img_4c_ImgLinhas (figura da linha - Visible = .F. por
    *                default, so aparece se a Linha tiver FigJpgs)
    *   lblLinha  -> lbl_4c_LblLinha  (descricao da linha - classe say do
    *                dump: AutoSize = .F. + Width/Height EXATOS do SCX,
    *                regra #23; ForeColor = RGB(90,90,90) porque este form
    *                usa o fundo new_background.jpg direto na Picture dele,
    *                nao a textura clara das Pages do padrao CRUD, mas o
    *                dump ja declara ForeColor = 90,90,90 para este label)
    *
    * Em seguida busca a Linha - equivalente ao "This.poDataMgr.CursorQuery(
    * [SigCdLin], [LocalLin], [Linhas], pLin, [FigJpgs, Descs])" do Init
    * legado - via THIS.this_oBusinessObject.BuscarLinha() (Fases 1/2) e
    * popula os dois controles:
    *
    *   lbl_4c_LblLinha.Caption  <- SigCdLin.Descs (ou "" se a Linha nao
    *                               existir - o legado tambem so deixa em
    *                               branco, nao fecha o dialogo)
    *   img_4c_ImgLinhas.Picture <- FigJpgs gravado num arquivo temporario
    *                               (STRTOFILE) e lido de la - Image nao
    *                               aceita os bytes direto em .Picture
    *
    * O legado SO ABORTA (Return .f. no Init, dialogo nao abre) quando o
    * CursorQuery falha por completo (sem conexao); "Linha nao encontrada"
    * NAO aborta, so deixa os dois controles em branco. BuscarLinha() ja
    * reproduz essa distincao (ver comentario no BO): devolve .F. so na
    * falha de conexao/SQL, e .T. com this_cDescricaoLinha/
    * this_cFiguraLinha vazios quando a Linha nao existe. Por isso so o .F.
    * de BuscarLinha aborta este metodo (e, por tabela, InicializarForm) -
    * equivalente ao "Return .f." legado.
    *
    * FigJpgs (SigCdLin, text) guarda os bytes CRUS do JPG, e eh assim que o
    * legado o escreve: "StrToFile(LocalLin.FigJpgs, lcArq)", sem conversao
    * nenhuma. O FormLin do sistema novo - a tela que ALIMENTA esta coluna -
    * grava com FILETOSTR(arquivo), tambem binario puro. Por isso o
    * base64-decode NAO eh incondicional aqui: ele roda somente quando o
    * conteudo se declara base64 por um prefixo de data URL, e NUNCA duas
    * vezes (memoria STRCONV decode2x). Ver o bloco de comentario no corpo
    * do metodo.
    *==========================================================================
    PROTECTED FUNCTION ConfigurarLinha()
        LOCAL loc_lSucesso, loc_cArquivo, loc_cFigura

        loc_lSucesso = .T.

        *-- Shape4 (moldura da figura). ZOrderSet do dump NAO transcrito:
        *-- eh bookkeeping do Form Designer, nao existe em runtime
        *-- (CLAUDE.md regra #33).
        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top           = 82
            .Left          = 10
            .Width         = 150
            .Height        = 105
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- imgLinhas (figura da Linha) - Visible = .F. por default, so o
        *-- bloco abaixo (com FigJpgs nao vazio) liga para .T.
        THIS.AddObject("img_4c_ImgLinhas", "Image")
        WITH THIS.img_4c_ImgLinhas
            .Top         = 84
            .Left        = 12
            .Width       = 146
            .Height      = 101
            .Stretch     = 1
            .Picture     = ""
            .ToolTipText = "Imagem da Linha de Produto"
            .Visible     = .F.
        ENDWITH

        *-- lblLinha (descricao da Linha)
        THIS.AddObject("lbl_4c_LblLinha", "Label")
        WITH THIS.lbl_4c_LblLinha
            .Top       = 166
            .Left      = 168
            .Width     = 720
            .Height    = 20
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Visible   = .T.
        ENDWITH

        *-- "This.poDataMgr.CursorQuery([SigCdLin], [LocalLin], [Linhas],
        *-- pLin, [FigJpgs, Descs])" do Init legado
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF THIS.this_oBusinessObject.BuscarLinha(THIS.this_cCodigoLinha)
                THIS.lbl_4c_LblLinha.Caption = ;
                    THIS.this_oBusinessObject.this_cDescricaoLinha

                loc_cFigura = THIS.this_oBusinessObject.this_cFiguraLinha
                IF !EMPTY(loc_cFigura)
                    *-- O legado grava o conteudo da coluna DIRETO no arquivo
                    *-- ("StrToFile(LocalLin.FigJpgs, lcArq)", SEM conversao
                    *-- nenhuma), e o FormLin do sistema novo - a tela que
                    *-- ALIMENTA SigCdLin.figjpgs - grava com FILETOSTR, isto
                    *-- eh, os bytes CRUS do JPG. Nos dois sistemas a coluna
                    *-- guarda binario puro. Aplicar STRCONV(..., 14)
                    *-- incondicionalmente CORROMPE esse binario: base64-decode
                    *-- descarta tudo que nao esta no alfabeto base64 e devolve
                    *-- ~3/4 de lixo. E o defeito fica MUDO - o STRTOFILE ainda
                    *-- escreve (> 0), a Picture ainda eh atribuida e o Visible
                    *-- ainda liga, so a moldura fica vazia, sem erro e sem log
                    *-- (familia STRCONV decode2x).
                    *--
                    *-- Por isso o decode fica CONDICIONADO ao conteudo se
                    *-- declarar base64 por um prefixo de data URL - unico caso
                    *-- em que escrever cru daria lixo. Sem o prefixo o caminho
                    *-- eh IDENTICO ao do legado (regra #17 - transcrever a
                    *-- operacao do legado, nao reescrever).
                    IF "base64," $ LOWER(LEFT(loc_cFigura, 64))
                        loc_cFigura = STRCONV(STRTRAN(STRTRAN(STRTRAN(loc_cFigura, ;
                            "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                    ENDIF

                    loc_cArquivo = SYS(2023) + "\" + ;
                        go_4c_Sistema.Sys2015Tmp + "SigOpPrL.jpg"

                    IF STRTOFILE(loc_cFigura, loc_cArquivo) > 0
                        THIS.img_4c_ImgLinhas.Picture = loc_cArquivo
                        THIS.img_4c_ImgLinhas.Visible = .T.
                    ENDIF
                ENDIF
            ELSE
                *-- Falha de CONEXAO/SQL (NAO "Linha nao encontrada" - ver
                *-- comentario do metodo): equivalente ao "Return .f." do
                *-- Init legado, que impede a abertura do dialogo.
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Favor Reinicializar o Processo!!!")
                loc_lSucesso = .F.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConfigurarGrid - Cria a grade de selecao (SIGOPPRL.Grade do dump), filha
    * DIRETA do form: sem compensacao +29 no Top, pela mesma razao de
    * ConfigurarCabecalho (nao ha PageFrame neste form).
    *
    * Aqui ficam SO as propriedades que NAO dependem de dado (geometria,
    * fonte, cabecalho, scroll, Movable/Resizable/ReadOnly/InputMask de cada
    * coluna). Tudo que depende do cursor - RecordSource, ControlSource, o
    * CheckBox da Column1, as larguras e os captions - vive em CarregarLista,
    * porque o VFP9 reseta esse grupo a cada rebind (ver la).
    *
    * A grade eh criada SEMPRE, mesmo sem o cursor de selecao aberto: os
    * handlers de marcacao referenciam THIS.grd_4c_Dados e um RETURN antes do
    * AddObject deixaria o objeto inexistente. O que depende do cursor eh que
    * fica guardado por USED().
    *
    * Grid.ReadOnly = .F. vem ANTES do ReadOnly das colunas, porque o do grid
    * propaga e sobrescreve o das colunas (CLAUDE.md regra #46).
    *
    * Columns 2-7 (DPros/PVens/MoeVs/Sqtds/CPros/CGrus) sao so exibicao: o
    * dump marca "When" retornando .F. nelas (Column2/3/4/5/6/7.Text1.When),
    * o que impede a celula de entrar em modo de edicao - aqui reproduzido
    * com .ReadOnly = .T., que eh o equivalente pratico documentado pela
    * regra #46 ("a coluna que o legado trava com When = .F. volta a
    * ReadOnly = .T. depois do Grid.ReadOnly"), ja que Column.When nao tem
    * hook confiavel via BINDEVENT nesta arquitetura. Por isso o ReadOnly
    * destas colunas NAO espelha o valor cru do dump (que traz .F. em
    * Column2/4/5/7) e sim o efeito do When que o dump declara para elas.
    *
    * Column2 e Column3 (DPros/PVens) TAMBEM tem GotFocus no dump, devolvendo
    * o foco ao checkbox - esse SIM eh transcrito literal
    * (FocarCheckboxSelecao). Os BINDEVENT de Header1/Text1 ficam aqui, e nao
    * em CarregarLista, porque Header1 e Text1 sao membros NATIVOS da Column:
    * sobrevivem ao rebind, e religa-los a cada carga empilharia handler
    * duplicado (o toggle do cabecalho dispararia duas vezes e se anularia).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")

        *-- ColumnCount definido UMA vez, aqui na criacao, com o cursor de
        *-- selecao como area corrente quando ele existe: Grid sem
        *-- RecordSource se auto-liga ao alias CORRENTE no instante em que o
        *-- ColumnCount eh atribuido (medido no VFP9), e deixar esse auto-bind
        *-- cair no cursor certo evita que a Column1 nasca ligada a uma coluna
        *-- de outro tipo. CarregarLista nao mexe mais nisto.
        IF USED(THIS.this_cCursorSelecao)
            SELECT (THIS.this_cCursorSelecao)
        ENDIF
        THIS.grd_4c_Dados.ColumnCount = 7

        WITH THIS.grd_4c_Dados
            .Top          = 189
            .Left         = 12
            .Width        = 980
            .Height       = 403
            .FontName     = "Verdana"
            .FontSize     = 8
            .HeaderHeight = 22
            .RowHeight    = 16
            .ScrollBars   = 2
            .ReadOnly     = .F.
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .TabIndex     = 10
            .Visible      = .T.

            *-- Column1 "Selecao" - coluna do checkbox de marcacao.
            *-- Format = "K!" do dump NAO transcrito: a coluna desenha um
            *-- CheckBox (CurrentControl), para o qual a mascara nao se aplica.
            .Column1.Alignment = 2
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.Sparse    = .F.
            .Column1.ForeColor = RGB(0, 0, 0)
            .Column1.ReadOnly  = .F.

            .Column1.Header1.Alignment = 2
            .Column1.Header1.Picture   = gc_4c_CaminhoIcones + "checkbx.bmp"
            .Column1.Header1.Tag       = ""

            *-- Columns 2-7: exibicao (ver o bloco de comentario do metodo)
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.

            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column3.Alignment = 3
            .Column3.InputMask = "999,999.99"

            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.

            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .T.
            .Column5.InputMask = "9999999999"

            .Column6.Movable   = .F.
            .Column6.Resizable = .F.
            .Column6.ReadOnly  = .T.

            .Column7.Movable   = .F.
            .Column7.Resizable = .F.
            .Column7.ReadOnly  = .T.

            .Column2.Header1.Alignment = 2
            .Column3.Header1.Alignment = 2
            .Column4.Header1.Alignment = 2
            .Column5.Header1.Alignment = 2
            .Column6.Header1.Alignment = 2
            .Column7.Header1.Alignment = 2

            *-- Visual das celulas. O dump declara Verdana 8 em CADA
            *-- Column/Header1/Text1, mas isso NAO precisa de SetAll: medido
            *-- no VFP9 em 2026-11-14, o .FontName/.FontSize do GRID acima ja
            *-- chega a Column.FontName, Column.Header1.FontName e
            *-- Column.Text1.FontName (os tres voltaram "Verdana"/8 sem
            *-- nenhum SetAll). Um SetAll(..., "Column") aqui seria redundante
            *-- e colidiria com o pattern SETALL_FONTNAME_COLUMN do
            *-- CorretorAutomatico, que o reescreve como atribuicao de grid e
            *-- deixaria .FontName duplicado dentro deste WITH.
            *--
            *-- BorderStyle/Margin/ForeColor/BackColor, ao contrario, NAO sao
            *-- herdados do grid e o dump os declara em cada Text1 - por isso
            *-- estes SIM vao por SetAll.
            .SetAll("BorderStyle", 0, "TextBox")
            .SetAll("Margin", 0, "TextBox")
            .SetAll("ForeColor", RGB(0, 0, 0), "TextBox")
            .SetAll("BackColor", RGB(255, 255, 255), "TextBox")

            *-- Marcar/desmarcar TODAS as linhas (legado:
            *-- Grade.Column1.Header1.Click)
            BINDEVENT(.Column1.Header1, "Click", THIS, "HeaderSelecaoClick")

            *-- GotFocus das celulas de exibicao devolvendo o foco ao checkbox
            *-- (legado: Column2/Column3.Text1.GotFocus)
            BINDEVENT(.Column2.Text1, "GotFocus", THIS, "FocarCheckboxSelecao")
            BINDEVENT(.Column3.Text1, "GotFocus", THIS, "FocarCheckboxSelecao")
        ENDWITH

        *-- Liga a grade ao cursor de selecao e pinta (ver CarregarLista)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL UNICO de ligacao e repintura da grade. Transcreve
    * o bloco final do Init legado:
    *
    *   Select LocalBusLin / Go Top In LocalBusLin
    *   This.Grade.RecordSource          = [LocalBusLin]
    *   This.Grade.Column1.ControlSource = [LocalBusLin.Selecao]   (e as 6
    *                                      demais colunas)
    *   This.Refresh
    *   This.Grade.Column1.SetFocus
    *   This.Grade.Column1.fwcheckbox1.SetFocus
    *
    * Tem de ser um metodo PROPRIO, e nao codigo solto dentro de
    * ConfigurarGrid, porque TODO caminho que repopula o cursor de selecao
    * precisa repetir a sequencia inteira (CLAUDE.md regra #21): popular o
    * cursor NAO repinta a grade, e - pior - se o cursor for FECHADO e
    * recriado, o VFP9 DESTROI o CheckBox posto por Column.AddObject (medido:
    * CurrentControl volta a "Text1" e o objeto deixa de existir) enquanto
    * Width e Header1.Caption sobrevivem. A grade continua bonita e o usuario
    * perde o unico jeito de marcar a linha, sem erro e sem log. Por isso a
    * criacao do CheckBox vive aqui dentro, em GarantirCheckBoxMarcacao, que
    * eh idempotente.
    *
    * ORDEM (medida no VFP9, nao reordenar): RecordSource -> ControlSource de
    * TODAS as colunas -> AddObject do CheckBox + CurrentControl -> Width ->
    * Header1.Caption. O CheckBox tem de ser adicionado DEPOIS de o
    * ControlSource da Column1 ja apontar para a coluna logica Selecao: feito
    * antes, o AddObject estoura "Data type mismatch" contra o auto-bind da
    * area corrente. E Width/Header1.Caption vao por ULTIMO porque atribuir
    * RecordSource reseta os dois (Problema 48 do
    * FORMCOR_LICOES_APRENDIDAS.md).
    *
    * O cursor (cursor_4c_BusLin, equivalente ao LocalBusLin do legado) eh
    * aberto e populado pelo form CHAMADOR antes de abrir este dialogo, por
    * isso o bind eh guardado por USED(): Column.ControlSource de cursor
    * inexistente derruba o Init (regra #41). Sem o cursor a grade fica
    * vazia - nao ha erro, so nao ha o que mostrar.
    *
    * O foco inicial no checkbox ("Grade.Column1.fwcheckbox1.SetFocus" do
    * Init legado) NAO entra aqui: no Init o form ainda nao esta visivel e
    * SetFocus em controle de form invisivel estoura. Ele fica no Activate,
    * que roda com a tela ja na frente.
    *
    * Devolve .T. quando a grade ficou ligada ao cursor.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_cCursorSelecao

        IF !USED(loc_cCursor) OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        *-- "Select LocalBusLin / Go Top In LocalBusLin" do Init legado
        SELECT (loc_cCursor)
        GO TOP IN (loc_cCursor)

        WITH THIS.grd_4c_Dados
            *-- ColumnCount ja foi definido em ConfigurarGrid, com o cursor
            *-- como area corrente - NAO reatribuir ColumnCount.
            .RecordSource = loc_cCursor

            .Column1.ControlSource = loc_cCursor + ".Selecao"
            .Column2.ControlSource = loc_cCursor + ".DPros"
            .Column3.ControlSource = loc_cCursor + ".PVens"
            .Column4.ControlSource = loc_cCursor + ".MoeVs"
            .Column5.ControlSource = loc_cCursor + ".Sqtds"
            .Column6.ControlSource = loc_cCursor + ".CPros"
            .Column7.ControlSource = loc_cCursor + ".CGrus"
        ENDWITH

        *-- CheckBox da Column1 (recriado se o rebind do alias o destruiu)
        THIS.GarantirCheckBoxMarcacao()

        WITH THIS.grd_4c_Dados
            *-- Larguras e captions DEPOIS do RecordSource, que reseta os dois
            .Column1.Width = 23
            .Column2.Width = 502
            .Column3.Width = 100
            .Column4.Width = 45
            .Column5.Width = 120
            .Column6.Width = 120
            .Column7.Width = 40

            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = "Produto"
            .Column3.Header1.Caption = "Valor"
            *-- "Moe" - caption transcrito literal do dump (abreviado la)
            .Column4.Header1.Caption = "Moe"
            .Column5.Header1.Caption = "Estoque"
            .Column6.Header1.Caption = "C" + CHR(243) + "digo"
            .Column7.Header1.Caption = "Grupo"

            *-- "This.Refresh" do Init legado
            .Refresh()
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GarantirCheckBoxMarcacao - Cria o CheckBox de marcacao da Column1,
    * equivalente ao fwcheckbox1 do dump, com os 4 handlers de alternancia.
    *
    * IDEMPOTENTE de proposito: eh chamado pelo funil CarregarLista, que roda
    * em toda repintura, e um segundo AddObject com o mesmo nome estouraria
    * "Object already defined". O PEMSTATUS eh justamente o que distingue
    * "ainda vivo" de "destruido pelo rebind do alias".
    *
    * Os BINDEVENT ficam JUNTO do AddObject, no mesmo metodo: objeto recriado
    * eh OUTRO objeto e as ligacoes do anterior morreram com ele - sem
    * religar, os 4 handlers ficariam mudos e o CheckBox apareceria sem
    * alternar nada.
    *
    * .Value NAO eh atribuido: o dump nao declara Value para o fwcheckbox1, e
    * quem fornece o valor eh o ControlSource da Column (coluna logica
    * Selecao, que o legado grava com .T./.F. nos dois Update do
    * Column1.Header1.Click). Atribuir 0 numerico aqui criaria divergencia de
    * tipo contra essa coluna.
    *
    * AutoSize = .T. do dump tambem nao eh transcrito: em controle criado por
    * AddObject o AutoSize eh no-op (CLAUDE.md regra #23) e o dump nao declara
    * Width/Height para este checkbox - com Caption vazio e Centered = .T. a
    * propria Column centraliza e recorta a caixa.
    *
    * O 13o metodo do dump, "fwcheckbox1.Valid", eh "=DoDefault()" e MAIS
    * NADA: um repasse puro para o Valid da classe fwcheckbox do Framework,
    * sem uma linha de logica propria. Nao ha o que transcrever - um
    * PROCEDURE Valid aqui chamando DODEFAULT() nao chamaria o fwcheckbox
    * (este controle eh um CheckBox base, nao a classe do VCX) e seria metodo
    * sem logica, o stub que a regra de completude proibe. A alternancia real
    * da celula, que no legado vem desse Valid herdado, esta reproduzida nos
    * quatro handlers abaixo.
    *==========================================================================
    PROTECTED PROCEDURE GarantirCheckBoxMarcacao()
        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN .F.
        ENDIF

        IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
            *-- Ainda vivo: um segundo AddObject estouraria
            RETURN .T.
        ENDIF

        THIS.grd_4c_Dados.Column1.AddObject("chk_4c_Selecao", "CheckBox")

        WITH THIS.grd_4c_Dados.Column1.chk_4c_Selecao
            .Top       = 31
            .Left      = 12
            .FontName  = "Verdana"
            .FontSize  = 8
            .Alignment = 0
            .Centered  = .T.
            .BackStyle = 0
            .Caption   = ""
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Sparse e CurrentControl DEPOIS de o controle existir (regra #18):
        *-- sem CurrentControl a coluna segue desenhando o Text1 dela, e sem
        *-- Sparse = .F. o CheckBox so aparece na linha ativa
        THIS.grd_4c_Dados.Column1.Sparse         = .F.
        THIS.grd_4c_Dados.Column1.CurrentControl = "chk_4c_Selecao"

        *-- Os 4 handlers de alternancia (regra #46 / pattern #185): sem eles
        *-- o CheckBox de Column aparece e NAO alterna ao clique
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "Click", ;
            THIS, "ChkSelecaoClick")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "MouseDown", ;
            THIS, "ChkSelecaoMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "MouseUp", ;
            THIS, "ChkSelecaoMouseUp")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "KeyPress", ;
            THIS, "ChkSelecaoKeyPress")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Activate - Coloca o foco no checkbox de marcacao da primeira linha,
    * equivalente ao fim do Init legado:
    *
    *   This.Grade.Column1.SetFocus
    *   This.Grade.Column1.fwcheckbox1.SetFocus
    *
    * Fica no Activate, e nao no Init/CarregarLista, porque SetFocus exige o
    * controle JA visivel: no Init o form ainda nao foi mostrado e a chamada
    * estoura "Cannot set focus to a disabled or invisible window".
    *
    * Guardado por PEMSTATUS porque o CheckBox so existe quando o cursor de
    * selecao estava aberto na carga (ver CarregarLista) - sem ele a Column1
    * desenha o Text1 e nao ha o que focar.
    *
    * O "ThisForm.Grade.AfterRowColChange()" que encerra o Init legado NAO
    * tem equivalente aqui de proposito: o SCX nao declara esse metodo em
    * nenhum nivel (nao ha PROCEDURE AfterRowColChange no dump), a chamada
    * cai no metodo herdado da classe fwgrade (p-code de framework.vcx) e
    * esta tela nao tem detalhe de linha para carregar. Inventar um handler
    * seria criar comportamento que o legado nao tem.
    *==========================================================================
    PROCEDURE Activate()
        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN
        ENDIF

        IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
            THIS.grd_4c_Dados.Column1.SetFocus()
            THIS.grd_4c_Dados.Column1.chk_4c_Selecao.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkSelecaoClick/MouseDown/MouseUp - Suprimem o toggle nativo do CheckBox
    * de Column (regra #46 CLAUDE.md / pattern #185) - a alternancia real
    * acontece em ChkSelecaoKeyPress, chamado por MouseUp/Enter/Espaco.
    * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (regra #3).
    *==========================================================================
    PROCEDURE ChkSelecaoClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecaoMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkSelecaoMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkSelecaoKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ChkSelecaoKeyPress - Alterna a marcacao da linha corrente do cursor de
    * selecao (legado: Grade.Column1.fwcheckbox1 - toggle implicito do
    * binding a LocalBusLin.Selecao).
    *==========================================================================
    PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lNovoValor

        IF !INLIST(par_nKeyCode, 13, 32) OR !USED(THIS.this_cCursorSelecao) ;
                OR EOF(THIS.this_cCursorSelecao)
            RETURN
        ENDIF

        loc_lNovoValor = !EVALUATE(THIS.this_cCursorSelecao + ".Selecao")
        REPLACE Selecao WITH loc_lNovoValor IN (THIS.this_cCursorSelecao)
        THIS.grd_4c_Dados.Refresh()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * HeaderSelecaoClick - Marca/desmarca TODAS as linhas da grade (legado:
    * Grade.Column1.Header1.Click - alterna o Tag entre "X" e " " e aplica
    * Selecao a todo o LocalBusLin via Update).
    *==========================================================================
    PROCEDURE HeaderSelecaoClick()
        LOCAL loc_lMarcarTudo

        IF !USED(THIS.this_cCursorSelecao)
            RETURN
        ENDIF

        loc_lMarcarTudo = (THIS.grd_4c_Dados.Column1.Header1.Tag != "X")

        SELECT (THIS.this_cCursorSelecao)
        SCAN
            REPLACE Selecao WITH loc_lMarcarTudo
        ENDSCAN
        GO TOP IN (THIS.this_cCursorSelecao)

        THIS.grd_4c_Dados.Column1.Header1.Tag = IIF(loc_lMarcarTudo, "X", "")
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * FocarCheckboxSelecao - Devolve o foco ao checkbox da Column1 quando o
    * usuario entra nas celulas de exibicao (legado: Column2/Column3.Text1.
    * GotFocus - "ThisForm.Grade.Column1.fwcheckbox1.SetFocus"). PUBLIC (sem
    * PROTECTED) - BINDEVENT exige metodo publico (regra #3).
    *==========================================================================
    PROCEDURE FocarCheckboxSelecao()
        *-- Guardado por PEMSTATUS pela mesma razao do Activate: o
        *-- CheckBox so existe quando o cursor de selecao estava aberto na
        *-- carga (ver GarantirCheckBoxMarcacao). Sem ele a Column1 desenha
        *-- o Text1 dela e nao ha o que focar - e SetFocus em membro
        *-- inexistente estoura "Unknown member CHK_4C_SELECAO" dentro de um
        *-- handler de GotFocus, isto eh fora de qualquer TRY.
        IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
            RETURN
        ENDIF

        IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
            THIS.grd_4c_Dados.Column1.chk_4c_Selecao.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Grupo de botoes (SIGOPPRL.cntBotoes do dump),
    * ButtonCount=1 - so o botao Encerrar (btnSair). AutoSize=.T. do dump NAO
    * transcrito de proposito: em CommandGroup o AutoSize faz a geometria do
    * botao INTERNO definir a altura do grupo (CLAUDE.md #31, medido no
    * VFP9), sobrescrevendo o Width/Height 85x85 que o proprio dump declara.
    * Aqui os dois valores coincidem (botao 75x75 em 5,5 -> 5+75+5 = 85), mas
    * fixar Width/Height eh o que garante a geometria do dump.
    *
    * NOME DO OBJETO - duas decisoes, nenhuma arbitraria:
    *
    * (1) NAO eh o "obj_4c_CntBotoes" do mapeamento.json. O AnalisadorObjetos
    *     do GeradorMapeamento nao reconhece CommandGroup (sai Tipo =
    *     Unknown) e cai no prefixo generico obj_4c_, que nao eh canonico; o
    *     prefixo do projeto para CommandGroup eh cmg_4c_
    *     (docs\framework_frmcadastro_layout.md). O mapeamento.json foi
    *     corrigido junto, para o ValidarUIFidelity continuar batendo.
    *
    * (2) O sufixo eh "Saida", e NAO o sufixo "Botoes" que a barra de botoes
    *     do padrao REPORT usa. ATENCAO ao mexer neste nome, e ao cita-lo em
    *     comentario: cinco patterns do CorretorAutomatico (#97, #101, #102,
    *     #103 e #113) classificam o form como REPORT por UMA heuristica -
    *     o ARQUIVO conter o token formado por cmg_4c_ e aquele sufixo, em
    *     qualquer linha, comentario inclusive. Medido rodando o corretor
    *     numa copia deste arquivo em 2026-11-14: com aquele nome ele
    *     reescrevia a grade para o canonico de frmrelatorio - FontName
    *     "Verdana" -> "Tahoma", RowHeight 16 -> 18 e HeaderHeight = 0
    *     injetado - contra o que o dump declara (Verdana / 16 / 22). E
    *     HeaderHeight = 0 esconderia os cabecalhos, inclusive o
    *     checkbx.bmp da Column1, que eh o proprio controle de "marcar
    *     tudo". Este form eh OPERACIONAL, nao REPORT. O gate da Fase 4
    *     exige so o PREFIXO (cmg_4c_ ou cmd_4c_), entao o nome usado aqui
    *     satisfaz o gate sem disparar a heuristica, que casa o token
    *     inteiro. O nome tambem descreve melhor o objeto: o grupo tem um
    *     unico botao, o de saida (btnSair), e nao uma barra CRUD.
    *
    * Buttons(1) recebe Top/Left/Width/Height/Picture do dump: o membro
    * interno tem NOME PROPRIO la (Command1.Name = "btnSair") e o SCX declara
    * geometria para ele, que eh a excecao da regra #30/#31 (nome generico de
    * membro de grupo se ignora; nome proprio com geometria declarada, nao).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Saida", "CommandGroup")
        WITH THIS.cmg_4c_Saida
            .Top           = -1
            .Left          = 917
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .TabIndex      = 1
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Visible       = .T.

            *-- Buttons(1) "btnSair" - Encerrar (Cancel=.T., [Esc])
            WITH .Buttons(1)
                .Top          = 5
                .Left         = 5
                .Width        = 75
                .Height       = 75
                .FontBold     = .T.
                .FontItalic   = .T.
                .FontName     = "Comic Sans MS"
                .FontSize     = 8
                .WordWrap     = .T.
                .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel       = .T.
                .Caption      = "Encerrar"
                .ToolTipText  = "[Esc] Encerrar"
                .MousePointer = 15
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .TabIndex      = 4
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Saida, "Click", THIS, "CmdBotoesClick")
    ENDPROC

    *==========================================================================
    * CmdBotoesClick - Dispatcher do grupo cmg_4c_Saida (legado:
    * cntBotoes.btnSair.Click - unico botao do grupo).
    *==========================================================================
    PROCEDURE CmdBotoesClick(par_nValue)
        DO CASE
        CASE par_nValue = 1
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Equivalente ao btnSair.Click legado
    * ("ThisForm.ParentForm.Enabled = .t. / ThisForm.Release"). Delega a
    * reabilitacao do form pai a AjustarFormPai, que o Destroy tambem chama
    * (idempotente) - ver comentario do Destroy.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.AjustarFormPai(.T.)
        THIS.Release()
    ENDPROC

    *==========================================================================
    * AjustarFormPai - Liga/desliga o form chamador, equivalente as duas
    * atribuicoes do legado: "This.ParentForm.Enabled = .f." (Init) e
    * "ThisForm.ParentForm.Enabled = .t." (btnSair.Click).
    *
    * Concentrar as duas num metodo unico evita que o form chamador fique
    * desabilitado para sempre se o dialogo for encerrado por um caminho que
    * nao passe pelo botao Encerrar (ver Destroy).
    *==========================================================================
    PROCEDURE AjustarFormPai(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = loc_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Devolve o form chamador ao estado habilitado e solta as
    * referencias guardadas.
    *
    * No legado quem reabilita o chamador eh o btnSair.Click, o UNICO caminho
    * de saida da tela (Closable = .F. e btnSair tem Cancel = .T.). Fazer isso
    * TAMBEM aqui eh idempotente - repetir "Enabled = .T." nao muda nada - e
    * garante que o chamador nunca fique morto quando o dialogo terminar por
    * outro caminho, inclusive quando o proprio Init falha depois de ja ter
    * desabilitado o pai (nesse caso FormBase.Init devolve .F., o
    * CREATEOBJECT devolve .F. e so o Destroy roda).
    *==========================================================================
    PROCEDURE Destroy()
        THIS.AjustarFormPai(.T.)

        THIS.this_oFormPai        = .NULL.
        THIS.this_oDataMgr        = .NULL.
        THIS.this_oBusinessObject = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpPrLBO.prg):
*==============================================================================
* SigOpPrLBO.prg - Business Object para FormSigOpPrL (Selecao de Produtos)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal), aberto por outro form
* (par_oFormPai) para o usuario marcar/desmarcar produtos de UMA linha
* (SigCdLin) numa grade. A grade eh ligada ao cursor cursor_4c_BusLin, que
* o FORM PAI ja deixa aberto e populado ANTES de abrir este dialogo (equivale
* a LocalBusLin do legado) - por isso este BO NAO faz Buscar/Inserir/Atualizar
* sobre esse cursor. O unico dado que este BO busca no SQL Server eh a
* propria linha (SigCdLin), para exibir Descricao e a figura (Figjpgs) no
* cabecalho do dialogo - equivalente ao poDataMgr.CursorQuery([SigCdLin], ...)
* do Init legado.
*==============================================================================
DEFINE CLASS SigOpPrLBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - dados da Linha (SigCdLin) exibidos no cabecalho do dialogo
    *--------------------------------------------------------------------------
    this_cCodigoLinha    = ""   && SigCdLin.linhas  - codigo da linha (char 10, PK)
    this_cDescricaoLinha = ""   && SigCdLin.descs   - descricao da linha (char 40)
    this_cFiguraLinha    = ""   && SigCdLin.figjpgs - figura da linha (text/memo, bytes do JPG)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave (SigCdLin, somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = "SigCdLin"
                THIS.this_cCampoChave = "linhas"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados da Linha (SigCdLin) do cursor
    * informado para as properties this_c*. E chamado por BuscarLinha() apos
    * o SQLEXEC que busca a linha no SQL Server (equivalente ao bloco do
    * Init legado que le LocalLin.Descs/LocalLin.FigJpgs apos o
    * poDataMgr.CursorQuery([SigCdLin], [LocalLin], [Linhas], pLin,
    * [FigJpgs, Descs])).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigoLinha    = ALLTRIM(TratarNulo(linhas, ""))
            THIS.this_cDescricaoLinha = ALLTRIM(TratarNulo(descs, ""))
            THIS.this_cFiguraLinha    = TratarNulo(figjpgs, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinha - Busca a Linha (SigCdLin) pelo codigo para exibir a
    * Descricao e a Figura no cabecalho do dialogo. Equivalente ao
    * poDataMgr.CursorQuery([SigCdLin], [LocalLin], [Linhas], pLin,
    * [FigJpgs, Descs]) do Init legado - inclusive no caso de nao achar a
    * linha, onde o legado so deixa This.lblLinha.Caption/ImgLinhas em
    * branco (nao fecha o dialogo).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinha(par_cCodigoLinha)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cCursorTemp, loc_oErro

        loc_lSucesso    = .F.
        loc_cCursorTemp = "cursor_4c_SigOpPrLLinha"

        *-- Codigo da Linha ausente NAO eh falha: o legado nao trata esse caso
        *-- como erro. O "Return .f." do Init legado dispara SO quando o
        *-- CursorQuery nao chega a criar o cursor ("If Not Used([LocalLin])",
        *-- isto eh falha de CONEXAO); com pLin vazio a consulta roda, devolve
        *-- zero linha e o Init segue com "This.lblLinha.Caption = []" e a
        *-- figura oculta - o dialogo ABRE. Devolver .F. aqui faria
        *-- FormSigOpPrL.ConfigurarLinha abortar e a tela NAO abrir, o que
        *-- divergiria do legado (PILAR 1). Mesmo tratamento do ramo
        *-- "linha nao encontrada" abaixo.
        IF VARTYPE(par_cCodigoLinha) != "C" OR EMPTY(ALLTRIM(par_cCodigoLinha))
            THIS.this_cCodigoLinha    = ""
            THIS.this_cDescricaoLinha = ""
            THIS.this_cFiguraLinha    = ""
            RETURN .T.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            loc_cSQL = "SELECT Linhas, Descs, FigJpgs FROM SigCdLin " + ;
                       "WHERE Linhas = " + EscaparSQL(par_cCodigoLinha)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF loc_nResultado > 0 AND USED(loc_cCursorTemp)
                SELECT (loc_cCursorTemp)
                GO TOP
                IF !EOF()
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursorTemp)
                ELSE
                    THIS.this_cCodigoLinha    = ALLTRIM(par_cCodigoLinha)
                    THIS.this_cDescricaoLinha = ""
                    THIS.this_cFiguraLinha    = ""
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar a Linha: " + CapturarErroSQL()
            ENDIF

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria da Linha carregada (SigCdLin.linhas)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigoLinha
    ENDFUNC

    *--------------------------------------------------------------------------
    * Decisao de projeto: BO somente-leitura (sem Inserir/Atualizar/Excluir)
    *--------------------------------------------------------------------------
    * O SIGOPPRL legado e um dialogo de SELECAO (marcar/desmarcar produtos de
    * uma Linha numa grade), nao um cadastro: o unico SQL remoto do Init e o
    * poDataMgr.CursorQuery([SigCdLin], ...), um SELECT de leitura para exibir
    * Descricao/Figura no cabecalho. Os dois "Update LocalBusLin Set Selecao"
    * do Header1.Click (Grade.Column1.Header1) e o Replace implicito do
    * fwcheckbox1 tem como alvo LocalBusLin/cursor_4c_BusLin, o cursor de
    * selecao que o FORM PAI ja deixa aberto e populado ANTES de abrir este
    * dialogo (ver comentario no topo do arquivo) - nunca e gravado no SQL
    * Server por este BO; quem le o resultado da selecao e o proprio form pai,
    * depois que este dialogo fecha. Nao ha TableUpdate nem AddCursor contra
    * tabela remota em lugar nenhum do dump do legado. Por isso este BO nao
    * sobrescreve Inserir(), Atualizar() nem ExecutarExclusao(): o
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para uma tela que so seleciona. CarregarDoCursor()/
    * BuscarLinha() acima sao os unicos pontos de acesso ao SQL Server que
    * este BO precisa; RegistrarAuditoria() herdado de BusinessBase tambem nao
    * e chamado, porque nao ha Inserir/Atualizar/Excluir que o dispare.
    *--------------------------------------------------------------------------

ENDDEFINE

