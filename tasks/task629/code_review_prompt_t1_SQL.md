# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABLE_NAME' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLOK, DOPES, CEMPS, ICLIS, CPROS, CODS, LNPRC, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLOK, DOPES, CEMPS, ICLIS, CPROS, CODS, LNPRC, EMPDOPNUMS

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
Select crImpMvCab
Append From &lcArq delimited with character '|'
lcQuery = [Select Dopes, NDopes, Numeras, vCompensas, GrVends, Cmoes From SigCdOpe Where Dopes = '] + crImpMvCab.Dopes + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpe') < 1)
	lcQuery = [Select cEmps From SigCdEmp Where cEmps = '] + crImpMvCab.Emps + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdEmp') < 1)
	lcQuery = [Select Rclis From SigCdCli Where Iclis = '] + crImpMvCab.CONORIGS + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	lcQuery = [Select Rclis From SigCdCli Where Iclis = '] + crImpMvCab.CONDESTS + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	lcQuery = [Select Rclis From SigCdCli Where Iclis = '] + crImpMvCab.VENDS + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	Select crSigMvCab
	Select crSigMvItn
	Select crSigMvIts
	Select crSigMvMov
	Select crImpMvCab
	Insert Into crSigMvCab ( Emps, Dopes, Numes, Usuars, Datars, Datas, Transps, Mascnum, Tabds, LPrecos, CidChaves, ;
		If !Seek(lcMoeOpe, "TmpTotal" )
			Insert Into TmpTotal (Moeds, Moevals) Values (lcMoeOpe, lnCotMov)
	Select crImpMvCab
		lcQuery = [Select Dpros From SigCdPro Where Cpros = '] + crImpMvCab.Cpros + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPro') < 1)
		Select crImpMvCab	
			If !Seek(m.Moedas, "TmpTotal" )
				Insert Into TmpTotal (Moeds, Moevals) Values (m.Moedas, m.MoeVals)
		Insert Into crSigMvItn From Memvar
				lcQuery = [Select Cods From SigCdCor Where Cods = '] + crImpMvCab.CodCors + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCor') < 1)
				lcQuery = [Select Cods From SigCdTam Where Cods = '] + crImpMvCab.CodTams + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdTam') < 1)
			Insert Into crSigMvIts From Memvar
		Select TmpTotal
				Insert Into crSigMvMov ( Emps, Dopes, Numes, Moeds, ValTots, ValItens, ValDifs, ;
If llOk And !ThisForm.poDataMgr.Update('crSigMvCab')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update crSigMvCab)')
If llOk And !ThisForm.poDataMgr.UpDate('crSigMvItn')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update crSigMvItn)')
If llOk And !ThisForm.poDataMgr.UpDate('crSigMvIts')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update crSigMvIts)')
If llOk And !ThisForm.poDataMgr.UpDate('crSigMvMov')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update crSigMvMov)')
Select crSigMvCab
Select crSigMvItn
Select crSigMvIts
Select crSigMvMov
	lcQuery = [Select MoedaPs, MascNums, DirImports From SigCdPam]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
				Delete File &lcArq.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg) - TRECHOS RELEVANTES PARA PASS SQL (776 linhas total):

*-- Linhas 359 a 377:
359:     * CarregarLista - FUNIL UNICO de carga da "lista" deste form OPERACIONAL (o
360:     * ListBox de arquivos .TXT disponiveis; nao ha Grid nem registros de CRUD).
361:     * Concentra o guard de ambiente: em validacao de UI / modo teste nao ha
362:     * conexao SQL, e CarregarParametrosSistema() faz SQLEXEC em SigCdPam.
363:     *
364:     * PUBLIC de proposito: o harness (TesteAutomatico.prg) chama
365:     * THIS.oForm.CarregarLista() de FORA da classe - metodo PROTECTED passaria
366:     * o PEMSTATUS(...,5) e falharia na chamada real (regra #3/#51).
367:     *==========================================================================
368:     PROCEDURE CarregarLista()
369:         IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
370:            (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
371:             *-- Sem banco: a tela fica montada e vazia, como o legado ficaria
372:             *-- se o diretorio de importacao estivesse em branco. O estado dos
373:             *-- botoes continua sendo decidido pelo When reproduzido.
374:             THIS.AtualizarEstadoBotoes()
375:             RETURN .F.
376:         ENDIF
377: 

*-- Linhas 617 a 635:
617:                         COPY FILE (loc_cArq) TO (loc_cDestino)
618:                     ENDIF
619:                     IF !EMPTY(loc_cDestino) AND FILE(loc_cDestino)
620:                         DELETE FILE (loc_cArq)
621:                         *-- O legado remove por POSICAO ("Arquivos.RemoveItem(
622:                         *-- lnPrc - lnDel)"), o que casa com a ordem do ADir -
623:                         *-- mas o ListBox tem "Sorted = .T." no SCX, entao a
624:                         *-- ordem EXIBIDA eh alfabetica e a posicao do ADir
625:                         *-- aponta para outra linha: o arquivo processado fica
626:                         *-- na lista e um nao-processado desaparece dela. Defeito
627:                         *-- HERDADO (regra #28); conserto registrado aqui -
628:                         *-- remover pelo NOME entrega o efeito que o legado
629:                         *-- evidentemente pretendia, sem depender da ordenacao.
630:                         THIS.RemoverArquivoDaLista(loc_cNomeArq)
631:                     ENDIF
632:                     THIS.obj_4c_Arquivos.Refresh()
633:                 ENDIF
634:             ENDFOR
635:         ELSE

