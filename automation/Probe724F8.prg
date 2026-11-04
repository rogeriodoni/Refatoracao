*==============================================================================
* Probe724F8.prg - Probe da Fase 8 de FormSigOpDpe (task724)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA com os metodos novos rodando dentro do InicializarForm
*      (AtualizarEstadoControles eh chamado por FormBase.Init apos o Init da
*      subclasse, logo um erro ali derrubaria a abertura)
*   2) escopo REAL de cada metodo novo (PEMSTATUS ...,2 = Protected, ao lado
*      de ...,5 = existe): FormParaBO/BOParaForm/LimparCampos sao PROTECTED
*      por HERANCA de FormBase (a subclasse nao alarga escopo em VFP9 -
*      regra #51), enquanto HabilitarCampos/AtualizarEstadoControles/
*      BtnEncerrarClick sao publicos de verdade
*   3) cursor_4c_Dados eh GRAVAVEL (ISREADONLY = .F.) - sem isso nenhuma
*      celula da grade aceita uma tecla e o REPLACE dos hooks estoura
*   4) FormParaBO carrega a LINHA CORRENTE no BO (cursor -> BO)
*   5) BOParaForm escreve as tres colunas de volta na linha, e a GUARDA DE
*      IDENTIDADE recusa a escrita quando a linha corrente nao eh a do BO
*   6) HabilitarCampos alterna Grid.ReadOnly/Enabled e o ReadOnly das TRES
*      colunas nos dois sentidos, e SEM argumento abre (teste por PCOUNT())
*   7) LimparCampos zera as tres colunas da linha corrente SEM perder
*      cidchaves/dopes (a identidade da linha)
*   8) BtnEncerrarClick existe e eh publico (nao eh invocado: ele GRAVA e da
*      Release, o que mataria o probe)
*
* Os hooks PROTECTED sao exercitados por SUBCLASSE (Probe724 AS FormSigOpDpe,
* definida AQUI e nunca em projeto\app\): subclasse alcanca membro protegido,
* script solto nao. Toda chamada vai em TRY/CATCH proprio - sem isso um
* Program Error abre dialogo que ninguem fecha e o probe pendura MUDO.
*
* O form tem DataSession = 2, entao o probe entra na data session DELE para
* ver cursor_4c_Dados (cursor de sessao privada nao aparece na sessao default).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_724f8.txt"
#DEFINE OUT "C:\4c\automation\probe_724f8.txt"

LOCAL loc_oE, loc_oForm, loc_oBO, loc_nSessaoAnt, loc_x

STRTOFILE("=== PROBE Fase 8 - FormSigOpDpe (task724) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpDpeBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpDpe.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\Probe724F8.prg"            ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao pela SUBCLASSE (herda Init e parametros)
    STRTOFILE("CK01 antes do CREATEOBJECT" + CHR(13) + CHR(10), OUT, 1)
    loc_oForm = CREATEOBJECT("Probe724", .NULL., "VENDA", "ALTERAR")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + ;
            " Caption=[" + loc_oForm.Caption + "]", " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("ABORTADO" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) escopo REAL: existe (5) x protegido (2)
    STRTOFILE("2) escopo dos metodos (existe / PROTECTED)" + CHR(13) + CHR(10) + ;
        "   FormParaBO               " + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + "   (esperado .T./.T. - herda FormBase)" + CHR(13) + CHR(10) + ;
        "   BOParaForm               " + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + "   (esperado .T./.T. - herda FormBase)" + CHR(13) + CHR(10) + ;
        "   LimparCampos             " + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)) + "   (esperado .T./.T. - herda FormBase)" + CHR(13) + CHR(10) + ;
        "   HabilitarCampos          " + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 2)) + "   (esperado .T./.F. - publico)" + CHR(13) + CHR(10) + ;
        "   AtualizarEstadoControles " + TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarEstadoControles", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "AtualizarEstadoControles", 2)) + "   (esperado .T./.F. - publico)" + CHR(13) + CHR(10) + ;
        "   BtnEncerrarClick         " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 2)) + "   (esperado .T./.F. - harness 06b)" + CHR(13) + CHR(10) + ;
        "   CarregarLista            " + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + "   (esperado .T./.F. - publico)" + CHR(13) + CHR(10), OUT, 1)

    *-- Estado deixado por AtualizarEstadoControles (rodou no Init da base)
    STRTOFILE("2b) estado pos-Init: Grid.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.ReadOnly) + ;
        " Grid.Enabled=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
        " Col1.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
        " Col3.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column3.ReadOnly) + ;
        " (esperado .F. .T. .F. .F.)" + CHR(13) + CHR(10), OUT, 1)

    *-- Entrar na data session do form (DataSession = 2)
    loc_nSessaoAnt = SET("Datasession")
    SET DATASESSION TO loc_oForm.DataSessionId

    *-- 3) o cursor da grade eh GRAVAVEL?
    STRTOFILE("3) cursor_4c_Dados: USED=" + TRANSFORM(USED("cursor_4c_Dados")) + ;
        " ISREADONLY=" + TRANSFORM(ISREADONLY("cursor_4c_Dados")) + ;
        " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + ;
        " (esperado .T. / .F. / 1 - a linha em branco do inserelinha)" + CHR(13) + CHR(10), OUT, 1)

    *-- Duas faixas gravadas + a linha em branco que o Init ja criou
    SELECT cursor_4c_Dados
    INSERT INTO cursor_4c_Dados (cidchaves, dopes, qtddis, qtddfs, percs, lnovos) ;
        VALUES ("CHV0000000000000001", "VENDA", 1, 30, 10.50, .F.)
    INSERT INTO cursor_4c_Dados (cidchaves, dopes, qtddis, qtddfs, percs, lnovos) ;
        VALUES ("CHV0000000000000002", "VENDA", 31, 60, 25.75, .F.)
    STRTOFILE("   RECCOUNT apos INSERT = " + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + CHR(13) + CHR(10), OUT, 1)

    *-- 4) linha corrente -> BO (ActiveColumn = 0, grade nunca teve foco:
    *--    o flush de celula tem de ser PULADO sem erro)
    SELECT cursor_4c_Dados
    LOCATE FOR cidchaves = "CHV0000000000000002"
    STRTOFILE("CK02 antes de ProbeFormParaBO (RECNO=" + TRANSFORM(RECNO()) + ;
        " ActiveColumn=" + TRANSFORM(loc_oForm.grd_4c_Dados.ActiveColumn) + ")" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_x = loc_oForm.ProbeFormParaBO()
        STRTOFILE("4) FormParaBO = " + TRANSFORM(loc_x) + CHR(13) + CHR(10) + ;
            "   BO.this_cCidChaves = [" + ALLTRIM(loc_oBO.this_cCidChaves) + "] (esperado CHV0000000000000002)" + CHR(13) + CHR(10) + ;
            "   BO.this_cDopes     = [" + ALLTRIM(loc_oBO.this_cDopes) + "] (esperado VENDA)" + CHR(13) + CHR(10) + ;
            "   BO.this_nQtddis    = " + TRANSFORM(loc_oBO.this_nQtddis) + " (esperado 31)" + CHR(13) + CHR(10) + ;
            "   BO.this_nQtddfs    = " + TRANSFORM(loc_oBO.this_nQtddfs) + " (esperado 60)" + CHR(13) + CHR(10) + ;
            "   BO.this_nPercs     = " + TRANSFORM(loc_oBO.this_nPercs) + " (esperado 25.75)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("4) ProbeFormParaBO FALHOU: " + loc_oE.Message + ;
            " LN=" + TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 4b) chamada DIRETA de fora tem de FALHAR (prova que eh PROTECTED)
    TRY
        loc_x = loc_oForm.FormParaBO()
        STRTOFILE("4b) chamada DIRETA de fora PASSOU -> metodo NAO esta protegido" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("4b) chamada DIRETA de fora recusada (correto): " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 5) BO -> linha corrente (mesma linha: a guarda de identidade LIBERA)
    loc_oBO.this_nQtddis = 31
    loc_oBO.this_nQtddfs = 90
    loc_oBO.this_nPercs  = 33.33
    STRTOFILE("CK03 antes de ProbeBOParaForm (mesma linha)" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_x = loc_oForm.ProbeBOParaForm()
        SELECT cursor_4c_Dados
        STRTOFILE("5) BOParaForm = " + TRANSFORM(loc_x) + " (esperado .T.)" + CHR(13) + CHR(10) + ;
            "   linha: qtddfs=" + TRANSFORM(cursor_4c_Dados.qtddfs) + " (esperado 90)" + ;
            " percs=" + TRANSFORM(cursor_4c_Dados.percs) + " (esperado 33.33)" + ;
            " cidchaves=[" + ALLTRIM(cursor_4c_Dados.cidchaves) + "] (intacto)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("5) ProbeBOParaForm FALHOU: " + loc_oE.Message + ;
            " LN=" + TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 5b) guarda de identidade: ponteiro em OUTRA linha -> tem de RECUSAR
    SELECT cursor_4c_Dados
    LOCATE FOR cidchaves = "CHV0000000000000001"
    loc_oBO.this_nQtddfs = 999
    STRTOFILE("CK04 antes de ProbeBOParaForm (OUTRA linha)" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_x = loc_oForm.ProbeBOParaForm()
        SELECT cursor_4c_Dados
        STRTOFILE("5b) BOParaForm em outra linha = " + TRANSFORM(loc_x) + " (esperado .F.)" + CHR(13) + CHR(10) + ;
            "    qtddfs da linha 1 = " + TRANSFORM(cursor_4c_Dados.qtddfs) + ;
            " (esperado 30 - NAO foi sobrescrito por 999)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("5b) FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    SET DATASESSION TO loc_nSessaoAnt

    *-- 6) HabilitarCampos nos dois sentidos + sem argumento
    STRTOFILE("CK05 antes de HabilitarCampos" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_oForm.HabilitarCampos(.F.)
        STRTOFILE("6) HabilitarCampos(.F.) -> Grid.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.ReadOnly) + ;
            " Enabled=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
            " Col1=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
            " Col2=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.ReadOnly) + ;
            " Col3=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column3.ReadOnly) + ;
            " Excluir.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Excluir.Enabled) + ;
            " Encerrar.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Encerrar.Enabled) + ;
            " (esperado .T. .F. .T. .T. .T. .F. .T.)" + CHR(13) + CHR(10), OUT, 1)

        loc_oForm.HabilitarCampos(.T.)
        STRTOFILE("   HabilitarCampos(.T.) -> Grid.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.ReadOnly) + ;
            " Enabled=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
            " Col1=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
            " Col3=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column3.ReadOnly) + ;
            " (esperado .F. .T. .F. .F.)" + CHR(13) + CHR(10), OUT, 1)

        loc_oForm.HabilitarCampos(.F.)
        loc_x = loc_oForm.HabilitarCampos()
        STRTOFILE("   SEM argumento -> retorno=" + TRANSFORM(loc_x) + ;
            " Grid.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.ReadOnly) + ;
            " Enabled=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
            " (esperado .T. / .F. / .T. - PCOUNT, nao VARTYPE)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("6) HabilitarCampos FALHOU: " + loc_oE.Message + ;
            " LN=" + TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 7) LimparCampos zera a linha corrente sem perder a identidade
    SET DATASESSION TO loc_oForm.DataSessionId
    SELECT cursor_4c_Dados
    LOCATE FOR cidchaves = "CHV0000000000000001"
    STRTOFILE("CK06 antes de ProbeLimparCampos (linha 1: qtddfs=" + ;
        TRANSFORM(cursor_4c_Dados.qtddfs) + " percs=" + TRANSFORM(cursor_4c_Dados.percs) + ")" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_x = loc_oForm.ProbeLimparCampos()
        SELECT cursor_4c_Dados
        STRTOFILE("7) LimparCampos = " + TRANSFORM(loc_x) + " (esperado .T.)" + CHR(13) + CHR(10) + ;
            "   qtddis=" + TRANSFORM(cursor_4c_Dados.qtddis) + ;
            " qtddfs=" + TRANSFORM(cursor_4c_Dados.qtddfs) + ;
            " percs=" + TRANSFORM(cursor_4c_Dados.percs) + " (esperado 0 0 0)" + CHR(13) + CHR(10) + ;
            "   cidchaves=[" + ALLTRIM(cursor_4c_Dados.cidchaves) + "] dopes=[" + ;
            ALLTRIM(cursor_4c_Dados.dopes) + "] (esperado INTACTOS)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("7) ProbeLimparCampos FALHOU: " + loc_oE.Message + ;
            " LN=" + TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 8) hooks em EOF: nao estouram e devolvem .F.
    SELECT cursor_4c_Dados
    GO BOTTOM
    SKIP
    STRTOFILE("CK07 antes dos hooks em EOF" + CHR(13) + CHR(10), OUT, 1)
    TRY
        STRTOFILE("8) EOF -> FormParaBO=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + ;
            " BOParaForm=" + TRANSFORM(loc_oForm.ProbeBOParaForm()) + ;
            " (esperado .F. / .F.)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("8) hooks em EOF FALHARAM: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    SET DATASESSION TO loc_nSessaoAnt

    STRTOFILE("=== FIM OK ===" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10) + ;
        "    Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10) + ;
        "    Proc:  " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT


*==============================================================================
* Probe724 - Subclasse SO do probe (nunca em projeto\app\). Existe para
* alcancar os hooks PROTECTED herdados de FormBase: subclasse alcanca membro
* protegido, script solto nao.
*==============================================================================
DEFINE CLASS Probe724 AS FormSigOpDpe

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbeLimparCampos()
        RETURN THIS.LimparCampos()
    ENDPROC

ENDDEFINE
