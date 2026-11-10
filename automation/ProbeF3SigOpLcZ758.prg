*-- ProbeF3SigOpLcZ758.prg
*-- Instancia FormSigOpLcZ (Fase 3) carregando SO as dependencias dele, sem o
*-- ConfigurarAmbiente() completo (que BLOQUEIA nesta maquina).
*-- Prova: (1) o caminho do harness (CREATEOBJECT sem argumento nenhum) e
*--        (2) o caminho real (cnx/escolha/origem + crTpmMvItn do form PAI
*--            aberto na sessao corrente, que eh o contrato DataSession = 1).
*-- Regra #1 do CLAUDE.md vale para este script tambem: nenhum RETURN dentro
*-- de TRY/CATCH - as funcoes acumulam o texto em loc_cOut e devolvem no fim.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_f3lcz.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

#DEFINE SAIDA "C:\4c\automation\probe_f3lcz.txt"

LOCAL loc_oE
STRTOFILE("A: inicio" + CHR(13) + CHR(10), SAIDA)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), SAIDA, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + ;
                 gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpLcZBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpLcZ.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), SAIDA, 1)

    *-- (1) caminho do harness: nenhum argumento, nenhum cursor do PAI
    STRTOFILE(ExercitarSemArgs() + CHR(13) + CHR(10), SAIDA, 1)

    *-- (2) caminho real: cursor do PAI aberto + modo/origem vindos do chamador
    STRTOFILE(ExercitarComPai("INSERIR", "ORIGEM") + CHR(13) + CHR(10), SAIDA, 1)
    STRTOFILE(ExercitarComPai("PROCURAR", "DESTINO") + CHR(13) + CHR(10), SAIDA, 1)

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), SAIDA, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), SAIDA, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13) + CHR(10), SAIDA, 1)
QUIT


*-- Caminho que o TestFormWrapper exercita: CREATEOBJECT sem argumento.
*-- Nenhuma ausencia (nem de parametro nem do cursor do PAI) pode derrubar
*-- o Init - se derrubar, CREATEOBJECT devolve o logico .F.
FUNCTION ExercitarSemArgs()
    LOCAL loc_oForm, loc_cOut, loc_oE2
    loc_cOut = "(1) sem args: "

    TRY
        IF USED("crTpmMvItn")
            USE IN crTpmMvItn
        ENDIF

        loc_oForm = CREATEOBJECT("FormSigOpLcZ")

        IF VARTYPE(loc_oForm) != "O"
            loc_cOut = loc_cOut + "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ELSE
            loc_cOut = loc_cOut + "Init OK" + ;
                " | W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
                " DS=" + TRANSFORM(loc_oForm.DataSession) + ;
                " WT=" + TRANSFORM(loc_oForm.WindowType) + ;
                " TB=" + TRANSFORM(loc_oForm.TitleBar) + ;
                " | BO=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
                " | cabecalho=" + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Sombra", 5)) + ;
                " | msgErro=[" + ALLTRIM(loc_oForm.this_cMensagemErro) + "]"

            loc_oForm.Release()
            loc_oForm = .NULL.
        ENDIF
    CATCH TO loc_oE2
        loc_cOut = loc_cOut + "EXCEPTION: " + loc_oE2.Message + ;
            " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY

    RETURN loc_cOut
ENDFUNC


*-- Caminho real: o form PAI deixa crTpmMvItn aberto NESTA sessao (contrato
*-- DataSession = 1) e passa cnx/escolha/origem. Conferem-se aqui a casca do
*-- cabecalho (geometria/cores/captions transcritos do SCX), a propagacao do
*-- contexto para o BO e a carga de cursor_4c_Itens a partir do cursor do PAI.
FUNCTION ExercitarComPai(par_cEscolha, par_cOrigem)
    LOCAL loc_oForm, loc_cOut, loc_oE2, loc_oBO, loc_oLbl

    loc_cOut = "(2) escolha=[" + par_cEscolha + "] origem=[" + par_cOrigem + "]: "

    TRY
        *-- cursor do form PAI, com os quatro campos que o legado usa
        IF USED("crTpmMvItn")
            USE IN crTpmMvItn
        ENDIF
        CREATE CURSOR crTpmMvItn (Cpros C(14), Dpros C(60), Locals C(10), LocalOs C(10))
        INSERT INTO crTpmMvItn (Cpros, Dpros, Locals, LocalOs) VALUES ("PRD001", "PRODUTO UM", "", "")
        INSERT INTO crTpmMvItn (Cpros, Dpros, Locals, LocalOs) VALUES ("PRD002", "PRODUTO DOIS", "A1", "B2")
        INSERT INTO crTpmMvItn (Cpros, Dpros, Locals, LocalOs) VALUES ("PRD001", "PRODUTO UM", "", "")
        INSERT INTO crTpmMvItn (Cpros, Dpros, Locals, LocalOs) VALUES ("", "SEM CODIGO", "", "")

        loc_oForm = CREATEOBJECT("FormSigOpLcZ", .NULL., par_cEscolha, par_cOrigem)

        IF VARTYPE(loc_oForm) != "O"
            loc_cOut = loc_cOut + "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
        ELSE
            loc_oBO  = loc_oForm.this_oBusinessObject
            loc_oLbl = loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo

            loc_cOut = loc_cOut + "Init OK" + ;
                " | BOescolha=[" + loc_oBO.this_cEscolha + "]" + ;
                " BOorigem=[" + loc_oBO.this_cOrigem + "]" + ;
                " PodeEditar=" + TRANSFORM(loc_oBO.PodeEditar()) + ;
                " | cnt(T/L/W/H)=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.Top) + "/" + ;
                    TRANSFORM(loc_oForm.cnt_4c_Sombra.Left) + "/" + ;
                    TRANSFORM(loc_oForm.cnt_4c_Sombra.Width) + "/" + ;
                    TRANSFORM(loc_oForm.cnt_4c_Sombra.Height) + ;
                " back=" + TRANSFORM(loc_oForm.cnt_4c_Sombra.BackColor) + ;
                " | titulo(T/W/H)=" + TRANSFORM(loc_oLbl.Top) + "/" + ;
                    TRANSFORM(loc_oLbl.Width) + "/" + TRANSFORM(loc_oLbl.Height) + ;
                " vis=" + TRANSFORM(loc_oLbl.Visible) + ;
                " cap=[" + ALLTRIM(loc_oLbl.Caption) + "]" + ;
                " | sombraCap=[" + ALLTRIM(loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption) + "]" + ;
                " | pic=" + TRANSFORM(FILE(loc_oForm.Picture)) + ;
                " | itens=" + TRANSFORM(USED("cursor_4c_Itens")) + ;
                " reccount=" + TRANSFORM(IIF(USED("cursor_4c_Itens"), RECCOUNT("cursor_4c_Itens"), -1)) + ;
                " selec=" + TRANSFORM(USED("cursor_4c_Selecionados")) + ;
                " | msgErro=[" + ALLTRIM(loc_oForm.this_cMensagemErro) + "]"

            *-- Solta as referencias locais ANTES do Release: enquanto loc_oBO
            *-- aponta para o BO, o objeto nao eh destruido e os cursores de
            *-- trabalho dele continuam abertos (artefato do probe, nao do form).
            loc_oBO  = .NULL.
            loc_oLbl = .NULL.

            *-- Destroy do form tem de liberar o BO (que fecha os cursores de
            *-- trabalho) e NAO pode fechar crTpmMvItn, que eh do PAI
            loc_oForm.Release()
            loc_oForm = .NULL.

            loc_cOut = loc_cOut + " || pos-Release: itens=" + TRANSFORM(USED("cursor_4c_Itens")) + ;
                " selec=" + TRANSFORM(USED("cursor_4c_Selecionados")) + ;
                " crTpmMvItnDoPai=" + TRANSFORM(USED("crTpmMvItn"))
        ENDIF

        IF USED("crTpmMvItn")
            USE IN crTpmMvItn
        ENDIF
    CATCH TO loc_oE2
        loc_cOut = loc_cOut + "EXCEPTION: " + loc_oE2.Message + ;
            " Linha:" + TRANSFORM(loc_oE2.LineNo) + " Proc:" + loc_oE2.Procedure
    ENDTRY

    RETURN loc_cOut
ENDFUNC
