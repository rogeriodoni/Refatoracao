SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gc_4c_LogProbe
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f7_sigoppro790_erro.txt"
gc_4c_LogProbe         = "C:\4c\automation\probe_f7_sigoppro790_r5.txt"

STRTOFILE("=== PROBE FASE 7 Formsigoppro ===" + CHR(13) + CHR(10), gc_4c_LogProbe)

LOCAL loc_oForm, loc_oErro, loc_nCont

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("Formsigoppro")
DO LogProbe WITH "ambiente carregado"

TRY
    loc_oForm = CREATEOBJECT("Formsigoppro")
CATCH TO loc_oErro
    DO LogProbe WITH "ERRO CREATEOBJECT: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo)
    loc_oForm = .NULL.
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    DO LogProbe WITH "FORM OK BaseClass=" + loc_oForm.BaseClass
    SET DATASESSION TO loc_oForm.DataSessionId
    DO LogProbe WITH "datasession=" + TRANSFORM(SET("DATASESSION")) + " cursor=" + TRANSFORM(USED("cursor_4c_Itens"))

    TRY
        loc_oForm.this_cEmps      = "001"
        loc_oForm.this_cDopes     = "VENDA"
        loc_oForm.this_nNumes     = 7
        loc_oForm.this_cOpEscolha = "INSERIR"

        *-- 1) cursor vazio: entrega a 1a linha
        loc_oForm.InserirLinhaGrade()
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        GO TOP
        DO LogProbe WITH "1) apos 1a insercao linhas=" + TRANSFORM(loc_nCont) + ;
            " citens=" + TRANSFORM(cursor_4c_Itens.citens) + ;
            " emps=[" + cursor_4c_Itens.emps + "] chave=[" + ALLTRIM(cursor_4c_Itens.empdopnums) + "]"

        *-- 2) ja existe linha em branco: nao insere outra
        loc_oForm.InserirLinhaGrade()
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        DO LogProbe WITH "2) com linha em branco linhas=" + TRANSFORM(loc_nCont)

        *-- 3) preenche a linha 1 e pede outra
        SELECT cursor_4c_Itens
        LOCATE FOR EMPTY(cpros)
        REPLACE cpros WITH "PRO001", dpros WITH "PRODUTO UM", qtds WITH 2
        loc_oForm.InserirLinhaGrade()
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        DO LogProbe WITH "3) apos preencher+inserir linhas=" + TRANSFORM(loc_nCont)

        *-- 4) preenche a linha 2, cria composicao dela e pede a 3a
        SELECT cursor_4c_Itens
        LOCATE FOR EMPTY(cpros)
        REPLACE cpros WITH "PRO002", dpros WITH "PRODUTO DOIS", qtds WITH 5
        INSERT INTO cursor_4c_Itens (emps, citens, citem2, cpros, qtds) ;
            VALUES ("001", 90, 2, "PRO002", 5)
        loc_oForm.InserirLinhaGrade()
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        DO LogProbe WITH "4) linhas antes da exclusao=" + TRANSFORM(loc_nCont)

        *-- 5) consistente -> .T.
        DO LogProbe WITH "5) ValidarItensAntesDeSair consistente=" + TRANSFORM(loc_oForm.ValidarItensAntesDeSair())

        *-- 6) divergente -> .F.
        SELECT cursor_4c_Itens
        LOCATE FOR citens = 90
        REPLACE cpros WITH "PRO999"
        DO LogProbe WITH "6) ValidarItensAntesDeSair divergente=" + TRANSFORM(loc_oForm.ValidarItensAntesDeSair())
        SELECT cursor_4c_Itens
        LOCATE FOR citens = 90
        REPLACE cpros WITH "PRO002"

        *-- 7) exclui item 2 (leva a composicao)
        SELECT cursor_4c_Itens
        LOCATE FOR citens = 2
        loc_oForm.ExcluirLinhaGrade()
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        DO LogProbe WITH "7) apos excluir item 2 + composicao linhas=" + TRANSFORM(loc_nCont)

        *-- 8) renumeracao
        loc_nCont = loc_oForm.RenumerarItensGrade()
        DO LogProbe WITH "8) RenumerarItensGrade=" + TRANSFORM(loc_nCont) + " CItem=" + TRANSFORM(loc_oForm.this_nCItem)
        SELECT cursor_4c_Itens
        GO TOP
        SCAN
            DO LogProbe WITH "   linha citens=" + TRANSFORM(cursor_4c_Itens.citens) + ;
                " citem2=" + TRANSFORM(cursor_4c_Itens.citem2) + ;
                " cpros=[" + ALLTRIM(cursor_4c_Itens.cpros) + "]"
        ENDSCAN

        *-- 9) unica linha em branco: esvazia em vez de remover
        SELECT cursor_4c_Itens
        LOCATE FOR EMPTY(cpros)
        DO LogProbe WITH "9) achou linha em branco=" + TRANSFORM(FOUND())
        loc_oForm.ExcluirLinhaGrade()
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        DO LogProbe WITH "9) apos excluir a unica em branco linhas=" + TRANSFORM(loc_nCont)

        *-- 10) LimparLinhaGrade sobre linha com produto
        SELECT cursor_4c_Itens
        LOCATE FOR !EMPTY(cpros)
        loc_oForm.LimparLinhaGrade()
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        DO LogProbe WITH "10) apos LimparLinhaGrade linhas=" + TRANSFORM(loc_nCont) + ;
            " cpros corrente=[" + ALLTRIM(cursor_4c_Itens.cpros) + "]"

        *-- 11) GarantirLinhaDeDigitacao com cursor vazio
        SELECT cursor_4c_Itens
        DELETE ALL
        DO LogProbe WITH "11) GarantirLinhaDeDigitacao=" + TRANSFORM(loc_oForm.GarantirLinhaDeDigitacao())
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        DO LogProbe WITH "11) linhas ao final=" + TRANSFORM(loc_nCont)

        *-- 12) TotalizarLinha sem form pai nao pode estourar
        DO LogProbe WITH "12) TotalizarLinha(sem pai)=" + TRANSFORM(loc_oForm.TotalizarLinha(.F.))
        *-- 12b) Duas linhas em branco: ExcluirLinhaGrade REMOVE uma
        SELECT cursor_4c_Itens
        DELETE ALL
        INSERT INTO cursor_4c_Itens (emps, citens, cpros) VALUES ("001", 1, "PRO001")
        INSERT INTO cursor_4c_Itens (emps, citens) VALUES ("001", 2)
        INSERT INTO cursor_4c_Itens (emps, citens) VALUES ("001", 3)
        SELECT cursor_4c_Itens
        LOCATE FOR citens = 2
        loc_oForm.ExcluirLinhaGrade()
        SELECT cursor_4c_Itens
        COUNT TO loc_nCont
        DO LogProbe WITH "12b) 2 linhas em branco - apos excluir linhas=" + TRANSFORM(loc_nCont)
        SELECT cursor_4c_Itens
        GO TOP
        SCAN
            DO LogProbe WITH "   restou citens=" + TRANSFORM(cursor_4c_Itens.citens) + " cpros=[" + ALLTRIM(cursor_4c_Itens.cpros) + "]"
        ENDSCAN


        *-- 13) BtnPApagaClick com grade vazia (EOF) avisa e nao estoura
        SELECT cursor_4c_Itens
        DELETE ALL
        GO BOTTOM
        DO LogProbe WITH "13) BtnPApagaClick com grade vazia - antes"
        loc_oForm.BtnPApagaClick()
        DO LogProbe WITH "13) BtnPApagaClick com grade vazia - depois OK"

    CATCH TO loc_oErro
        DO LogProbe WITH "ERRO TESTE: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure
    ENDTRY

    SET DATASESSION TO 1
    loc_oForm.Release()
ENDIF

DO LogProbe WITH "=== FIM ==="
QUIT

PROCEDURE LogProbe
    LPARAMETERS par_cTexto
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogProbe, 1)
ENDPROC
