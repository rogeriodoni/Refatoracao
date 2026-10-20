# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 3/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-10-19 16:59:34] [INFO] === VFP EXECUTOR v2.0 ===
[2026-10-19 16:59:34] [INFO] Config FPW: (nao fornecido)
[2026-10-19 16:59:34] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 16:59:34] [INFO] Timeout: 300 segundos
[2026-10-19 16:59:34] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_15zqaemc.prg
[2026-10-19 16:59:34] [INFO] Conteudo do wrapper:
[2026-10-19 16:59:34] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrSnd', 'C:\4c\tasks\task678\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrSnd', 'C:\4c\tasks\task678\logs\06_testForm.log'
QUIT

[2026-10-19 16:59:34] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_15zqaemc.prg
[2026-10-19 16:59:34] [INFO] VFP output esperado em: C:\4c\tasks\task678\vfp_output.txt
[2026-10-19 16:59:34] [INFO] Executando Visual FoxPro 9...
[2026-10-19 16:59:34] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_15zqaemc.prg
[2026-10-19 16:59:34] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_15zqaemc.prg
[2026-10-19 16:59:34] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrSnd
Inicio: 19/10/2026 16:59:35

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 19/10/2026 17:02:53
Duracao: 198 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-10-19 17:02:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-10-19 17:02:53] [INFO] VFP9 finalizado em 198.8000415 segundos
[2026-10-19 17:02:53] [INFO] Exit Code: 
[2026-10-19 17:02:53] [INFO] 
[2026-10-19 17:02:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-10-19 17:02:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_15zqaemc.prg
[2026-10-19 17:02:53] [INFO] 
[2026-10-19 17:02:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-10-19 17:02:53] [INFO] * Auto-generated wrapper for parameters
[2026-10-19 17:02:53] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-10-19 17:02:53] [INFO] * Parameters: 'FormSigPrSnd', 'C:\4c\tasks\task678\logs\06_testForm.log'
[2026-10-19 17:02:53] [INFO] 
[2026-10-19 17:02:53] [INFO] * Anti-dialog protections for unattended execution
[2026-10-19 17:02:53] [INFO] SET SAFETY OFF
[2026-10-19 17:02:53] [INFO] SET RESOURCE OFF
[2026-10-19 17:02:53] [INFO] SET TALK OFF
[2026-10-19 17:02:53] [INFO] SET NOTIFY OFF
[2026-10-19 17:02:53] [INFO] SYS(2335, 0)
[2026-10-19 17:02:53] [INFO] 
[2026-10-19 17:02:53] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrSnd', 'C:\4c\tasks\task678\logs\06_testForm.log'
[2026-10-19 17:02:53] [INFO] QUIT
[2026-10-19 17:02:53] [INFO] 
[2026-10-19 17:02:53] [INFO] === Fim do Wrapper.prg ===
[2026-10-19 17:02:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.prg):
*==============================================================================
* FORMSIGPRSND.PRG
* Form OPERACIONAL - Senhas Livres (legado SIGPRSND.SCX)
* Herda de: FormBase
*
* O legado SIGPRSND.scx e um dialogo pequeno (Width=500, Height=324, sem
* barra de titulo, DataSession=2) SEM PageFrame/Pagina Lista/Dados: apenas
* uma faixa de titulo (cntSombra), um campo "Qtde de Senhas" (getqtdsen),
* um grid de senhas geradas (grdSenha) e quatro botoes (btnSenPend/
* btnExcel/btnGerSen/Saida) - ver tasks\task678\analise.json (formType=
* "OPERACIONAL") e layout.json (sem objeto PageFrame na arvore).
*
* Por isso este form NAO segue o padrao Page1=Lista/Page2=Dados do CRUD: o
* nome "ConfigurarPageFrame" do roteiro generico de migracao NAO se aplica
* aqui (nao ha PageFrame real). O layout e montado direto nos filhos do
* Form, igual ao padrao ja usado em Formsigprsen.prg (mesmo legado-irmao
* SIGPRSEN: dialogo pequeno com cntSombra + botoes, sem PageFrame).
*
* Mapeamento de objetos (tasks\task678\mapeamento.json):
*   cntSombra           -> cnt_4c_Sombra
*   cntSombra.lblSombra -> lbl_4c_LblSombra
*   cntSombra.lblTitulo -> lbl_4c_LblTitulo
*   Label3              -> lbl_4c_Label3        (Fase 5)
*   getqtdsen           -> txt_4c_Qtdsen        (Fase 5)
*   grdSenha            -> grd_4c_Dados         (Fase 4)
*   btnSenPend          -> cmd_4c_BtnSenPend    (Fase 4)
*   btnExcel            -> cmd_4c_BtnExcel      (Fase 4)
*   btnGerSen           -> cmd_4c_BtnGerSen     (Fase 4)
*   Saida               -> cmd_4c_Saida         (Fase 4)
*
* FASE 3/8: estrutura base - DEFINE CLASS, Init(), guarda de conexao
* (ValidarParametros, fiel ao poDataMgr.pnIdconn > 0 do Init legado),
* instanciacao do Business Object e o UNICO container que existe no
* legado (cnt_4c_Sombra/faixa de titulo).
*
* FASE 4/8 (esta fase): Grid (grd_4c_Dados) e os quatro CommandButton
* standalone do legado (cmd_4c_BtnSenPend/BtnExcel/BtnGerSen/Saida) -
* todos filhos DIRETOS do form (sem PageFrame/Container de botoes, fieis
* ao dump: SIGPRSND.btnSenPend/btnExcel/btnGerSen/Saida tem Parent=
* SIGPRSND). Posicoes/Picture EXATAS de SigPrSnd_form_codigo_fonte.txt.
* Os tres botoes de Top=4 (btnExcel/btnGerSen/Saida) ficam DENTRO da
* faixa do cabecalho (cnt_4c_Sombra: Top=0, Height=80) - por isso
* ConfigurarGrid()/ConfigurarBotoes() sao chamados DEPOIS de
* ConfigurarCabecalho() (regra #11/#31: quem desenha depois fica por
* cima).
*
* Entram tambem nesta fase o cursor de trabalho da grade e os metodos de
* carga, que no legado moram no Init e no Click de btnSenPend:
*   CriarCursorDados() -> SigPrSndBO.CriarCursorSenhas()
*        cursor_4c_Senhas (= crSigPrSnd), VAZIO e READWRITE, estrutura de
*        SigPrSnd. Fiel ao AddCursor do Init legado, que usa a chave
*        SENTINELA Replicate(Chr(254),20) para nao casar com registro
*        nenhum - a grade abre VAZIA de proposito (regra #35a).
*   VincularGrade()    -> RecordSource/ControlSource + reaplicacao de
*        Width/Header1.Caption (regra #41 / Problema 48).
*   CarregarDados()    -> SigPrSndBO.CarregarSenhasPendentes()
*        "Select * From SigPrSnd Where EmpDopNums = ''" do Click de
*        btnSenPend; SQL no BO em cursor temporario + ZAP (guardado por
*        SET SAFETY OFF, porque DataSession=2 reseta SAFETY para ON) +
*        APPEND FROM DBF() no alias da grade, preservando o bind.
*
* FASE 5/8 (esta fase): o unico campo de dados do legado - Label3 (label
* fixo) + getqtdsen (quantidade de senhas a gerar) - filhos DIRETOS do
* form, abaixo da faixa do cabecalho (cnt_4c_Sombra termina em Top=80;
* Label3/getqtdsen ficam em Top=84..102, sem sobreposicao). Como o legado
* tem um UNICO campo de dados, a "primeira metade" dos campos cobre tudo
* que falta - nao ha segunda metade nesta tela.
*
* getqtdsen.AutoSize nao se aplica (eh TextBox), mas Label3 do dump
* declara AutoSize=.T. + Width=86 - AddObject ignora AutoSize (regra #23,
* NO-OP em controle criado assim), por isso aqui sai .AutoSize = .F. com
* o Width/Height JA calculados pelo Form Designer, transcritos do dump.
*
* O BINDEVENT dos quatro Click entra nas Fases 7/8 (btnSenPend chamara
* CarregarDados(); btnGerSen/btnExcel/Saida terao seus proprios handlers,
* lendo THIS.txt_4c_Qtdsen.Value direto, igual ao legado thisform.
* getqtdsen.Value).
*
* FASE 6/8 (esta fase): "campos restantes e lookups". MEDIDO no dump
* SigPrSnd_form_codigo_fonte.txt, o legado NAO TEM:
*
*   (a) LOOKUP ALGUM. Varredura dos cinco padroes de picker do legado
*       Fortyus - fwbusca* (Ext/Sel/Int), mAddColuna, sigacess(),
*       Acesso<X>() e FormBuscaAuxiliar - devolve ZERO ocorrencia. O
*       unico CreateObject do dump eh o gerenciador de conexao
*       (CreateObject('fSqlConector', ThisForm.Name) no Init), que NAO
*       eh picker. O dump tambem nao tem PROCEDURE Valid, KeyPress nem
*       DblClick em controle nenhum. Criar aqui um AbrirLookup*/
*       AbrirBusca* seria INVENTAR tabela de lookup que o legado nunca
*       consultou - viola o PILAR 1 e a regra explicita "NUNCA inventar
*       tabelas de lookup". Por isso NAO ha metodo de lookup neste form,
*       e isso eh o estado CORRETO - nao eh fase incompleta.
*
*   (b) CAMPO RESTANTE. O legado tem UM unico campo de dados
*       (Label3 + getqtdsen), ja entregue na Fase 5 - nao ha "segunda
*       metade" de campos nesta tela.
*
*   (c) cnt_4c_BotoesAcao (Confirmar/Cancelar). Este eh um dialogo
*       OPERACIONAL, nao um CRUD: os quatro botoes do legado
*       (btnSenPend/btnExcel/btnGerSen/Saida) sao standalone e ja foram
*       criados na Fase 4. O legado nao tem Salvar nem Cancelar.
*
* O que esta fase ENTREGA, entao, eh a superficie de evento e validacao
* do unico campo que existe:
*
*   ConfigurarEventos()    - BINDEVENT do txt_4c_Qtdsen (PUBLIC, regra #3).
*   TxtQtdsenLostFocus()   - normaliza .Value para NUMERICO ao sair do
*        campo. No legado o getqtdsen tem .Value = 0 e Format = "K", e o
*        tipo era garantido pelo proprio controle; no migrado o TextBox
*        nasce por AddObject SEM ControlSource, entao o tipo de .Value
*        nao eh garantido por coluna nenhuma (mesma familia da regra #16:
*        "o form funciona em ALTERAR e explode em INCLUIR porque o legado
*        tinha ControlSource e o migrado nao"). Normalizacao SILENCIOSA -
*        nao exibe dialogo, porque o legado nao valida ao SAIR do campo
*        (ver ValidarQtdeSenhas abaixo); por o aviso aqui inventaria um
*        modal que o legado nao tem (PILAR 1) e eh exatamente o defeito
*        da regra #47/#50.
*   ObterQtdeSenhas()      - leitura normalizada do campo, equivalente ao
*        'lnQtd = thisform.getqtdsen.Value' do legado.
*   ValidarQtdeSenhas()    - TRANSCRICAO do guard de campo obrigatorio que
*        no legado mora no TOPO do Click de btnGerSen:
*            If Empty(thisform.getQtdSen.Value)
*                =Messagebox('Qtde de senhas obrigatorio.',48,[Aviso])
*                ThisForm.getQtdSen.Setfocus()
*                Return .f.
*            EndIf
*        A validacao do legado mora em DOIS lugares (o metodo de
*        validacao E o Click do botao) - ela eh validacao DO CAMPO, logo
*        pertence a esta fase; quem a CHAMA eh o BtnGerSenClick da Fase 7,
*        no mesmo ponto em que o legado a executa. Nao ligada a LostFocus
*        de proposito, pelo motivo acima.
*
* FASE 7/8 (esta fase): "eventos principais dos botoes". Os quatro nomes do
* roteiro generico - BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
* BtnExcluirClick - sao convencao de form CRUD (a barra Incluir/Alterar/
* Visualizar/Excluir da Page1 de Lista do frmcadastro). MEDIDO no dump, este
* legado NAO TEM barra CRUD nenhuma: herda de `form` puro (nao de
* frmcadastro), nao tem Grupo_Op, nao tem a variavel de modo pcEscolha e
* nenhum dos seus quatro botoes tem nome de verbo CRUD. Criar esses quatro
* metodos aqui significaria INVENTAR botoes que o legado nao tem (viola o
* PILAR 1 e a regra "NUNCA inventar") ou deixar metodo vazio (proibido pela
* regra de completude). O que esta fase entrega sao os Click dos botoes de
* ACAO que o legado REALMENTE tem:
*
*   BtnGerSenClick()        - btnGerSen ("Gerar Senha"), a acao PRINCIPAL da
*        tela: guard de campo obrigatorio -> confirmacao -> geracao/gravacao
*        atomica no BO -> re-bind da grade -> aviso para anotar as senhas ->
*        zera a quantidade. Transcricao passo a passo do Click legado.
*   BtnSenPendClick()       - btnSenPend, dispara CarregarDados() (o
*        "Select * From SigPrSnd Where EmpDopNums = ''" do Click legado).
*   RecarregarGradeDoTemp() - funil unico do ZAP + APPEND FROM DBF() +
*        re-bind da grade, que o legado repete identico nos DOIS Clicks.
*
* Os dois BINDEVENT de Click entram em ConfigurarEventos (sempre guardados
* por PEMSTATUS do controle: BINDEVENT com objeto inexistente estoura no
* proprio BIND e derruba o Init). O Click de btnExcel (planilha) e o de Saida
* (ThisForm.Release) sao os eventos AUXILIARES e ficam para a Fase 8 - nao se
* liga aqui um Click cujo handler ainda nao existe.
*
* No BO, esta fase apoia-se em tres metodos novos (SigPrSndBO.prg):
* ContarSenhasIguais (o ChkRegister do fSqlConector legado), GerarSenhaUnica
* (o laco fKeyGen + ChkRegister) e GerarSenhasLivres (o Zap + For/Insert +
* Update + Commit/RollBack, num SQLEXEC unico com SAVE TRANSACTION para a
* gravacao ser de fato tudo-ou-nada como no legado).
*
* FASE 8/8 (esta fase): "eventos auxiliares e consolidacao final". Conferido
* metodo a metodo contra comportamento.json (totalMetodos=8): dos 8 metodos
* do legado, 6 ja estavam portados (Init/Load/Release na Fase 3, Click de
* btnSenPend/btnGerSen na Fase 7, When de grdSenha.Column1.Text1 nas Fases
* 4/6 via Column1.ReadOnly/Text1.ReadOnly). Faltavam os DOIS que a propria
* Fase 7 ja apontava como "auxiliares" - o Click de btnExcel e o de Saida:
*
*   BtnExcelClick() - TRANSCRICAO do Click de btnExcel ("Excel"): exporta a
*        coluna Senhads do cursor da grade (cursor_4c_Senhas) para planilha
*        XLS ou TXT delimitado, via PUTFILE() + fVerificaPasta() (wrapper ja
*        existente em utils\, criado exatamente para este padrao do VCX
*        DocumentoExcel do framework legado) + COPY TO. O "On Error llErr =
*        .t." do legado (trap global, que nao existe na arquitetura nova)
*        virou TRY/CATCH; MESSAGEBOX (proibido) virou MsgAviso - os DOIS
*        avisos do legado usam icone 48 (exclamacao/aviso), nenhum dos dois
*        eh erro tecnico.
*   BtnSaidaClick() - TRANSCRICAO do Click de Saida (ThisForm.Release).
*        Nome do handler pelo NOME DO OBJETO do legado (Saida -> cmd_4c_
*        Saida, por mapeamento.json), igual ao padrao ja adotado no legado-
*        irmao Formsigprsen.prg (BtnSaidaClick) - NAO "BtnEncerrarClick" do
*        roteiro generico de CRUD, que este form OPERACIONAL nao segue.
*
* Os dois BINDEVENT entram em ConfigurarEventos, junto dos dois ja ligados
* na Fase 7 - mesma guarda por PEMSTATUS do CONTROLE (BINDEVENT com objeto
* inexistente estoura no proprio BIND).
*
* O roteiro generico desta fase (BtnBuscarClick/BtnEncerrarClick/
* BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
* LimparCampos/CarregarLista/AjustarBotoesPorModo) presume um form CRUD com
* Page1=Lista/Page2=Dados - NAO SE APLICA a este legado (confirmado contra o
* dump, analise.json e layout.json, mesma conclusao do legado-irmao
* Formsigprsen.prg):
*
*   - BtnBuscarClick / CarregarLista: a "busca" real do legado eh o Click
*     de btnSenPend (Select ... Where EmpDopNums = ''), ja portado como
*     BtnSenPendClick/CarregarDados na Fase 7 - criar outro handler
*     duplicaria a mesma acao.
*   - BtnSalvarClick / FormParaBO / BOParaForm / HabilitarCampos /
*     LimparCampos: o UNICO campo de dados (txt_4c_Qtdsen) nao eh uma
*     property do BO persistida por mapeamento Form<->BO - ele eh um
*     PARAMETRO lido uma vez (ObterQtdeSenhas()) e passado direto a
*     GerarSenhasLivres(loc_nQtd), exatamente como 'lnQtd =
*     thisform.getqtdsen.Value' no legado. Nao ha "registro" para
*     Incluir/Alterar/Visualizar - cada clique em "Gerar Senha" eh uma
*     operacao completa e imediata.
*   - BtnEncerrarClick / BtnCancelarClick: o UNICO botao de saida do
*     legado eh Saida.Click (ThisForm.Release), portado nesta fase como
*     BtnSaidaClick.
*   - AjustarBotoesPorModo: o legado nao tem pcEscolha/modos (INCLUIR/
*     ALTERAR/VISUALIZAR/EXCLUIR) - e um dialogo de UMA acao so (gerar
*     senhas livres), sem alternancia de pagina nem de estado de botoes.
*
* Inventar qualquer um desses metodos criaria UI/funcionalidade que o
* legado nao tem (PILAR 1) ou um stub sem logica real (proibido pela regra
* de completude) - as duas coisas sao erro, nao omissao.
*
* Integracao (checklist da tarefa): config.prg ja carrega SigPrSndBO.prg/
* FormSigPrSnd.prg dinamicamente via ADIR (nao exige SET PROCEDURE manual);
* o item de menu (popFerramentas, ao lado de "Gerar Senha do Dia") e o
* PROCEDURE AbrirFormSigPrSnd entram nesta fase em menu.prg.
*
* Arquitetura: FormBase (UI) -> BusinessBase (BO) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS FormSigPrSnd AS FormBase

    *-- Propriedades visuais (fieis ao SIGPRSND.scx)
    Width        = 500
    Height       = 324
    Caption      = "Senhas livres"
    ShowWindow   = 1
    WindowType   = 1

    *-- Dialogo modal sem barra de titulo (fiel ao legado)
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    BorderStyle  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    DataSession  = 2

    *-- Business Object (geracao de senhas livres - ver SigPrSndBO.prg)
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Valida a conexao (guarda do Init legado), instancia
    * o Business Object e monta a faixa de titulo. Grid/campo de quantidade/
    * botoes entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF THIS.ValidarParametros()
            TRY
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.this_oBusinessObject = CREATEOBJECT("SigPrSndBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Erro ao criar SigPrSndBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.ConfigurarCabecalho()
                    THIS.ConfigurarGrid()
                    THIS.ConfigurarBotoes()
                    THIS.ConfigurarCampos()
                    THIS.ConfigurarEventos()

                    *-- Cursor de trabalho das senhas + bind da grade. O
                    *-- cursor nasce VAZIO e a grade abre vazia DE PROPOSITO
                    *-- (regra #35a): o legado so consulta dados no Click de
                    *-- btnSenPend / btnGerSen, nunca no Init.
                    IF THIS.CriarCursorDados()
                        THIS.VincularGrade()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Inicializar FormSigPrSnd")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - guarda de conexao do Init legado:
    *     .poDataMgr = CreateObject('fSqlConector', ThisForm.Name)
    *     If (.poDataMgr.pnIdconn > 0)
    *         =DoDefault()
    *     Else
    *         =Messagebox('Impossivel Efetuar Conexao com Servidor de Banco
    *                      de Dados...', 0+48, 'CreateObject')
    *         Return .f.
    *     EndIf
    * gnConnHandle substitui o poDataMgr.pnIdconn (conexao global aberta em
    * main.prg). PUBLIC (sem PROTECTED) porque o harness de teste automatico
    * chama metodos do form de fora da classe (regra #3 / CLAUDE.md).
    *--------------------------------------------------------------------------
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
                loc_lValido = .F.
            CASE gnConnHandle <= 0
                loc_lValido = .F.
        ENDCASE

        IF !loc_lValido
            MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                "o com Servidor de Banco de Dados...", "CreateObject")
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa cinza com o titulo (cntSombra do legado).
    * Width do container normalizado para THIS.Width (o dump legado traz
    * Width=800, herdado da classe compartilhada do Framework - maior que o
    * Form, que e 500; mesma normalizacao ja aplicada em Formsigprsen.prg
    * para o legado-irmao SIGPRSEN). Labels mantem a Width=769 literal do
    * dump (AutoSize=.F., BackStyle=0 transparente - a sobra nao pinta nada
    * e nao bloqueia clique em controle nenhum, porque e criada ANTES de
    * qualquer outro controle).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .WordWrap  = .T.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .WordWrap  = .T.
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Grid de senhas geradas (grdSenha do legado). Replica
    * ColumnCount/FontName/HeaderHeight/RowHeight/GridLineColor/Column1/
    * Header1/Text1 do dump (SigPrSnd_form_codigo_fonte.txt). ZOrderSet e
    * Panel do dump NAO sao propriedades reais em runtime (ZOrderSet eh
    * bookkeeping do Form Designer - regra #33 - e Panel nao existe na
    * classe Grid) - omitidos de proposito. RecordMark = .F. (NAO o .T. do
    * dump): regra do projeto para Grid criado via AddObject em form
    * OPERACIONAL (barra de marcacao lateral indevida).
    *
    * NAO liga RecordSource/ControlSource aqui: esse bind mora em
    * VincularGrade(), que eh chamado no InicializarForm (com o cursor
    * vazio, para o cabecalho "Senhas geradas" aparecer) e de novo em TODO
    * caminho que repopula o cursor - exatamente como o legado, que repete
    * o bloco de bind no Click de btnSenPend E no de btnGerSen. Concentrar
    * num metodo unico evita que um dos caminhos esqueca de reaplicar
    * Width/Header1.Caption, que o RecordSource reseta (Problema 48).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top                = 110
            .Left               = 48
            .Width              = 140
            .Height             = 162
            .ColumnCount        = 1
            .FontName           = "Verdana"
            .FontSize           = 8
            .HeaderHeight       = 16
            .RowHeight          = 16
            .ScrollBars         = 2
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLineColor      = RGB(238, 238, 238)

            WITH .Column1
                .ColumnOrder = 1
                .Width       = 100
                .FontSize    = 8
                .ReadOnly    = .T.

                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                    .Caption   = "Senhas geradas"
                ENDWITH

                WITH .Text1
                    .FontSize = 8
                    .ReadOnly = .T.
                ENDWITH
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Os quatro CommandButton standalone do legado
    * (btnSenPend/btnExcel/btnGerSen/Saida), filhos diretos do form (sem
    * CommandGroup/container - o dump nao tem nenhum dos dois aqui).
    * Top/Left/Caption/Picture EXATOS do dump; Width/Height/fonte/cores
    * seguem o padrao canonico dos botoes standalone fwbtng do projeto
    * (Formsigprsen.prg) - 75x75, Comic Sans MS, ForeColor cinza. Picture
    * com Themes=.T. + DisabledPicture (regra do projeto para standalone
    * CommandButton com Picture - sem isso o icone some com Enabled=.F.).
    * Criados DEPOIS de ConfigurarCabecalho/ConfigurarGrid: btnExcel/
    * btnGerSen/Saida ficam em Top=4, dentro da faixa do cabecalho
    * (Height=80), e precisam desenhar POR CIMA dela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_BtnSenPend", "CommandButton")
        WITH THIS.cmd_4c_BtnSenPend
            .Top             = 190
            .Left            = 251
            .Width           = 75
            .Height          = 75
            .Caption         = "Senhas pendentes"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnExcel", "CommandButton")
        WITH THIS.cmd_4c_BtnExcel
            .Top             = 4
            .Left            = 275
            .Width           = 75
            .Height          = 75
            .Caption         = "Excel"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_BtnGerSen", "CommandButton")
        WITH THIS.cmd_4c_BtnGerSen
            .Top             = 4
            .Left            = 350
            .Width           = 75
            .Height          = 75
            .Caption         = "Gerar Senha"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Saida", "CommandButton")
        WITH THIS.cmd_4c_Saida
            .Top             = 4
            .Left            = 425
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Unico campo de dados do legado: Label3 (fixo) +
    * getqtdsen (quantidade de senhas a gerar), filhos diretos do form.
    * Top/Left/Width/Height/Caption/propriedades EXATOS do dump
    * (SigPrSnd_form_codigo_fonte.txt) - sem offset de PageFrame (este form
    * OPERACIONAL nao tem PageFrame, regra ja documentada no cabecalho).
    *
    * Label3.AutoSize = .T. no dump eh NO-OP em Label criado por AddObject
    * (regra #23): aqui fica .AutoSize = .F. com o Width=86/Height=15 do
    * Form Designer, ja calculados para o texto "Qtde de Senhas :".
    *
    * getqtdsen.Format = "K" (seleciona o conteudo ao entrar - UX, regra
    * #49 severidade BAIXA) e .Alignment = 3 (Automatic) sao transcritos
    * literalmente do dump; .Value = 0 (numerico, ControlSource vazio no
    * legado - o campo so eh lido por codigo, nunca gravado no banco).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 87
            .Left      = 54
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde de Senhas :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Qtdsen", "TextBox")
        WITH THIS.txt_4c_Qtdsen
            .Top           = 84
            .Left          = 152
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Value         = 0
            .Format        = "K"
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga os eventos dos CAMPOS do form. Chamado DEPOIS
    * de ConfigurarCampos(), que eh quem cria o txt_4c_Qtdsen (BINDEVENT em
    * controle inexistente estoura no proprio BIND).
    *
    * O legado NAO tem lookup nenhum (ver cabecalho, item (a)) - nao ha
    * KeyPress de F3/F4 nem DblClick de picker para ligar aqui. O unico
    * evento de campo do dump inteiro eh
    *     SIGPRSND.grdSenha.Column1.Text1.When -> Return .f.
    * ou seja, a celula da grade nao aceita digitacao. Esse comportamento JA
    * esta reproduzido de forma ESTATICA em ConfigurarGrid()/VincularGrade()
    * (Column1.ReadOnly = .T. + Text1.ReadOnly = .T.), que eh o equivalente
    * canonico do projeto - e eh a unica forma que funciona: BINDEVENT
    * DESCARTA o valor de retorno do delegate, entao um "When" ligado por
    * BINDEVENT nao bloquearia edicao nenhuma (regra conhecida do projeto).
    * Por isso NAO ha BINDEVENT de "When" aqui.
    *
    * O Click dos quatro botoes do legado entra nas Fases 7/8 (Eventos
    * Principais / Auxiliares) - nao se liga aqui um Click cujo handler
    * ainda nao existe, porque BINDEVENT com delegate inexistente estoura
    * na hora do BIND.
    *
    * PUBLIC (sem PROTECTED): BINDEVENT so funciona com metodo PUBLIC e o
    * harness de teste automatico chama metodos do form de FORA da classe
    * (regra #3 / #51 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarEventos()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
                BINDEVENT(THIS.txt_4c_Qtdsen, "LostFocus", THIS, "TxtQtdsenLostFocus")
                loc_lSucesso = .T.
            ENDIF

            *-- Click dos botoes de ACAO do legado (Fase 7). Cada BINDEVENT eh
            *-- guardado pelo PEMSTATUS do CONTROLE porque BINDEVENT com objeto
            *-- inexistente estoura no proprio BIND, derrubando o Init inteiro.
            IF PEMSTATUS(THIS, "cmd_4c_BtnSenPend", 5)
                BINDEVENT(THIS.cmd_4c_BtnSenPend, "Click", THIS, "BtnSenPendClick")
            ENDIF

            IF PEMSTATUS(THIS, "cmd_4c_BtnGerSen", 5)
                BINDEVENT(THIS.cmd_4c_BtnGerSen, "Click", THIS, "BtnGerSenClick")
            ENDIF

            *-- Click dos botoes AUXILIARES do legado (Fase 8): exportar para
            *-- Excel e encerrar a tela. Mesma guarda por PEMSTATUS do
            *-- CONTROLE das duas linhas acima.
            IF PEMSTATUS(THIS, "cmd_4c_BtnExcel", 5)
                BINDEVENT(THIS.cmd_4c_BtnExcel, "Click", THIS, "BtnExcelClick")
            ENDIF

            IF PEMSTATUS(THIS, "cmd_4c_Saida", 5)
                BINDEVENT(THIS.cmd_4c_Saida, "Click", THIS, "BtnSaidaClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarEventos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtQtdsenLostFocus - Normaliza o conteudo de txt_4c_Qtdsen para
    * NUMERICO ao sair do campo.
    *
    * NAO exibe dialogo e NAO abre picker: o legado nao valida este campo ao
    * SAIR dele (o unico guard esta no Click de "Gerar Senha" - ver
    * ValidarQtdeSenhas). Avisar aqui inventaria um modal que o legado nao
    * tem, e apagar o digitado pelo usuario eh exatamente o defeito das
    * regras #47 e #50.
    *
    * Por que normalizar: no legado o getqtdsen nasce com .Value = 0 e o
    * tipo eh sustentado pelo proprio controle; no migrado o TextBox eh
    * criado por AddObject SEM ControlSource, entao nada garante que .Value
    * continue numerico depois de uma atribuicao por codigo (mesma familia
    * da regra #16). Normalizar no funil de saida do campo faz
    * ObterQtdeSenhas()/ValidarQtdeSenhas() e o laco de geracao da Fase 7
    * trabalharem sempre sobre numero.
    *
    * Sem parametros: LostFocus nao passa nenhum (declarar par_nKeyCode aqui
    * seria assinatura de handler de KeyPress - regra #47).
    *
    * PUBLIC (sem PROTECTED): exigencia do BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE TxtQtdsenLostFocus()
        LOCAL loc_nQtd, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
                loc_nQtd = THIS.ObterQtdeSenhas()

                *-- So reescreve quando o conteudo NAO esta no tipo esperado,
                *-- para nao mexer no que o usuario digitou sem necessidade.
                IF VARTYPE(THIS.txt_4c_Qtdsen.Value) != "N"
                    THIS.txt_4c_Qtdsen.Value = loc_nQtd
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em TxtQtdsenLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterQtdeSenhas - Leitura normalizada do campo "Qtde de Senhas".
    * Equivalente ao 'lnQtd = thisform.getqtdsen.Value' do Click de btnGerSen,
    * com a guarda de VARTYPE que o legado nao precisava ter (o controle dele
    * era numerico por construcao; o migrado nao tem ControlSource).
    *
    * Devolve SEMPRE um numero. Nao exibe mensagem - quem avisa eh
    * ValidarQtdeSenhas(), no mesmo ponto em que o legado avisa.
    *
    * PUBLIC: usado pelo BtnGerSenClick da Fase 7 e pelo harness (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ObterQtdeSenhas()
        LOCAL loc_nQtd, loc_uValor
        loc_nQtd = 0

        IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
            loc_uValor = THIS.txt_4c_Qtdsen.Value

            DO CASE
                CASE VARTYPE(loc_uValor) = "N"
                    loc_nQtd = loc_uValor
                CASE VARTYPE(loc_uValor) = "C"
                    loc_nQtd = VAL(ALLTRIM(loc_uValor))
                OTHERWISE
                    loc_nQtd = 0
            ENDCASE
        ENDIF

        RETURN loc_nQtd
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarQtdeSenhas - Campo "Qtde de Senhas" obrigatorio. TRANSCRICAO do
    * guard que abre o Click de btnGerSen no legado:
    *
    *     If Empty(thisform.getQtdSen.Value)
    *         =Messagebox('Qtde de senhas obrigatorio.',48,[Aviso])
    *         ThisForm.getQtdSen.Setfocus()
    *         Return .f.
    *     EndIf
    *
    * Mantidos o TEXTO e o TITULO do legado (icone 48 = aviso -> MsgAviso,
    * que eh a funcao canonica do projeto para validacao de UI; MESSAGEBOX
    * direto eh proibido). EMPTY(0) eh .T. em VFP9, entao o campo zerado
    * reprova exatamente como no legado.
    *
    * NAO acrescenta limite superior: o teto ja eh o MaxLength = 3 do
    * TextBox, transcrito do dump - inventar aqui um "maximo de N senhas"
    * seria regra de negocio que o legado nao tem.
    *
    * Chamado pelo BtnGerSenClick (Fase 7), no MESMO ponto do legado - nao
    * no LostFocus do campo (ver cabecalho).
    *
    * PUBLIC: chamado de fora da classe pelo harness de teste (regra #51 -
    * metodo que o form/teste chama de fora nunca pode ser PROTECTED).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarQtdeSenhas()
        LOCAL loc_lValido, loc_nQtd
        loc_lValido = .T.

        loc_nQtd = THIS.ObterQtdeSenhas()

        IF EMPTY(loc_nQtd)
            MsgAviso("Qtde de senhas obrigat" + CHR(243) + "rio.", "Aviso")

            IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5) AND THIS.txt_4c_Qtdsen.Enabled ;
                    AND THIS.txt_4c_Qtdsen.Visible
                THIS.txt_4c_Qtdsen.SetFocus()
            ENDIF

            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorDados - Cria o cursor de trabalho da grade (cursor_4c_Senhas,
    * equivalente ao crSigPrSnd do legado) delegando o SQL ao Business Object.
    *
    * No legado isso mora no Init, via poDataMgr.AddCursor com uma chave
    * SENTINELA (Replicate(Chr(254), 20)) que nao casa com registro nenhum:
    * o cursor nasce VAZIO e com a estrutura completa de SigPrSnd, pronto
    * para receber o Insert Into/Replace do Click de "Gerar Senha".
    *
    * PUBLIC (sem PROTECTED): o harness de teste automatico chama metodos do
    * form de FORA da classe (regra #3 / #51 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = THIS.this_oBusinessObject.CriarCursorSenhas()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CriarCursorDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrade - Liga grd_4c_Dados ao cursor_4c_Senhas. TRANSCRITO do
    * bloco que o legado repete no Click de btnSenPend E de btnGerSen:
    *     Select crSigPrSnd
    *     Go top
    *     Thisform.grdSenha.RecordSource = [crSigPrSnd]
    *     ThisForm.grdSenha.Column1.ControlSource = [crSigPrSnd.Senhads]
    *     ThisForm.grdSenha.Refresh()
    *
    * ORDEM OBRIGATORIA (regra #41 / Problema 48): ColumnCount -> RecordSource
    * -> ControlSource -> Width -> Header1.Caption. Atribuir RecordSource
    * RESETA Column.Width para o default 90 e o Header1.Caption para
    * "Header1", entao as propriedades visuais da coluna TEM de ser
    * reaplicadas DEPOIS do ControlSource - em TODO site que re-liga a grade,
    * e nao so no ConfigurarGrid.
    *
    * Reatribuir ColumnCount aqui eh seguro porque esta Column NAO tem
    * controle posto por AddObject (so os nativos Header1/Text1) - a regra
    * "nunca reatribuir ColumnCount" existe para proteger CheckBox/
    * OptionGroup criados em coluna, que nao eh o caso.
    *
    * PUBLIC (sem PROTECTED): chamado pelos handlers de Click (Fases 7/8) e
    * pelo harness de teste (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE VincularGrade()
        LOCAL loc_oGrid, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Senhas") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_oGrid = THIS.grd_4c_Dados

                SELECT cursor_4c_Senhas
                GO TOP

                loc_oGrid.RecordSource = ""
                loc_oGrid.ColumnCount  = 1
                loc_oGrid.RecordSource = "cursor_4c_Senhas"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Senhas.senhads"

                *-- Reaplicar DEPOIS do RecordSource/ControlSource (ver acima).
                *-- Valores identicos aos do dump legado (grdSenha.Column1 /
                *-- Column1.Header1 / Column1.Text1).
                WITH loc_oGrid.Column1
                    .ColumnOrder = 1
                    .Width       = 100
                    .FontSize    = 8
                    .ReadOnly    = .T.

                    WITH .Header1
                        .FontName  = "Verdana"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(36, 84, 155)
                        .Caption   = "Senhas geradas"
                    ENDWITH

                    WITH .Text1
                        .FontSize = 8
                        .ReadOnly = .T.
                    ENDWITH
                ENDWITH

                loc_oGrid.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em VincularGrade")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega na grade as senhas ainda NAO vinculadas a
    * documento. TRANSCRITO do Click de btnSenPend:
    *     Thisform.grdSenha.RecordSource = []
    *     lcQuery = [Select * From SigPrSnd Where EmpDopNums = '']
    *     ThisForm.poDataMgr.SqlExecute(lcQuery,'crSigPrSnd')
    *     Select crSigPrSnd / Go top / <re-liga a grade> / Refresh()
    *
    * O SQL fica no BO e devolve cursor_4c_SenhasTemp; aqui o alias da grade
    * eh recarregado com ZAP + APPEND FROM DBF(), que PRESERVA estrutura,
    * RecordSource, ControlSource e as larguras - fechar e recriar o alias
    * derrubaria o bind e deixaria a grade permanentemente vazia com o cursor
    * cheio (regra #21a: SQLEXEC sobre alias de Grid zera o ColumnCount).
    *
    * O ZAP vai GUARDADO por SET SAFETY OFF: SAFETY eh escopado por data
    * session e este form eh DataSession = 2, onde ela vale ON mesmo com o
    * SET SAFETY OFF do main.prg - sem a guarda o ZAP abre o dialogo modal
    * de confirmacao e CONGELA a tela.
    *
    * Fecha com GO TOP + Refresh da grade: popular o cursor NAO repinta a
    * grade sozinho (regra #21).
    *
    * PUBLIC (sem PROTECTED): chamado pelo handler de Click (Fase 7) e pelo
    * harness de teste (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Garante o alias da grade (primeira carga, ou cursor
                *-- derrubado por outro fluxo)
                IF !USED("cursor_4c_Senhas")
                    THIS.CriarCursorDados()
                ENDIF

                IF USED("cursor_4c_Senhas") ;
                        AND THIS.this_oBusinessObject.CarregarSenhasPendentes()

                    *-- ZAP + APPEND FROM DBF + re-bind da grade moram no funil
                    *-- unico RecarregarGradeDoTemp (Fase 7), compartilhado com
                    *-- o Click de btnGerSen - o legado repete o MESMO bloco de
                    *-- re-bind nos dois Clicks (Problema 48 / regra #41).
                    loc_lSucesso = THIS.RecarregarGradeDoTemp()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CarregarDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RecarregarGradeDoTemp - recarrega o alias da grade a partir de
    * cursor_4c_SenhasTemp e repinta a grade.
    *
    * FUNIL UNICO dos dois caminhos que trazem linhas para a grade (o Click de
    * btnSenPend, via CarregarDados, e o Click de btnGerSen): o legado repete
    * o MESMO bloco de re-bind nos dois Clicks, e manter uma copia por caminho
    * eh como um deles acaba esquecendo de reaplicar Width/Header1.Caption, que
    * o RecordSource reseta (Problema 48 / regra #41).
    *
    * ZAP + APPEND FROM DBF() em vez de recriar o alias: SQLEXEC (ou USE IN +
    * SELECT INTO) sobre o alias ligado a um Grid FECHA e RECRIA o alias,
    * zerando RecordSource/ControlSource/ColumnCount - a grade viraria um
    * retangulo branco pelo RESTO da vida do form (regra #21a). O ZAP preserva
    * estrutura e bind; o APPEND casa as colunas por NOME.
    *
    * O ZAP vai GUARDADO por SET SAFETY OFF: SAFETY eh escopado por data
    * session e este form eh DataSession = 2, onde ela vale ON mesmo com o
    * SET SAFETY OFF do main.prg - sem a guarda o ZAP abre o dialogo modal de
    * confirmacao e CONGELA a tela.
    *
    * Fecha com GO TOP + Refresh da grade (dentro de VincularGrade): popular o
    * cursor NAO repinta a grade sozinho (regra #21).
    *
    * PUBLIC (sem PROTECTED): chamado pelos handlers de Click e pelo harness de
    * teste automatico, que chama metodos do form de FORA da classe (regra #3 /
    * #51 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE RecarregarGradeDoTemp()
        LOCAL loc_lSucesso, loc_cSafety, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Garante o alias da grade (primeira carga, ou cursor derrubado
            *-- por outro fluxo)
            IF !USED("cursor_4c_Senhas")
                THIS.CriarCursorDados()
            ENDIF

            IF USED("cursor_4c_Senhas") AND USED("cursor_4c_SenhasTemp")
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                ZAP IN cursor_4c_Senhas
                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF

                SELECT cursor_4c_Senhas
                APPEND FROM DBF("cursor_4c_SenhasTemp")

                USE IN cursor_4c_SenhasTemp

                SELECT cursor_4c_Senhas
                GO TOP

                THIS.VincularGrade()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em RecarregarGradeDoTemp")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSenPendClick - Click de btnSenPend, o botao que lista as senhas ainda
    * nao vinculadas a documento algum. TRANSCRITO:
    *
    *     Thisform.grdSenha.RecordSource = []
    *     lcQuery = [Select * From SigPrSnd Where EmpDopNums = '']
    *     ThisForm.poDataMgr.SqlExecute(lcQuery,'crSigPrSnd')
    *     Select crSigPrSnd
    *     Go top
    *     Thisform.grdSenha.RecordSource = [crSigPrSnd]
    *     ThisForm.grdSenha.Column1.ControlSource = [crSigPrSnd.Senhads]
    *     ThisForm.grdSenha.Refresh()
    *
    * O corpo inteiro ja mora em CarregarDados() (consulta no BO + ZAP/APPEND +
    * re-bind da grade); aqui fica o Click, que eh so o disparo.
    *
    * NAO exibe mensagem quando a consulta volta VAZIA: o legado nao avisa nada
    * nesse caso - a grade simplesmente fica sem linhas. Inventar um
    * MsgAviso("Nenhuma senha ...") aqui seria modal que o legado nao tem
    * (PILAR 1), que eh o defeito das regras #47/#50.
    *
    * PUBLIC: exigencia do BINDEVENT (regra #3) e do harness (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSenPendClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnSenPendClick")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerSenClick - Click de btnGerSen ("Gerar Senha"). Acao PRINCIPAL da
    * tela. TRANSCRITO do legado, na MESMA ordem:
    *
    *   1. campo obrigatorio      -> THIS.ValidarQtdeSenhas()
    *          If Empty(thisform.getQtdSen.Value)
    *              =Messagebox('Qtde de senhas obrigatorio.',48,[Aviso])
    *              ThisForm.getQtdSen.Setfocus() / Return .f.
    *   2. confirmacao do usuario -> MsgConfirma(...)
    *          If Messagebox([Deseja realmente gerar ] + Alltrim(Str(lnQtd)) +
    *                        [ senhas livres?],4+32+256,[Gerar Senha]) = 7
    *              Return .f.
    *   3. Zap + geracao + gravacao + Commit/RollBack -> BO.GerarSenhasLivres()
    *   4. re-bind da grade com as senhas geradas     -> RecarregarGradeDoTemp()
    *   5. aviso de sucesso
    *          =Messagebox([Favor anotar as senhas geradas.],48,[Senhas Livres])
    *   6. thisform.getqtdsen.Value = 0
    *
    * MsgConfirma devolve LOGICO (.T. = Sim), nao numero: comparar com 6 ou 7
    * eh o defeito da regra #7. Ela usa MESSAGEBOX com 4+32 (Sim/Nao + icone de
    * pergunta); o legado soma ainda 256 (segundo botao como default, ou seja o
    * "Nao" pre-selecionado). MESSAGEBOX direto eh PROIBIDO no projeto, entao
    * fica a funcao canonica - a diferenca eh qual botao chega pre-selecionado.
    *
    * A mensagem de sucesso usa MsgAviso porque o legado usa o icone 48
    * (exclamacao/aviso) - eh um recado para o usuario ANOTAR as senhas, nao um
    * "gravado com sucesso" qualquer, e MsgAviso eh a funcao canonica do
    * projeto para icone 48.
    *
    * O passo 6 (zerar o campo) roda SO em caso de sucesso: no legado ele esta
    * depois do If/Else de Commit/RollBack, mas os dois RETURN anteriores (campo
    * vazio e confirmacao negada) desviam antes de chegar la, e com a gravacao
    * falhando nao faz sentido apagar a quantidade que o usuario digitou - ele
    * vai querer tentar de novo (regra #50).
    *
    * PUBLIC: exigencia do BINDEVENT (regra #3) e do harness (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerSenClick()
        LOCAL loc_nQtd, loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        *-- Os dois guards do legado ficam FORA do TRY, para o desvio ser um
        *-- RETURN de verdade e nao um salto para o CATCH (regra #1)
        IF !THIS.ValidarQtdeSenhas()
            RETURN .F.
        ENDIF

        loc_nQtd = THIS.ObterQtdeSenhas()

        IF !MsgConfirma("Deseja realmente gerar " + ALLTRIM(STR(loc_nQtd)) + ;
                " senhas livres?", "Gerar Senha")
            RETURN .F.
        ENDIF

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Gerar Senha")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.GerarSenhasLivres(loc_nQtd)
                    *-- A grade passa a exibir SO as senhas recem-geradas, como
                    *-- no legado (que faz Zap no cursor antes de gerar)
                    THIS.RecarregarGradeDoTemp()

                    MsgAviso("Favor anotar as senhas geradas.", "Senhas Livres")

                    IF PEMSTATUS(THIS, "txt_4c_Qtdsen", 5)
                        THIS.txt_4c_Qtdsen.Value = 0
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    *-- BusinessBase.ExibirFalha ja mostrou o motivo e marcou
                    *-- this_lErroExibido; nao repetir a mensagem (regra #20)
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel gerar as senhas livres.", "Gerar Senha")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnGerSenClick")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * BtnExcelClick - Click de btnExcel ("Excel"). Exporta a coluna de senhas
    * atualmente exibida na grade (cursor_4c_Senhas) para planilha XLS ou
    * TXT delimitado. TRANSCRITO do legado:
    *
    *     Select SenhaDs as Senhas From crSigPrSnd Into Cursor TmpPrSnd
    *     Select TmpPrSnd
    *     llErr = .f.
    *     lcErr = On([Error]) / On Error llErr = .t.
    *     lcExl = PutFile([Nome da Planilha], [], [XLS;TXT])
    *     If fVerificaPasta(lcExl, 2)
    *         If (Lower(Alltrim(JustExt(lcExl))) = [xls])
    *             Copy To (lcExl) Type Xl5
    *         Else
    *             Copy To (lcExl) Delimited With '' With Character ';'
    *         EndIf
    *         If File(lcExl)
    *             =MessageBox([Arquivo gerado com sucesso], 0+48+32, ;
    *                 [Geracao de Planilha])
    *         EndIf
    *     Else
    *         llErr = .t.
    *     EndIf
    *     If llErr
    *         =MessageBox([Falha na Geracao da Planilha. Verifique o ;
    *             Diretorio ou Planilha Em Uso], 0+48+32, [Geracao de Planilha])
    *     EndIf
    *     On Error &lcErr.
    *     Use in TmpPrSnd
    *
    * O "On Error llErr = .t." (trap global, inexistente na arquitetura
    * nova) virou TRY/CATCH em volta do COPY TO. MESSAGEBOX e PROIBIDO - os
    * DOIS avisos do legado usam icone 48 (exclamacao/aviso, nao 16/erro),
    * entao os dois mapeiam para MsgAviso.
    *
    * NAO ha guarda extra para "lcExl vazio" (usuario cancelou o PutFile):
    * o legado tambem nao tem - fVerificaPasta("",...) ja devolve .F. (ver
    * utils\fverificapasta.prg) e cai no MESMO "Falha na Geracao..." que o
    * legado mostraria. Transcricao literal, nao aproximacao (PILAR 1).
    *
    * PutFile()/GETFILE nativos do VFP9 continuam existindo sem troca.
    * fVerificaPasta() ja existe em utils\ (wrapper de compatibilidade para
    * o mesmo padrao do VCX DocumentoExcel do framework legado - mesmo
    * contrato, 2o parametro ignorado).
    *
    * PUBLIC: exigencia do BINDEVENT (regra #3) e do harness (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_lErro, loc_oErro
        loc_lErro = .F.

        IF !USED("cursor_4c_Senhas")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_TmpSenhas")
                USE IN cursor_4c_TmpSenhas
            ENDIF

            SELECT senhads AS Senhas FROM cursor_4c_Senhas ;
                INTO CURSOR cursor_4c_TmpSenhas

            SELECT cursor_4c_TmpSenhas

            loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS;TXT")

            IF fVerificaPasta(loc_cArquivo, 2)
                TRY
                    IF LOWER(ALLTRIM(JUSTEXT(loc_cArquivo))) = "xls"
                        COPY TO (loc_cArquivo) TYPE XL5
                    ELSE
                        COPY TO (loc_cArquivo) DELIMITED WITH "" WITH CHARACTER ";"
                    ENDIF
                CATCH TO loc_oErro
                    loc_lErro = .T.
                ENDTRY

                IF !loc_lErro AND FILE(loc_cArquivo)
                    MsgAviso("Arquivo gerado com sucesso", ;
                        "Gera" + CHR(231) + CHR(227) + "o de Planilha")
                ENDIF
            ELSE
                loc_lErro = .T.
            ENDIF
        CATCH TO loc_oErro
            loc_lErro = .T.
        ENDTRY

        IF loc_lErro
            MsgAviso("Falha na Gera" + CHR(231) + CHR(227) + "o da Planilha. " + ;
                "Verifique o Diret" + CHR(243) + "rio ou Planilha Em Uso", ;
                "Gera" + CHR(231) + CHR(227) + "o de Planilha")
        ENDIF

        IF USED("cursor_4c_TmpSenhas")
            USE IN cursor_4c_TmpSenhas
        ENDIF

        RETURN !loc_lErro
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSaidaClick - Click de Saida (cmd_4c_Saida, caption "Encerrar").
    * Fiel ao legado:
    *     PROCEDURE Click
    *     ThisForm.Release
    *
    * Nome do handler pelo NOME DO OBJETO do legado ("Saida"), nao pelo
    * roteiro generico de CRUD ("BtnEncerrarClick") - este form OPERACIONAL
    * nao segue esse roteiro (ver cabecalho do arquivo). Mesmo padrao do
    * legado-irmao Formsigprsen.prg (BtnSaidaClick).
    *
    * PUBLIC: exigencia do BINDEVENT (regra #3) e do harness (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSaidaClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o Business Object (DODEFAULT() ao final - regra do
    * CorretorAutomatico #145: sem ela o menu do sistema encolhe visualmente).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SenhasTemp")
            USE IN cursor_4c_SenhasTemp
        ENDIF
        IF USED("cursor_4c_SenhasEstrut")
            USE IN cursor_4c_SenhasEstrut
        ENDIF
        IF USED("cursor_4c_TmpSenhas")
            USE IN cursor_4c_TmpSenhas
        ENDIF
        IF USED("cursor_4c_Senhas")
            *-- TABLEREVERT SO com buffering ligado (ver SigPrSndBO.
            *-- CriarCursorSenhas): sem buffer ele dispara erro, e erro no
            *-- Destroy impede a tela de FECHAR.
            IF CURSORGETPROP("Buffering", "cursor_4c_Senhas") > 1
                TABLEREVERT(.T., "cursor_4c_Senhas")
            ENDIF
            USE IN cursor_4c_Senhas
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrSndBO.prg):
*============================================================================
* SigPrSndBO.prg - Business Object para Senhas Livres (Geracao de Senhas)
*
* Tabela: SigPrSnd  (PK: cidchaves char(20))
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrSndBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigPrSnd (campos do banco)
    *==========================================================================
    this_cCidchaves  = ""   && char(20)      - Chave primaria (gerada via fUniqueIds)
    this_dDatas      = {}   && datetime NULL - Data de geracao da senha
    this_nDocs       = 0    && numeric(10,0) - Numero do documento vinculado
    this_cHoras      = ""   && char(8)       - Hora de geracao da senha
    this_cMotivos    = ""   && char(40)      - Motivo da geracao da senha
    this_cOperas     = ""   && char(20)      - Operacao vinculada a senha
    this_cSenhads    = ""   && char(6)       - Senha gerada (codigo)
    this_cSolicits   = ""   && char(10)      - Solicitante da senha
    this_cUsuars     = ""   && char(10)      - Usuario que gerou a senha
    this_nValors     = 0    && numeric(11,2) - Valor vinculado a senha
    this_nTipos      = 0    && numeric(1,0)  - Tipo da senha (0=Livre)
    this_cEmps       = ""   && char(3)       - Codigo da empresa
    this_cFpags      = ""   && char(12)      - Forma de pagamento vinculada
    this_cEmpdopnums = ""   && char(29)      - Chave de vinculo Empresa+Documento+Operacao+Numero
    this_nPerlimite  = 0    && numeric(5,2)  - Percentual limite vinculado a senha

    *==========================================================================
    * Estado interno da geracao de senhas (nao sao colunas de SigPrSnd)
    *
    * this_lRandSemeado    - RAND() do VFP9 comeca numa semente FIXA, entao sem
    *      RAND(-1) (semente do relogio) duas sessoes gerariam a MESMA sequencia
    *      de candidatos. Semeado UMA vez por instancia do BO.
    * this_nMaxTentativasSenha - teto de tentativas por senha. O legado escreve
    *      "Do While _Inicio = 0" SEM teto: com a faixa de senhas esgotada, ou
    *      com a consulta de duplicidade falhando, aquele laco gira para sempre
    *      e CONGELA o dialogo modal sem mensagem nenhuma. O teto eh um desvio
    *      DELIBERADO do legado - ver GerarSenhaUnica.
    *==========================================================================
    this_lRandSemeado        = .F.
    this_nMaxTentativasSenha = 100

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrSnd"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir do cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar os campos
    * (nao usar sintaxe campo - erro de sintaxe em VFP9)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
                THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
                THIS.this_nDocs       = TratarNulo(docs,       0)
                THIS.this_cHoras      = TratarNulo(horas,      "")
                THIS.this_cMotivos    = TratarNulo(motivos,    "")
                THIS.this_cOperas     = TratarNulo(operas,     "")
                THIS.this_cSenhads    = TratarNulo(senhads,    "")
                THIS.this_cSolicits   = TratarNulo(solicits,   "")
                THIS.this_cUsuars     = TratarNulo(usuars,     "")
                THIS.this_nValors     = TratarNulo(valors,     0)
                THIS.this_nTipos      = TratarNulo(tipos,      0)
                THIS.this_cEmps       = TratarNulo(emps,       "")
                THIS.this_cFpags      = TratarNulo(fpags,      "")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_nPerlimite  = TratarNulo(perlimite,  0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "SigPrSndBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Grava uma nova senha livre na tabela SigPrSnd
    * Cobre TODAS as colunas NOT NULL (regra #22 CLAUDE.md)
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrSnd (cidchaves, datas, docs, horas, motivos, operas, senhads, solicits, usuars, valors, tipos, emps, fpags, empdopnums, perlimite)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidchaves)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<FormatarNumeroSQL(THIS.this_nDocs, 0)>>,
                    <<EscaparSQL(THIS.this_cHoras)>>,
                    <<EscaparSQL(THIS.this_cMotivos)>>,
                    <<EscaparSQL(THIS.this_cOperas)>>,
                    <<EscaparSQL(THIS.this_cSenhads)>>,
                    <<EscaparSQL(THIS.this_cSolicits)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cFpags)>>,
                    <<EscaparSQL(THIS.this_cEmpdopnums)>>,
                    <<FormatarNumeroSQL(THIS.this_nPerlimite, 2)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao gravar a senha livre:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "SigPrSndBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrSnd
    * (o legado nao altera senhas ja geradas - este metodo existe para
    * completar a arquitetura em camadas, por exemplo ao vincular a senha
    * a um documento/operacao apos a geracao)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrSnd
                SET datas      = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    docs       = <<FormatarNumeroSQL(THIS.this_nDocs, 0)>>,
                    horas      = <<EscaparSQL(THIS.this_cHoras)>>,
                    motivos    = <<EscaparSQL(THIS.this_cMotivos)>>,
                    operas     = <<EscaparSQL(THIS.this_cOperas)>>,
                    senhads    = <<EscaparSQL(THIS.this_cSenhads)>>,
                    solicits   = <<EscaparSQL(THIS.this_cSolicits)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>,
                    valors     = <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    tipos      = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    emps       = <<EscaparSQL(THIS.this_cEmps)>>,
                    fpags      = <<EscaparSQL(THIS.this_cFpags)>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpdopnums)>>,
                    perlimite  = <<FormatarNumeroSQL(THIS.this_nPerlimite, 2)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar a senha livre:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "SigPrSndBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarCursorSenhas - Cria o cursor de trabalho das senhas, VAZIO e
    * READWRITE, com a estrutura EXATA de SigPrSnd.
    *
    * TRANSCRITO do Init legado, que monta o cursor com uma chave SENTINELA
    * que nao casa com registro nenhum - ele nasce VAZIO DE PROPOSITO, e a
    * grade abre vazia esperando o usuario acionar btnSenPend ou
    * btnGerSen:
    *     pIds      = Replicate(Chr(254), 20)
    *     lcQrySend = [Select * From SigPrSnd Where cIdChaves = '] + pIds + [']
    *     .AddCursor('SigPrSnd','cIdChaves','crSigPrSnd','','',lcQrySend)
    *
    * READWRITE eh OBRIGATORIO: o Click de btnGerSen faz Zap/Insert Into/
    * Replace nesse cursor, e cursor devolvido por SQLEXEC nasce
    * SOMENTE-LEITURA. Por isso o SQLEXEC vai para um alias de ESTRUTURA e o
    * cursor final sai de um SELECT ... INTO CURSOR ... READWRITE.
    *
    * PUBLIC (sem PROTECTED): o Form chama este metodo de FORA da classe
    * (regra #51 - PROTECTED em qualquer nivel da heranca faz a chamada
    * externa estourar "Property CRIARCURSORSENHAS is not found").
    *==========================================================================
    PROCEDURE CriarCursorSenhas()
        LOCAL loc_cSQL, loc_nResultado, loc_cNull, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Derruba o cursor anterior (e as edicoes nao gravadas dele) para o
            *-- SELECT seguinte nao falhar com "uncommitted changes"
            IF USED("cursor_4c_Senhas")
                *-- TABLEREVERT SO com buffering ligado: medido no VFP9, cursor
                *-- de SELECT ... INTO CURSOR READWRITE tem Buffering = 1 (sem
                *-- buffer) e TABLEREVERT nele DISPARA ERRO - em tela headless
                *-- isso vira dialogo de Program Error que CONGELA o processo.
                IF CURSORGETPROP("Buffering", "cursor_4c_Senhas") > 1
                    TABLEREVERT(.T., "cursor_4c_Senhas")
                ENDIF
                USE IN cursor_4c_Senhas
            ENDIF
            IF USED("cursor_4c_SenhasEstrut")
                USE IN cursor_4c_SenhasEstrut
            ENDIF

            loc_nResultado = -1

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves = " + ;
                    EscaparSQL(REPLICATE(CHR(254), 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SenhasEstrut")
            ENDIF

            IF loc_nResultado >= 0 AND USED("cursor_4c_SenhasEstrut")
                *-- Estrutura vinda do proprio banco (PILAR 2: nenhuma coluna
                *-- inventada) e cursor final READWRITE
                SELECT * FROM cursor_4c_SenhasEstrut ;
                    INTO CURSOR cursor_4c_Senhas READWRITE
                USE IN cursor_4c_SenhasEstrut
            ELSE
                *-- Sem conexao (modo de teste/validacao de UI): estrutura
                *-- declarada na MESMA ORDEM de docs\schema.sql, para que o
                *-- APPEND FROM DBF() de CarregarSenhasPendentes case por nome
                loc_cNull = SET("NULL")
                SET NULL ON
                CREATE CURSOR cursor_4c_Senhas ( ;
                    datas      T        NULL, ;
                    docs       N(10, 0) NULL, ;
                    horas      C(8)     NULL, ;
                    motivos    C(40)    NULL, ;
                    operas     C(20)    NULL, ;
                    senhads    C(6)     NULL, ;
                    solicits   C(10)    NULL, ;
                    usuars     C(10)    NULL, ;
                    valors     N(11, 2) NULL, ;
                    cidchaves  C(20)    NULL, ;
                    tipos      N(1, 0)  NULL, ;
                    emps       C(3)     NULL, ;
                    fpags      C(12)    NULL, ;
                    empdopnums C(29)    NULL, ;
                    perlimite  N(5, 2)  NULL)
                IF loc_cNull = "OFF"
                    SET NULL OFF
                ENDIF
            ENDIF

            loc_lSucesso = USED("cursor_4c_Senhas")

        CATCH TO loc_oErro
            MostrarErro("Erro ao criar o cursor de senhas:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.CriarCursorSenhas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarSenhasPendentes - Consulta as senhas ainda NAO vinculadas a
    * documento algum e devolve o resultado em cursor_4c_SenhasTemp.
    *
    * TRANSCRITO do Click de btnSenPend:
    *     lcQuery = [Select * From SigPrSnd Where EmpDopNums = '']
    *     ThisForm.poDataMgr.SqlExecute(lcQuery,'crSigPrSnd')
    *
    * O resultado vai para um cursor TEMPORARIO - NUNCA direto no alias da
    * grade: SQLEXEC sobre o alias ligado a um Grid FECHA e RECRIA o alias,
    * zerando RecordSource/ControlSource/ColumnCount (a grade vira um
    * retangulo branco pelo resto da vida do form). Quem recarrega o alias
    * da grade eh o Form, com ZAP + APPEND FROM DBF() (regra #21a / #35).
    *
    * PUBLIC (sem PROTECTED): chamado pelo Form (regra #51).
    *==========================================================================
    PROCEDURE CarregarSenhasPendentes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SenhasTemp")
                USE IN cursor_4c_SenhasTemp
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o " + ;
                    "Servidor de Banco de Dados."
            ELSE
                loc_cSQL = "SELECT * FROM SigPrSnd WHERE empdopnums = " + EscaparSQL("")

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SenhasTemp")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao consultar as senhas pendentes:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar as senhas pendentes:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.CarregarSenhasPendentes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * ContarSenhasIguais - quantas linhas de SigPrSnd ja usam esta senha.
    *
    * Equivalente do ChkRegister do fSqlConector legado, chamado dentro do laco
    * de geracao do Click de btnGerSen:
    *     If ThisForm.poDataMgr.ChkRegister('SigPrSnd','SenhaDs',_Inicio)
    *         _Inicio = 0
    *     Endif
    * ChkRegister NAO existe no BusinessBase - a forma canonica do projeto eh
    * SELECT COUNT(*) + NVL(...) > 0.
    *
    * Ret: >= 0 = quantidade encontrada; -1 = NAO FOI POSSIVEL CONSULTAR.
    * O -1 eh indispensavel: devolver 0 ("nao existe") numa consulta que falhou
    * faria o gerador aceitar uma senha possivelmente DUPLICADA, e devolver um
    * valor positivo faria o laco girar para sempre. Quem chama distingue os
    * tres casos.
    *
    * Preserva o alias corrente: o gerador roda com cursor_4c_SenhasTemp
    * selecionado e perder essa selecao embaralharia o laco de fora.
    *
    * PUBLIC (sem PROTECTED): chamado pelo Form/harness (regra #51).
    *==========================================================================
    PROCEDURE ContarSenhasIguais(par_cSenha)
        LOCAL loc_cSQL, loc_nResultado, loc_nTotal, loc_cAliasAnt, loc_oErro
        loc_nTotal    = -1
        loc_cAliasAnt = ALIAS()

        TRY
            DO CASE
                CASE VARTYPE(par_cSenha) != "C" OR EMPTY(ALLTRIM(par_cSenha))
                    THIS.this_cMensagemErro = "Senha inv" + CHR(225) + "lida para confer" + ;
                        CHR(234) + "ncia de duplicidade."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o Servidor " + ;
                        "de Banco de Dados."

                OTHERWISE
                    IF USED("cursor_4c_ChkSenha")
                        USE IN cursor_4c_ChkSenha
                    ENDIF

                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrSnd WHERE senhads = " + ;
                        EscaparSQL(par_cSenha)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkSenha")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_ChkSenha")
                        SELECT cursor_4c_ChkSenha
                        GO TOP
                        IF EOF("cursor_4c_ChkSenha")
                            loc_nTotal = 0
                        ELSE
                            loc_nTotal = NVL(cursor_4c_ChkSenha.nExiste, 0)
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = CapturarErroSQL()
                    ENDIF

                    IF USED("cursor_4c_ChkSenha")
                        USE IN cursor_4c_ChkSenha
                    ENDIF
            ENDCASE
        CATCH TO loc_oErro
            MostrarErro("Erro ao conferir a senha gerada:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.ContarSenhasIguais")
            loc_nTotal = -1
        ENDTRY

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * GerarSenhaUnica - devolve UMA senha de 6 digitos que ainda nao existe,
    * nem em SigPrSnd nem no lote que esta sendo montado. "" = falhou.
    *
    * TRANSCRICAO do laco do Click de btnGerSen:
    *     _Inicio = 0
    *     Do While _Inicio = 0
    *         _Inicio = fKeyGen()
    *         If ThisForm.poDataMgr.ChkRegister('SigPrSnd','SenhaDs',_Inicio)
    *             _Inicio =  0
    *         Endif
    *     Enddo
    *     lcSenha = Str(_Inicio,6)
    *
    * fKeyGen() NAO FOI PORTADA e o fonte dela nao existe no acervo (so as
    * chamadas, em 3 SCX). Chamar o nome nu seria o defeito da regra #13 (VFP9
    * procuraria fkeygen.prg em disco e estouraria em RUNTIME, ao clicar o
    * botao). NAO cabe wrapper em utils\ como na regra #27: aquilo existe para
    * p-code COMPILADO de VCX, que nao da para editar - aqui o unico chamador
    * eh este .prg, entao a geracao mora no BO, que eh a camada certa.
    *
    * O CONTRATO de fKeyGen esta determinado pelo proprio call site: o legado
    * NAO confia no valor devolvido (confere duplicidade a cada volta e repete),
    * ou seja a funcao eh um gerador de CANDIDATO, nao de chave unica - um
    * contador sequencial (fGerUniqueKey) nao precisaria do laco. Por isso aqui
    * eh sorteio + a MESMA conferencia do legado.
    *
    * FAIXA 100000..999999 - decisao DELIBERADA, registrada porque eh o unico
    * ponto em que nao ha dump para transcrever: Str(n, 6) sobre a coluna
    * senhads char(6) so ocupa os 6 caracteres sem sobra de espaco quando n tem
    * 6 digitos. Com n menor, STR alinha a DIREITA e a senha gravada sairia com
    * espacos na frente ("   123"), que eh o que o usuario leria na grade e
    * levaria para a planilha do btnExcel.
    *
    * TETO DE TENTATIVAS - segundo desvio deliberado (ver a declaracao de
    * this_nMaxTentativasSenha, no topo da classe).
    *
    * Par: par_cCursorLote - alias (opcional) do lote em montagem. As senhas ja
    *      sorteadas nesta mesma rodada AINDA NAO ESTAO em SigPrSnd, entao a
    *      consulta do legado nao as veria e duas linhas do mesmo lote poderiam
    *      sair iguais.
    *
    * PUBLIC (sem PROTECTED): chamado pelo Form/harness (regra #51).
    *==========================================================================
    PROCEDURE GerarSenhaUnica(par_cCursorLote)
        LOCAL loc_cSenha, loc_nCandidato, loc_nTentativa, loc_nExiste
        LOCAL loc_lAchou, loc_lNoLote, loc_cAliasAnt, loc_oErro
        loc_cSenha    = ""
        loc_lAchou    = .F.
        loc_cAliasAnt = ALIAS()

        TRY
            IF !THIS.this_lRandSemeado
                *-- RAND(-1) semeia pelo relogio do sistema (uma vez por BO)
                = RAND(-1)
                THIS.this_lRandSemeado = .T.
            ENDIF

            loc_nTentativa = 0

            DO WHILE !loc_lAchou AND loc_nTentativa < THIS.this_nMaxTentativasSenha
                loc_nTentativa = loc_nTentativa + 1

                loc_nCandidato = INT(RAND() * 900000) + 100000
                loc_cSenha     = STR(loc_nCandidato, 6)

                *-- Duplicidade DENTRO do lote em montagem
                loc_lNoLote = .F.
                IF VARTYPE(par_cCursorLote) = "C" AND !EMPTY(par_cCursorLote)
                    IF USED(par_cCursorLote)
                        SELECT (par_cCursorLote)
                        LOCATE FOR ALLTRIM(senhads) == ALLTRIM(loc_cSenha)
                        loc_lNoLote = FOUND()
                    ENDIF
                ENDIF

                IF loc_lNoLote
                    loc_cSenha = ""
                ELSE
                    *-- Duplicidade em SigPrSnd (o ChkRegister do legado)
                    loc_nExiste = THIS.ContarSenhasIguais(loc_cSenha)

                    DO CASE
                        CASE loc_nExiste < 0
                            *-- Consulta falhou: abortar em vez de girar o laco
                            *-- ou aceitar senha possivelmente duplicada
                            loc_cSenha     = ""
                            loc_nTentativa = THIS.this_nMaxTentativasSenha
                        CASE loc_nExiste = 0
                            loc_lAchou = .T.
                        OTHERWISE
                            loc_cSenha = ""
                    ENDCASE
                ENDIF
            ENDDO

            IF !loc_lAchou
                loc_cSenha = ""
                IF EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel obter uma senha livre dispon" + CHR(237) + "vel ap" + CHR(243) + "s " + ;
                        ALLTRIM(STR(THIS.this_nMaxTentativasSenha)) + " tentativas."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao gerar a senha:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.GerarSenhaUnica")
            loc_cSenha = ""
        ENDTRY

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_cSenha
    ENDPROC

    *==========================================================================
    * GerarSenhasLivres - gera par_nQtd senhas livres e as grava em SigPrSnd.
    *
    * TRANSCRICAO do corpo do Click de btnGerSen (depois do guard de campo
    * obrigatorio e da confirmacao, que moram no Form):
    *     Select crSigPrSnd / Zap
    *     ldData = Datetime()
    *     For n = 1 to lnQtd
    *         Insert Into crSigPrSnd (Usuars, Datas, Tipos) Values (Usuar, ldData, 0)
    *         <gera senha unica>
    *         Replace Senhads With lcSenha, Horas With Time(), cIdChaves With fUniqueIds()
    *     Next
    *     llOk = ThisForm.poDataMgr.Update('crSigPrSnd')
    *     If llOk / Commit() / Else / RollBack() / Endif
    *
    * O que foi transcrito LITERALMENTE, e eh facil perder:
    *   - ldData FORA do laco: as N senhas compartilham o MESMO datetime, e
    *     Time() eh por linha. Nao sao a mesma informacao.
    *   - Tipos = 0 LITERAL (senha livre), nao this_nTipos.
    *   - Usuars = o usuario logado (o PUBLIC `Usuar` do legado, que nesta
    *     arquitetura eh gc_4c_UsuarioLogado - PILAR 3).
    *   - As demais colunas vao em BRANCO/ZERO, como no legado: la o Insert Into
    *     lista so 3 colunas e o resto vem do registro em branco do AddCursor.
    *     Em especial empdopnums fica VAZIA de proposito - eh exatamente o que
    *     o Click de btnSenPend consulta para achar as senhas ainda livres, e
    *     preencher emps aqui tiraria a senha dessa lista.
    *   - Todas as 15 colunas aparecem no INSERT: 14 delas sao NOT NULL sem
    *     DEFAULT no schema e omitir qualquer uma faz o SQL Server recusar o
    *     INSERT inteiro (regra #22).
    *
    * ATOMICIDADE - o legado eh tudo-ou-nada (um TABLEUPDATE do cursor inteiro
    * + Commit/RollBack). Um par BEGIN/COMMIT em SQLEXECs separados NAO
    * reproduz isso: a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale
    * 1, entao o BEGIN so aninha o contador e o ROLLBACK depois nao desfaz
    * nada. Por isso os N INSERT vao num SQLEXEC UNICO, com SAVE TRANSACTION/
    * TRY/CATCH/THROW em T-SQL - mesmo padrao de SIGOPCCOBO.ConfirmarCorrecao
    * e ProdutoBO.CopiarProduto.
    *
    * COMMIT - como @@TRANCOUNT ja eh 1, o lote usa SAVE TRANSACTION e NAO
    * comita: quem efetiva eh o SQLCOMMIT, que eh o Commit() do legado. IF
    * ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o SQLCOMMIT de qualquer forma.
    *
    * SAIDA: as senhas gravadas ficam em cursor_4c_SenhasTemp, que eh o cursor
    * que o Form usa para repintar a grade (ZAP + APPEND FROM DBF). Se a
    * gravacao FALHAR o cursor eh DERRUBADO, para a tela nao exibir senha que
    * nao foi gravada.
    *
    * PUBLIC (sem PROTECTED): chamado pelo Form/harness (regra #51).
    *==========================================================================
    PROCEDURE GerarSenhasLivres(par_nQtd)
        LOCAL loc_nQtd, loc_nI, loc_cSenha, loc_cChave, loc_cHora, loc_cUsuario
        LOCAL loc_tData, loc_cInserts, loc_cLote, loc_cCRLF, loc_nResultado
        LOCAL loc_lSucesso, loc_lManual, loc_lLoteCompleto, loc_cNull, loc_oErro

        loc_lSucesso            = .F.
        loc_lLoteCompleto       = .F.
        loc_lManual             = .F.
        loc_cInserts            = ""
        loc_cCRLF               = CHR(13) + CHR(10)
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            loc_nQtd = IIF(VARTYPE(par_nQtd) = "N", INT(par_nQtd), 0)

            DO CASE
                CASE loc_nQtd <= 0
                    THIS.this_cMensagemErro = "Qtde de senhas obrigat" + CHR(243) + "rio."
                    THIS.ExibirFalha("Gerar Senha")

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o Servidor " + ;
                        "de Banco de Dados."
                    THIS.ExibirFalha("Gerar Senha")

                OTHERWISE
                    loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

                    *-- Lote em montagem. Mesma lista e mesma ORDEM de colunas
                    *-- de CriarCursorSenhas (que eh a ordem do schema), porque
                    *-- o APPEND FROM DBF() do Form casa por NOME.
                    IF USED("cursor_4c_SenhasTemp")
                        USE IN cursor_4c_SenhasTemp
                    ENDIF

                    loc_cNull = SET("NULL")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_SenhasTemp ( ;
                        datas      T        NULL, ;
                        docs       N(10, 0) NULL, ;
                        horas      C(8)     NULL, ;
                        motivos    C(40)    NULL, ;
                        operas     C(20)    NULL, ;
                        senhads    C(6)     NULL, ;
                        solicits   C(10)    NULL, ;
                        usuars     C(10)    NULL, ;
                        valors     N(11, 2) NULL, ;
                        cidchaves  C(20)    NULL, ;
                        tipos      N(1, 0)  NULL, ;
                        emps       C(3)     NULL, ;
                        fpags      C(12)    NULL, ;
                        empdopnums C(29)    NULL, ;
                        perlimite  N(5, 2)  NULL)
                    IF loc_cNull = "OFF"
                        SET NULL OFF
                    ENDIF

                    *-- "Usuar" do legado; char(10) no schema
                    loc_cUsuario = LEFT(ALLTRIM(IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                        gc_4c_UsuarioLogado, "")), 10)

                    *-- ldData = Datetime() UMA vez, FORA do laco (fiel)
                    loc_tData = DATETIME()

                    loc_lLoteCompleto = .T.

                    FOR loc_nI = 1 TO loc_nQtd
                        loc_cSenha = THIS.GerarSenhaUnica("cursor_4c_SenhasTemp")

                        IF EMPTY(loc_cSenha)
                            loc_lLoteCompleto = .F.
                            EXIT
                        ENDIF

                        loc_cChave = fUniqueIds()
                        loc_cHora  = LEFT(TIME(), 8)

                        INSERT INTO cursor_4c_SenhasTemp ( ;
                                datas, docs, horas, motivos, operas, senhads, solicits, ;
                                usuars, valors, cidchaves, tipos, emps, fpags, ;
                                empdopnums, perlimite) ;
                            VALUES ( ;
                                loc_tData, 0, loc_cHora, "", "", loc_cSenha, "", ;
                                loc_cUsuario, 0, loc_cChave, 0, "", "", ;
                                "", 0)

                        loc_cInserts = loc_cInserts + ;
                            "INSERT INTO SigPrSnd (cidchaves, datas, docs, horas, motivos, " + ;
                            "operas, senhads, solicits, usuars, valors, tipos, emps, fpags, " + ;
                            "empdopnums, perlimite) VALUES (" + ;
                            EscaparSQL(loc_cChave) + ", " + ;
                            FormatarDataSQL(loc_tData) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + ;
                            EscaparSQL(loc_cHora) + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL(loc_cSenha) + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL(loc_cUsuario) + ", " + ;
                            FormatarNumeroSQL(0, 2) + ", " + ;
                            FormatarNumeroSQL(0, 0) + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL("") + ", " + ;
                            FormatarNumeroSQL(0, 2) + ");" + loc_cCRLF
                    ENDFOR

                    IF loc_lLoteCompleto AND !EMPTY(loc_cInserts)
                        loc_cLote = "SET NOCOUNT ON;" + loc_cCRLF + ;
                            "DECLARE @nivel int = @@TRANCOUNT;" + loc_cCRLF + ;
                            "IF @nivel = 0 BEGIN TRANSACTION" + loc_cCRLF + ;
                            "ELSE SAVE TRANSACTION Snd4c;" + loc_cCRLF + ;
                            "BEGIN TRY" + loc_cCRLF + ;
                            loc_cInserts + ;
                            "IF @nivel = 0 COMMIT TRANSACTION;" + loc_cCRLF + ;
                            "END TRY" + loc_cCRLF + ;
                            "BEGIN CATCH" + loc_cCRLF + ;
                            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + loc_cCRLF + ;
                            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Snd4c; END;" + loc_cCRLF + ;
                            "THROW;" + loc_cCRLF + ;
                            "END CATCH"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

                        IF loc_nResultado >= 0
                            loc_lSucesso = .T.
                        ELSE
                            THIS.this_cMensagemErro = CapturarErroSQL()
                        ENDIF

                        *-- LogAuditoria das linhas gravadas, ANTES do commit,
                        *-- para o registro de auditoria ser efetivado junto
                        IF loc_lSucesso
                            SELECT cursor_4c_SenhasTemp
                            GO TOP
                            SCAN
                                THIS.this_cCidchaves = ALLTRIM(NVL(cursor_4c_SenhasTemp.cidchaves, ""))
                                THIS.RegistrarAuditoria("INSERT")
                                SELECT cursor_4c_SenhasTemp
                            ENDSCAN
                        ENDIF

                        *-- Commit()/RollBack() do legado. IF ANINHADO de
                        *-- proposito: VFP9 nao faz curto-circuito em AND.
                        IF loc_lManual
                            IF loc_lSucesso
                                = SQLCOMMIT(gnConnHandle)
                            ELSE
                                = SQLROLLBACK(gnConnHandle)
                            ENDIF
                        ENDIF

                        IF !loc_lSucesso
                            *-- Nada foi gravado: derrubar o lote para a tela
                            *-- nao exibir senha inexistente no banco
                            IF USED("cursor_4c_SenhasTemp")
                                USE IN cursor_4c_SenhasTemp
                            ENDIF
                            THIS.ExibirFalha("Gerar Senha")
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_SenhasTemp")
                            USE IN cursor_4c_SenhasTemp
                        ENDIF
                        IF EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
                            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                "vel gerar as " + ALLTRIM(STR(loc_nQtd)) + " senhas livres."
                        ENDIF
                        THIS.ExibirFalha("Gerar Senha")
                    ENDIF
            ENDCASE
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            IF USED("cursor_4c_SenhasTemp")
                USE IN cursor_4c_SenhasTemp
            ENDIF
            MostrarErro("Erro ao gerar as senhas livres:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigPrSndBO.GerarSenhasLivres")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


ENDDEFINE

