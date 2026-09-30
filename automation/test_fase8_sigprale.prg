*==============================================================================
* test_fase8_sigprale.prg - Harness da Fase 8 do FormSIGPRALE
* Prova, INSTANCIANDO de verdade: o form abre; a geometria dos 4 objetos bate
* com o dump do SCX; o Init de 4 parametros reproduz o legado por PRESENCA
* (nao por conteudo); FormParaBO/BOParaForm continuam os no-op HERDADOS de
* FormBase (nao sobrescritos); e o BO foi instanciado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnFalhas, lcObj, i
lcCRLF   = CHR(13) + CHR(10)
lcLog    = "C:\4c\automation\fase8_sigprale_teste.txt"
lcCls    = "C:\4c\projeto\app\classes\"
lcUtl    = "C:\4c\projeto\app\utils\"
lnFalhas = 0

STRTOFILE("=== TESTE FASE 8 FormSIGPRALE ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste         = .T.
gb_4c_ValidandoUI       = .F.
gnConnHandle            = -1
gc_4c_CaminhoIcones     = "C:\4c\vbmp\"
gc_4c_CaminhoReports    = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework  = "C:\4c\Framework\"
gc_4c_UsuarioLogado     = "TESTE"
gc_4c_ArquivoErroTeste  = "C:\4c\automation\fase8_sigprale_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais,C:\4c\vbmp")

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "SIGPRALEBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGPRALE.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE        : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE        : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

*==============================================================================
* CENARIO A - SEM parametro: as 3 Captions do SCX sobrevivem
*==============================================================================
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGPRALE")
CATCH TO loErr
    STRTOFILE("A) CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("A) CREATEOBJECT      : FALHOU (VARTYPE=" + VARTYPE(loForm) + ")" + lcCRLF, lcLog, 1)
    STRTOFILE("RESULTADO            : FALHA" + lcCRLF, lcLog, 1)
    QUIT
ENDIF

STRTOFILE("A) CREATEOBJECT      : OK (form instanciado sem parametro)" + lcCRLF, lcLog, 1)

*-- Geometria do Form (dump: Height=115 Width=419 DataSession=2 TitleBar=0)
STRTOFILE("A) Form geometria    : H=" + TRANSFORM(loForm.Height) + ;
    " W=" + TRANSFORM(loForm.Width) + " DS=" + TRANSFORM(loForm.DataSession) + ;
    " TitleBar=" + TRANSFORM(loForm.TitleBar) + " ControlBox=" + TRANSFORM(loForm.ControlBox) + ;
    " Closable=" + TRANSFORM(loForm.Closable) + " MinButton=" + TRANSFORM(loForm.MinButton) + ;
    " MaxButton=" + TRANSFORM(loForm.MaxButton) + " AlwaysOnTop=" + TRANSFORM(loForm.AlwaysOnTop) + ;
    " BorderStyle=" + TRANSFORM(loForm.BorderStyle) + " AutoCenter=" + TRANSFORM(loForm.AutoCenter) + lcCRLF, lcLog, 1)
IF loForm.Height != 115 OR loForm.Width != 419 OR loForm.TitleBar != 0 OR ;
   loForm.ControlBox OR loForm.Closable OR loForm.MinButton OR loForm.MaxButton OR ;
   !loForm.AlwaysOnTop OR loForm.BorderStyle != 2 OR !loForm.AutoCenter
    STRTOFILE("A) Form geometria    : DIVERGE DO DUMP" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

*-- Picture do Form (dump: ..\framework\imagens\new_background.jpg)
STRTOFILE("A) Form.Picture      : [" + ALLTRIM(loForm.Picture) + "]" + lcCRLF, lcLog, 1)
IF !("new_background.jpg" $ LOWER(loForm.Picture))
    STRTOFILE("A) Form.Picture      : AUSENTE" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

*-- Os 4 objetos do dump existem
LOCAL ARRAY laObj[4]
laObj[1] = "img_4c_Imagem"
laObj[2] = "lbl_4c_Mensagem"
laObj[3] = "lbl_4c_Mensagem2"
laObj[4] = "lbl_4c_Mensagem3"
FOR i = 1 TO 4
    lcObj = laObj[i]
    IF PEMSTATUS(loForm, lcObj, 5)
        STRTOFILE("A) " + PADR(lcObj, 18) + ": EXISTE" + lcCRLF, lcLog, 1)
    ELSE
        STRTOFILE("A) " + PADR(lcObj, 18) + ": AUSENTE" + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDIF
ENDFOR

*-- Geometria dos controles contra o dump
STRTOFILE("A) Imagem            : T=" + TRANSFORM(loForm.img_4c_Imagem.Top) + ;
    " L=" + TRANSFORM(loForm.img_4c_Imagem.Left) + " W=" + TRANSFORM(loForm.img_4c_Imagem.Width) + ;
    " H=" + TRANSFORM(loForm.img_4c_Imagem.Height) + " Visible=" + TRANSFORM(loForm.img_4c_Imagem.Visible) + ;
    " Picture=[" + ALLTRIM(loForm.img_4c_Imagem.Picture) + "]" + lcCRLF, lcLog, 1)
IF loForm.img_4c_Imagem.Top != 5 OR loForm.img_4c_Imagem.Left != 6 OR ;
   loForm.img_4c_Imagem.Width != 38 OR loForm.img_4c_Imagem.Height != 36 OR ;
   !loForm.img_4c_Imagem.Visible OR !EMPTY(loForm.img_4c_Imagem.Picture)
    STRTOFILE("A) Imagem            : DIVERGE DO DUMP" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

STRTOFILE("A) mensagem          : T=" + TRANSFORM(loForm.lbl_4c_Mensagem.Top) + ;
    " L=" + TRANSFORM(loForm.lbl_4c_Mensagem.Left) + " W=" + TRANSFORM(loForm.lbl_4c_Mensagem.Width) + ;
    " H=" + TRANSFORM(loForm.lbl_4c_Mensagem.Height) + ;
    " Fonte=" + ALLTRIM(loForm.lbl_4c_Mensagem.FontName) + "/" + TRANSFORM(loForm.lbl_4c_Mensagem.FontSize) + ;
    " Bold=" + TRANSFORM(loForm.lbl_4c_Mensagem.FontBold) + ;
    " Align=" + TRANSFORM(loForm.lbl_4c_Mensagem.Alignment) + ;
    " BackStyle=" + TRANSFORM(loForm.lbl_4c_Mensagem.BackStyle) + ;
    " WordWrap=" + TRANSFORM(loForm.lbl_4c_Mensagem.WordWrap) + ;
    " Fore=" + TRANSFORM(loForm.lbl_4c_Mensagem.ForeColor) + lcCRLF, lcLog, 1)
IF loForm.lbl_4c_Mensagem.Top != 4 OR loForm.lbl_4c_Mensagem.Left != 85 OR ;
   loForm.lbl_4c_Mensagem.Width != 97 OR loForm.lbl_4c_Mensagem.Height != 25 OR ;
   loForm.lbl_4c_Mensagem.FontSize != 14 OR !loForm.lbl_4c_Mensagem.FontBold OR ;
   loForm.lbl_4c_Mensagem.Alignment != 2 OR loForm.lbl_4c_Mensagem.BackStyle != 0 OR ;
   !loForm.lbl_4c_Mensagem.WordWrap OR loForm.lbl_4c_Mensagem.ForeColor != RGB(255,0,0)
    STRTOFILE("A) mensagem          : DIVERGE DO DUMP" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

STRTOFILE("A) mensagem2         : T=" + TRANSFORM(loForm.lbl_4c_Mensagem2.Top) + ;
    " L=" + TRANSFORM(loForm.lbl_4c_Mensagem2.Left) + " W=" + TRANSFORM(loForm.lbl_4c_Mensagem2.Width) + ;
    " H=" + TRANSFORM(loForm.lbl_4c_Mensagem2.Height) + lcCRLF, lcLog, 1)
IF loForm.lbl_4c_Mensagem2.Top != 32 OR loForm.lbl_4c_Mensagem2.Left != 85 OR ;
   loForm.lbl_4c_Mensagem2.Width != 221 OR loForm.lbl_4c_Mensagem2.Height != 25
    STRTOFILE("A) mensagem2         : DIVERGE DO DUMP" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

STRTOFILE("A) mensagem3         : T=" + TRANSFORM(loForm.lbl_4c_Mensagem3.Top) + ;
    " L=" + TRANSFORM(loForm.lbl_4c_Mensagem3.Left) + " W=" + TRANSFORM(loForm.lbl_4c_Mensagem3.Width) + ;
    " H=" + TRANSFORM(loForm.lbl_4c_Mensagem3.Height) + lcCRLF, lcLog, 1)
IF loForm.lbl_4c_Mensagem3.Top != 62 OR loForm.lbl_4c_Mensagem3.Left != 85 OR ;
   loForm.lbl_4c_Mensagem3.Width != 248 OR loForm.lbl_4c_Mensagem3.Height != 48
    STRTOFILE("A) mensagem3         : DIVERGE DO DUMP" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

*-- Captions padrao do SCX preservadas (nenhum parametro informado)
STRTOFILE("A) Caption1          : [" + loForm.lbl_4c_Mensagem.Caption + "]" + lcCRLF, lcLog, 1)
STRTOFILE("A) Caption2          : [" + loForm.lbl_4c_Mensagem2.Caption + "]" + lcCRLF, lcLog, 1)
STRTOFILE("A) Caption3          : [" + loForm.lbl_4c_Mensagem3.Caption + "]" + lcCRLF, lcLog, 1)
IF loForm.lbl_4c_Mensagem.Caption != "Aguarde..." OR ;
   EMPTY(loForm.lbl_4c_Mensagem2.Caption) OR EMPTY(loForm.lbl_4c_Mensagem3.Caption)
    STRTOFILE("A) Captions          : DIVERGE (legado preserva as 3 do SCX)" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

*-- BO instanciado
STRTOFILE("A) BO instanciado    : " + IIF(VARTYPE(loForm.this_oBusinessObject) = "O", ;
    "OK (" + loForm.this_oBusinessObject.Class + ")", "AUSENTE") + lcCRLF, lcLog, 1)
IF VARTYPE(loForm.this_oBusinessObject) != "O"
    lnFalhas = lnFalhas + 1
ENDIF

*-- FormParaBO/BOParaForm: existem HERDADOS de FormBase (no-op), nao
*-- redefinidos neste form - a ausencia de override eh conferida no .prg
STRTOFILE("A) FormParaBO existe : " + IIF(PEMSTATUS(loForm, "FormParaBO", 5), "SIM (herdado de FormBase)", "NAO") + lcCRLF, lcLog, 1)
STRTOFILE("A) BOParaForm existe : " + IIF(PEMSTATUS(loForm, "BOParaForm", 5), "SIM (herdado de FormBase)", "NAO") + lcCRLF, lcLog, 1)
IF !PEMSTATUS(loForm, "FormParaBO", 5) OR !PEMSTATUS(loForm, "BOParaForm", 5)
    lnFalhas = lnFalhas + 1
ENDIF

loForm.Release()
loForm = .NULL.

*==============================================================================
* CENARIO B - COM parametros: as 3 Captions sao SUBSTITUIDAS (presenca, nao
* conteudo) - o _msg3 ausente deixa a 3a Caption VAZIA, como o legado faz
* (Iif(Type('_msg3')='C',_msg3,'')). E a Imagem recebe o Picture informado.
*==============================================================================
TRY
    loForm = CREATEOBJECT("FormSIGPRALE", "C:\4c\vbmp\cadastro_salvar_60.jpg", ;
        "Processando...", "Etapa 2 de 3")
CATCH TO loErr
    STRTOFILE("B) CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("B) CREATEOBJECT      : OK (3 parametros)" + lcCRLF, lcLog, 1)
    STRTOFILE("B) Caption1          : [" + loForm.lbl_4c_Mensagem.Caption + "]" + lcCRLF, lcLog, 1)
    STRTOFILE("B) Caption2          : [" + loForm.lbl_4c_Mensagem2.Caption + "]" + lcCRLF, lcLog, 1)
    STRTOFILE("B) Caption3(vazia?)  : [" + loForm.lbl_4c_Mensagem3.Caption + "]" + lcCRLF, lcLog, 1)
    STRTOFILE("B) Imagem.Visible    : " + TRANSFORM(loForm.img_4c_Imagem.Visible) + ;
        " Picture=[" + ALLTRIM(loForm.img_4c_Imagem.Picture) + "]" + lcCRLF, lcLog, 1)
    IF loForm.lbl_4c_Mensagem.Caption != "Processando..." OR ;
       loForm.lbl_4c_Mensagem2.Caption != "Etapa 2 de 3" OR ;
       !EMPTY(loForm.lbl_4c_Mensagem3.Caption) OR ;
       !loForm.img_4c_Imagem.Visible OR EMPTY(loForm.img_4c_Imagem.Picture)
        STRTOFILE("B) Init legado       : DIVERGE (presenca x conteudo)" + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDIF
    loForm.Release()
    loForm = .NULL.
ELSE
    STRTOFILE("B) CREATEOBJECT      : FALHOU" + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDIF

*==============================================================================
* CENARIO C - parametros informados VAZIOS: o legado ainda apaga as 3 Captions,
* porque o criterio e' Type()='C' (PRESENCA), nao Empty() (conteudo)
*==============================================================================
TRY
    loForm = CREATEOBJECT("FormSIGPRALE", "", "", "", "")
CATCH TO loErr
    STRTOFILE("C) CREATEOBJECT      : EXCECAO - " + loErr.Message + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("C) Captions vazias?  : [" + loForm.lbl_4c_Mensagem.Caption + "][" + ;
        loForm.lbl_4c_Mensagem2.Caption + "][" + loForm.lbl_4c_Mensagem3.Caption + "]" + lcCRLF, lcLog, 1)
    IF !EMPTY(loForm.lbl_4c_Mensagem.Caption) OR !EMPTY(loForm.lbl_4c_Mensagem2.Caption) OR ;
       !EMPTY(loForm.lbl_4c_Mensagem3.Caption)
        STRTOFILE("C) Init legado       : DIVERGE (string vazia deve apagar)" + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDIF
    loForm.Release()
    loForm = .NULL.
ELSE
    lnFalhas = lnFalhas + 1
ENDIF

STRTOFILE(lcCRLF + "FALHAS               : " + TRANSFORM(lnFalhas) + lcCRLF, lcLog, 1)
STRTOFILE("RESULTADO            : " + IIF(lnFalhas = 0, "SUCESSO", "FALHA") + lcCRLF, lcLog, 1)
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS SUPRIMIDOS  : " + FILETOSTR(gc_4c_ArquivoErroTeste) + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("DIALOGOS SUPRIMIDOS  : nenhum" + lcCRLF, lcLog, 1)
ENDIF

QUIT
