# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = ""
  ControlSource = ""
	Select MovAux
Insert Into Cabecalho (Empresa, Titulo, SubTit, Periodo) ;
lcQuery = [Select Codigos, ContConts ] + ;
		    [From SigCdGcr]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGcr') < 1)
Select crSigCdGcr
lcQuery = [Select Cemps ] + ;
		    [From SigCdEmp]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdEmp') < 1)
Select crSigCdEmp
lcQuery = [Select Emps, Grupos, Contas, Datas, Hists, Hist2s, Valors, Opers, Autos ] + ;
		    [From SigMvCcr ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCcr') < 1)
Select crSigMvCcr
	oProg.Update(.t.)
	=Seek(crSigMvCcr.Grupos, 'crSigCdGcr', 'Codigos')
	=Seek(crSigMvCcr.Emps,   'crSigCdEmp',  'Cemps')
	Select crSigMvCcr
			Select SemConta
			Select crSigMvCcr
	Select MovAux
Select ('semconta')
	Select MovAux
		lcQuery = [Select DirContabv ] + ;
				    [From SigCdPam]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrItb.prg) - TRECHOS RELEVANTES PARA PASS SQL (1391 linhas total):

*-- Linhas 141 a 159:
141:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrItbBO")
142: 
143:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
144:                 *-- Init legado aborta a tela se "Select DirContabv From
145:                 *-- SigCdPam" falhar (MessageBox + Return 0) - em validacao de
146:                 *-- UI/modo teste nao ha conexao SQL, e o form so monta a
147:                 *-- estrutura visual (mesmo padrao de FormSIGPRIMP.CarregarLista).
148:                 loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
149:                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
150: 
151:                 IF loc_lModoSemBanco OR THIS.this_oBusinessObject.CarregarParametros()
152:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
153: 
154:                     THIS.ConfigurarPageFrame()
155: 
156:                     THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
157:                     THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
158: 
159:                     THIS.TornarControlesVisiveis(THIS)

*-- Linhas 727 a 783:
727:     * padrao de Formsigatcrp.AbrirBuscaEmp/AbrirBuscaDemp (fAcessoEmpresa).
728:     * CREATEOBJECT sem parametros + mAddColuna/this_cCursorDestino manuais
729:     * (nao o Init com 9 parametros - regra #36): o cursor ja vem pronto desta
730:     * consulta, SEM re-executar outro SELECT dentro do picker.
731:     *==========================================================================
732:     PROCEDURE AbrirBuscaEmpresa(par_lPorDescricao)
733:         LOCAL loc_oCnt, loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo, ;
734:               loc_lProsseguir, loc_oErro
735: 
736:         loc_oCnt    = THIS.cnt_4c_Mvt1
737:         loc_cValor  = ALLTRIM(IIF(par_lPorDescricao, loc_oCnt.txt_4c_Dsemp1.Value, loc_oCnt.txt_4c_Emp1.Value))
738:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"
739: 
740:         IF USED("cursor_4c_BuscaEmp")
741:             USE IN cursor_4c_BuscaEmp
742:         ENDIF
743: 
744:         loc_lProsseguir = .T.
745:         TRY
746:             IF EMPTY(loc_cValor)
747:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY " + IIF(par_lPorDescricao, "Razas", "Cemps")
748:             ELSE
749:                 IF par_lPorDescricao
750:                     loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) LIKE " + ;
751:                         EscaparSQL(loc_cValor + "%") + " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
752:                         " ORDER BY Razas"
753:                 ELSE
754:                     loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps LIKE " + ;
755:                         EscaparSQL(loc_cValor + "%") + " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
756:                         " ORDER BY Cemps"
757:                 ENDIF
758:             ENDIF
759:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
760: 
761:             *-- Fallback: se o filtro nao trouxe nada, mostra a lista completa
762:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
763:                     AND !EMPTY(loc_cValor)
764:                 IF USED("cursor_4c_BuscaEmp")
765:                     USE IN cursor_4c_BuscaEmp
766:                 ENDIF
767:                 loc_nResult = SQLEXEC(gnConnHandle, ;
768:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY " + IIF(par_lPorDescricao, "Razas", "Cemps"), ;
769:                     "cursor_4c_BuscaEmp")
770:             ENDIF
771: 
772:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
773:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
774:                 loc_lProsseguir = .F.
775:             ENDIF
776: 
777:             IF loc_lProsseguir
778:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
779:                 IF VARTYPE(loc_oBusca) = "O"
780:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
781:                     loc_oBusca.this_cTitulo        = loc_cTitulo
782:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
783:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo

*-- Linhas 791 a 809:
791:                     loc_oBusca.Show()
792: 
793:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
794:                         SELECT cursor_4c_BuscaEmp
795:                         loc_oCnt.txt_4c_Emp1.Value   = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
796:                         loc_oCnt.txt_4c_Dsemp1.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
797:                     ENDIF
798:                     loc_oBusca.Release()
799:                 ENDIF
800:             ENDIF
801:         CATCH TO loc_oErro
802:             MsgErro(loc_oErro.Message, "Erro")
803:         ENDTRY
804: 
805:         IF USED("cursor_4c_BuscaEmp")
806:             USE IN cursor_4c_BuscaEmp
807:         ENDIF
808:         loc_oCnt.txt_4c_Emp1.Refresh
809:         loc_oCnt.txt_4c_Dsemp1.Refresh

*-- Linhas 1073 a 1119:
1073:     *   SemConta  - detalhe do relatorio (Contas/Datas/Hists/Valors/Ocors),
1074:     *               espelho ORDENADO de cursor_4c_SemConta (SigPrItbBO.
1075:     *               Processar ja populou). ORDER BY Contas, Datas reproduz o
1076:     *               "Select SemConta / Set Order to ('conta')" do legado - o
1077:     *               TAG Conta eh "Contas + Dtos(Datas)".
1078:     *   Cabecalho - titulo/periodo do cabecalho impresso. cursor_4c_Cabecalho
1079:     *               ja foi montado por SigPrItbBO.Processar() (via o metodo
1080:     *               PROTECTED MontarCabecalhoRelatorio - nunca chamado direto
1081:     *               de fora, regra #51); aqui so se copia o alias.
1082:     *==========================================================================
1083:     PROTECTED FUNCTION PrepararCursoresRelatorio()
1084:         IF !USED("cursor_4c_SemConta") OR RECCOUNT("cursor_4c_SemConta") = 0
1085:             MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia dispon" + CHR(237) + ;
1086:                 "vel para o relat" + CHR(243) + "rio.")
1087:             RETURN .F.
1088:         ENDIF
1089: 
1090:         IF USED("SemConta")
1091:             USE IN SemConta
1092:         ENDIF
1093:         SELECT * FROM cursor_4c_SemConta ORDER BY Contas, Datas ;
1094:             INTO CURSOR SemConta READWRITE
1095: 
1096:         IF USED("Cabecalho")
1097:             USE IN Cabecalho
1098:         ENDIF
1099:         IF USED("cursor_4c_Cabecalho")
1100:             SELECT * FROM cursor_4c_Cabecalho INTO CURSOR Cabecalho READWRITE
1101:         ELSE
1102:             *-- Defensivo: nao deveria ocorrer no fluxo normal (Processar() ja
1103:             *-- monta cursor_4c_Cabecalho antes de habilitar estes botoes)
1104:             CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
1105:         ENDIF
1106: 
1107:         RETURN .T.
1108:     ENDFUNC
1109: 
1110:     *==========================================================================
1111:     * ExecutarReportForm - helper canonico de REPORT FORM (CorretorAutomatico
1112:     * #117/#147): guard de existencia do FRX, guard de cursor vazio,
1113:     * isolamento de locale (POINT/SEPARATOR/REPORTBEHAVIOR 80 - FRX Fortyus
1114:     * com PICTURE americana) e restauracao do menu (REPORT FORM PREVIEW
1115:     * corrompe o cache visual do _MSYSMENU - Erro63).
1116:     * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER".
1117:     *==========================================================================
1118:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
1119:         LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig


### BO (C:\4c\projeto\app\classes\SigPrItbBO.prg):
*==============================================================================
* SIGPRITBBO.PRG
* Business Object do formulario SIGPRITB (Integracao Contabil Total)
* Responsabilidade: processar os lancamentos financeiros do periodo filtrado
* (SigMvCcr), classificar a conta contabil de cada lancamento (SigCdGcr /
* SigCdCli), detectar contas sem conta contabil cadastrada e gerar o arquivo
* texto de integracao contabil (um arquivo por empresa/data) no diretorio
* configurado em SigCdPam.DirContabv.
*
* SIGPRITB e um form OPERACIONAL de PROCESSAMENTO em lote, sem tabela
* mestre nem grid de cadastro - por isso this_cTabela e this_cCampoChave
* permanecem vazios (nao ha CRUD, nao ha chave primaria de registro).
*==============================================================================

DEFINE CLASS SigPrItbBO AS BusinessBase

    *-- Propriedades (espelham os controles/variaveis do form legado)
    this_dDataInicial       = {}    && Periodo inicial do filtro (cntMvt1.getData1.Value / IniPer)
    this_dDataFinal         = {}    && Periodo final do filtro (cntMvt1.getData2.Value / FinPer)
    this_cEmpresa           = ""    && Codigo da empresa filtrada, opcional (cntMvt1.getEmp1.Value / lcEmp1)
    this_cDescricaoEmpresa  = ""    && Razao social da empresa filtrada, somente exibicao (cntMvt1.getDsemp1.Value)
    this_cDiretorioContabil = ""    && Diretorio de geracao do arquivo contabil (crSigCdPam.DirContabv)
    this_nTotalRegistros    = 0     && Total de lancamentos processados no ultimo Processamento (Ncont)
    this_lTemInconsistencia = .F.   && .T. quando sobraram lancamentos sem conta contabil (cursor SemConta)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- SIGPRITB nao possui tabela mestre (form de processamento em lote)
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        DODEFAULT()

        *-- Valores padrao equivalentes ao Init do SCX legado
        THIS.this_dDataInicial = DATE()
        THIS.this_dDataFinal = DATE()
        THIS.this_cEmpresa = SPACE(3)
        THIS.this_cDescricaoEmpresa = SPACE(40)
        THIS.this_cDiretorioContabil = ""
        THIS.this_nTotalRegistros = 0
        THIS.this_lTemInconsistencia = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (SQLEXEC() troca a area selecionada ao criar o cursor de resultado).
    * Convencao adotada: sucesso quando o retorno do SQLEXEC nativo eh >= 0
    * (0 linhas tambem eh sucesso - periodo sem movimento NAO eh erro de
    * conexao, e e tratado depois por THIS.this_nTotalRegistros = 0).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - le o diretorio de geracao do arquivo contabil
    * (equivalente ao "Select DirContabv From SigCdPam" feito no Init do
    * SCX legado). SigCdPam nao tem filtro de empresa no legado - usa-se o
    * primeiro registro, igual ao original.
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF THIS.ExecutarSQL("SELECT DirContabv FROM SigCdPam", "cursor_4c_Pam", "SigCdPam")
            IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                THIS.CarregarDoCursor("cursor_4c_Pam")
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - transfere para as propriedades do BO as colunas
    * remotas que ele guarda, a partir de um cursor ja populado.
    *
    * PUBLIC (sem PROTECTED): a BusinessBase declara este metodo sem
    * modificador e o form chama de fora (regra #51 do CLAUDE.md).
    *
    * Atende os dois cursores que alimentam o BO, porque as colunas nao
    * colidem entre si e o teste de existencia eh feito coluna a coluna:
    *   - cursor de SigCdEmp (Cemps / Razas)   -> filtro de empresa da tela
    *     (equivalente ao "getEmp1.Value = crListaRemota.Cemps" e
    *      "getDsemp1.Value = crListaRemota.Razas" dos Valid do SCX legado)
    *   - cursor de SigCdPam (DirContabv)      -> diretorio de geracao
    *     (equivalente ao Select DirContabv do Init do SCX legado)
    *
    * Existencia de coluna conferida com TYPE(alias + "." + coluna) - NUNCA
    * PEMSTATUS, que exige OBJETO no 1o argumento e dispara erro 11 com
    * nome de cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAliasAnt, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAliasAnt = ALIAS()

        SELECT (par_cAliasCursor)
        IF RECCOUNT(par_cAliasCursor) > 0 AND EOF(par_cAliasCursor)
            GO TOP
        ENDIF

        IF !EOF(par_cAliasCursor)
            IF TYPE(par_cAliasCursor + ".Cemps") != "U"
                THIS.this_cEmpresa = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".Cemps"), ""))
                loc_lResultado = .T.
            ENDIF

            IF TYPE(par_cAliasCursor + ".Razas") != "U"
                THIS.this_cDescricaoEmpresa = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".Razas"), ""))
                loc_lResultado = .T.
            ENDIF

            IF TYPE(par_cAliasCursor + ".DirContabv") != "U"
                THIS.this_cDiretorioContabil = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".DirContabv"), ""))
                loc_lResultado = .T.
            ENDIF
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - resolve o filtro de empresa da tela por codigo
    * (Cemps) ou por razao social (Razas), com match EXATO.
    *
    * Equivale a primeira metade dos Valid de getEmp1/getDsemp1 do SCX
    * legado: achando UM registro, o par codigo/descricao eh preenchido e o
    * browse nao abre; nao achando, o form abre o picker (FormBuscaAuxiliar)
    * passando o valor digitado como prefixo - por isso aqui NAO se apaga o
    * valor digitado nem se exibe aviso de "nao encontrado" (regra #50).
    *
    * SigCdEmp: PK Cemps char(3), razao social Razas char(40) (schema.sql).
    *--------------------------------------------------------------------------
    FUNCTION CarregarEmpresa(par_cValor, par_lPorDescricao)
        LOCAL loc_lResultado, loc_cSQL, loc_cValor, loc_lPorDesc

        THIS.this_cMensagemErro = ""
        loc_lResultado = .F.

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
        loc_lPorDesc = (VARTYPE(par_lPorDescricao) = "L" AND par_lPorDescricao)

        IF EMPTY(loc_cValor)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE " + ;
            IIF(loc_lPorDesc, "RTRIM(Razas) = ", "RTRIM(Cemps) = ") + EscaparSQL(loc_cValor)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Emp", "SigCdEmp")
            IF USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") = 1
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Emp")
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificacao do lote processado (empresa +
    * periodo). SIGPRITB nao tem registro mestre; esta eh a unica chave que
    * identifica uma execucao, e eh o que a BusinessBase consome quando
    * RegistrarAuditoria() eh chamado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cEmp

        loc_cEmp = ALLTRIM(TratarNulo(THIS.this_cEmpresa, ""))
        IF EMPTY(loc_cEmp)
            loc_cEmp = "*"
        ENDIF

        RETURN loc_cEmp + "|" + DTOS(ConverterParaData(THIS.this_dDataInicial)) + ;
               "|" + DTOS(ConverterParaData(THIS.this_dDataFinal))
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalhoRelatorio - cria e popula cursor_4c_Cabecalho, o
    * cabecalho do "Relatorio de Integracao Contabil" (a lista de contas sem
    * conta contabil cadastrada). Transcrito do Create Cursor Cabecalho +
    * Insert Into Cabecalho do metodo "processamento" do SCX legado, que
    * busca a razao social da empresa corrente com
    * CursorQuery('SigCdEmp', 'crSigCdEmp', 'Cemps', _Empr).
    *
    * _Empr do legado = go_4c_Sistema.cCodEmpresa (a variavel legada _EMPR
    * nunca eh usada no sistema novo).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarCabecalhoRelatorio()
        LOCAL loc_lResultado, loc_cCodEmpresa, loc_cRazao, loc_cPeriodo

        loc_lResultado = .F.

        loc_cCodEmpresa = ""
        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            loc_cCodEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
        ENDIF

        loc_cRazao = ""
        IF !EMPTY(loc_cCodEmpresa)
            IF THIS.ExecutarSQL("SELECT Cemps, Razas FROM SigCdEmp WHERE RTRIM(Cemps) = " + ;
                    EscaparSQL(loc_cCodEmpresa), "cursor_4c_EmpCab", "SigCdEmp")
                IF USED("cursor_4c_EmpCab") AND RECCOUNT("cursor_4c_EmpCab") > 0
                    SELECT cursor_4c_EmpCab
                    GO TOP
                    loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_EmpCab.Razas, ""))
                ENDIF
                IF USED("cursor_4c_EmpCab")
                    USE IN cursor_4c_EmpCab
                ENDIF
                loc_lResultado = .T.
            ENDIF
        ELSE
            *-- Sem empresa corrente definida o legado tambem segue adiante
            *-- (o CursorQuery nao achando nada deixa crSigCdEmp.Razas vazio)
            loc_lResultado = .T.
        ENDIF

        IF loc_lResultado
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (Empresa C(80), Titulo C(80), ;
                SubTit C(80), Periodo C(80))

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                DTOC(ConverterParaData(THIS.this_dDataInicial)) + " " + CHR(224) + " " + ;
                DTOC(ConverterParaData(THIS.this_dDataFinal))

            INSERT INTO cursor_4c_Cabecalho (Empresa, Titulo, SubTit, Periodo) ;
                VALUES (loc_cCodEmpresa + " - " + loc_cRazao, ;
                        "Relat" + CHR(243) + "rio de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
                        "Contas Financeiras sem Conta Cont" + CHR(225) + "bil Cadastrada", ;
                        loc_cPeriodo)
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - valida o periodo informado antes de processar
    * (equivalente as checagens do Processar.Click do SCX legado).
    *--------------------------------------------------------------------------
    FUNCTION ValidarPeriodo()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_dDataInicial)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - classifica os lancamentos de SigMvCcr do periodo filtrado
    * (equivalente ao metodo "processamento" do SCX legado). Para cada
    * lancamento, define a conta contabil na ordem: conta do grupo de conta
    * corrente (SigCdGcr.ContConts) -> conta contabil do cliente
    * (SigCdCli.CContabs) -> a propria conta do lancamento (e nesse caso
    * entra em cursor_4c_SemConta, a lista de inconsistencias). Preenche
    * cursor_4c_MovAux (base do arquivo gerado por GerarArquivoContabil) e
    * as propriedades this_nTotalRegistros / this_lTemInconsistencia.
    *
    * EmpCont (cursor_4c_MovAux): no SCX legado este campo da cursor MovAux
    * nunca recebe valor dentro do Scan ("Scatter Memvar" em crSigMvCcr cria
    * m.Emps, nao m.EmpCont, e nenhuma linha do metodo atribui M.EmpCont) -
    * ficaria sempre em branco, o que faria a separacao "um arquivo por
    * empresa" (Gravar/GerarArquivoContabil, que agrupa por este campo)
    * degenerar num unico arquivo sem extensao para TODAS as empresas. Como
    * o proprio cursor (campo dedicado + indice EmpCont+Datas) e o metodo de
    * geracao do arquivo so fazem sentido com o agrupamento funcionando,
    * populamos aqui com o Emps do lancamento (crSigMvCcr.Emps) - e nao a
    * omissao do legado - para completar o mecanismo que a estrutura de
    * dados ja declarava.
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_cDataIniSQL, loc_cDataFimSQL, ;
              loc_nTotal, loc_cContabs, loc_nDebs, loc_nCreds, loc_cAnoFis, loc_cDatas, ;
              loc_cHistsRaw, loc_cHist2sRaw, loc_cHists, loc_cDocto, loc_dDataLan, loc_oErro

        THIS.this_cMensagemErro = ""
        THIS.this_nTotalRegistros = 0
        THIS.this_lTemInconsistencia = .F.
        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF !THIS.ValidarPeriodo()
            RETURN .F.
        ENDIF

        loc_lProsseguir = .T.

        TRY
            *-- Cursores de trabalho (recriados a cada chamada)
            IF USED("cursor_4c_MovAux")
                USE IN cursor_4c_MovAux
            ENDIF
            *-- Larguras TRANSCRITAS do Create Cursor do legado (Load /
            *-- processamento). Nao sao detalhe: GerarArquivoContabil grava
            *-- registro de largura FIXA (o "Copy To ... Type SDF" do legado),
            *-- entao cada caractere a mais desloca todas as colunas
            *-- seguintes do arquivo entregue a contabilidade.
            CREATE CURSOR cursor_4c_MovAux (AnoFis C(04), Datas C(08), Contas C(09), ;
                Debs C(12), Creds C(12), Docto C(10), Hists C(70), EmpCont C(03))
            INDEX ON EmpCont + Datas TAG EmpCont

            IF USED("cursor_4c_SemConta")
                USE IN cursor_4c_SemConta
            ENDIF
            *-- SEM "SET NULL ON": o legado declara estes campos NAO-nulaveis e
            *-- o cursor eh populado por APPEND BLANK + REPLACE com NVL(), nunca
            *-- por APPEND FROM de SQLEXEC. Nulavel, o APPEND BLANK deixaria
            *-- Datas = .NULL. e a chave do indice (DTOS(Datas)) sairia nula.
            CREATE CURSOR cursor_4c_SemConta (Contas C(09), Datas D, Hists C(70), ;
                Valors N(12,2), Ocors C(40))
            INDEX ON Contas + DTOS(Datas) TAG Conta

            *-- Cabecalho do relatorio de inconsistencias
            IF !THIS.MontarCabecalhoRelatorio()
                loc_lProsseguir = .F.
            ENDIF

            *-- Grupos de conta corrente (SigCdGcr) - preload + indice, igual ao legado
            IF loc_lProsseguir
                IF !THIS.ExecutarSQL("SELECT Codigos, ContConts FROM SigCdGcr", "cursor_4c_Gcr", "SigCdGcr")
                    loc_lProsseguir = .F.
                ELSE
                    SELECT cursor_4c_Gcr
                    INDEX ON Codigos TAG Codigos
                ENDIF
            ENDIF

            *-- Lancamentos financeiros do periodo, opcionalmente filtrados por empresa
            IF loc_lProsseguir
                loc_cDataIniSQL = LEFT(FormatarDataSQL(THIS.this_dDataInicial), ;
                    LEN(FormatarDataSQL(THIS.this_dDataInicial)) - 1) + " 00:00:00'"
                loc_cDataFimSQL = LEFT(FormatarDataSQL(THIS.this_dDataFinal), ;
                    LEN(FormatarDataSQL(THIS.this_dDataFinal)) - 1) + " 23:59:59'"

                loc_cSQL = "SELECT Emps, Grupos, Contas, Datas, Hists, Hist2s, Valors, Opers, Autos " + ;
                    "FROM SigMvCcr " + ;
                    "WHERE Datas BETWEEN " + loc_cDataIniSQL + " AND " + loc_cDataFimSQL
                IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                    loc_cSQL = loc_cSQL + " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
                ENDIF

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_MvCcr", "SigMvCcr")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nTotal = 0

                SELECT cursor_4c_MvCcr
                SCAN
                    loc_nTotal = loc_nTotal + 1

                    *-- Conta contabil do cliente do lancamento (SigCdCli) -
                    *-- consulta linha a linha, igual ao legado (CursorQuery por IClis)
                    THIS.ExecutarSQL("SELECT IClis, CContabs FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(ALLTRIM(cursor_4c_MvCcr.Contas)), "cursor_4c_Cli", "SigCdCli")

                    loc_cContabs = ""
                    IF SEEK(ALLTRIM(cursor_4c_MvCcr.Grupos), "cursor_4c_Gcr", "Codigos") AND ;
                            !EMPTY(ALLTRIM(NVL(cursor_4c_Gcr.ContConts, "")))
                        loc_cContabs = ALLTRIM(cursor_4c_Gcr.ContConts)
                    ELSE
                        IF USED("cursor_4c_Cli") AND RECCOUNT("cursor_4c_Cli") > 0 AND ;
                                !EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CContabs, "")))
                            loc_cContabs = ALLTRIM(cursor_4c_Cli.CContabs)
                        ELSE
                            loc_cContabs = ALLTRIM(cursor_4c_MvCcr.Contas)

                            SELECT cursor_4c_SemConta
                            APPEND BLANK
                            REPLACE Datas  WITH NVL(cursor_4c_MvCcr.Datas, {}), ;
                                    Contas WITH cursor_4c_MvCcr.Contas, ;
                                    Hists  WITH LEFT(TratarNulo(cursor_4c_MvCcr.Hists, "") + ;
                                        TratarNulo(cursor_4c_MvCcr.Hist2s, ""), 70), ;
                                    Valors WITH cursor_4c_MvCcr.Valors
                            THIS.this_lTemInconsistencia = .T.

                            SELECT cursor_4c_MvCcr
                        ENDIF
                    ENDIF

                    IF cursor_4c_MvCcr.Opers = "D"
                        loc_nDebs  = cursor_4c_MvCcr.Valors
                        loc_nCreds = 0
                    ELSE
                        loc_nDebs  = 0
                        loc_nCreds = cursor_4c_MvCcr.Valors
                    ENDIF

                    loc_dDataLan = ConverterParaData(cursor_4c_MvCcr.Datas)
                    loc_cAnoFis  = STR(YEAR(loc_dDataLan), 4)

                    *-- Legado: StrTran(Dtoc(...), "/", "") num campo c(08), ou
                    *-- seja DDMMAAAA - resultado que DEPENDE de SET DATE
                    *-- BRITISH + SET CENTURY ON. Montado aqui digito a digito
                    *-- para que o arquivo saia igual mesmo se os SETs estiverem
                    *-- em outro estado (DataSession=2 nasce em AMERICAN com
                    *-- CENTURY OFF - regra #9.4 - e Dtoc daria 6 caracteres,
                    *-- deslocando TODAS as colunas seguintes do arquivo).
                    IF EMPTY(loc_dDataLan)
                        loc_cDatas = SPACE(8)
                    ELSE
                        loc_cDatas = PADL(DAY(loc_dDataLan), 2, "0") + ;
                                     PADL(MONTH(loc_dDataLan), 2, "0") + ;
                                     PADL(YEAR(loc_dDataLan), 4, "0")
                    ENDIF

                    loc_cHistsRaw  = TratarNulo(cursor_4c_MvCcr.Hists, "")
                    loc_cHist2sRaw = TratarNulo(cursor_4c_MvCcr.Hist2s, "")

                    loc_cHists = LEFT(loc_cHistsRaw + loc_cHist2sRaw, 70)
                    loc_cHists = STRTRAN(loc_cHists, CHR(1), "")
                    loc_cHists = STRTRAN(loc_cHists, CHR(13), "")
                    loc_cHists = STRTRAN(loc_cHists, CHR(10), "")

                    *-- SigMvCcr.Autos eh coluna `bit`: chega ao VFP ora como
                    *-- Logico, ora como Numerico, conforme o driver ODBC.
                    *-- Comparar/conjugar direto com AND estoura
                    *-- "Data type mismatch" quando vem Numerico - por isso o
                    *-- ConverterParaLogico (regra #13).
                    IF ConverterParaLogico(cursor_4c_MvCcr.Autos) AND "LOTE" $ loc_cHistsRaw
                        loc_cDocto = TRANSFORM(VAL(RIGHT(ALLTRIM(loc_cHistsRaw), 6)), "@L 9999999999")
                    ELSE
                        loc_cDocto = TRANSFORM(loc_nTotal, "@L 999999")
                    ENDIF

                    SELECT cursor_4c_MovAux
                    APPEND BLANK
                    REPLACE AnoFis  WITH loc_cAnoFis, ;
                            Datas   WITH loc_cDatas, ;
                            Contas  WITH loc_cContabs, ;
                            Debs    WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                            Creds   WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                            Docto   WITH loc_cDocto, ;
                            Hists   WITH loc_cHists, ;
                            EmpCont WITH cursor_4c_MvCcr.Emps

                    SELECT cursor_4c_MvCcr
                ENDSCAN

                THIS.this_nTotalRegistros = loc_nTotal

                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
                IF USED("cursor_4c_MvCcr")
                    USE IN cursor_4c_MvCcr
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao processar integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarArquivoContabil - grava o arquivo texto de integracao contabil
    * (formato fixo, equivalente ao "Copy To ... Type SDF" do metodo
    * "gravar" do SCX legado), um arquivo por empresa (cursor_4c_MovAux.
    * EmpCont), nomeado "CT<sufixo unico>.<empresa>" dentro do diretorio
    * carregado por CarregarParametros(). Requer que Processar() tenha
    * rodado e populado cursor_4c_MovAux.
    *--------------------------------------------------------------------------
    FUNCTION GerarArquivoContabil()
        LOCAL loc_lResultado, loc_cDiretorio, loc_cEmpAnterior, loc_cNomeArquivo, loc_cLinha, ;
              loc_cConteudo, loc_nArquivosGerados, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lResultado = .F.

        IF !USED("cursor_4c_MovAux") OR RECCOUNT("cursor_4c_MovAux") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + "o no Per" + CHR(237) + "odo."
            RETURN .F.
        ENDIF

        loc_cDiretorio = ALLTRIM(TratarNulo(THIS.this_cDiretorioContabil, ""))
        IF EMPTY(loc_cDiretorio)
            THIS.this_cMensagemErro = "Diret" + CHR(243) + "rio de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + ;
                "bil n" + CHR(227) + "o configurado (SigCdPam.DirContabv)."
            RETURN .F.
        ENDIF
        loc_cDiretorio = ADDBS(loc_cDiretorio)

        TRY
            SELECT cursor_4c_MovAux
            SET ORDER TO TAG EmpCont
            GO TOP

            loc_nArquivosGerados = 0
            loc_cEmpAnterior = ""
            loc_cConteudo    = ""
            loc_cNomeArquivo = ""

            SCAN
                IF cursor_4c_MovAux.EmpCont != loc_cEmpAnterior
                    IF !EMPTY(loc_cConteudo) AND !EMPTY(loc_cNomeArquivo)
                        STRTOFILE(loc_cConteudo, loc_cNomeArquivo)
                        loc_nArquivosGerados = loc_nArquivosGerados + 1
                    ENDIF

                    loc_cEmpAnterior = cursor_4c_MovAux.EmpCont
                    loc_cNomeArquivo = loc_cDiretorio + "CT" + SUBSTR(SYS(3), 3) + "." + ALLTRIM(loc_cEmpAnterior)
                    loc_cConteudo    = ""
                ENDIF

                *-- Larguras IGUAIS as do CREATE CURSOR de Processar - eh o que
                *-- o "Copy To ... Type SDF" do legado produz.
                loc_cLinha = PADR(cursor_4c_MovAux.AnoFis, 4) + ;
                             PADR(cursor_4c_MovAux.Datas, 8) + ;
                             PADR(cursor_4c_MovAux.Contas, 9) + ;
                             PADR(cursor_4c_MovAux.Debs, 12) + ;
                             PADR(cursor_4c_MovAux.Creds, 12) + ;
                             PADR(cursor_4c_MovAux.Docto, 10) + ;
                             PADR(cursor_4c_MovAux.Hists, 70) + ;
                             PADR(cursor_4c_MovAux.EmpCont, 3)

                loc_cConteudo = loc_cConteudo + loc_cLinha + CHR(13) + CHR(10)
            ENDSCAN

            IF !EMPTY(loc_cConteudo) AND !EMPTY(loc_cNomeArquivo)
                STRTOFILE(loc_cConteudo, loc_cNomeArquivo)
                loc_nArquivosGerados = loc_nArquivosGerados + 1
            ENDIF

            IF loc_nArquivosGerados = 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o arquivo de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil."
                loc_lResultado = .F.
            ELSE
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

