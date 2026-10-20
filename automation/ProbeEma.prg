*==============================================================================
* ProbeEma.prg - Prova que o Cadastro de Email abre e grava (Erro233)
*
*   1) instancia Formema com conexao real (era aqui que estourava
*      "Nome de objeto 'SigCdEma' invalido")
*   2) CarregarLista devolve .T. e a grade fica vinculada
*   3) INCLUIR -> preenche o email -> Salvar -> le de volta do banco
*   4) EXCLUIR o registro de teste e conferir que a tabela volta ao estado
*      anterior (a tabela foi criada vazia agora)
*
* NAO chama Show(): o form eh modal e travaria o harness.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ema.txt"

#DEFINE OUT   "C:\4c\automation\probe_ema.txt"
#DEFINE EMAIL "teste.erro233@exemplo.invalido"

LOCAL loc_oForm, loc_oE, loc_nAntes, loc_nDepois, loc_nErros, loc_lOk

STRTOFILE("=== PROBE Cadastro de Email (Erro233) ===" + CHR(13)+CHR(10), OUT)
loc_nErros = 0

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
    SET PROCEDURE TO (gcCaminhoClasses + "emaBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formema.prg") ADDITIVE

    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
        gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    ENDIF
    STRTOFILE("gnConnHandle = " + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    *-- limpa resto de rodada anterior e mede o baseline
    = SQLEXEC(gnConnHandle, "DELETE FROM SigCdEma WHERE Cods LIKE 'teste.erro233%'", "qd")
    IF USED("qd")
        USE IN qd
    ENDIF
    = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCdEma", "qa")
    loc_nAntes = qa.n
    USE IN qa
    STRTOFILE("linhas em SigCdEma ANTES = " + TRANSFORM(loc_nAntes) + CHR(13)+CHR(10), OUT, 1)

    *-- 1) a tela abre?
    loc_oForm = CREATEOBJECT("Formema")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("*** A TELA NAO ABRIU (CREATEOBJECT devolveu nao-objeto) ***" + CHR(13)+CHR(10), OUT, 1)
        loc_nErros = loc_nErros + 1
    ELSE
        STRTOFILE("1) tela ABRIU  Caption=[" + loc_oForm.Caption + "]" + ;
                  "  Width=" + TRANSFORM(loc_oForm.Width) + ;
                  "  Height=" + TRANSFORM(loc_oForm.Height) + CHR(13)+CHR(10), OUT, 1)

        *-- 2) a lista carrega?
        loc_lOk = loc_oForm.CarregarLista()
        STRTOFILE("2) CarregarLista = " + TRANSFORM(loc_lOk) + ;
                  "   cursor_4c_Dados usado = " + TRANSFORM(USED("cursor_4c_Dados")) + CHR(13)+CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nErros = loc_nErros + 1
        ENDIF

        *-- 3) incluir + gravar
        loc_oForm.BtnIncluirClick()
        STRTOFILE("3) modo apos Incluir = " + loc_oForm.this_cModoAtual + CHR(13)+CHR(10), OUT, 1)
        IF PEMSTATUS(loc_oForm.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
            loc_oForm.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value = EMAIL
        ELSE
            STRTOFILE("   *** campo txt_4c_Codigo nao existe na Page2" + CHR(13)+CHR(10), OUT, 1)
            loc_nErros = loc_nErros + 1
        ENDIF
        loc_oForm.BtnSalvarClick()
        STRTOFILE("   modo apos Salvar  = " + loc_oForm.this_cModoAtual + CHR(13)+CHR(10), OUT, 1)

        *-- le de volta
        IF SQLEXEC(gnConnHandle, "SELECT cIdChaves, Cods FROM SigCdEma WHERE Cods LIKE 'teste.erro233%'", "qr") < 1
            STRTOFILE("   *** SELECT de volta falhou: " + MESSAGE() + CHR(13)+CHR(10), OUT, 1)
            loc_nErros = loc_nErros + 1
        ELSE
            IF RECCOUNT("qr") = 0
                STRTOFILE("   *** NAO GRAVOU" + CHR(13)+CHR(10), OUT, 1)
                loc_nErros = loc_nErros + 1
            ELSE
                STRTOFILE("   GRAVOU: Cods=[" + ALLTRIM(qr.Cods) + "]" + ;
                          "  cIdChaves=[" + ALLTRIM(qr.cIdChaves) + "]" + CHR(13)+CHR(10), OUT, 1)
                IF EMPTY(ALLTRIM(qr.cIdChaves))
                    STRTOFILE("   *** cIdChaves VAZIO - o 2o registro colidiria na PK" + CHR(13)+CHR(10), OUT, 1)
                    loc_nErros = loc_nErros + 1
                ENDIF
            ENDIF
            USE IN qr
        ENDIF

        loc_oForm.Release()
    ENDIF

    *-- 4) limpeza
    = SQLEXEC(gnConnHandle, "DELETE FROM SigCdEma WHERE Cods LIKE 'teste.erro233%'", "qd2")
    IF USED("qd2")
        USE IN qd2
    ENDIF
    = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCdEma", "qb")
    loc_nDepois = qb.n
    USE IN qb
    STRTOFILE(CHR(13)+CHR(10) + "4) linhas DEPOIS da limpeza = " + TRANSFORM(loc_nDepois) + ;
              IIF(loc_nDepois = loc_nAntes, "  (igual ao inicial - OK)", "  *** SOBROU LIXO ***") + ;
              CHR(13)+CHR(10), OUT, 1)
    IF loc_nDepois != loc_nAntes
        loc_nErros = loc_nErros + 1
    ENDIF
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ;
              ", " + loc_oE.Procedure + ")" + CHR(13)+CHR(10), OUT, 1)
    loc_nErros = loc_nErros + 1
ENDTRY

STRTOFILE(CHR(13)+CHR(10) + "=== RESULTADO: " + ;
          IIF(loc_nErros = 0, "TELA ABRE E GRAVA", TRANSFORM(loc_nErros) + " PROBLEMA(S)") + ;
          " ===" + CHR(13)+CHR(10), OUT, 1)
QUIT
