# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigopecm.prg] Marcador: * Todo

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopecm.prg):
*============================================================================
* Formsigopecm.prg - Geracao de Arquivo de Exportacao Para e-Commerce
* Migracao de SIGOPECM.SCX (task727)
*
* Form OPERACIONAL de LAYOUT PROPRIO. O objeto raiz do legado eh um "form"
* GENERICO (nao frmcadastro, nao frmrelatorio), portanto NAO existe PageFrame
* nem o par Page1=Lista / Page2=Dados: dos 13 controles do SCX, 11 penduram
* direto na Form e apenas os dois labels do titulo ficam dentro do unico
* container do legado (cntSombra -> cnt_4c_Sombra). Nenhum pgf_4c_* eh criado
* aqui - inventar um PageFrame que o legado nao tem violaria o PILAR 1.
*
* Estrutura visual do legado (SIGOPECM, 800x220), na ordem em que o SCX a
* desenha - cada bloco entra no metodo Configurar* correspondente:
*   cntSombra + lblSombra + lblTitulo -> ConfigurarCabecalho()  (faixa cinza)
*   Shape1, Processa, Cancela         -> ConfigurarBotoes()
*   Say1, getArqTXT, btnGetArqO,
*   chkImagens, Shape2, lblResults    -> ConfigurarCampos()
*
* DataSession: fica no DEFAULT (1 = sessao CORRENTE), e NAO em 2 (privada),
* porque este form eh um dialogo FILHO que consome o cursor crImagens montado
* pelo form chamador (SIGOPECM.Init recebe oFrm). Em sessao privada crImagens
* ficaria invisivel e o processamento nao acharia produto nenhum.
*
* Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
*
* Herda de: FormBase          BO associado: sigopecmBO
* Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
*
* Fase 4/8: este form NAO tem superficie de LISTA (zero Grid/pColuna/
* AddCursor no dump) - "Grid + 6 botoes CRUD" do template generico da fase
* nao se aplica (perfil CAPTURA: campos + botoes de acao, sem grade). O
* trabalho real da fase foi ConfigurarBotoes() (Shape1/Cancela/Processa) e
* ConfigurarCampos() (Say1/getArqTXT/btnGetArqO/chkImagens/Shape2/
* lblResults), com os 3 handlers de botao (BtnProcessarClick/
* BtnEncerrarClick/BtnGetArqOClick) e os BINDEVENTs em InicializarForm.
* Mesmo perfil ja registrado em FormSigOpCtd/task715 e SigOpCts/task717.
*
* Fase 7/8 (eventos principais dos botoes): ZERO codigo novo - os 3 eventos
* que o legado tem JA foram portados junto com os proprios botoes, na Fase 4.
* Nenhum dos 4 nomes CRUD do template generico (BtnIncluirClick/
* BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick) se aplica: cria-los
* exigiria INVENTAR botao que o SCX nao tem (viola o PILAR 1) ou escrever
* metodo vazio (proibido pela regra de completude).
*
* Ausencia de CRUD MEDIDA no dump, pelas tres vias independentes:
*   ESTRUTURAL - "Class: form" PURO (nao frmcadastro, nao frmrelatorio),
*                zero Grupo_Op, zero pcEscolha, zero Grid/pColuna/AddCursor;
*   NOME       - zero Incluir/Alterar/Visualizar/Excluir/Inserir em objeto
*                algum (os 3 botoes sao Cancela, Processa e btnGetArqO);
*   CHAMADA    - os unicos ".Click" do dump inteiro sao os desses 3 botoes.
*
* Superficie de botao do legado = 3 (3 "BaseClass: commandbutton", zero
* commandgroup); handlers entregues = 3 + o Exec de reentrancia. Os SEIS
* metodos com codigo do dump estao TODOS cobertos, um a um:
*   SIGOPECM.processamento -> sigopecmBO.GerarArquivoExportacao() + o
*                             preparo/tratamento em BtnProcessarClickExec
*   SIGOPECM.Init          -> Init(par_oFormPai)  (poObjForm -> this_oFormPai)
*   Processa.Click         -> BtnProcessarClick   (BINDEVENT "Click")
*   Cancela.Click          -> BtnEncerrarClick    (BINDEVENT "Click")
*   btnGetArqO.Click       -> BtnGetArqOClick     (BINDEVENT "Click")
*   getArqTXT.When         -> txt_4c_ArqTXT.ReadOnly = .T. (NAO por BINDEVENT:
*                             ele descarta o retorno do delegate)
* E nao sobra evento de outra familia para portar: zero evento de Grid, zero
* KeyPress, zero Valid, zero LostFocus, zero InteractiveChange no dump - logo
* nada de lookup/F3/F4 (regras #46/#47) alcanca esta tela.
*
* Re-auditado nesta fase, ponto a ponto, o par BINDEVENT + handler:
*   1. os 3 delegates sao PUBLIC (sem PROTECTED) - BINDEVENT com metodo
*      PROTECTED falha em SILENCIO (regra #3);
*   2. os 3 delegates EXISTEM com o nome exato do 4o argumento - delegate
*      inexistente estoura no proprio BINDEVENT;
*   3. os BINDEVENT rodam DEPOIS dos AddObject (InicializarForm chama
*      ConfigurarPageFrame -> Cabecalho/Botoes/Campos antes de bindar);
*   4. os alvos de SetFocus existem com o nome do AddObject
*      (cmd_4c_Cancela / cmd_4c_BtnGetArqO), reproduzindo os tres SetFocus do
*      legado (ThisForm.Cancela.SetFocus no fim do Processamento e
*      ThisForm.btnGetArqO.SetFocus nos dois Return .f. de validacao);
*   5. ESC continua saindo pelo Cancel = .T. do cmd_4c_Cancela, transcrito do
*      dump - o form nao tem ControlBox nem TitleBar;
*   6. Release() (nao Hide()) esta certo aqui: o dialogo nao devolve nada ao
*      chamador - o resultado dele eh o arquivo em disco;
*   7. as 5 properties do BO que os handlers tocam existem declaradas
*      (this_cArquivo, this_lExportarImagens, this_nQtdProdutos,
*      this_cMensagemResultado em sigopecmBO; this_cMensagemErro em
*      BusinessBase) - property nao declarada estoura "Property THIS_X is not
*      found" so em runtime, ao acionar o botao (regra #51/#177);
*   8. os 3 .Picture conferidos em vbmp\ (cadastro_sair_60.jpg,
*      geral_processar_60.jpg, geral_pasta_16.jpg): .Picture inexistente
*      falharia em SILENCIO (regra #25). Themes = .F. eh o do dump e eh
*      seguro porque nenhum dos botoes eh desabilitado em ponto algum.
*
* Sexta ocorrencia da familia "fase sem trabalho no legado", e segunda no eixo
* aberto pelo task726/FormSIGOPDVM: o legado TEM botao (3), entao o gate da
* Fase 7 PASSA (nBotoesLegado = 3 -> minHandlersF7 = 2, contra 3 handlers),
* mas o guard de NO-OP delega a Test-LegadoSemBotaoAlgum, que exige
* nBotoes = 0 - ele mede o LEGADO, e a condicao real de "sem trabalho" aqui
* depende do que a Fase 4 JA entregou. Precedentes: task699/SigOpChp,
* task715/SigOpCtd, task717/SigOpCts, task725/sigopdtf, task726/SIGOPDVM.
*
* Fase 8/8 (consolidacao final): acrescentou o par FormParaBO()/BOParaForm()
* (logo antes de BtnProcessarClick, abaixo) - ate aqui a leitura de
* getArqTXT.Value/chkImagens.Value morava INLINE em BtnProcessarClickExec.
* Os demais nomes que o template desta fase cobra NAO se aplicam a este
* legado, pela MESMA ausencia estrutural ja medida nos blocos acima (zero
* Grid/pColuna/AddCursor, zero commandgroup, 3 commandbutton JA cobertos):
*
*   BtnBuscarClick/BtnSalvarClick/BtnCancelarClick .. nao ha botao com esses
*                        papeis - Processa JA eh a acao de gravar/gerar
*                        (BtnProcessarClick) e Cancela JA eh o encerrar
*                        (BtnEncerrarClick), os dois desde a Fase 4/7.
*   HabilitarCampos .... nenhum campo e' desabilitado em runtime: getArqTXT
*                        ja nasce ReadOnly = .T. (transcricao do When) e
*                        chkImagens nunca trava - nao ha modo a condicionar.
*   LimparCampos ....... o legado nunca limpa getArqTXT/chkImagens depois de
*                        gerar o arquivo (conferido no dump: Processamento
*                        termina com ThisForm.Cancela.SetFocus, sem Replace
*                        nenhum nos dois controles) - zerar aqui inventaria
*                        comportamento que o legado nao tem (PILAR 1).
*
* Escrever qualquer um deles vazio so para casar com o nome do template
* seria o "stub disfarcado" que a regra de completude proibe; com controle
* real, inventaria superficie que o SCX nunca teve.
*
* Setima ocorrencia da familia "fase sem trabalho no legado" (ver a nota da
* Fase 7/8, acima) - a diferenca desta vez e' que HOUVE trabalho real
* (FormParaBO/BOParaForm), so nao nos nomes de botao/modo do template CRUD.
*============================================================================

DEFINE CLASS Formsigopecm AS FormBase

    *==========================================================================
    * Propriedades visuais - transcritas do dump do SCX legado (secao
    * "PROPRIEDADES DE: SIGOPECM"), propriedade a propriedade:
    *   BorderStyle = 2 / Height = 220 / Width = 800 / AutoCenter = .T.
    *   ControlBox = .F. / MaxButton = .F. / MinButton = .F. / TitleBar = 0
    *   WindowType = 1
    * O legado NAO declara Closable - por isso ele tambem NAO aparece aqui:
    * sem barra de titulo os botoes nao desenham, mas Closable continua .T. e
    * o Alt+F4 segue funcionando. Fixar .F. mudaria comportamento (tiraria do
    * usuario a unica forma de desistir sem gerar arquivo), e seria inventar
    * propriedade ausente do dump.
    * ShowWindow = 1 acompanha o canonico do projeto para WindowType = 1.
    *==========================================================================
    Height      = 220
    Width       = 800
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
    * ("ThisForm.poObjForm = oFrm" no Init). No legado ela servia para dois
    * fins: executar SQL (poObjForm.poDataMgr.SqlExecute) e alcancar o cursor
    * crImagens do chamador. Na arquitetura nova o SQL vai por gnConnHandle
    * dentro de sigopecmBO, e crImagens eh visto pela propria data session
    * (ver nota de DataSession no cabecalho); a referencia eh preservada para
    * o contrato de chamada com o form chamador continuar o mesmo.
    *==========================================================================
    this_oFormPai = .NULL.

    *==========================================================================
    * this_cUltimoProgresso - ultimo texto de progresso recebido do BO
    * (equivalente ao Caption de lblResults no legado). Guardado na classe
    * porque o BO reporta progresso desde o inicio do Scan e o label
    * lbl_4c_LblResults eh um controle da area de campos: assim o texto nunca
    * se perde, e quem exibe eh AtualizarProgresso().
    *==========================================================================
    this_cUltimoProgresso = ""

    *==========================================================================
    * this_lProcessando - guarda de REENTRANCIA de BtnProcessarClick.
    *
    * AtualizarProgresso chama DOEVENTS a cada produto gravado (o legado
    * NAO tinha DOEVENTS - ele so atribuia lblResults.Caption). DOEVENTS
    * despacha a fila de eventos do Windows, entao durante uma geracao em
    * curso o usuario pode acionar Processar outra vez (clique ou Alt+P) e
    * REENTRAR no handler. A 2a chamada eh DESTRUTIVA para a 1a:
    *   - GerarArquivoExportacao refaz o teste de gravabilidade com
    *     STRTOFILE("", arquivo, 0) - o modo 0 eh SOBRESCRITA, logo APAGA
    *     os registros td01/td03 que a 1a chamada ja tinha anexado;
    *   - ela faz USE IN + SELECT DISTINCT ... INTO CURSOR
    *     cursor_4c_GruposSelec, isto eh FECHA e RECRIA justamente o
    *     cursor que o SCAN da 1a chamada esta percorrendo;
    *   - zera this_nQtdGrupos/this_nQtdProdutos, entao o total reportado
    *     ao usuario deixa de corresponder ao arquivo em disco.
    * Nada disso aparece na tela: o arquivo sai truncado e o usuario le
    * "Arquivo de Produtos Gerado Com Sucesso!!!".
    *
    * A flag eh liberada no FINALLY do wrapper, nunca no fim do corpo: o
    * corpo tem RETURN antecipado na desistencia do MsgConfirma e, com
    * set/clear simples, a flag travaria ligada e MATARIA o Processar pelo
    * resto da vida do form (regra #47).
    *==========================================================================
    this_lProcessando = .F.

    *==========================================================================
    * Init - replica "Parameters oFrm / ThisForm.poObjForm = oFrm" do legado e
    * define o Caption por CHR() antes de delegar ao FormBase.Init (que eh
    * quem chama InicializarForm - NUNCA chamar InicializarForm aqui tambem,
    * senao os AddObject rodam duas vezes e estouram "member object with this
    * name already exists").
    *
    * par_oFormPai eh OPCIONAL: o harness de teste e a validacao de UI
    * instanciam o form sem parametro, e o legado tambem aceitava Parameters
    * sem argumento (oFrm chegaria .F.). Por isso o tipo eh conferido antes de
    * guardar - atribuir .F. em this_oFormPai faria VARTYPE devolver "L" e os
    * guards de objeto adiante lerem lixo.
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Arquivo de Exporta" + ;
            CHR(231) + CHR(227) + "o Para e-Commerce"

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ValidarParametros - guarda de conexao, PUBLIC para ser alcancavel pelo
    * harness. Chamada ANTES do TRY de InicializarForm, de modo que o RETURN
    * fique fora de TRY/CATCH.
    *
    * O bypass de gb_4c_ModoTeste/gb_4c_ValidandoUI vem PRIMEIRO porque o
    * TesteAutomatico.prg nao abre conexao real: ele define gnConnHandle = 0
    * como sentinela deliberada. Sem o bypass, InicializarForm devolveria .F.,
    * CREATEOBJECT devolveria logico e o teste de instanciacao falharia sem
    * nenhum erro de SQL no log.
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
    * Business Object e os containers de topo do layout legado.
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

            THIS.this_oBusinessObject = CREATEOBJECT("sigopecmBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopecmBO.", ;
                    "Erro em InicializarForm")
            ELSE
                *-- O BO repinta o progresso durante o Scan chamando
                *-- this_oFormUI.AtualizarProgresso() - equivale ao
                *-- "ThisForm.lblResults.Caption = ..." repetido no legado.
                THIS.this_oBusinessObject.this_oFormUI = THIS

                THIS.ConfigurarPageFrame()

                *-- Fase 8: aplica o default de this_lExportarImagens (BO) sobre
                *-- chk_4c_ChkImagens - precisa vir DEPOIS de ConfigurarPageFrame
                *-- (que cria o controle via ConfigurarCampos)
                THIS.BOParaForm()

                *-- BINDEVENTs: botoes e picker criados em ConfigurarBotoes/
                *-- ConfigurarCampos, acima
                BINDEVENT(THIS.cmd_4c_Processa,   "Click", THIS, "BtnProcessarClick")
                BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnEncerrarClick")
                BINDEVENT(THIS.cmd_4c_BtnGetArqO, "Click", THIS, "BtnGetArqOClick")

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
    * real neste form (ver cabecalho do arquivo): o metodo apenas encadeia os
    * configuradores de cada bloco do SCX, na ordem em que o legado os desenha.
    *
    * A ordem importa e eh a do SCX: o cabecalho vem PRIMEIRO porque a faixa
    * ocupa Top = 0..80 e os botoes Processar/Encerrar ficam em Top = 3,
    * DENTRO dessa area - criados depois, eles desenham POR CIMA da faixa;
    * invertido, o cabecalho os cobriria.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampos()

        *-- SEMPRE por ULTIMO: TabIndex eh posicional e cada atribuicao
        *-- reordena os irmaos, entao o passe exige que TODOS os AddObject
        *-- deste nivel ja tenham acontecido.
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * ConfigurarOrdemTabulacao - ordem de tabulacao dos 8 filhos diretos da
    * Form. Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que
    * aqui segue a ordem de DESENHO do SCX (cabecalho -> botoes -> campos) e
    * NAO a ordem de navegacao do legado: sem este passe o Tab cai primeiro no
    * Encerrar (2o objeto criado) e so depois chega aos campos. Nao ha erro,
    * nao ha log e nao aparece em screenshot - so o Tab andando errado.
    *
    * Os numeros abaixo sao a ordem EFETIVA do legado, MEDIDA no VFP9
    * (automation\medir_tabindex_727.prg, 2026-10-31), nao os literais do dump.
    * A distincao importa: o VFP aplica o TabIndex gravado no instante em que
    * CRIA cada objeto, e os literais de Cancela (6) e Processa (5) excedem a
    * contagem de objetos tab-able existentes naquele ponto da ordem de
    * registros do SCX (2 e 3), logo nao sobrevivem ao load. Transcrever 5 e 6
    * ao pe da letra seria FIEL AO ARQUIVO e INFIEL A TELA - e inverteria a
    * dupla, porque no legado quem vem primeiro eh o Encerrar:
    *
    *   literal do SCX : Say1=1 getArqTXT=2 btnGetArqO=3 chkImagens=4
    *                    Processa=5 Cancela=6 lblResults=1 (duplicado)
    *   EFETIVO medido : lblResults=1 Say1=2 getArqTXT=3 btnGetArqO=4
    *                    chkImagens=5 cntSombra=6 Cancela=7 Processa=8
    *
    * Atribuicao em ordem ASCENDENTE (cada uma poe o controle na posicao
    * pedida e empurra os demais para tras) e com contador SEQUENCIAL proprio,
    * sem lacuna e sem repetir: valor duplicado ou fora da faixa eh descartado
    * em SILENCIO pelo VFP, e a faixa valida eh o numero de controles que TEM
    * a propriedade - 8, nao os 10 do ControlCount, porque shp_4c_Shape1 e
    * shp_4c_Shape2 sao Shape e Shape NAO tem TabIndex.
    *
    * Os tres ultimos sao inertes para a navegacao e estao aqui para fechar a
    * faixa 1..8 sem lacuna: Label nao tem TabStop (nao recebe foco) e
    * cnt_4c_Sombra so tem os dois Label do titulo dentro, logo o Tab tambem
    * nao para nele. Quem de fato para eh cmd_4c_BtnGetArqO -> chk_4c_ChkImagens
    * -> cmd_4c_Cancela -> cmd_4c_Processa: txt_4c_ArqTXT fica fora do ciclo
    * por TabStop = .F., que com ReadOnly = .T. eh a transcricao do
    * "PROCEDURE When / Return .f." que o dump declara nele.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        THIS.lbl_4c_LblResults.TabIndex = 1    && SCX lblResults : efetivo 1
        THIS.lbl_4c_Label1.TabIndex     = 2    && SCX Say1       : efetivo 2
        THIS.txt_4c_ArqTXT.TabIndex     = 3    && SCX getArqTXT  : efetivo 3
        THIS.cmd_4c_BtnGetArqO.TabIndex = 4    && SCX btnGetArqO : efetivo 4
        THIS.chk_4c_ChkImagens.TabIndex = 5    && SCX chkImagens : efetivo 5
        THIS.cnt_4c_Sombra.TabIndex     = 6    && SCX cntSombra  : efetivo 6
        THIS.cmd_4c_Cancela.TabIndex    = 7    && SCX Cancela    : efetivo 7
        THIS.cmd_4c_Processa.TabIndex   = 8    && SCX Processa   : efetivo 8
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
    * (cntSombra do legado) e os dois labels sobrepostos que produzem o efeito
    * de sombra: lblSombra em preto (Top = 18) sob lblTitulo em branco
    * (Top = 17). Width/Height/Font/ForeColor transcritos do dump.
    *
    * Os dois labels declaram WordWrap = .T. e Width/Height explicitos no SCX,
    * entao AutoSize fica .F.: em Label criado por AddObject o AutoSize eh
    * no-op para a largura e, com WordWrap, DESCARTA a Height - a linha de
    * texto seria cortada. Os numeros do dump ja sao o auto-size calculado
    * pelo Form Designer, logo fixa-los eh reproducao fiel.
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
            .AutoSize      = .F.
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Shape1 (moldura decorativa) + os dois botoes de acao
    * do legado (Cancela -> cmd_4c_Cancela / Processa -> cmd_4c_Processa),
    * ambos classe fwbtng (framework.vcx). O dump so sobrescreve Top/Left/
    * Picture/Caption/TabIndex (e Cancel em Cancela) - Height/Width/Font*/
    * WordWrap/MousePointer/ForeColor/BackColor/Themes vem do DEFAULT da
    * classe fwbtng (docs/FRAMEWORK_class_codigo_fonte.txt, registro 3495):
    * Height=100, Width=80, FontBold=.T., FontItalic=.T.,
    * FontName="Comic Sans MS", FontSize=8, WordWrap=.T., MousePointer=15,
    * ForeColor=RGB(90,90,90), BackColor=RGB(255,255,255), Themes=.F.
    *
    * Themes=.F. (e nao o padrao standalone Themes=.T.+DisabledPicture da
    * regra #99) porque os dois botoes ficam SEMPRE Enabled=.T. - nunca
    * alternam em runtime, e o proprio fwbtng ja declara Themes=.F.
    *
    * "\<Processar" preserva o marcador de tecla de acesso (Alt+P) do VFP9 -
    * sintaxe nativa, nao removida na migracao (ver FormCliente/FormEnd).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 7
            .Left          = 565
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
            .Top         = 3
            .Left        = 725
            .Height      = 100
            .Width       = 80
            .Cancel      = .T.
            .Caption     = "Encerrar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .MousePointer = 15
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top         = 3
            .Left        = 650
            .Height      = 100
            .Width       = 80
            .Caption     = "\<Processar"
            .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .MousePointer = 15
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - area de parametros do processamento: Say1
    * (lbl_4c_Label1), getArqTXT (txt_4c_ArqTXT), btnGetArqO
    * (cmd_4c_BtnGetArqO), chkImagens (chk_4c_ChkImagens), Shape2
    * (shp_4c_Shape2, moldura do resultado) e lblResults (lbl_4c_LblResults).
    *
    * txt_4c_ArqTXT.ReadOnly = .T. eh a transcricao de getArqTXT.When
    * ("Return .f." no dump) - o campo NAO aceita digitacao, o valor so
    * chega pelo picker de btnGetArqO. NAO se faz isso com BINDEVENT "When":
    * BINDEVENT descarta o retorno do delegate e o campo continuaria
    * digitavel (CLAUDE.md regra #3; precedente: FormSIGOPCCO.prg).
    *
    * lbl_4c_Label1 eh classe "say" (framework.vcx) sem Width/Alignment no
    * dump - AutoSize = .T. herdado da classe eh NO-OP em Label criado por
    * AddObject (regra #23), entao aqui AutoSize = .F. + Width explicito
    * (que cabe "Arquivo a Ser Gerado" em Tahoma 8 bold) + Alignment = 0,
    * com ForeColor = RGB(90,90,90) (default da classe "say", registro 2597
    * de docs/FRAMEWORK_class_codigo_fonte.txt).
    *
    * chk_4c_ChkImagens eh fwcheckbox - mesma armadilha de AutoSize no-op
    * (CheckBox, nao so Label): Width explicito para caber "Exportar
    * Imagens". Height/FontName/FontSize/Alignment/BackStyle/ForeColor/
    * Themes do default da classe (docs/FRAMEWORK_class_codigo_fonte.txt,
    * registro 3401). Value = 1 (numerico, nunca .T./.F. - regra de
    * CheckBox.Value) reproduz o Value = 1 do dump (caixa marcada).
    *
    * lbl_4c_LblResults eh "say" tambem, mas o dump JA sobrescreve
    * AutoSize = .F. + Width = 573 + Height = 15 - esses numeros sao o
    * auto-size calculado pelo Form Designer, reproducao fiel (regra #23).
    * FontName/FontSize/ForeColor ficam no default da classe "say".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 92
            .Left      = 105
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

        THIS.AddObject("txt_4c_ArqTXT", "TextBox")
        WITH THIS.txt_4c_ArqTXT
            .Top           = 109
            .Left          = 105
            .Width         = 560
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

        THIS.AddObject("cmd_4c_BtnGetArqO", "CommandButton")
        WITH THIS.cmd_4c_BtnGetArqO
            .Top           = 107
            .Left          = 666
            .Height        = 26
            .Width         = 26
            .FontBold      = .T.
            .FontName      = "Verdana"
            .FontSize      = 10
            .Picture       = gc_4c_CaminhoIcones + "geral_pasta_16.jpg"
            .Caption       = ""
            .ToolTipText   = "Seleciona o Arquivo Que Ser" + CHR(225) + " Processado"
            .SpecialEffect = 2
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes           = .T.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("chk_4c_ChkImagens", "CheckBox")
        WITH THIS.chk_4c_ChkImagens
            .Top       = 139
            .Left      = 105
            .Width     = 150
            .Height    = 17
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .SpecialEffect = 1
            .Caption   = "Exportar Imagens"
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 163
            .Left        = 105
            .Width       = 590
            .Height      = 36
            .BackStyle   = 0
            .BorderStyle = 6
            .BorderWidth = 1
            .Curvature   = 12
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LblResults", "Label")
        WITH THIS.lbl_4c_LblResults
            .Top       = 174
            .Left      = 113
            .Width     = 573
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
    * FASE 8 - FormParaBO: Tela -> BO. Transfere os DOIS campos de entrada do
    * dialogo (getArqTXT.Value e chkImagens.Value) para as properties que
    * GerarArquivoExportacao() consome. Ate a Fase 7 essa leitura morava
    * INLINE em BtnProcessarClickExec; trazida para o hook canonico de
    * FormBase para ficar FONTE UNICA - um segundo caminho que precisasse dos
    * mesmos dois valores releria o controle em vez de confiar numa copia que
    * ja pode ter ficado velha (CLAUDE.md #44, item 6).
    *
    * "TODOS os campos" (cobranca da Fase 8) esta satisfeito por construcao: o
    * dialogo tem exatamente DOIS controles de ENTRADA (getArqTXT eh
    * ReadOnly = .T. - o valor so chega pelo picker de btnGetArqO - e
    * chkImagens), e os dois aparecem aqui.
    *
    * PROTECTED EXPLICITO - nao eh estilo, eh o escopo REAL: FormBase declara
    * "PROTECTED PROCEDURE FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR
    * escopo herdado (regra #51). Por isso o metodo e' chamado so por THIS.,
    * de dentro da classe (regra #8) - nunca de fora, nem pelo harness.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.txt_4c_ArqTXT) = "O" AND ;
           VARTYPE(THIS.chk_4c_ChkImagens) = "O"
            THIS.this_oBusinessObject.this_cArquivo         = ALLTRIM(THIS.txt_4c_ArqTXT.Value)
            THIS.this_oBusinessObject.this_lExportarImagens = (THIS.chk_4c_ChkImagens.Value = 1)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FASE 8 - BOParaForm: BO -> Tela. Caminho inverso: marca em
    * chk_4c_ChkImagens o estado que this_lExportarImagens guarda no BO
    * (default .T. - ver a nota dessa property em sigopecmBO.prg). Chamado por
    * InicializarForm() logo depois de ConfigurarPageFrame(), quando o
    * controle ja existe.
    *
    * Existe por FONTE UNICA, nao por simetria decorativa: sem este hook o
    * "marcado" do checkbox ficaria escrito DUAS vezes - uma em
    * sigopecmBO.this_lExportarImagens e outra no .Value = 1 hardcoded de
    * ConfigurarCampos. As duas copias divergiriam no primeiro ajuste de
    * default - quem mudasse o default no BO veria o checkbox continuar
    * abrindo desmarcado, porque ConfigurarCampos nunca consultaria o BO.
    *
    * PROTECTED EXPLICITO pelo MESMO motivo de FormParaBO, acima.
    *==========================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.chk_4c_ChkImagens) = "O"
            THIS.chk_4c_ChkImagens.Value = IIF(THIS.this_oBusinessObject.this_lExportarImagens, 1, 0)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BtnProcessarClick - equivale a SIGOPECM.Processa.Click -> ThisForm.
    * Processamento. PUBLIC porque BINDEVENT exige metodo publico (regra #3).
    *
    * A confirmacao (MessageBox 32+4 <> 6) e o metodo em si viram
    * MsgConfirma(), que ja devolve LOGICO (regra #7 - NUNCA comparar com 6).
    * Todo o resto do Processamento legado (checagem de arquivo vazio/nao-
    * gravavel, Scan de grupos/produtos, geracao dos registros td01/td03)
    * mora em sigopecmBO.GerarArquivoExportacao(); este handler so prepara os
    * dois parametros de entrada e trata o resultado.
    *
    * Contrato de erro do BO (ver cabecalho de GerarArquivoExportacao):
    *   - falha de SQL -> BO ja exibiu o proprio MsgErro, this_cMensagemErro
    *     fica vazio, este handler NAO repete mensagem (regra #20);
    *   - falha de validacao (arquivo vazio/nao-gravavel/sem imagens
    *     selecionadas) -> this_cMensagemErro preenchido, SEM MsgErro previo;
    *     o handler exibe com MsgAviso (validacao de UI, nao erro tecnico) e
    *     devolve o foco a btnGetArqO, igual ao legado nos dois Return .f.
    *     ("O Arquivo a Ser Gerado..." e "O Arquivo Nao Pode Ser Criado...").
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro

        *-- Guarda de reentrancia (ver a nota de this_lProcessando): um
        *-- segundo acionamento durante uma geracao em curso eh IGNORADO.
        IF THIS.this_lProcessando
            RETURN
        ENDIF

        THIS.this_lProcessando = .T.

        *-- O TRY/CATCH aqui eh tambem o que evita o "Program Error" CRU do
        *-- VFP neste caminho: sem ele, erro fora do TRY do BO cai na
        *-- janelinha nativa Cancel/Suspend/Ignore, nao no dialogo do sistema.
        TRY
            THIS.BtnProcessarClickExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnProcessarClick")
        FINALLY
            THIS.this_lProcessando = .F.
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClickExec - corpo real do Processar. Separado do handler
    * para que a liberacao da flag de reentrancia fique no FINALLY do
    * wrapper e sobreviva aos RETURN antecipados daqui (regra #47).
    *==========================================================================
    PROCEDURE BtnProcessarClickExec()
        IF !MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o dos Arquivos?", ;
                "Gera" + CHR(231) + CHR(227) + "o de Arquivos")
            RETURN
        ENDIF

        IF !THIS.FormParaBO()
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os dados da tela.", "Erro")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.GerarArquivoExportacao()
            IF THIS.this_oBusinessObject.this_nQtdProdutos > 0
                MsgInfo(THIS.this_oBusinessObject.this_cMensagemResultado, ;
                    "Processamento Finalizado")
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemResultado, ;
                    "Processamento Finalizado")
            ENDIF
            THIS.cmd_4c_Cancela.SetFocus()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.cmd_4c_BtnGetArqO.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - equivale a SIGOPECM.Cancela.Click -> ThisForm.
    * Release. O dialogo nao devolve resultado nenhum ao form chamador (so
    * gera o arquivo em disco), entao Release() eh fiel ao legado - nao se
    * aplica a ressalva de dialogo-filho-que-o-chamador-le-depois (esse caso
    * usaria Hide()). PUBLIC pelo mesmo motivo de BtnProcessarClick.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnGetArqOClick - equivale a SIGOPECM.btnGetArqO.Click: abre o picker
    * nativo GETFILE() e, se o usuario nao cancelar, grava o caminho
    * escolhido em txt_4c_ArqTXT.Value (transcricao literal do
    * "GetFile([TXT], [Arquivo TXT:], [Criar], 0, [Informe o Nome do Arquivo
    * TXT])" do legado - nenhum dos literais tem acento).
    *==========================================================================
    PROCEDURE BtnGetArqOClick()
        LOCAL loc_cArquivo

        loc_cArquivo = GETFILE("TXT", "Arquivo TXT:", "Criar", 0, "Informe o Nome do Arquivo TXT")

        IF !EMPTY(loc_cArquivo)
            THIS.txt_4c_ArqTXT.Value = ALLTRIM(loc_cArquivo)
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarProgresso - contrato com sigopecmBO.AtualizarProgresso, que
    * chama este metodo a cada grupo/produto processado (equivale ao
    * "ThisForm.lblResults.Caption = [Processando ] + ..." repetido dentro do
    * Scan do legado). PUBLIC porque quem chama eh o BO, de fora da classe.
    *
    * O texto eh sempre guardado em this_cUltimoProgresso e so entao exibido,
    * se o label de resultado da area de campos existir - assim o progresso
    * reportado antes de o label entrar em cena nao se perde. O DOEVENTS
    * reproduz o repintar imediato que o legado obtinha ao atribuir o Caption
    * no meio do laco.
    *==========================================================================
    PROCEDURE AtualizarProgresso(par_cTexto)
        LOCAL loc_cTexto

        loc_cTexto = IIF(VARTYPE(par_cTexto) = "C", par_cTexto, "")
        THIS.this_cUltimoProgresso = loc_cTexto

        IF PEMSTATUS(THIS, "lbl_4c_LblResults", 5)
            THIS.lbl_4c_LblResults.Caption = loc_cTexto
            THIS.lbl_4c_LblResults.Refresh()
            DOEVENTS
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F.; este metodo percorre a arvore e os exibe. Nao ha filtro
    * de nome porque o SCX legado NAO declara Visible = .F. em controle
    * nenhum: nesta tela todos os 13 objetos nascem visiveis, logo filtrar
    * algum esconderia o que o legado mostra.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
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
    * Metodos de contrato com o pipeline (ConfigurarPaginaLista /
    * ConfigurarPaginaDados / AlternarPagina / CarregarLista /
    * AjustarBotoesPorModo). Este form OPERACIONAL nao tem PageFrame, nem
    * grade de listagem, nem os modos CRUD (LISTA/INCLUIR/ALTERAR/
    * VISUALIZAR): o legado eh um dialogo de um unico fluxo - informar o
    * arquivo e Processar. Os metodos existem porque o harness os alcanca de
    * fora da classe (por isso PUBLIC) e precisam ser inofensivos ao serem
    * chamados; dar-lhes corpo exigiria inventar paginas e botoes que o SCX
    * nao possui.
    *
    * EXCECAO - ConfigurarPaginaDados: num form FLAT como este, o que num CRUD
    * seria "a Page2 de Dados" eh o proprio corpo da Form, e os campos foram
    * criados de uma vez por ConfigurarCampos. O que sobra de verdade para este
    * metodo eh a ordem de tabulacao desses campos, que SO pode rodar depois de
    * todos os AddObject - por isso ele DELEGA a ConfigurarOrdemTabulacao em
    * vez de ficar um RETURN morto que nenhum gate percebe. Chamar de fora eh
    * seguro: a atribuicao ascendente de uma ordem que ja esta no lugar eh
    * no-op, logo o metodo eh idempotente.
    *==========================================================================
    PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    * Destroy - libera o Business Object e os cursores auxiliares que
    * sigopecmBO.GerarArquivoExportacao abre durante o processamento, cobrindo
    * o caso de a tela ser fechada no meio de uma geracao. DODEFAULT() por
    * ULTIMO, para FormBase.Destroy reconstruir os popups do menu principal.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_oFormUI = .NULL.
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.this_oFormPai = .NULL.

        IF USED("cursor_4c_GruposSelec")
            USE IN cursor_4c_GruposSelec
        ENDIF
        IF USED("cursor_4c_ControleGrupos")
            USE IN cursor_4c_ControleGrupos
        ENDIF
        IF USED("cursor_4c_DadosGrupo")
            USE IN cursor_4c_DadosGrupo
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopecmBO.prg):
*============================================================================
* sigopecmBO.prg - Business Object para Geracao de Arquivo de Exportacao
* Para e-Commerce (SIGOPECM / Formsigopecm)
*
* Form OPERACIONAL (processo em lote, sem tabela propria no banco): gera um
* arquivo de texto de largura fixa (layout "td01"/"td03") a partir dos
* produtos selecionados previamente pelo usuario (cursor crImagens, montado
* pelo form chamador - SIGOPECM.poObjForm) e grava ao lado dele, opcional-
* mente, os JPGs decodificados de SigCdPro.FigJpgs (base64).
*
* crImagens NAO eh criado neste form - quem monta eh SigOpPec.SCT
* (ProximasMigracoes\SigOpPec.SCT, ainda NAO migrado), com pelo menos:
*   Create Cursor CrImagens (Cpros C(14), Cgrus C(3), Cunis C(3), FigJpgs M, ...)
* As duas colunas usadas pelo SIGOPECM sao Cgrus C(3) e Cpros C(14) - usar
* essa estrutura ao criar o cursor placeholder nas proximas fases (nao
* inventar largura diferente).
*
* Fontes de leitura (sem persistencia - o processo so GERA ARQUIVO):
*   - SigCdGrp (CGrus/DGrus/Ids)              -> registro td01 (Grupo)
*   - SigCdPro (CPros/DPros/CUnis/DtIncs/...)  -> registro td03 (Produto)
*   - SigPrCar + SigCrRap (Descrs/Ordens)      -> colecoes/caracteristicas
*     do produto, que tambem geram registros td01 (uma "colecao" por Ordens)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completo em: Fase 2 em diante (metodos de processamento/exportacao)
*============================================================================

DEFINE CLASS sigopecmBO AS BusinessBase

    *==========================================================================
    * Parametros informados na tela (SIGOPECM.getArqTXT/chkImagens)
    *==========================================================================
    this_cArquivo          = ""   && SIGOPECM.getArqTXT.Value - caminho completo do TXT a ser gerado
    *-- SIGOPECM.chkImagens.Value = 1 - espelha o estado da caixa "Exportar
    *-- Imagens" na tela. ATENCAO: o legado NAO CONSULTA esse controle em
    *-- metodo nenhum (conferido no dump inteiro - chkImagens so aparece na
    *-- arvore de objetos e nas propriedades), logo a caixa NAO TEM EFEITO
    *-- no sistema antigo: ele exporta os JPGs sempre que SigCdPro.FigJpgs
    *-- esta preenchido. A property eh mantida porque eh a transcricao fiel
    *-- do controle e deixa a ativacao a um IF de distancia, mas
    *-- GerarArquivoExportacao NAO a usa, de proposito - ativar a caixa eh
    *-- mudar comportamento e exige decisao do cliente (PILAR 1).
    this_lExportarImagens  = .T.

    *==========================================================================
    * Resultado do processamento (SIGOPECM.lblResults / MessageBox final)
    *==========================================================================
    this_nQtdGrupos        = 0    && lnQtd do legado - total de grupos (registros td01) encontrados
    this_nQtdProdutos      = 0    && lnCnt do legado - total de produtos (registros td03) gravados
    this_cMensagemResultado = ""  && espelha o Caption de lblResults durante o Scan

    *==========================================================================
    * Linha corrente lida de cursor por CarregarDoCursor() - equivale as
    * referencias LocalGrupo.<col> / LocalProds.<col> / LocalCaracs.<col> do
    * legado. O tipo de cada property segue o tipo da COLUNA no docs/schema.sql
    * (conferido com Get-Content -Raw, encoding UTF-16 - regra #14), nunca o
    * nome do controle:
    *
    *   SigCdGrp : cgrus char(3)  | dgrus char(20) | ids numeric(10,0)
    *   SigCdPro : cpros char(14) | dpros char(65) | cunis char(3)
    *              dtincs datetime NULL | situas numeric(1,0)
    *              pesoms numeric(8,3) | icms numeric(5,2)
    *              aliqipis numeric(5,2) | clfiscals char(10)
    *              sittricms char(3) | pvens numeric(11,5) | figjpgs text NULL
    *   SigCrRap : descrs char(40) | ordens numeric(6,0)
    *==========================================================================
    this_cCgrus      = ""   && SigCdGrp.cgrus  / crImagens.Cgrus - codigo do grupo
    this_cDgrus      = ""   && SigCdGrp.dgrus  - descricao do grupo (registro td01)
    this_nIds        = 0    && SigCdGrp.ids    - ID do grupo no e-Commerce (registro td01)

    this_cCpros      = ""   && SigCdPro.cpros  / crImagens.Cpros - codigo do produto
    this_cDpros      = ""   && SigCdPro.dpros  - descricao do produto
    this_cCunis      = ""   && SigCdPro.cunis  - unidade
    this_dDtincs     = {}   && SigCdPro.dtincs - data de inclusao (datetime NULL)
    this_nSituas     = 0    && SigCdPro.situas - 2 = inativo ("i"), demais = ativo ("a")
    this_nPesoms     = 0    && SigCdPro.pesoms - peso medio
    this_nIcms       = 0    && SigCdPro.icms   - % de ICMS
    this_nAliqipis   = 0    && SigCdPro.aliqipis - % de IPI
    this_cClfiscals  = ""   && SigCdPro.clfiscals - classificacao fiscal
    this_cSittricms  = ""   && SigCdPro.sittricms - situacao tributaria
    this_nPvens      = 0    && SigCdPro.pvens  - preco de venda
    this_cFigjpgs    = ""   && SigCdPro.figjpgs - imagem em base64 (text NULL)

    this_cDescrs     = ""   && SigCrRap.descrs - descricao da colecao (registro td01)
    this_nOrdens     = 0    && SigCrRap.ordens - ID da colecao (registro td01)

    *==========================================================================
    * Referencia ao form para repintar lblResults.Caption durante o
    * processamento (equivalente ao "ThisForm.lblResults.Caption = ... "
    * repetido dentro do Scan do legado). Fica .NULL. quando o BO eh usado
    * sem interface.
    *==========================================================================
    this_oFormUI = .NULL.

    *==========================================================================
    * Init - Inicializa o Business Object. Sem tabela propria (o processo
    * apenas le SigCdGrp/SigCdPro/SigPrCar/SigCrRap e grava arquivo em disco),
    * entao this_cTabela/this_cCampoChave ficam vazios - igual ao padrao
    * adotado em FAPPBO.prg para forms operacionais sem persistencia.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em sigopecmBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Sem tabela/registro proprio (processo so GERA
    * ARQUIVO), entao nao ha chave primaria para auditar. Explicito aqui (em
    * vez de confiar so no default de BusinessBase) para deixar claro que a
    * ausencia eh decisao, nao esquecimento - mesmo padrao de FAPPBO.prg.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * LimparDados - Zera a linha corrente (as properties alimentadas por
    * CarregarDoCursor). Chamado no inicio de GerarArquivoExportacao e a cada
    * troca de grupo/produto: sem isso, coluna ausente no cursor da vez
    * deixaria o valor do registro ANTERIOR na property e o registro td01/td03
    * sairia com dado de outro produto - divergencia silenciosa, sem erro.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCgrus     = ""
        THIS.this_cDgrus     = ""
        THIS.this_nIds       = 0

        THIS.this_cCpros     = ""
        THIS.this_cDpros     = ""
        THIS.this_cCunis     = ""
        THIS.this_dDtincs    = {}
        THIS.this_nSituas    = 0
        THIS.this_nPesoms    = 0
        THIS.this_nIcms      = 0
        THIS.this_nAliqipis  = 0
        THIS.this_cClfiscals = ""
        THIS.this_cSittricms = ""
        THIS.this_nPvens     = 0
        THIS.this_cFigjpgs   = ""

        THIS.this_cDescrs    = ""
        THIS.this_nOrdens    = 0
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Le a linha CORRENTE de um cursor para as properties
    * deste BO. Equivale as referencias LocalGrupo.<col> / LocalProds.<col> /
    * LocalCaracs.<col> espalhadas pelo Processamento do legado: aqui a leitura
    * acontece em UM lugar so, e o resto do codigo trabalha sobre as
    * properties.
    *
    * Atende os TRES cursores do processo (cada um traz um subconjunto de
    * colunas) e tambem o crImagens montado pelo form chamador:
    *   cursor_4c_DadosGrupo     -> Cgrus, Dgrus, Ids
    *   cursor_4c_DadosProduto   -> Cpros, Dpros, Cunis, Dtincs, Situas,
    *                               Pesoms, Icms, Aliqipis, Clfiscals,
    *                               Sittricms, Pvens, Figjpgs
    *   cursor_4c_Caracteristicas-> Descrs, Ordens
    *   crImagens                -> Cgrus, Cpros
    *
    * Cada coluna eh lida so quando EXISTE no cursor: o teste eh
    * TYPE(alias + ".coluna") != "U", NUNCA PEMSTATUS() - PEMSTATUS exige
    * OBJETO no 1o argumento e com nome de alias dispara o erro 11 do VFP9.
    *
    * O alias corrente eh restaurado no fim: o metodo eh chamado de DENTRO de
    * SCANs (crImagens/grupos/produtos) e nao pode deslocar a area de trabalho
    * de quem chamou.
    *
    * Parametro: par_cAliasCursor - nome do cursor/alias ja aberto e posicionado
    * Retorno: .T. se leu uma linha; .F. se o alias nao existe, nao esta aberto
    *          ou esta em EOF (cursor vazio ou ponteiro no fim).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro, loc_cAlias, loc_cAliasAnterior

        loc_lResultado     = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias         = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- SigCdGrp (grupo) / crImagens
                    IF TYPE(loc_cAlias + ".Cgrus") != "U"
                        THIS.this_cCgrus = ALLTRIM(TratarNulo(Cgrus, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dgrus") != "U"
                        THIS.this_cDgrus = ALLTRIM(TratarNulo(Dgrus, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Ids") != "U"
                        THIS.this_nIds = TratarNulo(Ids, 0)
                    ENDIF

                    *-- SigCdPro (produto) / crImagens
                    IF TYPE(loc_cAlias + ".Cpros") != "U"
                        THIS.this_cCpros = ALLTRIM(TratarNulo(Cpros, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dpros") != "U"
                        THIS.this_cDpros = ALLTRIM(TratarNulo(Dpros, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Cunis") != "U"
                        THIS.this_cCunis = ALLTRIM(TratarNulo(Cunis, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dtincs") != "U"
                        *-- datetime NULL: ConverterParaData normaliza DATE/DATETIME/NULL.
                        *-- TTOD() direto dispara erro 11 quando o valor chega como DATE.
                        THIS.this_dDtincs = ConverterParaData(Dtincs)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Situas") != "U"
                        THIS.this_nSituas = TratarNulo(Situas, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Pesoms") != "U"
                        THIS.this_nPesoms = TratarNulo(Pesoms, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Icms") != "U"
                        THIS.this_nIcms = TratarNulo(Icms, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Aliqipis") != "U"
                        THIS.this_nAliqipis = TratarNulo(Aliqipis, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Clfiscals") != "U"
                        THIS.this_cClfiscals = ALLTRIM(TratarNulo(Clfiscals, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Sittricms") != "U"
                        THIS.this_cSittricms = ALLTRIM(TratarNulo(Sittricms, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Pvens") != "U"
                        THIS.this_nPvens = TratarNulo(Pvens, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Figjpgs") != "U"
                        *-- text NULL - base64 da imagem, lido CRU (sem ALLTRIM)
                        THIS.this_cFigjpgs = TratarNulo(Figjpgs, "")
                    ENDIF

                    *-- SigCrRap (colecoes/caracteristicas do produto)
                    IF TYPE(loc_cAlias + ".Descrs") != "U"
                        THIS.this_cDescrs = ALLTRIM(TratarNulo(Descrs, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Ordens") != "U"
                        THIS.this_nOrdens = TratarNulo(Ordens, 0)
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler o cursor [" + loc_cAlias + "]: " + ;
                loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.

        FINALLY
            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao - este form NUNCA grava em tabela
    * (le SigCdGrp/SigCdPro/SigPrCar/SigCrRap e grava um arquivo em disco);
    * o comportamento padrao herdado de BusinessBase (recusar a operacao) ja
    * eh o correto aqui, entao NAO sao sobrescritos so para preencher metodo.
    * A operacao real do form eh GerarArquivoExportacao(), abaixo.
    *==========================================================================

    *==========================================================================
    * AtualizarProgresso - Repinta o andamento do processamento. Equivale ao
    * "ThisForm.lblResults.Caption = ..." repetido dentro do Scan do legado.
    * Nao sabe o nome do controle: delega para um metodo PUBLIC do form
    * (THIS.this_oFormUI.AtualizarProgresso(cTexto)), que o Form (Fase 3)
    * implementa para repintar o label dele e fazer Refresh().
    *==========================================================================
    PROTECTED PROCEDURE AtualizarProgresso(par_nQtdGrupos, par_nQtdProdutos)
        LOCAL loc_cTexto

        loc_cTexto = "Processando " + ALLTRIM(STR(par_nQtdGrupos, 10)) + " Grupo" + ;
            IIF(par_nQtdGrupos = 1, "", "s") + " / " + ;
            "Produtos Gerados : " + ALLTRIM(STR(par_nQtdProdutos, 10))

        THIS.this_cMensagemResultado = loc_cTexto

        IF VARTYPE(THIS.this_oFormUI) = "O" AND PEMSTATUS(THIS.this_oFormUI, "AtualizarProgresso", 5)
            THIS.this_oFormUI.AtualizarProgresso(loc_cTexto)
        ENDIF
    ENDPROC

    *==========================================================================
    * GerarArquivoExportacao - Equivalente a SIGOPECM.Processamento do legado.
    *
    * Le o cursor crImagens (montado pelo form chamador - ver cabecalho do
    * arquivo) e, para cada Cgrus/Cpros distinto nele, consulta SigCdGrp/
    * SigCdPro/SigPrCar+SigCrRap e grava registros de largura fixa ("td01"
    * para grupos/colecoes, "td03" para produtos) no arquivo THIS.this_cArquivo,
    * alem dos JPGs decodificados de SigCdPro.FigJpgs sempre que a coluna
    * estiver preenchida (o legado nao condiciona isso a nada mais - ver a
    * nota no bloco de exportacao de imagens, adiante).
    *
    * Pre-requisitos (devem ser setados pelo Form ANTES de chamar):
    *   THIS.this_cArquivo         - caminho completo do TXT a ser gerado
    *   THIS.this_oFormUI          - opcional, para repintar o progresso
    * (this_lExportarImagens NAO entra aqui: este metodo nao a le, porque o
    * legado tambem nao - ver a nota na declaracao da property.)
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo que
    * nenhum produto tenha sido gerado - igual ao legado, que so muda a
    * mensagem final, nunca o retorno); .F. em falha de validacao ou de SQL.
    *
    * Contrato de erro (mesmo do Inserir()/Atualizar() de BusinessBase):
    *   - falha de SQL exibe o proprio MsgErro aqui e deixa
    *     this_cMensagemErro VAZIO (ja mostrado, Form nao repete);
    *   - falha de validacao (arquivo vazio/nao-gravavel/sem imagens
    *     selecionadas) NAO mostra MsgErro - so preenche this_cMensagemErro,
    *     para o Form decidir a mensagem e o SetFocus.
    *==========================================================================
    PROCEDURE GerarArquivoExportacao()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cChr, loc_cSQL, loc_nResultado
        LOCAL loc_nQtdGrupos, loc_nQtdProdutos
        LOCAL loc_cGru, loc_cDes, loc_cUni, loc_cStr
        LOCAL loc_cRef, loc_cDat, loc_cSit, loc_cPes, loc_cIpi, loc_cIcm, loc_cClf, loc_cTri, loc_cVal, loc_cPre
        LOCAL loc_cGvd, loc_cGr1, loc_cDe1, loc_cUn1
        LOCAL loc_cImg, loc_cFoto

        loc_lResultado = .F.

        *-- Zera a linha corrente (LimparDados tambem limpa this_cMensagemErro
        *-- via DODEFAULT) para o processamento nunca herdar o produto/grupo de
        *-- uma geracao anterior - o form fica aberto entre um Processar e outro
        THIS.LimparDados()

        THIS.this_nQtdGrupos         = 0
        THIS.this_nQtdProdutos       = 0
        THIS.this_cMensagemResultado = ""

        loc_cArquivo = ALLTRIM(NVL(THIS.this_cArquivo, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "O Arquivo a Ser Gerado N" + CHR(227) + "o Foi Informado!!!"
            ELSE
                *-- Testa se o arquivo pode ser criado (igual ao legado)
                STRTOFILE("", loc_cArquivo, 0)

                IF !FILE(loc_cArquivo)
                    THIS.this_cMensagemErro = "O Arquivo N" + CHR(227) + "o Pode Ser Criado!!!"
                ELSE
                    IF !USED("crImagens")
                        THIS.this_cMensagemErro = "Nenhuma imagem selecionada para exportar."
                    ELSE
                        loc_cChr = CHR(13) + CHR(10)

                        IF USED("cursor_4c_GruposSelec")
                            USE IN cursor_4c_GruposSelec
                        ENDIF
                        SELECT DISTINCT Cgrus FROM crImagens ;
                            INTO CURSOR cursor_4c_GruposSelec ;
                            ORDER BY Cgrus

                        IF USED("cursor_4c_ControleGrupos")
                            USE IN cursor_4c_ControleGrupos
                        ENDIF
                        CREATE CURSOR cursor_4c_ControleGrupos (Grupo N(8))
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

                            *-- CarregarDoCursor devolve .F. em EOF, o que equivale ao
                            *-- "If Not Eof([LocalGrupo])" do legado
                            IF THIS.CarregarDoCursor("cursor_4c_DadosGrupo")
                                loc_cGru = PADL(THIS.this_nIds, 8, "0")
                                loc_cDes = PADR(THIS.this_cDgrus, 40)
                                loc_cUni = PADR("", 4)

                                *-- td01 - Tabela de Grupos
                                loc_cStr = "td01" + ;           && Tipo - "td01" - Constante - Caracter(4)
                                    loc_cGru + ;                && ID - Numerico(8)
                                    loc_cDes + ;                && Descricao - Caracter(40)
                                    loc_cUni + loc_cChr         && Unidade - Caracter(4)

                                STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                IF !SEEK(THIS.this_nIds, "cursor_4c_ControleGrupos", "Grupo")
                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (THIS.this_nIds)
                                ENDIF

                                *-- Produtos distintos do grupo (crPros do legado)
                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                                SELECT DISTINCT Cpros FROM crImagens ;
                                    WHERE Cgrus = cursor_4c_GruposSelec.Cgrus ;
                                    INTO CURSOR cursor_4c_ProdutosGrupo ;
                                    ORDER BY Cpros

                                SELECT cursor_4c_ProdutosGrupo
                                SCAN
                                    loc_cSQL = "SELECT Cpros, Dpros, Cunis, Dtincs, Situas, Pesoms, Icms," + ;
                                        " Aliqipis, Clfiscals, Sittricms, Pvens, Figjpgs" + ;
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

                                    IF THIS.CarregarDoCursor("cursor_4c_DadosProduto")
                                        loc_cRef = PADR(CHRTRAN(THIS.this_cCpros, [ */\:?"'<>|], []), 25)
                                        loc_cDes = PADR(THIS.this_cDpros, 60)
                                        loc_cUni = PADR(THIS.this_cCunis, 3)
                                        loc_cDat = DTOC(THIS.this_dDtincs)
                                        loc_cSit = IIF(THIS.this_nSituas = 2, "i", "a")
                                        *-- Pesoms/Pvens: PADL de COLUNA converte o numero com as
                                        *-- decimais DECLARADAS (pesoms numeric(8,3), pvens
                                        *-- numeric(11,5)); de VARIAVEL converteria com SET DECIMALS
                                        *-- (2 por default) e o campo de largura fixa sairia com
                                        *-- outro conteudo. O STR explicito reproduz a coluna.
                                        loc_cPes = STRTRAN(PADL(ALLTRIM(STR(THIS.this_nPesoms, 12, 3)), 8, "0"), ".", ",")
                                        loc_cIpi = PADL(INT(THIS.this_nAliqipis), 2, "0")
                                        loc_cIcm = PADL(INT(THIS.this_nIcms), 2, "0")
                                        loc_cClf = PADR(CHRTRAN(THIS.this_cClfiscals, [ .], []), 8)
                                        loc_cTri = PADR(THIS.this_cSittricms, 3)
                                        loc_cVal = STRTRAN(PADL(ALLTRIM(STR(THIS.this_nPvens, 18, 5)), 8, "0"), ".", ",")
                                        loc_cPre = PADR("00000000" + loc_cVal + "0000^", 400)

                                        loc_cGvd = ""

                                        *-- Colecoes/caracteristicas do produto (SigPrCar + SigCrRap)
                                        loc_cSQL = "SELECT b.Descrs, b.Ordens" + ;
                                            " FROM SigPrCar a, SigCrRap b" + ;
                                            " WHERE a.Cpros = " + EscaparSQL(THIS.this_cCpros) + ;
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
                                            *-- Le a linha corrente (Descrs/Ordens) para as
                                            *-- properties; Cpros/Figjpgs do produto NAO sao
                                            *-- tocados (este cursor nao tem essas colunas)
                                            THIS.CarregarDoCursor("cursor_4c_Caracteristicas")

                                            IF !EMPTY(THIS.this_nOrdens)
                                                IF !SEEK(THIS.this_nOrdens, "cursor_4c_ControleGrupos", "Grupo")
                                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (THIS.this_nOrdens)

                                                    loc_cGr1 = PADL(THIS.this_nOrdens, 8, "0")
                                                    loc_cDe1 = PADR(THIS.this_cDescrs, 40)
                                                    loc_cUn1 = PADR("", 4)

                                                    *-- td01 - Tabela de Grupos (colecao)
                                                    loc_cStr = "td01" + loc_cGr1 + loc_cDe1 + loc_cUn1 + loc_cChr

                                                    STRTOFILE(loc_cStr, loc_cArquivo, .T.)
                                                ENDIF
                                                loc_cGvd = loc_cGvd + ALLTRIM(STR(THIS.this_nOrdens, 8)) + "^"
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

                                        *-- Exportando as imagens
                                        *-- this_cFigjpgs ja vem sem NULL (TratarNulo em
                                        *-- CarregarDoCursor), por isso o ISNULL do legado
                                        *-- fica coberto pelo EMPTY.
                                        *--
                                        *-- A condicao eh SO esta: o legado NAO consulta
                                        *-- chkImagens em lugar nenhum - no dump do SCX esse
                                        *-- controle aparece apenas na arvore de objetos e no
                                        *-- bloco de propriedades, e o Processamento guarda a
                                        *-- exportacao so com "If Not Empty(LocalProds.FigJpgs)
                                        *-- And Not IsNull(LocalProds.FigJpgs)". Acrescentar
                                        *-- AND this_lExportarImagens aqui seria INVENTAR uma
                                        *-- restricao que o legado nao tem (PILAR 1 / regra
                                        *-- #49): quem desmarcasse "Exportar Imagens" deixaria
                                        *-- de receber os JPGs que o sistema antigo gera.
                                        *-- Ver a nota de this_lExportarImagens: ligar a
                                        *-- caixa eh mudanca de comportamento e precisa de
                                        *-- decisao do cliente, nao de decisao do migrador.
                                        IF !EMPTY(THIS.this_cFigjpgs)
                                            loc_cImg = ALLTRIM(JUSTPATH(loc_cArquivo)) + "\" + ALLTRIM(loc_cRef) + ".Jpg"
                                            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(THIS.this_cFigjpgs, ;
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
                                THIS.this_cMensagemResultado = "Arquivo de Produtos Gerado Com Sucesso!!!"
                            ELSE
                                THIS.this_cMensagemResultado = "Aten" + CHR(231) + CHR(227) + "o!!! Arquivo Gerado Sem Produtos!!!"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo de exporta" + CHR(231) + CHR(227) + "o: " + ;
                loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
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

