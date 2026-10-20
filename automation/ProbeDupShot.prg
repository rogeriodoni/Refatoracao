*==============================================================================
* ProbeDupShot.prg - Abre FormDup e deixa a tela VISIVEL para captura (Erro231)
*
* O form eh modal em producao (WindowType = 1) e Show() travaria o processo.
* Aqui o WindowType eh forcado a 0 (modeless) SO NO PROBE, para que Show()
* retorne e o PowerShell consiga capturar a janela.
*
* Grava um arquivo-sentinela quando a tela esta pronta; o chamador espera por
* ele, captura e grava o arquivo de parada para o probe fechar tudo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_dupshot.txt"

#DEFINE OUT    "C:\4c\automation\probe_dup_shot.txt"
#DEFINE PRONTO "C:\4c\automation\probe_dup_pronto.flag"
#DEFINE PARAR  "C:\4c\automation\probe_dup_parar.flag"

LOCAL loc_oForm, loc_oE, loc_nEspera

STRTOFILE("=== PROBE SHOT - FormDup ===" + CHR(13)+CHR(10), OUT)
IF FILE(PRONTO)
    DELETE FILE (PRONTO)
ENDIF
IF FILE(PARAR)
    DELETE FILE (PARAR)
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
    SET PROCEDURE TO (gcCaminhoClasses + "DupBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormDup.prg") ADDITIVE

    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
        gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    ENDIF
    STRTOFILE("gnConnHandle = " + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    loc_oForm = CREATEOBJECT("FormDup")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("*** NAO INSTANCIOU ***" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        *-- SO no probe: tira a modalidade para Show() retornar
        loc_oForm.WindowType = 0

        *-- Erro232: a tela reportada eh a pagina DADOS, entao entra em INCLUIR

        loc_oForm.BtnIncluirClick()
        loc_oForm.Show()
        loc_oForm.Caption = loc_oForm.Caption
        STRTOFILE("Show() OK - linhas no cursor = " + ;
                  IIF(USED("cursor_4c_Dados"), TRANSFORM(RECCOUNT("cursor_4c_Dados")), "cursor fechado") + ;
                  CHR(13)+CHR(10), OUT, 1)

        STRTOFILE("pronto", PRONTO)

        *-- espera o chamador capturar (limite ~40s)
        loc_nEspera = 0
        DO WHILE !FILE(PARAR) AND loc_nEspera < 400
            DOEVENTS
            = INKEY(0.1)
            loc_nEspera = loc_nEspera + 1
        ENDDO

        STRTOFILE("encerrando apos " + TRANSFORM(loc_nEspera / 10) + "s" + CHR(13)+CHR(10), OUT, 1)
        loc_oForm.Release()
    ENDIF
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ;
              ", " + loc_oE.Procedure + ")" + CHR(13)+CHR(10), OUT, 1)
ENDTRY

STRTOFILE("=== FIM ===" + CHR(13)+CHR(10), OUT, 1)
QUIT
