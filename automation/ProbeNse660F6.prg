*==============================================================================
* ProbeNse660F6.prg - Probe funcional da Fase 6 de FormSIGPRNSE (task660)
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA e cria os dois campos de empresa e os metodos novos
*   2) escopos: alvos de BINDEVENT sao PUBLIC (regra #3 - PEMSTATUS(...,5)
*      devolve .T. mesmo para PROTECTED, entao a chamada real so quebra em
*      runtime); os internos do lookup ficam PROTECTED
*   3) KeyPress com tecla que NAO eh Enter/Tab/F4 nao dispara nada (regra #47
*      - sem esse teste o picker subiria a cada caractere digitado)
*   4) Enter com o campo VAZIO limpa os DOIS controles e nao abre picker
*      (ramo "If llRet" do fAcessoEmpresa legado)
*   5) a guarda de reentrancia bloqueia o segundo picker (regra #47/#37)
*   6) getDEmps.When legado (Return Empty(getCEmps.Value)) aplicado por
*      ReadOnly, nos dois sentidos (quem RESTRINGE tem de LIBERAR - regra #40)
*   7) ObterFiltroAcessoEmpresas nao estoura sem conexao e devolve Caractere
*
* NAO chama Show(): o form eh modal em producao e travaria o harness. Com
* gnConnHandle = -1 o SQLEXEC falha de proposito, entao nenhum caminho chega
* a exibir o FormBuscaAuxiliar - se o script TERMINA dentro do timeout, isso
* prova que nenhum dialogo modal foi aberto.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_nse660.txt"
#DEFINE OUT "C:\4c\automation\probe_nse660_f6.txt"

LOCAL loc_oForm, loc_cL, loc_nFalhas, loc_oE, loc_cFiltro
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 6 - FormSIGPRNSE (task660) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRNSEBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRNSE.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeNse660F6.prg"           ADDITIVE

    gnConnHandle    = -1
    gb_4c_ModoTeste = .T.

    *-- 1) instanciacao
    loc_oForm = CREATEOBJECT("ProbeNseF6")
    loc_cL = "1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm)
    IF VARTYPE(loc_oForm) = "O"
        loc_cL = loc_cL + " Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + ;
            " ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13)+CHR(10) + ;
            "   txt_4c_CEmps=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_CEmps",5)) + ;
            " txt_4c_DEmps=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_DEmps",5)) + ;
            " grade=" + TRANSFORM(PEMSTATUS(loc_oForm,"grd_4c_Dados",5)) + CHR(13)+CHR(10) + ;
            "   ObterFiltroAcessoEmpresas=" + TRANSFORM(PEMSTATUS(loc_oForm,"ObterFiltroAcessoEmpresas",5)) + ;
            " CarregarUniversoEmpresas=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarUniversoEmpresas",5)) + ;
            " ResolverEmpresa=" + TRANSFORM(PEMSTATUS(loc_oForm,"ResolverEmpresa",5)) + ;
            " AbrirBuscaEmpresaExec=" + TRANSFORM(PEMSTATUS(loc_oForm,"AbrirBuscaEmpresaExec",5)) + CHR(13)+CHR(10)
    ELSE
        loc_cL = loc_cL + " *** NAO ABRIU ***" + CHR(13)+CHR(10)
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13)+CHR(10), OUT, 1)
        QUIT
    ENDIF

    *-- 2) escopos (atributo 2 = Protected)
    loc_cL = "2) escopos (Protected=.T. significa inacessivel de fora):" + CHR(13)+CHR(10) + ;
        "   ValidarEmpresaCEmps       Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarEmpresaCEmps",2))       + " esperado .F." + CHR(13)+CHR(10) + ;
        "   ValidarEmpresaDEmps       Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarEmpresaDEmps",2))       + " esperado .F." + CHR(13)+CHR(10) + ;
        "   CEmpsDblClick             Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CEmpsDblClick",2))             + " esperado .F." + CHR(13)+CHR(10) + ;
        "   DEmpsDblClick             Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"DEmpsDblClick",2))             + " esperado .F." + CHR(13)+CHR(10) + ;
        "   AjustarCamposDependentes  Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AjustarCamposDependentes",2))  + " esperado .F." + CHR(13)+CHR(10) + ;
        "   AbrirBuscaEmpresa         Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AbrirBuscaEmpresa",2))         + " esperado .F." + CHR(13)+CHR(10) + ;
        "   ResolverEmpresa           Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ResolverEmpresa",2))           + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnDirsClick              Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnDirsClick",2))              + " esperado .F." + CHR(13)+CHR(10) + ;
        "   ObterFiltroAcessoEmpresas Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ObterFiltroAcessoEmpresas",2)) + " esperado .T." + CHR(13)+CHR(10) + ;
        "   CarregarUniversoEmpresas  Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarUniversoEmpresas",2))  + " esperado .T." + CHR(13)+CHR(10) + ;
        "   AbrirBuscaEmpresaExec     Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AbrirBuscaEmpresaExec",2))     + " esperado .T." + CHR(13)+CHR(10)
    IF PEMSTATUS(loc_oForm,"ValidarEmpresaCEmps",2) OR PEMSTATUS(loc_oForm,"ValidarEmpresaDEmps",2) ;
       OR PEMSTATUS(loc_oForm,"CEmpsDblClick",2) OR PEMSTATUS(loc_oForm,"DEmpsDblClick",2) ;
       OR PEMSTATUS(loc_oForm,"AjustarCamposDependentes",2) OR PEMSTATUS(loc_oForm,"AbrirBuscaEmpresa",2) ;
       OR PEMSTATUS(loc_oForm,"ResolverEmpresa",2) OR PEMSTATUS(loc_oForm,"BtnDirsClick",2) ;
       OR !PEMSTATUS(loc_oForm,"ObterFiltroAcessoEmpresas",2) ;
       OR !PEMSTATUS(loc_oForm,"CarregarUniversoEmpresas",2) ;
       OR !PEMSTATUS(loc_oForm,"AbrirBuscaEmpresaExec",2)
        loc_cL = loc_cL + "   *** FALHA de escopo" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) tecla comum nao dispara o lookup (regra #47)
    loc_oForm.txt_4c_CEmps.Value = "0"
    loc_oForm.txt_4c_DEmps.Value = "RESIDUO"
    loc_oForm.ValidarEmpresaCEmps(65, 0)   && "A"
    loc_cL = "3) KeyPress com tecla 65 (nao eh Enter/Tab/F4):" + CHR(13)+CHR(10) + ;
        "   CEmps=[" + ALLTRIM(loc_oForm.txt_4c_CEmps.Value) + "] esperado [0]" + ;
        "   DEmps=[" + ALLTRIM(loc_oForm.txt_4c_DEmps.Value) + "] esperado [RESIDUO]" + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_CEmps.Value) != "0" OR ALLTRIM(loc_oForm.txt_4c_DEmps.Value) != "RESIDUO"
        loc_cL = loc_cL + "   *** FALHA: a tecla comum mexeu nos campos" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) Enter com o campo vazio limpa os dois controles (ramo "If llRet")
    loc_oForm.txt_4c_CEmps.Value = ""
    loc_oForm.txt_4c_DEmps.Value = "SOBRA DA BUSCA ANTERIOR"
    loc_oForm.ValidarEmpresaCEmps(13, 0)
    loc_cL = "4) Enter com o codigo VAZIO:" + CHR(13)+CHR(10) + ;
        "   CEmps vazio=" + TRANSFORM(EMPTY(loc_oForm.txt_4c_CEmps.Value)) + ;
        "   DEmps vazio=" + TRANSFORM(EMPTY(loc_oForm.txt_4c_DEmps.Value)) + " ambos esperados .T." + CHR(13)+CHR(10)
    IF !EMPTY(loc_oForm.txt_4c_CEmps.Value) OR !EMPTY(loc_oForm.txt_4c_DEmps.Value)
        loc_cL = loc_cL + "   *** FALHA: nao limpou os dois campos" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) guarda de reentrancia: com a flag ligada o funil devolve na hora
    loc_oForm.this_lEmLookupEmpresa = .T.
    loc_oForm.txt_4c_CEmps.Value = "001"
    loc_oForm.txt_4c_DEmps.Value = "MANTIDO"
    loc_oForm.AbrirBuscaEmpresa("001", "C")
    loc_oForm.CEmpsDblClick()
    loc_cL = "5) guarda de reentrancia ligada (nenhum picker pode abrir):" + CHR(13)+CHR(10) + ;
        "   CEmps=[" + ALLTRIM(loc_oForm.txt_4c_CEmps.Value) + "] esperado [001]" + ;
        "   DEmps=[" + ALLTRIM(loc_oForm.txt_4c_DEmps.Value) + "] esperado [MANTIDO]" + ;
        "   flag ainda ligada=" + TRANSFORM(loc_oForm.this_lEmLookupEmpresa) + " esperado .T." + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_CEmps.Value) != "001" ;
       OR ALLTRIM(loc_oForm.txt_4c_DEmps.Value) != "MANTIDO" ;
       OR !loc_oForm.this_lEmLookupEmpresa
        loc_cL = loc_cL + "   *** FALHA na guarda de reentrancia" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- a flag tem de ser LIBERADA pelo funil mesmo com o corpo falhando
    loc_oForm.this_lEmLookupEmpresa = .F.
    loc_oForm.AbrirBuscaEmpresa("001", "C")
    loc_cL = "5b) apos um ciclo completo do funil (corpo falha sem conexao):" + CHR(13)+CHR(10) + ;
        "   flag liberada=" + TRANSFORM(!loc_oForm.this_lEmLookupEmpresa) + " esperado .T." + CHR(13)+CHR(10)
    IF loc_oForm.this_lEmLookupEmpresa
        loc_cL = loc_cL + "   *** FALHA: flag travou ligada e mataria o lookup" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) getDEmps.When legado, nos dois sentidos
    loc_oForm.txt_4c_CEmps.Value = "001"
    loc_oForm.AjustarCamposDependentes()
    loc_cL = "6) When de getDEmps aplicado por ReadOnly:" + CHR(13)+CHR(10) + ;
        "   codigo preenchido -> DEmps.ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_DEmps.ReadOnly) + " esperado .T." + CHR(13)+CHR(10)
    IF !loc_oForm.txt_4c_DEmps.ReadOnly
        loc_cL = loc_cL + "   *** FALHA: descricao editavel com o codigo preenchido" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.txt_4c_CEmps.Value = ""
    loc_oForm.AjustarCamposDependentes()
    loc_cL = loc_cL + "   codigo vazio      -> DEmps.ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_DEmps.ReadOnly) + " esperado .F." + ;
        "   Dirs.ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_Dirs.ReadOnly) + " esperado .T." + CHR(13)+CHR(10)
    IF loc_oForm.txt_4c_DEmps.ReadOnly OR !loc_oForm.txt_4c_Dirs.ReadOnly
        loc_cL = loc_cL + "   *** FALHA: o funil nao LIBEROU o que tinha restringido" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) o filtro de acesso nao estoura sem conexao
    loc_cFiltro = loc_oForm.TesteObterFiltro()
    loc_cL = "7) ObterFiltroAcessoEmpresas() sem conexao -> VARTYPE=" + VARTYPE(loc_cFiltro) + ;
        " esperado C   valor=[" + loc_cFiltro + "]" + CHR(13)+CHR(10)
    IF VARTYPE(loc_cFiltro) != "C"
        loc_cL = loc_cL + "   *** FALHA: nao devolveu Caractere" + CHR(13)+CHR(10)
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

*-- Subclasse para alcancar o helper PROTECTED (script solto nao alcanca
*-- membro protegido; subclasse alcanca - tecnica padrao do projeto).
DEFINE CLASS ProbeNseF6 AS FormSIGPRNSE
    FUNCTION TesteObterFiltro()
        RETURN THIS.ObterFiltroAcessoEmpresas()
    ENDFUNC
ENDDEFINE
