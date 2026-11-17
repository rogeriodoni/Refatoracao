# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PTIP, CCARGS, CANCITENS, LIMITES, LIBFPAGS, LIBFPGS, LIBPESS, LIBPRODS, LIBSDINS, LIBVOPES, LIBOPES, LIBERAMOV, LIBQTMINS, LCQUERY, LIBLMPSS, LIBVMOVDUP, LIBLEILAOS, LIBDUPENDS, LIBDUPTITS, LIBPRZES, CUSTOPROD, LIBVALMMAX, LIBEXPRD, CONSSUBN, ALTCOTS, USUARIOS, EMPDOPNUMS, USUARS, SENHADS, CIDCHAVES, TIPO, CEMPS, FPAGS

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
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
			lcQuery = [Select a.* From SigCdUsu a ]+;
			lcQuery = [Select a.* From SigCdUsu a ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a ]+;
		lcQuery = [Select a.* From SigCdUsu a ]+;
		lcQuery = [Select a.* From SigCdUsu a ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
		lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b ]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpUsu') < 1)
Select TmpUsu
	select tmpusu
	if not seek(this.value)
	select tmpusu
		select TmpUsu
lcQuery = [select a.usuarios, a.senhas from SigCdUsu a where Not a.cAtivos='N' and a.usuarios='] + ALLTRIM(ThisForm.Usuario.Value) + [' order by 1]
ThisForm.poDataMgr.SQLExecute(lcQuery, 'TmpUsu')
lcQuery = [select * from SigPrSnd a where a.empdopnums = '' and a.usuars='] + ThisForm.Usuario.Value + [' and a.senhads='] + ALLTRIM(this.Value) + [' ]
ThisForm.poDataMgr.SQLExecute(lcQuery, 'TmpSLivre')
	lcQuery = [Update SigPrSnd Set EmpDopNums = '] + lcEDN + [' Where CidChaves = '] + tmpSLivre.CidChaves + [']
	Thisform.podatamgr.SqlExecute(lcQuery,[])
		lcSql = [Select nemps From SigCdEmp Where CEmps = ']+ThisForm.Empresa+[']
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrEmp')
		lcSql = [Select nfpags From SigOpFp Where Fpags = ']+ThisForm.Fpagto+[']
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrfPagto')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopsen.prg) - TRECHOS RELEVANTES PARA PASS SQL (2333 linhas total):

*-- Linhas 513 a 549:
513:     *   If Not Used([crParam]) -> MessageBox + Return .f.
514:     *
515:     * O 5o argumento da CursorQuery eh a lista de campos, logo as consultas
516:     * equivalentes sao "SELECT liblcreds FROM SigCdPam" e "SELECT senhdemps
517:     * FROM SigCdPac". NENHUMA das duas leva WHERE: conferido no schema
518:     * canonico, nem SigCdPam nem SigCdPac tem coluna de empresa (as unicas
519:     * colunas que contem "emps" sao blqmemps, libtremps e a propria senhdemps)
520:     * - sao tabelas de parametro de linha unica, e inventar um WHERE Emps aqui
521:     * faria o SQL Server recusar a consulta.
522:     *
523:     * UM desvio deliberado do literal: o legado testa "Used([crParam])" DUAS
524:     * vezes e nunca testa crParac. Aqui cada carga confere o SEU cursor - sem
525:     * isso a falha da segunda passaria calada e estouraria depois, ao ler
526:     * CrParac.SenhDEmps na conferencia da senha. O caminho de sucesso tem
527:     * desfecho identico ao do legado.
528:     *
529:     * As duas colunas sao "bit" no SQL Server, que chega ao VFP ora como
530:     * Logico ora como Numerico conforme o driver - por isso ConverterParaLogico
531:     * em vez de comparar com 1.
532:     *
533:     * Em modo de teste / validacao de UI nao ha conexao (o harness define
534:     * gnConnHandle = 0 de proposito) e um SQLEXEC sem handle valido BLOQUEIA o
535:     * processo em vez de devolver erro: a carga eh pulada nesses dois modos,
536:     * devolvendo .T. para a estrutura visual - que eh o que esses modos medem -
537:     * continuar sendo montada. Os parametros ficam nos defaults do BO.
538:     *
539:     * PUBLIC: eh o ponto de recarga dos parametros do sistema e pode ser
540:     * chamado de fora (harness e chamador), nao so de dentro da classe.
541:     *--------------------------------------------------------------------------
542:     PROCEDURE CarregarParametrosSistema()
543:         LOCAL loc_lSucesso, loc_cCursor, loc_nResultado, loc_oErro
544: 
545:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
546:             RETURN .F.
547:         ENDIF
548: 
549:         IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;

*-- Linhas 561 a 605:
561:                 USE IN (loc_cCursor)
562:             ENDIF
563: 
564:             loc_nResultado = SQLEXEC(gnConnHandle, "SELECT liblcreds FROM SigCdPam", loc_cCursor)
565: 
566:             IF loc_nResultado < 1 OR !USED(loc_cCursor)
567:                 THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
568:                 MsgErro(THIS.this_cMensagemErro, ;
569:                     "Falha na Conex" + CHR(227) + "o (CursorQuery - crParam)")
570:             ELSE
571:                 SELECT (loc_cCursor)
572:                 GO TOP
573:                 THIS.this_oBusinessObject.this_lLiblCreds = ;
574:                     IIF(EOF(loc_cCursor), .F., ConverterParaLogico(EVALUATE(loc_cCursor + ".liblcreds")))
575: 
576:                 *-- SigCdPac.senhdemps -> crParac do legado
577:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorParac
578: 
579:                 IF USED(loc_cCursor)
580:                     USE IN (loc_cCursor)
581:                 ENDIF
582: 
583:                 loc_nResultado = SQLEXEC(gnConnHandle, "SELECT senhdemps FROM SigCdPac", loc_cCursor)
584: 
585:                 IF loc_nResultado < 1 OR !USED(loc_cCursor)
586:                     THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
587:                     MsgErro(THIS.this_cMensagemErro, ;
588:                         "Falha na Conex" + CHR(227) + "o (CursorQuery - crParac)")
589:                 ELSE
590:                     SELECT (loc_cCursor)
591:                     GO TOP
592:                     THIS.this_oBusinessObject.this_lSenhDEmps = ;
593:                         IIF(EOF(loc_cCursor), .F., ConverterParaLogico(EVALUATE(loc_cCursor + ".senhdemps")))
594: 
595:                     THIS.this_lParametrosCarregados = .T.
596:                     loc_lSucesso = .T.
597:                 ENDIF
598:             ENDIF
599:         CATCH TO loc_oErro
600:             THIS.this_cMensagemErro = loc_oErro.Message
601:             MsgErro(loc_oErro.Message + CHR(13) + ;
602:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
603:                 "Procedure: " + loc_oErro.Procedure, ;
604:                 "Falha na Conex" + CHR(227) + "o (Par" + CHR(226) + "metros do Sistema)")
605:         ENDTRY

*-- Linhas 1362 a 1380:
1362:     * Legado, na ordem:
1363:     *   1. If Empty(This.Value) -> ZSen = .f. / ThisForm.Release / Return .t.
1364:     *   2. Do Case ... monta lcQuery conforme a liberacao pedida
1365:     *   3. If (SqlExecute(lcQuery,'TmpUsu') < 1) -> MessageBox / Return .f.
1366:     *   4. index on usuarios tag usuarios / set near on
1367:     *      if not seek(this.value) -> fwBuscaSel('tmpusu','usuarios',...)
1368:     *   5. thisform.usulibs = this.value
1369:     *   6. If IsEmpty(usual) -> zsen = .F. / release
1370:     *      Else If lastkey() <> 27
1371:     *              If IsEmpty(TmpUsu.senhas) -> autoriza na hora, esconde a
1372:     *                                           linha da senha e fecha
1373:     *              Else -> mostra a linha da senha e espera
1374:     *
1375:     * Os passos 2 e 3 moram no BO (MontarQueryUsuarios /
1376:     * CarregarUsuariosAutorizados): a escolha de QUAL permissao de cargo
1377:     * sera exigida eh regra de negocio, e eh no BO que vivem as 21 flags de
1378:     * liberacao que ConfigurarPorTipo() liga.
1379:     *
1380:     * TRES desvios deliberados, todos documentados:

*-- Linhas 1451 a 1469:
1451:         loc_cCursor     = loc_oBO.this_cCursorUsuarios
1452: 
1453:         TRY
1454:             *-- Passos 2 e 3 do legado (Do Case + SqlExecute em TmpUsu)
1455:             IF !loc_oBO.CarregarUsuariosAutorizados()
1456:                 MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro)), ;
1457:                     "Favor Reinicializar o Processo!!!", loc_oBO.this_cMensagemErro), ;
1458:                     "Falha na Conex" + CHR(227) + "o (TmpUsu)")
1459:                 loc_lProsseguir = .F.
1460:             ENDIF
1461: 
1462:             IF loc_lProsseguir
1463:                 loc_cCursor = loc_oBO.this_cCursorUsuarios
1464:                 loc_lAchou  = THIS.LocalizarUsuario(loc_cValor)
1465: 
1466:                 *-- Legado: if not seek(this.value) -> abre o fwBuscaSel
1467:                 IF !loc_lAchou
1468:                     IF THIS.AbrirBuscaUsuario()
1469:                         loc_cValor = UPPER(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, "")))

*-- Linhas 1620 a 1638:
1620:     * servidor - no sistema novo isso eh o FormBuscaAuxiliar pela API
1621:     * DefinirCursor/Mostrar, que exibe o cursor como ele esta e NAO dispara
1622:     * consulta propria. A API alternativa (CREATEOBJECT com parametros)
1623:     * seria errada aqui: ela monta um SELECT na tabela, e o universo desta
1624:     * busca nao eh "todos os usuarios", eh "os usuarios que podem conceder
1625:     * ESTA liberacao" - a consulta filtrada que o BO acabou de rodar.
1626:     *
1627:     * As legendas das duas colunas sao as do legado ("Codigo" e "cargo",
1628:     * esta em minuscula como escrita la). DefinirCursor cria as duas colunas
1629:     * usando o NOME do campo como titulo, por isso os titulos sao
1630:     * reescritos em seguida em this_aColunas[n, 3].
1631:     *
1632:     * F4/DblClick podem chegar antes de qualquer LostFocus, com o cursor
1633:     * ainda inexistente: nesse caso a lista eh carregada aqui. Pelo caminho
1634:     * do LostFocus ela ja esta carregada e nenhuma consulta eh repetida.
1635:     *
1636:     * Lista vazia nao abre picker vazio (regra #36): devolve .F. e quem
1637:     * chamou decide - pelo LostFocus isso cai no ramo que nega a liberacao e
1638:     * encerra o dialogo, como no legado.

*-- Linhas 1731 a 1749:
1731:             RETURN .F.
1732:         ENDIF
1733: 
1734:         SELECT (loc_cCursor)
1735:         LOCATE FOR UPPER(LEFT(usuarios, LEN(m.loc_cValor))) == m.loc_cValor
1736: 
1737:         RETURN FOUND(loc_cCursor)
1738:     ENDPROC
1739: 
1740:     *--------------------------------------------------------------------------
1741:     * SenhaLostFocus - Equivalente ao Valid do campo senha legado, que eh o
1742:     * fluxo de ACAO desta tela: eh aqui que a liberacao eh concedida ou
1743:     * recusada.
1744:     *
1745:     * WRAPPER FINO, so para a guarda de reentrancia, pelo mesmo desenho do
1746:     * UsuarioLostFocus: o corpo tem RETURN antecipado em varios caminhos
1747:     * (campo de senha oculto, senha ja conferida, usuario nao resolvido) e,
1748:     * com set/clear no proprio corpo, qualquer um desses RETURN deixaria a
1749:     * flag LIGADA para sempre - e dai a senha nunca mais seria conferida e o

