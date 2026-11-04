*==============================================================================
* Probe723F6.prg - Instancia FormSigOpDoc (Fase 6, task723) e exercita o que a
* fase entregou: campos de auditoria, vinculo de ControlSource, as duas
* validacoes de arquivo e os dois handlers (preview da grade + zoom).
*
* NAO chama ConfigurarAmbiente() - ela BLOQUEIA nesta maquina.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe723f6_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cSai, loc_oE
loc_cSai = "C:\4c\automation\probe723f6.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE("A: inicio" + CHR(13) + CHR(10), loc_cSai)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE("B: config.prg OK" + CHR(13) + CHR(10), loc_cSai, 1)

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
    STRTOFILE("C: deps carregadas" + CHR(13) + CHR(10), loc_cSai, 1)

    STRTOFILE(Exercitar() + CHR(13) + CHR(10), loc_cSai, 1)

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha: " + ;
        TRANSFORM(loc_oE.LineNo) + " | Proc: " + loc_oE.Procedure + ;
        CHR(13) + CHR(10), loc_cSai, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), loc_cSai, 1)
ELSE
    STRTOFILE("DIALOGOS SUPRIMIDOS: nenhum" + CHR(13) + CHR(10), loc_cSai, 1)
ENDIF

STRTOFILE("Z: fim" + CHR(13) + CHR(10), loc_cSai, 1)
QUIT


FUNCTION Exercitar()
    LOCAL loc_oForm, loc_cO, loc_oE2, loc_cImg, loc_cNomes
    loc_cO   = ""
    loc_cImg = "C:\TEMP\probe723img.jpg"

    TRY
        *-- Init recebe (pKey, pEsc) como o legado
        loc_oForm = CREATEOBJECT("FormSigOpDoc", "CHAVE-DE-TESTE-723", "ALTERAR")

        IF VARTYPE(loc_oForm) != "O"
            loc_cO = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm)
        ELSE
            loc_cO = "CK01 instanciou OK (a tela ABRE)" + CHR(13) + CHR(10)

            *-- 1. Geometria dos campos criados nesta fase (dump SIGOPDOC)
            loc_cO = loc_cO + "CK02 lbl_4c_Label1  T/L/W/H = " + ;
                TRANSFORM(loc_oForm.lbl_4c_Label1.Top) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label1.Left) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label1.Width) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label1.Height) + ;
                "  (dump 599/414/119/15)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK03 lbl_4c_Label2  T/L/W/H = " + ;
                TRANSFORM(loc_oForm.lbl_4c_Label2.Top) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label2.Left) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label2.Width) + "/" + ;
                TRANSFORM(loc_oForm.lbl_4c_Label2.Height) + ;
                "  (dump 599/667/103/15)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK04 txt_4c_Usuars  T/L = " + ;
                TRANSFORM(loc_oForm.txt_4c_Usuars.Top) + "/" + ;
                TRANSFORM(loc_oForm.txt_4c_Usuars.Left) + ;
                "  Enabled=" + TRANSFORM(loc_oForm.txt_4c_Usuars.Enabled) + ;
                "  (dump 595/535 Enabled=.F.)" + CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK05 txt_4c_Datas   T/L/W = " + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Top) + "/" + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Left) + "/" + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Width) + ;
                "  Enabled=" + TRANSFORM(loc_oForm.txt_4c_Datas.Enabled) + ;
                "  (dump 595/772/143 Enabled=.F.)" + CHR(13) + CHR(10)

            *-- 2. ControlSource ligado DEPOIS de o cursor existir (regra #41)
            loc_cO = loc_cO + "CK06 cursor USED=" + ;
                TRANSFORM(USED("cursor_4c_Dados")) + ;
                "  ObsArqs.CS=[" + loc_oForm.obj_4c_GetObsArqs.ControlSource + "]" + ;
                "  Usuars.CS=[" + loc_oForm.txt_4c_Usuars.ControlSource + "]" + ;
                "  Datas.CS=[" + loc_oForm.txt_4c_Datas.ControlSource + "]" + ;
                CHR(13) + CHR(10)

            loc_cO = loc_cO + "CK07 grade RecordSource=[" + ;
                loc_oForm.grd_4c_Dados.RecordSource + "]  Col1.CS=[" + ;
                loc_oForm.grd_4c_Dados.Column1.ControlSource + "]  Col1.W=" + ;
                TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + ;
                "  (esperado cursor_4c_Dados / .Arquivos / 778)" + CHR(13) + CHR(10)

            *-- 3. Preview oculto com a grade vazia
            loc_cO = loc_cO + "CK08 grade vazia -> img.Visible=" + ;
                TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
                "  (esperado .F.)" + CHR(13) + CHR(10)

            *-- 4. Linha com JPG REAL -> preview aparece
            INSERT INTO cursor_4c_Dados ;
                (pkChaves, fkChaves, Arquivos, ObsArqs, Usuars, Datas) ;
                VALUES ("PK1", "CHAVE-DE-TESTE-723", loc_cImg, "obs um", ;
                        "TESTE", DATETIME())
            SELECT cursor_4c_Dados
            GO TOP
            loc_oForm.GradeAfterRowColChange(1)
            loc_cO = loc_cO + "CK09 linha JPG real -> img.Visible=" + ;
                TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
                "  Picture=[" + loc_oForm.img_4c_ImgArqJpg.Picture + "]" + ;
                "  (esperado .T. + caminho)" + CHR(13) + CHR(10)

            *-- 5. Campos de detalhe espelharam a linha
            loc_cO = loc_cO + "CK10 detalhe Usuars=[" + ;
                ALLTRIM(TRANSFORM(loc_oForm.txt_4c_Usuars.Value)) + ;
                "]  ObsArqs=[" + ;
                ALLTRIM(TRANSFORM(loc_oForm.obj_4c_GetObsArqs.Value)) + "]" + ;
                "  (esperado TESTE / obs um)" + CHR(13) + CHR(10)

            *-- 6. Linha NAO-imagem -> preview esconde
            INSERT INTO cursor_4c_Dados ;
                (pkChaves, fkChaves, Arquivos, ObsArqs, Usuars, Datas) ;
                VALUES ("PK2", "CHAVE-DE-TESTE-723", "C:\TEMP\doc_qualquer.pdf", ;
                        "obs dois", "OUTRO", DATETIME())
            SELECT cursor_4c_Dados
            GO BOTTOM
            loc_oForm.GradeAfterRowColChange(1)
            loc_cO = loc_cO + "CK11 linha PDF -> img.Visible=" + ;
                TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
                "  detalhe Usuars=[" + ;
                ALLTRIM(TRANSFORM(loc_oForm.txt_4c_Usuars.Value)) + "]" + ;
                "  (esperado .F. / OUTRO)" + CHR(13) + CHR(10)

            *-- 7. Arquivo SEM ponto no nome (SUBSTR pos 0 no legado devolve "")
            SELECT cursor_4c_Dados
            GO BOTTOM
            REPLACE Arquivos WITH "C:\TEMP\arquivosemponto" IN cursor_4c_Dados
            loc_oForm.GradeAfterRowColChange(1)
            loc_cO = loc_cO + "CK12 nome sem ponto -> img.Visible=" + ;
                TRANSFORM(loc_oForm.img_4c_ImgArqJpg.Visible) + ;
                "  (esperado .F., sem excecao)" + CHR(13) + CHR(10)

            *-- 8. Zoom: arquivo nao-imagem nao abre nada
            loc_oForm.ImgArqJpgDblClick()
            loc_cO = loc_cO + "CK13 DblClick em nao-imagem: sem excecao" + ;
                CHR(13) + CHR(10)

            *-- 9. Zoom com imagem real: SigOpZom ausente -> MsgAviso, nao crash
            SELECT cursor_4c_Dados
            GO TOP
            loc_oForm.ImgArqJpgDblClick()
            loc_cO = loc_cO + "CK14 DblClick em JPG real: tratou ausencia de " + ;
                "SigOpZom sem excecao" + CHR(13) + CHR(10)

            *-- 10. Arquivo inexistente -> aviso do legado, sem excecao
            SELECT cursor_4c_Dados
            GO BOTTOM
            REPLACE Arquivos WITH "C:\TEMP\nao_existe_723.pdf" IN cursor_4c_Dados
            loc_oForm.BtnOpnArqsClick()
            loc_oForm.BtnOpnDirsClick()
            loc_cO = loc_cO + "CK15 arquivo inexistente: avisou sem excecao" + ;
                CHR(13) + CHR(10)

            *-- 11. AjustarBotoesPorModo (When do legado)
            loc_cO = loc_cO + "CK16 modo ALTERAR: Inserir.En=" + ;
                TRANSFORM(loc_oForm.cmd_4c_BtnInsArqs.Enabled) + ;
                " Excluir.En=" + TRANSFORM(loc_oForm.cmd_4c_BtnExcArqs.Enabled) + ;
                " Obs.RO=" + TRANSFORM(loc_oForm.obj_4c_GetObsArqs.ReadOnly) + ;
                " Abrir.En=" + TRANSFORM(loc_oForm.cmd_4c_BtnOpnArqs.Enabled) + ;
                "  (esperado .T./.T./.F./.T.)" + CHR(13) + CHR(10)

            loc_oForm.this_cEscolha = "PROCURAR"
            loc_oForm.AjustarBotoesPorModo()
            loc_cO = loc_cO + "CK17 modo PROCURAR: Inserir.En=" + ;
                TRANSFORM(loc_oForm.cmd_4c_BtnInsArqs.Enabled) + ;
                " Excluir.En=" + TRANSFORM(loc_oForm.cmd_4c_BtnExcArqs.Enabled) + ;
                " Obs.RO=" + TRANSFORM(loc_oForm.obj_4c_GetObsArqs.ReadOnly) + ;
                " Abrir.En=" + TRANSFORM(loc_oForm.cmd_4c_BtnOpnArqs.Enabled) + ;
                "  (esperado .F./.F./.T./.T.)" + CHR(13) + CHR(10)

            *-- 12. Visibilidade dos metodos chamados de FORA (regras #3/#51)
            loc_cNomes = "GradeAfterRowColChange,ImgArqJpgDblClick," + ;
                "BtnInsArqsClick,BtnOpnArqsClick,BtnExcArqsClick," + ;
                "BtnOpnDirsClick,CarregarLista,AjustarBotoesPorModo"
            loc_cO = loc_cO + "CK18 visibilidade:" + CHR(13) + CHR(10) + ;
                ChecarPublicos(loc_oForm, loc_cNomes)

            *-- 13. Helpers internos devem ser PROTECTED (PILAR 3)
            loc_cO = loc_cO + "CK19 internos PROTECTED: " + ;
                "ValidarArquivoSelecionado=" + ;
                TRANSFORM(PEMSTATUS(loc_oForm, "ValidarArquivoSelecionado", 2)) + ;
                " ValidarExtensaoImagem=" + ;
                TRANSFORM(PEMSTATUS(loc_oForm, "ValidarExtensaoImagem", 2)) + ;
                " VincularCamposDetalhe=" + ;
                TRANSFORM(PEMSTATUS(loc_oForm, "VincularCamposDetalhe", 2)) + ;
                "  (esperado .T./.T./.T.)" + CHR(13) + CHR(10)

            *-- 14. Nada fora da area do form (regra #30)
            loc_cO = loc_cO + "CK20 Datas dir=" + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Left + ;
                          loc_oForm.txt_4c_Datas.Width) + ;
                " base=" + ;
                TRANSFORM(loc_oForm.txt_4c_Datas.Top + ;
                          loc_oForm.txt_4c_Datas.Height) + ;
                " Form W/H=" + TRANSFORM(loc_oForm.Width) + "/" + ;
                TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

            loc_oForm.Release()
            loc_cO = loc_cO + "CK21 Release OK" + CHR(13) + CHR(10)
        ENDIF

    CATCH TO loc_oE2
        loc_cO = loc_cO + "EXCEPTION NO EXERCICIO: " + loc_oE2.Message + ;
            " | Linha: " + TRANSFORM(loc_oE2.LineNo) + ;
            " | Proc: " + loc_oE2.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_cO
ENDFUNC


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
