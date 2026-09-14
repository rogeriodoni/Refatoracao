CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1844: Tabela 'SigCdIcn' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1869: Tabela 'SigCdIcn' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormMPD.prg):

--- Linhas 1825 a 1865 ---
1825:             ENDIF
1826:         CATCH TO loException
1827:             MostrarErro(loException, "FormMPD.BtnSalvarClick")
1828:         ENDTRY
1829:     ENDPROC
1830: 
1831:     PROCEDURE BtnCancelarClick()
1832:         TRY
1833:             THIS.this_cModoAtual = "LISTA"
1834:             THIS.AlternarPagina(1)
1835:             THIS.CarregarLista()
1836:         CATCH TO loException
1837:             MostrarErro(loException, "FormMPD.BtnCancelarClick")
1838:         ENDTRY
1839:     ENDPROC
1840: 
1841:     PROCEDURE CmdGarqiconeClick()
1842:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
1843:         TRY
1844:             loc_cSQL = "SELECT codigos, descrs FROM SigCdIcn ORDER BY codigos"
1845:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn")
1846:             IF loc_nResult >= 0
1847:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
1848:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Icn"
1849:                 loc_oFrm.DefinirCursor("cursor_4c_Icn", "codigos", "descrs", CHR(205) + "cone")
1850:                 loc_oFrm.Mostrar()
1851:                 IF loc_oFrm.this_lSelecionou
1852:                     loc_oPg = THIS.pgf_4c_Paginas.Page2
1853:                     loc_oPg.txt_4c_Desc.Value = loc_oFrm.cCodigoSelecionado
1854:                 ENDIF
1855:                 IF USED("cursor_4c_Icn")
1856:                     USE IN cursor_4c_Icn
1857:                 ENDIF
1858:             ELSE
1859:                 MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
1860:             ENDIF
1861:         CATCH TO loException
1862:             MostrarErro(loException, "FormMPD.CmdGarqiconeClick")
1863:         ENDTRY
1864:     ENDPROC
1865: 

--- Linhas 1850 a 1890 ---
1850:                 loc_oFrm.Mostrar()
1851:                 IF loc_oFrm.this_lSelecionou
1852:                     loc_oPg = THIS.pgf_4c_Paginas.Page2
1853:                     loc_oPg.txt_4c_Desc.Value = loc_oFrm.cCodigoSelecionado
1854:                 ENDIF
1855:                 IF USED("cursor_4c_Icn")
1856:                     USE IN cursor_4c_Icn
1857:                 ENDIF
1858:             ELSE
1859:                 MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
1860:             ENDIF
1861:         CATCH TO loException
1862:             MostrarErro(loException, "FormMPD.CmdGarqiconeClick")
1863:         ENDTRY
1864:     ENDPROC
1865: 
1866:     PROCEDURE CmdIconeClick()
1867:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
1868:         TRY
1869:             loc_cSQL = "SELECT codigos, descrs FROM SigCdIcn ORDER BY codigos"
1870:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn2")
1871:             IF loc_nResult >= 0
1872:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
1873:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Icn2"
1874:                 loc_oFrm.DefinirCursor("cursor_4c_Icn2", "codigos", "descrs", CHR(205) + "cone Barra")
1875:                 loc_oFrm.Mostrar()
1876:                 IF loc_oFrm.this_lSelecionou
1877:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1878:                     loc_oPg.txt_4c_ArqIcone.Value = loc_oFrm.cCodigoSelecionado
1879:                     IF !EMPTY(loc_oFrm.cCodigoSelecionado)
1880:                         loc_oPg.img_4c_ImgIcone.Picture = gc_4c_CaminhoIcones + ALLTRIM(loc_oFrm.cCodigoSelecionado)
1881:                     ENDIF
1882:                 ENDIF
1883:                 IF USED("cursor_4c_Icn2")
1884:                     USE IN cursor_4c_Icn2
1885:                 ENDIF
1886:             ELSE
1887:                 MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
1888:             ENDIF
1889:         CATCH TO loException
1890:             MostrarErro(loException, "FormMPD.CmdIconeClick")



## Trechos relevantes do BO (C:\4c\projeto\app\classes\MPDBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormMPD.prg
- BO: C:\4c\projeto\app\classes\MPDBO.prg
