*==============================================================================
* ProbeCco657F8.prg - Probe funcional da Fase 8 de FormSIGOPCCO (task657)
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA com os 6 parametros do legado e cria grade/campo/botoes
*   2) o campo Nota chega preenchido com o parametro NFis (prova que a troca
*      da atribuicao inline por BOParaForm nao perdeu o valor)
*   3) escopos: CarregarLista e os handlers PUBLIC (chamados de fora / alvos
*      de BINDEVENT - regra #3); FormParaBO/BOParaForm/LimparCampos PROTECTED
*      (FormBase os declara assim e VFP9 nao permite alargar)
*   4) a grade mantem CurrentControl/Sparse da coluna Retificacao (Fase 4)
*      e o campo Nota segue nao digitavel (Get_NotaIni.When legado)
*   5) FormParaBO: campo Nota + contexto + LINHA CORRENTE da grade -> BO
*   6) FormParaBO com a grade VAZIA zera a ocorrencia (nao herda a anterior)
*   7) BOParaForm: nota -> campo, e retificacao -> linha da grade pelo
*      Seek/Replace do 2o Scan do Init/Valid legado
*   8) BOParaForm com this_nNoccors = 0 NAO mexe na grade
*   9) LimparCampos zera o campo E esvazia a grade (ramo Else do Valid legado)
*  10) ConfirmarCorrecao/ObterEmpDopNums SEM argumento caem nas properties
*      do proprio BO (o que o BtnConfirmarClick passou a fazer)
*
* NAO chama Show(): o form eh modal em producao e travaria o harness.
* Em gb_4c_ModoTeste, MsgAviso/MsgErro gravam em arquivo - nada bloqueia.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cco657.txt"
#DEFINE OUT "C:\4c\automation\probe_cco657_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_cL, loc_nFalhas, loc_oE
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSIGOPCCO (task657) ===" + CHR(13) + CHR(10), OUT)
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
    SET PROCEDURE TO (gcCaminhoClasses + "SIGOPCCOBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPCCO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeCco657F8.prg"    ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.

    *-- 1) instanciacao com os 6 parametros do legado
    loc_oForm = CREATEOBJECT("ProbeCcoF8", .NULL., "001", "1  ", ;
        {^2026-01-01}, {^2026-12-31}, "000123")
    loc_cL = "1) CREATEOBJECT com parametros -> VARTYPE=" + VARTYPE(loc_oForm)
    IF VARTYPE(loc_oForm) = "O"
        loc_cL = loc_cL + " Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + ;
            " ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13)+CHR(10) + ;
            "   grade=" + TRANSFORM(PEMSTATUS(loc_oForm,"grd_4c_Dados",5)) + ;
            " campoNota=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_NotaIni",5)) + ;
            " botoes=" + TRANSFORM(PEMSTATUS(loc_oForm,"cmg_4c_Sair",5)) + ;
            " cursor=" + TRANSFORM(USED("cursor_4c_Ocorrencias")) + CHR(13)+CHR(10)
    ELSE
        loc_cL = loc_cL + " *** NAO ABRIU ***" + CHR(13)+CHR(10)
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13)+CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) o campo Nota tem de chegar com o parametro NFis, via BOParaForm
    loc_cL = "2) campo Nota apos o Init: [" + ALLTRIM(loc_oForm.txt_4c_NotaIni.Value) + ;
        "] esperado [000123]   BO.this_cNfis=[" + ALLTRIM(loc_oBO.this_cNfis) + "]" + ;
        "  BO.this_cEmps=[" + ALLTRIM(loc_oBO.this_cEmps) + "]" + ;
        "  BO.this_cSeries=[" + ALLTRIM(loc_oBO.this_cSeries) + "]" + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_NotaIni.Value) != "000123" ;
       OR ALLTRIM(loc_oBO.this_cNfis) != "000123" ;
       OR ALLTRIM(loc_oBO.this_cEmps) != "001" OR ALLTRIM(loc_oBO.this_cSeries) != "1"
        loc_cL = loc_cL + "   *** FALHA: a semeadura FormParaBO -> BOParaForm nao chegou na tela" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) escopos (atributo 2 = Protected)
    loc_cL = "3) escopos (Protected=.T. significa inacessivel de fora):" + CHR(13)+CHR(10) + ;
        "   CarregarLista            Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2))            + " esperado .F." + CHR(13)+CHR(10) + ;
        "   CarregarDados            Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarDados",2))            + " esperado .F." + CHR(13)+CHR(10) + ;
        "   AtualizarGrade           Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AtualizarGrade",2))           + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnConfirmarClick        Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnConfirmarClick",2))        + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnCancelarClick         Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnCancelarClick",2))         + " esperado .F." + CHR(13)+CHR(10) + ;
        "   ValidarNotaIni           Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarNotaIni",2))           + " esperado .F." + CHR(13)+CHR(10) + ;
        "   GradeRetificacaoKeyPress Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"GradeRetificacaoKeyPress",2)) + " esperado .F." + CHR(13)+CHR(10) + ;
        "   AbrirImpressaoCorrecao   Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AbrirImpressaoCorrecao",2))   + " esperado .F." + CHR(13)+CHR(10) + ;
        "   FormParaBO               Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2))               + " esperado .T." + CHR(13)+CHR(10) + ;
        "   BOParaForm               Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2))               + " esperado .T." + CHR(13)+CHR(10) + ;
        "   LimparCampos             Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"LimparCampos",2))             + " esperado .T." + CHR(13)+CHR(10)
    IF PEMSTATUS(loc_oForm,"CarregarLista",2) OR PEMSTATUS(loc_oForm,"CarregarDados",2) ;
       OR PEMSTATUS(loc_oForm,"AtualizarGrade",2) OR PEMSTATUS(loc_oForm,"BtnConfirmarClick",2) ;
       OR PEMSTATUS(loc_oForm,"BtnCancelarClick",2) OR PEMSTATUS(loc_oForm,"ValidarNotaIni",2) ;
       OR PEMSTATUS(loc_oForm,"GradeRetificacaoKeyPress",2) OR PEMSTATUS(loc_oForm,"AbrirImpressaoCorrecao",2) ;
       OR !PEMSTATUS(loc_oForm,"FormParaBO",2) OR !PEMSTATUS(loc_oForm,"BOParaForm",2) ;
       OR !PEMSTATUS(loc_oForm,"LimparCampos",2)
        loc_cL = loc_cL + "   *** FALHA de escopo" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) regressao da Fase 4: coluna Retificacao e campo Nota travado
    loc_cL = "4) grade/campo (regressao das fases anteriores):" + CHR(13)+CHR(10) + ;
        "   Column3.CurrentControl=[" + loc_oForm.grd_4c_Dados.Column3.CurrentControl + "] esperado [edt_4c_Retificacao]" + CHR(13)+CHR(10) + ;
        "   Column3.Sparse=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column3.Sparse) + " esperado .F." + ;
        "   Column3.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column3.ReadOnly) + " esperado .F." + CHR(13)+CHR(10) + ;
        "   Column1.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + " esperado .T." + ;
        "   Column2.ReadOnly=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.ReadOnly) + " esperado .T." + CHR(13)+CHR(10) + ;
        "   txt_4c_NotaIni.ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_NotaIni.ReadOnly) + " esperado .T. (Get_NotaIni.When legado)" + CHR(13)+CHR(10)
    IF UPPER(loc_oForm.grd_4c_Dados.Column3.CurrentControl) != UPPER("edt_4c_Retificacao") ;
       OR loc_oForm.grd_4c_Dados.Column3.Sparse OR loc_oForm.grd_4c_Dados.Column3.ReadOnly ;
       OR !loc_oForm.grd_4c_Dados.Column1.ReadOnly OR !loc_oForm.grd_4c_Dados.Column2.ReadOnly ;
       OR !loc_oForm.txt_4c_NotaIni.ReadOnly
        loc_cL = loc_cL + "   *** FALHA de regressao" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- popula a grade como o 1o Scan do legado faria
    SELECT cursor_4c_Ocorrencias
    ZAP
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (10, "ERRO DE ENDERECO", "")
    INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) VALUES (20, "ERRO DE VALOR", "")
    SELECT cursor_4c_Ocorrencias
    GO TOP
    SKIP
    REPLACE retifs WITH "TEXTO DIGITADO NA GRADE" IN cursor_4c_Ocorrencias

    *-- 5) FormParaBO: campo + contexto + linha corrente
    loc_oBO.this_nNoccors = 0
    loc_oBO.this_cMretifs = ""
    loc_oForm.TesteFormParaBO()
    loc_cL = "5) FormParaBO com a grade na 2a linha (cods=20):" + CHR(13)+CHR(10) + ;
        "   BO.this_cNfis    = [" + ALLTRIM(loc_oBO.this_cNfis) + "] esperado [000123]" + CHR(13)+CHR(10) + ;
        "   BO.this_nNoccors = " + TRANSFORM(loc_oBO.this_nNoccors) + " esperado 20" + CHR(13)+CHR(10) + ;
        "   BO.this_cMretifs = [" + ALLTRIM(loc_oBO.this_cMretifs) + "] esperado [TEXTO DIGITADO NA GRADE]" + CHR(13)+CHR(10) + ;
        "   BO.this_dEmisDe  = " + DTOC(loc_oBO.this_dEmisDe) + "  BO.this_dEmisAte = " + DTOC(loc_oBO.this_dEmisAte) + CHR(13)+CHR(10)
    IF loc_oBO.this_nNoccors != 20 OR ALLTRIM(loc_oBO.this_cMretifs) != "TEXTO DIGITADO NA GRADE" ;
       OR ALLTRIM(loc_oBO.this_cNfis) != "000123" ;
       OR loc_oBO.this_dEmisDe != {^2026-01-01} OR loc_oBO.this_dEmisAte != {^2026-12-31}
        loc_cL = loc_cL + "   *** FALHA no FormParaBO" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) BOParaForm: nota -> campo, retificacao -> linha da ocorrencia do BO
    SELECT cursor_4c_Ocorrencias
    GO TOP
    REPLACE retifs WITH "" IN cursor_4c_Ocorrencias
    loc_oForm.txt_4c_NotaIni.Value = ""
    loc_oBO.this_cNfis    = "000999"
    loc_oBO.this_nNoccors = 10
    loc_oBO.this_cMretifs = "RETIFICACAO GRAVADA EM SIGNFCOR"
    loc_oForm.TesteBOParaForm()
    SELECT cursor_4c_Ocorrencias
    LOCATE FOR cursor_4c_Ocorrencias.cods = 10
    loc_cL = "7) BOParaForm (Seek/Replace do 2o Scan legado):" + CHR(13)+CHR(10) + ;
        "   campo Nota         = [" + ALLTRIM(loc_oForm.txt_4c_NotaIni.Value) + "] esperado [000999]" + CHR(13)+CHR(10) + ;
        "   linha cods=10 achada = " + TRANSFORM(FOUND()) + ;
        "  retifs = [" + ALLTRIM(cursor_4c_Ocorrencias.retifs) + "] esperado [RETIFICACAO GRAVADA EM SIGNFCOR]" + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_NotaIni.Value) != "000999" OR !FOUND() ;
       OR ALLTRIM(cursor_4c_Ocorrencias.retifs) != "RETIFICACAO GRAVADA EM SIGNFCOR"
        loc_cL = loc_cL + "   *** FALHA no BOParaForm" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 8) BOParaForm com ocorrencia 0 nao mexe na grade
    SELECT cursor_4c_Ocorrencias
    LOCATE FOR cursor_4c_Ocorrencias.cods = 20
    REPLACE retifs WITH "NAO DEVE SER TOCADO" IN cursor_4c_Ocorrencias
    loc_oBO.this_nNoccors = 0
    loc_oBO.this_cMretifs = "LIXO"
    loc_oForm.TesteBOParaForm()
    SELECT cursor_4c_Ocorrencias
    LOCATE FOR cursor_4c_Ocorrencias.cods = 20
    loc_cL = "8) BOParaForm com this_nNoccors = 0:" + CHR(13)+CHR(10) + ;
        "   retifs da linha 20 = [" + ALLTRIM(cursor_4c_Ocorrencias.retifs) + "] esperado [NAO DEVE SER TOCADO]" + CHR(13)+CHR(10)
    IF ALLTRIM(cursor_4c_Ocorrencias.retifs) != "NAO DEVE SER TOCADO"
        loc_cL = loc_cL + "   *** FALHA: escreveu na grade sem ocorrencia carregada" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 9) LimparCampos: campo vazio + grade esvaziada
    loc_oForm.TesteLimparCampos()
    loc_cL = "9) LimparCampos (ramo Else do Valid legado):" + CHR(13)+CHR(10) + ;
        "   campo Nota vazio = " + TRANSFORM(EMPTY(loc_oForm.txt_4c_NotaIni.Value)) + ;
        "   RECCOUNT(grade) = " + TRANSFORM(RECCOUNT("cursor_4c_Ocorrencias")) + " esperado 0" + CHR(13)+CHR(10)
    IF !EMPTY(loc_oForm.txt_4c_NotaIni.Value) OR RECCOUNT("cursor_4c_Ocorrencias") != 0
        loc_cL = loc_cL + "   *** FALHA no LimparCampos" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) FormParaBO com a grade VAZIA zera a ocorrencia
    loc_oBO.this_nNoccors = 77
    loc_oBO.this_cMretifs = "RESIDUO"
    loc_oForm.TesteFormParaBO()
    loc_cL = "6) FormParaBO com a grade VAZIA:" + CHR(13)+CHR(10) + ;
        "   BO.this_nNoccors = " + TRANSFORM(loc_oBO.this_nNoccors) + " esperado 0" + ;
        "   BO.this_cMretifs = [" + ALLTRIM(loc_oBO.this_cMretifs) + "] esperado []" + CHR(13)+CHR(10)
    IF loc_oBO.this_nNoccors != 0 OR !EMPTY(loc_oBO.this_cMretifs)
        loc_cL = loc_cL + "   *** FALHA: herdou a ocorrencia da leitura anterior" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 10) chamada SEM argumento cai nas properties do proprio BO. Com
    *-- gnConnHandle = -1 o SQLEXEC falha de proposito - o que se mede eh que
    *-- a chamada sem argumento NAO estoura por parametro ausente.
    loc_oBO.this_cEmps   = "001"
    loc_oBO.this_cSeries = "1"
    loc_oBO.this_cNfis   = "000123"
    STRTOFILE("10) chamadas sem argumento (fallback nas properties do BO):" + CHR(13)+CHR(10), OUT, 1)
    loc_cL = "   ObterEmpDopNums() -> [" + loc_oBO.ObterEmpDopNums() + "] (vazio: sem conexao, esperado)" + CHR(13)+CHR(10)
    STRTOFILE(loc_cL, OUT, 1)
    loc_cL = "   ConfirmarCorrecao() -> " + TRANSFORM(loc_oBO.ConfirmarCorrecao()) + ;
        "  this_lTemCorrecoesGravadas=" + TRANSFORM(loc_oBO.this_lTemCorrecoesGravadas) + ;
        " (.F./.F.: grade vazia e sem conexao, esperado)" + CHR(13)+CHR(10)
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
DEFINE CLASS ProbeCcoF8 AS FormSIGOPCCO
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC
    FUNCTION TesteBOParaForm()
        RETURN THIS.BOParaForm()
    ENDFUNC
    FUNCTION TesteLimparCampos()
        RETURN THIS.LimparCampos()
    ENDFUNC
ENDDEFINE
