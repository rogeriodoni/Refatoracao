*==============================================================================
* ProbeSigprintF7b.prg - Fase 7 / task631: exercita os caminhos COM DADOS
* (leitura da chave da linha selecionada + busca por exemplo do msv_procurar).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprint_f7b.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_cSaida, loc_oPg2
loc_cSaida = "C:\4c\automation\probe_sigprint_f7b_result.txt"
STRTOFILE("INICIO", loc_cSaida)
loc_cRes = ""

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
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRINTBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormSIGPRINT.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSIGPRINT")
    IF VARTYPE(loc_oForm) != "O"
        loc_cRes = CHR(13) + CHR(10) + "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ELSE
        loc_oPg2 = loc_oForm.pgf_4c_Paginas.Page2

        *-- Popula a grade com 3 linhas (a mesma estrutura do Buscar do BO)
        SELECT cursor_4c_Dados
        ZAP
        INSERT INTO cursor_4c_Dados VALUES ("CH00000000000000001", "0000000010", "INSTRUCAO DEZ",   1)
        INSERT INTO cursor_4c_Dados VALUES ("CH00000000000000002", "0000000020", "INSTRUCAO VINTE", 2)
        INSERT INTO cursor_4c_Dados VALUES ("CH00000000000000003", "0000000030", "INSTRUCAO TRINTA",3)
        GO TOP IN cursor_4c_Dados

        *-- 1) Linha corrente = 2a: Visualizar tem de ler o CIDCHAVES dela
        GO 2 IN cursor_4c_Dados
        loc_oForm.BtnVisualizarClick()
        loc_cRes = CHR(13) + CHR(10) + "=== BtnVisualizarClick na linha 2 (cidchaves=...002)"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "modo=" + loc_oForm.this_cModoAtual + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " (o SQLEXEC falha nesta maquina: o que importa eh NAO ter caido no" + ;
            " aviso 'Selecione um registro')"

        *-- 2) Busca por exemplo: BtnBuscarClick deixa SO o Codigo digitavel
        loc_oForm.BtnBuscarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== POS BtnBuscarClick"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "modo=" + loc_oForm.this_cModoAtual + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " cod.Enabled=" + TRANSFORM(loc_oPg2.txt_4c_Codigo.Enabled) + ;
            " descrs.Enabled=" + TRANSFORM(loc_oPg2.txt_4c_Descrs.Enabled) + ;
            " mensas.Enabled=" + TRANSFORM(loc_oPg2.obj_4c_GetMensas.Enabled) + ;
            " confirmar=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled)

        *-- 3) Confirmar em modo BUSCAR = msv_procurar: codigo EXATO
        loc_oPg2.txt_4c_Codigo.Value = "0000000030"
        loc_oForm.BtnSalvarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== Buscar 0000000030 (exato)"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "modo=" + loc_oForm.this_cModoAtual + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " recno=" + TRANSFORM(RECNO("cursor_4c_Dados")) + " (esperado 3)" + ;
            " cods=" + ALLTRIM(cursor_4c_Dados.cods) + ;
            " reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + " (esperado 3 - nada apagado)"

        *-- 4) NEAR ON: codigo que nao existe para na primeira linha MAIOR
        loc_oForm.BtnBuscarClick()
        loc_oPg2.txt_4c_Codigo.Value = "0000000015"
        loc_oForm.BtnSalvarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== Buscar 0000000015 (NEAR)"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "recno=" + TRANSFORM(RECNO("cursor_4c_Dados")) + ;
            " (esperado 2) cods=" + ALLTRIM(cursor_4c_Dados.cods)

        *-- 5) Codigo acima de todos: fica na ultima linha (NEAR ON do legado)
        loc_oForm.BtnBuscarClick()
        loc_oPg2.txt_4c_Codigo.Value = "9999999999"
        loc_oForm.BtnSalvarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== Buscar 9999999999 (acima de todos)"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "recno=" + TRANSFORM(RECNO("cursor_4c_Dados")) + ;
            " (esperado 3) cods=" + ALLTRIM(cursor_4c_Dados.cods)

        *-- 6) Confirmar em INCLUIR com campos vazios: as 3 validacoes do legado
        loc_oForm.BtnIncluirClick()
        loc_oForm.BtnSalvarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== Confirmar INCLUIR vazio (validacao 1)"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "modo=" + loc_oForm.this_cModoAtual + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + " (deve ficar em 2)"

        loc_oPg2.txt_4c_Codigo.Value = "0000000040"
        loc_oForm.BtnSalvarClick()
        loc_oPg2.txt_4c_Descrs.Value = "INSTRUCAO QUARENTA"
        loc_oForm.BtnSalvarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== validacoes 2 e 3 (ver DIALOGOS)" + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage)

        *-- 7) Cancelar volta para a Lista e limpa a ficha
        loc_oForm.BtnCancelarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "=== POS BtnCancelarClick"
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "modo=" + loc_oForm.this_cModoAtual + ;
            " page=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
            " cod.Value=[" + loc_oPg2.txt_4c_Codigo.Value + "]" + ;
            " descrs.Value=[" + loc_oPg2.txt_4c_Descrs.Value + "]" + ;
            " confirmar=" + TRANSFORM(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled)

        loc_oForm.Release()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + "RELEASE OK"
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
        " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cRes, loc_cSaida, 1)

IF FILE("C:\4c\automation\vfp_error_sigprint_f7b.txt")
    STRTOFILE(CHR(13) + CHR(10) + "DIALOGOS: " + ;
        FILETOSTR("C:\4c\automation\vfp_error_sigprint_f7b.txt"), loc_cSaida, 1)
ENDIF
QUIT
