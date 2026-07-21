# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-ASPAS] Linha 468: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_lcQuery = "Select ceps From cep Where ceps = '" + loc_lcCep + "'"
- [SQL-ASPAS] Linha 630: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_lcQuery = "Select COUNT(*) AS nExiste From SigCdCli Where IClis = '" + loc_lcContaDs + "'"
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLFISCALS, CPROS, GRUPOS, ESTOS, PRODWEBS, PRODVARS, DOPES, LNPRC, CEPS, LNBUS, CPFS, DESCRS, LNITN, LNERROR, LNKEY
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLFISCALS, CPROS, GRUPOS, ESTOS, PRODWEBS, PRODVARS, DOPES, LNPRC, CEPS, LNBUS, CPFS, DESCRS, LNITN, LNERROR, LNKEY
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ENCARGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLFISCALS, CPROS, GRUPOS, ESTOS, PRODWEBS, PRODVARS, DOPES, LNPRC, CEPS, LNBUS, CPFS, DESCRS, LNITN, LNERROR, LNKEY
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLFISCALS, CPROS, GRUPOS, ESTOS, PRODWEBS, PRODVARS, DOPES, LNPRC, CEPS, LNBUS, CPFS, DESCRS, LNITN, LNERROR, LNKEY

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
	DELETE FILE &lcArq
lcQuery = 	[select a.cpros, a.sqtds, b.dpros, b.pvens, b.pcuss, b.prodwebs, b.prodvars, b.Encargos, ] +;
			[from sigmvest a, SigCdPro b, SigcdClf c where b.clfiscals = c.codigos and a.cpros = b.cpros and a.grupos = 'ESTOQUE' and a.estos = 'ESTOQUE' ] +;
			[(select b.cpros, 0.000 as sqtds, b.dpros, b.pvens, b.pcuss, b.prodwebs, b.prodvars, b.Encargos, ] +;
			[from SigCdPro b, SigcdClf c where b.clfiscals = c.codigos and  b.cpros not in(select cpros from sigmvest where grupos = 'ESTOQUE' and estos = 'ESTOQUE') ] +;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEst]) < 1)
SELECT localEst
lcQuery = [Select * ] + ;
		    [From SigCdOpe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalOpe]) < 1)
	Select LocalOpe
					lcQuery = [Select * From cep Where ceps = '] + lcCep + [']
					If (ThisForm.poobjext.SqlExecute(lcQuery, [LocalCep]) < 1)
				Select crSigMvCab
									lcQuery = [Select * ] + ;
											    [From SigCdCli ] + ;
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCli]) < 1)
										Select LocalCli
											Insert Into crSigCdCli (Grupos, IClis, TpClis, Cpfs, Paises, Usuars, DataIncs, Emps, ContaVens) ;
											Select LocalCli
											Insert Into crSigCdCli From Memvar
											lcQuery = [select estados, descrs from sigcdufs Where descrs = '] + alltrim(lcAtu) + [']
											If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalUf]) < 1)
											lcQuery = [Select CUnis ] + ;
													    [From SigCdPro ] + ;
											If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
												Select LocalPro
										lcQuery = [Select Encargos From SigCdPro Where CPros = '] + crSigMvItn.Cpros + [']
										If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
			If llOks And Not ThisForm.poDataMgr.Update([crSigMvCab])
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvCab)])
			If llOks And Not ThisForm.poDataMgr.Update([crSigMvItn])
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvItn)])
			If llOks And Not ThisForm.poDataMgr.Update([crsigmvpar])
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crsigmvpar)])
			If llOks And Not ThisForm.poDataMgr.Update([crSigCdCli])
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigCdCli)])
					Delete File &lcArq.
		lcQuery = [Select DirLivrosV, CdChepSais, Mascnums, CdChepEnts ] + ;
				    [From sigcdpam]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crsigcdpam]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRMEI.prg) - TRECHOS RELEVANTES PARA PASS SQL (700 linhas total):

*-- Linhas 66 a 95:
66:                 THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o SIS E-Commerce"
67: 
68:                 *-- Carregar configuracoes operacionais de SigCdPam
69:                 loc_cSQL = "SELECT DirLivrosV, CdChepSais, Mascnums, CdChepEnts FROM SigCdPam"
70:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
71:                 IF loc_nRet > 0
72:                     SELECT cursor_4c_SigCdPam
73:                     GO TOP
74:                     IF !EOF("cursor_4c_SigCdPam")
75:                         THIS.this_oBusinessObject.this_cDirLivros  = ALLTRIM(cursor_4c_SigCdPam.DirLivrosV)
76:                         THIS.this_oBusinessObject.this_cDirSaida   = ALLTRIM(cursor_4c_SigCdPam.CdChepSais)
77:                         THIS.this_oBusinessObject.this_cMascNums   = ALLTRIM(cursor_4c_SigCdPam.Mascnums)
78:                         THIS.this_oBusinessObject.this_cDirEntrada = ALLTRIM(cursor_4c_SigCdPam.CdChepEnts)
79:                     ENDIF
80:                     USE IN SELECT("cursor_4c_SigCdPam")
81:                 ELSE
82:                     MsgErro("Erro ao carregar configura" + CHR(231) + CHR(245) + "es de SigCdPam.", "FormSIGPRMEI.InicializarForm")
83:                 ENDIF
84: 
85:                 THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado
86: 
87:                 THIS.ConfigurarPageFrame()
88:                 THIS.ConfigurarCabecalho()
89:                 THIS.ConfigurarBotoes()
90:                 THIS.ConfigurarLabels()
91: 
92:                 THIS.TornarControlesVisiveis(THIS)
93: 
94:                 loc_lSucesso = .T.
95:             ELSE

*-- Linhas 454 a 484:
454:     * lista" nos forms CRUD - devolve o dialogo ao estado inicial).
455:     *--------------------------------------------------------------------------
456:     PROTECTED PROCEDURE ConfigurarPaginaLista()
457:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
458:             THIS.lbl_4c_Status.Caption = ""
459:         ENDIF
460:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
461:             THIS.btn_4c_Processar.Enabled = .T.
462:         ENDIF
463:         IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
464:             THIS.btn_4c_Encerrar.Enabled = .T.
465:         ENDIF
466:     ENDPROC
467: 
468:     *--------------------------------------------------------------------------
469:     * ConfigurarPaginaDados - N/A para OPERACIONAL sem PageFrame
470:     *
471:     * FormSIGPRMEI eh um dialogo de processamento (500x147) sem PageFrame,
472:     * portanto nao ha Page2/Dados como em forms CRUD (frmcadastro).
473:     * Metodo mantido pela interface do pipeline de migracao. Nao ha campos
474:     * de entrada, TextBoxes ou Labels de dados a configurar ? todos os
475:     * controles visuais foram criados em ConfigurarCabecalho +
476:     * ConfigurarBotoes + ConfigurarLabels.
477:     *--------------------------------------------------------------------------
478:     PROTECTED PROCEDURE ConfigurarPaginaDados()
479:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
480:             THIS.lbl_4c_Status.Caption = ""
481:         ENDIF
482:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
483:             THIS.btn_4c_Processar.Enabled = .T.
484:         ENDIF

*-- Linhas 616 a 646:
616:     * BOParaForm - Sincroniza estado do BO para o form
617:     *
618:     * Form OPERACIONAL sem campos editaveis: atualiza o label de status com
619:     * a ultima mensagem gerada pelo BO durante o processamento.
620:     *--------------------------------------------------------------------------
621:     PROTECTED PROCEDURE BOParaForm()
622:         LOCAL loc_oBO
623:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
624:             loc_oBO = THIS.this_oBusinessObject
625:             IF PEMSTATUS(THIS, "lbl_4c_Status", 5) AND !EMPTY(ALLTRIM(loc_oBO.this_cUltStatus))
626:                 THIS.lbl_4c_Status.Caption = loc_oBO.this_cUltStatus
627:             ENDIF
628:         ENDIF
629:         RETURN .T.
630:     ENDPROC
631: 
632:     *--------------------------------------------------------------------------
633:     * HabilitarCampos - Habilita/desabilita botoes conforme modo de operacao
634:     *
635:     * par_cModo: "IDLE"        -> Processar habilitado, aguardando
636:     *            "PROCESSANDO" -> Processar desabilitado durante loop
637:     *--------------------------------------------------------------------------
638:     PROTECTED PROCEDURE HabilitarCampos(par_cModo)
639:         LOCAL loc_lIdle
640:         loc_lIdle = (UPPER(ALLTRIM(par_cModo)) = "IDLE" OR EMPTY(par_cModo))
641: 
642:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
643:             THIS.btn_4c_Processar.Enabled = loc_lIdle
644:         ENDIF
645:         IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
646:             THIS.btn_4c_Encerrar.Enabled = .T.

