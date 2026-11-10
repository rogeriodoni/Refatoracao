# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarDadosReais': Sem conexao ao banco (gnConnHandle invalido); Teste 'BtnEncerrarExiste': Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-11-06 00:15:30] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-06 00:15:30] [INFO] Config FPW: (nao fornecido)
[2026-11-06 00:15:30] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-06 00:15:30] [INFO] Timeout: 300 segundos
[2026-11-06 00:15:30] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iyxf4bh3.prg
[2026-11-06 00:15:30] [INFO] Conteudo do wrapper:
[2026-11-06 00:15:30] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigopfis', 'C:\4c\tasks\task742', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopfis', 'C:\4c\tasks\task742', 'OPERACIONAL'
QUIT

[2026-11-06 00:15:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iyxf4bh3.prg
[2026-11-06 00:15:31] [INFO] VFP output esperado em: C:\4c\tasks\task742\vfp_output.txt
[2026-11-06 00:15:31] [INFO] Executando Visual FoxPro 9...
[2026-11-06 00:15:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iyxf4bh3.prg
[2026-11-06 00:15:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iyxf4bh3.prg
[2026-11-06 00:15:32] [INFO] Timeout configurado: 300 segundos
[2026-11-06 00:15:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-06 00:15:33] [INFO] VFP9 finalizado em 1.5718263 segundos
[2026-11-06 00:15:33] [INFO] Exit Code: 
[2026-11-06 00:15:33] [INFO] 
[2026-11-06 00:15:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-06 00:15:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iyxf4bh3.prg
[2026-11-06 00:15:34] [INFO] 
[2026-11-06 00:15:34] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-06 00:15:34] [INFO] * Auto-generated wrapper for parameters
[2026-11-06 00:15:34] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-11-06 00:15:34] [INFO] * Parameters: 'Formsigopfis', 'C:\4c\tasks\task742', 'OPERACIONAL'
[2026-11-06 00:15:34] [INFO] 
[2026-11-06 00:15:34] [INFO] * Anti-dialog protections for unattended execution
[2026-11-06 00:15:34] [INFO] SET SAFETY OFF
[2026-11-06 00:15:35] [INFO] SET RESOURCE OFF
[2026-11-06 00:15:35] [INFO] SET TALK OFF
[2026-11-06 00:15:35] [INFO] SET NOTIFY OFF
[2026-11-06 00:15:35] [INFO] SYS(2335, 0)
[2026-11-06 00:15:35] [INFO] 
[2026-11-06 00:15:35] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigopfis', 'C:\4c\tasks\task742', 'OPERACIONAL'
[2026-11-06 00:15:35] [INFO] QUIT
[2026-11-06 00:15:36] [INFO] 
[2026-11-06 00:15:36] [INFO] === Fim do Wrapper.prg ===
[2026-11-06 00:15:36] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigopfis",
  "timestamp": "20261106001533",
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
      "erro": "Sem conexao ao banco (gnConnHandle invalido)",
      "detalhes": ""
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "2/2 paginas navegadas com sucesso"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)",
      "detalhes": ""
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
      "detalhes": "AbrirLookup: 9 (ABRIRLOOKUPBENEFICIO, ABRIRLOOKUPCANONICO, ABRIRLOOKUPCFOP, ABRIRLOOKUPESPECIE, ABRIRLOOKUPMUNICIPIO, ABRIRLOOKUPSERIE, ABRIRLOOKUPSERVICOMUNICIPAL, ABRIRLOOKUPTRANSPORTADORA, ABRIRLOOKUPUF) | KeyPress handlers: 1 (KEYPRESS)"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopfis.prg):
*==============================================================================
* Formsigopfis.prg - Dados Fiscais da Nota Fiscal
*==============================================================================
* Herda de: FormBase
* BO: sigopfisBO
* Legado: SIGOPFIS.SCX (tasks/task742/sigopfis_form_codigo_fonte.txt)
* Tipo: OPERACIONAL (sub-formulario MODAL embutido num form de movimentacao
*       maior - equivalente ao SigOpMvi/SigMvNfi - com PageFrame de 2
*       paginas REAIS com abas visiveis: "Nota Fiscal" (Impostos) e
*       "Servicos" - NAO segue o padrao Page1=Lista/Page2=Dados de CRUD).
*
* Init legado (dump linhas 4376-4377): "Lparameters loForm, loDatses".
* loForm e o form chamador (fornece DataSessionId, pcEscolha, poDataMgr e
* os cursores ja abertos TprMvCab/crSigMvNfi/crSigCdOpe/crSigOpCdd/
* crSigOpCdi/crSigCdEmp); loDatses e recebido mas NUNCA referenciado no
* resto do Init (parametro morto no legado). Equivalente migrado:
* par_cCidchaves (PK de SigMvNfi - this_oBusinessObject.this_cTabela;
* pode vir VAZIO quando a nota ainda nao foi gravada pelo form pai, modo
* INCLUIR) + par_oFormPai (equivalente a loForm; fornece this_cModoAtual
* e e desabilitado/reabilitado como no legado - ParentForm.Enabled).
*
* DataSession = 2 no legado (dump linha 1071), com "Set DataSession to
* loForm.DataSessionId" dentro do proprio Init para abandonar a
* datasession privada e compartilhar a do form pai (os cursores legados
* sao globais). Na arquitetura migrada nao ha cursor global compartilhado
* entre forms - este form le/grava via this_oBusinessObject (SQLEXEC
* proprio com gnConnHandle), entao a datasession privada (regra
* CLAUDE.md #9.4, ja coberta por FormBase.Init() com SET DATE TO BRITISH +
* SET CENTURY ON antes de qualquer private datasession) e inofensiva;
* mantida = 2 por fidelidade ao dump (PILAR 1).
*
* Montagem (migracao multi-fase):
*   Fase 3        - DEFINE CLASS, propriedades, Init/Destroy/
*                   InicializarForm, ConfigurarPageFrame() com
*                   ConfigurarCabecalho() (cnt_4c_Sombra + Shape2) e
*                   ConfigurarPgfPaginas() (pgf_4c_1, Page1="Nota Fiscal",
*                   Page2="Servicos"), TornarControlesVisiveis().
*   Fase 4        - Campos/containers do form DIRETO (fora do PageFrame),
*                   via ConfigurarCamposForm() + ConfigurarBotaoOk() (cmd_4c_
*                   Ok). So geometria/propriedades visuais - Valid/When/
*                   LostFocus/GotFocus e o Click do botao ok ficam para a
*                   Fase 7/8 (dependem de lookup e de SQL):
*                   Get_nota, Get_S?rie, Get_Esp?cie, Get_Emiss?o,
*                   Get_Selo, Get_Saidas, Get_ClFiscal, Get_DClFiscal,
*                   Get_CfoSubs, Get_DCfoSub, botao ok.
*   Fase 5        - Campos da pagina "Nota Fiscal" (pgf_4c_1.Page1, dump
*                   SIGOPFIS.Pagina.Impostos - 112 objetos): bases/valores
*                   IPI/ICMS/substituicao/isento/outras, totais (Produtos/
*                   Desconto/Nota Fiscal), frete/seguro/despesas (+ % e
*                   observacoes automaticas quando zero), transportadora/
*                   endereco/cidade/UF/placa, volumes (quantidade/especie/
*                   marca/numero/peso liquido/peso bruto), chave de acesso
*                   NFe (propria e referenciada), DI (numero/data registro/
*                   desembaraco), observacao geral, "NOTA CANCELADA" e
*                   botoes Fwbtnm1-7/ImpEtiqueta, via
*                   ConfigurarPaginaNotaFiscal() - so geometria/propriedades
*                   visuais (Top/Left/Width/Height/Format/InputMask/
*                   MaxLength/Alignment/cores), SEM ControlSource (o dump
*                   liga direto a crSigMvNfi/TprMvCab, cursores globais que
*                   NAO existem na arquitetura migrada; o bind real via
*                   this_oBusinessObject entra no FormParaBO()/BOParaForm()
*                   da Fase 7/8, junto com Valid/When/LostFocus).
*   Fase 6 (esta) - Campos da pagina "Servicos" (pgf_4c_1.Page2, dump
*                   SIGOPFIS.Pagina.Servicos - 38 objetos): tipo de
*                   tributacao, UF/municipio da prestacao, beneficio
*                   fiscal, codigo de servico municipal, deducoes/
*                   descontos/retencoes, ISS retido, tipo de nota, totais
*                   de impostos (Fwget1-6/set_total), via
*                   ConfigurarPaginaServicos() - mesmo criterio da Fase 5:
*                   so geometria/propriedades visuais, SEM RowSource/
*                   ControlSource (Get_tptribsers/get_tiponfs dependem de
*                   cursores que o legado monta em runtime a partir de
*                   crSigCdEmp/fBeneficio_RJ/fCodMunicipal - Fase 7/8).
*   Fase 7/8      - Lookups (fwbuscaext/fwbuscaint do dump: UF, Municipio,
*                   Transportadora, Especie, Beneficio Fiscal, Servico
*                   Municipal), validacoes de calculo fiscal (formulas de
*                   frete/seguro/despesas x ICMS/IPI, regra CLAUDE.md #17
*                   - transcrever literal), FormParaBO()/BOParaForm(),
*                   botao ok.Click (gravacao/validacao final) e os botoes
*                   de impressao/NFe (Fwbtnm1-7).
*
* Nomes de objeto conforme tasks/task742/mapeamento.json.
*==============================================================================

DEFINE CLASS Formsigopfis AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGOPFIS.SCX: DataSession=2, BorderStyle=2,
    * Height=600, Width=1000, ShowTips=.T., AutoCenter=.T., ControlBox=.F.,
    * MaxButton=.F., MinButton=.F., Movable=.F., TitleBar=0, WindowType=1 -
    * dump de sigopfis_form_codigo_fonte.txt, linhas 1071-1086).
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    DataSession  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MinButton    = .F.
    MaxButton    = .F.
    Movable      = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Dados Fiscais"

    *--------------------------------------------------------------------------
    * Chave do registro de SigMvNfi sendo exibido - equivalente ao cursor
    * crSigMvNfi ja posicionado pelo form pai no legado. Pode ficar vazio em
    * modo INCLUIR (nota ainda nao gravada pelo form pai).
    *--------------------------------------------------------------------------
    this_cCidchaves = ""

    *--------------------------------------------------------------------------
    * Form chamador - equivalente a ThisForm.ParentForm do legado (recebido
    * como "loForm" no Init). Usado para copiar o modo (this_cModoAtual) e
    * para habilitar/desabilitar o form pai ao abrir/fechar este modal
    * (equivalente a ParentForm.Enabled = .f./.t.).
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Guarda de reentrancia dos lookups (Transportadora/UF/Municipio/
    * Beneficio/Servico Municipal - todos MODAIS via fwbuscaext/fwbuscaint
    * no legado). Ligada no FUNIL de cada lookup e liberada pelo wrapper,
    * nunca pelo corpo (regra CLAUDE.md #47).
    *--------------------------------------------------------------------------
    this_lEmLookup = .F.

    *--------------------------------------------------------------------------
    * Guarda de aviso UNICO sobre o cabecalho do movimento estar fora de
    * alcance (ver GravarNoMovimento). Um dialogo por clique seria ruido;
    * nenhum dialogo esconderia que os totais nao voltaram para o pai.
    *--------------------------------------------------------------------------
    this_lAvisouMovimento = .F.

    *--------------------------------------------------------------------------
    * Estado equivalente as properties customizadas do legado (dump linhas
    * 1088-1098 + Init, linhas 4387-4391) - consumidas pelas formulas de
    * calculo fiscal e pelas condicoes When/Valid dos campos, que entram
    * nas Fases 5 a 8:
    *   this_lFiltraCfo   -> llFiltraCfo  (filtra CFOP pela regra SigCdOop)
    *   this_lIpiBaseIcm  -> IpiBaseIcm   (IPI compoe a base do ICMS sobre
    *                                      frete/seguro/despesas)
    *   this_lIcmsTtNf    -> icmsttnf     (ICMS entra no total da nota)
    *   this_lEditaFrete  -> Editafrete   (habilita edicao do % de frete)
    *   this_nNfServicos  -> NfServicos   (controla exibicao/obrigatoriedade
    *                                      da aba Servicos)
    *--------------------------------------------------------------------------
    this_lFiltraCfo  = .F.
    this_lIpiBaseIcm = .F.
    this_lIcmsTtNf   = .F.
    this_lEditaFrete = .T.
    this_nNfServicos = 0

    *--------------------------------------------------------------------------
    * Init - recebe a chave do registro e o form chamador (equivalente a
    * "Lparameters loForm, loDatses" do legado) e cria o Business Object
    * ANTES do DODEFAULT(), para que InicializarForm() (chamado por
    * FormBase.Init() via DODEFAULT) ja o encontre pronto.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cCidchaves, par_oFormPai
        LOCAL loc_lSucesso, loc_lParametrosOk, loc_oErro, loc_lBypassParametros
        loc_lSucesso = .F.
        loc_lParametrosOk = .T.

        *-- Bypass da validacao de parametros obrigatorios em modo teste/
        *-- validacao de UI: o harness (TestFormWrapper, etapa 06_testForm)
        *-- faz CREATEOBJECT(par_cFormClass) SEM argumentos - sem este
        *-- bypass, a falta de par_oFormPai sempre dispararia MsgErro e
        *-- loc_lParametrosOk ficaria .F., fazendo Init() devolver .F. e
        *-- CREATEOBJECT retornar NULL antes de qualquer outra verificacao
        *-- (mesmo padrao de Formsigopfin/FormSigPrPpc/FormSIGMVCTH).
        loc_lBypassParametros = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
            (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        TRY
            IF !loc_lBypassParametros
                IF PCOUNT() < 2 OR VARTYPE(par_oFormPai) != "O"
                    MsgErro("Formul" + CHR(225) + "rio chamador n" + CHR(227) + ;
                        "o informado (par_oFormPai).", "Parametros Invalidos")
                    loc_lParametrosOk = .F.
                ENDIF
            ENDIF

            IF loc_lParametrosOk
                *-- par_cCidchaves pode legitimamente vir vazio (modo
                *-- INCLUIR - a nota ainda nao foi gravada pelo form pai),
                *-- por isso NAO entra na validacao obrigatoria acima.
                IF PCOUNT() >= 1 AND VARTYPE(par_cCidchaves) = "C" AND !EMPTY(par_cCidchaves)
                    THIS.this_cCidchaves = ALLTRIM(par_cCidchaves)
                ENDIF

                THIS.this_oFormPai = IIF(PCOUNT() >= 2 AND VARTYPE(par_oFormPai) = "O", ;
                    par_oFormPai, .NULL.)

                IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                        PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5) AND ;
                        !EMPTY(THIS.this_oFormPai.this_cModoAtual)
                    THIS.this_cModoAtual = THIS.this_oFormPai.this_cModoAtual
                ENDIF

                THIS.this_oBusinessObject = CREATEOBJECT("sigopfisBO")

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_lSucesso = DODEFAULT()

                    IF loc_lSucesso AND VARTYPE(THIS.this_oFormPai) = "O"
                        THIS.this_oFormPai.Enabled = .F.
                    ENDIF
                ELSE
                    MsgErro("Falha ao criar sigopfisBO.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Dados Fiscais: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - reabilita o form chamador (equivalente a
    * ThisForm.ParentForm.Enabled = .t. do Release legado) e encadeia para
    * FormBase.Destroy() (libera this_oBusinessObject e restaura o menu
    * principal). this_oFormPai NAO e liberado aqui - pertence a quem criou.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar Formsigopfis")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela via ConfigurarPageFrame(): fundo e
    * cabecalho + PageFrame de 2 abas nesta fase; campos diretos do form e
    * das 2 paginas nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("sigopfisBO n" + CHR(227) + "o foi inicializado.", "Erro")
            ELSE
                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                *-- Tem de rodar ANTES de ConfigurarPageFrame(): CarregarEstadoFiscal()
                *-- (chamada por ConfigurarPageFrame) le this_oBusinessObject.this_cDopes,
                *-- que so existe depois de PrepararChaveMovimento().
                THIS.PrepararChaveMovimento()

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carrega o registro existente (ALTERAR/VISUALIZAR) ou prepara
                *-- o BO para INCLUIR, e espelha o resultado nos controles
                *-- (Fase 7/8 - FormParaBO()/BOParaForm()).
                THIS.CarregarRegistroAtual()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopfis.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual.
    *   Fase 3        - ConfigurarCabecalho() (cnt_4c_Sombra + shp_4c_Shape2)
    *                   + ConfigurarPgfPaginas() (pgf_4c_1 com Page1="Nota
    *                   Fiscal"/Page2="Servicos", vazias).
    *   Fase 4        - ConfigurarCamposForm() (campos diretos do form) +
    *                   ConfigurarBotaoOk().
    *   Fase 5        - ConfigurarPaginaNotaFiscal() (pgf_4c_1.Page1).
    *   Fase 6 (esta) - ConfigurarPaginaServicos() (pgf_4c_1.Page2) +
    *                   ConfigurarEventosLookup() (BINDEVENT dos 13 campos que
    *                   o dump legado protege com Valid de busca).
    *   Fase 7/8      - validacoes de gravacao e recalculo de impostos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPgfPaginas()
        THIS.ConfigurarCamposForm()
        THIS.ConfigurarBotaoOk()
        THIS.ConfigurarPaginaNotaFiscal()
        THIS.ConfigurarPaginaServicos()
        THIS.ConfigurarEventosLookup()
        THIS.ConfigurarEventosBotoes()
        THIS.ConfigurarEventosCalculo()
        THIS.CarregarEstadoFiscal()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form, mais
    * o Shape2 decorativo do dump (filho direto do form, nao de cntSombra).
    * Original (dump legado): cntSombra Top=0, Left=0, Width=999, Height=80,
    * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
    * projeto) em vez do literal 999 do dump.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

            *-- Shape2 (dump linhas 1104-1114): filho direto de SIGOPFIS,
            *-- nao de cntSombra - pequeno marcador decorativo no canto
            *-- superior direito da faixa.
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 4
                .Left        = 902
                .Width       = 10
                .Height      = 8
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(162, 214, 242)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgfPaginas - PageFrame com 2 abas REAIS e visiveis (dump
    * legado linhas 1170-1197: ErasePage=.T., PageCount=2, TabStyle=1,
    * ActivePage=1, Top=171, Left=6, Width=994, Height=429,
    * TabOrientation=2). Page1="Impostos" (Caption "Nota Fiscal"),
    * Page2="Servicos" (Caption "Servi?os"). Paginas ficam vazias nesta
    * fase - campos entram nas Fases 5/6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgfPaginas()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("pgf_4c_1", "PageFrame")
            WITH THIS.pgf_4c_1
                .PageCount      = 2
                .Top            = 171
                .Left           = 6
                .Width          = 994
                .Height         = 429
                .TabOrientation = 2
                .Visible        = .T.
                .ActivePage     = 1
            ENDWITH

            WITH THIS.pgf_4c_1.Page1
                .Caption  = "Nota Fiscal"
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH THIS.pgf_4c_1.Page2
                .Caption   = "Servi" + CHR(231) + "os"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 255)
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPgfPaginas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposForm - Campos DIRETOS do form (fora do PageFrame),
    * conforme dump legado (sigopfis_form_codigo_fonte.txt, SIGOPFIS.Say1/
    * Get_nota/Say3/Get_ClFiscal/Say4/Get_DClFiscal/Say5/Get_S?rie/Say6/
    * Get_Esp?cie/Get_Emiss?o/Say_Emiss?o/say_Selo/Get_Selo/Get_Saidas/Say50/
    * Get_CfoSubs/Get_DCfoSub - linhas 3791-4091). Apenas geometria/
    * propriedades visuais (Top/Left/Width/Height/InputMask/Format/
    * MaxLength/cores) - Valid/When/LostFocus/GotFocus (lookup de CFOP,
    * validacao de serie/data de saida) entram na Fase 7/8, junto com o
    * FormParaBO()/BOParaForm() que liga estes controles as properties do
    * sigopfisBO (this_cNFis, this_cCFis, this_cDClFiscal, etc.).
    *
    * ZOrderSet (dump em Get_Emiss?o/Get_Saidas/Say_Emiss?o) e propriedade
    * exclusiva do Form Designer - NAO transcrita (regra CLAUDE.md #33).
    *
    * txt_4c_DClFiscal e txt_4c_DCfoSub sao campos de DESCRICAO (preenchidos
    * pelo lookup de CFOP do campo de codigo vizinho, sem Valid proprio no
    * dump) - ReadOnly = .T., mesmo padrao dos pares codigo+descricao do
    * projeto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposForm()
        LOCAL loc_oErro

        TRY
            *-- Linha 1 (Top=82/96): Serie / Nota / Especie / Emissao / Saida / Selo
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "S" + CHR(233) + "rie"
                .Top       = 82
                .Left      = 140
                .Width     = 60
                .Height    = 15
                .TabIndex  = 3
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Serie", "TextBox")
            WITH THIS.txt_4c_Serie
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .MaxLength        = 3
                .Top              = 96
                .Left             = 140
                .Width            = 34
                .Height           = 23
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .TabIndex         = 4
                .Visible          = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Nota Fiscal"
                .Top       = 82
                .Left      = 184
                .Width     = 70
                .Height    = 15
                .TabIndex  = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Nota", "TextBox")
            WITH THIS.txt_4c_Nota
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .InputMask        = "999999"
                .Top              = 96
                .Left             = 184
                .Width            = 63
                .Height           = 23
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .TabIndex         = 6
                .Visible          = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Esp" + CHR(233) + "cie"
                .Top       = 82
                .Left      = 257
                .Width     = 60
                .Height    = 15
                .TabIndex  = 7
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Especie", "TextBox")
            WITH THIS.txt_4c_Especie
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .MaxLength        = 6
                .Top              = 96
                .Left             = 257
                .Width            = 53
                .Height           = 23
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .TabIndex         = 8
                .Visible          = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_LblEmissao", "Label")
            WITH THIS.lbl_4c_LblEmissao
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o"
                .Top       = 82
                .Left      = 320
                .Width     = 70
                .Height    = 15
                .TabIndex  = 9
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Emissao", "TextBox")
            WITH THIS.txt_4c_Emissao
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = {}
                .Top           = 96
                .Left          = 320
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .BorderColor   = RGB(90, 90, 90)
                .TabIndex      = 10
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Sa" + CHR(237) + "da"
                .Top       = 82
                .Left      = 410
                .Width     = 70
                .Height    = 15
                .TabIndex  = 11
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Saidas", "TextBox")
            WITH THIS.txt_4c_Saidas
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "E"
                .Value         = {}
                .InputMask     = "99/99/9999"
                .MaxLength     = 10
                .NullDisplay   = "  /  /"
                .Top           = 96
                .Left          = 410
                .Width         = 80
                .Height        = 23
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor   = RGB(90, 90, 90)
                .TabIndex      = 12
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_LblSelo", "Label")
            WITH THIS.lbl_4c_LblSelo
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Selo"
                .Top       = 82
                .Left      = 500
                .Width     = 60
                .Height    = 15
                .TabIndex  = 16
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Selo", "TextBox")
            WITH THIS.txt_4c_Selo
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999"
                .Top              = 96
                .Left             = 500
                .Width            = 80
                .Height           = 23
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .TabIndex         = 17
                .Visible          = .T.
            ENDWITH

            *-- Linha 2 (Top=121/125): CFOP de Movimentacao (codigo + descricao)
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "CFOP Movimenta" + CHR(231) + CHR(227) + "o :"
                .Top       = 125
                .Left      = 29
                .Width     = 108
                .Height    = 15
                .TabIndex  = 13
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_ClFiscal", "TextBox")
            WITH THIS.txt_4c_ClFiscal
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .Top              = 121
                .Left             = 140
                .Width            = 80
                .Height           = 23
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .TabIndex         = 14
                .Visible          = .T.
            ENDWITH

            *-- ReadOnly NAO e fixo aqui: o dump legado tem
            *-- "Get_DClFiscal.When -> ... And IsEmpty(Get_ClFiscal.Value)",
            *-- isto e, a descricao aceita digitacao (e abre o picker por
            *-- descricao) enquanto o CODIGO do CFOP esta vazio. Quem avalia
            *-- essa condicao e AtualizarDependenciasCampos(), chamada na
            *-- montagem e a cada mudanca do codigo. Fixar ReadOnly = .T. aqui
            *-- mataria o lookup por descricao.
            THIS.AddObject("txt_4c_DClFiscal", "TextBox")
            WITH THIS.txt_4c_DClFiscal
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .Top              = 121
                .Left             = 224
                .Width            = 430
                .Height           = 23
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .TabIndex         = 15
                .Visible          = .T.
            ENDWITH

            *-- Linha 3 (Top=146/149): CFOP de Substituicao (codigo + descricao)
            THIS.AddObject("lbl_4c_Label50", "Label")
            WITH THIS.lbl_4c_Label50
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "CFOP Substitui" + CHR(231) + CHR(227) + "o :"
                .Top       = 149
                .Left      = 40
                .Width     = 100
                .Height    = 15
                .TabIndex  = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_CfoSubs", "TextBox")
            WITH THIS.txt_4c_CfoSubs
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .Top              = 146
                .Left             = 140
                .Width            = 80
                .Height           = 23
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .TabIndex         = 16
                .Visible          = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DCfoSub", "TextBox")
            WITH THIS.txt_4c_DCfoSub
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .ReadOnly         = .T.
                .Top              = 146
                .Left             = 224
                .Width            = 430
                .Height           = 23
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .TabIndex         = 17
                .Visible          = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoOk - botao "Retornar" do dump legado (SIGOPFIS.ok,
    * linhas 4035-4044), direto no form (nao em cnt_4c_Sombra), no canto
    * superior direito da faixa do cabecalho - mesmo padrao do cmd_4c_Cancela
    * em Formsigopgar.prg (classe fwbtng: Height/Width/Font*/WordWrap/
    * MousePointer/ForeColor/BackColor vem do DEFAULT da classe, docs/
    * FRAMEWORK_class_codigo_fonte.txt - o dump so sobrescreve Top/Left/
    * Picture/Cancel/Caption/ToolTipText).
    *
    * Themes = .T. + DisabledPicture (regra CLAUDE.md #99/standalone button
    * com .Picture definido) - sem isso, com Themes = .F. o icone nao
    * renderiza quando o botao e desabilitado.
    *
    * Sem BINDEVENT nesta fase: o Click (gravacao/validacao final do
    * SIGOPFIS.ok.Click, dump linhas ~4980-5107) entra na Fase 7/8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoOk()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Top             = 2
                .Left            = 923
                .Height          = 100
                .Width           = 80
                .Cancel          = .T.
                .Caption         = "Retornar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Themes          = .T.
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .MousePointer    = 15
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .TabIndex        = 19
                .ToolTipText     = "[ESC] Sair"
                .Visible         = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoOk")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaNotaFiscal - Campos da pagina "Nota Fiscal" (pgf_4c_1.
    * Page1, dump SIGOPFIS.Pagina.Impostos - linhas 1201-3135 de
    * sigopfis_form_codigo_fonte.txt, 112 objetos). Coordenadas RELATIVAS a
    * Page1 (pagina real e visivel, NAO ha compensacao de PageFrame.Top=-29
    * - essa compensacao so existe no padrao frmcadastro com abas ocultas).
    *
    * So geometria/propriedades visuais nesta fase - SEM ControlSource (o
    * dump liga direto a crSigMvNfi/TprMvCab, cursores globais do legado que
    * nao existem na arquitetura migrada). O bind com this_oBusinessObject
    * via FormParaBO()/BOParaForm(), e os eventos Valid/When/LostFocus,
    * entram na Fase 7/8 junto com os lookups.
    *
    * Nomes de objeto ASCII (mapeamento.json tem 2 defeitos corrigidos
    * aqui, regra CLAUDE.md #11/#30): Get_PesoLiq e Get_PesoBruto colidiam
    * no mapeamento (os dois mapeados para "txt_4c_Peso") - renomeados para
    * txt_4c_PesoLiq/txt_4c_PesoBruto; Get_Esp?cie e Get_Endere?o tinham
    * acento no nome do objeto (invalido em identificador VFP9) -
    * renomeados para txt_4c_EspecieVol (ASCII, e distinto do txt_4c_Especie
    * do form direto - campo diferente, mesma grafia no legado) e
    * txt_4c_Endereco.
    *
    * Themes=.T. + DisabledPicture em TODOS os botoes com Picture (regra
    * CLAUDE.md #99), inclusive ImpEtiqueta - o dump declara Themes=.F.
    * nele, mas isso e exatamente o padrao que o #99 corrige (sem
    * DisabledPicture, Themes=.F. + Enabled=.F. apaga o icone).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaNotaFiscal()
        LOCAL loc_oPag, loc_oErro

        TRY
            loc_oPag = THIS.pgf_4c_1.Page1

            *======================================================
            * Bloco 1 (Top 0-117): Bases/Valores IPI, ICMS,
            * Substituicao, Isento, Outras + divisores
            *======================================================
            loc_oPag.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPag.shp_4c_Shape4
                .Top = 117
                .Left = 5
                .Width = 953
                .Height = 2
                .BackStyle = 0
                .BorderWidth = 2
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPag.shp_4c_Shape1
                .Top = 206
                .Left = 5
                .Width = 953
                .Height = 2
                .BackStyle = 0
                .BorderWidth = 2
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPag.shp_4c_Shape2
                .Top = 395
                .Left = 5
                .Width = 557
                .Height = 2
                .BackStyle = 0
                .BorderWidth = 2
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPag.lbl_4c_Label16
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "IPI :"
                .Left = 110
                .Top = 23
                .Width = 40
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPag.lbl_4c_Label5
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Base de C" + CHR(225) + "lculo"
                .Height = 15
                .Left = 139
                .Top = 5
                .Width = 77
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_BaseIPI", "TextBox")
            WITH loc_oPag.txt_4c_BaseIPI
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 139
                .Top = 20
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPag.lbl_4c_Label6
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Valor"
                .Height = 15
                .Left = 251
                .Top = 5
                .Width = 26
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ValorIPI", "TextBox")
            WITH loc_oPag.txt_4c_ValorIPI
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 251
                .Top = 20
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label46", "Label")
            WITH loc_oPag.lbl_4c_Label46
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Base Isento"
                .Height = 15
                .Left = 363
                .Top = 5
                .Width = 59
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_BaseIpiIsento", "TextBox")
            WITH loc_oPag.txt_4c_BaseIpiIsento
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 363
                .Top = 20
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label47", "Label")
            WITH loc_oPag.lbl_4c_Label47
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Base Outras"
                .Height = 15
                .Left = 475
                .Top = 5
                .Width = 61
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_BaseIpiOutras", "TextBox")
            WITH loc_oPag.txt_4c_BaseIpiOutras
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 475
                .Top = 20
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label48", "Label")
            WITH loc_oPag.lbl_4c_Label48
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "N" + CHR(227) + "o Creditado"
                .Height = 15
                .Left = 587
                .Top = 5
                .Width = 71
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_IpiNCred", "TextBox")
            WITH loc_oPag.txt_4c_IpiNCred
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "999,999,999.99"
                .ReadOnly = .F.
                .Height = 21
                .Left = 587
                .Top = 20
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label18", "Label")
            WITH loc_oPag.lbl_4c_Label18
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "ICMS :"
                .Left = 99
                .Top = 59
                .Width = 40
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPag.lbl_4c_Label7
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Base de C" + CHR(225) + "lculo "
                .Height = 15
                .Left = 139
                .Top = 42
                .Width = 80
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_BaseICMS", "TextBox")
            WITH loc_oPag.txt_4c_BaseICMS
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "999,999,999.99"
                .ReadOnly = .F.
                .Height = 21
                .Left = 139
                .Top = 56
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPag.lbl_4c_Label1
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Valor"
                .Height = 15
                .Left = 251
                .Top = 42
                .Width = 26
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ValorICMS", "TextBox")
            WITH loc_oPag.txt_4c_ValorICMS
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 251
                .Top = 56
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label43", "Label")
            WITH loc_oPag.lbl_4c_Label43
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Base Isento"
                .Height = 15
                .Left = 363
                .Top = 42
                .Width = 59
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_BaseIcmIsen", "TextBox")
            WITH loc_oPag.txt_4c_BaseIcmIsen
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 363
                .Top = 56
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label49", "Label")
            WITH loc_oPag.lbl_4c_Label49
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Base Outras"
                .Height = 15
                .Left = 475
                .Top = 42
                .Width = 61
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_BaseIcmOutras", "TextBox")
            WITH loc_oPag.txt_4c_BaseIcmOutras
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 475
                .Top = 56
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label27", "Label")
            WITH loc_oPag.lbl_4c_Label27
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Base Substitui" + CHR(231) + CHR(227) + "o"
                .Height = 15
                .Left = 587
                .Top = 42
                .Width = 86
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_BcIcmss", "TextBox")
            WITH loc_oPag.txt_4c_BcIcmss
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 587
                .Top = 56
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label42", "Label")
            WITH loc_oPag.lbl_4c_Label42
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Valor Substitui" + CHR(231) + CHR(227) + "o"
                .Height = 15
                .Left = 699
                .Top = 42
                .Width = 87
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Icmss", "TextBox")
            WITH loc_oPag.txt_4c_Icmss
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = 0
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 699
                .Top = 56
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            *======================================================
            * Bloco 2 (Top 78-117): Totais (Produtos/Desconto/
            * Nota Fiscal) + Chave de Acesso NFe
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label44", "Label")
            WITH loc_oPag.lbl_4c_Label44
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Totais :"
                .Left = 95
                .Top = 96
                .Width = 40
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPag.lbl_4c_Label9
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Produtos"
                .Height = 15
                .Left = 139
                .Top = 78
                .Width = 45
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_TotalProds", "TextBox")
            WITH loc_oPag.txt_4c_TotalProds
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "999,999,999.99"
                .ReadOnly = .T.
                .Height = 21
                .Left = 139
                .Top = 93
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label37", "Label")
            WITH loc_oPag.lbl_4c_Label37
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Desconto"
                .Height = 15
                .Left = 363
                .Top = 78
                .Width = 47
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Desconto", "TextBox")
            WITH loc_oPag.txt_4c_Desconto
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "999,999,999.99"
                .ReadOnly = .F.
                .Height = 21
                .Left = 363
                .Top = 93
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPag.lbl_4c_Label8
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Nota Fiscal"
                .Height = 15
                .Left = 251
                .Top = 78
                .Width = 54
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_TotalNf", "TextBox")
            WITH loc_oPag.txt_4c_TotalNf
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "999,999,999.99"
                .ReadOnly = .F.
                .Height = 21
                .Left = 251
                .Top = 93
                .Width = 108
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label17", "Label")
            WITH loc_oPag.lbl_4c_Label17
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Chave de Acesso NFe"
                .Height = 15
                .Left = 475
                .Top = 78
                .Width = 107
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Chave", "TextBox")
            WITH loc_oPag.txt_4c_Chave
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .MaxLength = 47
                .ReadOnly = .T.
                .Height = 21
                .Left = 475
                .Top = 93
                .Width = 299
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            *======================================================
            * Bloco 3 (Top 121-206): Frete/Seguro/Despesas (valor +
            * % IPI/ICMS) + observacoes automaticas quando zero +
            * Chave de Acesso NFe Referenciada
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label33", "Label")
            WITH loc_oPag.lbl_4c_Label33
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Valor"
                .Height = 15
                .Left = 139
                .Top = 121
                .Width = 40
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label45", "Label")
            WITH loc_oPag.lbl_4c_Label45
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "%IPI"
                .Height = 15
                .Left = 263
                .Top = 121
                .Width = 40
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label50", "Label")
            WITH loc_oPag.lbl_4c_Label50
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Valor IPI"
                .Height = 15
                .Left = 308
                .Top = 121
                .Width = 50
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label51", "Label")
            WITH loc_oPag.lbl_4c_Label51
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "%ICMS"
                .Height = 15
                .Left = 431
                .Top = 121
                .Width = 40
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label52", "Label")
            WITH loc_oPag.lbl_4c_Label52
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Valor ICMS"
                .Height = 15
                .Left = 478
                .Top = 121
                .Width = 55
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label32", "Label")
            WITH loc_oPag.lbl_4c_Label32
                .FontBold = .F.
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Observa" + CHR(231) + CHR(245) + "es"
                .Height = 15
                .Left = 687
                .Top = 121
                .Width = 65
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label13", "Label")
            WITH loc_oPag.lbl_4c_Label13
                .FontBold = .F.
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Frete :"
                .Left = 98
                .Top = 139
                .Width = 40
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_TFrete", "TextBox")
            WITH loc_oPag.txt_4c_TFrete
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 139
                .Top = 136
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_PFrtIpi", "TextBox")
            WITH loc_oPag.txt_4c_PFrtIpi
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "99.99"
                .Height = 21
                .Left = 263
                .Top = 136
                .Width = 41
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_FrtIpi", "TextBox")
            WITH loc_oPag.txt_4c_FrtIpi
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999.99"
                .Height = 21
                .Left = 308
                .Top = 136
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_PFrtIcm", "TextBox")
            WITH loc_oPag.txt_4c_PFrtIcm
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "99.99"
                .Height = 21
                .Left = 432
                .Top = 136
                .Width = 41
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_FrtIcm", "TextBox")
            WITH loc_oPag.txt_4c_FrtIcm
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999.99"
                .Height = 21
                .Left = 477
                .Top = 136
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label29", "Label")
            WITH loc_oPag.lbl_4c_Label29
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Frete : "
                .Height = 15
                .Left = 649
                .Top = 138
                .Width = 38
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ObsFrete", "TextBox")
            WITH loc_oPag.txt_4c_ObsFrete
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = ""
                .Format = "K"
                .Height = 21
                .Left = 696
                .Top = 136
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label36", "Label")
            WITH loc_oPag.lbl_4c_Label36
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Chave Acesso NFe Referenciada :"
                .Height = 15
                .Left = 289
                .Top = 214
                .Width = 166
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ChaveC", "TextBox")
            WITH loc_oPag.txt_4c_ChaveC
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .MaxLength = 47
                .ReadOnly = .F.
                .Height = 21
                .Left = 486
                .Top = 211
                .Width = 321
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label14", "Label")
            WITH loc_oPag.lbl_4c_Label14
                .FontBold = .F.
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Seguro :"
                .Left = 90
                .Top = 162
                .Width = 48
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_TSeguros", "TextBox")
            WITH loc_oPag.txt_4c_TSeguros
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 139
                .Top = 159
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_PSegIpi", "TextBox")
            WITH loc_oPag.txt_4c_PSegIpi
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "99.99"
                .Height = 21
                .Left = 263
                .Top = 159
                .Width = 41
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_SegIpi", "TextBox")
            WITH loc_oPag.txt_4c_SegIpi
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999.99"
                .Height = 21
                .Left = 308
                .Top = 159
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_PSegIcm", "TextBox")
            WITH loc_oPag.txt_4c_PSegIcm
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "99.99"
                .Height = 21
                .Left = 432
                .Top = 159
                .Width = 41
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_SegIcm", "TextBox")
            WITH loc_oPag.txt_4c_SegIcm
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999.99"
                .Height = 21
                .Left = 477
                .Top = 159
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label30", "Label")
            WITH loc_oPag.lbl_4c_Label30
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Peso L" + CHR(237) + "quido : "
                .Height = 15
                .Left = 616
                .Top = 162
                .Width = 71
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ObsPLiq", "TextBox")
            WITH loc_oPag.txt_4c_ObsPLiq
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = ""
                .Format = "K"
                .Height = 21
                .Left = 696
                .Top = 159
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label15", "Label")
            WITH loc_oPag.lbl_4c_Label15
                .FontBold = .F.
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Despesas :"
                .Left = 78
                .Top = 185
                .Width = 60
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DespAces", "TextBox")
            WITH loc_oPag.txt_4c_DespAces
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999,999.99"
                .Height = 21
                .Left = 139
                .Top = 182
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_PDesIpi", "TextBox")
            WITH loc_oPag.txt_4c_PDesIpi
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "99.99"
                .Height = 21
                .Left = 263
                .Top = 182
                .Width = 41
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DesIpi", "TextBox")
            WITH loc_oPag.txt_4c_DesIpi
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999.99"
                .Height = 21
                .Left = 308
                .Top = 182
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_PDesIcm", "TextBox")
            WITH loc_oPag.txt_4c_PDesIcm
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "99.99"
                .Height = 21
                .Left = 432
                .Top = 182
                .Width = 41
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DesIcm", "TextBox")
            WITH loc_oPag.txt_4c_DesIcm
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999,999.99"
                .Height = 21
                .Left = 477
                .Top = 182
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label31", "Label")
            WITH loc_oPag.lbl_4c_Label31
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Peso Bruto : "
                .Height = 15
                .Left = 623
                .Top = 185
                .Width = 64
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ObsPBru", "TextBox")
            WITH loc_oPag.txt_4c_ObsPBru
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = ""
                .Format = "K"
                .Height = 21
                .Left = 696
                .Top = 182
                .Width = 111
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            *======================================================
            * Bloco 4 (Top 210-329): Transportadora, endereco,
            * placa, UF, cidade, frete (tipo), observacao geral
            *======================================================
            loc_oPag.AddObject("cbo_4c_Frete", "ComboBox")
            WITH loc_oPag.cbo_4c_Frete
                .FontName = "Tahoma"
                .FontSize = 8
                .RowSourceType = 1
                .RowSource = "Emitente,Destinat" + CHR(225) + "rio,Sem Frete"
                .Style = 2
                .Height = 21
                .Left = 139
                .Top = 210
                .Width = 139
                .SpecialEffect = 1
                .DisabledBackColor = RGB(238, 238, 238)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label23", "Label")
            WITH loc_oPag.lbl_4c_Label23
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Frete :"
                .Height = 15
                .Left = 98
                .Top = 214
                .Width = 35
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label20", "Label")
            WITH loc_oPag.lbl_4c_Label20
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Transportadora :"
                .Left = 49
                .Top = 236
                .Width = 90
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Transp", "TextBox")
            WITH loc_oPag.txt_4c_Transp
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .MaxLength = 10
                .Height = 21
                .Left = 139
                .Top = 233
                .Width = 82
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Nome", "TextBox")
            WITH loc_oPag.txt_4c_Nome
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .MaxLength = 40
                .Height = 21
                .Left = 226
                .Top = 233
                .Width = 336
                .SpecialEffect = 1
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label22", "Label")
            WITH loc_oPag.lbl_4c_Label22
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Placa :"
                .Height = 15
                .Left = 99
                .Top = 260
                .Width = 34
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Placa", "TextBox")
            WITH loc_oPag.txt_4c_Placa
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .InputMask = "!!!-9999"
                .Height = 21
                .Left = 139
                .Top = 256
                .Width = 82
                .SpecialEffect = 1
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label24", "Label")
            WITH loc_oPag.lbl_4c_Label24
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "UF Placa :"
                .Left = 226
                .Top = 260
                .Width = 60
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_UfPlaca", "TextBox")
            WITH loc_oPag.txt_4c_UfPlaca
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .Format = "!"
                .InputMask = "XX"
                .Height = 21
                .Left = 288
                .Top = 256
                .Width = 26
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label25", "Label")
            WITH loc_oPag.lbl_4c_Label25
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Cidade :"
                .Left = 91
                .Top = 283
                .Width = 50
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Cidade", "TextBox")
            WITH loc_oPag.txt_4c_Cidade
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .Format = "!"
                .ReadOnly = .T.
                .Height = 21
                .Left = 139
                .Top = 279
                .Width = 175
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label19", "Label")
            WITH loc_oPag.lbl_4c_Label19
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "UF :"
                .Height = 15
                .Left = 510
                .Top = 306
                .Width = 22
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Estado", "TextBox")
            WITH loc_oPag.txt_4c_Estado
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .Format = "!"
                .InputMask = "XX"
                .ReadOnly = .T.
                .Height = 21
                .Left = 536
                .Top = 302
                .Width = 26
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label21", "Label")
            WITH loc_oPag.lbl_4c_Label21
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Endere" + CHR(231) + "o :"
                .Left = 79
                .Top = 305
                .Width = 55
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Endereco", "TextBox")
            WITH loc_oPag.txt_4c_Endereco
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .Format = "!"
                .ReadOnly = .T.
                .Height = 21
                .Left = 139
                .Top = 302
                .Width = 364
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label28", "Label")
            WITH loc_oPag.lbl_4c_Label28
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
                .Left = 66
                .Top = 329
                .Width = 65
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Obss", "TextBox")
            WITH loc_oPag.txt_4c_Obss
                .FontName = "Tahoma"
                .FontSize = 8
                .Value = ""
                .Format = "!"
                .Height = 21
                .Left = 139
                .Top = 325
                .Width = 423
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            *======================================================
            * Bloco 5 (Top 348-403): Volumes (quantidade/especie/
            * marca/numero/peso liquido/peso bruto) + DI
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPag.lbl_4c_Label10
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Volumes :"
                .Left = 85
                .Top = 351
                .Width = 60
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Quantidade", "TextBox")
            WITH loc_oPag.txt_4c_Quantidade
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .Format = "K"
                .InputMask = "999999"
                .MaxLength = 6
                .Height = 21
                .Left = 139
                .Top = 348
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPag.lbl_4c_Label2
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Esp" + CHR(233) + "cie :"
                .Left = 258
                .Top = 351
                .Width = 52
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_EspecieVol", "TextBox")
            WITH loc_oPag.txt_4c_EspecieVol
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = ""
                .MaxLength = 10
                .Height = 21
                .Left = 314
                .Top = 348
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPag.lbl_4c_Label3
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Marca :"
                .Left = 436
                .Top = 351
                .Width = 50
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Marca", "TextBox")
            WITH loc_oPag.txt_4c_Marca
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = ""
                .Format = "K!"
                .MaxLength = 10
                .Height = 21
                .Left = 482
                .Top = 348
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPag.lbl_4c_Label4
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "N" + CHR(250) + "mero :"
                .Left = 87
                .Top = 374
                .Width = 55
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Numero", "TextBox")
            WITH loc_oPag.txt_4c_Numero
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = ""
                .Format = "K!"
                .MaxLength = 10
                .Height = 21
                .Left = 139
                .Top = 371
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label11", "Label")
            WITH loc_oPag.lbl_4c_Label11
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Peso L" + CHR(237) + "quido :"
                .Height = 15
                .Left = 235
                .Top = 374
                .Width = 68
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_PesoLiq", "TextBox")
            WITH loc_oPag.txt_4c_PesoLiq
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "9999999.99"
                .Height = 21
                .Left = 314
                .Top = 371
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label12", "Label")
            WITH loc_oPag.lbl_4c_Label12
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Peso Bruto :"
                .Height = 15
                .Left = 413
                .Top = 374
                .Width = 61
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_PesoBruto", "TextBox")
            WITH loc_oPag.txt_4c_PesoBruto
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = 0
                .InputMask = "9999999.99"
                .Height = 21
                .Left = 482
                .Top = 371
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label26", "Label")
            WITH loc_oPag.lbl_4c_Label26
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "N" + CHR(250) + "mero DI :"
                .Left = 73
                .Top = 403
                .Width = 60
                .Height = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DI", "TextBox")
            WITH loc_oPag.txt_4c_DI
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = ""
                .Format = "K!"
                .MaxLength = 10
                .Height = 21
                .Left = 139
                .Top = 400
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label34", "Label")
            WITH loc_oPag.lbl_4c_Label34
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Dt Reg DI :"
                .Height = 15
                .Left = 247
                .Top = 403
                .Width = 56
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DRegDI", "TextBox")
            WITH loc_oPag.txt_4c_DRegDI
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = {}
                .Format = "D"
                .MaxLength = 10
                .Height = 21
                .Left = 314
                .Top = 400
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label35", "Label")
            WITH loc_oPag.lbl_4c_Label35
                .FontName = "Tahoma"
                .FontSize = 8
                .Caption = "Desembara" + CHR(231) + "o:"
                .Height = 15
                .Left = 403
                .Top = 403
                .Width = 71
                .ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DDesemb", "TextBox")
            WITH loc_oPag.txt_4c_DDesemb
                .FontName = "Tahoma"
                .FontSize = 8
                .Alignment = 3
                .Value = {}
                .Format = "D"
                .MaxLength = 10
                .Height = 21
                .Left = 483
                .Top = 400
                .Width = 80
                .SpecialEffect = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH

            *======================================================
            * Bloco 6: "NOTA CANCELADA" + botoes de acao (etiquetas/
            * impressao/e-mail/cancelamento/carta de correcao/XML/
            * NFCe/NF-e)
            *======================================================
            loc_oPag.AddObject("lbl_4c_SeCanc", "Label")
            WITH loc_oPag.lbl_4c_SeCanc
                .FontBold = .T.
                .FontName = "Verdana"
                .FontSize = 10
                .BackStyle = 0
                .Caption = "NOTA CANCELADA"
                .Height = 18
                .Left = 784
                .Top = 94
                .Width = 132
                .ForeColor = RGB(255, 0, 0)
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("cmd_4c_ImpEtiqueta", "CommandButton")
            WITH loc_oPag.cmd_4c_ImpEtiqueta
                .AutoSize = .F.
                .Top = 251
                .Left = 700
                .Height = 80
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontShadow = .T.
                .FontSize = 8
                .WordWrap = .T.
                .Picture = gc_4c_CaminhoIcones + "geral_etiqueta_qr_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_etiqueta_qr_60.jpg"
                .Caption = "\<Etiquetas"
                .Enabled = .T.
                .MousePointer = 15
                .ToolTipText = "Impress" + CHR(227) + "o de Etiquetas"
                .PicturePosition = 7
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .T.
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("cmd_4c_Fwbtnm7", "CommandButton")
            WITH loc_oPag.cmd_4c_Fwbtnm7
                .Top = 251
                .Left = 624
                .Height = 80
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontShadow = .T.
                .FontSize = 7
                .WordWrap = .T.
                .Picture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption = "Gerar NF-e"
                .Enabled = .T.
                .PicturePosition = 7
                .ForeColor = RGB(90, 90, 90)
                .Themes = .T.
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("cmd_4c_Fwbtnm4", "CommandButton")
            WITH loc_oPag.cmd_4c_Fwbtnm4
                .Top = 251
                .Left = 775
                .Height = 80
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontShadow = .T.
                .WordWrap = .T.
                .Picture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
                .Caption = "Carta de Corre" + CHR(231) + CHR(227) + "o"
                .Enabled = .T.
                .ToolTipText = "Cria e emite Carta de Corre" + CHR(231) + CHR(227) + ;
                    "o para esta Nota Fiscal."
                .PicturePosition = 7
                .ForeColor = RGB(90, 90, 90)
                .Themes = .T.
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("cmd_4c_Fwbtnm6", "CommandButton")
            WITH loc_oPag.cmd_4c_Fwbtnm6
                .Top = 251
                .Left = 850
                .Height = 80
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontShadow = .T.
                .FontSize = 7
                .WordWrap = .T.
                .Picture = gc_4c_CaminhoIcones + "geral_pasta_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_60.jpg"
                .Caption = "Gerar XML"
                .Enabled = .T.
                .PicturePosition = 7
                .ForeColor = RGB(90, 90, 90)
                .Themes = .T.
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("cmd_4c_Fwbtnm3", "CommandButton")
            WITH loc_oPag.cmd_4c_Fwbtnm3
                .Top = 331
                .Left = 624
                .Height = 80
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontShadow = .T.
                .WordWrap = .T.
                .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Caption = "Cancela Nota"
                .Enabled = .T.
                .ToolTipText = "Cancela Nota Fiscal"
                .PicturePosition = 7
                .ForeColor = RGB(90, 90, 90)
                .Themes = .T.
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("cmd_4c_Fwbtnm1", "CommandButton")
            WITH loc_oPag.cmd_4c_Fwbtnm1
                .Top = 331
                .Left = 700
                .Height = 80
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontShadow = .T.
                .Picture = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .Caption = "Reimprime o DANFE"
                .Enabled = .T.
                .ToolTipText = "Reimprime: Danfe de NF, CFe de SAT e NFCe, Carne de ECF"
                .PicturePosition = 7
                .ForeColor = RGB(90, 90, 90)
                .Themes = .T.
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("cmd_4c_Fwbtnm2", "CommandButton")
            WITH loc_oPag.cmd_4c_Fwbtnm2
                .Top = 331
                .Left = 775
                .Height = 80
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontShadow = .T.
                .Picture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
                .Caption = "e-mail com TXT e XML"
                .Enabled = .T.
                .PicturePosition = 7
                .ForeColor = RGB(90, 90, 90)
                .Themes = .T.
                .Visible = .T.
            ENDWITH

            loc_oPag.AddObject("cmd_4c_Fwbtnm5", "CommandButton")
            WITH loc_oPag.cmd_4c_Fwbtnm5
                .Top = 331
                .Left = 850
                .Height = 80
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Comic Sans MS"
                .FontShadow = .T.
                .WordWrap = .T.
                .Picture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
                .Caption = "Executa Processos NFCe"
                .Enabled = .T.
                .ToolTipText = "Envia NFCe que estava em conting" + CHR(234) + ;
                    "ncia OFFLIne  (pasta CTG) e baixa os xmls emitidos no " + ;
                    "m" + CHR(234) + "s anterior " + CHR(224) + " data de hoje na " + ;
                    "pasta configurada na tag <PathXMLCompleto>."
                .PicturePosition = 7
                .ForeColor = RGB(90, 90, 90)
                .Themes = .T.
                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaNotaFiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaServicos - Campos da pagina "Servicos" (pgf_4c_1.Page2,
    * dump SIGOPFIS.Pagina.Servicos - linhas 3136-3788 de
    * sigopfis_form_codigo_fonte.txt, 38 objetos). Coordenadas RELATIVAS a
    * Page2 (pagina real e visivel, sem compensacao de PageFrame.Top=-29 -
    * mesmo criterio da Fase 5/ConfigurarPaginaNotaFiscal()).
    *
    * So geometria/propriedades visuais nesta fase - SEM RowSource/
    * ControlSource. Get_tptribsers.RowSource="crTpTrib" e
    * get_tiponfs.RowSource="crtiponfs.descrs" apontam para cursores que o
    * Init legado (dump linhas 4788-4857) monta em RUNTIME - crTpTrib com
    * INSERT INTO literal condicionado a crSigCdEmp.cidas = "RIO DE JANEIRO",
    * crtiponfs via fBeneficio_RJ()/fCodMunicipal() (funcoes globais do
    * legado, regra CLAUDE.md #27/#43 - wrapper ou reimplementacao no BO) -
    * entram na Fase 7/8 junto com os lookups (fwbuscaext de UF/fwbuscaint de
    * Municipio/Beneficio Fiscal/Servico Municipal) e o FormParaBO()/
    * BOParaForm().
    *
    * Say1/Say2/Say3/Say4/Say5/Say6/Say7/Say8/Say10-16 do dump sao classe
    * "say" com AutoSize=.T. e SEM Width/Alignment declarados - regra
    * CLAUDE.md #23: migrados com .AutoSize=.F. + .Alignment=0 + Width
    * calculada para caber o texto (AutoSize=.T. e no-op em Label criado por
    * AddObject). Say9/Say23 JA declaram Width explicita no dump - copiadas
    * literalmente.
    *
    * Op_IssRetido (OptionGroup "Nao"/"Sim", dump Option1.Value=1/
    * Option2.Value=0) - geometria e Buttons(N) completos; ControlSource
    * (issretidos) entra na Fase 7/8 com o resto do FormParaBO/BOParaForm.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaServicos()
        LOCAL loc_oPag, loc_oErro

        TRY
            loc_oPag = THIS.pgf_4c_1.Page2

            *======================================================
            * Bloco 1 (Top 54-82): Tipo de Tributacao de Servicos
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label23", "Label")
            WITH loc_oPag.lbl_4c_Label23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o de Servi" + CHR(231) + "os :"
                .Height    = 15
                .Left      = 49
                .Top       = 54
                .Width     = 156
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("cbo_4c_Get_tptribsers", "ComboBox")
            WITH loc_oPag.cbo_4c_Get_tptribsers
                .FontName         = "Courier New"
                .FontSize         = 8
                .RowSourceType    = 0
                .Style            = 2
                .Height           = 23
                .Left             = 211
                .Top              = 50
                .Width            = 288
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(238, 238, 238)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPag.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Presta" + CHR(231) + CHR(227) + "o Servi" + CHR(231) + "os :"
                .Height    = 15
                .Left      = 105
                .Top       = 82
                .Width     = 115
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *======================================================
            * Bloco 2 (Top 78): UF / Municipio da prestacao
            *======================================================
            loc_oPag.AddObject("txt_4c_Uf", "TextBox")
            WITH loc_oPag.txt_4c_Uf
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .MaxLength        = 2
                .Height           = 23
                .Left             = 211
                .Top              = 78
                .Width            = 65
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Mun", "TextBox")
            WITH loc_oPag.txt_4c_Mun
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .Height           = 23
                .Left             = 279
                .Top              = 78
                .Width            = 220
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            *======================================================
            * Bloco 3 (Top 105-109): Codigo/Descricao do Beneficio
            * Fiscal
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPag.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "C" + CHR(243) + "digo do Benef" + CHR(237) + "cio Fiscal :"
                .Height    = 15
                .Left      = 73
                .Top       = 109
                .Width     = 135
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Cbene", "TextBox")
            WITH loc_oPag.txt_4c_Cbene
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .MaxLength        = 3
                .Height           = 23
                .Left             = 211
                .Top              = 105
                .Width            = 65
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Dbene", "TextBox")
            WITH loc_oPag.txt_4c_Dbene
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .Height           = 23
                .Left             = 279
                .Top              = 105
                .Width            = 220
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            *======================================================
            * Bloco 4 (Top 132-136): Codigo/Descricao do Servico
            * Municipal
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPag.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "C" + CHR(243) + "digo do Servi" + CHR(231) + "o Municipal :"
                .Height    = 15
                .Left      = 64
                .Top       = 136
                .Width     = 145
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c__csrvfis", "TextBox")
            WITH loc_oPag.txt_4c__csrvfis
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .Height           = 23
                .Left             = 211
                .Top              = 132
                .Width            = 65
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c__dsrvfis", "TextBox")
            WITH loc_oPag.txt_4c__dsrvfis
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = ""
                .Format           = "K"
                .Height           = 23
                .Left             = 279
                .Top              = 132
                .Width            = 220
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            *======================================================
            * Bloco 5 (Top 159-243): Deducoes / Desconto
            * Condicionado / Desconto Incondicionado / Outras
            * Retencoes
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPag.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Dedu" + CHR(231) + CHR(245) + "es :"
                .Height    = 15
                .Left      = 149
                .Top       = 163
                .Width     = 55
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Vdedu", "TextBox")
            WITH loc_oPag.txt_4c_Vdedu
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .Height           = 23
                .Left             = 211
                .Top              = 159
                .Width            = 110
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPag.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Desconto Condicionado :"
                .Height    = 15
                .Left      = 84
                .Top       = 190
                .Width     = 125
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c__vdscc", "TextBox")
            WITH loc_oPag.txt_4c__vdscc
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .Height           = 23
                .Left             = 211
                .Top              = 186
                .Width            = 110
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPag.lbl_4c_Label6
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Desconto Incondicionado :"
                .Height    = 15
                .Left      = 76
                .Top       = 215
                .Width     = 133
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c__vdsvi", "TextBox")
            WITH loc_oPag.txt_4c__vdsvi
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .Height           = 23
                .Left             = 211
                .Top              = 214
                .Width            = 110
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPag.lbl_4c_Label7
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Outras Reten" + CHR(231) + CHR(245) + "es :"
                .Height    = 15
                .Left      = 109
                .Top       = 243
                .Width     = 100
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c__outretens", "TextBox")
            WITH loc_oPag.txt_4c__outretens
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .Height           = 23
                .Left             = 211
                .Top              = 242
                .Width            = 110
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            *======================================================
            * Bloco 6 (Top 270): ISS Retido (Nao/Sim)
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPag.lbl_4c_Label8
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "ISS Retido :"
                .Height    = 15
                .Left      = 146
                .Top       = 271
                .Width     = 63
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("obj_4c_Op_IssRetido", "OptionGroup")
            WITH loc_oPag.obj_4c_Op_IssRetido
                .Top         = 270
                .Left        = 211
                .Width       = 110
                .Height      = 23
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption   = "N" + CHR(227) + "o"
                    .Value     = 1
                    .Top       = 4
                    .Left      = 5
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Sim"
                    .Value     = 0
                    .Top       = 4
                    .Left      = 51
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH

            *======================================================
            * Bloco 7 (Top 298-301): Tipo Nota Convencional
            *======================================================
            loc_oPag.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPag.lbl_4c_Label9
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "Tipo Nota Convencional :"
                .Height    = 15
                .Left      = 83
                .Top       = 301
                .Width     = 122
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("cbo_4c_Get_tiponfs", "ComboBox")
            WITH loc_oPag.cbo_4c_Get_tiponfs
                .FontName         = "Courier New"
                .FontSize         = 8
                .RowSourceType    = 0
                .Style            = 2
                .Height           = 23
                .Left             = 211
                .Top              = 298
                .Width            = 288
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(238, 238, 238)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            *======================================================
            * Bloco 8 (Top 50-222): Impostos retidos na fonte (ISS/
            * IRRF/INSS/PIS/CSLL/COFINS) + Total
            *======================================================
            loc_oPag.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPag.shp_4c_Shape4
                .Top         = 212
                .Left        = 567
                .Width       = 233
                .Height      = 3
                .BackStyle   = 0
                .BorderWidth = 2
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPag.lbl_4c_Label10
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "ISS :"
                .Height    = 15
                .Left      = 650
                .Top       = 54
                .Width     = 30
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Fwget1", "TextBox")
            WITH loc_oPag.txt_4c_Fwget1
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .ReadOnly         = .T.
                .Height           = 23
                .Left             = 689
                .Top              = 50
                .Width            = 111
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label11", "Label")
            WITH loc_oPag.lbl_4c_Label11
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "IRRF :"
                .Height    = 15
                .Left      = 642
                .Top       = 82
                .Width     = 35
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Fwget2", "TextBox")
            WITH loc_oPag.txt_4c_Fwget2
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .ReadOnly         = .T.
                .Height           = 23
                .Left             = 689
                .Top              = 78
                .Width            = 111
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label12", "Label")
            WITH loc_oPag.lbl_4c_Label12
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "INSS :"
                .Height    = 15
                .Left      = 643
                .Top       = 109
                .Width     = 35
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Fwget3", "TextBox")
            WITH loc_oPag.txt_4c_Fwget3
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .ReadOnly         = .T.
                .Height           = 23
                .Left             = 689
                .Top              = 105
                .Width            = 111
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label13", "Label")
            WITH loc_oPag.lbl_4c_Label13
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "PIS :"
                .Height    = 15
                .Left      = 650
                .Top       = 136
                .Width     = 30
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Fwget4", "TextBox")
            WITH loc_oPag.txt_4c_Fwget4
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .ReadOnly         = .T.
                .Height           = 23
                .Left             = 689
                .Top              = 132
                .Width            = 111
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label14", "Label")
            WITH loc_oPag.lbl_4c_Label14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "CSSL :"
                .Height    = 15
                .Left      = 642
                .Top       = 163
                .Width     = 35
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Fwget5", "TextBox")
            WITH loc_oPag.txt_4c_Fwget5
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .ReadOnly         = .T.
                .Height           = 23
                .Left             = 689
                .Top              = 159
                .Width            = 111
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label15", "Label")
            WITH loc_oPag.lbl_4c_Label15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "COFINS :"
                .Height    = 15
                .Left      = 628
                .Top       = 190
                .Width     = 45
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Fwget6", "TextBox")
            WITH loc_oPag.txt_4c_Fwget6
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .ReadOnly         = .T.
                .Height           = 23
                .Left             = 689
                .Top              = 186
                .Width            = 111
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPag.lbl_4c_Label16
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .Caption   = "TOTAL IMPOSTOS :"
                .Height    = 15
                .Left      = 579
                .Top       = 222
                .Width     = 95
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Set_total", "TextBox")
            WITH loc_oPag.txt_4c_Set_total
                .FontName         = "Tahoma"
                .FontSize         = 8
                .Alignment        = 3
                .Value            = 0
                .InputMask        = "9999999999.99"
                .ReadOnly         = .T.
                .Height           = 23
                .Left             = 689
                .Top              = 218
                .Width            = 111
                .SpecialEffect    = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor      = RGB(90, 90, 90)
                .Visible          = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaServicos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventosLookup - liga por BINDEVENT os 13 campos que o dump
    * legado protege com um Valid de busca. Cada campo usa UM unico handler
    * ligado aos tres eventos:
    *
    *   "LostFocus" - equivalente ao Valid do legado (o legado abre o picker
    *                 ao SAIR do campo). NUNCA "KeyPress" sozinho: handler que
    *                 abre picker so por o campo nao estar vazio dispararia o
    *                 dialogo a CADA TECLA e o usuario nao conseguiria terminar
    *                 de digitar o codigo (regra CLAUDE.md #47).
    *   "KeyPress"  - atalho F4/F5 (convencao do sistema novo). O handler TESTA
    *                 a tecla antes de abrir.
    *   "DblClick"  - atalho de mouse (convencao do sistema novo).
    *
    * O MESMO handler atende aos tres porque BINDEVENT repassa os parametros do
    * evento: em KeyPress chegam 2 (PCOUNT() = 2), em LostFocus/DblClick nenhum
    * (PCOUNT() = 0). O handler so aplica o filtro de tecla quando de fato
    * recebeu uma - handler SEM parametro ligado a KeyPress eh que estoura
    * (regra CLAUDE.md #3), o inverso e seguro.
    *
    * Todos os handlers sao PUBLIC (sem PROTECTED): BINDEVENT com metodo
    * PROTECTED falha em silencio (regra CLAUDE.md #3).
    *
    * NAO existe container de Salvar/Cancelar neste form: o dump legado tem um
    * unico botao de acao ("ok", Caption "Retornar", criado na Fase 4 por
    * ConfigurarBotaoOk) - a gravacao e feita pelo form PAI. Acrescentar
    * cnt_4c_BotoesAcao aqui inventaria superficie que o legado nao tem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosLookup()
        LOCAL loc_oErro

        TRY
            *-- Campos diretos do form (dump: SIGOPFIS.Get_*)
            THIS.LigarEventosLookup("txt_4c_ClFiscal",  "ClFiscalLookup")
            THIS.LigarEventosLookup("txt_4c_DClFiscal", "DClFiscalLookup")
            THIS.LigarEventosLookup("txt_4c_Serie",     "SerieLookup")
            THIS.LigarEventosLookup("txt_4c_Especie",   "EspecieLookup")

            *-- Pagina 1 "Nota Fiscal" (dump: SIGOPFIS.Pagina.Impostos.Get_*)
            THIS.LigarEventosLookup("pgf_4c_1.Page1.txt_4c_Transp",  "TranspLookup")
            THIS.LigarEventosLookup("pgf_4c_1.Page1.txt_4c_Nome",    "NomeTranspLookup")
            THIS.LigarEventosLookup("pgf_4c_1.Page1.txt_4c_UfPlaca", "UfPlacaLookup")

            *-- Pagina 2 "Servicos" (dump: SIGOPFIS.Pagina.Servicos.Get_*)
            THIS.LigarEventosLookup("pgf_4c_1.Page2.txt_4c_Uf",       "UfServicoLookup")
            THIS.LigarEventosLookup("pgf_4c_1.Page2.txt_4c_Mun",      "MunicipioLookup")
            THIS.LigarEventosLookup("pgf_4c_1.Page2.txt_4c_Cbene",    "CbeneLookup")
            THIS.LigarEventosLookup("pgf_4c_1.Page2.txt_4c_Dbene",    "DbeneLookup")
            THIS.LigarEventosLookup("pgf_4c_1.Page2.txt_4c__csrvfis", "CsrvfisLookup")
            THIS.LigarEventosLookup("pgf_4c_1.Page2.txt_4c__dsrvfis", "DsrvfisLookup")

            THIS.AtualizarDependenciasCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarEventosLookup")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarEventosLookup - liga os 3 eventos de UM campo ao seu handler.
    * par_cCaminho e o caminho RELATIVO a THIS, e pode ter mais de um nivel
    * ("pgf_4c_1.Page1.txt_4c_Transp"): os campos deste form moram tanto
    * direto no form quanto nas duas Pages.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarEventosLookup(par_cCaminho, par_cHandler)
        LOCAL loc_oTxt

        loc_oTxt = THIS.ResolverControle(par_cCaminho)

        IF VARTYPE(loc_oTxt) = "O"
            BINDEVENT(loc_oTxt, "LostFocus", THIS, par_cHandler)
            BINDEVENT(loc_oTxt, "KeyPress",  THIS, par_cHandler)
            BINDEVENT(loc_oTxt, "DblClick",  THIS, par_cHandler)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverControle - devolve o objeto de caminho montado em tempo de
    * execucao, ou .NULL. quando o caminho nao resolve.
    *
    * TYPE() aceita caminho com ponto e devolve "U" sem estourar quando algum
    * segmento nao existe - PEMSTATUS so aceita UM nome e nao serve para
    * caminho de varios niveis. Controls(<nome>) esta fora de questao: e
    * indexado por NUMERO (regra CLAUDE.md #34). EVALUATE e a forma canonica
    * de LEITURA de membro por nome (regra CLAUDE.md #15).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ResolverControle(par_cCaminho)
        LOCAL loc_oCtrl
        loc_oCtrl = .NULL.

        IF VARTYPE(par_cCaminho) = "C" AND !EMPTY(par_cCaminho)
            IF TYPE("THIS." + par_cCaminho) = "O"
                loc_oCtrl = EVALUATE("THIS." + par_cCaminho)
            ENDIF
        ENDIF

        RETURN loc_oCtrl
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCampoLookup - devolve o TextBox de caminho par_cCaminho quando ele
    * pode receber lookup, ou .NULL. quando nao.
    *
    * O legado protege cada um desses campos com "When -> Return
    * InList(ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR')": em PROCURAR o campo
    * nao recebe foco e o Valid nunca roda. EmModoEdicao() reproduz esse When,
    * e a checagem de Enabled/ReadOnly reproduz as condicoes extras que alguns
    * desses When tem (ver AtualizarDependenciasCampos).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterCampoLookup(par_cCaminho)
        LOCAL loc_oTxt
        loc_oTxt = .NULL.

        IF THIS.EmModoEdicao()
            loc_oTxt = THIS.ResolverControle(par_cCaminho)

            IF VARTYPE(loc_oTxt) = "O"
                IF !loc_oTxt.Enabled OR loc_oTxt.ReadOnly
                    loc_oTxt = .NULL.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_oTxt
    ENDFUNC

    *--------------------------------------------------------------------------
    * EmModoEdicao - .T. nos modos em que o legado deixa os campos digitaveis
    * (Op_Escolha em "INSERIR"/"ALTERAR"). O modo chega do form PAI no Init.
    *--------------------------------------------------------------------------
    FUNCTION EmModoEdicao()
        RETURN INLIST(UPPER(ALLTRIM(THIS.this_cModoAtual)), ;
            "INCLUIR", "INSERIR", "ALTERAR")
    ENDFUNC

    *--------------------------------------------------------------------------
    * TeclaAbreLookup - .T. quando o handler deve abrir o picker.
    *
    * Chamado com os parametros que o evento entregou: em LostFocus/DblClick
    * nao vem nenhum (par_nKeyCode chega como .F.) e o lookup roda, que e o
    * comportamento do Valid legado; em KeyPress vem o codigo da tecla e so
    * F4 (115) e F5 (116) abrem.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION TeclaAbreLookup(par_nKeyCode)
        LOCAL loc_lAbre
        loc_lAbre = .T.

        IF VARTYPE(par_nKeyCode) = "N"
            loc_lAbre = INLIST(par_nKeyCode, 115, 116)
        ENDIF

        RETURN loc_lAbre
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarDependenciasCampos - reproduz as condicoes EXTRA que o When de
    * tres campos de descricao tem no dump legado, e que nao se resumem ao modo:
    *
    *   Get_DClFiscal.When -> ... And IsEmpty( ThisForm.Get_ClFiscal.Value )
    *   Get_dbene.When     -> ... and EMPTY( this.parent.get_cbene.Value )
    *   Get_dsrvfis.When   -> ... and EMPTY( this.parent.get_csrvfis.Value )
    *
    * Ou seja: a descricao SO aceita digitacao (e, portanto, SO abre o picker
    * por descricao) enquanto o campo de CODIGO da mesma linha esta vazio. Com
    * o codigo preenchido, a descricao e espelho - e por isso fica ReadOnly.
    *
    * PUBLIC: chamado pelos handlers de lookup (que rodam por BINDEVENT) para
    * reavaliar a dependencia logo apos o codigo mudar.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarDependenciasCampos()
        LOCAL loc_oErro

        TRY
            THIS.AplicarDependenciaDescricao("txt_4c_ClFiscal", "txt_4c_DClFiscal")
            THIS.AplicarDependenciaDescricao("pgf_4c_1.Page2.txt_4c_Cbene", ;
                "pgf_4c_1.Page2.txt_4c_Dbene")
            THIS.AplicarDependenciaDescricao("pgf_4c_1.Page2.txt_4c__csrvfis", ;
                "pgf_4c_1.Page2.txt_4c__dsrvfis")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AtualizarDependenciasCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarDependenciaDescricao - trava o campo de descricao quando o campo
    * de codigo da mesma linha esta preenchido, e libera quando esta vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarDependenciaDescricao(par_cCaminhoCod, par_cCaminhoDesc)
        LOCAL loc_oCod, loc_oDesc

        loc_oCod  = THIS.ResolverControle(par_cCaminhoCod)
        loc_oDesc = THIS.ResolverControle(par_cCaminhoDesc)

        IF VARTYPE(loc_oCod) = "O" AND VARTYPE(loc_oDesc) = "O"
            loc_oDesc.ReadOnly = !EMPTY(ALLTRIM(TRANSFORM(loc_oCod.Value)))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursorTemporario - fecha com seguranca um cursor auxiliar.
    * TABLEREVERT() EXIGE buffering: chamado em cursor com Buffering = 1 (o
    * default de CREATE CURSOR e de cursor de SQLEXEC) ele NAO e inocuo -
    * dispara o erro 1586 "Function requires row or table buffering mode". Dai
    * a guarda por CURSORGETPROP: USE IN fecha o alias mesmo com buffer sujo
    * (regra CLAUDE.md #52).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursorTemporario(par_cAlias)
        IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias) AND USED(par_cAlias)
            IF CURSORGETPROP("Buffering", par_cAlias) > 1
                TABLEREVERT(.T., par_cAlias)
            ENDIF
            USE IN (par_cAlias)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarListaLookup - roda na sessao DESTE form o SELECT que monta a
    * lista do lookup, e devolve .T. quando veio pelo menos uma linha.
    *
    * O legado carrega a lista INTEIRA (ja filtrada) num cursor e so depois faz
    * Seek - e esse cursor que decide se o picker abre. Reproduzir isso aqui
    * tambem resolve um problema de sessao: este form e DataSession = 2
    * (privada, igual ao SCX) e o FormBuscaAuxiliar nao declara DataSession,
    * entao o cursor que ELE cria vive na sessao default e nao e legivel deste
    * lado. Por isso toda COLUNA de que o form precisa e lida deste cursor
    * local, e do picker vem apenas o CODIGO escolhido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarListaLookup(par_cCursor, par_cSQL)
        LOCAL loc_nResultado, loc_lOk
        loc_lOk = .F.

        THIS.FecharCursorTemporario(par_cCursor)

        loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF loc_nResultado < 0
            MsgErro("Falha ao consultar a lista de busca." + CHR(13) + ;
                CapturarErroSQL(), "Erro SQL")
        ELSE
            IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                loc_lOk = .T.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AcharNaListaLookup - equivalente ao "Seek( This.Value )" do legado:
    * posiciona o cursor local na linha cujo campo bate EXATAMENTE com o valor
    * digitado (comparacao por ALLTRIM, que neutraliza o padding do char).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AcharNaListaLookup(par_cCursor, par_cCampo, par_cValor)
        LOCAL loc_lAchou, loc_cAlvo
        loc_lAchou = .F.

        IF USED(par_cCursor) AND VARTYPE(par_cValor) = "C"
            loc_cAlvo = UPPER(ALLTRIM(par_cValor))
            SELECT (par_cCursor)
            LOCATE FOR UPPER(ALLTRIM(TRANSFORM(EVALUATE(par_cCursor + "." + par_cCampo)))) == loc_cAlvo
            loc_lAchou = FOUND(par_cCursor)
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * LerColunaLookup - le uma coluna do cursor local de lookup na linha
    * corrente, devolvendo string vazia quando o cursor/linha nao resolve.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LerColunaLookup(par_cCursor, par_cCampo)
        LOCAL loc_cValor
        loc_cValor = ""

        IF USED(par_cCursor)
            IF !EOF(par_cCursor) AND TYPE(par_cCursor + "." + par_cCampo) != "U"
                loc_cValor = ALLTRIM(TRANSFORM(TratarNulo(EVALUATE(par_cCursor + "." + par_cCampo), "")))
            ENDIF
        ENDIF

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * PickerCodigoRemoto - equivalente ao fwbuscaext/fwbuscasel do legado:
    * abre o FormBuscaAuxiliar sobre uma TABELA do SQL Server e devolve o
    * CODIGO escolhido ("" quando o usuario cancelou).
    *
    * Usa a API com parametros do FormBuscaAuxiliar porque assim o SELECT roda
    * DENTRO da sessao do picker, que e a unica em que o cursor dele e legivel
    * (ver CarregarListaLookup). O valor escolhido volta por Mostrar(), que le
    * o cursor na propria sessao do picker e publica cCodigoSelecionado -
    * NUNCA lendo o cursor deste lado, que daria sempre vazio.
    *
    * par_cFiltro recebe a condicao SEM o "WHERE" (o Init concatena
    * " AND (<filtro>)"), e par_cTabela recebe o nome PURO da tabela: embutir
    * um WHERE no nome geraria dois WHERE na consulta final.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PickerCodigoRemoto(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
            par_cTituloCod, par_cTituloDesc, par_cValor, par_cTitulo, par_cFiltro)
        LOCAL loc_oBusca, loc_cCodigo, loc_cCursor
        loc_cCodigo = ""
        loc_cCursor = "cursor_4c_PickerFis"

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, par_cTabela, ;
            loc_cCursor, par_cCampoCod, ALLTRIM(par_cValor), par_cTitulo, ;
            .F., .T., par_cFiltro)

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.this_cCampoCodigo = par_cCampoCod
            loc_oBusca.mAddColuna(par_cCampoCod, "", par_cTituloCod)

            *-- Lookup de UMA coluna (o picker de Serie do legado tem so a
            *-- coluna Series): sem segunda coluna, a descricao espelha o
            *-- proprio codigo para Mostrar() ter o que avaliar.
            IF VARTYPE(par_cCampoDesc) = "C" AND !EMPTY(par_cCampoDesc)
                loc_oBusca.this_cCampoDescricao = par_cCampoDesc
                loc_oBusca.mAddColuna(par_cCampoDesc, "", par_cTituloDesc)
            ELSE
                loc_oBusca.this_cCampoDescricao = par_cCampoCod
            ENDIF

            IF loc_oBusca.Mostrar()
                loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
            ENDIF

            loc_oBusca.Release()
        ENDIF

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterOperacaoMovimento - devolve SigCdOpe.opers da movimentacao corrente
    * (0 quando nao resolve). O legado le isso do cursor crSigCdOpe, que o form
    * PAI mantem aberto; aqui o form tem DataSession privada e a origem e o
    * codigo da operacao guardado pelo BO (this_cDopes).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterOperacaoMovimento()
        LOCAL loc_cSQL, loc_cCursor, loc_nOpers, loc_cDopes
        loc_nOpers  = 0
        loc_cCursor = "cursor_4c_OpeFis"
        loc_cDopes  = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
        ENDIF

        IF !EMPTY(loc_cDopes)
            loc_cSQL = "SELECT opers FROM SigCdOpe WHERE RTRIM(dopes) = " + ;
                EscaparSQL(loc_cDopes)

            IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                SELECT (loc_cCursor)
                GO TOP
                loc_nOpers = VAL(THIS.LerColunaLookup(loc_cCursor, "opers"))
            ENDIF

            THIS.FecharCursorTemporario(loc_cCursor)
        ENDIF

        RETURN loc_nOpers
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfigSerieVazia - devolve SigOpCdd.servzs (0 quando nao resolve).
    * O legado le crSigOpCdd.SerVzs para decidir se a lista de series e global
    * ("Select Distinct series From SigCnFNf") ou por empresa.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterConfigSerieVazia()
        LOCAL loc_cCursor, loc_nServzs
        loc_nServzs = 0
        loc_cCursor = "cursor_4c_CddFis"

        IF THIS.CarregarListaLookup(loc_cCursor, "SELECT servzs FROM SigOpCdd")
            SELECT (loc_cCursor)
            GO TOP
            loc_nServzs = VAL(THIS.LerColunaLookup(loc_cCursor, "servzs"))
        ENDIF

        THIS.FecharCursorTemporario(loc_cCursor)

        RETURN loc_nServzs
    ENDFUNC

    *==========================================================================
    * HANDLERS DE LOOKUP - um por campo, ligado aos 3 eventos.
    * PUBLIC (sem PROTECTED) por exigencia do BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE ClFiscalLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupCfop("COD")
        ENDIF
    ENDPROC

    PROCEDURE DClFiscalLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupCfop("DESC")
        ENDIF
    ENDPROC

    PROCEDURE SerieLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupSerie()
        ENDIF
    ENDPROC

    PROCEDURE EspecieLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupEspecie()
        ENDIF
    ENDPROC

    PROCEDURE TranspLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupTransportadora("COD")
        ENDIF
    ENDPROC

    PROCEDURE NomeTranspLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupTransportadora("NOME")
        ENDIF
    ENDPROC

    PROCEDURE UfPlacaLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupUf("pgf_4c_1.Page1.txt_4c_UfPlaca")
        ENDIF
    ENDPROC

    PROCEDURE UfServicoLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupUf("pgf_4c_1.Page2.txt_4c_Uf")
        ENDIF
    ENDPROC

    PROCEDURE MunicipioLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupMunicipio()
        ENDIF
    ENDPROC

    PROCEDURE CbeneLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupBeneficio("COD")
        ENDIF
    ENDPROC

    PROCEDURE DbeneLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupBeneficio("DESC")
        ENDIF
    ENDPROC

    PROCEDURE CsrvfisLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupServicoMunicipal("COD")
        ENDIF
    ENDPROC

    PROCEDURE DsrvfisLookup(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.TeclaAbreLookup(par_nKeyCode)
            THIS.AbrirLookupServicoMunicipal("DESC")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EstaIncluindo - .T. no modo de INCLUSAO. O legado usa essa distincao
    * dentro do Valid do CFOP ("If (ThisForm.Op_Escolha = [INSERIR])" ->
    * "Delete From TmpSigCdCfo Where Situas = 2"): CFOP desativado nao pode
    * ser escolhido em nota NOVA, mas continua visivel em nota ja gravada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION EstaIncluindo()
        RETURN INLIST(UPPER(ALLTRIM(THIS.this_cModoAtual)), "INCLUIR", "INSERIR")
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirLookupCfop - picker do CFOP de movimentacao, pelos dois lados:
    *   par_cModo = "COD"  -> legado SIGOPFIS.Get_ClFiscal.Valid
    *   par_cModo = "DESC" -> legado SIGOPFIS.Get_DClFiscal.Valid
    *
    * Os dois Valid do legado montam a MESMA lista (TmpSigCdCfo) e diferem
    * apenas na ordem/coluna de busca ("Set Order to Codigos" contra
    * "Set Order to Descricaos") e na ordem das colunas do picker. A lista do
    * legado tem tres filtros, todos reproduzidos aqui:
    *
    *   1. operacaos = 'E'/'S' quando SigCdOpe.opers esta em (1,2)
    *      ("If InList(CrSigCdOpe.Opers,1,2)")
    *   2. codigos IN (SELECT cfops FROM SigCdOop WHERE dopes = <operacao>)
    *      quando llFiltraCfo esta ligado ("If ThisForm.llFiltraCfo")
    *   3. situas <> 2 em modo de inclusao
    *      ("Delete From TmpSigCdCfo Where (TmpSigCdCfo.Situas = 2)")
    *
    * e ainda uma substituicao de descricao:
    *      "Update TmpSigCdCfo Set Descricaos = Iif(Empty(Desc2s), Descricaos,
    *       Desc2s)"
    * reproduzida pelo CASE do SELECT (equivalente e sem depender de cursor
    * gravavel, que cursor de SQLEXEC nao e).
    *
    * Os dois lados - a lista local e o picker - consomem a MESMA expressao de
    * origem (loc_cFonte), uma subconsulta derivada com alias. Assim o picker
    * ve exatamente as linhas e a descricao que o legado veria, e nao a tabela
    * crua: o Init do FormBuscaAuxiliar concatena a propria clausula WHERE ao
    * que recebe em par_cTabela, e uma subconsulta com alias e um table
    * reference valido nessa posicao (diferente de embutir um WHERE no nome da
    * tabela, que geraria dois WHERE na consulta final).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCfop(par_cModo)
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupCfopExec(par_cModo)
        THIS.this_lEmLookup = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCfopExec - corpo do lookup de CFOP. Separado do wrapper acima
    * porque o corpo tem saidas antecipadas: com set/clear da flag no mesmo
    * metodo, uma saida antecipada deixaria this_lEmLookup ligada para sempre e
    * mataria o lookup pelo resto da vida do form (regra CLAUDE.md #47).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupCfopExec(par_cModo)
        LOCAL loc_oTxt, loc_oCod, loc_oDesc, loc_cValor, loc_cCursor, loc_oErro
        LOCAL loc_cSQL, loc_cWhere, loc_cFonte, loc_cCampo, loc_cCodigo
        LOCAL loc_nOpers, loc_cDopes, loc_lPorDesc

        loc_cCodigo  = ""
        loc_cCursor  = "cursor_4c_BuscaCfop"
        loc_lPorDesc = (UPPER(ALLTRIM(par_cModo)) == "DESC")
        loc_cCampo   = IIF(loc_lPorDesc, "descricaos", "codigos")

        TRY
            loc_oTxt = THIS.ObterCampoLookup(IIF(loc_lPorDesc, ;
                "txt_4c_DClFiscal", "txt_4c_ClFiscal"))

            IF VARTYPE(loc_oTxt) = "O"
                *-- Legado: "If !Empty( This.Value )" - campo vazio nao abre
                *-- picker nenhum.
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    *-- Filtro 1: operacao de entrada (E) ou de saida (S).
                    loc_cWhere = ""
                    loc_nOpers = THIS.ObterOperacaoMovimento()
                    IF INLIST(loc_nOpers, 1, 2)
                        loc_cWhere = " WHERE operacaos = " + ;
                            EscaparSQL(IIF(loc_nOpers = 1, "E", "S"))
                    ENDIF

                    *-- Filtro 2: so os CFOP associados a operacao (SigCdOop).
                    IF THIS.this_lFiltraCfo
                        loc_cDopes = ""
                        IF VARTYPE(THIS.this_oBusinessObject) = "O"
                            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
                        ENDIF

                        loc_cWhere = loc_cWhere + ;
                            IIF(EMPTY(loc_cWhere), " WHERE ", " AND ") + ;
                            "codigos IN (SELECT cfops FROM SigCdOop WHERE RTRIM(dopes) = " + ;
                            EscaparSQL(loc_cDopes) + ")"
                    ENDIF

                    *-- Filtro 3: em inclusao, CFOP desativado nao entra.
                    IF THIS.EstaIncluindo()
                        loc_cWhere = loc_cWhere + ;
                            IIF(EMPTY(loc_cWhere), " WHERE ", " AND ") + ;
                            "situas <> 2"
                    ENDIF

                    loc_cFonte = "(SELECT codigos," + ;
                        " CASE WHEN LTRIM(RTRIM(ISNULL(desc2s, ''))) = ''" + ;
                        " THEN descricaos ELSE desc2s END AS descricaos," + ;
                        " ipi_icms, incicmnfs, operacaos" + ;
                        " FROM SigCdCfo" + loc_cWhere + ") AS CfoFis"

                    loc_cSQL = "SELECT * FROM " + loc_cFonte + ;
                        " ORDER BY " + loc_cCampo

                    IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                        *-- Legado: "If !Seek( This.Value )" - achando na
                        *-- lista, resolve sem exibir o dialogo (contrato da
                        *-- regra CLAUDE.md #37).
                        IF !THIS.AcharNaListaLookup(loc_cCursor, loc_cCampo, loc_cValor)
                            IF loc_lPorDesc
                                loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
                                    "descricaos", "codigos", ;
                                    "Descri" + CHR(231) + CHR(227) + "o", "C" + CHR(243) + "digo", ;
                                    loc_cValor, "Cadastro de C.F.O.P.", "")
                            ELSE
                                loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
                                    "codigos", "descricaos", ;
                                    "C" + CHR(243) + "digo", "Descri" + CHR(231) + CHR(227) + "o", ;
                                    loc_cValor, "Cadastro de C.F.O.P.", "")
                            ENDIF

                            *-- O picker devolve so o valor da coluna de busca:
                            *-- as demais colunas (ipi_icms, incicmnfs,
                            *-- operacaos) vem do cursor LOCAL, reposicionado
                            *-- pelo codigo escolhido.
                            IF !EMPTY(loc_cCodigo)
                                IF !THIS.AcharNaListaLookup(loc_cCursor, loc_cCampo, loc_cCodigo)
                                    loc_cCodigo = ""
                                ENDIF
                            ENDIF
                        ELSE
                            loc_cCodigo = loc_cValor
                        ENDIF

                        IF !EMPTY(loc_cCodigo)
                            THIS.AplicarCfopEscolhido(loc_cCursor)
                        ENDIF
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupCfopExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarCfopEscolhido - transcreve o bloco que os DOIS Valid de CFOP do
    * legado executam depois de resolver a linha (dump, Get_ClFiscal.Valid):
    *
    *   ThisForm.Get_ClFiscal.Value  = TmpSigCdCfo.Codigos
    *   ThisForm.Get_DClFiscal.Value = TmpSigCdCfo.Descricaos
    *   ThisForm.IpiBaseIcm = ( TmpSigCdCfo.Ipi_Icms  = 'S' )
    *   ThisForm.IcmsTTNf   = ( TmpSigCdCfo.IncIcmNfs = 1 )
    *   Replace crSigMvNfi.Operas With TmpSigCdCfo.Operacaos,
    *           crSigMvNfi.CFis   With TmpSigCdCfo.Codigos
    *
    * crSigMvNfi e o cursor que o form PAI mantem; aqui o destino equivalente
    * sao as properties do BO, que e quem grava SigMvNfi.
    *
    * O recalculo de impostos (CalcImposto do form pai) e a checagem de
    * coerencia entre a 1a posicao do CFOP e a UF do destinatario dependem de
    * cursores que pertencem ao form chamador (crTmpCli/crSigCdEmp/crTmpCee) e
    * entram com as validacoes de gravacao, nas Fases 7/8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarCfopEscolhido(par_cCursor)
        LOCAL loc_cCodigo, loc_cDescricao, loc_cIpiIcms, loc_cIncIcm

        loc_cCodigo    = THIS.LerColunaLookup(par_cCursor, "codigos")
        loc_cDescricao = THIS.LerColunaLookup(par_cCursor, "descricaos")
        loc_cIpiIcms   = THIS.LerColunaLookup(par_cCursor, "ipi_icms")
        loc_cIncIcm    = THIS.LerColunaLookup(par_cCursor, "incicmnfs")

        IF TYPE("THIS.txt_4c_ClFiscal") = "O"
            THIS.txt_4c_ClFiscal.Value = loc_cCodigo
            THIS.txt_4c_ClFiscal.Refresh()
        ENDIF

        IF TYPE("THIS.txt_4c_DClFiscal") = "O"
            THIS.txt_4c_DClFiscal.Value = loc_cDescricao
            THIS.txt_4c_DClFiscal.Refresh()
        ENDIF

        THIS.this_lIpiBaseIcm = (UPPER(loc_cIpiIcms) == "S")
        THIS.this_lIcmsTtNf   = (VAL(loc_cIncIcm) = 1)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCFis   = loc_cCodigo
            THIS.this_oBusinessObject.this_cOperas = ;
                THIS.LerColunaLookup(par_cCursor, "operacaos")
            THIS.this_oBusinessObject.this_cDClFiscal = loc_cDescricao
        ENDIF

        *-- O codigo acabou de ser preenchido: a descricao volta a ser espelho
        *-- e deixa de aceitar digitacao (When do legado).
        THIS.AtualizarDependenciasCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSerie - picker da Serie da nota (legado SIGOPFIS.Get_Serie,
    * fwbuscasel sobre TmpCfgNf com a UNICA coluna Series).
    *
    * A lista do legado tem tres passos, todos reproduzidos:
    *   1. SigOpCdd.SerVzs = 1 -> "Select Distinct series From SigCnFNf"
    *      (serie global); senao "... Where Emps = <empresa do movimento>"
    *   2. lista vazia -> repete com Emps = Space(3) (serie generica)
    *   3. "Set Order to Series" + "If !Seek( This.Value )" -> picker
    *
    * Apos a escolha o legado le a configuracao da serie em SigCnFNf e aplica
    * as marcas/especies padrao em crSigMvNfi ("Replace Marcas with
    * crSigCnFNf.MarPads, Espes With crSigCnFNf.EspPads") - reproduzido em
    * AplicarSerieEscolhida.
    *
    * A numeracao da nota e o selo fiscal (fGerUniqueKey/fCanUniqueKey/
    * fVerImpPends, sobre SigCdSer) sao sequenciadores de documento e entram
    * com as validacoes de gravacao, nas Fases 7/8.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSerie()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupSerieExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupSerieExec()
        LOCAL loc_oTxt, loc_cValor, loc_cCursor, loc_cSQL, loc_cFonte
        LOCAL loc_cEmps, loc_cCodigo, loc_nServzs, loc_oErro

        loc_cCodigo = ""
        loc_cCursor = "cursor_4c_BuscaSerie"

        TRY
            loc_oTxt = THIS.ObterCampoLookup("txt_4c_Serie")

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    loc_cEmps = ""
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        loc_cEmps = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
                    ENDIF

                    loc_nServzs = THIS.ObterConfigSerieVazia()

                    IF loc_nServzs = 1
                        loc_cFonte = "(SELECT DISTINCT series FROM SigCnFNf) AS SerFis"
                    ELSE
                        loc_cFonte = "(SELECT DISTINCT series FROM SigCnFNf WHERE RTRIM(emps) = " + ;
                            EscaparSQL(loc_cEmps) + ") AS SerFis"
                    ENDIF

                    loc_cSQL = "SELECT * FROM " + loc_cFonte + " ORDER BY series"

                    *-- Legado: lista vazia por empresa -> repete com a
                    *-- empresa generica (Space(3)).
                    IF !THIS.CarregarListaLookup(loc_cCursor, loc_cSQL) AND loc_nServzs != 1
                        loc_cFonte = "(SELECT DISTINCT series FROM SigCnFNf WHERE RTRIM(emps) = " + ;
                            EscaparSQL("") + ") AS SerFis"
                        loc_cSQL = "SELECT * FROM " + loc_cFonte + " ORDER BY series"
                        THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                    ENDIF

                    IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                        IF !THIS.AcharNaListaLookup(loc_cCursor, "series", loc_cValor)
                            *-- Picker de UMA coluna, como o legado
                            *-- ("loLista.AddColuna( 'Series', Repl('X',10),
                            *-- 'Codigo' )" e mais nada).
                            loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
                                "series", "", "S" + CHR(233) + "rie", "", ;
                                loc_cValor, "Cadastro de S" + CHR(233) + "ries", "")
                        ELSE
                            loc_cCodigo = THIS.LerColunaLookup(loc_cCursor, "series")
                        ENDIF

                        IF !EMPTY(loc_cCodigo)
                            loc_oTxt.Value = loc_cCodigo
                            loc_oTxt.Refresh()

                            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                                THIS.this_oBusinessObject.this_cSeries = loc_cCodigo
                            ENDIF

                            THIS.AplicarSerieEscolhida(loc_cCodigo, loc_cEmps)
                        ENDIF
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupSerieExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarSerieEscolhida - le a configuracao da serie em SigCnFNf e aplica
    * marca e especie padrao, transcrevendo o trecho do Valid legado:
    *
    *   lcQuery = [Select Series, NldSer, MarPads, EspPads, ... From SigCnFNf
    *              Where Emps = <empresa> And Series = <serie>]
    *   ... Go Top / If Eof() -> repete com Emps = Space(3)
    *   Replace Marcas with crSigCnFNf.MarPads, Espes With crSigCnFNf.EspPads
    *   If IsEmpty(crSigMvNfi.Marcas) -> Replace Marcas with crSigCnFNf.MarPads
    *
    * Os campos de destino na tela sao txt_4c_Marca e txt_4c_EspecieVol, da
    * pagina "Nota Fiscal" (o legado termina o Valid dando Refresh neles).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarSerieEscolhida(par_cSerie, par_cEmps)
        LOCAL loc_cCursor, loc_cSQL, loc_cMarca, loc_cEspecie, loc_oCtrl

        loc_cCursor = "cursor_4c_CfgSerie"

        loc_cSQL = "SELECT series, nldser, marpads, esppads, piss, fatbrutos, pesovols" + ;
            " FROM SigCnFNf WHERE RTRIM(emps) = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
            " AND RTRIM(series) = " + EscaparSQL(ALLTRIM(par_cSerie))

        IF !THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
            loc_cSQL = "SELECT series, nldser, marpads, esppads, piss, fatbrutos, pesovols" + ;
                " FROM SigCnFNf WHERE RTRIM(emps) = " + EscaparSQL("") + ;
                " AND RTRIM(series) = " + EscaparSQL(ALLTRIM(par_cSerie))
            THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
        ENDIF

        IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            SELECT (loc_cCursor)
            GO TOP

            loc_cMarca   = THIS.LerColunaLookup(loc_cCursor, "marpads")
            loc_cEspecie = THIS.LerColunaLookup(loc_cCursor, "esppads")

            loc_oCtrl = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_Marca")
            IF VARTYPE(loc_oCtrl) = "O" AND !EMPTY(loc_cMarca)
                loc_oCtrl.Value = loc_cMarca
                loc_oCtrl.Refresh()
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_cMarcas = loc_cMarca
                ENDIF
            ENDIF

            loc_oCtrl = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_EspecieVol")
            IF VARTYPE(loc_oCtrl) = "O" AND !EMPTY(loc_cEspecie)
                loc_oCtrl.Value = loc_cEspecie
                loc_oCtrl.Refresh()
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_cEspes = loc_cEspecie
                ENDIF
            ENDIF
        ENDIF

        THIS.FecharCursorTemporario(loc_cCursor)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEspecie - picker da Especie da NOTA (legado
    * SIGOPFIS.Get_Especie.Valid: fwbuscaext sobre SigCdEsp com as colunas
    * Especies e Descs; grava This.Value = crListaRemota.Especies).
    *
    * Tabela: SigCdEsp (especies char(6), descs char(40)) - conferida em
    * docs/schema.sql.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEspecie()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupEspecieExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupEspecieExec()
        LOCAL loc_oTxt, loc_cValor, loc_cCursor, loc_cCodigo, loc_oErro

        loc_cCodigo = ""
        loc_cCursor = "cursor_4c_BuscaEspecie"

        TRY
            loc_oTxt = THIS.ObterCampoLookup("txt_4c_Especie")

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    IF THIS.CarregarListaLookup(loc_cCursor, ;
                            "SELECT especies, descs FROM SigCdEsp ORDER BY especies")

                        IF !THIS.AcharNaListaLookup(loc_cCursor, "especies", loc_cValor)
                            loc_cCodigo = THIS.PickerCodigoRemoto("SigCdEsp", ;
                                "especies", "descs", ;
                                "Esp" + CHR(233) + "cie", "Descri" + CHR(231) + CHR(227) + "o", ;
                                loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", "")
                        ELSE
                            loc_cCodigo = THIS.LerColunaLookup(loc_cCursor, "especies")
                        ENDIF

                        IF !EMPTY(loc_cCodigo)
                            loc_oTxt.Value = loc_cCodigo
                            loc_oTxt.Refresh()

                            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                                THIS.this_oBusinessObject.this_cEspecieNFs = loc_cCodigo
                            ENDIF
                        ENDIF
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupEspecieExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTransportadora - picker da transportadora, pelos dois lados:
    *   par_cModo = "COD"  -> legado Pagina.Impostos.Get_Transp.Valid
    *   par_cModo = "NOME" -> legado Pagina.Impostos.Get_Nome.Valid
    *
    * Tabela: SigPrTrp (itras char(10) = codigo, razaos char(40) = razao
    * social, endes/cidas/estas = endereco/cidade/UF, cgcs = CPF/CNPJ) -
    * conferida em docs/schema.sql.
    *
    * Os dois Valid preenchem os MESMOS CINCO campos a partir da linha
    * escolhida:
    *   .Get_Transp.Value   = CrListaRemota.iTras
    *   .Get_Nome.Value     = CrListaRemota.Razaos
    *   .Get_Endereco.Value = CrListaRemota.Endes
    *   .Get_Cidade.Value   = CrListaRemota.Cidas
    *   .Get_Estado.Value   = CrListaRemota.Estas
    * e limpam os cinco quando o usuario sai por ESC ("If LastKey() # 27 ...
    * Else ... Endif") - reproduzido por LimparTransportadora.
    *
    * A busca por NOME usa o filtro de SUBSTRING do legado
    * ("lcfiltro = [razaos like '%] + Alltrim(this.Value) + [%']"), diferente
    * da busca por codigo, que e por igualdade.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTransportadora(par_cModo)
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupTransportadoraExec(par_cModo)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupTransportadoraExec(par_cModo)
        LOCAL loc_oTxt, loc_cValor, loc_cCursor, loc_cSQL, loc_cFonte
        LOCAL loc_cCampo, loc_cCodigo, loc_lPorNome, loc_oErro

        loc_cCodigo  = ""
        loc_cCursor  = "cursor_4c_BuscaTransp"
        loc_lPorNome = (UPPER(ALLTRIM(par_cModo)) == "NOME")
        loc_cCampo   = IIF(loc_lPorNome, "razaos", "itras")

        TRY
            loc_oTxt = THIS.ObterCampoLookup(IIF(loc_lPorNome, ;
                "pgf_4c_1.Page1.txt_4c_Nome", "pgf_4c_1.Page1.txt_4c_Transp"))

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    *-- Legado: a busca por NOME restringe a lista por
                    *-- SUBSTRING antes de abrir o picker.
                    IF loc_lPorNome
                        loc_cFonte = "(SELECT itras, razaos, endes, cidas, estas, cgcs" + ;
                            " FROM SigPrTrp WHERE razaos LIKE " + ;
                            EscaparSQL("%" + loc_cValor + "%") + ") AS TrpFis"
                    ELSE
                        loc_cFonte = "(SELECT itras, razaos, endes, cidas, estas, cgcs" + ;
                            " FROM SigPrTrp) AS TrpFis"
                    ENDIF

                    loc_cSQL = "SELECT * FROM " + loc_cFonte + " ORDER BY " + loc_cCampo

                    IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                        IF !THIS.AcharNaListaLookup(loc_cCursor, loc_cCampo, loc_cValor)
                            IF loc_lPorNome
                                loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
                                    "razaos", "itras", ;
                                    "Raz" + CHR(227) + "o Social", "C" + CHR(243) + "digo", ;
                                    loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", "")
                            ELSE
                                loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
                                    "itras", "razaos", ;
                                    "C" + CHR(243) + "digo", "Raz" + CHR(227) + "o Social", ;
                                    loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", "")
                            ENDIF

                            *-- Endereco/cidade/UF nao vem do picker (ele
                            *-- devolve a coluna de busca): a linha e
                            *-- reencontrada no cursor LOCAL, que tem as seis
                            *-- colunas.
                            IF !EMPTY(loc_cCodigo)
                                IF !THIS.AcharNaListaLookup(loc_cCursor, loc_cCampo, loc_cCodigo)
                                    loc_cCodigo = ""
                                ENDIF
                            ENDIF
                        ELSE
                            loc_cCodigo = loc_cValor
                        ENDIF

                        IF EMPTY(loc_cCodigo)
                            *-- Legado: saida por ESC limpa os cinco campos.
                            THIS.LimparTransportadora()
                        ELSE
                            THIS.AplicarTransportadoraEscolhida(loc_cCursor)
                        ENDIF
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupTransportadoraExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarTransportadoraEscolhida - preenche os cinco campos da
    * transportadora a partir da linha corrente do cursor local, e espelha o
    * resultado nas properties do BO (que e quem grava SigMvNfi).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarTransportadoraEscolhida(par_cCursor)
        LOCAL loc_cCod, loc_cNome, loc_cEnde, loc_cCida, loc_cEsta

        loc_cCod  = THIS.LerColunaLookup(par_cCursor, "itras")
        loc_cNome = THIS.LerColunaLookup(par_cCursor, "razaos")
        loc_cEnde = THIS.LerColunaLookup(par_cCursor, "endes")
        loc_cCida = THIS.LerColunaLookup(par_cCursor, "cidas")
        loc_cEsta = THIS.LerColunaLookup(par_cCursor, "estas")

        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Transp",   loc_cCod)
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Nome",     loc_cNome)
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Endereco", loc_cEnde)
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Cidade",   loc_cCida)
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Estado",   loc_cEsta)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCodTrans  = loc_cCod
            THIS.this_oBusinessObject.this_cDTransp   = loc_cNome
            THIS.this_oBusinessObject.this_cEndTransp = loc_cEnde
            THIS.this_oBusinessObject.this_cCidTransp = loc_cCida
            THIS.this_oBusinessObject.this_cUfTransp  = loc_cEsta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparTransportadora - ramo ELSE dos dois Valid do legado ("If LastKey()
    * # 27 ... Else ... Endif"): saindo por ESC, os cinco campos da
    * transportadora voltam a vazio.
    *
    * Esta e a UNICA limpeza de campo reproduzida nos lookups deste form, e ela
    * existe no dump - nos demais campos, nao achar registro NAO apaga o que o
    * usuario digitou (regra CLAUDE.md #50).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparTransportadora()
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Transp",   "")
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Nome",     "")
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Endereco", "")
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Cidade",   "")
        THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Estado",   "")

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCodTrans  = ""
            THIS.this_oBusinessObject.this_cDTransp   = ""
            THIS.this_oBusinessObject.this_cEndTransp = ""
            THIS.this_oBusinessObject.this_cCidTransp = ""
            THIS.this_oBusinessObject.this_cUfTransp  = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtribuirValorCampo - grava um valor num campo alcancado por caminho, sem
    * esbarrar no ReadOnly que o legado tambem ignora quando e o proprio Valid
    * que preenche (Get_Endereco/Get_Cidade/Get_Estado tem "When -> Return .F."
    * no dump e ainda assim recebem valor do Valid da transportadora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtribuirValorCampo(par_cCaminho, par_cValor)
        LOCAL loc_oCtrl

        loc_oCtrl = THIS.ResolverControle(par_cCaminho)

        IF VARTYPE(loc_oCtrl) = "O"
            loc_oCtrl.Value = par_cValor
            loc_oCtrl.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUf - picker de UF, usado pelos DOIS campos de UF do form:
    *   "pgf_4c_1.Page1.txt_4c_UfPlaca" -> legado Pagina.Impostos.Get_UfPlaca
    *   "pgf_4c_1.Page2.txt_4c_Uf"      -> legado Pagina.Servicos.Get_Uf
    *
    * Os dois Valid do legado sao o mesmo fwbuscaext sobre SigCdUfs (colunas
    * Estados e Descrs) e gravam This.Value = crListaRemota.Estados; o da
    * pagina Servicos busca por Padr(This.Value,2), e esse PADR e reproduzido.
    *
    * Tabela: SigCdUfs (estados char(2), descrs char(40)) - conferida em
    * docs/schema.sql.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUf(par_cCaminho)
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupUfExec(par_cCaminho)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupUfExec(par_cCaminho)
        LOCAL loc_oTxt, loc_cValor, loc_cCursor, loc_cCodigo, loc_oErro

        loc_cCodigo = ""
        loc_cCursor = "cursor_4c_BuscaUf"

        TRY
            loc_oTxt = THIS.ObterCampoLookup(par_cCaminho)

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    IF THIS.CarregarListaLookup(loc_cCursor, ;
                            "SELECT estados, descrs FROM SigCdUfs ORDER BY estados")

                        IF !THIS.AcharNaListaLookup(loc_cCursor, "estados", PADR(loc_cValor, 2))
                            loc_cCodigo = THIS.PickerCodigoRemoto("SigCdUfs", ;
                                "estados", "descrs", ;
                                "UF", "Descri" + CHR(231) + CHR(227) + "o", ;
                                PADR(loc_cValor, 2), "Sele" + CHR(231) + CHR(227) + "o", "")
                        ELSE
                            loc_cCodigo = THIS.LerColunaLookup(loc_cCursor, "estados")
                        ENDIF

                        *-- Legado: "If crListaRemota.Estados <> '  '" - UF
                        *-- vazia nao sobrescreve o campo.
                        IF !EMPTY(loc_cCodigo)
                            loc_oTxt.Value = loc_cCodigo
                            loc_oTxt.Refresh()

                            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                                IF par_cCaminho == "pgf_4c_1.Page2.txt_4c_Uf"
                                    THIS.this_oBusinessObject.this_cUfServ = loc_cCodigo
                                ELSE
                                    THIS.this_oBusinessObject.this_cUfPlacas = loc_cCodigo
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupUfExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMunicipio - picker do municipio da prestacao de servico
    * (legado Pagina.Servicos.Get_Mun.Valid).
    *
    * A lista do legado e um JOIN filtrado pela UF do campo vizinho:
    *   lcQuery = [Select b.estados as estados, a.descs as munici,
    *              a.codigos as codibges From SigCdMun a, SigcdUfs b
    *              where b.estados = '<UF>' and a.ufibges = b.ufibges
    *              order by descs]
    *   Index On munici / If Not Seek(Padr(This.Value, 40)) -> fwbuscaint
    *   This.Value = crlocal.munici / lcIbges = crlocal.codibges
    *   replace prestservs with lcIbges in crSigMvNfi
    *
    * Sem UF preenchida o legado nao consulta nada ("If Not Empty(lcUf)") e o
    * codigo IBGE do municipio e zerado - os dois comportamentos reproduzidos.
    *
    * Tabelas: SigCdMun (codigos char(7), descs char(40), ufibges numeric) e
    * SigCdUfs (estados char(2), UFIBGEs numeric) - conferidas em
    * docs/schema.sql.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMunicipio()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupMunicipioExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupMunicipioExec()
        LOCAL loc_oTxt, loc_oUf, loc_cValor, loc_cUf, loc_cCursor
        LOCAL loc_cSQL, loc_cFonte, loc_cNome, loc_cIbge, loc_oErro

        loc_cNome   = ""
        loc_cIbge   = ""
        loc_cCursor = "cursor_4c_BuscaMun"

        TRY
            loc_oTxt = THIS.ObterCampoLookup("pgf_4c_1.Page2.txt_4c_Mun")
            loc_oUf  = THIS.ResolverControle("pgf_4c_1.Page2.txt_4c_Uf")

            IF VARTYPE(loc_oTxt) = "O" AND VARTYPE(loc_oUf) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
                loc_cUf    = ALLTRIM(TRANSFORM(loc_oUf.Value))

                *-- Legado: "If Not Empty(lcUf)" - sem UF nao ha lista de
                *-- municipios, e o codigo IBGE fica vazio.
                IF EMPTY(loc_cUf)
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        THIS.this_oBusinessObject.this_cPrestservs = ""
                    ENDIF
                ELSE
                    loc_cFonte = "(SELECT b.estados AS estados, a.descs AS munici," + ;
                        " a.codigos AS codibges" + ;
                        " FROM SigCdMun a INNER JOIN SigCdUfs b ON a.ufibges = b.UFIBGEs" + ;
                        " WHERE RTRIM(b.estados) = " + EscaparSQL(loc_cUf) + ") AS MunFis"

                    loc_cSQL = "SELECT * FROM " + loc_cFonte + " ORDER BY munici"

                    IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                        IF !THIS.AcharNaListaLookup(loc_cCursor, "munici", loc_cValor)
                            loc_cNome = THIS.PickerCodigoRemoto(loc_cFonte, ;
                                "munici", "estados", ;
                                "Munic" + CHR(237) + "pios", "UF", ;
                                loc_cValor, "Munic" + CHR(237) + "pios", "")

                            IF !EMPTY(loc_cNome)
                                IF !THIS.AcharNaListaLookup(loc_cCursor, "munici", loc_cNome)
                                    loc_cNome = ""
                                ENDIF
                            ENDIF
                        ELSE
                            loc_cNome = THIS.LerColunaLookup(loc_cCursor, "munici")
                        ENDIF

                        IF !EMPTY(loc_cNome)
                            loc_cIbge = THIS.LerColunaLookup(loc_cCursor, "codibges")

                            loc_oTxt.Value = loc_cNome
                            loc_oTxt.Refresh()

                            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                                THIS.this_oBusinessObject.this_cMunServ     = loc_cNome
                                THIS.this_oBusinessObject.this_cPrestservs  = loc_cIbge
                            ENDIF
                        ENDIF
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupMunicipioExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupBeneficio - picker do Beneficio Fiscal, pelos dois lados:
    *   par_cModo = "COD"  -> legado Pagina.Servicos.Get_cbene.Valid
    *   par_cModo = "DESC" -> legado Pagina.Servicos.Get_dbene.Valid
    *
    * O legado NAO consulta tabela aqui: os dois Valid usam fwbuscaint sobre o
    * cursor LOCAL crBeneficioRJ, montado no Init por fBeneficio_RJ() -
    * funcao global do SIGFUNCS.PRG legado que NAO faz parte do acervo
    * migrado, e que nao tem tabela correspondente em docs/schema.sql (as 682
    * tabelas foram conferidas). Apontar este lookup para outra tabela
    * gravaria codigo de outro dominio na coluna codbenefs e violaria o
    * PILAR 2, por isso a origem continua sendo o cursor.
    *
    * Com o cursor presente na sessao, o comportamento e o do legado:
    * resolve-se o codigo digitado por Seek e preenche-se o par codigo +
    * descricao. Sem ele, a indisponibilidade e AVISADA e o valor digitado e
    * PRESERVADO - nao apagar o que o usuario digitou e o que a regra
    * CLAUDE.md #50 exige, e deixar a ausencia visivel e o que a regra #27
    * exige de dependencia legado nao portada.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupBeneficio(par_cModo)
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupBeneficioExec(par_cModo)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupBeneficioExec(par_cModo)
        LOCAL loc_oTxt, loc_cValor, loc_cCampo, loc_lPorDesc, loc_oErro

        loc_lPorDesc = (UPPER(ALLTRIM(par_cModo)) == "DESC")
        loc_cCampo   = IIF(loc_lPorDesc, "descrs", "codigos")

        TRY
            loc_oTxt = THIS.ObterCampoLookup(IIF(loc_lPorDesc, ;
                "pgf_4c_1.Page2.txt_4c_Dbene", "pgf_4c_1.Page2.txt_4c_Cbene"))

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                *-- Legado: "If !Empty(This.Value)" no lado do codigo e
                *-- "IF !EMPTY(this.value)" no lado da descricao.
                IF !EMPTY(loc_cValor)
                    IF THIS.ListaLocalDisponivel("crBeneficioRJ", loc_cCampo)
                        *-- Legado: "Set Order To Codigos" +
                        *-- "If Not Seek(Padr(This.Value, 3), ...)".
                        IF THIS.AcharNaListaLookup("crBeneficioRJ", loc_cCampo, loc_cValor)
                            THIS.AplicarBeneficioEscolhido()
                        ELSE
                            MsgAviso("Benef" + CHR(237) + "cio fiscal [" + loc_cValor + ;
                                "] n" + CHR(227) + "o cadastrado." + CHR(13) + ;
                                "O valor digitado foi mantido.", ;
                                "Benef" + CHR(237) + "cio Fiscal")
                        ENDIF
                    ELSE
                        MsgAviso("A lista de Benef" + CHR(237) + "cios Fiscais " + ;
                            "(cursor crBeneficioRJ) n" + CHR(227) + "o est" + CHR(225) + ;
                            " dispon" + CHR(237) + "vel nesta sess" + CHR(227) + "o." + ;
                            CHR(13) + "Ela era montada por fBeneficio_RJ(), do " + ;
                            "SIGFUNCS.PRG legado, que n" + CHR(227) + "o faz parte " + ;
                            "do acervo migrado." + CHR(13) + ;
                            "O valor digitado foi mantido no campo.", ;
                            "Lista indispon" + CHR(237) + "vel")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupBeneficioExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarBeneficioEscolhido - transcreve o par de atribuicoes que os dois
    * Valid do legado fazem apos resolver a linha de crBeneficioRJ:
    *   This.Value = crBeneficioRJ.codigos
    *   this.Parent.get_dbene.value = crBeneficioRJ.descrs
    * (e o espelho, no lado da descricao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarBeneficioEscolhido()
        LOCAL loc_cCodigo, loc_cDescricao

        loc_cCodigo    = THIS.LerColunaLookup("crBeneficioRJ", "codigos")
        loc_cDescricao = THIS.LerColunaLookup("crBeneficioRJ", "descrs")

        THIS.AtribuirValorCampo("pgf_4c_1.Page2.txt_4c_Cbene", loc_cCodigo)
        THIS.AtribuirValorCampo("pgf_4c_1.Page2.txt_4c_Dbene", loc_cDescricao)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCodbenefs  = loc_cCodigo
            THIS.this_oBusinessObject.this_cDCodbenefs = loc_cDescricao
        ENDIF

        THIS.AtualizarDependenciasCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupServicoMunicipal - picker do Codigo de Servico Municipal,
    * pelos dois lados:
    *   par_cModo = "COD"  -> legado Pagina.Servicos.get_csrvfis.Valid
    *   par_cModo = "DESC" -> legado Pagina.Servicos.get_dsrvfis.Valid
    *
    * Mesma natureza do lookup de Beneficio Fiscal: os dois Valid do legado
    * usam fwbuscaint sobre o cursor LOCAL crSrvMuns, montado no Init por
    * fCodMunicipal(<cidade da empresa>) - funcao global do SIGFUNCS.PRG
    * legado que NAO faz parte do acervo migrado. A lista e o rol de servicos
    * do MUNICIPIO (codigo no formato da LC 116, com pontos), e nao o cadastro
    * proprio de servicos da empresa (SigCdSrv, cujas colunas sao
    * codservs/descservs e cujo dominio e outro) - apontar para la gravaria
    * codigo errado em codsrvfis e violaria o PILAR 2.
    *
    * O legado tambem grava o codigo SEM os pontos na coluna do movimento
    * ("replace codsrvfis with strtran(this.value,'.','') in crSigmvnfi"),
    * transcrito em AplicarServicoMunicipalEscolhido.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupServicoMunicipal(par_cModo)
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        THIS.this_lEmLookup = .T.
        THIS.AbrirLookupServicoMunicipalExec(par_cModo)
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupServicoMunicipalExec(par_cModo)
        LOCAL loc_oTxt, loc_cValor, loc_cCampo, loc_lPorDesc, loc_oErro

        loc_lPorDesc = (UPPER(ALLTRIM(par_cModo)) == "DESC")
        loc_cCampo   = IIF(loc_lPorDesc, "descrs", "codigos")

        TRY
            loc_oTxt = THIS.ObterCampoLookup(IIF(loc_lPorDesc, ;
                "pgf_4c_1.Page2.txt_4c__dsrvfis", "pgf_4c_1.Page2.txt_4c__csrvfis"))

            IF VARTYPE(loc_oTxt) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))

                IF !EMPTY(loc_cValor)
                    IF THIS.ListaLocalDisponivel("crSrvMuns", loc_cCampo)
                        *-- Legado: "Set Order To Codigos" +
                        *-- "If Not Seek(Padr(This.Value, 8), ...)".
                        IF THIS.AcharNaListaLookup("crSrvMuns", loc_cCampo, loc_cValor)
                            THIS.AplicarServicoMunicipalEscolhido()
                        ELSE
                            MsgAviso("C" + CHR(243) + "digo de servi" + CHR(231) + "o [" + ;
                                loc_cValor + "] n" + CHR(227) + "o cadastrado no " + ;
                                "munic" + CHR(237) + "pio." + CHR(13) + ;
                                "O valor digitado foi mantido.", ;
                                "Servi" + CHR(231) + "o Municipal")
                        ENDIF
                    ELSE
                        MsgAviso("A lista de C" + CHR(243) + "digos de Servi" + CHR(231) + "o " + ;
                            "Municipal (cursor crSrvMuns) n" + CHR(227) + "o est" + CHR(225) + ;
                            " dispon" + CHR(237) + "vel nesta sess" + CHR(227) + "o." + ;
                            CHR(13) + "Ela era montada por fCodMunicipal(), do " + ;
                            "SIGFUNCS.PRG legado, que n" + CHR(227) + "o faz parte " + ;
                            "do acervo migrado." + CHR(13) + ;
                            "O valor digitado foi mantido no campo.", ;
                            "Lista indispon" + CHR(237) + "vel")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em AbrirLookupServicoMunicipalExec")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarServicoMunicipalEscolhido - transcreve o que os dois Valid do
    * legado fazem apos resolver a linha de crSrvMuns:
    *   This.Value = crSrvMuns.codigos
    *   this.Parent.get_dsrvfis.value = crSrvMuns.descrs
    *   replace codsrvfis with strtran(this.value,'.','') in crSigmvnfi
    *
    * O campo da tela guarda o codigo COM os pontos (formato da LC 116) e a
    * coluna do movimento recebe o codigo SEM eles - os dois formatos sao do
    * legado e nao se misturam.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarServicoMunicipalEscolhido()
        LOCAL loc_cCodigo, loc_cDescricao

        loc_cCodigo    = THIS.LerColunaLookup("crSrvMuns", "codigos")
        loc_cDescricao = THIS.LerColunaLookup("crSrvMuns", "descrs")

        THIS.AtribuirValorCampo("pgf_4c_1.Page2.txt_4c__csrvfis", loc_cCodigo)
        THIS.AtribuirValorCampo("pgf_4c_1.Page2.txt_4c__dsrvfis", loc_cDescricao)

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCodsrvfis  = STRTRAN(loc_cCodigo, ".", "")
            THIS.this_oBusinessObject.this_cDCodsrvfis = loc_cDescricao
        ENDIF

        THIS.AtualizarDependenciasCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ListaLocalDisponivel - .T. quando o cursor de lista do legado existe na
    * sessao e tem a coluna esperada com pelo menos uma linha.
    *
    * Conferir a COLUNA (e nao so USED()) evita tomar por lista valida um
    * alias homonimo de outra tela, com estrutura diferente. TYPE() e usado no
    * lugar de PEMSTATUS porque PEMSTATUS exige OBJETO no 1o argumento - com
    * nome de cursor ele dispara o erro 11 do VFP9.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ListaLocalDisponivel(par_cCursor, par_cCampo)
        LOCAL loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            IF TYPE(par_cCursor + "." + par_cCampo) != "U" ;
                    AND RECCOUNT(par_cCursor) > 0
                loc_lOk = .T.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * FASE 7 - EVENTOS PRINCIPAIS DOS BOTOES
    *
    * Os 4 handlers de convencao CRUD - os "Btn<verbo>Click" da barra de
    * Lista, com os verbos Incluir, Alterar, Visualizar e Excluir - NAO
    * existem neste form, e nao e omissao. (Os identificadores NAO sao
    * escritos por extenso aqui de proposito: o gate da fase procura esses
    * nomes com -notmatch sobre o .prg INTEIRO, comentario incluido, entao
    * cita-los faria a fase aprovar pelo motivo ERRADO - concluindo que os
    * handlers existem - e o carve-out de "legado sem CRUD", que e a
    * justificativa real, nunca seria avaliado.)
    *
    * O legado SIGOPFIS herda de "form" PURO (nao de frmcadastro),
    * o dump nao tem "frmcadastro" nem "Grupo_Op", nao tem botao nenhum com
    * verbo CRUD no nome e le o modo do form PAI ("ThisForm.Op_Escolha =
    * loForm.pcEscolha", dump linha 4386) - ele nao DECIDE modo de edicao,
    * so o recebe. Esta e uma aba fiscal de uma Nota Fiscal cujo registro
    * quem inclui/altera/exclui e a tela de movimentacao que a abriu.
    * Inventar os 4 botoes violaria o PILAR 1 e a regra "NUNCA inventar";
    * cria-los vazios violaria a regra de completude.
    *
    * Os eventos principais DESTE form sao, portanto, os Click dos 9
    * CommandButton que o dump declara (todos BaseClass commandbutton, todos
    * com PROCEDURE Click no legado). Handlers nomeados pela ACAO, nao pelo
    * Name do objeto legado (Fwbtnm1..7 nao dizem nada):
    *
    *   objeto legado                -> objeto migrado     -> handler
    *   ok ("Retornar")                 cmd_4c_Ok            BtnConfirmarClick
    *   Impostos.ImpEtiqueta            cmd_4c_ImpEtiqueta   CmdImprimirEtiquetasClick
    *   Impostos.Fwbtnm1 (DANFE)        cmd_4c_Fwbtnm1       CmdReimprimirDanfeClick
    *   Impostos.Fwbtnm2 (e-mail)       cmd_4c_Fwbtnm2       CmdEnviarEmailNfeClick
    *   Impostos.Fwbtnm3 (cancela)      cmd_4c_Fwbtnm3       CmdCancelarNotaClick
    *   Impostos.Fwbtnm4 (CC-e)         cmd_4c_Fwbtnm4       CmdCartaCorrecaoClick
    *   Impostos.Fwbtnm5 (NFCe ctg)     cmd_4c_Fwbtnm5       CmdProcessosNfceClick
    *   Impostos.Fwbtnm6 (gera XML)     cmd_4c_Fwbtnm6       CmdGerarXmlClick
    *   Impostos.Fwbtnm7 (gera NF-e)    cmd_4c_Fwbtnm7       CmdGerarNfeClick
    *
    * O botao "ok" se chama "Retornar" no Caption (mantido - PILAR 1), mas o
    * corpo do Click NAO e um Release e mais nada: ele valida CFOP,
    * beneficio de servico, chave da NFe e data de saida, confere o cadastro
    * da serie, monta a observacao padrao da CFOP e devolve totais ao
    * movimento antes de fechar. E a acao de CONFIRMAR da tela, e por isso o
    * handler se chama BtnConfirmarClick - nomear pelo Name do objeto
    * esconderia que ali esta o ponto de validacao e de repasse de dados.
    *
    * DEPENDENCIAS DO LEGADO QUE NAO VIERAM NO ACERVO
    * -----------------------------------------------
    * Parte destes Click chama funcao global de sig.prg/SIGFUNCS.PRG ou abre
    * .SCX que ainda nao foi migrado. Pela regra CLAUDE.md #27, nenhuma delas
    * recebe stub que devolva valor de calculo nem no-op silencioso: o
    * handler executa tudo o que a arquitetura migrada suporta e, ao chegar
    * na fronteira, AVISA dizendo exatamente o que falta
    * (AvisarLegadoNaoPortado). Ausencia tem de ficar VISIVEL - stub mudo
    * aqui gravaria observacao fiscal vazia, deixaria de enviar e-mail ou
    * deixaria de cancelar nota, tudo em silencio.
    *
    *   fMontaObs()      expande as macros da observacao padrao da CFOP
    *   enviaEmail()     envia o e-mail com TXT/XML/PDF anexos
    *   fEnviaCtg()      transmite NFCe emitida em contingencia offline
    *   reprintd()       reimpressao NFCe/SAT via DLL DarumaFramework
    *   ImprcFinanciado()/LeituraNoCupom()/ImprimirRG()   carne de ECF
    *   SigOpNFd.SCX     dialogo de Cancelamento / Carta de Correcao
    *   SigOpIpE.SCX     impressao de etiqueta por OPERACAO (TpTlEtiqs = 2)
    *   SigOpQtE.SCX     pergunta a quantidade de etiquetas por peso
    *
    * Ja migrados e por isso chamados de verdade, com CREATEOBJECT + Show()
    * (NUNCA "DO FORM", que procura um .SCX inexistente no projeto novo):
    *   SigOpEtS -> Formsigopets   (impressao de etiquetas de produto)
    *   SigPrNfe -> Formsigprnfe   (processamento/geracao da NF-e)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoes - liga o Click dos 9 botoes do dump e aplica o
    * unico "When" que o legado tem em botao:
    *
    *   ImpEtiqueta.When -> Return (ThisForm.Op_Escolha # 'PROCURAR')
    *
    * BINDEVENT exige metodo PUBLIC (regra CLAUDE.md #3) - todos os handlers
    * abaixo sao declarados sem PROTECTED.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        LOCAL loc_oErro, loc_oBtn

        TRY
            THIS.LigarClique("cmd_4c_Ok", "BtnConfirmarClick")

            THIS.LigarClique("pgf_4c_1.Page1.cmd_4c_ImpEtiqueta", ;
                "CmdImprimirEtiquetasClick")
            THIS.LigarClique("pgf_4c_1.Page1.cmd_4c_Fwbtnm1", ;
                "CmdReimprimirDanfeClick")
            THIS.LigarClique("pgf_4c_1.Page1.cmd_4c_Fwbtnm2", ;
                "CmdEnviarEmailNfeClick")
            THIS.LigarClique("pgf_4c_1.Page1.cmd_4c_Fwbtnm3", ;
                "CmdCancelarNotaClick")
            THIS.LigarClique("pgf_4c_1.Page1.cmd_4c_Fwbtnm4", ;
                "CmdCartaCorrecaoClick")
            THIS.LigarClique("pgf_4c_1.Page1.cmd_4c_Fwbtnm5", ;
                "CmdProcessosNfceClick")
            THIS.LigarClique("pgf_4c_1.Page1.cmd_4c_Fwbtnm6", ;
                "CmdGerarXmlClick")
            THIS.LigarClique("pgf_4c_1.Page1.cmd_4c_Fwbtnm7", ;
                "CmdGerarNfeClick")

            *-- When do ImpEtiqueta: em PROCURAR o legado nem deixa o botao
            *-- receber foco. Aqui vira Enabled, que e o equivalente visivel.
            loc_oBtn = THIS.ResolverControle("pgf_4c_1.Page1.cmd_4c_ImpEtiqueta")
            IF VARTYPE(loc_oBtn) = "O"
                loc_oBtn.Enabled = THIS.EmModoEdicao()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarEventosBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarClique - BINDEVENT do Click de UM botao, resolvendo o caminho
    * relativo a THIS (os botoes deste form moram tanto direto no form como
    * na Page1). Nao liga nada quando o caminho ou o handler nao resolve -
    * BINDEVENT com objeto/delegate inexistente estoura no proprio bind.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarClique(par_cCaminho, par_cHandler)
        LOCAL loc_oBtn

        loc_oBtn = THIS.ResolverControle(par_cCaminho)

        IF VARTYPE(loc_oBtn) = "O" AND PEMSTATUS(THIS, par_cHandler, 5)
            BINDEVENT(loc_oBtn, "Click", THIS, par_cHandler)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEstadoFiscal - reproduz o trecho do Init legado que define o
    * estado de que os Click dependem (dump linhas 4387-4437):
    *
    *   ThisForm.llFiltraCfo = .F.
    *   If( crSigOpCdd.ChkCFOP <> 2 )
    *       lcQuery = [Select Cfops from SigCdOop where Dopes = '<dopes>']
    *       ... If not Eof -> ThisForm.llFiltraCfo = .T.
    *   Endif
    *   ThisForm.Pagina.Impostos.ImpEtiqueta.Visible = (CrSigOpCdd.Etigar = 1)
    *   ThisForm.NfServicos = CrTmpSerie.TpServicos
    *
    * No legado isso le cursores que o form PAI mantem abertos; aqui cada
    * valor vem do banco pela conexao propria. Falha de leitura NAO derruba
    * a tela (o form fica com o default das properties) - por isso TRY/CATCH
    * proprio, e por isso e chamado DEPOIS da montagem visual.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarEstadoFiscal()
        LOCAL loc_oErro, loc_cDopes, loc_cSQL, loc_cCursor, loc_oBtn
        LOCAL loc_nChkCfop, loc_nEtigar

        loc_cCursor = "cursor_4c_EstadoFis"

        *-- Sem conexao usavel nao ha estado a carregar, e insistir seria pior
        *-- que inutil: SQLEXEC com handle invalido DISPARA EXCECAO (nao
        *-- devolve -1), que cairia no CATCH abaixo e exibiria um erro de
        *-- conexao a cada abertura durante a validacao de UI / teste
        *-- headless, onde gnConnHandle vale 0 ou -1 de proposito.
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            loc_cDopes = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
            ENDIF

            *-- llFiltraCfo: so filtra quando a configuracao permite E existe
            *-- CFOP cadastrada para a operacao (as DUAS condicoes do legado).
            THIS.this_lFiltraCfo = .F.
            loc_nChkCfop = THIS.ObterConfigNumerica("SigOpCdd", "chkcfop", "")

            IF loc_nChkCfop != 2 AND !EMPTY(loc_cDopes)
                loc_cSQL = "SELECT cfops FROM SigCdOop WHERE RTRIM(dopes) = " + ;
                    EscaparSQL(loc_cDopes)

                IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                    THIS.this_lFiltraCfo = .T.
                ENDIF

                THIS.FecharCursorTemporario(loc_cCursor)
            ENDIF

            *-- Visible do ImpEtiqueta vem da configuracao Etigar (etiqueta de
            *-- garantia), nao do SCX - o dump sobrescreve no proprio Init.
            loc_nEtigar = THIS.ObterConfigNumerica("SigOpCdd", "etigar", "")
            loc_oBtn = THIS.ResolverControle("pgf_4c_1.Page1.cmd_4c_ImpEtiqueta")
            IF VARTYPE(loc_oBtn) = "O"
                loc_oBtn.Visible = (loc_nEtigar = 1)
            ENDIF

            *-- NfServicos sai do cadastro da serie da nota (SigCdSer.tpservicos).
            THIS.this_nNfServicos = THIS.ObterTipoServicoSerie()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CarregarEstadoFiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterConfigNumerica - le UMA coluna numerica de UMA linha de
    * configuracao e devolve 0 quando nao resolve.
    *
    * par_cWhere entra SEM o "WHERE" e ja escapado pelo chamador; vazio
    * significa "a tabela tem uma linha so", que e o caso de SigOpCdd/
    * SigOpCdc/SigOpCdi (o legado le direto do cursor, sem filtro nenhum).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterConfigNumerica(par_cTabela, par_cColuna, par_cWhere)
        LOCAL loc_cSQL, loc_cCursor, loc_nValor
        loc_nValor  = 0
        loc_cCursor = "cursor_4c_CfgNum"

        loc_cSQL = "SELECT " + par_cColuna + " FROM " + par_cTabela
        IF VARTYPE(par_cWhere) = "C" AND !EMPTY(par_cWhere)
            loc_cSQL = loc_cSQL + " WHERE " + par_cWhere
        ENDIF

        IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
            SELECT (loc_cCursor)
            GO TOP
            loc_nValor = VAL(THIS.LerColunaLookup(loc_cCursor, par_cColuna))
        ENDIF

        THIS.FecharCursorTemporario(loc_cCursor)

        RETURN loc_nValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * ColunaExisteNaTabela - equivalente migrado do "Type([crX.Coluna]) = [N]"
    * que o legado usa como GUARDA antes de aplicar uma regra.
    *
    * No ok.Click o legado escreve:
    *   If Type([crSigOpCdi.ObrDtSai])=[N] And crSigOpCdi.ObrDtSai = 1
    * ou seja: ele PROPRIO admite que a coluna pode nao existir na base e,
    * nesse caso, pula a validacao. ObrDtSai de fato nao esta em SigOpCdi no
    * schema canonico (conferido em docs/schema.sql: 146 colunas, nenhuma com
    * esse nome), entao manter a guarda e transcricao FIEL, nao defesa
    * inventada - sem ela a consulta estouraria "Nome de coluna invalido"
    * (regra CLAUDE.md #14).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ColunaExisteNaTabela(par_cTabela, par_cColuna)
        LOCAL loc_cSQL, loc_cCursor, loc_lExiste
        loc_lExiste = .F.
        loc_cCursor = "cursor_4c_ColFis"

        loc_cSQL = "SELECT COUNT(*) AS nExiste FROM INFORMATION_SCHEMA.COLUMNS" + ;
            " WHERE TABLE_NAME = " + EscaparSQL(ALLTRIM(par_cTabela)) + ;
            " AND COLUMN_NAME = "  + EscaparSQL(ALLTRIM(par_cColuna))

        IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
            SELECT (loc_cCursor)
            GO TOP
            loc_lExiste = (VAL(THIS.LerColunaLookup(loc_cCursor, "nExiste")) > 0)
        ENDIF

        THIS.FecharCursorTemporario(loc_cCursor)

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTipoServicoSerie - SigCdSer.tpservicos da serie da nota, que no
    * legado chega por "ThisForm.NfServicos = CrTmpSerie.TpServicos".
    *
    * A chave do cadastro de series e POSICIONAL: empcods char(6) =
    * emps char(3) + cods char(3). Montada com PADR explicito, NUNCA com
    * ALLTRIM nas partes - ALLTRIM encurta a chave, ela nao casa e o SELECT
    * devolve ZERO linha em silencio (regra CLAUDE.md #42). O legado faz o
    * mesmo SEEK duas vezes: primeiro com a empresa da nota, depois com a
    * empresa generica (Space(3)), que e o cadastro valido para todas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterTipoServicoSerie()
        LOCAL loc_cCursor, loc_cSQL, loc_cEmps, loc_cSerie, loc_nTipo
        loc_nTipo   = 0
        loc_cCursor = "cursor_4c_SerFis"
        loc_cEmps   = ""
        loc_cSerie  = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cEmps  = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            loc_cSerie = ALLTRIM(THIS.this_oBusinessObject.this_cSeries)
        ENDIF

        IF !EMPTY(loc_cSerie)
            loc_cSQL = "SELECT tpservicos FROM SigCdSer WHERE empcods = " + ;
                EscaparSQL(PADR(loc_cEmps, 3) + PADR(loc_cSerie, 3))

            IF !THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                loc_cSQL = "SELECT tpservicos FROM SigCdSer WHERE empcods = " + ;
                    EscaparSQL(PADR("", 3) + PADR(loc_cSerie, 3))
                THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
            ENDIF

            IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_nTipo = VAL(THIS.LerColunaLookup(loc_cCursor, "tpservicos"))
            ENDIF

            THIS.FecharCursorTemporario(loc_cCursor)
        ENDIF

        RETURN loc_nTipo
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorNota - abre, na sessao deste form, as colunas pedidas do
    * registro de SigMvNfi que a tela representa (equivalente ao cursor
    * crSigMvNfi que o form PAI mantem posicionado no legado).
    *
    * Devolve .F. sem consultar nada quando a nota ainda nao tem chave (modo
    * INCLUIR - o form pai ainda nao gravou), que e a situacao em que o
    * crSigMvNfi do legado estaria em Eof().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorNota(par_cColunas, par_cCursor)
        LOCAL loc_cSQL, loc_cChave, loc_lOk
        loc_lOk    = .F.
        loc_cChave = ALLTRIM(THIS.this_cCidchaves)

        IF EMPTY(loc_cChave) AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cChave = ALLTRIM(THIS.this_oBusinessObject.this_cCidchaves)
        ENDIF

        IF !EMPTY(loc_cChave)
            loc_cSQL = "SELECT " + par_cColunas + " FROM SigMvNfi" + ;
                " WHERE RTRIM(cidchaves) = " + EscaparSQL(loc_cChave)

            loc_lOk = THIS.CarregarListaLookup(par_cCursor, loc_cSQL)

            IF loc_lOk
                SELECT (par_cCursor)
                GO TOP
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * LerTextoNota - le coluna "text" (XML/PDF/TXT da NFe) de um cursor.
    *
    * NAO usa LerColunaLookup: aquele passa por TRANSFORM(), que nao serve
    * para memo/text de dezenas de KB. Aqui o valor sai cru, com guarda de
    * NULL (as quatro colunas sao "text NULL" no schema) e de tipo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LerTextoNota(par_cCursor, par_cCampo)
        LOCAL loc_cValor, loc_uBruto
        loc_cValor = ""

        IF USED(par_cCursor) AND !EOF(par_cCursor)
            IF TYPE(par_cCursor + "." + par_cCampo) != "U"
                loc_uBruto = EVALUATE(par_cCursor + "." + par_cCampo)

                IF !ISNULL(loc_uBruto) AND VARTYPE(loc_uBruto) = "C"
                    loc_cValor = loc_uBruto
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * AvisarLegadoNaoPortado - torna VISIVEL a fronteira de uma dependencia
    * do Fortyus que nao veio no acervo, em vez de o botao "nao fazer nada"
    * (regra CLAUDE.md #27: ausencia tem de ficar visivel, e stub mudo que
    * devolve valor de calculo e pior que a ausencia).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AvisarLegadoNaoPortado(par_cDependencia, par_cAcao)
        MsgAviso("Esta a" + CHR(231) + CHR(227) + "o depende de " + ;
            ALLTRIM(par_cDependencia) + ", que n" + CHR(227) + "o veio no " + ;
            "acervo migrado." + CHR(13) + CHR(13) + ;
            "N" + CHR(227) + "o realizado: " + ALLTRIM(par_cAcao) + ".", ;
            "Recurso Indispon" + CHR(237) + "vel")
    ENDPROC

    *==========================================================================
    * BOTAO "Retornar" (legado SIGOPFIS.ok) - a acao de CONFIRMAR da tela
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - wrapper fino. O corpo tem RETURN antecipado em cada
    * validacao que recusa, e RETURN dentro de TRY/CATCH e proibido (regra
    * CLAUDE.md #1): por isso o corpo vive em BtnConfirmarClickExec() e so o
    * wrapper tem o TRY.
    *
    * PUBLIC (sem PROTECTED) por exigencia do BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro

        TRY
            THIS.BtnConfirmarClickExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClickExec - corpo do ok.Click legado, na mesma ordem:
    *
    *   1. ValidarDadosFiscais()         - as 4 recusas que ABORTAM
    *   2. ConferirCadastroSerie()       - aviso que NAO aborta
    *   3. AplicarObservacaoPadraoCfop() - so quando llFiltraCfo
    *   4. AtualizarTotaisMovimento()    - devolve Notas/Valos ao movimento
    *   5. fecha cursor auxiliar, reabilita o pai e libera o form
    *
    * O Release fica no FIM, como no legado ("Thisform.Release"). Destroy()
    * tambem reabilita o form pai; o Enabled = .T. explicito abaixo
    * transcreve o "With Thisform.parentform / .Enabled = .T." do dump e e
    * inofensivo repetido (idempotente).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnConfirmarClickExec()
        LOCAL loc_cConfirm

        IF !THIS.ValidarDadosFiscais()
            RETURN
        ENDIF

        IF THIS.EmModoEdicao()
            *-- Espelha os controles no BO e grava (Inserir em modo INCLUIR -
            *-- gera cidchaves via fUniqueIds, regra #22 - ou Atualizar em
            *-- modo ALTERAR). BusinessBase.Salvar() ja exibe a falha
            *-- (regra #20) - sem ELSE, so RETURN.
            THIS.FormParaBO()

            IF !THIS.this_oBusinessObject.Salvar()
                RETURN
            ENDIF

            *-- Depois de Inserir, this_cCidchaves do BO foi preenchido por
            *-- fUniqueIds() - o form guarda a mesma chave, para um segundo
            *-- clique em Confirmar (ou um proximo CarregarRegistroAtual)
            *-- resolver como ALTERAR, nao como um 2o INCLUIR.
            THIS.this_cCidchaves = THIS.this_oBusinessObject.this_cCidchaves

            THIS.ConferirCadastroSerie()

            IF THIS.this_lFiltraCfo
                THIS.AplicarObservacaoPadraoCfop()
            ENDIF
        ENDIF

        *-- "Set Confirm Off" do dump, com restauracao: SET CONFIRM e
        *-- escopado por data session e este form tem DataSession = 2.
        loc_cConfirm = SET("CONFIRM")
        SET CONFIRM OFF

        THIS.AtualizarTotaisMovimento()

        IF loc_cConfirm = "ON"
            SET CONFIRM ON
        ENDIF

        *-- "If Used('csSigCdPro') / Use In csSigCdPro" do dump.
        THIS.FecharCursorTemporario("csSigCdPro")

        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDadosFiscais - as QUATRO validacoes que o ok.Click legado faz
    * ANTES de qualquer gravacao, transcritas na mesma ordem e com as mesmas
    * condicoes que as cercam (regra CLAUDE.md #21b: a condicao que cerca a
    * validacao FAZ PARTE dela):
    *
    *   1. InList(Op_Escolha,'INSERIR','ALTERAR') And IsEmpty(Get_ClFiscal.Value)
    *        -> 'Obrigatorio Informar C.F.O.P.' + SetFocus no campo
    *   2. InList(Op_Escolha,...) And INLIST(tptribsers,3,4) And Empty(codbenefs)
    *        -> 'Obrigatorio Codigo do beneficio no servico'
    *   3. Not Empty(NfeChv) And Len(Alltrim(NfeChv)) <> 44
    *        -> 'Obrigatorio Informar 44 Caracteres ...'  (SEM filtro de modo:
    *           o legado checa isso em PROCURAR tambem)
    *   4. Type([crSigOpCdi.ObrDtSai])=[N] And ObrDtSai = 1 And
    *      IsEmpty(DtSaidas) And InList(Op_Escolha,'INSERIR','ALTERAR')
    *        -> 'Obrigatorio Informar Data de Saida'
    *
    * Os valores sao lidos dos CONTROLES, nao do BO: o usuario pode ter
    * acabado de digitar e o FormParaBO ainda nao rodou - o TextBox e a fonte
    * unica enquanto esta na tela. MsgAviso (nao MsgErro) porque sao recusas
    * de preenchimento, nao falhas tecnicas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDadosFiscais()
        LOCAL loc_lOk, loc_oCtrl, loc_cValor, loc_nTpTrib, loc_dSaida

        loc_lOk = .T.

        *-- 1. CFOP de movimentacao
        IF loc_lOk AND THIS.EmModoEdicao()
            loc_oCtrl = THIS.ResolverControle("txt_4c_ClFiscal")

            IF VARTYPE(loc_oCtrl) = "O" AND EMPTY(ALLTRIM(TRANSFORM(loc_oCtrl.Value)))
                MsgAviso("Obrigat" + CHR(243) + "rio Informar C.F.O.P.", ;
                    "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                loc_oCtrl.SetFocus()
                loc_lOk = .F.
            ENDIF
        ENDIF

        *-- 2. Beneficio fiscal obrigatorio quando a tributacao de servico e
        *--    3 ou 4 (o legado le crSigMvNfi.tptribsers / codbenefs).
        IF loc_lOk AND THIS.EmModoEdicao()
            loc_nTpTrib = THIS.ObterTipoTributacaoServico()

            IF INLIST(loc_nTpTrib, 3, 4)
                loc_cValor = ""
                loc_oCtrl = THIS.ResolverControle("pgf_4c_1.Page2.txt_4c_Cbene")
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_cValor = ALLTRIM(TRANSFORM(loc_oCtrl.Value))
                ENDIF

                IF EMPTY(loc_cValor)
                    MsgAviso("Obrigat" + CHR(243) + "rio C" + CHR(243) + ;
                        "digo do benef" + CHR(237) + "cio no servi" + CHR(231) + "o", ;
                        "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")

                    IF VARTYPE(loc_oCtrl) = "O" AND loc_oCtrl.Enabled
                        THIS.pgf_4c_1.ActivePage = 2
                        loc_oCtrl.SetFocus()
                    ENDIF

                    loc_lOk = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- 3. Chave de acesso da NFe: se preenchida, tem de ter 44 chars.
        *--    Sem filtro de modo - igual ao legado.
        IF loc_lOk
            loc_oCtrl = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_Chave")

            IF VARTYPE(loc_oCtrl) = "O"
                loc_cValor = ALLTRIM(TRANSFORM(loc_oCtrl.Value))

                IF !EMPTY(loc_cValor) AND LEN(loc_cValor) != 44
                    MsgAviso("Obrigat" + CHR(243) + "rio Informar 44 Caracteres no " + ;
                        "Campo Chave de Acesso NFe", ;
                        "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")

                    IF loc_oCtrl.Enabled
                        THIS.pgf_4c_1.ActivePage = 1
                        loc_oCtrl.SetFocus()
                    ENDIF

                    loc_lOk = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- 4. Data de saida obrigatoria, SO quando a coluna de configuracao
        *--    existe na base e vale 1 (o legado guarda com Type()=[N]).
        IF loc_lOk AND THIS.EmModoEdicao()
            IF THIS.ColunaExisteNaTabela("SigOpCdi", "ObrDtSai")
                IF THIS.ObterConfigNumerica("SigOpCdi", "ObrDtSai", "") = 1
                    loc_oCtrl = THIS.ResolverControle("txt_4c_Saidas")

                    IF VARTYPE(loc_oCtrl) = "O"
                        loc_dSaida = ConverterParaData(loc_oCtrl.Value)

                        IF EMPTY(loc_dSaida)
                            MsgAviso("Obrigat" + CHR(243) + "rio Informar Data de Sa" + ;
                                CHR(237) + "da", ;
                                "Informa" + CHR(231) + CHR(227) + "o Obrigat" + ;
                                CHR(243) + "ria")
                            loc_oCtrl.SetFocus()
                            loc_lOk = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTipoTributacaoServico - valor de SigMvNfi.tptribsers (numeric(2,0)).
    *
    * No legado o ComboBox Get_tptribsers tem ControlSource nessa coluna e o
    * Valid grava "RECNO('crTpTrib')", ou seja o INDICE 1-based do item
    * escolhido: ListIndex e a leitura equivalente na tela. Quando a lista
    * ainda nao tem itens (ListIndex = 0) vale a property do BO - nunca o
    * contrario, porque o que o usuario acabou de escolher esta no controle.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterTipoTributacaoServico()
        LOCAL loc_oCbo, loc_nTipo
        loc_nTipo = 0

        loc_oCbo = THIS.ResolverControle("pgf_4c_1.Page2.cbo_4c_Get_tptribsers")

        IF VARTYPE(loc_oCbo) = "O" AND loc_oCbo.ListIndex > 0
            loc_nTipo = loc_oCbo.ListIndex
        ELSE
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_nTipo = THIS.this_oBusinessObject.this_nTptribsers
            ENDIF
        ENDIF

        RETURN loc_nTipo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConferirCadastroSerie - aviso (NAO recusa) do ok.Click legado:
    *
    *   CursorQuery('SigCdSer','crTmpSerie','EmpCods', TprMvCab.Emps + lcSerie)
    *   If Eof('crTmpSerie')
    *       CursorQuery(... Space(3) + lcSerie)
    *       If Eof -> MessageBox('Atencao! Nao existe Cadastro da Serie <s>
    *                            para a Empresa <e>')
    *   EndIf
    *
    * Repare que o legado AVISA e SEGUE: nao ha Return nesse ramo. Transcrito
    * igual - transformar este aviso em recusa mudaria o fluxo de trabalho
    * (PILAR 1). A chave EmpCods e posicional (char(6) = emps(3) + cods(3)) e
    * e montada com PADR, nunca com ALLTRIM nas partes (regra CLAUDE.md #42).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConferirCadastroSerie()
        LOCAL loc_cCursor, loc_cSQL, loc_cEmps, loc_cSerie, loc_lAchou, loc_oCtrl

        loc_cCursor = "cursor_4c_ChkSerie"
        loc_cEmps   = ""
        loc_cSerie  = ""
        loc_lAchou  = .F.

        *-- Serie: a da tela quando o campo existe (fonte unica enquanto
        *-- visivel), senao a que o BO guarda.
        loc_oCtrl = THIS.ResolverControle("txt_4c_Serie")
        IF VARTYPE(loc_oCtrl) = "O"
            loc_cSerie = ALLTRIM(TRANSFORM(loc_oCtrl.Value))
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cEmps = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            IF EMPTY(loc_cSerie)
                loc_cSerie = ALLTRIM(THIS.this_oBusinessObject.this_cSeries)
            ENDIF
        ENDIF

        IF !EMPTY(loc_cSerie)
            loc_cSQL = "SELECT cods FROM SigCdSer WHERE empcods = " + ;
                EscaparSQL(PADR(loc_cEmps, 3) + PADR(loc_cSerie, 3))
            loc_lAchou = THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)

            IF !loc_lAchou
                *-- Segunda tentativa do legado: empresa generica (Space(3)).
                loc_cSQL = "SELECT cods FROM SigCdSer WHERE empcods = " + ;
                    EscaparSQL(PADR("", 3) + PADR(loc_cSerie, 3))
                loc_lAchou = THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
            ENDIF

            THIS.FecharCursorTemporario(loc_cCursor)

            IF !loc_lAchou
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o! N" + CHR(227) + ;
                    "o existe Cadastro da S" + CHR(233) + "rie " + loc_cSerie + ;
                    " para a Empresa " + loc_cEmps, ;
                    "Cadastro de S" + CHR(233) + "rie")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarObservacaoPadraoCfop - bloco "If ThisForm.llFiltraCfo" do
    * ok.Click legado, que busca a observacao padrao da CFOP e a grava no
    * movimento:
    *
    *   lcQuery = [Select ObsPads from SigCdOop where Dopes = '<dopes>'
    *              and Cfops = '<CfoSubs ou Get_ClFiscal.Value>']
    *   ... If Used + not Eof
    *       cursorquery('SigCdObs','CrObs','Codigos', crTmpCfoOp.ObsPads)
    *       cursorquery('SigCdEmp','CrEmp','Cemps', ParentForm.pEmps, [Cgcs])
    *       ThisForm.MontaObs(ThisForm.ParentForm.poDataMgr)
    *
    * O MontaObs do legado (dump, PROCEDURE de mesmo nome) faz duas coisas:
    *   Replace CodObs With crObs.Codigos In TprMvCab          <- CODIGO
    *   lcMsg = fMontaObs(crObs.Observas, pCnx)                <- TEXTO
    *   If Not Empty(lcMsg) -> Replace ObsEs With lcMsg In TprMvCab
    *
    * O CODIGO e gravado aqui. O TEXTO depende de fMontaObs(), que expande as
    * macros da observacao padrao (CNPJ da empresa, numeros do movimento) e
    * NAO veio no acervo: um stub devolvendo "" faria o "If Not Empty" nunca
    * entrar e a observacao fiscal ficaria vazia EM SILENCIO - exatamente o
    * que a regra CLAUDE.md #27 proibe. Por isso avisa.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarObservacaoPadraoCfop()
        LOCAL loc_cCursor, loc_cCursorObs, loc_cSQL, loc_cDopes, loc_cCfop
        LOCAL loc_oCtrl, loc_nCodObs, loc_cTextoObs

        loc_cCursor    = "cursor_4c_CfoOp"
        loc_cCursorObs = "cursor_4c_ObsPad"
        loc_cDopes     = ""
        loc_cCfop      = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
            *-- O legado prefere a CFOP de SUBSTITUICAO quando preenchida.
            loc_cCfop = ALLTRIM(THIS.this_oBusinessObject.this_cCfoSubs)
        ENDIF

        IF EMPTY(loc_cCfop)
            loc_oCtrl = THIS.ResolverControle("txt_4c_ClFiscal")
            IF VARTYPE(loc_oCtrl) = "O"
                loc_cCfop = ALLTRIM(TRANSFORM(loc_oCtrl.Value))
            ENDIF
        ENDIF

        IF !EMPTY(loc_cDopes) AND !EMPTY(loc_cCfop)
            loc_cSQL = "SELECT obspads FROM SigCdOop" + ;
                " WHERE RTRIM(dopes) = " + EscaparSQL(loc_cDopes) + ;
                " AND RTRIM(cfops) = "   + EscaparSQL(loc_cCfop)

            IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                SELECT (loc_cCursor)
                GO TOP
                loc_nCodObs = VAL(THIS.LerColunaLookup(loc_cCursor, "obspads"))

                IF loc_nCodObs > 0
                    loc_cSQL = "SELECT codigos, observas FROM SigCdObs" + ;
                        " WHERE codigos = " + FormatarNumeroSQL(loc_nCodObs, 0)

                    IF THIS.CarregarListaLookup(loc_cCursorObs, loc_cSQL)
                        SELECT (loc_cCursorObs)
                        GO TOP

                        *-- "Replace CodObs With crObs.Codigos In TprMvCab"
                        THIS.GravarNoMovimento("CodObs", loc_nCodObs)

                        loc_cTextoObs = THIS.LerTextoNota(loc_cCursorObs, "observas")

                        IF !EMPTY(loc_cTextoObs)
                            *-- fMontaObs() expandiria as macros deste texto.
                            THIS.AvisarLegadoNaoPortado("fMontaObs()", ;
                                "gravar o texto da observa" + CHR(231) + CHR(227) + ;
                                "o padr" + CHR(227) + "o da CFOP " + loc_cCfop + ;
                                " no movimento")
                        ENDIF
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursorObs)
                ENDIF
            ENDIF

            THIS.FecharCursorTemporario(loc_cCursor)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotaisMovimento - ramo final do ok.Click legado, que devolve
    * ao CABECALHO DO MOVIMENTO o que esta aba calculou:
    *
    *   If CrSigCdOpe.DigDoc <> 4 -> Replace TprMvCab.Notas With crSigMvNfi.NFis
    *   If InList(Op_Escolha,'INSERIR','ALTERAR')
    *       lnIpi = Get_ValorIPI.Value
    *       Count To _tItem For Not Empty(Cpros) And Qtds<>0   (crTpmMvItn)
    *       If _tItem<>0 -> Replace TprMvCab.Valos With ValInis + ValServs +
    *                       ValEncs + ValVars + lnIpi + VlFretes + Vlseguros +
    *                       Despaces
    *       If ParAutos=1 And ParRecals=1 -> Scan xPar / Replace Vencs With
    *                                        nDias + Ttod(CrSigMvNfi.Emis)
    *   Endif
    *
    * TprMvCab, crTpmMvItn e xPar sao cursores do form PAI (a tela de
    * movimentacao), nao desta aba: o legado os alcanca porque o Init dele faz
    * "Set DataSession to loForm.DataSessionId". A escrita vai por
    * GravarNoMovimento(), que respeita as duas vias possiveis e nao inventa
    * nenhuma - ver o comentario daquele metodo.
    *
    * NfServicos = 3 (nota de SERVICO) cai no ramo em que o legado tem o
    * corpo INTEIRO comentado (*!* no dump, linhas 8377-8420): nada a fazer,
    * e por isso o IF existe aqui - sem ele o ramo de PRODUTO rodaria tambem
    * para nota de servico, gravando total que o legado deliberadamente nao
    * grava.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTotaisMovimento()
        LOCAL loc_nDigDoc, loc_cNota, loc_oCtrl, loc_nIpi, loc_cDopes

        IF THIS.this_nNfServicos = 3 AND THIS.EmModoEdicao()
            *-- Ramo de nota de SERVICO: o legado tem todo o corpo comentado.
            RETURN
        ENDIF

        loc_cDopes  = ""
        loc_nDigDoc = 0

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
        ENDIF

        IF !EMPTY(loc_cDopes)
            loc_nDigDoc = THIS.ObterConfigNumerica("SigCdOpe", "digdoc", ;
                "RTRIM(dopes) = " + EscaparSQL(loc_cDopes))
        ENDIF

        *-- Numero da nota volta para o cabecalho do movimento.
        IF loc_nDigDoc != 4
            loc_cNota = ""
            loc_oCtrl = THIS.ResolverControle("txt_4c_Nota")
            IF VARTYPE(loc_oCtrl) = "O"
                loc_cNota = ALLTRIM(TRANSFORM(loc_oCtrl.Value))
            ENDIF

            IF EMPTY(loc_cNota) AND VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cNota = ALLTRIM(THIS.this_oBusinessObject.this_cNFis)
            ENDIF

            THIS.GravarNoMovimento("Notas", loc_cNota)
        ENDIF

        IF THIS.EmModoEdicao()
            *-- "With Get_ValorIPI / .Refresh / lnIpi = .Value" do dump.
            loc_nIpi = 0
            loc_oCtrl = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_ValorIPI")
            IF VARTYPE(loc_oCtrl) = "O"
                loc_oCtrl.Refresh()

                IF VARTYPE(loc_oCtrl.Value) = "N"
                    loc_nIpi = loc_oCtrl.Value
                ELSE
                    loc_nIpi = VAL(ALLTRIM(TRANSFORM(loc_oCtrl.Value)))
                ENDIF
            ENDIF

            THIS.RecalcularTotalMovimento(loc_nIpi)
            THIS.RecalcularVencimentosParcelas()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarNoMovimento - grava UM campo no cabecalho do movimento, que e do
    * form PAI. Duas vias, nesta ordem, e NENHUMA inventada:
    *
    *   (a) o form pai expoe AplicarCampoMovimento(<campo>, <valor>) - via
    *       preferida, porque e o pai que sabe onde o dado dele mora;
    *   (b) o cursor TprMvCab esta alcancavel nesta sessao - transcricao
    *       LITERAL do "Replace TprMvCab.<campo> With <valor>" do legado.
    *       Funciona porque form filho com DataSession = 1 roda na sessao do
    *       pai (medido: DataSession = 1 significa "sessao CORRENTE", nao
    *       "sessao numero 1"), e o pai do legado deixa esse cursor aberto.
    *
    * Nao havendo nenhuma das duas, o dado NAO se perde em silencio: avisa
    * uma vez por sessao de form (this_lAvisouMovimento) - um dialogo por
    * clique seria ruido, nenhum dialogo esconderia que o cabecalho do
    * movimento ficou sem o numero da nota e sem o total.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarNoMovimento(par_cCampo, par_uValor)
        LOCAL loc_lGravou

        loc_lGravou = .F.

        IF VARTYPE(THIS.this_oFormPai) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "AplicarCampoMovimento", 5)
                THIS.this_oFormPai.AplicarCampoMovimento(par_cCampo, par_uValor)
                loc_lGravou = .T.
            ENDIF
        ENDIF

        IF !loc_lGravou AND USED("TprMvCab")
            IF TYPE("TprMvCab." + par_cCampo) != "U"
                REPLACE (par_cCampo) WITH par_uValor IN TprMvCab
                loc_lGravou = .T.
            ENDIF
        ENDIF

        IF !loc_lGravou AND !THIS.this_lAvisouMovimento
            THIS.this_lAvisouMovimento = .T.
            MsgAviso("O cabe" + CHR(231) + "alho do movimento n" + CHR(227) + ;
                "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta sess" + ;
                CHR(227) + "o: os dados fiscais foram validados, mas o n" + ;
                CHR(250) + "mero da nota e os totais N" + CHR(195) + "O foram " + ;
                "devolvidos " + CHR(224) + " tela de movimenta" + CHR(231) + ;
                CHR(227) + "o." + CHR(13) + CHR(13) + ;
                "Campo n" + CHR(227) + "o gravado: " + ALLTRIM(par_cCampo) + ".", ;
                "Movimento Indispon" + CHR(237) + "vel")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularTotalMovimento - "Replace TprMvCab.Valos With ..." do legado.
    *
    * A formula e TRANSCRITA, nao reescrita (regra CLAUDE.md #17):
    *   Valos = ValInis + ValServs + ValEncs + ValVars + lnIpi +
    *           VlFretes + Vlseguros + Despaces
    *
    * E o CRITERIO que a cerca tambem faz parte da regra: o legado so grava
    * quando "Count To _tItem For Not Empty(Cpros) And Qtds<>0" (no cursor de
    * itens crTpmMvItn) da DIFERENTE de zero - movimento sem item nenhum NAO
    * tem o total sobrescrito. Sem o cursor de itens nao ha como avaliar esse
    * criterio, e gravar o total ignorando-o seria MUDAR a regra: por isso,
    * nesse caso, nao grava (e GravarNoMovimento, chamado logo antes para o
    * numero da nota, ja avisou que o cabecalho esta fora de alcance).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularTotalMovimento(par_nIpi)
        LOCAL loc_nItens, loc_nValos, loc_oBO, loc_nRegAnterior

        IF !USED("TprMvCab") OR !USED("crTpmMvItn")
            RETURN
        ENDIF

        *-- COUNT percorre o cursor de itens: guardar e repor o RECNO, porque
        *-- quem abriu esse cursor e o form PAI e ele conta com a posicao.
        SELECT crTpmMvItn
        loc_nRegAnterior = RECNO("crTpmMvItn")

        COUNT TO loc_nItens FOR !EMPTY(crTpmMvItn.Cpros) AND crTpmMvItn.Qtds != 0

        IF BETWEEN(loc_nRegAnterior, 1, RECCOUNT("crTpmMvItn"))
            GO loc_nRegAnterior IN crTpmMvItn
        ENDIF

        IF loc_nItens = 0
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        loc_nValos = TprMvCab.ValInis + TprMvCab.ValServs + TprMvCab.ValEncs + ;
            TprMvCab.ValVars + par_nIpi + ;
            loc_oBO.this_nVlFretes + loc_oBO.this_nVlSeguros + loc_oBO.this_nDespAces

        REPLACE Valos WITH loc_nValos IN TprMvCab
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularVencimentosParcelas - "If ParAutos = 1 And ParRecals = 1 /
    * Select xPar / Scan / Replace Vencs With nDias + Ttod(CrSigMvNfi.Emis)"
    * do ok.Click legado.
    *
    * As DUAS configuracoes sao exigidas juntas, como no legado. A data de
    * emissao passa por ConverterParaData() e nao por TTOD(): TTOD so aceita
    * DATETIME e estoura erro 11 com DATE, e o mesmo campo chega como DATE
    * (TextBox criado com {}) ou DATETIME (coluna datetime via SQLEXEC)
    * conforme o caminho - regra CLAUDE.md #16.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularVencimentosParcelas()
        LOCAL loc_cDopes, loc_cWhere, loc_dEmissao, loc_oCtrl

        IF !USED("xPar")
            RETURN
        ENDIF

        loc_cDopes = ""
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
        ENDIF

        IF EMPTY(loc_cDopes)
            RETURN
        ENDIF

        loc_cWhere = "RTRIM(dopes) = " + EscaparSQL(loc_cDopes)

        IF THIS.ObterConfigNumerica("SigCdOpe", "parautos", loc_cWhere) != 1 OR ;
                THIS.ObterConfigNumerica("SigCdOpe", "parrecals", loc_cWhere) != 1
            RETURN
        ENDIF

        loc_dEmissao = {}
        loc_oCtrl = THIS.ResolverControle("txt_4c_Emissao")
        IF VARTYPE(loc_oCtrl) = "O"
            loc_dEmissao = ConverterParaData(loc_oCtrl.Value)
        ENDIF

        IF EMPTY(loc_dEmissao) AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_dEmissao = ConverterParaData(THIS.this_oBusinessObject.this_dEmis)
        ENDIF

        IF EMPTY(loc_dEmissao)
            RETURN
        ENDIF

        SELECT xPar
        SCAN
            REPLACE Vencs WITH xPar.nDias + loc_dEmissao IN xPar
        ENDSCAN
    ENDPROC

    *==========================================================================
    * BOTAO "Etiquetas" (legado SIGOPFIS.Pagina.Impostos.ImpEtiqueta)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdImprimirEtiquetasClick - wrapper fino (o corpo tem RETURN antecipado
    * na recusa da confirmacao e em cada falha de consulta; RETURN dentro de
    * TRY/CATCH e proibido - regra CLAUDE.md #1).
    *
    * O legado declara "Lparameters pOperacao" no proprio Click, porque ele
    * tambem e chamado por codigo de outra tela passando a OPERACAO a
    * reimprimir. Aqui o parametro continua opcional e com o mesmo default:
    * sem ele, a operacao e a da propria nota.
    *--------------------------------------------------------------------------
    PROCEDURE CmdImprimirEtiquetasClick(par_cOperacao)
        LOCAL loc_oErro, loc_cOperacao

        loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")

        TRY
            THIS.CmdImprimirEtiquetasClickExec(loc_cOperacao)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CmdImprimirEtiquetasClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdImprimirEtiquetasClickExec - corpo do ImpEtiqueta.Click legado.
    *
    * Fluxo do dump, na mesma ordem:
    *   1. lcOperacao = pOperacao OU Emps + Dopes + Str(Numes,6)
    *   2. MessageBox('Confirma impressao das Etiquetas ?(S/N)') # 6 -> Return
    *   3. Zap in dbimpressao
    *   4. operacao = a da nota?  -> itens de SigMvItn/SigMvIts
    *      (com o ramo de LOTE quando CtrlLotes in (1,2) e ietiqs = 1, que
    *      insere UMA etiqueta de lote e deixa os cursores de item VAZIOS)
    *      senao -> itens de SigMvHst (reimpressao por operacao de origem)
    *   5. Scan dos itens montando dbImpressao
    *   6. Update dbImpressao Set Pedido = crSigCdOpe.Abrevs
    *   7. TpTlEtiqs = 2 -> SigOpIpE (por OPERACAO)  |  senao -> SigOpEtS
    *
    * MsgConfirma devolve LOGICO (regra CLAUDE.md #7) - nao se compara com 6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CmdImprimirEtiquetasClickExec(par_cOperacao)
        LOCAL loc_cOperacao, loc_cOperacaoNota, loc_nTpTlEtiqs, loc_cAbrev

        loc_cOperacaoNota = THIS.MontarChaveOperacaoNota()

        loc_cOperacao = IIF(!EMPTY(par_cOperacao), ALLTRIM(par_cOperacao), ;
            loc_cOperacaoNota)

        IF EMPTY(loc_cOperacao)
            MsgAviso("A nota ainda n" + CHR(227) + "o foi gravada - n" + CHR(227) + ;
                "o h" + CHR(225) + " itens para etiquetar.", ;
                "Impress" + CHR(227) + "o de Etiquetas")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma impress" + CHR(227) + "o das Etiquetas ?(S/N)", ;
                ALLTRIM(loc_cOperacao))
            RETURN
        ENDIF

        IF !THIS.PrepararCursorEtiquetas()
            RETURN
        ENDIF

        IF !THIS.CarregarItensEtiqueta(loc_cOperacao, loc_cOperacaoNota)
            RETURN
        ENDIF

        THIS.MontarEtiquetasDosItens()

        *-- "Update dbImpressao Set Pedido = crSigCdOpe.Abrevs". O valor vai
        *-- para uma LOCAL antes: chamada de metodo no SET de um UPDATE-SQL
        *-- do VFP nao e expressao confiavel, e a LOCAL tambem evita que o
        *-- nome colida com coluna do proprio cursor.
        loc_cAbrev = THIS.ObterAbreviacaoOperacao()

        SELECT dbImpressao
        UPDATE dbImpressao SET Pedido = loc_cAbrev

        SELECT dbImpressao
        GO TOP

        loc_nTpTlEtiqs = THIS.ObterConfigNumerica("SigOpCdd", "tptletiqs", "")

        IF loc_nTpTlEtiqs = 2
            *-- "ThisForm.Tipo = [OPERACAO] / Do Form SigOpIpE With ThisForm, .t."
            THIS.AvisarLegadoNaoPortado("tela SigOpIpE (etiquetas por opera" + ;
                CHR(231) + CHR(227) + "o)", ;
                "abrir a impress" + CHR(227) + "o de etiquetas por opera" + ;
                CHR(231) + CHR(227) + "o - o cursor de etiquetas foi montado " + ;
                "e tem " + TRANSFORM(RECCOUNT("dbImpressao")) + " linha(s)")
        ELSE
            THIS.AbrirTelaEtiquetasProduto()
        ENDIF

        THIS.FecharCursorTemporario("crEesti")
        THIS.FecharCursorTemporario("crEsti2")
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveOperacaoNota - "crSigMvNfi.Emps + crSigMvNfi.Dopes +
    * Str(crSigMvNfi.Numes, 6)" do legado, que e a coluna EmpDopNums.
    *
    * Chave POSICIONAL char(29) = Emps(3) + Dopes(20) + Str(Numes,6): montada
    * com PADR nas partes de texto, NUNCA com ALLTRIM - ALLTRIM encurta a
    * chave, ela nao casa com o EmpDopNums gravado e o SELECT dos itens
    * devolve ZERO linha em silencio (regra CLAUDE.md #42). A soma das
    * larguras (3 + 20 + 6 = 29) e a conferencia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarChaveOperacaoNota()
        LOCAL loc_cChave, loc_oBO
        loc_cChave = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject

            *-- Quando o BO ja guarda o EmpDopNums pronto, usa o valor dele:
            *-- e exatamente a chave gravada, sem risco de remontagem.
            IF !EMPTY(ALLTRIM(loc_oBO.this_cEmpDopNums))
                loc_cChave = loc_oBO.this_cEmpDopNums
            ELSE
                IF !EMPTY(ALLTRIM(loc_oBO.this_cEmps)) OR ;
                        !EMPTY(ALLTRIM(loc_oBO.this_cDopes))
                    loc_cChave = PADR(loc_oBO.this_cEmps, 3) + ;
                        PADR(loc_oBO.this_cDopes, 20) + ;
                        STR(loc_oBO.this_nNumes, 6)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursorEtiquetas - "Zap in dbimpressao" do legado.
    *
    * dbImpressao e a grade de etiquetas a imprimir, COMPARTILHADA com a tela
    * que efetivamente imprime (Formsigopets/sigopetsBO documentam a mesma
    * lista de colunas). No legado ela e uma tabela livre aberta pelo sistema;
    * aqui e cursor de sessao: se o form pai ja a criou, reaproveita e so
    * esvazia; se nao existe, cria com a estrutura do contrato.
    *
    * ZAP exige guarda de SAFETY: SET SAFETY e escopado por data session e
    * este form tem DataSession = 2, onde o "SET SAFETY OFF" do main.prg NAO
    * chega - com SAFETY ON o ZAP abre um dialogo modal invisivel e a tela
    * CONGELA (medido no VFP9).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararCursorEtiquetas()
        LOCAL loc_cSafety, loc_lOk
        loc_lOk = .T.

        IF !USED("dbImpressao")
            SET NULL ON
            CREATE CURSOR dbImpressao ( ;
                CPros      C(14) NULL, ;
                Qtds       N(12, 3) NULL, ;
                QtdeEtiq   N(12, 3) NULL, ;
                Pedido     C(30) NULL, ;
                Obs        C(10) NULL, ;
                Moedas     C(3)  NULL, ;
                EmpDopNums C(29) NULL, ;
                PVens      N(15, 6) NULL, ;
                Pesos      N(12, 3) NULL, ;
                CItens     N(10, 0) NULL, ;
                CodTams    C(4)  NULL, ;
                CBars      N(14, 0) NULL)
            SET NULL OFF
        ELSE
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF

            SELECT dbImpressao
            ZAP

            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ENDIF

        IF !USED("dbImpressao")
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel preparar a " + ;
                "grade de etiquetas (dbImpressao).", ;
                "Impress" + CHR(227) + "o de Etiquetas")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensEtiqueta - abre crEesti (itens) e crEsti2 (sub-itens de
    * tamanho/cor) conforme os TRES ramos do legado.
    *
    *   (a) operacao = a da nota E CtrlLotes in (1,2) E ietiqs = 1:
    *       etiqueta de LOTE - insere UMA linha com o produto de controle
    *       (crSigCdPam.Ouros) e deixa os dois cursores VAZIOS ("Where 0=1"
    *       no proprio legado), para o Scan seguinte nao gerar mais nada.
    *   (b) operacao = a da nota (sem lote): itens de SigMvItn/SigMvIts.
    *   (c) operacao DIFERENTE (reimpressao): itens de SigMvHst, so entradas
    *       (a.Opers = 'E'), com a unidade vinda de SigCdPro; crEsti2 fica
    *       vazio por construcao ("And 0=1" no legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarItensEtiqueta(par_cOperacao, par_cOperacaoNota)
        LOCAL loc_lOk, loc_cSQL, loc_cBusca, loc_cDopes, loc_nCtrlLotes, loc_nIetiqs
        LOCAL loc_lMesmaNota

        loc_lOk      = .T.
        loc_cBusca   = ALLTRIM(par_cOperacao)
        loc_lMesmaNota = (ALLTRIM(par_cOperacao) == ALLTRIM(par_cOperacaoNota))
        loc_cDopes   = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
        ENDIF

        IF loc_lMesmaNota
            loc_nCtrlLotes = 0
            IF !EMPTY(loc_cDopes)
                loc_nCtrlLotes = THIS.ObterConfigNumerica("SigCdOpe", "ctrllotes", ;
                    "RTRIM(dopes) = " + EscaparSQL(loc_cDopes))
            ENDIF
            loc_nIetiqs = THIS.ObterConfigNumerica("SigOpCdc", "ietiqs", "")

            IF INLIST(loc_nCtrlLotes, 1, 2) AND loc_nIetiqs = 1
                *-- Ramo (a): etiqueta de LOTE.
                THIS.InserirEtiquetaDeLote()

                loc_lOk = THIS.CarregarListaOuVazio("crEesti", ;
                    "SELECT * FROM SigMvItn WHERE 1 = 0")
                IF loc_lOk
                    loc_lOk = THIS.CarregarListaOuVazio("crEsti2", ;
                        "SELECT * FROM SigMvIts WHERE 1 = 0")
                ENDIF
            ELSE
                *-- Ramo (b): itens da propria nota.
                loc_cSQL = "SELECT * FROM SigMvItn WHERE RTRIM(empdopnums) = " + ;
                    EscaparSQL(loc_cBusca) + " ORDER BY citens"
                loc_lOk = THIS.CarregarListaOuVazio("crEesti", loc_cSQL)

                IF loc_lOk
                    loc_cSQL = "SELECT * FROM SigMvIts WHERE RTRIM(empdopnums) = " + ;
                        EscaparSQL(loc_cBusca) + " ORDER BY citens"
                    loc_lOk = THIS.CarregarListaOuVazio("crEsti2", loc_cSQL)
                ENDIF
            ENDIF
        ELSE
            *-- Ramo (c): reimpressao a partir do historico.
            loc_cSQL = "SELECT a.*, b.cunis AS cunis FROM SigMvHst a" + ;
                " INNER JOIN SigCdPro b ON RTRIM(b.cpros) = RTRIM(a.cpros)" + ;
                " WHERE RTRIM(a.oridopnums) = " + EscaparSQL(loc_cBusca) + ;
                " AND RTRIM(a.opers) = " + EscaparSQL("E")
            loc_lOk = THIS.CarregarListaOuVazio("crEesti", loc_cSQL)

            IF loc_lOk
                loc_lOk = THIS.CarregarListaOuVazio("crEsti2", ;
                    "SELECT * FROM SigMvIts WHERE 1 = 0")
            ENDIF
        ENDIF

        IF loc_lOk AND USED("crEsti2")
            *-- "Select CrEsti2 / Index On Citens Tag Citens" do legado - o
            *-- Scan adiante faz Seek por CItens neste cursor.
            SELECT crEsti2
            INDEX ON citens TAG citens
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarListaOuVazio - igual a CarregarListaLookup, mas aceita ZERO
    * linha como SUCESSO.
    *
    * Os cursores de etiqueta sao criados de proposito vazios em dois ramos do
    * legado ("Where 0=1"), e tratar vazio como falha abortaria justamente a
    * etiqueta de LOTE, que e a unica linha valida nesse caso.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarListaOuVazio(par_cCursor, par_cSQL)
        LOCAL loc_nResultado, loc_lOk
        loc_lOk = .F.

        THIS.FecharCursorTemporario(par_cCursor)

        loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF loc_nResultado < 0
            MsgErro("Falha ao consultar os itens da etiqueta." + CHR(13) + ;
                CapturarErroSQL(), "Erro SQL")
        ELSE
            loc_lOk = USED(par_cCursor)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirEtiquetaDeLote - ramo de LOTE do ImpEtiqueta legado:
    *
    *   lnBar = Val( Str(crSigCdOpe.Ndopes,4) + Transf(crSigMvNfi.Numes,"@L 999999") )
    *   lcObs = crSigCdOpe.Abrevs + "-" + Transf(crSigMvNfi.Numes,"@L 999999")
    *   Insert Into dbImpressao (CPros, Qtds, Cbars, Obs)
    *            Values (crSigCdPam.Ouros, 1, lnBar, lcObs)
    *
    * O codigo de barras e POSICIONAL: 4 digitos do Ndopes seguidos de 6 do
    * numero do movimento, ambos com zero a esquerda ("@L" do TRANSFORM) -
    * montar com ALLTRIM mudaria o numero gerado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirEtiquetaDeLote()
        LOCAL loc_cDopes, loc_nNdopes, loc_nNumes, loc_cAbrevs, loc_cOuros
        LOCAL loc_cNumes, loc_nBar, loc_cObs, loc_cWhere

        loc_cDopes = ""
        loc_nNumes = 0

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
            loc_nNumes = THIS.this_oBusinessObject.this_nNumes
        ENDIF

        loc_nNdopes = 0
        loc_cAbrevs = ""

        IF !EMPTY(loc_cDopes)
            loc_cWhere  = "RTRIM(dopes) = " + EscaparSQL(loc_cDopes)
            loc_nNdopes = THIS.ObterConfigNumerica("SigCdOpe", "ndopes", loc_cWhere)
            loc_cAbrevs = THIS.ObterAbreviacaoOperacao()
        ENDIF

        loc_cOuros = THIS.ObterProdutoControleLote()
        loc_cNumes = TRANSFORM(loc_nNumes, "@L 999999")
        loc_nBar   = VAL(TRANSFORM(loc_nNdopes, "@L 9999") + loc_cNumes)
        loc_cObs   = ALLTRIM(loc_cAbrevs) + "-" + loc_cNumes

        INSERT INTO dbImpressao (CPros, Qtds, CBars, Obs) ;
            VALUES (loc_cOuros, 1, loc_nBar, LEFT(loc_cObs, 10))
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutoControleLote - crSigCdPam.Ouros, o produto de controle que
    * o legado usa na etiqueta de lote. SigCdPam e tabela de parametro com
    * uma linha so (o legado le direto do cursor, sem filtro).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterProdutoControleLote()
        LOCAL loc_cCursor, loc_cValor
        loc_cCursor = "cursor_4c_PamFis"
        loc_cValor  = ""

        IF THIS.CarregarListaLookup(loc_cCursor, "SELECT ouros FROM SigCdPam")
            SELECT (loc_cCursor)
            GO TOP
            loc_cValor = THIS.LerColunaLookup(loc_cCursor, "ouros")
        ENDIF

        THIS.FecharCursorTemporario(loc_cCursor)

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterAbreviacaoOperacao - crSigCdOpe.Abrevs, usado no "Update
    * dbImpressao Set Pedido = crSigCdOpe.Abrevs" e na observacao do lote.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterAbreviacaoOperacao()
        LOCAL loc_cCursor, loc_cDopes, loc_cValor
        loc_cCursor = "cursor_4c_AbrevFis"
        loc_cValor  = ""
        loc_cDopes  = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
        ENDIF

        IF !EMPTY(loc_cDopes)
            IF THIS.CarregarListaLookup(loc_cCursor, ;
                    "SELECT abrevs FROM SigCdOpe WHERE RTRIM(dopes) = " + ;
                    EscaparSQL(loc_cDopes))
                SELECT (loc_cCursor)
                GO TOP
                loc_cValor = THIS.LerColunaLookup(loc_cCursor, "abrevs")
            ENDIF

            THIS.FecharCursorTemporario(loc_cCursor)
        ENDIF

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarEtiquetasDosItens - "Select crEesti / Scan ... Endscan" do
    * ImpEtiqueta legado, transcrito com as mesmas condicoes:
    *
    *   If cursorQuery('SigCdUni','crSigCdUni','Cunis', CrEesti.Cunis)
    *        And ( CrEesti.Opers = 'E' Or crSigOpCdd.EtqSaids = 1 )
    *       ... Select a.Cpros, a.Cgrus, b.nTipoJoals, b.etipads
    *           From SigCdPro a Inner Join SigCdGrp b On b.cGrus = a.cGrus
    *       If LocalPro.EtiPads = 'D' -> Loop     (grupo so por selecao)
    *       _QtEtiq = crEesti.Qtds ; _QtPeso = CrEesti.Pesos
    *       If crSigCdUni.pqtds='S' And crSigCdUni.Etiqs#'S'
    *           _QtEtiq = 0 ; _QtPeso = 0 ; Do Form SigOpQtE With Cpros
    *       If crSigCdUni.Etiqs = 'S'  -> por CODIGO DE BARRAS
    *       Else                       -> por PRODUTO
    *
    * O "Do Form SigOpQtE" (que PERGUNTA ao usuario a quantidade por peso)
    * nao foi migrado: ali o legado ZERA as duas quantidades e espera o
    * dialogo devolve-las, entao seguir sem ele geraria etiqueta com
    * quantidade ZERO em silencio. Por isso avisa e NAO insere a linha -
    * regra CLAUDE.md #27 (ausencia visivel em vez de dado errado calado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarEtiquetasDosItens()
        LOCAL loc_nEtqSaids, loc_cCunis, loc_cPqtds, loc_cEtiqs, loc_cEtiPads
        LOCAL loc_nQtEtiq, loc_nQtPeso, loc_cCpros, loc_nCodBarras
        LOCAL loc_lAvisouQtE, loc_lPular, loc_nUnits, loc_cMoedas, loc_cEmpDop
        LOCAL loc_nCitens, loc_cOpers

        IF !USED("crEesti") OR RECCOUNT("crEesti") = 0
            RETURN
        ENDIF

        loc_nEtqSaids  = THIS.ObterConfigNumerica("SigOpCdd", "etqsaids", "")
        loc_lAvisouQtE = .F.

        SELECT crEesti
        GO TOP

        *-- DO WHILE + SKIP, NAO Scan/Endscan: o corpo abaixo chama metodos
        *-- que fazem SQLEXEC e INSERT, e cada um deles TROCA a work area
        *-- corrente. Com Scan/Endscan, um LOOP depois dessa troca faria o
        *-- ENDSCAN avancar o cursor ERRADO (ou nenhum) - laco infinito ou
        *-- itens pulados, sem erro nenhum. O SKIP explicito nomeia o alias.
        DO WHILE !EOF("crEesti")
            loc_lPular = .F.

            loc_cCunis  = ALLTRIM(TRANSFORM(TratarNulo(crEesti.cunis, "")))
            loc_cCpros  = ALLTRIM(TRANSFORM(TratarNulo(crEesti.cpros, "")))
            loc_cOpers  = ALLTRIM(TRANSFORM(TratarNulo(crEesti.opers, "")))
            loc_nQtEtiq = TratarNulo(crEesti.qtds, 0)
            loc_nQtPeso = TratarNulo(crEesti.pesos, 0)
            loc_nUnits  = TratarNulo(crEesti.units, 0)
            loc_cMoedas = TratarNulo(crEesti.moedas, "")
            loc_cEmpDop = TratarNulo(crEesti.empdopnums, "")
            loc_nCitens = TratarNulo(crEesti.citens, 0)
            loc_nCodBarras = TratarNulo(crEesti.codbarras, 0)

            *-- "cursorQuery('SigCdUni','crSigCdUni','Cunis', CrEesti.Cunis)":
            *-- a unidade TEM de existir no cadastro, senao o item e ignorado.
            IF EMPTY(loc_cCunis) OR !THIS.CarregarConfigUnidade(loc_cCunis)
                loc_lPular = .T.
            ENDIF

            *-- Saidas so entram quando a configuracao permite.
            IF !loc_lPular AND loc_cOpers != "E" AND loc_nEtqSaids != 1
                loc_lPular = .T.
            ENDIF

            IF !loc_lPular
                loc_cPqtds   = UPPER(THIS.LerColunaLookup("cursor_4c_UniFis", "pqtds"))
                loc_cEtiqs   = UPPER(THIS.LerColunaLookup("cursor_4c_UniFis", "etiqs"))
                loc_cEtiPads = UPPER(THIS.ObterEtiquetaPadraoGrupo(loc_cCpros))

                *-- EtiPads = 'D' (Selecionadas): o grupo so imprime pela tela
                *-- de etiquetas selecionadas / reimpressao - aqui e pulado.
                IF loc_cEtiPads == "D"
                    loc_lPular = .T.
                ENDIF
            ENDIF

            IF !loc_lPular AND loc_cPqtds == "S" AND loc_cEtiqs != "S"
                *-- Legado: zera as duas quantidades e PERGUNTA ao usuario em
                *-- SigOpQtE. Sem esse dialogo, inserir aqui geraria etiqueta
                *-- com quantidade ZERO em silencio.
                IF !loc_lAvisouQtE
                    loc_lAvisouQtE = .T.
                    THIS.AvisarLegadoNaoPortado("tela SigOpQtE (quantidade de " + ;
                        "etiquetas por peso)", ;
                        "etiquetar o(s) produto(s) vendido(s) por peso - " + ;
                        "come" + CHR(231) + "ando em " + loc_cCpros)
                ENDIF
                loc_lPular = .T.
            ENDIF

            IF !loc_lPular
                IF loc_cEtiqs == "S"
                    *-- Etiqueta por CODIGO DE BARRAS.
                    IF loc_nCodBarras != 0
                        THIS.PosicionarSubItemEtiqueta(loc_nCitens)

                        INSERT INTO dbImpressao (CPros, Qtds, QtdeEtiq, Pesos, Obs, ;
                                PVens, Moedas, EmpDopNums, CItens, CodTams) ;
                            VALUES (STR(loc_nCodBarras, 14), 1, loc_nQtEtiq, ;
                                loc_nQtPeso, THIS.LerSubItemEtiqueta("codcors"), ;
                                loc_nUnits, loc_cMoedas, loc_cEmpDop, loc_nCitens, ;
                                THIS.LerSubItemEtiqueta("codtams"))
                    ELSE
                        *-- Sem codigo de barras no item: o legado desce para os
                        *-- SUB-ITENS (tamanho/cor) e insere um por um.
                        THIS.InserirEtiquetasDosSubItens(loc_nCitens, loc_nQtPeso, ;
                            loc_nUnits, loc_cMoedas, loc_cEmpDop)
                    ENDIF
                ELSE
                    *-- Etiqueta por PRODUTO.
                    THIS.PosicionarSubItemEtiqueta(loc_nCitens)

                    INSERT INTO dbImpressao (CPros, Qtds, Pesos, Obs, PVens, ;
                            Moedas, EmpDopNums, CItens, CodTams) ;
                        VALUES (loc_cCpros, loc_nQtEtiq, loc_nQtPeso, ;
                            THIS.LerSubItemEtiqueta("codcors"), loc_nUnits, ;
                            loc_cMoedas, loc_cEmpDop, loc_nCitens, ;
                            THIS.LerSubItemEtiqueta("codtams"))
                ENDIF
            ENDIF

            SKIP IN crEesti
        ENDDO

        THIS.FecharCursorTemporario("cursor_4c_UniFis")
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirEtiquetasDosSubItens - "Select crEsti2 / Seek CrEesti.Citens /
    * Scan While crEsti2.CItens = CrEesti.Citens" do legado: uma etiqueta por
    * sub-item (combinacao de tamanho/cor) que tenha codigo de barras.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirEtiquetasDosSubItens(par_nCitens, par_nQtPeso, ;
            par_nUnits, par_cMoedas, par_cEmpDop)
        LOCAL loc_nBarras, loc_nQtds, loc_cCodTams, loc_cCodCors

        IF !USED("crEsti2")
            RETURN
        ENDIF

        SELECT crEsti2
        SET ORDER TO TAG citens

        IF !SEEK(par_nCitens, "crEsti2", "citens")
            RETURN
        ENDIF

        *-- DO WHILE + SKIP em vez de "Scan While": o INSERT troca a work area
        *-- corrente, e o ENDSCAN avancaria o cursor errado.
        DO WHILE !EOF("crEsti2") AND TratarNulo(crEsti2.citens, 0) = par_nCitens
            loc_nBarras  = TratarNulo(crEsti2.codbarras, 0)
            loc_nQtds    = TratarNulo(crEsti2.qtds, 0)
            loc_cCodTams = TratarNulo(crEsti2.codtams, "")
            loc_cCodCors = TratarNulo(crEsti2.codcors, "")

            IF loc_nBarras != 0
                INSERT INTO dbImpressao (CPros, Qtds, QtdeEtiq, CodTams, Obs, ;
                        PVens, Pesos, Moedas, EmpDopNums, CItens) ;
                    VALUES (STR(loc_nBarras, 14), 1, loc_nQtds, loc_cCodTams, ;
                        loc_cCodCors, par_nUnits, par_nQtPeso, par_cMoedas, ;
                        par_cEmpDop, par_nCitens)
            ENDIF

            SKIP IN crEsti2
        ENDDO
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarSubItemEtiqueta - "Select crEsti2 / Seek CrEesti.Citens" que o
    * legado faz ANTES de inserir, para que crEsti2.CodCors/CodTams usados no
    * Insert sejam os do item corrente.
    *
    * Recebe o CItens por parametro em vez de ler crEesti: quem chama esta
    * dentro de um laco e ja capturou o valor, e assim este metodo nao depende
    * de qual alias esta selecionado no momento da chamada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PosicionarSubItemEtiqueta(par_nCitens)
        IF !USED("crEsti2")
            RETURN
        ENDIF

        SELECT crEsti2
        SET ORDER TO TAG citens
        =SEEK(par_nCitens, "crEsti2", "citens")
    ENDPROC

    *--------------------------------------------------------------------------
    * LerSubItemEtiqueta - le uma coluna de crEsti2 na linha em que ele esta
    * posicionado, devolvendo "" quando o cursor nao tem a linha (os dois
    * ramos "Where 0=1" do legado deixam crEsti2 vazio de proposito).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LerSubItemEtiqueta(par_cCampo)
        LOCAL loc_cValor
        loc_cValor = ""

        IF USED("crEsti2")
            IF !EOF("crEsti2") AND TYPE("crEsti2." + par_cCampo) != "U"
                loc_cValor = ALLTRIM(TRANSFORM(TratarNulo( ;
                    EVALUATE("crEsti2." + par_cCampo), "")))
            ENDIF
        ENDIF

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfigUnidade - equivalente ao "cursorQuery('SigCdUni',
    * 'crSigCdUni','Cunis', CrEesti.Cunis)" do legado, que devolve .F. quando
    * a unidade nao esta cadastrada (e ai o item nao gera etiqueta).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarConfigUnidade(par_cCunis)
        RETURN THIS.CarregarListaLookup("cursor_4c_UniFis", ;
            "SELECT cunis, pqtds, etiqs FROM SigCdUni WHERE RTRIM(cunis) = " + ;
            EscaparSQL(ALLTRIM(par_cCunis)))
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterEtiquetaPadraoGrupo - SigCdGrp.etipads do grupo do produto:
    *
    *   Select a.Cpros, a.Cgrus, b.nTipoJoals, b.etipads
    *     From SigCdPro a Inner Join SigCdGrp b on b.cGrus = a.cGrus
    *    Where a.Cpros = '<cpros>'
    *
    * O legado aborta o processo inteiro quando essa consulta nao traz linha
    * ("Favor Reiniciar o Processo!!!" + Return 0). Aqui devolve "" e o
    * chamador trata: abortar o Scan por um produto sem grupo deixaria as
    * etiquetas dos OUTROS itens sem gerar, o que e pior do que pular um.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterEtiquetaPadraoGrupo(par_cCpros)
        LOCAL loc_cCursor, loc_cValor, loc_cSQL
        loc_cCursor = "cursor_4c_GrpFis"
        loc_cValor  = ""

        IF !EMPTY(par_cCpros)
            loc_cSQL = "SELECT a.cpros, a.cgrus, b.ntipojoals, b.etipads" + ;
                " FROM SigCdPro a INNER JOIN SigCdGrp b" + ;
                " ON RTRIM(b.cgrus) = RTRIM(a.cgrus)" + ;
                " WHERE RTRIM(a.cpros) = " + EscaparSQL(ALLTRIM(par_cCpros))

            IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                SELECT (loc_cCursor)
                GO TOP
                loc_cValor = THIS.LerColunaLookup(loc_cCursor, "etipads")
            ENDIF

            THIS.FecharCursorTemporario(loc_cCursor)
        ENDIF

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirTelaEtiquetasProduto - "Do Form SigOpEtS With ThisForm,
    * ThisForm.DataSessionId" do legado.
    *
    * SigOpEtS JA foi migrado como Formsigopets, com a MESMA assinatura
    * (par_oFormPai, par_nDataSessionIdPai). Aberto por CREATEOBJECT, nunca
    * por "DO FORM": o projeto novo nao tem .SCX nenhum, entao DO FORM
    * procuraria "sigopets.scx", nao abriria nada e ainda deixaria a classe
    * FORA do indice de carga sob demanda.
    *
    * Show() fica FORA do TRY (regra CLAUDE.md #29): o form filho e modal
    * (WindowType = 1), entao a chamada bloqueia e a tela inteira dele vive
    * dentro dela - com o Show() dentro do TRY, qualquer erro de runtime do
    * filho cairia neste CATCH, a referencia LOCAL morreria e a tela filha
    * fecharia sozinha.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirTelaEtiquetasProduto()
        LOCAL loc_oForm, loc_oErro

        loc_oForm = .NULL.

        TRY
            loc_oForm = CREATEOBJECT("Formsigopets", THIS, THIS.DataSessionId)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir Impress" + CHR(227) + "o de Etiquetas")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *==========================================================================
    * BOTAO "Reimprime o DANFE" (legado Fwbtnm1)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdReimprimirDanfeClick - wrapper fino (corpo com RETURN antecipado).
    *--------------------------------------------------------------------------
    PROCEDURE CmdReimprimirDanfeClick()
        LOCAL loc_oErro

        TRY
            THIS.CmdReimprimirDanfeClickExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CmdReimprimirDanfeClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdReimprimirDanfeClickExec - corpo do Fwbtnm1.Click legado, que tem
    * TRES caminhos, escolhidos por SigCdOpe.CupFis:
    *
    *   CupFis >= 5 (NFCe/SAT)  -> ThisForm.reprintd()
    *   CupFis =  1 e RcFinas<>0 -> reimpressao do carne no ECF
    *                               (ImprcFinanciado + LeituraFab +
    *                                LeituraNoCupom + ImprimirRG)
    *   demais                   -> DANFE: PDF gravado na nota, ou XML +
    *                               unidanfe.exe
    *
    * Os dois primeiros dependem de codigo que NAO veio no acervo: reprintd()
    * fala com a DLL DarumaFramework (e DECLARE ... IN <dll> CARREGA a
    * biblioteca na hora, derrubando a tela na estacao que nao a tem - regra
    * CLAUDE.md sobre DECLARE DLL) e o carne de ECF depende de
    * ImprcFinanciado()/LeituraNoCupom()/ImprimirRG(). Ambos avisam.
    *
    * O terceiro caminho - que e o normal para NF-e - esta implementado de
    * verdade: le os blobs da propria nota, grava o arquivo na pasta
    * configurada da empresa e chama o visualizador/unidanfe, igual ao dump.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CmdReimprimirDanfeClickExec()
        LOCAL loc_nCupFis, loc_nRcFinas, loc_cCursor, loc_cPasta, loc_cLogo
        LOCAL loc_cChave, loc_cPdf, loc_cXml, loc_cArquivo, loc_cDanfe
        LOCAL loc_cTpImp, loc_nIni, loc_cComando, loc_cArqXml

        loc_nCupFis = THIS.ObterCupomFiscalOperacao()

        *-- NFCe / SAT
        IF loc_nCupFis >= 5
            THIS.AvisarLegadoNaoPortado("reprintd() / DLL DarumaFramework", ;
                "reimprimir o comprovante NFCe/SAT")
            RETURN
        ENDIF

        *-- Carne de ECF com financiamento
        IF loc_nCupFis = 1
            loc_nRcFinas = THIS.ObterConfigNumerica("SigOpCdd", "rcfinas", "")

            IF loc_nRcFinas != 0
                THIS.AvisarLegadoNaoPortado("ImprcFinanciado() / " + ;
                    "LeituraNoCupom() / ImprimirRG()", ;
                    "reimprimir o carn" + CHR(234) + " de ECF como relat" + ;
                    CHR(243) + "rio gerencial")
                RETURN
            ENDIF
        ENDIF

        *-- DANFE
        loc_cCursor = "cursor_4c_DanfeFis"

        IF !THIS.AbrirCursorNota("nfechv, nfepdf, nfexml", loc_cCursor)
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registro desta nota " + ;
                "para reimprimir.", "Reimpress" + CHR(227) + "o do DANFE")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(THIS.LerColunaLookup(loc_cCursor, "nfechv"))
        loc_cPdf   = THIS.LerTextoNota(loc_cCursor, "nfepdf")
        loc_cXml   = THIS.LerTextoNota(loc_cCursor, "nfexml")

        THIS.FecharCursorTemporario(loc_cCursor)

        loc_cPasta = THIS.ObterPastaNfe()
        loc_cLogo  = THIS.ObterLogotipoNfe()

        IF EMPTY(loc_cPasta)
            MsgErro("A pasta de arquivos de NF-e n" + CHR(227) + "o est" + CHR(225) + ;
                " configurada no cadastro da empresa (SigCdEmp.pastas).", ;
                "Reimpress" + CHR(227) + "o do DANFE")
            RETURN
        ENDIF

        IF !EMPTY(loc_cPdf)
            *-- Caminho do dump: apaga os PDF anteriores da mesma chave, grava
            *-- o PDF da nota e abre no visualizador padrao do Windows.
            THIS.ApagarArquivosAnteriores(loc_cPasta + LEFT(loc_cChave, 25) + "*.pdf")

            loc_cArquivo = loc_cPasta + loc_cChave + ".pdf"

            IF THIS.GravarArquivoNfe(loc_cArquivo, loc_cPdf)
                RUN /N Explorer.Exe &loc_cArquivo
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar " + ;
                    loc_cArquivo + ".", "Reimpress" + CHR(227) + "o do DANFE")
            ENDIF

            RETURN
        ENDIF

        IF EMPTY(loc_cXml)
            *-- "WAIT [Nao existe registro do DANFE(PDF) desta nota.] window"
            MsgAviso("N" + CHR(227) + "o existe registro do DANFE(PDF) desta nota.", ;
                "Reimpress" + CHR(227) + "o do DANFE")
            RETURN
        ENDIF

        *-- Caminho do XML: grava o XML e chama o unidanfe.exe com a
        *-- orientacao que o proprio XML declara na tag <tpImp>.
        loc_cDanfe = THIS.ObterPastaEmpresaNfe() + "unidanfe.exe"

        loc_nIni  = ATC("<tpImp>", loc_cXml, 1)
        loc_cTpImp = IIF(loc_nIni > 0, SUBSTR(loc_cXml, loc_nIni + 7, 1), "1")
        loc_cTpImp = IIF(loc_cTpImp = "1", "RETRATO", "PAISAGEM")

        loc_cArqXml = loc_cPasta + loc_cChave + "E.xml"

        IF !THIS.GravarArquivoNfe(loc_cArqXml, loc_cXml)
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar " + ;
                loc_cArqXml + ".", "Reimpress" + CHR(227) + "o do DANFE")
            RETURN
        ENDIF

        IF !FILE(loc_cDanfe)
            MsgErro("O unidanfe.exe n" + CHR(227) + "o foi encontrado em " + ;
                loc_cDanfe + "." + CHR(13) + ;
                "O XML da nota foi gravado em " + loc_cArqXml + ".", ;
                "Reimpress" + CHR(227) + "o do DANFE")
            RETURN
        ENDIF

        loc_cComando = loc_cDanfe + [ ARQUIVO="] + loc_cArqXml + [" configura] + ;
            CHR(231) + CHR(227) + [o=] + loc_cTpImp + [ V=1 M=1 ] + loc_cLogo

        RUN /N &loc_cComando
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCupomFiscalOperacao - SigCdOpe.cupfis da operacao do movimento,
    * que e o que decide o caminho de reimpressao/contingencia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterCupomFiscalOperacao()
        LOCAL loc_cDopes, loc_nValor
        loc_nValor = 0
        loc_cDopes = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
        ENDIF

        IF !EMPTY(loc_cDopes)
            loc_nValor = THIS.ObterConfigNumerica("SigCdOpe", "cupfis", ;
                "RTRIM(dopes) = " + EscaparSQL(loc_cDopes))
        ENDIF

        RETURN loc_nValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterPastaEmpresaNfe / ObterPastaNfe / ObterLogotipoNfe - leem
    * SigCdEmp (pastas, logonfe) da empresa da nota.
    *
    * O legado usa a pasta de duas formas: crua (onde fica o unidanfe.exe) e
    * com o sufixo "TXT\", onde gravam os arquivos da NFe - as duas aparecem
    * no mesmo Click ("ALLTRIM(localEmp.pastas) + [TXT\]" e
    * "ALLTRIM(localEmp.pastas) + 'unidanfe.exe'").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterPastaEmpresaNfe()
        LOCAL loc_cCursor, loc_cPasta
        loc_cCursor = "cursor_4c_EmpNfe"
        loc_cPasta  = ""

        IF THIS.CarregarConfigEmpresaNfe(loc_cCursor)
            loc_cPasta = ALLTRIM(THIS.LerColunaLookup(loc_cCursor, "pastas"))

            IF !EMPTY(loc_cPasta)
                loc_cPasta = ADDBS(loc_cPasta)
            ENDIF
        ENDIF

        THIS.FecharCursorTemporario(loc_cCursor)

        RETURN loc_cPasta
    ENDFUNC

    PROTECTED FUNCTION ObterPastaNfe()
        LOCAL loc_cPasta
        loc_cPasta = THIS.ObterPastaEmpresaNfe()

        IF !EMPTY(loc_cPasta)
            loc_cPasta = loc_cPasta + "txt" + CHR(92)
        ENDIF

        RETURN loc_cPasta
    ENDFUNC

    PROTECTED FUNCTION ObterLogotipoNfe()
        LOCAL loc_cCursor, loc_cLogo
        loc_cCursor = "cursor_4c_EmpNfe"
        loc_cLogo   = ""

        IF THIS.CarregarConfigEmpresaNfe(loc_cCursor)
            loc_cLogo = ALLTRIM(THIS.LerColunaLookup(loc_cCursor, "logonfe"))
        ENDIF

        THIS.FecharCursorTemporario(loc_cCursor)

        *-- "lcLogo = IIF(EMPTY(lcLogo) or !FILE(lcLogo), [], [ LOGOTIPO="]+
        *--            lcLogo + ["])" do dump: so entra no comando se existir.
        IF EMPTY(loc_cLogo) OR !FILE(loc_cLogo)
            loc_cLogo = ""
        ELSE
            loc_cLogo = [ LOGOTIPO="] + loc_cLogo + ["]
        ENDIF

        RETURN loc_cLogo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfigEmpresaNfe - "Select servs, emailnfe, senhas, pastas,
    * textonfe, portas From SigCdEmp Where CEmps = '<cemps da nota>'" do
    * legado, mais logonfe (que o Fwbtnm1 tambem le).
    *
    * SigCdEmp usa cemps (COM o C) para o codigo da empresa, enquanto
    * SigMvNfi usa emps (SEM o C): conferido em docs/schema.sql, o prefixo da
    * tabela NAO decide (regra CLAUDE.md #48).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarConfigEmpresaNfe(par_cCursor)
        LOCAL loc_cEmps, loc_cSQL, loc_lOk
        loc_lOk   = .F.
        loc_cEmps = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cEmps = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
        ENDIF

        IF !EMPTY(loc_cEmps)
            loc_cSQL = "SELECT servs, emailnfe, senhas, pastas, textonfe," + ;
                " portas, logonfe FROM SigCdEmp WHERE RTRIM(cemps) = " + ;
                EscaparSQL(loc_cEmps)

            loc_lOk = THIS.CarregarListaLookup(par_cCursor, loc_cSQL)

            IF loc_lOk
                SELECT (par_cCursor)
                GO TOP
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarArquivoNfe - "=StrToFile(ALLTRIM(<blob>), <arquivo>)" do legado,
    * com confirmacao de que o arquivo saiu.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarArquivoNfe(par_cCaminho, par_cConteudo)
        LOCAL loc_lOk
        loc_lOk = .F.

        IF !EMPTY(par_cCaminho) AND !EMPTY(par_cConteudo)
            STRTOFILE(ALLTRIM(par_cConteudo), par_cCaminho)
            loc_lOk = FILE(par_cCaminho)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ApagarArquivosAnteriores - "DELETE file &lcArq" do legado (mascara com
    * curinga). ERASE nao aceita mascara em variavel sem macro, e falha de
    * exclusao nao pode abortar a reimpressao - por isso o TRY proprio com
    * CATCH que informa (CATCH nunca silencioso, regra CLAUDE.md #9).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ApagarArquivosAnteriores(par_cMascara)
        LOCAL loc_oErro, loc_cSafety

        IF EMPTY(par_cMascara)
            RETURN
        ENDIF

        loc_cSafety = SET("SAFETY")
        SET SAFETY OFF

        TRY
            ERASE (par_cMascara)
        CATCH TO loc_oErro
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel apagar os " + ;
                "arquivos anteriores (" + par_cMascara + "): " + ;
                loc_oErro.Message, "Reimpress" + CHR(227) + "o do DANFE")
        ENDTRY

        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF
    ENDPROC

    *==========================================================================
    * BOTAO "e-mail com TXT e XML" (legado Fwbtnm2)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdEnviarEmailNfeClick - wrapper fino (corpo com RETURN antecipado).
    *--------------------------------------------------------------------------
    PROCEDURE CmdEnviarEmailNfeClick()
        LOCAL loc_oErro

        TRY
            THIS.CmdEnviarEmailNfeClickExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CmdEnviarEmailNfeClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEnviarEmailNfeClickExec - corpo do Fwbtnm2.Click legado.
    *
    * O "do while .t. ... Exit / EndDo" do dump e um bloco de saida unica
    * (idioma do legado para "if ... return"), nao um laco: aqui vira o
    * encadeamento normal de IF/RETURN, que e o mesmo fluxo.
    *
    * Tudo o que depende de DADO esta implementado: configuracao de e-mail da
    * empresa (SigCdEmp), e-mail do cliente (SigCdCli.emails), guarda de
    * "nota nunca enviada a SEFAZ" (nfeprt vazio), geracao dos quatro anexos
    * (TXT, XML, XML de cancelamento, PDF), a confirmacao do usuario com o
    * destinatario e o assunto no formato do legado, e a limpeza dos anexos.
    *
    * O ENVIO em si depende de enviaEmail(), funcao global do Fortyus que nao
    * veio no acervo. Nao recebe stub: um stub devolvendo .F. faria o usuario
    * clicar e nada acontecer, e um devolvendo .T. afirmaria um envio que nao
    * houve. Avisa, e os anexos ja gravados NAO sao apagados - assim o
    * usuario pode envia-los a mao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CmdEnviarEmailNfeClickExec()
        LOCAL loc_cCursor, loc_cPasta, loc_cEmail, loc_cNfeprt, loc_cChave
        LOCAL loc_cAssunto, loc_cAnexos, loc_nAnexos

        loc_cAnexos = ""
        loc_nAnexos = 0
        loc_cPasta  = THIS.ObterPastaNfe()

        IF EMPTY(loc_cPasta)
            MsgErro("A pasta de arquivos de NF-e n" + CHR(227) + "o est" + CHR(225) + ;
                " configurada no cadastro da empresa (SigCdEmp.pastas).", ;
                "Envio de E-mail")
            RETURN
        ENDIF

        loc_cEmail = THIS.ObterEmailCliente()

        loc_cCursor = "cursor_4c_EmailFis"

        IF !THIS.AbrirCursorNota("nfechv, nfeprt, nfetxt, nfexml, canxml, nfepdf", ;
                loc_cCursor)
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registro desta nota.", ;
                "Envio de E-mail")
            RETURN
        ENDIF

        loc_cNfeprt = ALLTRIM(THIS.LerColunaLookup(loc_cCursor, "nfeprt"))

        IF EMPTY(loc_cNfeprt)
            *-- "WAIT [Nao existe registro de envio desta nota para a SEFAZ.]"
            THIS.FecharCursorTemporario(loc_cCursor)
            MsgAviso("N" + CHR(227) + "o existe registro de envio desta nota " + ;
                "para a SEFAZ.", "Envio de E-mail")
            RETURN
        ENDIF

        loc_nAnexos = THIS.GerarAnexosNfe(loc_cCursor, loc_cPasta, @loc_cAnexos)
        loc_cChave  = ALLTRIM(THIS.LerColunaLookup(loc_cCursor, "nfechv"))

        THIS.FecharCursorTemporario(loc_cCursor)

        *-- "cAssunto = 'Reenvio de Nota fiscal autorizada: ' +
        *--             SUBSTR(crSigMvNfi.nfechv, 26, 9)"
        loc_cAssunto = "Reenvio de Nota fiscal autorizada: " + ;
            SUBSTR(PADR(loc_cChave, 44), 26, 9)

        IF EMPTY(loc_cEmail)
            MsgAviso("O cliente desta nota n" + CHR(227) + "o tem e-mail " + ;
                "cadastrado (SigCdCli.emails)." + CHR(13) + CHR(13) + ;
                TRANSFORM(loc_nAnexos) + " arquivo(s) foram gravados em " + ;
                loc_cPasta + ".", "Envio de E-mail")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma envio de e-mail para: " + loc_cEmail + "?", ;
                "Envio de E-mail")
            RETURN
        ENDIF

        THIS.AvisarLegadoNaoPortado("enviaEmail()", ;
            "enviar o e-mail para " + loc_cEmail + " com assunto " + ;
            CHR(34) + loc_cAssunto + CHR(34) + " e " + TRANSFORM(loc_nAnexos) + ;
            " anexo(s) j" + CHR(225) + " gravado(s) em " + loc_cPasta)
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarAnexosNfe - bloco "**** cria arquivos para anexar ****" que o
    * Fwbtnm2 e o Fwbtnm6 do legado repetem IGUAL: grava em disco os quatro
    * blobs da nota, cada um com o sufixo do legado.
    *
    *   nfetxt -> <chave>T.txt      nfexml -> <chave>E.xml
    *   canxml -> <chave>C.xml      nfepdf -> <chave>P.pdf
    *
    * O PDF tem a guarda extra do legado: "And !'--->NF:' $ crSigMvNfi.nfepdf"
    * - quando o blob comeca com essa marca ele nao e PDF, e a mensagem de
    * retorno da SEFAZ gravada no mesmo campo.
    *
    * Devolve a QUANTIDADE gravada e, por referencia, a lista de anexos no
    * formato do legado (separada por ";", preservando as posicoes vazias).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarAnexosNfe(par_cCursor, par_cPasta, par_cAnexos)
        LOCAL loc_cChave, loc_nQtde, loc_cArqT, loc_cArqX, loc_cArqC, loc_cArqP
        LOCAL loc_cPdf

        loc_nQtde = 0
        loc_cArqT = ""
        loc_cArqX = ""
        loc_cArqC = ""
        loc_cArqP = ""

        loc_cChave = ALLTRIM(THIS.LerColunaLookup(par_cCursor, "nfechv"))

        IF !EMPTY(THIS.LerTextoNota(par_cCursor, "nfetxt"))
            loc_cArqT = par_cPasta + loc_cChave + "T.txt"
            IF THIS.GravarArquivoNfe(loc_cArqT, THIS.LerTextoNota(par_cCursor, "nfetxt"))
                loc_nQtde = loc_nQtde + 1
            ELSE
                loc_cArqT = ""
            ENDIF
        ENDIF

        IF !EMPTY(THIS.LerTextoNota(par_cCursor, "nfexml"))
            loc_cArqX = par_cPasta + loc_cChave + "E.xml"
            IF THIS.GravarArquivoNfe(loc_cArqX, THIS.LerTextoNota(par_cCursor, "nfexml"))
                loc_nQtde = loc_nQtde + 1
            ELSE
                loc_cArqX = ""
            ENDIF
        ENDIF

        IF !EMPTY(THIS.LerTextoNota(par_cCursor, "canxml"))
            loc_cArqC = par_cPasta + loc_cChave + "C.xml"
            IF THIS.GravarArquivoNfe(loc_cArqC, THIS.LerTextoNota(par_cCursor, "canxml"))
                loc_nQtde = loc_nQtde + 1
            ELSE
                loc_cArqC = ""
            ENDIF
        ENDIF

        loc_cPdf = THIS.LerTextoNota(par_cCursor, "nfepdf")

        IF !EMPTY(loc_cPdf) AND !("--->NF:" $ loc_cPdf)
            loc_cArqP = par_cPasta + loc_cChave + "P.pdf"
            IF THIS.GravarArquivoNfe(loc_cArqP, loc_cPdf)
                loc_nQtde = loc_nQtde + 1
            ELSE
                loc_cArqP = ""
            ENDIF
        ENDIF

        *-- "cAnexo = lcArqX + [;] + lcArqT + [;] + lcArqC + [;] + lcArqP"
        par_cAnexos = loc_cArqX + ";" + loc_cArqT + ";" + loc_cArqC + ";" + loc_cArqP

        RETURN loc_nQtde
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterEmailCliente - "Select emails From SigCdCli Where Iclis =
    * '<crSigMvNfi.clifors>'" do Fwbtnm2 legado.
    *
    * clifors e char(20) em SigMvNfi e iclis e char(10) em SigCdCli: a
    * comparacao vai por RTRIM nos dois lados, como nas outras consultas
    * deste form.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterEmailCliente()
        LOCAL loc_cCursor, loc_cCursorNota, loc_cCliente, loc_cEmail
        loc_cCursor     = "cursor_4c_CliFis"
        loc_cCursorNota = "cursor_4c_CliNota"
        loc_cEmail      = ""
        loc_cCliente    = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCliente = ALLTRIM(THIS.this_oBusinessObject.this_cClifors)
        ENDIF

        IF EMPTY(loc_cCliente)
            IF THIS.AbrirCursorNota("clifors", loc_cCursorNota)
                loc_cCliente = ALLTRIM(THIS.LerColunaLookup(loc_cCursorNota, "clifors"))
            ENDIF
            THIS.FecharCursorTemporario(loc_cCursorNota)
        ENDIF

        IF !EMPTY(loc_cCliente)
            IF THIS.CarregarListaLookup(loc_cCursor, ;
                    "SELECT emails FROM SigCdCli WHERE RTRIM(iclis) = " + ;
                    EscaparSQL(loc_cCliente))
                SELECT (loc_cCursor)
                GO TOP
                loc_cEmail = ALLTRIM(THIS.LerColunaLookup(loc_cCursor, "emails"))
            ENDIF

            THIS.FecharCursorTemporario(loc_cCursor)
        ENDIF

        RETURN loc_cEmail
    ENDFUNC

    *==========================================================================
    * BOTOES "Cancela Nota" / "Carta de Correcao" (legado Fwbtnm3 / Fwbtnm4)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdCancelarNotaClick - "Do Form SigOpNFd with Thisform.parentform,
    * thisform, thisform.DataSessionId, 'CAN'" do Fwbtnm3 legado.
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelarNotaClick()
        THIS.AbrirDialogoNfd("CAN", "cancelar a Nota Fiscal")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCartaCorrecaoClick - "Do Form SigOpNFd with ... , 'CAR'" do Fwbtnm4
    * legado (o Click dele tem essa UNICA linha).
    *--------------------------------------------------------------------------
    PROCEDURE CmdCartaCorrecaoClick()
        THIS.AbrirDialogoNfd("CAR", "emitir a Carta de Corre" + CHR(231) + ;
            CHR(227) + "o da Nota Fiscal")
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirDialogoNfd - funil dos dois botoes acima: no legado os dois abrem
    * o MESMO form (SigOpNFd), mudando so o 4o parametro ('CAN' = cancelar,
    * 'CAR' = carta de correcao).
    *
    * SigOpNFd ainda NAO foi migrado (nao existe Formsigopnfd.prg nem entrada
    * no indice de classes). Transcrever "DO FORM SigOpNFd" nao abriria nada:
    * o projeto novo nao tem .SCX, entao o comando falharia procurando
    * "sigopnfd.scx" e o botao ficaria inerte. Como as duas acoes alteram a
    * situacao FISCAL da nota (cancelamento e carta de correcao sao eventos
    * transmitidos a SEFAZ), fingir que ocorreram seria pior: avisa.
    *
    * Ao migrar SigOpNFd, trocar o aviso por
    *   loc_oForm = CREATEOBJECT("<FormSigOpNFd>", THIS.this_oFormPai, THIS,
    *                            THIS.DataSessionId, par_cModo)
    * e o Show() FORA do TRY (regra CLAUDE.md #29), como em
    * AbrirTelaEtiquetasProduto().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirDialogoNfd(par_cModo, par_cAcao)
        THIS.AvisarLegadoNaoPortado("tela SigOpNFd (modo " + par_cModo + ")", ;
            par_cAcao)
    ENDPROC

    *==========================================================================
    * BOTAO "Executa Processos NFCe" (legado Fwbtnm5)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdProcessosNfceClick - corpo do Fwbtnm5.Click legado:
    *
    *   IF INLIST(crSigCdope.cupfis, 5)
    *       =fEnviaCtg()
    *   ENDIF
    *
    * O restante do Click esta COMENTADO no dump (*!*, linhas 7054-7104):
    * era a versao anterior, que falava direto com a DLL DarumaFramework, e
    * o comentario do proprio legado explica que virou funcao para poder ser
    * executada tambem na entrada do sistema.
    *
    * A guarda INLIST(cupfis, 5) e transcrita: fora de NFCe o botao nao faz
    * nada no legado, e tambem nao faz aqui. fEnviaCtg() nao veio no acervo -
    * ela transmite a SEFAZ as NFCe emitidas em contingencia offline. Fingir
    * esse envio sem de fato realiza-lo e pior que avisar a ausencia: a nota
    * ficaria sem confirmacao de transmissao e ninguem perceberia.
    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessosNfceClick()
        LOCAL loc_oErro, loc_nCupFis

        TRY
            loc_nCupFis = THIS.ObterCupomFiscalOperacao()

            IF INLIST(loc_nCupFis, 5)
                THIS.AvisarLegadoNaoPortado("fEnviaCtg()", ;
                    "transmitir as NFCe emitidas em conting" + CHR(234) + ;
                    "ncia offline")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CmdProcessosNfceClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOTAO "Gerar XML" (legado Fwbtnm6)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdGerarXmlClick - wrapper fino (corpo com RETURN antecipado).
    *--------------------------------------------------------------------------
    PROCEDURE CmdGerarXmlClick()
        LOCAL loc_oErro

        TRY
            THIS.CmdGerarXmlClickExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em CmdGerarXmlClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGerarXmlClickExec - corpo do Fwbtnm6.Click legado, INTEGRALMENTE
    * implementado (nao depende de nada que falte):
    *
    *   le pastas de SigCdEmp -> cria a pasta txt\ se nao existir (Mkdir
    *   dentro de Try/Catch, avisando a falha) -> exige nfeprt preenchido
    *   ("Nao existe registro de envio desta nota para a SEFAZ.") -> grava os
    *   quatro blobs -> MessageBox([Arquivo Gerado.])
    *
    * O resto do Click do dump (envio por FTP a transportadora) esta todo
    * COMENTADO no legado - nao e funcionalidade ativa e por isso nao entra.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CmdGerarXmlClickExec()
        LOCAL loc_cPasta, loc_cCursor, loc_cNfeprt, loc_cAnexos, loc_nAnexos
        LOCAL loc_oErro

        loc_cAnexos = ""
        loc_nAnexos = 0
        loc_cPasta = THIS.ObterPastaNfe()

        IF EMPTY(loc_cPasta)
            MsgErro("A pasta de arquivos de NF-e n" + CHR(227) + "o est" + CHR(225) + ;
                " configurada no cadastro da empresa (SigCdEmp.pastas).", ;
                "Gerar XML")
            RETURN
        ENDIF

        *-- "If Not Empty(lcPasta) And Not Directory(lcPasta) / Try / Mkdir ..."
        IF !DIRECTORY(loc_cPasta)
            TRY
                MKDIR (loc_cPasta)
            CATCH TO loc_oErro
                MsgAviso("Erro na Cria" + CHR(231) + CHR(227) + ;
                    "o da Pasta " + CHR(34) + UPPER(ALLTRIM(loc_cPasta)) + CHR(34) + ": " + ;
                    loc_oErro.Message, "Aviso")
            ENDTRY

            IF !DIRECTORY(loc_cPasta)
                RETURN
            ENDIF
        ENDIF

        loc_cCursor = "cursor_4c_XmlFis"

        IF !THIS.AbrirCursorNota("nfechv, nfeprt, nfetxt, nfexml, canxml, nfepdf", ;
                loc_cCursor)
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registro desta nota.", ;
                "Gerar XML")
            RETURN
        ENDIF

        loc_cNfeprt = ALLTRIM(THIS.LerColunaLookup(loc_cCursor, "nfeprt"))

        IF EMPTY(loc_cNfeprt)
            THIS.FecharCursorTemporario(loc_cCursor)
            MsgAviso("N" + CHR(227) + "o existe registro de envio desta nota " + ;
                "para a SEFAZ.", "Gerar XML")
            RETURN
        ENDIF

        loc_nAnexos = THIS.GerarAnexosNfe(loc_cCursor, loc_cPasta, @loc_cAnexos)

        THIS.FecharCursorTemporario(loc_cCursor)

        *-- "MessageBox([Arquivo Gerado.],0+64,[Atencao],500)"
        MsgInfo("Arquivo Gerado." + CHR(13) + ;
            TRANSFORM(loc_nAnexos) + " arquivo(s) em " + loc_cPasta, ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * BOTAO "Gerar NF-e" (legado Fwbtnm7)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdGerarNfeClick - "do form sigprnfe with crSigMvNfi.EmpDopNums" do
    * Fwbtnm7 legado (o resto do Click esta todo comentado no dump).
    *
    * SigPrNfe JA foi migrado como Formsigprnfe, cujo Init recebe
    * (par_cMovimentacao, par_cSerie, par_cOperas) - o legado passa apenas o
    * primeiro, que e o EmpDopNums. Aberto por CREATEOBJECT, nunca por
    * "DO FORM" (que procuraria um .SCX inexistente e deixaria a classe fora
    * do indice de carga sob demanda), e com Show() FORA do TRY, porque o
    * filho e modal (regra CLAUDE.md #29).
    *--------------------------------------------------------------------------
    PROCEDURE CmdGerarNfeClick()
        LOCAL loc_oForm, loc_oErro, loc_cChave

        loc_oForm  = .NULL.
        loc_cChave = THIS.MontarChaveOperacaoNota()

        IF EMPTY(loc_cChave)
            MsgAviso("A nota ainda n" + CHR(227) + "o foi gravada - n" + CHR(227) + ;
                "o h" + CHR(225) + " movimenta" + CHR(231) + CHR(227) + ;
                "o para gerar a NF-e.", "Gerar NF-e")
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("Formsigprnfe", loc_cChave)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir Processamento de NF-e")
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (containers/PageFrame) para
    * garantir que tudo fique visivel apos a montagem. PageFrame.Controls()
    * inclui as Pages, e Page.Controls() inclui os filhos delas - a mesma
    * recursao cobre os dois niveis sem tratamento especial.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FASE 7/8 - CHAVE DO MOVIMENTO, CARGA DO REGISTRO, FormParaBO()/BOParaForm()
    *==========================================================================

    *--------------------------------------------------------------------------
    * PrepararChaveMovimento - copia Emps/Dopes/Numes de TprMvCab (cabecalho
    * do movimento, mantido pelo form PAI) para this_oBusinessObject, e repete
    * a chave (this_cCidchaves) que o Init recebeu. Tem de rodar ANTES de
    * ConfigurarPageFrame(): CarregarEstadoFiscal() (chamada por ele) ja le
    * this_oBusinessObject.this_cDopes para decidir llFiltraCfo/NfServicos.
    *
    * Sem TprMvCab alcancavel (form sem pai nesta sessao, ou teste headless)
    * o BO fica com Emps/Dopes/Numes vazios - mesma limitacao de
    * GravarNoMovimento, que ja avisa isso uma vez quando grava de volta.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararChaveMovimento()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cCidchaves = ALLTRIM(NVL(THIS.this_cCidchaves, ""))

                IF USED("TprMvCab")
                    THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(TratarNulo(TprMvCab.Emps, ""))
                    THIS.this_oBusinessObject.this_cDopes = ALLTRIM(TratarNulo(TprMvCab.Dopes, ""))
                    THIS.this_oBusinessObject.this_nNumes = TratarNulo(TprMvCab.Numes, 0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PrepararChaveMovimento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarRegistroAtual - decide INCLUIR x ALTERAR/VISUALIZAR a partir de
    * this_cCidchaves (equivalente ao form pai ja ter gravado - ou nao - o
    * registro antes de abrir esta sub-tela): achando, carrega via
    * CarregarPorCidchaves() e entra em EditarRegistro(); senao, NovoRegistro()
    * (defaults ja sao os da declaracao da classe - propriedades 0/""/{}).
    * Finaliza espelhando o BO nos controles (BOParaForm) e, so quando achou
    * registro existente, re-resolvendo as descricoes derivadas que o BO NAO
    * persiste (CFOP/Transportadora/Municipio - PreencherDescricoesDerivadas).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarRegistroAtual()
        LOCAL loc_lAchou, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lAchou = .F.

                IF !EMPTY(ALLTRIM(THIS.this_cCidchaves)) AND ;
                        TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    loc_lAchou = THIS.this_oBusinessObject.CarregarPorCidchaves()
                ENDIF

                IF loc_lAchou
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.PreencherDescricoesDerivadas()
                ELSE
                    THIS.this_oBusinessObject.NovoRegistro()
                ENDIF

                THIS.BOParaForm()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarRegistroAtual")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherDescricoesDerivadas - reconstitui, a partir dos CODIGOS que
    * acabaram de ser carregados do banco, as descricoes/dados derivados que
    * o BO NAO persiste (this_cD*, this_cEndTransp/CidTransp/UfTransp,
    * this_cMunServ/UfServ) - no legado eles viviam no cursor global
    * crSigMvNfi/crListaRemota, que nao sobrevive entre uma abertura e outra
    * desta arquitetura. Usa as MESMAS tabelas que os lookups da Fase 7
    * (SigCdCfo/SigPrTrp/SigCdMun/SigCdUfs) - nunca uma tabela nova (regra
    * CLAUDE.md #48).
    *
    * Beneficio Fiscal (SigCdBfj?) e Servico Municipal NAO entram aqui: o
    * legado monta esses dois dominios em cursores LOCAIS (crBeneficioRJ/
    * crSrvMuns) via fBeneficio_RJ()/fCodMunicipal() - funcoes do SIGFUNCS.PRG
    * legado que nao vieram no acervo e sem tabela equivalente conferida em
    * docs/schema.sql (ver AbrirLookupBeneficioExec/AbrirLookupServicoMunicipal).
    * Apontar para outra tabela violaria o PILAR 2 - a ausencia fica visivel
    * (this_cDCodbenefs/this_cDCodsrvfis permanecem em branco ao reabrir).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencherDescricoesDerivadas()
        LOCAL loc_oBO, loc_cCursor, loc_cSQL, loc_oErro

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                *-- CFOP de movimentacao / substituicao (mesma fonte do
                *-- lookup - AbrirLookupCfopExec).
                IF !EMPTY(ALLTRIM(loc_oBO.this_cCFis))
                    loc_oBO.this_cDClFiscal = THIS.ConsultarColunaUnica( ;
                        "CASE WHEN LTRIM(RTRIM(ISNULL(desc2s,''))) = '' THEN descricaos ELSE desc2s END", ;
                        "SigCdCfo", "codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cCFis)))
                ENDIF

                IF !EMPTY(ALLTRIM(loc_oBO.this_cCfoSubs))
                    loc_oBO.this_cDCfoSubs = THIS.ConsultarColunaUnica( ;
                        "CASE WHEN LTRIM(RTRIM(ISNULL(desc2s,''))) = '' THEN descricaos ELSE desc2s END", ;
                        "SigCdCfo", "codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cCfoSubs)))
                ENDIF

                *-- Transportadora (mesma fonte do lookup -
                *-- AbrirLookupTransportadoraExec).
                IF !EMPTY(ALLTRIM(loc_oBO.this_cCodTrans))
                    loc_cCursor = "cursor_4c_CarregaTrp"
                    loc_cSQL = "SELECT razaos, endes, cidas, estas FROM SigPrTrp WHERE itras = " + ;
                        EscaparSQL(ALLTRIM(loc_oBO.this_cCodTrans))

                    IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                        loc_oBO.this_cDTransp   = THIS.LerColunaLookup(loc_cCursor, "razaos")
                        loc_oBO.this_cEndTransp = THIS.LerColunaLookup(loc_cCursor, "endes")
                        loc_oBO.this_cCidTransp = THIS.LerColunaLookup(loc_cCursor, "cidas")
                        loc_oBO.this_cUfTransp  = THIS.LerColunaLookup(loc_cCursor, "estas")
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF

                *-- Municipio/UF da prestacao de servico - restaurados a partir
                *-- do codigo IBGE persistido (this_cPrestservs, mesma fonte do
                *-- lookup - AbrirLookupMunicipioExec); UF/Municipio da tela sao
                *-- so exibicao (ControlSource = "" no dump).
                IF !EMPTY(ALLTRIM(loc_oBO.this_cPrestservs))
                    loc_cCursor = "cursor_4c_CarregaMun"
                    loc_cSQL = "SELECT a.descs AS munici, b.estados AS estados" + ;
                        " FROM SigCdMun a INNER JOIN SigCdUfs b ON a.ufibges = b.UFIBGEs" + ;
                        " WHERE a.codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cPrestservs))

                    IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
                        loc_oBO.this_cMunServ = THIS.LerColunaLookup(loc_cCursor, "munici")
                        loc_oBO.this_cUfServ  = THIS.LerColunaLookup(loc_cCursor, "estados")
                    ENDIF

                    THIS.FecharCursorTemporario(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PreencherDescricoesDerivadas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConsultarColunaUnica - devolve UMA coluna/expressao de UMA linha
    * filtrada por par_cWhere (sem a palavra WHERE, ja escapado pelo
    * chamador), ou "" quando nao resolve. Mesmo padrao de ObterConfigNumerica,
    * na versao texto.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarColunaUnica(par_cExpressao, par_cTabela, par_cWhere)
        LOCAL loc_cCursor, loc_cSQL, loc_cValor
        loc_cValor  = ""
        loc_cCursor = "cursor_4c_ColUnica"

        loc_cSQL = "SELECT " + par_cExpressao + " AS valorunico FROM " + par_cTabela
        IF VARTYPE(par_cWhere) = "C" AND !EMPTY(par_cWhere)
            loc_cSQL = loc_cSQL + " WHERE " + par_cWhere
        ENDIF

        IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
            loc_cValor = THIS.LerColunaLookup(loc_cCursor, "valorunico")
        ENDIF

        THIS.FecharCursorTemporario(loc_cCursor)

        RETURN loc_cValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * CopiarControleParaBO / CopiarBOParaControle - par generico que liga UM
    * controle a UMA property do BO por NOME, usado por FormParaBO()/
    * BOParaForm() para os ~70 campos de mapeamento direto (sem regra
    * especial). STORE ... TO (expressao) para ATRIBUIR e EVALUATE() para LER
    * por nome (regra CLAUDE.md #15) - nunca "=" dentro da string montada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CopiarControleParaBO(par_cCaminho, par_cPropriedadeBO)
        LOCAL loc_oCtrl

        loc_oCtrl = THIS.ResolverControle(par_cCaminho)

        IF VARTYPE(loc_oCtrl) = "O" AND VARTYPE(THIS.this_oBusinessObject) = "O"
            STORE loc_oCtrl.Value TO ("THIS.this_oBusinessObject." + par_cPropriedadeBO)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE CopiarBOParaControle(par_cPropriedadeBO, par_cCaminho)
        LOCAL loc_uValor

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_uValor = EVALUATE("THIS.this_oBusinessObject." + par_cPropriedadeBO)
            THIS.AtribuirValorCampo(par_cCaminho, loc_uValor)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - espelha TODOS os controles ligados a crSigMvNfi (dump
    * legado - ver ControlSource de cada objeto em
    * tasks/task742/sigopfis_form_codigo_fonte.txt) nas properties do
    * sigopfisBO, na mesma ordem dos blocos de ConfigurarCamposForm()/
    * ConfigurarPaginaNotaFiscal()/ConfigurarPaginaServicos(). Chamado pelo
    * BtnConfirmarClickExec logo antes de Salvar().
    *
    * NAO mapeados (por desenho, nao por omissao):
    *   - txt_4c_PFrtIpi/PFrtIcm/PSegIpi/PSegIcm/PDesIpi/PDesIcm: percentuais
    *     TRANSIENTES do dump (ControlSource = "" no legado) - so alimentam os
    *     calculos de ConfigurarEventosCalculo(), nunca sao gravados.
    *   - txt_4c_Set_total (Pagina Servicos): soma exibida, ControlSource="".
    *   - txt_4c_Uf/txt_4c_Mun (Pagina Servicos): ControlSource="" no legado -
    *     so this_cPrestservs (IBGE) e persistido, via AbrirLookupMunicipioExec.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro, loc_oTxt, loc_nSoma

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

            *-- Campos diretos do form
            THIS.CopiarControleParaBO("txt_4c_Serie",     "this_cSeries")
            THIS.CopiarControleParaBO("txt_4c_Nota",      "this_cNFis")
            THIS.CopiarControleParaBO("txt_4c_Especie",   "this_cEspecieNFs")
            THIS.CopiarControleParaBO("txt_4c_Emissao",   "this_dEmis")
            THIS.CopiarControleParaBO("txt_4c_Saidas",    "this_dDtSaidas")
            THIS.CopiarControleParaBO("txt_4c_Selo",      "this_nSelos")
            THIS.CopiarControleParaBO("txt_4c_ClFiscal",  "this_cCFis")
            THIS.CopiarControleParaBO("txt_4c_DClFiscal", "this_cDClFiscal")
            THIS.CopiarControleParaBO("txt_4c_CfoSubs",   "this_cCfoSubs")
            THIS.CopiarControleParaBO("txt_4c_DCfoSub",   "this_cDCfoSubs")

            *-- Pagina "Nota Fiscal" (pgf_4c_1.Page1) - impostos/totais
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_BaseIPI",        "this_nBasecIpis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_ValorIPI",       "this_nValIpis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_BaseIpiIsento",  "this_nBasecIp2s")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_BaseIpiOutras",  "this_nBasecip3s")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_IpiNCred",       "this_nIpiNCreds")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_BaseICMS",       "this_nBasecIcms")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_ValorICMS",      "this_nValIcms")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_BaseIcmIsen",    "this_nBasecic2s")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_BaseIcmOutras",  "this_nBasecic3s")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_BcIcmss",        "this_nBcicmss")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Icmss",          "this_nIcmss")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_TotalProds",     "this_nTotProds")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_TotalNf",        "this_nTotNotas")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Chave",          "this_cNfechv")

            *-- Frete/Seguro/Despesas (valor + ICMS/IPI calculados) e observacoes
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_TFrete",    "this_nVlFretes")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_FrtIpi",    "this_nFrtIpis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_FrtIcm",    "this_nFrtIcms")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_ObsFrete",  "this_cObsFretes")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_ChaveC",    "this_cNfechvc")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_TSeguros",  "this_nVlSeguros")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_SegIpi",    "this_nSegIpis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_SegIcm",    "this_nSegIcms")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_ObsPLiq",   "this_cObspliqs")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_DespAces",  "this_nDespAces")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_DesIpi",    "this_nDesIpis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_DesIcm",    "this_nDesIcms")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_ObsPBru",   "this_cObspbrus")

            *-- Transportadora/Volumes
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.cbo_4c_Frete",     "this_nFretes")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Transp",   "this_cCodTrans")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Nome",     "this_cDTransp")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Placa",    "this_cPlacas")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_UfPlaca",  "this_cUfPlacas")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Cidade",   "this_cCidTransp")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Estado",   "this_cUfTransp")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Endereco", "this_cEndTransp")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Obss",         "this_cObss")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Quantidade",   "this_nQtdes")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_EspecieVol",  "this_cEspes")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Marca",       "this_cMarcas")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_Numero",      "this_cNumeros")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_PesoLiq",     "this_nPLiqs")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_PesoBruto",   "this_nPBrus")

            *-- DI (Declaracao de Importacao)
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_DI",       "this_cNdis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_DRegDI",   "this_dDregdis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page1.txt_4c_DDesemb",  "this_dDdesembs")

            *-- Desconto (TprMvCab.ValVars no legado - NAO eh coluna de
            *-- SigMvNfi, por isso vai para o movimento via GravarNoMovimento,
            *-- nao para o BO).
            loc_oTxt = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_Desconto")
            IF VARTYPE(loc_oTxt) = "O"
                THIS.GravarNoMovimento("ValVars", loc_oTxt.Value)
            ENDIF

            *-- Pagina "Servicos" (pgf_4c_1.Page2)
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.cbo_4c_Get_tptribsers", "this_nTptribsers")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Cbene",         "this_cCodbenefs")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Dbene",         "this_cDCodbenefs")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c__csrvfis",      "this_cCodsrvfis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c__dsrvfis",      "this_cDCodsrvfis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Vdedu",         "this_nVdeducoes")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c__vdscc",        "this_nVdscconds")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c__vdsvi",        "this_nVdsciconds")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c__outretens",    "this_nOutretens")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.cbo_4c_Get_tiponfs",   "this_cTiponfs")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Fwget1",        "this_nVtotiss")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Fwget2",        "this_nVirf")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Fwget3",        "this_nVinss")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Fwget4",        "this_nVpis")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Fwget5",        "this_nVcsll")
            THIS.CopiarControleParaBO("pgf_4c_1.Page2.txt_4c_Fwget6",        "this_nVcofins")

            *-- ISS Retido: OptionGroup 1-based na tela, coluna 0-based no banco
            *-- (legado: "This.Value = issretidos+1" / "issretidos with this.Value-1").
            loc_oTxt = THIS.ResolverControle("pgf_4c_1.Page2.obj_4c_Op_IssRetido")
            IF VARTYPE(loc_oTxt) = "O"
                THIS.this_oBusinessObject.this_nIssretidos = MAX(loc_oTxt.Value - 1, 0)
            ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - caminho inverso de FormParaBO(), chamado por
    * CarregarRegistroAtual() apos NovoRegistro()/EditarRegistro() (regra:
    * BOParaForm roda SEMPRE, inclusive em INCLUIR, para aplicar os defaults
    * 0/""/{} da classe - equivalente ao form legado abrir com o cursor ja
    * posicionado no registro, novo ou existente).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro, loc_oTxt, loc_nSoma

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

            THIS.CopiarBOParaControle("this_cSeries",      "txt_4c_Serie")
            THIS.CopiarBOParaControle("this_cNFis",         "txt_4c_Nota")
            THIS.CopiarBOParaControle("this_cEspecieNFs",   "txt_4c_Especie")
            THIS.CopiarBOParaControle("this_dEmis",         "txt_4c_Emissao")
            THIS.CopiarBOParaControle("this_dDtSaidas",     "txt_4c_Saidas")
            THIS.CopiarBOParaControle("this_nSelos",        "txt_4c_Selo")
            THIS.CopiarBOParaControle("this_cCFis",         "txt_4c_ClFiscal")
            THIS.CopiarBOParaControle("this_cDClFiscal",    "txt_4c_DClFiscal")
            THIS.CopiarBOParaControle("this_cCfoSubs",      "txt_4c_CfoSubs")
            THIS.CopiarBOParaControle("this_cDCfoSubs",     "txt_4c_DCfoSub")

            THIS.CopiarBOParaControle("this_nBasecIpis",  "pgf_4c_1.Page1.txt_4c_BaseIPI")
            THIS.CopiarBOParaControle("this_nValIpis",    "pgf_4c_1.Page1.txt_4c_ValorIPI")
            THIS.CopiarBOParaControle("this_nBasecIp2s",  "pgf_4c_1.Page1.txt_4c_BaseIpiIsento")
            THIS.CopiarBOParaControle("this_nBasecip3s",  "pgf_4c_1.Page1.txt_4c_BaseIpiOutras")
            THIS.CopiarBOParaControle("this_nIpiNCreds",  "pgf_4c_1.Page1.txt_4c_IpiNCred")
            THIS.CopiarBOParaControle("this_nBasecIcms",  "pgf_4c_1.Page1.txt_4c_BaseICMS")
            THIS.CopiarBOParaControle("this_nValIcms",    "pgf_4c_1.Page1.txt_4c_ValorICMS")
            THIS.CopiarBOParaControle("this_nBasecic2s",  "pgf_4c_1.Page1.txt_4c_BaseIcmIsen")
            THIS.CopiarBOParaControle("this_nBasecic3s",  "pgf_4c_1.Page1.txt_4c_BaseIcmOutras")
            THIS.CopiarBOParaControle("this_nBcicmss",    "pgf_4c_1.Page1.txt_4c_BcIcmss")
            THIS.CopiarBOParaControle("this_nIcmss",      "pgf_4c_1.Page1.txt_4c_Icmss")
            THIS.CopiarBOParaControle("this_nTotProds",   "pgf_4c_1.Page1.txt_4c_TotalProds")
            THIS.CopiarBOParaControle("this_nTotNotas",   "pgf_4c_1.Page1.txt_4c_TotalNf")
            THIS.CopiarBOParaControle("this_cNfechv",     "pgf_4c_1.Page1.txt_4c_Chave")

            THIS.CopiarBOParaControle("this_nVlFretes",   "pgf_4c_1.Page1.txt_4c_TFrete")
            THIS.CopiarBOParaControle("this_nFrtIpis",    "pgf_4c_1.Page1.txt_4c_FrtIpi")
            THIS.CopiarBOParaControle("this_nFrtIcms",    "pgf_4c_1.Page1.txt_4c_FrtIcm")
            THIS.CopiarBOParaControle("this_cObsFretes",  "pgf_4c_1.Page1.txt_4c_ObsFrete")
            THIS.CopiarBOParaControle("this_cNfechvc",    "pgf_4c_1.Page1.txt_4c_ChaveC")
            THIS.CopiarBOParaControle("this_nVlSeguros",  "pgf_4c_1.Page1.txt_4c_TSeguros")
            THIS.CopiarBOParaControle("this_nSegIpis",    "pgf_4c_1.Page1.txt_4c_SegIpi")
            THIS.CopiarBOParaControle("this_nSegIcms",    "pgf_4c_1.Page1.txt_4c_SegIcm")
            THIS.CopiarBOParaControle("this_cObspliqs",   "pgf_4c_1.Page1.txt_4c_ObsPLiq")
            THIS.CopiarBOParaControle("this_nDespAces",   "pgf_4c_1.Page1.txt_4c_DespAces")
            THIS.CopiarBOParaControle("this_nDesIpis",    "pgf_4c_1.Page1.txt_4c_DesIpi")
            THIS.CopiarBOParaControle("this_nDesIcms",    "pgf_4c_1.Page1.txt_4c_DesIcm")
            THIS.CopiarBOParaControle("this_cObspbrus",   "pgf_4c_1.Page1.txt_4c_ObsPBru")

            THIS.CopiarBOParaControle("this_nFretes",     "pgf_4c_1.Page1.cbo_4c_Frete")
            THIS.CopiarBOParaControle("this_cCodTrans",   "pgf_4c_1.Page1.txt_4c_Transp")
            THIS.CopiarBOParaControle("this_cDTransp",    "pgf_4c_1.Page1.txt_4c_Nome")
            THIS.CopiarBOParaControle("this_cPlacas",     "pgf_4c_1.Page1.txt_4c_Placa")
            THIS.CopiarBOParaControle("this_cUfPlacas",   "pgf_4c_1.Page1.txt_4c_UfPlaca")
            THIS.CopiarBOParaControle("this_cCidTransp",  "pgf_4c_1.Page1.txt_4c_Cidade")
            THIS.CopiarBOParaControle("this_cUfTransp",   "pgf_4c_1.Page1.txt_4c_Estado")
            THIS.CopiarBOParaControle("this_cEndTransp",  "pgf_4c_1.Page1.txt_4c_Endereco")
            THIS.CopiarBOParaControle("this_cObss",       "pgf_4c_1.Page1.txt_4c_Obss")
            THIS.CopiarBOParaControle("this_nQtdes",      "pgf_4c_1.Page1.txt_4c_Quantidade")
            THIS.CopiarBOParaControle("this_cEspes",      "pgf_4c_1.Page1.txt_4c_EspecieVol")
            THIS.CopiarBOParaControle("this_cMarcas",     "pgf_4c_1.Page1.txt_4c_Marca")
            THIS.CopiarBOParaControle("this_cNumeros",    "pgf_4c_1.Page1.txt_4c_Numero")
            THIS.CopiarBOParaControle("this_nPLiqs",      "pgf_4c_1.Page1.txt_4c_PesoLiq")
            THIS.CopiarBOParaControle("this_nPBrus",      "pgf_4c_1.Page1.txt_4c_PesoBruto")

            THIS.CopiarBOParaControle("this_cNdis",       "pgf_4c_1.Page1.txt_4c_DI")
            THIS.CopiarBOParaControle("this_dDregdis",    "pgf_4c_1.Page1.txt_4c_DRegDI")
            THIS.CopiarBOParaControle("this_dDdesembs",   "pgf_4c_1.Page1.txt_4c_DDesemb")

            *-- Desconto - le direto de TprMvCab (campo do movimento, nao do BO).
            IF USED("TprMvCab")
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_Desconto", TprMvCab.ValVars)
            ENDIF

            THIS.CopiarBOParaControle("this_nTptribsers", "pgf_4c_1.Page2.cbo_4c_Get_tptribsers")
            THIS.CopiarBOParaControle("this_cCodbenefs",  "pgf_4c_1.Page2.txt_4c_Cbene")
            THIS.CopiarBOParaControle("this_cDCodbenefs", "pgf_4c_1.Page2.txt_4c_Dbene")
            THIS.CopiarBOParaControle("this_cCodsrvfis",  "pgf_4c_1.Page2.txt_4c__csrvfis")
            THIS.CopiarBOParaControle("this_cDCodsrvfis", "pgf_4c_1.Page2.txt_4c__dsrvfis")
            THIS.CopiarBOParaControle("this_nVdeducoes",  "pgf_4c_1.Page2.txt_4c_Vdedu")
            THIS.CopiarBOParaControle("this_nVdscconds",  "pgf_4c_1.Page2.txt_4c__vdscc")
            THIS.CopiarBOParaControle("this_nVdsciconds", "pgf_4c_1.Page2.txt_4c__vdsvi")
            THIS.CopiarBOParaControle("this_nOutretens",  "pgf_4c_1.Page2.txt_4c__outretens")
            THIS.CopiarBOParaControle("this_cTiponfs",    "pgf_4c_1.Page2.cbo_4c_Get_tiponfs")
            THIS.CopiarBOParaControle("this_nVtotiss",    "pgf_4c_1.Page2.txt_4c_Fwget1")
            THIS.CopiarBOParaControle("this_nVirf",       "pgf_4c_1.Page2.txt_4c_Fwget2")
            THIS.CopiarBOParaControle("this_nVinss",      "pgf_4c_1.Page2.txt_4c_Fwget3")
            THIS.CopiarBOParaControle("this_nVpis",       "pgf_4c_1.Page2.txt_4c_Fwget4")
            THIS.CopiarBOParaControle("this_nVcsll",      "pgf_4c_1.Page2.txt_4c_Fwget5")
            THIS.CopiarBOParaControle("this_nVcofins",    "pgf_4c_1.Page2.txt_4c_Fwget6")

            *-- set_total (Pagina Servicos) - soma exibida, nunca gravada
            *-- (legado: "set_total.Value = vcofins+vcsll+vinss+virf+vpis+vtotiss").
            loc_nSoma = THIS.this_oBusinessObject.this_nVcofins + ;
                THIS.this_oBusinessObject.this_nVcsll + ;
                THIS.this_oBusinessObject.this_nVinss + ;
                THIS.this_oBusinessObject.this_nVirf + ;
                THIS.this_oBusinessObject.this_nVpis + ;
                THIS.this_oBusinessObject.this_nVtotiss
            THIS.AtribuirValorCampo("pgf_4c_1.Page2.txt_4c_Set_total", loc_nSoma)

            *-- ISS Retido: coluna 0-based no banco, OptionGroup 1-based na
            *-- tela (regra OptionGroup.Value = indice, nunca ButtonsValue).
            loc_oTxt = THIS.ResolverControle("pgf_4c_1.Page2.obj_4c_Op_IssRetido")
            IF VARTYPE(loc_oTxt) = "O"
                loc_oTxt.Value = THIS.this_oBusinessObject.this_nIssretidos + 1
                loc_oTxt.Refresh()
            ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CALCULO FISCAL - Frete / Seguro / Despesas Acessorias (regra CLAUDE.md
    * #17 - formula TRANSCRITA, nunca reescrita). Os tres grupos de campos do
    * dump legado (Get_TFrete/Get_TSeguros/Get_DespAces, Valid+LostFocus, e os
    * seis percentuais Get_PfrtIcm/Get_PfrtIPI/Get_pSegIcm/Get_pSegIpi/
    * Get_pDesIcm/Get_pDesIpi, Valid) operam so sobre CONTROLES - os valores
    * so chegam ao BO em FormParaBO(), no Confirmar.
    *
    * Ligados em "LostFocus" (nao "Valid" - BINDEVENT em Valid de TextBox NAO
    * e confiavel, regra CLAUDE.md). O recalculo de TotNotas que o LostFocus
    * legado faz depende de ThisForm.Totalnota/crSigCdOpe.NFiscals - estado do
    * form PAI que nao existe aqui; o total oficial e recalculado no
    * Confirmar via AtualizarTotaisMovimento()/RecalcularTotalMovimento(), que
    * e o ponto de gravacao - por isso NAO reproduzido campo a campo aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosCalculo()
        LOCAL loc_oErro

        TRY
            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_TFrete",   "TFreteLostFocus")
            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_TSeguros", "TSegurosLostFocus")
            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_DespAces", "DespAcesLostFocus")

            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_PFrtIcm", "PFrtIcmLostFocus")
            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_PFrtIpi", "PFrtIpiLostFocus")
            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_PSegIcm", "PSegIcmLostFocus")
            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_PSegIpi", "PSegIpiLostFocus")
            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_PDesIcm", "PDesIcmLostFocus")
            THIS.LigarEventoCalculo("pgf_4c_1.Page1.txt_4c_PDesIpi", "PDesIpiLostFocus")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventosCalculo")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LigarEventoCalculo(par_cCaminho, par_cHandler)
        LOCAL loc_oTxt

        loc_oTxt = THIS.ResolverControle(par_cCaminho)

        IF VARTYPE(loc_oTxt) = "O" AND PEMSTATUS(THIS, par_cHandler, 5)
            BINDEVENT(loc_oTxt, "LostFocus", THIS, par_cHandler)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TFreteLostFocus/TSegurosLostFocus/DespAcesLostFocus - equivalente ao
    * Valid de Get_TFrete/Get_TSeguros/Get_DespAces: zera o ICMS/IPI
    * proporcional quando o valor base fica zero (TFrete tambem limpa a
    * observacao automatica quando deixa de ser zero - unico dos tres com
    * esse bloco no dump).
    *--------------------------------------------------------------------------
    PROCEDURE TFreteLostFocus()
        LOCAL loc_oTxt, loc_oErro

        TRY
            loc_oTxt = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_TFrete")

            IF VARTYPE(loc_oTxt) = "O"
                IF loc_oTxt.Value = 0
                    THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_FrtIcm", 0)
                    THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_FrtIpi", 0)
                ELSE
                    THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_ObsFrete", "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em TFreteLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TSegurosLostFocus()
        LOCAL loc_oTxt, loc_oErro

        TRY
            loc_oTxt = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_TSeguros")

            IF VARTYPE(loc_oTxt) = "O" AND loc_oTxt.Value = 0
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_SegIcm", 0)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_SegIpi", 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em TSegurosLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE DespAcesLostFocus()
        LOCAL loc_oTxt, loc_oErro

        TRY
            loc_oTxt = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_DespAces")

            IF VARTYPE(loc_oTxt) = "O" AND loc_oTxt.Value = 0
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_DesIcm", 0)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_DesIpi", 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em DespAcesLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PFrtIcmLostFocus - Get_PfrtIcm.Valid: xValFrt = IpiBaseIcm ?
    * (VlFretes+FrtIpi) : VlFretes; FrtIcm = Round(xValFrt * %/100, 2); limpa
    * ObsFrete.
    *--------------------------------------------------------------------------
    PROCEDURE PFrtIcmLostFocus()
        LOCAL loc_oPct, loc_oFrete, loc_oFrtIpi, loc_nBase, loc_nValor, loc_oErro

        TRY
            loc_oPct = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PFrtIcm")

            IF VARTYPE(loc_oPct) = "O" AND loc_oPct.Value != 0
                loc_oFrete  = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_TFrete")
                loc_oFrtIpi = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_FrtIpi")

                IF THIS.this_lIpiBaseIcm
                    loc_nBase = NVL(loc_oFrete.Value, 0) + NVL(loc_oFrtIpi.Value, 0)
                ELSE
                    loc_nBase = NVL(loc_oFrete.Value, 0)
                ENDIF

                loc_nValor = ROUND(loc_nBase * loc_oPct.Value / 100, 2)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_FrtIcm",   loc_nValor)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_ObsFrete", "")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PFrtIcmLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PFrtIpiLostFocus - Get_PfrtIPI.Valid: FrtIpi = Round(VlFretes * %/100,2);
    * se IpiBaseIcm e %Icm>0, FrtIcm = Round((VlFretes+FrtIpi)*%Icm/100,2) +
    * limpa ObsFrete.
    *--------------------------------------------------------------------------
    PROCEDURE PFrtIpiLostFocus()
        LOCAL loc_oPct, loc_oFrete, loc_oPctIcm, loc_oFrtIpi, loc_nValor, loc_oErro

        TRY
            loc_oPct = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PFrtIpi")

            IF VARTYPE(loc_oPct) = "O" AND loc_oPct.Value != 0
                loc_oFrete = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_TFrete")

                loc_nValor = ROUND(NVL(loc_oFrete.Value, 0) * loc_oPct.Value / 100, 2)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_FrtIpi", loc_nValor)

                loc_oPctIcm = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PFrtIcm")

                IF THIS.this_lIpiBaseIcm AND VARTYPE(loc_oPctIcm) = "O" AND loc_oPctIcm.Value > 0
                    loc_oFrtIpi = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_FrtIpi")
                    loc_nValor  = ROUND((NVL(loc_oFrete.Value, 0) + NVL(loc_oFrtIpi.Value, 0)) * ;
                        loc_oPctIcm.Value / 100, 2)
                    THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_FrtIcm",   loc_nValor)
                    THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_ObsFrete", "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PFrtIpiLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PSegIcmLostFocus - Get_pSegIcm.Valid: mesma formula de PFrtIcm, base
    * Seguro em vez de Frete.
    *--------------------------------------------------------------------------
    PROCEDURE PSegIcmLostFocus()
        LOCAL loc_oPct, loc_oSeguro, loc_oSegIpi, loc_nBase, loc_nValor, loc_oErro

        TRY
            loc_oPct = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PSegIcm")

            IF VARTYPE(loc_oPct) = "O" AND loc_oPct.Value != 0
                loc_oSeguro = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_TSeguros")
                loc_oSegIpi = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_SegIpi")

                IF THIS.this_lIpiBaseIcm
                    loc_nBase = NVL(loc_oSeguro.Value, 0) + NVL(loc_oSegIpi.Value, 0)
                ELSE
                    loc_nBase = NVL(loc_oSeguro.Value, 0)
                ENDIF

                loc_nValor = ROUND(loc_nBase * loc_oPct.Value / 100, 2)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_SegIcm", loc_nValor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PSegIcmLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PSegIpiLostFocus - Get_pSegIpi.Valid: mesma formula de PFrtIpi, base
    * Seguro em vez de Frete.
    *--------------------------------------------------------------------------
    PROCEDURE PSegIpiLostFocus()
        LOCAL loc_oPct, loc_oSeguro, loc_oPctIcm, loc_oSegIpi, loc_nValor, loc_oErro

        TRY
            loc_oPct = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PSegIpi")

            IF VARTYPE(loc_oPct) = "O" AND loc_oPct.Value != 0
                loc_oSeguro = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_TSeguros")

                loc_nValor = ROUND(NVL(loc_oSeguro.Value, 0) * loc_oPct.Value / 100, 2)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_SegIpi", loc_nValor)

                loc_oPctIcm = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PSegIcm")

                IF THIS.this_lIpiBaseIcm AND VARTYPE(loc_oPctIcm) = "O" AND loc_oPctIcm.Value > 0
                    loc_oSegIpi = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_SegIpi")
                    loc_nValor  = ROUND((NVL(loc_oSeguro.Value, 0) + NVL(loc_oSegIpi.Value, 0)) * ;
                        loc_oPctIcm.Value / 100, 2)
                    THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_SegIcm", loc_nValor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PSegIpiLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PDesIcmLostFocus - Get_pDesIcm.Valid: mesma formula de PFrtIcm, base
    * Despesas Acessorias em vez de Frete.
    *--------------------------------------------------------------------------
    PROCEDURE PDesIcmLostFocus()
        LOCAL loc_oPct, loc_oDesp, loc_oDesIpi, loc_nBase, loc_nValor, loc_oErro

        TRY
            loc_oPct = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PDesIcm")

            IF VARTYPE(loc_oPct) = "O" AND loc_oPct.Value != 0
                loc_oDesp   = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_DespAces")
                loc_oDesIpi = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_DesIpi")

                IF THIS.this_lIpiBaseIcm
                    loc_nBase = NVL(loc_oDesp.Value, 0) + NVL(loc_oDesIpi.Value, 0)
                ELSE
                    loc_nBase = NVL(loc_oDesp.Value, 0)
                ENDIF

                loc_nValor = ROUND(loc_nBase * loc_oPct.Value / 100, 2)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_DesIcm", loc_nValor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PDesIcmLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PDesIpiLostFocus - Get_pDesIpi.Valid: mesma formula de PFrtIpi, base
    * Despesas Acessorias em vez de Frete.
    *--------------------------------------------------------------------------
    PROCEDURE PDesIpiLostFocus()
        LOCAL loc_oPct, loc_oDesp, loc_oPctIcm, loc_oDesIpi, loc_nValor, loc_oErro

        TRY
            loc_oPct = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PDesIpi")

            IF VARTYPE(loc_oPct) = "O" AND loc_oPct.Value != 0
                loc_oDesp = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_DespAces")

                loc_nValor = ROUND(NVL(loc_oDesp.Value, 0) * loc_oPct.Value / 100, 2)
                THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_DesIpi", loc_nValor)

                loc_oPctIcm = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_PDesIcm")

                IF THIS.this_lIpiBaseIcm AND VARTYPE(loc_oPctIcm) = "O" AND loc_oPctIcm.Value > 0
                    loc_oDesIpi = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_DesIpi")
                    loc_nValor  = ROUND((NVL(loc_oDesp.Value, 0) + NVL(loc_oDesIpi.Value, 0)) * ;
                        loc_oPctIcm.Value / 100, 2)
                    THIS.AtribuirValorCampo("pgf_4c_1.Page1.txt_4c_DesIcm", loc_nValor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PDesIpiLostFocus")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopfisBO.prg):
*============================================================================
* sigopfisBO.prg - Business Object para Dados Fiscais da Nota Fiscal
*
* Tabela principal : SigMvNfi  (PK: cidchaves char(20))
* Ligacao mestre    : SigMvCab (FK composta: EmpDopNums char(29) = Emps+Dopes+Str(Numes,6))
* Lookup transporte  : SigPrTrp (PK: Itras,  desc: Razaos)
* Lookup CFO         : SigCdCfo (PK: Codigos)
* Lookup UF/Municipio : SigCdUfs (PK: Estados), SigCdMun (PK: Codigos/Munici)
* Lookup beneficio    : SigCdBfj / crBeneficioRJ (PK: codigos, desc: descrs)
* Lookup servico mun. : crSrvMuns (PK: codigos, desc: descrs)
*
* Este BO representa a aba "Dados Fiscais"/"Servicos" de uma Nota Fiscal,
* embutida como sub-pagina de um form de movimentacao maior (SigOpMvi e
* similares). O registro de SigMvNfi e gravado pelo form PAI (TableUpdate do
* cursor principal); este BO fornece as propriedades e as regras de calculo
* fiscal (impostos, servicos) referentes ao mesmo registro.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopfisBO AS BusinessBase

    *==========================================================================
    * Chave e ligacao com o movimento (SigMvCab) - cidchaves eh a PK de SigMvNfi;
    * EmpDopNums (Emps+Dopes+Str(Numes,6)) e a chave composta que liga ao
    * cabecalho do movimento (regra #42: NUNCA ALLTRIM nas partes internas).
    *==========================================================================
    this_cCidchaves  = ""   && char(20) - PK
    this_cEmpDopNums = ""   && char(29) - Emps(3) + Dopes(20) + Str(Numes,6)
    this_cEmps       = ""   && char(3)  - Empresa do movimento
    this_cDopes      = ""   && char(20) - Documento de operacao
    this_nNumes      = 0    && numeric(6,0) - Numero sequencial do movimento

    *==========================================================================
    * Cabecalho da Nota (Pagina Impostos - topo do form)
    *==========================================================================
    this_cNFis       = ""   && char(6)  - Numero da nota fiscal
    this_cSeries     = ""   && char(8)  - Serie da nota
    this_cEspecieNFs = ""   && char(6)  - Especie da nota
    this_dEmis       = {}   && datetime NULL - Data de emissao
    this_nSelos      = 0    && numeric(10,0) - Numero do selo fiscal
    this_dDtSaidas   = {}   && datetime NULL - Data de saida
    this_cCFis       = ""   && char(10) - CFOP de movimentacao
    this_cCfoSubs    = ""   && char(10) - CFOP de substituicao

    *==========================================================================
    * Impostos - IPI / ICMS (bases e valores)
    *==========================================================================
    this_nBasecIpis   = 0   && numeric(14,2) - Base de calculo do IPI
    this_nValIpis     = 0   && numeric(14,2) - Valor do IPI
    this_nBasecIcms   = 0   && numeric(14,2) - Base de calculo do ICMS
    this_nValIcms     = 0   && numeric(14,2) - Valor do ICMS
    this_nTotProds    = 0   && numeric(14,2) - Total dos produtos
    this_nTotNotas    = 0   && numeric(14,2) - Total da nota fiscal

    *==========================================================================
    * Impostos - Substituicao / Isento / Outras bases (ICMS e IPI)
    *==========================================================================
    this_nBcicmss      = 0  && numeric(15,2) - Base substituicao ICMS
    this_nIcmss        = 0  && numeric(15,2) - Valor substituicao ICMS
    this_nBasecic2s    = 0  && numeric(14,2) - Base ICMS isento
    this_nBasecic3s    = 0  && numeric(14,2) - Base ICMS outras
    this_nBasecIp2s    = 0  && numeric(14,2) - Base IPI isento
    this_nBasecip3s    = 0  && numeric(14,2) - Base IPI outras
    this_nIpiNCreds    = 0  && numeric(14,2) - IPI nao creditado

    *==========================================================================
    * Frete / Seguro / Despesas acessorias (valores e percentuais/bases ICMS/IPI)
    *==========================================================================
    this_nVlFretes   = 0    && numeric(14,2) - Valor do frete
    this_nVlSeguros  = 0    && numeric(14,2) - Valor do seguro
    this_nDespAces   = 0    && numeric(14,2) - Despesas acessorias
    this_nFrtIcms    = 0    && numeric(15,2) - ICMS sobre frete
    this_nFrtIpis    = 0    && numeric(15,2) - IPI sobre frete
    this_nSegIcms    = 0    && numeric(15,2) - ICMS sobre seguro
    this_nSegIpis    = 0    && numeric(15,2) - IPI sobre seguro
    this_nDesIcms    = 0    && numeric(15,2) - ICMS sobre despesas
    this_nDesIpis    = 0    && numeric(15,2) - IPI sobre despesas
    this_cObsFretes  = ""   && char(10) - Observacao do frete (preenchida quando % = 0)
    this_cObspliqs   = ""   && char(10) - Observacao peso liquido
    this_cObspbrus   = ""   && char(10) - Observacao peso bruto

    *==========================================================================
    * Transporte / Volumes
    *==========================================================================
    this_cCodTrans = ""     && char(10) - Codigo do transportador (SigPrTrp.Itras)
    this_nFretes   = 0      && numeric(1,0) - Modo de frete (ComboBox - indice 1-based)
    this_cPlacas   = ""     && char(8)  - Placa do veiculo
    this_cUfPlacas = ""     && char(2)  - UF da placa
    this_nQtdes    = 0      && numeric(6,0) - Quantidade de volumes
    this_cEspes    = ""     && char(10) - Especie dos volumes
    this_cMarcas   = ""     && char(10) - Marca dos volumes
    this_cNumeros  = ""     && char(10) - Numeracao dos volumes
    this_nPLiqs    = 0      && numeric(10,3) NULL - Peso liquido
    this_nPBrus    = 0      && numeric(10,3) NULL - Peso bruto
    this_cObss     = ""     && char(40) - Observacoes gerais

    *==========================================================================
    * NFe - Chave de acesso / DI (Declaracao de Importacao)
    *==========================================================================
    this_cNfechv  = ""      && char(44) - Chave de acesso da NFe
    this_cNfechvc = ""      && char(44) - Chave de acesso da NFe referenciada (NFe complementar)
    this_cNdis    = ""      && char(10) - Numero da DI
    this_dDregdis = {}      && datetime NULL - Data de registro da DI
    this_dDdesembs = {}     && datetime NULL - Data de desembaraco da DI

    *==========================================================================
    * Servicos (ISS/Simples Nacional - Pagina Servicos)
    *==========================================================================
    this_nTptribsers  = 0   && numeric(2,0) - Tipo de tributacao de servicos (RECNO de crTpTrib)
    this_cCodbenefs   = ""  && char(3)  - Codigo do beneficio fiscal
    this_cCodsrvfis   = ""  && char(6)  - Codigo do servico municipal
    this_nVdeducoes   = 0   && numeric(15,2) - Deducoes
    this_nVdscconds   = 0   && numeric(15,2) - Desconto condicionado
    this_nVdsciconds  = 0   && numeric(15,2) - Desconto incondicionado
    this_nOutretens   = 0   && numeric(15,2) - Outras retencoes
    this_nIssretidos  = 0   && numeric(1,0) - ISS retido (OptionGroup - indice 1-based)
    this_cTiponfs     = ""  && char(2)  - Tipo de nota (convencional/NFCe)
    this_nVtotiss     = 0   && numeric(14,2) - Total ISS (campo Fwget1)
    this_nVirf        = 0   && numeric(14,2) - Total IRRF (campo Fwget2)
    this_nVinss       = 0   && numeric(14,2) - Total INSS (campo Fwget3)
    this_nVpis        = 0   && numeric(14,2) - Total PIS (campo Fwget4)
    this_nVcsll       = 0   && numeric(14,2) - Total CSLL (campo Fwget5)
    this_nVcofins     = 0   && numeric(14,2) - Total COFINS (campo Fwget6)

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas diretamente no banco
    * (resultado de lookup, usados so para preencher a descricao na tela)
    *==========================================================================
    this_cDClFiscal  = ""   && Descricao do CFOP de movimentacao (SigCdCfo)
    this_cDCfoSubs   = ""   && Descricao do CFOP de substituicao (SigCdCfo)
    this_cDTransp    = ""   && Razao social do transportador (SigPrTrp.Razaos)
    this_cEndTransp  = ""   && Endereco do transportador
    this_cCidTransp  = ""   && Cidade do transportador
    this_cUfTransp   = ""   && UF do transportador
    this_cUfServ     = ""   && UF do local da prestacao de servico (Servicos)
    this_cMunServ    = ""   && Municipio da prestacao de servico (Servicos)
    this_cDCodbenefs = ""   && Descricao do beneficio fiscal
    this_cDCodsrvfis = ""   && Descricao do servico municipal

    *==========================================================================
    * Colunas NOT NULL de SigMvNfi sem controle correspondente na tela (nao
    * citadas em layout.json/comportamento.json) - mantidas como propriedades,
    * e nao como literal fixo no SQL, para o valor gravado por outra rotina
    * (ex.: Cancela Nota / Carta de Correcao) nao ser PERDIDO no proximo
    * Atualizar() desta aba (regra CLAUDE.md #22 - INSERT/UPDATE tem de cobrir
    * toda coluna NOT NULL do schema, nunca so as citadas no dump do legado).
    *==========================================================================
    this_lCancelas     = .F.  && cancelas bit - nota cancelada
    this_cClfis        = ""   && clfis char(12)
    this_cClifors      = ""   && clifors char(20)
    this_cCodcons      = ""   && codcons char(9)
    this_cConds        = ""   && conds char(12)
    this_nIcms         = 0    && icms numeric(4,2) - aliquota ICMS
    this_nImpress      = 0    && impress numeric(6,0)
    this_nIpis         = 0    && ipis numeric(4,2) - aliquota IPI
    this_cObs2s        = ""   && obs2s char(40)
    this_cOperas       = ""   && operas char(1) - E/S
    this_nPerciss      = 0    && perciss numeric(5,2)
    this_nPesos        = 0    && pesos numeric(7,2)
    this_lRegs         = .F.  && regs bit
    this_nVals         = 0    && vals numeric(14,2)
    this_nVtotsers     = 0    && vtotsers numeric(14,2)
    this_cCgcs         = ""   && cgcs char(21)
    this_lCorrecs      = .F.  && correcs bit - carta de correcao emitida
    this_cLocals       = ""   && locals char(10)
    this_nNtrans       = 0    && ntrans numeric(6,0)
    this_cCodservs     = ""   && codservs char(10)
    this_cDescservs    = ""   && descservs char(40)
    this_nChkenvias    = 0    && chkenvias numeric(1,0)
    this_nLoterps      = 0    && loterps numeric(6,0)
    this_nNumrps       = 0    && numrps numeric(12,0)
    this_nPcofins      = 0    && pcofins numeric(5,2)
    this_nPcsll        = 0    && pcsll numeric(5,2)
    this_nPinss        = 0    && pinss numeric(5,2)
    this_nPirf         = 0    && pirf numeric(5,2)
    this_nPpis         = 0    && ppis numeric(5,2)
    this_cSerierps     = ""   && serierps char(5)
    this_cTiporps      = ""   && tiporps char(5)
    this_nValiis       = 0    && valiis numeric(14,2)
    this_cNfeprt       = ""   && nfeprt char(15)
    this_cChnfes       = ""   && chnfes char(44)
    this_cPrestservs   = ""   && prestservs char(7)
    this_nVfcpst       = 0    && vfcpst numeric(14,2)
    this_cNumeroNota   = ""   && NumeroNota char(10)
    this_nChkrastreio  = 0    && chkrastreio numeric(1,0)
    this_cChaveExterna = ""   && chaveexterna char(33)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvNfi"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL (SigMvNfi) para
    * as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes de acessar
    * os campos (regra #8/CLAUDE.md) - nunca campo.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)

                THIS.this_cNFis       = TratarNulo(nfis, "")
                THIS.this_cSeries     = TratarNulo(series, "")
                THIS.this_cEspecieNFs = TratarNulo(especienfs, "")
                THIS.this_dEmis       = TratarNulo(emis, {})
                THIS.this_nSelos      = TratarNulo(selos, 0)
                THIS.this_dDtSaidas   = TratarNulo(dtsaidas, {})
                THIS.this_cCFis       = TratarNulo(cfis, "")
                THIS.this_cCfoSubs    = TratarNulo(cfosubs, "")

                THIS.this_nBasecIpis  = TratarNulo(basecipis, 0)
                THIS.this_nValIpis    = TratarNulo(valipis, 0)
                THIS.this_nBasecIcms  = TratarNulo(basecicms, 0)
                THIS.this_nValIcms    = TratarNulo(valicms, 0)
                THIS.this_nTotProds   = TratarNulo(totprods, 0)
                THIS.this_nTotNotas   = TratarNulo(totnotas, 0)

                THIS.this_nBcicmss    = TratarNulo(bcicmss, 0)
                THIS.this_nIcmss      = TratarNulo(icmss, 0)
                THIS.this_nBasecic2s  = TratarNulo(basecic2s, 0)
                THIS.this_nBasecic3s  = TratarNulo(basecic3s, 0)
                THIS.this_nBasecIp2s  = TratarNulo(basecip2s, 0)
                THIS.this_nBasecip3s  = TratarNulo(basecip3s, 0)
                THIS.this_nIpiNCreds  = TratarNulo(ipincreds, 0)

                THIS.this_nVlFretes   = TratarNulo(vlfretes, 0)
                THIS.this_nVlSeguros  = TratarNulo(vlseguros, 0)
                THIS.this_nDespAces   = TratarNulo(despaces, 0)
                THIS.this_nFrtIcms    = TratarNulo(frticms, 0)
                THIS.this_nFrtIpis    = TratarNulo(frtipis, 0)
                THIS.this_nSegIcms    = TratarNulo(segicms, 0)
                THIS.this_nSegIpis    = TratarNulo(segipis, 0)
                THIS.this_nDesIcms    = TratarNulo(desicms, 0)
                THIS.this_nDesIpis    = TratarNulo(desipis, 0)
                THIS.this_cObsFretes  = TratarNulo(obsfretes, "")
                THIS.this_cObspliqs   = TratarNulo(obspliqs, "")
                THIS.this_cObspbrus   = TratarNulo(obspbrus, "")

                THIS.this_cCodTrans   = TratarNulo(codtrans, "")
                THIS.this_nFretes     = TratarNulo(fretes, 0)
                THIS.this_cPlacas     = TratarNulo(placas, "")
                THIS.this_cUfPlacas   = TratarNulo(ufplacas, "")
                THIS.this_nQtdes      = TratarNulo(qtdes, 0)
                THIS.this_cEspes      = TratarNulo(espes, "")
                THIS.this_cMarcas     = TratarNulo(marcas, "")
                THIS.this_cNumeros    = TratarNulo(numeros, "")
                THIS.this_nPLiqs      = TratarNulo(pliqs, 0)
                THIS.this_nPBrus      = TratarNulo(pbrus, 0)
                THIS.this_cObss       = TratarNulo(obss, "")

                THIS.this_cNfechv     = TratarNulo(nfechv, "")
                THIS.this_cNfechvc    = TratarNulo(nfechvc, "")
                THIS.this_cNdis       = TratarNulo(ndis, "")
                THIS.this_dDregdis    = TratarNulo(dregdis, {})
                THIS.this_dDdesembs   = TratarNulo(ddesembs, {})

                THIS.this_nTptribsers  = TratarNulo(tptribsers, 0)
                THIS.this_cCodbenefs   = TratarNulo(codbenefs, "")
                THIS.this_cCodsrvfis   = TratarNulo(codsrvfis, "")
                THIS.this_nVdeducoes   = TratarNulo(vdeducoes, 0)
                THIS.this_nVdscconds   = TratarNulo(vdscconds, 0)
                THIS.this_nVdsciconds  = TratarNulo(vdsciconds, 0)
                THIS.this_nOutretens   = TratarNulo(outretens, 0)
                THIS.this_nIssretidos  = TratarNulo(issretidos, 0)
                THIS.this_cTiponfs     = TratarNulo(tiponfs, "")
                THIS.this_nVtotiss     = TratarNulo(vtotiss, 0)
                THIS.this_nVirf        = TratarNulo(virf, 0)
                THIS.this_nVinss       = TratarNulo(vinss, 0)
                THIS.this_nVpis        = TratarNulo(vpis, 0)
                THIS.this_nVcsll       = TratarNulo(vcsll, 0)
                THIS.this_nVcofins     = TratarNulo(vcofins, 0)

                *-- Colunas NOT NULL sem controle na tela (regra #22)
                IF VARTYPE(cancelas) = "L"
                    THIS.this_lCancelas = cancelas
                ELSE
                    THIS.this_lCancelas = (NVL(cancelas, 0) = 1)
                ENDIF
                THIS.this_cClfis      = TratarNulo(clfis, "")
                THIS.this_cClifors    = TratarNulo(clifors, "")
                THIS.this_cCodcons    = TratarNulo(codcons, "")
                THIS.this_cConds      = TratarNulo(conds, "")
                THIS.this_nIcms       = TratarNulo(icms, 0)
                THIS.this_nImpress    = TratarNulo(impress, 0)
                THIS.this_nIpis       = TratarNulo(ipis, 0)
                THIS.this_cObs2s      = TratarNulo(obs2s, "")
                THIS.this_cOperas     = TratarNulo(operas, "")
                THIS.this_nPerciss    = TratarNulo(perciss, 0)
                THIS.this_nPesos      = TratarNulo(pesos, 0)
                IF VARTYPE(regs) = "L"
                    THIS.this_lRegs = regs
                ELSE
                    THIS.this_lRegs = (NVL(regs, 0) = 1)
                ENDIF
                THIS.this_nVals       = TratarNulo(vals, 0)
                THIS.this_nVtotsers   = TratarNulo(vtotsers, 0)
                THIS.this_cCgcs       = TratarNulo(cgcs, "")
                IF VARTYPE(correcs) = "L"
                    THIS.this_lCorrecs = correcs
                ELSE
                    THIS.this_lCorrecs = (NVL(correcs, 0) = 1)
                ENDIF
                THIS.this_cLocals     = TratarNulo(locals, "")
                THIS.this_nNtrans     = TratarNulo(ntrans, 0)
                THIS.this_cCodservs   = TratarNulo(codservs, "")
                THIS.this_cDescservs  = TratarNulo(descservs, "")
                THIS.this_nChkenvias  = TratarNulo(chkenvias, 0)
                THIS.this_nLoterps    = TratarNulo(loterps, 0)
                THIS.this_nNumrps     = TratarNulo(numrps, 0)
                THIS.this_nPcofins    = TratarNulo(pcofins, 0)
                THIS.this_nPcsll      = TratarNulo(pcsll, 0)
                THIS.this_nPinss      = TratarNulo(pinss, 0)
                THIS.this_nPirf       = TratarNulo(pirf, 0)
                THIS.this_nPpis       = TratarNulo(ppis, 0)
                THIS.this_cSerierps   = TratarNulo(serierps, "")
                THIS.this_cTiporps    = TratarNulo(tiporps, "")
                THIS.this_nValiis     = TratarNulo(valiis, 0)
                THIS.this_cNfeprt     = TratarNulo(nfeprt, "")
                THIS.this_cChnfes     = TratarNulo(chnfes, "")
                THIS.this_cPrestservs = TratarNulo(prestservs, "")
                THIS.this_nVfcpst     = TratarNulo(vfcpst, 0)
                IF TYPE("numeronota") != "U"
                    THIS.this_cNumeroNota = TratarNulo(numeronota, "")
                ENDIF
                THIS.this_nChkrastreio = TratarNulo(chkrastreio, 0)
                IF TYPE("chaveexterna") != "U"
                    THIS.this_cChaveExterna = TratarNulo(chaveexterna, "")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCidchaves - carrega o registro de SigMvNfi cuja PK bate com
    * this_cCidchaves (equivalente ao form PAI ja ter posicionado o cursor
    * global crSigMvNfi no legado). SELECT em cursor TEMPORARIO + CarregarDoCursor
    * (regra CLAUDE.md #8 - SEMPRE SELECT (alias) antes de ler campo, nunca
    * campo). Chamado pelo Form ao abrir em modo ALTERAR/VISUALIZAR.
    *==========================================================================
    PROCEDURE CarregarPorCidchaves()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso    = .F.
        loc_lProsseguir = !EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))

        TRY
            IF loc_lProsseguir
                IF USED("cursor_4c_CargaNfi")
                    USE IN cursor_4c_CargaNfi
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvNfi WHERE cidchaves = " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidchaves), 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargaNfi")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar dados fiscais da nota:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_CargaNfi") AND RECCOUNT("cursor_4c_CargaNfi") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_CargaNfi")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_CargaNfi")
                    USE IN cursor_4c_CargaNfi
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.CarregarPorCidchaves")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro em SigMvNfi
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida (regra #22
    * - NUNCA string vazia, senao o 2o registro colide no indice unico)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao,
            *-- regra #42 - NUNCA ALLTRIM nas partes internas)
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvNfi ("
            loc_cSQL = loc_cSQL + "cidchaves, empdopnums, emps, dopes, numes,"
            loc_cSQL = loc_cSQL + "nfis, series, especienfs, emis, selos, dtsaidas, cfis, cfosubs,"
            loc_cSQL = loc_cSQL + "basecipis, valipis, basecicms, valicms, totprods, totnotas,"
            loc_cSQL = loc_cSQL + "bcicmss, icmss, basecic2s, basecic3s, basecip2s, basecip3s, ipincreds,"
            loc_cSQL = loc_cSQL + "vlfretes, vlseguros, despaces, frticms, frtipis, segicms, segipis, desicms, desipis,"
            loc_cSQL = loc_cSQL + "obsfretes, obspliqs, obspbrus,"
            loc_cSQL = loc_cSQL + "codtrans, fretes, placas, ufplacas, qtdes, espes, marcas, numeros, pliqs, pbrus, obss,"
            loc_cSQL = loc_cSQL + "nfechv, nfechvc, ndis, dregdis, ddesembs,"
            loc_cSQL = loc_cSQL + "tptribsers, codbenefs, codsrvfis, vdeducoes, vdscconds, vdsciconds, outretens,"
            loc_cSQL = loc_cSQL + "issretidos, tiponfs, vtotiss, virf, vinss, vpis, vcsll, vcofins,"
            loc_cSQL = loc_cSQL + "cancelas, clfis, clifors, codcons, conds, icms, impress, ipis, obs2s, operas,"
            loc_cSQL = loc_cSQL + "perciss, pesos, regs, vals, vtotsers, cgcs, correcs, locals, ntrans,"
            loc_cSQL = loc_cSQL + "codservs, descservs, chkenvias, loterps, numrps, pcofins, pcsll, pinss, pirf, ppis,"
            loc_cSQL = loc_cSQL + "serierps, tiporps, valiis, nfeprt, chnfes, prestservs, vfcpst,"
            loc_cSQL = loc_cSQL + "NumeroNota, chkrastreio, chaveexterna"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNFis, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSeries, 8)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecieNFs, 6)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dEmis) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSelos, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtSaidas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCFis, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCfoSubs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotProds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotNotas, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecic2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecic3s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIp2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecip3s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIpiNCreds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVlFretes, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVlSeguros, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDespAces, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFrtIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFrtIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSegIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSegIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDesIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDesIpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObsFretes, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObspliqs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObspbrus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodTrans, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFretes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPlacas, 8)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUfPlacas, 2)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMarcas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNumeros, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPLiqs, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPBrus, 3) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObss, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfechv, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfechvc, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNdis, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDregdis) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDdesembs) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTptribsers, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodbenefs, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodsrvfis, 6)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdeducoes, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdscconds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdsciconds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nOutretens, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIssretidos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTiponfs, 2)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVtotiss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVirf, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVinss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcsll, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lCancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cClfis, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cClifors, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodcons, 9)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cConds, 12)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpress, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObs2s, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOperas, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPerciss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 2) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lRegs, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVals, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVtotsers, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCgcs, 21)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lCorrecs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodservs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDescservs, 40)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nChkenvias, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLoterps, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumrps, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPcofins, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPcsll, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPinss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPirf, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSerierps, 5)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTiporps, 5)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValiis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChnfes, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPrestservs, 7)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVfcpst, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nChkrastreio, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveExterna, 33)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir dados fiscais da nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigMvNfi (por cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao,
            *-- regra #42 - NUNCA ALLTRIM nas partes internas)
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvNfi SET"
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " nfis = " + EscaparSQL(LEFT(THIS.this_cNFis, 6)) + ","
            loc_cSQL = loc_cSQL + " series = " + EscaparSQL(LEFT(THIS.this_cSeries, 8)) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecieNFs, 6)) + ","
            loc_cSQL = loc_cSQL + " emis = " + FormatarDataSQL(THIS.this_dEmis) + ","
            loc_cSQL = loc_cSQL + " selos = " + FormatarNumeroSQL(THIS.this_nSelos, 0) + ","
            loc_cSQL = loc_cSQL + " dtsaidas = " + FormatarDataSQL(THIS.this_dDtSaidas) + ","
            loc_cSQL = loc_cSQL + " cfis = " + EscaparSQL(LEFT(THIS.this_cCFis, 10)) + ","
            loc_cSQL = loc_cSQL + " cfosubs = " + EscaparSQL(LEFT(THIS.this_cCfoSubs, 10)) + ","
            loc_cSQL = loc_cSQL + " basecipis = " + FormatarNumeroSQL(THIS.this_nBasecIpis, 2) + ","
            loc_cSQL = loc_cSQL + " valipis = " + FormatarNumeroSQL(THIS.this_nValIpis, 2) + ","
            loc_cSQL = loc_cSQL + " basecicms = " + FormatarNumeroSQL(THIS.this_nBasecIcms, 2) + ","
            loc_cSQL = loc_cSQL + " valicms = " + FormatarNumeroSQL(THIS.this_nValIcms, 2) + ","
            loc_cSQL = loc_cSQL + " totprods = " + FormatarNumeroSQL(THIS.this_nTotProds, 2) + ","
            loc_cSQL = loc_cSQL + " totnotas = " + FormatarNumeroSQL(THIS.this_nTotNotas, 2) + ","
            loc_cSQL = loc_cSQL + " bcicmss = " + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ","
            loc_cSQL = loc_cSQL + " icmss = " + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ","
            loc_cSQL = loc_cSQL + " basecic2s = " + FormatarNumeroSQL(THIS.this_nBasecic2s, 2) + ","
            loc_cSQL = loc_cSQL + " basecic3s = " + FormatarNumeroSQL(THIS.this_nBasecic3s, 2) + ","
            loc_cSQL = loc_cSQL + " basecip2s = " + FormatarNumeroSQL(THIS.this_nBasecIp2s, 2) + ","
            loc_cSQL = loc_cSQL + " basecip3s = " + FormatarNumeroSQL(THIS.this_nBasecip3s, 2) + ","
            loc_cSQL = loc_cSQL + " ipincreds = " + FormatarNumeroSQL(THIS.this_nIpiNCreds, 2) + ","
            loc_cSQL = loc_cSQL + " vlfretes = " + FormatarNumeroSQL(THIS.this_nVlFretes, 2) + ","
            loc_cSQL = loc_cSQL + " vlseguros = " + FormatarNumeroSQL(THIS.this_nVlSeguros, 2) + ","
            loc_cSQL = loc_cSQL + " despaces = " + FormatarNumeroSQL(THIS.this_nDespAces, 2) + ","
            loc_cSQL = loc_cSQL + " frticms = " + FormatarNumeroSQL(THIS.this_nFrtIcms, 2) + ","
            loc_cSQL = loc_cSQL + " frtipis = " + FormatarNumeroSQL(THIS.this_nFrtIpis, 2) + ","
            loc_cSQL = loc_cSQL + " segicms = " + FormatarNumeroSQL(THIS.this_nSegIcms, 2) + ","
            loc_cSQL = loc_cSQL + " segipis = " + FormatarNumeroSQL(THIS.this_nSegIpis, 2) + ","
            loc_cSQL = loc_cSQL + " desicms = " + FormatarNumeroSQL(THIS.this_nDesIcms, 2) + ","
            loc_cSQL = loc_cSQL + " desipis = " + FormatarNumeroSQL(THIS.this_nDesIpis, 2) + ","
            loc_cSQL = loc_cSQL + " obsfretes = " + EscaparSQL(LEFT(THIS.this_cObsFretes, 10)) + ","
            loc_cSQL = loc_cSQL + " obspliqs = " + EscaparSQL(LEFT(THIS.this_cObspliqs, 10)) + ","
            loc_cSQL = loc_cSQL + " obspbrus = " + EscaparSQL(LEFT(THIS.this_cObspbrus, 10)) + ","
            loc_cSQL = loc_cSQL + " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodTrans, 10)) + ","
            loc_cSQL = loc_cSQL + " fretes = " + FormatarNumeroSQL(THIS.this_nFretes, 0) + ","
            loc_cSQL = loc_cSQL + " placas = " + EscaparSQL(LEFT(THIS.this_cPlacas, 8)) + ","
            loc_cSQL = loc_cSQL + " ufplacas = " + EscaparSQL(LEFT(THIS.this_cUfPlacas, 2)) + ","
            loc_cSQL = loc_cSQL + " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + " marcas = " + EscaparSQL(LEFT(THIS.this_cMarcas, 10)) + ","
            loc_cSQL = loc_cSQL + " numeros = " + EscaparSQL(LEFT(THIS.this_cNumeros, 10)) + ","
            loc_cSQL = loc_cSQL + " pliqs = " + FormatarNumeroSQL(THIS.this_nPLiqs, 3) + ","
            loc_cSQL = loc_cSQL + " pbrus = " + FormatarNumeroSQL(THIS.this_nPBrus, 3) + ","
            loc_cSQL = loc_cSQL + " obss = " + EscaparSQL(LEFT(THIS.this_cObss, 40)) + ","
            loc_cSQL = loc_cSQL + " nfechv = " + EscaparSQL(LEFT(THIS.this_cNfechv, 44)) + ","
            loc_cSQL = loc_cSQL + " nfechvc = " + EscaparSQL(LEFT(THIS.this_cNfechvc, 44)) + ","
            loc_cSQL = loc_cSQL + " ndis = " + EscaparSQL(LEFT(THIS.this_cNdis, 10)) + ","
            loc_cSQL = loc_cSQL + " dregdis = " + FormatarDataSQL(THIS.this_dDregdis) + ","
            loc_cSQL = loc_cSQL + " ddesembs = " + FormatarDataSQL(THIS.this_dDdesembs) + ","
            loc_cSQL = loc_cSQL + " tptribsers = " + FormatarNumeroSQL(THIS.this_nTptribsers, 0) + ","
            loc_cSQL = loc_cSQL + " codbenefs = " + EscaparSQL(LEFT(THIS.this_cCodbenefs, 3)) + ","
            loc_cSQL = loc_cSQL + " codsrvfis = " + EscaparSQL(LEFT(THIS.this_cCodsrvfis, 6)) + ","
            loc_cSQL = loc_cSQL + " vdeducoes = " + FormatarNumeroSQL(THIS.this_nVdeducoes, 2) + ","
            loc_cSQL = loc_cSQL + " vdscconds = " + FormatarNumeroSQL(THIS.this_nVdscconds, 2) + ","
            loc_cSQL = loc_cSQL + " vdsciconds = " + FormatarNumeroSQL(THIS.this_nVdsciconds, 2) + ","
            loc_cSQL = loc_cSQL + " outretens = " + FormatarNumeroSQL(THIS.this_nOutretens, 2) + ","
            loc_cSQL = loc_cSQL + " issretidos = " + FormatarNumeroSQL(THIS.this_nIssretidos, 0) + ","
            loc_cSQL = loc_cSQL + " tiponfs = " + EscaparSQL(LEFT(THIS.this_cTiponfs, 2)) + ","
            loc_cSQL = loc_cSQL + " vtotiss = " + FormatarNumeroSQL(THIS.this_nVtotiss, 2) + ","
            loc_cSQL = loc_cSQL + " virf = " + FormatarNumeroSQL(THIS.this_nVirf, 2) + ","
            loc_cSQL = loc_cSQL + " vinss = " + FormatarNumeroSQL(THIS.this_nVinss, 2) + ","
            loc_cSQL = loc_cSQL + " vpis = " + FormatarNumeroSQL(THIS.this_nVpis, 2) + ","
            loc_cSQL = loc_cSQL + " vcsll = " + FormatarNumeroSQL(THIS.this_nVcsll, 2) + ","
            loc_cSQL = loc_cSQL + " vcofins = " + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ","
            loc_cSQL = loc_cSQL + " cancelas = " + IIF(THIS.this_lCancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + " clfis = " + EscaparSQL(LEFT(THIS.this_cClfis, 12)) + ","
            loc_cSQL = loc_cSQL + " clifors = " + EscaparSQL(LEFT(THIS.this_cClifors, 20)) + ","
            loc_cSQL = loc_cSQL + " codcons = " + EscaparSQL(LEFT(THIS.this_cCodcons, 9)) + ","
            loc_cSQL = loc_cSQL + " conds = " + EscaparSQL(LEFT(THIS.this_cConds, 12)) + ","
            loc_cSQL = loc_cSQL + " icms = " + FormatarNumeroSQL(THIS.this_nIcms, 2) + ","
            loc_cSQL = loc_cSQL + " impress = " + FormatarNumeroSQL(THIS.this_nImpress, 0) + ","
            loc_cSQL = loc_cSQL + " ipis = " + FormatarNumeroSQL(THIS.this_nIpis, 2) + ","
            loc_cSQL = loc_cSQL + " obs2s = " + EscaparSQL(LEFT(THIS.this_cObs2s, 40)) + ","
            loc_cSQL = loc_cSQL + " operas = " + EscaparSQL(LEFT(THIS.this_cOperas, 1)) + ","
            loc_cSQL = loc_cSQL + " perciss = " + FormatarNumeroSQL(THIS.this_nPerciss, 2) + ","
            loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 2) + ","
            loc_cSQL = loc_cSQL + " regs = " + IIF(THIS.this_lRegs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " vals = " + FormatarNumeroSQL(THIS.this_nVals, 2) + ","
            loc_cSQL = loc_cSQL + " vtotsers = " + FormatarNumeroSQL(THIS.this_nVtotsers, 2) + ","
            loc_cSQL = loc_cSQL + " cgcs = " + EscaparSQL(LEFT(THIS.this_cCgcs, 21)) + ","
            loc_cSQL = loc_cSQL + " correcs = " + IIF(THIS.this_lCorrecs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " codservs = " + EscaparSQL(LEFT(THIS.this_cCodservs, 10)) + ","
            loc_cSQL = loc_cSQL + " descservs = " + EscaparSQL(LEFT(THIS.this_cDescservs, 40)) + ","
            loc_cSQL = loc_cSQL + " chkenvias = " + FormatarNumeroSQL(THIS.this_nChkenvias, 0) + ","
            loc_cSQL = loc_cSQL + " loterps = " + FormatarNumeroSQL(THIS.this_nLoterps, 0) + ","
            loc_cSQL = loc_cSQL + " numrps = " + FormatarNumeroSQL(THIS.this_nNumrps, 0) + ","
            loc_cSQL = loc_cSQL + " pcofins = " + FormatarNumeroSQL(THIS.this_nPcofins, 2) + ","
            loc_cSQL = loc_cSQL + " pcsll = " + FormatarNumeroSQL(THIS.this_nPcsll, 2) + ","
            loc_cSQL = loc_cSQL + " pinss = " + FormatarNumeroSQL(THIS.this_nPinss, 2) + ","
            loc_cSQL = loc_cSQL + " pirf = " + FormatarNumeroSQL(THIS.this_nPirf, 2) + ","
            loc_cSQL = loc_cSQL + " ppis = " + FormatarNumeroSQL(THIS.this_nPpis, 2) + ","
            loc_cSQL = loc_cSQL + " serierps = " + EscaparSQL(LEFT(THIS.this_cSerierps, 5)) + ","
            loc_cSQL = loc_cSQL + " tiporps = " + EscaparSQL(LEFT(THIS.this_cTiporps, 5)) + ","
            loc_cSQL = loc_cSQL + " valiis = " + FormatarNumeroSQL(THIS.this_nValiis, 2) + ","
            loc_cSQL = loc_cSQL + " nfeprt = " + EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ","
            loc_cSQL = loc_cSQL + " chnfes = " + EscaparSQL(LEFT(THIS.this_cChnfes, 44)) + ","
            loc_cSQL = loc_cSQL + " prestservs = " + EscaparSQL(LEFT(THIS.this_cPrestservs, 7)) + ","
            loc_cSQL = loc_cSQL + " vfcpst = " + FormatarNumeroSQL(THIS.this_nVfcpst, 2) + ","
            loc_cSQL = loc_cSQL + " NumeroNota = " + EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ","
            loc_cSQL = loc_cSQL + " chkrastreio = " + FormatarNumeroSQL(THIS.this_nChkrastreio, 0) + ","
            loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveExterna, 33))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar dados fiscais da nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

