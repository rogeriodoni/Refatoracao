* ProbeF8SigOpTrf814.prg
* Fase 8 da task814 (SIGOPTRF -> FormSigOpTrf): mede os hooks de transporte
* e de consolidacao acrescentados nesta fase.
*
* 1. ESCOPO REAL de cada metodo novo, medido com PEMSTATUS(obj, <nome>, 2)
*    (atributo 2 = Protected) numa instancia de FormSigOpTrf - prova que
*    FormParaBO/BOParaForm/LimparCampos ficaram PROTECTED (FormBase os
*    declara assim e a subclasse nao alarga escopo herdado, regra #51) e que
*    HabilitarCampos/AjustarBotoesPorModo sao PUBLIC de verdade.
* 2. COMPORTAMENTO de FormParaBO/BOParaForm/LimparCampos, exercitados a
*    partir de uma SUBCLASSE de teste (sao PROTECTED - a chamada de fora
*    estouraria em runtime), sobre um cursor de itens montado a mao com a
*    MESMA estrutura do CREATE CURSOR de SigOpTrfBO.CarregarRegras.
* 3. HabilitarCampos/AjustarBotoesPorModo chamados de FORA da classe, como o
*    harness faz, inclusive o caso SEM ARGUMENTO (guard por PCOUNT()).
*
* Nao roda config.prg nem toca em SQL (SQL Server inacessivel nesta
* maquina): CarregarLista/lookup nao sao chamados aqui - a prova deles eh o
* ProbeF4SigOpTrf814.prg/ProbeF6*.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f8_sigoptrf814.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oProbe, loc_oErro, loc_oPai, loc_oTxt, loc_oBO
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\textboxgridlookup.PRG" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpTrfBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpTrf.prg" ADDITIVE

    loc_oPai = CREATEOBJECT("Form")
    loc_oPai.Enabled = .F.

    *==================================================================
    * 1. ESCOPO REAL - instancia DIRETA de FormSigOpTrf
    *==================================================================
    loc_oForm = CREATEOBJECT("FormSigOpTrf", loc_oPai, "001234", 1)

    IF VARTYPE(loc_oForm) != "O"
        loc_cSaida = "FALHA: CREATEOBJECT(FormSigOpTrf) devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    ELSE
        loc_cSaida = "OK: FormSigOpTrf instanciado" + CHR(13) + CHR(10)

        LOCAL loc_aMet(5), loc_nI, loc_cMet
        loc_aMet(1) = "FormParaBO"
        loc_aMet(2) = "BOParaForm"
        loc_aMet(3) = "LimparCampos"
        loc_aMet(4) = "HabilitarCampos"
        loc_aMet(5) = "AjustarBotoesPorModo"

        FOR loc_nI = 1 TO 5
            loc_cMet = loc_aMet(loc_nI)
            loc_cSaida = loc_cSaida + "ESCOPO " + PADR(loc_cMet, 22) + ;
                " existe=[" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cMet, 5)) + ;
                "] protected=[" + TRANSFORM(PEMSTATUS(loc_oForm, loc_cMet, 2)) + "]" + CHR(13) + CHR(10)
        ENDFOR

        *==================================================================
        * 3. PUBLICOS chamados de FORA da classe (como o harness faz)
        *==================================================================
        loc_oForm.HabilitarCampos(.F.)
        loc_cSaida = loc_cSaida + "HabilitarCampos(.F.) de fora: OpeCol1.ReadOnly=[" + ;
            TRANSFORM(loc_oForm.grd_4c_Operacoes.Column1.ReadOnly) + ;
            "] ItensCol1.ReadOnly=[" + TRANSFORM(loc_oForm.grd_4c_Itens.Column1.ReadOnly) + ;
            "] Inserir.Enabled=[" + TRANSFORM(loc_oForm.cmd_4c_CmdInserir.Enabled) + ;
            "] Command2.Enabled=[" + TRANSFORM(loc_oForm.cmd_4c_Command2.Enabled) + ;
            "] Sair.Enabled=[" + TRANSFORM(loc_oForm.cmd_4c_CmdSair.Enabled) + "]" + CHR(13) + CHR(10)

        *-- SEM argumento: guard por PCOUNT() tem de derivar .T. (esta tela
        *-- nao tem modo de so-leitura - ver cabecalho de HabilitarCampos)
        loc_oForm.HabilitarCampos()
        loc_cSaida = loc_cSaida + "HabilitarCampos() sem arg:  OpeCol1.ReadOnly=[" + ;
            TRANSFORM(loc_oForm.grd_4c_Operacoes.Column1.ReadOnly) + ;
            "] ItensCol1.ReadOnly=[" + TRANSFORM(loc_oForm.grd_4c_Itens.Column1.ReadOnly) + ;
            "] Inserir.Enabled=[" + TRANSFORM(loc_oForm.cmd_4c_CmdInserir.Enabled) + ;
            "] Command1.Enabled=[" + TRANSFORM(loc_oForm.cmd_4c_Command1.Enabled) + "]" + CHR(13) + CHR(10)

        loc_oForm.HabilitarCampos(.F.)
        loc_oForm.AjustarBotoesPorModo()
        loc_cSaida = loc_cSaida + "AjustarBotoesPorModo() de fora: ItensCol1.ReadOnly=[" + ;
            TRANSFORM(loc_oForm.grd_4c_Itens.Column1.ReadOnly) + ;
            "] Excluir.Enabled=[" + TRANSFORM(loc_oForm.cmd_4c_CmdExcluir.Enabled) + "]" + CHR(13) + CHR(10)

        loc_oForm.Release()
    ENDIF

    *==================================================================
    * 2. COMPORTAMENTO dos hooks PROTECTED, via subclasse de teste
    *==================================================================
    loc_oProbe = CREATEOBJECT("ProbeTrfF8", loc_oPai, "001234", 1)

    IF VARTYPE(loc_oProbe) != "O"
        loc_cSaida = loc_cSaida + "FALHA: CREATEOBJECT(ProbeTrfF8) devolveu " + VARTYPE(loc_oProbe) + CHR(13) + CHR(10)
    ELSE
        loc_oBO = loc_oProbe.ObterBO()

        *-- MESMA estrutura do CREATE CURSOR de SigOpTrfBO.CarregarRegras
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        CREATE CURSOR cursor_4c_Itens (Dopes C(20), Dopeds C(20), Cpros C(14), Dpros C(60))
        INSERT INTO cursor_4c_Itens (Dopes, Dopeds, Cpros, Dpros) ;
            VALUES ("001234", "DESTINO A", "7890", "PRODUTO ANTIGO")
        GO TOP IN cursor_4c_Itens

        *-- FormParaBO SEM celula: le o cursor
        loc_cSaida = loc_cSaida + "FormParaBO() sem celula ret=[" + ;
            TRANSFORM(loc_oProbe.ChamarFormParaBO()) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "  BO: Dopes=[" + loc_oBO.this_cDopes + "] Dopeds=[" + loc_oBO.this_cDopeds + ;
            "] Cpros=[" + loc_oBO.this_cCpros + "] Dpros=[" + loc_oBO.this_cDpros + ;
            "] CidChaves=[" + loc_oBO.this_cCidChaves + "] NovoReg=[" + ;
            TRANSFORM(loc_oBO.this_lNovoRegistro) + "]" + CHR(13) + CHR(10)

        *-- FormParaBO COM celula: a CELULA vence o cursor no Cpros (regra #46)
        loc_oTxt = CREATEOBJECT("TextBox")
        loc_oTxt.Value = "ZZ99"
        loc_cSaida = loc_cSaida + "FormParaBO(celula) ret=[" + ;
            TRANSFORM(loc_oProbe.ChamarFormParaBO(loc_oTxt)) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "  BO.Cpros (celula vence)=[" + loc_oBO.this_cCpros + ;
            "] cursor.Cpros (intacto)=[" + ALLTRIM(cursor_4c_Itens.Cpros) + "]" + CHR(13) + CHR(10)

        *-- BOParaForm: devolve Cpros E Dpros ao cursor + celula + grade
        loc_oBO.this_cCpros = "555"
        loc_oBO.this_cDpros = "PRODUTO NOVO"
        loc_cSaida = loc_cSaida + "BOParaForm(celula) ret=[" + ;
            TRANSFORM(loc_oProbe.ChamarBOParaForm(loc_oTxt)) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "  cursor.Cpros=[" + ALLTRIM(cursor_4c_Itens.Cpros) + ;
            "] cursor.Dpros=[" + ALLTRIM(cursor_4c_Itens.Dpros) + ;
            "] celula.Value=[" + ALLTRIM(loc_oTxt.Value) + ;
            "] aliasCorrente=[" + ALIAS() + "]" + CHR(13) + CHR(10)

        *-- LimparCampos: zera a ficha e REPOE a operacao de origem
        loc_oProbe.ChamarLimparCampos()
        loc_cSaida = loc_cSaida + "LimparCampos: Dopes=[" + loc_oBO.this_cDopes + "] Dopeds=[" + loc_oBO.this_cDopeds + ;
            "] Cpros=[" + loc_oBO.this_cCpros + "] Dpros=[" + loc_oBO.this_cDpros + ;
            "] CidChaves=[" + loc_oBO.this_cCidChaves + "] NovoReg=[" + ;
            TRANSFORM(loc_oBO.this_lNovoRegistro) + "]" + CHR(13) + CHR(10)

        *-- Cursor VAZIO (EOF): FormParaBO/BOParaForm devolvem .F. sem estourar
        DELETE ALL IN cursor_4c_Itens
        GO TOP IN cursor_4c_Itens
        loc_cSaida = loc_cSaida + "cursor vazio: FormParaBO=[" + ;
            TRANSFORM(loc_oProbe.ChamarFormParaBO()) + "] BOParaForm=[" + ;
            TRANSFORM(loc_oProbe.ChamarBOParaForm()) + "]" + CHR(13) + CHR(10)

        loc_oProbe.Release()
    ENDIF

    IF USED("cursor_4c_Itens")
        USE IN cursor_4c_Itens
    ENDIF

    loc_oPai.Release()
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "ERRO: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f8_sigoptrf814.txt")

QUIT

*==========================================================================
* Subclasse de teste: expoe os hooks PROTECTED para medicao. Chamar
* FormParaBO/BOParaForm/LimparCampos de FORA estouraria em runtime
* ("Property FORMPARABO is not found") - exatamente o que a regra #51
* descreve -, entao a medicao tem de ser feita de DENTRO da classe.
*==========================================================================
DEFINE CLASS ProbeTrfF8 AS FormSigOpTrf

    FUNCTION ChamarFormParaBO(par_oTxt)
        IF PCOUNT() >= 1
            RETURN THIS.FormParaBO(par_oTxt)
        ENDIF
        RETURN THIS.FormParaBO()
    ENDFUNC

    FUNCTION ChamarBOParaForm(par_oTxt)
        IF PCOUNT() >= 1
            RETURN THIS.BOParaForm(par_oTxt)
        ENDIF
        RETURN THIS.BOParaForm()
    ENDFUNC

    PROCEDURE ChamarLimparCampos
        THIS.LimparCampos()
    ENDPROC

    FUNCTION ObterBO
        RETURN THIS.this_oBusinessObject
    ENDFUNC

ENDDEFINE
