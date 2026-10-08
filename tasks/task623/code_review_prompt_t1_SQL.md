# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHA, FPAGS, LNCONTA1, IMPBOLS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHA, FPAGS, LNCONTA1, IMPBOLS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHA, FPAGS, LNCONTA1, IMPBOLS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHA, FPAGS, LNCONTA1, IMPBOLS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PARCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLINHA, FPAGS, LNCONTA1, IMPBOLS

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
  ControlSource = "crSigCnFbl.clocals"
	Select crSigCnFBl
	Insert Into TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
lcQueryCfgBl  = [Select * From SigCnFBl Where FPags = ?pPag]
	Select crSigCnFBl
	If ThisForm.Podatamgr.Update('CrSigCnFBl') And ;
			Select TprMvCab
			Insert Into TprMvCab (Emps, Dopes, Numes) ;
		Select TprMvCab
							Select CrSigCnFBl
							Select CrTmpPar
									Insert into Crdados  values(CrSigCnFBl.cLocals, xVenc, CrTmpPar.Datas, CrtmpNfis.NFis+'-'+Str(Crtmppar.parcs,1),;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg) - TRECHOS RELEVANTES PARA PASS SQL (1323 linhas total):

*-- Linhas 85 a 105:
85:                 THIS.ConfigurarPaginaDados()
86: 
87:                 *-- Cursor auxiliar de movimentos a imprimir (regra: mesma
88:                 *-- estrutura/ordem de campos em TODO CREATE CURSOR TprMvCab)
89:                 IF !USED("TprMvCab")
90:                     CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
91:                 ENDIF
92: 
93:                 THIS.AtualizaBoleto("")
94: 
95:                 THIS.TornarControlesVisiveis(THIS)
96:                 THIS.Visible = .T.
97:                 loc_lSucesso = .T.
98:             ELSE
99:                 MsgErro("Falha ao criar SIGPRIBLBO.", "Erro em InicializarForm")
100:             ENDIF
101:         CATCH TO loc_oErro
102:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
103:         ENDTRY
104:         RETURN loc_lSucesso
105:     ENDPROC

*-- Linhas 606 a 624:
606:                 ENDIF
607: 
608:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaFPags")
609:                     SELECT cursor_4c_BuscaFPags
610:                     IF !EOF("cursor_4c_BuscaFPags")
611:                         loc_cEscolhido  = ALLTRIM(NVL(cursor_4c_BuscaFPags.fpags, ""))
612:                         loc_lSelecionou = .T.
613:                     ENDIF
614:                 ENDIF
615: 
616:                 loc_oLookup.Release()
617:             ENDIF
618: 
619:             IF USED("cursor_4c_BuscaFPags")
620:                 USE IN cursor_4c_BuscaFPags
621:             ENDIF
622: 
623:             *-- Legado: valor vem do cursor quando escolheu, VAZIO no cancelamento
624:             THIS.txt_4c_FPags.Value = IIF(loc_lSelecionou, loc_cEscolhido, "")

*-- Linhas 703 a 735:
703:                 *-- Carrega movimento recebido na abertura do form (se houver)
704:                 IF !EMPTY(THIS.this_cChave1)
705:                     IF !USED("TprMvCab")
706:                         CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
707:                     ENDIF
708:                     SELECT TprMvCab
709:                     ZAP
710:                     INSERT INTO TprMvCab (Emps, Dopes, Numes) VALUES ;
711:                         (SUBSTR(THIS.this_cChave1, 1, 3), ;
712:                          SUBSTR(THIS.this_cChave1, 4, 20), ;
713:                          INT(VAL(SUBSTR(THIS.this_cChave1, 24, 6))))
714:                 ENDIF
715: 
716:                 IF USED("Crdados")
717:                     USE IN Crdados
718:                 ENDIF
719:                 SET NULL ON
720:                 CREATE CURSOR Crdados ( ;
721:                     clocal  C(100), ;
722:                     vencs   C(12), ;
723:                     datdoc  D, ;
724:                     numdoc  C(8), ;
725:                     valor   N(14,2), ;
726:                     razaos  C(50), ;
727:                     cpfs    C(20), ;
728:                     endcobs C(80), ;
729:                     baicobs C(20), ;
730:                     cidcobs C(20), ;
731:                     estcobs C(2), ;
732:                     cepcobs C(9), ;
733:                     texto   M ;
734:                 )
735:                 SET NULL OFF

*-- Linhas 755 a 820:
755:                                     AT("/", THIS.this_oBusinessObject.this_cTamFolha, 1) - 1)))
756: 
757:                 *-- Itera os movimentos a imprimir
758:                 SELECT TprMvCab
759:                 GO TOP
760:                 SCAN
761:                     loc_cChave1 = TprMvCab.Emps + TprMvCab.Dopes + STR(TprMvCab.Numes, 6)
762:                     loc_nParcel = NVL(TprMvCab.Parcs, 0)
763:                     IF VARTYPE(loc_nParcel) != "N"
764:                         loc_nParcel = 0
765:                     ENDIF
766: 
767:                     loc_cSQL = "SELECT TOP 1 emps, dopes, numes, contaos, contads" + ;
768:                                " FROM SigMvCab WHERE empdopnums = " + EscaparSQL(loc_cChave1)
769:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
770:                     IF loc_nRet <= 0 OR !USED("cursor_4c_MvCab") OR RECCOUNT("cursor_4c_MvCab") = 0
771:                         MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
772:                             "o Encontrou Movimenta" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
773:                         IF USED("cursor_4c_MvCab")
774:                             USE IN cursor_4c_MvCab
775:                         ENDIF
776:                         LOOP
777:                     ENDIF
778: 
779:                     loc_cSQL = "SELECT emps, dopes, numes, parcs, fpags, vencs, datas, valos" + ;
780:                                " FROM SigMvPar WHERE empdopnums = " + EscaparSQL(loc_cChave1) + ;
781:                                " ORDER BY parcs"
782:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPar")
783:                     IF loc_nRet <= 0 OR !USED("cursor_4c_MvPar") OR RECCOUNT("cursor_4c_MvPar") = 0
784:                         MsgAviso("Nenhuma Forma de Pagamento Encontrada Nessa Opera" + CHR(231) + CHR(227) + "o.", ;
785:                             "Aten" + CHR(231) + CHR(227) + "o")
786:                         IF USED("cursor_4c_MvPar")
787:                             USE IN cursor_4c_MvPar
788:                         ENDIF
789:                         IF USED("cursor_4c_MvCab")
790:                             USE IN cursor_4c_MvCab
791:                         ENDIF
792:                         LOOP
793:                     ENDIF
794: 
795:                     *-- Operacao habilitada para impressao de boleto (SigCdOpe+SigOpCdc)
796:                     loc_lBoletoHabilitado = .F.
797:                     loc_nNfiscals = 0
798:                     loc_cSQL = "SELECT TOP 1 dopes, nfiscals FROM SigCdOpe WHERE dopes = " + ;
799:                                EscaparSQL(cursor_4c_MvPar.Dopes)
800:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
801:                     IF loc_nRet > 0 AND USED("cursor_4c_Ope") AND RECCOUNT("cursor_4c_Ope") > 0
802:                         loc_nNfiscals = NVL(cursor_4c_Ope.Nfiscals, 0)
803:                         loc_cSQL = "SELECT TOP 1 dopes, impbols FROM SigOpCdc WHERE dopes = " + ;
804:                                    EscaparSQL(cursor_4c_MvPar.Dopes)
805:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdc")
806:                         IF loc_nRet > 0 AND USED("cursor_4c_OpCdc") AND RECCOUNT("cursor_4c_OpCdc") > 0 ;
807:                            AND NVL(cursor_4c_OpCdc.ImpBols, 0) = 1
808:                             loc_lBoletoHabilitado = .T.
809:                         ENDIF
810:                     ENDIF
811:                     IF USED("cursor_4c_OpCdc")
812:                         USE IN cursor_4c_OpCdc
813:                     ENDIF
814:                     IF USED("cursor_4c_Ope")
815:                         USE IN cursor_4c_Ope
816:                     ENDIF
817: 
818:                     IF !loc_lBoletoHabilitado
819:                         MsgAviso("Opera" + CHR(231) + CHR(227) + "o sem Impress" + CHR(227) + ;
820:                             "o de Boleto Banc" + CHR(225) + "rio Habilitado.", "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 827 a 906:
827:                         LOOP
828:                     ENDIF
829: 
830:                     loc_cSQL = "SELECT TOP 1 NFis FROM SigMvNfi WHERE empdopnums = " + EscaparSQL(loc_cChave1)
831:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvNfi")
832:                     IF loc_nRet <= 0 OR !USED("cursor_4c_MvNfi") OR RECCOUNT("cursor_4c_MvNfi") = 0
833:                         MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
834:                             "o possui Nota Fiscal Cadastrada.", "Aten" + CHR(231) + CHR(227) + "o")
835:                         IF USED("cursor_4c_MvNfi")
836:                             USE IN cursor_4c_MvNfi
837:                         ENDIF
838:                         IF USED("cursor_4c_MvPar")
839:                             USE IN cursor_4c_MvPar
840:                         ENDIF
841:                         IF USED("cursor_4c_MvCab")
842:                             USE IN cursor_4c_MvCab
843:                         ENDIF
844:                         LOOP
845:                     ENDIF
846: 
847:                     *-- Cursor/indice do template de posicoes de impressao
848:                     IF USED("TmpImprime")
849:                         USE IN TmpImprime
850:                     ENDIF
851:                     CREATE CURSOR TmpImprime ( ;
852:                         Linha    N(6,2), ;
853:                         Coluna   N(6,2), ;
854:                         Conteudo C(100), ;
855:                         Style    C(3), ;
856:                         fontname C(64), ;
857:                         fontsize I, ;
858:                         linesize N(6,2), ;
859:                         nheight  N(6,2) ;
860:                     )
861:                     INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem
862: 
863:                     SELECT cursor_4c_MvCab
864:                     loc_cContaCli = IIF(loc_nNfiscals = 1, cursor_4c_MvCab.Contaos, cursor_4c_MvCab.Contads)
865: 
866:                     loc_cSQL = "SELECT TOP 1 Iclis, Razaos, Cpfs, Endes, EndCobs, Bairs, BaiCobs," + ;
867:                                " Cidas, CidCobs, Estas, EstCobs, Ceps, CepCobs" + ;
868:                                " FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaCli)
869:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")
870: 
871:                     SELECT Crdados
872:                     ZAP
873: 
874:                     SELECT cursor_4c_MvPar
875:                     GO TOP
876:                     SCAN
877:                         loc_lTaOk = .T.
878:                         IF loc_nParcel > 0 AND cursor_4c_MvPar.Parcs != loc_nParcel
879:                             loc_lTaOk = .F.
880:                         ENDIF
881: 
882:                         IF loc_lTaOk
883:                             loc_cSQL = "SELECT TOP 1 Fpags, ImpBols, ImpNotas FROM SigOpFp WHERE Fpags = " + ;
884:                                        EscaparSQL(cursor_4c_MvPar.Fpags)
885:                             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp")
886: 
887:                             IF loc_nRet > 0 AND USED("cursor_4c_OpFp") AND RECCOUNT("cursor_4c_OpFp") > 0 ;
888:                                AND NVL(cursor_4c_OpFp.ImpBols, 0) = 1
889: 
890:                                 IF USED("TmpImprime")
891:                                     SELECT TmpImprime
892:                                     ZAP
893:                                 ENDIF
894: 
895:                                 IF NVL(cursor_4c_OpFp.ImpNotas, 0) = 1
896:                                     loc_xVenc = DTOC(cursor_4c_MvPar.Vencs)
897:                                 ELSE
898:                                     loc_xVenc = ALLTRIM(NVL(cursor_4c_MvPar.FPags, ""))
899:                                 ENDIF
900: 
901:                                 *-- Legado: CrtmpNfis.NFis + '-' + Str(Crtmppar.parcs,1) - SEM
902:                                 *-- AllTrim. SigMvNfi.nfis eh char(6), mais "-" mais 1 digito da
903:                                 *-- EXATAMENTE os 8 de Crdados.numdoc C(8): a largura do destino
904:                                 *-- prova que o campo eh POSICIONAL e o padding faz parte dele
905:                                 *-- (CLAUDE.md regra #42). AllTrim encurtaria o numero do
906:                                 *-- documento impresso no boleto.

*-- Linhas 919 a 937:
919:                                     loc_cCepCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CepCobs, ""))), ;
920:                                         cursor_4c_Cli.CepCobs, cursor_4c_Cli.Ceps)
921: 
922:                                     INSERT INTO Crdados VALUES ( ;
923:                                         THIS.this_oBusinessObject.this_cLocals, loc_xVenc, cursor_4c_MvPar.Datas, ;
924:                                         loc_cNumDoc, cursor_4c_MvPar.Valos, cursor_4c_Cli.Razaos, cursor_4c_Cli.Cpfs, ;
925:                                         loc_cEndCob, loc_cBaiCob, loc_cCidCob, loc_cEstCob, loc_cCepCob, ;
926:                                         THIS.this_oBusinessObject.this_cTxtCds)
927:                                 ENDIF
928:                             ENDIF
929:                             IF USED("cursor_4c_OpFp")
930:                                 USE IN cursor_4c_OpFp
931:                             ENDIF
932:                         ENDIF
933:                     ENDSCAN
934: 
935:                     *-- ATENCAO: as 13 linhas de posicao e a chamada da rotina de
936:                     *-- impressao rodam UMA VEZ POR MOVIMENTO, DEPOIS do EndScan das
937:                     *-- parcelas - exatamente onde o legado as tem (cmdImprimir.Click:

*-- Linhas 1034 a 1052:
1034: 
1035:             IF !(loc_cEstilo == "*") AND (loc_nColuna != 0 OR loc_nLinha != 0)
1036:                 IF USED("TmpImprime")
1037:                     INSERT INTO TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
1038:                         VALUES (loc_nLinha, loc_nColuna, loc_cDetalhe, ALLTRIM(loc_cEstilo), par_nLineSize, par_nHeight)
1039:                 ENDIF
1040:             ENDIF
1041:         CATCH TO loc_oErro
1042:             MsgErro(loc_oErro.Message, "Erro em GrDetalhe")
1043:         ENDTRY
1044:     ENDPROC
1045: 
1046:     *==========================================================================
1047:     * CarregarLista - Ponto de entrada canonico do funil multi-fase. Form
1048:     * OPERACIONAL flat: recarrega a configuracao do boleto atualmente
1049:     * selecionado.
1050:     *==========================================================================
1051:     PROCEDURE CarregarLista()
1052:         LOCAL loc_lSucesso, loc_oErro


### BO (C:\4c\projeto\app\classes\SIGPRIBLBO.prg):
*====================================================================
* SIGPRIBLBO.prg
*
* Business Object para Impressao de Boleto Bancario (form OPERACIONAL)
* Tabela: SigCnFBl (Configuracao de Impressao de Boleto Bancario)
* Chave: cidchaves char(20) - PK
* Busca: fpags char(12) - Condicao de Pagamento (campo digitado na tela)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRIBLBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCnFBl)
    this_cIdChaves  = ""    && cidchaves char(20) - PK
    this_cFPags     = ""    && fpags char(12) - condicao de pagamento (chave de busca)
    this_cEmps      = ""    && cemps char(3)
    this_dDatas     = {}    && ddatas datetime
    this_cHoras     = ""    && choras char(8)
    this_cUsuarios  = ""    && cusuarios char(20)
    this_cTxtCds    = ""    && ctxtcds text - texto de responsabilidade do cedente
    this_cLocals    = ""    && clocals char(100) - local de pagamento
    this_nLnLocals  = 0     && nlnlocals numeric(5,2)
    this_nClLocals  = 0     && ncllocals numeric(5,2)
    this_nLnDtVencs = 0     && nlndtvencs numeric(5,2)
    this_nClDtVencs = 0     && ncldtvencs numeric(5,2)
    this_nLnDtDocs  = 0     && nlndtdocs numeric(5,2)
    this_nClDtDocs  = 0     && ncldtdocs numeric(5,2)
    this_nLnNrDocs  = 0     && nlnnrdocs numeric(5,2)
    this_nClNrDocs  = 0     && nclnrdocs numeric(5,2)
    this_nLnVlDocs  = 0     && nlnvldocs numeric(5,2)
    this_nClVlDocs  = 0     && nclvldocs numeric(5,2)
    this_nLnTxtCds  = 0     && nlntxtcds numeric(5,2)
    this_nClTxtCds  = 0     && ncltxtcds numeric(5,2)
    this_nTxtLins   = 0     && ntxtlins numeric(3,0)
    this_nTxtCols   = 0     && ntxtcols numeric(3,0)
    this_nLnRazClis = 0     && nlnrazclis numeric(5,2)
    this_nClRazClis = 0     && nclrazclis numeric(5,2)
    this_nLnEndCobs = 0     && nlnendcobs numeric(5,2)
    this_nClEndCobs = 0     && nclendcobs numeric(5,2)
    this_nLnCgcClis = 0     && nlncgcclis numeric(5,2)
    this_nClCgcClis = 0     && nclcgcclis numeric(5,2)
    this_nLnBaiCobs = 0     && nlnbaicobs numeric(5,2)
    this_nClBaiCobs = 0     && nclbaicobs numeric(5,2)
    this_nLnCidCobs = 0     && nlncidcobs numeric(5,2)
    this_nClCidCobs = 0     && nclcidcobs numeric(5,2)
    this_nLnEstCobs = 0     && nlnestcobs numeric(5,2)
    this_nClEstCobs = 0     && nclestcobs numeric(5,2)
    this_nLnCepCobs = 0     && nlncepcobs numeric(5,2)
    this_nClCepCobs = 0     && nclcepcobs numeric(5,2)
    this_cNomeImps  = ""    && cnomeimps char(128) - nome da impressora
    this_cFontePdrs = ""    && cfontepdrs char(128) - fonte padrao
    this_nTamFontes = 0     && ntamfontes numeric(3,0)
    this_cTamFolha  = ""    && ctamfolha char(50)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCnFBl"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGPRIBLBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cidchaves eh a PK fisica (char(20)) de SigCnFBl
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia todas as colunas do cursor para as propriedades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves,  "")
            THIS.this_cFPags     = TratarNulo(fpags,      "")
            THIS.this_cEmps      = TratarNulo(cemps,      "")
            THIS.this_dDatas     = TratarNulo(ddatas,     {})
            THIS.this_cHoras     = TratarNulo(choras,     "")
            THIS.this_cUsuarios  = TratarNulo(cusuarios,  "")
            THIS.this_cTxtCds    = TratarNulo(ctxtcds,    "")
            THIS.this_cLocals    = TratarNulo(clocals,    "")
            THIS.this_nLnLocals  = TratarNulo(nlnlocals,  0)
            THIS.this_nClLocals  = TratarNulo(ncllocals,  0)
            THIS.this_nLnDtVencs = TratarNulo(nlndtvencs, 0)
            THIS.this_nClDtVencs = TratarNulo(ncldtvencs, 0)
            THIS.this_nLnDtDocs  = TratarNulo(nlndtdocs,  0)
            THIS.this_nClDtDocs  = TratarNulo(ncldtdocs,  0)
            THIS.this_nLnNrDocs  = TratarNulo(nlnnrdocs,  0)
            THIS.this_nClNrDocs  = TratarNulo(nclnrdocs,  0)
            THIS.this_nLnVlDocs  = TratarNulo(nlnvldocs,  0)
            THIS.this_nClVlDocs  = TratarNulo(nclvldocs,  0)
            THIS.this_nLnTxtCds  = TratarNulo(nlntxtcds,  0)
            THIS.this_nClTxtCds  = TratarNulo(ncltxtcds,  0)
            THIS.this_nTxtLins   = TratarNulo(ntxtlins,   0)
            THIS.this_nTxtCols   = TratarNulo(ntxtcols,   0)
            THIS.this_nLnRazClis = TratarNulo(nlnrazclis, 0)
            THIS.this_nClRazClis = TratarNulo(nclrazclis, 0)
            THIS.this_nLnEndCobs = TratarNulo(nlnendcobs, 0)
            THIS.this_nClEndCobs = TratarNulo(nclendcobs, 0)
            THIS.this_nLnCgcClis = TratarNulo(nlncgcclis, 0)
            THIS.this_nClCgcClis = TratarNulo(nclcgcclis, 0)
            THIS.this_nLnBaiCobs = TratarNulo(nlnbaicobs, 0)
            THIS.this_nClBaiCobs = TratarNulo(nclbaicobs, 0)
            THIS.this_nLnCidCobs = TratarNulo(nlncidcobs, 0)
            THIS.this_nClCidCobs = TratarNulo(nclcidcobs, 0)
            THIS.this_nLnEstCobs = TratarNulo(nlnestcobs, 0)
            THIS.this_nClEstCobs = TratarNulo(nclestcobs, 0)
            THIS.this_nLnCepCobs = TratarNulo(nlncepcobs, 0)
            THIS.this_nClCepCobs = TratarNulo(nclcepcobs, 0)
            THIS.this_cNomeImps  = TratarNulo(cnomeimps,  "")
            THIS.this_cFontePdrs = TratarNulo(cfontepdrs, "")
            THIS.this_nTamFontes = TratarNulo(ntamfontes, 0)
            THIS.this_cTamFolha  = TratarNulo(ctamfolha,  "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorFPags - Carrega configuracao de boleto pela condicao de
    * pagamento (fpags eh o campo de busca digitado na tela; cidchaves eh a
    * PK fisica Fortyus, gerada so no Inserir)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorFPags(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                       " ctxtcds, clocals, nlnlocals, ncllocals," + ;
                       " nlndtvencs, ncldtvencs, nlndtdocs, ncldtdocs," + ;
                       " nlnnrdocs, nclnrdocs, nlnvldocs, nclvldocs," + ;
                       " nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                       " nlnrazclis, nclrazclis, nlnendcobs, nclendcobs," + ;
                       " nlncgcclis, nclcgcclis, nlnbaicobs, nclbaicobs," + ;
                       " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                       " nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs," + ;
                       " ntamfontes, ctamfolha" + ;
                       " FROM SigCnFBl WHERE fpags = " + EscaparSQL(par_cFPags)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT completo na tabela SigCnFBl
    * cidchaves eh a PK fisica Fortyus - gerada aqui, nunca vazia (regra #22)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChaves = PADR(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCnFBl" + ;
                       " (cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                       " ctxtcds, clocals, nlnlocals, ncllocals," + ;
                       " nlndtvencs, ncldtvencs, nlndtdocs, ncldtdocs," + ;
                       " nlnnrdocs, nclnrdocs, nlnvldocs, nclvldocs," + ;
                       " nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                       " nlnrazclis, nclrazclis, nlnendcobs, nclendcobs," + ;
                       " nlncgcclis, nclcgcclis, nlnbaicobs, nclbaicobs," + ;
                       " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                       " nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs," + ;
                       " ntamfontes, ctamfolha)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cFPags, 12)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cHoras, 8)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cUsuarios, 20)) + "," + ;
                       EscaparSQL(THIS.this_cTxtCds) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cLocals, 100)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnLocals, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClLocals, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTxtLins, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTxtCols, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClRazClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cNomeImps, 128)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTamFontes, 0) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cTamFolha, 50)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE completo na tabela SigCnFBl (cidchaves eh a chave,
    * nunca alterada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " fpags = "      + EscaparSQL(LEFT(THIS.this_cFPags, 12)) + "," + ;
                       " cemps = "      + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                       " ddatas = "     + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " choras = "     + EscaparSQL(LEFT(THIS.this_cHoras, 8)) + "," + ;
                       " cusuarios = "  + EscaparSQL(LEFT(THIS.this_cUsuarios, 20)) + "," + ;
                       " ctxtcds = "    + EscaparSQL(THIS.this_cTxtCds) + "," + ;
                       " clocals = "    + EscaparSQL(LEFT(THIS.this_cLocals, 100)) + "," + ;
                       " nlnlocals = "  + FormatarNumeroSQL(THIS.this_nLnLocals, 2) + "," + ;
                       " ncllocals = "  + FormatarNumeroSQL(THIS.this_nClLocals, 2) + "," + ;
                       " nlndtvencs = " + FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + "," + ;
                       " ncldtvencs = " + FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + "," + ;
                       " nlndtdocs = "  + FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + "," + ;
                       " ncldtdocs = "  + FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + "," + ;
                       " nlnnrdocs = "  + FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + "," + ;
                       " nclnrdocs = "  + FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + "," + ;
                       " nlnvldocs = "  + FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + "," + ;
                       " nclvldocs = "  + FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + "," + ;
                       " nlntxtcds = "  + FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + "," + ;
                       " ncltxtcds = "  + FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + "," + ;
                       " ntxtlins = "   + FormatarNumeroSQL(THIS.this_nTxtLins, 0) + "," + ;
                       " ntxtcols = "   + FormatarNumeroSQL(THIS.this_nTxtCols, 0) + "," + ;
                       " nlnrazclis = " + FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + "," + ;
                       " nclrazclis = " + FormatarNumeroSQL(THIS.this_nClRazClis, 2) + "," + ;
                       " nlnendcobs = " + FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + "," + ;
                       " nclendcobs = " + FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + "," + ;
                       " nlncgcclis = " + FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + "," + ;
                       " nclcgcclis = " + FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + "," + ;
                       " nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + "," + ;
                       " nclbaicobs = " + FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + "," + ;
                       " nlncidcobs = " + FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + "," + ;
                       " nclcidcobs = " + FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + "," + ;
                       " nlnestcobs = " + FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + "," + ;
                       " nclestcobs = " + FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + "," + ;
                       " nlncepcobs = " + FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + "," + ;
                       " nclcepcobs = " + FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + "," + ;
                       " cnomeimps = "  + EscaparSQL(LEFT(THIS.this_cNomeImps, 128)) + "," + ;
                       " cfontepdrs = " + EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + "," + ;
                       " ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamFontes, 0) + "," + ;
                       " ctamfolha = "  + EscaparSQL(LEFT(THIS.this_cTamFolha, 50)) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

