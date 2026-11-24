# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: Teste de formulario falhou com exit code 1. ERRO CAPTURADO: FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigopvda
Erro: Unknown member COLUMN4.


## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
FormBase.Init FALHOU - InicializarForm retornou .F.
Form: Formsigopvda
Erro: Unknown member COLUMN4.


### LOG DA ETAPA (06_testForm):
[2026-11-19 07:41:06] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-19 07:41:06] [INFO] Config FPW: (nao fornecido)
[2026-11-19 07:41:07] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-19 07:41:07] [INFO] Timeout: 300 segundos
[2026-11-19 07:41:07] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pislwfud.prg
[2026-11-19 07:41:08] [INFO] Conteudo do wrapper:
[2026-11-19 07:41:08] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpVda', 'C:\4c\tasks\task817\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpVda', 'C:\4c\tasks\task817\logs\06_testForm.log'
QUIT

[2026-11-19 07:41:08] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pislwfud.prg
[2026-11-19 07:41:09] [INFO] VFP output esperado em: C:\4c\tasks\task817\vfp_output.txt
[2026-11-19 07:41:09] [INFO] Executando Visual FoxPro 9...
[2026-11-19 07:41:09] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pislwfud.prg
[2026-11-19 07:41:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pislwfud.prg
[2026-11-19 07:41:10] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpVda
Inicio: 19/11/2026 07:41:11

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
ERRO - CREATEOBJECT retornou NULL ou tipo invalido

=== RESULTADO DO TESTE ===
Fim: 19/11/2026 07:42:18
Duracao: 67 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-19 07:42:18] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-19 07:42:19] [INFO] VFP9 finalizado em 70.1553795 segundos
[2026-11-19 07:42:19] [INFO] Exit Code: 
[2026-11-19 07:42:19] [INFO] 
[2026-11-19 07:42:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-19 07:42:20] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pislwfud.prg
[2026-11-19 07:42:20] [INFO] 
[2026-11-19 07:42:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-19 07:42:21] [INFO] * Auto-generated wrapper for parameters
[2026-11-19 07:42:21] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-19 07:42:21] [INFO] * Parameters: 'FormSigOpVda', 'C:\4c\tasks\task817\logs\06_testForm.log'
[2026-11-19 07:42:22] [INFO] 
[2026-11-19 07:42:22] [INFO] * Anti-dialog protections for unattended execution
[2026-11-19 07:42:23] [INFO] SET SAFETY OFF
[2026-11-19 07:42:23] [INFO] SET RESOURCE OFF
[2026-11-19 07:42:24] [INFO] SET TALK OFF
[2026-11-19 07:42:24] [INFO] SET NOTIFY OFF
[2026-11-19 07:42:25] [INFO] SYS(2335, 0)
[2026-11-19 07:42:25] [INFO] 
[2026-11-19 07:42:26] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpVda', 'C:\4c\tasks\task817\logs\06_testForm.log'
[2026-11-19 07:42:26] [INFO] QUIT
[2026-11-19 07:42:27] [INFO] 
[2026-11-19 07:42:27] [INFO] === Fim do Wrapper.prg ===
[2026-11-19 07:42:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpVda.prg):
*------------------------------------------------------------------------------
* FormSigOpVda.prg - Form Operacional: Geracao de Arquivos de Vendas
* Herda de FormBase
* Migrado de SIGOPVDA.SCX
*
* Form OPERACIONAL sem PageFrame Lista/Dados (layout PLANO, igual ao SCX
* legado): cabecalho cinza (cntSombra) + filtros de periodo/empresa/
* adquirente + grade de operacoes (csOperacoes, 13 colunas com CheckBox de
* selecao na Column1) + botoes de acao (cmdBtnGrade/cmdBtnForm) + campo do
* nome do arquivo de exportacao (getArqNoms).
*
* FASE 3/8 - ESTRUTURA BASE: casca do form (propriedades visuais EXATAS do
* SCX - DataSession=2, Height=600, Width=1300, BorderStyle=2, ControlBox=.F.,
* TitleBar=0) e o cabecalho cinza superior (cnt_4c_Sombra + lbl_4c_LblSombra
* + lbl_4c_LblTitulo), equivalente ao cntSombra do framework legado - mesmo
* padrao ja adotado nos demais forms OPERACIONAIS da familia "SigOp*"
* (Formsigopvci.prg/FormSigOpTot.prg).
*
* FASE 4/8 - GRADE, BOTOES E FUNIL DE CARGA:
*   ConfigurarGrade() ...... cnt_4c_Grade/grd_4c_Dados: SO o que NAO depende
*                            de dado (geometria, ColumnCount, ReadOnly do
*                            GRID antes do das colunas - regra #18, fontes,
*                            cores). HeaderHeight=19 e ReadOnly=.F. vem do
*                            Init legado, que sobrescreve o dump (16).
*   AplicarFormatoGrade() .. FONTE UNICA de Column.Width/Header1.Caption
*                            (Problema 48) + o Check1 da Column1
*                            (AddObject + CurrentControl + Sparse=.F.,
*                            regra #18) + as colunas 2..13 ReadOnly, como
*                            no "For I=2 To .ColumnCount" do legado.
*   VincularGrade() ........ RecordSource + os 13 ControlSource (incluindo a
*                            EXPRESSAO calculada da Column7), GUARDADOS por
*                            USED() e seguidos de AplicarFormatoGrade.
*   CarregarDados() ........ PUBLIC. FUNIL: cursor + vinculo + Go Top +
*                            THIS.Refresh + Grade.Refresh, o par que o
*                            legado repete nos SEIS caminhos que mexem em
*                            csOperacoes (regra #21).
*   ConfigurarBotoes() ..... os 3 blocos de botoes do dump -
*                            cmg_4c_CmdBtnGrade (Marca Tudo/Desmarca/
*                            Documentos da linha corrente), cmg_4c_CmdBtnForm
*                            (Limpar Selecao/Gera Arquivo/Encerrar) e
*                            cmd_4c_CmdSelecionar (dispara a consulta).
*
* cursor_4c_Operacoes (CriarCursorOperacoes) tem a MESMA estrutura/ordem do
* "Create Cursor csOperacoes" do legado (Load) - fases futuras vao ZAP +
* APPEND FROM DBF neste MESMO cursor, nunca recria-lo por SQLEXEC (SQLEXEC
* sobre alias de grid ZERA o ColumnCount).
*
* NENHUM BINDEVENT nesta fase (Click dos botoes, MouseDown/MouseUp/KeyPress
* do Check1) - fica para a Fase 7, mesmo padrao dos irmaos desta familia
* (FormSigoptrp.prg/FormSigOpTrf.prg/FormSigOpTop.prg).
*
* FASE 5/8 - FILTROS, PARTE 1 (metade superior - linha "Movimentacoes :" +
*   linha "Periodo de Venda :"):
*   ConfigurarFiltrosParte1() .. lbl_4c_Label1/obj_4c_OptProcessados (1-Nao
*                                Processadas/2-Ja Processadas) + lbl_4c_Say1/
*                                txt_4c_DtIni/lbl_4c_Say2("ate")/txt_4c_DtFin/
*                                lbl_4c_Say33/txt_4c_Adquirs. So a casca
*                                visual - sem BINDEVENT (fica para a Fase 7).
*
* FASE 6/8 - FILTROS, PARTE 2 (segunda metade - linha "Empresa :" + linha
*   "Arquivo :") E LOOKUPS:
*   ConfigurarFiltrosParte2() .. lbl_4c_Say4("Empresa :")/txt_4c_EmpOs
*                                (codigo, SigCdEmp.Cemps)/txt_4c_DEmpOs
*                                (razao social, SigCdEmp.Razas)/
*                                lbl_4c_Say3("Arquivo :")/obj_4c_GetArqNoms
*                                (EditBox)/cmd_4c_BtnNomArqs ("..."). Chama os
*                                BINDEVENT dos 3 lookups desta fase (Adquirs,
*                                EmpOs, DEmpOs) + o Click de BtnNomArqs.
*
*   Lookup Adquirente (getAdquirs.Valid do legado = Seek em crAdquirs/
*   fwBuscaInt) -> AdquirsKeyPress/ValidarAdquirs/AbrirLookupAdquirente,
*   via FormBuscaAuxiliar direto em SigCdCad (par_cFiltro = "TipoCads =
*   'ADQUIRENTE'" - regra #36/#54), em vez de pre-carregar o cursor local
*   crAdquirs do Init legado (Select codcads as Adquirente, descads As
*   Descr From SigCdCad Where TipoCads = 'ADQUIRENTE') - mesmo resultado,
*   sem precisar manter cursor global.
*
*   Lookup Empresa (getEmpOs.Valid/getDEmpOs.Valid = fAcessoEmpresa, funcao
*   NAO portada - memoria "fAcessoEmpresa NAO EXISTE") -> EmpOsKeyPress/
*   ValidarEmpOs/AbrirLookupEmpOs (modo C, por codigo) e DEmpOsKeyPress/
*   ValidarDEmpOs/AbrirLookupDEmpOs (modo D, por razao social), ambos via
*   FormBuscaAuxiliar em SigCdEmp (Cemps/Razas). AtualizarEstadoDEmpOs()
*   simula o getDEmpOs.When legado ("Return Empty(ThisForm.getEmpOs.Value)")
*   alternando txt_4c_DEmpOs.ReadOnly - padrao canonico identico a
*   Formsigrevto.prg (AtualizarEstadoDesEmpresa/ValidarEmpresa/
*   ValidarDesEmpresa).
*
*   BtnNomArqsClick (btnNomArqs.Valid do legado = Putfile(...)) abre o
*   dialogo nativo de salvar arquivo e preenche obj_4c_GetArqNoms.
*
* FASE 7/8 - EVENTOS PRINCIPAIS (acoes dos botoes de selecao/processamento):
*   Este form OPERACIONAL nao tem CRUD (Incluir/Alterar/Visualizar/Excluir)
*   - a superficie real e cmd_4c_CmdSelecionar/cmg_4c_CmdBtnGrade/
*   cmg_4c_CmdBtnForm/Check1 da grade, todos ja criados nas fases 3/4.
*
*   Selecionar() ........... cmdSelecionar.Valid do legado: valida Data
*                             Inicial/Final/pasta do arquivo, monta e
*                             executa o JOIN SigOpFp+SigCdCli+SigMvPar+
*                             SigCdOpe, e povoa cursor_4c_Operacoes linha a
*                             linha com os campos derivados (BANDEIRA,
*                             ORIGEM, parcelas/valor/datas formatados,
*                             Erros/SelImp).
*   LimpaSelecao() ......... PROCEDURE limpaselecao do legado: ZAP no
*                             cursor e devolve filtros/botoes ao estado
*                             inicial (via HabilitarFiltros/
*                             HabilitarAcoesProcessamento).
*   Processamento() ........ PROCEDURE processamento do legado: grava o
*                             header 'A01' + uma linha 'A02' por operacao
*                             SelImp no cursor de exportacao, COPY TO
*                             DELIMITED, e insere o controle em SigPcOoL -
*                             um INSERT por linha, tudo num UNICO SQLEXEC
*                             (BEGIN/COMMIT via SQLEXEC separado NAO
*                             protege).
*   Check1KeyPress/MouseDown/MouseUp/Click .. toggle de SelImp na celula
*                             da grade, transcrito LITERAL do legado (o
*                             toggle mora no MouseDown, nao no MouseUp).
*   AbrirDocumentoOperacao() . cmdBtnGrade "Documentos": Do Form SigMvExp
*                             do legado -> CREATEOBJECT("FormSigMvExp", ...)
*                             com os mesmos 5 parametros (Dopes/'C'/Numes/
*                             Emps/.T.).
*
* FASE 8/8 - CONSOLIDACAO (filtros com FONTE UNICA no BO):
*   BOParaForm() ........... PROTECTED. Espelha os filtros guardados no BO
*                             nos controles da tela. E o bloco de defaults
*                             do FIM do Init legado, que ali nao tem nome:
*                             "getDtIni.Value = Date() / getDtFin.Value =
*                             Date() / getArqNoms.Value = [C:\CONCILIADOR.
*                             CSV]". Faltava: a tela abria com as duas datas
*                             e o caminho do arquivo em BRANCO e Selecionar
*                             recusava de imediato.
*   FormParaBO() ........... PROTECTED. Inverso - le os 6 controles de
*                             filtro para as properties do BO com a MESMA
*                             normalizacao do legado (Padr(getEmpOs.Value,3)
*                             de "selecionar", Alltrim nos demais). Branco
*                             SOBRESCREVE de proposito: aqui vazio quer
*                             dizer "todas as empresas"/"todos os
*                             adquirentes", nao "nao informado".
*
*   Com isso Selecionar() e Processamento() param de ler os controles cada
*   um por conta propria (duas copias da mesma leitura, livres para
*   divergir) e leem SO do BO - cujas 7 properties de filtro existiam
*   declaradas desde a Fase 1 e nunca eram preenchidas por ninguem.
*
*   Os valores default moram em SigOpVdaBO.AplicarFiltrosPadrao(), chamado
*   pelo Init do BO: UM lugar decide o default, UM lugar o escreve na tela.
*
*   obj_4c_GetArqNoms recebeu .ReadOnly = .T. - e o "getArqNoms.When ->
*   Return .f." do SCX (no legado o campo nao aceita digitacao, so o botao
*   "..." escreve nele).
*
*   NAO ha BtnSalvarClick/BtnCancelarClick/CarregarLista nesta tela, e isso
*   e fiel ao legado, nao omissao: o SCX nao tem botao de gravar registro
*   nem de cancelar edicao (os 3 botoes de cmdBtnForm sao Limpar Selecao/
*   Gera Arquivo/Encerrar) e nao tem pagina de Lista - a grade e a propria
*   tela e o funil de carga dela se chama CarregarDados(), com esse nome
*   para o harness nao classificar o form como CRUD.
*------------------------------------------------------------------------------
DEFINE CLASS FormSigOpVda AS FormBase

    *-- Propriedades visuais (original SIGOPVDA.SCX: DataSession=2, Height=600,
    *-- Width=1300, BorderStyle=2, ControlBox=.F., TitleBar=0)
    this_cMensagemErro = ""
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    Height      = 600
    Width       = 1300
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Themes      = .F.
    Caption     = "Gera" + CHR(231) + CHR(227) + "o de Arquivos de Vendas"
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpVdaBO")

            THIS.ConfigurarPageFrame()

            *-- FASE 4/8: grade de operacoes (cntGrade/GrdOperacoes) e os
            *-- botoes de acao (cmdBtnGrade/cmdBtnForm/cmdSelecionar). So a
            *-- casca visual - RecordSource aponta para o cursor placeholder
            *-- criado em CriarCursorOperacoes (regra #41), e nenhum Click
            *-- e ligado ainda (BINDEVENT fica para a Fase 7, mesmo padrao
            *-- dos irmaos desta familia - ver FormSigoptrp.prg).
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotoes()

            *-- FASE 7/8: estado inicial dos botoes de acao - legado
            *-- (Init): cmdBtnForm.btnLimpar/btnCopiar e cmdBtnGrade.
            *-- btnMarcaTudo/btnDesmarcar/btnDocumentos nascem .F., so
            *-- habilitam depois de Selecionar() povoar a grade.
            THIS.HabilitarAcoesProcessamento(.F.)

            *-- FASE 5/8: primeira metade dos campos de filtro (linha
            *-- "Movimentacoes :" + optProcessados e a linha "Periodo de
            *-- Venda :" + Adquirente).
            THIS.ConfigurarFiltrosParte1()

            *-- FASE 6/8: segunda metade (Empresa/Arquivo) + os 3 lookups
            *-- (Adquirente, Empresa por codigo, Empresa por razao social) +
            *-- o botao "..." de escolha do arquivo de exportacao.
            THIS.ConfigurarFiltrosParte2()

            *-- FASE 8/8: defaults dos filtros. O Init legado termina com
            *-- "getDtIni.Value = Date() / getDtFin.Value = Date() /
            *-- getArqNoms.Value = [C:\CONCILIADOR.CSV]" - sem este passo a
            *-- tela abre com as duas datas e o caminho do arquivo em BRANCO
            *-- e o botao Selecionar recusa na hora ("A Data Inicial Nao
            *-- Pode Ficar em Branco!!!"). Os valores vem do BO
            *-- (AplicarFiltrosPadrao, chamado no Init dele) e BOParaForm os
            *-- espelha nos controles - UM lugar decide, UM lugar escreve.
            THIS.BOParaForm()

            THIS.TornarControlesVisiveis()

            *-- FUNIL de carga (nunca a posicionadora nua): liga a grade ao
            *-- cursor e repinta. O legado faz isso no Init (RecordSource +
            *-- os 13 ControlSource) e repete o par Go Top + Refresh em TODO
            *-- caminho que mexe em csOperacoes - regra #21.
            THIS.CarregarDados()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o cabecalho cinza superior do form e o
    * fundo padrao (textura new_background.jpg, igual ao SCX legado). Forms
    * OPERACIONAIS nao usam PageFrame CRUD - o cabecalho e um container
    * direto no form, equivalente ao cntSombra do framework legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BackStyle   = 1
                .BorderWidth = 0

                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .Top       = 18
                    .Left      = 10
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

                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .Top       = 17
                    .Left      = 10
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
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CriarCursorOperacoes - placeholder de cursor_4c_Operacoes (csOperacoes
    * no legado), com a MESMA estrutura/ordem de campos do PROCEDURE Load do
    * SCX original. Tem que existir ANTES do RecordSource/ControlSource do
    * grid ser atribuido (regra #41) - por isso e chamado no INICIO de
    * ConfigurarGrade, nao depois.
    *
    * So cria se ainda nao existe - idempotente, porque fases futuras (ZAP +
    * APPEND FROM DBF no cursor do grid, regra do Problema "SQLEXEC sobre
    * alias de grid zera ColumnCount") vao reusar este MESMO cursor, nunca
    * recria-lo.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorOperacoes()
        IF USED("cursor_4c_Operacoes")
            RETURN
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Operacoes (SelImp L(1), TIPO_REGISTRO C(3), ;
            ADQUIRENTE C(60), LOJA_FILIAL C(15), BANDEIRA C(60), ;
            TIPO_TRANSACAO C(15), NRO_PARCELA C(2), QTD_PARCELAS C(2), ;
            TID C(40), NSU C(30), AUTORIZACAO C(20), VALOR C(14), ;
            CLIENTE C(50), DATA_VENDA C(10), ORIGEM C(10), SEQUENCIA C(20), ;
            NOTA_FISCAL C(20), CPF_CNPJ C(20), ESTABELECIMENTO C(20), ;
            DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), REFERENCIA1 C(60), ;
            Emps C(3), Dopes C(20), Numes N(6), EmpDopNums C(29), Erros L(1))
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - cntGrade/GrdOperacoes do legado -> cnt_4c_Grade/
    * grd_4c_Dados (grade de 13 colunas que lista as operacoes selecionadas
    * para gerar o arquivo de vendas).
    *
    * Transcricao do dump (SIGOPVDA.cntGrade/GrdOperacoes):
    *   cntGrade      Top=198 Left=13 Width=1229 Height=387 BorderWidth=0
    *   GrdOperacoes  Top=2 Left=1 Width=1225 Height=467 RowHeight=16
    *                 HeaderHeight=16 ScrollBars=2 DeleteMark=.F. RecordMark=.F.
    *                 AllowHeaderSizing=.F. AllowRowSizing=.F.
    *                 GridLineColor=238,238,238 Tahoma 8
    *
    * ColumnCount/RecordSource ficam FORA do WITH que acessa .ColumnN -
    * dentro do mesmo WITH, acessar .Column1 logo depois de atribuir
    * RecordSource estoura "Unknown member COLUMN1" (regra GRID-WITH).
    *
    * Geometria/headers das colunas moram em AplicarFormatoGrade (chamada ao
    * final), que e a FONTE UNICA (regra do Problema 48: RecordSource zera
    * Column.Width e Header1.Caption, e este metodo e chamado de novo quando
    * a grade for religada a dado real nas fases seguintes).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.CriarCursorOperacoes()

        THIS.AddObject("cnt_4c_Grade", "Container")
        WITH THIS.cnt_4c_Grade
            .Top           = 198
            .Left          = 13
            .Width         = 1229
            .Height        = 387
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .TabIndex      = 15
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Grade.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.cnt_4c_Grade.grd_4c_Dados
            .Top               = 2
            .Left              = 1
            .Width             = 1225
            .Height            = 467
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 19
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabIndex          = 16
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.

            *-- Grid.ReadOnly ANTES de qualquer Column.ReadOnly (regra #18:
            *-- o do grid propaga para as colunas e sobrescreve). O legado
            *-- declara .ReadOnly = .f. no Init (so a Column1 e editavel - as
            *-- demais sao travadas uma a uma em AplicarFormatoGrade).
            .ReadOnly          = .F.
        ENDWITH

        *-- ColumnCount FORA do WITH acima (regra GRID-WITH). RecordSource/
        *-- ControlSource NAO ficam aqui: moram em VincularGrade (ver nota la).
        THIS.cnt_4c_Grade.grd_4c_Dados.ColumnCount = 13

        *-- VincularGrade (e NAO AplicarFormatoGrade direto): atribuir
        *-- ColumnCount sem RecordSource faz o Grid AUTO-BINDAR na area de
        *-- trabalho CORRENTE, e a Column1 pode cair numa coluna de tipo
        *-- incompativel - dai o AddObject do CheckBox estoura "Data type
        *-- mismatch" no proprio AddObject, dentro do TRY do InicializarForm,
        *-- e a tela nao abre. Vinculando ANTES, a Column1 ja esta no campo
        *-- LOGICO SelImp quando o Check1 e criado.
        THIS.VincularGrade()
    ENDPROC

    *==========================================================================
    * VincularGrade - liga grd_4c_Dados ao alias cursor_4c_Operacoes
    * (RecordSource + os 13 ControlSource, transcritos um a um do Init legado,
    * inclusive a EXPRESSAO calculada da Column7).
    *
    * Separado de ConfigurarGrade de proposito: ConfigurarGrade carrega so o
    * que NAO depende de dado (geometria, ColumnCount, fontes, cores), e o
    * bind vive aqui porque e refeito a cada recarga. Guardado por USED() -
    * atribuir RecordSource/ControlSource de alias que ainda nao existe
    * estoura "Alias is not found" DENTRO do TRY do InicializarForm, o que
    * faz CREATEOBJECT devolver .F. e a tela nao abrir (regra #41).
    *
    * AplicarFormatoGrade e chamada DEPOIS do bind, SEMPRE (inclusive quando
    * o alias nao esta aberto): atribuir RecordSource zera Column.Width e
    * Header1.Caption (regra #41 / Problema 48), e sem a reaplicacao a grade
    * ficaria com cabecalho "Column1" e largura default.
    *==========================================================================
    PROCEDURE VincularGrade()
        LOCAL loc_lVinculou
        loc_lVinculou = .F.

        IF !PEMSTATUS(THIS, "cnt_4c_Grade", 5)
            RETURN loc_lVinculou
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Dados", 5)
            RETURN loc_lVinculou
        ENDIF

        IF USED("cursor_4c_Operacoes")
            THIS.cnt_4c_Grade.grd_4c_Dados.ColumnCount = 3
            THIS.cnt_4c_Grade.grd_4c_Dados.RecordSource = "cursor_4c_Operacoes"

            WITH THIS.cnt_4c_Grade.grd_4c_Dados
                .Column1.ControlSource  = "cursor_4c_Operacoes.SelImp"
                .Column2.ControlSource  = "cursor_4c_Operacoes.DATA_VENDA"
                .Column3.ControlSource  = "cursor_4c_Operacoes.ADQUIRENTE"
                .Column4.ControlSource  = "cursor_4c_Operacoes.BANDEIRA"
                .Column5.ControlSource  = "cursor_4c_Operacoes.TIPO_TRANSACAO"
                .Column6.ControlSource  = "cursor_4c_Operacoes.DATA_VENCIMENTO"
                .Column7.ControlSource  = "PADL(cursor_4c_Operacoes.NRO_PARCELA, 2, '0') + ' / ' + " + ;
                                           "PADL(cursor_4c_Operacoes.QTD_PARCELAS, 2, '0')"
                .Column8.ControlSource  = "cursor_4c_Operacoes.NSU"
                .Column9.ControlSource  = "cursor_4c_Operacoes.AUTORIZACAO"
                .Column10.ControlSource = "cursor_4c_Operacoes.VALOR"
                .Column11.ControlSource = "cursor_4c_Operacoes.Emps"
                .Column12.ControlSource = "cursor_4c_Operacoes.Dopes"
                .Column13.ControlSource = "cursor_4c_Operacoes.Numes"
            ENDWITH

            loc_lVinculou = .T.
        ENDIF

        *-- SEMPRE, vinculado ou nao (RecordSource zera Width/Caption)
        THIS.AplicarFormatoGrade()

        RETURN loc_lVinculou
    ENDPROC

    *==========================================================================
    * CarregarDados - FUNIL de carga/repintura da grade de operacoes.
    *
    * Existe porque popular o cursor NAO repinta a grade ligada a ele (regra
    * #21): o legado fecha TODO caminho que mexe em csOperacoes com o mesmo
    * par, e sao SEIS caminhos -
    *   Selecionar ............ Select csOperacoes / Go Top /
    *                           GrdOperacoes.Column1.SetFocus /
    *                           Column1.Refresh / GrdOperacoes.Refresh
    *   LimpaSelecao .......... Zap In csOperacoes + Refresh
    *   cmdBtnGrade "Marca Tudo" .. Replace All SelImp With .t. For Not Erros /
    *                           Go Top / GrdOperacoes.Refresh
    *   cmdBtnGrade "Desmarcar" ... Replace All SelImp With .f. / Go Top /
    *                           GrdOperacoes.Refresh
    *   Check1.MouseUp ........ Gather Memvar / GrdOperacoes.Refresh
    *   Check1.KeyPress ....... Gather Memvar / GrdOperacoes.Refresh
    * Sem um funil unico, cada um desses pontos (fases 7 e 8) teria de
    * lembrar do par - e o que falta nunca da erro: a grade so fica
    * mostrando o conteudo de antes, e o sintoma reportado vira "a tela nao
    * traz dados".
    *
    * PUBLIC de proposito (regra #3): o harness de teste (TesteAutomatico.prg)
    * chama THIS.oForm.CarregarDados() de FORA da classe. PEMSTATUS(...,5)
    * devolve .T. tambem para PROTECTED, entao o harness entraria no branch e
    * a chamada estouraria "Property CARREGARDADOS is not found".
    *
    * Nome CarregarDados (nao CarregarLista) de proposito: o harness usa
    * PEMSTATUS(oForm, "CarregarLista", 5) para CLASSIFICAR o form como CRUD
    * e passaria a cobrar BtnIncluirClick/BtnVisualizarClick/cursor_4c_Dados -
    * superficie que este form OPERACIONAL nao tem.
    *
    * Nao estoura sem o cursor: TRY, resultado por flag e RETURN unico depois
    * do ENDTRY (regra #1).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.CriarCursorOperacoes()

            IF THIS.VincularGrade()
                SELECT cursor_4c_Operacoes
                GO TOP IN cursor_4c_Operacoes

                THIS.Refresh()
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AplicarFormatoGrade - FONTE UNICA da geometria/headers das 13 colunas
    * de grd_4c_Dados (regra do Problema 48 - chamada de novo sempre que o
    * RecordSource for reatribuido nas fases seguintes).
    *
    * Transcricao do dump coluna a coluna (Width/Alignment/Header1.Caption/
    * Text1.* de cada Column do SCX original). Colunas 2 a 13 ficam
    * ReadOnly (legado: "For I=2 To .ColumnCount / .ReadOnly = .t.") - so a
    * Column1 (SelImp) e editavel.
    *
    * Column1.Check1: AddObject + CurrentControl + Sparse=.F. (regra #18) -
    * sem isso a coluna desenha o valor cru em vez do CheckBox. Guard
    * PEMSTATUS antes do AddObject porque este metodo roda de novo apos
    * RecordSource (Problema 48) e um 2o AddObject do mesmo nome estouraria
    * "Object already defined".
    *
    * NENHUM BINDEVENT aqui (MouseDown/MouseUp/KeyPress/Click do Check1) -
    * fica para a Fase 7, mesmo padrao dos irmaos desta familia.
    *
    * Metodo PUBLIC (regra #3): e chamado tanto na montagem (ConfigurarGrade)
    * quanto nas recargas futuras, e o harness de teste pode alcanca-lo de
    * fora da classe.
    *==========================================================================
    PROCEDURE AplicarFormatoGrade()
        LOCAL loc_lAplicou
        loc_lAplicou = .F.

        IF !PEMSTATUS(THIS, "cnt_4c_Grade", 5)
            RETURN loc_lAplicou
        ENDIF

        IF !PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Dados", 5)
            RETURN loc_lAplicou
        ENDIF

        WITH THIS.cnt_4c_Grade.grd_4c_Dados
            *-- Column1 (SelImp) - marcacao da linha para processamento
            .Column1.Width             = 16
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Header1.Caption   = ""
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2

            IF !PEMSTATUS(.Column1, "Check1", 5)
                .Column1.AddObject("Check1", "CheckBox")

                *-- BINDEVENT so na criacao (este metodo roda de novo apos
                *-- RecordSource - Problema 48 - e um 2o BINDEVENT no mesmo
                *-- objeto duplicaria a execucao do handler).
                BINDEVENT(.Column1.Check1, "KeyPress",  THIS, "Check1KeyPress")
                BINDEVENT(.Column1.Check1, "MouseUp",   THIS, "Check1MouseUp")
                BINDEVENT(.Column1.Check1, "MouseDown", THIS, "Check1MouseDown")
                BINDEVENT(.Column1.Check1, "Click",     THIS, "Check1Click")
            ENDIF
            WITH .Column1.Check1
                .Top         = 9
                .Left        = 2
                .Height      = 17
                .Width       = 22
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Alignment   = 0
                .AutoSize    = .T.
                .Caption     = ""
                .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
                .ReadOnly    = .F.
                .Visible     = .T.
            ENDWITH
            .Column1.CurrentControl = "Check1"
            .Column1.Sparse         = .F.
            .Column1.ReadOnly       = .F.
            .Column1.Movable        = .F.
            .Column1.Resizable      = .F.

            *-- Column2 (DATA_VENDA) - "Data"
            .Column2.Alignment         = 2
            .Column2.Width             = 80
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ReadOnly          = .T.
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Header1.Caption   = "Data"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Text1.Alignment   = 2
            .Column2.Text1.BorderStyle = 1
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)

            *-- Column3 (ADQUIRENTE) - "Adquirente"
            .Column3.Width             = 170
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ReadOnly          = .T.
            .Column3.FontName          = "Tahoma"
            .Column3.FontSize          = 8
            .Column3.Header1.Caption   = "Adquirente"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .T.

            *-- Column4 (BANDEIRA) - "Bandeira"
            .Column4.Width             = 170
            .Column4.Movable           = .F.
            .Column4.Resizable         = .F.
            .Column4.ReadOnly          = .T.
            .Column4.FontName          = "Tahoma"
            .Column4.FontSize          = 8
            .Column4.Header1.Caption   = "Bandeira"
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ReadOnly    = .T.
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column5 (TIPO_TRANSACAO) - "T"
            .Column5.Alignment         = 2
            .Column5.Width             = 22
            .Column5.Movable           = .F.
            .Column5.Resizable         = .F.
            .Column5.ReadOnly          = .T.
            .Column5.FontName          = "Tahoma"
            .Column5.FontSize          = 8
            .Column5.Header1.Caption   = "T"
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
            .Column5.Text1.Alignment   = 2
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.ReadOnly    = .T.
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column6 (DATA_VENCIMENTO) - "Vencimento"
            .Column6.Alignment         = 2
            .Column6.Width             = 85
            .Column6.Movable           = .F.
            .Column6.Resizable         = .F.
            .Column6.ReadOnly          = .T.
            .Column6.FontName          = "Tahoma"
            .Column6.FontSize          = 8
            .Column6.Header1.Caption   = "Vencimento"
            .Column6.Header1.FontName  = "Tahoma"
            .Column6.Header1.FontSize  = 8
            .Column6.Header1.Alignment = 2
            .Column6.Text1.Alignment   = 2
            .Column6.Text1.BorderStyle = 0
            .Column6.Text1.Margin      = 0
            .Column6.Text1.ReadOnly    = .T.
            .Column6.Text1.ForeColor   = RGB(0, 0, 0)
            .Column6.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column7 (parcelas, expressao calculada Nro/Qtd) - "Parcelas"
            .Column7.Alignment         = 2
            .Column7.Width             = 70
            .Column7.Movable           = .F.
            .Column7.Resizable         = .F.
            .Column7.ReadOnly          = .T.
            .Column7.FontName          = "Tahoma"
            .Column7.FontSize          = 8
            .Column7.Header1.Caption   = "Parcelas"
            .Column7.Header1.FontName  = "Tahoma"
            .Column7.Header1.FontSize  = 8
            .Column7.Header1.Alignment = 2
            .Column7.Text1.Alignment   = 2
            .Column7.Text1.BorderStyle = 0
            .Column7.Text1.Margin      = 0
            .Column7.Text1.ReadOnly    = .T.
            .Column7.Text1.ForeColor   = RGB(0, 0, 0)
            .Column7.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column8 (NSU)
            .Column8.Alignment         = 2
            .Column8.Width             = 100
            .Column8.Movable           = .F.
            .Column8.Resizable         = .F.
            .Column8.ReadOnly          = .T.
            .Column8.FontName          = "Tahoma"
            .Column8.FontSize          = 8
            .Column8.Header1.Caption   = "NSU"
            .Column8.Header1.FontName  = "Tahoma"
            .Column8.Header1.FontSize  = 8
            .Column8.Header1.Alignment = 2
            .Column8.Text1.Alignment   = 2
            .Column8.Text1.BorderStyle = 0
            .Column8.Text1.Margin      = 0
            .Column8.Text1.ReadOnly    = .T.
            .Column8.Text1.ForeColor   = RGB(0, 0, 0)
            .Column8.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column9 (AUTORIZACAO)
            .Column9.Alignment         = 2
            .Column9.Width             = 100
            .Column9.Movable           = .F.
            .Column9.Resizable         = .F.
            .Column9.ReadOnly          = .T.
            .Column9.FontName          = "Tahoma"
            .Column9.FontSize          = 8
            .Column9.Header1.Caption   = "Autoriza" + CHR(231) + CHR(227) + "o"
            .Column9.Header1.FontName  = "Tahoma"
            .Column9.Header1.FontSize  = 8
            .Column9.Header1.Alignment = 2
            .Column9.Text1.Alignment   = 2
            .Column9.Text1.BorderStyle = 0
            .Column9.Text1.Margin      = 0
            .Column9.Text1.ReadOnly    = .T.
            .Column9.Text1.ForeColor   = RGB(0, 0, 0)
            .Column9.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column10 (VALOR)
            .Column10.Width             = 125
            .Column10.Movable           = .F.
            .Column10.Resizable         = .F.
            .Column10.ReadOnly          = .T.
            .Column10.FontName          = "Tahoma"
            .Column10.FontSize          = 8
            .Column10.Header1.Caption   = "Valor"
            .Column10.Header1.FontName  = "Tahoma"
            .Column10.Header1.FontSize  = 8
            .Column10.Header1.Alignment = 2
            .Column10.Text1.BorderStyle = 0
            .Column10.Text1.Margin      = 0
            .Column10.Text1.ReadOnly    = .T.
            .Column10.Text1.ForeColor   = RGB(0, 0, 0)
            .Column10.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column11 (Emps) - "Emp"
            .Column11.Width             = 35
            .Column11.Movable           = .F.
            .Column11.Resizable         = .F.
            .Column11.ReadOnly          = .T.
            .Column11.FontName          = "Tahoma"
            .Column11.FontSize          = 8
            .Column11.Header1.Caption   = "Emp"
            .Column11.Header1.FontName  = "Tahoma"
            .Column11.Header1.FontSize  = 8
            .Column11.Header1.Alignment = 2
            .Column11.Text1.BorderStyle = 0
            .Column11.Text1.Margin      = 0
            .Column11.Text1.ReadOnly    = .T.
            .Column11.Text1.ForeColor   = RGB(0, 0, 0)
            .Column11.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column12 (Dopes) - "Movimentacao"
            .Column12.Width             = 160
            .Column12.Movable           = .F.
            .Column12.Resizable         = .F.
            .Column12.ReadOnly          = .T.
            .Column12.FontName          = "Tahoma"
            .Column12.FontSize          = 8
            .Column12.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Column12.Header1.FontName  = "Tahoma"
            .Column12.Header1.FontSize  = 8
            .Column12.Header1.Alignment = 2
            .Column12.Text1.BorderStyle = 0
            .Column12.Text1.Margin      = 0
            .Column12.Text1.ReadOnly    = .T.
            .Column12.Text1.ForeColor   = RGB(0, 0, 0)
            .Column12.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column13 (Numes) - "Codigo"
            .Column13.Width             = 58
            .Column13.Movable           = .F.
            .Column13.Resizable         = .F.
            .Column13.ReadOnly          = .T.
            .Column13.FontName          = "Tahoma"
            .Column13.FontSize          = 8
            .Column13.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column13.Header1.FontName  = "Tahoma"
            .Column13.Header1.FontSize  = 8
            .Column13.Header1.Alignment = 2
            .Column13.Text1.Alignment   = 3
            .Column13.Text1.BorderStyle = 0
            .Column13.Text1.Margin      = 0
            .Column13.Text1.ReadOnly    = .T.
            .Column13.Text1.ForeColor   = RGB(0, 0, 0)
            .Column13.Text1.BackColor   = RGB(255, 255, 255)

            *-- Legado: .SetAll('DynamicForeColor', 'Iif(csOperacoes.Erros,
            *-- Rgb(255,0,0), Rgb(0,0,0))', 'Column') - linha em erro pinta
            *-- vermelho (ver PROCEDURE selecionar, m.Erros)
            .SetAll("DynamicForeColor", "IIF(cursor_4c_Operacoes.Erros, RGB(255,0,0), RGB(0,0,0))", "Column")
        ENDWITH

        loc_lAplicou = .T.
        RETURN loc_lAplicou
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cmdBtnGrade/cmdBtnForm/cmdSelecionar do legado ->
    * cmg_4c_CmdBtnGrade / cmg_4c_CmdBtnForm / cmd_4c_CmdSelecionar.
    *
    * Transcricao do dump:
    *   cmdBtnGrade (Marca Tudo/Desmarca/Documentos da linha corrente):
    *     ButtonCount=3 BackStyle=0 BorderStyle=0 Top=339 Left=1244
    *     Width=43 Height=135 Themes=.F.
    *     Buttons: Top=-1/45/91 Left=-1 Height=45 Width=45 Verdana 8
    *       1=geral_marcar_26.jpg      ToolTip "Selecionar"
    *       2=cadastro_excluir_26.jpg  ToolTip "Desmarcar"
    *       3=geral_configuracao_26.jpg ToolTip "Documento"
    *       ForeColor=36,84,155 BackColor=255,255,255 (DECLARADO no dump,
    *       por isso prevalece sobre o canonico 90,90,90 - regra #12)
    *
    *   cmdBtnForm (Limpar Selecao/Gera Arquivo/Encerrar):
    *     AutoSize=.T. ButtonCount=3 BackStyle=0 BorderStyle=0
    *     SpecialEffect=1 Top=-2 Left=1070 Width=235 Height=85
    *     BorderColor=136,189,188 Themes=.F.
    *     Buttons: Top=5 Left=5/80/155 Height=75 Width=75 Comic Sans MS 8 bold italic
    *       1=geral_limpa_grade_60.jpg "Limpar"       ToolTip "Limpar Selecao"
    *       2=geral_disco2_60.jpg      "Gera Arquivo"
    *       3=cadastro_sair_60.jpg     "Encerrar" Cancel=.T. ToolTip "[ESC] Sair"
    *       ForeColor=90,90,90 BackColor=255,255,255
    *
    *   cmdSelecionar (standalone - dispara a consulta das operacoes):
    *     Top=3 Left=1000 Height=75 Width=75 Comic Sans MS 8 bold italic
    *     Picture=importar_72_down.png Caption="\<Selecionar"
    *     ForeColor=90,90,90 BackColor=255,255,255
    *     Themes = .T. + DisabledPicture (standalone com Picture - regra #99;
    *     o legado declara Themes=.F., mas essa excecao do projeto prevalece,
    *     senao o icone some quando o botao for desabilitado nas fases
    *     seguintes)
    *
    * NENHUM BINDEVENT de Click aqui - fica para a Fase 7, mesmo padrao dos
    * irmaos desta familia (FormSigoptrp.prg/FormSigOpTrf.prg/FormSigOpTop.prg).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIconeMarcaTudo, loc_cIconeDesmarcar, loc_cIconeDocumentos, ;
              loc_cIconeLimpar, loc_cIconeGeraArquivo, loc_cIconeEncerrar, ;
              loc_cIconeSelecionar

        loc_cIconeMarcaTudo   = ""
        loc_cIconeDesmarcar   = ""
        loc_cIconeDocumentos  = ""
        loc_cIconeLimpar      = ""
        loc_cIconeGeraArquivo = ""
        loc_cIconeEncerrar    = ""
        loc_cIconeSelecionar  = ""

        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cIconeMarcaTudo   = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            loc_cIconeDesmarcar   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            loc_cIconeDocumentos  = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
            loc_cIconeLimpar      = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            loc_cIconeGeraArquivo = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
            loc_cIconeEncerrar    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            loc_cIconeSelecionar  = gc_4c_CaminhoIcones + "Importar_72_Down.png"
        ENDIF

        *-- cmdBtnGrade -> cmg_4c_CmdBtnGrade
        THIS.AddObject("cmg_4c_CmdBtnGrade", "CommandGroup")
        WITH THIS.cmg_4c_CmdBtnGrade
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 339
            .Left        = 1244
            .Width       = 43
            .Height      = 135
            .TabIndex    = 16
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        WITH THIS.cmg_4c_CmdBtnGrade.Buttons(1)
            .Top         = -1
            .Left         = -1
            .Height       = 45
            .Width        = 45
            .FontName     = "Verdana"
            .FontSize     = 8
            .Caption      = ""
            .TabIndex     = 1
            .ToolTipText  = "Selecionar"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            IF !EMPTY(loc_cIconeMarcaTudo) AND FILE(loc_cIconeMarcaTudo)
                .Picture = loc_cIconeMarcaTudo
            ENDIF
        ENDWITH

        WITH THIS.cmg_4c_CmdBtnGrade.Buttons(2)
            .Top          = 45
            .Left         = -1
            .Height       = 45
            .Width        = 45
            .FontName     = "Verdana"
            .FontSize     = 8
            .Caption      = ""
            .TabIndex     = 2
            .ToolTipText  = "Desmarcar"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            IF !EMPTY(loc_cIconeDesmarcar) AND FILE(loc_cIconeDesmarcar)
                .Picture = loc_cIconeDesmarcar
            ENDIF
        ENDWITH

        WITH THIS.cmg_4c_CmdBtnGrade.Buttons(3)
            .Top          = 91
            .Left         = -1
            .Height       = 45
            .Width        = 45
            .FontName     = "Verdana"
            .FontSize     = 8
            .Caption      = ""
            .TabIndex     = 3
            .ToolTipText  = "Documento"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            IF !EMPTY(loc_cIconeDocumentos) AND FILE(loc_cIconeDocumentos)
                .Picture = loc_cIconeDocumentos
            ENDIF
        ENDWITH

        *-- cmdBtnForm -> cmg_4c_CmdBtnForm
        THIS.AddObject("cmg_4c_CmdBtnForm", "CommandGroup")
        WITH THIS.cmg_4c_CmdBtnForm
            .AutoSize      = .T.
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Top           = -2
            .Left          = 1070
            .Width         = 235
            .Height        = 85
            .TabIndex      = 14
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_CmdBtnForm.Buttons(1)
            .Top          = 5
            .Left         = 5
            .Height       = 75
            .Width        = 75
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .Caption      = "Limpar"
            .TabIndex     = 1
            .ToolTipText  = "Limpar Sele" + CHR(231) + CHR(227) + "o"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            IF !EMPTY(loc_cIconeLimpar) AND FILE(loc_cIconeLimpar)
                .Picture = loc_cIconeLimpar
            ENDIF
        ENDWITH

        WITH THIS.cmg_4c_CmdBtnForm.Buttons(2)
            .Top          = 5
            .Left         = 80
            .Height       = 75
            .Width        = 75
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .Caption      = "Gera Arquivo"
            .TabIndex     = 2
            .ToolTipText  = ""
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            IF !EMPTY(loc_cIconeGeraArquivo) AND FILE(loc_cIconeGeraArquivo)
                .Picture = loc_cIconeGeraArquivo
            ENDIF
        ENDWITH

        WITH THIS.cmg_4c_CmdBtnForm.Buttons(3)
            .Top          = 5
            .Left         = 155
            .Height       = 75
            .Width        = 75
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .Cancel       = .T.
            .Caption      = "Encerrar"
            .TabIndex     = 3
            .ToolTipText  = "[ESC] Sair"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            IF !EMPTY(loc_cIconeEncerrar) AND FILE(loc_cIconeEncerrar)
                .Picture = loc_cIconeEncerrar
            ENDIF
        ENDWITH

        *-- cmdSelecionar -> cmd_4c_CmdSelecionar (standalone)
        THIS.AddObject("cmd_4c_CmdSelecionar", "CommandButton")
        WITH THIS.cmd_4c_CmdSelecionar
            .Top          = 3
            .Left         = 1000
            .Height       = 75
            .Width        = 75
            .FontBold     = .T.
            .FontItalic   = .T.
            .FontName     = "Comic Sans MS"
            .FontSize     = 8
            .Caption      = "\<Selecionar"
            .TabIndex     = 13
            .ToolTipText  = "Seleciona as Opera" + CHR(231) + CHR(227) + "es Conforme os Dados Digitados"
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .MousePointer = 15
            .Themes       = .T.

            IF !EMPTY(loc_cIconeSelecionar) AND FILE(loc_cIconeSelecionar)
                .Picture         = loc_cIconeSelecionar
                .DisabledPicture = loc_cIconeSelecionar
                .PicturePosition = 13
            ENDIF

            .Visible = .T.
        ENDWITH

        *-- BINDEVENT dos 3 botoes de acao desta fase (regra #3: handlers
        *-- PUBLIC). cmdSelecionar.Valid do legado -> Click (CommandButton
        *-- standalone nao dispara Valid).
        BINDEVENT(THIS.cmg_4c_CmdBtnGrade,   "Click", THIS, "CmgCmdBtnGradeClick")
        BINDEVENT(THIS.cmg_4c_CmdBtnForm,    "Click", THIS, "CmgCmdBtnFormClick")
        BINDEVENT(THIS.cmd_4c_CmdSelecionar, "Click", THIS, "CmdSelecionarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarFiltrosParte1 - PRIMEIRA METADE dos campos de filtro do
    * SIGOPVDA.SCX (os que ficam na parte SUPERIOR do form, entre o
    * cabecalho e a grade): linha "Movimentacoes :" + optProcessados
    * (Label1/optProcessados) e a linha "Periodo de Venda :" (Say1/getDtIni/
    * Say2 "ate"/getDtFin/Say33 "Adquirente :"/getAdquirs).
    *
    * A segunda metade (linha "Empresa :" com getEmpOs/getDEmpOs e a linha
    * "Arquivo :" com getArqNoms/btnNomArqs) fica para a Fase 6, em
    * ConfigurarFiltrosParte2() - mesmo criterio de divisao do restante da
    * migracao multi-fase (metade dos campos por fase).
    *
    * Transcricao do dump (sem compensacao de PageFrame - este form
    * OPERACIONAL nao tem PageFrame, os controles sao filhos diretos de
    * THIS, igual ao cntGrade/cmdBtnGrade das fases 3/4):
    *   Label1         Top=87  Left=44  Width=83  Height=15 AutoSize=.F.
    *                  "Movimentacoes :"
    *   optProcessados Top=89  Left=124 Width=235 Height=15 ButtonCount=2
    *                  Option1="Nao Processadas" Option2="Ja Processadas"
    *                  (Value=1 default - legado: 1-Nao Processadas;
    *                  2-Ja Processadas)
    *   Say1           Top=113 Left=34  "Periodo de Venda :"
    *   getDtIni       Top=109 Left=129 Width=80 Height=23 (fweditdata -
    *                  sem Width/Height no dump, usando o mesmo tamanho de
    *                  getDtFin para nao sobrepor Say2 em Left=216)
    *   Say2           Top=113 Left=216 "ate"
    *   getDtFin       Top=109 Left=240 Width=80 Height=23
    *   Say33          Top=113 Left=406 "Adquirente :"
    *   getAdquirs     Top=109 Left=470 Width=150 Height=23 BorderStyle=1
    *
    * NENHUM BINDEVENT aqui (Valid/KeyPress de getDtIni/getDtFin/getAdquirs,
    * InteractiveChange de optProcessados) - fica para a Fase 7, mesmo
    * padrao das fases anteriores desta familia.
    *
    * Valores iniciais (.Value) ficam vazios/default nesta fase - o legado
    * so atribui Date() a getDtIni/getDtFin e 1 a optProcessados dentro do
    * bloco "poDataMgr.pnIdconn > 0" do Init (depende de conexao SQL), que
    * entra no funil de carga das fases seguintes.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltrosParte1()
        *-- Label1 -> lbl_4c_Label1 "Movimentacoes :"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 87
            .Left      = 44
            .Width     = 83
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .FontItalic = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
            .Visible   = .T.
        ENDWITH

        *-- optProcessados -> obj_4c_OptProcessados (OptionGroup, 2 botoes:
        *-- 1-Nao Processadas, 2-Ja Processadas)
        THIS.AddObject("obj_4c_OptProcessados", "OptionGroup")
        WITH THIS.obj_4c_OptProcessados
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 89
            .Left        = 124
            .Width       = 235
            .Height      = 15
            .Value       = 1
            .TabIndex    = 18
            .Visible     = .T.
        ENDWITH

        WITH THIS.obj_4c_OptProcessados.Buttons(1)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "N" + CHR(227) + "o Processadas"
            .Left      = 5
            .Top       = -1
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH THIS.obj_4c_OptProcessados.Buttons(2)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "J" + CHR(225) + " Processadas"
            .Left      = 126
            .Top       = -1
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Say1 -> lbl_4c_Say1 "Periodo de Venda :"
        THIS.AddObject("lbl_4c_Say1", "Label")
        WITH THIS.lbl_4c_Say1
            .Top        = 113
            .Left       = 34
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Per" + CHR(237) + "odo de Venda :"
            .Visible    = .T.
        ENDWITH

        *-- getDtIni -> txt_4c_DtIni (fweditdata) - data inicial do filtro
        THIS.AddObject("txt_4c_DtIni", "TextBox")
        WITH THIS.txt_4c_DtIni
            .Top           = 109
            .Left          = 129
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .TabIndex      = 2
            .ToolTipText   = "Data Inicial Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
            .ForeColor     = RGB(0, 0, 0)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Say2 -> lbl_4c_Say2 "ate"
        THIS.AddObject("lbl_4c_Say2", "Label")
        WITH THIS.lbl_4c_Say2
            .Top        = 113
            .Left       = 216
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "at" + CHR(233)
            .Visible    = .T.
        ENDWITH

        *-- getDtFin -> txt_4c_DtFin (fweditdata) - data final do filtro
        THIS.AddObject("txt_4c_DtFin", "TextBox")
        WITH THIS.txt_4c_DtFin
            .Top           = 109
            .Left          = 240
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .TabIndex      = 4
            .ToolTipText   = "Data Final Para Sele" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es "
            .ForeColor     = RGB(0, 0, 0)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Say33 -> lbl_4c_Say33 "Adquirente :"
        THIS.AddObject("lbl_4c_Say33", "Label")
        WITH THIS.lbl_4c_Say33
            .Top       = 113
            .Left      = 406
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Adquirente :"
            .Visible   = .T.
        ENDWITH

        *-- getAdquirs -> txt_4c_Adquirs - codigo do adquirente (lookup
        *-- fwBuscaInt em crAdquirs na Fase 6/7, so a casca visual aqui)
        THIS.AddObject("txt_4c_Adquirs", "TextBox")
        WITH THIS.txt_4c_Adquirs
            .Top           = 109
            .Left          = 470
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .SpecialEffect = 1
            .TabIndex      = 6
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarFiltrosParte2 - SEGUNDA METADE dos campos de filtro do
    * SIGOPVDA.SCX: linha "Empresa :" (Say4/getEmpOs/getDEmpOs) e linha
    * "Arquivo :" (Say3/getArqNoms/btnNomArqs).
    *
    * Transcricao do dump:
    *   Say4       Top=139 Left=77  "Empresa :"
    *   getEmpOs   Top=135 Left=129 Width=31  Height=23 MaxLength=3
    *              (codigo - SigCdEmp.Cemps char(3), regra "SigCdEmp
    *              TextBox de codigo: .MaxLength = 3 OBRIGATORIO")
    *   getDEmpOs  Top=135 Left=163 Width=457 Height=23
    *              (razao social - SigCdEmp.Razas; ReadOnly dinamico, ver
    *              AtualizarEstadoDEmpOs)
    *   Say3       Top=166 Left=81  "Arquivo :"
    *   getArqNoms Top=162 Left=129 Width=491 Height=23 (fwmemo -> EditBox)
    *   btnNomArqs Top=162 Left=621 Width=28  Height=23 Caption="..."
    *              Comic Sans MS 12 bold italic
    *
    * Tambem registra os BINDEVENT dos 3 lookups desta familia de campos
    * (Adquirente - criado na Fase 5 - e Empresa por codigo/por razao
    * social, criados aqui) e do Click de btnNomArqs. KeyPress testa o
    * codigo da tecla ANTES de agir (F4=115 abre o picker; Enter=13/Tab=9
    * valida o valor digitado) - regra "Lookup textbox DEVE disparar em
    * ENTER/TAB alem de F4", NUNCA a cada tecla (regra #47).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltrosParte2()
        *-- Say4 -> lbl_4c_Say4 "Empresa :"
        THIS.AddObject("lbl_4c_Say4", "Label")
        WITH THIS.lbl_4c_Say4
            .Top        = 139
            .Left       = 77
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Empresa :"
            .Visible    = .T.
        ENDWITH

        *-- getEmpOs -> txt_4c_EmpOs - codigo da empresa (SigCdEmp.Cemps)
        THIS.AddObject("txt_4c_EmpOs", "TextBox")
        WITH THIS.txt_4c_EmpOs
            .Top           = 135
            .Left          = 129
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- getDEmpOs -> txt_4c_DEmpOs - razao social (SigCdEmp.Razas).
        *-- ReadOnly dinamico (AtualizarEstadoDEmpOs, chamada no fim deste
        *-- metodo) - simula o When legado: "Return
        *-- Empty(ThisForm.getEmpOs.Value)" (so editavel por nome quando o
        *-- codigo esta vazio).
        THIS.AddObject("txt_4c_DEmpOs", "TextBox")
        WITH THIS.txt_4c_DEmpOs
            .Top           = 135
            .Left          = 163
            .Width         = 457
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ToolTipText   = "Raz" + CHR(227) + "o Social da Empresa"
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say3 -> lbl_4c_Say3 "Arquivo :"
        THIS.AddObject("lbl_4c_Say3", "Label")
        WITH THIS.lbl_4c_Say3
            .Top        = 166
            .Left       = 81
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Arquivo :"
            .Visible    = .T.
        ENDWITH

        *-- getArqNoms -> obj_4c_GetArqNoms (EditBox) - caminho/nome do
        *-- arquivo de exportacao. O default "C:\CONCILIADOR.CSV" do Init
        *-- legado chega pelo BOParaForm() (chamado no InicializarForm), e
        *-- NAO aqui: a property do BO e a fonte unica do valor.
        *--
        *-- ReadOnly = .T. reproduz o "getArqNoms.When -> Return .f." do
        *-- SCX: no legado o campo NAO aceita digitacao, so o botao "..."
        *-- (Putfile) escreve nele. Atribuicao por codigo continua valendo
        *-- em controle ReadOnly, entao BtnNomArqsClick/BOParaForm seguem
        *-- preenchendo normalmente.
        THIS.AddObject("obj_4c_GetArqNoms", "EditBox")
        WITH THIS.obj_4c_GetArqNoms
            .Top           = 162
            .Left          = 129
            .Width         = 491
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ScrollBars    = 0
            .ReadOnly      = .T.
            .ToolTipText   = "Nome do Arquivo Texto a Ser Gerado"
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- btnNomArqs -> cmd_4c_BtnNomArqs ("...") - abre o dialogo nativo
        *-- de salvar arquivo (Putfile) e preenche obj_4c_GetArqNoms.
        THIS.AddObject("cmd_4c_BtnNomArqs", "CommandButton")
        WITH THIS.cmd_4c_BtnNomArqs
            .Top         = 162
            .Left        = 621
            .Height      = 23
            .Width       = 28
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 12
            .WordWrap    = .T.
            .Caption     = "..."
            .ToolTipText = "Informar o Nome do Arquivo Texto a Ser Gerado"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- BINDEVENT dos lookups (regra #3: handlers tem de ser PUBLIC)
        BINDEVENT(THIS.txt_4c_Adquirs,    "KeyPress", THIS, "AdquirsKeyPress")
        BINDEVENT(THIS.txt_4c_EmpOs,      "KeyPress", THIS, "EmpOsKeyPress")
        BINDEVENT(THIS.txt_4c_DEmpOs,     "KeyPress", THIS, "DEmpOsKeyPress")
        BINDEVENT(THIS.cmd_4c_BtnNomArqs, "Click",    THIS, "BtnNomArqsClick")

        *-- Estado inicial do campo de descricao da empresa
        THIS.AtualizarEstadoDEmpOs()
    ENDPROC

    *==========================================================================
    * AdquirsKeyPress - getAdquirs.KeyPress (novo - o legado valida no
    * Valid/LostFocus do campo). F4(115) abre o picker direto; Enter(13)/
    * Tab(9) valida o codigo digitado contra SigCdCad - mesmo padrao do
    * getDtIni/getDtFin/getAdquirs do restante do projeto.
    *
    * PUBLIC (regra #3 - alvo de BINDEVENT).
    *==========================================================================
    PROCEDURE AdquirsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupAdquirente()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarAdquirs()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarAdquirs - getAdquirs.Valid do legado:
    *   If Not Empty(This.Value)
    *       Select crAdquirs / Set Order To Adquirente
    *       If Not Seek(This.Value)
    *           <abre fwBuscaInt>
    *       EndIf
    *       This.Value = crAdquirs.Adquirente
    *   EndIf
    *
    * crAdquirs era pre-carregado no Init legado com "Select codcads as
    * Adquirente, descads As Descr From SigCdCad Where TipoCads =
    * 'ADQUIRENTE'". Aqui o SEEK equivalente vai direto ao SQL Server (sem
    * manter cursor global), e so abre o picker quando o codigo digitado
    * NAO existe - regra #50 (universo vazio nao e erro, nunca apagar o
    * digitado nem avisar antes do picker).
    *==========================================================================
    PROCEDURE ValidarAdquirs()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado
        loc_cValor = ALLTRIM(THIS.txt_4c_Adquirs.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT codcads FROM SigCdCad WHERE TipoCads = " + ;
                   EscaparSQL("ADQUIRENTE") + " AND codcads = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AdqVal")

        IF loc_nResultado <= 0 OR !USED("cursor_4c_AdqVal") OR EOF("cursor_4c_AdqVal")
            IF USED("cursor_4c_AdqVal")
                USE IN cursor_4c_AdqVal
            ENDIF
            THIS.AbrirLookupAdquirente()
        ELSE
            USE IN cursor_4c_AdqVal
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupAdquirente - picker de Adquirente (SigCdCad filtrado por
    * TipoCads = 'ADQUIRENTE'), substituicao canonica do fwBuscaInt em
    * crAdquirs do legado - regra #36 (1o argumento e o HANDLE da conexao).
    *
    * PUBLIC (regra #3 - alvo potencial de BINDEVENT/chamada direta).
    *==========================================================================
    PROCEDURE AbrirLookupAdquirente()
        LOCAL loc_oBusca, loc_cValor

        loc_cValor = ALLTRIM(THIS.txt_4c_Adquirs.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCad", "cursor_4c_BuscaAdq", "codcads", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Adquirente", .F., .T., ;
            "TipoCads = " + EscaparSQL("ADQUIRENTE"))

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("codcads", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descads", "", "Adquirente")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAdq")
                SELECT cursor_4c_BuscaAdq
                THIS.txt_4c_Adquirs.Value = ALLTRIM(codcads)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaAdq")
            USE IN cursor_4c_BuscaAdq
        ENDIF
    ENDPROC

    *==========================================================================
    * EmpOsKeyPress / DEmpOsKeyPress - getEmpOs/getDEmpOs.KeyPress (novo).
    * F4(115) abre o picker direto; Enter(13)/Tab(9) valida o valor
    * digitado - mesmo padrao de AdquirsKeyPress.
    *
    * PUBLIC (regra #3 - alvo de BINDEVENT).
    *==========================================================================
    PROCEDURE EmpOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpOs()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpOs()
        ENDIF
    ENDPROC

    PROCEDURE DEmpOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDEmpOs()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDEmpOs()
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarEstadoDEmpOs - simula o getDEmpOs.When do legado:
    *   "Return Empty(ThisForm.getEmpOs.Value)"
    * txt_4c_DEmpOs so e editavel (pesquisa reversa por razao social)
    * quando txt_4c_EmpOs esta vazio - mesmo padrao de
    * Formsigrevto.AtualizarEstadoDesEmpresa.
    *
    * PUBLIC (regra #3 - chamado pelos Validar*/AbrirLookup* de Empresa).
    *==========================================================================
    PROCEDURE AtualizarEstadoDEmpOs()
        THIS.txt_4c_DEmpOs.ReadOnly = !EMPTY(ALLTRIM(THIS.txt_4c_EmpOs.Value))
    ENDPROC

    *==========================================================================
    * ValidarEmpOs - getEmpOs.Valid do legado:
    *   =fAcessoEmpresa(Usuar, 'C', This.Value, ThisForm.getEmpOs,
    *                    ThisForm.getDEmpOs, ThisForm.poDataMgr)
    * fAcessoEmpresa NAO foi portada (memoria "fAcessoEmpresa NAO EXISTE") -
    * substituicao canonica: resolve o codigo digitado contra SigCdEmp e
    * preenche a razao social; sem match, abre o picker (regra #50 - sem
    * MsgAviso, sem apagar o codigo digitado).
    *==========================================================================
    PROCEDURE ValidarEmpOs()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado
        loc_cValor = ALLTRIM(THIS.txt_4c_EmpOs.Value)

        IF EMPTY(loc_cValor)
            THIS.txt_4c_DEmpOs.Value = ""
            THIS.AtualizarEstadoDEmpOs()
            RETURN
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
            THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
        ELSE
            THIS.txt_4c_DEmpOs.Value = ""
        ENDIF

        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF

        IF EMPTY(THIS.txt_4c_DEmpOs.Value)
            THIS.AbrirLookupEmpOs()
        ENDIF

        THIS.AtualizarEstadoDEmpOs()
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpOs - picker de Empresa por codigo (SigCdEmp.Cemps).
    *==========================================================================
    PROCEDURE AbrirLookupEmpOs()
        LOCAL loc_oBusca, loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_EmpOs.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        THIS.AtualizarEstadoDEmpOs()
    ENDPROC

    *==========================================================================
    * ValidarDEmpOs - getDEmpOs.Valid do legado:
    *   =fAcessoEmpresa(Usuar, 'D', This.Value, ThisForm.getEmpOs,
    *                    ThisForm.getDEmpOs, ThisForm.poDataMgr)
    * So age quando o codigo esta vazio (equivalente ao getDEmpOs.When,
    * que no legado impede ATE de entrar no campo por codigo preenchido -
    * aqui a mesma condicao e checada no Valid, porque ReadOnly dinamico ja
    * bloqueia a digitacao via AtualizarEstadoDEmpOs). Resolve a razao
    * social digitada contra SigCdEmp.Razas (prefixo, LIKE 'valor%').
    *==========================================================================
    PROCEDURE ValidarDEmpOs()
        LOCAL loc_cValor, loc_cSQL, loc_nResultado

        IF !EMPTY(ALLTRIM(THIS.txt_4c_EmpOs.Value))
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_DEmpOs.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_EmpOs.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
                   EscaparSQL(loc_cValor + "%")
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")

        IF loc_nResultado > 0 AND USED("cursor_4c_EmpDescVal") AND !EOF("cursor_4c_EmpDescVal")
            THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_EmpDescVal.Cemps)
            THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_EmpDescVal.Razas)
            IF USED("cursor_4c_EmpDescVal")
                USE IN cursor_4c_EmpDescVal
            ENDIF
        ELSE
            IF USED("cursor_4c_EmpDescVal")
                USE IN cursor_4c_EmpDescVal
            ENDIF
            THIS.AbrirLookupDEmpOs()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupDEmpOs - picker de Empresa por razao social
    * (SigCdEmp.Razas), mesmo padrao de Formsigrevto.AbrirBuscaDesEmpresa.
    *==========================================================================
    PROCEDURE AbrirLookupDEmpOs()
        LOCAL loc_oBusca, loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_DEmpOs.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", .F., .T., "")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
                        THIS.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                        THIS.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmpD")
            USE IN cursor_4c_BuscaEmpD
        ENDIF

        THIS.AtualizarEstadoDEmpOs()
    ENDPROC

    *==========================================================================
    * BtnNomArqsClick - btnNomArqs.Valid do legado:
    *   lcArq = Putfile([Nome do Arquivo], [C:\CONCILIADOR.CSV], [CSV])
    *   ThisForm.getArqNoms.Value = lcArq
    * PUTFILE() devolve string vazia quando o usuario cancela o dialogo -
    * nesse caso o campo permanece com o valor anterior (igual ao legado,
    * que so atribui quando lcArq retorna preenchido - PUTFILE sem
    * confirmacao devolve "").
    *
    * PUBLIC (regra #3 - alvo de BINDEVENT).
    *==========================================================================
    PROCEDURE BtnNomArqsClick()
        LOCAL loc_cArquivo
        loc_cArquivo = PUTFILE("Nome do Arquivo", "C:\CONCILIADOR.CSV", "CSV")

        IF !EMPTY(loc_cArquivo)
            THIS.obj_4c_GetArqNoms.Value = loc_cArquivo
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarFiltros - habilita/desabilita os 9 controles de filtro
    * (periodo/processados/empresa/arquivo), equivalente ao bloco
    * "With ThisForm / .getDtIni.Enabled = ... / EndWith" repetido no
    * Init/Selecionar/LimpaSelecao do legado. getAdquirs NAO entra (o
    * legado nunca alterna o Enabled dele em lugar nenhum).
    *==========================================================================
    PROTECTED PROCEDURE HabilitarFiltros(par_lHabilitar)
        THIS.txt_4c_DtIni.Enabled                    = par_lHabilitar
        THIS.txt_4c_DtFin.Enabled                    = par_lHabilitar
        THIS.cmd_4c_CmdSelecionar.Enabled             = par_lHabilitar
        THIS.obj_4c_OptProcessados.Buttons(1).Enabled = par_lHabilitar
        THIS.obj_4c_OptProcessados.Buttons(2).Enabled = par_lHabilitar
        THIS.obj_4c_GetArqNoms.Enabled                = par_lHabilitar
        THIS.cmd_4c_BtnNomArqs.Enabled                 = par_lHabilitar
        THIS.txt_4c_EmpOs.Enabled                      = par_lHabilitar
        THIS.txt_4c_DEmpOs.Enabled                     = par_lHabilitar
    ENDPROC

    *==========================================================================
    * HabilitarAcoesProcessamento - habilita/desabilita os 2 botoes de
    * cmg_4c_CmdBtnForm (Limpar/Gera Arquivo) e os 3 de cmg_4c_CmdBtnGrade
    * (Marca Tudo/Desmarcar/Documentos) - equivalente aos blocos "With
    * ThisForm.cmdBtnForm"/"With ThisForm.cmdBtnGrade" do Init/Selecionar/
    * LimpaSelecao do legado. O 3o botao de cmg_4c_CmdBtnForm (Encerrar)
    * NAO entra - o legado nunca o desabilita.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarAcoesProcessamento(par_lHabilitar)
        THIS.cmg_4c_CmdBtnForm.Buttons(1).Enabled  = par_lHabilitar
        THIS.cmg_4c_CmdBtnForm.Buttons(2).Enabled  = par_lHabilitar
        THIS.cmg_4c_CmdBtnGrade.Buttons(1).Enabled = par_lHabilitar
        THIS.cmg_4c_CmdBtnGrade.Buttons(2).Enabled = par_lHabilitar
        THIS.cmg_4c_CmdBtnGrade.Buttons(3).Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    * CmdSelecionarClick - cmdSelecionar.Valid do legado (CommandButton
    * standalone nao dispara Valid em VFP9 - mapeado para Click).
    *==========================================================================
    PROCEDURE CmdSelecionarClick()
        THIS.Selecionar()
    ENDPROC

    *==========================================================================
    * Selecionar - PROCEDURE selecionar do legado: valida Data Inicial/
    * Final/pasta do arquivo de exportacao, monta e executa o JOIN
    * SigOpFp+SigCdCli+SigMvPar+SigCdOpe (filtrado por empresa/adquirente/
    * periodo/situacao de processamento ja gravada em SigPcOoL), e povoa
    * cursor_4c_Operacoes linha a linha com os campos derivados.
    *
    * RETURN so FORA do TRY (regra #1) - loc_lValido encadeia os 4 guards
    * de validacao do legado (cada MessageBox + SetFocus + Return .f.).
    *
    * PUBLIC (regra #3): alvo de BINDEVENT (CmdSelecionarClick) e mesmo
    * nome do PROCEDURE legado (harness pode chamar direto).
    *==========================================================================
    PROCEDURE Selecionar()
        LOCAL loc_cEmp, loc_lNaoProcessados, loc_dDtIni, loc_dDtFin, ;
              loc_cArquivo, loc_cAdquirente, loc_dDtFinHora, loc_cSQL, ;
              loc_nResultado, loc_lValido, loc_lErros, loc_cBandeira, ;
              loc_cOrigem, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                ZAP IN cursor_4c_Operacoes
            ENDIF

            *-- FONTE UNICA dos filtros: FormParaBO() transfere os 6
            *-- controles de filtro para as properties do BO aplicando a
            *-- MESMA normalizacao do legado (Padr(getEmpOs.Value, 3),
            *-- Alltrim nos demais), e a partir daqui o metodo le do BO.
            *-- Antes, Selecionar e Processamento liam os controles cada um
            *-- por conta propria - duas copias da mesma leitura, livres
            *-- para divergir no primeiro filtro novo.
            loc_lValido = THIS.FormParaBO()

            IF loc_lValido
                WITH THIS.this_oBusinessObject
                    loc_cEmp            = PADR(.this_cEmps, 3)
                    loc_lNaoProcessados = (.this_nProcessados = 1)
                    loc_dDtIni          = .this_dDataIni
                    loc_dDtFin          = .this_dDataFin
                    loc_cArquivo        = ALLTRIM(.this_cArquivo)
                    loc_cAdquirente     = ALLTRIM(.this_cAdquirente)
                ENDWITH
            ENDIF

            IF loc_lValido AND EMPTY(loc_dDtIni)
                MsgAviso("A Data Inicial N" + CHR(227) + "o Pode Ficar em Branco!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_DtIni.SetFocus()
                loc_lValido = .F.
            ENDIF

            IF loc_lValido AND EMPTY(loc_dDtFin)
                MsgAviso("A Data Final N" + CHR(227) + "o Pode Ficar em Branco!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_DtFin.SetFocus()
                loc_lValido = .F.
            ENDIF

            IF loc_lValido AND loc_dDtIni > loc_dDtFin
                MsgAviso("A Data Inicial N" + CHR(227) + "o Pode Ser Maior do Que a Data Final!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.txt_4c_DtIni.SetFocus()
                loc_lValido = .F.
            ENDIF

            IF loc_lValido AND (EMPTY(loc_cArquivo) OR EMPTY(JUSTPATH(loc_cArquivo)) ;
                    OR !DIRECTORY(JUSTPATH(loc_cArquivo)))
                MsgAviso("O Arquivo a Ser Gerado Precisa Ser Informado!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!!")
                THIS.cmd_4c_BtnNomArqs.SetFocus()
                loc_lValido = .F.
            ENDIF

            IF loc_lValido
                loc_dDtFinHora = DATETIME(YEAR(loc_dDtFin), MONTH(loc_dDtFin), DAY(loc_dDtFin), 23, 59, 59)

                loc_cSQL = "SELECT 'A02' AS TIPO_REGISTRO, p.Adquirente AS ADQUIRENTE," + ;
                    " p.Emps AS LOJA_FILIAL, f.Bandeira AS BANDEIRA1, d.RClis AS BANDEIRA2," + ;
                    " f.Opers AS TIPO_TRANSACAO, p.Parcs AS NRO_PARCELA, p.TParcs AS QTD_PARCELAS," + ;
                    " SPACE(40) AS TID, p.NSU AS NSU, p.Autoriza AS AUTORIZACAO, p.Valos AS VALOR," + ;
                    " SPACE(50) AS CLIENTE, p.Datas AS DATA_VENDA, f.CCupomNvs AS ORIGEM," + ;
                    " '' AS SEQUENCIA, '' AS NOTA_FISCAL, '' AS CPF_CNPJ, f.CodEstabs AS ESTABELECIMENTO," + ;
                    " p.Vencs AS DATA_VENCIMENTO, '' AS NUMERO_CARTAO," + ;
                    " p.EmpDopNums + p.FPags + STR(p.Nopers, 10) AS REFERENCIA1," + ;
                    " p.Emps, p.Dopes, p.Numes, p.EmpDopNums" + ;
                    " FROM SigOpFP f, SigCdCli d, SigMvPar p, SigCdOpe o" + ;
                    " WHERE f.Infos = 'T'" + ;
                    "   AND f.ContaDs = d.IClis" + ;
                    "   AND p.FPags = f.FPags" + ;
                    IIF(EMPTY(loc_cEmp), "", "   AND p.Emps = " + EscaparSQL(loc_cEmp)) + ;
                    IIF(EMPTY(loc_cAdquirente), "", "   AND p.Adquirente = " + EscaparSQL(loc_cAdquirente)) + ;
                    "   AND p.Datas BETWEEN " + FormatarDataSQL(loc_dDtIni) + " AND " + FormatarDataSQL(loc_dDtFinHora) + ;
                    "   AND p.Dopes = o.Dopes" + ;
                    "   AND NOT o.Vendas = 2" + ;
                    "   AND p.Vencs IS NOT NULL" + ;
                    "   AND p.EmpDopNums " + IIF(loc_lNaoProcessados, "NOT ", "") + ;
                    "   IN (SELECT DISTINCT b.EmpDopNums FROM SigPcOoL b WHERE b.Tipos = " + EscaparSQL("SIGOPVDA") + ")" + ;
                    " ORDER BY p.Datas, p.EmpDopNums, p.FPags, p.Parcs"

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao")

                IF loc_nResultado < 0 OR !USED("cursor_4c_Selecao")
                    MsgErro("Erro ao consultar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ELSE
                    SELECT cursor_4c_Selecao
                    GO TOP

                    IF EOF("cursor_4c_Selecao")
                        USE IN cursor_4c_Selecao
                        MsgInfo("N" + CHR(227) + "o Existem Registros Informados Com as Condi" + ;
                            CHR(231) + CHR(245) + "es Selecionadas!!!", "Nenhum Registro Encontrado")
                        THIS.LimpaSelecao()
                    ELSE
                        SELECT cursor_4c_Selecao
                        SCAN
                            loc_lErros = EMPTY(ALLTRIM(cursor_4c_Selecao.BANDEIRA1 + cursor_4c_Selecao.BANDEIRA2)) ;
                                OR EMPTY(cursor_4c_Selecao.NRO_PARCELA) ;
                                OR EMPTY(cursor_4c_Selecao.QTD_PARCELAS) ;
                                OR EMPTY(cursor_4c_Selecao.NSU) ;
                                OR EMPTY(cursor_4c_Selecao.AUTORIZACAO) ;
                                OR EMPTY(cursor_4c_Selecao.VALOR) ;
                                OR EMPTY(cursor_4c_Selecao.DATA_VENDA) ;
                                OR EMPTY(cursor_4c_Selecao.DATA_VENCIMENTO) ;
                                OR EMPTY(cursor_4c_Selecao.ADQUIRENTE)

                            loc_cBandeira = IIF(EMPTY(ALLTRIM(cursor_4c_Selecao.BANDEIRA1)), ;
                                ALLTRIM(cursor_4c_Selecao.BANDEIRA2), ALLTRIM(cursor_4c_Selecao.BANDEIRA1))
                            loc_cOrigem = IIF(EMPTY(ALLTRIM(cursor_4c_Selecao.ORIGEM)), "POS", ;
                                ALLTRIM(cursor_4c_Selecao.ORIGEM))

                            INSERT INTO cursor_4c_Operacoes (SelImp, TIPO_REGISTRO, ADQUIRENTE, ;
                                LOJA_FILIAL, BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, ;
                                TID, NSU, AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, ;
                                SEQUENCIA, NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
                                NUMERO_CARTAO, REFERENCIA1, Emps, Dopes, Numes, EmpDopNums, Erros) ;
                                VALUES (!loc_lErros, cursor_4c_Selecao.TIPO_REGISTRO, ;
                                cursor_4c_Selecao.ADQUIRENTE, cursor_4c_Selecao.LOJA_FILIAL, ;
                                loc_cBandeira, cursor_4c_Selecao.TIPO_TRANSACAO, ;
                                ALLTRIM(STR(cursor_4c_Selecao.NRO_PARCELA, 3)), ;
                                ALLTRIM(STR(cursor_4c_Selecao.QTD_PARCELAS, 3)), ;
                                cursor_4c_Selecao.TID, cursor_4c_Selecao.NSU, ;
                                cursor_4c_Selecao.AUTORIZACAO, ;
                                STRTRAN(ALLTRIM(STR(cursor_4c_Selecao.VALOR, 12, 2)), ".", ","), ;
                                cursor_4c_Selecao.CLIENTE, ;
                                DTOC(ConverterParaData(cursor_4c_Selecao.DATA_VENDA)), loc_cOrigem, ;
                                cursor_4c_Selecao.SEQUENCIA, cursor_4c_Selecao.NOTA_FISCAL, ;
                                cursor_4c_Selecao.CPF_CNPJ, cursor_4c_Selecao.ESTABELECIMENTO, ;
                                DTOC(ConverterParaData(cursor_4c_Selecao.DATA_VENCIMENTO)), ;
                                cursor_4c_Selecao.NUMERO_CARTAO, cursor_4c_Selecao.REFERENCIA1, ;
                                cursor_4c_Selecao.Emps, cursor_4c_Selecao.Dopes, ;
                                cursor_4c_Selecao.Numes, cursor_4c_Selecao.EmpDopNums, loc_lErros)

                            SELECT cursor_4c_Selecao
                        ENDSCAN

                        USE IN cursor_4c_Selecao

                        THIS.HabilitarFiltros(.F.)
                        THIS.HabilitarAcoesProcessamento(.T.)

                        THIS.CarregarDados()
                        THIS.cnt_4c_Grade.grd_4c_Dados.Column1.SetFocus()
                        THIS.cnt_4c_Grade.grd_4c_Dados.Column1.Refresh()

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Selecionar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimpaSelecao - PROCEDURE limpaselecao do legado: esvazia
    * cursor_4c_Operacoes e devolve filtros/botoes ao estado inicial.
    *
    * PUBLIC (regra #3): chamado por Selecionar/Processamento e mesmo nome
    * do PROCEDURE legado.
    *==========================================================================
    PROCEDURE LimpaSelecao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                ZAP IN cursor_4c_Operacoes
            ENDIF

            THIS.HabilitarFiltros(.T.)
            THIS.HabilitarAcoesProcessamento(.F.)

            THIS.CarregarDados()
            THIS.Refresh()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro LimpaSelecao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Processamento - PROCEDURE processamento do legado: grava o header
    * 'A01' (nomes das colunas) + uma linha 'A02' por operacao SelImp no
    * cursor de exportacao, COPY TO DELIMITED, e insere o controle em
    * SigPcOoL (um INSERT por linha, tudo num UNICO SQLEXEC - BEGIN/COMMIT
    * via SQLEXEC separado NAO protege, a conexao ja nasce com @@TRANCOUNT
    * = 1 - regra "BEGIN/COMMIT via SQLEXEC nao protege").
    *
    * Nao apaga o arquivo se o lote SQL falhar (igual ao legado: o arquivo
    * ja foi gravado em disco ANTES da tentativa de commit).
    *
    * PUBLIC (regra #3): chamado por CmgCmdBtnFormClick e mesmo nome do
    * PROCEDURE legado.
    *==========================================================================
    PROCEDURE Processamento()
        LOCAL loc_lNaoProcessados, loc_cArquivo, loc_nOrdem, loc_lOk, ;
              loc_cInserts, loc_cSQLLote, loc_cProdutosFlag, loc_nResultado, ;
              loc_lFiltrosOk, loc_oErro
        loc_lOk = .F.

        TRY
            *-- FONTE UNICA dos filtros, igual a Selecionar: FormParaBO()
            *-- recarrega as properties do BO a partir dos controles (o
            *-- legado tambem relia optProcessados/getArqNoms aqui) e
            *-- Processamento le do BO, nunca mais do controle.
            loc_lFiltrosOk      = THIS.FormParaBO()
            loc_lNaoProcessados = .T.
            loc_cArquivo        = ""

            IF loc_lFiltrosOk
                WITH THIS.this_oBusinessObject
                    loc_lNaoProcessados = (.this_nProcessados = 1)
                    loc_cArquivo        = ALLTRIM(.this_cArquivo)
                ENDWITH
            ENDIF

            loc_cProdutosFlag = IIF(loc_lNaoProcessados, "", "J" + CHR(193) + " PROCESSADOS")

            *-- RETURN so FORA do TRY (regra #1): o corpo inteiro fica sob a
            *-- flag, em vez de abandonar o bloco no meio.
            IF !loc_lFiltrosOk
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os filtros da tela." + ;
                    CHR(13) + "Nenhum arquivo foi gerado.", "Aten" + CHR(231) + CHR(227) + "o!!!")
            ELSE
                IF USED("cursor_4c_Excel")
                    USE IN cursor_4c_Excel
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Excel (TIPO_REGISTRO C(3), ADQUIRENTE C(60), ;
                    LOJA_FILIAL C(15), BANDEIRA C(60), TIPO_TRANSACAO C(15), ;
                    NRO_PARCELA C(2), QTD_PARCELAS C(2), TID C(40), NSU C(30), ;
                    AUTORIZACAO C(20), VALOR C(14), CLIENTE C(50), DATA_VENDA C(10), ;
                    ORIGEM C(10), SEQUENCIA C(20), NOTA_FISCAL C(20), CPF_CNPJ C(20), ;
                    ESTABELECIMENTO C(20), DATA_VENCIMENTO C(10), NUMERO_CARTAO C(30), ;
                    REFERENCIA1 C(60))
                SET NULL OFF

                *-- Header 'A01' - o legado grava os NOMES das colunas como a
                *-- 1a linha do arquivo exportado.
                INSERT INTO cursor_4c_Excel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, ;
                    BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, TID, NSU, ;
                    AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, SEQUENCIA, ;
                    NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
                    NUMERO_CARTAO, REFERENCIA1) ;
                    VALUES ("A01", "ADQUIRENTE", "LOJA_FILIAL", "BANDEIRA", ;
                    "TIPO_TRANSACAO", "NRO_PARCELA", "QTD_PARCELAS", "TID", "NSU", ;
                    "AUTORIZA" + CHR(199) + CHR(195) + "O", "VALOR", "CLIENTE", ;
                    "DATA_VENDA", "ORIGEM", "SEQUENCIA", "NOTA_FISCAL", "CPF_CNPJ", ;
                    "ESTABELECIMENTO", "DATA_VENCIMENTO", "NUMERO_CARTAO", "REFERENCIA1")

                loc_nOrdem   = 0
                loc_cInserts = ""

                SELECT cursor_4c_Operacoes
                SCAN FOR SelImp
                    loc_nOrdem = loc_nOrdem + 1

                    INSERT INTO cursor_4c_Excel (TIPO_REGISTRO, ADQUIRENTE, LOJA_FILIAL, ;
                        BANDEIRA, TIPO_TRANSACAO, NRO_PARCELA, QTD_PARCELAS, TID, NSU, ;
                        AUTORIZACAO, VALOR, CLIENTE, DATA_VENDA, ORIGEM, SEQUENCIA, ;
                        NOTA_FISCAL, CPF_CNPJ, ESTABELECIMENTO, DATA_VENCIMENTO, ;
                        NUMERO_CARTAO, REFERENCIA1) ;
                        VALUES (cursor_4c_Operacoes.TIPO_REGISTRO, cursor_4c_Operacoes.ADQUIRENTE, ;
                        cursor_4c_Operacoes.LOJA_FILIAL, cursor_4c_Operacoes.BANDEIRA, ;
                        cursor_4c_Operacoes.TIPO_TRANSACAO, cursor_4c_Operacoes.NRO_PARCELA, ;
                        cursor_4c_Operacoes.QTD_PARCELAS, cursor_4c_Operacoes.TID, ;
                        cursor_4c_Operacoes.NSU, cursor_4c_Operacoes.AUTORIZACAO, ;
                        cursor_4c_Operacoes.VALOR, cursor_4c_Operacoes.CLIENTE, ;
                        cursor_4c_Operacoes.DATA_VENDA, cursor_4c_Operacoes.ORIGEM, ;
                        ALLTRIM(STR(loc_nOrdem, 20)), cursor_4c_Operacoes.NOTA_FISCAL, ;
                        cursor_4c_Operacoes.CPF_CNPJ, cursor_4c_Operacoes.ESTABELECIMENTO, ;
                        cursor_4c_Operacoes.DATA_VENCIMENTO, cursor_4c_Operacoes.NUMERO_CARTAO, ;
                        cursor_4c_Operacoes.REFERENCIA1)

                    loc_cInserts = loc_cInserts + ;
                        "INSERT INTO SigPcOoL (tipos, emps, dopes, numes, empds, dopeds," + ;
                        " numeds, datas, usuars, produtos, cidchaves, edndests, empdopnums," + ;
                        " processos, nopers) VALUES (" + ;
                        EscaparSQL("SIGOPVDA") + "," + ;
                        EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Emps)) + "," + ;
                        EscaparSQL(ALLTRIM(cursor_4c_Operacoes.Dopes)) + "," + ;
                        FormatarNumeroSQL(cursor_4c_Operacoes.Numes, 0) + "," + ;
                        EscaparSQL("") + "," + EscaparSQL("") + "," + FormatarNumeroSQL(0, 0) + "," + ;
                        "GETDATE()," + ;
                        EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                        EscaparSQL(loc_cProdutosFlag) + "," + ;
                        EscaparSQL(ALLTRIM(fUniqueIds())) + "," + ;
                        EscaparSQL("") + "," + ;
                        EscaparSQL(ALLTRIM(cursor_4c_Operacoes.EmpDopNums)) + "," + ;
                        EscaparSQL(ALLTRIM(cursor_4c_Operacoes.REFERENCIA1)) + "," + ;
                        FormatarNumeroSQL(0, 0) + ");" + CHR(13)

                    SELECT cursor_4c_Operacoes
                ENDSCAN

                SELECT cursor_4c_Excel
                COPY TO (loc_cArquivo) DELIMITED

                IF !FILE(loc_cArquivo)
                    MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + "vel Gerar o Arquivo!!! " + ;
                        "Verifique Suas Permiss" + CHR(245) + "es!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                ELSE
                    loc_cSQLLote = "SET NOCOUNT ON;" + CHR(13) + ;
                        "DECLARE @nivel4c int = @@TRANCOUNT;" + CHR(13) + ;
                        "IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Op4cVda;" + CHR(13) + ;
                        "BEGIN TRY" + CHR(13) + ;
                        loc_cInserts + ;
                        "IF @nivel4c = 0 COMMIT TRANSACTION;" + CHR(13) + ;
                        "END TRY" + CHR(13) + ;
                        "BEGIN CATCH" + CHR(13) + ;
                        "IF @nivel4c = 0" + CHR(13) + ;
                        "BEGIN" + CHR(13) + ;
                        "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;" + CHR(13) + ;
                        "END" + CHR(13) + ;
                        "ELSE" + CHR(13) + ;
                        "BEGIN" + CHR(13) + ;
                        "IF XACT_STATE() = 1 ROLLBACK TRANSACTION Op4cVda;" + CHR(13) + ;
                        "END;" + CHR(13) + ;
                        "THROW;" + CHR(13) + ;
                        "END CATCH"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLLote)

                    IF loc_nResultado < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (SigPcOoL)")
                    ELSE
                        MsgInfo("Arquivo Gerado!!!", "OK")
                        THIS.LimpaSelecao()
                        THIS.Selecionar()
                        loc_lOk = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Excel")
                    USE IN cursor_4c_Excel
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro Processamento")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * CmgCmdBtnGradeClick - cmdBtnGrade.Click do legado (Marca Tudo/
    * Desmarcar/Documentos da linha corrente).
    *==========================================================================
    PROCEDURE CmgCmdBtnGradeClick()
        LOCAL loc_oGrp
        loc_oGrp = THIS.cmg_4c_CmdBtnGrade

        DO CASE
        CASE loc_oGrp.Value = 1 AND loc_oGrp.Buttons(1).Enabled
            *-- Marca Tudo
            IF USED("cursor_4c_Operacoes")
                SELECT cursor_4c_Operacoes
                REPLACE ALL SelImp WITH .T. FOR !Erros
                GO TOP
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
            ENDIF

        CASE loc_oGrp.Value = 2 AND loc_oGrp.Buttons(2).Enabled
            *-- Desmarcar
            IF USED("cursor_4c_Operacoes")
                SELECT cursor_4c_Operacoes
                REPLACE ALL SelImp WITH .F.
                GO TOP
                THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
            ENDIF

        CASE loc_oGrp.Value = 3 AND loc_oGrp.Buttons(3).Enabled
            *-- Documentos (legado: Do Form SigMvExp)
            THIS.AbrirDocumentoOperacao()
        ENDCASE
    ENDPROC

    *==========================================================================
    * AbrirDocumentoOperacao - cmdBtnGrade "Documentos" do legado:
    *   Do Form SigMvExp With csOperacoes.Dopes, 'C', csOperacoes.Numes,
    *                          csOperacoes.Emps, .t.
    * -> CREATEOBJECT("FormSigMvExp", par_cDopes, par_cTipos, par_nNumes,
    *                  par_cEmps, par_lConsulta, par_nCaixa, par_lMacro)
    *==========================================================================
    PROCEDURE AbrirDocumentoOperacao()
        LOCAL loc_oForm

        IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes")
            RETURN
        ENDIF

        loc_oForm = CREATEOBJECT("FormSigMvExp", ALLTRIM(cursor_4c_Operacoes.Dopes), ;
            "C", cursor_4c_Operacoes.Numes, cursor_4c_Operacoes.Emps, .T.)

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmgCmdBtnFormClick - cmdBtnForm.Click do legado (Limpar Selecao/Gera
    * Arquivo/Encerrar). O guard de "nenhum lancamento selecionado" (Select
    * ... Count(1) ... Group By SelImp) roda ANTES do Do Case, so quando o
    * botao clicado e o 2o (Gera Arquivo) - igual ao legado.
    *==========================================================================
    PROCEDURE CmgCmdBtnFormClick()
        LOCAL loc_oGrp, loc_nSelecionados

        loc_oGrp = THIS.cmg_4c_CmdBtnForm

        IF loc_oGrp.Value = 2
            loc_nSelecionados = 0

            IF USED("cursor_4c_Operacoes")
                IF USED("cursor_4c_ContaSel")
                    USE IN cursor_4c_ContaSel
                ENDIF
                SELECT COUNT(*) AS Selecionados FROM cursor_4c_Operacoes ;
                    WHERE SelImp INTO CURSOR cursor_4c_ContaSel
                IF USED("cursor_4c_ContaSel")
                    loc_nSelecionados = cursor_4c_ContaSel.Selecionados
                    USE IN cursor_4c_ContaSel
                ENDIF
            ENDIF

            IF loc_nSelecionados < 1
                MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado!!!", "Processamento")
                THIS.txt_4c_DtIni.SetFocus()
                RETURN
            ENDIF
        ENDIF

        DO CASE
        CASE loc_oGrp.Value = 1 AND loc_oGrp.Buttons(1).Enabled
            *-- Limpar Selecao
            THIS.LimpaSelecao()

        CASE loc_oGrp.Value = 2 AND loc_oGrp.Buttons(2).Enabled
            *-- Gera Arquivo
            THIS.Processamento()

        CASE loc_oGrp.Value = 3
            *-- Encerrar ([ESC] Sair)
            THIS.Release()
        ENDCASE
    ENDPROC

    *==========================================================================
    * Check1ToggleSelImp - fonte unica do toggle de SelImp na celula
    * corrente da grade (regra do Problema 48/#21: popular cursor NAO
    * repinta a grade - o Refresh e obrigatorio).
    *==========================================================================
    PROCEDURE Check1ToggleSelImp()
        IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
            REPLACE cursor_4c_Operacoes.SelImp WITH !cursor_4c_Operacoes.SelImp
            THIS.cnt_4c_Grade.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Check1KeyPress/MouseUp/MouseDown/Click - Column1.Check1 do legado,
    * TRANSCRITO LITERAL: o toggle mora no MouseDown (Gather Memvar +
    * Refresh + NoDefault); MouseUp e Click so suprimem o default; KeyPress
    * toggla em Enter(13)/Espaco(32). PUBLIC (regra #3 - alvo de BINDEVENT).
    *==========================================================================
    PROCEDURE Check1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.Check1ToggleSelImp()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE Check1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE Check1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.Check1ToggleSelImp()
        NODEFAULT
    ENDPROC

    PROCEDURE Check1Click()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * BOParaForm - leva os filtros de selecao guardados no BO para os
    * controles da tela. E o bloco de defaults do Init legado, que nao tem
    * esse nome la mas existe literalmente:
    *
    *   .getDtIni.Value   = Date()
    *   .getDtFin.Value   = Date()
    *   .getArqNoms.Value = [C:\CONCILIADOR.CSV]
    *
    * Os valores moram em SigOpVdaBO.AplicarFiltrosPadrao() - aqui so se
    * espelha a property no controle, para haver UM lugar que decide o
    * default e UM lugar que o escreve na tela.
    *
    * PROTECTED obrigatoriamente: FormBase declara BOParaForm como
    * PROTECTED e VFP9 nao permite ALARGAR o escopo de metodo herdado.
    *
    * Nao estoura com o BO ausente nem antes dos controles existirem: os
    * dois guards checam, resultado por flag e RETURN unico depois do
    * ENDTRY (regra #1).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN loc_lSucesso
        ENDIF

        IF !PEMSTATUS(THIS, "txt_4c_DtIni", 5)
            RETURN loc_lSucesso
        ENDIF

        TRY
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_DtIni.Value  = ConverterParaData(.this_dDataIni)
                THIS.txt_4c_DtFin.Value  = ConverterParaData(.this_dDataFin)
                THIS.txt_4c_EmpOs.Value  = ALLTRIM(.this_cEmps)
                THIS.txt_4c_DEmpOs.Value = ALLTRIM(.this_cDescEmps)
                THIS.txt_4c_Adquirs.Value = ALLTRIM(.this_cAdquirente)
                THIS.obj_4c_GetArqNoms.Value = ALLTRIM(.this_cArquivo)

                *-- OptionGroup e 1-based (1-Nao Processadas / 2-Ja
                *-- Processadas): nunca atribuir 0 a um controle 1-based.
                THIS.obj_4c_OptProcessados.Value = ;
                    IIF(BETWEEN(.this_nProcessados, 1, 2), .this_nProcessados, 1)
            ENDWITH

            *-- getDEmpOs.When do legado depende do getEmpOs recem-escrito.
            THIS.AtualizarEstadoDEmpOs()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - inverso de BOParaForm: le os 6 controles de filtro e
    * grava nas properties do BO, aplicando a MESMA normalizacao do legado
    * (selecionar: "lcEmp = Padr(ThisForm.getEmpOs.Value, 3)", Alltrim nos
    * demais). Depois disto Selecionar() e Processamento() leem SO do BO.
    *
    * Campo em BRANCO SOBRESCREVE a property de proposito - aqui vazio e um
    * valor com significado, nao "nao informado": empresa vazia significa
    * TODAS as empresas e adquirente vazio significa TODOS os adquirentes
    * (o IIF(EMPTY(...)) de Selecionar simplesmente omite a clausula do
    * WHERE). Por isso NAO se aplica o guard "branco nao sobrescreve" usado
    * em tela de configuracao resolvida.
    *
    * As validacoes do legado (data em branco, inicial > final, pasta do
    * arquivo inexistente) continuam em Selecionar(), que e onde o SCX as
    * tem - este metodo so transfere.
    *
    * PROTECTED obrigatoriamente (FormBase declara FormParaBO PROTECTED e
    * VFP9 nao permite alargar escopo de metodo herdado).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN loc_lSucesso
        ENDIF

        TRY
            WITH THIS.this_oBusinessObject
                *-- Padr(...,3) e o do legado: SigCdEmp.Cemps e char(3) e a
                *-- comparacao em SigMvPar.Emps tambem (chave POSICIONAL -
                *-- regra #42). EMPTY("   ") continua .T., entao o filtro
                *-- vazio segue significando "todas as empresas".
                .this_cEmps       = PADR(ALLTRIM(THIS.txt_4c_EmpOs.Value), 3)
                .this_cDescEmps   = ALLTRIM(THIS.txt_4c_DEmpOs.Value)
                .this_dDataIni    = ConverterParaData(THIS.txt_4c_DtIni.Value)
                .this_dDataFin    = ConverterParaData(THIS.txt_4c_DtFin.Value)
                .this_nProcessados = THIS.obj_4c_OptProcessados.Value
                .this_cArquivo    = ALLTRIM(THIS.obj_4c_GetArqNoms.Value)
                .this_cAdquirente = ALLTRIM(THIS.txt_4c_Adquirs.Value)
            ENDWITH

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles ja criados nesta
    * fase (AddObject nasce Visible=.F.). Varre recursivamente para que as
    * fases seguintes (grade dentro de cnt_4c_Grade, CommandGroups de botoes)
    * fiquem automaticamente cobertas sem precisar reescrever este metodo.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI

        FOR loc_nI = 1 TO THIS.ControlCount
            THIS.TornarVisivelRecursivo(THIS.Controls(loc_nI))
        ENDFOR
    ENDPROC

    *==========================================================================
    * TornarVisivelRecursivo - torna par_oObjeto e seus filhos (Controls e,
    * se for PageFrame, Pages) visiveis, recursivamente.
    *==========================================================================
    PROTECTED PROCEDURE TornarVisivelRecursivo(par_oObjeto)
        LOCAL loc_nI

        IF VARTYPE(par_oObjeto) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(par_oObjeto, "Visible", 5)
            par_oObjeto.Visible = .T.
        ENDIF

        IF PEMSTATUS(par_oObjeto, "PageCount", 5)
            FOR loc_nI = 1 TO par_oObjeto.PageCount
                THIS.TornarVisivelRecursivo(par_oObjeto.Pages(loc_nI))
            ENDFOR
        ENDIF

        IF PEMSTATUS(par_oObjeto, "ControlCount", 5)
            FOR loc_nI = 1 TO par_oObjeto.ControlCount
                THIS.TornarVisivelRecursivo(par_oObjeto.Controls(loc_nI))
            ENDFOR
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpVdaBO.prg):
*------------------------------------------------------------------------------
* SigOpVdaBO - Business Object de Geracao de Arquivos de Vendas
* Baseado no formulario legado SIGOPVDA (SigOpVda.SCX)
* Tabela principal: SigPcOoL (controle de operacoes ja processadas)
*------------------------------------------------------------------------------
DEFINE CLASS SigOpVdaBO AS BusinessBase

    *-- Filtros de selecao (Pagina de criterios do form)
    this_cEmps = ""
    this_cDescEmps = ""
    this_dDataIni = {}
    this_dDataFin = {}
    this_nProcessados = 1
    this_cArquivo = ""
    this_cAdquirente = ""

    *-- Campos do registro de controle (SigPcOoL) gravado por operacao processada
    this_cTipos = ""
    this_cEmpsReg = ""      && emps da LINHA processada (empresa do movimento) - NAO confundir com this_cEmps (filtro digitado na tela)
    this_cDopes = ""
    this_nNumes = 0
    this_dDatas = {}
    this_cUsuars = ""
    this_cProdutos = ""
    this_cProcessos = ""
    this_cIdChaves = ""
    this_cEmpDopNums = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BusinessObject
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela = "SigPcOoL"
        THIS.this_cCampoChave = "cIdChaves"

        DODEFAULT()

        *-- Filtros nascem com os defaults do Init legado (ver
        *-- AplicarFiltrosPadrao). O form os leva para a tela no
        *-- BOParaForm() chamado pelo InicializarForm.
        THIS.AplicarFiltrosPadrao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFiltrosPadrao - valores iniciais dos filtros de selecao,
    * transcritos do bloco de defaults do Init do SCX legado (dentro do
    * "If (.poDataMgr.pnIdconn > 0)"):
    *
    *   .getDtIni.Value   = Date()
    *   .getDtFin.Value   = Date()
    *   .getArqNoms.Value = [C:\CONCILIADOR.CSV]
    *   optProcessados.Value = 1   (1-Nao Processadas / 2-Ja Processadas)
    *
    * Sem isto a tela abre com as duas datas e o caminho do arquivo em
    * BRANCO e o botao Selecionar recusa de imediato ("A Data Inicial Nao
    * Pode Ficar em Branco!!!" / "O Arquivo a Ser Gerado Precisa Ser
    * Informado!!!") - divergencia silenciosa do legado, que ja abre a tela
    * pronta para o dia corrente.
    *
    * Empresa, descricao da empresa e adquirente ficam VAZIOS de proposito:
    * o legado nao os preenche, e vazio significa "todas as empresas" /
    * "todos os adquirentes" nas duas consultas (o IIF(EMPTY(...)) de
    * Selecionar simplesmente omite a clausula do WHERE).
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarFiltrosPadrao()
        THIS.this_cEmps         = ""
        THIS.this_cDescEmps     = ""
        THIS.this_dDataIni      = DATE()
        THIS.this_dDataFin      = DATE()
        THIS.this_nProcessados  = 1
        THIS.this_cArquivo      = "C:\CONCILIADOR.CSV"
        THIS.this_cAdquirente   = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa as propriedades do registro de controle
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cTipos = ""
        THIS.this_cEmpsReg = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0
        THIS.this_dDatas = {}
        THIS.this_cUsuars = ""
        THIS.this_cProdutos = ""
        THIS.this_cProcessos = ""
        THIS.this_cIdChaves = ""
        THIS.this_cEmpDopNums = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cidchaves char(20), PK de SigPcOoL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cIdChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do registro de controle a
    * partir da linha corrente de um alias no formato de SigPcOoL/crSigPcOoL
    * (tipos, emps, dopes, numes, datas, usuars, produtos, processos,
    * cidchaves, empdopnums).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF EOF(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cTipos      = TratarNulo(tipos, "")
        THIS.this_cEmpsReg    = TratarNulo(emps, "")
        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
        THIS.this_cUsuars     = TratarNulo(usuars, "")
        THIS.this_cProdutos   = TratarNulo(produtos, "")
        THIS.this_cProcessos  = TratarNulo(processos, "")
        THIS.this_cIdChaves   = TratarNulo(cidchaves, "")
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava um registro de controle em SigPcOoL (uma linha por
    * operacao de venda processada/exportada), reproduzindo o
    * "Insert Into crSigPcOoL (...)" do metodo Processamento() do legado.
    *
    * cidchaves (PK char(20)) e gerado com fUniqueIds() quando ainda nao foi
    * atribuido - NUNCA string vazia, senao a linha seguinte do lote colide
    * no indice unico sigpcool_cidchaves (regra #22 do CLAUDE.md).
    *
    * empds/dopeds/numeds/edndests/nopers sao NOT NULL sem DEFAULT no schema
    * mas o legado nunca os preenche (o Insert Into do SCX lista so 10 das 15
    * colunas) - no fluxo legado eles chegam em branco/zero porque o cursor
    * crSigPcOoL nasce de AddCursor (estrutura completa da tabela, valores
    * default do tipo). Aqui o INSERT via SQLEXEC precisa declarar esses
    * mesmos defaults explicitamente, senao o SQL Server recusa a linha
    * inteira por tentar gravar NULL numa coluna que nao aceita.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cIdChaves, "")))
                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigPcOoL" + ;
                       " (tipos, emps, dopes, numes, empds, dopeds, numeds, datas," + ;
                       "  usuars, produtos, cidchaves, edndests, empdopnums, processos, nopers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       EscaparSQL(THIS.this_cEmpsReg) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                       EscaparSQL("") + "," + ;
                       EscaparSQL("") + "," + ;
                       FormatarNumeroSQL(0, 0) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cUsuars) + "," + ;
                       EscaparSQL(THIS.this_cProdutos) + "," + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL("") + "," + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                       EscaparSQL(THIS.this_cProcessos) + "," + ;
                       FormatarNumeroSQL(0, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao gravar controle de opera" + CHR(231) + CHR(227) + ;
                    "o processada:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao gravar controle de opera" + CHR(231) + CHR(227) + "o processada:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Corrige um registro de controle ja gravado em SigPcOoL,
    * identificado pela PK cidchaves. O legado (SIGOPVDA) nunca faz UPDATE
    * nesta tabela - cada linha e gravada uma unica vez no Processamento() e
    * nunca mais tocada - mas o metodo e implementado para completar o
    * contrato de BusinessBase.Salvar() (THIS.this_lNovoRegistro = .F.).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cIdChaves, "")))
                THIS.this_cMensagemErro = "Registro sem chave para altera" + CHR(231) + CHR(227) + "o"
            ELSE
                loc_cSQL = "UPDATE SigPcOoL SET" + ;
                           " tipos = "      + EscaparSQL(THIS.this_cTipos) + "," + ;
                           " emps = "       + EscaparSQL(THIS.this_cEmpsReg) + "," + ;
                           " dopes = "      + EscaparSQL(THIS.this_cDopes) + "," + ;
                           " numes = "      + FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                           " usuars = "     + EscaparSQL(THIS.this_cUsuars) + "," + ;
                           " produtos = "   + EscaparSQL(THIS.this_cProdutos) + "," + ;
                           " processos = "  + EscaparSQL(THIS.this_cProcessos) + "," + ;
                           " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar controle de opera" + CHR(231) + CHR(227) + ;
                        "o processada:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar controle de opera" + CHR(231) + CHR(227) + "o processada:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

