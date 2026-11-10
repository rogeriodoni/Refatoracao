* ProbeF8Task755.prg - Prova de RUNTIME da Fase 8 do FormSigOpJob.
* Exercita o que a Fase 8 acrescentou: ChecarCamposObrigatorios (mascara
* SigOpCdI.job_mv_obr), AplicarTitulosPersonalizados (job_mv_tit/job_mv_cpo),
* AplicarVisibilidadeEquipes (SigCdEmp.divnotas) e o funil CarregarLista.
*
* Sem banco (o SQL Server do projeto nao e alcancavel nesta maquina) as tres
* cargas do BO devolvem .F. e as propriedades ficam vazias - entao o probe
* INJETA valores nas propriedades para exercitar a LOGICA, que e o que a
* Fase 8 escreveu.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probef8_755.txt"
STRTOFILE("PROBE F8 task755 INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpJob")

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probef8_755_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LogF8("ambiente OK")

LOCAL loForm, loBO, lcRet, lnCor
LOCAL ARRAY laEv[1]
loForm = CREATEOBJECT("ProbeF8FormSigOpJob")
LogF8("CK01 CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    loBO = loForm.this_oBusinessObject
    LogF8("CK02 BO VARTYPE=" + VARTYPE(loBO))

    *-- Visibilidade dos metodos novos (regra #3: o harness chama de fora)
    LogF8("CK03 CarregarLista PROTECTED?=" + TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 2)))
    LogF8("CK04 ChecarCamposObrigatorios PROTECTED?=" + TRANSFORM(PEMSTATUS(loForm, "ChecarCamposObrigatorios", 2)))

    *-- Funil da lista chamado A MAO (gb_4c_ModoTeste faz o Init pular)
    loForm.CarregarLista()
    LogF8("CK05 CarregarLista executado; grade RecordSource=[" + ;
          loForm.pgf_4c_Job.Page5.grd_4c_Dados.RecordSource + "]" + ;
          " ColumnCount=" + TRANSFORM(loForm.pgf_4c_Job.Page5.grd_4c_Dados.ColumnCount) + ;
          " Header1=[" + loForm.pgf_4c_Job.Page5.grd_4c_Dados.Column1.Header1.Caption + "]")

    *-- 1) SEM mascara: nada obrigatorio -> "OK"
    loBO.this_cJobMvObr = ""
    lcRet = loForm.ChecarCamposObrigatorios()
    LogF8("CK06 sem mascara -> [" + lcRet + "]  (esperado OK)")

    *-- 2) mascara com "1" na posicao 1 (Apresentacao) e campo VAZIO -> "ERRO"
    loBO.this_cJobMvObr = "1"
    loForm.pgf_4c_Job.Page1.txt_4c__01_001.Value = {}
    lcRet = loForm.ChecarCamposObrigatorios()
    lnCor = loForm.pgf_4c_Job.Page1.txt_4c__01_001.BorderColor
    LogF8("CK07 mascara pos1=1 + campo vazio -> [" + lcRet + "]  (esperado ERRO)" + ;
          "  BorderColor=" + TRANSFORM(lnCor) + ;
          "  vermelho=" + TRANSFORM(lnCor = RGB(255,0,0)))

    *-- 3) mesmo campo PREENCHIDO -> volta a "OK" e fica AZUL
    loForm.pgf_4c_Job.Page1.txt_4c__01_001.Value = DATE()
    lcRet = loForm.ChecarCamposObrigatorios()
    lnCor = loForm.pgf_4c_Job.Page1.txt_4c__01_001.BorderColor
    LogF8("CK08 mascara pos1=1 + campo preenchido -> [" + lcRet + "]  (esperado OK)" + ;
          "  BorderColor=" + TRANSFORM(lnCor) + ;
          "  azul=" + TRANSFORM(lnCor = RGB(36,84,155)))

    *-- 4) posicao 3 = PAR de datas (Periodo do Evento): so uma preenchida -> ERRO
    loBO.this_cJobMvObr = "001"
    loForm.pgf_4c_Job.Page1.txt_4c__01_017.Value = DATE()
    loForm.pgf_4c_Job.Page1.txt_4c__01_018.Value = {}
    lcRet = loForm.ChecarCamposObrigatorios()
    LogF8("CK09 par de datas incompleto -> [" + lcRet + "]  (esperado ERRO)" + ;
          "  18.BorderColor vermelho=" + ;
          TRANSFORM(loForm.pgf_4c_Job.Page1.txt_4c__01_018.BorderColor = RGB(255,0,0)))
    loForm.pgf_4c_Job.Page1.txt_4c__01_018.Value = DATE()
    lcRet = loForm.ChecarCamposObrigatorios()
    LogF8("CK10 par de datas completo   -> [" + lcRet + "]  (esperado OK)")

    *-- 5) posicao 36 = GRUPO de 4 CheckBox (Tipo de Projeto): nenhum marcado
    *--    -> ERRO, e o ROTULO da secao fica vermelho (ForeColor, nao Border)
    loBO.this_cJobMvObr = REPLICATE("0", 35) + "1"
    loForm.pgf_4c_Job.Page3.chk_4c_Get_01_038.Value = 0
    loForm.pgf_4c_Job.Page3.chk_4c_Get_01_039.Value = 0
    loForm.pgf_4c_Job.Page3.chk_4c_Get_01_040.Value = 0
    loForm.pgf_4c_Job.Page3.chk_4c_Get_01_041.Value = 0
    lcRet = loForm.ChecarCamposObrigatorios()
    LogF8("CK11 grupo 4 chk nenhum marcado -> [" + lcRet + "]  (esperado ERRO)" + ;
          "  lbl_02_003.ForeColor vermelho=" + ;
          TRANSFORM(loForm.pgf_4c_Job.Page3.lbl_4c_Lbl_02_003.ForeColor = RGB(255,0,0)))
    loForm.pgf_4c_Job.Page3.chk_4c_Get_01_040.Value = 1
    lcRet = loForm.ChecarCamposObrigatorios()
    LogF8("CK12 grupo 4 chk um marcado     -> [" + lcRet + "]  (esperado OK)")

    *-- 6) a peculiaridade do legado: indice 65 le a mascara na posicao 69
    loBO.this_cJobMvObr = REPLICATE("0", 64) + "1"
    LogF8("CK13 mascara so na pos 65 -> CampoObrigatorio(65)=" + ;
          TRANSFORM(loBO.CampoObrigatorio(65)) + " (a mascara DIZ 65)")
    loForm.pgf_4c_Job.Page5.obj_4c_Get_01_070.Value = ""
    lcRet = loForm.ChecarCamposObrigatorios()
    LogF8("CK14 ...mas o indice 65 le a pos 69 -> [" + lcRet + "] (esperado OK: pos 69 = 0)")
    loBO.this_cJobMvObr = REPLICATE("0", 68) + "1"
    lcRet = loForm.ChecarCamposObrigatorios()
    LogF8("CK15 mascara na pos 69 + Outras Receitas vazio -> [" + lcRet + "] (esperado ERRO)")

    *-- 7) titulos personalizados (job_mv_tit / job_mv_cpo)
    loBO.this_cJobMvTit = REPLICATE(" ", 100) + PADR("BRIEF CUSTOM", 50) + ;
                          PADR("EQUIPE UM", 50) + PADR("EQUIPE DOIS", 50)
    loBO.this_cJobMvCpo = REPLICATE(" ", 3350) + PADR("EXTRA CUSTOM", 50)
    LogF8("CK16 ObterTituloPersonalizado(101)=[" + loBO.ObterTituloPersonalizado(101) + "]")
    LogF8("CK17 ObterRotuloPersonalizado(3351)=[" + loBO.ObterRotuloPersonalizado(3351) + "]")
    loForm.TesteAplicarTitulos()
    LogF8("CK18 Page1.Caption=[" + loForm.pgf_4c_Job.Page1.Caption + "]")
    LogF8("CK19 Page2.Caption=[" + loForm.pgf_4c_Job.Page2.Caption + "]")
    LogF8("CK20 Emp1.lbl_02_001=[" + loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.lbl_4c_Lbl_02_001.Caption + "]")
    LogF8("CK21 lbl_Extra=[" + loForm.lbl_4c_Lbl_Extra.Caption + "]")

    *-- 8) visibilidade dos blocos de equipe por SigCdEmp.divnotas
    loBO.this_nDivNotas = 2
    loForm.TesteAplicarVisibilidade()
    LogF8("CK22 divnotas=2 -> Emp1.Visible=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.Visible) + ;
          " Emp2.Visible=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp2.Visible))
    loBO.this_nDivNotas = 3
    loForm.TesteAplicarVisibilidade()
    LogF8("CK23 divnotas=3 -> Emp1.Visible=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.Visible) + ;
          " Emp2.Visible=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp2.Visible) + ;
          " Emp2.Left=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp2.Left) + ;
          " Emp1.Left=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.Left))
    loBO.this_nDivNotas = 4
    loForm.TesteAplicarVisibilidade()
    LogF8("CK24 divnotas=4 -> Emp1.Visible=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp1.Visible) + ;
          " Emp2.Visible=" + TRANSFORM(loForm.pgf_4c_Job.Page3.cnt_4c_Emp2.Visible))

    *-- 9) Os BINDEVENT de LostFocus -> ChecarCamposObrigatorios NAO sao
    *-- conferidos aqui, e de proposito: AEVENTS neste ponto derrubava o
    *-- probe com Program Error (que em "-T" nao aparece no console e nao
    *-- passa pelo MsgErro, entao nao entra no arquivo de erros - o sintoma
    *-- era o log parar no CK24 sem nenhuma pista). A conferencia vive em
    *-- ProbeF8Task755Bind.prg, que isola cada AEVENTS num TRY/CATCH e usa a
    *-- forma de DOIS argumentos com o evento na coluna 3 - la ela passa,
    *-- cobrindo 9 familias de campo mais um controle negativo (a grade, que
    *-- NAO deve ter o binding).

    loForm.Release()
ENDIF

LogF8("PROBE F8 FIM")
QUIT

PROCEDURE LogF8(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

DEFINE CLASS ProbeF8FormSigOpJob AS FormSigOpJob
    *-- AplicarTitulosPersonalizados/AplicarVisibilidadeEquipes sao PROTECTED
    *-- (nada externo os chama no form real); chamar PROTECTED de fora estoura
    *-- Program Error modal e PENDURA o probe - uma subclasse pode.
    PROCEDURE TesteAplicarTitulos()
        THIS.AplicarTitulosPersonalizados()
    ENDPROC
    PROCEDURE TesteAplicarVisibilidade()
        THIS.AplicarVisibilidadeEquipes()
    ENDPROC
ENDDEFINE
