*==============================================================================
* ProbeCim701F8.prg - task701 (SIGOPCIM -> Formsigopcim), Fase 8.
*
* MEDE em VFP9, instanciando o form de verdade (regra "a tela abriu so se
* prova instanciando"), o que a Fase 8 consolidou:
*   1) o form instancia nos DOIS modos do legado (Consulta Imagem / Exclusao)
*   2) o ESCOPO de cada metodo novo (regra CLAUDE.md #3/#51: PEMSTATUS(...,5)
*      devolve .T. ate para PROTECTED - quem responde escopo e o atributo 2).
*      Os hooks FormParaBO/BOParaForm sao PROTEGIDOS POR HERANCA (FormBase os
*      declara assim) e NAO podem ser alargados - por isso sao exercitados
*      atraves da subclasse ProbeFormCim701 no fim deste arquivo, nunca
*      chamados do script solto.
*   3) o fim do Init legado (Historico posicionado, campo Barra limpo)
*   4) HabilitarCampos reproduz o When de Get_Produto
*   5) AjustarBotoesPorModo reproduz as 3 linhas repetidas do legado
*   6) FormParaBO / BOParaForm fazem a transferencia nos dois sentidos
*   7) CarregarLista repinta a grade E RECONSTROI o bind que o
*      DesvincularGrade derruba (ColumnCount/Width/Header/CurrentControl)
*
* SEM BANCO: a maquina do pipeline nao tem rota para 192.168.200.10, e
* ConfigurarAmbiente() nao retorna nesta maquina - por isso o carregamento
* manual abaixo e gnConnHandle = -1. As consultas do BO tem guarda
* TYPE("gnConnHandle") = "N" AND gnConnHandle > 0, entao nada vai a rede.
*
* SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DELETED ON
SET EXACT ON

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cim701.txt"

#DEFINE OUT "C:\4c\automation\probe_cim701_f8.txt"

LOCAL loc_oE, loc_oF, loc_oG, loc_oBO, lcRel, loc_nFalhas

STRTOFILE("=== PROBE Formsigopcim - Fase 8 (consolidacao) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gnConnHandle        = -1

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigopcimBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms   + "operacionais\Formsigopcim.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeCim701F8.prg"         ADDITIVE

    *============ 1) instancia nos DOIS modos do legado ======================
    STRTOFILE(CHR(13) + CHR(10) + "1) Instanciacao nos dois modos" + CHR(13) + CHR(10), OUT, 1)

    loc_oF = CREATEOBJECT("Formsigopcim", .T., .NULL.)
    DO Chk WITH "instancia em modo EXCLUSAO (par_lExcluir = .T.)", (VARTYPE(loc_oF) = "O")
    IF VARTYPE(loc_oF) = "O"
        STRTOFILE("   Caption = [" + ALLTRIM(loc_oF.Caption) + "]" + CHR(13) + CHR(10), OUT, 1)
        DO Chk WITH "Caption do modo exclusao", (ALLTRIM(loc_oF.Caption) == "Exclus" + CHR(227) + "o de Barras")
        DO Chk WITH "botao de excluir item VISIVEL em modo exclusao", loc_oF.cmd_4c_Excluiitem.Visible
        DO Chk WITH "Shape2 visivel / Shape3 oculto em modo exclusao", ;
            (loc_oF.shp_4c_Shape2.Visible AND NOT loc_oF.shp_4c_Shape3.Visible)
        loc_oF.Release()
    ENDIF

    *-- SUBCLASSE: alcanca os hooks protegidos por heranca (FormParaBO/
    *-- BOParaForm). Instanciar a subclasse tambem prova que o Init do form
    *-- migrado sobrevive a especializacao.
    loc_oF = CREATEOBJECT("ProbeFormCim701", .F., .NULL.)
    DO Chk WITH "instancia em modo CONSULTA (par_lExcluir = .F.)", (VARTYPE(loc_oF) = "O")
    IF VARTYPE(loc_oF) != "O"
        STRTOFILE("ABORTADO: CREATEOBJECT devolveu " + VARTYPE(loc_oF) + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF
    DO Chk WITH "Caption do modo consulta", (ALLTRIM(loc_oF.Caption) == "Consulta Imagem")
    DO Chk WITH "botao de excluir item OCULTO em modo consulta", (NOT loc_oF.cmd_4c_Excluiitem.Visible)
    DO Chk WITH "Shape3 visivel / Shape2 oculto em modo consulta", ;
        (loc_oF.shp_4c_Shape3.Visible AND NOT loc_oF.shp_4c_Shape2.Visible)

    loc_oBO = loc_oF.this_oBusinessObject
    loc_oG  = loc_oF.grd_4c_Dados

    *============ 2) escopo dos metodos (regra #3) ===========================
    STRTOFILE(CHR(13) + CHR(10) + "2) Escopo dos metodos (atributo 2 = Protected)" + CHR(13) + CHR(10), OUT, 1)

    *-- os tres que o harness PODE chamar de fora tem de ser publicos
    DO Esc WITH loc_oF, "CarregarLista",        .F.
    DO Esc WITH loc_oF, "HabilitarCampos",      .F.
    DO Esc WITH loc_oF, "AjustarBotoesPorModo", .F.

    *-- os dois hooks herdados de FormBase sao PROTEGIDOS e nao se alargam:
    *-- esperar publico aqui seria exigir o impossivel
    DO Esc WITH loc_oF, "FormParaBO", .T.
    DO Esc WITH loc_oF, "BOParaForm", .T.

    *-- medicao de referencia: PROTECTED declarado NA SUBCLASSE (nao herdado)
    DO Esc WITH loc_oF, "DesvincularGrade", .T.
    DO Esc WITH loc_oF, "MontaGrade",       .T.

    DO Chk WITH "a property do codigo de barras do BO e NUMERICA (this_nBarra)", ;
        (PEMSTATUS(loc_oBO, "this_nBarra", 5) AND VARTYPE(loc_oBO.this_nBarra) = "N")
    DO Chk WITH "a property char antiga do codigo de barras NAO existe mais", ;
        (NOT PEMSTATUS(loc_oBO, "this_cBarra", 5))
    DO Chk WITH "o BO tem o flag de falha de conexao", ;
        (PEMSTATUS(loc_oBO, "this_lFalhaConexao", 5) AND VARTYPE(loc_oBO.this_lFalhaConexao) = "L")

    *============ 3) fim do Init legado ======================================
    STRTOFILE(CHR(13) + CHR(10) + "3) Fim do Init legado" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   txt_4c_Barra.Value = [" + TRANSFORM(loc_oF.txt_4c_Barra.Value) + ;
        "]  tipo = " + VARTYPE(loc_oF.txt_4c_Barra.Value) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "campo Barra limpo e NUMERICO (0, nunca string vazia)", ;
        (VARTYPE(loc_oF.txt_4c_Barra.Value) = "N" AND loc_oF.txt_4c_Barra.Value = 0)
    DO Chk WITH "cursor de historico aberto e posicionado no topo", ;
        (USED("cursor_4c_Historico") AND RECNO("cursor_4c_Historico") <= 1)

    *============ 4) HabilitarCampos (When de Get_Produto) ==================
    STRTOFILE(CHR(13) + CHR(10) + "4) HabilitarCampos - When de Get_Produto" + CHR(13) + CHR(10), OUT, 1)
    loc_oF.txt_4c_Barra.Value = 0
    loc_oF.HabilitarCampos()
    DO Chk WITH "Barra vazio -> campo Produto HABILITADO", loc_oF.txt_4c_Produto.Enabled
    loc_oF.txt_4c_Barra.Value = 12345678901234
    loc_oF.HabilitarCampos()
    DO Chk WITH "Barra preenchido -> campo Produto DESABILITADO", (NOT loc_oF.txt_4c_Produto.Enabled)
    loc_oF.txt_4c_Barra.Value = 0
    loc_oF.HabilitarCampos()

    *============ 5) AjustarBotoesPorModo ===================================
    STRTOFILE(CHR(13) + CHR(10) + "5) AjustarBotoesPorModo" + CHR(13) + CHR(10), OUT, 1)
    loc_oF.cmd_4c_Excluiitem.Visible = .T.
    loc_oF.shp_4c_Shape2.Visible     = .T.
    loc_oF.shp_4c_Shape3.Visible     = .F.
    loc_oF.AjustarBotoesPorModo()
    DO Chk WITH "repoe as 3 visibilidades pelo modo (consulta)", ;
        ((NOT loc_oF.cmd_4c_Excluiitem.Visible) AND (NOT loc_oF.shp_4c_Shape2.Visible) AND loc_oF.shp_4c_Shape3.Visible)

    *============ 6) FormParaBO / BOParaForm ================================
    STRTOFILE(CHR(13) + CHR(10) + "6) Transferencia nos dois sentidos" + CHR(13) + CHR(10), OUT, 1)
    loc_oF.txt_4c_Barra.Value   = 98765432109876
    loc_oF.txt_4c_Produto.Value = "ABC123"
    DO Chk WITH "FormParaBO devolveu .T.", loc_oF.ProbeFormParaBO()
    STRTOFILE("   BO: this_nBarra = " + TRANSFORM(loc_oBO.this_nBarra) + ;
        "  this_cProduto = [" + ALLTRIM(loc_oBO.this_cProduto) + "]" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "FormParaBO levou a barra como NUMERO", (loc_oBO.this_nBarra = 98765432109876)
    DO Chk WITH "FormParaBO levou o produto", (ALLTRIM(loc_oBO.this_cProduto) == "ABC123")

    *-- o legado chega a atribuir "" ao campo Barra: a conversao tem de aguentar
    loc_oF.txt_4c_Barra.Value = ""
    DO Chk WITH "FormParaBO aguenta o campo Barra em CARACTERE (sem estourar)", loc_oF.ProbeFormParaBO()
    DO Chk WITH "   e converte para 0", (loc_oBO.this_nBarra = 0)
    loc_oF.txt_4c_Barra.Value = 0

    loc_oBO.this_cProduto   = "XYZ999        "
    loc_oBO.this_cDescricao = "PRODUTO DE TESTE"
    loc_oBO.this_nPeso      = 12.345
    loc_oBO.this_cLinha     = "LINHA DE TESTE"
    loc_oBO.this_mFigJpgs   = ""
    DO Chk WITH "BOParaForm devolveu .T.", loc_oF.ProbeBOParaForm()
    STRTOFILE("   tela: Produto=[" + ALLTRIM(TRANSFORM(loc_oF.txt_4c_Produto.Value)) + ;
        "]  Descricao=[" + ALLTRIM(TRANSFORM(loc_oF.txt_4c_Descricao.Value)) + ;
        "]  Peso=[" + ALLTRIM(TRANSFORM(loc_oF.txt_4c_Peso.Value)) + ;
        "]  Linha=[" + ALLTRIM(TRANSFORM(loc_oF.txt_4c_Linha.Value)) + "]" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "BOParaForm preencheu Produto",   (ALLTRIM(loc_oF.txt_4c_Produto.Value)   == "XYZ999")
    DO Chk WITH "BOParaForm preencheu Descricao", (ALLTRIM(loc_oF.txt_4c_Descricao.Value) == "PRODUTO DE TESTE")
    DO Chk WITH "BOParaForm preencheu Peso",      (loc_oF.txt_4c_Peso.Value = 12.345)
    DO Chk WITH "BOParaForm preencheu Linha",     (ALLTRIM(loc_oF.txt_4c_Linha.Value)     == "LINHA DE TESTE")
    DO Chk WITH "foto ausente deixa a imagem OCULTA", (NOT loc_oF.img_4c_ImgJpg.Visible)

    *============ 7) CarregarLista repinta E religa o bind ===================
    STRTOFILE(CHR(13) + CHR(10) + "7) CarregarLista - repintura e rebind" + CHR(13) + CHR(10), OUT, 1)
    INSERT INTO cursor_4c_InvH (cbars, cpros, localis, ocors, pesreals) ;
        VALUES (111, PADR("XYZ999", 14), "LOC1", "OC1", 1.5)
    INSERT INTO cursor_4c_InvH (cbars, cpros, localis, ocors, pesreals) ;
        VALUES (222, PADR("XYZ999", 14), "LOC2", "OC2", 2.5)
    DO Chk WITH "CarregarLista devolveu .T. com cursor aberto", loc_oF.CarregarLista()
    STRTOFILE("   RecordSource=[" + ALLTRIM(loc_oG.RecordSource) + "]  ColumnCount=" + ;
        TRANSFORM(loc_oG.ColumnCount) + "  RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_InvH")) + ;
        "  RECNO=" + TRANSFORM(RECNO("cursor_4c_InvH")) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "grade ligada ao cursor da grade", (UPPER(ALLTRIM(loc_oG.RecordSource)) == "CURSOR_4C_INVH")
    DO Chk WITH "as 2 linhas inseridas estao no cursor", (RECCOUNT("cursor_4c_InvH") = 2)
    DO Chk WITH "CarregarLista reposicionou no topo (GO TOP do legado)", (RECNO("cursor_4c_InvH") = 1)

    *-- Cenario do defeito (b): o legado faz "Grade.RecordSource = ''" antes de
    *-- reconstruir o cursor, e isso RESETA Width/Header/CurrentControl da
    *-- grade. Reproduzido aqui com a MESMA atribuicao que DesvincularGrade faz
    *-- (o metodo em si e PROTECTED, provado no item 2), para medir se
    *-- CarregarLista reconstroi tudo.
    loc_oG.RecordSource = ""
    STRTOFILE("   bind derrubado: RecordSource=[" + ALLTRIM(loc_oG.RecordSource) + ;
        "]  Col1.Width=" + TRANSFORM(loc_oG.Column1.Width) + ;
        "  Col4.CurrentControl=[" + ALLTRIM(loc_oG.Column4.CurrentControl) + "]" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "CarregarLista devolveu .T. no religamento", loc_oF.CarregarLista()
    STRTOFILE("   religado: RecordSource=[" + ALLTRIM(loc_oG.RecordSource) + ;
        "]  ColumnCount=" + TRANSFORM(loc_oG.ColumnCount) + ;
        "  Col1.Width=" + TRANSFORM(loc_oG.Column1.Width) + ;
        "  Col4.CurrentControl=[" + ALLTRIM(loc_oG.Column4.CurrentControl) + ;
        "]  Col4.Sparse=" + TRANSFORM(loc_oG.Column4.Sparse) + ;
        "  Col1.Header=[" + ALLTRIM(loc_oG.Column1.Header1.Caption) + "]" + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH "rebind: grade volta ao cursor",          (UPPER(ALLTRIM(loc_oG.RecordSource)) == "CURSOR_4C_INVH")
    DO Chk WITH "rebind: 5 colunas preservadas",          (loc_oG.ColumnCount = 5)
    DO Chk WITH "rebind: Width da coluna 1 reaplicado",   (loc_oG.Column1.Width = 108)
    DO Chk WITH "rebind: EditBox da Observacao rearmado", (UPPER(ALLTRIM(loc_oG.Column4.CurrentControl)) == "EDT_4C_OBS")
    DO Chk WITH "rebind: Sparse da Observacao em .F.",    (NOT loc_oG.Column4.Sparse)
    DO Chk WITH "rebind: cabecalho reaplicado",           (ALLTRIM(loc_oG.Column1.Header1.Caption) == "Barras")
    DO Chk WITH "rebind: ControlSource da coluna 1",      (UPPER(ALLTRIM(loc_oG.Column1.ControlSource)) == "CURSOR_4C_INVH.CBARS")
    DO Chk WITH "nenhuma linha perdida no religamento",   (RECCOUNT("cursor_4c_InvH") = 2)

    loc_oF.Release()
    DO Chk WITH "Release nao deixa o cursor da grade aberto", (NOT USED("cursor_4c_InvH"))

CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + "  (linha " + TRANSFORM(loc_oE.LineNo) + ;
        ", procedure " + loc_oE.Procedure + ")" + CHR(13) + CHR(10), OUT, 1)
ENDTRY

lcRel = FILETOSTR(OUT)
loc_nFalhas = OCCURS("[FALHA]", lcRel) + OCCURS("EXCECAO:", lcRel)
STRTOFILE(CHR(13) + CHR(10) + "PROBE_FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10), OUT, 1)
QUIT


PROCEDURE Chk(pcTitulo, plOk)
    STRTOFILE("   " + IIF(plOk, "[OK]   ", "[FALHA]") + " " + pcTitulo + CHR(13) + CHR(10), OUT, 1)
ENDPROC

*-- Atributo 2 do PEMSTATUS = Protected. O 5 (que o migrador costuma usar) so
*-- diz se o membro EXISTE, e devolve .T. ate para PROTECTED - foi assim que a
*-- regra #3/#51 nasceu.
*-- ATENCAO (medido no VFP9 nesta task, automation\MedirPemstatusProtected.prg):
*-- quando o membro E protegido, PEMSTATUS(obj, membro, 2) devolve um logico
*-- TRUTHY mas que NAO EH IGUAL a .T. -
*--   VARTYPE -> "L" | TRANSFORM -> ".T." | NOT -> .F. | IIF -> ramo verdadeiro
*--   mas  ( retorno = .T. ) -> .F.   e   ( retorno == .T. ) -> .F.
*-- (e compara-lo com 1 estoura e pendura o processo num dialogo modal).
*-- Por isso o escopo NUNCA se afere por comparacao: so por teste direto de
*-- verdade (IIF/IF) ou negacao (NOT). Foi este helper, na 1a versao, que
*-- reportou 4 FALHAS falsas em metodos corretos.
PROCEDURE Esc(poObj, pcMetodo, plEsperadoProtegido)
    LOCAL loc_lExiste, loc_lProt, loc_lOk
    loc_lExiste = IIF(PEMSTATUS(poObj, pcMetodo, 5), .T., .F.)
    loc_lProt   = IIF(loc_lExiste, IIF(PEMSTATUS(poObj, pcMetodo, 2), .T., .F.), .T.)

    *-- normalizados por IIF acima, os dois ja sao logicos CANONICOS - dai
    *-- em diante a comparacao e segura
    loc_lOk = (loc_lExiste AND (loc_lProt = IIF(plEsperadoProtegido, .T., .F.)))

    STRTOFILE("   " + PADR(pcMetodo, 24) + " existe=" + PADR(TRANSFORM(loc_lExiste), 3) + ;
        "  protected=" + PADR(TRANSFORM(loc_lProt), 3) + ;
        "  esperado=" + TRANSFORM(plEsperadoProtegido) + CHR(13) + CHR(10), OUT, 1)
    DO Chk WITH pcMetodo + " existe com o escopo esperado (" + ;
        IIF(plEsperadoProtegido, "protegido", "publico") + ")", loc_lOk
ENDPROC


*==============================================================================
* ProbeFormCim701 - subclasse so do harness. Os hooks FormParaBO/BOParaForm
* sao PROTEGIDOS por HERANCA (FormBase os declara assim) e a subclasse nao
* pode alargar o escopo; script solto nao os alcanca, subclasse alcanca. E o
* padrao registrado para exercitar hook protegido sem mentir sobre o escopo.
*==============================================================================
DEFINE CLASS ProbeFormCim701 AS Formsigopcim

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
