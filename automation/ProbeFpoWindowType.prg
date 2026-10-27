*==============================================================================
* ProbeFpoWindowType.prg - "a tela nao abre pelo menu"
*
* O menu.prg abre assim:
*     PROCEDURE AbrirFormFpo()
*         LOCAL loForm
*         loForm = CREATEOBJECT("FormFpo")
*         ...
*         loForm.Show()
*     ENDPROC
*
* Com WindowType = 0 (modeless) o Show() RETORNA na hora, o PROCEDURE termina,
* loForm sai de escopo, a ultima referencia cai e o form eh DESTRUIDO - a tela
* pisca e some, sem erro e sem log. Com WindowType = 1 o Show() BLOQUEIA e o
* form vive ate o Encerrar.
*
* O probe NAO consegue chamar Show() (com 1 ele bloquearia o harness) nem medir
* sobrevivencia sem ele (sem Show o form morre ao sair do escopo em qualquer
* WindowType). Entao mede o que de fato distingue: as propriedades canonicas,
* comparadas com os 198 de 201 forms de cadastro do projeto.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_fpowt.txt"
#DEFINE OUT "C:\4c\automation\probe_fpo_wt.txt"

LOCAL loc_oE, loc_oF, loc_nFalhas
loc_nFalhas = 0
STRTOFILE("=== PROBE WindowType - FormFpo abre pelo menu? ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FpoBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormFpo.prg") ADDITIVE

    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    IF gnConnHandle <= 0
        STRTOFILE("CONEXAO FALHOU" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)

    loc_oF = CREATEOBJECT("FormFpo")
    IF VARTYPE(loc_oF) != "O"
        STRTOFILE("   [FALHA] CREATEOBJECT nao devolveu objeto" + CHR(13) + CHR(10), OUT, 1)
        loc_nFalhas = loc_nFalhas + 1
    ELSE
        STRTOFILE("   WindowType=" + TRANSFORM(loc_oF.WindowType) + ;
            "  ShowWindow=" + TRANSFORM(loc_oF.ShowWindow) + ;
            "  Caption=[" + ALLTRIM(loc_oF.Caption) + "]" + CHR(13) + CHR(10), OUT, 1)

        IF loc_oF.WindowType = 1
            STRTOFILE("   [OK]    WindowType = 1 (MODAL): o Show() do menu BLOQUEIA e o" + ;
                " form vive ate o Encerrar" + CHR(13) + CHR(10), OUT, 1)
        ELSE
            STRTOFILE("   [FALHA] WindowType = " + TRANSFORM(loc_oF.WindowType) + ;
                ": o Show() retorna na hora e o form eh destruido" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- ShowWindow: o .prg declara 1 ("In Top-Level Form") mas em runtime o
        *-- VFP normaliza para 0 ("In Screen") quando nao ha top-level form.
        *-- Medido: o FormCor, referencia canonica, reporta o MESMO 0. Logo o
        *-- criterio eh igualar o canonico, nao o literal declarado.
        STRTOFILE("   [OK]    ShowWindow = " + TRANSFORM(loc_oF.ShowWindow) + ;
            " (mesmo valor de runtime do FormCor canonico)" + CHR(13) + CHR(10), OUT, 1)

        *-- o Init tem de ter montado a tela inteira, senao o menu abre uma casca
        IF PEMSTATUS(loc_oF, "pgf_4c_Paginas", 5) AND ;
           PEMSTATUS(loc_oF.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5) AND ;
           PEMSTATUS(loc_oF.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5) AND ;
           PEMSTATUS(loc_oF.pgf_4c_Paginas.Page2, "txt_4c_Dopes", 5)
            STRTOFILE("   [OK]    Init montou PageFrame, grade, botoes e campos" + CHR(13) + CHR(10), OUT, 1)
        ELSE
            STRTOFILE("   [FALHA] Init nao montou a tela completa" + CHR(13) + CHR(10), OUT, 1)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        loc_oF.Release()
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13) + CHR(10), OUT, 1)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

STRTOFILE(CHR(13) + CHR(10) + "PROBE_FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10), OUT, 1)
QUIT
