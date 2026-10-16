*==============================================================================
* ProbeSigPrIteF8.prg - MEDE, no VFP9, os hooks da Fase 8 de Formsigprite
* contra os CONTROLES REAIS (instancia o form, nao so compila).
*
* DOIS detalhes que a 1a versao deste probe errou e que ficam registrados:
*   1. FormParaBO/BOParaForm/LimparCampos sao PROTECTED por HERANCA
*      (FormBase.prg os declara assim) - chamar de fora estoura. Por isso a
*      subclasse ProbeFormIteF8 expoe wrappers so para medir. CarregarLista
*      NAO existe em FormBase e e PUBLIC de proposito (o harness
*      TesteAutomatico.prg a chama de fora - CLAUDE.md regra #3).
*   2. O form tem DataSession = 2: os cursores dele NAO sao enxergados da
*      sessao 1. Todo acesso a cursor_4c_Grade aqui acontece depois de
*      SET DATASESSION TO <DataSessionId do form>.
*
* Sem SQL Server alcancavel nesta maquina: InicializarForm em gb_4c_ModoTeste
* cria TODOS os controles mas pula CarregarFlagImagem/CarregarLista, entao o
* probe popula cursor_4c_Grade na mao (o BO ja criou a estrutura vazia em
* InicializarCursores).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogProbe
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\logs\vfp_error_probesigpriteF8.txt"
gc_4c_LogProbe         = "C:\4c\automation\logs\probe_sigprite_f8.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogProbe)
    DELETE FILE (gc_4c_LogProbe)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oBO, loc_nSessaoProbe, loc_nSessaoForm
loc_nSessaoProbe = SET("DATASESSION")
LogProbe("PROBE FASE8 Formsigprite - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    *-- ConfigurarAmbiente() trava nesta maquina: carregar so o necessario
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
    SET PROCEDURE TO (gcCaminhoClasses + "sigpriteBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprite.prg") ADDITIVE
    LogProbe("0 SETUP: OK")
CATCH TO loc_oErro
    LogProbe("0 SETUP FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

*-- 1. Instancia a subclasse de teste com os parametros de um documento
TRY
    loc_oForm = CREATEOBJECT("ProbeFormIteF8", "001", "MALOTE", 3, .T.)
    LogProbe("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm))
CATCH TO loc_oErro
    LogProbe("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    loc_oBO         = loc_oForm.this_oBusinessObject
    loc_nSessaoForm = loc_oForm.DataSessionId

    *-- 2. Escopo REAL de cada hook (atributo 2 de PEMSTATUS = Protected)
    TRY
        LogProbe("2a CarregarLista  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + "  (esperado .T./.F.)")
        LogProbe("2b CarregarItens  existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarItens", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarItens", 2)) + "  (esperado .T./.F.)")
        LogProbe("2c FormParaBO     existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + "  (PROTECTED pela FormBase)")
        LogProbe("2d BOParaForm     existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + "  (PROTECTED pela FormBase)")
        LogProbe("2e LimparCampos   existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 5)) + ;
            " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)) + "  (PROTECTED pela FormBase)")
    CATCH TO loc_oErro
        LogProbe("2 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 3. Controles que os hooks tocam, e os cursores DENTRO da sessao do form
    TRY
        LogProbe("3a grd_4c_Itens="   + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Itens", 5)) + ;
            " img_4c_FigJpg="         + TRANSFORM(PEMSTATUS(loc_oForm, "img_4c_FigJpg", 5)) + ;
            " obj_4c_Get_obs="        + TRANSFORM(PEMSTATUS(loc_oForm, "obj_4c_Get_obs", 5)))
        LogProbe("3b grd_4c_Itens.RecordSource=[" + loc_oForm.grd_4c_Itens.RecordSource + ;
            "] ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Itens.ColumnCount) + ;
            " Col2.ControlSource=[" + loc_oForm.grd_4c_Itens.Column2.ControlSource + "]")

        SET DATASESSION TO loc_nSessaoForm
        LogProbe("3c (sessao " + TRANSFORM(loc_nSessaoForm) + ") cursor_4c_Grade USED=" + ;
            TRANSFORM(USED("cursor_4c_Grade")) + " cursor_4c_Rodape USED=" + ;
            TRANSFORM(USED("cursor_4c_Rodape")))
        SET DATASESSION TO loc_nSessaoProbe
    CATCH TO loc_oErro
        SET DATASESSION TO loc_nSessaoProbe
        LogProbe("3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 4. Popula a grade na mao (o SQL Server nao esta alcancavel aqui) e
    *-- mede FormParaBO: a LINHA CORRENTE tem de virar o item do BO
    TRY
        SET DATASESSION TO loc_nSessaoForm
        INSERT INTO cursor_4c_Grade (CItens, CPros, DPros, Obs, CUnis, Volumes, Opers, ;
            QtdOs, QtdBs, QtdSs, Units, CMoes, Totas, Disps) VALUES ;
            (1, "PRD0001", "PRODUTO UM", "OBS UM", "UN", 2, "S", 10, 4, 6, 1.5, "BRL", 15, 0)
        INSERT INTO cursor_4c_Grade (CItens, CPros, DPros, Obs, CUnis, Volumes, Opers, ;
            QtdOs, QtdBs, QtdSs, Units, CMoes, Totas, Disps) VALUES ;
            (2, "PRD0002", "PRODUTO DOIS", "OBS DOIS", "CX", 3, "E", 20, 20, 0, 2.5, "USD", 50, 0)
        GO TOP IN cursor_4c_Grade
        LogProbe("4a RECCOUNT(cursor_4c_Grade)=" + TRANSFORM(RECCOUNT("cursor_4c_Grade")) + ;
            " RECNO=" + TRANSFORM(RECNO("cursor_4c_Grade")))
        SET DATASESSION TO loc_nSessaoProbe

        LogProbe("4b FormParaBO()=" + TRANSFORM(loc_oForm.ProbeFormParaBO()))
        LogProbe("4c BO CPros=[" + ALLTRIM(loc_oBO.this_cCodigoProduto) + "]" + ;
            " DPros=[" + ALLTRIM(loc_oBO.this_cDescricaoProduto) + "]" + ;
            " CUnis=[" + ALLTRIM(loc_oBO.this_cUnidade) + "]" + ;
            " QtdSs=" + TRANSFORM(loc_oBO.this_nQtdSaldo) + ;
            " CMoes=[" + ALLTRIM(loc_oBO.this_cMoeda) + "]" + ;
            "  (esperado PRD0001 / PRODUTO UM / UN / 6 / BRL)")

        *-- 2a linha: prova que o hook segue a SELECAO, nao um valor fixo
        SET DATASESSION TO loc_nSessaoForm
        SKIP IN cursor_4c_Grade
        SET DATASESSION TO loc_nSessaoProbe
        LogProbe("4d FormParaBO() na 2a linha=" + TRANSFORM(loc_oForm.ProbeFormParaBO()))
        LogProbe("4e BO CPros=[" + ALLTRIM(loc_oBO.this_cCodigoProduto) + "]" + ;
            " QtdSs=" + TRANSFORM(loc_oBO.this_nQtdSaldo) + "  (esperado PRD0002 / 0)")
    CATCH TO loc_oErro
        SET DATASESSION TO loc_nSessaoProbe
        LogProbe("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 5. FormParaBO NAO pode deixar a area de trabalho trocada para quem
    *-- chamou (BO.CarregarDoCursor faz SELECT no cursor da grade). Medido
    *-- DENTRO da sessao do form, que e onde o AfterRowColChange roda.
    TRY
        LogProbe("5a ALIAS() antes=[" + loc_oForm.ProbeAliasCorrente() + "]")
        LogProbe("5b FormParaBO() -> " + TRANSFORM(loc_oForm.ProbeFormParaBOComAlias("cursor_4c_Rodape")))
        LogProbe("5c ALIAS() depois=[" + loc_oForm.ProbeAliasCorrente() + ;
            "]  (tem de ser CURSOR_4C_RODAPE)")
    CATCH TO loc_oErro
        LogProbe("5 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 6. LimparCampos: esconde e descarrega a foto
    TRY
        loc_oForm.img_4c_FigJpg.Visible = .T.
        loc_oForm.img_4c_FigJpg.Picture = ""
        loc_oForm.ProbeLimparCampos()
        LogProbe("6a img Visible=" + TRANSFORM(loc_oForm.img_4c_FigJpg.Visible) + ;
            " Picture=[" + loc_oForm.img_4c_FigJpg.Picture + "]  (esperado .F. / vazio)")
    CATCH TO loc_oErro
        LogProbe("6 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 7. BOParaForm com Imagems = 0 (operacao sem foto): nao pode tentar
    *-- ler SigCdPro nem estourar - so repinta
    TRY
        loc_oBO.this_nImagems = 0
        LogProbe("7a BOParaForm() Imagems=0 -> " + TRANSFORM(loc_oForm.ProbeBOParaForm()))
        LogProbe("7b img Visible=" + TRANSFORM(loc_oForm.img_4c_FigJpg.Visible) + "  (esperado .F.)")
    CATCH TO loc_oErro
        LogProbe("7 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 8. BOParaForm com Imagems = 1 e SEM conexao: BO.CarregarImagemProduto
    *-- devolve .F. e o AND em curto tem de parar ali, sem exibir foto velha
    TRY
        loc_oBO.this_nImagems = 1
        LogProbe("8a BOParaForm() Imagems=1 sem conexao -> " + TRANSFORM(loc_oForm.ProbeBOParaForm()))
        LogProbe("8b img Visible=" + TRANSFORM(loc_oForm.img_4c_FigJpg.Visible) + "  (esperado .F.)")
        loc_oBO.this_nImagems = 0
    CATCH TO loc_oErro
        LogProbe("8 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 9. AfterRowColChange (o handler que o BINDEVENT dispara, PUBLIC)
    *-- encadeia os tres hooks sem estourar e devolve LockScreen a .F.
    TRY
        SET DATASESSION TO loc_nSessaoForm
        GO TOP IN cursor_4c_Grade
        SET DATASESSION TO loc_nSessaoProbe
        loc_oForm.GrdItensAfterRowColChange(1)
        LogProbe("9a AfterRowColChange OK - LockScreen=" + TRANSFORM(loc_oForm.LockScreen) + ;
            " BO CPros=[" + ALLTRIM(loc_oBO.this_cCodigoProduto) + "]  (esperado .F. / PRD0001)")
    CATCH TO loc_oErro
        SET DATASESSION TO loc_nSessaoProbe
        LogProbe("9 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 10. Activate com o form AINDA NAO desenhado: o guard tem de segurar o
    *-- SetFocus (senao estouraria) e NAO marcar a trava de foco inicial
    TRY
        LogProbe("10a THIS.Visible=" + TRANSFORM(loc_oForm.Visible))
        loc_oForm.Activate()
        LogProbe("10b Activate() form invisivel OK - this_lFocoInicialDado=" + ;
            TRANSFORM(loc_oForm.this_lFocoInicialDado) + "  (esperado .F.)")
    CATCH TO loc_oErro
        LogProbe("10 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 11. CarregarLista SEM conexao: tem de devolver .F. (a consulta falhou)
    *-- e NAO pode estourar nem deixar a tela num estado quebrado
    TRY
        LogProbe("11a CarregarLista() sem conexao -> " + TRANSFORM(loc_oForm.CarregarLista()) + ;
            "  (esperado .F. - gnConnHandle=" + TRANSFORM(IIF(TYPE("gnConnHandle") = "N", gnConnHandle, -99)) + ")")
        LogProbe("11b BO mensagem=[" + ALLTRIM(loc_oBO.this_cMensagemErro) + "]")
    CATCH TO loc_oErro
        LogProbe("11 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 12. Destroy
    TRY
        loc_oForm.Release()
        LogProbe("12a Release OK")
    CATCH TO loc_oErro
        LogProbe("12 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogProbe("--- gc_4c_ArquivoErroTeste ---")
    LogProbe(FILETOSTR(gc_4c_ArquivoErroTeste))
ENDIF

LogProbe("PROBE FASE8 Formsigprite - fim")
QUIT

PROCEDURE LogProbe(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogProbe, 1)
ENDPROC

*==============================================================================
* Subclasse de teste: so expoe wrappers dos hooks PROTECTED (FormBase nao
* permite alargar escopo - CLAUDE.md regra #51) e um par de utilitarios que
* rodam DENTRO da data session privada do form.
*==============================================================================
DEFINE CLASS ProbeFormIteF8 AS Formsigprite

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbeLimparCampos()
        THIS.LimparCampos()
    ENDPROC

    *-- ALIAS() avaliado na sessao privada do form
    PROCEDURE ProbeAliasCorrente()
        RETURN ALIAS()
    ENDPROC

    *-- Seleciona par_cAlias na sessao do form, chama FormParaBO e deixa o
    *-- alias corrente como ficou - e assim que se prova que o hook restaura
    PROCEDURE ProbeFormParaBOComAlias(par_cAlias)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAlias)
            SELECT (par_cAlias)
            loc_lResultado = THIS.FormParaBO()
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
