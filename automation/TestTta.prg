*==============================================================================
* TestTta.prg - Verificacao headless do FormSigMvTta (task580, Fase 6)
*
* Prova tres coisas que "compila limpo" nao prova:
*   1. o Init inteiro roda (CREATEOBJECT devolve OBJETO, nao .F.) - Init de
*      form grande falha em CADEIA, e cada defeito esconde o proximo;
*   2. os membros entregues pela Fase 6 existem de fato no objeto vivo
*      (campos de descricao + os dois metodos novos);
*   3. o laco de validacao ValidarTitulosVencimentos percorre o cursor e
*      reconhece linha incompleta - inclusive Vencs NULO, que a EMPTY()
*      nativa do VFP9 daria por "preenchido" (CLAUDE.md regra #27).
*
* SET SAFETY/RESOURCE OFF: script auxiliar de pipeline nao supervisionado -
* dialogo modal travaria a execucao indefinidamente (CLAUDE.md regra #6).
* gb_4c_ModoTeste SOZINHO nao suprime dialogo: precisa de
* gc_4c_ArquivoErroTeste apontando para um arquivo (senao o teste TRAVA).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_tta_dialogos.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRel, loc_oForm, loc_oErro, loc_lValidou, loc_cMembros, loc_i
LOCAL ARRAY loc_aEsperado[6]

loc_cRel = ""

*-- Ambiente do sistema, na MESMA ordem do main.prg: "DO config.prg" apenas
*-- DEFINE as procedures e as variaveis de caminho - quem varre classes\ e
*-- forms\ com ADIR e emite os SET PROCEDURE e' ConfigurarAmbiente(). Sem essa
*-- segunda chamada, SET("PROCEDURE") fica VAZIO e nenhuma classe do projeto
*-- resolve ("Class definition ... is not found").
*-- NAO chamamos ConfigurarSETs() nem ConectarBancoDados(): a primeira mora em
*-- main.prg (nao em config.prg, logo nao resolve daqui) e a segunda abriria
*-- conexao que este teste nao usa - em modo teste o form pula CarregarDados,
*-- que e' seu unico caminho com SQLEXEC.
CD C:\4c\projeto\app\start
TRY
    DO config.prg
    ConfigurarAmbiente()
    loc_cRel = loc_cRel + "CONFIG=OK PROCS=" + ;
               TRANSFORM(OCCURS(",", SET("PROCEDURE")) + 1) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "CONFIG=ERRO: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
ENDTRY

*-- Cursor de impostos no formato que o form CHAMADOR entrega (as colunas que
*-- as 8 do grid consomem + EmpDopNums char(29) = Emps(3)+Dopes(20)+Numes(6),
*-- CLAUDE.md regra #42). SET NULL ON para poder gravar Vencs NULO na linha 3.
SET NULL ON
CREATE CURSOR cursor_4c_TesteTta ( ;
    EmpDopNums C(29) NULL, ;
    Impostos   C(10) NULL, ;
    ValBases   N(14,2) NULL, ;
    Aliqs      N(6,2) NULL, ;
    ValImps    N(14,2) NULL, ;
    Grupos     C(10) NULL, ;
    Contas     C(10) NULL, ;
    ValTits    N(14,2) NULL, ;
    Vencs      T NULL)
SET NULL OFF

*-- Linha 1: COMPLETA (ValTits e Vencs preenchidos) -> nao deve perguntar nada.
INSERT INTO cursor_4c_TesteTta ;
    (EmpDopNums, Impostos, ValBases, Aliqs, ValImps, Grupos, Contas, ValTits, Vencs) ;
    VALUES (PADR("001", 3) + PADR("MALOTE", 20) + STR(3, 6), ;
            "ICMS", 1000.00, 18.00, 180.00, "0001", "0002", 180.00, DATETIME())
*-- Linha 2: ValTits ZERADO -> deve perguntar.
INSERT INTO cursor_4c_TesteTta ;
    (EmpDopNums, Impostos, ValBases, Aliqs, ValImps, Grupos, Contas, ValTits, Vencs) ;
    VALUES (PADR("001", 3) + PADR("MALOTE", 20) + STR(3, 6), ;
            "IPI", 1000.00, 5.00, 50.00, "0001", "0002", 0.00, DATETIME())
*-- Linha 3: Vencs NULO com ValTits preenchido -> deve perguntar. E' o caso que
*-- so o ISNULL pega: EMPTY(.NULL.) devolve .F. ("nao esta vazio") no VFP9.
INSERT INTO cursor_4c_TesteTta ;
    (EmpDopNums, Impostos, ValBases, Aliqs, ValImps, Grupos, Contas, ValTits, Vencs) ;
    VALUES (PADR("001", 3) + PADR("MALOTE", 20) + STR(3, 6), ;
            "PIS", 1000.00, 1.65, 16.50, "0001", "0002", 16.50, .NULL.)

loc_cRel = loc_cRel + "CURSOR_LINHAS=" + TRANSFORM(RECCOUNT("cursor_4c_TesteTta")) + CHR(13) + CHR(10)

*-- 1) O Init roda inteiro?
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigMvTta", "cursor_4c_TesteTta", "ALTERAR")
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "CREATEOBJECT=EXCECAO: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + ;
               " Proc:" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cRel = loc_cRel + "VARTYPE_FORM=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cRel = loc_cRel + "CAPTION=[" + ALLTRIM(loc_oForm.Caption) + "]" + CHR(13) + CHR(10)

    *-- 2) Membros entregues pela Fase 6 existem no objeto VIVO?
    loc_aEsperado[1] = "txt_4c_DGrupos"
    loc_aEsperado[2] = "txt_4c_DContas"
    loc_aEsperado[3] = "lbl_4c_Label3"
    loc_aEsperado[4] = "lbl_4c_Label1"
    loc_aEsperado[5] = "ValidarTitulosVencimentos"
    loc_aEsperado[6] = "GrdDadosAfterRowColChange"

    loc_cMembros = ""
    FOR loc_i = 1 TO ALEN(loc_aEsperado)
        loc_cMembros = loc_cMembros + loc_aEsperado[loc_i] + "=" + ;
            IIF(PEMSTATUS(loc_oForm, loc_aEsperado[loc_i], 5), "SIM", "NAO") + " "
    ENDFOR
    loc_cRel = loc_cRel + "MEMBROS: " + loc_cMembros + CHR(13) + CHR(10)

    *-- Os dois campos de descricao tem de nascer somente-leitura (o legado tem
    *-- PROCEDURE When devolvendo .f. incondicional nos dois).
    loc_cRel = loc_cRel + "READONLY_DGRUPOS=" + TRANSFORM(loc_oForm.txt_4c_DGrupos.ReadOnly) + ;
               " READONLY_DCONTAS=" + TRANSFORM(loc_oForm.txt_4c_DContas.ReadOnly) + CHR(13) + CHR(10)

    *-- 3) O laco de validacao: em modo teste MsgConfirma grava no arquivo e
    *-- devolve .F. (usuario NAO quis corrigir), entao o laco aceita a linha
    *-- incompleta e segue - o retorno esperado e' .T. e o arquivo tem de ter
    *-- registrado as DUAS linhas problematicas (IPI e PIS), nao a completa.
    loc_lValidou = loc_oForm.ValidarTitulosVencimentos()
    loc_cRel = loc_cRel + "VALIDAR_RETORNO=" + TRANSFORM(loc_lValidou) + CHR(13) + CHR(10)

    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRel = loc_cRel + "--- DIALOGOS CAPTURADOS ---" + CHR(13) + CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cRel = loc_cRel + "--- NENHUM DIALOGO CAPTURADO ---" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRel, "C:\4c\automation\test_tta_resultado.txt")
QUIT
