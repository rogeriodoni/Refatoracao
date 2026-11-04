# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABINDEX' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LCCHAVE

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
Select CrSigMvCcr

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCrp.prg) - PRIMEIRAS 962 de 962 linhas:
*==============================================================================
* FormSigOpCrp.prg
*
* Dialogo de Procura de Lancamento - Extrato de Conta Corrente Individual
* Legado: SigOpCrp.SCX (task714)
*
* FASE 4/8 - Campos de pesquisa (txt_4c_Lancamento/Valor/Historico + labels) e
* obj_4c_Commandgroup1 (Procurar/Encerrar), com os eventos GotFocus/LostFocus/
* Click que fecham o ciclo de BuscarRegistro() do SigOpCrpBO.
*
* FASE 5/8 - Sem campo NOVO: o legado tem 3 campos e os 3 ja entregues na
* Fase 4 (este dialogo nao tem Page2 - a superficie de campos e' unica).
* O trabalho da fase foi reconciliar os 3 campos com os defaults da CLASSE do
* framework (fweditdata/fwget) que o SCX nao sobrescreve e o migrador havia
* descartado: Format "K", Themes = .F., FontName/FontSize e o Height de
* txt_4c_Lancamento. Detalhamento e' evidencia no cabecalho de
* ConfigurarControlesPesquisa().
*
* FASE 6/8 - "Campos restantes e lookups". Os dois itens do titulo da fase
* ficam resolvidos POR AUSENCIA neste form; o terceiro e' o que ela entrega:
*
*   1) Campos restantes: NAO HA. O legado tem exatamente 3 campos
*      (getLancamento / getValor / getHistorico) e os 3 ja estao criados desde
*      a Fase 4 - este dialogo nao tem Page2, a superficie de campos e' unica.
*      Acrescentar um 4o campo seria inventar UI que o legado nao tem.
*
*   2) Lookups: NAO HA NENHUM NO LEGADO - e por isso nenhum foi criado.
*      Medido no dump (tasks\task714\SigOpCrp_form_codigo_fonte.txt): zero
*      ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt, de mAddColuna, de
*      sigacess( e das funcoes Acesso*( ; e zero PROCEDURE KeyPress, zero
*      F4/F5. Os tres Valid do legado NAO sao lookup: nenhum deles consulta
*      tabela - cada um so zera os OUTROS dois criterios de pesquisa (e o
*      Continuar), que e' validacao de exclusao mutua. Inventar
*      FormBuscaAuxiliar aqui violaria o PILAR 1 e a regra explicita "NUNCA
*      inventar tabelas de lookup que nao existem no original"; e metodo
*      AbrirLookup* vazio e' proibido pela regra de completude.
*
*   3) O que a fase DE FATO entrega: o Valid dos 3 campos digitaveis, agora
*      com o nome canonico Validar<Campo> (antes Txt<Campo>LostFocus, que e'
*      a assinatura de defeito da regra #47) - ver o cabecalho do bloco
*      ValidarLancamento / ValidarValor / ValidarHistorico.
*
*   Tambem NAO ha container cnt_4c_BotoesAcao (Salvar/Cancelar): isto nao e'
*   um CRUD. O legado tem UM CommandGroup de 2 botoes - Procurar e Encerrar -
*   ja entregue na Fase 4, e nao grava nada (so faz LOCATE/CONTINUE no cursor
*   do form pai).
*
* FASE 7/8 - "Eventos principais dos botoes" (BtnIncluirClick/BtnAlterarClick/
* BtnVisualizarClick/BtnExcluirClick). O template generico pressupoe a barra
* CRUD do frmcadastro (Incluir/Alterar/Visualizar/Excluir/Buscar), que este
* dialogo NAO TEM - medido no dump (SigOpCrp_form_codigo_fonte.txt): o UNICO
* agrupador de botoes e' Commandgroup1, ButtonCount=2, com os metodos
* btnOK.Click (buscar/continuar no cursor do pai) e btnSair.Click
* (ThisForm.Release); zero ocorrencia de Incluir/Alterar/Visualizar/Excluir em
* qualquer metodo deste dump. Criar os 4 handlers do template seria inventar
* funcionalidade que o legado nunca teve - exatamente a violacao que a regra
* "NUNCA inventar" e o PILAR 1 proibem (mesma familia de falso-positivo do
* precedente task699/SIGOPCHP: dialogo filho, OPERACIONAL, sem barra CRUD).
*
* Os "eventos principais dos botoes" DESTE form sao BtnProcurarClick e
* BtnEncerrarClick - a totalidade dos Click do Commandgroup1 legado - e os
* dois ja estao implementados abaixo desde a Fase 4 (criacao do
* CommandGroup, BINDEVENT e corpo completo). Nao ha codigo novo para esta
* fase.
*
* NOTA SOBRE O TEMPLATE GENERICO DE FASE 4 ("Grid + 6 botoes CRUD em Page1"):
* NAO SE APLICA a este form. O dump (SigOpCrp_form_codigo_fonte.txt) e o
* layout.json/analise.json de task714 confirmam: BorderStyle=2/TitleBar=0/
* WindowType=1 (dialogo modal), SEM PageFrame (nenhuma Page1/Page2), SEM Grid,
* SEM AddCursor/pColuna - "temGrid": false em analise.json. O legado tem
* exatamente 3 campos de pesquisa e 1 CommandGroup de 2 botoes (Procurar /
* Encerrar), todos direto no Form. Inventar Grid+6 botoes CRUD violaria o
* PILAR 1 (UI que o legado nao tem) e a regra "NUNCA inventar" - mesma familia
* de falso-positivo documentada para forms DESPACHANTE/CAPTURA sem superficie
* de lista (precedente: task699/SIGOPCHP, perfil CAPTURA). Como os campos e os
* botoes sao a UNICA superficie real deste dialogo (nao ha Page separada para
* "grid" versus "campos"), a Fase 4 entrega aqui o conteudo completo: campos +
* botoes + eventos - nao apenas os botoes isolados.
*
*------------------------------------------------------------------------------
* NAO E UM CRUD - e um dialogo FILHO, modal, sem barra de titulo, aberto pelo
* extrato de Conta Corrente Individual (Formsigopind) no clique do botao
* "Procura":
*
*     DO FORM SigOpCrp WITH THIS.DataSessionId, THIS
*
* Por isso este form:
*   - NAO tem PageFrame Page1=Lista/Page2=Dados (layout FLAT, 520x200, igual
*     ao SCX legado);
*   - recebe DOIS parametros no Init - o DataSessionId do form pai (legado:
*     "Arquivos") e o OBJETO do form pai (legado: "pFormPai") - guardados em
*     this_nDataSessionPai/this_oFormPai porque o BO usa o primeiro para
*     SET DATASESSION TO antes de tocar no cursor CrSigMvCcr do pai (ver
*     SigOpCrpBO.prg), e o Form usa o segundo so para se posicionar do lado
*     do pai (legado: ThisForm.Top/Left a partir de ThisForm.FormPai).
*
* O cabecalho (cntSombra/lblSombra/lblTitulo do legado) e o MESMO componente
* visual usado nos cadastros CRUD (framework.vcx), so que aqui aparece direto
* no Form (sem Page), porque este dialogo nao tem PageFrame. Nomes dos objetos
* fixados em tasks\task714\mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
* lbl_4c_LblTitulo.
*
*==============================================================================
* FASE 8/8 - CONSOLIDACAO FINAL
*==============================================================================
* A fase entrega os TRES hooks canonicos que esta tela de fato tem, extraindo
* para metodo proprio o codigo que ja existia ESPALHADO nos handlers - isto eh
* PILAR 3 (fonte unica), nao UI nova:
*
*   FormParaBO()   - os 3 campos -> as 3 properties de criterio do BO. O corpo
*                    estava inline no BtnProcurarClick; agora o Click chama o
*                    hook, que eh o UNICO lugar que le os TextBox de criterio.
*   BOParaForm()   - as 3 properties de criterio do BO -> os 3 campos. O corpo
*                    estava TRIPLICADO (uma copia em cada Validar<Campo>, cada
*                    uma espelhando so os DOIS campos irmaos); agora as tres
*                    chamam o mesmo hook, que espelha os tres. Espelhar o
*                    proprio campo de volta eh inocuo e necessario: o
*                    ValidarCriterio* do BO nunca altera o criterio que ACABOU
*                    de mudar, so zera os outros dois.
*   LimparCampos() - os defaults do Init legado (Ctod('  /  /  ') / 0.00 / '')
*                    num funil unico: zera as properties do BO e refaz a tela
*                    pelo BOParaForm. O Init legado faz exatamente isso, campo
*                    a campo; aqui o estado tem UMA fonte (o BO).
*
* Com os hooks no lugar, os valores iniciais que os WITH de AddObject atribuem
* deixam de ser a fonte do estado e passam a ter uma funcao so: FIXAR O TIPO de
* .Value (Date / Numeric / Character) no instante da criacao - TextBox assume o
* tipo do que lhe for atribuido primeiro, e sem isso o {} / 0.00 / "" do
* BOParaForm seria a primeira atribuicao e o tipo passaria a depender da ordem
* de chamada. Por isso eles FICAM.
*
*------------------------------------------------------------------------------
* O QUE O TEMPLATE DA FASE PEDE E NAO TEM REFERENTE NESTE LEGADO
*------------------------------------------------------------------------------
* O template generico da Fase 8 lista metodos do form CRUD (frmcadastro). Os
* que faltam aqui faltam porque a SUPERFICIE deles nao existe no SCX - criar
* qualquer um seria inventar UI (viola o PILAR 1 e a regra "NUNCA inventar") ou
* escrever metodo vazio, que a regra de completude proibe:
*
*   BtnBuscarClick     -> o botao de busca DESTA tela se chama "Procurar" no
*                         SCX (Commandgroup1.btnOK), e o handler dele eh o
*                         BtnProcurarClick ja entregue. Um segundo handler com
*                         o nome canonico seria o MESMO botao duas vezes.
*   BtnSalvarClick     -> nao existe botao de gravar: medido no dump, os UNICOS
*                         Click sao btnOK.Click (Locate/Continue no cursor do
*                         PAI) e btnSair.Click ("Thisform.Release"). A tela nao
*                         escreve em tabela nenhuma.
*   BtnCancelarClick   -> "Cancelar" eh o botao que ABANDONA uma edicao na
*                         Page2 de Dados. Nao ha PageFrame, nem Page2, nem modo
*                         de edicao, nem registro em edicao. O 2o botao do SCX
*                         eh "Encerrar" (Cancel = .T., Click = Release) e o
*                         migrado o entrega com o nome do legado
*                         (BtnEncerrarClick). Renomea-lo para Cancelar faria o
*                         nome MENTIR sobre o que o metodo faz.
*   CarregarLista      -> nao ha grade NEM cursor de listagem neste form. A
*                         grade eh do form PAI (Formsigopind:
*                         pgf_4c_1.Page2.grd_4c_Lancamento) e quem a popula eh
*                         o pai; este dialogo so MOVE o ponteiro do cursor
*                         CrSigMvCcr do pai (Locate/Continue) e manda o pai
*                         repintar - exatamente o que o btnOK.Click legado faz.
*   HabilitarCampos    -> a tela nunca desabilita campo: zero Enabled = .F. e
*                         zero ReadOnly no SCX inteiro. Os 3 campos sao sempre
*                         digitaveis.
*   AjustarBotoesPorModo -> nao ha MODO. O SCX nao tem pcEscolha nem
*                         INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR; os 2 botoes estao
*                         sempre habilitados.
*
* O gate da Fase 8 reconhece esta forma de tela pelo ramo NAVEGADOR-DO-PAI
* (automation\OrquestradorMigracao.ps1, Test-LegadoNavegadorDoCursorDoPai), que
* dispensa BtnCancelarClick/CarregarLista exigindo em troca exatamente o que
* esta entregue acima: o handler do botao de acao do legado MAIS os dois hooks
* FormParaBO/BOParaForm.
*==============================================================================

DEFINE CLASS FormSigOpCrp AS FormBase

    *--------------------------------------------------------------------------
    * Layout (pixel-perfect do legado - SIGOPCRP.SCX)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 520
    Height       = 200
    AutoCenter   = .F.
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    WindowState  = 0
    AlwaysOnTop  = .T.
    ShowWindow   = 1
    Caption      = "Procura"

    *--------------------------------------------------------------------------
    * Propriedades customizadas
    *
    * this_oFormPai        - legado: ThisForm.FormPai. Objeto do extrato de
    *                        Conta Corrente (Formsigopind) que abriu este
    *                        dialogo. Usado so para posicionamento (Top/Left)
    *                        nesta fase; nas fases de evento (7/8) tambem
    *                        recebe o Refresh/SetFocus da grade do pai.
    *
    * this_nDataSessionPai - legado: parametro "Arquivos" do Init, o mesmo
    *                        DataSessionId repassado ao BO (SigOpCrpBO usa
    *                        para SET DATASESSION TO antes de ler CrSigMvCcr).
    *--------------------------------------------------------------------------
    this_oFormPai         = .NULL.
    this_nDataSessionPai  = 0

    *==========================================================================
    * Init - recebe os dois parametros do "DO FORM SigOpCrp WITH ..." legado
    *
    * Guardar os dois ANTES de DODEFAULT(): FormBase.Init() chama
    * ja preenchidos (um para instanciar o BO, outro para posicionar o form).
    *==========================================================================
    PROCEDURE Init(par_nDataSessionPai, par_oFormPai)
        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            THIS.this_nDataSessionPai = par_nDataSessionPai
        ENDIF

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Hook de FormBase.Init(). Cria o BO, posiciona o
    * dialogo ao lado do form pai e monta o cabecalho.
    *
    * O BO (SigOpCrpBO) nao faz nenhum acesso a servidor no proprio Init (ver
    * nota de arquitetura no cabecalho de SigOpCrpBO.prg) - por isso a
    * instanciacao roda sempre, inclusive em gb_4c_ValidandoUI, sem o guard
    * que outros forms usam para pular CarregarLista().
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCrpBO", THIS.this_nDataSessionPai)
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio SigOpCrpBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- FASE 8: o resto so corre com o BO VIVO. Antes, a falha do
            *-- CREATEOBJECT apenas marcava o flag e a execucao seguia; agora
            *-- LimparCampos/BOParaForm tocam o BO, e sem este IF o usuario
            *-- levaria DOIS dialogos de erro - o real e um "Property is not
            *-- found" derivado dele, que esconde a causa.
            IF loc_lSucesso
                THIS.PosicionarJuntoAoFormPai()

                THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

                THIS.ConfigurarCabecalho()

                THIS.ConfigurarControlesPesquisa()

                *-- Os defaults do Init legado (Ctod('  /  /  ') / 0.00 / '')
                *-- passam pelo funil unico, para tela e BO nascerem com o
                *-- MESMO estado. Os valores dos WITH de AddObject ficam porque
                *-- sao o que FIXA o TIPO de cada .Value (ver cabecalho).
                THIS.LimparCampos()

                THIS.TornarControlesVisiveis(THIS)
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PosicionarJuntoAoFormPai - Transcricao do bloco de posicionamento do
    * Init legado:
    *
    *     ThisForm.Top  = ThisForm.FormPai.Top
    *     ThisForm.Left = (ThisForm.FormPai.Left + ThisForm.FormPai.Width) - ThisForm.Width
    *
    * isto eh, o dialogo nasce encostado na borda DIREITA do form pai, na
    * mesma altura do topo dele. Sem this_oFormPai (form aberto fora do fluxo
    * do extrato, ex.: teste isolado), AutoCenter continua .F. e o form fica
    * na posicao default do VFP9 - nao ha pai para copiar Top/Left.
    *==========================================================================
    PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.Top  = THIS.this_oFormPai.Top
            THIS.Left = (THIS.this_oFormPai.Left + THIS.this_oFormPai.Width) - THIS.Width
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cnt_4c_Sombra + lbl_4c_LblSombra + lbl_4c_LblTitulo
    *
    * Mesmo componente visual do cabecalho canonico dos cadastros CRUD
    * (framework.vcx: cntSombra/lblSombra/lblTitulo), so que direto no Form -
    * este dialogo nao tem PageFrame/Page para hospeda-lo. Nomes fixados em
    * tasks\task714\mapeamento.json (cnt_4c_Sombra, nao cnt_4c_Cabecalho).
    *
    * Width da faixa e dos dois labels usa THIS.Width (520) em vez do 800/769
    * literal do dump: aqueles numeros sao o default da CLASSE do framework
    * (dimensionada para o form 800px dos cadastros) e nunca foram
    * sobrescritos neste SCX de 520px - copiar ao pe da letra faria a faixa
    * estourar a borda do dialogo. Top/Left/Height/FontName/FontSize/
    * ForeColor sao TODOS transcritos do dump (regra #23: nada inventado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top          = 18
            .Left         = 10
            .Width        = THIS.Width - 31
            .Height       = 40
            .FontName     = "Tahoma"
            .FontSize     = 18
            .FontBold     = .T.
            .FontUnderline = .F.
            .WordWrap     = .T.
            .Alignment    = 0
            .BackStyle    = 0
            .ForeColor    = RGB(0, 0, 0)
            .Caption      = THIS.Caption
            .Visible      = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 31
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
    * ConfigurarControlesPesquisa - os 3 campos de pesquisa (+ labels) e o
    * CommandGroup Procurar/Encerrar. Transcricao pixel-perfect do dump
    * (SigOpCrp_form_codigo_fonte.txt, SECAO 2) - nomes conforme
    * tasks\task714\mapeamento.json.
    *
    * Os 3 TextBox nascem com o mesmo default do Init legado (Ctod('  /  /  '),
    * 0.00, '') - aqui replicado via {} / 0.00 / "", pois este metodo roda
    * ANTES de qualquer busca.
    *
    * ForeColor nao declarado nos 3 Say = RGB(90,90,90), o canonico de label
    * de dados fora do cabecalho (regra #12) - o Form.Picture (textura clara)
    * tornaria um ForeColor branco invisivel.
    *
    *--------------------------------------------------------------------------
    * FASE 5/8 - A BASE DE UM CAMPO SAO DUAS FONTES: O DUMP *E* A CLASSE
    *--------------------------------------------------------------------------
    * Esta fase pede "metade dos campos da Page2". Este dialogo nao tem Page2
    * (nem PageFrame) e tem EXATAMENTE 3 campos, todos entregues na Fase 4 -
    * nao ha campo NOVO a acrescentar, e inventar um quarto violaria o PILAR 1
    * e a regra "NUNCA inventar". O trabalho desta fase foi, portanto,
    * RECONCILIAR esses 3 campos com a sua base real.
    *
    * O que se achou: o migrador transcreveu so os OVERRIDES do SCX e
    * descartou os defaults da CLASSE do framework que o SCX nao sobrescreve.
    * Medido em Framework\framework.vcx (docs\FRAMEWORK_class_codigo_fonte.txt,
    * blocos "PROPRIEDADES DE: fweditdata" e "PROPRIEDADES DE: fwget"):
    *
    *   fweditdata (getLancamento) : FontName "Tahoma" / FontSize 8 /
    *                                Alignment 3 / Height 23 / Width 80 /
    *                                Themes .F.          -- SEM Format
    *   fwget (getValor/Historico) : FontName "Tahoma" / FontSize 8 /
    *                                Format "K" / Height 23 / Width 100 /
    *                                Themes .F.
    *
    * Dai as 4 correcoes aplicadas abaixo (nenhuma eh invencao - todas tem
    * referente no dump ou na classe):
    *
    *  1) Format = "K" em txt_4c_Valor e txt_4c_Historico. O dump nao declara
    *     Format nesses dois, mas a classe fwget declara - e override vazio
    *     nao existe aqui (regra #49 proibe transcrever Format = "", nao
    *     proibe transcrever o default da classe). "K" sozinho seleciona o
    *     conteudo ao entrar no campo (severidade BAIXA/UX da regra #49);
    *     sem ele o usuario tem de apagar o valor anterior a mao.
    *     txt_4c_Lancamento NAO leva Format: fweditdata nao tem.
    *
    *  2) Themes = .F. nos 3. Sem isso as DUAS propriedades que o migrador
    *     corretamente transcreveu do dump - SpecialEffect = 1 e
    *     BorderColor = RGB(100,100,100) - ficam inertes, porque com Themes
    *     no default (.T.) a borda do TextBox e' desenhada pelo tema do
    *     Windows. A classe do framework pina Themes = .F. exatamente para
    *     que elas valham. Mesma familia do
    *     [[feedback_standalone_commandbutton_themes]].
    *
    *  3) FontName "Tahoma" / FontSize 8 nos 3. A classe pina os dois; o
    *     TextBox criado por AddObject nao herda a fonte do Form. Sem isso os
    *     campos saem numa fonte diferente das labels irmas, que JA estao em
    *     Tahoma 8. Pratica canonica: FormCor.txt_4c_Codigo.
    *
    *  4) txt_4c_Lancamento.Height: 23, nao 21. O dump de getLancamento NAO
    *     declara Height (declara so Left/Top/SpecialEffect/TabIndex/
    *     ForeColor/BorderColor), logo vale o 23 da classe fweditdata - o
    *     mesmo dos outros dois campos da linha. O 21 anterior nao tinha
    *     referente nem no dump nem na classe.
    *
    * Alignment: a classe fweditdata declara 3, que e' tambem o default REAL
    * do TextBox criado por AddObject (medido - ver
    * [[feedback_textbox_alignment_default_e_3_nao_0]]); fica EXPLICITO para o
    * ValidarUIFidelity comparar sem depender do default.
    *
    * O que deliberadamente NAO entrou, para nao inventar:
    *   - InputMask: nem o dump nem fweditdata/fwget declaram (regra #49);
    *   - MaxLength: idem. Hists e' C(60), mas estes campos sao CRITERIO DE
    *     BUSCA (nada aqui e' gravado), entao a regra #19 nao se aplica -
    *     limitar a digitacao seria restricao que o legado nao tem;
    *   - DisabledBackColor/DisabledForeColor da fwget: inalcancaveis, este
    *     dialogo nunca desabilita campo (nao ha Enabled = .F. em lugar
    *     nenhum do SCX nem do migrado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesPesquisa()
        *----------------------------------------------------------------------
        * lbl_4c_Label1 "Data :" + txt_4c_Lancamento
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Left      = 120
            .Top       = 116
            .Width     = 150
            .Height    = 18
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Data :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Lancamento", "TextBox")
        WITH THIS.txt_4c_Lancamento
            .Left          = 154          && dump getLancamento.Left
            .Top           = 113          && dump getLancamento.Top
            .Width         = 80           && classe fweditdata (dump nao declara)
            .Height        = 23           && classe fweditdata (dump nao declara)
            .FontName      = "Tahoma"     && classe fweditdata
            .FontSize      = 8            && classe fweditdata
            .Alignment     = 3            && classe fweditdata
            .Themes        = .F.          && classe fweditdata - sem isto SpecialEffect/BorderColor sao inertes
            .SpecialEffect = 1            && dump getLancamento.SpecialEffect
            .ForeColor     = RGB(0, 0, 0) && dump getLancamento.ForeColor
            .BorderColor   = RGB(100, 100, 100)   && dump getLancamento.BorderColor
            .Value         = {}           && legado Init: Ctod('  /  /  ')
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Lancamento, "GotFocus", THIS, "TxtLancamentoGotFocus")
        BINDEVENT(THIS.txt_4c_Lancamento, "LostFocus", THIS, "ValidarLancamento")

        *----------------------------------------------------------------------
        * lbl_4c_Label2 "Valor :" + txt_4c_Valor
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Left      = 303
            .Top       = 116
            .Width     = 150
            .Height    = 18
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.txt_4c_Valor
            .Left          = 338          && dump getValor.Left
            .Top           = 113          && dump getValor.Top
            .Width         = 80           && dump getValor.Width
            .Height        = 23           && dump getValor.Height (= classe fwget)
            .FontName      = "Tahoma"     && classe fwget
            .FontSize      = 8            && classe fwget
            .Format        = "K"          && classe fwget - seleciona o conteudo ao entrar
            .Themes        = .F.          && classe fwget - sem isto SpecialEffect/BorderColor sao inertes
            .SpecialEffect = 1            && dump getValor.SpecialEffect
            .ForeColor     = RGB(0, 0, 0) && dump getValor.ForeColor
            .BorderColor   = RGB(100, 100, 100)   && dump getValor.BorderColor
            .Value         = 0.00         && legado Init: getValor.Value = 0.00
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Valor, "GotFocus", THIS, "TxtValorGotFocus")
        BINDEVENT(THIS.txt_4c_Valor, "LostFocus", THIS, "ValidarValor")

        *----------------------------------------------------------------------
        * lbl_4c_Label3 "Historico :" + txt_4c_Historico
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Left      = 102
            .Top       = 140
            .Width     = 150
            .Height    = 18
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Hist" + CHR(243) + "rico :"
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Historico", "TextBox")
        WITH THIS.txt_4c_Historico
            .Left          = 154          && dump getHistorico.Left
            .Top           = 137          && dump getHistorico.Top
            .Width         = 264          && dump getHistorico.Width
            .Height        = 23           && classe fwget (dump nao declara)
            .FontName      = "Tahoma"     && classe fwget
            .FontSize      = 8            && classe fwget
            .Format        = "K"          && classe fwget - seleciona o conteudo ao entrar
            .Themes        = .F.          && classe fwget - sem isto SpecialEffect/BorderColor sao inertes
            .SpecialEffect = 1            && dump getHistorico.SpecialEffect
            .ForeColor     = RGB(0, 0, 0) && dump getHistorico.ForeColor
            .BorderColor   = RGB(100, 100, 100)   && dump getHistorico.BorderColor
            .Value         = ""           && legado Init: getHistorico.Value = ''
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Historico, "GotFocus", THIS, "TxtHistoricoGotFocus")
        BINDEVENT(THIS.txt_4c_Historico, "LostFocus", THIS, "ValidarHistorico")

        *----------------------------------------------------------------------
        * obj_4c_Commandgroup1 - Procurar (Buttons(1)) / Encerrar (Buttons(2))
        * ButtonCount DEVE ser setado ANTES de qualquer Buttons(N) (senao
        * "BUTTONS is not an object").
        *----------------------------------------------------------------------
        THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
        WITH THIS.obj_4c_Commandgroup1
            .ButtonCount   = 2
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Top           = -2
            .Left          = 365
            .Width         = 160
            .Height        = 85
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        *-- NAO atribuir .TabIndex aqui: o grupo e' o ULTIMO AddObject, e
        *-- atribuir no meio da criacao o puxa para a frente dos campos.
        *-- A ordem de tabulacao inteira vai em AplicarOrdemTabulacao(),
        *-- chamado depois de TODOS os AddObject.

        WITH THIS.obj_4c_Commandgroup1.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .Caption         = "\<Procurar"
        ENDWITH
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnProcurarClick")

        WITH THIS.obj_4c_Commandgroup1.Buttons(2)
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Caption         = "Encerrar"
        ENDWITH
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnEncerrarClick")

        THIS.AplicarOrdemTabulacao()
    ENDPROC

    *==========================================================================
    * AplicarOrdemTabulacao - ordem de tabulacao do legado
    *
    * O TabIndex nao pode ser atribuido dentro do WITH de cada AddObject: o
    * VFP aplica o valor no instante da criacao e CLAMPA ao numero de objetos
    * que existem ali, entao o grupo de botoes (ultimo AddObject) com
    * .TabIndex = 4 era puxado para a 4a posicao e o Tab saltava de "Data"
    * direto para os botoes, pulando Valor e Historico. Medido no VFP9 em
    * 2026-10-30: TabIndex efetivo era Lancamento=3, Commandgroup1=4,
    * Valor=6, Historico=8.
    *
    * O valor LITERAL do dump tambem nao serve como alvo - no legado ele
    * sofre o MESMO clamp. Simulando o load do SCX (recriando os filhos na
    * ordem dos REGISTROS e aplicando o valor logo apos cada AddObject),
    * a ordem EFETIVA do legado lida de volta foi:
    *
    *     getLancamento=1  getValor=2  getHistorico=3
    *     cntSombra=4      Commandgroup1=5   Say1=6  Say2=7  Say3=8
    *
    * isto eh, entre os FOCALIZAVEIS: Lancamento -> Valor -> Historico ->
    * Commandgroup1 (os botoes vem por ULTIMO, nao em 4o). O SCX declara
    * Commandgroup1.TabIndex = 4, mas esse 4 e' inalcancavel por construcao
    * (o grupo e' o 2o registro criado) - transcrever o literal seria FIEL AO
    * ARQUIVO e INFIEL A TELA.
    *
    * Numerar so os FOCALIZAVEIS: Label nao tem TabStop (medido: a property
    * nem existe), entao transcrever o TabIndex dos tres Say e' inerte e
    * ainda embaralha a sequencia de quem realmente para o Tab.
    *
    * Atribuicao em ordem ASCENDENTE e depois de todos os AddObject - cada
    * atribuicao poe o controle na posicao pedida e empurra os demais para
    * tras. Com a ordem de criacao deste form a sequencia ja sai correta, ou
    * seja na pratica isto e' um no-op; fica como documentacao e como guarda
    * caso alguem reordene os AddObject.
    *==========================================================================
    PROCEDURE AplicarOrdemTabulacao()
        THIS.txt_4c_Lancamento.TabIndex    = 1    && SCX getLancamento TabIndex = 1
        THIS.txt_4c_Valor.TabIndex         = 2    && SCX getValor      TabIndex = 2
        THIS.txt_4c_Historico.TabIndex     = 3    && SCX getHistorico  TabIndex = 3
        THIS.obj_4c_Commandgroup1.TabIndex = 4    && SCX declara 4; efetivo = depois dos 3 campos
    ENDPROC

    *==========================================================================
    * TxtLancamentoGotFocus / TxtValorGotFocus / TxtHistoricoGotFocus
    *
    * Transcricao do GotFocus dos 3 campos legado (This.Tag = <valor de
    * entrada>). O estado fica no BO (AtualizarTag*), nao no .Tag do TextBox -
    * so existe para o par Valid/LostFocus seguinte comparar entrada x saida.
    *==========================================================================
    PROCEDURE TxtLancamentoGotFocus()
        THIS.this_oBusinessObject.AtualizarTagDatas(THIS.txt_4c_Lancamento.Value)
    ENDPROC

    PROCEDURE TxtValorGotFocus()
        THIS.this_oBusinessObject.AtualizarTagValors(THIS.txt_4c_Valor.Value)
    ENDPROC

    PROCEDURE TxtHistoricoGotFocus()
        THIS.this_oBusinessObject.AtualizarTagHistorico(THIS.txt_4c_Historico.Value)
    ENDPROC

    *==========================================================================
    * ValidarLancamento / ValidarValor / ValidarHistorico
    *
    * FASE 6 - estes TRES metodos sao a entrega da fase: o Valid de cada campo
    * DIGITAVEL do legado. Os 3 campos deste dialogo aceitam digitacao
    * (nenhum tem ReadOnly nem When -> .f. no dump) e cada um tem um Valid de
    * verdade, entao reproduzi-los e' trabalho DESTA fase, nao da 7/8.
    *
    * Transcricao do Valid dos 3 campos legado - ligados a "LostFocus" porque
    * BINDEVENT "Valid" nao funciona de forma confiavel em TextBox (regra
    * critica #2 do CLAUDE.md). LostFocus cobre as tres saidas de campo que
    * disparam o Valid legado (Enter, Tab e clique fora) e NAO passa
    * parametro, por isso a assinatura e' vazia - handler sem parametro
    * ligado a "KeyPress" estouraria a cada tecla (regra #3).
    *
    * NOME: Validar<Campo> e' o nome canonico do projeto para o handler que
    * reproduz o Valid de um campo. O nome anterior (Txt<Campo>LostFocus) era
    * justamente a assinatura que a regra #47 marca como defeito - ela proibe
    * handler batizado <X>LostFocus porque, no acervo, esse nome aparece
    * ligado a "KeyPress" (picker abrindo a cada tecla). Aqui o binding sempre
    * esteve correto; o que estava fora da convencao era o nome. Os handlers
    * de GotFocus acima NAO entram nesse renome: eles nao validam nada -
    * capturam o valor de ENTRADA (a metade Tag do par) - e o nome deles casa
    * com o evento a que estao ligados.
    *
    * SEM GUARDA DE REENTRANCIA, de proposito: o corpo so escreve .Value nos
    * outros dois TextBox, e escrever .Value nao move o foco - nada redispara
    * o proprio LostFocus. A guarda das regras #37/#47 existe para handler que
    * abre form MODAL (picker); aqui nao ha picker nenhum.
    *
    * O ValidarCriterio* do BO compara entrada x saida e, mudando, ja zera as
    * OUTRAS duas properties de criterio - fonte unica da regra (PILAR 3),
    * inclusive da assimetria do legado: o Valid de Data NAO limpa
    * ThisForm.Continuar, os de Valor e Historico limpam. Aqui so falta
    * espelhar esse zeramento nos TextBox visiveis - exatamente o que o legado
    * faz com ThisForm.get*.Value = Ctod('  /  /  ') / 0.00 / ''.
    *==========================================================================
    PROCEDURE ValidarLancamento()
        IF THIS.this_oBusinessObject.ValidarCriterioDatas(THIS.txt_4c_Lancamento.Value)
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    PROCEDURE ValidarValor()
        IF THIS.this_oBusinessObject.ValidarCriterioValors(THIS.txt_4c_Valor.Value)
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    PROCEDURE ValidarHistorico()
        IF THIS.this_oBusinessObject.ValidarCriterioHistorico(THIS.txt_4c_Historico.Value)
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - FASE 8: tela -> BO (os 3 criterios de pesquisa)
    *
    * Legado: o btnOK.Click le ThisForm.get<Campo>.Value DIRETO, dentro do
    * proprio Do Case. Na arquitetura em camadas quem decide a precedencia dos
    * criterios eh o BO (SigOpCrpBO.BuscarRegistro testa this_dDatas /
    * this_nValors / this_cHists), entao o Form tem de alimentar as tres
    * properties ANTES de chamar a busca - este metodo eh esse unico ponto de
    * leitura dos TextBox de criterio.
    *
    * FUNCTION (nao PROCEDURE) e com retorno conferido pelo chamador: sem o
    * retorno, uma falha aqui deixaria o BtnProcurarClick seguir e o LOCATE
    * rodaria com os criterios do clique ANTERIOR, movendo o cursor do pai para
    * o registro errado sem erro na tela.
    *
    * Nenhuma conversao de tipo eh necessaria nos tres: os .Value nascem
    * Date / Numeric / Character nos WITH de AddObject (ver nota de tipo no
    * cabecalho do arquivo) e as properties do BO sao declaradas nos mesmos
    * tipos ({} / 0.00 / "") - MEDIDO no VFP9 (automation\probe714.prg):
    * VARTYPE devolve D / N / C nos tres controles recem-criados.
    *
    * PROTECTED explicito, e nao por estilo: FormBase.prg:285 declara
    * "PROTECTED PROCEDURE FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR o
    * escopo - escrever "FUNCTION FormParaBO" sem o modificador nao torna o
    * metodo publico, so ESCONDE que ele continua protegido (regra #51; medido
    * no probe: chamar loForm.FormParaBO() de fora estoura Program Error e
    * pendura o VFP). Declarar PROTECTED deixa o arquivo dizer a verdade. Os
    * tres hooks sao chamados SO por THIS. - BtnProcurarClick, os tres
    * Validar<Campo>, LimparCampos e InicializarForm.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            WITH THIS.this_oBusinessObject
                .this_dDatas  = THIS.txt_4c_Lancamento.Value
                .this_nValors = THIS.txt_4c_Valor.Value
                .this_cHists  = THIS.txt_4c_Historico.Value
            ENDWITH
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BOParaForm - FASE 8: BO -> tela (os 3 criterios de pesquisa)
    *
    * Sentido inverso do FormParaBO, e o unico ponto que ESCREVE nos TextBox de
    * criterio. Chamado de dois lugares:
    *
    *   1) os tres Validar<Campo>, quando o ValidarCriterio* do BO confirma que
    *      o campo mudou e portanto ja zerou os outros dois criterios - o
    *      legado espelha isso com ThisForm.get<Outro>.Value = <default>;
    *   2) o LimparCampos, depois de zerar as properties.
    *
    * Espelha os TRES campos, inclusive o que acabou de ser digitado - e eh o
    * que permite UM hook em vez das tres copias que havia antes (cada uma
    * espelhando um par diferente de campos), que era a forma de as copias
    * divergirem em silencio ao acrescentar um quarto criterio.
    *
    * Espelhar o proprio campo so eh seguro porque o ValidarCriterio* do BO
    * GUARDA o valor de saida na property do proprio criterio antes de zerar os
    * outros dois. Essa linha foi acrescentada aos tres metodos do BO nesta
    * mesma fase, depois de o probe (automation\probe714c.prg) mostrar o
    * contrario: sem ela a property ficava com o valor ANTERIOR (ela so era
    * alimentada pelo FormParaBO, que roda no Procurar e nao no Valid), e este
    * hook devolvia o valor velho ao campo, APAGANDO o que o usuario tinha
    * acabado de digitar - ValidarValor com 777 deixava a tela em [ / / |0|],
    * que eh o defeito da regra #50. Ao mexer em qualquer um dos dois lados,
    * reexecutar aquele probe: o par "BO guarda o proprio criterio" +
    * "hook espelha os tres" vale junto ou nenhum dos dois vale.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_Lancamento.Value = .this_dDatas
                THIS.txt_4c_Valor.Value      = .this_nValors
                THIS.txt_4c_Historico.Value  = .this_cHists
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - FASE 8: funil unico dos defaults do Init legado
    *
    *     ThisForm.getLancamento.Value = Ctod('  /  /  ')
    *     ThisForm.getValor.Value      = 0.00
    *     ThisForm.getHistorico.Value  = ''
    *
    * Zera as properties de criterio do BO e refaz a tela pelo BOParaForm, para
    * o estado ter UMA fonte (o BO) - sem isso tela e BO poderiam discordar,
    * que eh como um criterio "invisivel" sobreviveria a um clique seguinte e
    * moveria o cursor do pai para o registro errado.
    *
    * Zera tambem o this_cContinuar: ele eh o estado de "continuar de onde
    * parei" dos criterios Valor e Historico (legado: ThisForm.Continuar), e
    * limpar os campos sem limpar o acumulador faria o proximo clique entrar no
    * ramo Continue de uma pesquisa que o usuario ja abandonou.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        WITH THIS.this_oBusinessObject
            .this_dDatas     = {}
            .this_nValors    = 0.00
            .this_cHists     = ""
            .this_cContinuar = ""
        ENDWITH

        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * BtnProcurarClick - transcricao de SIGOPCRP.Commandgroup1.btnOK.Click
    *
    * Esta e' a entrega da Fase 7/8 ("eventos principais dos botoes") para
    * este form: o legado so tem este Click e o de BtnEncerrarClick abaixo -
    * ver nota no cabecalho do arquivo sobre a ausencia de
    * Incluir/Alterar/Visualizar/Excluir.
    *
    * 1) Copia os 3 campos da tela para as properties de criterio do BO
    *    (o legado le ThisForm.get*.Value direto dentro do Click - aqui o
    *    BO so testa THIS.this_dDatas/this_nValors/this_cHists, entao o
    *    form precisa alimenta-las antes de chamar BuscarRegistro).
    * 2) BuscarRegistro() faz o LOCATE/CONTINUE no cursor do pai.
    * 3) Refresh + SetFocus na grade do pai - INCONDICIONAL, igual ao legado
    *    (roda mesmo quando o dialogo vai fechar na sequencia).
    * 4) this_lFecharDialogo / this_cCampoFoco decidem Release ou SetFocus
    *    local - mesma assimetria do segundo Do Case legado (ver cabecalho
    *    de SigOpCrpBO.prg, secao "PRECEDENCIA DOS CRITERIOS").
    *==========================================================================
    PROCEDURE BtnProcurarClick()
        *-- FASE 8: a copia tela -> BO saiu daqui para o hook FormParaBO (fonte
        *-- unica). Retorno conferido: falhando a transferencia, o LOCATE
        *-- rodaria com os criterios do clique ANTERIOR e moveria o cursor do
        *-- pai para o registro errado, sem nada na tela.
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.BuscarRegistro()

        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "pgf_4c_1", 5)
                IF PEMSTATUS(THIS.this_oFormPai.pgf_4c_1.Page2, "grd_4c_Lancamento", 5)
                    THIS.this_oFormPai.pgf_4c_1.Page2.grd_4c_Lancamento.Refresh()
                    THIS.this_oFormPai.pgf_4c_1.Page2.grd_4c_Lancamento.SetFocus()
                ENDIF
            ENDIF
        ENDIF

        DO CASE
            CASE THIS.this_oBusinessObject.this_lFecharDialogo
                THIS.Release()
            CASE THIS.this_oBusinessObject.this_cCampoFoco == "VALOR"
                THIS.txt_4c_Valor.SetFocus()
            CASE THIS.this_oBusinessObject.this_cCampoFoco == "HISTORICO"
                THIS.txt_4c_Historico.SetFocus()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - transcricao de SIGOPCRP.Commandgroup1.btnSair.Click
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - identico ao padrao dos demais forms (percorre
    * Pages de PageFrame e Controls de Container recursivamente). Este form
    * nao tem PageFrame nem container flutuante Visible=.F., mas o metodo fica
    * generico para as proximas fases (obj_4c_Commandgroup1 e os TextBox de
    * campo entram sempre visiveis).
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
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

    *==========================================================================
    * Destroy - nenhum cursor local a fechar (CrSigMvCcr pertence ao form pai
    * e nao deve ser tocado aqui); DODEFAULT() preserva o fix de menu/popup da
    * FormBase (regra #29 / Erro58).
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

### BO (C:\4c\projeto\app\classes\SigOpCrpBO.prg):
*==============================================================================
* SigOpCrpBO.prg
*
* Business Object para FormSigOpCrp - Procura de Lancamento de Conta Corrente
* Legado: SigOpCrp.SCX (task714)
*
* Cursor pesquisado : CrSigMvCcr (grade de lancamentos do form pai)
* Tabela de origem  : SigMvCcr (chave: cidchaves char(20))
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo FILHO, modal e sem barra de titulo, aberto pelo extrato de Conta
* Corrente Individual (SIGOPIND / Formsigopind) no clique do botao "Procura":
*
*     DO FORM SigOpCrp WITH THIS.DataSessionId, THIS
*
* A tela NAO consulta o servidor e NAO grava nada. Ela apenas POSICIONA o
* cursor que o form pai mantem aberto na grade de lancamentos, com LOCATE /
* CONTINUE, por um destes tres criterios:
*
*     Data      -> getLancamento -> CrSigMvCcr.Datas   (D)
*     Valor     -> getValor      -> CrSigMvCcr.Valors  (N(11,2))
*     Historico -> getHistorico  -> CrSigMvCcr.Hists   (C(60))
*
* Por isso o legado comeca com "Set DataSession To Arquivos": o dialogo entra
* na MESMA data session do pai e so assim enxerga CrSigMvCcr. O DataSessionId
* recebido fica guardado em this_nDataSessionPai.
*
*------------------------------------------------------------------------------
* TIPOS DOS CAMPOS - CONFERIDOS NAS DUAS PONTAS
*
* O criterio eh comparado contra o CURSOR, nao contra a tabela, e os dois
* divergem num ponto que importa: na tabela a coluna datas eh datetime, mas
* no cursor que o pai cria (Formsigopind, CREATE CURSOR CrSigMvCcr) a coluna
* Datas eh do tipo D. Conferido em docs/schema.sql (UTF-16, lido com
* Get-Content -Raw, regra #14) e no CREATE CURSOR do form pai:
*
*     coluna      SigMvCcr          CrSigMvCcr       property
*     ----------  ----------------  ---------------  -------------
*     datas       datetime NULL     Datas   D        this_dDatas
*     valors      numeric(11,2)     Valors  N(11,2)  this_nValors
*     hists       char(60) NULL     Hists   C(60)    this_cHists
*
* Dai duas consequencias:
*   - a property de data eh DATE, igual ao Ctod() vazio que o legado atribui
*     ao TextBox, e a montagem da chave passa por ConverterParaData antes do
*     DTOS para nao depender do caminho por onde o valor chegou (regra #16:
*     TTOD estoura erro 11 quando recebe DATE);
*   - o MaxLength do campo Historico eh 60, a largura da COLUNA, e nao a
*     largura em pixels do controle (regra #19).
*
*------------------------------------------------------------------------------
* BUSCA SEQUENCIAL - O QUE this_cContinuar GUARDA
*
* O legado guarda a ultima chave pesquisada na property "continuar" do form e
* usa esse valor para decidir entre RECOMECAR do topo ou CONTINUAR de onde
* parou (transcricao do btnOK.Click):
*
*     Case ThisForm.getValor.Value # 0
*         lcChave = ThisForm.getValor.Value
*         If lcChave = Val(ThisForm.Continuar) .and. !llFinal
*             Continue
*         Else
*             ThisForm.Continuar = Str(lcChave,12,2)
*             Go Top
*             Locate For lcChave = Valors
*         Endif
*
* Ou seja: mesma chave da vez anterior e cursor ainda nao no fim -> CONTINUE
* (proxima ocorrencia); chave nova -> grava a chave, GO TOP e LOCATE. Por isso
* "continuar" eh CARACTERE mesmo no criterio numerico - o legado guarda
* Str(valor,12,2) e compara com Val(). this_cContinuar reproduz isso
* literalmente, inclusive o formato de 12 posicoes com 2 decimais.
*
* llFinal eh medido ANTES da busca e espelhado em this_lFinalArquivo:
*
*     llFinal = Eof()
*     If !llFinal
*         Skip
*         llFinal = Eof()
*         Skip - 1
*     Endif
*
* isto eh, "estou no ultimo registro (ou alem dele)" - o CONTINUE so eh
* permitido quando ainda ha para onde avancar.
*
*------------------------------------------------------------------------------
* PRECEDENCIA DOS CRITERIOS E DESTINO DO FOCO
*
* O Do Case do legado usa UM criterio por vez, nesta ordem: Data, Valor,
* Historico - e os Valid dos tres campos zeram os outros dois, de modo que na
* pratica so um fica preenchido. O MESMO teste decide, no segundo Do Case, o
* que acontece depois da busca:
*
*     criterio    chave          comparacao          depois da busca
*     ----------  -------------  ------------------  --------------------
*     DATA        Dtos(Datas)    igualdade exata     fecha o dialogo
*     VALOR       Valors         igualdade numerica  foco em getValor
*     HISTORICO   Hists          lcChave $ Hists     foco em getHistorico
*     (nenhum)    -              -                   fecha o dialogo
*
* A assimetria eh do legado e eh proposital: a data identifica um lancamento
* (fecha), valor e historico repetem (o dialogo fica aberto para o usuario
* clicar Procurar de novo e cair na ocorrencia seguinte). O criterio escolhido
* fica em this_cTipoBusca e o destino do foco em this_cCampoFoco /
* this_lFecharDialogo.
*
* Atencao ao criterio de HISTORICO: o operador eh "$" (contido em), nao "=".
* Trocar por igualdade restringiria a busca e mudaria o comportamento da tela.
*
*------------------------------------------------------------------------------
* AUSENCIA DE MENSAGEM QUANDO NAO ACHA - EH DO LEGADO
*
* Quando o LOCATE falha, o legado NAO avisa nada: ele apenas da Refresh e
* SetFocus na grade do pai. Nao cabe acrescentar MsgAviso de "nao encontrado"
* nem limpar o criterio digitado - isso impediria o usuario de corrigir o
* valor e repetir a busca (regra #50). O resultado do LOCATE fica apenas em
* this_lAchouRegistro, para o form poder reposicionar a grade.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA - BO SOMENTE-LEITURA
*
* O legado nao tem INSERT, UPDATE, DELETE, TABLEUPDATE nem AddCursor: o unico
* efeito da tela eh o PONTEIRO do cursor do pai. Portanto este BO nao
* sobrescreve Inserir(), Atualizar() nem ExecutarExclusao() - o comportamento
* padrao herdado de BusinessBase (recusar a operacao e reportar pelo
* ExibirFalha do Salvar) ja eh o correto, e sobrescrever esses metodos
* exigiria INVENTAR uma lista de colunas, o que a regra #22 proibe.
*
* Pelo mesmo motivo o Init NAO passa o nome da tabela para o DODEFAULT: sem
* nenhuma ida ao servidor nao ha DataAccess a instanciar. this_cTabela e
* this_cCampoChave sao preenchidos direto, como contexto da entidade.
*==============================================================================

DEFINE CLASS SigOpCrpBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CRITERIOS DE BUSCA
    *
    * Uma property por caixa da tela, com a grafia da COLUNA do cursor
    * preservada (inclusive o sufixo "s" do padrao Fortyus - NUNCA "corrigir"
    * para o singular). Os valores iniciais reproduzem o Init do legado:
    *
    *     ThisForm.getLancamento.Value = Ctod('  /  /  ')
    *     ThisForm.getValor.Value      = 0.00
    *     ThisForm.getHistorico.Value  = ''
    *--------------------------------------------------------------------------
    this_dDatas  = {}   && Datas  D        - getLancamento "Data :"
    this_nValors = 0.00 && Valors N(11,2)  - getValor      "Valor :" (legado: 0.00)
    this_cHists  = ""   && Hists  C(60)    - getHistorico  "Historico :"

    *--------------------------------------------------------------------------
    * ESTADO DA BUSCA SEQUENCIAL
    *
    * this_cContinuar eh o "continuar" do form legado: CARACTERE, guardando
    * Str(valor,12,2) no criterio numerico e Alltrim(historico) no criterio
    * texto. Vazio significa "a proxima busca comeca do topo".
    *
    * this_lFinalArquivo eh o llFinal medido ANTES da busca: com ele ligado o
    * CONTINUE nao eh tentado, porque nao ha registro seguinte.
    *--------------------------------------------------------------------------
    this_cContinuar    = ""     && legado: ThisForm.Continuar
    this_lFinalArquivo = .F.    && legado: llFinal (cursor no ultimo registro)

    *--------------------------------------------------------------------------
    * CRITERIO ESCOLHIDO E DESTINO DO FOCO
    *
    * this_cTipoBusca eh o seletor dos DOIS Do Case do btnOK.Click legado,
    * resolvido uma vez e reusado: "DATA" / "VALOR" / "HISTORICO" / "" (nenhum
    * criterio preenchido). As outras duas properties sao a traducao do segundo
    * Do Case, para o form apenas obedecer:
    *
    *     this_lFecharDialogo = .T.  -> ThisForm.Release
    *     this_cCampoFoco = "VALOR" ou "HISTORICO" -> SetFocus no campo
    *--------------------------------------------------------------------------
    this_cTipoBusca     = ""    && DATA / VALOR / HISTORICO / vazio
    this_cCampoFoco     = ""    && VALOR / HISTORICO / vazio
    this_lFecharDialogo = .F.   && .T. quando o legado faz ThisForm.Release

    *--------------------------------------------------------------------------
    * RESULTADO DA BUSCA
    *
    * this_lAchouRegistro recebe o FOUND() do LOCATE / CONTINUE. Nao gera
    * mensagem nenhuma (ver nota "AUSENCIA DE MENSAGEM" no cabecalho): serve
    * para o form decidir se vale reposicionar a grade.
    *
    * this_nRegistroAchado guarda o RECNO() da ocorrencia e
    * this_nRegistroAnterior o RECNO() de onde a busca partiu - o que permite
    * devolver o ponteiro ao lugar de origem quando nada eh encontrado, em vez
    * de deixar a grade parada em EOF.
    *--------------------------------------------------------------------------
    this_lAchouRegistro    = .F.
    this_nRegistroAchado   = 0
    this_nRegistroAnterior = 0
    this_nTotalRegistros   = 0

    *--------------------------------------------------------------------------
    * VALORES DO REGISTRO LOCALIZADO (preenchidos por CarregarDoCursor)
    *
    * Espelho das tres colunas pesquisadas, LIDAS da linha em que o LOCATE /
    * CONTINUE parou. Sao DISTINTAS das properties de criterio (this_dDatas /
    * this_nValors / this_cHists) de proposito, e a separacao eh obrigatoria:
    * o primeiro Do Case do BuscarRegistro escolhe o criterio TESTANDO as
    * properties de criterio, entao carregar a linha achada em cima delas
    * TROCARIA o criterio da busca seguinte - uma busca por Valor passaria a
    * ser por Data (a coluna Datas da linha achada nunca esta vazia), em
    * silencio. Com o par separado, CarregarDoCursor eh so leitura e nao tem
    * como interferir na sequencia de buscas.
    *
    * Tipos conferidos nas duas pontas (ver cabecalho do arquivo): no cursor
    * do form pai Datas eh D, Valors eh N(11,2) e Hists eh C(60).
    *--------------------------------------------------------------------------
    this_dDatasAchado  = {}   && Datas  da linha localizada
    this_nValorsAchado = 0    && Valors da linha localizada
    this_cHistsAchado  = ""   && Hists  da linha localizada

    *--------------------------------------------------------------------------
    * CURSOR PESQUISADO E CONTEXTO DO FORM PAI
    *
    * this_cCursorBusca eh o alias que o form pai mantem ligado ao RecordSource
    * da grade de lancamentos - CrSigMvCcr em
    * Formsigopind.pgf_4c_1.Page2.grd_4c_Lancamento. Fica numa property, e nao
    * numa constante espalhada pelo codigo, porque TODA operacao deste BO eh
    * sobre esse alias.
    *
    * this_nDataSessionPai eh o primeiro parametro do form legado ("Arquivos"),
    * usado no "Set DataSession To Arquivos": sem entrar na data session do
    * pai, o alias nem existe para este dialogo.
    *--------------------------------------------------------------------------
    this_cCursorBusca    = "CrSigMvCcr"
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * NOMES DAS COLUNAS PESQUISADAS
    *
    * Centralizados aqui para que LOCATE, CONTINUE e montagem de chave usem
    * sempre a mesma grafia - a do CREATE CURSOR do form pai, que eh tambem a
    * da tabela (regra #48: nome de coluna nao se deduz, se confere).
    *--------------------------------------------------------------------------
    this_cColunaData      = "Datas"
    this_cColunaValor     = "Valors"
    this_cColunaHistorico = "Hists"

    *--------------------------------------------------------------------------
    * VALOR ANTERIOR DE CADA CAMPO (legado: This.Tag no GotFocus)
    *
    * Os tres campos tem o par GotFocus / Valid: o GotFocus guarda o valor de
    * entrada e o Valid compara com o valor de saida para saber se o usuario
    * MUDOU o criterio - e, mudando, zera os outros dois campos e reinicia a
    * sequencia. O legado guarda isso no Tag do proprio controle, sempre como
    * CARACTERE:
    *
    *     getLancamento.GotFocus -> This.Tag = Dtos(This.Value)
    *     getValor.GotFocus      -> This.Tag = Str(This.Value,12,2)
    *     getHistorico.GotFocus  -> This.Tag = Alltrim(This.Value)
    *
    * Ficam espelhadas no BO, tambem como CARACTERE e no mesmo formato, porque
    * Tag de TextBox aceita SO caractere e porque guardar o estado no BO deixa
    * uma fonte unica para a comparacao.
    *--------------------------------------------------------------------------
    this_cTagDatas  = ""    && Dtos(valor de entrada)     - 8 posicoes
    this_cTagValors = ""    && Str(valor de entrada,12,2)  - 12 posicoes
    this_cTagHists  = ""    && Alltrim(valor de entrada)

    *--------------------------------------------------------------------------
    * LARGURAS DE DIGITACAO
    *
    * Vem da largura da COLUNA no cursor / schema, nunca do Width em pixels do
    * controle (regra #19). Usadas pelo MaxLength dos campos e pelo corte do
    * criterio de historico.
    *--------------------------------------------------------------------------
    this_nTamanhoHists   = 60   && Hists  C(60)
    this_nTamanhoValors  = 12   && Valors N(11,2) -> Str(x,12,2)
    this_nDecimaisValors = 2    && Valors N(11,2)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Parametros (ambos opcionais):
    *     par_nDataSessionPai - DataSessionId do form pai, o "Arquivos" do
    *                           legado. Guardado para o form poder executar
    *                           SET DATASESSION TO e alcancar o cursor.
    *     par_cCursorBusca    - alias a pesquisar. Omitido, fica o canonico
    *                           CrSigMvCcr do extrato de Conta Corrente.
    *
    * DODEFAULT() eh chamado SEM o nome da tabela de proposito: este BO nao vai
    * ao servidor e nao precisa de DataAccess (ver nota de arquitetura no
    * cabecalho).
    *
    * Devolve SEMPRE .T.: nao ha pre-requisito que possa falhar aqui - nenhum
    * SQL, nenhum cursor a abrir - e Init de BO que devolve .F. transforma o
    * CREATEOBJECT em logico e derruba o Init do proprio form, deixando a tela
    * sem abrir.
    *==========================================================================
    PROCEDURE Init(par_nDataSessionPai, par_cCursorBusca)
        LOCAL loc_nDataSession, loc_cCursor

        DODEFAULT()

        *-- Contexto da entidade (nenhuma ida ao servidor acontece aqui)
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"

        *-- DataSession do form pai (legado: Set DataSession To Arquivos)
        loc_nDataSession = 0
        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            loc_nDataSession = par_nDataSessionPai
        ENDIF
        THIS.this_nDataSessionPai = loc_nDataSession

        *-- Alias pesquisado (default: a grade de lancamentos do extrato)
        loc_cCursor = ""
        IF VARTYPE(par_cCursorBusca) = "C"
            loc_cCursor = ALLTRIM(par_cCursorBusca)
        ENDIF
        IF EMPTY(loc_cCursor)
            loc_cCursor = "CrSigMvCcr"
        ENDIF
        THIS.this_cCursorBusca = loc_cCursor

        *-- Colunas pesquisadas (grafia do CREATE CURSOR do form pai)
        THIS.this_cColunaData      = "Datas"
        THIS.this_cColunaValor     = "Valors"
        THIS.this_cColunaHistorico = "Hists"

        *-- Criterios zerados, como no Init do legado
        *-- 0.00 (nao 0): o legado grava getValor.Value = 0.00 e o VFP9
        *-- preserva as casas decimais do literal, entao o campo da tela tem
        *-- de voltar a exibir "0.00". O form espelha esta property no
        *-- TxtValorLostFocus, logo o zero daqui chega a tela.
        THIS.this_dDatas  = {}
        THIS.this_nValors = 0.00
        THIS.this_cHists  = ""

        *-- A sequencia de busca comeca do topo
        THIS.this_cContinuar    = ""
        THIS.this_lFinalArquivo = .F.

        *-- Nenhum criterio escolhido e nenhum destino de foco decidido
        THIS.this_cTipoBusca     = ""
        THIS.this_cCampoFoco     = ""
        THIS.this_lFecharDialogo = .F.

        *-- Nenhuma busca executada ainda
        THIS.this_lAchouRegistro    = .F.
        THIS.this_nRegistroAchado   = 0
        THIS.this_nRegistroAnterior = 0
        THIS.this_nTotalRegistros   = 0

        *-- Nenhuma linha localizada ainda
        THIS.LimparRegistroAchado()

        *-- Valores de entrada dos campos (legado: This.Tag no GotFocus)
        THIS.this_cTagDatas  = ""
        THIS.this_cTagValors = ""
        THIS.this_cTagHists  = ""

        *-- Larguras vindas da coluna, nao do Width do controle
        THIS.this_nTamanhoHists   = 60
        THIS.this_nTamanhoValors  = 12
        THIS.this_nDecimaisValors = 2

        *-- Estado de edicao herdado: esta tela eh de consulta
        THIS.this_lEmEdicao     = .F.
        THIS.this_lNovoRegistro = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BuscarRegistro - Posiciona o cursor do form pai no registro encontrado
    *
    * Transcricao de SIGOPCRP.Commandgroup1.btnOK.Click (ver cabecalho do
    * arquivo, secoes "BUSCA SEQUENCIAL" e "PRECEDENCIA DOS CRITERIOS").
    *
    * O metodo faz SO a parte de DADOS do Click legado - LOCATE/CONTINUE no
    * cursor do pai e o calculo de qual criterio foi usado. As acoes de
    * TELA do legado (Refresh/SetFocus na grade do pai, SetFocus no proprio
    * campo, Release do dialogo) ficam no FORM, que le this_cTipoBusca /
    * this_cCampoFoco / this_lFecharDialogo / this_lAchouRegistro depois de
    * chamar este metodo.
    *
    * Devolve o mesmo valor guardado em this_lAchouRegistro. NUNCA exibe
    * mensagem quando nao acha - eh do legado (nota "AUSENCIA DE MENSAGEM"
    * no cabecalho do arquivo).
    *==========================================================================
    PROCEDURE BuscarRegistro()
        LOCAL loc_cAlias, loc_cColData, loc_cColValor, loc_cColHist, ;
              loc_cChaveTexto, loc_nChaveNumero, loc_lFinal, loc_lAchou

        loc_lAchou = .F.

        THIS.this_lAchouRegistro  = .F.
        THIS.this_nRegistroAchado = 0
        THIS.this_cCampoFoco      = ""
        THIS.this_lFecharDialogo  = .F.

        *-- A linha localizada da busca ANTERIOR nao vale mais
        THIS.LimparRegistroAchado()

        *-- Entra na data session do form pai - sem isso o alias nem existe
        *-- (legado: Set DataSession To Arquivos)
        IF THIS.this_nDataSessionPai > 0
            SET DATASESSION TO (THIS.this_nDataSessionPai)
        ENDIF

        loc_cAlias = THIS.this_cCursorBusca

        IF !USED(loc_cAlias)
            THIS.this_cTipoBusca     = ""
            THIS.this_lFecharDialogo = .T.
            RETURN .F.
        ENDIF

        loc_cColData  = THIS.this_cColunaData
        loc_cColValor = THIS.this_cColunaValor
        loc_cColHist  = THIS.this_cColunaHistorico

        SELECT (loc_cAlias)
        THIS.this_nRegistroAnterior = RECNO()
        THIS.this_nTotalRegistros   = RECCOUNT()

        SET NEAR ON

        *-- llFinal: "estou no ultimo registro (ou alem dele)", medido
        *-- ANTES da busca - igual ao legado
        loc_lFinal = EOF()
        IF !loc_lFinal
            SKIP
            loc_lFinal = EOF()
            SKIP -1
        ENDIF
        THIS.this_lFinalArquivo = loc_lFinal

        DO CASE
            *-- Criterio DATA: igualdade exata, sempre recomeca do topo
            CASE !EMPTY(THIS.this_dDatas)
                THIS.this_cTipoBusca = "DATA"
                THIS.this_cContinuar = ""
                loc_cChaveTexto = DTOS(ConverterParaData(THIS.this_dDatas))
                LOCATE FOR DTOS(&loc_cColData) = loc_cChaveTexto
                loc_lAchou = FOUND()

            *-- Criterio VALOR: mesma chave da vez anterior + ainda nao no
            *-- fim do arquivo -> Continue; senao grava a chave, Go Top e
            *-- Locate
            CASE THIS.this_nValors <> 0
                THIS.this_cTipoBusca = "VALOR"
                THIS.this_cCampoFoco = "VALOR"
                loc_nChaveNumero = THIS.this_nValors
                IF loc_nChaveNumero = VAL(THIS.this_cContinuar) AND !loc_lFinal
                    CONTINUE
                ELSE
                    THIS.this_cContinuar = STR(loc_nChaveNumero, ;
                        THIS.this_nTamanhoValors, THIS.this_nDecimaisValors)
                    GO TOP
                    LOCATE FOR loc_nChaveNumero = &loc_cColValor
                ENDIF
                loc_lAchou = FOUND()

            *-- Criterio HISTORICO: "$" (contido em), NUNCA "=" - mesma
            *-- logica de Continue do criterio Valor
            CASE !EMPTY(THIS.this_cHists)
                THIS.this_cTipoBusca = "HISTORICO"
                THIS.this_cCampoFoco = "HISTORICO"
                loc_cChaveTexto = ALLTRIM(THIS.this_cHists)
                IF ALLTRIM(THIS.this_cContinuar) = loc_cChaveTexto AND !loc_lFinal
                    CONTINUE
                ELSE
                    THIS.this_cContinuar = loc_cChaveTexto
                    GO TOP
                    LOCATE FOR loc_cChaveTexto $ &loc_cColHist
                ENDIF
                loc_lAchou = FOUND()

            *-- Nenhum criterio preenchido - legado so fecha o dialogo
            OTHERWISE
                THIS.this_cTipoBusca = ""
        ENDCASE

        SET NEAR OFF

        *-- DATA fecha sempre; sem nenhum criterio preenchido tambem fecha
        *-- (Otherwise do segundo Do Case legado); VALOR/HISTORICO deixam o
        *-- dialogo aberto com foco no proprio campo
        THIS.this_lFecharDialogo = INLIST(THIS.this_cTipoBusca, "DATA", "")

        THIS.this_lAchouRegistro = loc_lAchou
        IF loc_lAchou
            THIS.this_nRegistroAchado = RECNO(loc_cAlias)

            *-- Le a linha em que o LOCATE / CONTINUE parou para as
            *-- properties this_*Achado (o cursor JA esta posicionado nela;
            *-- CarregarDoCursor apenas le e NAO move o ponteiro)
            THIS.CarregarDoCursor(loc_cAlias)
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * AtualizarTagDatas / AtualizarTagValors / AtualizarTagHistorico
    *
    * Espelham o GotFocus dos tres campos (This.Tag = <valor de entrada>,
    * sempre como CARACTERE - ver nota "VALOR ANTERIOR DE CADA CAMPO" no
    * cabecalho). O form chama um destes no GotFocus do TextBox
    * correspondente, passando o .Value de ENTRADA (antes da edicao).
    *==========================================================================
    PROCEDURE AtualizarTagDatas(par_dValorEntrada)
        THIS.this_cTagDatas = DTOS(ConverterParaData(par_dValorEntrada))
    ENDPROC

    PROCEDURE AtualizarTagValors(par_nValorEntrada)
        THIS.this_cTagValors = STR(par_nValorEntrada, ;
            THIS.this_nTamanhoValors, THIS.this_nDecimaisValors)
    ENDPROC

    PROCEDURE AtualizarTagHistorico(par_cValorEntrada)
        THIS.this_cTagHists = ALLTRIM(par_cValorEntrada)
    ENDPROC

    *==========================================================================
    * ValidarCriterioDatas / ValidarCriterioValors / ValidarCriterioHistorico
    *
    * Espelham o Valid dos tres campos: comparam o valor de SAIDA do
    * controle com o Tag guardado no GotFocus (AtualizarTag*) para saber se
    * o usuario MUDOU aquele criterio. Mudando, zeram os OUTROS criterios -
    * exatamente o Do Case de cada Valid no legado (ver cabecalho do
    * arquivo). O form chama no Valid do TextBox correspondente, passando o
    * .Value de SAIDA, e zera na TELA os campos cuja property voltou a
    * vazio/zero.
    *
    * Devolvem .T. quando o criterio mudou (os outros campos foram
    * zerados) e .F. quando nao mudou nada.
    *
    *--------------------------------------------------------------------------
    * CADA UM GUARDA O PROPRIO CRITERIO (Fase 8)
    *--------------------------------------------------------------------------
    * Os tres zeram os OUTROS dois criterios e, antes disso, guardam na propria
    * property o valor de SAIDA que acabaram de receber. No legado isso nao
    * precisa existir porque o CONTROLE eh o armazenamento
    * (ThisForm.getValor.Value eh, ao mesmo tempo, tela e modelo); na
    * arquitetura em camadas o modelo eh a property, e sem esta linha ela ficava
    * com o valor ANTERIOR - a property so era alimentada pelo FormParaBO, que
    * roda no Procurar, nao no Valid.
    *
    * MEDIDO no VFP9 (automation\probe714c.prg) - sem o "guarda o proprio", o
    * BOParaForm da Fase 8 (que espelha os TRES campos) devolvia a property
    * velha para o campo e APAGAVA o valor que o usuario tinha acabado de
    * digitar: ValidarValor com 777 deixava a tela em [ / / |0|]. Eh o defeito
    * da regra #50 (apagar o digitado), e a alternativa - o Form espelhar "todos
    * menos o que mudou" - devolveria o BOParaForm as tres copias com pares
    * diferentes de campos que a Fase 8 unificou.
    *
    * Guardar FORA do IF, de proposito: a property tem de refletir o campo
    * tambem quando o criterio NAO mudou, senao o estado do modelo passa a
    * depender de o usuario ter mexido no campo.
    *==========================================================================
    PROCEDURE ValidarCriterioDatas(par_dValorSaida)
        LOCAL loc_dTagComoData, loc_lMudou

        *-- legado: Ctod(Subs(Tag,7,2)+'/'+Subs(Tag,5,2)+'/'+Subs(Tag,1,4))
        *-- Tag em DTOS (YYYYMMDD) -> reconstroi DD/MM/YYYY (SET DATE BRITISH)
        loc_dTagComoData = CTOD(SUBSTR(THIS.this_cTagDatas, 7, 2) + "/" + ;
                                 SUBSTR(THIS.this_cTagDatas, 5, 2) + "/" + ;
                                 SUBSTR(THIS.this_cTagDatas, 1, 4))

        loc_lMudou = (ConverterParaData(par_dValorSaida) <> loc_dTagComoData)

        *-- ConverterParaData (nao TTOD) porque o valor vem de TextBox criado
        *-- com .Value = {}, isto eh DATE, e TTOD com DATE dispara erro 11 em
        *-- runtime (regra #16)
        THIS.this_dDatas = ConverterParaData(par_dValorSaida)

        IF loc_lMudou
            THIS.this_nValors = 0.00   && legado: ThisForm.getValor.Value = 0.00
            THIS.this_cHists  = ""
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    PROCEDURE ValidarCriterioValors(par_nValorSaida)
        LOCAL loc_lMudou

        loc_lMudou = (par_nValorSaida <> VAL(THIS.this_cTagValors))

        THIS.this_nValors = par_nValorSaida

        IF loc_lMudou
            THIS.this_cContinuar = ""
            THIS.this_dDatas     = {}
            THIS.this_cHists     = ""
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    PROCEDURE ValidarCriterioHistorico(par_cValorSaida)
        LOCAL loc_lMudou

        loc_lMudou = (THIS.this_cTagHists <> ALLTRIM(par_cValorSaida))

        *-- Guarda o texto CRU, nao o ALLTRIM: o ALLTRIM eh da COMPARACAO e da
        *-- montagem da chave em BuscarRegistro; apagar os espacos aqui mudaria
        *-- o que o usuario ve no campo quando o BOParaForm espelhar de volta.
        THIS.this_cHists = par_cValorSaida

        IF loc_lMudou
            THIS.this_cContinuar = ""
            THIS.this_dDatas     = {}
            THIS.this_nValors    = 0.00   && legado: ThisForm.getValor.Value = 0.00
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    *==========================================================================
    * LimparRegistroAchado - Zera o espelho da linha localizada
    *
    * Chamado no Init e na ENTRADA do BuscarRegistro: a linha achada na busca
    * anterior nao vale mais assim que uma nova busca comeca, e deixa-la para
    * tras faria o chamador ler o registro errado quando o LOCATE falhasse.
    *
    * Nao leva PROTECTED (regra #51): metodo que o Form pode chamar de fora
    * nunca pode ser protegido em nivel nenhum da heranca.
    *==========================================================================
    PROCEDURE LimparRegistroAchado()
        THIS.this_dDatasAchado  = {}
        THIS.this_nValorsAchado = 0
        THIS.this_cHistsAchado  = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Le a linha CORRENTE do cursor pesquisado
    *
    * Override do metodo homonimo da BusinessBase, que na base eh um stub
    * documentando justamente este contrato: "ler a linha corrente do alias
    * recebido para as properties do BO", com EVALUATE(pcCursor + ".coluna").
    *
    * Aqui ele le as tres colunas pesquisadas - Datas, Valors e Hists - da
    * linha em que o cursor do form pai esta POSICIONADO, para as properties
    * this_dDatasAchado / this_nValorsAchado / this_cHistsAchado. Serve para o
    * chamador saber QUAL lancamento a busca encontrou sem ter de mexer no
    * cursor do pai (que eh o RecordSource da grade de lancamentos e nao deve
    * ser navegado por fora).
    *
    * ESCOPO - o que este metodo NAO faz, de proposito:
    *   - NAO escreve em property de CRITERIO (this_dDatas / this_nValors /
    *     this_cHists): isso trocaria o criterio da busca seguinte em silencio
    *     (ver nota nas properties this_*Achado);
    *   - NAO habilita edicao: este BO eh somente-leitura, o legado so move o
    *     ponteiro do cursor e nao tem INSERT / UPDATE / DELETE nem
    *     TABLEUPDATE (ver nota de arquitetura no cabecalho do arquivo);
    *   - NAO move o ponteiro: EVALUATE apenas le.
    *
    * Parametro:
    *     par_cAliasCursor - alias a ler. Omitido ou vazio, usa o cursor
    *                        pesquisado (this_cCursorBusca = CrSigMvCcr).
    *
    * Devolve .T. quando leu uma linha valida e .F. quando o alias nao esta
    * aberto ou o cursor esta vazio / em EOF - neste caso o espelho fica
    * zerado, nunca com o resto da leitura anterior.
    *
    * NOTAS DE IMPLEMENTACAO
    *
    * (a) SELECT (par_cAliasCursor) ANTES de qualquer leitura, e acesso por
    *     EVALUATE(alias + "." + coluna) - NUNCA a sintaxe campo,
    *     que nao existe em VFP9 e estoura "Function name is missing )".
    *
    * (b) A existencia de cada coluna eh conferida com TYPE(alias + ".col"),
    *     nao com PEMSTATUS: PEMSTATUS exige OBJETO no 1o argumento e com
    *     nome de cursor dispara erro 11.
    *
    * (c) TratarNulo(valor, <PADRAO>) - o 2o argumento eh o VALOR PADRAO, nao
    *     um codigo de tipo. Dai {} / 0 / "" e nunca "D" / "N" / "C", que
    *     gravariam a LETRA na property.
    *
    * (d) A data passa por ConverterParaData porque a MESMA coluna chega com
    *     tipos diferentes conforme a origem: D no cursor que o form pai cria
    *     com CREATE CURSOR, T quando o alias vem de um SELECT sobre
    *     SigMvCcr.datas (datetime). TTOD() nao serve - com DATE ele dispara
    *     erro 11 em runtime (regra #16).
    *
    * (e) Valor e historico tambem sao conferidos por VARTYPE antes de serem
    *     aceitos (regra #13): coluna numerica que chegue como caractere viria
    *     a estourar "Operator/operand type mismatch" na primeira conta.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso, loc_cPrefixo, ;
              loc_uDatas, loc_uValors, loc_uHists

        loc_lSucesso = .F.

        *-- Alias a ler: o informado ou, na falta, o cursor pesquisado
        loc_cAlias = ""
        IF VARTYPE(par_cAliasCursor) = "C"
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ENDIF
        IF EMPTY(loc_cAlias)
            loc_cAlias = THIS.this_cCursorBusca
        ENDIF

        *-- Espelho sempre zerado antes de ler: alias fechado ou cursor em
        *-- EOF nao pode deixar para tras o registro da leitura anterior
        THIS.LimparRegistroAchado()

        IF USED(loc_cAlias)
            *-- (a) OBRIGATORIO antes de ler campo com alias dinamico
            SELECT (loc_cAlias)

            IF RECCOUNT() > 0 AND !EOF()
                loc_cPrefixo = loc_cAlias + "."

                *-- Datas  D  (no cursor do pai) / datetime (na tabela)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaData) != "U"
                    loc_uDatas = EVALUATE(loc_cPrefixo + THIS.this_cColunaData)
                    THIS.this_dDatasAchado = ConverterParaData(TratarNulo(loc_uDatas, {}))
                ENDIF

                *-- Valors N(11,2)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaValor) != "U"
                    loc_uValors = TratarNulo(EVALUATE(loc_cPrefixo + THIS.this_cColunaValor), 0)
                    IF VARTYPE(loc_uValors) = "N"
                        THIS.this_nValorsAchado = loc_uValors
                    ELSE
                        THIS.this_nValorsAchado = 0
                    ENDIF
                ENDIF

                *-- Hists  C(60)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaHistorico) != "U"
                    loc_uHists = TratarNulo(EVALUATE(loc_cPrefixo + THIS.this_cColunaHistorico), "")
                    IF VARTYPE(loc_uHists) = "C"
                        THIS.this_cHistsAchado = LEFT(loc_uHists, THIS.this_nTamanhoHists)
                    ELSE
                        THIS.this_cHistsAchado = ""
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

