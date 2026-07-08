*==============================================================================
* SIGREFTPBO.PRG
* Business Object para Relatorio - Ficha Tecnica do Produto
* Herda de RelatorioBase
*
* Descricao:
*   Gerencia a logica do relatorio SigReFtp (Ficha Tecnica do Produto).
*   Recebe parametros pcProd/pdProd do form chamador.
*   Utiliza cursor csDetalhes ja aberto no contexto do chamador para montar
*   cursor de selecao cursor_4c_SelSigReFtp, onde o usuario marca/desmarca
*   processos antes de imprimir.
*   Suporta dois layouts: Reduzida (SigReFtp.frx) e Expandida (SigReFt1.frx).
*==============================================================================

DEFINE CLASS SigReFtpBO AS RelatorioBase

    *-- Referencia ao cursor fonte (csDetalhes do contexto chamador)
    this_cTabela          = "csDetalhes"
    this_cCampoChave      = "Ordems"
    this_cMensagemErro    = ""

    *-- Parametros de entrada (populados pelo form via FormParaRelatorio)
    this_cCodProd         = ""   && Codigo do produto (pcProd)
    this_cNomProd         = ""   && Descricao do produto (pdProd)

    *-- Configuracao do relatorio
    this_nTipoRelatorio   = 1    && 1=Reduzida (SigReFtp.frx), 2=Expandida (SigReFt1.frx)

    *-- Cursor de selecao (equivalente ao csSelekTon do legado)
    this_cCursorSel       = "cursor_4c_SelSigReFtp"

    *-- Paths dos arquivos FRX (configurados no Init)
    this_cArqRelReduzido  = ""
    this_cArqRelExpandido = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cArqRelReduzido  = gc_4c_CaminhoReports + "SigReFtp.frx"
            THIS.this_cArqRelExpandido = gc_4c_CaminhoReports + "SigReFt1.frx"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorSelecao - Cria cursor de selecao a partir de csDetalhes
    * Equivalente ao bloco SELECT/INDEX do Init() legado.
    * par_cCodProd: Codigo do produto
    * par_cNomProd: Descricao do produto
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorSelecao(par_cCodProd, par_cNomProd)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED("csDetalhes")
                THIS.this_cMensagemErro = "Cursor csDetalhes n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cCodProd = ALLTRIM(NVL(par_cCodProd, ""))
            THIS.this_cNomProd = ALLTRIM(NVL(par_cNomProd, ""))

            *-- Fecha cursor anterior se existir
            IF USED(THIS.this_cCursorSel)
                USE IN (THIS.this_cCursorSel)
            ENDIF

            *-- Cria cursor de selecao com coluna lMarca adicional
            SELECT .F. AS lMarca, * ;
              FROM csDetalhes ;
              INTO CURSOR (THIS.this_cCursorSel) READWRITE

            *-- Cria indice para busca por Ordem+Grupo (mesmo do legado)
            SELECT (THIS.this_cCursorSel)
            INDEX ON STR(Ordems, 2) + Grupos TAG OrdGru
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Filtra csDetalhes com base nas marcacoes do usuario
    * Equivalente ao 'processamento' do legado:
    *   Recall All em csDetalhes, depois deleta os nao marcados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cCursorSel
        loc_lSucesso  = .F.
        loc_cCursorSel = THIS.this_cCursorSel
        TRY
            IF !USED("csDetalhes")
                THIS.this_cMensagemErro = "Cursor csDetalhes n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF
            IF !USED(loc_cCursorSel)
                THIS.this_cMensagemErro = "Cursor de sele" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o inicializado"
                loc_lSucesso = .F.
            ENDIF

            *-- Restaura todos os registros deletados anteriormente
            SELECT csDetalhes
            RECALL ALL

            *-- Varre csDetalhes e deleta registros nao selecionados
            SCAN
                IF SEEK(STR(csDetalhes.Ordems, 2) + csDetalhes.Grupos, ;
                        loc_cCursorSel, "OrdGru")
                    IF !EVALUATE(loc_cCursorSel + ".lMarca")
                        DELETE IN csDetalhes
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Posiciona no inicio de todos os cursores (igual ao legado)
            GO TOP IN (loc_cCursorSel)
            IF USED("csCabecalho")
                GO TOP IN csCabecalho
            ENDIF
            GO TOP IN csDetalhes

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo preview (PREVIEW NOCONSOLE)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com prompt de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) TO PRINTER PROMPT NOCONSOLE
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Imprime relatorio direto sem prompt
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) TO PRINTER
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) TO PRINTER
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Seleciona todos os processos (cmdSel.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorSel)
                loc_lSucesso = .F.
            ENDIF
            REPLACE ALL lMarca WITH .T. IN (THIS.this_cCursorSel)
            GO TOP IN (THIS.this_cCursorSel)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os processos (CmdApg.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorSel)
                loc_lSucesso = .F.
            ENDIF
            REPLACE ALL lMarca WITH .F. IN (THIS.this_cCursorSel)
            GO TOP IN (THIS.this_cCursorSel)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo do produto (chave de contexto)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodProd
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursor de selecao proprio (NAO fecha csDetalhes)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorSel)
            USE IN (THIS.this_cCursorSel)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
