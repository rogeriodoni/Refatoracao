# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrGlx.prg] Marcador: * placeholder

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg):
*==============================================================================
* FormSigPrGlx.prg - Form Operacional: Previa da Globalizacao
* Migrado de: tasks/task618/SigPrGlx.scx (SIGPRGLX)
*
* Processo de globalizacao de saldos de producao: consolida, por
* produto/cor/tamanho, o que esta em Estoque x em Producao x Pedido,
* permite ao usuario redistribuir saldo disponivel (abas de Estoque
* Disponivel/Producao em Fase/Requisicao de material) e, ao confirmar,
* grava os movimentos de transferencia/globalizacao atraves do BO
* (SigPrGlxBO).
*
* Nao segue o padrao Page1=Lista/Page2=Dados de CRUD: o legado tem UM
* unico PageFrame (PageDados) com 6 sub-paginas de fluxo (grade
* principal, selecao de linha/estoque/disponivel/requisicao), navegadas
* por botao (Tabs=.F.), nao por cadastro.
*
* Estrutura ja entregue: DEFINE CLASS, Init, InicializarForm,
* ConfigurarPageFrame (PageFrame com as 6 paginas do legado + cabecalho da
* Page1) e Destroy (Fase 3); grade principal e botoes de acao da Page1
* (Fase 4); grade de selecao, totais, imagem e observacao da Page2
* (Fases 5-6); e, nesta Fase 6, as sub-paginas restantes - Page3 (Totais
* por Linha), Page4 (Selecionar Estoque), Page5 (Disponivel/Tamanho) e
* Page6 (Requisicao Manual de Material), esta ultima com os DOIS unicos
* lookups do form (Column1/Column5 de GradePedra -> SigCdPro, via
* FormBuscaAuxiliar). Os handlers de Click/navegacao e o processamento
* entram nas Fases 7-8.
*==============================================================================

DEFINE CLASS FormSigPrGlx AS FormBase

    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow   = 0
    DataSession  = 2
    ShowWindow = 1
    MaxButton    = .F.
    MinButton    = .F.
    FontName     = "Tahoma"
    FontSize     = 8
    *-- WindowType = 0 na classe (evita timeout em VFP9 -T/harness de teste);
    *-- producao promove para modal (1) no Init, como FormICD/FormHOR/FormGps.
    WindowType   = 0

    *--------------------------------------------------------------------------
    * Parametros recebidos de quem abre a previa - equivalentes ao
    * Lparameters _ParentForm, _Data, _ReservaAuto, _nGerEmphPdr, _Autom,
    * _numeroOp, _PorDestino do Init legado. Repassados para o BO em
    * InicializarForm (SigPrGlxBO.this_lReserva/this_nEmphPdr/
    * this_lAutomatico/this_cNumeroDaOp/this_lPorDestino).
    *--------------------------------------------------------------------------
    this_oFormPai      = .NULL.    && thisform.ParentForm (_ParentForm) - de fato FormSigPrGl2 (CREATEOBJECT("FormSigPrGlx", THIS, ...) em FormSigPrGl2.BtnProcessarClick)
    this_dDataAnalise  = {}        && thisform.Data        (_Data) - vestigial: o real 2o parametro enviado por FormSigPrGl2 eh this_nDataSessionId (NUMERICO), nao uma data
    this_lReservaAuto  = .F.       && thisform.Reserva     (_ReservaAuto)
    this_nGerEmphPdr   = 0         && thisform.EmphPdr      (_nGerEmphPdr)
    this_lAutomatico   = .F.       && thisform.Automatico   (_Autom)
    this_nNumeroDaOp   = 0         && thisform.Numerodaop   (_numeroOp) - NUMERICO: FormSigPrGl2.BtnProcessarClick envia VAL(this_cNumeroDaOp)
    this_lPorDestino   = .F.       && thisform.PorDestino   (_PorDestino)

    *-- Guarda de reentrancia dos lookups de produto da Page6: o Show() do
    *-- picker bloqueia, o foco sai e volta da celula da grade e o proprio
    *-- gatilho pode disparar de novo, empilhando um segundo picker.
    this_lLookupEmCurso = .F.

    *-- ThisForm.OldValue do legado - valor da celula ANTES da edicao, usado
    *-- pelos Valid das colunas digitaveis (Page1 e Page2, Column7/Column10)
    *-- para restaurar o conteudo quando a validacao recusa.
    *--
    *-- Tem de ser property do FORM, como no legado: medido no VFP9 em
    *-- 2026-10-06 que NEM Column, NEM Column.Text1, NEM TextBox possuem
    *-- OldValue (PEMSTATUS = .F. nos tres; ler estoura "Property OLDVALUE
    *-- is not found"). O legado captura em "ThisForm.OldValue = This.Value"
    *-- no When de cada coluna; aqui a captura vai no GotFocus das mesmas
    *-- colunas, porque BINDEVENT em "When" nao dispara de forma confiavel
    *-- (regra #3 do CLAUDE.md) e GotFocus tem o mesmo gatilho util: o
    *-- usuario entrou na celula e ainda nao digitou.
    this_nOldValue = 0

    *-- ThisForm.Liberado do legado - gate de UMA edicao da coluna
    *-- "Produzir Estq" (Column8/GradeItens Page1) apos autorizacao de
    *-- BtnAlteraqtdClick (DO FORM SigOpSen). Consumido e desarmado no
    *-- LostFocus da propria coluna.
    this_lLiberadoAlteracao = .F.

    *--------------------------------------------------------------------------
    * Init - recebe os parametros do chamador (equivalente ao Lparameters do
    * legado) e delega o resto para FormBase.Init() (que chama
    * InicializarForm()). Promove WindowType/ShowWindow para modal fora do
    * modo de teste, igual ao padrao FormICD/FormHOR/FormGps.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_dData, par_lReservaAuto, par_nGerEmphPdr, ;
                    par_lAutomatico, par_cNumeroOp, par_lPorDestino

        IF PCOUNT() >= 1
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai

                *-- CRITICO: assume a DataSessionId do pai ANTES do DODEFAULT()
                *-- (que chama InicializarForm()) - sem isto este form abre
                *-- numa sessao privada NOVA e TmpFinal/TmpFinalg (criados por
                *-- FormSigPrGl2BO.ExecutarProcessamento na sessao do PAI)
                *-- ficam invisiveis: a grade principal abriria sempre vazia.
                *-- Mesmo padrao ja adotado em FormSigPrGlp.Init.
                IF PEMSTATUS(par_oFormPai, "DataSessionId", 5)
                    THIS.DataSessionId = par_oFormPai.DataSessionId
                ENDIF
            ENDIF
        ENDIF

        *-- par_dData (2o parametro) eh vestigial - o chamador real
        *-- (FormSigPrGl2.BtnProcessarClick) envia this_nDataSessionId
        *-- (NUMERICO), que o Init legado tambem nunca lia. Guardado so
        *-- quando vier DATE/DATETIME de fato (chamada manual/teste).
        IF PCOUNT() >= 2
            IF INLIST(VARTYPE(par_dData), "D", "T")
                THIS.this_dDataAnalise = par_dData
            ENDIF
        ENDIF

        IF PCOUNT() >= 3
            IF VARTYPE(par_lReservaAuto) = "L"
                THIS.this_lReservaAuto = par_lReservaAuto
            ENDIF
        ENDIF

        IF PCOUNT() >= 4
            IF VARTYPE(par_nGerEmphPdr) = "N"
                THIS.this_nGerEmphPdr = par_nGerEmphPdr
            ENDIF
        ENDIF

        IF PCOUNT() >= 5
            IF VARTYPE(par_lAutomatico) = "L"
                THIS.this_lAutomatico = par_lAutomatico
            ENDIF
        ENDIF

        *-- par_cNumeroOp eh NUMERICO no chamador real (VAL(this_cNumeroDaOp))
        IF PCOUNT() >= 6
            IF VARTYPE(par_cNumeroOp) = "N"
                THIS.this_nNumeroDaOp = par_cNumeroOp
            ENDIF
        ENDIF

        IF PCOUNT() >= 7
            IF VARTYPE(par_lPorDestino) = "L"
                THIS.this_lPorDestino = par_lPorDestino
            ENDIF
        ENDIF

        *-- ShowWindow=1 na classe causaria TIMEOUT em VFP9 -T (top-level window
        *-- bloqueante). Fora do modo de teste, promove para modal de verdade.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object, repassa os parametros
    * recebidos no Init e monta a estrutura visual base (PageFrame + as 6
    * paginas do legado + cabecalho da Page1).
    *--------------------------------------------------------------------------
    *
    * NAO LIGAR "SET EXACT ON" NESTA TELA. Este form tem DataSession = 2,
    * logo nasce com os SETs no default do VFP (EXACT OFF) - e eh disso que
    * TODA a navegacao por item depende. Medido no VFP9 em 2026-10-06, com
    * chave de 22 chars (CPros+CodCors+CodTams) sobre indice de 34:
    *
    *   SET EXACT OFF -> SEEK prefixo = .T.   | SET KEY prefixo -> 1 linha
    *   SET EXACT ON  -> SEEK prefixo = .F.   | SET KEY prefixo -> 0 linhas
    *
    * Com EXACT ON as grades de resumo (cursor_4c_TmpSaldg/cursor_4c_TmpFabr,
    * cujos indices tem Priors/Grupos/Estos/Emps/Nops DEPOIS da chave do
    * item) ficariam PERMANENTEMENTE VAZIAS e os Valid das colunas
    * digitaveis deixariam de achar o saldo - sem erro e sem log. O
    * config.prg liga EXACT ON na sessao 1; esta sessao privada nao herda, e
    * eh justamente o que faz o codigo funcionar igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso = .F.

        THIS.Caption = IIF(THIS.this_lReservaAuto, ;
            "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
            "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
        THIS.this_cTituloForm = THIS.Caption

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")
            loc_lProsseguir = (VARTYPE(THIS.this_oBusinessObject) = "O")

            IF !loc_lProsseguir
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrGlxBO.", ;
                        "Erro em InicializarForm")
            ENDIF

            IF loc_lProsseguir
                THIS.this_oBusinessObject.this_lReserva    = THIS.this_lReservaAuto
                THIS.this_oBusinessObject.this_nEmphPdr     = THIS.this_nGerEmphPdr
                THIS.this_oBusinessObject.this_lAutomatico  = THIS.this_lAutomatico
                THIS.this_oBusinessObject.this_nNumeroDaOp  = THIS.this_nNumeroDaOp
                THIS.this_oBusinessObject.this_lPorDestino  = THIS.this_lPorDestino

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaTotaisLinha()
                THIS.ConfigurarPaginaEstoque()
                THIS.ConfigurarPaginaTamanhos()
                THIS.ConfigurarPaginaRequisicao()

                THIS.TornarControlesVisiveis(THIS)

                *-- BOParaForm DEPOIS de TornarControlesVisiveis: este ultimo
                *-- forca Visible = .T. em todo controle que nao esteja na
                *-- sua lista de excecao, e eh BOParaForm quem decide a
                *-- visibilidade REAL de Pedras/SelEstoque/Disponivel a
                *-- partir de crSigCdPam/fChecaAcesso - rodar antes faria a
                *-- decisao ser sobrescrita se a lista mudar. Tambem repoe o
                *-- titulo e o rotulo "Periodo: NN meses".
                THIS.BOParaForm()

                *-- Carga da grade principal + filtros relacionais + totais
                *-- (bloco final do Init legado). Em modo de teste/validacao
                *-- de UI nao ha dados do form pai - pular evita o aviso
                *-- "sem dados de globalizacao" num contexto sem usuario.
                IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_1.ActivePage = 1

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - cria o pgf_4c_1 (SIGPRGLX.PageDados no legado)
    * com as 6 paginas originais (Tabs=.F. - navegacao por botao, nao por
    * aba nativa) e o cabecalho (cntSombra do legado), que so existe na
    * Page1. Grid/totais/botoes de cada pagina entram nas proximas fases.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPag1, loc_oCab

        THIS.AddObject("pgf_4c_1", "PageFrame")

        WITH THIS.pgf_4c_1
            .Top       = -27
            .Left      = -1
            .Width     = 804
            .Height    = 635
            .PageCount = 6
            .Tabs      = .F.
        ENDWITH

        *-- Page1: cabecalho (cntSombra legado) - unico container de titulo
        *-- do form; as demais paginas sao sub-telas de selecao/detalhe e nao
        *-- repetem a faixa.
        loc_oPag1 = THIS.pgf_4c_1.Page1

        loc_oPag1.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = loc_oPag1.cnt_4c_Sombra

        WITH loc_oCab
            .Top         = -1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .SpecialEffect = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize  = .F.
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = ""
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize  = .F.
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = ""
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - completa a Page1 (SIGPRGLX.PageDados.Page1 no
    * legado) com a grade principal (GradeItens -> grd_4c_Dados), os 3
    * paineis de resumo (Container3 "Estoque Disponivel"/grupo-conta,
    * Container1 "Estoque Em Producao"/fase, Container5 "Periodo/Referencia
    * Analisada"), a imagem do produto (ImgFigJpg) e os totais gerais da
    * pagina (Tot_Qtd/Tot_Est/Tot_Prz/Tot_prdc/Tot_prze), alem dos botoes de
    * acao/navegacao - todos filhos DIRETOS da Page1 (mapeamento.json:
    * SIGPRGLX.PageDados.Page1.<X>). Posicoes/Top/Left copiadas de
    * tasks/task618/layout.json SEM a compensacao +27 do PageFrame, mesmo
    * padrao ja usado no cnt_4c_Sombra (Fase 3).
    *
    * grd_4c_Dados liga DIRETO em TmpFinalg - cursor da MESMA DataSession
    * privada que FormSigPrGl2BO.ExecutarProcessamento deixa aberto (nome
    * LITERAL, nao cursor_4c_ - regra documentada em
    * FormSigPrGl2.BtnProcessarClick), por isso o Init assume
    * THIS.DataSessionId = par_oFormPai.DataSessionId. Em modo de teste de
    * UI (gb_4c_ValidandoUI), TmpFinalg nao existe - cria-se aqui um
    * placeholder com a MESMA estrutura so para a tela abrir sem erro.
    * cursor_4c_TmpSaldg/cursor_4c_TmpFabr (Container3/Container1) sao os
    * equivalentes migrados de TmpSaldG/TmpFabr - mesma origem compartilhada.
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * this_lPermiteAjustarPrioridade - "If fChecaAcesso('SIGPRGLO',
    * 'PRIORIDADE')" do legado (Init, Container1/Container3.GradeDisp):
    * controla se a coluna Prior das grades de resumo eh editavel e se
    * cmd_4c_SelEstoque fica visivel.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION this_lPermiteAjustarPrioridade()
        RETURN fChecaAcesso("SIGPRGLO", "PRIORIDADE")
    ENDFUNC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag1, loc_oCnt, loc_nCol

        loc_oPag1 = THIS.pgf_4c_1.Page1

        IF !USED("TmpFinalg")
            CREATE CURSOR TmpFinalg (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), ;
                Linhas C(10), Qtds N(10,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), ;
                Fabrs N(10,3), Produzir2 N(10,3), TotVenda N(10,3), QtdMins N(10,3), ;
                KeySelM L, KeySelMP L, UsuLibs C(10))
            INDEX ON Cpros + CodCors + CodTams TAG Cpros
        ENDIF
        IF !USED("cursor_4c_TmpSaldg")
            CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), ;
                CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
            INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos + Estos + Emps TAG CPros
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
        ENDIF
        IF !USED("cursor_4c_TmpFabr")
            CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), ;
                CodCors C(4), CodTams C(4), Qtds N(12,3), Disps N(12,3), Reservs N(12,3))
            INDEX ON Cpros + CodCors + CodTams + STR(Priors, 2) + STR(Nops, 10) TAG Cpros
        ENDIF
        IF !USED("cursor_4c_TmpSaldo")
            CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), ;
                Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
            INDEX ON CPros + CodCors + CodTams TAG CPros
        ENDIF
        *-- TmpSaldU (Init legado): marca "produto com selecao manual" por
        *-- item (KeySelm/KeySelmp), consultado/alterado pelos Valid das
        *-- colunas editaveis (Column7 aqui, Column10 na Page2)
        IF !USED("TmpSaldU")
            CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L, KeySelmp L)
            INDEX ON Cpros TAG Cpros
        ENDIF

        *-- Grade principal (TmpFinalg) -----------------------------------
        loc_oPag1.AddObject("grd_4c_Dados", "Grid")

        WITH loc_oPag1.grd_4c_Dados
            .Top         = 173
            .Left        = 52
            .Width       = 586
            .Height      = 173
            .RecordSource = ""
            .ColumnCount  = 10
            .RecordSource = "TmpFinalg"
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ReadOnly     = .F.

            .Column1.ControlSource = "TmpFinalg.Cpros"
            .Column1.Header1.Caption = "Produto"
            .Column1.Width = 90
            .Column1.ReadOnly = .T.

            .Column2.ControlSource = "TmpFinalg.CodCors"
            .Column2.Header1.Caption = "Cor"
            .Column2.Width = 50
            .Column2.ReadOnly = .T.

            .Column3.ControlSource = "TmpFinalg.Flag"
            .Column3.Header1.Caption = ""
            .Column3.Width = 30

            .Column4.ControlSource = "TmpFinalg.Qtds"
            .Column4.Header1.Caption = "N" + CHR(250) + "mero"
            .Column4.Width = 60
            .Column4.ReadOnly = .T.

            .Column5.ControlSource = "TmpFinalg.Saldo"
            .Column5.Header1.Caption = "Qtde Pedido"
            .Column5.Width = 70
            .Column5.ReadOnly = .T.

            .Column6.ControlSource = "TmpFinalg.Produzir"
            .Column6.Header1.Caption = "Produzir"
            .Column6.Width = 70
            .Column6.ReadOnly = .T.

            .Column7.ControlSource = "TmpFinalg.Fabrs"
            .Column7.Header1.Caption = "Qtd Produ" + CHR(231) + CHR(227) + "o"
            .Column7.Width = 80
            .Column7.ReadOnly = .F.
            .Column7.DynamicBackColor = "RGB(255,255,204)"

            .Column8.ControlSource = "TmpFinalg.Produzir2"
            .Column8.Header1.Caption = "Produzir Estq"
            .Column8.Width = 80
            .Column8.ReadOnly = .T.
            .Column8.DynamicForeColor = "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"

            .Column9.ControlSource = "TmpFinalg.CodTams"
            .Column9.Header1.Caption = "Tam"
            .Column9.Width = 40
            .Column9.ReadOnly = .T.

            .Column10.ControlSource = "TmpFinalg.Estoque"
            .Column10.Header1.Caption = "Qtd Estoque"
            .Column10.Width = 76
            .Column10.ReadOnly = .F.
        ENDWITH

        *-- GotFocus -> Column7.SetFocus SO nas colunas que o legado redireciona
        *-- (Column1/2/5/6/9 - dump: ver lista de PROCEDURE por coluna). NUNCA
        *-- no laco inteiro de 1 a 10: Column7 (Qtd Producao), Column8
        *-- (Produzir Estq, liberada por BtnAlteraqtdClick) e Column10 (Qtd
        *-- Estoque) sao JUSTAMENTE as digitaveis - redirecionar o foco delas
        *-- torna as tres inalcancaveis e o usuario nao consegue digitar nada.
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column6.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column9.Text1, "GotFocus", THIS, "GradeItensPage1GotFocus")
        loc_oPag1.grd_4c_Dados.Column3.Text1.ReadOnly = .T.
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column3.Text1, "DblClick", THIS, "GradeItensPage1Column3DblClick")
        *-- Captura do "ThisForm.OldValue = This.Value" do When (as duas
        *-- colunas digitaveis) - sem isto o Valid nao tem com que comparar
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "CapturarOldValuePage1Col7")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "GotFocus", THIS, "CapturarOldValuePage1Col10")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "Valid", THIS, "GradeItensPage1Column7Valid")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column7.Text1, "KeyPress", THIS, "GradeItensPage1LostFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GradeItensPage1Column8LostFocus")
        *-- Column10 (Qtd Estoque) eh a SEGUNDA coluna digitavel do legado -
        *-- mesmo par Valid/LostFocus de Column7 (dump 7046-7146)
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "Valid", THIS, "GradeItensPage1Column10Valid")
        BINDEVENT(loc_oPag1.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GradeItensPage1LostFocus")
        BINDEVENT(loc_oPag1.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensPage1AfterRowColChange")

        *-- Container3 "Estoque Disponivel" (grupo/conta, TmpSaldG) --------
        loc_oPag1.AddObject("cnt_4c_Container3", "Container")
        loc_oCnt = loc_oPag1.cnt_4c_Container3
        WITH loc_oCnt
            .Top = 371
            .Left = 50
            .Width = 363
            .Height = 186
            .BackStyle = 0
            .BorderWidth = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .AutoSize = .F.
            .Top = 1
            .Left = 0
            .Width = 363
            .Height = 16
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Estoque Dispon" + CHR(237) + "vel"
        ENDWITH

        loc_oCnt.AddObject("grd_4c_DispGrupo", "Grid")
        WITH loc_oCnt.grd_4c_DispGrupo
            .Top = 15
            .Left = 3
            .Width = 358
            .Height = 147
            .RecordSource = ""
            .ColumnCount = 6
            .RecordSource = "cursor_4c_TmpSaldg"
            .RecordMark = .F.
            .DeleteMark = .F.
            .ReadOnly = .T.

            .Column1.ControlSource = "cursor_4c_TmpSaldg.Grupos"
            .Column1.Header1.Caption = "Grupo"
            .Column2.ControlSource = "cursor_4c_TmpSaldg.Estos"
            .Column2.Header1.Caption = "Conta"
            .Column3.ControlSource = "cursor_4c_TmpSaldg.Saldo"
            .Column3.Header1.Caption = "Saldo"
            .Column4.ControlSource = "cursor_4c_TmpSaldg.Saldo - cursor_4c_TmpSaldg.Disps"
            .Column4.Header1.Caption = "Reservado"
            .Column5.ControlSource = "cursor_4c_TmpSaldg.Disps"
            .Column5.Header1.Caption = "Disponivel"
            .Column6.ControlSource = "cursor_4c_TmpSaldg.Priors"
            .Column6.Header1.Caption = "Prior"
            .Column6.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
        ENDWITH
        BINDEVENT(loc_oCnt.grd_4c_DispGrupo.Column6.Text1, "KeyPress", THIS, "GradeDispGrupoColumn6LostFocus")

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .AutoSize = .F.
            .Top = 163
            .Left = 128
            .Width = 42
            .Height = 17
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Totais :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
        WITH loc_oCnt.txt_4c_Tot_Qtd
            .Top = 161
            .Left = 174
            .Width = 58
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
        WITH loc_oCnt.txt_4c_Tot_Est
            .Top = 161
            .Left = 234
            .Width = 58
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
        WITH loc_oCnt.txt_4c_Tot_Prz
            .Top = 161
            .Left = 292
            .Width = 58
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH

        *-- Container1 "Estoque Em Producao" (fase, TmpFabr) ---------------
        loc_oPag1.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = loc_oPag1.cnt_4c_Container1
        WITH loc_oCnt
            .Top = 371
            .Left = 418
            .Width = 308
            .Height = 136
            .BackStyle = 0
            .BorderWidth = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_label12", "Label")
        WITH loc_oCnt.lbl_4c_label12
            .AutoSize = .F.
            .Top = 1
            .Left = 1
            .Width = 305
            .Height = 16
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Estoque Em Produ" + CHR(231) + CHR(227) + "o"
        ENDWITH

        loc_oCnt.AddObject("grd_4c_DispFase", "Grid")
        WITH loc_oCnt.grd_4c_DispFase
            .Top = 15
            .Left = 2
            .Width = 303
            .Height = 99
            .RecordSource = ""
            .ColumnCount = 6
            .RecordSource = "cursor_4c_TmpFabr"
            .RecordMark = .F.
            .DeleteMark = .F.
            .ReadOnly = .T.

            .Column1.ControlSource = "cursor_4c_TmpFabr.Fases"
            .Column1.Header1.Caption = "Fase"
            .Column2.ControlSource = "cursor_4c_TmpFabr.Qtds"
            .Column2.Header1.Caption = "Quantidade"
            .Column3.ControlSource = "cursor_4c_TmpFabr.Disps"
            .Column3.Header1.Caption = "Disponivel"
            .Column4.ControlSource = "cursor_4c_TmpFabr.Priors"
            .Column4.Header1.Caption = "Prior"
            .Column4.ReadOnly = !THIS.this_lPermiteAjustarPrioridade()
            .Column5.ControlSource = ""
            .Column5.Header1.Caption = ""
            .Column6.ControlSource = "cursor_4c_TmpFabr.Nops"
            .Column6.Header1.Caption = "Nop"
            .Column6.Visible = .F.
        ENDWITH
        BINDEVENT(loc_oCnt.grd_4c_DispFase.Column4.Text1, "KeyPress", THIS, "GradeDispFaseColumn4LostFocus")

        loc_oCnt.AddObject("lbl_4c_label22", "Label")
        WITH loc_oCnt.lbl_4c_label22
            .AutoSize = .F.
            .Top = 115
            .Left = 102
            .Width = 42
            .Height = 17
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Totais :"
        ENDWITH
        loc_oCnt.AddObject("txt_4c_tot_qtd2", "TextBox")
        WITH loc_oCnt.txt_4c_tot_qtd2
            .Top = 113
            .Left = 145
            .Width = 61
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oCnt.AddObject("txt_4c_tot_est2", "TextBox")
        WITH loc_oCnt.txt_4c_tot_est2
            .Top = 113
            .Left = 207
            .Width = 61
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH

        *-- Container5 "Periodo/Referencia Analisada" ----------------------
        loc_oPag1.AddObject("cnt_4c_Container5", "Container")
        loc_oCnt = loc_oPag1.cnt_4c_Container5
        WITH loc_oCnt
            .Top = 129
            .Left = 36
            .Width = 727
            .Height = 40
            .BackStyle = 0
            .BorderWidth = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LabPeriodo", "Label")
        WITH loc_oCnt.lbl_4c_LabPeriodo
            .AutoSize = .F.
            .Top = 2
            .Left = 8
            .Width = 105
            .Height = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Per" + CHR(237) + "odo:"
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_LabProduto", "Label")
        WITH loc_oCnt.lbl_4c_LabProduto
            .AutoSize = .F.
            .Top = 18
            .Left = 8
            .Width = 127
            .Height = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Refer" + CHR(234) + "ncia Analisada :"
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oCnt.txt_4c_Cpros
            .Top = 16
            .Left = 141
            .Width = 108
            .Height = 19
            .ReadOnly = .T.
            .ControlSource = "TmpFinalg.Cpros"
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label13", "Label")
        WITH loc_oCnt.lbl_4c_label13
            .AutoSize = .F.
            .Top = 18
            .Left = 269
            .Width = 83
            .Height = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Qtde Vendida :"
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tot_Venda", "TextBox")
        WITH loc_oCnt.txt_4c_Tot_Venda
            .Top = 17
            .Left = 349
            .Width = 80
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .ControlSource = "TmpFinalg.TotVenda"
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label23", "Label")
        WITH loc_oCnt.lbl_4c_label23
            .AutoSize = .F.
            .Top = 18
            .Left = 448
            .Width = 164
            .Height = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Qtde M" + CHR(237) + "nima Para Produ" + CHR(231) + CHR(227) + "o :"
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Minima", "TextBox")
        WITH loc_oCnt.txt_4c_Minima
            .Top = 17
            .Left = 623
            .Width = 80
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .ControlSource = "TmpFinalg.QtdMins"
        ENDWITH

        *-- Imagem do produto corrente (SigCdPro.FigJpgs) ------------------
        loc_oPag1.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPag1.img_4c_FigJpg
            .Top = 255
            .Left = 646
            .Width = 122
            .Height = 89
            .Stretch = 1
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPag1.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgPage1DblClick")

        *-- Totais gerais da pagina (soma de TmpFinalg) --------------------
        loc_oPag1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag1.lbl_4c_Label1
            .AutoSize = .F.
            .Top = 348
            .Left = 224
            .Width = 42
            .Height = 17
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Totais :"
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_Qtd", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_Qtd
            .Top = 346
            .Left = 271
            .Width = 67
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_prdc", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_prdc
            .Top = 346
            .Left = 339
            .Width = 67
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_Est", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_Est
            .Top = 346
            .Left = 407
            .Width = 68
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_Prz", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_Prz
            .Top = 346
            .Left = 476
            .Width = 67
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH
        loc_oPag1.AddObject("txt_4c_Tot_prze", "TextBox")
        WITH loc_oPag1.txt_4c_Tot_prze
            .Top = 346
            .Left = 543
            .Width = 75
            .Height = 19
            .InputMask = "999,999.99"
            .ReadOnly = .T.
            .Value = 0
        ENDWITH

        *-- Botoes de navegacao/acao - filhos diretos da Page1, posicoes do
        *-- legado (tasks/task618/layout.json). Pedras/SelEstoque/Disponivel
        *-- nascem ocultos (Visible=.F. no SCX original); a logica que os
        *-- exibe por tipo de estoque (TipoEstos) e o restante dos Click
        *-- (Processar/TotLinha/Alteraqtd/Pedras/Cancelar) entra na fase de
        *-- eventos/handlers.
        loc_oPag1.AddObject("cmd_4c_Pedras", "CommandButton")
        WITH loc_oPag1.cmd_4c_Pedras
            .Top     = 2
            .Left    = 348
            .Width   = 75
            .Height  = 75
            .Caption = "\<Requisi" + CHR(231) + CHR(245) + "es"
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")

        loc_oPag1.AddObject("cmd_4c_SelEstoque", "CommandButton")
        WITH loc_oPag1.cmd_4c_SelEstoque
            .Top     = 2
            .Left    = 423
            .Width   = 75
            .Height  = 75
            .Caption = "\<Estoques"
            .Visible = THIS.this_lPermiteAjustarPrioridade()
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")

        loc_oPag1.AddObject("cmd_4c_Disponivel", "CommandButton")
        WITH loc_oPag1.cmd_4c_Disponivel
            .Top     = 2
            .Left    = 498
            .Width   = 75
            .Height  = 75
            .Caption = "\<Disponiveis"
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")

        loc_oPag1.AddObject("cmd_4c_TotLinha", "CommandButton")
        WITH loc_oPag1.cmd_4c_TotLinha
            .Top     = 2
            .Left    = 573
            .Width   = 75
            .Height  = 75
            .Caption = "\<Total/Linhas"
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")

        loc_oPag1.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPag1.cmd_4c_Processar
            .Top     = 2
            .Left    = 648
            .Width   = 75
            .Height  = 75
            .Caption = "\<Processar"
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        loc_oPag1.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPag1.cmd_4c_Cancelar
            .Top     = 2
            .Left    = 723
            .Width   = 75
            .Height  = 75
            .Caption = "Encerrar"
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        loc_oPag1.AddObject("cmd_4c_Alteraqtd", "CommandButton")
        WITH loc_oPag1.cmd_4c_Alteraqtd
            .Top     = 189
            .Left    = 687
            .Width   = 40
            .Height  = 40
            .Caption = ""
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Alteraqtd, "Click", THIS, "BtnAlteraqtdClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - completa a Page2 (SIGPRGLX.PageDados.Page2 no
    * legado) com a grade de selecao de linha (GradeItens -> grd_4c_Dados,
    * ligada ao cursor TmpFinal do legado), os totais GERAL (Label1 "Totais :"
    * + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc, azul) e SELECIONADO (Label2 "Qtd
    * Selecionada :" + Tot_sEst/Tot_sPrc, vermelho), a imagem do produto
    * corrente (img_4c_FigJpg), a observacao do item (obj_4c_ObsItens +
    * lbl_4c_Txt_ObsItens) e o botao Cancelar/Voltar - ver
    * tasks/task618/SigPrGlx_form_codigo_fonte.txt linhas 2386-2924.
    *
    * Page2 NAO tem nenhum campo de lookup (F4/fwBuscaExt) no legado - todas
    * as colunas da grade sao ReadOnly (dados ja resolvidos na Page1) ou
    * quantidade editavel validada por faixa (Column7/Column10.Valid, fase
    * de eventos). O unico lookup de todo o form (fwBuscaExt sobre SigCdPro,
    * por Cpros) fica em Page6.GradePedra (Requisicao Manual de Material),
    * montada em ConfigurarPaginaRequisicao(), com os dois lookups da
    * Column1/Column5 completamente implementados.
    *
    * A grade do legado foi desenhada com colunas RENOMEADAS (Column.Name)
    * fora da ordem fisica de criacao - o que importa para a fidelidade
    * visual eh a ORDEM mostrada (ColumnOrder) e nao a ordem de criacao.
    * Aqui os 10 Column1..Column10 ja nascem na ORDEM VISUAL final do
    * legado (Produto/Cor/Tam/Opera??o/N?mero/Quantidade/Estoque/Produzir/
    * Obs/Produ??o), evitando reproduzir o artefato de renomeacao do SCX.
    * Estoque (editavel, fundo amarelo) e Produ??o (editavel, fundo
    * amarelo) sao as 2 colunas que o usuario preenche manualmente - as
    * demais ficam ReadOnly, como no legado.
    *
    * cursor_4c_Selecao eh o placeholder desta grade (TmpFinal no legado) -
    * a populacao real entra em fase posterior; a estrutura aqui tem de
    * bater exatamente com o que for populado depois (mesma regra do
    * cursor placeholder usada em ConfigurarPaginaLista).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag2, loc_nCol

        loc_oPag2 = THIS.pgf_4c_1.Page2

        *-- TmpFinal (literal, nao cursor_4c_) - cursor compartilhado criado
        *-- por FormSigPrGl2BO.ExecutarProcessamento na MESMA DataSession
        *-- (THIS.DataSessionId assumida do pai em Init - ver regra na
        *-- cabeca de ConfigurarPaginaLista). Placeholder so para modo de
        *-- teste de UI, com a MESMA estrutura exportada pelo pai.
        IF !USED("TmpFinal")
            CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), ;
                Peso N(9,3), Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, ;
                Obsps M NULL, Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), ;
                Linhas C(10), Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ;
                ContaDs C(10), KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
            INDEX ON Cpros + CodCors + CodTams TAG Cpros
        ENDIF

        *-- Grade de selecao de linha (GradeItens / TmpFinal). ControlSource
        *-- remapeado conforme SIGPRGLX.Init (dump 4279-4291) - NAO pela
        *-- ordem fisica de Column no SCX (ver nota do cabecalho do metodo).
        loc_oPag2.AddObject("grd_4c_Dados", "Grid")

        WITH loc_oPag2.grd_4c_Dados
            .Top          = 181
            .Left         = 53
            .Width        = 703
            .Height       = 189
            .FontName     = "Tahoma"
            .FontSize     = 8
            .RecordSource = ""
            .ColumnCount  = 10
            .RecordSource = "TmpFinal"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight    = 17
            .GridLineColor = RGB(238, 238, 238)
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ReadOnly     = .F.

            .Column1.ControlSource = "TmpFinal.Cpros"
            .Column1.Header1.Caption = "Produto"
            .Column1.Width = 108
            .Column1.ReadOnly = .T.

            .Column2.ControlSource = "TmpFinal.CodCors"
            .Column2.Header1.Caption = "Cor"
            .Column2.Width = 38
            .Column2.ReadOnly = .T.

            .Column3.ControlSource = "TmpFinal.Dopes"
            .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column3.Width = 150
            .Column3.ReadOnly = .T.

            .Column4.ControlSource = "TmpFinal.Numes"
            .Column4.Header1.Caption = "N" + CHR(250) + "mero"
            .Column4.Width = 47
            .Column4.ReadOnly = .T.

            .Column5.ControlSource = "TmpFinal.Saldo"
            .Column5.Header1.Caption = "Quantidade"
            .Column5.Width = 65
            .Column5.ReadOnly = .T.

            .Column6.ControlSource = "TmpFinal.Produzir"
            .Column6.Header1.Caption = "Produzir"
            .Column6.Width = 65
            .Column6.ReadOnly = .T.

            .Column7.ControlSource = "TmpFinal.Estoque"
            .Column7.Header1.Caption = "Estoque"
            .Column7.Width = 65
            .Column7.ReadOnly = .F.
            .Column7.BackColor = RGB(255, 255, 204)
            .Column7.Text1.FontBold = .T.
            .Column7.Text1.BackColor = RGB(255, 255, 204)

            .Column8.ControlSource = [IIF(!EMPTY(TmpFinal.Obsps), "*", "")]
            .Column8.Header1.Caption = "Obs"
            .Column8.Width = 21
            .Column8.ReadOnly = .T.

            .Column9.ControlSource = "TmpFinal.CodTams"
            .Column9.Header1.Caption = "Tam"
            .Column9.Width = 38
            .Column9.ReadOnly = .T.

            .Column10.ControlSource = "TmpFinal.Fabrs"
            .Column10.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
            .Column10.Width = 65
            .Column10.ReadOnly = .F.
            .Column10.BackColor = RGB(255, 255, 204)
            .Column10.Text1.FontBold = .T.
            .Column10.Text1.BackColor = RGB(255, 255, 204)
        ENDWITH

        *-- Cabecalhos: Tahoma 8, alinhado ao centro, azul - igual ao legado
        *-- em todas as 10 colunas.
        FOR loc_nCol = 1 TO 10
            WITH EVALUATE("loc_oPag2.grd_4c_Dados.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Alignment  = 2
                .ForeColor  = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        FOR loc_nCol = 1 TO 10
            IF !INLIST(loc_nCol, 7, 10)
                BINDEVENT(loc_oPag2.grd_4c_Dados.Columns(loc_nCol).Text1, "GotFocus", THIS, "GradeItensPage2GotFocus")
            ENDIF
        ENDFOR
        *-- Captura do "ThisForm.OldValue = This.Value" do When (as duas
        *-- colunas digitaveis) - sem isto o Valid nao tem com que comparar
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "CapturarOldValuePage2Col7")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "GotFocus", THIS, "CapturarOldValuePage2Col10")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "Valid", THIS, "GradeItensPage2Column7Valid")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column7.Text1, "KeyPress", THIS, "GradeItensPage2LostFocus")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "Valid", THIS, "GradeItensPage2Column10Valid")
        BINDEVENT(loc_oPag2.grd_4c_Dados.Column10.Text1, "KeyPress", THIS, "GradeItensPage2LostFocus")
        BINDEVENT(loc_oPag2.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensPage2AfterRowColChange")

        *-- Totais (parte 1 de 2 - Label1 + Tot_Qtd/Tot_Est/Tot_Prz/Tot_prc,
        *-- total GERAL em azul). Parte 2 (Label2/Tot_sEst/Tot_sPrc = total
        *-- SELECIONADO em vermelho, ImgFigJpg, ObsItens, Txt_ObsItens e o
        *-- botao Cancelar) vem a seguir.
        loc_oPag2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag2.lbl_4c_Label1
            .AutoSize  = .F.
            .Top       = 372
            .Left      = 403
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Totais :"
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_Qtd", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_Qtd
            .Top       = 370
            .Left      = 449
            .Width     = 68
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 255)
            .Value     = 0
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_Est", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_Est
            .Top       = 370
            .Left      = 516
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 255)
            .Value     = 0
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_prc", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_prc
            .Top       = 370
            .Left      = 581
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 255)
            .Value     = 0
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_Prz", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_Prz
            .Top       = 370
            .Left      = 648
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(0, 0, 255)
            .Value     = 0
        ENDWITH

        *-- Totais (parte 2 de 2) -----------------------------------------
        *-- Label2/Tot_sEst/Tot_sPrc = "Qtd Selecionada" (Estoque/Producao
        *-- somados pelo usuario nas sub-paginas 4/5/6), em VERMELHO para
        *-- destacar do total GERAL (Label1, em azul) acima.
        loc_oPag2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag2.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 164
            .Left      = 383
            .Width     = 119
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtd Selecionada : "
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_sEst", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_sEst
            .Top       = 162
            .Left      = 501
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Value     = 0
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Tot_sPrc", "TextBox")
        WITH loc_oPag2.txt_4c_Tot_sPrc
            .Top       = 162
            .Left      = 567
            .Width     = 67
            .Height    = 19
            .FontBold  = .T.
            .InputMask = "999,999.99"
            .Margin    = 0
            .ReadOnly  = .T.
            .ForeColor = RGB(255, 0, 0)
            .Value     = 0
        ENDWITH

        *-- Imagem do produto da linha corrente (TmpPro.FigJpgs, carregada no
        *-- AfterRowColChange de grd_4c_Dados - fase de eventos). Nasce oculta
        *-- como no legado (Visible=.F.) - so aparece quando ha figura.
        loc_oPag2.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPag2.img_4c_FigJpg
            .Top         = 394
            .Left        = 73
            .Width       = 135
            .Height      = 92
            .Stretch     = 1
            .Visible     = .F.
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
        ENDWITH

        *-- Observacao do item corrente (TmpFinal.Obsps) - EditBox somente
        *-- leitura, com label de titulo que a fase de eventos atualiza com
        *-- o codigo do produto (Txt_ObsItens.Caption, no AfterRowColChange).
        loc_oPag2.AddObject("lbl_4c_Txt_ObsItens", "Label")
        WITH loc_oPag2.lbl_4c_Txt_ObsItens
            .AutoSize  = .F.
            .Top       = 400
            .Left      = 221
            .Width     = 119
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
        ENDWITH

        loc_oPag2.AddObject("obj_4c_ObsItens", "EditBox")
        WITH loc_oPag2.obj_4c_ObsItens
            .Top            = 415
            .Left           = 221
            .Width          = 396
            .Height         = 69
            .ReadOnly       = .T.
            .ControlSource  = "TmpFinal.Obsps"
        ENDWITH

        *-- Cancelar/Voltar da Page2 (volta para a grade principal - Page1 -
        *-- apos validar que Estoque/Producao selecionados fecham com o que
        *-- foi reservado nas sub-paginas; validacao real na fase de eventos).
        loc_oPag2.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPag2.cmd_4c_Cancelar
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarPage2Click")
    ENDPROC


    *--------------------------------------------------------------------------
    * ConfigurarPaginaTotaisLinha - Page3 (SIGPRGLX.PageDados.Page3): grade
    * de totais consolidados por linha de produto (GradeLinhas -> TmpLinha no
    * legado, alimentada pelo Click de cmd_4c_TotLinha). Toda a grade eh
    * somente-leitura no legado (Grid.ReadOnly = .T.), portanto NAO tem
    * lookup - nao ha onde digitar codigo para o picker resolver.
    *
    * Posicoes/Top/Left transcritas da secao "PROPRIEDADES DE:
    * SIGPRGLX.PageDados.Page3.*" do dump legado, SEM compensacao de
    * PageFrame (mesmo criterio das Fases 3-5 deste form, cujo
    * pgf_4c_1.Top = -27 veio cru do SCX).
    *
    * cursor_4c_Linhas eh o placeholder desta grade (TmpLinha no legado) - a
    * estrutura aqui tem de bater EXATAMENTE com a do SELECT que a popula
    * depois (regra do cursor placeholder / APPEND FROM casa por NOME).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaTotaisLinha()
        LOCAL loc_oPag3, loc_nCol

        loc_oPag3 = THIS.pgf_4c_1.Page3

        WITH loc_oPag3
            .Caption   = "Totais por Linha"
            .FontBold  = .T.
            .ForeColor = RGB(0, 128, 192)
            .Enabled   = .F.
        ENDWITH

        SET NULL ON
        IF !USED("cursor_4c_Linhas")
            CREATE CURSOR cursor_4c_Linhas ;
                (Linhas C(10) NULL, Ordem N(1) NULL, Saldo N(12,3) NULL, ;
                 Estoque N(12,3) NULL, Produzir N(12,3) NULL, Fabrs N(12,3) NULL)
        ENDIF
        SET NULL OFF

        *-- Titulo da sub-tela (Label2 + Shape4 no legado) ------------------
        loc_oPag3.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag3.lbl_4c_Label2
            .AutoSize   = .F.
            .Top        = 147
            .Left       = 173
            .Width      = 157
            .Height     = 25
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Totais por Linha"
        ENDWITH

        loc_oPag3.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag3.shp_4c_Shape4
            .Top         = 169
            .Left        = 168
            .Width       = 437
            .Height      = 2
            .BorderWidth = 1
        ENDWITH

        *-- Grade de totais por linha (GradeLinhas / TmpLinha) --------------
        loc_oPag3.AddObject("grd_4c_Linhas", "Grid")

        WITH loc_oPag3.grd_4c_Linhas
            .Top          = 181
            .Left         = 167
            .Width        = 438
            .Height       = 292
            .FontName     = "Tahoma"
            .FontSize     = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight    = 16
            .ScrollBars   = 2
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark   = .F.
            .RecordMark   = .T.
            .RecordSource = ""
            .ColumnCount  = 5
            .RecordSource = "cursor_4c_Linhas"
            *-- Grid.ReadOnly propaga para as colunas: tem de vir ANTES delas.
            .ReadOnly     = .T.

            .Column1.ControlSource = "cursor_4c_Linhas.Linhas"
            .Column1.Header1.Caption = "Linha"
            .Column1.Width     = 84
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.Sparse    = .F.
            .Column1.ReadOnly  = .T.
            .Column1.ForeColor = RGB(36, 84, 155)

            .Column2.ControlSource = "cursor_4c_Linhas.Saldo"
            .Column2.Header1.Caption = "Quantidade"
            .Column2.Width     = 80
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.Sparse    = .F.
            .Column2.ReadOnly  = .T.
            .Column2.Text1.InputMask = "999,999.99"
            .Column2.Text1.MaxLength = 10

            .Column3.ControlSource = "cursor_4c_Linhas.Estoque"
            .Column3.Header1.Caption = "Estoque"
            .Column3.Width     = 80
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.Sparse    = .F.
            .Column3.ReadOnly  = .T.
            .Column3.Text1.InputMask = "999,999.99"
            .Column3.Text1.MaxLength = 10

            .Column4.ControlSource = "cursor_4c_Linhas.Fabrs"
            .Column4.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
            .Column4.Width     = 80
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.Sparse    = .F.
            .Column4.ReadOnly  = .T.
            .Column4.Text1.InputMask = "999,999.99"
            .Column4.Text1.MaxLength = 10

            .Column5.ControlSource = "cursor_4c_Linhas.Produzir"
            .Column5.Header1.Caption = "Produzir"
            .Column5.Width     = 80
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.Sparse    = .F.
            .Column5.ReadOnly  = .T.
            .Column5.Text1.InputMask = "999,999.99"
            .Column5.Text1.MaxLength = 10
        ENDWITH

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oPag3.grd_4c_Linhas.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        *-- Voltar (CancelaLin) --------------------------------------------
        loc_oPag3.AddObject("cmd_4c_CancelaLin", "CommandButton")
        WITH loc_oPag3.cmd_4c_CancelaLin
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLinClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaEstoque - Page4 (SIGPRGLX.PageDados.Page4, "Selecionar
    * Estoque"): grade de saldo disponivel POR GRUPO/CONTA (GradeDisp ->
    * TmpDisp no legado, montado pelo Click de cmd_4c_SelEstoque a partir de
    * TmpSaldG) mais os totalizadores Qtde Pedida / Qtde Selecionada.
    *
    * No legado as Pages 4 e 5 compartilham o MESMO alias TmpDisp, recriado
    * com estruturas DIFERENTES a cada clique (Page4 traz Grupo/Conta/Prior,
    * Page5 traz Produto/Cor/Tam). Aqui cada grade recebe o SEU cursor
    * (cursor_4c_DispEstoque / cursor_4c_DispTamanho): manter o alias
    * compartilhado obrigaria a derrubar o alias ligado a outra grade, o que
    * zera o ColumnCount dela e a deixa morta pelo resto da vida do form.
    * Divergencia de CODIGO (PILAR 3) - o que o usuario ve eh identico.
    *
    * Unica coluna editavel: "Utilizar" (Column5) - quantidade que o usuario
    * tira daquele grupo/conta. As outras quatro sao ReadOnly no legado,
    * portanto esta pagina nao tem campo de lookup.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaEstoque()
        LOCAL loc_oPag4, loc_nCol

        loc_oPag4 = THIS.pgf_4c_1.Page4

        WITH loc_oPag4
            .Caption    = "Selecionar Estoque"
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor  = RGB(0, 128, 192)
            .Enabled    = .F.
        ENDWITH

        SET NULL ON
        IF !USED("cursor_4c_DispEstoque")
            CREATE CURSOR cursor_4c_DispEstoque ;
                (Priors N(2) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
                 Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
                 Disps N(12,3) NULL, Utilizar N(12,3) NULL)
        ENDIF
        SET NULL OFF

        *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
        loc_oPag4.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag4.lbl_4c_Label1
            .AutoSize   = .F.
            .Top        = 138
            .Left       = 197
            .Width      = 184
            .Height     = 25
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Selecionar Estoque"
        ENDWITH

        loc_oPag4.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag4.shp_4c_Shape4
            .Top         = 159
            .Left        = 191
            .Width       = 370
            .Height      = 2
            .BorderWidth = 1
        ENDWITH

        *-- Produto da linha corrente da grade principal (TmpFinalg.Cpros -
        *-- mesmo cursor literal usado em grd_4c_Dados.RecordSource da Page1,
        *-- NAO o cursor_4c_Dados renomeado que nunca chegou a existir aqui).
        loc_oPag4.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPag4.txt_4c_Cpros
            .Top           = 138
            .Left          = 479
            .Width         = 80
            .Height        = 19
            .FontBold      = .T.
            .Margin        = 0
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 255)
            .ControlSource = "TmpFinalg.Cpros"
        ENDWITH

        *-- Grade de disponivel por grupo/conta (GradeDisp / TmpSaldG) ------
        loc_oPag4.AddObject("grd_4c_DispEstoque", "Grid")

        WITH loc_oPag4.grd_4c_DispEstoque
            .Top          = 169
            .Left         = 191
            .Width        = 370
            .Height       = 244
            .FontSize     = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight    = 16
            .ScrollBars   = 2
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark   = .F.
            .RecordMark   = .T.
            .Panel        = 1
            .RecordSource = ""
            .ColumnCount  = 5
            .RecordSource = "cursor_4c_DispEstoque"
            *-- Grid.ReadOnly ANTES das colunas: ele propaga e sobrescreveria
            *-- o ReadOnly = .F. da coluna Utilizar.
            .ReadOnly     = .F.

            .Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
            .Column1.Header1.Caption = "Grupo"
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .T.

            .Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
            .Column2.Header1.Caption = "Conta"
            .Column2.Width     = 80
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.

            .Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
            .Column3.Header1.Caption = "Prior"
            .Column3.Width     = 24
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.

            .Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
            .Column4.Header1.Caption = "Disponivel"
            .Column4.Width     = 75
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.

            .Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"
            .Column5.Header1.Caption = "Utilizar"
            .Column5.Width     = 75
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .F.
            .Column5.Text1.FontBold = .T.
        ENDWITH
        BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "Valid", THIS, "GradeDispEstoqueColumn5Valid")
        BINDEVENT(loc_oPag4.grd_4c_DispEstoque.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oPag4.grd_4c_DispEstoque.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Verdana"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        *-- Totalizadores da selecao ----------------------------------------
        loc_oPag4.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag4.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 418
            .Left      = 220
            .Width     = 82
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde Pedida : "
        ENDWITH

        loc_oPag4.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag4.lbl_4c_Label3
            .AutoSize  = .F.
            .Top       = 437
            .Left      = 192
            .Width     = 110
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde Selecionada : "
        ENDWITH

        loc_oPag4.AddObject("txt_4c_Qt_pedida", "TextBox")
        WITH loc_oPag4.txt_4c_Qt_pedida
            .Top       = 413
            .Left      = 312
            .Width     = 67
            .Height    = 23
            .InputMask = "9,999.99"
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        loc_oPag4.AddObject("txt_4c_Qt_Selec", "TextBox")
        WITH loc_oPag4.txt_4c_Qt_Selec
            .Top       = 436
            .Left      = 312
            .Width     = 67
            .Height    = 23
            .Alignment = 3
            .InputMask = "9,999.99"
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        *-- Voltar (CancelaDisp) --------------------------------------------
        loc_oPag4.AddObject("cmd_4c_CancelaDisp", "CommandButton")
        WITH loc_oPag4.cmd_4c_CancelaDisp
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage4Click")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaTamanhos - Page5 (SIGPRGLX.PageDados.Page5,
    * "Disponivel/Tamanho"): grade do saldo disponivel QUEBRADO POR TAMANHO
    * (GradeDisp -> TmpDisp no legado, montado pelo Click de
    * cmd_4c_Disponivel a partir de TmpSaldo) mais os mesmos totalizadores
    * Qtde Pedida / Qtde Selecionada da Page4.
    *
    * Cursor proprio (cursor_4c_DispTamanho) pelo motivo explicado em
    * ConfigurarPaginaEstoque. Unica coluna editavel: "Utilizar" (Column5) -
    * as demais sao ReadOnly, portanto esta pagina nao tem lookup.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaTamanhos()
        LOCAL loc_oPag5, loc_nCol

        loc_oPag5 = THIS.pgf_4c_1.Page5

        WITH loc_oPag5
            .Caption   = "Disponivel/Tamanho"
            .FontBold  = .T.
            .ForeColor = RGB(0, 128, 192)
            .Enabled   = .F.
        ENDWITH

        SET NULL ON
        IF !USED("cursor_4c_DispTamanho")
            CREATE CURSOR cursor_4c_DispTamanho ;
                (Cpros C(14) NULL, CodCors C(10) NULL, CodTams C(10) NULL, ;
                 Disps N(12,3) NULL, Utilizar N(12,3) NULL)
        ENDIF
        SET NULL OFF

        loc_oPag5.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag5.lbl_4c_Label1
            .AutoSize   = .F.
            .Top        = 150
            .Left       = 246
            .Width      = 205
            .Height     = 25
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Selecionar Tamanhos"
        ENDWITH

        loc_oPag5.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag5.shp_4c_Shape4
            .Top         = 171
            .Left        = 240
            .Width       = 328
            .Height      = 2
            .BorderWidth = 1
        ENDWITH

        loc_oPag5.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPag5.txt_4c_Cpros
            .Top           = 151
            .Left          = 486
            .Width         = 80
            .Height        = 19
            .FontBold      = .T.
            .Margin        = 0
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 255)
            .ControlSource = "TmpFinalg.Cpros"
        ENDWITH

        loc_oPag5.AddObject("grd_4c_DispTamanho", "Grid")

        WITH loc_oPag5.grd_4c_DispTamanho
            .Top          = 181
            .Left         = 239
            .Width        = 327
            .Height       = 228
            .FontName     = "Tahoma"
            .FontSize     = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight    = 16
            .ScrollBars   = 2
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark   = .F.
            .RecordMark   = .T.
            .Panel        = 1
            .RecordSource = ""
            .ColumnCount  = 5
            .RecordSource = "cursor_4c_DispTamanho"
            .ReadOnly     = .F.

            .Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
            .Column1.Header1.Caption = "Produto"
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .T.

            .Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
            .Column2.Header1.Caption = "Cor"
            .Column2.Width     = 38
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column2.Text1.FontBold = .T.

            .Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
            .Column3.Header1.Caption = "Tam"
            .Column3.Width     = 24
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column3.Text1.FontBold = .T.

            .Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
            .Column4.Header1.Caption = "Disponivel"
            .Column4.Width     = 75
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.

            .Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"
            .Column5.Header1.Caption = "Utilizar"
            .Column5.Width     = 75
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .F.
            .Column5.Text1.FontBold = .T.
        ENDWITH
        BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "Valid", THIS, "GradeDispTamanhoColumn5Valid")
        BINDEVENT(loc_oPag5.grd_4c_DispTamanho.Column5.Text1, "KeyPress", THIS, "GradeDispColumn5LostFocus")

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oPag5.grd_4c_DispTamanho.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Verdana"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        loc_oPag5.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag5.lbl_4c_Label2
            .AutoSize  = .F.
            .Top       = 415
            .Left      = 289
            .Width     = 82
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde Pedida : "
        ENDWITH

        loc_oPag5.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag5.lbl_4c_Label3
            .AutoSize  = .F.
            .Top       = 434
            .Left      = 261
            .Width     = 110
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qtde Selecionada : "
        ENDWITH

        loc_oPag5.AddObject("txt_4c_Qt_pedida", "TextBox")
        WITH loc_oPag5.txt_4c_Qt_pedida
            .Top       = 410
            .Left      = 379
            .Width     = 67
            .Height    = 23
            .InputMask = "9,999.99"
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        loc_oPag5.AddObject("txt_4c_Qt_Selec", "TextBox")
        WITH loc_oPag5.txt_4c_Qt_Selec
            .Top       = 433
            .Left      = 379
            .Width     = 67
            .Height    = 23
            .Alignment = 3
            .InputMask = "9,999.99"
            .ReadOnly  = .T.
            .Value     = 0
        ENDWITH

        loc_oPag5.AddObject("cmd_4c_CancelaDisp", "CommandButton")
        WITH loc_oPag5.cmd_4c_CancelaDisp
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage5Click")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaRequisicao - Page6 (SIGPRGLX.PageDados.Page6,
    * "Requisicao"): "Requisicao Manual de Material" (GradePedra -> SelPedra
    * no legado, aberta pelo Click de cmd_4c_Pedras). Esta eh a UNICA pagina
    * do form que tem campo de lookup - as duas colunas de produto
    * (Column1 "Produto" = material requisitado e Column5 "Produto" =
    * material substituto) tem Valid que abre o picker de SigCdPro:
    *
    *   SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid (linha 8093)
    *   SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid (linha 8176)
    *   CreateObject('fwBuscaExt', ..., 'SigCdPro', 'crListaRemota',
    *                'CPros', This.Value, 'Selecao', 1000)
    *     -> mAddColuna('CPros','','Codigo') / mAddColuna('DPros','','Descricao')
    *
    * Column2 (Descricao) e Column3 (Uni) sao preenchidas pelo proprio
    * lookup da Column1 (o Replace SelPedra.Dpros/Cunis do legado) e tem
    * When -> Return .f. (nao digitaveis). Column4 (Qtde) e Column5 so
    * aceitam digitacao com a Column1 preenchida - o When do legado eh
    * Return (Not EMPTY(Column1.Text1.Value)), reproduzido como guarda no
    * inicio dos handlers.
    *
    * cursor_4c_Requisicao eh o placeholder de SelPedra; o legado garante ao
    * menos UMA linha em branco (Init: "If Reccount('SelPedra') = 0 / Append
    * Blank"), que eh onde o usuario digita o primeiro material.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaRequisicao()
        LOCAL loc_oPag6, loc_nCol

        loc_oPag6 = THIS.pgf_4c_1.Page6

        WITH loc_oPag6
            .Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
            .FontBold  = .T.
            .ForeColor = RGB(0, 128, 192)
            .Enabled   = .F.
        ENDWITH

        SET NULL ON
        IF !USED("cursor_4c_Requisicao")
            CREATE CURSOR cursor_4c_Requisicao ;
                (Cpros C(14) NULL, Dpros C(65) NULL, Cunis C(3) NULL, ;
                 Qtds N(12,3) NULL, Cpro2s C(14) NULL)
        ENDIF
        SET NULL OFF

        *-- Linha em branco inicial (Init legado: If Reccount('SelPedra') = 0
        *-- / Append Blank) - sem ela a grade abre sem nenhuma celula onde
        *-- digitar o primeiro material.
        IF USED("cursor_4c_Requisicao")
            IF RECCOUNT("cursor_4c_Requisicao") = 0
                SELECT cursor_4c_Requisicao
                APPEND BLANK
                REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
                        Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
                GO TOP IN cursor_4c_Requisicao
            ENDIF
        ENDIF

        *-- Titulo da sub-tela (Label1 + Shape4) ----------------------------
        loc_oPag6.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag6.lbl_4c_Label1
            .AutoSize   = .F.
            .Top        = 168
            .Left       = 132
            .Width      = 294
            .Height     = 25
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .FontItalic = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Caption    = "Requisi" + CHR(231) + CHR(227) + "o Manual de Material"
        ENDWITH

        loc_oPag6.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPag6.shp_4c_Shape4
            .Top         = 189
            .Left        = 119
            .Width       = 500
            .Height      = 2
            .BorderWidth = 1
        ENDWITH

        *-- Produto da linha corrente da grade principal (TmpFinalg.Cpros) --
        loc_oPag6.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPag6.txt_4c_Cpros
            .Top           = 169
            .Left          = 487
            .Width         = 80
            .Height        = 19
            .FontBold      = .T.
            .Margin        = 0
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 255)
            .ControlSource = "TmpFinalg.Cpros"
        ENDWITH

        *-- Grade de requisicao manual (GradePedra / SelPedra) --------------
        loc_oPag6.AddObject("grd_4c_Pedra", "Grid")

        WITH loc_oPag6.grd_4c_Pedra
            .Top          = 197
            .Left         = 119
            .Width        = 500
            .Height       = 261
            .FontSize     = 8
            .RowHeight    = 16
            .ScrollBars   = 2
            .GridLineColor = RGB(238, 238, 238)
            .DeleteMark   = .F.
            .RecordMark   = .T.
            .RecordSource = ""
            .ColumnCount  = 5
            .RecordSource = "cursor_4c_Requisicao"
            *-- Grid.ReadOnly ANTES das colunas: propaga e sobrescreveria o
            *-- ReadOnly = .F. das colunas digitaveis (1, 4 e 5).
            .ReadOnly     = .F.

            .Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
            .Column1.Header1.Caption = "Produto"
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.ReadOnly  = .F.
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.MaxLength   = 14
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)
            .Column1.Text1.ToolTipText = "F4 ou duplo clique: buscar produto"

            .Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width     = 200
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column2.Text1.FontBold    = .T.
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            .Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
            .Column3.Header1.Caption = "Uni"
            .Column3.Width     = 30
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column3.Text1.FontBold    = .T.
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .T.
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            .Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
            .Column4.Header1.Caption = "Qtde"
            .Column4.Width     = 75
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .F.
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.Margin      = 0
            .Column4.Text1.ForeColor   = RGB(0, 0, 0)
            .Column4.Text1.BackColor   = RGB(255, 255, 255)

            .Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"
            .Column5.Header1.Caption = "Produto"
            .Column5.Width     = 80
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .F.
            .Column5.Text1.BorderStyle = 0
            .Column5.Text1.Margin      = 0
            .Column5.Text1.MaxLength   = 14
            .Column5.Text1.ForeColor   = RGB(0, 0, 0)
            .Column5.Text1.BackColor   = RGB(255, 255, 255)
            .Column5.Text1.ToolTipText = "F4 ou duplo clique: buscar produto substituto"
        ENDWITH

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oPag6.grd_4c_Pedra.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Verdana"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        *-- LOOKUPS -------------------------------------------------------
        *-- Column1.Text1 e Column5.Text1 do legado tem Valid com
        *-- fwBuscaExt sobre SigCdPro. BINDEVENT "Valid" NAO dispara de
        *-- forma confiavel em TextBox (regra #3), entao o gatilho vai no
        *-- KeyPress (ENTER/TAB/F4 - o equivalente a "sair do campo") e no
        *-- DblClick, que eh o atalho canonico de lookup do sistema novo.
        BINDEVENT(loc_oPag6.grd_4c_Pedra.Column1.Text1, "KeyPress", THIS, "GrdPedraProdutoKeyPress")
        BINDEVENT(loc_oPag6.grd_4c_Pedra.Column1.Text1, "DblClick", THIS, "GrdPedraProdutoDblClick")

        BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "KeyPress", THIS, "GrdPedraSubstitutoKeyPress")
        BINDEVENT(loc_oPag6.grd_4c_Pedra.Column5.Text1, "DblClick", THIS, "GrdPedraSubstitutoDblClick")

        *-- Voltar (CancelaDisp) --------------------------------------------
        loc_oPag6.AddObject("cmd_4c_CancelaDisp", "CommandButton")
        WITH loc_oPag6.cmd_4c_CancelaDisp
            .Top         = 12
            .Left        = 704
            .Width       = 75
            .Height      = 75
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .WordWrap    = .T.
            .Cancel      = .T.
            .Caption     = "Voltar"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPag6.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDispPage6Click")
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdPedraProdutoKeyPress / GrdPedraProdutoDblClick - gatilhos do lookup
    * do MATERIAL REQUISITADO (GradePedra.Column1.Text1.Valid no legado).
    * PUBLIC (sem PROTECTED): BINDEVENT so enxerga metodo publico.
    * LPARAMETERS obrigatorio - sem ele o primeiro keystroke estoura
    * "No PARAMETER statement is found".
    *--------------------------------------------------------------------------
    PROCEDURE GrdPedraProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        *-- Guarda obrigatoria: sem ela o picker abriria a CADA tecla
        *-- digitada e o usuario nao conseguiria terminar o codigo.
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        THIS.AbrirLookupProdutoRequisicao()
    ENDPROC

    PROCEDURE GrdPedraProdutoDblClick()
        THIS.AbrirLookupProdutoRequisicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupProdutoRequisicao - lookup do material requisitado
    * (Column1 "Produto"), transcrito de
    * SIGPRGLX.PageDados.Page6.GradePedra.Column1.Text1.Valid:
    *
    *   If Not Empty(This.Value)
    *       loLista = CreateObject('fwBuscaExt', ..., 'SigCdPro',
    *                              'crListaRemota', 'CPros', This.Value, 'Selecao', 1000)
    *       If Not loLista.plAchouRegistro
    *           loLista.mAddColuna('CPros','','Codigo')
    *           loLista.mAddColuna('DPros','','Descricao')
    *           loLista.Show()
    *       EndIf
    *       This.Value = CrListaRemota.Cpros
    *       Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
    *               SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra
    *       Use In crListaRemota
    *       ThisForm.PageDados.Page6.GradePedra.Refresh
    *   EndIf
    *
    * O Replace de Dpros/Cunis eh o que preenche as colunas Descricao e Uni,
    * que sao ReadOnly e nao tem outra origem - sem ele a linha fica so com
    * o codigo. Cunis vem junto do mesmo SELECT (por isso o lookup consulta
    * CPros/DPros/Cunis, mesmo exibindo so as duas primeiras no picker,
    * exatamente como o legado, cujo fwBuscaExt traz a linha inteira).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupProdutoRequisicao()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        LOCAL loc_oGrade, loc_oCampo

        IF THIS.this_lLookupEmCurso
            RETURN
        ENDIF
        THIS.this_lLookupEmCurso = .T.

        TRY
            loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
            loc_oCampo = loc_oGrade.Column1.Text1

            *-- Legado: "If Not Empty(This.Value)" - campo vazio nao consulta.
            IF !EMPTY(loc_oCampo.Value) AND !loc_oCampo.ReadOnly
                loc_cValor = ALLTRIM(loc_oCampo.Value)

                IF USED("cursor_4c_BuscaProduto")
                    USE IN cursor_4c_BuscaProduto
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", ;
                    "cursor_4c_BuscaProduto", ;
                    "CPros", ;
                    loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    *-- this_lAchouRegistro: o Init ja resolveu o match exato
                    *-- (1 registro) - nesse caso o picker NAO deve aparecer.
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    *-- Atribuicao SO sob a guarda de selecao: fora dela, o
                    *-- usuario que desiste do picker teria o campo ZERADO.
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                        IF !EOF("cursor_4c_BuscaProduto")
                            loc_oCampo.Value = ALLTRIM(cursor_4c_BuscaProduto.CPros)

                            IF USED("cursor_4c_Requisicao") AND !EOF("cursor_4c_Requisicao")
                                REPLACE Cpros WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
                                        Dpros WITH TratarNulo(cursor_4c_BuscaProduto.DPros, ""), ;
                                        Cunis WITH TratarNulo(cursor_4c_BuscaProduto.Cunis, "") ;
                                   IN cursor_4c_Requisicao
                            ENDIF
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_BuscaProduto")
                        USE IN cursor_4c_BuscaProduto
                    ENDIF

                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ENDIF

                loc_oGrade.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao buscar Produto")
        ENDTRY

        *-- Liberado DEPOIS do ENDTRY para valer tambem quando o CATCH dispara.
        THIS.this_lLookupEmCurso = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdPedraSubstitutoKeyPress / GrdPedraSubstitutoDblClick - gatilhos do
    * lookup do MATERIAL SUBSTITUTO (GradePedra.Column5.Text1.Valid).
    *--------------------------------------------------------------------------
    PROCEDURE GrdPedraSubstitutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        THIS.AbrirLookupProdutoSubstituto()
    ENDPROC

    PROCEDURE GrdPedraSubstitutoDblClick()
        THIS.AbrirLookupProdutoSubstituto()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupProdutoSubstituto - lookup do material substituto
    * (Column5 "Produto"), transcrito de
    * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1.Valid. Igual ao da
    * Column1, SEM o Replace de Dpros/Cunis - o legado so devolve o codigo
    * aqui, porque Descricao/Uni da linha pertencem ao material PRINCIPAL.
    *
    * A guarda inicial reproduz o When do legado
    * (Return (Not EMPTY(...Column1.Text1.Value))): sem material principal
    * digitado, a coluna do substituto nao aceita entrada e, portanto, nao
    * abre o picker.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupProdutoSubstituto()
        LOCAL loc_oBusca, loc_cValor, loc_oErro
        LOCAL loc_oGrade, loc_oCampo

        IF THIS.this_lLookupEmCurso
            RETURN
        ENDIF
        THIS.this_lLookupEmCurso = .T.

        TRY
            loc_oGrade = THIS.pgf_4c_1.Page6.grd_4c_Pedra
            loc_oCampo = loc_oGrade.Column5.Text1

            *-- When do legado: so ha substituto se ha material principal.
            IF EMPTY(loc_oGrade.Column1.Text1.Value)
                MsgAviso("Informe primeiro o Produto da requisi" + CHR(231) + ;
                         CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF !EMPTY(loc_oCampo.Value) AND !loc_oCampo.ReadOnly
                    loc_cValor = ALLTRIM(loc_oCampo.Value)

                    IF USED("cursor_4c_BuscaProduto")
                        USE IN cursor_4c_BuscaProduto
                    ENDIF

                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdPro", ;
                        "cursor_4c_BuscaProduto", ;
                        "CPros", ;
                        loc_cValor, ;
                        "Sele" + CHR(231) + CHR(227) + "o")

                    IF VARTYPE(loc_oBusca) = "O"
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                        ENDIF

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                            IF !EOF("cursor_4c_BuscaProduto")
                                loc_oCampo.Value = ALLTRIM(cursor_4c_BuscaProduto.CPros)

                                IF USED("cursor_4c_Requisicao") AND !EOF("cursor_4c_Requisicao")
                                    REPLACE Cpro2s WITH ALLTRIM(cursor_4c_BuscaProduto.CPros) ;
                                       IN cursor_4c_Requisicao
                                ENDIF
                            ENDIF
                        ENDIF

                        IF USED("cursor_4c_BuscaProduto")
                            USE IN cursor_4c_BuscaProduto
                        ENDIF

                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                    ENDIF

                    *-- LostFocus do legado: garante sempre UMA linha em branco
                    *-- no fim, para o usuario digitar o proximo material.
                    THIS.GarantirLinhaLivreRequisicao()

                    loc_oGrade.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao buscar Produto")
        ENDTRY

        THIS.this_lLookupEmCurso = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirLinhaLivreRequisicao - transcricao do LostFocus de
    * SIGPRGLX.PageDados.Page6.GradePedra.Column5.Text1:
    *
    *   SELECT SelPedra
    *   xPosicao = RECNO()
    *   Locate For Empty(Cpros)
    *   If Eof()
    *       Append Blank
    *   EndIf
    *   Locate for Recno() = xPosicao
    *
    * Mantem sempre ao menos uma linha em branco disponivel na grade e
    * devolve o ponteiro para onde o usuario estava. O KEYBOARD '{DNARROW}'
    * do legado (que empurra o cursor para a linha de baixo) nao eh
    * reproduzido aqui: la ele vinha do LostFocus real da celula; neste
    * ponto o foco ja voltou do picker e o salto adicional tiraria o
    * usuario da linha que ele acabou de preencher.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GarantirLinhaLivreRequisicao()
        LOCAL loc_nPosicao

        IF !USED("cursor_4c_Requisicao")
            RETURN
        ENDIF

        SELECT cursor_4c_Requisicao
        loc_nPosicao = RECNO()

        LOCATE FOR EMPTY(cursor_4c_Requisicao.Cpros)
        IF EOF("cursor_4c_Requisicao")
            APPEND BLANK
            REPLACE Cpros WITH "", Dpros WITH "", Cunis WITH "", ;
                    Qtds  WITH 0,  Cpro2s WITH "" IN cursor_4c_Requisicao
        ENDIF

        IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("cursor_4c_Requisicao")
            GOTO loc_nPosicao IN cursor_4c_Requisicao
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1GotFocus - "GotFocus -> Column7.Text1.SetFocus" das
    * colunas 1/2/4/5/6/9/10 do legado (dump 6730-6793): a grade so tem UMA
    * coluna de entrada de verdade (Fabrs); clicar em qualquer outra
    * redireciona o foco para ela.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1GotFocus()
        THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * CapturarOldValuePage1 / CapturarOldValuePage2 - "ThisForm.OldValue =
    * This.Value" do When das colunas digitaveis (Page1 e Page2,
    * Column7/Column10). Guardam o valor ANTES da edicao para que o Valid
    * possa restaura-lo quando recusar a entrada.
    *
    * Ligados ao GotFocus (nao ao When): BINDEVENT em "When" de TextBox de
    * Grid nao dispara de forma confiavel (regra #3 do CLAUDE.md), e
    * GotFocus cobre o mesmo instante - a celula acabou de receber o foco e
    * o usuario ainda nao digitou.
    *
    * par_nColuna: 7 ou 10 (a coluna que ganhou o foco).
    *--------------------------------------------------------------------------
    PROCEDURE CapturarOldValuePage1()
        LPARAMETERS par_nColuna

        DO CASE
            CASE par_nColuna = 10
                THIS.this_nOldValue = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1.Value
            OTHERWISE
                THIS.this_nOldValue = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1.Value
        ENDCASE
    ENDPROC

    PROCEDURE CapturarOldValuePage1Col7()
        THIS.CapturarOldValuePage1(7)
    ENDPROC

    PROCEDURE CapturarOldValuePage1Col10()
        THIS.CapturarOldValuePage1(10)
    ENDPROC

    PROCEDURE CapturarOldValuePage2Col7()
        THIS.this_nOldValue = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1.Value
    ENDPROC

    PROCEDURE CapturarOldValuePage2Col10()
        THIS.this_nOldValue = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column10.Text1.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1Column3DblClick - Column3 (Flag) DblClick/Click do
    * legado (dump 6946-6961): atalho para a pagina de selecao de linha.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1Column3DblClick()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_1.Page2.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1Column7Valid - transcricao de GradeItens.Column7.Text1.
    * Valid (dump 6833-6913): valida a quantidade de Fabrs (producao em
    * fase) reservada manualmente para o item corrente e redistribui o
    * saldo em cursor_4c_TmpSaldo/cursor_4c_TmpFabr/TmpFinal.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1Column7Valid()
        LOCAL loc_oCampo, loc_nValorNovo, loc_nXBaixa, loc_lOk

        loc_oCampo    = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column7.Text1
        loc_nValorNovo = loc_oCampo.Value

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
        ENDIF
        IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelmp
            IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de OP." + CHR(13) + ;
                    "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
                    "Confirmar")
                loc_oCampo.Value = THIS.this_nOldValue
                RETURN
            ENDIF
        ENDIF

        loc_lOk = .T.
        DO CASE
            CASE loc_nValorNovo = THIS.this_nOldValue
                * nada a fazer
            CASE loc_nValorNovo < 0
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE loc_nValorNovo > TmpFinalg.Saldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE loc_nValorNovo > (TmpFinalg.Saldo - TmpFinalg.Estoque)
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE !SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, ;
                    "cursor_4c_TmpSaldo", "CPros") AND TmpFinalg.Produzir != TmpFinalg.Saldo
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
                    "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            OTHERWISE
                IF cursor_4c_TmpSaldo.Fabrs >= loc_nValorNovo
                    REPLACE DispFs WITH Fabrs - loc_nValorNovo IN cursor_4c_TmpSaldo
                    REPLACE Produzir WITH Saldo - Estoque - loc_nValorNovo IN TmpFinalg

                    SELECT TmpFinalg
                    REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                            QtdMins - Produzir, 0), ;
                            UsuLibs WITH " " IN TmpFinalg

                    REPLACE KeySelmp WITH .F. IN TmpSaldU

                    SELECT cursor_4c_TmpSaldo
                    loc_nXBaixa = Fabrs - DispFs
                    SELECT cursor_4c_TmpFabr
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    REPLACE Disps WITH 0 WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE cursor_4c_TmpFabr.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            cursor_4c_TmpFabr.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            cursor_4c_TmpFabr.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
                            REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
                            REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Qtds
                        ENDIF
                        SELECT cursor_4c_TmpFabr
                    ENDSCAN

                    loc_nXBaixa = loc_nValorNovo
                    SELECT TmpFinal
                    SET ORDER TO
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    REPLACE Fabrs WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
                            AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa >= 0
                        IF (TmpFinal.Saldo - TmpFinal.Estoque) >= loc_nXBaixa
                            REPLACE TmpFinal.Fabrs WITH TmpFinal.Fabrs + loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Estoque)
                            REPLACE TmpFinal.Fabrs WITH (TmpFinal.Saldo - TmpFinal.Estoque)
                        ENDIF
                        REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
                        SELECT TmpFinal
                    ENDSCAN
                ELSE
                    MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto Em " + ;
                        "Produ" + CHR(231) + CHR(227) + "o para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lOk = .F.
                ENDIF
        ENDCASE

        IF !loc_lOk
            loc_oCampo.Value = THIS.this_nOldValue
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1Column10Valid - transcricao de GradeItens.Column10.Text1.
    * Valid (dump 7046-7128): irma exata da Column7 acima, mas para a
    * quantidade de ESTOQUE (TmpFinalg.Estoque). Redistribui o saldo em
    * cursor_4c_TmpSaldo (Disps) -> cursor_4c_TmpSaldg (Disps por
    * grupo/conta) -> TmpFinal (Estoque linha a linha).
    *
    * Duas diferencas de verbo em relacao a Column7, que vem do legado e NAO
    * sao simetria quebrada por descuido:
    *   - o teto eh (Saldo - Fabrs), nao (Saldo - Estoque);
    *   - no cursor_4c_TmpSaldg o legado SATURA primeiro (Replace Disps With
    *     Saldo While ...) e so depois DESCONTA xBaixa no Scan, enquanto na
    *     Column7 ele ZERA (Replace Disps With 0) e depois SOMA. Transcrito
    *     literalmente (regra #17 do CLAUDE.md).
    *
    * UNICA divergencia consciente: no 5o Case o legado escreve
    * "This.Value = This.Value = Thisform.OldValue" - um typo que avalia a
    * comparacao e grava um LOGICO num campo numerico. Aqui restaura o valor
    * anterior (que eh o que os outros quatro Case fazem e o que o typo
    * claramente pretendia); transcrever o typo gravaria .T./.F. em
    * TmpFinalg.Estoque e estouraria "Data type mismatch".
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1Column10Valid()
        LOCAL loc_oCampo, loc_nValorNovo, loc_nXBaixa, loc_lOk

        loc_oCampo     = THIS.pgf_4c_1.Page1.grd_4c_Dados.Column10.Text1
        loc_nValorNovo = loc_oCampo.Value

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        IF !SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
        ENDIF
        IF loc_nValorNovo != THIS.this_nOldValue AND TmpSaldU.KeySelm
            IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + CHR(13) + ;
                    "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", ;
                    "Confirmar")
                loc_oCampo.Value = THIS.this_nOldValue
                RETURN
            ENDIF
        ENDIF

        loc_lOk = .T.
        DO CASE
            CASE loc_nValorNovo = THIS.this_nOldValue
                * nada a fazer
            CASE loc_nValorNovo < 0
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE loc_nValorNovo > TmpFinalg.Saldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE loc_nValorNovo > (TmpFinalg.Saldo - TmpFinalg.Fabrs)
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            CASE !SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, ;
                    "cursor_4c_TmpSaldo", "CPros") AND TmpFinalg.Produzir != TmpFinalg.Saldo
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
                    "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lOk = .F.
            OTHERWISE
                IF cursor_4c_TmpSaldo.Saldo >= loc_nValorNovo
                    REPLACE Disps WITH Saldo - loc_nValorNovo IN cursor_4c_TmpSaldo
                    REPLACE Produzir WITH Saldo - Fabrs - loc_nValorNovo IN TmpFinalg

                    SELECT TmpFinalg
                    REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                            QtdMins - Produzir, 0), ;
                            UsuLibs WITH " " IN TmpFinalg

                    REPLACE KeySelm WITH .F. IN TmpSaldU

                    SELECT cursor_4c_TmpSaldo
                    loc_nXBaixa = Saldo - Disps

                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO CPros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    REPLACE Disps WITH Saldo WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
                            REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
                            REPLACE cursor_4c_TmpSaldg.Disps WITH 0
                        ENDIF
                        SELECT cursor_4c_TmpSaldg
                    ENDSCAN

                    loc_nXBaixa = loc_nValorNovo
                    SELECT TmpFinal
                    SET ORDER TO
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                            TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                            TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
                            REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa IN TmpFinal
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
                            REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs) IN TmpFinal
                        ENDIF
                        REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
                        SELECT TmpFinal
                    ENDSCAN
                ELSE
                    MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " saldo dispon" + CHR(237) + "vel deste produto no " + ;
                        "estoque para reservar...", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lOk = .F.
                ENDIF
        ENDCASE

        IF !loc_lOk
            loc_oCampo.Value = THIS.this_nOldValue
        ENDIF

        SELECT TmpFinalg
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarVisibilidadeDisponivel - "When" de GradeItens.Column10.Text1
    * (Page1, dump 7029-7043): o botao "Disponiveis" so aparece quando o
    * form esta em modo RESERVA, o item corrente ainda nao tem estoque
    * reservado e o GRUPO do produto eh de tipo de estoque 3 ou 4.
    *
    *   ThisForm.PageDados.Page1.Disponivel.Visible = .f.
    *   If ThisForm.Reserva And TmpFinalg.Estoque = 0
    *       ... CursorQuery SigCdPro -> Cgrus -> SigCdGrp -> TipoEstos
    *       If InList(CrSigCdGrp.TipoEstos,3,4) -> Visible = .t.
    *
    * Vive num metodo proprio, chamado de AfterRowColChange (troca de item)
    * e de CarregarLista (primeira linha), porque BINDEVENT em "When" de
    * TextBox de Grid nao dispara de forma confiavel (regra #3 do
    * CLAUDE.md) - AfterRowColChange cobre exatamente o mesmo gatilho util,
    * que eh "o item corrente mudou".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarVisibilidadeDisponivel()
        LOCAL loc_nTipoEsto

        THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.

        IF !THIS.this_lReservaAuto
            RETURN
        ENDIF
        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF
        IF TmpFinalg.Estoque != 0
            RETURN
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_nTipoEsto = THIS.this_oBusinessObject.ObterTipoEstoqueProduto(ALLTRIM(TmpFinalg.Cpros))

        IF INLIST(loc_nTipoEsto, 3, 4)
            THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1Column8LostFocus - desarma o gate de liberacao manual
    * (ThisForm.Liberado = .f. do legado) apos UMA edicao de Column8.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1Column8LostFocus()
        THIS.this_lLiberadoAlteracao = .F.
        THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.ReadOnly = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1LostFocus - recalcula os totais gerais da Page1
    * (Tot_Qtd/Tot_Est/Tot_prdc/Tot_Prz/Tot_prze), igual ao LostFocus de
    * Column7 no legado (dump 6918-6933) - RECNO salvo/restaurado porque
    * SUM percorre o cursor e deixa o ponteiro em EOF.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1LostFocus()
        THIS.AtualizarTotaisPage1()
    ENDPROC

    PROTECTED PROCEDURE AtualizarTotaisPage1()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze

        IF !USED("TmpFinalg")
            RETURN
        ENDIF

        SELECT TmpFinalg
        loc_nRecno = RECNO()
        SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinalg")
            GOTO loc_nRecno
        ENDIF

        WITH THIS.pgf_4c_1.Page1
            .txt_4c_Tot_Qtd.Value  = loc_nSal
            .txt_4c_Tot_Est.Value  = loc_nEst
            .txt_4c_Tot_prdc.Value = loc_nPrc
            .txt_4c_Tot_Prz.Value  = loc_nPrz
            .txt_4c_Tot_prze.Value = loc_nPrze
            .txt_4c_Tot_Qtd.Refresh()
            .txt_4c_Tot_Est.Refresh()
            .txt_4c_Tot_prdc.Refresh()
            .txt_4c_Tot_Prz.Refresh()
            .txt_4c_Tot_prze.Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage1AfterRowColChange - transcricao de GradeItens.
    * AfterRowColChange (dump 6666-6726): ao trocar de linha na grade
    * principal, reposiciona cursor_4c_TmpSaldg/cursor_4c_TmpFabr no
    * produto/cor/tamanho corrente, atualiza os totais dos paineis
    * Container3/Container1 e carrega a imagem do produto.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage1AfterRowColChange(par_nColIndex)
        LOCAL loc_cChave, loc_cFiltro, loc_cArquivo, loc_oPag1

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        loc_oPag1 = THIS.pgf_4c_1.Page1
        *-- Chave POSICIONAL: o padding faz parte dela (CPros C(14) +
        *-- CodCors C(4) + CodTams C(4) = 22). ALLTRIM nas partes encurta a
        *-- chave e ela nunca casa (regra #42 do CLAUDE.md).
        loc_cChave = TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams

        = SEEK(loc_cChave, "cursor_4c_TmpSaldo", "CPros")

        *-- As duas grades de resumo tem de mostrar SO as linhas do item
        *-- corrente - o legado faz isso com "Set Key To TmpFinalg.Cpros +
        *-- CodCors + CodTams", REEMITIDO aqui a cada troca de linha (medido
        *-- no VFP9 em 2026-10-06: SET KEY TO <expr> eh ESTATICO, congela a
        *-- faixa no valor do momento e nao reavalia). SEEK no lugar dele
        *-- posicionaria o ponteiro mas deixaria a grade exibindo TODOS os
        *-- produtos.
        *--
        *-- Aqui, porem, NAO se usa SET KEY e sim SET FILTER com "==" e o
        *-- valor EMBUTIDO por macro: a faixa do SET KEY eh parcial (22 chars
        *-- contra indices de 34/47) e faixa parcial fica VAZIA sob
        *-- SET EXACT ON - e a faixa eh avaliada na NAVEGACAO, inclusive no
        *-- desenho do Grid, entao nao ha bloco onde salvar/restaurar o SET.
        *-- Hoje esta sessao nasce com EXACT OFF (DataSession = 2) e SET KEY
        *-- funcionaria, mas seria uma mina: ligar EXACT ON por qualquer
        *-- outro motivo apagaria as duas grades em silencio. "==" eh imune
        *-- ao SET EXACT. Mesmo remedio ja adotado no irmao FormSigPrGlp.
        loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"

        SELECT cursor_4c_TmpSaldg
        SET ORDER TO CPros
        SET KEY TO
        SET FILTER TO &loc_cFiltro
        GO TOP

        WITH loc_oPag1.cnt_4c_Container3
            .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0)
            .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Saldo, 0) - TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
            .txt_4c_Tot_Prz.Value = TratarNulo(cursor_4c_TmpSaldo.Disps, 0)
            .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel " + ALLTRIM(TmpFinalg.Cpros) + ;
                IIF(!EMPTY(TmpFinalg.CodCors), " Cor:" + ALLTRIM(TmpFinalg.CodCors), "") + ;
                IIF(!EMPTY(TmpFinalg.CodTams), " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
            .grd_4c_DispGrupo.Refresh()
            .Visible     = .T.
        ENDWITH

        SELECT cursor_4c_TmpFabr
        SET ORDER TO Cpros
        SET KEY TO
        SET FILTER TO &loc_cFiltro
        GO TOP

        WITH loc_oPag1.cnt_4c_Container1
            .txt_4c_Tot_Qtd.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0)
            .txt_4c_Tot_Est.Value = TratarNulo(cursor_4c_TmpSaldo.Fabrs, 0) - TratarNulo(cursor_4c_TmpSaldo.DispFs, 0)
            .grd_4c_DispFase.Refresh()
            .Visible     = .T.
        ENDWITH

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb_" + SYS(3) + ".jpg"
            loc_oPag1.img_4c_FigJpg.Picture = ""
            loc_oPag1.img_4c_FigJpg.Visible = .F.
            IF THIS.this_oBusinessObject.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros), loc_cArquivo)
                loc_oPag1.img_4c_FigJpg.Picture = loc_cArquivo
                loc_oPag1.img_4c_FigJpg.Visible = .T.
            ENDIF
        ENDIF

        *-- "Disponiveis" eh decidido POR ITEM (When de Column10 no legado)
        THIS.AtualizarVisibilidadeDisponivel()

        SELECT TmpFinalg
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispGrupoColumn6LostFocus / GradeDispFaseColumn4LostFocus -
    * "Skip / Skip -1 / Grid.Refresh" do legado (dump 4439-4444, 6625-6630,
    * 6647-6654): forca a grade a repintar apos editar a coluna Prior.
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispGrupoColumn6LostFocus()
        THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_DispGrupo.Refresh()
    ENDPROC

    PROCEDURE GradeDispFaseColumn4LostFocus()
        THIS.pgf_4c_1.Page1.cnt_4c_Container1.grd_4c_DispFase.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgPage1DblClick - "Do Form SigOpZom" do legado (zoom da
    * imagem). SigOpZom nao foi migrado - ausencia reportada via MsgAviso
    * (regra #27 do CLAUDE.md: ausencia visivel, nunca mascarada), em vez
    * de silenciosamente nao fazer nada.
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgPage1DblClick()
        MsgAviso("Visualiza" + CHR(231) + CHR(227) + "o ampliada da imagem (SigOpZom) " + ;
            "ainda n" + CHR(227) + "o foi portada para o novo sistema.", "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - troca a pagina ativa do pgf_4c_1 (equivalente a
    * ThisForm.PageDados.ActivePage = N do legado, usado por todos os botoes
    * de navegacao entre a grade principal e as sub-paginas de selecao:
    * Disponivel/SelEstoque/Pedras abrem uma pagina de detalhe, Cancela*
    * volta para a Page1). PUBLIC (nao PROTECTED) porque o harness de teste
    * automatizado chama THIS.oForm.AlternarPagina(N) direto de fora da
    * classe (mesma regra de BtnIncluirClick/CarregarLista).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina()
        LPARAMETERS par_nPagina

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 ;
                AND par_nPagina <= THIS.pgf_4c_1.PageCount
            THIS.pgf_4c_1.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage2GotFocus - idem GradeItensPage1GotFocus, mas para a
    * grade de selecao de linha (Page2): toda coluna que nao seja a 7
    * (Estoque) ou a 10 (Produ" + "cao") redireciona para a Column7.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage2GotFocus()
        THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage2Column7Valid / Column10Valid - transcricao de
    * GradeItens.Column7/Column10.Text1.Valid da Page2 (dump 7357-7379,
    * 7477-7499): validacao PURA de faixa (sem redistribuicao - o
    * ControlSource do Grid ja grava o valor em TmpFinal.Estoque/Fabrs).
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage2Column7Valid()
        LOCAL loc_oCampo, loc_nPSaldo

        loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column7.Text1
        loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value

        IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
            RETURN
        ENDIF

        DO CASE
            CASE loc_oCampo.Value < 0
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > TmpFinal.Saldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > loc_nPSaldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Selecionada...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > (TmpFinal.Saldo - TmpFinal.Fabrs)
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
        ENDCASE
    ENDPROC

    PROCEDURE GradeItensPage2Column10Valid()
        LOCAL loc_oCampo, loc_nPSaldo

        loc_oCampo = THIS.pgf_4c_1.Page2.grd_4c_Dados.Column10.Text1
        loc_nPSaldo = THIS.pgf_4c_1.Page2.txt_4c_Tot_sPrc.Value

        IF !USED("TmpFinal") OR EOF("TmpFinal") OR loc_oCampo.Value = THIS.this_nOldValue
            RETURN
        ENDIF

        DO CASE
            CASE loc_oCampo.Value < 0
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > TmpFinal.Saldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade da Opera" + CHR(231) + CHR(227) + "o...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > loc_nPSaldo
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Selecionada...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
            CASE loc_oCampo.Value > (TmpFinal.Saldo - TmpFinal.Estoque)
                MsgAviso("A quantidade n" + CHR(227) + "o pode ser maior que a quantidade Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oCampo.Value = THIS.this_nOldValue
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage2LostFocus - recalcula Tot_Qtd/Tot_Est/Tot_prc/Tot_Prz
    * da Page2 (dump 7384-7398 / 7504-7517, identicos nas duas colunas).
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage2LostFocus()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc

        IF !USED("TmpFinal")
            RETURN
        ENDIF

        SELECT TmpFinal
        loc_nRecno = RECNO()
        SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
            GOTO loc_nRecno
        ENDIF

        WITH THIS.pgf_4c_1.Page2
            .txt_4c_Tot_Qtd.Value = loc_nSal
            .txt_4c_Tot_Est.Value = loc_nEst
            .txt_4c_Tot_prc.Value = loc_nPrc
            .txt_4c_Tot_Prz.Value = loc_nPrz
            .txt_4c_Tot_Qtd.Refresh()
            .txt_4c_Tot_Est.Refresh()
            .txt_4c_Tot_prc.Refresh()
            .txt_4c_Tot_Prz.Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensPage2AfterRowColChange - transcricao de GradeItens.
    * AfterRowColChange da Page2 (dump 7251-7279): atualiza o rotulo e a
    * imagem do produto da linha corrente. Usa o MESMO
    * CarregarFotoProduto() do BO ja usado na Page1 (que decodifica o
    * base64 corretamente) em vez do StrToFile direto do legado - o dump da
    * Page2 grava o campo cru, sem o Strconv/Strtran que a Page1 faz, o que
    * geraria um arquivo .jpg invalido.
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensPage2AfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_oPag2

        IF !USED("TmpFinal") OR EOF("TmpFinal")
            RETURN
        ENDIF

        loc_oPag2 = THIS.pgf_4c_1.Page2
        loc_oPag2.obj_4c_ObsItens.Refresh()
        loc_oPag2.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cArquivo = ADDBS(SYS(2023)) + "TempGlb6_" + SYS(3) + ".jpg"
            loc_oPag2.img_4c_FigJpg.Picture = ""
            loc_oPag2.img_4c_FigJpg.Visible = .F.
            IF THIS.this_oBusinessObject.CarregarFotoProduto(ALLTRIM(TmpFinal.Cpros), loc_cArquivo)
                loc_oPag2.img_4c_FigJpg.Picture = loc_cArquivo
                loc_oPag2.img_4c_FigJpg.Visible = .T.
            ENDIF
        ENDIF

        SELECT TmpFinal
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispEstoqueColumn5Valid / GradeDispTamanhoColumn5Valid -
    * transcricao de Page4/Page5.GradeDisp.Column5.Text1.Valid (dump
    * 7754-7785, 8030-8057): valida a quantidade "Utilizar" contra o
    * disponivel da linha e contra o saldo total ainda nao atendido
    * (Qt_pedida), e atualiza Qt_Selec com a soma de Utilizar da grade.
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispEstoqueColumn5Valid()
        LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno

        loc_oCampo = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1

        IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR !USED("cursor_4c_DispEstoque")
            RETURN
        ENDIF

        loc_nPSaldo = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs

        IF loc_oCampo.Value > cursor_4c_DispEstoque.Disps
            MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF
        IF loc_oCampo.Value < 0
            MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF

        loc_nRecno = RECNO("cursor_4c_DispEstoque")
        SELECT cursor_4c_DispEstoque
        SUM Utilizar TO loc_nQtdUti
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispEstoque")
            GOTO loc_nRecno
        ENDIF

        IF loc_nQtdUti > loc_nPSaldo
            MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF

        THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nQtdUti
        THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Refresh()
    ENDPROC

    PROCEDURE GradeDispTamanhoColumn5Valid()
        LOCAL loc_oCampo, loc_nPSaldo, loc_nQtdUti, loc_nRecno

        loc_oCampo = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Text1

        IF !USED("cursor_4c_DispTamanho")
            RETURN
        ENDIF

        loc_nPSaldo = THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value

        IF loc_oCampo.Value > cursor_4c_DispTamanho.Disps
            MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF

        loc_nRecno = RECNO("cursor_4c_DispTamanho")
        SELECT cursor_4c_DispTamanho
        SUM Utilizar TO loc_nQtdUti
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_DispTamanho")
            GOTO loc_nRecno
        ENDIF

        IF loc_nQtdUti > loc_nPSaldo
            MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Pedida...", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oCampo.Value = 0
            loc_oCampo.Refresh()
            RETURN
        ENDIF

        THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nQtdUti
        THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispColumn5LostFocus - "If Lastkey()=13 / Keyboard DNARROW" +
    * Refresh do legado (dump 7790-7795, 8058-7? identico nas duas
    * paginas). O avanco automatico de linha via KEYBOARD nao eh
    * reproduzido (regra geral do projeto contra simular teclado); o
    * Refresh, que corrige o redraw da celula, permanece. BINDEVENT em
    * "LostFocus" nao repassa o controle de origem como parametro -
    * refresca as duas colunas (Page4 e Page5), ambas inofensivas se a
    * pagina correspondente nao estiver ativa.
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispColumn5LostFocus()
        IF PEMSTATUS(THIS.pgf_4c_1.Page4, "grd_4c_DispEstoque", 5)
            THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Text1.Refresh()
        ENDIF
        IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_DispTamanho", 5)
            THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Text1.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna visiveis todos os controles criados via
    * AddObject (que nascem com Visible=.F.), percorrendo Pages de PageFrame e
    * Controls de Container recursivamente. cmd_4c_Pedras/SelEstoque/
    * Disponivel nascem Visible=.F. no SCX legado (so aparecem conforme o
    * TipoEstos do produto corrente - logica da fase de eventos) e por isso
    * sao filtrados aqui, senao esta rotina reabre os tres incondicionalmente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CMD_4C_PEDRAS", ;
                        "CMD_4C_SELESTOQUE", "CMD_4C_DISPONIVEL", "IMG_4C_FIGJPG")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - "Cancelar" da Page1 (Encerrar). Fecha a tela;
    * Destroy() ja reabilita o form pai (THIS.this_oFormPai).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarPage2Click - transcricao de Page2.Cancelar.Click (dump
    * 7530-7550): so volta para a Page1 se o total de Estoque/Fabrs
    * distribuido na grade de selecao (TmpFinal) bater com o que
    * TmpFinalg espera para o item corrente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarPage2Click()
        LOCAL loc_nEstoque, loc_nFabrica, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc

        IF !USED("TmpFinalg") OR !USED("TmpFinal")
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        loc_nEstoque = TmpFinalg.Estoque
        loc_nFabrica = TmpFinalg.Fabrs

        SELECT TmpFinal
        SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
        GO TOP

        IF loc_nEst != loc_nEstoque
            MsgAviso("A quantidade de Estoque n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        IF loc_nPrc != loc_nFabrica
            MsgAviso("A quantidade de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o confere com a Quantidade Selecionada!!!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaLinClick - transcricao de Page3.CancelaLin.Click (dump
    * 7562-7572): volta para a Page1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaLinClick()
        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.pgf_4c_1.Page2.Enabled = .T.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotLinhaClick - transcricao de Page1.TotLinha.Click (dump
    * 6478-6512): monta TmpLinha (totais por Linha + linha "TOTAIS") a
    * partir de TmpFinalg e liga a grade da Page3.
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotLinhaClick()
        LOCAL loc_oGrid, loc_nCol

        IF !USED("TmpFinalg")
            RETURN
        ENDIF

        IF USED("TmpLinha")
            USE IN TmpLinha
        ENDIF

        SELECT Linhas, 0 AS Ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
                SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
            FROM TmpFinalg GROUP BY 1 ;
            UNION ALL ;
            SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS ordem, SUM(saldo) AS saldo, SUM(estoque) AS estoque, ;
                SUM(produzir) AS produzir, SUM(Fabrs) AS Fabrs ;
            FROM TmpFinalg GROUP BY 1 ;
            INTO CURSOR TmpLinha ORDER BY 2, 1

        loc_oGrid = THIS.pgf_4c_1.Page3.grd_4c_Linhas
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 5
        loc_oGrid.RecordSource = "TmpLinha"
        loc_oGrid.Column1.ControlSource = "TmpLinha.Linhas"
        loc_oGrid.Column2.ControlSource = "TmpLinha.Saldo"
        loc_oGrid.Column3.ControlSource = "TmpLinha.Estoque"
        loc_oGrid.Column4.ControlSource = "TmpLinha.Fabrs"
        loc_oGrid.Column5.ControlSource = "TmpLinha.Produzir"

        *-- ColumnCount reatribuido RESETA Header1.Caption/Width/ReadOnly/
        *-- Movable/Resizable/Sparse de TODAS as colunas (medido no VFP9 -
        *-- regra do Problema 48/Pattern #180) - reconfigurar na mesma
        *-- ordem de ConfigurarPaginaTotaisLinha.
        loc_oGrid.Column1.Header1.Caption = "Linha"
        loc_oGrid.Column1.Width     = 84
        loc_oGrid.Column1.Movable   = .F.
        loc_oGrid.Column1.Resizable = .F.
        loc_oGrid.Column1.Sparse    = .F.
        loc_oGrid.Column1.ReadOnly  = .T.
        loc_oGrid.Column1.ForeColor = RGB(36, 84, 155)

        loc_oGrid.Column2.Header1.Caption = "Quantidade"
        loc_oGrid.Column2.Width     = 80
        loc_oGrid.Column2.Movable   = .F.
        loc_oGrid.Column2.Resizable = .F.
        loc_oGrid.Column2.Sparse    = .F.
        loc_oGrid.Column2.ReadOnly  = .T.
        loc_oGrid.Column2.Text1.InputMask = "999,999.99"
        loc_oGrid.Column2.Text1.MaxLength = 10

        loc_oGrid.Column3.Header1.Caption = "Estoque"
        loc_oGrid.Column3.Width     = 80
        loc_oGrid.Column3.Movable   = .F.
        loc_oGrid.Column3.Resizable = .F.
        loc_oGrid.Column3.Sparse    = .F.
        loc_oGrid.Column3.ReadOnly  = .T.
        loc_oGrid.Column3.Text1.InputMask = "999,999.99"
        loc_oGrid.Column3.Text1.MaxLength = 10

        loc_oGrid.Column4.Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
        loc_oGrid.Column4.Width     = 80
        loc_oGrid.Column4.Movable   = .F.
        loc_oGrid.Column4.Resizable = .F.
        loc_oGrid.Column4.Sparse    = .F.
        loc_oGrid.Column4.ReadOnly  = .T.
        loc_oGrid.Column4.Text1.InputMask = "999,999.99"
        loc_oGrid.Column4.Text1.MaxLength = 10

        loc_oGrid.Column5.Header1.Caption = "Produzir"
        loc_oGrid.Column5.Width     = 80
        loc_oGrid.Column5.Movable   = .F.
        loc_oGrid.Column5.Resizable = .F.
        loc_oGrid.Column5.Sparse    = .F.
        loc_oGrid.Column5.ReadOnly  = .T.
        loc_oGrid.Column5.Text1.InputMask = "999,999.99"
        loc_oGrid.Column5.Text1.MaxLength = 10

        FOR loc_nCol = 1 TO 5
            WITH EVALUATE("loc_oGrid.Column" + TRANSFORM(loc_nCol) + ".Header1")
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDFOR

        loc_oGrid.SetAll("DynamicFontBold", [TmpLinha.Linhas = "TOTAIS"], "Column")
        loc_oGrid.SetAll("DynamicForeColor", [IIF(TmpLinha.Linhas = "TOTAIS", RGB(0,0,255), RGB(0,0,0))], "Column")

        THIS.pgf_4c_1.Page1.Enabled = .F.
        THIS.pgf_4c_1.Page2.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.pgf_4c_1.Page3.Enabled = .T.
        THIS.AlternarPagina(3)
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelEstoqueClick - transcricao de Page1.SelEstoque.Click (dump
    * 6524-6583): lista o saldo priorizado por grupo/conta do item
    * corrente (cursor_4c_TmpSaldg) na Page4, para o usuario redistribuir a
    * prioridade/uso manualmente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelEstoqueClick()
        LOCAL loc_cCpro, loc_cCor, loc_cTam, loc_oGrid

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        loc_cCpro = TmpFinalg.Cpros
        loc_cCor  = TmpFinalg.CodCors
        loc_cTam  = TmpFinalg.CodTams

        IF USED("cursor_4c_DispEstoque")
            THIS.pgf_4c_1.Page4.grd_4c_DispEstoque.RecordSource = ""
            USE IN cursor_4c_DispEstoque
        ENDIF

        SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
            FROM cursor_4c_TmpSaldg ;
            WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND CodTams = loc_cTam AND Disps > 0 ;
            ORDER BY 1, 2, 3, 4 ;
            INTO CURSOR cursor_4c_DispEstoque READWRITE

        IF RECCOUNT("cursor_4c_DispEstoque") = 0
            MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_1.Page4.grd_4c_DispEstoque
        loc_oGrid.ColumnCount = 5
        loc_oGrid.RecordSource = "cursor_4c_DispEstoque"
        loc_oGrid.Column1.ControlSource = "cursor_4c_DispEstoque.Grupos"
        loc_oGrid.Column2.ControlSource = "cursor_4c_DispEstoque.Estos"
        loc_oGrid.Column3.ControlSource = "cursor_4c_DispEstoque.Priors"
        loc_oGrid.Column4.ControlSource = "cursor_4c_DispEstoque.Disps"
        loc_oGrid.Column5.ControlSource = "cursor_4c_DispEstoque.Utilizar"

        *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
        *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
        *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaEstoque.
        loc_oGrid.Column1.Header1.Caption = "Grupo"
        loc_oGrid.Column1.Width     = 80
        loc_oGrid.Column1.ReadOnly  = .T.
        loc_oGrid.Column2.Header1.Caption = "Conta"
        loc_oGrid.Column2.Width     = 80
        loc_oGrid.Column2.ReadOnly  = .T.
        loc_oGrid.Column3.Header1.Caption = "Prior"
        loc_oGrid.Column3.Width     = 24
        loc_oGrid.Column3.ReadOnly  = .T.
        loc_oGrid.Column4.Header1.Caption = "Disponivel"
        loc_oGrid.Column4.Width     = 75
        loc_oGrid.Column4.ReadOnly  = .T.
        loc_oGrid.Column5.Header1.Caption = "Utilizar"
        loc_oGrid.Column5.Width     = 75
        loc_oGrid.Column5.ReadOnly  = .F.
        loc_oGrid.Column5.Text1.FontBold = .T.

        WITH THIS.pgf_4c_1.Page4
            .txt_4c_Qt_pedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
            .txt_4c_Qt_Selec.Value  = 0
        ENDWITH
        loc_oGrid.Refresh()

        THIS.pgf_4c_1.Page1.Enabled = .F.
        THIS.pgf_4c_1.Page2.Enabled = .F.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .T.
        THIS.AlternarPagina(4)
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDisponivelClick - transcricao de Page1.Disponivel.Click (dump
    * 4487-4550): lista o saldo disponivel do produto/cor corrente
    * QUEBRADO POR TAMANHO (cursor_4c_TmpSaldo) na Page5.
    *--------------------------------------------------------------------------
    PROCEDURE BtnDisponivelClick()
        LOCAL loc_cCpro, loc_cCor, loc_oGrid

        IF !USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        IF TmpFinalg.Estoque != 0 OR TmpFinalg.Fabrs != 0
            MsgAviso("Quantidade de Estoque e Produ" + CHR(231) + CHR(227) + "o tem estar Zero antes deste Processo!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        loc_cCpro = TmpFinalg.Cpros
        loc_cCor  = TmpFinalg.CodCors

        IF USED("cursor_4c_DispTamanho")
            THIS.pgf_4c_1.Page5.grd_4c_DispTamanho.RecordSource = ""
            USE IN cursor_4c_DispTamanho
        ENDIF

        SELECT Cpros, CodCors, CodTams, Disps, 0 AS Utilizar ;
            FROM cursor_4c_TmpSaldo ;
            WHERE Cpros = loc_cCpro AND CodCors = loc_cCor AND Disps > 0 ;
            ORDER BY 1, 2, 3 ;
            INTO CURSOR cursor_4c_DispTamanho READWRITE

        IF RECCOUNT("cursor_4c_DispTamanho") = 0
            MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_1.Page5.grd_4c_DispTamanho
        loc_oGrid.ColumnCount = 5
        loc_oGrid.RecordSource = "cursor_4c_DispTamanho"
        loc_oGrid.Column1.ControlSource = "cursor_4c_DispTamanho.Cpros"
        loc_oGrid.Column2.ControlSource = "cursor_4c_DispTamanho.CodCors"
        loc_oGrid.Column3.ControlSource = "cursor_4c_DispTamanho.CodTams"
        loc_oGrid.Column4.ControlSource = "cursor_4c_DispTamanho.Disps"
        loc_oGrid.Column5.ControlSource = "cursor_4c_DispTamanho.Utilizar"

        *-- RecordSource reatribuido RESETA Header1.Caption/Width/ReadOnly de
        *-- TODAS as colunas (medido no VFP9 - regra do Problema 48/Pattern
        *-- #180) - reconfigurar na mesma ordem de ConfigurarPaginaTamanhos.
        loc_oGrid.Column1.Header1.Caption = "Produto"
        loc_oGrid.Column1.Width     = 80
        loc_oGrid.Column1.ReadOnly  = .T.
        loc_oGrid.Column2.Header1.Caption = "Cor"
        loc_oGrid.Column2.Width     = 38
        loc_oGrid.Column2.ReadOnly  = .T.
        loc_oGrid.Column2.Text1.FontBold = .T.
        loc_oGrid.Column3.Header1.Caption = "Tam"
        loc_oGrid.Column3.Width     = 24
        loc_oGrid.Column3.ReadOnly  = .T.
        loc_oGrid.Column3.Text1.FontBold = .T.
        loc_oGrid.Column4.Header1.Caption = "Disponivel"
        loc_oGrid.Column4.Width     = 75
        loc_oGrid.Column4.ReadOnly  = .T.
        loc_oGrid.Column5.Header1.Caption = "Utilizar"
        loc_oGrid.Column5.Width     = 75
        loc_oGrid.Column5.ReadOnly  = .F.
        loc_oGrid.Column5.Text1.FontBold = .T.

        WITH THIS.pgf_4c_1.Page5
            .txt_4c_Qt_pedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs
            .txt_4c_Qt_Selec.Value  = 0
        ENDWITH
        loc_oGrid.Refresh()

        THIS.pgf_4c_1.Page1.Enabled = .F.
        THIS.pgf_4c_1.Page2.Enabled = .F.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .T.
        THIS.AlternarPagina(5)
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaDispPage4Click - transcricao de Page4.CancelaDisp.Click
    * (dump 7584-7666): devolve o "Utilizar" marcado na grade de
    * grupo/conta para TmpFinalg/cursor_4c_TmpSaldo/cursor_4c_TmpSaldg e
    * TmpFinal, e volta para a Page1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaDispPage4Click()
        LOCAL loc_nQtdUti, loc_nLnQtUtil, loc_nXBaixa

        IF USED("cursor_4c_DispEstoque") AND RECCOUNT("cursor_4c_DispEstoque") > 0
            SELECT cursor_4c_DispEstoque
            SUM Utilizar TO loc_nQtdUti

            IF loc_nQtdUti > 0
                SELECT cursor_4c_DispEstoque
                SCAN
                    IF cursor_4c_DispEstoque.Utilizar = 0
                        LOOP
                    ENDIF
                    loc_nLnQtUtil = cursor_4c_DispEstoque.Utilizar

                    = SEEK(cursor_4c_DispEstoque.CPros + cursor_4c_DispEstoque.CodCors + cursor_4c_DispEstoque.CodTams, ;
                        "cursor_4c_TmpSaldo", "CPros")

                    SELECT TmpFinalg
                    REPLACE Produzir WITH Produzir - loc_nLnQtUtil, ;
                            Estoque  WITH Estoque + loc_nLnQtUtil, ;
                            UsuLibs  WITH " " IN TmpFinalg

                    SELECT cursor_4c_TmpSaldo
                    REPLACE Disps WITH Disps - loc_nLnQtUtil IN cursor_4c_TmpSaldo

                    IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
                        INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
                    ENDIF
                    REPLACE keySelm WITH .T. IN TmpSaldU

                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO CPros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams + ;
                        STR(cursor_4c_DispEstoque.Priors, 2) + cursor_4c_DispEstoque.Grupos + cursor_4c_DispEstoque.Estos)
                    REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nLnQtUtil
                    SELECT cursor_4c_DispEstoque
                ENDSCAN

                = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")

                loc_nXBaixa = TmpFinalg.Estoque
                SELECT TmpFinal
                SET ORDER TO
                SET ORDER TO Cpros
                = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                REPLACE Estoque WITH 0 WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                        TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams
                = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                SCAN WHILE TmpFinal.Cpros = cursor_4c_TmpSaldo.Cpros AND TmpFinal.CodCors = cursor_4c_TmpSaldo.CodCors ;
                        AND TmpFinal.CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                    IF (TmpFinal.Saldo - TmpFinal.Fabrs) >= loc_nXBaixa
                        REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa
                        loc_nXBaixa = 0
                    ELSE
                        loc_nXBaixa = loc_nXBaixa - (TmpFinal.Saldo - TmpFinal.Fabrs)
                        REPLACE TmpFinal.Estoque WITH (TmpFinal.Saldo - TmpFinal.Fabrs)
                    ENDIF
                    REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
                    SELECT TmpFinal
                ENDSCAN
            ENDIF
        ENDIF

        THIS.AtualizarTotaisPage1()

        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.pgf_4c_1.Page2.Enabled = .T.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaDispPage5Click - transcricao de Page5.CancelaDisp.Click
    * (dump 7835-7959): quebra a linha de TmpFinal/TmpFinalg do
    * produto/cor corrente por TAMANHO, de acordo com o "Utilizar" marcado
    * em cursor_4c_DispTamanho, e reflete a quebra em SigMvIts (tabela
    * real - a linha de origem, sem tamanho definido, eh dividida numa
    * nova linha com o tamanho escolhido).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaDispPage5Click()
        LOCAL loc_nQtdUti, loc_nRegFinal, loc_nLnQtUtil, loc_cEdn, loc_cQuery

        IF !USED("TmpFinal") OR !USED("cursor_4c_DispTamanho")
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        SELECT TmpFinal
        SET ORDER TO
        loc_nRegFinal = RECNO()

        SELECT cursor_4c_DispTamanho
        SUM Utilizar TO loc_nQtdUti

        IF loc_nQtdUti > 0
            IF USED("Temporario")
                USE IN Temporario
            ENDIF
            SELECT * FROM TmpFinal WHERE .F. INTO CURSOR Temporario READWRITE

            SELECT cursor_4c_DispTamanho
            SCAN
                IF cursor_4c_DispTamanho.Utilizar = 0
                    LOOP
                ENDIF
                loc_nLnQtUtil = cursor_4c_DispTamanho.Utilizar

                = SEEK(cursor_4c_DispTamanho.CPros + cursor_4c_DispTamanho.CodCors + cursor_4c_DispTamanho.CodTams, ;
                    "cursor_4c_TmpSaldo", "CPros")

                SELECT TmpFinal
                SCATTER MEMVAR
                SELECT Temporario
                APPEND BLANK
                GATHER MEMVAR
                REPLACE Temporario.Saldo WITH loc_nLnQtUtil, ;
                        Temporario.codTams WITH cursor_4c_DispTamanho.CodTams, ;
                        Temporario.Estoque WITH loc_nLnQtUtil, ;
                        Temporario.Produzir WITH 0

                SELECT TmpFinal
                REPLACE TmpFinal.Saldo WITH TmpFinal.Saldo - loc_nLnQtUtil, ;
                        TmpFinal.Produzir WITH TmpFinal.Produzir - loc_nLnQtUtil

                REPLACE Saldo WITH Saldo - loc_nLnQtUtil, Produzir WITH Produzir - loc_nLnQtUtil IN TmpFinalg

                SELECT TmpFinalg
                REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                    QtdMins - Produzir, 0) IN TmpFinalg

                SELECT cursor_4c_TmpSaldo
                REPLACE cursor_4c_TmpSaldo.Disps WITH cursor_4c_TmpSaldo.Disps - loc_nLnQtUtil

                SELECT cursor_4c_TmpSaldg
                SET ORDER TO CPros
                = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldo.Saldo ;
                    WHILE cursor_4c_TmpSaldg.Cpros = cursor_4c_TmpSaldo.Cpros AND ;
                          cursor_4c_TmpSaldg.CodCors = cursor_4c_TmpSaldo.CodCors AND ;
                          cursor_4c_TmpSaldg.CodTams = cursor_4c_TmpSaldo.CodTams

                *-- Divide a linha SEM tamanho de SigMvIts (tabela real) em
                *-- duas: a original com a quantidade restante e uma nova
                *-- com o tamanho escolhido e loc_nLnQtUtil (dump 7896-7916)
                loc_cEdn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                    " AND Citens = " + FormatarNumeroSQL(TmpFinal.Citens, 0) + ;
                    " AND CodCors = " + EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + ;
                    " AND CodTams = " + EscaparSQL(SPACE(4))
                IF USED("cursor_4c_MvItsOrig")
                    USE IN cursor_4c_MvItsOrig
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvItsOrig") >= 0 AND ;
                        USED("cursor_4c_MvItsOrig") AND !EOF("cursor_4c_MvItsOrig")

                    IF (cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil) = 0
                        SQLEXEC(gnConnHandle, "DELETE FROM SigMvIts WHERE cIdChaves = " + ;
                            EscaparSQL(cursor_4c_MvItsOrig.cIdChaves))
                    ELSE
                        SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET Qtds = " + ;
                            FormatarNumeroSQL(cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil, 3) + ;
                            ", Aqtds = " + FormatarNumeroSQL(cursor_4c_MvItsOrig.Qtds - loc_nLnQtUtil, 3) + ;
                            " WHERE cIdChaves = " + EscaparSQL(cursor_4c_MvItsOrig.cIdChaves))
                    ENDIF

                    SQLEXEC(gnConnHandle, ;
                        "INSERT INTO SigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Aqtds, CodCors, CodTams, QtdEmbs, cIdChaves) " + ;
                        "VALUES (" + FormatarNumeroSQL(cursor_4c_MvItsOrig.Citens, 0) + ", " + ;
                        EscaparSQL(cursor_4c_MvItsOrig.Emps) + ", " + EscaparSQL(cursor_4c_MvItsOrig.Dopes) + ", " + ;
                        FormatarNumeroSQL(cursor_4c_MvItsOrig.Numes, 0) + ", " + ;
                        EscaparSQL(cursor_4c_MvItsOrig.Cpros) + ", " + FormatarNumeroSQL(loc_nLnQtUtil, 3) + ", " + ;
                        FormatarNumeroSQL(loc_nLnQtUtil, 3) + ", " + EscaparSQL(cursor_4c_MvItsOrig.CodCors) + ", " + ;
                        EscaparSQL(cursor_4c_DispTamanho.CodTams) + ", 1, " + EscaparSQL(fUniqueIds()) + ")")
                ENDIF
                IF USED("cursor_4c_MvItsOrig")
                    USE IN cursor_4c_MvItsOrig
                ENDIF

                SELECT cursor_4c_DispTamanho
            ENDSCAN

            IF USED("Temporario") AND RECCOUNT("Temporario") > 0
                SELECT TmpFinal
                APPEND FROM DBF("Temporario")
            ENDIF
            IF loc_nRegFinal > 0 AND loc_nRegFinal <= RECCOUNT("TmpFinal")
                GOTO loc_nRegFinal IN TmpFinal
            ENDIF
            IF TmpFinal.Saldo = 0
                SELECT TmpFinal
                DELETE
            ENDIF

            SELECT TmpFinalg
            IF TmpFinalg.Saldo = 0
                DELETE
            ENDIF

            = SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, "cursor_4c_TmpSaldo", "CPros")
        ENDIF

        THIS.AtualizarTotaisPage1()

        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.pgf_4c_1.Page2.Enabled = .T.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaDispPage6Click - "Voltar" da Page6 (Requisicao Manual).
    * NAO existe no legado original (a pagina de requisicao do dump nao
    * tem Cancelar) - segue o mesmo padrao de retorno das outras
    * sub-paginas, canonico do projeto.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaDispPage6Click()
        THIS.pgf_4c_1.Page1.Enabled = .T.
        THIS.pgf_4c_1.Page2.Enabled = .T.
        THIS.pgf_4c_1.Page6.Enabled = .F.
        THIS.AlternarPagina(1)
        THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPedrasClick - transcricao de Page1.Pedras.Click (dump 7216-7239):
    * liga a grade de requisicao manual (SelPedra/cursor_4c_Requisicao) e
    * vai para a Page6.
    *--------------------------------------------------------------------------
    PROCEDURE BtnPedrasClick()
        LOCAL loc_oGrid

        loc_oGrid = THIS.pgf_4c_1.Page6.grd_4c_Pedra
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 5
        loc_oGrid.RecordSource = "cursor_4c_Requisicao"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Requisicao.Cpros"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Requisicao.Dpros"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Requisicao.Cunis"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Requisicao.Qtds"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Requisicao.Cpro2s"

        THIS.pgf_4c_1.Page1.Enabled = .F.
        THIS.pgf_4c_1.Page2.Enabled = .F.
        THIS.pgf_4c_1.Page3.Enabled = .F.
        THIS.pgf_4c_1.Page4.Enabled = .F.
        THIS.pgf_4c_1.Page5.Enabled = .F.
        THIS.pgf_4c_1.Page6.Enabled = .T.
        THIS.AlternarPagina(6)
        loc_oGrid.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraqtdClick - transcricao de Page1.Alteraqtd.Click (dump
    * 7180-7204): autoriza UMA edicao da coluna "Produzir Estq" via dialogo
    * de senha de risco (SigOpSen, "PRDZRISCO"). SigOpSen NAO foi migrado
    * (ver feedback_sigopsen_ausente_gate_autorizacao) - gate de
    * AUTORIZACAO tratado FAIL-CLOSED: dialogo indisponivel = NAO
    * autorizado, nunca MsgConfirma/skip.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraqtdClick()
        LOCAL loc_cString, loc_cRetorno, loc_lOk, loc_oErro

        IF !USED("TmpFinalg") OR EOF("TmpFinalg") OR TmpFinalg.Produzir2 = 0
            MsgAviso("Refer" + CHR(234) + "ncia Sem Quantidade a Produzir para Estoque!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_1.Page1.grd_4c_Dados.SetFocus()
            RETURN
        ENDIF

        loc_cString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ALLTRIM(TRANSFORM(TmpFinalg.QtdMins, "@Z 99999.999")) + ;
            " Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))

        loc_cRetorno = ""
        loc_lOk = .F.
        TRY
            DO FORM SigOpSen WITH "PRDZRISCO", loc_cString, "" TO loc_cRetorno
            loc_lOk = (LEFT(TratarNulo(loc_cRetorno, ""), 1) = "*")
        CATCH TO loc_oErro
            MsgErro("Dialogo de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen) indispon" + CHR(237) + "vel - " + ;
                "altera" + CHR(231) + CHR(227) + "o N" + CHR(195) + "O autorizada." + CHR(13) + loc_oErro.Message, ;
                "Erro de Autoriza" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDTRY

        IF !loc_lOk
            MsgAviso("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o autorizada!!!", "Aten" + CHR(231) + CHR(227) + "o")
        ELSE
            REPLACE TmpFinalg.UsuLibs WITH PADR(SUBSTR(loc_cRetorno, 2), 10) IN TmpFinalg
            THIS.this_lLiberadoAlteracao = .T.
            THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.ReadOnly = .F.
        ENDIF
        THIS.pgf_4c_1.Page1.grd_4c_Dados.Column8.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - leva para a tela o que o Init legado lia dos cursores de
    * parametro do sistema (crSigCdPam/CrSigCdPac), hoje carregados uma
    * unica vez em SigPrGlxBO.Init:
    *
    *   Thisform.SigKey = CrSigCdPac.sigKeys                 -> BO.this_cSigKey
    *   lab_periodo.Caption = 'Periodo: '+Alltrim(Str(
    *       CrSigCdPac.nMeses,2))+' meses'                   -> BO.this_nPacNMeses
    *   Pedras.Visible = .f.                                 -> BO.this_cPamDop*
    *   If Not Empty(crSigCdPam.DopEmphs) And Not Empty(DopReqcs)
    *      And Not Empty(DopPedcs) And Not Empty(DopComps)
    *      And Not ThisForm.Reserva -> Pedras.Visible = .t.
    *   SelEstoque.Visible (fChecaAcesso SIGPRGLO/PRIORIDADE)
    *   Caption / lblSombra / lblTitulo (modo Reserva x Globalizacao)
    *
    * PROTECTED EXPLICITO: FormBase ja declara BOParaForm como PROTECTED e
    * o VFP9 nao deixa a subclasse ALARGAR o escopo - omitir o modificador
    * mentiria para quem le, porque o metodo continua protegido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPag1, loc_lTemPedras, loc_oErro

        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_oPag1 = THIS.pgf_4c_1.Page1

            *-- Titulo da tela e os dois labels da faixa do cabecalho
            THIS.Caption = IIF(THIS.this_lReservaAuto, ;
                "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica", ;
                "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o")
            THIS.this_cTituloForm = THIS.Caption
            loc_oPag1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            loc_oPag1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

            IF VARTYPE(loc_oBO) = "O"
                *-- "Periodo: NN meses" (SigCdPac.nmeses). O legado monta o
                *-- rotulo INTEIRO aqui; o Caption posto em
                *-- ConfigurarPaginaLista eh so o texto base de projeto.
                loc_oPag1.cnt_4c_Container5.lbl_4c_LabPeriodo.Caption = ;
                    "Per" + CHR(237) + "odo: " + ALLTRIM(STR(loc_oBO.this_nPacNMeses, 2)) + " meses"

                *-- "Requisicoes" (cmd_4c_Pedras): so com as QUATRO operacoes
                *-- de requisicao configuradas em SigCdPam e fora do modo
                *-- Reserva.
                loc_lTemPedras = !EMPTY(loc_oBO.this_cPamDopEmphs) AND ;
                                 !EMPTY(loc_oBO.this_cPamDopReqcs) AND ;
                                 !EMPTY(loc_oBO.this_cPamDopPedcs) AND ;
                                 !EMPTY(loc_oBO.this_cPamDopComps) AND ;
                                 !THIS.this_lReservaAuto
                loc_oPag1.cmd_4c_Pedras.Visible = loc_lTemPedras
            ELSE
                loc_oPag1.cmd_4c_Pedras.Visible = .F.
            ENDIF

            *-- "Estoques" (cmd_4c_SelEstoque): mesma condicao de acesso que
            *-- libera a coluna Prior das grades de resumo.
            loc_oPag1.cmd_4c_SelEstoque.Visible = THIS.this_lPermiteAjustarPrioridade()

            *-- "Disponiveis" (cmd_4c_Disponivel) nasce oculto e eh decidido
            *-- por item em AtualizarVisibilidadeDisponivel().
            loc_oPag1.cmd_4c_Disponivel.Visible = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - (re)liga a grade principal da Page1 ao cursor
    * TmpFinalg e deixa a tela no estado em que o Init legado a entregava:
    *
    *   With ThisForm.PageDados.page1.GradeItens -> RecordSource/ControlSource
    *   Select TmpSaldG / Set Order To Cpros / Set Key To TmpFinalg.Cpros+
    *       CodCors+CodTams / Go Top          (filtro relacional por item)
    *   Select TmpFabr  / idem
    *   Select TmpFinalg / Sum ... / Tot_* .Value / .Refresh
    *   ThisForm.pageDados.Page1.GradeItens.Setfocus
    *
    * Por que REBIND e nao so Refresh: TmpFinalg/TmpFinal/TmpSaldG/TmpFabr
    * sao criados por FormSigPrGl2BO.ExecutarProcessamento na data session
    * do form PAI (assumida no Init). Quando o pai reprocessa, o alias eh
    * fisicamente RECRIADO e o Grid perde RecordSource/ControlSource,
    * Header1.Caption, Width e ReadOnly (regra #43.1 do CLAUDE.md) - a
    * grade viraria "Column1/Column2" generica e editavel. Por isso a
    * reconfiguracao completa, na ordem ColumnCount -> RecordSource ->
    * ControlSource -> Width -> Header1.Caption -> ReadOnly (regra #41).
    *
    * Fecha com GO TOP + Refresh (regra #21a: popular/religar cursor NAO
    * repinta a grade sozinho).
    *
    * PUBLIC (nao PROTECTED): CarregarLista nao existe em FormBase e o
    * harness de teste automatizado chama THIS.oForm.CarregarLista() direto
    * de fora da classe (regra #3 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("TmpFinalg")
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados de globaliza" + CHR(231) + CHR(227) + ;
                    "o para exibir - reprocesse a gera" + CHR(231) + CHR(227) + "o de O.P.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oGrid = THIS.pgf_4c_1.Page1.grd_4c_Dados

                WITH loc_oGrid
                    .RecordSource = ""
                    .ColumnCount  = 10
                    .RecordSource = "TmpFinalg"

                    .Column1.ControlSource  = "TmpFinalg.Cpros"
                    .Column2.ControlSource  = "TmpFinalg.CodCors"
                    .Column3.ControlSource  = "TmpFinalg.Flag"
                    .Column4.ControlSource  = "TmpFinalg.Qtds"
                    .Column5.ControlSource  = "TmpFinalg.Saldo"
                    .Column6.ControlSource  = "TmpFinalg.Produzir"
                    .Column7.ControlSource  = "TmpFinalg.Fabrs"
                    .Column8.ControlSource  = "TmpFinalg.Produzir2"
                    .Column9.ControlSource  = "TmpFinalg.CodTams"
                    .Column10.ControlSource = "TmpFinalg.Estoque"

                    *-- Width DEPOIS do RecordSource/ControlSource: reatribuir
                    *-- a fonte do Grid recalcula toda largura para o default.
                    .Column1.Width  = 90
                    .Column2.Width  = 50
                    .Column3.Width  = 30
                    .Column4.Width  = 60
                    .Column5.Width  = 70
                    .Column6.Width  = 70
                    .Column7.Width  = 80
                    .Column8.Width  = 80
                    .Column9.Width  = 40
                    .Column10.Width = 76

                    .Column1.Header1.Caption  = "Produto"
                    .Column2.Header1.Caption  = "Cor"
                    .Column3.Header1.Caption  = ""
                    .Column4.Header1.Caption  = "N" + CHR(250) + "mero"
                    .Column5.Header1.Caption  = "Qtde Pedido"
                    .Column6.Header1.Caption  = "Produzir"
                    .Column7.Header1.Caption  = "Qtd Produ" + CHR(231) + CHR(227) + "o"
                    .Column8.Header1.Caption  = "Produzir Estq"
                    .Column9.Header1.Caption  = "Tam"
                    .Column10.Header1.Caption = "Qtd Estoque"

                    *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (o do grid
                    *-- propaga para as colunas e sobrescreveria): so Fabrs
                    *-- (7) e Estoque (10) sao digitaveis no legado.
                    .ReadOnly = .F.
                    .Column1.ReadOnly  = .T.
                    .Column2.ReadOnly  = .T.
                    .Column3.ReadOnly  = .T.
                    .Column4.ReadOnly  = .T.
                    .Column5.ReadOnly  = .T.
                    .Column6.ReadOnly  = .T.
                    .Column7.ReadOnly  = .F.
                    .Column8.ReadOnly  = .T.
                    .Column9.ReadOnly  = .T.
                    .Column10.ReadOnly = .F.

                    .Column7.DynamicBackColor = "RGB(255,255,204)"
                    .Column8.DynamicForeColor = ;
                        "IIF(!EMPTY(TmpFinalg.UsuLibs), RGB(255,0,0), RGB(0,0,0))"
                ENDWITH

                SELECT TmpFinalg
                GO TOP

                *-- Ordem das grades de resumo (Set Order To Cpros do Init
                *-- legado). O FILTRO por item corrente NAO vem aqui: eh
                *-- GradeItensPage1AfterRowColChange quem o aplica, e ele eh
                *-- chamado no fim deste metodo para a primeira linha - uma
                *-- fonte unica, em vez de duas copias para divergirem.
                IF USED("cursor_4c_TmpSaldg")
                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO CPros
                ENDIF
                IF USED("cursor_4c_TmpFabr")
                    SELECT cursor_4c_TmpFabr
                    SET ORDER TO Cpros
                ENDIF

                SELECT TmpFinalg
                GO TOP
                loc_oGrid.Refresh()

                *-- Totais gerais e paineis/imagem do primeiro item
                THIS.AtualizarTotaisPage1()
                THIS.AtualizarVisibilidadeDisponivel()
                IF !EOF("TmpFinalg")
                    THIS.GradeItensPage1AfterRowColChange(1)
                ENDIF

                SELECT TmpFinalg
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - repassa a Processar() os dois campos que o Init legado
    * lia do form AVO (_Prev/_DtGera = ThisForm.ParentForm.ParentForm.
    * Cnt_Previsao.GetPrevisao/GetGeracao). THIS.this_oFormPai eh o
    * FormSigPrGl2 (pai direto); THIS.this_oFormPai.this_oParentForm eh o
    * FormSigPrGlo (avo, "Processamento de O.P."). Mesmo padrao ja adotado
    * em FormSigPrGlp.FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oGlo, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
            ELSE
                loc_oGlo = .NULL.
                IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "this_oParentForm", 5)
                    IF VARTYPE(THIS.this_oFormPai.this_oParentForm) = "O"
                        loc_oGlo = THIS.this_oFormPai.this_oParentForm
                    ENDIF
                ENDIF

                IF VARTYPE(loc_oGlo) = "O" AND PEMSTATUS(loc_oGlo, "cnt_4c_Previsao", 5)
                    THIS.this_oBusinessObject.this_dPrevisao    = ;
                        ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Previsao.Value)
                    THIS.this_oBusinessObject.this_dDataGeracao = ;
                        ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Geracao.Value)
                ELSE
                    *-- Sem o form avo (ex.: teste direto desta tela), usa a
                    *-- data de hoje para ambos - nunca deixa {} (gravaria
                    *-- a O.P. com data em branco)
                    THIS.this_oBusinessObject.this_dPrevisao    = DATE()
                    THIS.this_oBusinessObject.this_dDataGeracao = DATE()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - "Processar" da Page1 (dump 4562-6466). So
    * ORQUESTRA: repassa ao BO os parametros que o Init legado lia do form
    * avo (FormParaBO) e delega toda a gravacao a SigPrGlxBO.Processar().
    * "Do Form SigReGli" do fecho legado NAO foi migrado - mostra o numero
    * da O.P. via MsgInfo e fecha esta tela, mesmo padrao de
    * FormSigPrGlp.BtnProcessarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_lFechar, loc_oErro
        loc_lFechar = .F.

        TRY
            IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para processar.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.FormParaBO()
                    THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled    = .F.
                    THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled   = .F.
                    THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled   = .F.
                    THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled     = .F.

                    loc_lSucesso = THIS.this_oBusinessObject.Processar()

                    IF loc_lSucesso
                        MsgInfo("Processamento efetuado com sucesso!" + CHR(13) + ;
                            "O.P. " + TRANSFORM(THIS.this_oBusinessObject.this_nNumeroOpGerada) + ;
                            " gerada.", "Confirmar")
                        loc_lFechar = .T.
                    ELSE
                        THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled  = .T.
                        THIS.pgf_4c_1.Page1.cmd_4c_SelEstoque.Enabled = THIS.this_lPermiteAjustarPrioridade()
                        THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Enabled = .T.
                        THIS.pgf_4c_1.Page1.cmd_4c_TotLinha.Enabled   = .T.

                        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Processar")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY

        IF loc_lFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form pai (padrao do Cancelar.Click legado: a
    * previa eh modeless-sobre-pai, nao modal de verdade, entao quem fecha
    * precisa devolver o Enabled do pai manualmente).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGlxBO.prg):
*============================================================================
* SigPrGlxBO.prg - Business Object para Previa da Globalizacao (SIGPRGLX)
*
* Form OPERACIONAL (SIGPRGLX / FormSigPrGlx): processo de globalizacao de
* saldos de producao - consolida, por produto/cor/tamanho, o que esta em
* Estoque x em Producao x Pedido, permite ao usuario redistribuir saldo
* disponivel (Estoque/Producao em Fase/Requisicao de material - abas
* GradeDisp/GradeLinhas/GradeDisp-Pedras) e ao final grava os movimentos
* de transferencia/globalizacao (SigMvCab/SigMvItn/SigMvHst/SigBxEst/
* SigOpPic/SigPdMvf/SigCdNec/SigInAtz/SigCdNei) via Processar.Click do
* legado.
*
* NAO existe uma unica "tabela principal" para este processo (this_cTabela
* permanece vazio) - o BO opera sobre varios cursores temporarios (gerados
* a partir de SigMvHst/SigCdOpe/SigCdPro/TmpSaldo/TmpSaldG/etc, conforme
* tasks/task618/comportamento.json) e grava, ao confirmar, nas tabelas de
* movimento acima.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga/gravacao (CarregarDoCursor/
*                Inserir/Atualizar/ObterChavePrimaria/RegistrarAuditoria)
*============================================================================

DEFINE CLASS SigPrGlxBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos do form que abre a previa (equivalente ao
    * Lparameters _ParentForm, _Data, _ReservaAuto, _nGerEmphPdr, _Autom,
    * _numeroOp, _PorDestino do Init legado). _ParentForm e _Data nao se
    * tornam propriedades do BO (referencia de form/ponto no tempo de
    * abertura, tratados pelo FormSigPrGlx); os demais pilotam o processo.
    *==========================================================================
    this_lReserva      = .F.       && thisform.Reserva    (_ReservaAuto) - reserva automatica de saldo
    this_nEmphPdr      = 0         && thisform.EmphPdr     (_nGerEmphPdr) - empresa padrao p/ geracao de movimento
    this_lAutomatico   = .F.       && thisform.Automatico  (_Autom) - globalizacao automatica (sem intervencao manual)
    this_nNumeroDaOp   = 0         && thisform.Numerodaop  (_numeroOp) - numero MANUAL da OP, NUMERICO (so usado se SigCdPam.GlobAutos=2)
    this_lPorDestino   = .F.       && thisform.PorDestino  (_PorDestino) - agrupa saldo por destino em vez de por linha (ThisForm.Pordestino)

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init -
    * equivalente ao "Select CrSigCdPam / _Dopp = crSigCdPam.DoppPads /
    * _Dope = crSigCdPam.TransfRes / _DopEst = crSigCdPam.DopBxEsts" no
    * inicio do Processar.Click legado
    *==========================================================================
    this_cDoppPads     = SPACE(20) && SigCdPam.dopppads  - operacao padrao de producao
    this_cTransfRes    = SPACE(20) && SigCdPam.transfres - operacao padrao de transferencia/reserva
    this_cDopBxEsts    = SPACE(20) && SigCdPam.dopbxests - operacao padrao de baixa de estoque (nao usada por Processar - ver this_cPacDopEsts)

    *==========================================================================
    * Demais parametros de SigCdPam/SigCdPac usados por Processar() (dump
    * 4562-6466) - carregados em CarregarParametrosProcessamento(), igual ao
    * padrao ja adotado em SigPrGlpBO.Init/CarregarParametrosProcessamento.
    *==========================================================================
    this_cPamDopEmphs   = SPACE(20) && SigCdPam.dopemphs
    this_cPamDopReqcs   = SPACE(20) && SigCdPam.dopreqcs
    this_cPamDopPedcs   = SPACE(20) && SigCdPam.doppedcs
    this_cPamDopComps   = SPACE(20) && SigCdPam.dopcomps
    this_cPamDopTrfCps  = SPACE(20) && SigCdPam.doptrfcps
    this_cPamGruReservs = SPACE(10) && SigCdPam.grureservs
    this_cPamConReservs = SPACE(10) && SigCdPam.conreservs
    this_nPamAgrupEmph  = 0         && SigCdPam.agrupemph
    this_cPamOuros      = SPACE(14) && SigCdPam.ouros
    this_cPamTpOpEntAus = SPACE(15) && SigCdPam.tpopentaus
    this_cPamDopEntAus  = SPACE(20) && SigCdPam.dopentaus
    this_nPamAutComps   = 0         && SigCdPam.autcomps
    this_nPamGlobAutos  = 0         && SigCdPam.globautos
    this_cPamGruConfs   = SPACE(10) && SigCdPam.gruconfs
    this_cPamConConfs   = SPACE(10) && SigCdPam.conconfs

    this_cPacDopEsts    = SPACE(20) && SigCdPac.dopEsts    - operacao de baixa de estoque p/ fabricacao (_DopEst)
    this_cPacOpPdCompra = SPACE(20) && SigCdPac.OpPdCompra - operacao de pedido de compra de acabado
    this_nPacOpZers     = 0         && SigCdPac.OpZers
    this_nPacAgrupReqs  = 0         && SigCdPac.AgrupReqs  - 1=agrupa requisicao por fornecedor+prazo
    this_cSigKey        = SPACE(3)  && CrSigCdPac.sigKeys (Thisform.SigKey)
    this_nPacNMeses     = 0         && SigCdPac.nmeses numeric(2,0) - janela de analise de venda, exibida no rotulo "Periodo: NN meses" da Page1 (Init legado: Container5.lab_periodo.Caption)

    *==========================================================================
    * DbParam - o legado le um cursor "DBParam" de UMA linha (montado pelo
    * form avo - FormSigPrGlo - igual ao mesmo cursor que SigPrGlpBO
    * documenta) em CodTgOps/OpZers/EntPes. Nao portado; vira properties
    * resolvidas em CarregarDbParam() a partir do tipo de geracao que o FORM
    * le do grandparent (THIS.this_oFormPai.this_oParentForm).
    *==========================================================================
    this_cTipoGeracaoOP = SPACE(10) && _lcTpGOp (grandparent)
    this_lGerPorTp      = .F.       && ThisForm.GerPorTp do grandparent
    this_cDbCodTgOps    = SPACE(10) && DBParam.CodTgOps
    this_nDbOpZers      = 0         && DBParam.OpZers
    this_nDbEntPes      = 0         && DBParam.EntPes

    *==========================================================================
    * Previsao de entrega / data de geracao - no legado vem de
    * ThisForm.ParentForm.ParentForm.Cnt_Previsao.GetPrevisao/GetGeracao
    * (FormSigPrGl2.this_oParentForm = FormSigPrGlo). O FORM repassa para ca
    * em FormParaBO(), antes de chamar Processar() - mesmo padrao de
    * SigPrGlpBO.this_dPrevisao/this_dDataGeracao.
    *==========================================================================
    this_dPrevisao      = {}        && _Prev
    this_dDataGeracao   = {}        && _DtGera

    *==========================================================================
    * Resultado do processamento
    *==========================================================================
    this_nNumeroOpGerada = 0        && _Nump - numero da OP efetivada por Processar()

    *==========================================================================
    * Referencia do produto/cor/tamanho corrente na grade de itens
    * (TmpFinalg.Cpros/CodCors/CodTams - chave usada por quase todos os
    * metodos: Disponivel.Click, SelEstoque.Click, GradeItens.*, etc.)
    *==========================================================================
    this_cCpros        = SPACE(14) && TmpFinalg.Cpros  - SigCdPro.CPros
    this_cCodCors      = SPACE(10) && TmpFinalg.CodCors
    this_cCodTams      = SPACE(10) && TmpFinalg.CodTams

    *==========================================================================
    * Totais exibidos no rodape do form (Container1/Container3/Container5/
    * GradeItens) - somente leitura, recalculados a partir dos cursores
    * temporarios (TmpFinal/TmpFinalg) a cada alteracao de linha
    *==========================================================================
    this_nTotQtd       = 0  && Tot_Qtd  - saldo total selecionado
    this_nTotEst       = 0  && Tot_Est  - total em estoque
    this_nTotPrz       = 0  && Tot_Prz  - total disponivel/prioridade
    this_nTotPrdc      = 0  && Tot_prdc - total em producao
    this_nTotPrze      = 0  && Tot_prze - total em producao para estoque
    this_nTotVenda     = 0  && Tot_Venda - quantidade vendida no periodo analisado
    this_nQtdMinima    = 0  && Get_Minima - quantidade minima para producao

    *==========================================================================
    * Numero da operacao gerada durante o Processar (equivalente a _Rnop /
    * _Nump do legado) - preenchido ao gravar os movimentos de globalizacao
    *==========================================================================
    this_nNumeroOperacaoGerada = 0

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo (BO opera sobre cursores temporarios), mas
    * carrega os parametros padrao de operacao (SigCdPam) usados em todo o
    * fluxo de globalizacao
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                SQLEXEC(gnConnHandle, ;
                    "SELECT dopppads, transfres, dopbxests, dopemphs, dopreqcs, " + ;
                    "doppedcs, dopcomps, doptrfcps, grureservs, conreservs, " + ;
                    "agrupemph, ouros, tpopentaus, dopentaus, autcomps, " + ;
                    "globautos, gruconfs, conconfs FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cDoppPads      = PADR(TratarNulo(cursor_4c_SigCdPam.dopppads, ""), 20)
                    THIS.this_cTransfRes     = PADR(TratarNulo(cursor_4c_SigCdPam.transfres, ""), 20)
                    THIS.this_cDopBxEsts     = PADR(TratarNulo(cursor_4c_SigCdPam.dopbxests, ""), 20)
                    THIS.this_cPamDopEmphs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopemphs, ""), 20)
                    THIS.this_cPamDopReqcs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopreqcs, ""), 20)
                    THIS.this_cPamDopPedcs   = PADR(TratarNulo(cursor_4c_SigCdPam.doppedcs, ""), 20)
                    THIS.this_cPamDopComps   = PADR(TratarNulo(cursor_4c_SigCdPam.dopcomps, ""), 20)
                    THIS.this_cPamDopTrfCps  = PADR(TratarNulo(cursor_4c_SigCdPam.doptrfcps, ""), 20)
                    THIS.this_cPamGruReservs = PADR(TratarNulo(cursor_4c_SigCdPam.grureservs, ""), 10)
                    THIS.this_cPamConReservs = PADR(TratarNulo(cursor_4c_SigCdPam.conreservs, ""), 10)
                    THIS.this_nPamAgrupEmph  = TratarNulo(cursor_4c_SigCdPam.agrupemph, 0)
                    THIS.this_cPamOuros      = PADR(TratarNulo(cursor_4c_SigCdPam.ouros, ""), 14)
                    THIS.this_cPamTpOpEntAus = PADR(TratarNulo(cursor_4c_SigCdPam.tpopentaus, ""), 15)
                    THIS.this_cPamDopEntAus  = PADR(TratarNulo(cursor_4c_SigCdPam.dopentaus, ""), 20)
                    THIS.this_nPamAutComps   = TratarNulo(cursor_4c_SigCdPam.autcomps, 0)
                    THIS.this_nPamGlobAutos  = TratarNulo(cursor_4c_SigCdPam.globautos, 0)
                    THIS.this_cPamGruConfs   = PADR(TratarNulo(cursor_4c_SigCdPam.gruconfs, ""), 10)
                    THIS.this_cPamConConfs   = PADR(TratarNulo(cursor_4c_SigCdPam.conconfs, ""), 10)
                ENDIF

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                IF USED("cursor_4c_SigCdPac")
                    USE IN cursor_4c_SigCdPac
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT dopEsts, OpPdCompra, OpZers, AgrupReqs, sigKeys, nmeses FROM SigCdPac", ;
                    "cursor_4c_SigCdPac")
                IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                    THIS.this_cPacDopEsts    = PADR(TratarNulo(cursor_4c_SigCdPac.dopEsts, ""), 20)
                    THIS.this_cPacOpPdCompra = PADR(TratarNulo(cursor_4c_SigCdPac.OpPdCompra, ""), 20)
                    THIS.this_nPacOpZers     = TratarNulo(cursor_4c_SigCdPac.OpZers, 0)
                    THIS.this_nPacAgrupReqs  = TratarNulo(cursor_4c_SigCdPac.AgrupReqs, 0)
                    THIS.this_cSigKey        = PADR(TratarNulo(cursor_4c_SigCdPac.sigKeys, ""), 3)
                    THIS.this_nPacNMeses     = TratarNulo(cursor_4c_SigCdPac.nmeses, 0)
                ENDIF
                IF USED("cursor_4c_SigCdPac")
                    USE IN cursor_4c_SigCdPac
                ENDIF

            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - usada por RegistrarAuditoria() quando o processo
    * de globalizacao grava movimentos (SigMvCab/SigMvItn/SigMvHst/...).
    * Nao ha "registro desta entidade": a chave de auditoria eh o numero da
    * O.P. efetivada por Processar() (this_nNumeroOpGerada).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNumeroOpGerada)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor() / Inserir() / Atualizar() / ExecutarExclusao():
    * este BO deliberadamente NAO sobrescreve esses metodos do BusinessBase.
    *
    * SigPrGlx eh um PROCESSO (previa/globalizacao de saldos), nao um
    * cadastro: nao existe uma unica tabela/cursor/registro que o form
    * carregue, edite e grave via Salvar()/Excluir(). O form OPERACIONAL
    * nao tem botoes de Incluir/Alterar/Excluir - a gravacao real ocorre
    * quando o usuario aciona Processar, que grava diretamente nas tabelas
    * de movimento (SigMvCab/SigMvItn/SigMvHst/SigBxEst/SigOpPic/SigPdMvf/
    * SigCdNec/SigInAtz/SigCdNei) atraves de um metodo proprio desta
    * classe, chamando RegistrarAuditoria() por conta propria quando essa
    * logica for incorporada. Ate la, os stubs herdados de BusinessBase
    * (que devolvem .F. com mensagem de erro) permanecem corretos, pois
    * Salvar()/Excluir() nunca sao acionados por este form.
    *==========================================================================

    *==========================================================================
    * CarregarFotoProduto - busca a figura tecnica do produto (SigCdPro.
    * FigJpgs) e grava decodificada em arquivo temporario, para exibicao em
    * Image (ImgFigJpg). Equivalente a Page1.ImgFigJpg.Click / Page2.
    * GradeItens.Procedure do legado:
    *   lcSql = "Select a.cpros,a.dpros,a.FigJpgs From SigCdPro a
    *             Where a.cpros = '<codigo>'"
    *   lcFoto = Strconv(Strtran(Strtran(Strtran(FigJpgs,
    *               "data:image/png;base64,", ""),
    *               "data:image/jpeg;base64,", ""),
    *               "data:image/jpg;base64,", ""), 14)
    *   StrToFile(lcFoto, lcArquivo)
    *
    * par_cCpros: SigCdPro.Cpros do produto corrente (TmpFinalg.Cpros)
    * par_cArquivoTemp: caminho completo do arquivo .jpg a gravar
    * Retorno: .T. se a figura existia e foi gravada; .F. se o produto nao
    * tem figura (nao eh erro) ou se a consulta falhou (this_cMensagemErro
    * descreve a falha neste ultimo caso)
    *==========================================================================
    FUNCTION CarregarFotoProduto(par_cCpros, par_cArquivoTemp)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFoto, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_FotoProduto")
                USE IN cursor_4c_FotoProduto
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.dpros, a.FigJpgs FROM SigCdPro a " + ;
                "WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoProduto")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao buscar figura do produto: " + CapturarErroSQL()
            ELSE
                IF USED("cursor_4c_FotoProduto") AND !EOF("cursor_4c_FotoProduto")
                    IF !EMPTY(cursor_4c_FotoProduto.FigJpgs) AND !ISNULL(cursor_4c_FotoProduto.FigJpgs)
                        loc_cFoto = STRTRAN(cursor_4c_FotoProduto.FigJpgs, "data:image/png;base64,", "")
                        loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
                        loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
                        loc_cFoto = STRCONV(loc_cFoto, 14)

                        IF STRTOFILE(loc_cFoto, par_cArquivoTemp) > 0
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_FotoProduto")
                USE IN cursor_4c_FotoProduto
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
            IF USED("cursor_4c_FotoProduto")
                USE IN cursor_4c_FotoProduto
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterTipoEstoqueProduto - resolve SigCdGrp.tipoestos do GRUPO do
    * produto, transcrevendo a cadeia de duas consultas do When de
    * GradeItens.Column10 (Page1, dump 7029-7043):
    *
    *   ThisForm.poDataMgr.CursorQuery('SigCdPro','crSigCdPro','CPros',
    *                                   TmpFinalg.Cpros,[Cgrus])
    *   ThisForm.poDataMgr.CursorQuery('SigCdGrp','crSigCdGrp','CGrus',
    *                                   crSigCdPro.CGrus,[TipoEstos])
    *   If InList(CrSigCdGrp.TipoEstos,3,4) ... Disponivel.Visible = .t.
    *
    * O form usa o retorno para decidir a visibilidade de cmd_4c_Disponivel
    * (o InList(.,3,4) fica no FORM, que eh quem conhece o botao).
    *
    * Retorna o tipo de estoque (numeric(1,0)) ou 0 quando o produto/grupo
    * nao for encontrado ou a conexao nao estiver disponivel - 0 nao esta em
    * (3,4), entao o caminho de falha mantem o botao oculto, que eh o estado
    * inicial do legado (Disponivel.Visible = .f. no SCX).
    *==========================================================================
    FUNCTION ObterTipoEstoqueProduto(par_cCpros)
        LOCAL loc_nTipo, loc_cGrupo, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_nTipo = 0

        IF VARTYPE(par_cCpros) != "C" OR EMPTY(par_cCpros)
            RETURN 0
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN 0
        ENDIF

        TRY
            IF THIS.ConsultarTabela("SigCdPro", "cursor_4c_TipoEstPro", "cpros", ALLTRIM(par_cCpros))
                IF USED("cursor_4c_TipoEstPro") AND !EOF("cursor_4c_TipoEstPro")
                    loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_TipoEstPro.cgrus, ""))

                    IF !EMPTY(loc_cGrupo)
                        IF THIS.ConsultarTabela("SigCdGrp", "cursor_4c_TipoEstGrp", "cgrus", loc_cGrupo)
                            IF USED("cursor_4c_TipoEstGrp") AND !EOF("cursor_4c_TipoEstGrp")
                                loc_nTipo = TratarNulo(cursor_4c_TipoEstGrp.tipoestos, 0)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_nTipo = 0
        ENDTRY

        IF USED("cursor_4c_TipoEstPro")
            USE IN cursor_4c_TipoEstPro
        ENDIF
        IF USED("cursor_4c_TipoEstGrp")
            USE IN cursor_4c_TipoEstGrp
        ENDIF

        RETURN loc_nTipo
    ENDFUNC

    *==========================================================================
    * Infraestrutura generica de Processar() - mesmos helpers (com a mesma
    * logica) ja adotados em SigPrGlpBO.prg para o form irmao SigPrGlp, que
    * resolve o mesmo problema (gerenciador de dados Fortyus com cursores
    * buferizados - poDataMgr.CursorQuery/SqlExecute/Update/Commit/RollBack -
    * que nao existe no sistema migrado).
    *==========================================================================

    *--------------------------------------------------------------------------
    * ExecutarSQL - substitui ThisForm.poDataMgr.SqlExecute(sql, cursor).
    * Preserva a area de trabalho corrente (o legado chama SqlExecute DENTRO
    * de SCAN sem reselecionar depois - SQLEXEC() troca a area selecionada).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL)
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarTabela - substitui ThisForm.poDataMgr.CursorQuery(tabela,
    * cursorDestino, campoChave, valorChave). Cursor fica ABERTO; com zero
    * linhas, leitura de campo devolve branco (igual ao legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarTabela(par_cTabela, par_cCursor, par_cCampoChave, par_uValorChave)
        LOCAL loc_cValor, loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        DO CASE
            CASE VARTYPE(par_uValorChave) = "N"
                loc_cValor = FormatarNumeroSQL(par_uValorChave, 0)
            CASE VARTYPE(par_uValorChave) = "D" OR VARTYPE(par_uValorChave) = "T"
                loc_cValor = FormatarDataSQL(par_uValorChave)
            OTHERWISE
                loc_cValor = EscaparSQL(ALLTRIM(TratarNulo(par_uValorChave, "")))
        ENDCASE

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampoChave + " = " + loc_cValor, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0 AND USED(par_cCursor))

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - cria (ou recria VAZIO) um cursor READWRITE com a
    * estrutura COMPLETA da tabela informada (equivale ao AddCursor() do
    * gerenciador Fortyus) - garante que PersistirCursor() cubra toda coluna
    * NOT NULL da tabela destino (regra #22 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_Estrut")
            USE IN cursor_4c_Estrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_Estrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_Estrut")
            SELECT * FROM cursor_4c_Estrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_Estrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(estrutura de " + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome) - helpers canonicos
    * do projeto, que ja devolvem COM aspas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - substitui ThisForm.poDataMgr.Update('<cursor>'):
    * grava em par_cTabela, linha a linha, TODAS as colunas do cursor (que
    * AbrirCursorTabela criou com a estrutura completa da tabela).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Update - " + par_cCursor + ") " + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ReservarSequencia - forma de BLOCO do fGerUniqueKey legado (que o
    * GravaHis legado chama com 4 argumentos, reservando N numeros de uma vez
    * e devolvendo o ULTIMO do bloco). O fGerUniqueKey portado emite UM
    * numero por chamada - o bloco eh reservado aqui, com o MESMO contador
    * (SIGSYSEQ) e a mesma instrucao atomica que ele usa.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ReservarSequencia(par_cChave, par_nQtd)
        LOCAL loc_cChave, loc_nQtd, loc_nRet, loc_nUltimo, loc_nI, loc_lManual

        loc_cChave  = ALLTRIM(TratarNulo(par_cChave, ""))
        loc_nQtd    = MAX(1, INT(TratarNulo(par_nQtd, 1)))
        loc_nUltimo = 0

        IF EMPTY(loc_cChave)
            RETURN 0
        ENDIF

        IF loc_nQtd = 1
            RETURN fGerUniqueKey(loc_cChave)
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF USED("cursor_4c_SeqBloco")
            USE IN cursor_4c_SeqBloco
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "UPDATE SIGSYSEQ SET conteudo = conteudo + " + FormatarNumeroSQL(loc_nQtd, 0) + ;
            " OUTPUT inserted.conteudo AS novo" + ;
            " WHERE valor = " + EscaparSQL(loc_cChave), ;
            "cursor_4c_SeqBloco")

        IF loc_nRet > 0 AND USED("cursor_4c_SeqBloco") AND RECCOUNT("cursor_4c_SeqBloco") > 0
            GO TOP IN cursor_4c_SeqBloco
            loc_nUltimo = INT(TratarNulo(cursor_4c_SeqBloco.novo, 0))
        ENDIF

        IF USED("cursor_4c_SeqBloco")
            USE IN cursor_4c_SeqBloco
        ENDIF

        IF loc_lManual
            IF loc_nUltimo > 0
                = SQLCOMMIT(gnConnHandle)
            ELSE
                = SQLROLLBACK(gnConnHandle)
            ENDIF
        ENDIF

        IF loc_nUltimo = 0
            FOR loc_nI = 1 TO loc_nQtd
                loc_nUltimo = fGerUniqueKey(loc_cChave)
                IF loc_nUltimo = 0
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        RETURN loc_nUltimo
    ENDFUNC

    *==========================================================================
    * NOTA DE ESCOPO - fRecalculaP / fRecalculaC (recalculo de custo/preco
    * medio de estoque, SigOpClP/SigOpClC)
    *
    * O Click legado (Processar) chama fRecalculaP/fRecalculaC apos cada
    * Insert Into crSigMvHst (retorno descartado, "=fRecalculaP(...)") e em
    * dois pares de fecho em lote, onde o retorno gateia llErro (dump linhas
    * 5875-5876, 5888-5889, 5960-5961, 5973-5974, 6048-6055, 6435-6442).
    *
    * As DUAS funcoes NAO existem no acervo migrado - mesma auditoria e
    * mesma decisao JA tomadas em SigPrGlpBO.prg (ver NOTA DE ESCOPO la: regra
    * #27 do CLAUDE.md, 3a linha da tabela - funcao que produz VALOR DE
    * CALCULO fica AUSENTE e visivel, nunca vira stub). As chamadas foram
    * OMITIDAS, nao stubadas; os pares de fecho NAO marcam llErro (abortar
    * desfaria toda a geracao de O.P. por causa de uma funcao inexistente).
    *
    * CONSEQUENCIA FUNCIONAL A REPORTAR: apos Processar(), o custo/preco medio
    * de estoque NAO eh recalculado. Os movimentos (SigMvHst/SigBxEst/
    * SigMvItn/SigMvIts/SigMvCab/SigOpPic/SigPdMvf/SigCdNec/SigCdNei/
    * SigOpPii/SigInAtz) sao gravados corretamente.
    *
    * Cada ponto esta marcado abaixo com
    * "*-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)".
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDbParam - resolve as tres colunas do cursor "DBParam" do
    * legado (montado no Click do grandparent FormSigPrGlo): CodTgOps =
    * _lcTpGOp; OpZers = Iif(GerPorTp, SigInTgo.OpZers, SigCdPac.OpZers);
    * EntPes = Iif(GerPorTp, SigInTgo.EntPes, 0). Mesmo padrao ja adotado em
    * SigPrGlpBO.CarregarDbParam.
    *--------------------------------------------------------------------------
    FUNCTION CarregarDbParam()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cDbCodTgOps = PADR(ALLTRIM(THIS.this_cTipoGeracaoOP), 10)

            IF THIS.this_lGerPorTp
                THIS.this_nDbOpZers = 0
                THIS.this_nDbEntPes = 0

                IF USED("cursor_4c_TpGOp")
                    USE IN cursor_4c_TpGOp
                ENDIF
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    IF SQLEXEC(gnConnHandle, ;
                            "SELECT opzers, entpes FROM SigInTgo WHERE codigos = " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cTipoGeracaoOP)), ;
                            "cursor_4c_TpGOp") >= 0 AND USED("cursor_4c_TpGOp")

                        IF !EOF("cursor_4c_TpGOp")
                            THIS.this_nDbOpZers = TratarNulo(cursor_4c_TpGOp.opzers, 0)
                            THIS.this_nDbEntPes = TratarNulo(cursor_4c_TpGOp.entpes, 0)
                        ENDIF
                        USE IN cursor_4c_TpGOp
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "(SigInTgo) " + CapturarErroSQL()
                    ENDIF
                ENDIF
            ELSE
                THIS.this_nDbOpZers = THIS.this_nPacOpZers
                THIS.this_nDbEntPes = 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigPrGlxBO.CarregarDbParam")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizaPeso - transcricao de SIGPRGLX.atualizapeso (dump 4109-4144).
    * Opera sobre o cursor CORRENTE (cCompo = Alias() no legado) e devolve o
    * peso/quantidade total dos componentes que entram no custo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AtualizaPeso()
        LOCAL loc_cCompo, loc_nTotQtd, loc_cQuery, loc_nFator, loc_cUni, loc_lFalhou

        loc_cCompo  = ALIAS()
        loc_nTotQtd = 0
        loc_lFalhou = .F.

        IF EMPTY(loc_cCompo) OR !USED(loc_cCompo)
            RETURN 0
        ENDIF

        IF THIS.this_nPamAutComps != 1
            SELECT (loc_cCompo)
            SCAN
                IF !USED("crSigCdCom")
                    LOOP
                ENDIF

                SELECT crSigCdCom
                GO TOP IN crSigCdCom
                LOCATE FOR crSigCdCom.CGrus = EVALUATE(loc_cCompo + ".CGrus") ;
                       AND crSigCdCom.Custos = 1

                IF !EOF("crSigCdCom")
                    loc_cQuery = "SELECT a.cUnis, a.cUnips, b.BPesos" + ;
                        " FROM SigCdPro a, SigCdGrp b" + ;
                        " WHERE a.CPros = " + EscaparSQL(ALLTRIM(EVALUATE(loc_cCompo + ".Mats"))) + ;
                        " AND a.CGrus = b.CGrus"

                    IF !THIS.ExecutarSQL(loc_cQuery, "crSomaGru", "crSomaGru - 1")
                        loc_lFalhou = .T.
                        EXIT
                    ENDIF

                    GO TOP IN crSomaGru

                    IF !EOF("crSomaGru") AND INLIST(TratarNulo(crSomaGru.BPesos, 0), 1, 3)
                        loc_cUni = IIF(TratarNulo(crSomaGru.BPesos, 0) = 1, ;
                            TratarNulo(crSomaGru.cUnis, ""), TratarNulo(crSomaGru.cUnips, ""))

                        IF !THIS.ExecutarSQL( ;
                                "SELECT Fators FROM SigCdUni WHERE Cunis = " + ;
                                EscaparSQL(ALLTRIM(loc_cUni)), "LocalUni", "LocalUni")
                            loc_lFalhou = .T.
                            EXIT
                        ENDIF

                        loc_nFator = 1
                        IF USED("LocalUni") AND !EOF("LocalUni")
                            loc_nFator = IIF(TratarNulo(LocalUni.Fators, 0) = 0, 1, ;
                                TratarNulo(LocalUni.Fators, 0))
                        ENDIF

                        SELECT (loc_cCompo)
                        loc_nTotQtd = loc_nTotQtd + ( ;
                            IIF(TratarNulo(crSomaGru.BPesos, 0) = 1, ;
                                EVALUATE(loc_cCompo + ".Qtds"), ;
                                EVALUATE(loc_cCompo + ".Pesos")) * loc_nFator)
                    ENDIF
                ENDIF

                SELECT (loc_cCompo)
            ENDSCAN

            SELECT (loc_cCompo)
        ENDIF

        IF loc_lFalhou
            loc_nTotQtd = 0
        ENDIF

        RETURN loc_nTotQtd
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravaHis - transcricao de SIGPRGLX.gravahis (dump 4149-4215). Atribui
    * as chaves primarias do historico de estoque (crSigMvHst): CidChaves =
    * Dtos(Datas) + <letra da operacao> + Transform(seq,"@L 999999") +
    * SigKey, e Seqs = sequencial 'HISTBAR'. As duas sequencias sao BLOCOS
    * reservados de uma vez (ReservarSequencia), equivalente ao
    * fGerUniqueKey de 4 argumentos do legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravaHis()
        LOCAL loc_lOk, loc_cSql, loc_nRegistro, loc_nReservado, loc_nInicio
        LOCAL loc_nRerSeq, loc_nIniSeq, loc_cNewOpe

        loc_lOk = .T.

        IF !USED("crSigMvHst")
            RETURN .T.
        ENDIF

        IF USED("LocalOpe")
            USE IN LocalOpe
        ENDIF
        IF THIS.ExecutarSQL( ;
                "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests" + ;
                " FROM SigCdOpe WHERE 1 = 0", "cursor_4c_OpeEstr", "LocalOpe")
            SELECT * FROM cursor_4c_OpeEstr WHERE .F. INTO CURSOR LocalOpe READWRITE
            USE IN cursor_4c_OpeEstr
        ELSE
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            SELECT DISTINCT Dopes FROM crSigMvHst INTO CURSOR SelOperacao

            SELECT SelOperacao
            SCAN
                loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests" + ;
                    " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(SelOperacao.Dopes))
                IF !THIS.ExecutarSQL(loc_cSql, "xTmpOpe", "xTmpOpe")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                IF USED("xTmpOpe") AND RECCOUNT("xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                SELECT SelOperacao
            ENDSCAN
        ENDIF

        IF loc_lOk
            SELECT LocalOpe
            INDEX ON Dopes TAG Dopes

            SELECT SelOperacao
            SCAN
                loc_cSql = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos," + ;
                    " EstOrigs, EstDests FROM SigCdOpd WHERE Dopps = " + ;
                    EscaparSQL(ALLTRIM(SelOperacao.Dopes))
                IF !THIS.ExecutarSQL(loc_cSql, "xTmpOpe", "xTmpOpe - Opd")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                IF USED("xTmpOpe") AND RECCOUNT("xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                SELECT SelOperacao
            ENDSCAN
        ENDIF

        IF loc_lOk
            WAIT WINDOW "Criando Chaves Prim" + CHR(225) + "rias no Arquivo de Hist" + CHR(243) + "rico " NOWAIT

            SELECT crSigMvHst
            GO TOP
            loc_nRegistro = RECCOUNT("crSigMvHst")

            IF loc_nRegistro > 0
                loc_nReservado = THIS.ReservarSequencia(DTOS(crSigMvHst.Datas), loc_nRegistro + 1)
                loc_nRerSeq    = 0
                IF loc_nReservado > 0
                    loc_nRerSeq = THIS.ReservarSequencia("HISTBAR", loc_nRegistro + 1)
                ENDIF

                IF loc_nReservado = 0 OR loc_nRerSeq = 0
                    WAIT CLEAR
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "N" + CHR(227) + "o foi poss" + CHR(237) + "vel reservar a numera" + ;
                        CHR(231) + CHR(227) + "o do hist" + CHR(243) + "rico de estoque."
                    RETURN .F.
                ENDIF

                loc_nInicio = loc_nReservado - loc_nRegistro
                loc_nIniSeq = loc_nRerSeq - loc_nRegistro

                SELECT crSigMvHst
                SCAN
                    loc_nInicio = loc_nInicio + 1
                    loc_nIniSeq = loc_nIniSeq + 1

                    loc_cNewOpe = TratarNulo(crSigMvHst.Opers, " ")

                    REPLACE CidChaves WITH DTOS(crSigMvHst.Datas) + loc_cNewOpe + ;
                            TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
                            Seqs      WITH loc_nIniSeq ;
                        IN crSigMvHst

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDSCAN
            ENDIF

            WAIT CLEAR
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursoresDestino - equivale ao "Select crXxx / Zap" do topo do
    * Click legado (dump 4574-4597): os cursores de gravacao nascem aqui,
    * VAZIOS e com a estrutura COMPLETA da tabela destino (AbrirCursorTabela),
    * em vez de ZAP num cursor pre-existente (ZAP em DataSession privada ja
    * travou a tela neste projeto). SigPrGlx usa as MESMAS 9 tabelas de
    * SigPrGlpBO + CrSigOpPii/CrSigInAtz (entrada automatica/producao com
    * selecao manual liberada).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararCursoresDestino()
        LOCAL loc_lOk

        loc_lOk = THIS.AbrirCursorTabela("crSigOpPic", "SigOpPic")
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigPdMvf", "SigPdMvf")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigCdNec", "SigCdNec")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvCab", "SigMvCab")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvHst", "SigMvHst")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigBxEst", "SigBxEst")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvItn", "SigMvItn")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvIts", "SigMvIts")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigCdNei", "SigCdNei")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigOpPii", "SigOpPii")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigInAtz", "SigInAtz")
        ENDIF

        *-- Select * From CrSigCdNei Where 0=1 Into Cursor GrSigCdNei ReadWrite
        IF loc_lOk
            IF USED("GrSigCdNei")
                USE IN GrSigCdNei
            ENDIF
            SELECT * FROM crSigCdNei WHERE .F. INTO CURSOR GrSigCdNei READWRITE
            loc_lOk = USED("GrSigCdNei")
        ENDIF

        *-- crTplMvIts / crTpmMvItn: cursores de TRABALHO (consolidados em
        *-- crSigMvIts/crSigMvItn por ConsolidarMovimentoItens)
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crTplMvIts", "SigMvIts")
            IF loc_lOk
                SELECT crTplMvIts
                INDEX ON Cpros TAG Cpros
            ENDIF
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crTpmMvItn", "SigMvItn")
            IF loc_lOk
                SELECT crTpmMvItn
                INDEX ON Cpros TAG Cpros
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharCursoresProcessamento - libera os cursores de trabalho criados
    * por Processar(), tornando-o reexecutavel na mesma sessao do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresProcessamento()
        LOCAL ARRAY loc_aCursores[38]
        LOCAL loc_nI

        loc_aCursores[1]  = "crSigOpPic"
        loc_aCursores[2]  = "crSigPdMvf"
        loc_aCursores[3]  = "crSigCdNec"
        loc_aCursores[4]  = "crSigCdNei"
        loc_aCursores[5]  = "crSigMvCab"
        loc_aCursores[6]  = "crSigMvHst"
        loc_aCursores[7]  = "crSigBxEst"
        loc_aCursores[8]  = "crSigMvItn"
        loc_aCursores[9]  = "crSigMvIts"
        loc_aCursores[10] = "crSigOpPii"
        loc_aCursores[11] = "crSigInAtz"
        loc_aCursores[12] = "GrSigCdNei"
        loc_aCursores[13] = "crTplMvIts"
        loc_aCursores[14] = "crTpmMvItn"
        loc_aCursores[15] = "TmpEmpH"
        loc_aCursores[16] = "TmpPedra"
        loc_aCursores[17] = "TmpMatPrz"
        loc_aCursores[18] = "TmpEstoque"
        loc_aCursores[19] = "TmpOpePed"
        loc_aCursores[20] = "TmpOpi"
        loc_aCursores[21] = "TmpUltItn"
        loc_aCursores[22] = "TempEest"
        loc_aCursores[23] = "TempEestI"
        loc_aCursores[24] = "TempEsti2"
        loc_aCursores[25] = "LocalCompo"
        loc_aCursores[26] = "crSomaGru"
        loc_aCursores[27] = "LocalUni"
        loc_aCursores[28] = "LocalOpe"
        loc_aCursores[29] = "SelOperacao"
        loc_aCursores[30] = "xTmpOpe"
        loc_aCursores[31] = "crSigPrMtz"
        loc_aCursores[32] = "pEstoque"
        loc_aCursores[33] = "TmpNensi"
        loc_aCursores[34] = "xNensi"
        loc_aCursores[35] = "TmpLinF"
        loc_aCursores[36] = "TmpHis"
        loc_aCursores[37] = "crSigCdOpd"
        loc_aCursores[38] = "crSigCdOpe"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - transcricao do Click do botao Processar (SIGPRGLX.
    * PageDados.Page1.Processar.Click, dump linhas 4562-6466). Efetiva a
    * geracao/transferencia de Ordens de Producao a partir dos cursores
    * TmpFinal/TmpFinalg (preparados pelo form pai - FormSigPrGl2BO.
    * ExecutarProcessamento) e, quando configurado, das grades de ajuste
    * manual (cursor_4c_TmpSaldo/TmpSaldg/TmpFabr e cursor_4c_Requisicao).
    *
    * CONTRATO (fixado em FormSigPrGlx.BtnProcessarClick): sem parametros. O
    * form preenche antes this_dPrevisao (_Prev) e this_dDataGeracao
    * (_DtGera) a partir do grandparent (FormSigPrGlo), e this_lPorDestino
    * ja vem do Init. Devolve .T. em sucesso, com this_nNumeroOpGerada =
    * _Nump; em falha devolve .F. com this_cMensagemErro preenchido.
    *
    * NAO transcrito (confirmado morto no dump): "Keyboard '{ESC}'" x3 do
    * fecho (fecha o form - fica no form, nao no BO) e os literais de
    * MessageBox substituidos por this_cMensagemErro.
    *
    * FICA NO FORM: ThisForm.Aguarde/Enabled dos botoes e o
    * "Do Form SigReGli"/Cancelar.Click() do fecho (SigReGli nao foi
    * migrado - FormSigPrGlx.BtnProcessarClick mostra o numero da O.P. via
    * MsgInfo e fecha o form, mesmo padrao ja adotado em FormSigPrGlp).
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lSucesso, loc_oErro, loc_cExactOrig

        *-- Estado compartilhado com os metodos de bloco (PRIVATE - visivel
        *-- para THIS.ProcessarXxx() chamados daqui, igual as Private/Local
        *-- do Click legado e ao mesmo padrao de SigPrGlpBO.Processar)
        PRIVATE loc_lAbortar, loc_tDay, loc_cEmpr, loc_cUsuar
        PRIVATE loc_cDopp, loc_cDope, loc_cDopEst, loc_nNump, loc_nRnop, loc_nNumpe, loc_nSeqs
        PRIVATE loc_cCpros, loc_cReff, loc_cCor, loc_cTam, loc_dPrev, loc_dDtGera
        PRIVATE loc_nTProd, loc_nTPeso, loc_cClinha, loc_cNota
        PRIVATE loc_cGrupoD, loc_cContaD, loc_nNume, loc_nCitens, loc_cDopePed, loc_lPedUtilz

        loc_lSucesso = .F.
        loc_lAbortar = .F.
        THIS.this_cMensagemErro   = ""
        THIS.this_nNumeroOpGerada = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados." + CHR(13) + ;
                "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF
        IF !USED("TmpFinal") OR !USED("TmpFinalg")
            THIS.this_cMensagemErro = "Os dados da pr" + CHR(233) + "via n" + CHR(227) + ;
                "o est" + CHR(227) + "o dispon" + CHR(237) + "veis." + CHR(13) + ;
                "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        *-- SET EXACT: o Click legado depende do default do VFP (EXACT OFF)
        *-- para os SEEK PARCIAIS sobre indices compostos (Seek(cPros) sobre
        *-- Cpros+CodCors+CodTams, etc). config.prg deste projeto liga SET
        *-- EXACT ON - com EXACT ON o SEEK parcial nunca casaria. Restaurado
        *-- no fim, inclusive no caminho do CATCH.
        loc_cExactOrig = SET("EXACT")
        SET EXACT OFF

        TRY
            loc_tDay   = DATETIME()
            loc_cEmpr  = PADR(go_4c_Sistema.cCodEmpresa, 3)
            loc_cUsuar = PADR(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10), 10)
            loc_lPedUtilz = .F.

            IF !THIS.PrepararCursoresDestino()
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar AND !THIS.CarregarDbParam()
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                loc_cDopp   = PADR(THIS.this_cDoppPads, 20)
                loc_cDope   = PADR(THIS.this_cTransfRes, 20)
                loc_cDopEst = PADR(THIS.this_cPacDopEsts, 20)

                IF !THIS.ConsultarTabela("SigCdOpd", "crSigCdOpd", "Dopps", ALLTRIM(loc_cDopp))
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- Numero da O.P. (_Nump) ou da reserva (_Rnop) + conferencia de duplicidade
            IF !loc_lAbortar
                loc_nNump = 0
                loc_nRnop = 0
                IF !THIS.this_lReserva
                    IF THIS.this_nPamGlobAutos = 2 AND THIS.this_nNumeroDaOp > 0
                        loc_nNump = THIS.this_nNumeroDaOp
                    ELSE
                        loc_nNump = fGerUniqueKey(ALLTRIM(loc_cDopp))
                    ENDIF

                    IF !THIS.ExecutarSQL("SELECT Numps FROM SigOpPic WHERE Numps = " + ;
                            FormatarNumeroSQL(loc_nNump, 0), "TmpOpi", "TmpOpi")
                        loc_lAbortar = .T.
                    ELSE
                        IF RECCOUNT("TmpOpi") > 0
                            THIS.this_cMensagemErro = "N" + CHR(250) + "mero de Op j" + CHR(225) + ;
                                " existe. Favor Corrigir!!!"
                            loc_lAbortar = .T.
                        ENDIF
                    ENDIF
                ELSE
                    loc_nRnop = fGerUniqueKey("RESERVAPCP")
                ENDIF
            ENDIF

            IF !loc_lAbortar
                loc_nSeqs   = 0
                loc_cCpros  = ""
                loc_cReff   = SPACE(15)
                loc_cCor    = SPACE(4)
                loc_cTam    = SPACE(2)
                loc_dPrev   = ConverterParaData(THIS.this_dPrevisao)
                loc_dDtGera = ConverterParaData(THIS.this_dDataGeracao)
                loc_nTProd  = 0
                loc_nTPeso  = 0
                loc_cClinha = SPACE(10)
                loc_cNota   = SPACE(6)
                loc_cGrupoD = SPACE(10)
                loc_cContaD = SPACE(10)
                loc_nNumpe  = (loc_nNump * 10000) + 1
                loc_nNume   = 0
                loc_nCitens = 0

                IF USED("TmpEmpH")
                    USE IN TmpEmpH
                ENDIF
                CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), QtdGReqs N(12,3), ;
                    cpro2s C(14))
                INDEX ON Cgrus + Cmats TAG GruMat
                INDEX ON CMats + cpro2s TAG CMats

                IF USED("TmpPedra")
                    USE IN TmpPedra
                ENDIF
                CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), QtdGReqs N(12,3))
                INDEX ON Cgrus + Cmats TAG GruMat
                INDEX ON CMats TAG CMats

                IF USED("TmpMatPrz")
                    USE IN TmpMatPrz
                ENDIF
                CREATE CURSOR TmpMatPrz (cMats C(14), Qtds N(12,3), Pesos N(12,3), ;
                    PrazoEnts D, QtBaixas N(12,3))
                INDEX ON DTOC(PrazoEnts) + Cmats TAG MatPrazo DESC

                loc_cDopePed = PADR(THIS.this_cPacOpPdCompra, 20)
                IF !THIS.ConsultarTabela("SigCdOpe", "TmpOpePed", "Dopes", ALLTRIM(loc_cDopePed))
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- Cabecalho da operacao de baixa de estoque de fabricacao
            *-- (_DopEst) - equivalente ao Insert Into CrSigMvCab do topo do
            *-- Click legado (dump 4671-4681)
            IF !loc_lAbortar
                loc_nNume = fGerUniqueKey(ALLTRIM(loc_cDopEst) + loc_cEmpr)

                IF !THIS.ExecutarSQL("SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                        EscaparSQL(ALLTRIM(loc_cDopEst)), "crSigCdOpe", "crSigCdOpe")
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                        Grupoos, Contaos, Grupods, Contads, Obses, CidChaves, Dtalts, ;
                        EmpDopNums, rNops, PrazoEnts) ;
                    VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                        loc_dDtGera, DATE(), loc_cUsuar, ;
                        crSigCdOpe.GruOrigs, crSigCdOpe.ConOrigs, crSigCdOpe.GruDests, crSigCdOpe.ConDests, ;
                        " [ Reserva Autom" + CHR(225) + "tica ] ", fUniqueIds(), DATE(), ;
                        loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6), loc_nRnop, {})

                THIS.ProcessarProducao()
            ENDIF

            IF !loc_lAbortar
                THIS.ProcessarBaixaEstoque()
            ENDIF

            IF !loc_lAbortar
                THIS.ProcessarBaixaProducao()
            ENDIF

            IF !loc_lAbortar
                IF !loc_lPedUtilz
                    *-- "If Not llPedUtilz / Delete crSigMvCab do Dopest" -
                    *-- nada foi usado dessa operacao de baixa - desfaz o
                    *-- cabecalho que a abre (dump 5500-5508)
                    = fCanUniqueKey(loc_nNume, ALLTRIM(loc_cDopEst) + loc_cEmpr)
                    SELECT crSigMvCab
                    LOCATE FOR Dopes = loc_cDopEst
                    IF FOUND()
                        DELETE
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT crSigOpPic
                APPEND FROM DBF("TmpOpi")
                REPLACE ALL CodTgOps WITH THIS.this_cDbCodTgOps IN crSigOpPic
            ENDIF

            IF !loc_lAbortar
                THIS.ProcessarRequisicaoPedras()
            ENDIF

            IF !loc_lAbortar
                SELECT crTpmMvItn
                SCAN
                    INSERT INTO crSigMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, ;
                            Opers, Citens, EmpDopNums, CidChaves, DtAlts, cpro2s) ;
                        VALUES (crTpmMvItn.Emps, crTpmMvItn.Dopes, crTpmMvItn.Numes, crTpmMvItn.CPros, ;
                            crTpmMvItn.Qtds, crTpmMvItn.Cunis, crTpmMvItn.Dpros, crTpmMvItn.Opers, ;
                            crTpmMvItn.citens, crTpmMvItn.Emps + crTpmMvItn.Dopes + STR(crTpmMvItn.Numes, 6), ;
                            fUniqueIds(), DATETIME(), crTpmMvItn.Cpro2s)
                    SELECT crTpmMvItn
                ENDSCAN

                SELECT crTplMvIts
                SCAN
                    INSERT INTO CrSigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, ;
                            CodTams, QtdEmbs) ;
                        VALUES (crTplMvIts.Citens, crTplMvIts.Emps, crTplMvIts.Dopes, crTplMvIts.Numes, ;
                            crTplMvIts.CPros, crTplMvIts.Qtds, crTplMvIts.CodCors, crTplMvIts.CodTams, 1)
                    SELECT crTplMvIts
                ENDSCAN
            ENDIF

            IF !loc_lAbortar
                THIS.ProcessarEntradaAutomatica()
            ENDIF

            IF !loc_lAbortar
                IF !THIS.GravaHis()
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT crSigMvHst
                GO TOP
                IF !EOF("crSigMvHst")
                    SCAN
                        REPLACE cIdChaves WITH DTOS(crSigMvHst.Datas) + crSigMvHst.Opers + ;
                                PADL(fGerUniqueKey(DTOS(crSigMvHst.Datas)), 6, "0") IN crSigMvHst
                    ENDSCAN
                ENDIF
            ENDIF

            IF !loc_lAbortar
                IF THIS.GravarMovimentos()
                    loc_lSucesso = .T.
                ELSE
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF loc_lSucesso AND THIS.this_lAutomatico
                IF !THIS.ProcessarModoAutomatico()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.this_nNumeroOpGerada = loc_nNump
            ENDIF

        CATCH TO loc_oErro
            = SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                " / " + TRANSFORM(loc_oErro.Procedure) + "]"
            loc_lSucesso = .F.
        ENDTRY

        THIS.FecharCursoresProcessamento()

        IF loc_cExactOrig = "ON"
            SET EXACT ON
        ELSE
            SET EXACT OFF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarProducao - "If Not ThisForm.Reserva ... EndIf" (dump
    * 4683-5017): marca o cabecalho (Nops/Rnops), monta TmpFinal a partir de
    * TmpFinalg (Produzir2) e, por item com Produzir<>0, gera a O.P. de
    * producao (industrializacao, quebrada pela capacidade QtPcs da linha)
    * OU o pedido de compra do acabado (fornecedor externo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarProducao()
        LOCAL loc_lOk, loc_nQtdLim, loc_nQtBaixar, loc_nLnVezes, loc_nQtBaixado
        LOCAL loc_nNopComp, loc_cCidC, loc_cQuery, loc_nQtdTb, loc_nQtdCpnt
        LOCAL loc_uUnits, loc_cMoedas, loc_cEpn, loc_nPesoCmp
        LOCAL loc_cForn, loc_nTotPed, loc_nCitensPed
        LOCAL loc_nBaixa, loc_cPEdn, loc_nPItn, loc_cPIds, loc_nPendente, loc_nPQtd, loc_cPId2, loc_nPQt2

        loc_lOk = .T.

        IF !THIS.this_lReserva

            REPLACE Nops WITH loc_nNump, Rnops WITH loc_nNump IN crSigMvCab

            SELECT TmpFinal
            DELETE FOR KeyPdes = .T.

            SELECT TmpFinalg
            SCAN
                IF TmpFinalg.Produzir2 = 0
                    LOOP
                ENDIF

                = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpFinalg.CPros))

                loc_cGrupoD = IIF(THIS.this_lPorDestino AND !EMPTY(crSigMvCab.GrupoDs), ;
                    crSigMvCab.GrupoDs, crSigCdOpd.GruDests)
                loc_cContaD = IIF(THIS.this_lPorDestino AND !EMPTY(crSigMvCab.ContaDs), ;
                    crSigMvCab.ContaDs, crSigCdOpd.ConDests)

                INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, ;
                        Produzir, Obsps, Obs, Datas, Entregas, CodCors, CodTams, Linhas, Citens, ;
                        Reffs, Notas, Dpros, GrupoDs, ContaDs, KeyPdes) ;
                    VALUES (crSigMvCab.Emps, crSigMvCab.Dopes, crSigMvCab.Numes, TmpFinalg.CPros, ;
                        TmpFinalg.Qtds, crSigCdPro.PesoMs, 0, 0, TmpFinalg.Produzir2, "", "", ;
                        crSigMvCab.Datas, crSigMvCab.PrazoEnts, TmpFinalg.CodCors, TmpFinalg.CodTams, ;
                        crSigCdPro.Linhas, 0, crSigCdPro.Reffs, "", crSigCdPro.Dpros, ;
                        loc_cGrupoD, loc_cContaD, .T.)

                SELECT TmpFinalg
            ENDSCAN

            SELECT TmpFinal
            INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + CodTams + GrupoDs + ContaDs ;
                TAG Cpros FOR Produzir > 0
            SET ORDER TO Cpros
            GO TOP

            DO WHILE !EOF("TmpFinal")
                IF TmpFinal.Produzir != 0

                    = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpFinal.CPros))
                    = THIS.ConsultarTabela("SigCdLin", "CrSigCdLin", "Linhas", ALLTRIM(TmpFinal.Linhas))
                    = THIS.ConsultarTabela("SigCdGrp", "CrSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.Cgrus))
                    = THIS.ConsultarTabela("SigCdGpr", "CrSigCdGpr", "Codigos", ALLTRIM(CrSigCdGrp.Mercs))

                    IF EMPTY(THIS.this_cPacOpPdCompra) OR crSigCdPro.FabrProPrs = 1
                        *-- INDUSTRIALIZACAO: quebra Produzir pela capacidade
                        *-- (QtPcs) da linha de producao
                        loc_nQtdLim   = IIF(CrSigCdLin.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin.QtPcs)
                        loc_nQtBaixar = TmpFinal.Produzir
                        loc_nLnVezes  = 0

                        DO WHILE loc_nQtBaixar > 0
                            loc_nLnVezes = loc_nLnVezes + 1

                            IF loc_nQtBaixar < loc_nQtdLim
                                loc_nQtBaixado = loc_nQtBaixar
                                loc_nQtBaixar  = 0
                            ELSE
                                loc_nQtBaixar  = loc_nQtBaixar - loc_nQtdLim
                                loc_nQtBaixado = loc_nQtdLim
                            ENDIF

                            IF (loc_cClinha + loc_cReff + loc_cCpros + loc_cNota + loc_cCor + ;
                                    loc_cGrupoD + loc_cContaD != TmpFinal.Linhas + TmpFinal.Reffs + ;
                                    TmpFinal.CPros + TmpFinal.Notas + TmpFinal.CodCors + ;
                                    TmpFinal.GrupoDs + TmpFinal.ContaDs) OR loc_nLnVezes > 1

                                loc_cClinha  = TmpFinal.Linhas
                                loc_cCpros   = TmpFinal.CPros
                                loc_cCor     = TmpFinal.CodCors
                                loc_cTam     = TmpFinal.CodTams
                                loc_cReff    = TmpFinal.Reffs
                                loc_cGrupoD  = TmpFinal.GrupoDs
                                loc_cContaD  = TmpFinal.ContaDs
                                loc_nSeqs    = loc_nSeqs + 1
                                loc_cNota    = TmpFinal.Notas
                                loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
                                loc_cCidC    = DTOS(loc_dDtGera) + ;
                                    TRANSFORM(fGerUniqueKey(DTOS(loc_dDtGera)), "@L 999999") + THIS.this_cSigKey

                                INSERT INTO crSigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, ;
                                        Grupoos, Contaos, Grupods, Contads, Nops, CodPds, Unids, ;
                                        Pesos, Qtds, Ordems, cIdChaves, EmpDopNums, EmpDNps) ;
                                    VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, DATETIME(), loc_dDtGera, ;
                                        loc_cUsuar, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, loc_cGrupoD, ;
                                        loc_cContaD, loc_nNopComp, loc_cCpros, crSigCdPro.CUnis, ;
                                        IIF(THIS.this_nDbOpZers = 1, 0, loc_nTPeso), loc_nTProd, 1, loc_cCidC, ;
                                        loc_cEmpr + SPACE(20) + STR(0, 6), ;
                                        loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10))

                                INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, ;
                                        TotPesos, Grupoos, Contaos, Grupods, Contads, cIdChaves, ;
                                        EmpDNps, Jobs) ;
                                    VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, DATETIME(), loc_dDtGera, ;
                                        loc_cUsuar, loc_nTPeso, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                        loc_cGrupoD, loc_cContaD, loc_cCidC, ;
                                        loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), TmpFinal.Jobs)

                                INSERT INTO GrSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
                                        cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves, nenvs) ;
                                    VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, loc_nNopComp, loc_nNopComp, ;
                                        loc_cCpros, crSigCdPro.Dpros, crSigCdPro.Cunis, ;
                                        IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                        IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                        THIS.this_cPamTpOpEntAus, loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), ;
                                        fUniqueIds(), loc_nNopComp)

                                loc_nTProd = 0
                                loc_nTPeso = 0
                            ENDIF

                            loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs

                            IF crSigCdGrp.GeraTubs != 2
                                loc_nQtdTb = crSigCdPro.QtdCpnts
                            ELSE
                                loc_lOk = THIS.ExecutarSQL("SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                    "WHERE Cpros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), ;
                                    "crSigPrMtz", "crSigPrMtz")
                                IF !loc_lOk
                                    EXIT
                                ENDIF
                                loc_nQtdTb = TratarNulo(crSigPrMtz.Total, 0)
                            ENDIF
                            loc_nQtdCpnt = TratarNulo(loc_nQtdTb, 0) * loc_nQtBaixado

                            loc_uUnits  = 0
                            loc_cMoedas = SPACE(3)

                            loc_cQuery = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                                EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)) + ;
                                " AND CPros = " + EscaparSQL(ALLTRIM(TmpFinal.Cpros))
                            loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
                            IF !loc_lOk
                                EXIT
                            ENDIF

                            SELECT TempEestI
                            SCAN
                                IF TempEestI.CItens = TmpFinal.Citens
                                    loc_uUnits  = TempEestI.Units
                                    loc_cMoedas = TempEestI.Moedas
                                    EXIT
                                ENDIF
                            ENDSCAN
                            IF TmpFinal.KeyPdes
                                loc_uUnits  = crSigCdPro.pVens
                                loc_cMoedas = crSigCdPro.Moevs
                            ENDIF

                            INSERT INTO crSigOpPic (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, ;
                                    Dataps, Obss, Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, ;
                                    QtdCpnts, Units, Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, ;
                                    Empds, EmpDopNops, Dpros, CodTgOps, Citens) ;
                                VALUES (loc_cEmpr, loc_cDopp, loc_nNump, loc_nNopComp, TmpFinal.Dopes, ;
                                    TmpFinal.Numes, loc_dPrev, TmpFinal.Datas, TmpFinal.Obsps, ;
                                    loc_nQtBaixado, loc_cCpros, loc_dDtGera, TmpFinal.CodCors, ;
                                    TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, loc_nQtdCpnt, ;
                                    loc_uUnits, loc_cMoedas, fUniqueIds(), ;
                                    TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6), ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNump, 10), TmpFinal.Notas, TmpFinal.Emps, ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), TmpFinal.Dpros, ;
                                    THIS.this_cDbCodTgOps, TmpFinal.Citens)

                            *-- Baixa QtProds em SigMvItn/SigMvIts pela
                            *-- quantidade deste lote (dump 4837-4914)
                            SELECT TempEestI
                            loc_nBaixa = loc_nQtBaixado
                            SCAN WHILE loc_nBaixa > 0
                                loc_cPEdn = TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6)
                                loc_nPItn = TempEestI.Citens
                                loc_cPIds = TempEestI.cIdChaves

                                IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) != 0
                                    loc_lOk = THIS.ExecutarSQL( ;
                                        "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cPEdn) + ;
                                        " AND CItens = " + FormatarNumeroSQL(loc_nPItn, 0), ;
                                        "TempEsti2", "TempEsti2 - 1")
                                    IF !loc_lOk
                                        EXIT
                                    ENDIF

                                    SELECT TempEsti2
                                    GO TOP
                                    IF EOF("TempEsti2")
                                        loc_nPendente = TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds
                                        IF loc_nPendente > loc_nBaixa
                                            loc_nPQtd  = TempEestI.QtProds + loc_nBaixa
                                            loc_nBaixa = 0
                                        ELSE
                                            loc_nPQtd  = TempEestI.QtProds + loc_nPendente
                                            loc_nBaixa = loc_nBaixa - loc_nPendente
                                        ENDIF

                                        loc_lOk = THIS.ExecutarSQL("UPDATE SigMvItn SET DtAlts = " + ;
                                            FormatarDataSQL(loc_tDay) + ", QtProds = " + ;
                                            FormatarNumeroSQL(loc_nPQtd, 3) + " WHERE cIdChaves = " + ;
                                            EscaparSQL(loc_cPIds), "", "Update - 1")
                                        IF !loc_lOk
                                            EXIT
                                        ENDIF
                                    ELSE
                                        SELECT TempEsti2
                                        SCAN WHILE loc_nBaixa > 0
                                            loc_cPId2     = TempEsti2.cIdChaves
                                            loc_nPendente = TempEsti2.Qtds - TempEsti2.QtBaixas - TempEsti2.QtProds
                                            IF loc_nPendente != 0
                                                IF loc_nPendente > loc_nBaixa
                                                    loc_nPQtd  = TempEestI.QtProds + loc_nBaixa
                                                    loc_nPQt2  = TempEsti2.QtProds + loc_nBaixa
                                                    loc_nBaixa = 0
                                                ELSE
                                                    loc_nPQtd  = TempEestI.QtProds + loc_nPendente
                                                    loc_nPQt2  = TempEsti2.QtProds + loc_nPendente
                                                    loc_nBaixa = loc_nBaixa - loc_nPendente
                                                ENDIF

                                                loc_lOk = THIS.ExecutarSQL("UPDATE SigMvItn SET DtAlts = " + ;
                                                    FormatarDataSQL(loc_tDay) + ", QtProds = " + ;
                                                    FormatarNumeroSQL(loc_nPQtd, 3) + " WHERE cIdChaves = " + ;
                                                    EscaparSQL(loc_cPIds), "", "Update - 2")
                                                IF loc_lOk
                                                    loc_lOk = THIS.ExecutarSQL("UPDATE SigMvIts SET QtProds = " + ;
                                                        FormatarNumeroSQL(loc_nPQt2, 3) + " WHERE cIdChaves = " + ;
                                                        EscaparSQL(loc_cPId2), "", "Update - 3")
                                                ENDIF
                                                IF !loc_lOk
                                                    EXIT
                                                ENDIF
                                            ENDIF
                                            SELECT TempEsti2
                                        ENDSCAN
                                    ENDIF
                                ENDIF
                                IF !loc_lOk
                                    EXIT
                                ENDIF
                                SELECT TempEestI
                            ENDSCAN
                            IF !loc_lOk
                                EXIT
                            ENDIF

                            loc_lOk = THIS.ExecutarSQL("UPDATE SigMvCab SET Nops = " + ;
                                FormatarNumeroSQL(loc_nNump, 0) + ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                                " WHERE EmpDopNums = " + ;
                                EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)), ;
                                "", "Update - 4")
                            IF !loc_lOk
                                EXIT
                            ENDIF

                            *-- Composicao SUBSTITUIDA na O.P., se existir
                            loc_cEpn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                            loc_lOk = THIS.ExecutarSQL("SELECT a.*, b.cgrus FROM SigSubMv a " + ;
                                "INNER JOIN SigCdPro b ON a.mats = b.cpros WHERE a.empdopnums = " + ;
                                EscaparSQL(loc_cEpn) + " AND a.cpros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)) + ;
                                " AND a.citem2 = " + FormatarNumeroSQL(TmpFinal.citens, 0), ;
                                "LocalCompo", "LocalCompo")
                            IF !loc_lOk
                                EXIT
                            ENDIF

                            IF THIS.this_nPamAutComps != 1 AND USED("LocalCompo") AND RECCOUNT("LocalCompo") > 0
                                SELECT LocalCompo
                                loc_nPesoCmp = THIS.AtualizaPeso()
                                loc_nTProd = loc_nTProd + loc_nQtBaixado
                                loc_nTPeso = loc_nTPeso + (loc_nQtBaixado * loc_nPesoCmp)

                                SELECT crSigOpPic
                                REPLACE Pesos WITH loc_nQtBaixado * loc_nPesoCmp
                            ELSE
                                loc_nTProd = loc_nTProd + loc_nQtBaixado
                                loc_nTPeso = loc_nTPeso + (loc_nQtBaixado * TmpFinal.Peso)
                            ENDIF

                            SELECT crSigPdMvf
                            REPLACE Pesos WITH IIF(THIS.this_nDbOpZers = 1, 0, loc_nTPeso), Qtds WITH loc_nTProd

                            SELECT GrSigCdNei
                            REPLACE Pesos WITH IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                    Qtds  WITH IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso) ;
                                IN GrSigCdNei

                            SELECT crSigCdNec
                            REPLACE TotPesos WITH loc_nTPeso
                            IF THIS.this_lAutomatico
                                REPLACE Autos WITH .T.
                            ENDIF
                        ENDDO
                        IF !loc_lOk
                            EXIT
                        ENDIF
                    ELSE
                        *-- PEDIDO DE COMPRA do acabado (fornecedor externo)
                        loc_cForn   = IIF(!EMPTY(crSigCdPro.Ifors), crSigCdPro.Ifors, TmpOpePed.ConOrigs)
                        loc_nTotPed = TmpFinal.Produzir

                        SELECT crSigMvCab
                        GO TOP
                        LOCATE FOR Dopes = ALLTRIM(loc_cDopePed) AND ContaDs = loc_cForn
                        IF FOUND()
                            loc_nNume = crSigMvCab.Numes

                            IF USED("TmpUltItn")
                                USE IN TmpUltItn
                            ENDIF
                            SELECT MAX(Citens) AS Citens FROM crTpmMvItn ;
                                WHERE Emps = loc_cEmpr AND Dopes = ALLTRIM(loc_cDopePed) AND Numes = loc_nNume ;
                                INTO CURSOR TmpUltItn
                            loc_nCitensPed = TratarNulo(TmpUltItn.Citens, 0) + 1
                        ELSE
                            loc_nCitensPed = 9999
                        ENDIF

                        IF loc_nCitensPed >= 9999
                            loc_nCitensPed = 1
                            loc_nNume = fGerUniqueKey(ALLTRIM(loc_cEmpr) + ALLTRIM(loc_cDopePed))

                            INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                                    Grupoos, Contaos, Grupods, Contads, Nops, Obses, Empdopnums, ;
                                    cIdChaves, DtAlts) ;
                                VALUES (loc_cEmpr, loc_cDopePed, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                                    loc_dDtGera, DATETIME(), loc_cUsuar, TmpOpePed.GruOrigs, loc_cForn, ;
                                    TmpOpePed.GruDests, TmpOpePed.ConDests, loc_nNump, ;
                                    "[ OP: " + TRANSFORM(loc_nNump) + "] ", ;
                                    loc_cEmpr + loc_cDopePed + STR(loc_nNume, 6), fUniqueIds(), DATETIME())
                        ENDIF

                        INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
                                Citens, Pesos, cUniPs, Obs) ;
                            VALUES (loc_cEmpr, loc_cDopePed, loc_nNume, TmpFinal.Cpros, loc_nTotPed, ;
                                crSigCdPro.Cunis, crSigCdPro.Dpros, "E", loc_nCitensPed, crSigCdPro.PesoMs, ;
                                crSigCdPro.cUniPs, TmpFinal.Obsps)

                        IF !EMPTY(TmpFinal.CodCors) OR !EMPTY(TmpFinal.CodTams)
                            INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, ;
                                    CodCors, CodTams, QtdEmbs) ;
                                VALUES (loc_nCitensPed, loc_cEmpr, loc_cDopePed, loc_nNume, TmpFinal.CPros, ;
                                    loc_nTotPed, crSigCdPro.PesoMs, TmpFinal.CodCors, TmpFinal.CodTams, 1)
                        ENDIF

                        loc_lOk = THIS.ExecutarSQL("UPDATE SigMvCab SET Nops = " + ;
                            FormatarNumeroSQL(loc_nNump, 0) + ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                            " WHERE EmpDopNums = " + ;
                            EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)), ;
                            "", "Update - 4.1")
                        IF !loc_lOk
                            EXIT
                        ENDIF
                    ENDIF
                ENDIF
                SELECT TmpFinal
                SKIP
            ENDDO
        ENDIF

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarBaixaEstoque - dump 5019-5273: empenha o Estoque reservado de
    * TmpFinal contra o saldo priorizado por grupo/conta (cursor_4c_TmpSaldg
    * - "TmpSaldG" do legado, cursor COMPARTILHADO deixado aberto por
    * SigPrGl2BO.ExecutarProcessamento), gera a transferencia (crSigMvCab +
    * crSigMvHst E/S) e baixa QtProds em SigMvItn/SigMvIts + crSigBxEst.
    *
    * Tambem recria TmpOpi (vazio, estrutura de SigOpPic) - acumulador usado
    * por ProcessarBaixaProducao e, no fim de Processar(), por
    * "Append From Dbf('TmpOpi')" em crSigOpPic.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarBaixaEstoque()
        LOCAL loc_lOk, loc_nXBaixa, loc_lGrvEest, loc_cChave, loc_cChave2
        LOCAL loc_cEdn, loc_cObses, loc_cQuery, loc_nQtBaixar, loc_nQtBaixado
        LOCAL loc_cChavBus, loc_lTemItem2, loc_cPIds

        loc_lOk = .T.

        IF USED("TmpOpi")
            USE IN TmpOpi
        ENDIF
        loc_lOk = THIS.ExecutarSQL("SELECT * FROM SigOpPic WHERE 1 = 0", "cursor_4c_OpiEstr", "TmpOpi")
        IF loc_lOk
            SELECT * FROM cursor_4c_OpiEstr WHERE .F. INTO CURSOR TmpOpi READWRITE
            USE IN cursor_4c_OpiEstr
        ENDIF

        IF loc_lOk
            *-- SET FILTER TO antes do REPLACE ALL: a tela deixa um filtro
            *-- por item corrente neste cursor (FormSigPrGlx.
            *-- GradeItensPage1AfterRowColChange, que reproduz o "Set Key To"
            *-- do legado). Medido no VFP9 em 2026-10-06: "SET ORDER TO"
            *-- limpa SET KEY mas NAO limpa SET FILTER, e "REPLACE ALL" sob
            *-- filtro altera SO as linhas visiveis - sem o SET FILTER TO
            *-- abaixo, a reserva de estoque seria gravada apenas para o
            *-- ultimo item que o usuario olhou, em silencio.
            SELECT cursor_4c_TmpSaldg
            SET ORDER TO
            SET FILTER TO
            REPLACE ALL Reservs WITH Saldo - Disps

            IF USED("TmpEstoque")
                USE IN TmpEstoque
            ENDIF
            CREATE CURSOR TmpEstoque (EmpDs C(3), Cpros C(14), CodCors C(4), CodTams C(4), ;
                Emps C(3), Dopes C(20), Numes N(6), grupos C(10), Estos C(10), Estoque N(12,3))
            INDEX ON EmpDs + Grupos + Estos + Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

            SELECT TmpFinal
            SET ORDER TO
            SCAN
                IF TmpFinal.Estoque != 0
                    loc_nXBaixa = TmpFinal.Estoque
                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO CPros
                    = SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
                    SCAN WHILE cursor_4c_TmpSaldg.Cpros = TmpFinal.Cpros AND ;
                            cursor_4c_TmpSaldg.CodCors = TmpFinal.CodCors AND ;
                            cursor_4c_TmpSaldg.CodTams = TmpFinal.CodTams AND loc_nXBaixa > 0
                        IF cursor_4c_TmpSaldg.Reservs >= loc_nXBaixa
                            REPLACE cursor_4c_TmpSaldg.Reservs WITH cursor_4c_TmpSaldg.Reservs - loc_nXBaixa ;
                                IN cursor_4c_TmpSaldg
                            INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, ;
                                    Grupos, Estos, Estoque, EmpDs) ;
                                VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, ;
                                    TmpFinal.Dopes, TmpFinal.Numes, cursor_4c_TmpSaldg.Grupos, ;
                                    cursor_4c_TmpSaldg.Estos, loc_nXBaixa, cursor_4c_TmpSaldg.Emps)
                            loc_nXBaixa = 0
                        ELSE
                            IF cursor_4c_TmpSaldg.Reservs > 0
                                loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Reservs
                                INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, ;
                                        Grupos, Estos, Estoque, EmpDs) ;
                                    VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, ;
                                        TmpFinal.Dopes, TmpFinal.Numes, cursor_4c_TmpSaldg.Grupos, ;
                                        cursor_4c_TmpSaldg.Estos, cursor_4c_TmpSaldg.Reservs, cursor_4c_TmpSaldg.Emps)
                                REPLACE cursor_4c_TmpSaldg.Reservs WITH 0 IN cursor_4c_TmpSaldg
                            ENDIF
                        ENDIF
                        SELECT cursor_4c_TmpSaldg
                    ENDSCAN
                    SELECT TmpFinal
                ENDIF
            ENDSCAN

            loc_lGrvEest = .F.
            loc_cChave   = SPACE(30)
            loc_cChave2  = SPACE(20)
            loc_nCitens  = 1

            SELECT TmpEstoque
            SET ORDER TO EmpDopNum

            SCAN
                = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpEstoque.CPros))
                = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))
                SELECT TmpEstoque

                IF (TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos != loc_cChave2) OR ;
                        (TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6) != loc_cChave)

                    IF (TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos != loc_cChave2)
                        loc_lGrvEest = .F.
                    ENDIF
                    loc_cChave2 = TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos
                    loc_cChave  = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)

                    loc_cEdn = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)

                    loc_lOk = THIS.ExecutarSQL("UPDATE SigMvCab SET Nops = " + FormatarNumeroSQL(loc_nNump, 0) + ;
                        ", DtAlts = " + FormatarDataSQL(loc_tDay) + " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                        "", "Update - 5")
                    IF !loc_lOk
                        EXIT
                    ENDIF

                    = THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(TmpEstoque.Dopes))
                    = THIS.ConsultarTabela("SigMvCab", "TempEest", "EmpDopNums", loc_cEdn)

                    IF crSigCdOpe.Globalizas = 1
                        loc_cGrupoD = TempEest.Grupoos
                        loc_cContaD = TempEest.Contaos
                    ELSE
                        loc_cGrupoD = TempEest.Grupods
                        loc_cContaD = TempEest.Contads
                    ENDIF

                    IF !EMPTY(THIS.this_cPamGruReservs)
                        loc_cGrupoD = THIS.this_cPamGruReservs
                    ENDIF
                    IF !EMPTY(THIS.this_cPamConReservs)
                        loc_cContaD = THIS.this_cPamConReservs
                    ENDIF

                    IF (THIS.this_nPamAgrupEmph = 2 AND !EMPTY(THIS.this_cPamGruReservs) AND !loc_lGrvEest) OR ;
                            (THIS.this_nPamAgrupEmph != 2)
                        loc_nNume   = fGerUniqueKey(ALLTRIM(TmpEstoque.EmpDs) + ALLTRIM(loc_cDope))
                        loc_nCitens = 1

                        INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                                Grupoos, Contaos, Grupods, Contads, Nops, Obses, cIdChaves, Dtalts, ;
                                EmpDopNums, EmpDs, rNops) ;
                            VALUES (TmpEstoque.EmpDs, loc_cDope, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                                loc_dDtGera, DATETIME(), loc_cUsuar, TmpEstoque.grupos, TmpEstoque.Estos, ;
                                loc_cGrupoD, loc_cContaD, loc_nNump, ;
                                IIF(THIS.this_lReserva, " [ Reserva Autom" + CHR(225) + "tica ] ", ;
                                    "[ OP: " + TRANSFORM(loc_nNump) + "] ") + loc_cChave, ;
                                fUniqueIds(), DATETIME(), TmpEstoque.Empds + loc_cDope + STR(loc_nNume, 6), ;
                                loc_cEmpr, loc_nRnop)
                        loc_lGrvEest = .T.
                    ELSE
                        loc_cEdn = TmpEstoque.Emps + loc_cDope + STR(loc_nNume, 6)
                        = THIS.ConsultarTabela("SigMvCab", "TempEest", "EmpDopNums", loc_cEdn)

                        loc_cObses = TratarNulo(TempEest.Obses, "") + " / " + loc_cChave

                        loc_lOk = THIS.ExecutarSQL("UPDATE SigMvCab SET Obses = " + EscaparSQL(loc_cObses) + ;
                            ", DtAlts = " + FormatarDataSQL(loc_tDay) + " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                            "", "Update - 6")
                        IF !loc_lOk
                            EXIT
                        ENDIF
                    ENDIF
                ENDIF

                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens) ;
                    VALUES (TmpEstoque.EmpDs, loc_cDope, loc_nNume, TmpEstoque.CPros, TmpEstoque.Estoque, ;
                        crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens)

                IF crSigCdGrp.TipoEstos > 1
                    INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, QtdEmbs) ;
                        VALUES (loc_nCitens, TmpEstoque.EmpDs, loc_cDope, loc_nNume, TmpEstoque.CPros, ;
                            TmpEstoque.Estoque, TmpEstoque.CodCors, TmpEstoque.CodTams, 1)
                ENDIF

                loc_nCitens = loc_nCitens + 1

                = THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(loc_cDope))

                IF crSigCdOpe.Estoqs = 1
                    INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, ;
                            Opers, Grupos, Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, OriDopNums, ;
                            cIdChaves, Seqs) ;
                        VALUES (loc_cUsuar, loc_dDtGera, DATETIME(), TmpEstoque.EmpDs, loc_cDope, loc_nNume, ;
                            loc_cEmpr, TmpEstoque.CPros, TmpEstoque.Estoque, "S", TmpEstoque.Grupos, ;
                            TmpEstoque.Estos, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                            TmpEstoque.Empds + loc_cDope + STR(loc_nNume, 6), ;
                            TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos, ;
                            TmpEstoque.EmpDs + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), 0)

                    INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, ;
                            Opers, Grupos, Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, OriDopNums, ;
                            cIdChaves, Seqs) ;
                        VALUES (loc_cUsuar, loc_dDtGera, DATETIME(), loc_cEmpr, loc_cDope, loc_nNume, ;
                            loc_cEmpr, TmpEstoque.CPros, TmpEstoque.Estoque, "E", loc_cGrupoD, loc_cContaD, ;
                            TmpEstoque.CodCors, TmpEstoque.CodTams, loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                            loc_cEmpr + loc_cGrupoD + loc_cContaD, TmpEstoque.EmpDs + loc_cDope + STR(loc_nNume, 6), ;
                            fUniqueIds(), 0)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                *-- Baixar a quantidade para nao produzir (QtProds), em
                *-- SigMvItn e, em paralelo, em SigMvIts (dump 5175-5272)
                loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + ;
                    EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                    " AND CPros = " + EscaparSQL(ALLTRIM(TmpEstoque.Cpros))
                loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEsti2", "TempEsti2 - 2")
                IF !loc_lOk
                    EXIT
                ENDIF
                GO TOP IN TempEsti2
                loc_lTemItem2 = !EOF("TempEsti2")

                loc_cQuery = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                    EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                    " AND CPros = " + EscaparSQL(ALLTRIM(TmpEstoque.Cpros))
                loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
                IF !loc_lOk
                    EXIT
                ENDIF

                loc_nQtBaixar = TmpEstoque.Estoque
                SELECT TempEestI
                SCAN WHILE loc_nQtBaixar > 0
                    loc_cPIds = TempEestI.cIdChaves
                    IF (TempEestI.QtProds + loc_nQtBaixar) <= TempEestI.Qtds
                        loc_nPQtd      = TempEestI.QtProds + loc_nQtBaixar
                        loc_nQtBaixado = loc_nQtBaixar
                        loc_nQtBaixar  = 0
                    ELSE
                        loc_nQtBaixar  = loc_nQtBaixar - (TempEestI.Qtds - TempEestI.QtProds)
                        loc_nQtBaixado = TempEestI.Qtds - TempEestI.QtProds
                        loc_nPQtd      = TempEestI.Qtds
                    ENDIF

                    loc_lOk = THIS.ExecutarSQL("UPDATE SigMvItn SET QtProds = " + ;
                        FormatarNumeroSQL(loc_nPQtd, 3) + ;
                        IIF(THIS.this_lReserva, ", QtReservas = " + FormatarNumeroSQL(loc_nPQtd, 3), ;
                            ", QtReservas = " + FormatarNumeroSQL(loc_nQtBaixado, 3)) + ;
                        ", DtAlts = " + FormatarDataSQL(loc_tDay) + " WHERE cIdChaves = " + EscaparSQL(loc_cPIds), ;
                        "", "Update - 7")
                    IF !loc_lOk
                        EXIT
                    ENDIF

                    IF !loc_lTemItem2
                        INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, ;
                                Numebs, Qtdfs, CidChaves, EmpDopNums, EmpDopNumb) ;
                            VALUES (loc_cEmpr, loc_cDope, loc_nNume, TempEestI.CItens, TempEestI.Cpros, ;
                                loc_dDtGera, TempEestI.Emps, TempEestI.Dopes, TempEestI.Numes, loc_nQtBaixado, ;
                                fUniqueIds(), loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6))
                    ENDIF
                    SELECT TempEestI
                ENDSCAN
                IF !loc_lOk
                    EXIT
                ENDIF

                loc_nQtBaixar = TmpEstoque.Estoque
                SELECT TempEsti2
                SCAN WHILE loc_nQtBaixar > 0
                    IF (TempEsti2.CodCors != TmpEstoque.CodCors) OR (TempEsti2.CodTams != TmpEstoque.CodTams)
                        LOOP
                    ENDIF

                    loc_cPIds = TempEsti2.cIdChaves
                    IF (TempEsti2.QtProds + loc_nQtBaixar) <= TempEsti2.Qtds
                        loc_nPQtd      = TempEsti2.QtProds + loc_nQtBaixar
                        loc_nQtBaixado = loc_nQtBaixar
                        loc_nQtBaixar  = 0
                    ELSE
                        loc_nQtBaixar  = loc_nQtBaixar - (TempEsti2.Qtds - TempEsti2.QtProds)
                        loc_nQtBaixado = TempEsti2.Qtds - TempEsti2.QtProds
                        loc_nPQtd      = TempEsti2.Qtds
                    ENDIF

                    loc_lOk = THIS.ExecutarSQL("UPDATE SigMvIts SET QtProds = " + ;
                        FormatarNumeroSQL(loc_nPQtd, 3) + ;
                        IIF(THIS.this_lReserva, ", QtReservas = " + FormatarNumeroSQL(loc_nPQtd, 3), ;
                            ", QtReservas = " + FormatarNumeroSQL(loc_nQtBaixado, 3)) + ;
                        ", DtAlts = " + FormatarDataSQL(loc_tDay) + " WHERE cIdChaves = " + EscaparSQL(loc_cPIds), ;
                        "", "Update - 8")
                    IF !loc_lOk
                        EXIT
                    ENDIF

                    INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, Numebs, ;
                            Qtdfs, CodCors, CodTams, cIdChaves, EmpDopNums, EmpDopNumb) ;
                        VALUES (loc_cEmpr, loc_cDope, loc_nNume, TempEsti2.CItens, TempEsti2.cpros, loc_dDtGera, ;
                            TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, loc_nQtBaixado, TempEsti2.CodCors, ;
                            TempEsti2.CodTams, fUniqueIds(), loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                            TempEsti2.Emps + TempEsti2.Dopes + STR(TempEsti2.Numes, 6))
                    SELECT TempEsti2
                ENDSCAN
                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT TmpEstoque
            ENDSCAN
        ENDIF

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarBaixaProducao - dump 5275-5498: empenha o Fabrs (producao em
    * fase) de TmpFinal contra cursor_4c_TmpFabr ("TmpFabr" do legado, idem
    * cursor_4c_TmpSaldg - compartilhado por SigPrGl2BO), grava a entrada de
    * liberacao manual (crSigInAtz, quando UsuLibs preenchido por
    * BtnAlteraqtdClick), gera os itens de producao (crTpmMvItn/crTplMvIts)
    * e baixa a quantidade usada contra as O.P.s de origem (CrSigOpPii +
    * TmpOpi + QtProds em SigMvItn/SigMvIts).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarBaixaProducao()
        LOCAL loc_lOk, loc_nXBaixa, loc_nQtdF, loc_cQuery, loc_nQtBaixar, loc_nQtBaixado, loc_nPQtd
        LOCAL ARRAY loc_aLinha[1]

        loc_lOk = .T.

        *-- SET FILTER TO: mesma razao do ProcessarBaixaEstoque - a tela
        *-- deixa um filtro por item corrente neste cursor e "SET ORDER TO"
        *-- nao o limpa; sem isto o REPLACE ALL cobriria so o ultimo item
        *-- visitado pelo usuario.
        SELECT cursor_4c_TmpFabr
        SET ORDER TO
        SET FILTER TO
        REPLACE ALL Reservs WITH Disps

        IF USED("TmpEstoque")
            USE IN TmpEstoque
        ENDIF
        CREATE CURSOR TmpEstoque (Cpros C(14), CodCors C(4), CodTams C(4), Emps C(3), Dopes C(20), ;
            Numes N(6), Nops N(10), Estoque N(12,3))
        INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

        SELECT TmpFinal
        SET ORDER TO
        SCAN
            IF TmpFinal.Fabrs != 0
                loc_nXBaixa = TmpFinal.Fabrs
                SELECT cursor_4c_TmpFabr
                SET ORDER TO Cpros
                = SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
                SCAN WHILE cursor_4c_TmpFabr.Cpros = TmpFinal.Cpros AND ;
                        cursor_4c_TmpFabr.CodCors = TmpFinal.CodCors AND ;
                        cursor_4c_TmpFabr.CodTams = TmpFinal.CodTams AND loc_nXBaixa > 0
                    IF cursor_4c_TmpFabr.Reservs >= loc_nXBaixa
                        REPLACE cursor_4c_TmpFabr.Reservs WITH cursor_4c_TmpFabr.Reservs - loc_nXBaixa ;
                            IN cursor_4c_TmpFabr
                        INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Nops, Estoque) ;
                            VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, ;
                                TmpFinal.Dopes, TmpFinal.Numes, cursor_4c_TmpFabr.Nops, loc_nXBaixa)
                        loc_nXBaixa = 0
                    ELSE
                        IF cursor_4c_TmpFabr.Reservs > 0
                            loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpFabr.Reservs
                            INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Nops, Estoque) ;
                                VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, ;
                                    TmpFinal.Dopes, TmpFinal.Numes, cursor_4c_TmpFabr.Nops, cursor_4c_TmpFabr.Reservs)
                            REPLACE cursor_4c_TmpFabr.Reservs WITH 0 IN cursor_4c_TmpFabr
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_TmpFabr
                ENDSCAN
                SELECT TmpFinal
            ENDIF
        ENDSCAN

        SELECT crSigMvCab
        LOCATE FOR Dopes = loc_cDopEst
        IF FOUND()
            loc_nNume = crSigMvCab.Numes
        ENDIF

        loc_nCitens = 1
        SELECT TmpFinalg
        SET ORDER TO
        SCAN
            IF !EMPTY(TmpFinalg.UsuLibs)
                loc_nQtdF = IIF(TmpFinalg.QtdMins > 0 AND TmpFinalg.Produzir < TmpFinalg.QtdMins AND ;
                    TmpFinalg.Produzir > 0, TmpFinalg.QtdMins - TmpFinalg.Produzir, 0)

                INSERT INTO crSigInAtz (Emps, dopes, Numes, EmpDopNums, Cpros, Qtds, Qtdes, qtdps, ;
                        qtdfs, qtdms, qtdfes, qtdfins, usulibs, CidChaves) ;
                    VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6), ;
                        TmpFinalg.CPros, TmpFinalg.Saldo, TmpFinalg.Estoque, TmpFinalg.fabrs, ;
                        TmpFinalg.Produzir, TmpFinalg.qtdmins, loc_nQtdF, TmpFinalg.Produzir2, ;
                        TmpFinalg.usuLibs, fUniqueIds())
                loc_lPedUtilz = .T.
            ENDIF

            IF TmpFinalg.Produzir2 = 0
                LOOP
            ENDIF

            = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpFinalg.CPros))
            = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))

            INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens, ;
                    Pesos, Units, Moedas, Totas) ;
                VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, TmpFinalg.CPros, TmpFinalg.Produzir2, ;
                    crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens, ;
                    (CrSigCdPro.PesoMs * TmpFinalg.Produzir2), CrSigCdPro.pVens, CrSigCdPro.Moevs, ;
                    TmpFinalg.Produzir2 * CrSigCdPro.Pvens)

            loc_lPedUtilz = .T.
            IF !THIS.this_lReserva
                REPLACE QtProds WITH Qtds IN crTpmMvItn
            ENDIF

            IF crSigCdGrp.TipoEstos > 1
                INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, QtdEmbs) ;
                    VALUES (loc_nCitens, loc_cEmpr, loc_cDopEst, loc_nNume, TmpFinalg.CPros, ;
                        TmpFinalg.produzir2, TmpFinalg.CodCors, TmpFinalg.CodTams, 1)
            ENDIF
            loc_nCitens = loc_nCitens + 1
            SELECT TmpFinalg
        ENDSCAN

        SELECT TmpEstoque
        SCAN
            loc_nXBaixa = TmpEstoque.Estoque

            loc_lOk = THIS.ExecutarSQL("SELECT * FROM SigOpPic WHERE Nops = " + ;
                FormatarNumeroSQL(TmpEstoque.Nops, 0), "LocalOpi", "LocalOpi")
            IF !loc_lOk
                EXIT
            ENDIF

            SELECT LocalOpi
            GO TOP
            SCAN WHILE loc_nXBaixa > 0
                IF LocalOpi.Dopes != loc_cDopEst
                    LOOP
                ENDIF
                IF LocalOpi.Qtds >= loc_nXBaixa
                    REPLACE Qtds WITH Qtds - loc_nXBaixa IN LocalOpi
                    SCATTER TO loc_aLinha

                    loc_lOk = THIS.ExecutarSQL("UPDATE SigOpPic SET Qtds = " + ;
                        FormatarNumeroSQL(LocalOpi.Qtds, 3) + " WHERE CidChaves = " + ;
                        EscaparSQL(LocalOpi.CidChaves), "", "Update SigOpPic")
                    IF !loc_lOk
                        EXIT
                    ENDIF

                    INSERT INTO CrSigOpPii (Emps, dopes, Numes, EmpDopNums, Empos, DopeOs, NumeOs, ;
                            EmpDs, DopeDs, Numeds, Qtds, Nops, Cidchaves) ;
                        VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6), ;
                            LocalOpi.Empds, LocalOpi.Dopes, LocalOpi.Numes, TmpEstoque.Emps, TmpEstoque.Dopes, ;
                            TmpEstoque.Numes, loc_nXBaixa, LocalOpi.Nops, fUniqueIds())

                    loc_lPedUtilz = .T.

                    SELECT TmpOpi
                    APPEND FROM ARRAY loc_aLinha
                    REPLACE Empds WITH TmpEstoque.Emps, Dopes WITH TmpEstoque.Dopes, ;
                            Numes WITH TmpEstoque.Numes, Qtds WITH loc_nXBaixa, ;
                            EmpDopNums WITH TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6), ;
                            CidChaves  WITH fUniqueIds() IN TmpOpi
                    loc_nXBaixa = 0
                ELSE
                    IF LocalOpi.Qtds > 0
                        INSERT INTO CrSigOpPii (Emps, dopes, Numes, EmpDopNums, Empos, DopeOs, NumeOs, ;
                                EmpDs, DopeDs, Numeds, Qtds, Nops, Cidchaves) ;
                            VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6), ;
                                LocalOpi.Empds, LocalOpi.Dopes, LocalOpi.Numes, TmpEstoque.Emps, TmpEstoque.Dopes, ;
                                TmpEstoque.Numes, LocalOpi.Qtds, LocalOpi.Nops, fUniqueIds())

                        loc_nXBaixa = loc_nXBaixa - LocalOpi.Qtds
                        REPLACE Empds WITH TmpEstoque.Emps, Dopes WITH TmpEstoque.Dopes, ;
                                Numes WITH TmpEstoque.Numes, ;
                                EmpDopNums WITH TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6) ;
                            IN LocalOpi

                        loc_lPedUtilz = .T.

                        SELECT LocalOpi
                        SCATTER TO loc_aLinha
                        SELECT TmpOpi
                        APPEND FROM ARRAY loc_aLinha
                    ENDIF
                ENDIF
                SELECT LocalOpi
            ENDSCAN
            IF !loc_lOk
                EXIT
            ENDIF

            *-- Baixar a quantidade para nao produzir (QtProds), em paralelo
            *-- em SigMvItn e SigMvIts (dump 5416-5497)
            loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + ;
                EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                " AND CPros = " + EscaparSQL(ALLTRIM(TmpEstoque.Cpros))
            loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEsti2", "TempEsti2 - 2")
            IF !loc_lOk
                EXIT
            ENDIF

            loc_cQuery = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                " AND CPros = " + EscaparSQL(ALLTRIM(TmpEstoque.Cpros))
            loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
            IF !loc_lOk
                EXIT
            ENDIF

            loc_nQtBaixar = TmpEstoque.Estoque
            SELECT TempEestI
            SCAN WHILE loc_nQtBaixar > 0
                IF (TempEestI.QtProds + loc_nQtBaixar) <= TempEestI.Qtds
                    loc_nPQtd      = TempEestI.QtProds + loc_nQtBaixar
                    loc_nQtBaixado = loc_nQtBaixar
                    loc_nQtBaixar  = 0
                ELSE
                    loc_nQtBaixar  = loc_nQtBaixar - (TempEestI.Qtds - TempEestI.QtProds)
                    loc_nQtBaixado = TempEestI.Qtds - TempEestI.QtProds
                    loc_nPQtd      = TempEestI.Qtds
                ENDIF

                loc_lOk = THIS.ExecutarSQL("UPDATE SigMvItn SET QtProds = " + FormatarNumeroSQL(loc_nPQtd, 3) + ;
                    " WHERE cIdChaves = " + EscaparSQL(TempEestI.cIdChaves), "", "Update - 7b")
                IF !loc_lOk
                    EXIT
                ENDIF
                SELECT TempEestI
            ENDSCAN
            IF !loc_lOk
                EXIT
            ENDIF

            loc_nQtBaixar = TmpEstoque.Estoque
            SELECT TempEsti2
            SCAN WHILE loc_nQtBaixar > 0
                IF (TempEsti2.CodCors != TmpEstoque.CodCors) OR (TempEsti2.CodTams != TmpEstoque.CodTams)
                    LOOP
                ENDIF
                IF (TempEsti2.QtProds + loc_nQtBaixar) <= TempEsti2.Qtds
                    loc_nPQtd      = TempEsti2.QtProds + loc_nQtBaixar
                    loc_nQtBaixado = loc_nQtBaixar
                    loc_nQtBaixar  = 0
                ELSE
                    loc_nQtBaixar  = loc_nQtBaixar - (TempEsti2.Qtds - TempEsti2.QtProds)
                    loc_nQtBaixado = TempEsti2.Qtds - TempEsti2.QtProds
                    loc_nPQtd      = TempEsti2.Qtds
                ENDIF

                loc_lOk = THIS.ExecutarSQL("UPDATE SigMvIts SET QtProds = " + FormatarNumeroSQL(loc_nPQtd, 3) + ;
                    " WHERE cIdChaves = " + EscaparSQL(TempEsti2.cIdChaves), "", "Update - 8b")
                IF !loc_lOk
                    EXIT
                ENDIF
                SELECT TempEsti2
            ENDSCAN
            IF !loc_lOk
                EXIT
            ENDIF

            SELECT TmpEstoque
        ENDSCAN

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarRequisicaoPedras - dump 5500-5797: SO roda quando SigCdPam
    * tem as 4 operacoes de empenho/requisicao/pedido/compra configuradas E
    * this_nEmphPdr != 0 E nao eh Reserva Automatica. Acumula a necessidade
    * de material da requisicao manual (SelPedra/cursor_4c_Requisicao) e dos
    * componentes de TmpFinal (via BuscarCompos) em TmpPedra/TmpEmpH/
    * TmpMatPrz, deduz estoque/pedidos/compras ja em aberto e gera o empenho
    * (crSigMvCab + crTpmMvItn, Dopp = SigCdPam.DopEmphs).
    *
    * NAO TRANSCRITO: o "Do While lnTotReq > 0" do dump (5746-5795), que
    * gera requisicao de compra agrupada por fornecedor+prazo - a variavel
    * lnTotReq NUNCA eh atribuida antes desse ponto em todo o Click legado
    * (conferido linha a linha), caracterizando bug/codigo morto do proprio
    * legado (VFP estouraria "Variable LNTOTREQ is not found" numa sessao
    * nova). Reproduzido como loc_nTotReq = 0 (loop nunca executa) em vez de
    * replicar o erro do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarRequisicaoPedras()
        LOCAL loc_lOk, loc_nQtde, loc_cQuery, loc_cBusca, loc_cEpn, loc_dDtEnt
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEds, loc_cEdn, loc_nTotReq
        LOCAL loc_cForn, loc_cCgru, loc_nLnQtd

        loc_lOk = .T.

        IF !EMPTY(THIS.this_cPamDopEmphs) AND !EMPTY(THIS.this_cPamDopReqcs) AND ;
                !EMPTY(THIS.this_cPamDopPedcs) AND !THIS.this_lReserva AND THIS.this_nEmphPdr != 0

            IF USED("cursor_4c_Requisicao")
                SELECT cursor_4c_Requisicao
                SCAN
                    IF EMPTY(cursor_4c_Requisicao.Cpros) OR cursor_4c_Requisicao.Qtds <= 0
                        LOOP
                    ENDIF

                    = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(cursor_4c_Requisicao.Cpros))
                    = THIS.ConsultarTabela("SigCdUni", "crSigCdUni", "CUnis", ALLTRIM(crSigCdPro.CUnis))
                    = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))

                    IF crSigCdGrp.CEstoqs = 1 AND !EMPTY(crSigCdGrp.GruEstps) AND !EMPTY(crSigCdGrp.ConEstps)
                        loc_nQtde = cursor_4c_Requisicao.Qtds

                        SELECT TmpPedra
                        IF !SEEK(ALLTRIM(cursor_4c_Requisicao.Cpros))
                            INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, crSigCdPro.CGrus, ;
                                    cursor_4c_Requisicao.cpros, crSigCdPro.QMins)
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde

                        SELECT TmpMatPrz
                        IF !SEEK(DTOC(DATE()) + ALLTRIM(cursor_4c_Requisicao.Cpros))
                            INSERT INTO TmpMatPrz (cMats, PrazoEnts) ;
                                VALUES (cursor_4c_Requisicao.cpros, DATE())
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde

                        SELECT TmpEmpH
                        IF !SEEK(ALLTRIM(cursor_4c_Requisicao.Cpros) + ALLTRIM(cursor_4c_Requisicao.Cpro2s))
                            INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, crSigCdPro.CGrus, ;
                                    cursor_4c_Requisicao.cpros, crSigCdPro.QMins, cursor_4c_Requisicao.Cpro2s)
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                    ENDIF
                    SELECT cursor_4c_Requisicao
                ENDSCAN
            ENDIF

            SELECT TmpFinal
            SET ORDER TO Cpros
            SCAN
                IF TmpFinal.Produzir = 0
                    LOOP
                ENDIF

                = THIS.ExecutarSQL("SELECT GerEmphs FROM SigOpCdc WHERE Dopes = " + ;
                    EscaparSQL(ALLTRIM(TmpFinal.Dopes)), "TmpDcOpe", "TmpDcOpe")
                IF !USED("TmpDcOpe") OR TratarNulo(TmpDcOpe.GerEmphs, 0) != 1
                    SELECT TmpFinal
                    LOOP
                ENDIF

                loc_cEpn    = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                loc_cBusca  = THIS.BuscarCompos(loc_cEpn, ALLTRIM(TmpFinal.CPros), TmpFinal.citens, "")

                IF !EMPTY(loc_cBusca) AND USED(loc_cBusca)
                    IF USED("crSigPrCpo")
                        USE IN crSigPrCpo
                    ENDIF
                    SELECT * FROM (loc_cBusca) INTO CURSOR crSigPrCpo READWRITE

                    SELECT crSigPrCpo
                    SCAN
                        = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(crSigPrCpo.Mats))
                        = THIS.ConsultarTabela("SigCdUni", "crSigCdUni", "CUnis", ALLTRIM(crSigCdPro.CUnis))
                        = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))

                        IF crSigCdGrp.CEstoqs = 1 AND !EMPTY(crSigCdGrp.GruEstps) AND !EMPTY(crSigCdGrp.ConEstps)
                            loc_nQtde = TmpFinal.Produzir * crSigPrCpo.Qtds

                            SELECT TmpPedra
                            IF !SEEK(ALLTRIM(crSigPrCpo.Mats))
                                INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                    VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, crSigCdPro.CGrus, ;
                                        crSigPrCpo.Mats, crSigCdPro.QMins)
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc_nQtde

                            SELECT TmpMatPrz
                            loc_dDtEnt = IIF(THIS.this_nPacAgrupReqs = 1, ;
                                TratarNulo(TmpFinal.Entregas, {}), DATE())
                            IF !SEEK(DTOC(loc_dDtEnt) + ALLTRIM(crSigPrCpo.Mats))
                                INSERT INTO TmpMatPrz (cMats, PrazoEnts) ;
                                    VALUES (crSigPrCpo.Mats, loc_dDtEnt)
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc_nQtde

                            SELECT TmpEmpH
                            IF !SEEK(ALLTRIM(crSigPrCpo.Mats) + ALLTRIM(crSigPrCpo.Cpros))
                                INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                    VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, crSigCdPro.CGrus, ;
                                        crSigPrCpo.Mats, crSigCdPro.QMins, crSigPrCpo.Cpros)
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc_nQtde
                        ENDIF
                        SELECT crSigPrCpo
                    ENDSCAN
                ENDIF
                SELECT TmpFinal
            ENDSCAN

            FOR loc_nX = 1 TO 5
                loc_cOperBusca = ICASE(loc_nX = 1, THIS.this_cPamDopEmphs, loc_nX = 2, THIS.this_cPamDopReqcs, ;
                    loc_nX = 3, THIS.this_cPamDopPedcs, loc_nX = 4, THIS.this_cPamDopComps, ;
                    THIS.this_cPamDopTrfCps)
                loc_cCampo = "Qtd" + ICASE(loc_nX = 1, "Emphs", loc_nX = 2, "Reqs", loc_nX = 3, "Pedcs", "Comps")

                IF EMPTY(loc_cOperBusca)
                    LOOP
                ENDIF

                loc_cEds = loc_cEmpr + ALLTRIM(loc_cOperBusca)
                loc_lOk = THIS.ExecutarSQL("SELECT * FROM SigMvCab WHERE EmpDopNums BETWEEN " + ;
                    EscaparSQL(loc_cEds + "     0") + " AND " + EscaparSQL(loc_cEds + "999999"), ;
                    "TempEest", "TempEest")
                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT TempEest
                SCAN
                    loc_cEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                    = THIS.ConsultarTabela("SigMvItn", "TempEestI", "EmpDopNums", loc_cEdn)

                    SELECT TempEestI
                    SCAN
                        IF (TempEestI.Qtds - TempEestI.QtBaixas) > 0
                            SELECT TmpPedra
                            IF SEEK(ALLTRIM(TempEestI.Cpros))
                                REPLACE &loc_cCampo. WITH &loc_cCampo. + (TempEestI.Qtds - TempEestI.QtBaixas)
                            ENDIF
                        ENDIF
                        SELECT TempEestI
                    ENDSCAN
                    SELECT TempEest
                ENDSCAN
            ENDFOR
            IF !loc_lOk
                loc_lAbortar = .T.
                RETURN
            ENDIF

            loc_lOk = THIS.ExecutarSQL("SELECT b.* FROM SigMvEst b WHERE NOT b.Sqtds = 0 AND " + ;
                "b.Grupos + b.Estos IN (SELECT GruEstps + ConEstPs FROM SigCdGrp " + ;
                "WHERE NOT GruEstPs = " + EscaparSQL(SPACE(10)) + " AND NOT ConEstPs = " + ;
                EscaparSQL(SPACE(10)) + " GROUP BY GruEstPs, ConEstPs)", "pEstoque", "pEstoque")
            IF !loc_lOk
                loc_lAbortar = .T.
                RETURN
            ENDIF

            SELECT pEstoque
            SCAN
                SELECT TmpPedra
                IF SEEK(ALLTRIM(pEstoque.Cpros))
                    REPLACE QtdEsts WITH QtdEsts + pEstoque.Sqtds
                ENDIF
                SELECT pEstoque
            ENDSCAN

            SELECT TmpEmpH
            SET ORDER TO GruMat
            GO TOP
            loc_cCgru   = TmpEmpH.Cgrus
            loc_nCitens = 999
            SCAN
                = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpEmpH.CMats))

                IF TmpEmpH.Cgrus != loc_cCgru
                    loc_nCitens = 999
                    loc_cCgru   = TmpEmpH.Cgrus
                ENDIF

                IF loc_nCitens >= 999
                    loc_nCitens = 1
                    loc_cDopp   = PADR(THIS.this_cPamDopEmphs, 20)
                    loc_nNume   = fGerUniqueKey(ALLTRIM(loc_cEmpr) + ALLTRIM(loc_cDopp))

                    INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                            Grupoos, Contaos, Nops, Obses, EmpDopNums, cIdChaves, DtAlts, rNops) ;
                        VALUES (loc_cEmpr, loc_cDopp, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                            loc_dDtGera, DATETIME(), loc_cUsuar, TmpEmpH.Grupos, TmpEmpH.contas, loc_nNump, ;
                            "[ OP: " + TRANSFORM(loc_nNump) + "] ", loc_cEmpr + loc_cDopp + STR(loc_nNume, 6), ;
                            fUniqueIds(), DATETIME(), loc_nRnop)
                ENDIF

                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, cPro2s) ;
                    VALUES (loc_cEmpr, loc_cDopp, loc_nNume, TmpEmpH.cMats, TmpEmpH.Qtds, crSigCdPro.Cunis, ;
                        crSigCdPro.Dpros, "S", loc_nCitens, TmpEmpH.Cpro2s)

                loc_nCitens = loc_nCitens + 1
                SELECT TmpEmpH
            ENDSCAN

            SELECT TmpPedra
            SCAN
                loc_cDope = PADR(THIS.this_cPamDopReqcs, 20)
                = THIS.ConsultarTabela("SigOpCdc", "crSigOpCdc", "Dopes", ALLTRIM(loc_cDope))

                IF TratarNulo(crSigOpCdc.verests, 0) != 2
                    loc_nLnQtd = TmpPedra.Qtds - (TmpPedra.QtdEsts - TmpPedra.QtdMins + TmpPedra.QtdReqs + ;
                        TmpPedra.QtdPedcs + TmpPedra.QtdComps - TmpPedra.QtdEmphs)
                    IF loc_nLnQtd > 0
                        REPLACE QtdgReqs WITH loc_nLnQtd
                    ENDIF
                ELSE
                    REPLACE QtdgReqs WITH TmpPedra.Qtds
                ENDIF
                SELECT TmpPedra
            ENDSCAN

            SELECT TmpPedra
            SET ORDER TO GruMat
            GO TOP
            loc_cCgru = TmpPedra.Cgrus
            = THIS.ConsultarTabela("SigCdPro", "crTmpPro", "CPros", ALLTRIM(TmpPedra.CMats))
            loc_cForn   = TratarNulo(crTmpPro.Ifors, "")
            loc_nCitens = 999
            loc_nTotReq = 0

            SCAN
                IF TmpPedra.QtdGreqs <= 0
                    LOOP
                ENDIF

                = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpPedra.CMats))

                *-- "Do While lnTotReq > 0" (dump 5746-5795) nao transcrito -
                *-- ver nota de escopo no cabecalho deste metodo
                SELECT TmpPedra
            ENDSCAN
        ENDIF

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEntradaAutomatica - dump 5816-5979: SO roda quando SigCdPam
    * tem operacao/tipo de entrada antecipada configurados E this_nDbEntPes
    * (DbParam.EntPes) = 1. Consolida GrSigCdNei (peso/material acumulado
    * pelas fases da O.P.) em crSigCdNei/crSigCdNec e crSigMvHst, por DOIS
    * caminhos: destino UNICO configurado na operacao (CrSigCdOpd.GruDests/
    * ConDests) ou destino por NECESSIDADE (CrSigCdNec.EmpDnPs de cada
    * grupo de fases).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEntradaAutomatica()
        LOCAL loc_lOk, loc_cDopEntAu, loc_cTpOp, loc_cGrupoC, loc_cContaC
        LOCAL loc_nNumEntAu, loc_nTPesoEnt, loc_lGravou, loc_cMat, loc_nQtde, loc_nPeso
        LOCAL loc_cOper, loc_cIds, loc_nEnv, loc_lPrimeiro

        loc_lOk = .T.
        loc_cDopEntAu = PADR(THIS.this_cPamDopEntAus, 20)
        loc_cTpOp     = PADR(THIS.this_cPamTpOpEntAus, 15)

        IF !EMPTY(loc_cDopEntAu) AND !EMPTY(loc_cTpOp) AND THIS.this_nDbEntPes = 1

            IF USED("crSigCdNec")
                *-- crSigCdNec nasce de AbrirCursorTabela() sem indice - os
                *-- dois usados pelos SEEK abaixo sao criados aqui
                SELECT crSigCdNec
                INDEX ON EmpDnPs TAG EmpDnPs
                INDEX ON Dopps + GrupoOs + ContaOs + GrupoDs + ContaDs TAG DopEntAu
            ENDIF

            = THIS.ConsultarTabela("SigCdOpd", "CrSigCdOpd", "Dopps", ALLTRIM(loc_cDopEntAu))

            IF !EMPTY(CrSigCdOpd.GruDests) AND !EMPTY(CrSigCdOpd.ConDests)
                loc_cGrupoC  = CrSigCdOpd.GruOrigs
                loc_cContaC  = CrSigCdOpd.ConOrigs
                loc_cGrupoD  = CrSigCdOpd.GruDests
                loc_cContaD  = CrSigCdOpd.ConDests
                loc_nNumEntAu = fGerUniqueKey(ALLTRIM(loc_cDopEntAu))

                IF USED("TmpNensi")
                    USE IN TmpNensi
                ENDIF
                SELECT Cmats, Cdescs, cUnis, TpOps, Nops, Nenvs, SUM(Pesos) AS Pesos, SUM(Qtds) AS Qtds, ;
                        SUM(Peso2s) AS Peso2s FROM GrSigCdNei ;
                    GROUP BY 1, 2, 3, 4, 5, 6 INTO CURSOR TmpNensi

                loc_nTPesoEnt = 0
                loc_lGravou   = .F.

                SELECT TmpNensi
                SCAN
                    loc_lGravou = .T.
                    loc_cMat    = TmpNensi.Cmats

                    = THIS.ConsultarTabela("SigCdPro", "CrSigCdPro", "Cpros", ALLTRIM(loc_cMat))

                    INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, TpOps, ;
                            EmpDNps, cIdChaves, Peso2s, Nenvs, Nops) ;
                        VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, TmpNensi.Cmats, TmpNensi.cDescs, ;
                            TmpNensi.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, loc_cTpOp, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), fUniqueIds(), TmpNensi.peso2s, ;
                            TmpNensi.Nenvs, TmpNensi.Nops)

                    loc_nTPesoEnt = loc_nTPesoEnt + TmpNensi.Pesos
                    loc_nQtde = TmpNensi.Qtds
                    loc_nPeso = TmpNensi.Peso2s

                    IF CrSigCdOpd.Origems = 1 AND INLIST(CrSigCdOpd.EstOrigs, 1, 2)
                        loc_cOper = IIF(CrSigCdOpd.EstOrigs = 1, "E", "S")
                        INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, ;
                                Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, empgruests, OriDopNums, ;
                                Seqs, Pesos) ;
                            VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), DATE(), ;
                                {}, loc_cGrupoC, loc_cContaC, loc_cMat, loc_cOper, loc_nQtde, " ", ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                                loc_cEmpr + loc_cGrupoC + loc_cContaC, ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPeso)
                        *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    ENDIF
                    IF CrSigCdOpd.Destinos = 1 AND INLIST(CrSigCdOpd.EstDests, 1, 2)
                        loc_cOper = IIF(CrSigCdOpd.EstDests = 1, "E", "S")
                        INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, ;
                                Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, empgruests, OriDopNums, ;
                                Seqs, Pesos) ;
                            VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), DATE(), ;
                                {}, loc_cGrupoD, loc_cContaD, loc_cMat, loc_cOper, loc_nQtde, " ", ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                                loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPeso)
                        *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    ENDIF
                    SELECT TmpNensi
                ENDSCAN

                IF loc_lGravou
                    loc_cIds = DTOS(DATE()) + TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey

                    INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
                            Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps) ;
                        VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATETIME(), DATETIME(), loc_cUsuar, ;
                            loc_cGrupoC, loc_cContaC, loc_cGrupoD, loc_cContaD, loc_nTPesoEnt, loc_nNumpe, ;
                            loc_cIds, loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10))
                ENDIF
            ELSE
                IF USED("TmpNensi")
                    USE IN TmpNensi
                ENDIF
                SELECT * FROM GrSigCdNei ORDER BY EmpDnPs, Nops INTO CURSOR TmpNensi

                loc_nTPesoEnt = 0

                SELECT TmpNensi
                SCAN
                    loc_nEnv = TmpNensi.nEnvs

                    = SEEK(TmpNensi.EmpDnPs, "crSigCdNec", "EmpDnPs")

                    loc_cGrupoC = crSigCdNec.GrupoOs
                    loc_cContaC = crSigCdNec.ContaOs
                    loc_cGrupoD = IIF(!EMPTY(CrSigCdOpd.GruDests), CrSigCdOpd.GruDests, crSigCdNec.GrupoDs)
                    loc_cContaD = crSigCdNec.ContaDs

                    loc_lPrimeiro = !SEEK(loc_cDopEntAu + loc_cGrupoC + loc_cContaC + loc_cGrupoD + loc_cContaD, ;
                        "crSigCdNec", "DopEntAu")
                    IF loc_lPrimeiro
                        loc_nNumEntAu = fGerUniqueKey(ALLTRIM(loc_cDopEntAu))
                        loc_cIds = DTOS(DATE()) + TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + ;
                            THIS.this_cSigKey

                        INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
                                Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps, Docus) ;
                            VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATETIME(), DATETIME(), loc_cUsuar, ;
                                loc_cGrupoC, loc_cContaC, loc_cGrupoD, loc_cContaD, loc_nTPesoEnt, loc_nNumpe, ;
                                loc_cIds, loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), TRANSFORM(loc_nNumpe))
                        loc_nTPesoEnt = 0
                    ENDIF

                    loc_nQtde = TmpNensi.Qtds
                    loc_nPeso = TmpNensi.Peso2s
                    loc_cMat  = TmpNensi.cMats
                    loc_nTPesoEnt = loc_nTPesoEnt + TmpNensi.Pesos

                    = THIS.ConsultarTabela("SigCdPro", "CrSigCdPro", "Cpros", ALLTRIM(loc_cMat))

                    INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, TpOps, ;
                            EmpDNps, cIdChaves, nenvs, Peso2s, Nops) ;
                        VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, loc_cMat, CrSigCdPro.Dpros, ;
                            CrSigCdPro.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, loc_cTpOp, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), fUniqueIds(), loc_nEnv, ;
                            TmpNensi.Peso2s, TmpNensi.Nops)

                    IF CrSigCdOpd.Origems = 1 AND INLIST(CrSigCdOpd.EstOrigs, 1, 2)
                        loc_cOper = IIF(CrSigCdOpd.EstOrigs = 1, "E", "S")
                        INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, ;
                                Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, empgruests, OriDopNums, ;
                                Seqs, Pesos) ;
                            VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), DATE(), ;
                                {}, loc_cGrupoC, loc_cContaC, loc_cMat, loc_cOper, loc_nQtde, " ", ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                                loc_cEmpr + loc_cGrupoC + loc_cContaC, ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPeso)
                        *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    ENDIF
                    IF CrSigCdOpd.Destinos = 1 AND INLIST(CrSigCdOpd.EstDests, 1, 2)
                        loc_cOper = IIF(CrSigCdOpd.EstDests = 1, "E", "S")
                        INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, ;
                                Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, empgruests, OriDopNums, ;
                                Seqs, Pesos) ;
                            VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), DATE(), ;
                                {}, loc_cGrupoD, loc_cContaD, loc_cMat, loc_cOper, loc_nQtde, " ", ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                                loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPeso)
                        *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    ENDIF
                    SELECT TmpNensi
                ENDSCAN
            ENDIF
        ENDIF

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarMovimentos - dump 5981-6065: numera definitivamente o historico
    * (GravaHis - ja chamado por Processar() antes deste metodo), persiste
    * os 11 cursores de trabalho nas tabelas reais (PersistirCursor) e
    * efetiva com COMMIT - ou desfaz tudo com ROLLBACK em caso de falha.
    *
    * "Select TmpCabec / Scan / Update SigMvCab Set Rnops..." (dump
    * 5991-6000, so roda em ThisForm.Reserva) depende de um cursor TmpCabec
    * que o Click original nao cria - vem do form avo (fora do escopo desta
    * task) e eh protegido por USED() para nao quebrar quando ausente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarMovimentos()
        LOCAL loc_lErro

        loc_lErro = .F.

        IF THIS.this_lReserva AND USED("TmpCabec")
            SELECT TmpCabec
            SCAN
                IF TmpCabec.Flag
                    = THIS.ExecutarSQL("UPDATE SigMvCab SET Rnops = " + FormatarNumeroSQL(loc_nRnop, 0) + ;
                        " WHERE EmpDopNums = " + ;
                        EscaparSQL(TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)), "", "Update Rnops")
                ENDIF
                SELECT TmpCabec
            ENDSCAN
        ENDIF

        IF !loc_lErro AND !THIS.PersistirCursor("crSigOpPic", "SigOpPic")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigPdMvf", "SigPdMvf")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNec", "SigCdNec")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNei", "SigCdNei")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvCab", "SigMvCab")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvHst", "SigMvHst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigBxEst", "SigBxEst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvItn", "SigMvItn")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvIts", "SigMvIts")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigOpPii", "SigOpPii")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigInAtz", "SigInAtz")
            loc_lErro = .T.
        ENDIF

        *-- fRecalculaP(.t., ...) / fRecalculaC(.t.,.f.,.f., ...) de lote:
        *-- omitidos (ver NOTA DE ESCOPO) - nao marcam erro

        IF !loc_lErro
            IF SQLCOMMIT(gnConnHandle) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Commit) " + CapturarErroSQL()
                loc_lErro = .T.
            ENDIF
        ENDIF

        IF loc_lErro
            = SQLROLLBACK(gnConnHandle)
        ENDIF

        RETURN !loc_lErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarModoAutomatico - dump 6081-6458: SO roda quando
    * this_lAutomatico = .T. (chamado por Processar() apos o lote manual ja
    * ter sido commitado). Gera o fluxo de fases/transferencia por LINHA de
    * producao (SigCdLnf) a partir das O.P.s recem-criadas (SigOpPic entre
    * loc_nNopI/loc_nNopF) e grava um SEGUNDO lote (crSigPdMvf/crSigCdNec/
    * crSigCdNei/crSigMvHst), com commit proprio.
    *
    * Estrutura e correcao de defeito IDENTICAS as de SigPrGlpBO.
    * ProcessarModoAutomatico - os dumps legados de SIGPRGLX e SIGPRGLP sao,
    * neste bloco, o MESMO codigo (mesmos comentarios "Tiago"/datas,
    * confirmado linha a linha): a consulta que monta TmpOpi (dump 6147-
    * 6148) NAO traz EmpDopNums nem Citens, mas a consulta de composicao
    * logo abaixo (6159-6160) referencia TmpOpi.empdopnums e TmpOpi.citens
    * - em VFP isso estoura "Variable not found" em runtime. Igual ao
    * SigPrGlpBO, as duas colunas entram como MAX() no SELECT, e NAO no
    * GROUP BY, para nao alterar a granularidade do agrupamento original.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarModoAutomatico()
        LOCAL loc_lOk, loc_lErro, loc_cSql, loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD
        LOCAL loc_dDtGe, loc_cUsuarLin, loc_nQtAnt, loc_nPsAnt, loc_nTran, loc_nInicio
        LOCAL loc_cIds, loc_cOper, loc_cDpTrf, loc_nNopI, loc_nNopF, loc_nSeqAuto
        LOCAL ARRAY loc_aNensi[1, 18]

        loc_lOk   = .T.
        loc_lErro = .F.

        IF !THIS.ExecutarSQL("Select dopps From SigCdOpd where Autos = 1 ", ;
                "CrSigCdOpd", "CrSigCdOpd - Autos 1")
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrSigCdOpd") = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Movimento!!!"
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrSigCdOpd") > 1
            THIS.this_cMensagemErro = "Mais de Uma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Movimento!!!"
            RETURN .F.
        ENDIF
        GO TOP IN CrSigCdOpd

        IF !THIS.ExecutarSQL("Select Dopps From SigCdOpd Where Autos = 2 ", ;
                "CrTmpOpp", "CrTmpOpp - Autos 2")
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrTmpOpp") = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Encerramento!!!"
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrTmpOpp") > 1
            THIS.this_cMensagemErro = "Mais de Uma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Encerramento!!!"
            RETURN .F.
        ENDIF
        GO TOP IN CrTmpOpp
        loc_cDpTrf = PADR(CrTmpOpp.Dopps, 20)

        IF !THIS.AbrirCursorTabela("crSigPdMvf", "SigPdMvf")
            RETURN .F.
        ENDIF
        SELECT crSigPdMvf
        INDEX ON nTrans TAG nTrans

        IF !THIS.AbrirCursorTabela("crSigCdNec", "SigCdNec")
            RETURN .F.
        ENDIF
        SELECT crSigCdNec
        INDEX ON Grupoos + contaOs + GrupoDs + ContaDs + DTOS(Datas) + STR(nAceites, 10) TAG Gravacao

        IF !THIS.AbrirCursorTabela("crSigCdNei", "SigCdNei")
            RETURN .F.
        ENDIF
        SELECT crSigCdNei
        INDEX ON nTrans TAG nTrans

        IF !THIS.AbrirCursorTabela("crSigMvHst", "SigMvHst")
            RETURN .F.
        ENDIF

        SELECT crSigCdNei
        = AFIELDS(loc_aNensi, "crSigCdNei")
        IF USED("xNensi")
            USE IN xNensi
        ENDIF
        CREATE CURSOR xNensi FROM ARRAY loc_aNensi

        IF !THIS.ExecutarSQL("Select * From SigCdLnf ", "cursor_4c_LinfTmp", "TmpLinf")
            RETURN .F.
        ENDIF
        IF USED("TmpLinF")
            USE IN TmpLinF
        ENDIF
        SELECT * FROM cursor_4c_LinfTmp INTO CURSOR TmpLinF READWRITE
        USE IN cursor_4c_LinfTmp
        SELECT TmpLinF
        INDEX ON Linhas + STR(Ordems, 2) TAG Linhas

        loc_nNopI   = (loc_nNump * 10000) + 1
        loc_nNopF   = (loc_nNump * 10000) + 9999
        loc_nSeqAuto = 1

        *-- ATENCAO - CORRECAO DE DEFEITO DO LEGADO (ver cabecalho deste
        *-- metodo): EmpDopNums/Citens entram via MAX(), fora do GROUP BY.
        loc_cSql = "Select a.Cpros, a.Nops, b.Linhas, b.cUnis, a.EmpdopNops, a.CodTams," + ;
            " MAX(a.EmpDopNums) as EmpDopNums, MAX(a.Citens) as Citens," + ;
            " sum(a.Qtds) as Qtds, Sum(a.Pesos) as Pesos From SigOpPic a, SigCdPro b " + ;
            "Where a.Nops Between " + FormatarNumeroSQL(loc_nNopI, 0) + " And " + ;
            FormatarNumeroSQL(loc_nNopF, 0) + " And a.cpros = b.cpros " + ;
            "Group by a.Cpros, a.Nops, b.Linhas, b.Cunis, a.EmpDopNops, a.CodTams "

        IF !THIS.ExecutarSQL(loc_cSql, "cursor_4c_OpiTmp", "TmpOpi")
            RETURN .F.
        ENDIF
        IF USED("TmpOpi")
            USE IN TmpOpi
        ENDIF
        SELECT * FROM cursor_4c_OpiTmp INTO CURSOR TmpOpi READWRITE
        USE IN cursor_4c_OpiTmp
        SELECT TmpOpi
        INDEX ON Nops TAG Nops
        INDEX ON Linhas + cpros TAG Linha

        SELECT TmpOpi
        SCAN
            loc_cSql = "Select a.Mats, a.Qtds, b.cunis, b.Pesoms, b.Cgrus, b.dpros," + ;
                " c.Fators, b.Varias, d.Mercs " + ;
                "From SigSubMv a, SigCdPro b, SigCdUni c, SigCdGrp d " + ;
                "Where a.empdopnums = " + EscaparSQL(TmpOpi.empdopnums) + ;
                " and a.Cpros = " + EscaparSQL(TmpOpi.Cpros) + ;
                " and a.citem2 = " + FormatarNumeroSQL(TmpOpi.citens, 0) + ;
                " and a.mats = b.Cpros and b.Cunis = c.Cunis And b.Cgrus = d.Cgrus "

            IF !THIS.ExecutarSQL(loc_cSql, "TmpCompo", "TmpCompo")
                loc_lOk = .F.
                EXIT
            ENDIF

            IF RECCOUNT("TmpCompo") = 0
                loc_cSql = "Select a.Mats, b.cunis, b.Pesoms, b.Cgrus, b.dpros, c.Fators," + ;
                    " b.Varias, d.Mercs, " + ;
                    "Case When e.Qtds is null Then a.Qtds Else e.Qtds End as Qtds " + ;
                    "From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros " + ;
                    "Inner Join SigCdUni c On b.Cunis = c.Cunis " + ;
                    "Inner Join SigCdGrp d On b.Cgrus = d.Cgrus " + ;
                    "Left Join SigSubCp e On a.mats = e.Mats And e.CodTams = " + ;
                    EscaparSQL(TmpOpi.CodTams) + " " + ;
                    "Where a.Cpros = " + EscaparSQL(TmpOpi.Cpros) + ;
                    " and a.mats = b.Cpros and b.Cunis = c.Cunis And b.Cgrus = d.Cgrus"

                IF !THIS.ExecutarSQL(loc_cSql, "TmpCompo", "TmpCompo - padrao")
                    loc_lOk = .F.
                    EXIT
                ENDIF
            ENDIF

            IF USED("xNensi")
                USE IN xNensi
            ENDIF
            CREATE CURSOR xNensi FROM ARRAY loc_aNensi

            SELECT TmpLinF
            IF !SEEK(TmpOpi.Linhas)
                MsgAviso("Linha :" + ALLTRIM(TmpOpi.Linhas) + " do Produto: " + ;
                    ALLTRIM(TmpOpi.cpros) + " nao Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                SELECT TmpOpi
                LOOP
            ENDIF
            loc_cGrpO     = PADR(TmpLinF.Grupos, 10)
            loc_cCtaO     = PADR(TmpLinF.Contas, 10)
            loc_dDtGe     = loc_dDtGera + TmpLinf.nDias
            loc_cUsuarLin = PADR(IIF(EMPTY(TmpLinf.Usuars), loc_cUsuar, TmpLinf.Usuars), 10)

            IF DOW(loc_dDtGe) = 7
                loc_dDtGe = loc_dDtGe + 2
            ELSE
                IF DOW(loc_dDtGe) = 1
                    loc_dDtGe = loc_dDtGe + 1
                ENDIF
            ENDIF

            SELECT TmpLinF
            SKIP
            SCAN WHILE TmpLinF.Linhas = TmpOpi.Linhas
                loc_cGrpD = PADR(TmpLinf.Grupos, 10)
                loc_cCtaD = PADR(TmpLinf.Contas, 10)

                SELECT crSigCdNec
                IF !SEEK(loc_cGrpO + loc_cCtaO + loc_cGrpD + loc_cCtaD + DTOS(loc_dDtGe) + ;
                        STR(TmpLinf.Ordems, 10))
                    APPEND BLANK
                    REPLACE GrupoOs  WITH loc_cGrpO, ;
                            ContaOs  WITH loc_cCtaO, ;
                            GrupoDs  WITH loc_cGrpD, ;
                            ContaDs  WITH loc_cCtaD, ;
                            Datas    WITH loc_dDtGe, ;
                            Dopps    WITH CrSigCdOpd.Dopps, ;
                            nTrans   WITH loc_nSeqAuto, ;
                            Usuars   WITH loc_cUsuarLin, ;
                            nAceites WITH TmpLinf.Ordems ;
                        IN crSigCdNec

                    loc_nSeqAuto = loc_nSeqAuto + 1
                ENDIF

                INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, ;
                        Codpds, Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                    VALUES (loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD, TmpOpi.Nops, ;
                        TmpOpi.Nops, TmpOpi.Cpros, TmpOpi.Cunis, TmpOpi.Pesos, TmpOpi.Qtds, ;
                        TmpLinf.Ordems, CrSigCdNec.nTrans, loc_cUsuarLin)

                IF !EMPTY(TmpLinf.Cgrus)
                    SELECT TmpCompo
                    SCAN
                        IF Cgrus = TmpLinf.Cgrus
                            IF TmpCompo.Varias = 1 AND TmpOpi.Cpros != THIS.this_cPamOuros
                                loc_nQtAnt = TmpOpi.Pesos
                                loc_nPsAnt = TmpOpi.Pesos
                            ELSE
                                loc_nQtAnt = TmpCompo.Qtds * TmpOpi.Qtds
                                loc_nPsAnt = IIF(TmpCompo.Fators != 0, ;
                                    loc_nQtAnt * Tmpcompo.Fators, TmpCompo.Pesoms * TmpOpi.Qtds)
                            ENDIF
                            INSERT INTO xNensi (Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
                                    Qtds, Pesos) ;
                                VALUES (TmpOpi.Nops, TmpOpi.Nops, TmpCompo.Mats, ;
                                    TmpCompo.Dpros, TmpCompo.CUnis, TmpCompo.CGrus, ;
                                    loc_nQtAnt, loc_nPsAnt)
                        ENDIF
                        SELECT TmpCompo
                    ENDSCAN
                ENDIF
                SELECT xNensi
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO crSigCdNei FROM MEMVAR
                    REPLACE nTrans WITH CrSigCdNec.nTrans IN crSigCdNei
                    SELECT xNensi
                ENDSCAN
                SELECT TmpLinF
                loc_cGrpO = TmpLinF.Grupos
                loc_cCtaO = TmpLinF.Contas
                loc_dDtGe = loc_dDtGe + TmpLinf.nDias
                IF DOW(loc_dDtGe) = 7
                    loc_dDtGe = loc_dDtGe + 2
                ELSE
                    IF DOW(loc_dDtGe) = 1
                        loc_dDtGe = loc_dDtGe + 1
                    ENDIF
                ENDIF
            ENDSCAN

            loc_cGrpD = PADR(THIS.this_cPamGruConfs, 10)
            loc_cCtaD = PADR(THIS.this_cPamConConfs, 10)

            SELECT crSigCdNec
            IF !SEEK(loc_cGrpO + loc_cCtaO + loc_cGrpD + loc_cCtaD + DTOS(loc_dDtGe) + STR(99, 10))
                APPEND BLANK
                REPLACE GrupoOs  WITH loc_cGrpO, ;
                        ContaOs  WITH loc_cCtaO, ;
                        GrupoDs  WITH loc_cGrpD, ;
                        ContaDs  WITH loc_cCtaD, ;
                        Datas    WITH loc_dDtGe, ;
                        Dopps    WITH loc_cDpTrf, ;
                        Usuars   WITH loc_cUsuar, ;
                        nTrans   WITH loc_nSeqAuto, ;
                        nAceites WITH 99 ;
                    IN crSigCdNec

                loc_nSeqAuto = loc_nSeqAuto + 1
            ENDIF

            INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, Codpds, ;
                    Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                VALUES (loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD, TmpOpi.Nops, TmpOpi.Nops, ;
                    TmpOpi.Cpros, TmpOpi.Cunis, TmpOpi.Pesos, TmpOpi.Qtds, TmpLinf.Ordems, ;
                    CrSigCdNec.nTrans, loc_cUsuar)

            SELECT xNensi
            SCAN
                SCATTER MEMVAR
                INSERT INTO crSigCdNei FROM MEMVAR
                REPLACE nTrans WITH CrSigCdNec.nTrans IN crSigCdNei
                SELECT xNensi
            ENDSCAN

            SELECT TmpOpi
        ENDSCAN

        IF !loc_lOk
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        SELECT crSigCdNec
        INDEX ON DTOS(Datas) + STR(nAceites, 10) TAG Datas
        SCAN
            loc_nTran   = crSigCdNec.nTrans
            loc_nInicio = fGerUniqueKey(ALLTRIM(CrSigCdNec.Dopps) + loc_cEmpr)
            loc_cIds    = DTOS(CrSigCdNec.Datas) + ;
                TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + THIS.this_cSigKey

            REPLACE Emps      WITH loc_cEmpr, ;
                    Numps     WITH loc_nInicio, ;
                    Datars    WITH DATETIME(), ;
                    Nops      WITH loc_nNopI, ;
                    Autos     WITH .T., ;
                    CidChaves WITH loc_cIds, ;
                    EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                IN crSigCdNec

            SELECT crSigPdMvf
            = SEEK(loc_nTran)
            SCAN WHILE crSigPdMvf.nTrans = loc_nTran
                REPLACE Emps      WITH loc_cEmpr, ;
                        Dopps     WITH CrSigCdNec.Dopps, ;
                        Numps     WITH loc_nInicio, ;
                        Usuars    WITH CrSigCdNec.Usuars, ;
                        Datars    WITH DATETIME(), ;
                        Datas     WITH CrSigCdNec.Datas, ;
                        CidChaves WITH DTOS(CrSigCdNec.Datas) + ;
                            TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                            THIS.this_cSigKey, ;
                        EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                    IN crSigPdMvf
                SELECT crSigPdMvf
            ENDSCAN

            loc_cSql = "Select * From SigCdOpd Where Dopps = " + ;
                EscaparSQL(ALLTRIM(CrSigCdNec.Dopps))
            IF !THIS.ExecutarSQL(loc_cSql, "CrSigCdOpd", "CrSigCdOpd - fase")
                loc_lOk = .F.
                EXIT
            ENDIF

            SELECT crSigCdNei
            = SEEK(loc_nTran)
            SCAN WHILE crSigCdNei.nTrans = loc_nTran
                REPLACE Emps      WITH loc_cEmpr, ;
                        Dopps     WITH CrSigCdNec.Dopps, ;
                        Numps     WITH loc_nInicio, ;
                        CidChaves WITH fUniqueIds(), ;
                        EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                    IN crSigCdNei

                loc_cSql = "Select Cgrus From SigCdPro Where Cpros = " + ;
                    EscaparSQL(ALLTRIM(CrSigCdNei.Cmats))
                IF !THIS.ExecutarSQL(loc_cSql, "LocalPro", "LocalPro")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                loc_cSql = "Select cEstoqs From SigCdGrp Where Cgrus = " + ;
                    EscaparSQL(ALLTRIM(LocalPro.Cgrus))
                IF !THIS.ExecutarSQL(loc_cSql, "LocalGru", "LocalGru")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                IF INLIST(crSigCdOpd.EstOrigs, 1, 2) AND (crSigCdOpd.BxOEsts = 2) ;
                        AND (LocalGru.CEstoqs = 1)
                    loc_cOper = IIF(crSigCdOpd.EstOrigs = 1, "E", "S")
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNei.Numps, CrSigCdNec.Datas, ;
                            CrSigCdNei.CMats, loc_cEmpr, CrSigCdNei.Qtds, CrSigCdNec.Grupoos, ;
                            CrSigCdNec.Contaos, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupoos + CrSigCdNec.Contaos, ;
                            DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), 0)
                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 2) ;
                        AND (LocalGru.CEstoqs = 1)
                    loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNei.Numps, CrSigCdNec.Datas, ;
                            CrSigCdNei.CMats, loc_cEmpr, CrSigCdNei.Qtds, CrSigCdNec.Grupods, ;
                            CrSigCdNec.Contads, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupods + CrSigCdNec.Contads, ;
                            DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), 0)
                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                SELECT crSigCdNei
            ENDSCAN

            IF !loc_lOk
                EXIT
            ENDIF

            IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 1)
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                SELECT DISTINCT b.Nops, b.Cpros, b.Qtds ;
                    FROM crSigCdNei a, TmpOpi b ;
                    WHERE a.nTrans = m.loc_nTran AND a.Nops = b.Nops ;
                    INTO CURSOR TmpHis

                loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")

                SELECT TmpHis
                SCAN
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNec.Numps, CrSigCdNec.Datas, ;
                            TmpHis.CPros, loc_cEmpr, TmpHis.Qtds, CrSigCdNec.Grupods, ;
                            CrSigCdNec.Contads, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupods + CrSigCdNec.Contads, DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps, 6), 0)
                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    SELECT TmpHis
                ENDSCAN
            ENDIF

            SELECT crSigCdNec
        ENDSCAN

        IF !loc_lOk
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        SELECT crSigMvHst
        GO TOP

        SELECT TmpOpi
        SCAN
            loc_cSql = "Select CidChaves From SigCdNec Where EmpDnPs = " + ;
                EscaparSQL(TmpOpi.EmpDopNops)
            IF !THIS.ExecutarSQL(loc_cSql, "LocalNens", "Update - crSigCdNec")
                loc_lErro = .T.
                EXIT
            ENDIF

            SELECT LocalNens
            SCAN
                loc_cSql = "Update SigCdNec Set ChkSubn = 1 Where cidChaves = " + ;
                    EscaparSQL(LocalNens.CidChaves)
                IF !THIS.ExecutarSQL(loc_cSql, "", "Update - crSigCdNec 1")
                    loc_lErro = .T.
                    EXIT
                ENDIF
                SELECT LocalNens
            ENDSCAN
            IF loc_lErro
                EXIT
            ENDIF
            SELECT TmpOpi
        ENDSCAN

        IF !loc_lErro AND !THIS.PersistirCursor("crSigPdMvf", "SigPdMvf")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNec", "SigCdNec")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvHst", "SigMvHst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNei", "SigCdNei")
            loc_lErro = .T.
        ENDIF

        *-- fRecalculaP / fRecalculaC de lote: omitidos (ver NOTA DE ESCOPO)

        IF !loc_lErro
            IF SQLCOMMIT(gnConnHandle) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Commit) " + CapturarErroSQL()
                loc_lErro = .T.
            ENDIF
        ENDIF

        IF loc_lErro
            = SQLROLLBACK(gnConnHandle)
        ENDIF

        RETURN !loc_lErro
    ENDFUNC

ENDDEFINE

