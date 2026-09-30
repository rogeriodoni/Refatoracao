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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCNB.prg) - TRECHOS RELEVANTES PARA PASS SQL (2187 linhas total):

*-- Linhas 579 a 645:
579:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
580:         ENDWITH
581: 
582:         *-- Cursor placeholder da grade de operacoes (regra #41: o ControlSource
583:         *-- das colunas nao pode apontar para cursor que ainda nao existe).
584:         *-- Estrutura identica a THIS.CarregarOperacoes(), que substitui o
585:         *-- conteudo pelo resultado real do SQLEXEC.
586:         IF USED("cursor_4c_Operacoes")
587:             USE IN cursor_4c_Operacoes
588:         ENDIF
589:         SET NULL ON
590:         CREATE CURSOR cursor_4c_Operacoes (Dopes C(20) NULL, Marca L NULL)
591:         SET NULL OFF
592: 
593:         *-- Grade de selecao de operacoes (grdope no legado, Pagina Filtro)
594:         loc_oPag.AddObject("grd_4c_Operacoes", "Grid")
595:         loc_oGrid = loc_oPag.grd_4c_Operacoes
596:         WITH loc_oGrid
597:             .Top               = 261
598:             .Left              = 350
599:             .Width             = 202
600:             .Height            = 344
601:             .FontName          = "Tahoma"
602:             .AllowHeaderSizing = .F.
603:             .AllowRowSizing    = .F.
604:             .DeleteMark        = .F.
605:             .RecordMark        = .F.
606:             .GridLines         = 3
607:             .GridLineColor     = RGB(238,238,238)
608:             .ScrollBars        = 2
609:             .Themes            = .F.
610:             .ColumnCount       = 2
611:             .RecordSource      = "cursor_4c_Operacoes"
612: 
613:             *-- Limpa o ControlSource auto-atribuido pelo Grid (por default ele
614:             *-- liga Column1 ao 1o campo do cursor - Dopes, Character) ANTES de
615:             *-- adicionar o CheckBox, senao o VFP tenta sincronizar o .Value do
616:             *-- controle novo com um campo Character e estoura "Data type
617:             *-- mismatch" (regra #18: AddObject/CurrentControl SEMPRE antes do
618:             *-- ControlSource definitivo).
619:             .Column1.ControlSource = ""
620:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
621:             .Column1.CurrentControl = "chk_4c_Marca"
622:             WITH .Column1.chk_4c_Marca
623:                 .Caption   = ""
624:                 .BackColor = RGB(255,255,255)
625:             ENDWITH
626: 
627:             .Column1.ControlSource  = "cursor_4c_Operacoes.Marca"
628:             .Column2.ControlSource  = "cursor_4c_Operacoes.Dopes"
629: 
630:             *-- Largura/legenda reaplicadas DEPOIS do RecordSource/ControlSource
631:             *-- (ambos resetam Column.Width e Header1.Caption - Problema 48)
632:             .Column1.Width          = 18
633:             .Column1.Movable        = .F.
634:             .Column1.Resizable      = .F.
635:             .Column1.Sparse         = .F.
636:             .Column1.ReadOnly       = .F.
637:             .Column1.Header1.Caption = ""
638: 
639:             .Column2.Width          = 150
640:             .Column2.Movable        = .F.
641:             .Column2.Resizable      = .F.
642:             .Column2.ReadOnly       = .T.
643:             .Column2.Header1.Alignment = 2
644:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
645:         ENDWITH

*-- Linhas 911 a 996:
911:             .Value         = ""
912:         ENDWITH
913: 
914:         *-- Cursor placeholder da grade de titulos (regra #41 - ControlSource
915:         *-- nao pode apontar para cursor que ainda nao existe). Estrutura
916:         *-- identica ao resultado do SQLEXEC de THIS.ProcessarTitulos()
917:         *-- (mesmos nomes/tipos do "crFiltro" do legado).
918:         IF USED("cursor_4c_Titulos")
919:             USE IN cursor_4c_Titulos
920:         ENDIF
921:         SET NULL ON
922:         CREATE CURSOR cursor_4c_Titulos (Marca L NULL, Titulos C(10) NULL, Dopes C(20) NULL, ;
923:             Numes N(6,0) NULL, RClis C(50) NULL, Vencs T NULL, Fpags C(12) NULL, Valos N(11,2) NULL, ;
924:             Datas T NULL, Vpags N(11,2) NULL, IClis C(10) NULL, Endes C(60) NULL, Cidas C(30) NULL, ;
925:             Estas C(2) NULL, Nums C(10) NULL, Compls C(50) NULL, Bairs C(40) NULL, Ceps C(9) NULL, ;
926:             Cpfs C(20) NULL, Emps C(3) NULL, EmpDopNums C(29) NULL, Nopers N(7,0) NULL, Razaos C(50) NULL, ;
927:             EndCobs C(80) NULL, CepCobs C(9) NULL, EstCobs C(2) NULL, BaiCobs C(20) NULL, CidCobs C(20) NULL, ;
928:             EndErro N(1,0) NULL)
929:         SET NULL OFF
930: 
931:         *-- Grade de titulos em aberto (grdope no legado, Pagina Dados) - 8
932:         *-- colunas. ColumnOrder visual segue o legado (Column8 "Titulo"
933:         *-- aparece logo apos o checkbox - regra #35b: a grade espelha a
934:         *-- estrutura do legado, nao a ordem de criacao das colunas).
935:         loc_oPag.AddObject("grd_4c_Titulos", "Grid")
936:         loc_oGridTit = loc_oPag.grd_4c_Titulos
937:         WITH loc_oGridTit
938:             .Top               = 180
939:             .Left              = 7
940:             .Width             = 981
941:             .Height            = 382
942:             .FontName          = "Tahoma"
943:             .AllowHeaderSizing = .F.
944:             .AllowRowSizing    = .F.
945:             .DeleteMark        = .F.
946:             .RecordMark        = .F.
947:             .GridLineColor     = RGB(238,238,238)
948:             .ScrollBars        = 2
949:             .Themes            = .F.
950:             .ColumnCount       = 8
951:             .RecordSource      = "cursor_4c_Titulos"
952: 
953:             *-- Limpa o ControlSource auto-atribuido pelo Grid ANTES de
954:             *-- adicionar o CheckBox (regra #18).
955:             .Column1.ControlSource = ""
956:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
957:             .Column1.CurrentControl = "chk_4c_Marca"
958:             WITH .Column1.chk_4c_Marca
959:                 .Caption   = ""
960:                 .BackColor = RGB(255,255,255)
961:             ENDWITH
962: 
963:             .Column1.ControlSource = "cursor_4c_Titulos.Marca"
964:             .Column2.ControlSource = "cursor_4c_Titulos.Dopes"
965:             .Column3.ControlSource = "cursor_4c_Titulos.Numes"
966:             .Column4.ControlSource = "cursor_4c_Titulos.RClis"
967:             .Column5.ControlSource = "cursor_4c_Titulos.Vencs"
968:             .Column6.ControlSource = "cursor_4c_Titulos.Fpags"
969:             .Column7.ControlSource = "cursor_4c_Titulos.Valos"
970:             .Column8.ControlSource = "cursor_4c_Titulos.Titulos"
971: 
972:             .Column1.Width           = 16
973:             .Column1.Movable         = .F.
974:             .Column1.Resizable       = .F.
975:             .Column1.Sparse         = .F.
976:             .Column1.ReadOnly        = .F.
977:             .Column1.Header1.Caption = ""
978:         ENDWITH
979: 
980:         *-- Largura/legenda/ordem reaplicadas DEPOIS do RecordSource/
981:         *-- ControlSource (Problema 48 - ambos resetam Column.Width e
982:         *-- Header1.Caption).
983:         THIS.FormatarGridTitulos(loc_oGridTit)
984: 
985:         *-- Container Marcar/Desmarcar Tudo dos titulos (Commandgroup2 no
986:         *-- legado, pgdados) - mesmo padrao visual do cnt_4c_Marca da
987:         *-- Pagina Filtro.
988:         loc_oPag.AddObject("cnt_4c_Marca", "Container")
989:         WITH loc_oPag.cnt_4c_Marca
990:             .Top         = 570
991:             .Left        = 7
992:             .Width       = 92
993:             .Height      = 50
994:             .BackStyle   = 0
995:             .BorderWidth = 0
996: 

*-- Linhas 1030 a 1050:
1030:     *==========================================================================
1031:     * FormatarGridTitulos - Reaplica largura/legenda/ordem/cor dinamica das
1032:     * colunas da grade de titulos. Chamado apos QUALQUER atribuicao de
1033:     * RecordSource/ControlSource (Problema 48 - ambos resetam Column.Width e
1034:     * Header1.Caption): uma vez na estrutura inicial (ConfigurarPaginaDados)
1035:     * e de novo apos o SQLEXEC real (THIS.ProcessarTitulos).
1036:     *==========================================================================
1037:     PROTECTED PROCEDURE FormatarGridTitulos(par_oGrid)
1038:         WITH par_oGrid
1039:             .Column1.Width           = 16
1040:             .Column1.Movable         = .F.
1041:             .Column1.Resizable       = .F.
1042:             .Column1.Sparse          = .F.
1043:             .Column1.ReadOnly        = .F.
1044:             .Column1.ColumnOrder     = 1
1045:             .Column1.Header1.Caption = ""
1046: 
1047:             .Column2.Width             = 150
1048:             .Column2.Movable           = .F.
1049:             .Column2.Resizable         = .F.
1050:             .Column2.ReadOnly          = .T.

*-- Linhas 1106 a 1157:
1106:     *==========================================================================
1107:     * CarregarOperacoes - Popula cursor_4c_Operacoes com as operacoes (SigCdOpe)
1108:     * elegiveis para o processo de CNAB (Parcontas=1 e ValPends=1), igual ao
1109:     * legado (Init: "select dopes, ?lltru as marca from SigCdOpe where
1110:     * Parcontas = 1 And ValPends = 1 order by dopes", com lltru=.F.).
1111:     * Cursor eh READWRITE porque a Coluna1 do grid eh um CheckBox editavel
1112:     * (marca/desmarca operacao) - SQLEXEC devolve cursor somente-leitura.
1113:     *==========================================================================
1114:     PROTECTED PROCEDURE CarregarOperacoes()
1115:         LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
1116:         loc_lSucesso = .F.
1117: 
1118:         TRY
1119:             loc_cSQL = "SELECT Dopes, CAST(0 AS BIT) AS Marca" + CHR(13) + ;
1120:                        "FROM SigCdOpe" + CHR(13) + ;
1121:                        "WHERE Parcontas = 1 AND ValPends = 1" + CHR(13) + ;
1122:                        "ORDER BY Dopes"
1123: 
1124:             IF USED("cursor_4c_OperacoesTmp")
1125:                 USE IN cursor_4c_OperacoesTmp
1126:             ENDIF
1127: 
1128:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTmp")
1129: 
1130:             IF loc_nResultado >= 0
1131:                 IF USED("cursor_4c_Operacoes")
1132:                     USE IN cursor_4c_Operacoes
1133:                 ENDIF
1134: 
1135:                 SELECT * FROM cursor_4c_OperacoesTmp INTO CURSOR cursor_4c_Operacoes READWRITE
1136: 
1137:                 IF USED("cursor_4c_OperacoesTmp")
1138:                     USE IN cursor_4c_OperacoesTmp
1139:                 ENDIF
1140: 
1141:                 IF RECCOUNT("cursor_4c_Operacoes") > 0
1142:                     SELECT cursor_4c_Operacoes
1143:                     GO TOP
1144:                 ENDIF
1145: 
1146:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.ColumnCount = 3
1147:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.RecordSource = "cursor_4c_Operacoes"
1148:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1149: 
1150:                 loc_lSucesso = .T.
1151:             ELSE
1152:                 MostrarErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1153:                             CapturarErroSQL(), "Erro SQL")
1154:             ENDIF
1155:         CATCH TO loc_oErro
1156:             MostrarErro(loc_oErro.Message + CHR(13) + ;
1157:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1241 a 1259:
1241: 
1242:         loc_nCont = 0
1243:         IF USED("cursor_4c_Operacoes")
1244:             SELECT cursor_4c_Operacoes
1245:             COUNT FOR Marca TO loc_nCont
1246:         ENDIF
1247:         IF loc_nCont = 0
1248:             MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada", "Aviso")
1249:             RETURN
1250:         ENDIF
1251: 
1252:         THIS.ProcessarTitulos()
1253:     ENDPROC
1254: 
1255:     *==========================================================================
1256:     * BtnEncerrarClick - cmdTestaPos.btnsair.Click (Pagina Filtro) no legado.
1257:     *==========================================================================
1258:     PROCEDURE BtnEncerrarClick()
1259:         THIS.Release()

*-- Linhas 1266 a 1294:
1266:     *==========================================================================
1267:     PROCEDURE BtnMarcarTudoClick()
1268:         IF USED("cursor_4c_Operacoes")
1269:             SELECT cursor_4c_Operacoes
1270:             REPLACE ALL Marca WITH .T.
1271:             LOCATE
1272:             GO TOP
1273:         ENDIF
1274:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1275:     ENDPROC
1276: 
1277:     PROCEDURE BtnDesmarcarTudoClick()
1278:         IF USED("cursor_4c_Operacoes")
1279:             SELECT cursor_4c_Operacoes
1280:             REPLACE ALL Marca WITH .F.
1281:             LOCATE
1282:             GO TOP
1283:         ENDIF
1284:         THIS.pgf_4c_Paginas.Page1.grd_4c_Operacoes.Refresh()
1285:     ENDPROC
1286: 
1287:     *==========================================================================
1288:     * ProcessarTitulos - PROCEDURE processamento no legado. Monta a lista de
1289:     * operacoes marcadas + consulta os titulos em aberto (SigMvPar/SigOpFp/
1290:     * SigMvCab/SigCdCli/SigMvCcr), populando cursor_4c_Titulos (READWRITE -
1291:     * a coluna Marca eh CheckBox editavel no grid). Formula/filtros
1292:     * TRANSCRITOS literalmente do legado (regra CLAUDE.md #17) - inclusive a
1293:     * ausencia de filtro pela conta/carteira na consulta (o legado le
1294:     * get_cd_car_conta so para validar preenchimento, e aplica a conta

*-- Linhas 1312 a 1402:
1312:         *-- POSICIONAL concatenada da regra #42, ALLTRIM por item eh seguro.
1313:         loc_cListaOperacoes = "("
1314:         IF USED("cursor_4c_Operacoes")
1315:             SELECT cursor_4c_Operacoes
1316:             SCAN FOR Marca
1317:                 loc_cListaOperacoes = loc_cListaOperacoes + ;
1318:                     IIF(loc_cListaOperacoes == "(", "", ",") + EscaparSQL(ALLTRIM(Dopes))
1319:             ENDSCAN
1320:         ENDIF
1321:         loc_cListaOperacoes = loc_cListaOperacoes + ")"
1322: 
1323:         loc_cCampoData = IIF(loc_nPeriodo = 1, "a.vencs", "e.dtemis")
1324:         loc_cNotIn     = IIF(loc_lNaoProcessados, "NOT ", "")
1325: 
1326:         TRY
1327:             loc_cSQL = ;
1328:                 "SELECT CAST(1 AS BIT) AS Marca, e.titulos AS Titulos, a.dopes AS Dopes, a.numes AS Numes," + CHR(13) + ;
1329:                 "       d.rclis AS RClis, a.vencs AS Vencs, b.fpags AS Fpags, a.valos AS Valos, a.datas AS Datas," + CHR(13) + ;
1330:                 "       a.vpags AS Vpags, d.iclis AS IClis, d.endes AS Endes, d.cidas AS Cidas, d.estas AS Estas," + CHR(13) + ;
1331:                 "       d.nums AS Nums, d.compls AS Compls, d.bairs AS Bairs, d.ceps AS Ceps, d.cpfs AS Cpfs," + CHR(13) + ;
1332:                 "       a.emps AS Emps, a.empdopnums AS EmpDopNums, a.nopers AS Nopers, d.razaos AS Razaos," + CHR(13) + ;
1333:                 "       d.endcobs AS EndCobs, d.cepcobs AS CepCobs, d.estcobs AS EstCobs, d.baicobs AS BaiCobs, d.cidcobs AS CidCobs," + CHR(13) + ;
1334:                 "       CASE WHEN d.endcobs <> '' AND LEN(RTRIM(d.endcobs)) > 40 THEN 1" + CHR(13) + ;
1335:                 "            WHEN d.endes <> '' AND LEN(RTRIM(d.endes) + ' ' + RTRIM(d.nums) + ' ' + RTRIM(d.compls)) > 40 THEN 1" + CHR(13) + ;
1336:                 "            ELSE 0 END AS EndErro" + CHR(13) + ;
1337:                 "FROM SigMvPar a" + CHR(13) + ;
1338:                 "INNER JOIN SigOpFp b ON a.fpags = b.fpags" + CHR(13) + ;
1339:                 "LEFT JOIN SigMvCab c ON a.empdopnums = c.empdopnums" + CHR(13) + ;
1340:                 "LEFT JOIN SigCdCli d ON c.contads = d.iclis" + CHR(13) + ;
1341:                 "LEFT JOIN SigMvCcr e ON a.empdopnums = e.empdopnums AND a.nopers = e.nopers" + CHR(13) + ;
1342:                 "WHERE b.infos = 'B' AND a.vpags = 0" + CHR(13) + ;
1343:                 "  AND " + loc_cCampoData + " BETWEEN " + FormatarDataSQL(loc_dIni) + " AND " + FormatarDataSQL(loc_dFim) + CHR(13) + ;
1344:                 "  AND e.opers = 'C'" + CHR(13) + ;
1345:                 "  AND c.emps = " + EscaparSQL(loc_cEmpresa) + CHR(13) + ;
1346:                 "  AND a.dopes IN " + loc_cListaOperacoes + CHR(13) + ;
1347:                 "  AND a.empdopnums + e.titulos " + loc_cNotIn + "IN (" + CHR(13) + ;
1348:                 "      SELECT f.empdopnums + SUBSTRING(f.dopeds, 1, 10)" + CHR(13) + ;
1349:                 "      FROM SigPcOoL f" + CHR(13) + ;
1350:                 "      WHERE f.tipos = 'SIGPRCNB')" + CHR(13) + ;
1351:                 "ORDER BY a.dopes, a.numes, a.parcs"
1352: 
1353:             IF USED("cursor_4c_TitulosTmp")
1354:                 USE IN cursor_4c_TitulosTmp
1355:             ENDIF
1356: 
1357:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitulosTmp")
1358: 
1359:             IF loc_nResultado >= 0
1360:                 IF USED("cursor_4c_Titulos")
1361:                     USE IN cursor_4c_Titulos
1362:                 ENDIF
1363: 
1364:                 SELECT * FROM cursor_4c_TitulosTmp INTO CURSOR cursor_4c_Titulos READWRITE
1365: 
1366:                 IF USED("cursor_4c_TitulosTmp")
1367:                     USE IN cursor_4c_TitulosTmp
1368:                 ENDIF
1369: 
1370:                 IF RECCOUNT("cursor_4c_Titulos") = 0
1371:                     MsgAviso("Nenhum dado foi encontrado", "Aviso")
1372:                 ELSE
1373:                     SELECT cursor_4c_Titulos
1374:                     REPLACE ALL Marca WITH .F. FOR EndErro = 1
1375:                     GO TOP
1376: 
1377:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos
1378:                     loc_oGrid.ColumnCount = 8
1379:                     loc_oGrid.RecordSource         = "cursor_4c_Titulos"
1380:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Titulos.Marca"
1381:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Titulos.Dopes"
1382:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Titulos.Numes"
1383:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Titulos.RClis"
1384:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Titulos.Vencs"
1385:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Titulos.Fpags"
1386:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Titulos.Valos"
1387:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Titulos.Titulos"
1388:                     THIS.FormatarGridTitulos(loc_oGrid)
1389:                     loc_oGrid.Refresh()
1390: 
1391:                     THIS.pgf_4c_Paginas.Page1.Enabled = .F.
1392:                     THIS.pgf_4c_Paginas.Page2.Enabled = .T.
1393: 
1394:                     *-- cmdTestaPos.btnBoleto.Enabled = !llNPr no legado (linha
1395:                     *-- 1468): Boleto so comeca habilitado quando o filtro eh
1396:                     *-- "Ja Processadas" (reimpressao); ProcessadoBrasil/
1397:                     *-- Santander240 forcam .T. depois de gerar com sucesso.
1398:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.obj_4c_Comandos.Buttons(3).Enabled = ;
1399:                         (loc_oPag.obj_4c_Processados.Value = 2)
1400: 
1401:                     THIS.AlternarPagina(2)
1402:                     loc_lSucesso = .T.

*-- Linhas 1436 a 1464:
1436:     *==========================================================================
1437:     PROCEDURE BtnMarcarTudoTitulosClick()
1438:         IF USED("cursor_4c_Titulos")
1439:             SELECT cursor_4c_Titulos
1440:             REPLACE ALL Marca WITH .T.
1441:             LOCATE
1442:             GO TOP
1443:         ENDIF
1444:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1445:     ENDPROC
1446: 
1447:     PROCEDURE BtnDesmarcarTudoTitulosClick()
1448:         IF USED("cursor_4c_Titulos")
1449:             SELECT cursor_4c_Titulos
1450:             REPLACE ALL Marca WITH .F.
1451:             LOCATE
1452:             GO TOP
1453:         ENDIF
1454:         THIS.pgf_4c_Paginas.Page2.grd_4c_Titulos.Refresh()
1455:     ENDPROC
1456: 
1457:     *==========================================================================
1458:     * ChkTituloMarcaClick - Column1.Check1.When no legado (Return
1459:     * crFiltro.EndErro = 0): titulo com endereco muito longo nao pode ser
1460:     * selecionado. O nativo do CheckBox ja alterna Marca no clique; aqui so
1461:     * revertemos quando a linha estiver marcada como EndErro=1.
1462:     *==========================================================================
1463:     PROCEDURE ChkTituloMarcaClick()
1464:         IF USED("cursor_4c_Titulos") AND !EOF("cursor_4c_Titulos")

*-- Linhas 1558 a 1576:
1558:         LOCAL loc_nMarcados
1559: 
1560:         IF USED("cursor_4c_Titulos")
1561:             SELECT cursor_4c_Titulos
1562:             COUNT FOR Marca TO loc_nMarcados
1563:         ELSE
1564:             loc_nMarcados = 0
1565:         ENDIF
1566: 
1567:         IF loc_nMarcados = 0
1568:             MsgAviso("Nenhum registro foi selecionado", "Aviso")
1569:             RETURN
1570:         ENDIF
1571: 
1572:         THIS.ExecutarReportForm("SigReCnb", "PREVIEW", "cursor_4c_Titulos")
1573:     ENDPROC
1574: 
1575:     *==========================================================================
1576:     * BtnBoletoClick - Commandgroup1.btnBoleto.Click no legado ("thisform.

*-- Linhas 1627 a 1645:
1627: 
1628:     *==========================================================================
1629:     * ValidarCodEmpresa - KeyPress em txt_4c_CodEmpresa (get_cd_empresa no
1630:     * legado). Enter/Tab/F4 -> SELECT exato em SigCdEmp.Cemps; hit preenche a
1631:     * razao social, miss abre o picker (fAcessoEmpresa modo 'C' nao portada -
1632:     * regra CLAUDE.md sobre fAcessoEmpresa, substituicao canonica FormBuscaAuxiliar
1633:     * em SigCdEmp).
1634:     *==========================================================================
1635:     PROCEDURE ValidarCodEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1636:         LOCAL loc_oPag, loc_cVal, loc_nResult
1637: 
1638:         IF par_nKeyCode = 115
1639:             THIS.AbrirBuscaEmpresa()
1640:             RETURN
1641:         ENDIF
1642: 
1643:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1644:             RETURN
1645:         ENDIF

*-- Linhas 1654 a 1676:
1654:         ENDIF
1655: 
1656:         TRY
1657:             loc_nResult = SQLEXEC(gnConnHandle, ;
1658:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
1659:                 "cursor_4c_EmpresaVal")
1660:             IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
1661:                 SELECT cursor_4c_EmpresaVal
1662:                 loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
1663:                 loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
1664:             ELSE
1665:                 THIS.AbrirBuscaEmpresa()
1666:             ENDIF
1667:             IF USED("cursor_4c_EmpresaVal")
1668:                 USE IN cursor_4c_EmpresaVal
1669:             ENDIF
1670:         CATCH TO loc_oErro
1671:             MsgErro(loc_oErro.Message, "Erro")
1672:         ENDTRY
1673: 
1674:         loc_oPag.txt_4c_CodEmpresa.Refresh
1675:         loc_oPag.txt_4c_NomeEmpresa.Refresh
1676:     ENDPROC

*-- Linhas 1705 a 1727:
1705:         ENDIF
1706: 
1707:         TRY
1708:             loc_nResult = SQLEXEC(gnConnHandle, ;
1709:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) = " + EscaparSQL(loc_cVal), ;
1710:                 "cursor_4c_EmpresaVal")
1711:             IF loc_nResult > 0 AND USED("cursor_4c_EmpresaVal") AND !EOF("cursor_4c_EmpresaVal")
1712:                 SELECT cursor_4c_EmpresaVal
1713:                 loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_EmpresaVal.Cemps)
1714:                 loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_EmpresaVal.Razas)
1715:             ELSE
1716:                 THIS.AbrirBuscaEmpresa()
1717:             ENDIF
1718:             IF USED("cursor_4c_EmpresaVal")
1719:                 USE IN cursor_4c_EmpresaVal
1720:             ENDIF
1721:         CATCH TO loc_oErro
1722:             MsgErro(loc_oErro.Message, "Erro")
1723:         ENDTRY
1724: 
1725:         loc_oPag.txt_4c_CodEmpresa.Refresh
1726:         loc_oPag.txt_4c_NomeEmpresa.Refresh
1727:     ENDPROC

*-- Linhas 1747 a 1800:
1747:         loc_lProsseguir = .T.
1748:         TRY
1749:             IF EMPTY(loc_cValor)
1750:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
1751:             ELSE
1752:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
1753:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
1754:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1755:                            " ORDER BY Cemps"
1756:             ENDIF
1757:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpresa")
1758: 
1759:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0) ;
1760:                     AND !EMPTY(loc_cValor)
1761:                 IF USED("cursor_4c_BuscaEmpresa")
1762:                     USE IN cursor_4c_BuscaEmpresa
1763:                 ENDIF
1764:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1765:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
1766:                     "cursor_4c_BuscaEmpresa")
1767:             ENDIF
1768: 
1769:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmpresa") OR RECCOUNT("cursor_4c_BuscaEmpresa") = 0
1770:                 MsgAviso("Nenhuma empresa encontrada.", "Empresa")
1771:                 loc_lProsseguir = .F.
1772:             ENDIF
1773: 
1774:             IF loc_lProsseguir
1775:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1776:                 IF VARTYPE(loc_oBusca) = "O"
1777:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpresa"
1778:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1779:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1780:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1781:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1782:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1783:                     loc_oBusca.Show()
1784:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1785:                         SELECT cursor_4c_BuscaEmpresa
1786:                         loc_oPag.txt_4c_CodEmpresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1787:                         loc_oPag.txt_4c_NomeEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1788:                     ENDIF
1789:                     loc_oBusca.Release()
1790:                 ENDIF
1791:             ENDIF
1792:         CATCH TO loc_oErro
1793:             MsgErro(loc_oErro.Message, "Erro")
1794:         ENDTRY
1795: 
1796:         IF USED("cursor_4c_BuscaEmpresa")
1797:             USE IN cursor_4c_BuscaEmpresa
1798:         ENDIF
1799:         loc_oPag.txt_4c_CodEmpresa.Refresh
1800:         loc_oPag.txt_4c_NomeEmpresa.Refresh

*-- Linhas 1823 a 1841:
1823: 
1824:     *==========================================================================
1825:     * ValidarCodConta - KeyPress em txt_4c_CodConta (get_cd_car_conta no
1826:     * legado). Enter/Tab/F4 -> SELECT exato em SigCdCli.IClis; hit preenche a
1827:     * razao social, miss abre o picker (fAcessoContas NAO USAR para lookup UX -
1828:     * regra CLAUDE.md, substituicao canonica SigCdCli.IClis/RClis).
1829:     *==========================================================================
1830:     PROCEDURE ValidarCodConta(par_nKeyCode, par_nShiftAltCtrl)
1831:         LOCAL loc_oPag, loc_cVal, loc_nResult
1832: 
1833:         IF par_nKeyCode = 115
1834:             THIS.AbrirBuscaConta()
1835:             RETURN
1836:         ENDIF
1837: 
1838:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1839:             RETURN
1840:         ENDIF
1841: 

*-- Linhas 1849 a 1871:
1849:         ENDIF
1850: 
1851:         TRY
1852:             loc_nResult = SQLEXEC(gnConnHandle, ;
1853:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
1854:                 "cursor_4c_ContaVal")
1855:             IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
1856:                 SELECT cursor_4c_ContaVal
1857:                 loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
1858:                 loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
1859:             ELSE
1860:                 MsgAviso("Conta Inv" + CHR(225) + "lida, Acesso Negado.", "Aviso")
1861:                 loc_oPag.txt_4c_CodConta.Value  = ""
1862:                 loc_oPag.txt_4c_NomeConta.Value = ""
1863:             ENDIF
1864:             IF USED("cursor_4c_ContaVal")
1865:                 USE IN cursor_4c_ContaVal
1866:             ENDIF
1867:         CATCH TO loc_oErro
1868:             MsgErro(loc_oErro.Message, "Erro")
1869:         ENDTRY
1870: 
1871:         loc_oPag.txt_4c_CodConta.Refresh

*-- Linhas 1902 a 1924:
1902:         ENDIF
1903: 
1904:         TRY
1905:             loc_nResult = SQLEXEC(gnConnHandle, ;
1906:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) = " + EscaparSQL(loc_cVal), ;
1907:                 "cursor_4c_ContaVal")
1908:             IF loc_nResult > 0 AND USED("cursor_4c_ContaVal") AND !EOF("cursor_4c_ContaVal")
1909:                 SELECT cursor_4c_ContaVal
1910:                 loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_ContaVal.IClis)
1911:                 loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_ContaVal.RClis)
1912:             ELSE
1913:                 THIS.AbrirBuscaConta()
1914:             ENDIF
1915:             IF USED("cursor_4c_ContaVal")
1916:                 USE IN cursor_4c_ContaVal
1917:             ENDIF
1918:         CATCH TO loc_oErro
1919:             MsgErro(loc_oErro.Message, "Erro")
1920:         ENDTRY
1921: 
1922:         loc_oPag.txt_4c_CodConta.Refresh
1923:         loc_oPag.txt_4c_NomeConta.Refresh
1924:     ENDPROC

*-- Linhas 1944 a 1997:
1944:         loc_lProsseguir = .T.
1945:         TRY
1946:             IF EMPTY(loc_cValor)
1947:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
1948:             ELSE
1949:                 loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
1950:                            "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1951:                            " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
1952:                            " ORDER BY IClis"
1953:             ENDIF
1954:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1955: 
1956:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0) ;
1957:                     AND !EMPTY(loc_cValor)
1958:                 IF USED("cursor_4c_BuscaConta")
1959:                     USE IN cursor_4c_BuscaConta
1960:                 ENDIF
1961:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1962:                     "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
1963:                     "cursor_4c_BuscaConta")
1964:             ENDIF
1965: 
1966:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
1967:                 MsgAviso("Nenhuma conta encontrada.", "Conta")
1968:                 loc_lProsseguir = .F.
1969:             ENDIF
1970: 
1971:             IF loc_lProsseguir
1972:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1973:                 IF VARTYPE(loc_oBusca) = "O"
1974:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1975:                     loc_oBusca.this_cTitulo        = loc_cTitulo
1976:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
1977:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
1978:                     loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1979:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1980:                     loc_oBusca.Show()
1981:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1982:                         SELECT cursor_4c_BuscaConta
1983:                         loc_oPag.txt_4c_CodConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1984:                         loc_oPag.txt_4c_NomeConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1985:                     ENDIF
1986:                     loc_oBusca.Release()
1987:                 ENDIF
1988:             ENDIF
1989:         CATCH TO loc_oErro
1990:             MsgErro(loc_oErro.Message, "Erro")
1991:         ENDTRY
1992: 
1993:         IF USED("cursor_4c_BuscaConta")
1994:             USE IN cursor_4c_BuscaConta
1995:         ENDIF
1996:         loc_oPag.txt_4c_CodConta.Refresh
1997:         loc_oPag.txt_4c_NomeConta.Refresh

*-- Linhas 2024 a 2047:
2024:         ENDIF
2025: 
2026:         TRY
2027:             loc_nResult = SQLEXEC(gnConnHandle, ;
2028:                 "SELECT TOP 1 Fpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cVal) + ;
2029:                 " AND Situas IN ('R','A') AND Infos = 'K'", ;
2030:                 "cursor_4c_TituloBancoVal")
2031:             IF loc_nResult > 0 AND USED("cursor_4c_TituloBancoVal") AND !EOF("cursor_4c_TituloBancoVal")
2032:                 SELECT cursor_4c_TituloBancoVal
2033:                 loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_TituloBancoVal.Fpags)
2034:             ELSE
2035:                 THIS.AbrirBuscaTituloBanco()
2036:             ENDIF
2037:             IF USED("cursor_4c_TituloBancoVal")
2038:                 USE IN cursor_4c_TituloBancoVal
2039:             ENDIF
2040:         CATCH TO loc_oErro
2041:             MsgErro(loc_oErro.Message, "Erro")
2042:         ENDTRY
2043: 
2044:         loc_oPag.txt_4c_TituloBanco.Refresh
2045:     ENDPROC
2046: 
2047:     *==========================================================================

*-- Linhas 2064 a 2116:
2064:         loc_lProsseguir = .T.
2065:         TRY
2066:             IF EMPTY(loc_cValor)
2067:                 loc_cSQL = "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags"
2068:             ELSE
2069:                 loc_cSQL = "SELECT Fpags FROM SigOpFp " + ;
2070:                            "WHERE Situas IN ('R','A') AND Infos = 'K' " + ;
2071:                            "AND Fpags LIKE " + EscaparSQL(loc_cValor + "%") + ;
2072:                            " ORDER BY Fpags"
2073:             ENDIF
2074:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTituloBanco")
2075: 
2076:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0) ;
2077:                     AND !EMPTY(loc_cValor)
2078:                 IF USED("cursor_4c_BuscaTituloBanco")
2079:                     USE IN cursor_4c_BuscaTituloBanco
2080:                 ENDIF
2081:                 loc_nResult = SQLEXEC(gnConnHandle, ;
2082:                     "SELECT Fpags FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K' ORDER BY Fpags", ;
2083:                     "cursor_4c_BuscaTituloBanco")
2084:             ENDIF
2085: 
2086:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaTituloBanco") OR RECCOUNT("cursor_4c_BuscaTituloBanco") = 0
2087:                 MsgAviso("Nenhuma forma de pagamento encontrada.", "Formas de Pagamento")
2088:                 loc_lProsseguir = .F.
2089:             ENDIF
2090: 
2091:             IF loc_lProsseguir
2092:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2093:                 IF VARTYPE(loc_oBusca) = "O"
2094:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTituloBanco"
2095:                     loc_oBusca.this_cTitulo        = loc_cTitulo
2096:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
2097:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
2098:                     loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2099:                     loc_oBusca.Show()
2100:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTituloBanco")
2101:                         SELECT cursor_4c_BuscaTituloBanco
2102:                         loc_oPag.txt_4c_TituloBanco.Value = ALLTRIM(cursor_4c_BuscaTituloBanco.Fpags)
2103:                     ENDIF
2104:                     loc_oBusca.Release()
2105:                 ENDIF
2106:             ENDIF
2107:         CATCH TO loc_oErro
2108:             MsgErro(loc_oErro.Message, "Erro")
2109:         ENDTRY
2110: 
2111:         IF USED("cursor_4c_BuscaTituloBanco")
2112:             USE IN cursor_4c_BuscaTituloBanco
2113:         ENDIF
2114:         loc_oPag.txt_4c_TituloBanco.Refresh
2115:     ENDPROC
2116: 

