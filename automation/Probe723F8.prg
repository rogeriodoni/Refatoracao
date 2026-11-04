*==============================================================================
* Probe723F8.prg - Probe da Fase 8 de FormSigOpDoc (task723)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA com os metodos novos rodando dentro do InicializarForm
*   2) escopo REAL de cada metodo novo (PEMSTATUS ...,2 = Protected, ao lado de
*      ...,5 = existe): FormParaBO/BOParaForm/LimparCampos sao PROTECTED por
*      HERANCA de FormBase (a subclasse nao alarga escopo em VFP9), enquanto
*      HabilitarCampos/CarregarLista/BtnCancelarClick sao publicos de verdade
*   3) cursor_4c_Dados eh GRAVAVEL (ISREADONLY = .F.) - sem isso o EditBox de
*      observacao nao aceita uma tecla e SalvarDados nao tem o que gravar
*   4) GradeAfterRowColChange carrega a linha corrente no BO (cursor -> BO)
*   5) BOParaForm normaliza ObsArqs NULL para "" (legado: Update ... Nvl())
*   6) FormParaBO descarrega no cursor a observacao digitada na tela
*   7) HabilitarCampos alterna o ReadOnly do EditBox nos dois sentidos, e sem
*      argumento deriva o estado de this_cEscolha
*   8) LimparCampos apaga o preview quando nao ha linha corrente
*
* Os hooks PROTECTED sao exercitados por SUBCLASSE (Probe723 AS FormSigOpDoc,
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
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_723f8.txt"
#DEFINE OUT "C:\4c\automation\probe_723f8.txt"

LOCAL loc_oE, loc_oForm, loc_oBO, loc_nSessaoAnt, loc_x

STRTOFILE("=== PROBE Fase 8 - FormSigOpDoc (task723) v2 ===" + CHR(13) + CHR(10), OUT)

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
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpDocBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpDoc.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\Probe723F8.prg"            ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao pela SUBCLASSE (herda Init e parametros)
    STRTOFILE("CK01 antes do CREATEOBJECT" + CHR(13) + CHR(10), OUT, 1)
    loc_oForm = CREATEOBJECT("Probe723", "001MALOTE                   3", "ALTERAR")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height), " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("ABORTADO" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) escopo REAL: existe (5) x protegido (2)
    STRTOFILE("2) escopo dos metodos (existe / PROTECTED)" + CHR(13) + CHR(10) + ;
        "   FormParaBO       " + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + "   (esperado .T./.T. - herda FormBase)" + CHR(13) + CHR(10) + ;
        "   BOParaForm       " + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + "   (esperado .T./.T. - herda FormBase)" + CHR(13) + CHR(10) + ;
        "   LimparCampos     " + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)) + "   (esperado .T./.T. - herda FormBase)" + CHR(13) + CHR(10) + ;
        "   HabilitarCampos  " + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 2)) + "   (esperado .T./.F. - publico)" + CHR(13) + CHR(10) + ;
        "   CarregarLista    " + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + "   (esperado .T./.F. - publico)" + CHR(13) + CHR(10) + ;
        "   BtnCancelarClick " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)) + "   (esperado .T./.F. - BINDEVENT)" + CHR(13) + CHR(10) + ;
        "   BtnConfirmarClick " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnConfirmarClick", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnConfirmarClick", 2)) + "  (esperado .T./.F. - BINDEVENT)" + CHR(13) + CHR(10) + ;
        "   SalvarDados      " + TRANSFORM(PEMSTATUS(loc_oForm, "SalvarDados", 5)) + " / " + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "SalvarDados", 2)) + "   (esperado .T./.F.)" + CHR(13) + CHR(10), OUT, 1)

    *-- Entrar na data session do form (DataSession = 2)
    loc_nSessaoAnt = SET("Datasession")
    SET DATASESSION TO loc_oForm.DataSessionId

    *-- 3) o cursor da grade eh GRAVAVEL?
    STRTOFILE("3) cursor_4c_Dados: USED=" + TRANSFORM(USED("cursor_4c_Dados")) + ;
        " ISREADONLY=" + TRANSFORM(ISREADONLY("cursor_4c_Dados")) + ;
        " (esperado .F. = gravavel)" + CHR(13) + CHR(10), OUT, 1)

    *-- Duas linhas: a 2a com ObsArqs NULL, para medir a normalizacao do legado
    SELECT cursor_4c_Dados
    INSERT INTO cursor_4c_Dados (pkChaves, fkChaves, Arquivos, ObsArqs, Usuars, Datas) ;
        VALUES ("PK0000000001", "001MALOTE                   3", ;
                "C:\4c\vbmp\logo.bmp", "OBS ORIGINAL", "TESTE", DATETIME())
    INSERT INTO cursor_4c_Dados (pkChaves, fkChaves, Arquivos, ObsArqs, Usuars, Datas) ;
        VALUES ("PK0000000002", "001MALOTE                   3", ;
                "C:\4c\docs\schema.sql", .NULL., "TESTE", DATETIME())
    STRTOFILE("   RECCOUNT apos INSERT = " + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + CHR(13) + CHR(10), OUT, 1)

    STRTOFILE("CK02 antes de CarregarLista" + CHR(13) + CHR(10), OUT, 1)
    TRY
        STRTOFILE("   CarregarLista = " + TRANSFORM(loc_oForm.CarregarLista()) + ;
            " / Column1.ControlSource = [" + loc_oForm.grd_4c_Dados.Column1.ControlSource + "]" + ;
            " / EditBox.ControlSource = [" + loc_oForm.obj_4c_GetObsArqs.ControlSource + "]" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("   CarregarLista FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 4) cursor -> BO na linha corrente (linha 1 apos o GO TOP)
    STRTOFILE("CK03 antes de GradeAfterRowColChange" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_oForm.GradeAfterRowColChange(1)
        STRTOFILE("4) linha 1 -> BO: RECNO=" + TRANSFORM(RECNO("cursor_4c_Dados")) + CHR(13) + CHR(10) + ;
            "   BO.this_cPkChaves = [" + ALLTRIM(loc_oBO.this_cPkChaves) + "] (esperado PK0000000001)" + CHR(13) + CHR(10) + ;
            "   BO.this_cArquivos = [" + ALLTRIM(loc_oBO.this_cArquivos) + "]" + CHR(13) + CHR(10) + ;
            "   BO.this_cObsArqs  = [" + ALLTRIM(loc_oBO.this_cObsArqs) + "] (esperado OBS ORIGINAL)" + CHR(13) + CHR(10) + ;
            "   EditBox.Value     = [" + ALLTRIM(loc_oForm.obj_4c_GetObsArqs.Value) + "]" + CHR(13) + CHR(10) + ;
            "   preview Visible   = " + TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
            " (.bmp -> esperado .T.)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("4) GradeAfterRowColChange FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 5) normalizacao do ObsArqs NULL (legado: Update ... Set ObsArqs = Nvl())
    SELECT cursor_4c_Dados
    GO 2
    STRTOFILE("5) linha 2 (ObsArqs NULL): ISNULL antes = " + ;
        TRANSFORM(ISNULL(cursor_4c_Dados.ObsArqs)) + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("CK04 antes de GradeAfterRowColChange na linha 2" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_oForm.GradeAfterRowColChange(1)
        STRTOFILE("   ISNULL depois   = " + TRANSFORM(ISNULL(cursor_4c_Dados.ObsArqs)) + ;
            " (esperado .F.)" + CHR(13) + CHR(10) + ;
            "   preview Visible = " + TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
            " (.sql -> esperado .F.)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("   FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 6) FormParaBO descarrega a observacao digitada no cursor (via subclasse)
    SELECT cursor_4c_Dados
    GO 1
    loc_oForm.obj_4c_GetObsArqs.Value = "TEXTO DIGITADO NA TELA"
    STRTOFILE("CK05 antes de ProbeFormParaBO" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_x = loc_oForm.ProbeFormParaBO()
        STRTOFILE("6) FormParaBO = " + TRANSFORM(loc_x) + CHR(13) + CHR(10) + ;
            "   cursor.ObsArqs    = [" + ALLTRIM(cursor_4c_Dados.ObsArqs) + "]" + CHR(13) + CHR(10) + ;
            "   BO.this_cObsArqs  = [" + ALLTRIM(loc_oBO.this_cObsArqs) + "]" + CHR(13) + CHR(10) + ;
            "   BO.this_cPkChaves = [" + ALLTRIM(loc_oBO.this_cPkChaves) + "]" + CHR(13) + CHR(10) + ;
            "   BO.this_cFkChaves = [" + ALLTRIM(loc_oBO.this_cFkChaves) + "]" + CHR(13) + CHR(10) + ;
            "   BO.this_dDatas    = " + TRANSFORM(loc_oBO.this_dDatas) + ;
            " VARTYPE=" + VARTYPE(loc_oBO.this_dDatas) + " (esperado T)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("6) ProbeFormParaBO FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 6b) chamada DIRETA de fora tem de FALHAR (prova de que eh PROTECTED)
    TRY
        loc_x = loc_oForm.FormParaBO()
        STRTOFILE("6b) chamada DIRETA de fora PASSOU -> metodo NAO esta protegido" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("6b) chamada DIRETA de fora recusada (correto): " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 7) HabilitarCampos nos dois sentidos + sem argumento (PUBLICO)
    STRTOFILE("CK06 antes de HabilitarCampos" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_oForm.HabilitarCampos(.F.)
        STRTOFILE("7) HabilitarCampos(.F.) -> EditBox.ReadOnly = " + ;
            TRANSFORM(loc_oForm.obj_4c_GetObsArqs.ReadOnly) + " (esperado .T.)" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.HabilitarCampos(.T.)
        STRTOFILE("   HabilitarCampos(.T.) -> EditBox.ReadOnly = " + ;
            TRANSFORM(loc_oForm.obj_4c_GetObsArqs.ReadOnly) + " (esperado .F.)" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.HabilitarCampos(.F.)
        loc_x = loc_oForm.HabilitarCampos()
        STRTOFILE("   sem argumento (this_cEscolha=[" + ALLTRIM(loc_oForm.this_cEscolha) + ;
            "]) -> retorno = " + TRANSFORM(loc_x) + ;
            " / ReadOnly = " + TRANSFORM(loc_oForm.obj_4c_GetObsArqs.ReadOnly) + ;
            " (esperado .T. / .F.)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("7) HabilitarCampos FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 8) LimparCampos apaga o preview (via subclasse)
    loc_oForm.img_4c_ImgArqJpg.Visible = .T.
    STRTOFILE("CK07 antes de ProbeLimparCampos" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_x = loc_oForm.ProbeLimparCampos()
        STRTOFILE("8) LimparCampos = " + TRANSFORM(loc_x) + ;
            " -> preview Visible = " + TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
            " / Picture = [" + loc_oForm.img_4c_ImgArqJpg.Picture + "]" + ;
            " (esperado .F. / vazio)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("8) ProbeLimparCampos FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    *-- 9) EOF: os tres hooks nao estouram e devolvem .F.
    SELECT cursor_4c_Dados
    GO BOTTOM
    SKIP
    loc_oForm.img_4c_ImgArqJpg.Visible = .T.
    STRTOFILE("CK08 antes dos hooks em EOF" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_oForm.GradeAfterRowColChange(1)
        STRTOFILE("9) EOF -> preview Visible = " + TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
            " / BOParaForm = " + TRANSFORM(loc_oForm.ProbeBOParaForm()) + ;
            " / FormParaBO = " + TRANSFORM(loc_oForm.ProbeFormParaBO()) + ;
            " (esperado .F. / .F. / .F.)" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("9) hooks em EOF FALHARAM: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    SET DATASESSION TO loc_nSessaoAnt

    *-- 10) BtnCancelarClick e o alias BtnSairClick (os dois sao BINDEVENT/harness)
    STRTOFILE("CK09 antes de BtnSairClick" + CHR(13) + CHR(10), OUT, 1)
    TRY
        loc_oForm.BtnSairClick()
        STRTOFILE("10) BtnSairClick -> delegou para BtnCancelarClick sem erro" + CHR(13) + CHR(10), OUT, 1)
    CATCH TO loc_oE
        STRTOFILE("10) BtnSairClick FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    ENDTRY

    STRTOFILE("=== FIM OK ===" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10) + ;
        "    Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10) + ;
        "    Proc:  " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT


*==============================================================================
* Probe723 - Subclasse SO do probe (nunca em projeto\app\). Existe para
* alcancar os hooks PROTECTED herdados de FormBase: subclasse alcanca membro
* protegido, script solto nao.
*==============================================================================
DEFINE CLASS Probe723 AS FormSigOpDoc

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
