*==============================================================================
* ProbeCgv695F8.prg - Probe funcional da Fase 8 de Formsigopcgv (task695)
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA (AlternarPagina(1) do Init ja passa por
*      HabilitarCampos + AjustarBotoesPorModo, acrescentados nesta fase)
*   2) escopos: os metodos chamados de FORA (harness/BINDEVENT) sao PUBLIC;
*      FormParaBO/BOParaForm/LimparCampos ficam PROTECTED porque FormBase os
*      declara assim e VFP9 nao permite alargar (regra #51)
*   3) HabilitarCampos reproduz a cascata de When do legado
*   4) FormParaBO: criterios da tela + periodo -> BO
*   5) BOParaForm: BO -> criterios da tela + periodo
*   6) LimparCampos zera os 5 campos E o BO (LimparDados sobrescrito no BO)
*   7) BtnSalvarClick fora de ALTERAR nao bloqueia a saida
*   8) AjustarBotoesPorModo nao mexe na geometria do grp_operacao com acesso
*      liberado (235/769 do SCX) e esconde a barra da pagina Resultado
*
* NAO chama Show(): o form eh modal em producao e travaria o harness.
* Em gb_4c_ModoTeste, MsgAviso/MsgErro/MsgConfirma gravam em arquivo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ValidandoUI
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cgv695.txt"
#DEFINE OUT "C:\4c\automation\probe_cgv695_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_oCnt, loc_cL, loc_nFalhas, loc_oE
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - Formsigopcgv (task695) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigopcgvBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigopcgv.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeCgv695F8.prg"    ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.
    *-- gb_4c_ValidandoUI tem de ser setado DEPOIS do config.prg (ele reseta a
    *-- flag) e eh o que faz o InicializarForm pular o gate de gnConnHandle > 0
    gb_4c_ValidandoUI = .T.
    STRTOFILE("0) flags: ModoTeste=" + TRANSFORM(gb_4c_ModoTeste) + ;
        " ValidandoUI TYPE=" + TYPE("gb_4c_ValidandoUI") + ;
        " valor=" + TRANSFORM(gb_4c_ValidandoUI) + ;
        " gnConnHandle=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    *-- 1) instanciacao
    loc_oForm = CREATEOBJECT("ProbeCgvF8")
    loc_cL = "1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm)
    IF VARTYPE(loc_oForm) = "O"
        loc_cL = loc_cL + " Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + ;
            " ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13)+CHR(10) + ;
            "   pgf=" + TRANSFORM(PEMSTATUS(loc_oForm,"pgf_4c_Paginas",5)) + ;
            " Origem=" + TRANSFORM(PEMSTATUS(loc_oForm.pgf_4c_Paginas.Page1,"cnt_4c_Origem",5)) + ;
            " GrpOperacao=" + TRANSFORM(PEMSTATUS(loc_oForm.pgf_4c_Paginas.Page1,"cmg_4c_GrpOperacao",5)) + ;
            " ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " Modo=[" + loc_oForm.this_cModoAtual + "]" + CHR(13)+CHR(10)
    ELSE
        loc_cL = loc_cL + " *** NAO ABRIU ***" + CHR(13)+CHR(10)
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13)+CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_oBO  = loc_oForm.this_oBusinessObject
    loc_oCnt = loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Origem

    *-- 2) escopos (atributo 2 = Protected)
    loc_cL = "2) escopos (Protected=.T. significa inacessivel de fora):" + CHR(13)+CHR(10) + ;
        "   CarregarLista        Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2))        + " esperado .F." + CHR(13)+CHR(10) + ;
        "   HabilitarCampos      Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"HabilitarCampos",2))      + " esperado .F." + CHR(13)+CHR(10) + ;
        "   AjustarBotoesPorModo Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AjustarBotoesPorModo",2)) + " esperado .F." + CHR(13)+CHR(10) + ;
        "   AlternarPagina       Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AlternarPagina",2))       + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnBuscarClick       Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnBuscarClick",2))       + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnSalvarClick       Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnSalvarClick",2))       + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnCancelarClick     Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnCancelarClick",2))     + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnEncerrarClick     Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnEncerrarClick",2))     + " esperado .F." + CHR(13)+CHR(10) + ;
        "   FormParaBO           Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2))           + " esperado .T. (FormBase)" + CHR(13)+CHR(10) + ;
        "   BOParaForm           Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2))           + " esperado .T. (FormBase)" + CHR(13)+CHR(10) + ;
        "   LimparCampos         Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"LimparCampos",2))         + " esperado .T. (FormBase)" + CHR(13)+CHR(10)
    IF PEMSTATUS(loc_oForm,"CarregarLista",2) OR PEMSTATUS(loc_oForm,"HabilitarCampos",2) ;
       OR PEMSTATUS(loc_oForm,"AjustarBotoesPorModo",2) OR PEMSTATUS(loc_oForm,"AlternarPagina",2) ;
       OR PEMSTATUS(loc_oForm,"BtnBuscarClick",2) OR PEMSTATUS(loc_oForm,"BtnSalvarClick",2) ;
       OR PEMSTATUS(loc_oForm,"BtnCancelarClick",2) OR PEMSTATUS(loc_oForm,"BtnEncerrarClick",2)
        loc_cL = loc_cL + "   *** FALHA de escopo (metodo chamado de fora esta PROTECTED)" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) cascata de When (HabilitarCampos)
    loc_oForm.LimparCamposPub()
    loc_cL = "3) cascata de When:" + CHR(13)+CHR(10) + ;
        "   a) todos vazios -> Conta=" + TRANSFORM(loc_oCnt.txt_4c_Conta.ReadOnly) + ;
        " Cpf=" + TRANSFORM(loc_oCnt.txt_4c_Cpf.ReadOnly) + ;
        " DConta=" + TRANSFORM(loc_oCnt.txt_4c_DConta.ReadOnly) + ;
        " Conjuge=" + TRANSFORM(loc_oCnt.txt_4c_Conjuge.ReadOnly) + ;
        " Telefone=" + TRANSFORM(loc_oCnt.txt_4c_Telefone.ReadOnly) + ;
        "  (esperado todos .F.)" + CHR(13)+CHR(10)
    IF loc_oCnt.txt_4c_Conta.ReadOnly OR loc_oCnt.txt_4c_Cpf.ReadOnly ;
       OR loc_oCnt.txt_4c_DConta.ReadOnly OR loc_oCnt.txt_4c_Conjuge.ReadOnly ;
       OR loc_oCnt.txt_4c_Telefone.ReadOnly
        loc_cL = loc_cL + "      *** FALHA: campo travado com todos os criterios vazios" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    loc_oCnt.txt_4c_Conta.Value = "0000000123"
    loc_oForm.HabilitarCampos(.T.)
    loc_cL = loc_cL + "   b) Conta preenchida -> Conta=" + TRANSFORM(loc_oCnt.txt_4c_Conta.ReadOnly) + ;
        " Cpf=" + TRANSFORM(loc_oCnt.txt_4c_Cpf.ReadOnly) + ;
        " DConta=" + TRANSFORM(loc_oCnt.txt_4c_DConta.ReadOnly) + ;
        " Conjuge=" + TRANSFORM(loc_oCnt.txt_4c_Conjuge.ReadOnly) + ;
        " Telefone=" + TRANSFORM(loc_oCnt.txt_4c_Telefone.ReadOnly) + ;
        "  (esperado Conta .F. e os outros 4 .T.)" + CHR(13)+CHR(10)
    IF loc_oCnt.txt_4c_Conta.ReadOnly OR !loc_oCnt.txt_4c_Cpf.ReadOnly ;
       OR !loc_oCnt.txt_4c_DConta.ReadOnly OR !loc_oCnt.txt_4c_Conjuge.ReadOnly ;
       OR !loc_oCnt.txt_4c_Telefone.ReadOnly
        loc_cL = loc_cL + "      *** FALHA: cascata de When do legado nao aplicada" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    loc_oForm.HabilitarCampos(.F.)
    loc_cL = loc_cL + "   c) HabilitarCampos(.F.) -> Conta=" + TRANSFORM(loc_oCnt.txt_4c_Conta.ReadOnly) + ;
        " optFiltro.Enabled=" + TRANSFORM(loc_oCnt.obj_4c_OptFiltro.Enabled) + ;
        "  (esperado .T. / .F.)" + CHR(13)+CHR(10)
    IF !loc_oCnt.txt_4c_Conta.ReadOnly OR loc_oCnt.obj_4c_OptFiltro.Enabled
        loc_cL = loc_cL + "      *** FALHA: HabilitarCampos(.F.) nao trancou os criterios" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) FormParaBO
    loc_oForm.LimparCamposPub()
    loc_oCnt.txt_4c_Conta.Value    = "0000000123"
    loc_oCnt.txt_4c_DConta.Value   = "CLIENTE DE TESTE"
    loc_oCnt.txt_4c_Cpf.Value      = "111.222.333-44"
    loc_oCnt.txt_4c_Conjuge.Value  = "CONJUGE DE TESTE"
    loc_oCnt.txt_4c_Telefone.Value = "71999990000"
    loc_oCnt.obj_4c_OptFiltro.Value = 2
    loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Periodo.txt_4c_DtInicial.Value = {^2026-01-01}
    loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Periodo.txt_4c_DtFinal.Value   = {^2026-12-31}
    loc_oForm.FormParaBOPub()
    loc_cL = "4) FormParaBO:" + CHR(13)+CHR(10) + ;
        "   Conta=[" + ALLTRIM(loc_oBO.this_cConta) + "] Nome=[" + ALLTRIM(loc_oBO.this_cDescConta) + "]" + CHR(13)+CHR(10) + ;
        "   Cpf=[" + ALLTRIM(loc_oBO.this_cCpf) + "] Conjuge=[" + ALLTRIM(loc_oBO.this_cConjuge) + ;
        "] Telefone=[" + ALLTRIM(loc_oBO.this_cTelefone) + "]" + CHR(13)+CHR(10) + ;
        "   OpcaoFiltro=" + TRANSFORM(loc_oBO.this_nOpcaoFiltro) + " esperado 2" + ;
        "   DtIni=" + DTOC(loc_oBO.this_dDataInicial) + " DtFim=" + DTOC(loc_oBO.this_dDataFinal) + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oBO.this_cConta) != "0000000123" ;
       OR ALLTRIM(loc_oBO.this_cDescConta) != "CLIENTE DE TESTE" ;
       OR ALLTRIM(loc_oBO.this_cCpf) != "111.222.333-44" ;
       OR ALLTRIM(loc_oBO.this_cConjuge) != "CONJUGE DE TESTE" ;
       OR ALLTRIM(loc_oBO.this_cTelefone) != "71999990000" ;
       OR loc_oBO.this_nOpcaoFiltro != 2 ;
       OR loc_oBO.this_dDataInicial != {^2026-01-01} OR loc_oBO.this_dDataFinal != {^2026-12-31}
        loc_cL = loc_cL + "   *** FALHA no FormParaBO" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) BOParaForm
    loc_oForm.LimparCamposPub()
    loc_oBO.this_cConta       = "0000000999"
    loc_oBO.this_cDescConta   = "OUTRO CLIENTE"
    loc_oBO.this_cCpf         = "999.888.777-66"
    loc_oBO.this_cConjuge     = "OUTRO CONJUGE"
    loc_oBO.this_cTelefone    = "71888880000"
    loc_oBO.this_nOpcaoFiltro = 1
    loc_oBO.this_dDataInicial = {^2026-03-01}
    loc_oBO.this_dDataFinal   = {^2026-03-31}
    loc_oForm.BOParaFormPub()
    loc_cL = "5) BOParaForm:" + CHR(13)+CHR(10) + ;
        "   Conta=[" + ALLTRIM(loc_oCnt.txt_4c_Conta.Value) + "] Nome=[" + ALLTRIM(loc_oCnt.txt_4c_DConta.Value) + "]" + CHR(13)+CHR(10) + ;
        "   Cpf=[" + ALLTRIM(loc_oCnt.txt_4c_Cpf.Value) + "] Conjuge=[" + ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value) + ;
        "] Telefone=[" + ALLTRIM(loc_oCnt.txt_4c_Telefone.Value) + "]" + CHR(13)+CHR(10) + ;
        "   optFiltro=" + TRANSFORM(loc_oCnt.obj_4c_OptFiltro.Value) + ;
        "   DtIni=" + DTOC(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Periodo.txt_4c_DtInicial.Value) + ;
        " DtFim=" + DTOC(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Periodo.txt_4c_DtFinal.Value) + CHR(13)+CHR(10) + ;
        "   ReadOnly apos a volta -> Cpf=" + TRANSFORM(loc_oCnt.txt_4c_Cpf.ReadOnly) + " (esperado .T.)" + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oCnt.txt_4c_Conta.Value) != "0000000999" ;
       OR ALLTRIM(loc_oCnt.txt_4c_DConta.Value) != "OUTRO CLIENTE" ;
       OR ALLTRIM(loc_oCnt.txt_4c_Cpf.Value) != "999.888.777-66" ;
       OR ALLTRIM(loc_oCnt.txt_4c_Conjuge.Value) != "OUTRO CONJUGE" ;
       OR ALLTRIM(loc_oCnt.txt_4c_Telefone.Value) != "71888880000" ;
       OR loc_oCnt.obj_4c_OptFiltro.Value != 1 ;
       OR loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Periodo.txt_4c_DtInicial.Value != {^2026-03-01} ;
       OR !loc_oCnt.txt_4c_Cpf.ReadOnly
        loc_cL = loc_cL + "   *** FALHA no BOParaForm" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) LimparCampos limpa tela E BO (LimparDados sobrescrito no BO)
    loc_oBO.this_lConsultaExecutada = .T.
    loc_oBO.this_nLimiteCredito     = 12345
    loc_oBO.this_cEscolha           = "ALTERAR"
    loc_oForm.LimparCamposPub()
    loc_cL = "6) LimparCampos:" + CHR(13)+CHR(10) + ;
        "   tela -> Conta vazio=" + TRANSFORM(EMPTY(loc_oCnt.txt_4c_Conta.Value)) + ;
        " Nome vazio=" + TRANSFORM(EMPTY(loc_oCnt.txt_4c_DConta.Value)) + ;
        " Cpf vazio=" + TRANSFORM(EMPTY(loc_oCnt.txt_4c_Cpf.Value)) + ;
        " Conjuge vazio=" + TRANSFORM(EMPTY(loc_oCnt.txt_4c_Conjuge.Value)) + ;
        " Telefone vazio=" + TRANSFORM(EMPTY(loc_oCnt.txt_4c_Telefone.Value)) + CHR(13)+CHR(10) + ;
        "   BO   -> Conta vazio=" + TRANSFORM(EMPTY(loc_oBO.this_cConta)) + ;
        " ConsultaExecutada=" + TRANSFORM(loc_oBO.this_lConsultaExecutada) + ;
        " LimiteCredito=" + TRANSFORM(loc_oBO.this_nLimiteCredito) + ;
        " Escolha=[" + loc_oBO.this_cEscolha + "]" + ;
        " OpcaoFiltro=" + TRANSFORM(loc_oBO.this_nOpcaoFiltro) + CHR(13)+CHR(10)
    IF !EMPTY(loc_oCnt.txt_4c_Conta.Value) OR !EMPTY(loc_oCnt.txt_4c_DConta.Value) ;
       OR !EMPTY(loc_oCnt.txt_4c_Cpf.Value) OR !EMPTY(loc_oCnt.txt_4c_Conjuge.Value) ;
       OR !EMPTY(loc_oCnt.txt_4c_Telefone.Value) ;
       OR !EMPTY(loc_oBO.this_cConta) OR loc_oBO.this_lConsultaExecutada ;
       OR loc_oBO.this_nLimiteCredito != 0 OR !EMPTY(loc_oBO.this_cEscolha) ;
       OR loc_oBO.this_nOpcaoFiltro != 1
        loc_cL = loc_cL + "   *** FALHA no LimparCampos / LimparDados do BO" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) BtnSalvarClick fora de ALTERAR nao bloqueia a saida
    loc_oBO.this_cEscolha = "CONSULTAR"
    loc_cL = "7) BtnSalvarClick com Escolha=[CONSULTAR] -> " + ;
        TRANSFORM(loc_oForm.BtnSalvarClick()) + " esperado .T. (nao bloqueia a saida)" + CHR(13)+CHR(10)
    IF !loc_oForm.BtnSalvarClick()
        loc_cL = loc_cL + "   *** FALHA: bloqueou a saida sem haver o que gravar" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    *-- Em ALTERAR, MsgConfirma devolve .F. em modo teste (usuario respondeu
    *-- Nao): o legado tambem segue a saida nesse caso
    loc_oBO.this_cEscolha = "ALTERAR"
    loc_cL = loc_cL + "   BtnSalvarClick com Escolha=[ALTERAR] e MsgConfirma=.F. -> " + ;
        TRANSFORM(loc_oForm.BtnSalvarClick()) + " esperado .T." + CHR(13)+CHR(10)
    IF !loc_oForm.BtnSalvarClick()
        loc_cL = loc_cL + "   *** FALHA: respondeu Nao e ainda assim bloqueou a saida" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 8) AjustarBotoesPorModo
    loc_oForm.AjustarBotoesPorModo()
    loc_cL = "8) AjustarBotoesPorModo na pagina Consulta:" + CHR(13)+CHR(10) + ;
        "   grp_operacao Left=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cmg_4c_GrpOperacao.Left) + ;
        " Width=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cmg_4c_GrpOperacao.Width) + ;
        " (esperado 769 / 235 - acesso liberado)" + CHR(13)+CHR(10) + ;
        "   Buttons 1/2/3 Visible=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cmg_4c_GrpOperacao.Buttons(1).Visible) + "/" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cmg_4c_GrpOperacao.Buttons(2).Visible) + "/" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.cmg_4c_GrpOperacao.Buttons(3).Visible) + CHR(13)+CHR(10) + ;
        "   Imprime.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cmd_4c_Imprime.Visible) + ;
        " Voltar.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_Voltar.Visible) + ;
        " (esperado .F./.F. - barra da pagina Resultado)" + CHR(13)+CHR(10)
    IF loc_oForm.pgf_4c_Paginas.Page1.cmg_4c_GrpOperacao.Left != 769 ;
       OR loc_oForm.pgf_4c_Paginas.Page1.cmg_4c_GrpOperacao.Width != 235 ;
       OR !loc_oForm.pgf_4c_Paginas.Page1.cmg_4c_GrpOperacao.Buttons(1).Visible ;
       OR loc_oForm.pgf_4c_Paginas.Page2.cmd_4c_Imprime.Visible ;
       OR loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_Voltar.Visible
        loc_cL = loc_cL + "   *** FALHA no AjustarBotoesPorModo" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 9) troca para a pagina Resultado: a barra tem de APARECER (prova que o
    *-- AjustarBotoesPorModo acrescentado em AjustarVisibilidadeResultado e em
    *-- AlternarPagina nao deixa a barra escondida no destino)
    loc_oForm.AjustarVisibilidadeResultado("MOVIMENTO")
    loc_oForm.AlternarPagina(2)
    loc_cL = "9) AlternarPagina(2) na visao MOVIMENTO:" + CHR(13)+CHR(10) + ;
        "   Modo=[" + loc_oForm.this_cModoAtual + "] ModoResultado=[" + loc_oForm.this_cModoResultado + ;
        "] ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " Height=" + TRANSFORM(loc_oForm.Height) + CHR(13)+CHR(10) + ;
        "   Imprime.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cmd_4c_Imprime.Visible) + ;
        " Voltar.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_Voltar.Visible) + ;
        " MudaCli.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_MudaCli.Visible) + ;
        " MudaMov.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_MudaMov.Visible) + ;
        " (esperado .T./.T./.T./.F.)" + CHR(13)+CHR(10)
    IF loc_oForm.this_cModoAtual != "RESULTADO" ;
       OR loc_oForm.pgf_4c_Paginas.ActivePage != 2 OR loc_oForm.Height != 600 ;
       OR !loc_oForm.pgf_4c_Paginas.Page2.cmd_4c_Imprime.Visible ;
       OR !loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_Voltar.Visible ;
       OR !loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_MudaCli.Visible ;
       OR loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_MudaMov.Visible
        loc_cL = loc_cL + "   *** FALHA: a barra da pagina Resultado nao apareceu no destino" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 10) visao CADASTRO inverte o par MudaCli/MudaMov
    loc_oForm.AjustarVisibilidadeResultado("CADASTRO")
    loc_cL = "10) visao CADASTRO:" + CHR(13)+CHR(10) + ;
        "   MudaCli.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_MudaCli.Visible) + ;
        " MudaMov.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_MudaMov.Visible) + ;
        " Periodo.Visible=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Periodo.Visible) + ;
        " (esperado .F./.T./.F.)" + CHR(13)+CHR(10)
    IF loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_MudaCli.Visible ;
       OR !loc_oForm.pgf_4c_Paginas.Page2.cmg_4c_MudaMov.Visible ;
       OR loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Periodo.Visible
        loc_cL = loc_cL + "   *** FALHA: o par MudaCli/MudaMov nao inverteu" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 11) BtnCancelarClick na pagina Resultado volta para a Consulta sem gravar
    loc_oForm.BtnCancelarClick()
    loc_cL = "11) BtnCancelarClick na pagina Resultado:" + CHR(13)+CHR(10) + ;
        "   ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " Modo=[" + loc_oForm.this_cModoAtual + "]" + ;
        " Escolha=[" + loc_oForm.this_oBusinessObject.this_cEscolha + "]" + ;
        " Height=" + TRANSFORM(loc_oForm.Height) + ;
        " (esperado 1 / CONSULTA / vazio apos LimparDados / 300)" + CHR(13)+CHR(10)
    IF loc_oForm.pgf_4c_Paginas.ActivePage != 1 OR loc_oForm.this_cModoAtual != "CONSULTA" ;
       OR loc_oForm.Height != 300
        loc_cL = loc_cL + "   *** FALHA: o Cancelar nao devolveu a tela para a Consulta" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    STRTOFILE(CHR(13)+CHR(10) + IIF(loc_nFalhas = 0, "PROBE_OK", ;
        "PROBE_FALHAS=" + TRANSFORM(loc_nFalhas)) + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | Proc " + loc_oE.Procedure + CHR(13)+CHR(10) + "PROBE_FALHAS=EXCECAO" + CHR(13)+CHR(10), OUT, 1)
ENDTRY

QUIT

*-- Subclasse para alcancar os hooks PROTECTED (script solto nao alcanca
*-- membro protegido; subclasse alcanca - tecnica padrao do projeto).
DEFINE CLASS ProbeCgvF8 AS Formsigopcgv
    FUNCTION FormParaBOPub()
        RETURN THIS.FormParaBO()
    ENDFUNC
    FUNCTION BOParaFormPub()
        RETURN THIS.BOParaForm()
    ENDFUNC
    FUNCTION LimparCamposPub()
        RETURN THIS.LimparCampos()
    ENDFUNC
ENDDEFINE
