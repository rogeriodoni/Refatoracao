*==============================================================================
* ProbeErro306Msg.prg - Prova que o BtnConfirmarClick exibe "Registro salvo
* com sucesso!" quando o Salvar() da certo. Sem banco o Salvar real falha,
* entao usa-se uma subclasse do PATBO cujo Inserir/Atualizar devolve .T. -
* o que se mede e o CAMINHO do form, nao o SQL.
* gb_4c_ModoTeste manda os MsgInfo/MsgErro para gc_4c_ArquivoErroTeste.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gcL306, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_306.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

gcL306 = "C:\4c\automation\probe_erro306_msg.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcL306)

LOCAL loc_oE, loF, loPg2, lcAntes, lcDepois

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "PATBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormPAT.prg") ADDITIVE
    Log306("B: deps carregadas")

    go_4c_Sistema = CREATEOBJECT("Empty")
    ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")

    loF = CREATEOBJECT("FormPAT")
    IF VARTYPE(loF) # "O"
        Log306("C: form nao instanciou")
    ELSE
        SET DATASESSION TO loF.DataSessionId
        loPg2 = loF.pgf_4c_Paginas.Page2

        *-- troca o BO por um que GRAVA com sucesso (so o caminho importa)
        loF.this_oBusinessObject = CREATEOBJECT("PATBOFake")
        Log306("C: BO de teste instalado")

        *-- entra em INCLUIR e preenche o minimo que o ValidarDados exige
        loF.BtnIncluirClick()
        Log306("D: apos Incluir -> EmEdicao=" + ;
               TRANSFORM(loF.this_oBusinessObject.this_lEmEdicao))
        loPg2.txt_4c_Emps.Value     = "001"
        loPg2.txt_4c_Codvends.Value = "1110100001"
        loPg2.txt_4c_Clientes.Value = "CLIENTE TESTE"
        loPg2.edt_4c_Perguntas.Value = "teste"

        lcAntes = IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "")

        Log306("E: BtnConfirmarClick() = " + TRANSFORM(loF.BtnConfirmarClick()))

        lcDepois = IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "")
        Log306("F: mensagens NOVAS geradas pelo Confirmar:")
        Log306("   " + STRTRAN(ALLTRIM(SUBSTR(lcDepois, LEN(lcAntes) + 1)), CHR(13) + CHR(10), " | "))
        Log306("G: contem 'salvo com sucesso'? " + ;
               TRANSFORM(AT("salvo com sucesso", SUBSTR(lcDepois, LEN(lcAntes) + 1)) > 0))
        Log306("   voltou para a pagina 1? " + ;
               TRANSFORM(loF.pgf_4c_Paginas.ActivePage = 1))

        SET DATASESSION TO 1
        loF.Release()
        Log306("H: Release OK")
    ENDIF

CATCH TO loc_oE
    Log306("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
           " | Proc:" + loc_oE.Procedure)
ENDTRY

Log306("Z: fim")
QUIT

PROCEDURE Log306(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcL306, 1)
ENDPROC

*-- BO de teste: herda tudo, mas Inserir/Atualizar "gravam" com sucesso
DEFINE CLASS PATBOFake AS PATBO
    PROCEDURE Init()
        DODEFAULT()
        RETURN .T.
    ENDPROC
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC
ENDDEFINE
