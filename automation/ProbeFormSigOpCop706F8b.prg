*==============================================================================
* ProbeFormSigOpCop706F8b.prg
*
* Parte B da probe: estado dos campos quando a tela e aberta SEM chamador
* (par_cOperacao ausente) - o caminho do item de menu, em que a nota 19 do
* FormSigOpCop manda o campo de origem ficar DIGITAVEL.
*
* Roda em processo PROPRIO de proposito: na parte A ficou medido que a SEGUNDA
* instanciacao no MESMO processo nao retorna sob vfp9 -T (o Destroy do FormBase
* reconstroi o menu principal). Isso e do harness, nao do form - a parte A
* criou, acionou e liberou a tela inteira com sucesso.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\ProbeFormSigOpCop706F8b.err"
IF FILE(gc_4c_ArquivoErroTeste)
    ERASE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL lcOut, lcSaida, loForm, loc_oErro
lcOut   = "C:\4c\automation\ProbeFormSigOpCop706F8b.out"
lcSaida = ""

STRTOFILE("CKB0 inicio" + CHR(13) + CHR(10), lcOut)
CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSigOpCop")
STRTOFILE("CKB1 ambiente ok" + CHR(13) + CHR(10), lcOut, 1)

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
        lcSaida = lcSaida + "   Encerrar.Enabled=" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(2).Enabled) + CHR(13) + CHR(10)

        *-- Guard de origem vazia: para antes de tudo e NAO pode deixar a tela
        *-- travada nem a guarda de reentrancia presa (notas 26 e 31).
        loForm.BtnCopiarClick()

        lcSaida = lcSaida + "B pos-BtnCopiarClick (guard de origem):" + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.ReadOnly =" + TRANSFORM(loForm.txt_4c_Origem.ReadOnly) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Origem.TabStop  =" + TRANSFORM(loForm.txt_4c_Origem.TabStop) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   Copiar.Enabled  =" + TRANSFORM(loForm.cmg_4c_Botoes.Buttons(1).Enabled) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   EmCopia (flag)  =" + TRANSFORM(loForm.this_lEmCopia) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   EmLookupOrigem  =" + TRANSFORM(loForm.this_lEmLookupOrigem) + CHR(13) + CHR(10)
        lcSaida = lcSaida + "   EmValidaDestino =" + TRANSFORM(loForm.this_lEmValidaDestino) + CHR(13) + CHR(10)

        STRTOFILE("CKB2 props lidas:" + CHR(13) + CHR(10) + lcSaida, lcOut, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("B: EXCECAO " + loc_oErro.Message + " LN=" + ;
              TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), lcOut, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("ERROS CAPTURADOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste), lcOut, 1)
ELSE
    STRTOFILE("ERROS CAPTURADOS: (nenhum)" + CHR(13) + CHR(10), lcOut, 1)
ENDIF

STRTOFILE("CKB3 fim" + CHR(13) + CHR(10), lcOut, 1)
QUIT
