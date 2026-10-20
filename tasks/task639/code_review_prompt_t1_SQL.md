# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLASSES, NTPALTERA, OPERS, NOPERS, EMPS, LNERREX, LNERRO1
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLASSES, NTPALTERA, OPERS, NOPERS, EMPS, LNERREX, LNERRO1
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLASSES, NTPALTERA, OPERS, NOPERS, EMPS, LNERREX, LNERRO1
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MOEDAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLASSES, NTPALTERA, OPERS, NOPERS, EMPS, LNERREX, LNERRO1
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COTACAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CLASSES, NTPALTERA, OPERS, NOPERS, EMPS, LNERREX, LNERRO1

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
  ControlSource = "crAltcc.datas"
  ControlSource = "crAltcc.opers"
  ControlSource = "crAltcc.docus"
  ControlSource = "crAltcc.valors"
  ControlSource = "crAltcc.nfs"
  ControlSource = "crAltcc.usualts"
  ControlSource = "crAltcc.cotacaos"
  ControlSource = "crAltcc.vencs"
  ControlSource = "crAltcc.hist2s"
  ControlSource = "crAltcc.hists"
  ControlSource = "crAltcc.sopers"
  ControlSource = "crAltcc.svalors"
  ControlSource = "crAltcc.grupos"
  ControlSource = ""
  ControlSource = "crAltcc.scotacaos"
  ControlSource = "crAltcc.contapgs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crAltcc.contas"
  ControlSource = "crAltcc.sgrupos"
  ControlSource = "crAltcc.scontas"
  ControlSource = "crAltcc.moedas"
  ControlSource = "crAltcc.smoedas"
  ControlSource = "crAltcc.grupems"
  ControlSource = "crAltcc.contems"
  ControlSource = "crAltcc.Jobs"
Select crSigCdCot
Select CrSigCdMoe
Select CrSigCdUsu
Select CrSigCdCrg
Select CrSigCdGcr
	=seek(M.grupos,'CrSigCdGcr','Codigos')
		lcQuery = [Select InvEmisCCs ] + ;
				    [From SigCdCss ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalClass]) < 1)
		Select LocalClass
	=seek(M.sgrupos,'crSigCdGcr','Codigos')
	=seek(M.grupems,'CrSigCdGcr','Codigos')
	Select CrSigCdCli
	Select CrSigCdCli
	Select CrSigCdCli
	Select CrSigCdCli
=Seek( CrAltcc.Moedas, 'crSigCdMoe', 'CMoes' )
=Seek( Padr( Alltrim( Usuar ), 10 ), 'CrSigCdUsu', 'Usuarios' )
llAltCot = ((!Seek( CrSigCdUsu.Ccargs, 'CrSigCdCrg', 'Ccargs' ) Or CrSigCdCrg.AltCots # 'S' ) And ;
=Seek( CrAltcc.SMoedas, 'CrSigCdMoe', 'CMoes' )
llAltcot = ( ( !Seek( CrSigCdUsu.Ccargs, 'CrSigCdCrg', 'Ccargs' ) Or CrSigCdCrg.AltCots # 'S' ) And ;
=Seek( Padr( Alltrim( Usuar ), 10 ), 'CrSigCdUsu', 'Usuarios' )
=Seek( ThisForm.Get_Moeda.Value, 'crSigCdMoe', 'CMoes' )
Return( Seek( CrSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs' ) And ;
=Seek( Padr( Alltrim( Usuar ), 10 ), 'CrSigCdUsu', 'Usuarios' )
=Seek( ThisForm.Get_sMoeda.Value, 'crSigCdMoe', 'CMoes' )
Return( Seek( CrSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs' ) And ;
Select CrSigCdMoe
If !Seek( This.Value )
			Select CrSigCdCot
=Seek( Padr( Alltrim( Usuar ), 10 ), 'CrSigCdUsu', 'Usuarios' )
llCota = ( ( !Seek( CrSigCdUsu.Ccargs, 'crSigCdCrg', 'Ccargs' ) Or crSigCdCrg.AltCots # 'S' ) And ;
Select CrSigCdMoe
If !Seek( This.Value )
			Select CrSigCdCot
=Seek( Padr( Alltrim( Usuar ), 10 ), 'CrSigCdUsu', 'Usuarios' )
llCota = ( ( !Seek( CrSigCdUsu.Ccargs, 'CrSigCdCrg', 'Ccargs' ) Or CrSigCdCrg.AltCots # 'S' ) And ;
	lnErro0 = ThisForm.ParentForm.poDataMgr.SqlExecute([Select CidChaves as nRecNo, Emps, Grupos, Contas, Datas, Moedas, ValPags, Opers From SigMvCcr Where Nopers = ?lnNopers],'CsLog')
		Select csLog
	lcUpdate = [Update SigMvCcr Set Datexcs = ?pData, usuexcs = ?pUsuar Where ]+;
	lcDelete = [Delete From SigMvCcr Where Emps= ']+pEmp+[ ' And Nopers = ]+Str(pNop)
	lnErro1 = ThisForm.ParentForm.poDataMgr.SqlExecute(lcUpdate,'')
		lnErrEx = ThisForm.ParentForm.poDataMgr.SqlExecute(lcDelete,'')
		Select CsLog && Tiago - 01/10/2015 - Quando trocava as contas não estava recalculando as contas anteriores; mudei para o cursor Cslog pois tem as os dados antigos - CrAltcc
	Select CrAltcc
	Delete From CrAltcc Where Not cIdChaves = ThisForm.pkChaves
	Select CrAltcc
	select CrAltcc
	If !ThisForm.Parentform.PoDataMgr.Update('Craltcc')
			lnErro0 = ThisForm.ParentForm.poDataMgr.SqlExecute([Select Cidchaves as nRecNo From SigMvCcr Where Nopers = ?lnNopers],'CsLog')
				Select csLog

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopacc.prg) - TRECHOS RELEVANTES PARA PASS SQL (2673 linhas total):

*-- Linhas 54 a 72:
54: *             - CarregarDados(): le o registro de SigMvCcr pela PK
55: *               (cidchaves) e chama BOParaForm(); em INCLUIR prepara
56: *               registro novo. Equivale ao "crAltcc ja posicionado" que o
57: *               legado herda do form pai via ControlSource - sem isso os
58: *               campos abriam todos em branco no modo ALTERAR.
59: *             - BOParaForm()/FormParaBO() COMPLETOS (os 29 TextBox + o
60: *               OptionGroup Acerto). NAO foi feita a divisao "metade agora,
61: *               metade na Fase 6": os campos ja existiam todos desde a Fase
62: *               4 e mapear so parte deles e exatamente o defeito do Erro184
63: *               (o valor digitado nunca chega ao BO e o bloco grava em
64: *               branco, calado). Dividir aqui criaria o defeito de proposito.
65: *             - AtualizarEstadoControles(): transcricao do When de CADA
66: *               controle do SCX (hook PUBLIC que FormBase.Init() ja chama
67: *               depois de InicializarForm) + o Cmd_Confirma.Enabled do Init
68: *               legado (desabilitado em CONSULTAR).
69: *             - this_nOldContaPgs: ThisForm.OldContaPgs do Init legado,
70: *               usado pelo Cmd_Confirma.Click (Fase 7) para decidir o
71: *               estorno de valpags. Medido no VFP9 (2026-10-16): atribuir
72: *               OptionGroup.Value = 3 ou 4 com ButtonCount = 2 e coagido

*-- Linhas 100 a 120:
100: *               (Append Blank + CidChaves novo via
101: *               Dtos()+fGerUniqueKey()+Sigkey) - artificio exigido pelo
102: *               cursor buffered do legado (so' se adiciona uma 2a linha com
103: *               Append Blank antes do TableUpdate). A arquitetura nova
104: *               localiza a linha da CONTRAPARTIDA (mesmo Nopers, outro
105: *               cidchaves - LocalizarCidContrapartida) e faz UPDATE IN
106: *               PLACE nas DUAS linhas (a principal, this_cPkChaves, e a
107: *               contrapartida, com os campos D<->C trocados), preservando
108: *               os CidChaves existentes. O estado final em SigMvCcr e'
109: *               equivalente (mesmos Grupos/Contas/Moedas/Valores/Opers
110: *               trocados); fUniqueIds() (regra #22 CLAUDE.md) e o gerador
111: *               de chave do projeto, usado so' quando o BO precisa de PK
112: *               nova (Inserir), nao neste fluxo. O recalculo de saldo
113: *               (fRecalculaS nos combos ANTIGOS e NOVOS dos dois lados +
114: *               fRecalculaS(.T., gnConnHandle) para processar a fila) e o
115: *               fGravarLog (no-op documentado - regra #27) sao transcritos
116: *               do Click legado.
117: *               Modo INSERIR/INCLUIR: o legado nunca abre este dialogo
118: *               assim (nota da Fase 5) - SalvarLancamento() grava so a
119: *               linha principal via loc_oBO.Salvar(), sem contrapartida.
120: *   Fase 8:   Auditoria final - NENHUM metodo novo foi adicionado. O

*-- Linhas 420 a 438:
420:     * CLAUDE.md #23: label classe "say" sem Width/Alignment no dump -> AutoSize
421:     * = .F. + Alignment = 0 + Width calculada para nao invadir o campo vizinho.
422:     * CLAUDE.md #12: ForeColor de label de dados = RGB(90,90,90) (nao branco).
423:     * Sem ControlSource (regra #15/arquitetura nova): campos sao preenchidos
424:     * via FormParaBO/BOParaForm (Fase de campos/eventos), nao por binding.
425:     *--------------------------------------------------------------------------
426:     PROTECTED PROCEDURE ConfigurarPaginaDados()
427:         LOCAL loc_cNao
428: 
429:         *-- Labels ------------------------------------------------------------
430:         THIS.AddObject("lbl_4c_Label1", "Label")
431:         WITH THIS.lbl_4c_Label1
432:             .FontBold  = .T.
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .Alignment = 0
436:             .AutoSize  = .F.
437:             .BackStyle = 0
438:             .Caption   = "Data : "

*-- Linhas 1121 a 1139:
1121:             .ForeColor     = RGB(0, 0, 0)
1122:         ENDWITH
1123: 
1124:         *-- OptionGroup "Acerto" (Sim/Nao) - ControlSource legado: crAltcc.contapgs
1125:         *-- (numerico, indice 1-based - regra #45). Default legado Value=2 (Nao).
1126:         THIS.AddObject("obj_4c_Opcao_conta", "OptionGroup")
1127:         WITH THIS.obj_4c_Opcao_conta
1128:             .ButtonCount = 2
1129:             .Left        = 282
1130:             .Top         = 163
1131:             .Width       = 88
1132:             .Height      = 27
1133:             .Value       = 2
1134:         ENDWITH
1135:         WITH THIS.obj_4c_Opcao_conta.Buttons(1)
1136:             .Caption   = "Sim"
1137:             .Left      = 5
1138:             .Top       = 5
1139:             .AutoSize  = .F.

*-- Linhas 1245 a 1263:
1245:     * CarregarDados - Traz para a tela o lancamento que o form pai mandou
1246:     * editar. No legado isto nao existia como codigo: o SIGOPACC era aberto com
1247:     * o cursor crAltcc do pai ja posicionado no registro e TODOS os campos
1248:     * tinham ControlSource = "crAltcc.<coluna>". A arquitetura nova nao
1249:     * compartilha cursor entre telas, entao a PK chega por parametro (Init) e o
1250:     * BO le o registro (sigopaccBO.CarregarPorChave).
1251:     *
1252:     * Guarda tambem this_nOldContaPgs, que eh o "ThisForm.OldContaPgs =
1253:     * crAltcc.ContaPgs" do Init legado - o Cmd_Confirma.Click (Fase 7) compara
1254:     * o valor atual com ele para decidir o estorno de valpags.
1255:     *--------------------------------------------------------------------------
1256:     PROTECTED PROCEDURE CarregarDados()
1257:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
1258: 
1259:         loc_lSucesso = .F.
1260:         loc_oBO      = THIS.this_oBusinessObject
1261: 
1262:         TRY
1263:             IF VARTYPE(loc_oBO) != "O"

*-- Linhas 1376 a 1394:
1376:         THIS.txt_4c_HIST.Value            = loc_oBO.this_cHists
1377:         THIS.txt_4c_Hist2.Value           = loc_oBO.this_cHist2s
1378: 
1379:         *-- OptionGroup "Acerto": ControlSource legado eh crAltcc.contapgs
1380:         *-- direto, coluna numeric(1,0) 1-based (regra #45 - sem +1/-1).
1381:         *-- contapgs NAO esta limitado a 1..2: o proprio When do legado testa
1382:         *-- Inlist(Craltcc.contapgs, 3, 4). Medido no VFP9 (2026-10-16):
1383:         *-- atribuir .Value = 3 ou 4 a um OptionGroup com ButtonCount = 2
1384:         *-- devolve 0 em SILENCIO (nenhum botao marcado) - que eh exatamente o
1385:         *-- que o legado exibe nesse caso. Achatar para 2 "para ficar valido"
1386:         *-- faria o FormParaBO regravar 2 por cima de 3/4 (PILAR 2: nada de
1387:         *-- valor inventado). O valor original fica em this_nOldContaPgs e eh
1388:         *-- devolvido intacto pelo FormParaBO.
1389:         IF BETWEEN(loc_oBO.this_nContapgs, 1, THIS.obj_4c_Opcao_conta.ButtonCount)
1390:             THIS.obj_4c_Opcao_conta.Value = loc_oBO.this_nContapgs
1391:         ELSE
1392:             THIS.obj_4c_Opcao_conta.Value = 0
1393:         ENDIF
1394:     ENDPROC

*-- Linhas 1619 a 1650:
1619:             IF USED("cursor_4c_ValClasseGrp")
1620:                 USE IN cursor_4c_ValClasseGrp
1621:             ENDIF
1622:             SQLEXEC(gnConnHandle, "SELECT Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo), "cursor_4c_ValClasseGrp")
1623:             IF USED("cursor_4c_ValClasseGrp") AND RECCOUNT("cursor_4c_ValClasseGrp") > 0
1624:                 loc_cClasse = ALLTRIM(NVL(cursor_4c_ValClasseGrp.Classes, ""))
1625:             ENDIF
1626:             IF USED("cursor_4c_ValClasseGrp")
1627:                 USE IN cursor_4c_ValClasseGrp
1628:             ENDIF
1629:         ENDIF
1630: 
1631:         IF !EMPTY(loc_cClasse)
1632:             IF USED("cursor_4c_ValInvEmis")
1633:                 USE IN cursor_4c_ValInvEmis
1634:             ENDIF
1635:             SQLEXEC(gnConnHandle, "SELECT InvEmisCCs FROM SigCdCss WHERE Classes = " + EscaparSQL(loc_cClasse), "cursor_4c_ValInvEmis")
1636:             IF USED("cursor_4c_ValInvEmis") AND RECCOUNT("cursor_4c_ValInvEmis") > 0
1637:                 IF VARTYPE(cursor_4c_ValInvEmis.InvEmisCCs) = "L"
1638:                     loc_lInverter = cursor_4c_ValInvEmis.InvEmisCCs
1639:                 ELSE
1640:                     loc_lInverter = (NVL(cursor_4c_ValInvEmis.InvEmisCCs, 0) = 1)
1641:                 ENDIF
1642:             ENDIF
1643:             IF USED("cursor_4c_ValInvEmis")
1644:                 USE IN cursor_4c_ValInvEmis
1645:             ENDIF
1646:         ENDIF
1647: 
1648:         THIS.this_lInvEmisCCs = loc_lInverter
1649: 
1650:         IF loc_lInverter

*-- Linhas 1742 a 1760:
1742:             IF USED("cursor_4c_ValMoeCota")
1743:                 USE IN cursor_4c_ValMoeCota
1744:             ENDIF
1745:             SQLEXEC(gnConnHandle, "SELECT Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(par_cMoeda), "cursor_4c_ValMoeCota")
1746:             IF USED("cursor_4c_ValMoeCota") AND RECCOUNT("cursor_4c_ValMoeCota") > 0
1747:                 loc_lResultado = ConverterParaLogico(cursor_4c_ValMoeCota.Cotas)
1748:             ENDIF
1749:             IF USED("cursor_4c_ValMoeCota")
1750:                 USE IN cursor_4c_ValMoeCota
1751:             ENDIF
1752:         ENDIF
1753: 
1754:         RETURN loc_lResultado
1755:     ENDFUNC
1756: 
1757:     *--------------------------------------------------------------------------
1758:     * AtualizarVisibilidadeCambio - Calcula this_lMoedaTemCotas/
1759:     * this_lSMoedaTemCotas a partir da moeda JA CARREGADA (sem recalcular a
1760:     * cotacao vigente - o valor persistido no banco eh historico e nao pode

*-- Linhas 1944 a 1985:
1944:             USE IN cursor_4c_ValContrapartida
1945:         ENDIF
1946: 
1947:         loc_cSQL = "SELECT TOP 1 cidchaves FROM SigMvCcr" + ;
1948:             " WHERE Emps = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
1949:             " AND Nopers = " + FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNopers, 0) + ;
1950:             " AND cidchaves <> " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))
1951: 
1952:         SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValContrapartida")
1953: 
1954:         IF USED("cursor_4c_ValContrapartida") AND RECCOUNT("cursor_4c_ValContrapartida") > 0
1955:             loc_cResultado = ALLTRIM(cursor_4c_ValContrapartida.cidchaves)
1956:         ENDIF
1957: 
1958:         IF USED("cursor_4c_ValContrapartida")
1959:             USE IN cursor_4c_ValContrapartida
1960:         ENDIF
1961: 
1962:         RETURN loc_cResultado
1963:     ENDFUNC
1964: 
1965:     *--------------------------------------------------------------------------
1966:     * SalvarLancamento - Nucleo do Cmd_Confirma.Click legado (fora da
1967:     * validacao de campos, que fica em ValidarCamposObrigatoriosConfirma).
1968:     * Ver nota "Fase 7" no cabecalho do arquivo sobre o desvio arquitetural
1969:     * (UPDATE in place nas duas linhas do lancamento, em vez do
1970:     * delete-tudo-e-recria-tudo do cursor buffered legado).
1971:     *--------------------------------------------------------------------------
1972:     PROTECTED PROCEDURE SalvarLancamento()
1973:         LOCAL loc_oBO, loc_oBOCtra, loc_oErro, loc_lOk, loc_lJaExibiu
1974:         LOCAL loc_cCidCtrapartida, loc_nValPagsD, loc_nValPagsC, loc_cTransacao
1975:         LOCAL loc_cGrupoAnt, loc_cContaAnt, loc_cMoedaAnt, loc_dDataAnt
1976:         LOCAL loc_cGrupoCAnt, loc_cContaCAnt, loc_cMoedaCAnt
1977: 
1978:         loc_lOk     = .F.
1979:         loc_oBO     = THIS.this_oBusinessObject
1980:         loc_oBOCtra = .NULL.
1981: 
1982:         TRY
1983:             IF INLIST(THIS.this_cModoAtual, "INSERIR", "INCLUIR")
1984:                 *-- Caminho teorico (legado nunca abre o dialogo assim -
1985:                 *-- nota da Fase 5): grava so a linha principal, sem

*-- Linhas 1992 a 2011:
1992:             ELSE
1993:                 *-- ALTERAR: combos ANTIGOS (antes da edicao), para
1994:                 *-- recalculo do saldo do que esta sendo substituido
1995:                 *-- (legado: fRecalculaS sobre CsLog, lido ANTES do Update/
1996:                 *-- Delete em SigMvCcr).
1997:                 loc_cGrupoAnt  = ALLTRIM(loc_oBO.this_cGrupos)
1998:                 loc_cContaAnt  = ALLTRIM(loc_oBO.this_cContas)
1999:                 loc_cMoedaAnt  = ALLTRIM(loc_oBO.this_cMoedas)
2000:                 loc_dDataAnt   = ConverterParaData(loc_oBO.this_dDatas)
2001:                 loc_cGrupoCAnt = ALLTRIM(loc_oBO.this_cSgrupos)
2002:                 loc_cContaCAnt = ALLTRIM(loc_oBO.this_cScontas)
2003:                 loc_cMoedaCAnt = ALLTRIM(loc_oBO.this_cSmoedas)
2004:                 loc_nValPagsD  = loc_oBO.this_nValpags
2005: 
2006:                 loc_cCidCtrapartida = THIS.LocalizarCidContrapartida()
2007:                 IF !EMPTY(loc_cCidCtrapartida)
2008:                     loc_oBOCtra = CREATEOBJECT("sigopaccBO")
2009:                     IF VARTYPE(loc_oBOCtra) = "O" AND loc_oBOCtra.CarregarPorChave(loc_cCidCtrapartida)
2010:                         loc_nValPagsC = loc_oBOCtra.this_nValpags
2011:                         loc_oBOCtra.EditarRegistro()

*-- Linhas 2512 a 2530:
2512:         IF USED("cursor_4c_ValMoe")
2513:             USE IN cursor_4c_ValMoe
2514:         ENDIF
2515:         SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), "cursor_4c_ValMoe")
2516: 
2517:         IF !USED("cursor_4c_ValMoe") OR RECCOUNT("cursor_4c_ValMoe") = 0
2518:             IF USED("cursor_4c_ValMoe")
2519:                 USE IN cursor_4c_ValMoe
2520:             ENDIF
2521:             IF par_cLado == "D"
2522:                 THIS.AbrirLookupMoeda()
2523:             ELSE
2524:                 THIS.AbrirLookupSMoeda()
2525:             ENDIF
2526:             RETURN
2527:         ENDIF
2528: 
2529:         loc_lCotas = ConverterParaLogico(cursor_4c_ValMoe.Cotas)
2530:         loc_cValor = ALLTRIM(cursor_4c_ValMoe.CMoes)

*-- Linhas 2545 a 2565:
2545:             IF USED("cursor_4c_ValCot")
2546:                 USE IN cursor_4c_ValCot
2547:             ENDIF
2548:             SQLEXEC(gnConnHandle, "SELECT TOP 1 Valos FROM SigCdCot" + ;
2549:                 " WHERE Moedas = " + EscaparSQL(loc_cValor) + ;
2550:                 " AND Cotacaos <= " + FormatarDataSQL(loc_dData) + ;
2551:                 " ORDER BY Cotacaos DESC", "cursor_4c_ValCot")
2552:             IF USED("cursor_4c_ValCot") AND RECCOUNT("cursor_4c_ValCot") > 0
2553:                 loc_nCotacao = cursor_4c_ValCot.Valos
2554:             ENDIF
2555:             IF USED("cursor_4c_ValCot")
2556:                 USE IN cursor_4c_ValCot
2557:             ENDIF
2558:         ENDIF
2559: 
2560:         IF par_cLado == "D"
2561:             THIS.txt_4c_COTACAO.Value = loc_nCotacao
2562:             IF EMPTY(ALLTRIM(THIS.txt_4c_Smoeda.Value))
2563:                 THIS.txt_4c_Smoeda.Value   = THIS.txt_4c_MOEDA.Value
2564:                 THIS.txt_4c_SCOTACAO.Value = THIS.txt_4c_COTACAO.Value
2565:                 THIS.this_lSMoedaTemCotas  = loc_lCotas


### BO (C:\4c\projeto\app\classes\sigopaccBO.prg):
*============================================================================
* sigopaccBO.prg - Business Object para Lancamento de Conta Corrente
*
* Tabela principal : SigMvCcr  (PK: cidchaves char(20))
* Lookup grupo/conta: SigCdGrp / SigCdCta (ou equivalentes, grupo+conta normal e contrapartida)
* Lookup emissor    : SigCdGrp / SigCdCta (GrupEms / ContEms)
* Lookup job         : SigCdJob (ou equivalente)
* Lookup moeda       : SigCdMoe
*
* Este BO suporta um dialogo OPERACIONAL de ALTERACAO de um lancamento
* ja existente de SigMvCcr (edicao pontual de um registro de movimento de
* conta corrente), espelhando o comportamento do legado SIGOPACC.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopaccBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigMvCcr (campos do banco - chave e dados)
    *==========================================================================
    this_cCidchaves = ""   && char(20)      - Chave primaria (PK, fUniqueIds())
    this_dDatas      = {}  && datetime NULL - Data do lancamento
    this_cOpers      = ""  && char(1)       - Operacao (D/C)
    this_cDocus      = ""  && char(10)      - Documento
    this_cNfs        = ""  && char(10)      - Nota Fiscal
    this_nValors     = 0   && numeric(11,2) - Valor
    this_nCotacaos   = 0   && numeric(15,7) - Cotacao
    this_dVencs      = {}  && datetime NULL - Vencimento
    this_cHists      = ""  && char(60)      - Historico
    this_cHist2s     = ""  && char(80)      - Historico complementar
    this_cSopers     = ""  && char(1)       - Operacao contrapartida (D/C)
    this_nSvalors    = 0   && numeric(11,2) - Valor contrapartida
    this_nScotacaos  = 0   && numeric(15,7) - Cotacao contrapartida
    this_cGrupos     = ""  && char(10)      - Grupo
    this_cContas     = ""  && char(10)      - Conta
    this_cSgrupos    = ""  && char(10)      - Grupo contrapartida
    this_cScontas    = ""  && char(10)      - Conta contrapartida
    this_cMoedas     = ""  && char(3)       - Moeda
    this_cSmoedas    = ""  && char(3)       - Moeda contrapartida
    this_cGrupems    = ""  && char(10)      - Grupo emissor
    this_cContems    = ""  && char(10)      - Conta emissor
    this_cJobs       = ""  && char(10)      - Job
    this_nContapgs   = 0   && numeric(1,0)  - Conta a Pagar (flag/opcao do lancamento original)
    this_cCotusus    = ""  && char(10)      - Usuario que alterou a cotacao

    *==========================================================================
    * Propriedades das demais colunas de SigMvCcr (nao editadas na tela, mas
    * obrigatorias no INSERT - regra #22 CLAUDE.md: INSERT cobre TODA coluna
    * NOT NULL). Nomeadas como as colunas do schema (docs/schema.sql).
    *==========================================================================
    this_lAutos      = .F.  && bit           - autos
    this_lConcs      = .F.  && bit           - concs
    this_cContages   = ""   && char(10)      - contages
    this_dDatalts    = {}   && datetime NULL - datalts (data de alteracao)
    this_dDataconcs  = {}   && datetime NULL - dataconcs
    this_dDatatrans  = {}   && datetime NULL - datatrans
    this_dDatexcs    = {}   && datetime NULL - datexcs
    this_cDopes      = ""   && char(20)      - dopes
    this_dDtemis     = {}   && datetime NULL - dtemis
    this_cEmps       = ""   && char(3)       - emps (empresa)
    this_cGrupages   = ""   && char(10)      - grupages
    this_cLocals     = ""   && char(10)      - locals
    this_nNlancs     = 0    && numeric(6,0)  - nlancs
    this_nNopers     = 0    && numeric(7,0)  - nopers (numero da operacao)
    this_nNtrans     = 0    && numeric(6,0)  - ntrans
    this_nNumes      = 0    && numeric(6,0)  - numes
    this_nSaldocs    = 0    && numeric(15,2) - saldocs
    this_nSaldons    = 0    && numeric(15,2) - saldons
    this_nSaldos     = 0    && numeric(15,2) - saldos
    this_cShists     = ""   && char(40)      - shists
    this_cTipos      = ""   && char(1)       - tipos
    this_cTitbans    = ""   && char(12)      - titbans
    this_cTitulos    = ""   && char(10)      - titulos
    this_cUsualts    = ""   && char(10)      - usualts (usuario que alterou)
    this_cUsuexcs    = ""   && char(10)      - usuexcs
    this_nValliqs    = 0    && numeric(11,2) - valliqs
    this_nValocurs   = 0    && numeric(11,2) - valocurs
    this_nValpags    = 0    && numeric(11,2) - valpags
    this_cVlancs     = ""   && char(10)      - vlancs
    this_cVopers     = ""   && char(13)      - vopers
    this_cDopcs      = ""   && char(20)      - dopcs
    this_nNumcs      = 0    && numeric(6,0)  - numcs
    this_cBcontas    = ""   && char(10)      - bcontas
    this_cBgrupos    = ""   && char(10)      - bgrupos
    this_nBorderos   = 0    && numeric(6,0)  - borderos
    this_nIntconts   = 0    && numeric(6,0)  - intconts
    this_cUsuconcs   = ""   && char(10)      - usuconcs
    this_cAuditors   = ""   && char(10)      - auditors
    this_dDtaudits   = {}   && datetime NULL - dtaudits
    this_nValprev    = 0    && numeric(11,2) - valprev
    this_cEmpdopncs  = ""   && char(29)      - empdopncs (posicional: emps+dopes+numcs)
    this_cEmpdopnums = ""   && char(29)      - empdopnums (posicional: emps+dopes+numes)
    this_cGruconmoes = ""   && char(23)      - gruconmoes (grupos+contas+moedas)
    this_cPagos      = ""   && char(1)       - pagos (0/1 conforme valors = valpags)
    this_cDopotps    = ""   && char(23)      - dopotps
    this_cUsupagos   = ""   && char(10)      - usupagos
    this_nTitcancs   = 0    && numeric(1,0)  - titcancs
    this_dDtconfs    = {}   && datetime NULL - dtconfs
    this_cUsuconfs   = ""   && char(10)      - usuconfs
    this_nNopercancs = 0    && numeric(7,0)  - nopercancs
    this_cEspecienfs = ""   && char(6)       - especienfs
    this_nImpostos   = 0    && numeric(11,2) - impostos
    this_nTpimpostos = 0    && numeric(2,0)  - tpimpostos
    this_cTitpais    = ""   && char(10)      - titpais
    this_cEmpccs     = ""   && char(3)       - empccs
    this_nRecor      = 0    && numeric(1,0)  - recor
    this_cCompet     = ""   && char(7)       - compet
    this_cEmpos      = ""   && char(3)       - empos
    this_cOridopnums = ""   && char(29)      - oridopnums
    this_cPastas     = ""   && text NULL     - pastas
    this_cRcontas    = ""   && char(10)      - rcontas
    this_cTpdocnf    = ""   && char(2)       - tpdocnf

    *==========================================================================
    * Propriedades de controle da tela - nao persistidas diretamente
    *==========================================================================
    this_cUsuario     = ""  && Usuario corrente exibido no cabecalho (auditoria)
    this_nOpcaoConta  = 0   && OptionGroup Acerto (D/C) - indice 1-based

    *==========================================================================
    * Propriedades de exibicao (descricoes de lookup) - nao armazenadas no banco
    *==========================================================================
    this_cDescGrupo    = ""  && Descricao do Grupo (this_cGrupos)
    this_cDescConta    = ""  && Descricao da Conta (this_cContas)
    this_cDescSGrupo   = ""  && Descricao do Grupo contrapartida (this_cSgrupos)
    this_cDescSConta   = ""  && Descricao da Conta contrapartida (this_cScontas)
    this_cDescGrupEms  = ""  && Descricao do Grupo emissor (this_cGrupems)
    this_cDescContEms  = ""  && Descricao da Conta emissor (this_cContems)
    this_cDescJob      = ""  && Descricao do Job (this_cJobs)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
            *-- this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio
            *-- o objeto de acesso a dados fica .NULL. e todo metodo herdado
            *-- que depende dele (Buscar) devolve .F. com "Objeto de acesso a
            *-- dados nao inicializado".
            DODEFAULT("SigMvCcr")
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso em
    * RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * CarregarPorChave - Le UM lancamento de SigMvCcr pela PK (cidchaves) e
    * popula as propriedades do BO atraves de CarregarDoCursor().
    *
    * No legado o registro ja chegava posicionado: o form pai mantinha o cursor
    * crAltcc e o SIGOPACC lia tudo por ControlSource. A arquitetura nova nao
    * compartilha cursor entre telas, entao quem abre o dialogo passa a PK e o
    * BO busca o registro.
    *
    * SQLEXEC direto (mesmo estilo de Inserir/Atualizar deste BO) em vez do
    * Buscar() herdado: aqui o nome do cursor e EXPLICITO, em vez de depender
    * do default interno do DataAccess ("cur" + tabela).
    *==========================================================================
    PROCEDURE CarregarPorChave(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCidchaves) != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
                THIS.this_cMensagemErro = "Chave do lan" + CHR(231) + "amento n" + CHR(227) + "o informada."
            ELSE
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvCcr" + ;
                    " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao ler o lan" + CHR(231) + "amento." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "sigopaccBO.CarregarPorChave")
                    THIS.this_lErroExibido = .T.
                ELSE
                    IF RECCOUNT("cursor_4c_Dados") = 0
                        THIS.this_cMensagemErro = "Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado."
                    ELSE
                        SELECT cursor_4c_Dados
                        GO TOP
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Dados")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "sigopaccBO.CarregarPorChave")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL (SELECT * FROM
    * SigMvCcr) para as propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor)
    * antes de acessar os campos (regra #8 CLAUDE.md).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cContems = TratarNulo(contems, "")
                THIS.this_nCotacaos = TratarNulo(cotacaos, 0)
                THIS.this_dDatalts = TratarNulo(datalts, {})
                THIS.this_dDatas = TratarNulo(datas, {})
                THIS.this_dDataconcs = TratarNulo(dataconcs, {})
                THIS.this_dDatatrans = TratarNulo(datatrans, {})
                THIS.this_dDatexcs = TratarNulo(datexcs, {})
                THIS.this_cDocus = TratarNulo(docus, "")
                THIS.this_cDopes = TratarNulo(dopes, "")
                THIS.this_dDtemis = TratarNulo(dtemis, {})
                THIS.this_cEmps = TratarNulo(emps, "")
                THIS.this_cGrupages = TratarNulo(grupages, "")
                THIS.this_cGrupems = TratarNulo(grupems, "")
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cHists = TratarNulo(hists, "")
                THIS.this_cLocals = TratarNulo(locals, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_cNfs = TratarNulo(nfs, "")
                THIS.this_nNlancs = TratarNulo(nlancs, 0)
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nNtrans = TratarNulo(ntrans, 0)
                THIS.this_nNumes = TratarNulo(numes, 0)
                THIS.this_cOpers = TratarNulo(opers, "")
                THIS.this_nSaldocs = TratarNulo(saldocs, 0)
                THIS.this_nSaldons = TratarNulo(saldons, 0)
                THIS.this_nSaldos = TratarNulo(saldos, 0)
                THIS.this_cScontas = TratarNulo(scontas, "")
                THIS.this_nScotacaos = TratarNulo(scotacaos, 0)
                THIS.this_cSgrupos = TratarNulo(sgrupos, "")
                THIS.this_cShists = TratarNulo(shists, "")
                THIS.this_cSmoedas = TratarNulo(smoedas, "")
                THIS.this_cSopers = TratarNulo(sopers, "")
                THIS.this_nSvalors = TratarNulo(svalors, 0)
                THIS.this_cTipos = TratarNulo(tipos, "")
                THIS.this_cTitbans = TratarNulo(titbans, "")
                THIS.this_cTitulos = TratarNulo(titulos, "")
                THIS.this_cUsualts = TratarNulo(usualts, "")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "")
                THIS.this_nValliqs = TratarNulo(valliqs, 0)
                THIS.this_nValocurs = TratarNulo(valocurs, 0)
                THIS.this_nValors = TratarNulo(valors, 0)
                THIS.this_nValpags = TratarNulo(valpags, 0)
                THIS.this_dVencs = TratarNulo(vencs, {})
                THIS.this_cVlancs = TratarNulo(vlancs, "")
                THIS.this_cVopers = TratarNulo(vopers, "")
                THIS.this_nContapgs = TratarNulo(contapgs, 0)
                THIS.this_cDopcs = TratarNulo(dopcs, "")
                THIS.this_nNumcs = TratarNulo(numcs, 0)
                THIS.this_cCotusus = TratarNulo(cotusus, "")
                THIS.this_cBcontas = TratarNulo(bcontas, "")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "")
                THIS.this_nBorderos = TratarNulo(borderos, 0)
                THIS.this_cHist2s = TratarNulo(hist2s, "")
                THIS.this_nIntconts = TratarNulo(intconts, 0)
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "")
                THIS.this_cAuditors = TratarNulo(auditors, "")
                THIS.this_dDtaudits = TratarNulo(dtaudits, {})
                THIS.this_nValprev = TratarNulo(valprev, 0)
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "")
                THIS.this_cPagos = TratarNulo(pagos, "")
                THIS.this_cDopotps = TratarNulo(dopotps, "")
                THIS.this_cUsupagos = TratarNulo(usupagos, "")
                THIS.this_nTitcancs = TratarNulo(titcancs, 0)
                THIS.this_dDtconfs = TratarNulo(dtconfs, {})
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "")
                THIS.this_nNopercancs = TratarNulo(nopercancs, 0)
                THIS.this_cEspecienfs = TratarNulo(especienfs, "")
                THIS.this_cJobs = TratarNulo(jobs, "")
                THIS.this_nImpostos = TratarNulo(impostos, 0)
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, 0)
                THIS.this_cTitpais = TratarNulo(titpais, "")
                THIS.this_cEmpccs = TratarNulo(empccs, "")
                THIS.this_nRecor = TratarNulo(recor, 0)
                THIS.this_cCompet = TratarNulo(compet, "")
                THIS.this_cEmpos = TratarNulo(empos, "")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "")
                THIS.this_cPastas = TratarNulo(pastas, "")
                THIS.this_cRcontas = TratarNulo(rcontas, "")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo lancamento em SigMvCcr
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(NVL(THIS.this_cEmps, "")))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            THIS.this_cUsualts = gc_4c_UsuarioLogado
            THIS.this_dDatalts = DATETIME()

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
            THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza lancamento existente em SigMvCcr (por cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts = gc_4c_UsuarioLogado
            THIS.this_dDatalts = DATETIME()

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
            THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

