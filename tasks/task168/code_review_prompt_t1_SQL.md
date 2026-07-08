# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CIDCHAVES, QTDELIDO, CBARS, CPROS, DTALTS, CODCORS, CODTAMS, CITENS, CONTAS, DTMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CIDCHAVES, QTDELIDO, CBARS, CPROS, DTALTS, CODCORS, CODTAMS, CITENS, CONTAS, DTMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CIDCHAVES, QTDELIDO, CBARS, CPROS, DTALTS, CODCORS, CODTAMS, CITENS, CONTAS, DTMOVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CIDCHAVES, QTDELIDO, CBARS, CPROS, DTALTS, CODCORS, CODTAMS, CITENS, CONTAS, DTMOVS

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
  DeleteMark = .F.
  Column1.ControlSource = "CodBarra"
  Column2.ControlSource = "CPros"
  Column3.ControlSource = "Dopes"
  Column4.ControlSource = "Numes"
  Column5.ControlSource = "QtdeLido"
Select TmpBaixa
Delete All
Select TmpEnc
Delete All For Empty(Dopps) Or Empty(Numps)
	Select crSigOpEtq
				Select crSigMvCab
						lcQuery = [Select cIdChaves, QtBaixas, Qtds ] + ;
								    [From SigMvItn ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEestI') < 1)
						Select LocalEestI
								lcQuery = [Update SigMvItn ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigMvItn 1)')
						lcQuery = [Select cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds ] + ;
								    [From SigMvIts ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEstI2') < 1)
						Select LocalEstI2
							lcQuery = [Select cIdChaves, QtBaixas, Qtds ] + ;
									    [From SigMvItn ] + ;
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEestI') < 1)
								lcQuery = [Update SigMvIts ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigMvIts 1)')
								lcQuery = [Update SigMvItn ] + ;
								If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
									=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigMvItn 3)')
				Insert Into TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, Nops, Grupods, Contads) ;
				Insert Into TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, Nops, Grupods, Contads) ;
Select TmpBaixa
	.Column1.ControlSource = 'TmpBaixa.CodBarra'
	.Column2.ControlSource = 'TmpBaixa.Cpros'
	.Column3.ControlSource = 'TmpBaixa.Dopes'
	.Column4.ControlSource = 'TmpBaixa.Numes'
	.Column5.ControlSource = 'TmpBaixa.QtdeLido'
Select TmpBaixa
	If Seek(This.Value)
		=Seek(This.Value)
Select xGrava
Select Distinct Grupods, Contads ;
  From TmpBaixa ;
Select xCabec
	Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, Contaos, ;
	Select TmpBaixa
		Insert Into crSigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, Opers, Grupos, Estos, ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, Opers, Grupos, Estos, ;
		lcQuery = [Update SigOpEtq ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpEtq') < 1)
Select Min(Datas) as Datas From CrSigMvCab Into Cursor TmpGdm
If Not ThisForm.poDataMgr.Update('crSigMvCab')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
	If Not ThisForm.poDataMgr.Update('crSigMvItn')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')
	If Not ThisForm.poDataMgr.Update('crSigMvHst')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
Select TmpBaixa

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1088 linhas total):

*-- Linhas 180 a 198:
180:         ENDIF
181: 
182:         SET NULL ON
183:         CREATE CURSOR cursor_4c_TmpBaixa ;
184:             (CodBarra C(20) NULL, ;
185:              CPros    C(14) NULL, ;
186:              Dopes    C(20) NULL, ;
187:              Numes    N(6,0) NULL, ;
188:              Qtde     N(12,3) NULL, ;
189:              QtdeLido N(12,3) NULL, ;
190:              Nops     N(6,0) NULL, ;
191:              Grupods  C(10) NULL, ;
192:              Contads  C(10) NULL)
193:         SET NULL OFF
194: 
195:         INDEX ON CodBarra           TAG CodBarra
196:         INDEX ON ALLTRIM(Grupods) + ALLTRIM(Contads) TAG GruConta
197:     ENDPROC
198: 

*-- Linhas 573 a 591:
573:                 .FontSize          = 8
574:                 .AllowHeaderSizing = .F.
575:                 .AllowRowSizing    = .F.
576:                 .DeleteMark        = .F.
577:                 .RecordMark        = .F.
578:                 .Height            = 336
579:                 .Left              = 12
580:                 .ReadOnly          = .T.
581:                 .RowHeight         = 17
582:                 .ScrollBars        = 2
583:                 .Top               = 98
584:                 .Width             = 940
585:                 .Panel             = 1
586:                 .Visible           = .F.
587: 
588:                 *-- Propriedades visuais das colunas
589:                 .Column1.Width = 135
590:                 .Column1.Movable = .F.
591:                 .Column1.Resizable = .F.

*-- Linhas 612 a 638:
612:                 .Column5.ReadOnly = .T.
613:                 .Column5.DynamicForeColor = "IIF(cursor_4c_TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
614: 
615:                 *-- RecordSource ANTES de ControlSource (cursor existe vazio apos CriarCursorTmpBaixa)
616:                 .RecordSource = "cursor_4c_TmpBaixa"
617: 
618:                 *-- ControlSource (apos RecordSource)
619:                 .Column1.ControlSource = "cursor_4c_TmpBaixa.CodBarra"
620:                 .Column2.ControlSource = "cursor_4c_TmpBaixa.CPros"
621:                 .Column3.ControlSource = "cursor_4c_TmpBaixa.Dopes"
622:                 .Column4.ControlSource = "cursor_4c_TmpBaixa.Numes"
623:                 .Column5.ControlSource = "cursor_4c_TmpBaixa.QtdeLido"
624: 
625:                 *-- Headers (reconfigurar apos RecordSource pois VFP9 os reseta)
626:                 .Column1.Header1.Caption   = "C" + CHR(243) + "d. Barra"
627:                 .Column1.Header1.FontName  = "Tahoma"
628:                 .Column1.Header1.FontSize  = 8
629:                 .Column1.Header1.Alignment = 2
630:                 .Column2.Header1.Caption   = "Produto"
631:                 .Column2.Header1.FontName  = "Tahoma"
632:                 .Column2.Header1.FontSize  = 8
633:                 .Column2.Header1.Alignment = 2
634:                 .Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
635:                 .Column3.Header1.FontName  = "Tahoma"
636:                 .Column3.Header1.FontSize  = 8
637:                 .Column3.Header1.Alignment = 2
638:                 .Column4.Header1.Caption   = "N" + CHR(250) + "mero"

*-- Linhas 677 a 695:
677:                 RETURN
678:             ENDIF
679: 
680:             SELECT cursor_4c_TmpBaixa
681:             GO TOP
682:             loc_lTemDados = !EOF()
683: 
684:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
685: 
686:             loc_oPagina.grd_4c_Dados.Visible                    = loc_lTemDados
687:             loc_oPagina.txt_4c_Leitura.Visible                   = loc_lTemDados
688:             loc_oPagina.lbl_4c_Txt_Leitura.Visible               = loc_lTemDados
689:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible          = loc_lTemDados
690:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
691: 
692:             IF loc_lTemDados
693:                 loc_oPagina.grd_4c_Dados.Refresh()
694:                 loc_oPagina.txt_4c_Leitura.SetFocus()
695:             ELSE

*-- Linhas 794 a 812:
794: 
795:                 *-- Posicionar cursor no registro lido para atualizar highlighting
796:                 IF USED("cursor_4c_TmpBaixa")
797:                     SELECT cursor_4c_TmpBaixa
798:                     SET ORDER TO TAG CodBarra
799:                     SEEK loc_cCodBarra
800:                 ENDIF
801:             ENDIF
802: 
803:             loc_oTxt.Value = 0
804:             loc_oGrd.Refresh()
805:             loc_oTxt.SetFocus()
806: 
807:         CATCH TO loc_oErro
808:             MsgErro(loc_oErro.Message, "Erro TxtLeituraKeyPress")
809:         ENDTRY
810:     ENDPROC
811: 
812:     *--------------------------------------------------------------------------

*-- Linhas 857 a 875:
857:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
858: 
859:             IF USED("cursor_4c_TmpBaixa")
860:                 SELECT cursor_4c_TmpBaixa
861:                 GO TOP
862:             ENDIF
863: 
864:             loc_oGrd.Refresh()
865:             loc_oGrd.SetFocus()
866:         CATCH TO loc_oErro
867:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
868:         ENDTRY
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * BtnExcluirClick - Limpa leituras da etiqueta corrente do grid
873:     * Form OPERACIONAL: "Excluir" = zerar QtdeLido do registro corrente
874:     *--------------------------------------------------------------------------
875:     PROCEDURE BtnExcluirClick()

*-- Linhas 881 a 899:
881:                 RETURN
882:             ENDIF
883: 
884:             SELECT cursor_4c_TmpBaixa
885: 
886:             IF EOF() OR BOF()
887:                 MsgAviso("Selecione uma etiqueta na grade para excluir a leitura.", "Aviso")
888:                 RETURN
889:             ENDIF
890: 
891:             IF NVL(cursor_4c_TmpBaixa.QtdeLido, 0) = 0
892:                 MsgAviso("Esta etiqueta ainda n" + CHR(227) + "o foi lida.", "Aviso")
893:                 RETURN
894:             ENDIF
895: 
896:             IF !MsgConfirma("Confirma limpar a leitura desta etiqueta?", "Confirmar")
897:                 RETURN
898:             ENDIF
899: 


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object para Conferencia e Reserva de Producao
* Herda de: BusinessBase
* Tabela principal: SigOpEtq (etiquetas de producao)
*==============================================================================

DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Chave e tabela principal
    this_cTabela      = "SigOpEtq"
    this_cCampoChave  = "CBars"

    *-- Data de referencia (Get_Data do form pai)
    this_dData        = {}

    *-- Chave unica da sessao (CrSigCdPac.SigKeys)
    this_cSigKey      = ""

    *-- Parametros vindos de crSigCdPam
    this_cDopeCit     = ""
    this_cDopTransf   = ""
    this_cGruConfs    = ""
    this_cConConfs    = ""
    this_cGruReservs  = ""
    this_cConReservs  = ""
    this_cGrupoEsts   = ""
    this_cContaEsts   = ""

    *-- Campos do cursor cursor_4c_TmpBaixa (linha corrente)
    this_cCodBarra    = ""
    this_cCPros       = ""
    this_cDopes       = ""
    this_nNumes       = 0
    this_nQtde        = 0
    this_nQtdeLido    = 0
    this_nNops        = 0
    this_cGrupods     = ""
    this_cContads     = ""

    *-- Estado interno
    this_lGradeVisivel = .F.
    this_nSeqContador  = 0

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            DODEFAULT()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades this_
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodBarra  = TratarNulo(CodBarra,  "C")
                THIS.this_cCPros     = TratarNulo(CPros,     "C")
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_nNumes     = TratarNulo(Numes,     "N")
                THIS.this_nQtde      = TratarNulo(Qtde,      "N")
                THIS.this_nQtdeLido  = TratarNulo(QtdeLido,  "N")
                THIS.this_nNops      = TratarNulo(Nops,      "N")
                THIS.this_cGrupods   = TratarNulo(Grupods,   "C")
                THIS.this_cContads   = TratarNulo(Contads,   "C")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBaixas - Carrega etiquetas de producao em cursor_4c_TmpBaixa
    * Equivalente ao legado carregabars.
    * Pre-requisito: cursor_4c_TmpEnc deve existir (Dopps C, Numps N)
    * cursor_4c_TmpBaixa deve existir com tags CodBarra e GruConta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBaixas()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL
        LOCAL loc_cDopps, loc_nNumps, loc_cChave
        LOCAL loc_cGruConfs, loc_cConConfs
        LOCAL loc_cGruReservs, loc_cConReservs
        LOCAL loc_cGrupoEsts, loc_cContaEsts, loc_cDopeCit
        LOCAL loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs
        LOCAL loc_nNops, loc_cEmpos, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtEti, loc_nQtCit, loc_nBaixa, loc_nPendente, loc_nPVal
        LOCAL loc_llBaixa, loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_nTipoEstos, loc_cEmpDopNumsCit

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                MsgErro("cursor_4c_TmpBaixa n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_TmpEnc")
                MsgErro("cursor_4c_TmpEnc n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Limpar TmpBaixa
            SELECT cursor_4c_TmpBaixa
            ZAP

            loc_cGruConfs   = ALLTRIM(THIS.this_cGruConfs)
            loc_cConConfs   = ALLTRIM(THIS.this_cConConfs)
            loc_cGruReservs = ALLTRIM(THIS.this_cGruReservs)
            loc_cConReservs = ALLTRIM(THIS.this_cConReservs)
            loc_cGrupoEsts  = ALLTRIM(THIS.this_cGrupoEsts)
            loc_cContaEsts  = ALLTRIM(THIS.this_cContaEsts)
            loc_cDopeCit    = ALLTRIM(THIS.this_cDopeCit)

            SELECT cursor_4c_TmpEnc
            GO TOP

            SCAN FOR !EMPTY(Dopps) AND !EMPTY(Numps)
                loc_cDopps = ALLTRIM(cursor_4c_TmpEnc.Dopps)
                loc_nNumps = cursor_4c_TmpEnc.Numps
                loc_cChave = go_4c_Sistema.cCodEmpresa + loc_cDopps + STR(loc_nNumps, 6)

                *-- Buscar etiquetas desta OS
                loc_cSQL = "SELECT e.CBars, e.CPros, e.DopeOs, e.NumeOs, e.Qtds, e.Nops, " + ;
                           "e.Empos, e.CodCors, e.CodTams, e.Grupos, e.Contas " + ;
                           "FROM SigOpEtq e " + ;
                           "WHERE e.EmpDopNums = " + EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpEtqBx") > 0
                    SELECT cursor_4c_SigOpEtqBx
                    SCAN
                        *-- Verificar se etiqueta pertence ao grupo/conta de conferencia
                        IF ALLTRIM(cursor_4c_SigOpEtqBx.Grupos) + ALLTRIM(cursor_4c_SigOpEtqBx.Contas) <> ;
                           loc_cGruConfs + loc_cConConfs
                            LOOP
                        ENDIF

                        loc_cCBars   = ALLTRIM(cursor_4c_SigOpEtqBx.CBars)
                        loc_cCPros   = ALLTRIM(cursor_4c_SigOpEtqBx.CPros)
                        loc_cDopeOs  = ALLTRIM(cursor_4c_SigOpEtqBx.DopeOs)
                        loc_nNumeOs  = cursor_4c_SigOpEtqBx.NumeOs
                        loc_nNops    = cursor_4c_SigOpEtqBx.Nops
                        loc_cEmpos   = ALLTRIM(cursor_4c_SigOpEtqBx.Empos)
                        loc_cCodCors = ALLTRIM(cursor_4c_SigOpEtqBx.CodCors)
                        loc_cCodTams = ALLTRIM(cursor_4c_SigOpEtqBx.CodTams)
                        loc_nQtEti   = cursor_4c_SigOpEtqBx.Qtds
                        loc_nQtCit   = 0

                        *-- Buscar movimento origem para determinar grupos/contas
                        loc_cSQL = "SELECT TOP 1 m.Dopes, m.Grupoos, m.Contaos, m.Grupods, m.Contads " + ;
                                   "FROM SigMvCab m " + ;
                                   "WHERE m.EmpDopNums = " + EscaparSQL(loc_cEmpos + loc_cDopeOs + STR(loc_nNumeOs, 6))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCabBx") > 0
                            SELECT cursor_4c_MvCabBx
                            IF !EOF()
                                *-- Verificar tipo de operacao (Globalizas/Servicos)
                                loc_cSQL = "SELECT TOP 1 Globalizas, Servicos FROM SigCdOpe " + ;
                                           "WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_MvCabBx.Dopes))

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeBx") > 0
                                    SELECT cursor_4c_SigCdOpeBx
                                    IF !EOF() AND (NVL(cursor_4c_SigCdOpeBx.Globalizas, 0) = 1 OR ;
                                                   NVL(cursor_4c_SigCdOpeBx.Servicos, 0) = 1)
                                        loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupoos)
                                        loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contaos)
                                    ELSE
                                        loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupods)
                                        loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contads)
                                    ENDIF
                                    IF USED("cursor_4c_SigCdOpeBx")
                                        USE IN cursor_4c_SigCdOpeBx
                                    ENDIF
                                ELSE
                                    loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupods)
                                    loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contads)
                                ENDIF

                                *-- Aplicar override de GruReservs/ConReservs
                                loc_cGrupo = IIF(EMPTY(loc_cGruReservs), loc_cTGrupo, loc_cGruReservs)
                                loc_cConta = IIF(EMPTY(loc_cConReservs), loc_cTConta, loc_cConReservs)

                                *-- Verificar tipo de estoque pelo grupo do produto
                                loc_nTipoEstos = 1
                                loc_cSQL = "SELECT p.CGrus FROM SigCdPro p WHERE p.CPros = " + EscaparSQL(loc_cCPros)
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdProBx") > 0
                                    SELECT cursor_4c_SigCdProBx
                                    IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_SigCdProBx.CGrus))
                                        loc_cSQL = "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + ;
                                                   EscaparSQL(ALLTRIM(cursor_4c_SigCdProBx.CGrus))
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdGrpBx") > 0
                                            SELECT cursor_4c_SigCdGrpBx
                                            IF !EOF()
                                                loc_nTipoEstos = NVL(cursor_4c_SigCdGrpBx.TipoEstos, 1)
                                                IF !INLIST(loc_nTipoEstos, 2, 3, 4)
                                                    loc_nTipoEstos = 1
                                                ENDIF
                                            ENDIF
                                            IF USED("cursor_4c_SigCdGrpBx")
                                                USE IN cursor_4c_SigCdGrpBx
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                    IF USED("cursor_4c_SigCdProBx")
                                        USE IN cursor_4c_SigCdProBx
                                    ENDIF
                                ENDIF

                                *-- Override grupo/conta pelo cliente destino
                                loc_cSQL = "SELECT GruProds, ConProds FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cTConta)
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdCliBx") > 0
                                    SELECT cursor_4c_SigCdCliBx
                                    IF !EOF()
                                        IF !EMPTY(ALLTRIM(cursor_4c_SigCdCliBx.GruProds))
                                            loc_cGrupo = ALLTRIM(cursor_4c_SigCdCliBx.GruProds)
                                        ENDIF
                                        IF !EMPTY(ALLTRIM(cursor_4c_SigCdCliBx.ConProds))
                                            loc_cConta = ALLTRIM(cursor_4c_SigCdCliBx.ConProds)
                                        ENDIF
                                    ENDIF
                                    IF USED("cursor_4c_SigCdCliBx")
                                        USE IN cursor_4c_SigCdCliBx
                                    ENDIF
                                ENDIF

                                *-- Processar operacao de citacao (DopeCit) se configurada
                                IF !EMPTY(loc_cDopeCit)
                                    loc_cEmpDopNumsCit = loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)
                                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvCab " + ;
                                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCit") > 0
                                        SELECT cursor_4c_ChkCit
                                        IF !EOF() AND NVL(cursor_4c_ChkCit.nExiste, 0) > 0
                                            loc_nBaixa = loc_nQtEti

                                            IF loc_nTipoEstos = 1
                                                *-- Baixar SigMvItn (itens simples por produto)
                                                loc_cSQL = "SELECT cIdChaves, QtBaixas, Qtds " + ;
                                                           "FROM SigMvItn " + ;
                                                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit) + ;
                                                           " AND CPros = " + EscaparSQL(loc_cCPros)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnCit") > 0
                                                    SELECT cursor_4c_ItnCit
                                                    GO TOP
                                                    SCAN WHILE !EOF("cursor_4c_ItnCit") AND loc_nBaixa > 0
                                                        IF (cursor_4c_ItnCit.Qtds - cursor_4c_ItnCit.QtBaixas) <> 0
                                                            loc_nPendente = cursor_4c_ItnCit.Qtds - cursor_4c_ItnCit.QtBaixas
                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nPVal  = loc_nBaixa
                                                                loc_nBaixa = 0
                                                            ELSE
                                                                loc_nPVal  = loc_nPendente
                                                                loc_nBaixa = loc_nBaixa - loc_nPendente
                                                            ENDIF
                                                            loc_llBaixa = IIF(cursor_4c_ItnCit.QtBaixas + loc_nPVal = cursor_4c_ItnCit.Qtds, 1, 0)
                                                            loc_cSQL = "UPDATE SigMvItn " + ;
                                                                       "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                       "ChkSubn = " + TRANSFORM(loc_llBaixa) + ", " + ;
                                                                       "DtAlts = GETDATE() " + ;
                                                                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItnCit.cIdChaves))
                                                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdItn")
                                                            IF USED("cursor_4c_UpdItn")
                                                                USE IN cursor_4c_UpdItn
                                                            ENDIF
                                                        ENDIF
                                                        SELECT cursor_4c_ItnCit
                                                    ENDSCAN
                                                    IF USED("cursor_4c_ItnCit")
                                                        USE IN cursor_4c_ItnCit
                                                    ENDIF
                                                ENDIF
                                            ELSE
                                                *-- Baixar SigMvIts (itens com cor/tamanho)
                                                loc_cSQL = "SELECT cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds " + ;
                                                           "FROM SigMvIts " + ;
                                                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit) + ;
                                                           " AND CPros = " + EscaparSQL(loc_cCPros) + ;
                                                           " AND CodCors = " + EscaparSQL(loc_cCodCors) + ;
                                                           " AND CodTams = " + EscaparSQL(loc_cCodTams)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItsCit") > 0
                                                    SELECT cursor_4c_ItsCit
                                                    SCAN WHILE !EOF("cursor_4c_ItsCit") AND loc_nBaixa > 0
                                                        loc_nPendente = cursor_4c_ItsCit.Qtds - cursor_4c_ItsCit.QtBaixas
                                                        IF loc_nPendente <> 0
                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nPVal = loc_nBaixa
                                                            ELSE
                                                                loc_nPVal = loc_nPendente
                                                            ENDIF
                                                            loc_llBaixa = IIF(cursor_4c_ItsCit.QtBaixas + loc_nPVal = cursor_4c_ItsCit.Qtds, 1, 0)

                                                            loc_cSQL = "UPDATE SigMvIts " + ;
                                                                       "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                       "ChkSubn = " + TRANSFORM(loc_llBaixa) + " " + ;
                                                                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItsCit.cIdChaves))
                                                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdIts")
                                                            IF USED("cursor_4c_UpdIts")
                                                                USE IN cursor_4c_UpdIts
                                                            ENDIF

                                                            *-- Atualizar SigMvItn correspondente ao item
                                                            loc_cSQL = "SELECT cIdChaves FROM SigMvItn " + ;
                                                                       "WHERE EmpDopNums = " + EscaparSQL(ALLTRIM(cursor_4c_ItsCit.EmpDopNums)) + ;
                                                                       " AND CItens = " + TRANSFORM(cursor_4c_ItsCit.CItens)
                                                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnCorr") > 0
                                                                SELECT cursor_4c_ItnCorr
                                                                IF !EOF()
                                                                    loc_cSQL = "UPDATE SigMvItn " + ;
                                                                               "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                               "DtAlts = GETDATE() " + ;
                                                                               "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItnCorr.cIdChaves))
                                                                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdItnC")
                                                                    IF USED("cursor_4c_UpdItnC")
                                                                        USE IN cursor_4c_UpdItnC
                                                                    ENDIF
                                                                ENDIF
                                                                IF USED("cursor_4c_ItnCorr")
                                                                    USE IN cursor_4c_ItnCorr
                                                                ENDIF
                                                            ENDIF

                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nBaixa = 0
                                                            ELSE
                                                                loc_nBaixa = loc_nBaixa - loc_nPendente
                                                            ENDIF
                                                        ENDIF
                                                        SELECT cursor_4c_ItsCit
                                                    ENDSCAN
                                                    IF USED("cursor_4c_ItsCit")
                                                        USE IN cursor_4c_ItsCit
                                                    ENDIF
                                                ENDIF
                                            ENDIF

                                            loc_nQtCit = loc_nQtEti - loc_nBaixa
                                        ENDIF
                                        IF USED("cursor_4c_ChkCit")
                                            USE IN cursor_4c_ChkCit
                                        ENDIF
                                    ENDIF
                                ENDIF

                                *-- Calcular quantidade que vai para TmpBaixa
                                loc_nQtEti = cursor_4c_SigOpEtqBx.Qtds - loc_nQtCit

                                *-- Inserir na TmpBaixa (quantidade principal -> grupo/conta destino)
                                IF loc_nQtEti <> 0
                                    INSERT INTO cursor_4c_TmpBaixa ;
                                        (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                        VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                                loc_nQtEti, 0, loc_nNops, loc_cGrupo, loc_cConta)
                                ENDIF

                                *-- Inserir na TmpBaixa (quantidade citacao -> grupo/conta estoque)
                                IF loc_nQtCit <> 0
                                    INSERT INTO cursor_4c_TmpBaixa ;
                                        (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                        VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                                loc_nQtCit, 0, loc_nNops, loc_cGrupoEsts, loc_cContaEsts)
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_MvCabBx")
                                USE IN cursor_4c_MvCabBx
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpEtqBx
                    ENDSCAN

                    IF USED("cursor_4c_SigOpEtqBx")
                        USE IN cursor_4c_SigOpEtqBx
                    ENDIF
                ENDIF

                SELECT cursor_4c_TmpEnc
            ENDSCAN

            *-- Posicionar no inicio da TmpBaixa
            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLeitura - Marca codigo de barras como lido na cursor_4c_TmpBaixa
    * Equivalente ao legado Get_Leitura.Valid
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLeitura(par_cCodBarra)
        LOCAL loc_lSucesso, loc_oErro, loc_cCodBarra

        loc_lSucesso = .F.
        loc_cCodBarra = ALLTRIM(par_cCodBarra)

        TRY
            IF EMPTY(loc_cCodBarra) OR !USED("cursor_4c_TmpBaixa")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_TmpBaixa
            SET ORDER TO TAG CodBarra

            IF SEEK(loc_cCodBarra)
                IF cursor_4c_TmpBaixa.QtdeLido = 0
                    REPLACE QtdeLido WITH cursor_4c_TmpBaixa.Qtde IN cursor_4c_TmpBaixa
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + " Foi Lido!!!", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + "o Cadastrado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLidas - Marca todas etiquetas como lidas (Conferencia Auto)
    * Equivalente ao legado Conferencia.Click
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLidas()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                SET ORDER TO TAG CodBarra
                REPLACE ALL QtdeLido WITH Qtde IN cursor_4c_TmpBaixa
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarConferencia - Processa confirmacao da conferencia (equivalente Ok.Click)
    * Cria SigMvCab + SigMvItn + SigMvHst e atualiza SigOpEtq para cada item lido
    * Pre-requisito: this_cDopTransf, this_cGruConfs, this_cConConfs, this_cSigKey devem estar setados
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarConferencia()
        LOCAL loc_lSucesso, loc_oErro, loc_llTaOk
        LOCAL loc_cSQL, loc_nNume, loc_cDopTransf
        LOCAL loc_cGruConfs, loc_cConConfs
        LOCAL loc_nItem, loc_cPCidC, loc_nPSeq
        LOCAL loc_cGrupods, loc_cContads, loc_cEmpDopNums
        LOCAL loc_cCPros, loc_cCodBarra, loc_nQtdeLido
        LOCAL loc_cDPros, loc_cCUnis
        LOCAL loc_cEmposItm, loc_cCodCors2, loc_cCodTams2

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                MsgErro("cursor_4c_TmpBaixa n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cDopTransf = ALLTRIM(THIS.this_cDopTransf)
            loc_cGruConfs  = ALLTRIM(THIS.this_cGruConfs)
            loc_cConConfs  = ALLTRIM(THIS.this_cConConfs)

            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trans")
            IF USED("cursor_4c_Trans")
                USE IN cursor_4c_Trans
            ENDIF

            loc_llTaOk = .T.

            *-- Obter grupos/contas distintos com itens lidos
            SELECT DISTINCT Grupods, Contads FROM cursor_4c_TmpBaixa ;
                WHERE QtdeLido <> 0 ;
                INTO CURSOR cursor_4c_xCabec READWRITE

            SELECT cursor_4c_xCabec
            GO TOP

            SCAN WHILE !EOF("cursor_4c_xCabec") AND loc_llTaOk
                loc_cGrupods = ALLTRIM(cursor_4c_xCabec.Grupods)
                loc_cContads = ALLTRIM(cursor_4c_xCabec.Contads)

                *-- Gerar numero unico do movimento
                loc_nNume      = THIS.GerarChaveUnica(go_4c_Sistema.cCodEmpresa + loc_cDopTransf)
                loc_cEmpDopNums = go_4c_Sistema.cCodEmpresa + loc_cDopTransf + STR(loc_nNume, 6)

                *-- Inserir cabecalho SigMvCab
                loc_cSQL = "INSERT INTO SigMvCab " + ;
                           "(Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                           "Grupoos, Contaos, Grupods, Contads, EmpDopNums, cIdChaves, DtAlts, EmpGopNums) " + ;
                           "VALUES (" + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                           EscaparSQL(loc_cDopTransf) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           EscaparSQL(THIS.GerarMascara(loc_nNume)) + ", " + ;
                           "GETDATE(), GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(loc_cGruConfs) + ", " + ;
                           EscaparSQL(loc_cConConfs) + ", " + ;
                           EscaparSQL(loc_cGrupods) + ", " + ;
                           EscaparSQL(loc_cContads) + ", " + ;
                           EscaparSQL(loc_cEmpDopNums) + ", " + ;
                           EscaparSQL(THIS.GerarIdUnico()) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa + SPACE(20) + STR(0, 6)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResCab") < 1
                    MsgErro("Falha ao inserir SigMvCab!", "Erro")
                    loc_llTaOk = .F.
                    EXIT
                ENDIF
                IF USED("cursor_4c_ResCab")
                    USE IN cursor_4c_ResCab
                ENDIF

                *-- Iterar itens deste grupo/conta
                loc_nItem = 0
                SELECT cursor_4c_TmpBaixa
                SET ORDER TO TAG GruConta
                SEEK loc_cGrupods + loc_cContads

                SCAN WHILE ALLTRIM(Grupods) + ALLTRIM(Contads) = loc_cGrupods + loc_cContads ;
                      FOR QtdeLido <> 0

                    loc_nItem     = loc_nItem + 1
                    loc_cCPros    = ALLTRIM(cursor_4c_TmpBaixa.CPros)
                    loc_cCodBarra = ALLTRIM(cursor_4c_TmpBaixa.CodBarra)
                    loc_nQtdeLido = cursor_4c_TmpBaixa.QtdeLido

                    *-- Buscar dados do produto (descricao e unidade)
                    loc_cDPros = ""
                    loc_cCUnis = ""
                    loc_cSQL = "SELECT DPros, CUnis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProItm") > 0
                        SELECT cursor_4c_ProItm
                        IF !EOF()
                            loc_cDPros = ALLTRIM(DPros)
                            loc_cCUnis = ALLTRIM(CUnis)
                        ENDIF
                        IF USED("cursor_4c_ProItm")
                            USE IN cursor_4c_ProItm
                        ENDIF
                    ENDIF

                    *-- Buscar dados da etiqueta (cor, tamanho, empresa origem)
                    loc_cCodCors2 = ""
                    loc_cCodTams2 = ""
                    loc_cEmposItm = go_4c_Sistema.cCodEmpresa
                    loc_cSQL = "SELECT CodCors, CodTams, Empos FROM SigOpEtq WHERE CBars = " + EscaparSQL(loc_cCodBarra)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtqItm") > 0
                        SELECT cursor_4c_EtqItm
                        IF !EOF()
                            loc_cCodCors2 = ALLTRIM(CodCors)
                            loc_cCodTams2 = ALLTRIM(CodTams)
                            loc_cEmposItm = ALLTRIM(Empos)
                        ENDIF
                        IF USED("cursor_4c_EtqItm")
                            USE IN cursor_4c_EtqItm
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_TmpBaixa

                    *-- Inserir item SigMvItn
                    loc_cSQL = "INSERT INTO SigMvItn " + ;
                               "(CItens, Emps, Dopes, Numes, CPros, Qtds, CUnis, DPros, Opers, " + ;
                               "CodBarras, EmpDopNums, cIdChaves, DtAlts) " + ;
                               "VALUES (" + ;
                               TRANSFORM(loc_nItem) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               EscaparSQL(loc_cCUnis) + ", " + ;
                               EscaparSQL(loc_cDPros) + ", " + ;
                               "'S', " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               EscaparSQL(THIS.GerarIdUnico()) + ", " + ;
                               "GETDATE())"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResItn") < 1
                        MsgErro("Falha ao inserir SigMvItn!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResItn")
                        USE IN cursor_4c_ResItn
                    ENDIF

                    *-- Historico de saida do grupo conferencia (S)
                    loc_cPCidC = DTOS(DATE()) + "S" + ;
                                 TRANSFORM(THIS.GerarChaveUnica(DTOS(DATE())), "@L 999999") + ;
                                 ALLTRIM(THIS.this_cSigKey)
                    loc_nPSeq = THIS.GerarChaveUnica("HISTBAR")

                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, CPros, Qtds, Opers, " + ;
                               "Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, " + ;
                               "EmpGruEsts, OriDopNums, Seqs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "GETDATE(), GETDATE(), " + ;
                               EscaparSQL(loc_cEmposItm) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               "'S', " + ;
                               EscaparSQL(loc_cGruConfs) + ", " + ;
                               EscaparSQL(loc_cConConfs) + ", " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cCodCors2) + ", " + ;
                               EscaparSQL(loc_cCodTams2) + ", " + ;
                               EscaparSQL(loc_cPCidC) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cDopTransf + STR(loc_nNume, 6)) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cGruConfs + loc_cConConfs) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               FormatarNumeroSQL(loc_nPSeq) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResHstS") < 1
                        MsgErro("Falha ao inserir SigMvHst (S)!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResHstS")
                        USE IN cursor_4c_ResHstS
                    ENDIF

                    THIS.RecalcularPositivo(loc_cEmposItm, loc_cGruConfs, loc_cConConfs, ;
                                            loc_cCPros, loc_cCodCors2, loc_cCodTams2)
                    THIS.RecalcularCusto(loc_cEmposItm, loc_cCPros)

                    *-- Historico de entrada no grupo destino (E)
                    loc_cPCidC = DTOS(DATE()) + "E" + ;
                                 TRANSFORM(THIS.GerarChaveUnica(DTOS(DATE())), "@L 999999") + ;
                                 ALLTRIM(THIS.this_cSigKey)
                    loc_nPSeq = THIS.GerarChaveUnica("HISTBAR")

                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, CPros, Qtds, Opers, " + ;
                               "Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, " + ;
                               "EmpGruEsts, OriDopNums, Seqs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "GETDATE(), GETDATE(), " + ;
                               EscaparSQL(loc_cEmposItm) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               "'E', " + ;
                               EscaparSQL(loc_cGrupods) + ", " + ;
                               EscaparSQL(loc_cContads) + ", " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cCodCors2) + ", " + ;
                               EscaparSQL(loc_cCodTams2) + ", " + ;
                               EscaparSQL(loc_cPCidC) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cDopTransf + STR(loc_nNume, 6)) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cGrupods + loc_cContads) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               FormatarNumeroSQL(loc_nPSeq) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResHstE") < 1
                        MsgErro("Falha ao inserir SigMvHst (E)!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResHstE")
                        USE IN cursor_4c_ResHstE
                    ENDIF

                    THIS.RecalcularPositivo(loc_cEmposItm, loc_cGrupods, loc_cContads, ;
                                            loc_cCPros, loc_cCodCors2, loc_cCodTams2)
                    THIS.RecalcularCusto(loc_cEmposItm, loc_cCPros)

                    *-- Atualizar SigOpEtq com grupo/conta destino
                    loc_cSQL = "UPDATE SigOpEtq " + ;
                               "SET Grupos = " + EscaparSQL(loc_cGrupods) + ", " + ;
                               "Contas = " + EscaparSQL(loc_cContads) + ", " + ;
                               "DtMovs = GETDATE() " + ;
                               "WHERE CBars = " + EscaparSQL(loc_cCodBarra)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResEtq") < 1
                        MsgErro("Falha ao atualizar SigOpEtq!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResEtq")
                        USE IN cursor_4c_ResEtq
                    ENDIF

                    SELECT cursor_4c_TmpBaixa
                ENDSCAN

                IF !loc_llTaOk
                    EXIT
                ENDIF

                SELECT cursor_4c_xCabec
            ENDSCAN

            IF USED("cursor_4c_xCabec")
                USE IN cursor_4c_xCabec
            ENDIF

            *-- Confirmar ou reverter transacao
            IF loc_llTaOk
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_TransR")
                IF USED("cursor_4c_TransR")
                    USE IN cursor_4c_TransR
                ENDIF
                THIS.RegistrarAuditoria("CONFERENCIA")
                loc_lSucesso = .T.
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_TransR")
                IF USED("cursor_4c_TransR")
                    USE IN cursor_4c_TransR
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_TransR")
            IF USED("cursor_4c_TransR")
                USE IN cursor_4c_TransR
            ENDIF
            IF USED("cursor_4c_xCabec")
                USE IN cursor_4c_xCabec
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Processa a conferencia das etiquetas (wrapper)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarConferencia()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Registra leitura de codigo de barras (wrapper)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_cCodBarra)
        LOCAL loc_cCodBarra
        loc_cCodBarra = IIF(PCOUNT() > 0, par_cCodBarra, THIS.this_cCodBarra)
        RETURN THIS.RegistrarLeitura(loc_cCodBarra)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodBarra)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Audit")
            IF USED("cursor_4c_Audit")
                USE IN cursor_4c_Audit
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear operacao principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera numero sequencial unico por prefixo
    * Prefixo de movimento (Emps+Dopes, >8 chars): usa MAX(Numes)+1 de SigMvCab
    * Prefixo curto (data YYYYMMDD ou HISTBAR): usa contador interno this_nSeqContador
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarChaveUnica(par_cPrefixo)
        LOCAL loc_nChave, loc_cSQL, loc_cPref, loc_oErro

        loc_nChave = 1
        loc_cPref  = ALLTRIM(par_cPrefixo)

        TRY
            IF LEN(loc_cPref) > 8
                *-- Prefixo de movimento: Emps + Dopes
                loc_cSQL = "SELECT ISNULL(MAX(Numes), 0) + 1 AS Proximo " + ;
                           "FROM SigMvCab " + ;
                           "WHERE Emps + Dopes = " + EscaparSQL(loc_cPref)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqMv") > 0
                    SELECT cursor_4c_SeqMv
                    IF !EOF()
                        loc_nChave = NVL(cursor_4c_SeqMv.Proximo, 1)
                    ENDIF
                    IF USED("cursor_4c_SeqMv")
                        USE IN cursor_4c_SeqMv
                    ENDIF
                ENDIF
            ELSE
                *-- Prefixo curto (data ou HISTBAR): contador interno da sessao
                THIS.this_nSeqContador = THIS.this_nSeqContador + 1
                loc_nChave = THIS.this_nSeqContador
            ENDIF

        CATCH TO loc_oErro
            THIS.this_nSeqContador = THIS.this_nSeqContador + 1
            loc_nChave = THIS.this_nSeqContador
        ENDTRY

        RETURN loc_nChave
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarIdUnico - Gera string ID unico para cIdChaves
    * Equivalente ao legado fUniqueIds()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarIdUnico()
        THIS.this_nSeqContador = THIS.this_nSeqContador + 1
        RETURN SYS(2015) + TRANSFORM(THIS.this_nSeqContador, "@L 99999")
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarMascara - Formata numero como string mascarada
    * Equivalente ao legado fGerMascara()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarMascara(par_nNumero)
        RETURN ALLTRIM(TRANSFORM(par_nNumero, "@L 999999"))
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularPositivo - Recalcula posicao de estoque via stored procedure
    * Equivalente ao legado fRecalculaP por registro (SigOpClP)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularPositivo(par_cEmps, par_cGrupos, par_cEstos, par_cCPros, par_cCodCors, par_cCodTams)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "EXEC SigOpClP " + ;
                       "@Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ", " + ;
                       "@Grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ", " + ;
                       "@Estos = " + EscaparSQL(ALLTRIM(par_cEstos)) + ", " + ;
                       "@CPros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ", " + ;
                       "@CodCors = " + EscaparSQL(ALLTRIM(par_cCodCors)) + ", " + ;
                       "@CodTams = " + EscaparSQL(ALLTRIM(par_cCodTams))
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResRecP")
            IF USED("cursor_4c_ResRecP")
                USE IN cursor_4c_ResRecP
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recalcular posi" + CHR(231) + CHR(227) + "o de estoque: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularCusto - Recalcula custo do produto via stored procedure
    * Equivalente ao legado fRecalculaC por registro (SigOpClC)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularCusto(par_cEmps, par_cCPros)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "EXEC SigOpClC " + ;
                       "@Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ", " + ;
                       "@CPros = " + EscaparSQL(ALLTRIM(par_cCPros))
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResRecC")
            IF USED("cursor_4c_ResRecC")
                USE IN cursor_4c_ResRecC
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recalcular custo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

