# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NAGENCIAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONVENIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NOPERS, INFOS, VPAGS, TIPOS, ENDERRO, GRUCONTAS, EMPDOPNUMS, LCT085A087, PROCESSOS, DOPEDS, MSGMULTA, LCBARRA, LCT079A081, LCT140A142, LCQ019A033, LCQ034A073, LCQ074A113, LCQ114A128, LCQ129A136, LCQ137A151, LCQ152A153, LCQ154A154, LCB019A032, LCB033A062, SITUAS, PARCONTAS, VALPENDS, OPERS, EMPS

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
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
Select crSigCdOpe
lcquery = [select ?ltru as marca, e.titulos, a.dopes, a.numes, d.rclis, a.vencs, b.fpags, a.valos, a.datas, a.vpags, ] +;
	[from SigMvPar a inner join SigOpFp b on a.fpags = b.fpags ] +;
	[left join SigMvCab c on a.empdopnums = c.empdopnums ] +;
	[left join SigCdCli d on c.contads = d.iclis ] +;
	[left join SigMvCcr e on a.empdopnums = e.empdopnums and a.nopers = e.nopers ] +;
	[In (Select e.EmpDopNums+substring(e.dopeds,1,10) ] + ;
	[From SigPcOol e ] + ;
Thisform.podatamgr.sqlexecute(lcquery,[crFiltro])
Select crFiltro
	Select crFiltro
	lcQuery = [Select * ] + ;
				[From SigCdCeb ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crConvenio') < 1)
	lcQuery = [Select * ] + ;
			    [From SigCdCeb ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crConvenio') < 1)
	Insert Into crcabecalho(titulo,periodo,empresa) Values ('Dados para geração do CNAB',lcdata,lcemp + [ - ] + crEmpresa.RazSocs)
	Select *, Space(11) as SeqNums From crFiltro Where marca Into Cursor crFiltro2
	Select crFiltro2
Select *, Space(11) as SeqNums  From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol (EmpDopNums, Emps, Dopes, Numes, Usuars, Tipos, Processos, Produtos, Datas, cIdChaves, DopeDs,NumeDs ) ;
	If Not ThisForm.poDataMgr.Update([crSigPcOol])
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update)])	
		Select crFiltro2
			lcQuery = [Select Titulos, TitBans ] + ;
					    [From SigMvCcr ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvCcr]) < 1)
			Select crSigMvCcr
				lcQuery = [Update SigMvCcr ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery) < 1)
					=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update)])	
SELECT * from crfiltro where marca into cursor crFiltro2
SELECT crFiltro2
	Insert into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,datas,cidchaves,dopeds) values ;
	If ! thisform.podatamgr.Update('crSigPcOol')
		MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')	
		Select crFiltro2
			thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If thisform.podatamgr.Sqlexecute(lcquery) < 1
					MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')	
Select *, Space(5) as SeqNums  From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
Select a.*, Space(44) as nBarras, Space(30) as ImgBarra, lcRaz as Cedente, Space(50) as NomeCli, Space(50) as Instr1, Space(50) as Instr2, Space(50) as Instr3, ;
		from crFiltro2 a, crEmpresa b into cursor crFiltro2 ReadWrite
Select crFiltro2
		If thisform.podatamgr.SqlExecute([Select top 1 NumeDs from SigPcOol where Processos = 'CNAB' And DopeDs = ?crFiltro2.titulos order by Datas Desc],[crTmpPcOol]) < 1
		Select crFiltro2
Select crFiltro2
Select crFiltro2
Select *, Space(5) as SeqNums  From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
Select *, Space(5) as SeqNums From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
Select crFiltro2
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
Select *, Space(5) as SeqNums From crfiltro Where marca Into Cursor crFiltro2 ReadWrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
Select *, Space(5) As SeqNums From crfiltro Where marca Into Cursor crFiltro2 Readwrite
Select crFiltro2
	Insert Into crSigPcOol(empdopnums,emps,dopes,numes,usuars,tipos,processos,produtos,DataS,cidchaves,dopeds,NumeDs) Values ;
	If ! Thisform.podatamgr.Update('crSigPcOol')
		Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
		Select crFiltro2
			Thisform.podatamgr.Sqlexecute('select titulos, titbans from SigMvCcr where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers','crSigMvCcr')
			Select crSigMvCcr
				lcquery = 'Update SigMvCcr set titbans = ?lctit where empdopnums = ?crFiltro2.empdopnums and nopers = ?crFiltro2.nopers'
				If Thisform.podatamgr.Sqlexecute(lcquery) < 1
					Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update) ')
	lcQuery = [Select * ] + ;
		[From SigOpFp ] + ;
	Thisform.poDataMgr.SqlExecute(lcQuery, [CrSigOpFp])
	Select CrSigOpFp
	Thisform.poDataMgr.SqlExecute([select dopes, ?lltru as marca from SigCdOpe where Parcontas = 1 And ValPends = 1 order by dopes],[crSigCdOpe])
	Select crSigCdOpe
	Thisform.pgfprincipal.pgfiltro.grdope.column1.ControlSource = [crSigCdOpe.marca]
	Thisform.pgfprincipal.pgfiltro.grdope.column2.ControlSource = [crSigCdOpe.dopes]
Select crSigCdOpe
	Select * ;
	  From CrSigOpFp ;
	Select LocalFpag
	If Not Seek(This.Value)
Select crSigCdOpe
Update crSigCdOpe Set marca = .T.
Select crSigCdOpe
Update crSigCdOpe Set marca = .F.
SELECT crfiltro
Update crfiltro set marca = .t.
SELECT crfiltro
Update crfiltro set marca = .f.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS SQL (2225 linhas total):

*-- Linhas 597 a 669:
597:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
598:         ENDWITH
599: 
600:         *-- Cursor placeholder da grade de operacoes (regra #41: o ControlSource
601:         *-- das colunas nao pode apontar para cursor que ainda nao existe).
602:         *-- Estrutura identica a THIS.CarregarOperacoes(), que substitui o
603:         *-- conteudo pelo resultado real do SQLEXEC.
604:         IF USED("cursor_4c_Operacoes")
605:             USE IN cursor_4c_Operacoes
606:         ENDIF
607:         SET NULL ON
608:         CREATE CURSOR cursor_4c_Operacoes (Dopes C(20) NULL, Marca L NULL)
609:         SET NULL OFF
610: 
611:         *-- Grade de selecao de operacoes (grdope no legado, Pagina Filtro)
612:         loc_oPag.AddObject("grd_4c_Operacoes", "Grid")
613:         loc_oGrid = loc_oPag.grd_4c_Operacoes
614: 
615:         *-- ColumnCount/RecordSource FORA do WITH (regra GRID-WITH): dentro do
616:         *-- mesmo WITH que acessa .Column, o Grid pode nao ter as colunas
617:         *-- prontas ainda, e o acesso a .Column1 logo abaixo estouraria
618:         *-- 'Unknown member COLUMN1'.
619:         loc_oGrid.ColumnCount  = 2
620:         loc_oGrid.RecordSource = "cursor_4c_Operacoes"
621: 
622:         WITH loc_oGrid
623:             .Top               = 261
624:             .Left              = 350
625:             .Width             = 202
626:             .Height            = 344
627:             .FontName          = "Tahoma"
628:             .AllowHeaderSizing = .F.
629:             .AllowRowSizing    = .F.
630:             .DeleteMark        = .F.
631:             .RecordMark        = .F.
632:             .GridLines         = 3
633:             .GridLineColor     = RGB(238,238,238)
634:             .ScrollBars        = 2
635:             .Themes            = .F.
636: 
637:             *-- Limpa o ControlSource auto-atribuido pelo Grid (por default ele
638:             *-- liga Column1 ao 1o campo do cursor - Dopes, Character) ANTES de
639:             *-- adicionar o CheckBox, senao o VFP tenta sincronizar o .Value do
640:             *-- controle novo com um campo Character e estoura "Data type
641:             *-- mismatch" (regra #18: AddObject/CurrentControl SEMPRE antes do
642:             *-- ControlSource definitivo).
643:             .Column1.ControlSource = ""
644:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
645:             .Column1.CurrentControl = "chk_4c_Marca"
646:             WITH .Column1.chk_4c_Marca
647:                 .Caption   = ""
648:                 .BackColor = RGB(255,255,255)
649:             ENDWITH
650: 
651:             .Column1.ControlSource  = "cursor_4c_Operacoes.Marca"
652:             .Column2.ControlSource  = "cursor_4c_Operacoes.Dopes"
653: 
654:             *-- Largura/legenda reaplicadas DEPOIS do RecordSource/ControlSource
655:             *-- (ambos resetam Column.Width e Header1.Caption - Problema 48)
656:             .Column1.Width          = 18
657:             .Column1.Movable        = .F.
658:             .Column1.Resizable      = .F.
659:             .Column1.Sparse         = .F.
660:             .Column1.ReadOnly       = .F.
661:             .Column1.Header1.Caption = ""
662: 
663:             .Column2.Width          = 150
664:             .Column2.Movable        = .F.
665:             .Column2.Resizable      = .F.
666:             .Column2.ReadOnly       = .T.
667:             .Column2.Header1.Alignment = 2
668:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
669:         ENDWITH

*-- Linhas 935 a 961:
935:             .Value         = ""
936:         ENDWITH
937: 
938:         *-- Cursor placeholder da grade de titulos (regra #41 - ControlSource
939:         *-- nao pode apontar para cursor que ainda nao existe). Estrutura
940:         *-- identica ao resultado do SQLEXEC de THIS.ProcessarTitulos()
941:         *-- (mesmos nomes/tipos do "crFiltro" do legado).
942:         IF USED("cursor_4c_Titulos")
943:             USE IN cursor_4c_Titulos
944:         ENDIF
945:         SET NULL ON
946:         CREATE CURSOR cursor_4c_Titulos (Marca L NULL, Titulos C(10) NULL, Dopes C(20) NULL, ;
947:             Numes N(6,0) NULL, RClis C(50) NULL, Vencs T NULL, Fpags C(12) NULL, Valos N(11,2) NULL, ;
948:             Datas T NULL, Vpags N(11,2) NULL, IClis C(10) NULL, Endes C(60) NULL, Cidas C(30) NULL, ;
949:             Estas C(2) NULL, Nums C(10) NULL, Compls C(50) NULL, Bairs C(40) NULL, Ceps C(9) NULL, ;
950:             Cpfs C(20) NULL, Emps C(3) NULL, EmpDopNums C(29) NULL, Nopers N(7,0) NULL, Razaos C(50) NULL, ;
951:             EndCobs C(80) NULL, CepCobs C(9) NULL, EstCobs C(2) NULL, BaiCobs C(20) NULL, CidCobs C(20) NULL, ;
952:             EndErro N(1,0) NULL)
953:         SET NULL OFF
954: 
955:         *-- Grade de titulos em aberto (grdope no legado, Pagina Dados) - 8
956:         *-- colunas. ColumnOrder visual segue o legado (Column8 "Titulo"
957:         *-- aparece logo apos o checkbox - regra #35b: a grade espelha a
958:         *-- estrutura do legado, nao a ordem de criacao das colunas).
959:         loc_oPag.AddObject("grd_4c_Titulos", "Grid")
960:         loc_oGridTit = loc_oPag.grd_4c_Titulos
961: 

*-- Linhas 974 a 1026:
974:             .FontName          = "Tahoma"
975:             .AllowHeaderSizing = .F.
976:             .AllowRowSizing    = .F.
977:             .DeleteMark        = .F.
978:             .RecordMark        = .F.
979:             .GridLineColor     = RGB(238,238,238)
980:             .ScrollBars        = 2
981:             .Themes            = .F.
982: 
983:             *-- Limpa o ControlSource auto-atribuido pelo Grid ANTES de
984:             *-- adicionar o CheckBox (regra #18).
985:             .Column1.ControlSource = ""
986:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
987:             .Column1.CurrentControl = "chk_4c_Marca"
988:             WITH .Column1.chk_4c_Marca
989:                 .Caption   = ""
990:                 .BackColor = RGB(255,255,255)
991:             ENDWITH
992: 
993:             .Column1.ControlSource = "cursor_4c_Titulos.Marca"
994:             .Column2.ControlSource = "cursor_4c_Titulos.Dopes"
995:             .Column3.ControlSource = "cursor_4c_Titulos.Numes"
996:             .Column4.ControlSource = "cursor_4c_Titulos.RClis"
997:             .Column5.ControlSource = "cursor_4c_Titulos.Vencs"
998:             .Column6.ControlSource = "cursor_4c_Titulos.Fpags"
999:             .Column7.ControlSource = "cursor_4c_Titulos.Valos"
1000:             .Column8.ControlSource = "cursor_4c_Titulos.Titulos"
1001: 
1002:             .Column1.Width           = 16
1003:             .Column1.Movable         = .F.
1004:             .Column1.Resizable       = .F.
1005:             .Column1.Sparse         = .F.
1006:             .Column1.ReadOnly        = .F.
1007:             .Column1.Header1.Caption = ""
1008:         ENDWITH
1009: 
1010:         *-- Largura/legenda/ordem reaplicadas DEPOIS do RecordSource/
1011:         *-- ControlSource (Problema 48 - ambos resetam Column.Width e
1012:         *-- Header1.Caption).
1013:         THIS.FormatarGridTitulos(loc_oGridTit)
1014: 
1015:         *-- Container Marcar/Desmarcar Tudo dos titulos (Commandgroup2 no
1016:         *-- legado, pgdados) - mesmo padrao visual do cnt_4c_Marca da
1017:         *-- Pagina Filtro.
1018:         loc_oPag.AddObject("cnt_4c_Marca", "Container")
1019:         WITH loc_oPag.cnt_4c_Marca
1020:             .Top         = 570
1021:             .Left        = 7
1022:             .Width       = 92
1023:             .Height      = 50
1024:             .BackStyle   = 0
1025:             .BorderWidth = 0
1026: 

*-- Linhas 1060 a 1080:
1060:     *==========================================================================
1061:     * FormatarGridTitulos - Reaplica largura/legenda/ordem/cor dinamica das
1062:     * colunas da grade de titulos. Chamado apos QUALQUER atribuicao de
1063:     * RecordSource/ControlSource (Problema 48 - ambos resetam Column.Width e
1064:     * Header1.Caption): uma vez na estrutura inicial (ConfigurarPaginaDados)
1065:     * e de novo apos o SQLEXEC real (THIS.ProcessarTitulos).
1066:     *==========================================================================
1067:     PROTECTED PROCEDURE FormatarGridTitulos(par_oGrid)
1068:         WITH par_oGrid
1069:             .Column1.Width           = 16
1070:             .Column1.Movable         = .F.
1071:             .Column1.Resizable       = .F.
1072:             .Column1.Sparse          = .F.
1073:             .Column1.ReadOnly        = .F.
1074:             .Column1.ColumnOrder     = 1
1075:             .Column1.Header1.Caption = ""
1076: 
1077:             .Column2.Width             = 150
1078:             .Column2.Movable           = .F.
1079:             .Column2.Resizable         = .F.
1080:             .Column2.ReadOnly          = .T.

*-- Linhas 1136 a 1198:
1136:     *==========================================================================
1137:     * CarregarOperacoes - Popula cursor_4c_Operacoes com as operacoes (SigCdOpe)
1138:     * elegiveis para o processo de CNAB (Parcontas=1 e ValPends=1), igual ao
1139:     * legado (Init: "select dopes, ?lltru as marca from SigCdOpe where
1140:     * Parcontas = 1 And ValPends = 1 order by dopes", com lltru=.F.).
1141:     * Cursor eh READWRITE porque a Coluna1 do grid eh um CheckBox editavel
1142:     * (marca/desmarca operacao) - SQLEXEC devolve cursor somente-leitura.
1143:     *==========================================================================
1144:     PROTECTED PROCEDURE CarregarOperacoes()
1145:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
1146:         loc_lSucesso = .F.
1147: 
1148:         TRY
1149:             loc_cSQL = "SELECT Dopes, CAST(0 AS BIT) AS Marca" + CHR(13) + ;
1150:                        "FROM SigCdOpe" + CHR(13) + ;
1151:                        "WHERE Parcontas = 1 AND ValPends = 1" + CHR(13) + ;
1152:                        "ORDER BY Dopes"
1153: 
1154:             IF USED("cursor_4c_OperacoesTmp")
1155:                 USE IN cursor_4c_OperacoesTmp
1156:             ENDIF
1157: 
1158:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTmp")
1159: 
1160:             IF loc_nResultado >= 0
1161:                 IF USED("cursor_4c_Operacoes")
1162:                     USE IN cursor_4c_Operacoes
1163:                 ENDIF
1164: 
1165:                 SELECT * FROM cursor_4c_OperacoesTmp INTO CURSOR cursor_4c_Operacoes READWRITE
1166: 
1167:                 IF USED("cursor_4c_OperacoesTmp")
1168:                     USE IN cursor_4c_OperacoesTmp
1169:                 ENDIF
1170: 
1171:                 IF RECCOUNT("cursor_4c_Operacoes") > 0
1172:                     SELECT cursor_4c_Operacoes
1173:                     GO TOP
1174:                 ENDIF
1175: 
1176:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.ColumnCount = 3
1177:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.RecordSource = "cursor_4c_Operacoes"
1178: 
1179:                 *-- RecordSource reatribuido faz o Grid auto-bindar as colunas
1180:                 *-- pela ordem dos campos do cursor, ignorando o ControlSource
1181:                 *-- anterior - redefinir explicitamente (regra GRID-RECORDSOURCE-AUTOBIND).
1182:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column1.ControlSource = "cursor_4c_Operacoes.Marca"
1183:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Column2.ControlSource = "cursor_4c_Operacoes.Dopes"
1184: 
1185:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1186: 
1187:                 loc_lSucesso = .T.
1188:             ELSE
1189:                 MostrarErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1190:                             CapturarErroSQL(), "Erro SQL")
1191:             ENDIF
1192:         CATCH TO loc_oErro
1193:             MostrarErro(loc_oErro.Message + CHR(13) + ;
1194:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1195:                         "Procedure: " + loc_oErro.Procedure, "Erro CarregarOperacoes")
1196:         ENDTRY
1197: 
1198:         RETURN loc_lSucesso

*-- Linhas 1278 a 1296:
1278: 
1279:         loc_nCont = 0
1280:         IF USED("cursor_4c_Operacoes")
1281:             SELECT cursor_4c_Operacoes
1282:             COUNT FOR Marca TO loc_nCont
1283:         ENDIF
1284:         IF loc_nCont = 0
1285:             MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada", "Aviso")
1286:             RETURN
1287:         ENDIF
1288: 
1289:         THIS.ProcessarTitulos()
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * BtnEncerrarClick - cmdTestaPos.btnsair.Click (Pagina Filtro) no legado.
1294:     *==========================================================================
1295:     PROCEDURE BtnEncerrarClick()
1296:         THIS.Release()

*-- Linhas 1303 a 1331:
1303:     *==========================================================================
1304:     PROCEDURE BtnMarcarTudoClick()
1305:         IF USED("cursor_4c_Operacoes")
1306:             SELECT cursor_4c_Operacoes
1307:             REPLACE ALL Marca WITH .T.
1308:             LOCATE
1309:             GO TOP
1310:         ENDIF
1311:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1312:     ENDPROC
1313: 
1314:     PROCEDURE BtnDesmarcarTudoClick()
1315:         IF USED("cursor_4c_Operacoes")
1316:             SELECT cursor_4c_Operacoes
1317:             REPLACE ALL Marca WITH .F.
1318:             LOCATE
1319:             GO TOP
1320:         ENDIF
1321:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * ProcessarTitulos - PROCEDURE processamento no legado. Monta a lista de
1326:     * operacoes marcadas + consulta os titulos em aberto (SigMvPar/SigOpFp/
1327:     * SigMvCab/SigCdCli/SigMvCcr), populando cursor_4c_Titulos (READWRITE -
1328:     * a coluna Marca eh CheckBox editavel no grid). Formula/filtros
1329:     * TRANSCRITOS literalmente do legado (regra CLAUDE.md #17) - inclusive a
1330:     * ausencia de filtro pela conta/carteira na consulta (o legado le
1331:     * get_cd_car_conta so para validar preenchimento, e aplica a conta

*-- Linhas 1349 a 1439:
1349:         *-- POSICIONAL concatenada da regra #42, ALLTRIM por item eh seguro.
1350:         loc_cListaOperacoes = "("
1351:         IF USED("cursor_4c_Operacoes")
1352:             SELECT cursor_4c_Operacoes
1353:             SCAN FOR Marca
1354:                 loc_cListaOperacoes = loc_cListaOperacoes + ;
1355:                     IIF(loc_cListaOperacoes == "(", "", ",") + EscaparSQL(ALLTRIM(Dopes))
1356:             ENDSCAN
1357:         ENDIF
1358:         loc_cListaOperacoes = loc_cListaOperacoes + ")"
1359: 
1360:         loc_cCampoData = IIF(loc_nPeriodo = 1, "a.vencs", "e.dtemis")
1361:         loc_cNotIn     = IIF(loc_lNaoProcessados, "NOT ", "")
1362: 
1363:         TRY
1364:             loc_cSQL = ;
1365:                 "SELECT CAST(1 AS BIT) AS Marca, e.titulos AS Titulos, a.dopes AS Dopes, a.numes AS Numes," + CHR(13) + ;
1366:                 "       d.rclis AS RClis, a.vencs AS Vencs, b.fpags AS Fpags, a.valos AS Valos, a.datas AS Datas," + CHR(13) + ;
1367:                 "       a.vpags AS Vpags, d.iclis AS IClis, d.endes AS Endes, d.cidas AS Cidas, d.estas AS Estas," + CHR(13) + ;
1368:                 "       d.nums AS Nums, d.compls AS Compls, d.bairs AS Bairs, d.ceps AS Ceps, d.cpfs AS Cpfs," + CHR(13) + ;
1369:                 "       a.emps AS Emps, a.empdopnums AS EmpDopNums, a.nopers AS Nopers, d.razaos AS Razaos," + CHR(13) + ;
1370:                 "       d.endcobs AS EndCobs, d.cepcobs AS CepCobs, d.estcobs AS EstCobs, d.baicobs AS BaiCobs, d.cidcobs AS CidCobs," + CHR(13) + ;
1371:                 "       CASE WHEN d.endcobs <> '' AND LEN(RTRIM(d.endcobs)) > 40 THEN 1" + CHR(13) + ;
1372:                 "            WHEN d.endes <> '' AND LEN(RTRIM(d.endes) + ' ' + RTRIM(d.nums) + ' ' + RTRIM(d.compls)) > 40 THEN 1" + CHR(13) + ;
1373:                 "            ELSE 0 END AS EndErro" + CHR(13) + ;
1374:                 "FROM SigMvPar a" + CHR(13) + ;
1375:                 "INNER JOIN SigOpFp b ON a.fpags = b.fpags" + CHR(13) + ;
1376:                 "LEFT JOIN SigMvCab c ON a.empdopnums = c.empdopnums" + CHR(13) + ;
1377:                 "LEFT JOIN SigCdCli d ON c.contads = d.iclis" + CHR(13) + ;
1378:                 "LEFT JOIN SigMvCcr e ON a.empdopnums = e.empdopnums AND a.nopers = e.nopers" + CHR(13) + ;
1379:                 "WHERE b.infos = 'B' AND a.vpags = 0" + CHR(13) + ;
1380:                 "  AND " + loc_cCampoData + " BETWEEN " + FormatarDataSQL(loc_dIni) + " AND " + FormatarDataSQL(loc_dFim) + CHR(13) + ;
1381:                 "  AND e.opers = 'C'" + CHR(13) + ;
1382:                 "  AND c.emps = " + EscaparSQL(loc_cEmpresa) + CHR(13) + ;
1383:                 "  AND a.dopes IN " + loc_cListaOperacoes + CHR(13) + ;
1384:                 "  AND a.empdopnums + e.titulos " + loc_cNotIn + "IN (" + CHR(13) + ;
1385:                 "      SELECT f.empdopnums + SUBSTRING(f.dopeds, 1, 10)" + CHR(13) + ;
1386:                 "      FROM SigPcOoL f" + CHR(13) + ;
1387:                 "      WHERE f.tipos = 'SIGPRCNB')" + CHR(13) + ;
1388:                 "ORDER BY a.dopes, a.numes, a.parcs"
1389: 
1390:             IF USED("cursor_4c_TitulosTmp")
1391:                 USE IN cursor_4c_TitulosTmp
1392:             ENDIF
1393: 
1394:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitulosTmp")
1395: 
1396:             IF loc_nResultado >= 0
1397:                 IF USED("cursor_4c_Titulos")
1398:                     USE IN cursor_4c_Titulos
1399:                 ENDIF
1400: 
1401:                 SELECT * FROM cursor_4c_TitulosTmp INTO CURSOR cursor_4c_Titulos READWRITE
1402: 
1403:                 IF USED("cursor_4c_TitulosTmp")
1404:                     USE IN cursor_4c_TitulosTmp
1405:                 ENDIF
1406: 
1407:                 IF RECCOUNT("cursor_4c_Titulos") = 0
1408:                     MsgAviso("Nenhum dado foi encontrado", "Aviso")
1409:                 ELSE
1410:                     SELECT cursor_4c_Titulos
1411:                     REPLACE ALL Marca WITH .F. FOR EndErro = 1
1412:                     GO TOP
1413: 
1414:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
1415:                     loc_oGrid.ColumnCount = 8
1416:                     loc_oGrid.RecordSource         = "cursor_4c_Titulos"
1417:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Titulos.Marca"
1418:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Titulos.Dopes"
1419:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Titulos.Numes"
1420:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Titulos.RClis"
1421:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Titulos.Vencs"
1422:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Titulos.Fpags"
1423:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Titulos.Valos"
1424:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Titulos.Titulos"
1425:                     THIS.FormatarGridTitulos(loc_oGrid)
1426:                     loc_oGrid.Refresh()
1427: 
1428:                     THIS.pgf_4c_Paginas.Page1.Enabled = .F.
1429:                     THIS.pgf_4c_Paginas.Page2.Enabled = .T.
1430: 
1431:                     *-- cmdTestaPos.btnBoleto.Enabled = !llNPr no legado (linha
1432:                     *-- 1468): Boleto so comeca habilitado quando o filtro eh
1433:                     *-- "Ja Processadas" (reimpressao); ProcessadoBrasil/
1434:                     *-- Santander240 forcam .T. depois de gerar com sucesso.
1435:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = ;
1436:                         (loc_oPag.obj_4c_Processados.Value = 2)
1437: 
1438:                     THIS.AlternarPagina(2)
1439:                     loc_lSucesso = .T.

*-- Linhas 1473 a 1501:
1473:     *==========================================================================
1474:     PROCEDURE BtnMarcarTudoTitulosClick()
1475:         IF USED("cursor_4c_Titulos")
1476:             SELECT cursor_4c_Titulos
1477:             REPLACE ALL Marca WITH .T.
1478:             LOCATE
1479:             GO TOP
1480:         ENDIF
1481:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1482:     ENDPROC
1483: 
1484:     PROCEDURE BtnDesmarcarTudoTitulosClick()
1485:         IF USED("cursor_4c_Titulos")
1486:             SELECT cursor_4c_Titulos
1487:             REPLACE ALL Marca WITH .F.
1488:             LOCATE
1489:             GO TOP
1490:         ENDIF
1491:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1492:     ENDPROC
1493: 
1494:     *==========================================================================
1495:     * ChkTituloMarcaClick - Column1.Check1.When no legado (Return
1496:     * crFiltro.EndErro = 0): titulo com endereco muito longo nao pode ser
1497:     * selecionado. O nativo do CheckBox ja alterna Marca no clique; aqui so
1498:     * revertemos quando a linha estiver marcada como EndErro=1.
1499:     *==========================================================================
1500:     PROCEDURE ChkTituloMarcaClick()
1501:         IF USED("cursor_4c_Titulos") AND !EOF("cursor_4c_Titulos")

*-- Linhas 1596 a 1614:
1596:         LOCAL loc_nMarcados
1597: 
1598:         IF USED("cursor_4c_Titulos")
1599:             SELECT cursor_4c_Titulos
1600:             COUNT FOR Marca TO loc_nMarcados
1601:         ELSE
1602:             loc_nMarcados = 0
1603:         ENDIF
1604: 
1605:         IF loc_nMarcados = 0
1606:             MsgAviso("Nenhum registro foi selecionado", "Aviso")
1607:             RETURN
1608:         ENDIF
1609: 
1610:         THIS.ExecutarReportForm("SigReCnb", "PREVIEW", "cursor_4c_Titulos")
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     * BtnBoletoClick - Commandgroup1.btnBoleto.Click no legado ("thisform.

*-- Linhas 1665 a 1683:
1665: 
1666:     *==========================================================================
1667:     * ValidarCodEmpresa - KeyPress em txt_4c_CodEmpresa (get_cd_empresa no
1668:     * legado). Enter/Tab/F4 -> SELECT exato em SigCdEmp.Cemps; hit preenche a
1669:     * razao social, miss abre o picker (fAcessoEmpresa modo 'C' nao portada -
1670:     * regra CLAUDE.md sobre fAcessoEmpresa, substituicao canonica FormBuscaAuxiliar
1671:     * em SigCdEmp).
1672:     *==========================================================================
1673:     PROCEDURE ValidarCodEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1674:         LOCAL loc_oPag, loc_cVal, loc_nResult
1675: 
1676:         IF par_nKeyCode = 115
1677:             THIS.AbrirBuscaEmpresa()
1678:             RETURN
1679:         ENDIF
1680: 
1681:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1682:             RETURN
1683:         ENDIF

*-- Linhas 1692 a 1714:
1692:         ENDIF
1693: 
1694:         TRY
1695:             loc_nResult = SQLEXEC(gnConnHandle, ;
1696:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
1697:                 "cursor_4c_EmpresaVal")
1698:             IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
1699:                 SELECT cursor_4c_EmpresaVal
1700:                 loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
1701:                 loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
1702:             ELSE
1703:                 THIS.AbrirBuscaEmpresa()
1704:             ENDIF
1705:             IF USED("cursor_4c_EmpresaVal")
1706:                 USE IN cursor_4c_EmpresaVal
1707:             ENDIF
1708:         CATCH TO loc_oErro
1709:             MsgErro(loc_oErro.Message, "Erro")
1710:         ENDTRY
1711: 
1712:         loc_oPag.txt_4c_CodEmpresa.Refresh
1713:         loc_oPag.txt_4c_NomeEmpresa.Refresh
1714:     ENDPROC

*-- Linhas 1743 a 1765:
1743:         ENDIF
1744: 
1745:         TRY
1746:             loc_nResult = SQLEXEC(gnConnHandle, ;
1747:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) = " + EscaparSQL(loc_cVal), ;
1748:                 "cursor_4c_EmpresaVal")
1749:             IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
1750:                 SELECT cursor_4c_EmpresaVal
1751:                 loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
1752:                 loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
1753:             ELSE
1754:                 THIS.AbrirBuscaEmpresa()
1755:             ENDIF
1756:             IF USED("cursor_4c_EmpresaVal")
1757:                 USE IN cursor_4c_EmpresaVal
1758:             ENDIF
1759:         CATCH TO loc_oErro
1760:             MsgErro(loc_oErro.Message, "Erro")
1761:         ENDTRY
1762: 
1763:         loc_oPag.txt_4c_CodEmpresa.Refresh
1764:         loc_oPag.txt_4c_NomeEmpresa.Refresh
1765:     ENDPROC

*-- Linhas 1785 a 1838:
1785:         loc_lProsseguir = .T.
1786:         TRY
1787:             IF EMPTY(loc_cValor)
1788:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
1789:             ELSE
1790:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1791:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1792:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1793:                            " ORDER BY Cemps"
1794:             ENDIF
1795:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpresa")
1796: 
1797:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0) ;
1798:                     AND !EMPTY(loc_cValor)
1799:                 IF USED("cursor_4c_BuscaEmpresa")
1800:                     USE IN cursor_4c_BuscaEmpresa
1801:                 ENDIF
1802:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1803:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
1804:                     "cursor_4c_BuscaEmpresa")
1805:             ENDIF
1806: 
1807:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0
1808:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1809:                 loc_lProsseguir = .F.
1810:             ENDIF
1811: 
1812:             IF loc_lProsseguir
1813:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1814:                 IF VARTYPE(loc_oBusca) = "O"
1815:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpresa"
1816:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1817:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1818:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1819:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1820:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1821:                     loc_oBusca.Show()
1822:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1823:                         SELECT cursor_4c_BuscaEmpresa
1824:                         loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1825:                         loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1826:                     ENDIF
1827:                     loc_oBusca.Release()
1828:                 ENDIF
1829:             ENDIF
1830:         CATCH TO loc_oErro
1831:             MsgErro(loc_oErro.Message, "Erro")
1832:         ENDTRY
1833: 
1834:         IF USED("cursor_4c_BuscaEmpresa")
1835:             USE IN cursor_4c_BuscaEmpresa
1836:         ENDIF
1837:         loc_oPag.txt_4c_CodEmpresa.Refresh
1838:         loc_oPag.txt_4c_NomeEmpresa.Refresh

*-- Linhas 1861 a 1879:
1861: 
1862:     *==========================================================================
1863:     * ValidarCodConta - KeyPress em txt_4c_CodConta (get_cd_car_conta no
1864:     * legado). Enter/Tab/F4 -> SELECT exato em SigCdCli.IClis; hit preenche a
1865:     * razao social, miss abre o picker (fAcessoContas NAO USAR para lookup UX -
1866:     * regra CLAUDE.md, substituicao canonica SigCdCli.IClis/RClis).
1867:     *==========================================================================
1868:     PROCEDURE ValidarCodConta(par_nKeyCode, par_nShiftAltCtrl)
1869:         LOCAL loc_oPag, loc_cVal, loc_nResult
1870: 
1871:         IF par_nKeyCode = 115
1872:             THIS.AbrirBuscaConta()
1873:             RETURN
1874:         ENDIF
1875: 
1876:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1877:             RETURN
1878:         ENDIF
1879: 

*-- Linhas 1887 a 1909:
1887:         ENDIF
1888: 
1889:         TRY
1890:             loc_nResult = SQLEXEC(gnConnHandle, ;
1891:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
1892:                 "cursor_4c_ContaVal")
1893:             IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
1894:                 SELECT cursor_4c_ContaVal
1895:                 loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
1896:                 loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
1897:             ELSE
1898:                 MsgAviso("Conta Inv" + CHR(225) + "lida, Acesso Negado.", "Aviso")
1899:                 loc_oPag.txt_4c_CodConta.Value  = ""
1900:                 loc_oPag.txt_4c_NomeConta.Value = ""
1901:             ENDIF
1902:             IF USED("cursor_4c_ContaVal")
1903:                 USE IN cursor_4c_ContaVal
1904:             ENDIF
1905:         CATCH TO loc_oErro
1906:             MsgErro(loc_oErro.Message, "Erro")
1907:         ENDTRY
1908: 
1909:         loc_oPag.txt_4c_CodConta.Refresh

*-- Linhas 1940 a 1962:
1940:         ENDIF
1941: 
1942:         TRY
1943:             loc_nResult = SQLEXEC(gnConnHandle, ;
1944:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) = " + EscaparSQL(loc_cVal), ;
1945:                 "cursor_4c_ContaVal")
1946:             IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
1947:                 SELECT cursor_4c_ContaVal
1948:                 loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
1949:                 loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
1950:             ELSE
1951:                 THIS.AbrirBuscaConta()
1952:             ENDIF
1953:             IF USED("cursor_4c_ContaVal")
1954:                 USE IN cursor_4c_ContaVal
1955:             ENDIF
1956:         CATCH TO loc_oErro
1957:             MsgErro(loc_oErro.Message, "Erro")
1958:         ENDTRY
1959: 
1960:         loc_oPag.txt_4c_CodConta.Refresh
1961:         loc_oPag.txt_4c_NomeConta.Refresh
1962:     ENDPROC

*-- Linhas 1982 a 2035:
1982:         loc_lProsseguir = .T.
1983:         TRY
1984:             IF EMPTY(loc_cValor)
1985:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
1986:             ELSE
1987:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
1988:                            "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1989:                            " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1990:                            " ORDER BY IClis"
1991:             ENDIF
1992:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1993: 
1994:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0) ;
1995:                     AND !EMPTY(loc_cValor)
1996:                 IF USED("cursor_4c_BuscaConta")
1997:                     USE IN cursor_4c_BuscaConta
1998:                 ENDIF
1999:                 loc_nResult = SQLEXEC(gnConnHandle, ;
2000:                     "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
2001:                     "cursor_4c_BuscaConta")
2002:             ENDIF
2003: 
2004:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
2005:                 MsgAviso("Nenhuma conta encontrada.", "Conta")
2006:                 loc_lProsseguir = .F.
2007:             ENDIF
2008: 
2009:             IF loc_lProsseguir
2010:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2011:                 IF VARTYPE(loc_oBusca) = "O"
2012:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
2013:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2014:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2015:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2016:                     loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2017:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
2018:                     loc_oBusca.Show()
2019:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
2020:                         SELECT cursor_4c_BuscaConta
2021:                         loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
2022:                         loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
2023:                     ENDIF
2024:                     loc_oBusca.Release()
2025:                 ENDIF
2026:             ENDIF
2027:         CATCH TO loc_oErro
2028:             MsgErro(loc_oErro.Message, "Erro")
2029:         ENDTRY
2030: 
2031:         IF USED("cursor_4c_BuscaConta")
2032:             USE IN cursor_4c_BuscaConta
2033:         ENDIF
2034:         loc_oPag.txt_4c_CodConta.Refresh
2035:         loc_oPag.txt_4c_NomeConta.Refresh

*-- Linhas 2062 a 2085:
2062:         ENDIF
2063: 
2064:         TRY
2065:             loc_nResult = SQLEXEC(gnConnHandle, ;
2066:                 "SELECT TOP 1 Fpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cVal) + ;
2067:                 " AND Situas IN ('R','A') AND Infos = 'K'", ;
2068:                 "cursor_4c_TituloBancoVal")
2069:             IF loc_nResult > 0 AND USED("cursor_4c_TituloBancoVal") AND !EOF("cursor_4c_TituloBancoVal")
2070:                 SELECT cursor_4c_TituloBancoVal
2071:                 loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_TituloBancoVal.Fpags)
2072:             ELSE
2073:                 THIS.AbrirBuscaTituloBanco()
2074:             ENDIF
2075:             IF USED("cursor_4c_TituloBancoVal")
2076:                 USE IN cursor_4c_TituloBancoVal
2077:             ENDIF
2078:         CATCH TO loc_oErro
2079:             MsgErro(loc_oErro.Message, "Erro")
2080:         ENDTRY
2081: 
2082:         loc_oPag.txt_4c_TituloBanco.Refresh
2083:     ENDPROC
2084: 
2085:     *==========================================================================

*-- Linhas 2102 a 2154:
2102:         loc_lProsseguir = .T.
2103:         TRY
2104:             IF EMPTY(loc_cValor)
2105:                 loc_cSQL = "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags"
2106:             ELSE
2107:                 loc_cSQL = "SELECT Fpags FROM SigOpFp " + ;
2108:                            "WHERE Situas IN ('R','A') AND Infos = 'K' " + ;
2109:                            "AND Fpags LIKE " + EscaparSQL(loc_cValor + "%") + ;
2110:                            " ORDER BY Fpags"
2111:             ENDIF
2112:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTituloBanco")
2113: 
2114:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0) ;
2115:                     AND !EMPTY(loc_cValor)
2116:                 IF USED("cursor_4c_BuscaTituloBanco")
2117:                     USE IN cursor_4c_BuscaTituloBanco
2118:                 ENDIF
2119:                 loc_nResult = SQLEXEC(gnConnHandle, ;
2120:                     "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags", ;
2121:                     "cursor_4c_BuscaTituloBanco")
2122:             ENDIF
2123: 
2124:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0
2125:                 MsgAviso("Nenhuma forma de pagamento encontrada.", "Formas de Pagamento")
2126:                 loc_lProsseguir = .F.
2127:             ENDIF
2128: 
2129:             IF loc_lProsseguir
2130:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2131:                 IF VARTYPE(loc_oBusca) = "O"
2132:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTituloBanco"
2133:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2134:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2135:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2136:                     loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2137:                     loc_oBusca.Show()
2138:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTituloBanco")
2139:                         SELECT cursor_4c_BuscaTituloBanco
2140:                         loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_BuscaTituloBanco.Fpags)
2141:                     ENDIF
2142:                     loc_oBusca.Release()
2143:                 ENDIF
2144:             ENDIF
2145:         CATCH TO loc_oErro
2146:             MsgErro(loc_oErro.Message, "Erro")
2147:         ENDTRY
2148: 
2149:         IF USED("cursor_4c_BuscaTituloBanco")
2150:             USE IN cursor_4c_BuscaTituloBanco
2151:         ENDIF
2152:         loc_oPag.txt_4c_TituloBanco.Refresh
2153:     ENDPROC
2154: 

