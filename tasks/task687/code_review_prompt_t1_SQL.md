# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NUMS, CIDCHAVES

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "SigCdClh.datas"
  ControlSource = "SigCdClh.hists"
lcQueryCheh  = [Select * From SigCheh Where Nums = ?lcNum ]
Select crSigCheH
	.DeleteMark = .f.
	.Column1.Controlsource = 'crSigCheH.Datas'
	.Column2.Controlsource = 'crSigCheH.Hists'
Select CrSigCheh
		lcDelete = [ Delete From SigCheh Where CidChaves = ']+pChave+[']
		lnErro = ThisForm.poDatamgr.SqlExecute(lcDelete,'')
			Select CrSigCheh
			Delete
Select CrSigCheH
Select CrSigCheh
		Select CrSigCheh
	ThisForm.podatamgr.Update('CrSigCheh')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCfl.prg) - TRECHOS RELEVANTES PARA PASS SQL (1979 linhas total):

*-- Linhas 619 a 637:
619:     * CrSigCheh.Datas no Alterar - Value inicial {} igual ao this_dDatas
620:     * do BO). txt_4c_Hist eh CHARACTER (SigCheh.hists char(76) - MaxLength
621:     * = 76, regra #19/CLAUDE.md; o dump legado nao declara MaxLength
622:     * nesse controle porque GetHist nao tem ControlSource fixo, mas o
623:     * destino SQL eh char(76), igual ao LEFT(...,76) de
624:     * SigOpCflBO.Inserir/Atualizar). Format = "K!"/"K" transcritos
625:     * literalmente do dump (regra #49/CLAUDE.md).
626:     * O LostFocus de txt_4c_Hist (GetHist.LostFocus legado) eh ligado aqui
627:     * por BINDEVENT - eh ELE que grava o followup. O toggle de Visible do
628:     * container e o preenchimento inicial dos dois campos (Incluir/Alterar)
629:     * ficam para a Fase 8 (eventos dos botoes de acao).
630:     *==========================================================================
631:     PROTECTED PROCEDURE ConfigurarPainelInserir()
632:         LOCAL loc_oErro
633:         TRY
634:             THIS.cnt_4c__inserir.AddObject("lbl_4c_Label13", "Label")
635:             WITH THIS.cnt_4c__inserir.lbl_4c_Label13
636:                 .FontName  = "Tahoma"
637:                 .FontSize  = 8

*-- Linhas 717 a 780:
717:     * moldura shp_4c_Shape2) - area de dados NAO escala com a largura nova
718:     * do form (mesmo padrao de ConfigurarContainersBase).
719:     * Liga a grade a um cursor PLACEHOLDER (cursor_4c_Dados) criado aqui -
720:     * regra #41/CLAUDE.md: Column.ControlSource exige o alias JA existir,
721:     * senao o Init inteiro estoura "Alias is not found". A ORDEM dos campos
722:     * eh IDENTICA a SigOpCflBO.CarregarDoCursor (cidchaves, nums, datas,
723:     * emps, hists, numlotes, autos) - a Fase 7/8 popula este mesmo cursor
724:     * via SQLEXEC em cursor temporario + ZAP + APPEND FROM DBF().
725:     * Bloco de configuracao runtime (ColumnCount/RecordSource/ControlSource/
726:     * Width/Header.Caption, nesta ordem) e o DynamicForeColor (verde para
727:     * historico automatico) transcritos literalmente do Init legado
728:     * (With ThisForm.gridFollowup ... SetAll('DynamicForeColor', ...)).
729: * A celula "Data / Hora" (Column1) recebe a classe
730: * TextBoxCelulaFollowupCfl_4c via AddObject + CurrentControl + Sparse =
731: * .F. (regra #18): eh ela que carrega o When e o Valid que o legado tem em
732: * gridFollowup.Column1.Text1 - BINDEVENT em evento de celula de Grid nao eh
733: * confiavel (regra #46).
734:     *==========================================================================
735:     PROTECTED PROCEDURE ConfigurarGrid()
736:         LOCAL loc_oErro
737:         TRY
738:             IF USED("cursor_4c_Dados")
739:                 USE IN cursor_4c_Dados
740:             ENDIF
741:             SET NULL ON
742:             CREATE CURSOR cursor_4c_Dados ;
743:                 (cidchaves C(20), nums C(8), datas T, emps C(3), hists C(76), numlotes N(8,0), autos L)
744:             SET NULL OFF
745: 
746:             THIS.AddObject("grd_4c_Dados", "Grid")
747:             WITH THIS.grd_4c_Dados
748:                 .Top           = 177
749:                 .Left          = 67
750:                 .Width         = 667
751:                 .Height        = 312
752:                 .ReadOnly      = .T.
753:                 .DeleteMark    = .F.
754:                 .RecordMark    = .F.
755:                 .ScrollBars    = 2
756:                 .GridLineColor = RGB(238, 238, 238)
757:                 .TabIndex      = 1
758:                 .BackColor     = RGB(255, 255, 255)
759:                 .Visible       = .T.
760: 
761:                 .ColumnCount  = 2
762:                 .RecordSource = "cursor_4c_Dados"
763: 
764:                 .Column1.ControlSource = "cursor_4c_Dados.datas"
765:                 .Column2.ControlSource = "cursor_4c_Dados.hists"
766: 
767:                 .Column1.Width = 144
768:                 .Column2.Width = 490
769: 
770:                 .Column1.Movable   = .F.
771:                 .Column2.Movable   = .F.
772:                 .Column1.Resizable = .F.
773:                 .Column2.Resizable = .F.
774:                 .Column1.ReadOnly  = .T.
775:                 .Column2.ReadOnly  = .T.
776:                 .Column2.InputMask = REPLICATE("X", 76)
777: 
778:                 .Column1.FontName = "Courier New"
779:                 .Column2.FontName = "Courier New"
780: 

*-- Linhas 900 a 960:
900:     *==========================================================================
901:     * CarregarLista - Popula a grade de historico (followup) do cheque
902:     * consultado. Legado (SIGOPCFL.Init):
903:     *     lcQueryCheh = [Select * From SigCheh Where Nums = ?lcNum ]
904:     *     .AddCursor('SigCheh','CidChaves','CrSigCheh','','',lcQueryCheh)
905:     *     =ThisForm.Podatamgr.Requery('CrSigCheh')
906:     *     Select crSigCheH / Go Top
907:     * Ou seja: o filtro eh SEMPRE aplicado (inclusive com Nums vazio, caso em
908:     * que a consulta nao casa nada e a grade abre vazia de proposito - regra
909:     * #35a). O SQLEXEC vai para um cursor TEMPORARIO e o alias da grade eh
910:     * recarregado com ZAP + APPEND FROM DBF(), para nao derrubar
911:     * RecordSource/ControlSource/largura das colunas (SQLEXEC sobre o alias
912:     * ligado ao Grid zera o ColumnCount). Fecha com GO TOP + Refresh, que eh
913:     * o 'Go Top' + repintura que o legado faz (regra #21a).
914:     * A lista de colunas do SELECT eh IDENTICA (nome e ordem) a do
915:     * CREATE CURSOR de ConfigurarGrid - APPEND FROM casa por NOME.
916:     *==========================================================================
917:     PROCEDURE CarregarLista()
918:         LOCAL loc_lSucesso, loc_oBO, loc_oErro
919:         loc_lSucesso = .F.
920: 
921:         TRY
922:             IF !USED("cursor_4c_Dados")
923:                 THIS.ConfigurarGrid()
924:             ENDIF
925: 
926:             IF USED("cursor_4c_DadosTmp")
927:                 USE IN cursor_4c_DadosTmp
928:             ENDIF
929: 
930:             loc_oBO = THIS.this_oBusinessObject
931: 
932:             *-- Sem conexao (validacao de UI / modo teste) a grade fica vazia,
933:             *-- mas o cursor e o binding continuam validos.
934:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND VARTYPE(loc_oBO) = "O"
935:                 *-- A consulta mora no BO (PILAR 3 - o form nao fala com o
936:                 *-- banco). O BO devolve as linhas no cursor TEMPORARIO e o
937:                 *-- alias ligado ao Grid eh recarregado com ZAP + APPEND FROM
938:                 *-- DBF(), que preserva RecordSource/ControlSource/Width das
939:                 *-- colunas e o CurrentControl da celula de data.
940:                 IF loc_oBO.CarregarHistorico(THIS.this_cConta, "cursor_4c_DadosTmp")
941:                     *-- Esvazia SO depois do SELECT ter dado certo: ZAP antes
942:                     *-- da consulta deixaria a grade vazia quando o SQL Server
943:                     *-- recusasse.
944:                     THIS.EsvaziarCursorDados()
945:                     APPEND FROM DBF("cursor_4c_DadosTmp")
946:                     loc_lSucesso = .T.
947:                 ENDIF
948: 
949:                 IF USED("cursor_4c_DadosTmp")
950:                     USE IN cursor_4c_DadosTmp
951:                 ENDIF
952:             ELSE
953:                 THIS.EsvaziarCursorDados()
954:                 loc_lSucesso = .T.
955:             ENDIF
956: 
957:             THIS.RepintarGrade()
958:         CATCH TO loc_oErro
959:             MsgErro(loc_oErro.Message + CHR(13) + ;
960:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 966 a 1026:
966: 
967:     *==========================================================================
968:     * EsvaziarCursorDados - ZAP no cursor da grade, com SET SAFETY guardado.
969:     * ZAP (e nao USE IN + CREATE CURSOR) eh a escolha CERTA aqui: eh o
970:     * 'Zap In <cursor>' do legado Fortyus e preserva a estrutura, o
971:     * RecordSource/ControlSource do Grid e o CurrentControl da celula de data -
972:     * fechar e recriar o alias derrubaria o binding e a grade ficaria
973:     * permanentemente vazia com o cursor cheio.
974:     * O guard de SAFETY eh obrigatorio porque este form eh DataSession = 2:
975:     * SET SAFETY eh escopado por sessao de dados e vale ON na sessao privada
976:     * MESMO com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP abre o
977:     * dialogo modal "Zap ... Are you sure?" e a tela CONGELA esperando um
978:     * clique que ninguem ve - em teste headless isso aparece como timeout sem
979:     * erro nenhum, nao como falha.
980:     * Restaura o valor ANTERIOR em vez de forcar OFF: desligar SAFETY para o
981:     * resto da vida da sessao tiraria a protecao de outros comandos
982:     * destrutivos (COPY TO / COPY FILE sobre arquivo existente).
983:     * Deixa cursor_4c_Dados SELECIONADO na saida - o APPEND FROM de
984:     * CarregarLista conta com isso (APPEND vai para a area de trabalho
985:     * CORRENTE, e ZAP IN nao muda a area corrente).
986:     *==========================================================================
987:     PROCEDURE EsvaziarCursorDados()
988:         LOCAL loc_cSafety
989: 
990:         IF USED("cursor_4c_Dados")
991:             loc_cSafety = SET("SAFETY")
992:             SET SAFETY OFF
993: 
994:             SELECT cursor_4c_Dados
995:             ZAP
996: 
997:             IF loc_cSafety = "ON"
998:                 SET SAFETY ON
999:             ENDIF
1000:         ENDIF
1001:     ENDPROC
1002: 
1003:     *==========================================================================
1004:     * RepintarGrade - Posiciona no topo e repinta a grade. Metodo UNICO,
1005:     * chamado por TODO caminho que popula cursor_4c_Dados: popular cursor NAO
1006:     * repinta a grade sozinho (regra #21a), e o legado sempre fecha com
1007:     * 'Select crSigCheH / Go Top' + 'ThisForm.gridFollowup.Refresh'.
1008:     *==========================================================================
1009:     PROCEDURE RepintarGrade()
1010:         IF USED("cursor_4c_Dados")
1011:             SELECT cursor_4c_Dados
1012:             GO TOP IN cursor_4c_Dados
1013:         ENDIF
1014: 
1015:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1016:             THIS.grd_4c_Dados.Refresh()
1017:         ENDIF
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * CelulaDataFollowupEditavel - When da celula "Data / Hora" da grade.
1022:     * Legado (SIGOPCFL.gridFollowup.Column1.Text1.When), transcrito:
1023:     *     Return ThisForm.cmdApagaItem.cmdApagar.Visible
1024:     * cmdApagar eh o Buttons(1) de cmg_4c_CmdApagaitem - a ordem de declaracao
1025:     * do legado eh Apagar=1, Listar=2, Incluir=3, Alterar=4 (ver
1026:     * ConfigurarAcoes). Ou seja: a celula so recebe FOCO quando o usuario tem

*-- Linhas 1091 a 1112:
1091:     * Em ALTERAR o legado regrava SO Hists sobre a linha corrente do cursor,
1092:     * entao a chave vem de cursor_4c_Dados.cidchaves (linha selecionada na
1093:     * grade) e Nums/Datas/Emps/Autos do registro original sao preservados - o
1094:     * UPDATE do BO toca apenas hists.
1095:     * _EMPR eh LEGADO e nunca se usa: a empresa vem de go_4c_Sistema.
1096:     * Devolve .F. (com aviso) quando falta a chave da linha em ALTERAR -
1097:     * gravar sem chave faria um UPDATE sem WHERE valido.
1098:     * PROTECTED EXPLICITO: FormBase ja declara PROTECTED PROCEDURE FormParaBO e
1099:     * em VFP9 a subclasse NAO alarga escopo herdado - omitir o modificador
1100:     * mentiria para quem le (o metodo fica protegido de qualquer jeito) e
1101:     * PEMSTATUS(..., 5) devolveria .T. sem a chamada externa funcionar.
1102:     * Chamado sempre por THIS. de dentro da classe (regra #8).
1103:     *==========================================================================
1104:     PROTECTED PROCEDURE FormParaBO()
1105:         LOCAL loc_oBO, loc_cModo, loc_uData, loc_lSucesso, loc_oErro
1106:         loc_lSucesso = .F.
1107: 
1108:         TRY
1109:             loc_oBO   = THIS.this_oBusinessObject
1110:             loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))
1111: 
1112:             IF VARTYPE(loc_oBO) = "O"

*-- Linhas 1381 a 1417:
1381:     * HistoricoLostFocusExec - Corpo do GetHist.LostFocus legado:
1382:     *     Local lcConta
1383:     *     lcConta = ThisForm.Conta
1384:     *     Select CrSigCheh
1385:     *     If !Empty(This.Value)
1386:     *         If ThisForm.Tipo = 'INSERIR'
1387:     *             pChave = fUniqueIds()
1388:     *             Append Blank
1389:     *             Replace Nums With lcConta, Datas With This.Parent.GetData.Value,;
1390:     *                     Emps With _Empr, CidChaves with pChave
1391:     *         Endif
1392:     *         Replace Hists With This.Parent.GetHist.Value
1393:     *         ThisForm.podatamgr.Update('CrSigCheh')
1394:     *         ThisForm.podatamgr.commit()
1395:     *     Endif
1396:     *     ThisForm.cnt_inserir.Visible = .f.
1397:     *     ThisForm.gridFollowup.Refresh
1398:     *     ThisForm.GridFollowup.Column1.SetFocus
1399:     *
1400:     * Na nova arquitetura o Append/Replace + Update + commit do cursor viram
1401:     * NovoRegistro/EditarRegistro + FormParaBO + Salvar() no BO (INSERT ou
1402:     * UPDATE em SigCheh) e a grade eh RECARREGADA do banco por CarregarLista,
1403:     * em vez de editada no cursor.
1404:     *
1405:     * As TRES ultimas linhas do legado rodam SEMPRE - inclusive com a
1406:     * observacao em branco, caso em que nada eh gravado e o painel so fecha.
1407:     * Por isso ficam FORA do IF de gravacao, igual ao legado.
1408:     *
1409:     * A gravacao exige painel VISIVEL e modo INSERIR/ALTERAR: no legado eh o
1410:     * cmdInserir/cmdAlterar que mostra o painel e define ThisForm.Tipo, e com
1411:     * o painel oculto GetHist nao recebe foco - a visibilidade EH o gate.
1412:     * Salvar() do BusinessBase ja reporta a falha sozinho (regra #20), por
1413:     * isso nao ha ELSE repetindo a mensagem.
1414:     *==========================================================================
1415:     PROCEDURE HistoricoLostFocusExec()
1416:         LOCAL loc_oBO, loc_cModo, loc_cHist, loc_oErro
1417: 

*-- Linhas 1842 a 1913:
1842:         THIS.AjustarBotoesPorModo()
1843: 
1844:         *-- Legado: gridFollowup.Refresh. Recarrega do banco porque a gravacao
1845:         *-- (quando houve) foi INSERT/UPDATE em SigCheh, nao edicao de cursor.
1846:         *-- CarregarLista fecha chamando RepintarGrade (GO TOP + Refresh -
1847:         *-- regra #21a).
1848:         THIS.CarregarLista()
1849: 
1850:         *-- Legado: GridFollowup.Column1.SetFocus
1851:         THIS.FocarCelulaHistorico()
1852: 
1853:         THIS.this_lEmGravacao = loc_lEmGravacaoAnt
1854:     ENDPROC
1855: 
1856:     *==========================================================================
1857:     * BtnExcluirClick - cmdApagar.Click (Buttons(1) de cmg_4c_CmdApagaitem).
1858:     * Legado (SIGOPCFL.cmdApagaitem.cmdApagar.Click):
1859:     *     Select CrSigCheh
1860:     *     If !Eof()
1861:     *         If !CrSigCheH.Autos .or. IsEmpty(CrSigCheh.Hists) Or IsEmpty(CrSigCheh.Datas)
1862:     *             pchave = CrSigCheh.CidChaves
1863:     *             lcDelete = [ Delete From SigCheh Where CidChaves = ']+pChave+[']
1864:     *             lnErro = ThisForm.poDatamgr.SqlExecute(lcDelete,'')
1865:     *             If lnErro > 0
1866:     *                 ThisForm.poDatamgr.Commit() / Select CrSigCheh / Delete / Skip / Skip -1
1867:     *             Else
1868:     *                 MessageBox('Favor Reiniciar o Processo !!!',0+48,'Falha na Conexao')
1869:     *             Endif
1870:     *         Else
1871:     *             MessageBox('Historico automatico !!!',0+48,'Impossivel Excluir')
1872:     *         EndIf
1873:     *     Endif
1874:     *     Select CrSigCheH / Thisform.GridFollowUp.Refresh / Column1.Text1.Setfocus
1875:     * A guarda Autos/Hists/Datas e a mensagem "Historico automatico!!!" ja
1876:     * estao em SigOpCflBO.ExecutarExclusao() (Fase 2) - aqui so carrega a
1877:     * linha selecionada no BO e delega para Excluir() (PUBLIC - regra #51,
1878:     * NUNCA chamar ExecutarExclusao de fora do BO). CancelarEdicao() ANTES
1879:     * de CarregarDoCursor normaliza this_lNovoRegistro: se um Incluir
1880:     * anterior tivesse falhado ao salvar, a flag ficaria em .T. e Excluir()
1881:     * recusaria com "Nao ha registro para excluir" mesmo com uma linha
1882:     * valida selecionada (regra #32 - form nao fecha entre operacoes).
1883:     *==========================================================================
1884:     PROCEDURE BtnExcluirClick()
1885:         LOCAL loc_oBO
1886: 
1887:         *-- Legado: 'Select CrSigCheh / If !Eof()' - sem linha corrente o
1888:         *-- Click nao faz nada (nem avisa). TemLinhaSelecionada usa IFs
1889:         *-- aninhados porque VFP9 nao faz short-circuit.
1890:         IF THIS.TemLinhaSelecionada()
1891:             loc_oBO = THIS.this_oBusinessObject
1892:             IF VARTYPE(loc_oBO) = "O"
1893:                 loc_oBO.CancelarEdicao()
1894:                 loc_oBO.CarregarDoCursor("cursor_4c_Dados")
1895:                 THIS.this_oBusinessObject.Excluir()
1896:             ENDIF
1897: 
1898:             *-- Legado: Select CrSigCheH / gridFollowup.Refresh /
1899:             *-- Column1.Text1.Setfocus - sempre, mesmo quando o BO recusou a
1900:             *-- exclusao (ja avisou na MsgAviso do ExecutarExclusao).
1901:             THIS.CarregarLista()
1902:             THIS.FocarCelulaHistorico()
1903:         ENDIF
1904:     ENDPROC
1905: 
1906:     *==========================================================================
1907:     * BtnEncerrarClick - Commandgroup1.Command1.Valid do legado:
1908:     *     ThisForm.Release
1909:     * PUBLIC: ligado por BINDEVENT em ConfigurarSaida (regra #3).
1910:     *==========================================================================
1911:     PROCEDURE BtnEncerrarClick()
1912:         THIS.Release()
1913:     ENDPROC

*-- Linhas 1954 a 1973:
1954:     *                        aqui para o caso de o metodo ter saido pelo CATCH)
1955:     *   cursor_4c_CflChe   - temporarios de SigOpCflBO.CarregarCabecalho, que
1956:     *   cursor_4c_CflCli     os fecha sozinho; mesma razao do anterior
1957:     * SEM TABLEREVERT: todos nascem com Buffering = 1 (CREATE CURSOR e cursor
1958:     * de SQLEXEC), onde TABLEREVERT estoura erro 1586, e USE IN fecha o alias
1959:     * de qualquer jeito (regra #52).
1960:     * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que reconstroi os
1961:     * popups do menu principal - sem ele os menus aparecem encolhidos.
1962:     *==========================================================================
1963:     PROCEDURE Destroy()
1964:         IF USED("cursor_4c_Dados")
1965:             USE IN cursor_4c_Dados
1966:         ENDIF
1967:         IF USED("cursor_4c_DadosTmp")
1968:             USE IN cursor_4c_DadosTmp
1969:         ENDIF
1970:         IF USED("cursor_4c_CflChe")
1971:             USE IN cursor_4c_CflChe
1972:         ENDIF
1973:         IF USED("cursor_4c_CflCli")


### BO (C:\4c\projeto\app\classes\SigOpCflBO.prg):
*==============================================================================
* SIGOPCFLBO.PRG
* Business Object para Consulta de FollowUp de Cheques (SigOpCfl)
* Tabela principal: SigCheh (historico de followup do cheque)
* Tabelas auxiliares (somente leitura, cabecalho do form): SigChe, SigCdCli
*==============================================================================

DEFINE CLASS SigOpCflBO AS BusinessBase

    *-- Propriedades da entidade SigCheh (historico de followup)
    this_cCidChaves = ""            && SigCheh.cidchaves - chave primaria (char 20)
    this_cNums = ""                 && SigCheh.nums / SigChe.nums - numero do titulo (parametro "conta" do legado)
    this_dDatas = {}                && SigCheh.datas - data/hora do lancamento de followup
    this_cEmps = ""                 && SigCheh.emps - empresa
    this_cHists = ""                && SigCheh.hists - observacao do followup
    this_nNumlotes = 0              && SigCheh.numlotes
    this_lAutos = .F.               && SigCheh.autos - .T. quando o historico foi gerado automaticamente

    *-- Propriedades auxiliares de cabecalho (somente leitura - SigChe/SigCdCli)
    this_cIclis = ""                && SigCdCli.iclis - codigo do cliente/emissor do cheque
    this_cRclis = ""                && SigCdCli.rclis - razao/nome do cliente
    this_cBancos = ""                && SigChe.bancos - codigo do banco
    this_cAgencias = ""             && SigChe.agencias - agencia
    this_cNContas = ""              && SigChe.ncontas - conta bancaria
    this_cNCheques = ""             && SigChe.ncheques - numero do cheque

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigCheh"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades da entidade (NovoRegistro/CancelarEdicao)
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cNums      = ""
        THIS.this_dDatas     = {}
        THIS.this_cEmps      = ""
        THIS.this_cHists     = ""
        THIS.this_nNumlotes  = 0
        THIS.this_lAutos     = .F.
    ENDPROC

    *==========================================================================
    * InicializarValoresPadrao - Defaults do ramo pcEscolha = 'INSERIR' do
    * legado (cmdApagaitem.Click): GetData.Value = DateTime(), Hists em branco.
    * Autos sempre .F. - followup manual nunca nasce como automatico.
    *==========================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_dDatas    = DATETIME()
        THIS.this_lAutos    = .F.
        THIS.this_nNumlotes = 0
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria (cidchaves) para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor de
    * SigCheh (crSigCheh/cursor_4c_Dados)
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    * PUBLIC de proposito (regra #51): o form chama este metodo de FORA, em
    * BtnExcluirClick (loc_oBO.CarregarDoCursor("cursor_4c_Dados")). Como
    * BusinessBase.CarregarDoCursor eh PUBLIC, declarar PROTECTED aqui faria
    * a chamada estourar em RUNTIME com "Property CARREGARDOCURSOR is not
    * found." ao clicar Excluir - compila limpo. NAO reintroduzir PROTECTED.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cNums      = TratarNulo(nums,      "")
                THIS.this_dDatas     = TratarNulo(datas,     {})
                THIS.this_cEmps      = TratarNulo(emps,      "")
                THIS.this_cHists     = TratarNulo(hists,     "")
                THIS.this_nNumlotes  = TratarNulo(numlotes,  0)
                THIS.this_lAutos     = TratarNulo(autos,     .F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpCflBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Regra de gravacao do legado, em FONTE UNICA.
    * O legado so grava quando a observacao esta preenchida:
    *     If !Empty(This.Value)   (GetHist.LostFocus)
    * e o followup pertence SEMPRE a um cheque (SigCheh.nums -> SigChe.nums,
    * char(8) NOT NULL): sem o numero do cheque o registro nasceria orfao.
    * Chamado por BusinessBase.Salvar(), que exibe a falha sozinho via
    * ExibirFalha() quando este metodo devolve .F. - por isso aqui so se
    * preenche this_cMensagemErro, sem MsgAviso proprio (regra #20).
    * PUBLIC (sem modificador): BusinessBase.ValidarDados tambem eh PUBLIC e
    * em VFP9 PROTECTED em QUALQUER nivel da heranca ja bloqueia a chamada
    * externa (regra #51).
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .F.

        THIS.this_cMensagemErro = ""

        DO CASE
        CASE EMPTY(ALLTRIM(THIS.this_cNums))
            THIS.this_cMensagemErro = "Cheque n" + CHR(227) + "o informado - " + ;
                "n" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel gravar " + ;
                "followup sem o t" + CHR(237) + "tulo de origem."
        CASE EMPTY(ALLTRIM(THIS.this_cHists))
            THIS.this_cMensagemErro = "Observa" + CHR(231) + CHR(227) + "o " + ;
                "necessita ser preenchida."
        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * CarregarHistorico - Consulta o historico de followup do cheque e devolve
    * as linhas em par_cCursorDestino (cursor TEMPORARIO do chamador, que
    * depois faz ZAP + APPEND FROM DBF() no alias ligado ao Grid - SQLEXEC
    * sobre o alias do Grid zera o ColumnCount).
    * Legado (SIGOPCFL.Init):
    *     lcQueryCheh = [Select * From SigCheh Where Nums = ?lcNum ]
    *     .AddCursor('SigCheh','CidChaves','CrSigCheh','','',lcQueryCheh)
    *     =ThisForm.Podatamgr.Requery('CrSigCheh')
    * O filtro eh aplicado SEMPRE, inclusive com Nums vazio - a consulta nao
    * casa nada e a grade abre vazia, de proposito (regra #35a).
    * A lista de colunas (nome E ordem) eh IDENTICA a de CarregarDoCursor e a
    * do CREATE CURSOR do form - APPEND FROM casa por NOME.
    * Devolve .T. quando a consulta rodou (inclusive com ZERO linhas: lista
    * vazia nao eh erro) e .F. quando o SQL Server recusou.
    * PUBLIC: o form chama de FORA, em CarregarLista (regra #51).
    *==========================================================================
    PROCEDURE CarregarHistorico(par_cNums, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Fecha o destino antes do SQLEXEC. O TABLEREVERT vai guardado
            *-- pelo Buffering: cursor com Buffering = 1 (o default de
            *-- CREATE CURSOR e de cursor de SQLEXEC) faz TABLEREVERT estourar
            *-- erro 1586 "Function requires row or table buffering mode", e
            *-- USE IN fecha o alias de qualquer jeito (regra #52).
            IF USED(par_cCursorDestino)
                IF CURSORGETPROP("Buffering", par_cCursorDestino) > 1
                    TABLEREVERT(.T., par_cCursorDestino)
                ENDIF
                USE IN (par_cCursorDestino)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
SELECT cidchaves, nums, datas, emps, hists, numlotes, autos
  FROM SigCheh
 WHERE nums = <<EscaparSQL(LEFT(par_cNums, 8))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + ;
                    "rico do cheque:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "SigOpCflBO.CarregarHistorico")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar hist" + CHR(243) + "rico:" + CHR(13) + ;
                loException.Message, "SigOpCflBO.CarregarHistorico")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Carrega os dados FIXOS do cheque consultado nas
    * propriedades auxiliares (somente leitura) deste BO.
    * Legado (SIGOPCFL.Init):
    *     =ThisForm.Podatamgr.Cursorquery('SigChe','CrTmpChe','Nums',lcNum)
    *     =ThisForm.Podatamgr.Cursorquery('SigCdCli','CrTmpCli','Iclis',CrTmpChe.Iclis)
    * O cliente so eh consultado quando o cheque traz Iclis preenchido - eh o
    * encadeamento do legado, nao uma otimizacao.
    * PUBLIC: o form chama de FORA, em CarregarCabecalhoCheque (regra #51).
    *==========================================================================
    PROCEDURE CarregarCabecalho(par_cNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIclis    = ""
            THIS.this_cRclis    = ""
            THIS.this_cBancos   = ""
            THIS.this_cAgencias = ""
            THIS.this_cNContas  = ""
            THIS.this_cNCheques = ""

            IF USED("cursor_4c_CflChe")
                USE IN cursor_4c_CflChe
            ENDIF
            IF USED("cursor_4c_CflCli")
                USE IN cursor_4c_CflCli
            ENDIF

            loc_cSQL = "SELECT iclis, bancos, agencias, ncontas, ncheques" + ;
                " FROM SigChe WHERE nums = " + EscaparSQL(LEFT(par_cNums, 8))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CflChe")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar os dados do cheque:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "SigOpCflBO.CarregarCabecalho")
            ELSE
                *-- IFs ANINHADOS de proposito: VFP9 nao faz short-circuit,
                *-- entao 'USED(x) AND RECCOUNT(x) > 0' avaliaria o RECCOUNT
                *-- mesmo com o alias fechado e estouraria "Alias is not found".
                IF USED("cursor_4c_CflChe")
                    IF RECCOUNT("cursor_4c_CflChe") > 0
                        SELECT cursor_4c_CflChe
                        GO TOP

                        THIS.this_cIclis    = TratarNulo(iclis,    "")
                        THIS.this_cBancos   = TratarNulo(bancos,   "")
                        THIS.this_cAgencias = TratarNulo(agencias, "")
                        THIS.this_cNContas  = TratarNulo(ncontas,  "")
                        THIS.this_cNCheques = TratarNulo(ncheques, "")

                        loc_lSucesso = .T.

                        IF !EMPTY(ALLTRIM(THIS.this_cIclis))
                            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                                EscaparSQL(THIS.this_cIclis)

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CflCli")

                            IF loc_nResultado >= 0 AND USED("cursor_4c_CflCli")
                                IF RECCOUNT("cursor_4c_CflCli") > 0
                                    SELECT cursor_4c_CflCli
                                    GO TOP
                                    THIS.this_cRclis = TratarNulo(rclis, "")
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_CflChe")
                USE IN cursor_4c_CflChe
            ENDIF
            IF USED("cursor_4c_CflCli")
                USE IN cursor_4c_CflCli
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar cabe" + CHR(231) + "alho do cheque:" + ;
                CHR(13) + loException.Message, "SigOpCflBO.CarregarCabecalho")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Inclui novo registro de followup em SigCheh
    * Espelha o ramo pcEscolha = 'INSERIR' do GetHist.LostFocus legado: gera a
    * chave com fUniqueIds() e grava Nums/Datas/Emps/CidChaves/Hists. Autos
    * sempre 0 (bit) - followup manual nunca nasce automatico.
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCheh (cidchaves, nums, datas, emps, hists, autos, numlotes)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(LEFT(THIS.this_cNums, 8))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cHists, 76))>>,
                    0,
                    <<FormatarNumeroSQL(THIS.this_nNumlotes, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao incluir followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpCflBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro de followup existente em SigCheh
    * Espelha o ramo pcEscolha = 'ALTERAR' do legado: so o historico (Hists)
    * eh regravado; Nums/Datas/Emps/Autos do registro original sao preservados.
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCheh
                SET hists = <<EscaparSQL(LEFT(THIS.this_cHists, 76))>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpCflBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de followup de SigCheh
    * Guarda do legado (cmdApagaitem.Click): so permite excluir quando o
    * historico NAO foi gerado automaticamente (Autos = .F.) OU quando
    * Hists/Datas estao vazios. Historico automatico com Hists/Datas
    * preenchidos NAO pode ser excluido ("Historico automatico!!!").
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_lAutos AND !EMPTY(THIS.this_cHists) AND !EMPTY(THIS.this_dDatas)
                MsgAviso("Hist" + CHR(243) + "rico autom" + CHR(225) + "tico !!!", ;
                    "Imposs" + CHR(237) + "vel")
            ELSE
                loc_cSQL = "DELETE FROM SigCheh WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigOpCflBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

