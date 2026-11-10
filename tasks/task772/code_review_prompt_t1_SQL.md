# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SERVICOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, EMPDNPS, CMATS, NOPS, CPROS, LNNODE, PNNODEEXP, CUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, EMPDNPS, CMATS, NOPS, CPROS, LNNODE, PNNODEEXP, CUN

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
m.loTree1.SelectedStyle = 2
m.loTree1.SelectedStyle = 2
Delete File (ThisForm.Arqfigura)
	lcQuery = [SELECT b.Cidchaves,a.Nenvs,  a.EmpDnPs, b.Datas, b.Grupoos, b.Contaos, b.grupods, b.contads, ] + ;
			  [from SigCdNei a, SigCdNec b, SigCdPro c ] + ;
	If ThisForm.poDataMgr.SqlExecute(lcQuery,'TmpNensi') < 1
	Select TmpNensi
	Select EmpDnPs, Sum(Pesos) as Pesos From TmpNensi Where Not Servicos;
	Select a.*, b.Pesos as TotPesos From TmpNensi a, TmpNens b Where ;
	lcQuery = [SELECT distinct b.CidChaves,a.Nops as Nenvs, a.EmpDnPs, b.Datas, ]+;
			  [from SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d ]+;
			  [SELECT distinct b.CidChaves,a.Nenvs, a.EmpDnPs, b.Datas, ]+;
			  [from SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d ]+;
	If ThisForm.poDataMgr.SqlExecute(lcQuery,'TmpNensi') < 1
	Select TmpNensi
		lcQuery = [SELECT b.cidchaves,a.Nops as Nenvs, a.EmpDnPs, b.Datas, ]+;
				  [from SigPdMvf a, SigCdNec b ]+;
		If ThisForm.poDataMgr.SqlExecute(lcQuery,'TmpNensi') < 1
		Select TmpNensi
	lcSql = [Select cpros, dpros, FigJpgs From SigCdPro Where Cpros = ']+lcProduto+[']
	If Thisform.Podatamgr.Sqlexecute(lcSql,'CrTmpPro') < 1
	Select EmpDnPs, Sum(Pesos) as TotPesos From TmpNensi Where Not Servicos ;
	Select a.*, b.TotPesos From TmpNensi a, TmpNens b Where a.EmpDnps = b.EmpDnPs ;
Select crTmpPro
		Delete File (lcArquivo)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.prg) - TRECHOS RELEVANTES PARA PASS SQL (2160 linhas total):

*-- Linhas 55 a 83:
55: * NodeFontBold). Medicao que dispensa Grid/CRUD neste legado, feita sobre
56: * tasks\task772\SIGOPNOP_form_codigo_fonte.txt: ZERO "BaseClass: grid",
57: * ZERO "BaseClass: pageframe", ZERO .AddCursor(/pColuna/RecordSource/
58: * ControlSource, UM "BaseClass: olecontrol" e 7 chamadas da API de nos.
59: *   CarregarDados()           -> escolhe o criterio (O.P. ou Envelope -
60: *     mutuamente exclusivos no legado), chama SIGOPNOPBO.PesquisarPorOP/
61: *     PesquisarPorEnvelope e desenha a arvore. Equivale aos dois Valid do
62: *     legado (Container1.GetOP.Valid -> MakeTree, Container1.GetEnvelope.
63: *     Valid -> MakeTreeEnv).
64: *   PopularArvore()           -> transcricao dos PROCEDURE maketree e
65: *     maketreeenv (mesmo algoritmo, cinco textos/icones diferentes).
66: *   PrepararArvore()          -> os seis AddImage do Init legado (uma unica
67: *     vez - os indices 1..6 do AddPictureNode sao fixos) e o bloco
68: *     ClearNodes/TipsDisplay/SmallIcons/PicAlign/SelectedStyle/PictureType
69: *     que os dois metodos legado repetem no inicio.
70: *   ExibirImagemProduto()     -> bloco da figura do produto do GetOP.Valid.
71: *   AdicionarNoOrigemDestino()/AdicionarNoMedida() -> os blocos de no que o
72: *     legado repete literalmente (2x e 3x por iteracao do Scan).
73: *   ArvoreDisponivel()        -> guarda do ActiveX (OCX ausente/modo teste).
74: *
75: * FASES 6/7 - EVENTOS PRINCIPAIS: ConfigurarEventos() liga os eventos dos
76: * dois campos digitaveis (GotFocus/Valid -> KeyPress em ENTER/TAB) e o Click
77: * dos tres botoes do legado (Encerrar/Expandir/Regredir).
78: *
79: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO: fecham-se os TRES ultimos
80: * metodos com codigo do dump que ainda nao tinham equivalente, completando a
81: * cobertura de 100% da SECAO 3 (17 metodos - ver a tabela de cobertura no fim
82: * deste cabecalho):
83: *   TreeViewKeyPress()      -> TreeView.KeyPress  (ESC)

*-- Linhas 114 a 132:
114: *     O SCX declara TRES botoes e nenhum persiste nada: Commandgroup1
115: *     ("Encerrar", Cancel = .T.) fecha a tela, e Fwbtng1/Fwbtng2 - icone puro,
116: *     Caption = "", verbo so no ToolTipText "Expandir"/"Regredir" - mexem no
117: *     nivel de expansao da arvore. Nao ha Insert/Update/Delete/TableUpdate em
118: *     lugar nenhum do dump: esta tela ANALISA. A acao dela eh disparada pelos
119: *     CAMPOS (Valid -> consulta -> arvore), nao por botao.
120: *
121: * LINHAS DO LEGADO DELIBERADAMENTE NAO REPRODUZIDAS (e por que):
122: *   Init: "Keyboard Chr(32)" + "=Inkey(0)"
123: *     Idioma Fortyus de descarte de tecla ja digitada antes de instanciar o
124: *     ActiveX - enfileira um espaco e o consome na hora, com o retorno
125: *     jogado fora. Nao persiste, nao abre tela, nao retem calculo: eh ruido
126: *     de UI. Reproduzi-lo injetaria um espaco no primeiro campo com foco.
127: *   NodeClick: as tres atribuicoes a GetcEmp/GetDopes/GetNumes
128: *     Os tres TextBox NAO EXISTEM no SCX - ver TreeViewNodeClick, que mede
129: *     isso e explica o que entrou no lugar (a property this_cChaveNavegacao).
130: *   TreeView.DblClick e Commandgroup1.Command3.When / GetEnvelope.When
131: *     O primeiro esta VAZIO no dump; os outros dois sao "Return(.t.)" puro.
132: *     Nao ha efeito a reproduzir.

*-- Linhas 208 a 226:
208: 	*-- ThisForm.Arqfigura - caminho do .jpg temporario extraido de
209: 	*-- SigCdPro.FigJpgs (ver SIGOPNOPBO.this_cArquivoImagem/
210: 	*-- BuscarImagemProduto/ExcluirImagemTemporaria). Apagado ao Encerrar
211: 	*-- (Commandgroup1.Command1.Click no legado: "Delete File
212: 	*-- (ThisForm.Arqfigura)").
213: 	this_cArquivoFigura = ""
214: 
215: 	*-- ThisForm.plDblClick - cargo (NodeCargo) do ultimo no clicado na
216: 	*-- arvore, usado pelo TreeView.NodeClick para distinguir o 1o clique
217: 	*-- (so seleciona) do 2o clique no MESMO no (drill - dispara MakeTree).
218: 	this_cUltimoNoClicado = ""
219: 
220: 	*-- Chave de navegacao CORRENTE (Emps + Dopes + Str(Numes)). No legado ela
221: 	*-- nao mora numa property: mora em TRES TextBox - Container1.GetcEmp,
222: 	*-- Container1.GetDopes e Container1.GetNumes -, que o NodeClick le e
223: 	*-- reescreve. Esses tres controles NAO EXISTEM no SCX (a SECAO 1 do dump
224: 	*-- lista, dentro do Container1, apenas TreeView, Label3, Label1,
225: 	*-- GetEnvelope e GetOP) - sobraram so as referencias a eles no codigo do
226: 	*-- NodeClick. Reproduzir os tres controles seria INVENTAR tela que o

*-- Linhas 800 a 818:
800: 	* do campo) e BINDEVENT em "Valid" NAO dispara de forma confiavel em
801: 	* TextBox. O substituto canonico eh "KeyPress" TESTANDO a tecla - ENTER(13)
802: 	* e TAB(9), as duas que saem do campo. "LostFocus" esta proibido aqui pela
803: 	* regra oposta: o handler chama CarregarDados (SQLEXEC + redesenho da
804: 	* arvore) e LostFocus dispara SEMPRE, inclusive pelo SetFocus de outro
805: 	* controle, o que produz recursao. A regra CLAUDE.md #47 (lookup tem de ir
806: 	* em LostFocus) NAO se aplica: ela trata de handler que abre PICKER sem
807: 	* testar a tecla - aqui nao ha picker e a tecla eh testada.
808: 	*
809: 	* GotFocus reproduz DUAS coisas do legado, que juntas fazem dos dois
810: 	* campos mutuamente exclusivos:
811: 	*   GetOP.GotFocus       -> "This.Parent.GetEnvelope.Value = 0"
812: 	*   GetEnvelope.GotFocus -> "This.Parent.GetOP.Value = 0"
813: 	* e, no caso do O.P., mais o When ("ThisForm.Imagem.Visible = .f."), cujo
814: 	* Return(.t.) esta COMENTADO no SCX - ou seja, o When legado so tem esse
815: 	* efeito colateral. Ele vai para o GotFocus por dois motivos: BINDEVENT
816: 	* DESCARTA o retorno do delegate (um When ligado por BINDEVENT nao
817: 	* bloquearia nada mesmo) e When/GotFocus disparam na MESMA entrada no
818: 	* campo, logo o efeito visivel eh identico. O When do GetEnvelope eh

*-- Linhas 894 a 912:
894: 	ENDPROC
895: 
896: 	*==========================================================================
897: 	* ValidarOP - GetOP.Valid do legado. A consulta (SELECT + UNION ALL +
898: 	* fallback de SigPdMvf + figura do produto) mora no SIGOPNOPBO e o desenho
899: 	* da arvore em PopularArvore; aqui fica so o GATILHO, com a guarda do
900: 	* legado e a do teclado.
901: 	*
902: 	* Os tres IF sao SEPARADOS de proposito: VFP9 NAO faz short-circuit em OR,
903: 	* entao juntar "VARTYPE(par_nKeyCode) != 'N' OR par_nKeyCode != 13"
904: 	* avaliaria a comparacao numerica tambem quando o argumento nao eh
905: 	* numerico, estourando "Operator/operand type mismatch".
906: 	*
907: 	* Os RETURN ficam todos FORA de qualquer TRY (regra CLAUDE.md #1).
908: 	*==========================================================================
909: 	PROCEDURE ValidarOP(par_nKeyCode, par_nShiftAltCtrl)
910: 		LOCAL loc_nValor, loc_oErro
911: 
912: 		*-- KeyPress passa SEMPRE os dois argumentos, mas o handler tambem eh

*-- Linhas 994 a 1032:
994: 	*==========================================================================
995: 	* CmdEncerrarClick - Commandgroup1.Command3.Click do legado, as DUAS
996: 	* linhas, NESTA ordem:
997: 	*   Delete File (ThisForm.Arqfigura)
998: 	*   ThisForm.Release
999: 	*
1000: 	* O botao eh o UNICO do CommandGroup (ButtonCount = 1, Caption "Encerrar",
1001: 	* Cancel = .T.) - por isso o BINDEVENT vai em .Buttons(1) e nao no grupo:
1002: 	* o legado poe o codigo no BOTAO (Command3.Click), e o Click do GRUPO so
1003: 	* dispararia se o botao nao tivesse codigo proprio.
1004: 	*
1005: 	* (a) O "Delete File" mora no BO (SIGOPNOPBO.ExcluirImagemTemporaria), que
1006: 	* eh quem conhece o caminho do .jpg temporario extraido de SigCdPro.FigJpgs
1007: 	* e ja traz as duas defesas que o legado nao tem: IF FILE() antes de apagar
1008: 	* e SET SAFETY OFF em volta do DELETE FILE (com SAFETY ON ele abre dialogo
1009: 	* de confirmacao, e dialogo modal travaria o pipeline). O legado apaga as
1010: 	* cegas - e no caminho em que o produto NAO tem foto o Arqfigura dele
1011: 	* aponta para arquivo que nunca foi criado (ou para o " " do Init), entao o
1012: 	* Delete File legado erra ali. A guarda eh desvio DELIBERADO e invisivel ao
1013: 	* usuario (PILAR 1 preservado).
1014: 	*
1015: 	* (b) .Picture = "" ANTES de apagar: o controle Image mantem o arquivo
1016: 	* preso enquanto aponta para ele, e o CLEAR RESOURCES do BO sozinho nao
1017: 	* solta essa referencia. Sem isto o DELETE FILE falha e o .jpg fica para
1018: 	* tras em SYS(2023) a cada pesquisa. Nao tem efeito visivel - a tela esta
1019: 	* fechando - entao tambem nao mexe com o PILAR 1.
1020: 	*
1021: 	* (c) O TRY cobre SO a limpeza, e o Release fica FORA dele: falha ao apagar
1022: 	* um temporario nao pode impedir a tela de fechar, que eh a razao de existir
1023: 	* do botao. O CATCH nao eh silencioso (CLAUDE.md #9).
1024: 	*
1025: 	* (d) Release() e nao Hide(): esta tela NAO devolve resultado a chamador
1026: 	* nenhum - conferido, nao presumido. O dump do SCX nao tem PROCEDURE Unload
1027: 	* (logo nao existe "DO FORM ... TO"), o form nao tem property de retorno, e
1028: 	* nao ha um unico call site de SIGOPNOP no acervo legado nem no projeto
1029: 	* migrado. A regra do Hide
1030: 	* (feedback_release_mata_referencia_dialogo_usa_hide) vale para dialogo
1031: 	* FILHO cujo pai le o resultado depois do Show(); aqui Hide() deixaria o
1032: 	* objeto vivo segurando a datasession privada e os cursores dela.

*-- Linhas 1042 a 1060:
1042: 		LOCAL loc_oErro
1043: 
1044: 		TRY
1045: 			*-- (b) solta a referencia do Image antes do DELETE FILE
1046: 			THIS.img_4c_Imagem.Picture = ""
1047: 			THIS.img_4c_Imagem.Visible = .F.
1048: 
1049: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
1050: 				THIS.this_oBusinessObject.ExcluirImagemTemporaria()
1051: 			ENDIF
1052: 
1053: 			*-- Espelho de ThisForm.Arqfigura: o arquivo acabou de ser
1054: 			*-- apagado, entao a property nao pode seguir apontando para ele.
1055: 			THIS.this_cArquivoFigura = ""
1056: 		CATCH TO loc_oErro
1057: 			MsgErro("Falha ao apagar a imagem tempor" + CHR(225) + "ria: " + ;
1058: 					loc_oErro.Message + CHR(13) + ;
1059: 					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1060: 					"Procedure: " + loc_oErro.Procedure, "Erro")

*-- Linhas 1395 a 1431:
1395: 	* Produto (Clique Duplo Para Zoom)"):
1396: 	*
1397: 	*   lcArquivo = Sys(2023) + '\' + Sys(2015) + '.Jpg'
1398: 	*   Select crTmpPro
1399: 	*   If Not Empty(crTmpPro.FigJpgs) And Not IsNull(crTmpPro.FigJpgs)
1400: 	*       =StrToFile(crTmpPro.FigJpgs, lcArquivo)
1401: 	*   EndIf
1402: 	*   If File(lcArquivo)
1403: 	*       Do Form SigOpZom With lcArquivo, 'Produto : ' + crTmpPro.CPros + ' - ' + crTmpPro.DPros, ''
1404: 	*       Delete File (lcArquivo)
1405: 	*   EndIf
1406: 	*
1407: 	* O crTmpPro do legado eh o cursor_4c_Produto do BO (SIGOPNOPBO.
1408: 	* this_cCursorProduto), populado por BuscarImagemProduto no caminho da
1409: 	* O.P. - o mesmo SELECT cpros, dpros, FigJpgs From SigCdPro. O arquivo
1410: 	* daqui eh um temporario PROPRIO (SYS(2015) novo), separado do
1411: 	* this_cArquivoImagem que alimenta o img_4c_Imagem da tela: eh assim no
1412: 	* legado, e por isso ele apaga este e nao o outro.
1413: 	*
1414: 	* Tres desvios deliberados, nenhum visivel ao usuario:
1415: 	*   (a) a work area corrente eh salva e restaurada em volta do
1416: 	*       SELECT - o legado troca de area e nunca repoe;
1417: 	*   (b) STRTOFILE eh TESTADO (> 0) antes de tentar abrir o zoom, em vez de
1418: 	*       descartar o retorno com "=StrToFile(...)";
1419: 	*   (c) SET SAFETY OFF em volta do ERASE: com SAFETY ON o VFP9 abre
1420: 	*       dialogo de confirmacao, e dialogo modal trava o pipeline
1421: 	*       (CLAUDE.md #6). O legado apaga as cegas.
1422: 	*
1423: 	* NAO ha STRCONV/base64 aqui: o legado grava o memo FigJpgs direto com
1424: 	* StrToFile, e o BO desta task faz igual (SIGOPNOPBO.BuscarImagemProduto).
1425: 	* Acrescentar um STRCONV(...,14) decodificaria duas vezes a imagem de quem
1426: 	* grava JPG puro.
1427: 	*
1428: 	* PUBLIC (sem PROTECTED) porque eh alvo de BINDEVENT (CLAUDE.md #3).
1429: 	*==========================================================================
1430: 	PROCEDURE ImgImagemDblClick()
1431: 		LOCAL loc_cCursor, loc_cArquivo, loc_cProduto, loc_cDescProduto

*-- Linhas 1437 a 1468:
1437: 
1438: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorProduto
1439: 
1440: 		*-- "Select crTmpPro": sem o cursor do produto nao ha foto a ampliar
1441: 		*-- (acontece quando a pesquisa foi por Envelope - esse caminho do
1442: 		*-- legado nunca consulta SigCdPro).
1443: 		IF !USED(loc_cCursor)
1444: 			RETURN
1445: 		ENDIF
1446: 
1447: 		loc_cArquivo     = ""
1448: 		loc_cProduto     = ""
1449: 		loc_cDescProduto = ""
1450: 		loc_cAliasAnterior = ALIAS()
1451: 
1452: 		TRY
1453: 			SELECT (loc_cCursor)
1454: 
1455: 			IF !EOF()
1456: 				loc_cProduto     = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Cpros"), ""))
1457: 				loc_cDescProduto = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".Dpros"), ""))
1458: 
1459: 				*-- "If Not Empty(crTmpPro.FigJpgs) And Not IsNull(...)" -
1460: 				*-- TratarNulo cobre o IsNull (CLAUDE.md #27: EMPTY(.NULL.)
1461: 				*-- devolve .F., entao o EMPTY sozinho nao bastaria).
1462: 				loc_cFoto = TratarNulo(EVALUATE(loc_cCursor + ".FigJpgs"), "")
1463: 
1464: 				IF !EMPTY(loc_cFoto)
1465: 					loc_cArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + ".Jpg"
1466: 
1467: 					IF STRTOFILE(loc_cFoto, loc_cArquivo) <= 0
1468: 						loc_cArquivo = ""

*-- Linhas 1479 a 1500:
1479: 
1480: 		*-- (a) repoe a area de trabalho do chamador
1481: 		IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1482: 			SELECT (loc_cAliasAnterior)
1483: 		ENDIF
1484: 
1485: 		*-- "If File(lcArquivo) / Do Form SigOpZom ... / Delete File". O
1486: 		*-- Show() do dialogo filho fica FORA de qualquer TRY (CLAUDE.md #29).
1487: 		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
1488: 			THIS.AbrirFormZoomImagem(loc_cArquivo, loc_cProduto, loc_cDescProduto)
1489: 
1490: 			*-- (c) ERASE sem dialogo de confirmacao
1491: 			loc_cSafety = SET("SAFETY")
1492: 			SET SAFETY OFF
1493: 
1494: 			ERASE (loc_cArquivo)
1495: 
1496: 			IF loc_cSafety = "ON"
1497: 				SET SAFETY ON
1498: 			ENDIF
1499: 		ENDIF
1500: 	ENDPROC

*-- Linhas 1561 a 1579:
1561: 	* bloco de inicializacao que MakeTree e MakeTreeEnv repetem identicos no
1562: 	* inicio:
1563: 	*   loTree1.ClearNodes / TipsDisplay = .t. / ExpandOnDClick /
1564: 	*   SmallIcons = .t. / PicAlign = 0 / SelectedStyle = 2 / PictureType = 1
1565: 	*
1566: 	* As imagens entram UMA UNICA vez (this_lImagensArvore), como no Init
1567: 	* legado: AddImage empilha indices novos a cada chamada e os indices
1568: 	* 1..6 usados pelo AddPictureNode sao FIXOS no codigo do legado -
1569: 	* recarregar a cada pesquisa trocaria os icones de todos os nos (mesma
1570: 	* razao do flag em FormSIGMVMVT.PrepararArvore).
1571: 	*
1572: 	* Caminhos transcritos do Init legado, na MESMA ordem (eh a ordem que
1573: 	* define o indice). Cada linha do legado traz, COMENTADA ao lado, a versao
1574: 	* ANTERIOR do mesmo icone - que eh o alternativo usado aqui (ver abaixo):
1575: 	*   1 \imagens\geral_documento_26.jpg  (&&\vbmp\Form4.Ico)     raiz O.P.
1576: 	*   2 \imagens\geral_caixa_16.jpg      (&&\vbmp\depend3.bmp)   movim./material/medida
1577: 	*   3 \imagens\geral_pendencia_26.jpg  (&&\vbmp\OHist.Ico)     (reservado pelo legado)
1578: 	*   4 \imagens\geral_palete_26.jpg     (&&\vbmp\Replace.Ico)   material de SERVICO
1579: 	*   5 \vbmp\EnvMail.Bmp                (sem alternativo)       raiz Envelope

*-- Linhas 1622 a 1640:
1622: 					.ExpandOnDClick
1623: 					.SmallIcons    = .T.
1624: 					.PicAlign      = 0
1625: 					.SelectedStyle = 2
1626: 					.PictureType   = 1
1627: 				ENDWITH
1628: 			CATCH TO loc_oErro
1629: 				MsgErro("Falha ao preparar a " + CHR(225) + "rvore: " + ;
1630: 						loc_oErro.Message + CHR(13) + ;
1631: 						"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1632: 						"Procedure: " + loc_oErro.Procedure, "Erro")
1633: 			ENDTRY
1634: 		ENDIF
1635: 	ENDPROC
1636: 
1637: 	*==========================================================================
1638: 	* CarregarImagemArvore - UM AddImage do Init legado. Tenta primeiro o
1639: 	* arquivo da linha ATIVA do legado (par_cRelativoFramework, dentro de
1640: 	* gc_4c_CaminhoFramework) e, falhando, o arquivo que o legado nomeia no

*-- Linhas 1717 a 1740:
1717: 	* O "If ! Empty(This.Value)" que envolve os DOIS Valid do legado tambem eh
1718: 	* reproduzido: campo vazio nao consulta e nao avisa nada.
1719: 	*
1720: 	* A consulta em si (SELECT + UNION ALL + fallback de SigPdMvf + figura do
1721: 	* produto + agregacao de TotPesos) mora no SIGOPNOPBO (Fase 2); aqui fica
1722: 	* so o que eh de TELA: escolher o criterio, exibir a figura e desenhar a
1723: 	* arvore.
1724: 	*
1725: 	* O TRY cobre a chamada ao BO porque SQLEXEC com handle invalido DISPARA
1726: 	* excecao em vez de devolver -1 - sem ele o usuario veria o "Program Error"
1727: 	* CRU do VFP no lugar do dialogo do sistema. RETURN unico, DEPOIS do
1728: 	* ENDTRY (CLAUDE.md #1).
1729: 	*==========================================================================
1730: 	PROCEDURE CarregarDados()
1731: 		LOCAL loc_lSucesso, loc_nOP, loc_nEnvelope, loc_lPorEnvelope
1732: 		LOCAL loc_lAchou, loc_oErro, loc_cMensagem
1733: 
1734: 		loc_lSucesso = .F.
1735: 
1736: 		IF VARTYPE(THIS.this_oBusinessObject) != "O"
1737: 			MsgErro("Business Object indispon" + CHR(237) + "vel - n" + CHR(227) + ;
1738: 					"o foi poss" + CHR(237) + "vel consultar.", "Erro")
1739: 		ELSE
1740: 			loc_nOP       = THIS.cnt_4c_Container1.txt_4c_OP.Value

*-- Linhas 1814 a 1832:
1814: 
1815: 		loc_cArquivo = ALLTRIM(THIS.this_oBusinessObject.this_cArquivoImagem)
1816: 
1817: 		*-- ThisForm.Arqfigura = lcArquivo - apagado ao Encerrar ("Delete File
1818: 		*-- (ThisForm.Arqfigura)" no Click do Commandgroup1, Fase 7).
1819: 		THIS.this_cArquivoFigura = loc_cArquivo
1820: 
1821: 		CLEAR RESOURCES
1822: 
1823: 		THIS.img_4c_Imagem.Picture = ""
1824: 		THIS.img_4c_Imagem.Visible = .F.
1825: 
1826: 		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
1827: 			THIS.img_4c_Imagem.Picture = loc_cArquivo
1828: 			THIS.img_4c_Imagem.Visible = .T.
1829: 		ENDIF
1830: 	ENDPROC
1831: 
1832: 	*==========================================================================

*-- Linhas 1876 a 1894:
1876: 		SET DECIMALS TO 3
1877: 
1878: 		TRY
1879: 			SELECT (loc_cCursor)
1880: 			GO TOP
1881: 
1882: 			*-- ===== Nivel 1 - no raiz =====
1883: 			*-- maketree:    [O.P. : ] + Str(nEnvs) + [ - ] + Cpros +
1884: 			*--              Iif(nOpMaes > 0, [ - O.P. Mae: ] + Str(nOpMaes), [ ])
1885: 			*-- maketreeenv: [Envelope : ] + Str(nEnvs)
1886: 			IF loc_lPorEnvelope
1887: 				loc_cTexto = "Envelope : " + ALLTRIM(STR(TratarNulo(Nenvs, 0)))
1888: 				loc_nIcone = 5
1889: 			ELSE
1890: 				loc_cTexto = "O.P. : " + ALLTRIM(STR(TratarNulo(Nenvs, 0))) + " - " + ;
1891: 					TratarNulo(Cpros, "") + ;
1892: 					IIF(TratarNulo(NopMaes, 0) > 0, ;
1893: 						" - O.P. M" + CHR(227) + "e: " + ALLTRIM(STR(TratarNulo(NopMaes, 0))), ;
1894: 						" ")

*-- Linhas 1907 a 1925:
1907: 			loc_cOriDesAnt  = ""
1908: 
1909: 			SCAN
1910: 				*-- Servicos eh coluna bit no SQL Server e o SELECT do BO a
1911: 				*-- traz como CAST(... AS INT): chega NUMERICA ao cursor,
1912: 				*-- entao a comparacao tem de ser explicita (IIF exige logico
1913: 				*-- no 1o argumento - numerico estoura erro 11).
1914: 				loc_lServicos = (TratarNulo(Servicos, 0) = 1)
1915: 
1916: 				*-- EmpDnPs eh char(33) POSICIONAL = Emps(3) + Dopps(20) +
1917: 				*-- Str(Numps, 10). O PADR repoe as 33 posicoes antes de
1918: 				*-- fatiar - o legado fatia o campo do cursor direto, que ja
1919: 				*-- vem preenchido (CLAUDE.md #42: o padding FAZ PARTE da chave).
1920: 				loc_cChave = PADR(TratarNulo(EmpDnPs, ""), 33)
1921: 
1922: 				loc_cOriDes = TratarNulo(Grupoos, "") + TratarNulo(Contaos, "") + ;
1923: 					TratarNulo(Grupods, "") + TratarNulo(Contads, "")
1924: 
1925: 				*-- ===== Nivel 2 - movimentacao (quebra por EmpDnPs) =====

*-- Linhas 1955 a 1984:
1955: 					loc_cOriDesAnt = loc_cOriDes
1956: 
1957: 					IF USED(loc_cCursor)
1958: 						SELECT (loc_cCursor)
1959: 					ENDIF
1960: 				ENDIF
1961: 
1962: 				*-- ===== Nivel 3 - Origem/Destino (quebra DENTRO da mesma
1963: 				*-- movimentacao). O legado repete o IF, nao usa ELSE. =====
1964: 				IF !(loc_cOriDesAnt == loc_cOriDes)
1965: 					THIS.AdicionarNoOrigemDestino()
1966: 					loc_cOriDesAnt = loc_cOriDes
1967: 
1968: 					IF USED(loc_cCursor)
1969: 						SELECT (loc_cCursor)
1970: 					ENDIF
1971: 				ENDIF
1972: 
1973: 				*-- ===== Nivel 4 - material =====
1974: 				*-- maketree:    Alltrim(cMats) + [ - ] + Alltrim(dPros)
1975: 				*-- maketreeenv: Iif(nOps = 0, [], Alltrim(Str(nOps)) + [ - ]) +
1976: 				*--              Alltrim(cMats) + [ - ] + Alltrim(dPros)
1977: 				loc_cTexto = IIF(loc_lPorEnvelope, ;
1978: 						IIF(TratarNulo(Nops, 0) = 0, "", ;
1979: 							ALLTRIM(STR(TratarNulo(Nops, 0))) + " - "), ;
1980: 						"") + ;
1981: 					ALLTRIM(TratarNulo(Cmats, "")) + " - " + ;
1982: 					ALLTRIM(TratarNulo(Dpros, ""))
1983: 
1984: 				WITH THIS.cnt_4c_Container1.obj_4c_TreeView


### BO (C:\4c\projeto\app\classes\SIGOPNOPBO.prg):
*==============================================================================
* SIGOPNOPBO.PRG
* Business Object para FormSIGOPNOP - Analise de OP/Envelopes
*
* Form OPERACIONAL de consulta (sem tabela unica): pesquisa movimentacoes de
* producao por numero de Envelope (SigCdNei/SigCdNec) ou por numero de O.P.
* (SigCdNei/SigCdNec/SigOpPic/SigPdMvf), monta a arvore de resultado e exibe
* a figura do produto (SigCdPro.FigJpgs) extraida para arquivo temporario.
*==============================================================================

DEFINE CLASS SIGOPNOPBO AS BusinessBase

	*-- Criterios de pesquisa (espelham Container1.GetOP e Container1.GetEnvelope do legado)
	this_nNumeroOP = 0
	this_nNumeroEnvelope = 0

	*-- Cursores de resultado populados pelas pesquisas (Fase 2)
	this_cCursorArvore = "cursor_4c_Arvore"
	this_cCursorProduto = "cursor_4c_Produto"
	this_lRegistroEncontrado = .F.

	*-- Figura do produto extraida de SigCdPro.FigJpgs para arquivo temporario
	this_cArquivoImagem = ""

	*-- REGISTRO CORRENTE da arvore de resultado (THIS.this_cCursorArvore),
	*-- carregado por CarregarDoCursor(). Os nomes espelham as colunas do cursor
	*-- (que por sua vez espelham as colunas do legado lidas no Scan de
	*-- MakeTree/MakeTreeEnv sobre CrSigCdNei).
	this_cCidchaves = ""
	this_nNenvs = 0
	this_cEmpDnPs = ""
	this_dDatas = {}
	this_cGrupoos = ""
	this_cContaos = ""
	this_cGrupods = ""
	this_cContads = ""
	this_lServicos = .F.
	this_nNops = 0
	this_cCmats = ""
	this_cDpros = ""
	this_nQtds = 0
	this_cCunis = ""
	this_nPeso2s = 0
	this_cCunips = ""
	this_nPesos = 0
	this_nTotPesos = 0
	this_cCpros = ""
	this_nNopMaes = 0

	*-- Decomposicao POSICIONAL de EmpDnPs char(33) = Emps(3) + Dopps(20) +
	*-- Str(Numps, 10). O legado decompoe assim no TreeView.DblClick:
	*-- Left(NodeCargo,3) / Substr(NodeCargo,4,20) / Val(Alltrim(Substr(NodeCargo,24)))
	this_cEmps = ""
	this_cDopps = ""
	this_nNumps = 0

	*==============================================================================
	* Init - Inicializa Business Object
	*==============================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Consulta multi-tabela (SigCdNei/SigCdNec/SigCdPro/SigOpPic/SigPdMvf):
		*-- nao existe tabela mestre unica. O registro eh identificado pela chave de
		*-- movimentacao EmpDnPs char(33), compartilhada pelas tabelas envolvidas.
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = "EmpDnPs"

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_cCursorArvore = "cursor_4c_Arvore"
		THIS.this_cCursorProduto = "cursor_4c_Produto"
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""

		THIS.ResetarRegistroCorrente()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
	* sobrescritos aqui: este form eh de CONSULTA (pesquisa movimentacoes de
	* producao por Envelope ou O.P. em SigCdNei/SigCdNec/SigCdPro/SigOpPic/
	* SigPdMvf), sem INSERT/UPDATE/DELETE no legado - o unico efeito colateral
	* eh a extracao da figura do produto para um arquivo temporario (apagado ao
	* Encerrar). O comportamento padrao herdado de BusinessBase para
	* Inserir/Atualizar/ExecutarExclusao/RegistrarAuditoria ja eh o correto para
	* este BO.
	*
	* Conferido no dump legado (SIGOPNOP_form_codigo_fonte.txt): ZERO ocorrencia
	* de TABLEUPDATE(, ZERO de .AddCursor( e ZERO alvo de Insert Into / Update /
	* Delete From. O unico Delete do legado eh "Delete File (ThisForm.Arqfigura)",
	* que apaga o arquivo temporario da figura e nao toca no banco - reproduzido
	* aqui em ExcluirImagemTemporaria(). Inventar um INSERT/UPDATE para este BO
	* exigiria adivinhar a lista de colunas, o que a regra #22 do CLAUDE.md
	* proibe (a lista vem do schema, nunca de adivinhacao).
	*
	* ObterChavePrimaria() SIM eh sobrescrito, porque a identidade do registro
	* corrente (EmpDnPs) nao eh derivavel de this_cTabela/this_cCampoChave.
	*==============================================================================

	*==============================================================================
	* PesquisarPorEnvelope - Pesquisa movimentacoes de producao por numero de
	* Envelope. Equivale ao PROCEDURE Valid de Container1.GetEnvelope no legado
	* (SigCdNei/SigCdNec/SigCdPro), que monta o cursor CrSigCdNei consumido pela
	* arvore (ThisForm.MakeTreeEnv no legado).
	*==============================================================================
	PROCEDURE PesquisarPorEnvelope(par_nNumeroEnvelope)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroEnvelope) != "N" OR par_nNumeroEnvelope = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroEnvelope = par_nNumeroEnvelope

		loc_cSQL = "SELECT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, b.Grupoos, b.Contaos, " + ;
			"b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, a.Nops, a.Cmats, c.Dpros, a.Qtds, c.Cunis, " + ;
			"a.Peso2s, c.Cunips, a.Pesos, SPACE(14) AS Cpros, 0 AS NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroEnvelope, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			THIS.this_cMensagemErro = "Envelope N" + CHR(227) + "o Localizado !!!"
			USE IN cursor_4c_Nensi
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* PesquisarPorOP - Pesquisa movimentacoes de producao por numero de O.P.
	* Equivale ao PROCEDURE Valid de Container1.GetOP no legado: primeiro tenta a
	* consulta de movimentacao normal (SigCdNei/SigCdNec/SigCdPro/SigOpPic, nos
	* dois sentidos - O.P. propria e O.P. filha de um Envelope); se nao encontrar
	* nada, cai no fallback de O.P. ainda sem movimentacao gerada (SigPdMvf/
	* SigCdNec). Em qualquer dos dois casos, busca a figura do produto em
	* SigCdPro e extrai para arquivo temporario (THIS.this_cArquivoImagem).
	*==============================================================================
	PROCEDURE PesquisarPorOP(par_nNumeroOP)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cProduto

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroOP) != "N" OR par_nNumeroOP = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroOP = par_nNumeroOP

		loc_cSQL = "SELECT DISTINCT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nops = d.Nops " + ;
			"UNION ALL " + ;
			"SELECT DISTINCT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.Nops <> " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nenvs = d.Nops " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			*-- O.P. ainda sem movimentacao gerada - cai no fallback de SigPdMvf,
			*-- igual ao legado ("Nenhum" material agregado, pesos/qtds zerados)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF

			loc_cSQL = "SELECT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
				"b.Grupoos, b.Contaos, b.Grupods, b.Contads, 0 AS Servicos, " + ;
				"0 AS Nops, 'Nenhum        ' AS Cmats, " + ;
				"'Nenhum Material Agregado' AS Dpros, 0 AS Qtds, '   ' AS Cunis, " + ;
				"0 AS Peso2s, '   ' AS Cunips, 0 AS Pesos, a.CodPds AS Cpros, 0 AS NopMaes " + ;
				"FROM SigPdMvf a, SigCdNec b " + ;
				"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
				" AND a.EmpDnPs = b.EmpDnPs " + ;
				"ORDER BY b.Cidchaves, a.Nops"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
				RETURN .F.
			ENDIF

			SELECT cursor_4c_Nensi
			GO TOP

			IF EOF("cursor_4c_Nensi")
				THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada !!!"
				USE IN cursor_4c_Nensi
				RETURN .F.
			ENDIF
		ENDIF

		loc_cProduto = ALLTRIM(cursor_4c_Nensi.Cpros)

		IF !THIS.BuscarImagemProduto(loc_cProduto)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarCursorArvore - Agrupa os pesos por movimentacao (EmpDnPs, excluindo
	* linhas de servico) e junta o total (TotPesos) a cada linha do cursor de
	* origem, gravando o resultado em THIS.this_cCursorArvore. Equivale ao bloco
	* final repetido no Valid de GetEnvelope e de GetOP do legado (Select ...
	* Sum(Pesos) ... Group by 1 + Select a.*, b.TotPesos ... Into Cursor
	* CrSigCdNei Order by CidChaves, Nops, Cmats).
	*==============================================================================
	PROTECTED PROCEDURE MontarCursorArvore(par_cCursorOrigem)
		LOCAL loc_cCursorTotais

		loc_cCursorTotais = "cursor_4c_Totais"

		IF !USED(par_cCursorOrigem)
			RETURN .F.
		ENDIF

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		SELECT EmpDnPs, SUM(Pesos) AS TotPesos FROM (par_cCursorOrigem) WHERE Servicos = 0 ;
			INTO CURSOR (loc_cCursorTotais) GROUP BY 1

		IF USED(THIS.this_cCursorArvore)
			USE IN (THIS.this_cCursorArvore)
		ENDIF

		SELECT a.*, b.TotPesos FROM (par_cCursorOrigem) a, (loc_cCursorTotais) b ;
			WHERE a.EmpDnPs = b.EmpDnPs ;
			INTO CURSOR (THIS.this_cCursorArvore) READWRITE ;
			ORDER BY a.CidChaves, a.Nops, a.Cmats

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		RETURN USED(THIS.this_cCursorArvore) AND RECCOUNT(THIS.this_cCursorArvore) > 0
	ENDPROC

	*==============================================================================
	* BuscarImagemProduto - Localiza o produto em SigCdPro e extrai a figura
	* (FigJpgs) para um arquivo .jpg temporario, exatamente como o legado faz no
	* final do Valid de GetOP (StrToFile sobre o campo memo). Ausencia de figura
	* NAO eh erro - THIS.this_cArquivoImagem fica vazio e o Form nao exibe nada.
	*==============================================================================
	PROTECTED PROCEDURE BuscarImagemProduto(par_cProduto)
		LOCAL loc_cSQL, loc_nResultado, loc_cNomeArquivo

		THIS.this_cArquivoImagem = ""

		IF VARTYPE(par_cProduto) != "C" OR EMPTY(ALLTRIM(par_cProduto))
			RETURN .T.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			USE IN (THIS.this_cCursorProduto)
		ENDIF

		loc_cSQL = "SELECT Cpros, Dpros, FigJpgs FROM SigCdPro WHERE Cpros = " + ;
			EscaparSQL(par_cProduto)

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProduto)

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			SELECT (THIS.this_cCursorProduto)
			GO TOP

			IF !EOF() ;
					AND !EMPTY(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs")) ;
					AND !ISNULL(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"))

				loc_cNomeArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + ".jpg"

				IF STRTOFILE(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"), loc_cNomeArquivo) > 0
					THIS.this_cArquivoImagem = loc_cNomeArquivo
				ENDIF
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC


	*==============================================================================
	* CarregarDoCursor - Carrega o registro CORRENTE do cursor da arvore para as
	* propriedades do BO. Eh o que o Form consome ao montar a arvore e ao tratar o
	* no selecionado: no legado, cada iteracao do "Scan" de MakeTree/MakeTreeEnv
	* le essas MESMAS colunas direto do cursor CrSigCdNei.
	*
	* Sem par_cAliasCursor assume THIS.this_cCursorArvore.
	*
	* A work area corrente eh SALVA e RESTAURADA: o Form chama este metodo de
	* dentro de lacos que percorrem o proprio cursor, e trocar a area sem repor
	* quebraria o SCAN do chamador. Por isso ha um unico RETURN, no fim.
	*==============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_nAreaAnterior, loc_lSucesso, loc_cChave

		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			ALLTRIM(par_cAliasCursor), THIS.this_cCursorArvore)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
				"o est" + CHR(225) + " aberto."
		ELSE
			loc_nAreaAnterior = SELECT()
			SELECT (loc_cAlias)

			*-- Cursor em EOF/BOF nao eh falha: apenas nao ha registro corrente
			*-- para carregar (a arvore chama este metodo dentro de laco)
			IF !EOF() AND !BOF()
				THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
				THIS.this_nNenvs     = TratarNulo(Nenvs, 0)
				THIS.this_cEmpDnPs   = TratarNulo(EmpDnPs, "")
				THIS.this_dDatas     = ConverterParaData(Datas)
				THIS.this_cGrupoos   = TratarNulo(Grupoos, "")
				THIS.this_cContaos   = TratarNulo(Contaos, "")
				THIS.this_cGrupods   = TratarNulo(Grupods, "")
				THIS.this_cContads   = TratarNulo(Contads, "")
				THIS.this_nNops      = TratarNulo(Nops, 0)
				THIS.this_cCmats     = TratarNulo(Cmats, "")
				THIS.this_cDpros     = TratarNulo(Dpros, "")
				THIS.this_nQtds      = TratarNulo(Qtds, 0)
				THIS.this_cCunis     = TratarNulo(Cunis, "")
				THIS.this_nPeso2s    = TratarNulo(Peso2s, 0)
				THIS.this_cCunips    = TratarNulo(Cunips, "")
				THIS.this_nPesos     = TratarNulo(Pesos, 0)
				THIS.this_cCpros     = TratarNulo(Cpros, "")
				THIS.this_nNopMaes   = TratarNulo(NopMaes, 0)

				*-- Servicos eh coluna bit no SQL Server. O SELECT do BO a traz
				*-- como CAST(... AS INT), entao chega SEMPRE numerica ao cursor.
				*-- A conversao aqui entrega um LOGICO de verdade ao Form, que
				*-- precisa dele para usar IIF() (IIF exige logico no 1o argumento).
				THIS.this_lServicos = ConverterParaLogico(TratarNulo(Servicos, 0))

				*-- TotPesos so existe no cursor da arvore (eh o total agregado por
				*-- movimentacao). Alias cru de SQLEXEC nao tem essa coluna, e nome
				*-- de campo inexistente estoura "Variable ... is not found" - por
				*-- isso o TYPE() antes (PEMSTATUS NAO serve para cursor).
				IF TYPE(loc_cAlias + ".TotPesos") = "N"
					THIS.this_nTotPesos = TratarNulo(EVALUATE(loc_cAlias + ".TotPesos"), 0)
				ELSE
					THIS.this_nTotPesos = 0
				ENDIF

				*-- EmpDnPs char(33) eh chave POSICIONAL: Emps(3) + Dopps(20) +
				*-- Str(Numps, 10). O legado decompoe exatamente nessas fatias
				*-- (Left / Substr / Val) no TreeView.DblClick. O PADR garante as
				*-- 33 posicoes antes de fatiar; NUNCA aplicar ALLTRIM nas partes
				*-- INTERIORES, porque o padding FAZ PARTE da chave.
				loc_cChave = PADR(THIS.this_cEmpDnPs, 33)
				THIS.this_cEmps  = LEFT(loc_cChave, 3)
				THIS.this_cDopps = SUBSTR(loc_cChave, 4, 20)
				THIS.this_nNumps = VAL(ALLTRIM(SUBSTR(loc_cChave, 24)))

				loc_lSucesso = .T.
			ENDIF

			IF loc_nAreaAnterior > 0
				SELECT (loc_nAreaAnterior)
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarChaveEmpDnPs - Remonta a chave POSICIONAL EmpDnPs:
	*     Emps char(3) + Dopps char(20) + Str(Numps, 10) = char(33)
	* A largura do char(33) destino (SigCdNei / SigCdNec / SigPdMvf / SigOpPic) eh
	* a conferencia da montagem: 3 + 20 + 10 = 33.
	*
	* PADR EXPLICITO em cada parte. ALLTRIM nas partes INTERIORES encurtaria a
	* chave, ela nunca casaria no WHERE e o SELECT devolveria ZERO linhas em
	* SILENCIO - sem erro e sem log. Nao confiar no padding que o cursor por
	* acaso traz: as propriedades do BO podem ter vindo de um TextBox.
	*==============================================================================
	PROCEDURE MontarChaveEmpDnPs(par_cEmps, par_cDopps, par_nNumps)
		LOCAL loc_cEmps, loc_cDopps, loc_nNumps

		loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopps = IIF(VARTYPE(par_cDopps) = "C", par_cDopps, "")
		loc_nNumps = IIF(VARTYPE(par_nNumps) = "N", par_nNumps, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopps, 20) + STR(loc_nNumps, 10)
	ENDPROC

	*==============================================================================
	* ObterChavePrimaria - Identidade do registro corrente, usada pela auditoria
	* da BusinessBase. Nesta consulta nao existe tabela mestre unica: o registro
	* eh identificado pela chave de movimentacao EmpDnPs, coluna char(33) que
	* SigCdNei, SigCdNec, SigPdMvf e SigOpPic compartilham.
	*
	* ALLTRIM aqui eh na chave INTEIRA (no fim), nao nas partes - isso eh
	* inofensivo, porque char no SQL Server compara com blank-padding ANSI.
	*==============================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		LOCAL loc_cChave

		loc_cChave = ALLTRIM(THIS.this_cEmpDnPs)

		IF EMPTY(loc_cChave)
			loc_cChave = ALLTRIM(THIS.MontarChaveEmpDnPs(THIS.this_cEmps, ;
				THIS.this_cDopps, THIS.this_nNumps))
		ENDIF

		RETURN loc_cChave
	ENDPROC

	*==============================================================================
	* ResetarRegistroCorrente - Zera as propriedades do registro corrente da
	* arvore. Chamado pelo Init e pelo LimparDados: o Form nao eh fechado entre
	* uma pesquisa e outra, entao sem este reset a pesquisa seguinte exibiria
	* residuo da anterior quando o novo cursor viesse vazio.
	*==============================================================================
	PROTECTED PROCEDURE ResetarRegistroCorrente()
		THIS.this_cCidchaves = ""
		THIS.this_nNenvs     = 0
		THIS.this_cEmpDnPs   = ""
		THIS.this_dDatas     = {}
		THIS.this_cGrupoos   = ""
		THIS.this_cContaos   = ""
		THIS.this_cGrupods   = ""
		THIS.this_cContads   = ""
		THIS.this_lServicos  = .F.
		THIS.this_nNops      = 0
		THIS.this_cCmats     = ""
		THIS.this_cDpros     = ""
		THIS.this_nQtds      = 0
		THIS.this_cCunis     = ""
		THIS.this_nPeso2s    = 0
		THIS.this_cCunips    = ""
		THIS.this_nPesos     = 0
		THIS.this_nTotPesos  = 0
		THIS.this_cCpros     = ""
		THIS.this_nNopMaes   = 0
		THIS.this_cEmps      = ""
		THIS.this_cDopps     = ""
		THIS.this_nNumps     = 0

		RETURN .T.
	ENDPROC

	*==============================================================================
	* LimparDados - Zera criterios de pesquisa e registro corrente, fechando os
	* cursores de resultado. O Form chama isto ao limpar a tela (no legado os dois
	* TextBox se zeram mutuamente: GetOP.GotFocus zera GetEnvelope e o GotFocus de
	* GetEnvelope zera GetOP).
	*==============================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cMensagemErro = ""

		THIS.ResetarRegistroCorrente()
		THIS.FecharCursoresResultado()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* FecharCursoresResultado - Fecha os cursores de resultado da consulta.
	*
	* O guard eh pelo BUFFERING, nao so pelo USED(): TABLEREVERT() EXIGE row ou
	* table buffering e, sem ele, dispara o erro 1586 em vez de ser no-op. Cursor
	* nascido de CREATE CURSOR ou de SELECT INTO CURSOR vem com Buffering = 1, e
	* nesse caso USE IN fecha o alias sozinho, mesmo com buffer sujo.
	*==============================================================================
	PROCEDURE FecharCursoresResultado()
		LOCAL ARRAY loc_aCursores[3]
		LOCAL loc_nI, loc_cCursor

		loc_aCursores[1] = THIS.this_cCursorArvore
		loc_aCursores[2] = THIS.this_cCursorProduto
		loc_aCursores[3] = "cursor_4c_Nensi"

		FOR loc_nI = 1 TO ALEN(loc_aCursores)
			loc_cCursor = loc_aCursores[loc_nI]

			IF VARTYPE(loc_cCursor) = "C" AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
				IF CURSORGETPROP("Buffering", loc_cCursor) > 1
					TABLEREVERT(.T., loc_cCursor)
				ENDIF
				USE IN (loc_cCursor)
			ENDIF
		ENDFOR

		RETURN .T.
	ENDPROC

	*==============================================================================
	* ExcluirImagemTemporaria - Apaga o .jpg que BuscarImagemProduto extraiu de
	* SigCdPro.FigJpgs. Equivale ao "Delete File (ThisForm.Arqfigura)" que o legado
	* executa no Click do botao de saida (Commandgroup1).
	*
	* CLEAR RESOURCES antes de apagar: o VFP mantem o bitmap em cache e o arquivo
	* fica preso enquanto o cache nao eh liberado (o legado faz o mesmo antes de
	* trocar a figura). SET SAFETY OFF em volta do DELETE FILE porque com SAFETY ON
	* ele abre dialogo de confirmacao, e dialogo modal travaria o pipeline.
	*==============================================================================
	PROCEDURE ExcluirImagemTemporaria()
		LOCAL loc_cArquivo, loc_cSafety

		loc_cArquivo = ALLTRIM(THIS.this_cArquivoImagem)
		THIS.this_cArquivoImagem = ""

		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
			CLEAR RESOURCES

			loc_cSafety = SET("SAFETY")
			SET SAFETY OFF

			DELETE FILE (loc_cArquivo)

			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Destroy - Libera os cursores de resultado e o arquivo temporario da figura.
	*==============================================================================
	PROCEDURE Destroy()
		THIS.ExcluirImagemTemporaria()
		THIS.FecharCursoresResultado()

		DODEFAULT()
	ENDPROC
ENDDEFINE

