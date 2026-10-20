*==============================================================================
* ProbeTrf684F4.prg - Instancia FormSIGPRTRF headless (Fase 4 / task684) e
* mede o que a fase acrescentou:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto);
*   (2) a grade nasce vinculada: ColumnCount=2, RecordSource, os 2
*       ControlSource e as larguras 108/290 do SCX (prova que sobreviveram
*       ao RecordSource, que devolve Width/Header1.Caption ao default);
*   (3) a coluna da Descricao esta travada (Column2.ReadOnly=.T., o
*       equivalente ao "Return .f." do When legado) e a do Codigo nao;
*   (4) os 2 botoes do legado existem e apontam para icone que EXISTE;
*   (5) escopo: CarregarLista tem de ser PUBLIC (harness chama de fora);
*   (6) RECUPERACAO: derruba o alias da grade e confere que CarregarLista()
*       reconstroi o vinculo, as larguras e os cabecalhos.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: gb_4c_ValidandoUI pula o SQLEXEC do BO.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_trf684_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oGrd
loc_cOut = "C:\4c\automation\probe_trf684_f4_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRTRFBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRTRF.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo
    loc_oForm = CREATEOBJECT("FormSIGPRTRF")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_oGrd = loc_oForm.cnt_4c__Referencia.grd_4c_Dados

        *-- (2) Vinculo e geometria
        STRTOFILE(CHR(13)+CHR(10)+"GRID ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RecordSource=[" + ALLTRIM(loc_oGrd.RecordSource) + "]" + ;
                  " Top=" + TRANSFORM(loc_oGrd.Top) + " Left=" + TRANSFORM(loc_oGrd.Left) + ;
                  " W=" + TRANSFORM(loc_oGrd.Width) + " H=" + TRANSFORM(loc_oGrd.Height) + ;
                  " GridReadOnly=" + TRANSFORM(loc_oGrd.ReadOnly) + ;
                  " Visible=" + TRANSFORM(loc_oGrd.Visible), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"COL1 CS=[" + ALLTRIM(loc_oGrd.Column1.ControlSource) + "]" + ;
                  " W=" + TRANSFORM(loc_oGrd.Column1.Width) + ;
                  " RO=" + TRANSFORM(loc_oGrd.Column1.ReadOnly) + ;
                  " Format=[" + ALLTRIM(loc_oGrd.Column1.Format) + "]" + ;
                  " Mask=[" + ALLTRIM(loc_oGrd.Column1.Text1.InputMask) + "]" + ;
                  " Hdr=[" + ALLTRIM(loc_oGrd.Column1.Header1.Caption) + "]", loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"COL2 CS=[" + ALLTRIM(loc_oGrd.Column2.ControlSource) + "]" + ;
                  " W=" + TRANSFORM(loc_oGrd.Column2.Width) + ;
                  " RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly) + ;
                  " Hdr=[" + ALLTRIM(loc_oGrd.Column2.Header1.Caption) + "]", loc_cOut, 1)

        *-- O cursor vive na DATA SESSION PRIVADA do form (DataSession = 2):
        *-- de fora dela USED/RECCOUNT nao enxergam o alias.
        SET DATASESSION TO loc_oForm.DataSessionID
        STRTOFILE(CHR(13)+CHR(10)+"CURSOR used=" + TRANSFORM(USED("cursor_4c_Produtos")) + ;
                  " Reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Produtos")) + ;
                  " Recno=" + TRANSFORM(RECNO("cursor_4c_Produtos")), loc_cOut, 1)

        *-- (4) Botoes + icone realmente existente
        STRTOFILE(CHR(13)+CHR(10)+"BOTOES Ok[" + JUSTFNAME(loc_oForm.cmd_4c_Altera.Picture) + "]=" + ;
                  IIF(FILE(loc_oForm.cmd_4c_Altera.Picture), "OK", "FALTA") + ;
                  " Cancelar[" + JUSTFNAME(loc_oForm.cmd_4c_Sair.Picture) + "]=" + ;
                  IIF(FILE(loc_oForm.cmd_4c_Sair.Picture), "OK", "FALTA") + ;
                  " OkPos=" + TRANSFORM(loc_oForm.cmd_4c_Altera.Left) + "/" + ;
                  TRANSFORM(loc_oForm.cmd_4c_Altera.Top) + ;
                  " CancelPos=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Left) + "/" + ;
                  TRANSFORM(loc_oForm.cmd_4c_Sair.Top) + ;
                  " CancelProp=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Cancel), loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"MENSAGEM Visible=" + TRANSFORM(loc_oForm.cnt_4c__Mensagem.Visible) + ;
                  " (tem de ser .F. - container flutuante)", loc_cOut, 1)

        *-- (5) Escopo (2 = PROTECTED; CarregarLista tem de dar .F.)
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO CarregarLista prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2)) + ;
                  " FocarPrimeiraCelula prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"FocarPrimeiraCelula",2)) + ;
                  " ConfigurarGradeProdutos prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ConfigurarGradeProdutos",2)), loc_cOut, 1)

        *-- (6) RECUPERACAO: derruba o alias e reconstroi por CarregarLista
        USE IN cursor_4c_Produtos
        STRTOFILE(CHR(13)+CHR(10)+"ALIAS DERRUBADO ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RecordSource=[" + ALLTRIM(loc_oGrd.RecordSource) + "]", loc_cOut, 1)

        STRTOFILE(CHR(13)+CHR(10)+"CarregarLista retorno=" + TRANSFORM(loc_oForm.CarregarLista()), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"REVINCULADO ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RecordSource=[" + ALLTRIM(loc_oGrd.RecordSource) + "]" + ;
                  " Col1CS=[" + ALLTRIM(loc_oGrd.Column1.ControlSource) + "]" + ;
                  " Col2CS=[" + ALLTRIM(loc_oGrd.Column2.ControlSource) + "]" + ;
                  " W=" + TRANSFORM(loc_oGrd.Column1.Width) + "/" + TRANSFORM(loc_oGrd.Column2.Width) + ;
                  " Hdr1=[" + ALLTRIM(loc_oGrd.Column1.Header1.Caption) + "]" + ;
                  " Hdr2=[" + ALLTRIM(loc_oGrd.Column2.Header1.Caption) + "]" + ;
                  " Col2RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly) + ;
                  " Reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Produtos")), loc_cOut, 1)

        SET DATASESSION TO 1
        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"POS-RELEASE cursorAberto=" + TRANSFORM(USED("cursor_4c_Produtos")), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
