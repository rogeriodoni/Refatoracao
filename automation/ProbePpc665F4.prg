*==============================================================================
* ProbePpc665F4.prg - Instancia FormSigPrPpc headless (Fase 4 / task665) e
* mede o que a fase entrega neste form OPERACIONAL FLAT:
*   (1) o Init inteiro conclui (CREATEOBJECT devolve objeto);
*   (2) a faixa do cabecalho exibe o TITULO DO FORM e nao o placeholder
*       "Cadastro de Testes" do SCX - o Init legado faz
*       lblSombra/lblTitulo.Caption = ThisForm.Caption (dump linhas 499-500);
*   (3) os 6 labels de dados tem ForeColor RGB(90,90,90) (regra #12: o SCX
*       nao declara ForeColor, classe say) e o separador de periodo eh o
*       CHR(224) do legado, nao um "a" simples;
*   (4) AlternarPagina(2) bloqueia TODOS os campos de filtro e o botao
*       Consultar; AlternarPagina(1) devolve tudo ao estado editavel -
*       este eh o deliverable da Fase 4 adaptado ao layout FLAT;
*   (5) ConfigurarPaginaLista roda pelo funil sem apagar os filtros;
*   (6) escopo: os metodos chamados de FORA (harness / FormBase) tem de ser
*       PUBLIC - PEMSTATUS(...,2) = PROTECTED deve dar .F.;
*   (7) os 2 botoes do CommandGroup apontam para icone que EXISTE
*       (.Picture inexistente falha em silencio - regra #25).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: nao exercita CmdConsultarClick.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ppc665_f4.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_cPic, loc_cLbl
loc_cOut = "C:\4c\automation\probe_ppc665_f4_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrPpcBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrPpc.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) Init completo
    loc_oForm = CREATEOBJECT("FormSigPrPpc")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"FORM Caption=[" + loc_oForm.Caption + "]" + ;
                  " W=" + TRANSFORM(loc_oForm.Width) + ;
                  " H=" + TRANSFORM(loc_oForm.Height), loc_cOut, 1)

        *-- (2) Faixa do cabecalho
        STRTOFILE(CHR(13)+CHR(10)+"CABECALHO Sombra=[" + ;
                  loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "]" + ;
                  " Titulo=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + ;
                  " PLACEHOLDER=" + ;
                  IIF("Cadastro de Testes" $ loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption, ;
                      "PRESENTE", "AUSENTE"), loc_cOut, 1)

        *-- (3) Labels de dados: ForeColor e o separador do periodo
        loc_cLbl = "Grupo=" + TRANSFORM(loc_oForm.lbl_4c_LblGrupo.ForeColor) + ;
                   " Conta=" + TRANSFORM(loc_oForm.lbl_4c_LblConta.ForeColor) + ;
                   " Oper=" + TRANSFORM(loc_oForm.lbl_4c_LblOperacao.ForeColor) + ;
                   " Per=" + TRANSFORM(loc_oForm.lbl_4c_LblPeriodo.ForeColor) + ;
                   " A=" + TRANSFORM(loc_oForm.lbl_4c_LblA.ForeColor) + ;
                   " Emp=" + TRANSFORM(loc_oForm.lbl_4c_LblEmpresa.ForeColor)
        STRTOFILE(CHR(13)+CHR(10)+"LABELS ForeColor " + loc_cLbl + ;
                  " (esperado " + TRANSFORM(RGB(90,90,90)) + ")", loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"SEPARADOR asc=" + TRANSFORM(ASC(loc_oForm.lbl_4c_LblA.Caption)) + ;
                  " (esperado 224)", loc_cOut, 1)

        *-- (4) AlternarPagina: o deliverable da Fase 4
        loc_oForm.txt_4c_Grupo.Value = "99"
        loc_oForm.AlternarPagina(2)
        STRTOFILE(CHR(13)+CHR(10)+"ALTERNAR(2) Grupo=" + TRANSFORM(loc_oForm.txt_4c_Grupo.Enabled) + ;
                  " DGrupo=" + TRANSFORM(loc_oForm.txt_4c_DGrupo.Enabled) + ;
                  " Conta=" + TRANSFORM(loc_oForm.txt_4c_Conta.Enabled) + ;
                  " ContaDesc=" + TRANSFORM(loc_oForm.txt_4c_ContaDesc.Enabled) + ;
                  " Oper=" + TRANSFORM(loc_oForm.txt_4c_Operacao.Enabled) + ;
                  " DtIni=" + TRANSFORM(loc_oForm.txt_4c_DtIni.Enabled) + ;
                  " DtFin=" + TRANSFORM(loc_oForm.txt_4c_DtFin.Enabled) + ;
                  " Emp=" + TRANSFORM(loc_oForm.txt_4c_Empresa.Enabled) + ;
                  " EmpDesc=" + TRANSFORM(loc_oForm.txt_4c_EmpresaDesc.Enabled) + ;
                  " Consultar=" + TRANSFORM(loc_oForm.cmg_4c_Operacao.Buttons(1).Enabled), loc_cOut, 1)

        loc_oForm.AlternarPagina(1)
        STRTOFILE(CHR(13)+CHR(10)+"ALTERNAR(1) Grupo=" + TRANSFORM(loc_oForm.txt_4c_Grupo.Enabled) + ;
                  " DGrupo=" + TRANSFORM(loc_oForm.txt_4c_DGrupo.Enabled) + ;
                  " Conta=" + TRANSFORM(loc_oForm.txt_4c_Conta.Enabled) + ;
                  " ContaDesc=" + TRANSFORM(loc_oForm.txt_4c_ContaDesc.Enabled) + ;
                  " Oper=" + TRANSFORM(loc_oForm.txt_4c_Operacao.Enabled) + ;
                  " DtIni=" + TRANSFORM(loc_oForm.txt_4c_DtIni.Enabled) + ;
                  " DtFin=" + TRANSFORM(loc_oForm.txt_4c_DtFin.Enabled) + ;
                  " Emp=" + TRANSFORM(loc_oForm.txt_4c_Empresa.Enabled) + ;
                  " EmpDesc=" + TRANSFORM(loc_oForm.txt_4c_EmpresaDesc.Enabled) + ;
                  " Consultar=" + TRANSFORM(loc_oForm.cmg_4c_Operacao.Buttons(1).Enabled), loc_cOut, 1)

        *-- (5) ConfigurarPaginaLista roda pelo funil e NAO apaga o filtro
        STRTOFILE(CHR(13)+CHR(10)+"POS-VOLTA Grupo.Value=[" + ;
                  ALLTRIM(loc_oForm.txt_4c_Grupo.Value) + "] (esperado 99)", loc_cOut, 1)

        *-- (6) Escopo (2 = PROTECTED) dos metodos chamados de fora
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO prot AlternarPagina=" + TRANSFORM(PEMSTATUS(loc_oForm,"AlternarPagina",2)) + ;
                  " CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2)) + ;
                  " AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loc_oForm,"AjustarBotoesPorModo",2)) + ;
                  " HabilitarCampos=" + TRANSFORM(PEMSTATUS(loc_oForm,"HabilitarCampos",2)) + ;
                  " LimparCampos=" + TRANSFORM(PEMSTATUS(loc_oForm,"LimparCampos",2)) + ;
                  " BtnIncluirClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnIncluirClick",2)) + ;
                  " BtnCancelarClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnCancelarClick",2)), loc_cOut, 1)

        *-- (7) Icones dos 2 botoes
        loc_cPic = "Consultar[" + JUSTFNAME(loc_oForm.cmg_4c_Operacao.Buttons(1).Picture) + "]=" + ;
                   IIF(FILE(loc_oForm.cmg_4c_Operacao.Buttons(1).Picture), "OK", "FALTA") + ;
                   " Encerrar[" + JUSTFNAME(loc_oForm.cmg_4c_Operacao.Buttons(2).Picture) + "]=" + ;
                   IIF(FILE(loc_oForm.cmg_4c_Operacao.Buttons(2).Picture), "OK", "FALTA")
        STRTOFILE(CHR(13)+CHR(10)+"BOTOES " + loc_cPic, loc_cOut, 1)

        *-- CarregarLista (contrato FormBase) tem de devolver .T.
        STRTOFILE(CHR(13)+CHR(10)+"CarregarLista retorno=" + TRANSFORM(loc_oForm.CarregarLista()), loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
