* Probe784F6c.prg - Fase 6 task784: exercita ValidarProcura / ProcuraGotFocus.
* Sem laco sobre AEVENTS (a leitura elemento-a-elemento pendurou o VFP no F6b);
* aqui so a CONTAGEM de bindings, que ja prova que os BINDEVENT pegaram.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
ON ERROR DO Err784 WITH MESSAGE(), LINENO(), PROGRAM()

PUBLIC gcOut
gcOut = "C:\4c\automation\probe784f6c.txt"
STRTOFILE("PROBE F6c task784 INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpPdt")

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe784f6c_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

PUBLIC goForm, gnEv, gaEv
goForm = CREATEOBJECT("FormSigOpPdt")
Log784("CREATEOBJECT -> VARTYPE=" + VARTYPE(goForm))

*-- O form tem DataSession = 2 (PRIVADA): o cursor da grade existe
*-- DENTRO da sessao dele e eh INVISIVEL para esta sessao (o F6c anterior
*-- estourou "Alias CURSOR_4C_PENDENTES is not found" por isso). Entrar na
*-- sessao do form para exercitar os handlers sobre o cursor REAL.
SET DATASESSION TO goForm.DataSessionId
Log784("DataSessionId do form=" + TRANSFORM(goForm.DataSessionId))

DIMENSION gaEv[1]
gnEv = AEVENTS(gaEv, goForm.txt_4c_Procura)
Log784("bindings em txt_4c_Procura=" + TRANSFORM(gnEv))

SELECT cursor_4c_Pendentes
Log784("TAGCOUNT=" + TRANSFORM(TAGCOUNT()))

INSERT INTO cursor_4c_Pendentes (Flag, Emps, Dopes, Numes, MascNum, Valos) VALUES (.F., "001", "MALOTE", 10, "000010", 100.00)
INSERT INTO cursor_4c_Pendentes (Flag, Emps, Dopes, Numes, MascNum, Valos) VALUES (.F., "001", "MALOTE", 20, "000020", 200.00)
INSERT INTO cursor_4c_Pendentes (Flag, Emps, Dopes, Numes, MascNum, Valos) VALUES (.F., "001", "MALOTE", 30, "000030", 300.00)
SELECT cursor_4c_Pendentes
GO TOP
Log784("linhas=" + TRANSFORM(RECCOUNT()) + " recno=" + TRANSFORM(RECNO()))

*-- ACHA
goForm.txt_4c_Procura.Value = 20
goForm.ValidarProcura()
SELECT cursor_4c_Pendentes
Log784("ACHA 20: NumesCorrente=" + TRANSFORM(cursor_4c_Pendentes.Numes) + ;
       " campo=" + TRANSFORM(goForm.txt_4c_Procura.Value) + ;
       " pend=" + TRANSFORM(goForm.this_nProcuraPendente) + ;
       " flag=" + TRANSFORM(goForm.this_lEmValidacaoProcura))

*-- NAO ACHA
goForm.txt_4c_Procura.Value = 99
goForm.ValidarProcura()
Log784("NAO ACHA 99: campo=" + TRANSFORM(goForm.txt_4c_Procura.Value) + ;
       " pend=" + TRANSFORM(goForm.this_nProcuraPendente) + ;
       " flag=" + TRANSFORM(goForm.this_lEmValidacaoProcura))

*-- GotFocus pos-recusa: devolve o valor
goForm.ProcuraGotFocus()
Log784("GotFocus pos-recusa: campo=" + TRANSFORM(goForm.txt_4c_Procura.Value) + ;
       " pend=" + TRANSFORM(goForm.this_nProcuraPendente))

*-- GotFocus normal: zera (When legado)
goForm.ProcuraGotFocus()
Log784("GotFocus normal: campo=" + TRANSFORM(goForm.txt_4c_Procura.Value))

*-- VAZIO: nao mexe no cursor
SELECT cursor_4c_Pendentes
GO BOTTOM
PRIVATE pnRecAntes
pnRecAntes = RECNO()
goForm.txt_4c_Procura.Value = 0
goForm.ValidarProcura()
SELECT cursor_4c_Pendentes
Log784("VAZIO: recno antes=" + TRANSFORM(pnRecAntes) + " depois=" + TRANSFORM(RECNO()))

goForm.Release()
Log784("Release OK")
Log784("ARQ ERRO TESTE=[" + IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "<ausente>") + "]")
Log784("PROBE F6c FIM")
QUIT

PROCEDURE Log784(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

PROCEDURE Err784(par_cMsg, par_nLinha, par_cProg)
    STRTOFILE("ERRO VFP: " + TRANSFORM(par_cMsg) + " | LINENO=" + TRANSFORM(par_nLinha) + ;
        " | PROG=" + TRANSFORM(par_cProg) + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
