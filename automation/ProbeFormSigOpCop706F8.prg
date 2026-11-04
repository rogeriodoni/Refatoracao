*==============================================================================
* ProbeFormSigOpCop706F8.prg
*
* Prova o estado REAL dos dois campos depois do Init, nos DOIS caminhos que a
* nota 19 do FormSigOpCop distingue - o que instanciar sozinho nao cobre:
*
*   A) origem VINDA DO CHAMADOR (par_cOperacao preenchido)
*        txt_4c_Origem  : Value = a operacao recebida, ReadOnly = .T., TabStop = .F.
*        txt_4c_Destino : Value = "", ReadOnly = .F., TabStop = .T.
*   B) tela aberta SEM chamador (par_cOperacao ausente)
*        txt_4c_Origem  : Value = "", ReadOnly = .F., TabStop = .T.
*
* E prova que a trava da transacao (HabilitarCampos(.F.)) de fato trava os dois
* campos e o botao Copiar, e que o destravamento devolve cada controle ao estado
* da regra - nao a ".T. em tudo".
*
* HabilitarCampos/BOParaForm/LimparCampos/FormParaBO sao PROTECTED (regra #51),
* entao a probe NAO os chama de fora: ela le as PROPRIEDADES dos controles, que
* e o efeito observavel, e aciona a trava pelo caminho publico real - o
* BtnCopiarClick com destino em branco, que para no guard "Destino Invalido" e
* passa pelo destravamento depois do ENDTRY.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\ProbeFormSigOpCop706F8.err"
IF FILE(gc_4c_ArquivoErroTeste)
    ERASE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL lcOut, lcSaida, loForm, loc_oErro
lcOut   = "C:\4c\automation\ProbeFormSigOpCop706F8.out"
lcSaida = ""

STRTOFILE("CK0 inicio" + CHR(13) + CHR(10), lcOut)
CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CK1 config.prg ok" + CHR(13) + CHR(10), lcOut, 1)
ConfigurarAmbiente()
STRTOFILE("CK2 ConfigurarAmbiente ok" + CHR(13) + CHR(10), lcOut, 1)
GarantirClasse("FormSigOpCop")
STRTOFILE("CK3 GarantirClasse ok" + CHR(13) + CHR(10), lcOut, 1)

*------------------------------------------------------------------ CAMINHO A
TRY
    STRTOFILE("CKA0 antes do CREATEOBJECT A" + CHR(13) + CHR(10), lcOut, 1)
    loForm = CREATEOBJECT("FormSigOpCop", .NULL., "VENDA BALCAO")
    STRTOFILE("CKA1 depois do CREATEOBJECT A" + CHR(13) + CHR(10), lcOut, 1)

    IF VARTYPE(loForm) != "O"
        lcSaida = lcSaida + "A: FALHA - CREATEOBJECT devolveu " + VARTYPE(loForm) + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "A origem-do-chamador:" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.Value    =[" + ALLTRIM(loForm.txt_4c_Origem.Value) + "]" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.ReadOnly =" + TRANSFORM(loForm.txt_4c_Origem.ReadOnly) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.TabStop  =" + TRANSFORM(loForm.txt_4c_Origem.TabStop) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Destino.Value   =[" + ALLTRIM(loForm.txt_4c_Destino.Value) + "]" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Destino.ReadOnly=" + TRANSFORM(loForm.txt_4c_Destino.ReadOnly) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Destino.TabStop =" + TRANSFORM(loForm.txt_4c_Destino.TabStop) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Copiar.Enabled  =" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(1).Enabled) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Encerrar.Enabled=" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(2).Enabled) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   BO.Origem       =[" + ALLTRIM(loForm.this_oBusinessObject.this_cOperacaoOrigem) + "]" + CHR(13) + CHR(10)

        *-- Aciona o caminho publico que trava e destrava: destino em branco
        *-- para no guard "Destino Invalido" e passa pelo destravamento que
        *-- fica DEPOIS do ENDTRY (nota 31).
        STRTOFILE("CKA2 antes do BtnCopiarClick A" + CHR(13) + CHR(10), lcOut, 1)
        loForm.BtnCopiarClick()
        STRTOFILE("CKA3 depois do BtnCopiarClick A" + CHR(13) + CHR(10), lcOut, 1)

        lcSaida = lcSaida + "A pos-BtnCopiarClick (guard de destino, destravou):" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.ReadOnly =" + TRANSFORM(loForm.txt_4c_Origem.ReadOnly) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Destino.ReadOnly=" + TRANSFORM(loForm.txt_4c_Destino.ReadOnly) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Destino.TabStop =" + TRANSFORM(loForm.txt_4c_Destino.TabStop) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Copiar.Enabled  =" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(1).Enabled) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   EmCopia (flag)  =" + TRANSFORM(loForm.this_lEmCopia) + CHR(13) + CHR(10)

        STRTOFILE("CKA4 props lidas - conteudo:" + CHR(13) + CHR(10) + lcSaida, lcOut, 1)
        loForm.Release()
        STRTOFILE("CKA5 depois do Release A" + CHR(13) + CHR(10), lcOut, 1)
    ENDIF
CATCH TO loc_oErro
    lcSaida = lcSaida + "A: EXCECAO " + loc_oErro.Message + " LN=" + ;
              TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

loForm = .NULL.
lcSaida = lcSaida + CHR(13) + CHR(10)

*------------------------------------------------------------------ CAMINHO B
TRY
    loForm = CREATEOBJECT("FormSigOpCop")

    IF VARTYPE(loForm) != "O"
        lcSaida = lcSaida + "B: FALHA - CREATEOBJECT devolveu " + VARTYPE(loForm) + CHR(13) + CHR(10)
    ELSE
        lcSaida = lcSaida + "B sem-chamador:" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.Value    =[" + ALLTRIM(loForm.txt_4c_Origem.Value) + "]" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.ReadOnly =" + TRANSFORM(loForm.txt_4c_Origem.ReadOnly) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.TabStop  =" + TRANSFORM(loForm.txt_4c_Origem.TabStop) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Destino.ReadOnly=" + TRANSFORM(loForm.txt_4c_Destino.ReadOnly) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Copiar.Enabled  =" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(1).Enabled) + CHR(13) + CHR(10)

        *-- Guard de origem vazia: para antes de tudo e nao deixa a tela travada
        loForm.BtnCopiarClick()
        lcSaida = lcSaida + "B pos-BtnCopiarClick (guard de origem):" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.ReadOnly =" + TRANSFORM(loForm.txt_4c_Origem.ReadOnly) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.TabStop  =" + TRANSFORM(loForm.txt_4c_Origem.TabStop) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Copiar.Enabled  =" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(1).Enabled) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   EmCopia (flag)  =" + TRANSFORM(loForm.this_lEmCopia) + CHR(13) + CHR(10)

        loForm.Release()
    ENDIF
CATCH TO loc_oErro
    lcSaida = lcSaida + "B: EXCECAO " + loc_oErro.Message + " LN=" + ;
              TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    lcSaida = lcSaida + CHR(13) + CHR(10) + "ERROS CAPTURADOS EM MODO TESTE:" + CHR(13) + CHR(10) + ;
              FILETOSTR(gc_4c_ArquivoErroTeste)
ELSE
    lcSaida = lcSaida + CHR(13) + CHR(10) + "ERROS CAPTURADOS EM MODO TESTE: (nenhum)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE("CK4 fim - resultado abaixo" + CHR(13) + CHR(10), lcOut, 1)
STRTOFILE(lcSaida, lcOut, 1)
QUIT
