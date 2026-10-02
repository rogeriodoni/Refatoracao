*-- Erro179 verificacao: grade de sub-grupos da aba Cadastro (grd_4c_PsgCad).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_gpdgrid.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_gpdgrid.txt"
LOCAL loc_oE, loc_oForm, loc_nR, loc_cGru, loc_oPg1
STRTOFILE("A: inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gpdbo.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formgpd.prg") ADDITIVE
    STRTOFILE("C: deps OK" + CHR(13)+CHR(10), OUT, 1)

    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    STRTOFILE("D: conn=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    loc_oForm = CREATEOBJECT("Formgpd")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("E: NAO INSTANCIOU" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        STRTOFILE("E: Init OK" + CHR(13)+CHR(10), OUT, 1)
        SET DATASESSION TO loc_oForm.DataSessionId
        loc_oPg1 = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        STRTOFILE(Dump(loc_oForm, "01-apos-Init"), OUT, 1)

        *-- ALTERAR: recarrega a partir de um grupo REAL que tenha sub-grupos
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 cgrus, COUNT(*) AS qtd FROM SigCdPsg GROUP BY cgrus " + ;
            "ORDER BY COUNT(*) DESC", "crTopGru")
        loc_cGru = ""
        IF loc_nR > 0 AND RECCOUNT("crTopGru") > 0
            loc_cGru = ALLTRIM(crTopGru.cgrus)
            STRTOFILE("   grupo com mais sub-grupos = [" + loc_cGru + "] qtd=" + ;
                      TRANSFORM(crTopGru.qtd) + CHR(13)+CHR(10), OUT, 1)
        ENDIF
        loc_oForm.CarregarSigCdPsgCad(loc_cGru)
        STRTOFILE(Dump(loc_oForm, "02-apos-CarregarSigCdPsgCad (ALTERAR)"), OUT, 1)

        *-- INCLUIR logo depois (era aqui que a grade continuava morta)
        loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Gde.Value = "JOO"
        loc_oForm.BtnIncluirClick()
        STRTOFILE(Dump(loc_oForm, "03-apos-BtnIncluirClick"), OUT, 1)

        *-- clique no "+" SEM codigo de grupo: guard do When legado deve barrar
        loc_oPg1.txt_4c_Cgrus.Value = ""
        loc_oForm.PsgCadInserirClick()
        STRTOFILE(Dump(loc_oForm, "04-clique-+-SEM-codigo (deve ficar 0 linhas)"), OUT, 1)

        *-- clique no "+" COM codigo: cria linha e LIBERA a Column1
        loc_oPg1.txt_4c_Cgrus.Value = "ZZ9"
        loc_oForm.PsgCadInserirClick()
        STRTOFILE(Dump(loc_oForm, "05-clique-+-COM-codigo"), OUT, 1)
        IF USED("cursor_4c_SigCdPsg") AND RECCOUNT("cursor_4c_SigCdPsg") > 0
            GO TOP IN cursor_4c_SigCdPsg
            STRTOFILE("   linha: cgrus=[" + cursor_4c_SigCdPsg.cgrus + "]" + ;
                " codigos=[" + cursor_4c_SigCdPsg.codigos + "]" + ;
                " cgrucods=[" + cursor_4c_SigCdPsg.cgrucods + "] len=" + ;
                TRANSFORM(LEN(cursor_4c_SigCdPsg.cgrucods)) + ;
                " cidchaves=[" + ALLTRIM(cursor_4c_SigCdPsg.cidchaves) + "]" + ;
                CHR(13)+CHR(10), OUT, 1)
        ENDIF

        *-- digita o codigo/descricao e grava; depois le de volta do servidor
        SELECT cursor_4c_SigCdPsg
        GO TOP
        REPLACE codigos WITH "E179T1", descricaos WITH "TESTE ERRO179", ;
                marckupa WITH 12.34 IN cursor_4c_SigCdPsg
        loc_oForm.SalvarSigCdPsg("ZZ9")
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT cgrus, codigos, descricaos, cgrucods, marckupa FROM SigCdPsg " + ;
            "WHERE cgrus = 'ZZ9'", "crVerif")
        STRTOFILE(CHR(13)+CHR(10) + "=== 06-gravacao: SQLEXEC=" + TRANSFORM(loc_nR) + ;
            " linhas=" + TRANSFORM(IIF(USED("crVerif"), RECCOUNT("crVerif"), -1)) + ;
            CHR(13)+CHR(10), OUT, 1)
        IF USED("crVerif") AND RECCOUNT("crVerif") > 0
            SCAN
                STRTOFILE("   BANCO: cgrus=[" + crVerif.cgrus + "] cod=[" + ;
                    crVerif.codigos + "] desc=[" + ALLTRIM(crVerif.descricaos) + ;
                    "] cgrucods=[" + crVerif.cgrucods + "] markup=" + ;
                    TRANSFORM(crVerif.marckupa) + CHR(13)+CHR(10), OUT, 1)
            ENDSCAN
        ENDIF
        *-- limpeza: o grupo ZZ9 eh so do teste
        SQLEXEC(gnConnHandle, "DELETE FROM SigCdPsg WHERE cgrus = 'ZZ9'")
        STRTOFILE("   limpeza ZZ9 executada" + CHR(13)+CHR(10), OUT, 1)
    ENDIF
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13)+CHR(10), OUT, 1)
QUIT

FUNCTION Dump(par_oForm, par_cTag)
    LOCAL loc_c, loc_oG, loc_oE3, loc_nI
    loc_c = CHR(13)+CHR(10) + "=== " + par_cTag + CHR(13)+CHR(10)
    TRY
        loc_c = loc_c + "  USED=" + TRANSFORM(USED("cursor_4c_SigCdPsg"))
        IF USED("cursor_4c_SigCdPsg")
            loc_c = loc_c + "  RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_SigCdPsg")) + ;
                    "  FCOUNT=" + TRANSFORM(FCOUNT("cursor_4c_SigCdPsg"))
        ENDIF
        loc_c = loc_c + CHR(13)+CHR(10)
        loc_oG = par_oForm.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1.grd_4c_PsgCad
        loc_c = loc_c + "  Grid RecordSource=[" + loc_oG.RecordSource + "]" + ;
                "  ColumnCount=" + TRANSFORM(loc_oG.ColumnCount) + CHR(13)+CHR(10)
        FOR loc_nI = 1 TO loc_oG.ColumnCount
            loc_c = loc_c + "  Col" + TRANSFORM(loc_nI) + ;
                " CS=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".ControlSource") + "]" + ;
                " W=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".Width")) + ;
                " Cap=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".Header1.Caption") + "]" + ;
                " CC=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".CurrentControl") + "]" + ;
                " RO=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".ReadOnly")) + ;
                CHR(13)+CHR(10)
        ENDFOR
    CATCH TO loc_oE3
        loc_c = loc_c + "  DUMP-ERRO: " + loc_oE3.Message + CHR(13)+CHR(10)
    ENDTRY
    RETURN loc_c
ENDFUNC
