*==============================================================================
* Probe723F6b.prg - Mesmo probe da Fase 6 (task723), mas gravando CADA
* checkpoint NA HORA (STRTOFILE append), para localizar onde a execucao para.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gb_4c_ValidandoUI
PUBLIC pc_cSaida

pc_cSaida = "C:\4c\automation\probe723f6b.txt"

STRTOFILE("A: inicio" + CHR(13) + CHR(10), pc_cSaida)

LOCAL loc_oE

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    Anota("B: config.prg OK")

    *-- DEPOIS do config.prg: ele reseta gb_4c_ValidandoUI (linha 118)
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\probe723f6b_dialogs.txt"
    gb_4c_ValidandoUI      = .F.
    gnConnHandle           = 0
    IF FILE(gc_4c_ArquivoErroTeste)
        DELETE FILE (gc_4c_ArquivoErroTeste)
    ENDIF
    Anota("B2: flags de teste setadas (ModoTeste=" + ;
        TRANSFORM(gb_4c_ModoTeste) + ")")

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + ;
                 gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpDocBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpDoc.prg") ADDITIVE
    Anota("C: deps carregadas")

    Exercitar()

CATCH TO loc_oE
    Anota("EXCEPTION: " + loc_oE.Message + " | Linha: " + ;
        TRANSFORM(loc_oE.LineNo) + " | Proc: " + loc_oE.Procedure)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    Anota("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    Anota("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF

Anota("Z: fim")
QUIT


PROCEDURE Anota(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), pc_cSaida, 1)
ENDPROC


PROCEDURE Exercitar()
    LOCAL loc_oForm, loc_oE2, loc_cImg, loc_cNomes
    loc_cImg = "C:\TEMP\probe723img.jpg"

    TRY
        Anota("D: antes do CREATEOBJECT")
        loc_oForm = CREATEOBJECT("FormSigOpDoc", "CHAVE-DE-TESTE-723", "ALTERAR")
        Anota("CK01 CREATEOBJECT devolveu " + VARTYPE(loc_oForm))

        IF VARTYPE(loc_oForm) != "O"
            Anota("FALHA: a tela NAO abre")
        ELSE
            Anota("CK02 lbl_4c_Label1  T/L/W/H = " + ;
                TRANSFORM(loc_oForm.lbl_4c_Label1.Top) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label1.Left) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label1.Width) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label1.Height) + ;
                "  (dump 599/414/119/15)")

            Anota("CK03 lbl_4c_Label2  T/L/W/H = " + ;
                TRANSFORM(loc_oForm.lbl_4c_Label2.Top) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label2.Left) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label2.Width) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label2.Height) + ;
                "  (dump 599/667/103/15)")

            Anota("CK04 txt_4c_Usuars  T/L = " + ;
                TRANSFORM(loc_oForm.txt_4c_Usuars.Top) + "/" + ;
                TRANSFORM(loc_oForm.txt_4c_Usuars.Left) + ;
                "  Enabled=" + TRANSFORM(loc_oForm.txt_4c_Usuars.Enabled) + ;
                "  (dump 595/535 Enabled=.F.)")

            Anota("CK05 txt_4c_Datas   T/L/W = " + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Top) + "/" + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Left) + "/" + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Width) + ;
                "  Enabled=" + TRANSFORM(loc_oForm.txt_4c_Datas.Enabled) + ;
                "  (dump 595/772/143 Enabled=.F.)")

            Anota("CK06 cursor USED=" + TRANSFORM(USED("cursor_4c_Dados")) + ;
                "  ObsArqs.CS=[" + loc_oForm.obj_4c_GetObsArqs.ControlSource + "]" + ;
                "  Usuars.CS=[" + loc_oForm.txt_4c_Usuars.ControlSource + "]" + ;
                "  Datas.CS=[" + loc_oForm.txt_4c_Datas.ControlSource + "]")

            Anota("CK07 grade RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + ;
                "]  Col1.CS=[" + loc_oForm.grd_4c_Dados.Column1.ControlSource + ;
                "]  Col1.W=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + ;
                "  (esperado cursor_4c_Dados / .Arquivos / 778)")

            Anota("CK08 grade vazia -> img.Visible=" + ;
                TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + "  (esperado .F.)")

            SET DATASESSION TO loc_oForm.DataSessionID
            Anota("D1b: datasession do form = " + TRANSFORM(SET("DATASESSION")) + "  cursor USED=" + TRANSFORM(USED("cursor_4c_Dados")))
            INSERT INTO cursor_4c_Dados ;
                (pkChaves, fkChaves, Arquivos, ObsArqs, Usuars, Datas) ;
                VALUES ("PK1", "CHAVE-DE-TESTE-723", loc_cImg, "obs um", ;
                        "TESTE", DATETIME())
            SELECT cursor_4c_Dados
            GO TOP
            Anota("D2: linha 1 inserida, antes do GradeAfterRowColChange")
            loc_oForm.GradeAfterRowColChange(1)
            Anota("CK09 linha JPG real -> img.Visible=" + ;
                TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
                "  Picture=[" + loc_oForm.img_4c_ImgArqJpg.Picture + "]" + ;
                "  (esperado .T. + caminho)")

            Anota("CK10 detalhe Usuars=[" + ;
                ALLTRIM(TRANSFORM(loc_oForm.txt_4c_Usuars.Value)) + ;
                "]  ObsArqs=[" + ;
                ALLTRIM(TRANSFORM(loc_oForm.obj_4c_GetObsArqs.Value)) + "]" + ;
                "  (esperado TESTE / obs um)")

            INSERT INTO cursor_4c_Dados ;
                (pkChaves, fkChaves, Arquivos, ObsArqs, Usuars, Datas) ;
                VALUES ("PK2", "CHAVE-DE-TESTE-723", "C:\TEMP\doc_qualquer.pdf", ;
                        "obs dois", "OUTRO", DATETIME())
            SELECT cursor_4c_Dados
            GO BOTTOM
            loc_oForm.GradeAfterRowColChange(1)
            Anota("CK11 linha PDF -> img.Visible=" + ;
                TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
                "  detalhe Usuars=[" + ;
                ALLTRIM(TRANSFORM(loc_oForm.txt_4c_Usuars.Value)) + "]" + ;
                "  (esperado .F. / OUTRO)")

            SELECT cursor_4c_Dados
            GO BOTTOM
            REPLACE Arquivos WITH "C:\TEMP\arquivosemponto" IN cursor_4c_Dados
            loc_oForm.GradeAfterRowColChange(1)
            Anota("CK12 nome sem ponto -> img.Visible=" + ;
                TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
                "  (esperado .F., sem excecao)")

            Anota("D3: antes do DblClick em nao-imagem")
            loc_oForm.ImgArqJpgDblClick()
            Anota("CK13 DblClick em nao-imagem: sem excecao")

            SELECT cursor_4c_Dados
            GO TOP
            Anota("D4: antes do DblClick em JPG real (SigOpZom ausente)")
            loc_oForm.ImgArqJpgDblClick()
            Anota("CK14 DblClick em JPG real: tratou ausencia de SigOpZom")

            SELECT cursor_4c_Dados
            GO BOTTOM
            REPLACE Arquivos WITH "C:\TEMP\nao_existe_723.pdf" IN cursor_4c_Dados
            Anota("D5: antes de BtnOpnArqsClick com arquivo inexistente")
            loc_oForm.BtnOpnArqsClick()
            loc_oForm.BtnOpnDirsClick()
            Anota("CK15 arquivo inexistente: avisou sem excecao")

            Anota("CK16 modo ALTERAR: Inserir.En=" + ;
                TRANSFORM(loc_oForm.cmd_4c_BtnInsArqs.Enabled) + ;
                " Excluir.En=" + TRANSFORM(loc_oForm.cmd_4c_BtnExcArqs.Enabled) + ;
                " Obs.RO=" + TRANSFORM(loc_oForm.obj_4c_GetObsArqs.ReadOnly) + ;
                " Abrir.En=" + TRANSFORM(loc_oForm.cmd_4c_BtnOpnArqs.Enabled) + ;
                "  (esperado .T./.T./.F./.T.)")

            loc_oForm.this_cEscolha = "PROCURAR"
            loc_oForm.AjustarBotoesPorModo()
            Anota("CK17 modo PROCURAR: Inserir.En=" + ;
                TRANSFORM(loc_oForm.cmd_4c_BtnInsArqs.Enabled) + ;
                " Excluir.En=" + TRANSFORM(loc_oForm.cmd_4c_BtnExcArqs.Enabled) + ;
                " Obs.RO=" + TRANSFORM(loc_oForm.obj_4c_GetObsArqs.ReadOnly) + ;
                " Abrir.En=" + TRANSFORM(loc_oForm.cmd_4c_BtnOpnArqs.Enabled) + ;
                "  (esperado .F./.F./.T./.T.)")

            loc_cNomes = "GradeAfterRowColChange,ImgArqJpgDblClick," + ;
                "BtnInsArqsClick,BtnOpnArqsClick,BtnExcArqsClick," + ;
                "BtnOpnDirsClick,CarregarLista,AjustarBotoesPorModo"
            Anota("CK18 visibilidade:" + CHR(13) + CHR(10) + ;
                ChecarPublicos(loc_oForm, loc_cNomes))

            Anota("CK19 internos PROTECTED: ValidarArquivoSelecionado=" + ;
                TRANSFORM(PEMSTATUS(loc_oForm, "ValidarArquivoSelecionado", 2)) + ;
                " ValidarExtensaoImagem=" + ;
                TRANSFORM(PEMSTATUS(loc_oForm, "ValidarExtensaoImagem", 2)) + ;
                " VincularCamposDetalhe=" + ;
                TRANSFORM(PEMSTATUS(loc_oForm, "VincularCamposDetalhe", 2)) + ;
                "  (esperado .T./.T./.T.)")

            Anota("CK20 Datas dir=" + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Left + ;
                          loc_oForm.txt_4c_Datas.Width) + ;
                " base=" + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Top + ;
                          loc_oForm.txt_4c_Datas.Height) + ;
                " Form W/H=" + TRANSFORM(loc_oForm.Width) + "/" + ;
                TRANSFORM(loc_oForm.Height))

            loc_oForm.Release()
            Anota("CK21 Release OK")
        ENDIF

    CATCH TO loc_oE2
        Anota("EXCEPTION NO EXERCICIO: " + loc_oE2.Message + ;
            " | Linha: " + TRANSFORM(loc_oE2.LineNo) + ;
            " | Proc: " + loc_oE2.Procedure)
    ENDTRY
ENDPROC


FUNCTION ChecarPublicos(par_oForm, par_cNomes)
    LOCAL loc_nI, loc_cNome, loc_cRuins, loc_nQtd
    loc_cRuins = ""
    loc_nQtd   = 0

    FOR loc_nI = 1 TO GETWORDCOUNT(par_cNomes, ",")
        loc_cNome = ALLTRIM(GETWORDNUM(par_cNomes, loc_nI, ","))
        loc_nQtd  = loc_nQtd + 1
        IF !PEMSTATUS(par_oForm, loc_cNome, 5)
            loc_cRuins = loc_cRuins + "     AUSENTE: " + loc_cNome + ;
                CHR(13) + CHR(10)
        ELSE
            IF PEMSTATUS(par_oForm, loc_cNome, 2)
                loc_cRuins = loc_cRuins + "     PROTECTED: " + loc_cNome + ;
                    CHR(13) + CHR(10)
            ENDIF
        ENDIF
    ENDFOR

    RETURN "     " + TRANSFORM(loc_nQtd) + " metodos conferidos; " + ;
        IIF(EMPTY(loc_cRuins), "TODOS existem e sao PUBLIC", "PROBLEMAS:") + ;
        CHR(13) + CHR(10) + loc_cRuins
ENDFUNC
