# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABLE_NAME' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CODIGOS, PGRU, IDIOMA, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CODIGOS, PGRU, IDIOMA, CPROS

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
Select crSigCdPro
Select crSigCdPrd
	lStrQuery = [Select * From SigCdGrp Where CGrus = '] + pGru + [']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'crSigCdGrp') < 1
	lStrQuery = [Select * From SigCdPsg Where Cgrus = '] + pGru + [' And codigos = '] + pSGr + [']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'crSigCdPsg') < 1
	Select Distinct CGrus, Linguas, TpMontas ;
	  From crSigCdPrd ;
	Select LocalMontas
				Select crSigCdDic
If Not ThisForm.poDataMgr.Update('crSigCdPro')
If llTaOk And Not ThisForm.poDataMgr.Update('crSigPrCpo')
If llTaOk And Not ThisForm.poDataMgr.Update('crSigCdPrf')
		lcQuery = [Select * From SigCdPrd]
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdPrd]) < 1)
		Select crSigCdPrd
		lcQuery = [Select Str(Len(Ltrim(Rtrim(a.Expressao))), 10) as COrdems, a.Expressao, a.Traducao ] + ;
					[From SigCdDic a ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)
lStrQuery = [Select CGrus, Mercs, CodProds, IdeCPros From SigCdGrp Where CGrus = '] + lcCGrus + [']
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
	Select crSigCdGpr1
Select crSigPrCpo
	Select crTmp
		Select crTmp
		Insert Into crSigPrCpo From Memvar
Select crSigCdPrf
	Select crTmp
		Select crTmp
		Insert Into crSigCdPrf From Memvar
lcSql = [Select * from SigCdPro where Cpros = ']+lcLocPros+[']
ThisForm.Podatamgr.Sqlexecute(lcSql,'CrTmp')
Select CrTmp
Select crSigCdPro
Insert Into crSigCdPro From Memvar
Select crSigCdPro
lStrQuery = [Select CGrus,CodProds,IdeCPros From SigCdGrp Where CGrus = ']+lcCGrus+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
		Select TmpGruPro

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpRef.prg) - TRECHOS RELEVANTES PARA PASS SQL (1670 linhas total):

*-- Linhas 35 a 53:
35: *
36: * Fase 4/8 - Dialogo de CAPTURA (sem Page1/Lista): o dump nao tem NENHUMA
37: * superficie de lista (zero BaseClass grid/pageframe, zero AddCursor/
38: * pColuna/RecordSource com valor, zero ControlSource com valor fora do
39: * CommandGroup) e TEM superficie de campos editaveis (5 TextBox fwget +
40: * 1 OptionGroup, nenhum ReadOnly=.T. incondicional - GetOldCPro/
41: * getOldCGrus/getolddpro so ficam Enabled=.F. porque espelham o produto
42: * de ORIGEM, que o usuario nao edita, mas nao sao campos de EXIBICAO do
43: * dialogo como um todo). Entao nao ha Grid nem 6 botoes CRUD a entregar
44: * aqui (inventa-los violaria o PILAR 1) - o entregavel real desta fase eh
45: * o container de botoes de ACAO do legado (cntBotoes -> cmg_4c_Botoes,
46: * CommandGroup com Confirmar/Cancelar), equivalente ao "cnt_4c_Botoes" do
47: * template CRUD. Mesmo padrao de FormSigMvChv.prg/FormSigOpCcj.prg
48: * (familia de dialogo OPERACIONAL flat sem Lista). Os campos (Fase 5) e
49: * os handlers de Click (fase de eventos/acao) ficam para as proximas
50: * fases.
51: *
52: * Fase 5/8 - Campos de CODIGO/GRUPO (primeira metade): este dialogo nao
53: * tem PageFrame/Page2 (regra da Fase 3 - form PLANO), entao os controles

*-- Linhas 69 a 87:
69: * so usada quando o usuario digita manualmente; nos demais casos o legado
70: * remonta a descricao via fGerarDescrs/fGerDescritivo, que nao vieram no
71: * acervo - regra #27, ja documentado em SigOpRefBO.Inserir), Say4/Get_Qtd
72: * (Quantidade), Say19/Opc_situacao (Situacao Ativo/Inativo - ControlSource
73: * NUMERICO direto, Value = coluna, sem +1/-1) e os dois labels de status
74: * (lblOk/lblNotOk) - estes DOIS ultimos sao dead code no legado: nenhum
75: * metodo do SCX (Init/btnConfirmar.Click/btnSair.Click) jamais atribui
76: * .Visible aos dois (confirmado varrendo o dump inteiro) - ficam sempre
77: * ocultos, e por isso TornarControlesVisiveis tem uma excecao para NAO
78: * forcar .Visible = .T. neles (mesma tecnica de "containers flutuantes"
79: * do guia de migracao - um controle que o legado nunca exibe nao pode
80: * passar a aparecer so porque a ferramenta generica torna tudo visivel).
81: * Say19 nao declara Width/Height no dump (classe say AutoSize=.T.,
82: * regra CLAUDE.md #23) - como AutoSize eh no-op em Label criado por
83: * AddObject, a Width foi calculada para caber o texto "Situacao :" sem
84: * encostar no Opc_situacao (Left=190), seguindo a mesma regra.
85: *
86: * BOParaForm()/FormParaBO() fazem o binding completo entre os controles
87: * e as properties do SigOpRefBO (todas ja declaradas nas Fases 1/2).

*-- Linhas 798 a 816:
798:                 .Visible   = .T.
799:             ENDWITH
800: 
801:             *-- Opc_situacao -> this_nSituacao (ControlSource numerico direto:
802:             *-- Value = 1 Ativo / 2 Inativo, sem +1/-1 - regra #188)
803:             THIS.AddObject("opt_4c_Situacao", "OptionGroup")
804:             WITH THIS.opt_4c_Situacao
805:                 .Top           = 143
806:                 .Left          = 190
807:                 .Width         = 129
808:                 .Height        = 17
809:                 .ButtonCount   = 2
810:                 .AutoSize      = .F.
811:                 .BackStyle     = 0
812:                 .BorderStyle   = 0
813:                 .Value         = 1
814:                 .Visible       = .T.
815: 
816:                 WITH .Buttons(1)

*-- Linhas 1186 a 1207:
1186:                 USE IN cursor_4c_ProdOrigemRef
1187:             ENDIF
1188: 
1189:             loc_cSQL = "SELECT cpros, cgrus, dpros FROM SigCdPro WHERE cpros = " + ;
1190:                 EscaparSQL(PADR(ALLTRIM(THIS.this_cParCodProdOrigem), 14))
1191: 
1192:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdOrigemRef")
1193: 
1194:             IF loc_nResultado < 0
1195:                 MsgErro("Erro ao consultar o produto de origem:" + CHR(13) + ;
1196:                     CapturarErroSQL(), "Erro SQL")
1197:                 loc_lSucesso = .F.
1198:             ELSE
1199:                 IF THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_ProdOrigemRef")
1200:                     THIS.this_oBusinessObject.this_nSituacaoIt = THIS.this_nParSituacao
1201:                     THIS.this_oBusinessObject.this_lSaiAuto    = THIS.this_lParSaiAuto
1202:                     THIS.this_oBusinessObject.this_nIdentFixa  = THIS.this_nParIdentFixa
1203:                     THIS.this_oBusinessObject.this_nCadPro     = THIS.this_nParCadPro
1204:                     THIS.this_oBusinessObject.this_cDopes      = THIS.this_cParDopes
1205: 
1206:                     THIS.this_oBusinessObject.this_cGrupoDestino = ;
1207:                         IIF(!EMPTY(ALLTRIM(THIS.this_cParGrupoDestino)), ;

*-- Linhas 1325 a 1343:
1325:     *   EndIf
1326:     *   ThisForm.Release
1327:     *
1328:     * A COPIA em si (os tres Zap/Scatter/Insert mais o mSv_Inserir) esta toda
1329:     * no Business Object (SigOpRefBO.Inserir, Fase 2), chamada pelo par
1330:     * canonico NovoRegistro() + Salvar() - regra #20: BusinessBase.Salvar() ja
1331:     * EXIBE a falha em todo caminho de recusa, por isso nao ha ELSE com
1332:     * MsgErro aqui.
1333:     *
1334:     * As duas checagens acima continuam NO HANDLER, e nao so no
1335:     * SigOpRefBO.ValidarDados que as repete, porque no legado elas rodam
1336:     * ANTES da pergunta de confirmacao e a primeira delas devolve o FOCO ao
1337:     * campo do codigo - deixar so a validacao do BO perguntaria "confirma?"
1338:     * para em seguida recusar, invertendo o fluxo da tela (PILAR 1).
1339:     *
1340:     * fVerificarBarras(lcNewPros, crSigCdPam.TpCBars) NAO tem equivalente: a
1341:     * funcao global (SIGFUNCS.PRG) nao veio no acervo e so reforcava o
1342:     * FORMATO do codigo digitado - mesma ausencia ja documentada em
1343:     * SigOpRefBO.ValidarDados e em Formsigoppro/FormSigPrEtq (regra #27: nao

