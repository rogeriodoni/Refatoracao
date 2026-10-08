*==============================================================================
* TestSigPrGmiF5.prg - Verificacao headless do FormSigPrGmi (task619, Fase 5)
*
* Prova o que "compila limpo" NAO prova:
*   1. o Init inteiro roda (CREATEOBJECT devolve OBJETO, nao .F.) - Init de
*      form falha em CADEIA e cada defeito esconde o proximo;
*   2. os 6 TextBox + 3 Labels da Fase 5 existem no objeto VIVO;
*   3. cada propriedade transcrita bate com o dump do SIGPRGMI.SCX
*      (Top/Left/Width/Height/MaxLength/Format/InputMask/FontName/FontSize) -
*      divergencia de layout nao da erro e nao aparece em log;
*   4. o TabIndex saiu na ordem do SCX (2..7) e NAO na ordem de criacao, que
*      poria os botoes Processar/Encerrar antes dos campos.
*
* A tabela de esperados eh uma STRING "controle|propriedade|valor" por linha:
* VFP9 nao tem separador de comandos (nao existe o "|" de uma linha so), e
* uma tabela desta altura em assignments viraria 126 linhas de ruido.
* A comparacao eh feita sobre ALLTRIM(TRANSFORM(valor)), que normaliza
* numerico, caractere e logico num unico criterio.
*
* SET SAFETY/RESOURCE OFF: script auxiliar de pipeline nao supervisionado -
* dialogo modal travaria a execucao indefinidamente (CLAUDE.md regra #6).
* gb_4c_ModoTeste SOZINHO nao suprime dialogo: precisa de
* gc_4c_ArquivoErroTeste apontando para um arquivo (senao o teste TRAVA).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_sigprgmi_f5_dialogos.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRel, loc_oForm, loc_oErro, loc_nI, loc_nFalhas, loc_nLinhas
LOCAL loc_cNome, loc_oCtl, loc_cProp, loc_cEsp, loc_cObt, loc_cTabela
LOCAL ARRAY loc_aLinha[1]

loc_cRel    = ""
loc_nFalhas = 0

*-- "DO config.prg" so DEFINE as globais gc_4c_Caminho* e retorna. NAO se
*-- chama ConfigurarAmbiente(): medido nesta maquina, ela NAO RETORNA (o
*-- processo fica pendurado antes de qualquer CREATEOBJECT, e o probe morre
*-- por timeout sem uma linha de diagnostico). Em troca, carrega-se a mao
*-- apenas o que este form usa - o carregamento em massa de classes\ e
*-- forms\ que mora dentro de ConfigurarAmbiente nao eh necessario aqui.
*-- SET PATH com UMA string concatenada: com varias expressoes separadas por
*-- virgula o VFP9 honra SO a primeira (CLAUDE.md regra #26).
*-- gb_4c_ValidandoUI e' atribuido DEPOIS do config.prg porque o config
*-- reseta a flag.
CD C:\4c\projeto\app\start
TRY
    DO config.prg

    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
                 gc_4c_CaminhoIcones)

    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrGmiBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrGmi.prg") ADDITIVE

    gb_4c_ValidandoUI = .T.
    loc_cRel = loc_cRel + "CONFIG=OK PROCS=" + ;
               TRANSFORM(OCCURS(",", SET("PROCEDURE")) + 1) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "CONFIG=ERRO: " + loc_oErro.Message + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

*-- 1) O form INSTANCIA?
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigPrGmi")
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "CREATEOBJECT=EXCECAO: " + loc_oErro.Message + ;
               " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
               " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

loc_cRel = loc_cRel + "VARTYPE(form)=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cRel = loc_cRel + "ControlCount=" + ;
               TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10)

    *-- 2) e 3) Propriedades transcritas, controle a controle, contra o dump.
    TEXT TO loc_cTabela NOSHOW
lbl_4c_Lbl_empresa|Top|118
lbl_4c_Lbl_empresa|Left|211
lbl_4c_Lbl_empresa|Width|53
lbl_4c_Lbl_empresa|AutoSize|.F.
lbl_4c_Lbl_empresa|ForeColor|5921370
lbl_4c_Lbl_empresa|Caption|Empresa :
txt_4c__cd_empresa|Top|113
txt_4c__cd_empresa|Left|268
txt_4c__cd_empresa|Width|31
txt_4c__cd_empresa|Height|25
txt_4c__cd_empresa|MaxLength|3
txt_4c__cd_empresa|Format|K
txt_4c__cd_empresa|InputMask|XXX
txt_4c__cd_empresa|FontName|Courier New
txt_4c__cd_empresa|FontSize|9
txt_4c__cd_empresa|SpecialEffect|0
txt_4c__cd_empresa|BorderStyle|1
txt_4c__cd_empresa|TabIndex|2
txt_4c__ds_empresa|Top|113
txt_4c__ds_empresa|Left|348
txt_4c__ds_empresa|Width|290
txt_4c__ds_empresa|MaxLength|40
txt_4c__ds_empresa|Format|K
txt_4c__ds_empresa|FontName|Courier New
txt_4c__ds_empresa|FontSize|9
txt_4c__ds_empresa|TabIndex|3
lbl_4c_Label1|Top|142
lbl_4c_Label1|Left|166
lbl_4c_Label1|Width|98
lbl_4c_Label1|AutoSize|.F.
lbl_4c_Label1|Caption|Grupo de Estoque :
txt_4c__Cd_GrEstoque|Top|138
txt_4c__Cd_GrEstoque|Left|268
txt_4c__Cd_GrEstoque|Width|80
txt_4c__Cd_GrEstoque|MaxLength|10
txt_4c__Cd_GrEstoque|FontName|Courier New
txt_4c__Cd_GrEstoque|TabIndex|4
txt_4c__Ds_GrEstoque|Top|138
txt_4c__Ds_GrEstoque|Left|348
txt_4c__Ds_GrEstoque|Width|150
txt_4c__Ds_GrEstoque|MaxLength|20
txt_4c__Ds_GrEstoque|TabIndex|5
lbl_4c_Lbl_estoque|Top|168
lbl_4c_Lbl_estoque|Left|213
lbl_4c_Lbl_estoque|Width|51
lbl_4c_Lbl_estoque|AutoSize|.F.
lbl_4c_Lbl_estoque|Caption|Estoque :
txt_4c__cd_estoque|Top|163
txt_4c__cd_estoque|Left|268
txt_4c__cd_estoque|Width|80
txt_4c__cd_estoque|MaxLength|10
txt_4c__cd_estoque|Format|K
txt_4c__cd_estoque|FontName|Courier New
txt_4c__cd_estoque|FontSize|9
txt_4c__cd_estoque|SpecialEffect|0
txt_4c__cd_estoque|TabIndex|6
txt_4c__ds_estoque|Top|163
txt_4c__ds_estoque|Left|348
txt_4c__ds_estoque|Width|290
txt_4c__ds_estoque|MaxLength|40
txt_4c__ds_estoque|FontName|Courier New
txt_4c__ds_estoque|TabIndex|7
    ENDTEXT

    loc_nLinhas = ALINES(loc_aLinha, loc_cTabela)
    loc_cRel = loc_cRel + "Conferindo " + TRANSFORM(loc_nLinhas) + ;
               " propriedades contra o dump" + CHR(13) + CHR(10)

    FOR loc_nI = 1 TO loc_nLinhas
        loc_cNome = ALLTRIM(GETWORDNUM(loc_aLinha[loc_nI], 1, "|"))
        loc_cProp = ALLTRIM(GETWORDNUM(loc_aLinha[loc_nI], 2, "|"))
        loc_cEsp  = ALLTRIM(GETWORDNUM(loc_aLinha[loc_nI], 3, "|"))

        IF EMPTY(loc_cNome)
            LOOP
        ENDIF

        IF !PEMSTATUS(loc_oForm, loc_cNome, 5)
            loc_cRel = loc_cRel + "FALHA controle AUSENTE: " + loc_cNome + ;
                       CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
            LOOP
        ENDIF

        loc_oCtl = EVALUATE("loc_oForm." + loc_cNome)

        IF !PEMSTATUS(loc_oCtl, loc_cProp, 5)
            loc_cRel = loc_cRel + "FALHA propriedade AUSENTE: " + ;
                       loc_cNome + "." + loc_cProp + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
            LOOP
        ENDIF

        loc_cObt = ALLTRIM(TRANSFORM(EVALUATE("loc_oForm." + loc_cNome + ;
                                              "." + loc_cProp)))

        IF loc_cObt == loc_cEsp
            loc_cRel = loc_cRel + "ok    " + loc_cNome + "." + loc_cProp + ;
                       " = " + loc_cObt + CHR(13) + CHR(10)
        ELSE
            loc_cRel = loc_cRel + "FALHA " + loc_cNome + "." + loc_cProp + ;
                       " esperado=[" + loc_cEsp + "] obtido=[" + loc_cObt + ;
                       "]" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    ENDFOR

    *-- 4) Os botoes da Fase 4 nao podem ficar na frente dos campos no Tab.
    loc_cRel = loc_cRel + "TabIndex botoes (apos ajuste): Processa=" + ;
               TRANSFORM(loc_oForm.cmd_4c_Processa.TabIndex) + ;
               " Cancela=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.TabIndex) + ;
               CHR(13) + CHR(10)

    loc_oForm = .NULL.
ELSE
    loc_cRel = loc_cRel + ;
               "FALHA: form nao instanciou - Init devolveu .F." + ;
               CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRel = loc_cRel + "DIALOGOS SUPRIMIDOS (houve erro):" + CHR(13) + CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDIF

loc_cRel = loc_cRel + "==============================" + CHR(13) + CHR(10)
loc_cRel = loc_cRel + "FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10)
loc_cRel = loc_cRel + IIF(loc_nFalhas = 0, "RESULTADO=SUCESSO", ;
                          "RESULTADO=FALHA") + CHR(13) + CHR(10)

STRTOFILE(loc_cRel, "C:\4c\automation\test_sigprgmi_f5.txt")
QUIT
