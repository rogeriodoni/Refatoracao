*==============================================================================
* ProbeF8SigOpSqn806.prg - Probe da FASE 8 do FormSigOpSqn (task806)
*
* Mede, no VFP9 de verdade:
*   CK1  - as classes compilam/carregam e o form instancia em modo teste
*   CK2  - escopo dos hooks novos (FormParaBO/BOParaForm devem ser PROTECTED)
*   CK3  - SigOpSqnBO.LimparDados zera SO as 4 properties da entidade e
*          PRESERVA os aliases de cursor e o contexto do form pai
*   CK4  - NovoRegistro() (que chama LimparDados) nao carrega dado da linha
*          anterior
*   CK5  - FormParaBO leva a linha CORRENTE do cursor para o BO
*   CK6  - FormParaBO/BOParaForm com cursor em fim de arquivo nao estouram
*   CK7  - BOParaForm devolve para a linha a chave regerada pelo BO
*   CK8  - BOParaForm nao mexe nas outras 3 colunas nem na outra linha
*
* NAO toca o SQL Server (gnConnHandle fica indefinido de proposito - os
* metodos Listar* do BO tem guarda e devolvem .F. sem consultar).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .F.

LOCAL loc_cOut, loc_cLog, loc_oErro, loc_oForm, loc_oBO
loc_cOut = ""
loc_cLog = "C:\4c\automation\_probe_f8_sqn.txt"

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "textboxgridlookup.PRG")   ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpSqnBO.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpSqn.prg") ADDITIVE

loc_cOut = loc_cOut + "CK0 dependencias carregadas" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*------------------------------------------------------------------ CK1
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("ProbeFormSqn")
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "CK1 EXCECAO: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cOut = loc_cOut + "CK1 instanciou=" + TRANSFORM(VARTYPE(loc_oForm) = "O") + ;
    "  Caption=[" + IIF(VARTYPE(loc_oForm) = "O", loc_oForm.Caption, "") + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

IF VARTYPE(loc_oForm) != "O"
    QUIT
ENDIF

*------------------------------------------------------------------ CK2
*-- atributo 2 = Protected. O atributo 4 eh user-defined e devolve .T. em
*-- tudo, por isso nao serve para medir escopo.
loc_cOut = loc_cOut + "CK2 FormParaBO existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
    " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "CK2 BOParaForm existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
    " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*------------------------------------------------------------------ CK3
loc_oBO = loc_oForm.this_oBusinessObject

WITH loc_oBO
    .this_cCidChaves      = "K-ANTIGA"
    .this_cCDopes         = "OP-PAI"
    .this_cCNivels        = "OP-FILHA"
    .this_nSeqs           = 7
    .this_cEscolha        = "INSERIR"
    .this_nDataSessionPai = 3
ENDWITH
loc_oBO.LimparDados()

loc_cOut = loc_cOut + "CK3 zerou entidade: cid=[" + loc_oBO.this_cCidChaves + "]" + ;
    " cdopes=[" + loc_oBO.this_cCDopes + "]" + ;
    " cnivels=[" + loc_oBO.this_cCNivels + "]" + ;
    " seqs=" + TRANSFORM(loc_oBO.this_nSeqs) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "CK3 preservou contexto: escolha=[" + loc_oBO.this_cEscolha + "]" + ;
    " dataSessionPai=" + TRANSFORM(loc_oBO.this_nDataSessionPai) + ;
    " cursorSeq=[" + loc_oBO.this_cCursorSequencias + "]" + ;
    " cursorOper=[" + loc_oBO.this_cCursorOperacoes + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*------------------------------------------------------------------ CK4
loc_oBO.this_cCNivels = "LIXO-ANTERIOR"
loc_oBO.this_nSeqs    = 5
loc_oBO.NovoRegistro()
loc_cOut = loc_cOut + "CK4 apos NovoRegistro: cnivels=[" + loc_oBO.this_cCNivels + "]" + ;
    " seqs=" + TRANSFORM(loc_oBO.this_nSeqs) + ;
    " emEdicao=" + TRANSFORM(loc_oBO.this_lEmEdicao) + ;
    " novo=" + TRANSFORM(loc_oBO.this_lNovoRegistro) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*------------------------------------------------------------------ CK5
*-- cursor com a MESMA estrutura que SigOpSqnBO.ListarSequencias produz
IF USED("cursor_4c_Sequencias")
    USE IN cursor_4c_Sequencias
ENDIF
CREATE CURSOR cursor_4c_Sequencias ;
    (cdopes C(20), cidchaves C(20), cnivels C(20), seqs N(2,0))
INSERT INTO cursor_4c_Sequencias (cdopes, cidchaves, cnivels, seqs) ;
    VALUES ("OP-PAI", "K1", "OPER-UM", 1)
INSERT INTO cursor_4c_Sequencias (cdopes, cidchaves, cnivels, seqs) ;
    VALUES ("OP-PAI", "K2", "OPER-DOIS", 2)

SELECT cursor_4c_Sequencias
GO BOTTOM
loc_cOut = loc_cOut + "CK5 FormParaBO retorno=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "CK5 BO recebeu: cid=[" + loc_oBO.this_cCidChaves + "]" + ;
    " cdopes=[" + loc_oBO.this_cCDopes + "]" + ;
    " cnivels=[" + loc_oBO.this_cCNivels + "]" + ;
    " seqs=" + TRANSFORM(loc_oBO.this_nSeqs) + ;
    "   esperado K2/OP-PAI/OPER-DOIS/2" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*------------------------------------------------------------------ CK6
SELECT cursor_4c_Sequencias
GO BOTTOM
SKIP
loc_cOut = loc_cOut + "CK6 em EOF: EOF=" + TRANSFORM(EOF("cursor_4c_Sequencias")) + ;
    " FormParaBO=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + ;
    " BOParaForm=" + TRANSFORM(loc_oForm.ProbeBOParaForm()) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*------------------------------------------------------------------ CK7 / CK8
SELECT cursor_4c_Sequencias
GO TOP
loc_oForm.ProbeFormParaBO()
*-- simula o que SigOpSqnBO.Inserir() faz quando a PK chega vazia
loc_oBO.this_cCidChaves = "K1-REGERADA"
loc_cOut = loc_cOut + "CK7 BOParaForm retorno=" + TRANSFORM(loc_oForm.ProbeBOParaForm()) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "CK7 linha agora: cid=[" + ALLTRIM(cursor_4c_Sequencias.cidchaves) + "]" + ;
    "   esperado K1-REGERADA" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "CK8 colunas intactas: cdopes=[" + ALLTRIM(cursor_4c_Sequencias.cdopes) + "]" + ;
    " cnivels=[" + ALLTRIM(cursor_4c_Sequencias.cnivels) + "]" + ;
    " seqs=" + TRANSFORM(cursor_4c_Sequencias.seqs) + ;
    "   esperado OP-PAI/OPER-UM/1" + CHR(13) + CHR(10)

GO BOTTOM
loc_cOut = loc_cOut + "CK8 2a linha: cid=[" + ALLTRIM(cursor_4c_Sequencias.cidchaves) + "]" + ;
    "   esperado K2" + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, loc_cLog)

IF USED("cursor_4c_Sequencias")
    USE IN cursor_4c_Sequencias
ENDIF
loc_oForm.Release()
QUIT


*------------------------------------------------------------------------------
* ProbeFormSqn - subclasse SO do probe, com passthrough PUBLIC para os dois
* hooks PROTECTED (nao se chama metodo PROTECTED de fora - regra #51).
*------------------------------------------------------------------------------
DEFINE CLASS ProbeFormSqn AS FormSigOpSqn
    PROCEDURE ProbeFormParaBO
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm
        RETURN THIS.BOParaForm()
    ENDPROC
ENDDEFINE
