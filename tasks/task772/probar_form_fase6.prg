*==============================================================================
* probar_form_fase6.prg - Fase 6: prova que FormSIGOPNOP INSTANCIA, que os
* QUATRO BINDEVENT de ConfigurarEventos ficaram de fato ligados (AEVENTS) e que
* os handlers dos dois campos digitaveis se comportam como o legado:
*   - GotFocus zera o campo IRMAO (mutuamente exclusivos) e, no caso da O.P.,
*     apaga a figura do produto (o When legado);
*   - KeyPress consulta SO em ENTER(13)/TAB(9) e SO com o campo preenchido.
* A testemunha de "consultou / nao consultou" eh a property do BO
* (this_nNumeroOP / this_nNumeroEnvelope), que PesquisarPor* grava logo depois
* da propria guarda - sem depender de conexao SQL.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, loForm, loErro, lcArqSaida, loCnt, loBO, lnI, laEv
lcArqSaida = "C:\4c\tasks\task772\probar_form_fase6_resultado.txt"
lcSaida    = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task772\probar_form_fase6_erros.txt"

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPNOP")

lcSaida = lcSaida + "M2 ambiente ok" + CHR(13) + CHR(10)
STRTOFILE(lcSaida, lcArqSaida)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPNOP")
    lcSaida = lcSaida + "CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10)
CATCH TO loErro
    lcSaida = lcSaida + "EXCECAO: " + loErro.Message + ;
              " | Linha: " + TRANSFORM(loErro.LineNo) + ;
              " | Procedure: " + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(lcSaida, lcArqSaida)

IF VARTYPE(loForm) = "O"
    loCnt = loForm.cnt_4c_Container1
    loBO  = loForm.this_oBusinessObject

    *-- ===== 1) BINDEVENT ligados? =====
    lcSaida = lcSaida + "--- AEVENTS txt_4c_OP ---" + CHR(13) + CHR(10)
    DIMENSION laEv[1]
    lnI = AEVENTS(laEv, loCnt.txt_4c_OP)
    lcSaida = lcSaida + "ligacoes=" + TRANSFORM(lnI) + CHR(13) + CHR(10)
    IF lnI > 0
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcSaida = lcSaida + "  [" + TRANSFORM(lnI) + "] ev=" + TRANSFORM(laEv[lnI, 2]) + ;
                      " -> metodo=" + TRANSFORM(laEv[lnI, 4]) + CHR(13) + CHR(10)
        ENDFOR
    ENDIF

    lcSaida = lcSaida + "--- AEVENTS txt_4c_Envelope ---" + CHR(13) + CHR(10)
    DIMENSION laEv[1]
    lnI = AEVENTS(laEv, loCnt.txt_4c_Envelope)
    lcSaida = lcSaida + "ligacoes=" + TRANSFORM(lnI) + CHR(13) + CHR(10)
    IF lnI > 0
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcSaida = lcSaida + "  [" + TRANSFORM(lnI) + "] ev=" + TRANSFORM(laEv[lnI, 2]) + ;
                      " -> metodo=" + TRANSFORM(laEv[lnI, 4]) + CHR(13) + CHR(10)
        ENDFOR
    ENDIF

    *-- ===== 2) GotFocus zera o irmao (GetOP/GetEnvelope.GotFocus legado) ====
    lcSaida = lcSaida + "--- GOTFOCUS (exclusao mutua + When) ---" + CHR(13) + CHR(10)
    loCnt.txt_4c_OP.Value       = 777
    loCnt.txt_4c_Envelope.Value = 888
    loForm.img_4c_Imagem.Visible = .T.

    loForm.TxtOPGotFocus()
    lcSaida = lcSaida + "apos TxtOPGotFocus: OP=" + TRANSFORM(loCnt.txt_4c_OP.Value) + ;
              " Envelope=" + TRANSFORM(loCnt.txt_4c_Envelope.Value) + " (esperado 777/0)" + ;
              " Imagem.Visible=" + TRANSFORM(loForm.img_4c_Imagem.Visible) + " (esperado .F.)" + CHR(13) + CHR(10)

    loCnt.txt_4c_Envelope.Value = 888
    loForm.TxtEnvelopeGotFocus()
    lcSaida = lcSaida + "apos TxtEnvelopeGotFocus: OP=" + TRANSFORM(loCnt.txt_4c_OP.Value) + ;
              " Envelope=" + TRANSFORM(loCnt.txt_4c_Envelope.Value) + " (esperado 0/888)" + CHR(13) + CHR(10)
    STRTOFILE(lcSaida, lcArqSaida)

    *-- ===== 3) KeyPress: tecla que NAO sai do campo nao consulta =====
    lcSaida = lcSaida + "--- KEYPRESS (gate de tecla e de campo vazio) ---" + CHR(13) + CHR(10)
    loCnt.txt_4c_OP.Value       = 4242
    loCnt.txt_4c_Envelope.Value = 0
    loBO.this_nNumeroOP         = 0

    loForm.ValidarOP(65, 0)
    lcSaida = lcSaida + "tecla 65 (A), OP=4242 -> BO.this_nNumeroOP=" + TRANSFORM(loBO.this_nNumeroOP) + ;
              " (esperado 0 = NAO consultou)" + CHR(13) + CHR(10)

    *-- argumento nao-numerico (chamada direta): nao pode estourar
    loForm.ValidarOP("X", 0)
    lcSaida = lcSaida + "tecla nao-numerica -> BO.this_nNumeroOP=" + TRANSFORM(loBO.this_nNumeroOP) + ;
              " (esperado 0 = NAO consultou, sem excecao)" + CHR(13) + CHR(10)

    *-- campo zerado: "If ! Empty(This.Value)" do Valid legado
    loCnt.txt_4c_OP.Value = 0
    loForm.ValidarOP(13, 0)
    lcSaida = lcSaida + "ENTER com OP=0 -> BO.this_nNumeroOP=" + TRANSFORM(loBO.this_nNumeroOP) + ;
              " (esperado 0 = NAO consultou)" + CHR(13) + CHR(10)
    STRTOFILE(lcSaida, lcArqSaida)

    *-- ===== 4) KeyPress: ENTER com campo preenchido CONSULTA =====
    loCnt.txt_4c_OP.Value = 4242
    loForm.ValidarOP(13, 0)
    lcSaida = lcSaida + "ENTER com OP=4242 -> BO.this_nNumeroOP=" + TRANSFORM(loBO.this_nNumeroOP) + ;
              " (esperado 4242 = CONSULTOU)" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "this_lEmConsulta apos consulta=" + TRANSFORM(loForm.this_lEmConsulta) + ;
              " (esperado .F. - flag liberada depois do ENDTRY)" + CHR(13) + CHR(10)

    loBO.this_nNumeroEnvelope   = 0
    loCnt.txt_4c_OP.Value       = 0
    loCnt.txt_4c_Envelope.Value = 3131
    loForm.ValidarEnvelope(9, 0)
    lcSaida = lcSaida + "TAB com Envelope=3131 -> BO.this_nNumeroEnvelope=" + TRANSFORM(loBO.this_nNumeroEnvelope) + ;
              " (esperado 3131 = CONSULTOU)" + CHR(13) + CHR(10)
    lcSaida = lcSaida + "this_lEmConsulta apos consulta=" + TRANSFORM(loForm.this_lEmConsulta) + ;
              " (esperado .F.)" + CHR(13) + CHR(10)

    *-- ===== 5) Guarda de reentrancia bloqueia =====
    loBO.this_nNumeroOP     = 0
    loForm.this_lEmConsulta = .T.
    loCnt.txt_4c_OP.Value   = 5555
    loForm.ValidarOP(13, 0)
    lcSaida = lcSaida + "ENTER com this_lEmConsulta=.T. -> BO.this_nNumeroOP=" + TRANSFORM(loBO.this_nNumeroOP) + ;
              " (esperado 0 = guarda bloqueou)" + CHR(13) + CHR(10)
    loForm.this_lEmConsulta = .F.

    lcSaida = lcSaida + "RESULTADO=INSTANCIOU" + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "RESULTADO=NAO INSTANCIOU" + CHR(13) + CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    lcSaida = lcSaida + "--- ERROS REPORTADOS (MsgErro/MsgAviso em modo teste) ---" + CHR(13) + CHR(10) + ;
              FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    lcSaida = lcSaida + "--- sem arquivo de erro de teste ---" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, lcArqSaida)
QUIT
