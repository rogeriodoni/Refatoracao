# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2744: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 2872: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formpag.prg) - TRECHOS RELEVANTES PARA PASS GRID (3083 linhas total):

*-- Linhas 248 a 298:
248:             BINDEVENT(loc_oCntSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
249: 
250:             && --- Grid ---
251:             loc_oPage.AddObject("grd_4c_Lista", "Grid")
252:             loc_oGrd = loc_oPage.grd_4c_Lista
253:             WITH loc_oGrd
254:                 .Top          = 130
255:                 .Left         = 26
256:                 .Width        = 890
257:                 .Height       = 490
258:                 .RecordSource = "cursor_4c_Dados"
259:                 .ReadOnly     = .T.
260:                 .ColumnCount  = 5
261:                 .HeaderHeight = 22
262:                 .RowHeight    = 18
263:                 .GridLines    = 1
264:                 .Visible      = .T.
265:             ENDWITH
266: 
267:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
268:             loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.fpags"
269:             loc_oGrd.Column1.Width           = 100
270: 
271:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
272:             loc_oGrd.Column2.ControlSource   = "cursor_4c_Dados.descrs"
273:             loc_oGrd.Column2.Width           = 250
274: 
275:             loc_oGrd.Column3.Header1.Caption = "Moeda"
276:             loc_oGrd.Column3.ControlSource   = "cursor_4c_Dados.moefpgs"
277:             loc_oGrd.Column3.Width           = 60
278: 
279:             loc_oGrd.Column4.Header1.Caption = "Dias"
280:             loc_oGrd.Column4.ControlSource   = "cursor_4c_Dados.dias"
281:             loc_oGrd.Column4.Width           = 50
282: 
283:             loc_oGrd.Column5.Header1.Caption = "T.Venc"
284:             loc_oGrd.Column5.ControlSource   = "cursor_4c_Dados.tvens"
285:             loc_oGrd.Column5.Width           = 60
286: 
287:         CATCH TO loc_oErro
288:             MsgErro("Erro em Formpag.ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
289:         ENDTRY
290:     ENDPROC
291: 
292:     *==========================================================================
293:     PROTECTED PROCEDURE ConfigurarPaginaDados()
294:     *==========================================================================
295:         LOCAL loc_oPage, loc_oCntSalva, loc_oCntSaida2, loc_oPgf2
296:         TRY
297:             loc_oPage = THIS.pgf_4c_Paginas.Pages(2)
298:             loc_oPage.Caption = "Dados"

*-- Linhas 2730 a 2760:
2730:         CATCH TO loc_oErro
2731:             MsgErro("Erro em Formpag.AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
2732:         ENDTRY
2733:     ENDPROC
2734: 
2735:     *==========================================================================
2736:     PROCEDURE CarregarLista()
2737:     *==========================================================================
2738:         LOCAL loc_lResultado
2739:         loc_lResultado = .F.
2740: 
2741:         TRY
2742:             IF THIS.this_oBusinessObject.Buscar("")
2743:                 IF USED("cursor_4c_Dados")
2744:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
2745:                 ENDIF
2746:                 loc_lResultado = .T.
2747:             ENDIF
2748:         CATCH TO loc_oErro
2749:             MsgErro("Erro em Formpag.CarregarLista: " + loc_oErro.Message, "Erro")
2750:         ENDTRY
2751: 
2752:         RETURN loc_lResultado
2753:     ENDPROC
2754: 
2755:     *==========================================================================
2756:     PROCEDURE BtnIncluirClick()
2757:     *==========================================================================
2758:         LOCAL loc_lResultado
2759:         loc_lResultado = .F.
2760: 

*-- Linhas 2857 a 2888:
2857: 
2858:             loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
2859:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca") < 0
2860:                 CREATE CURSOR cursor_4c_Busca (fpags C(12), descrs C(30))
2861:             ENDIF
2862: 
2863:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2864:             IF VARTYPE(loc_oBusca) = "O"
2865:                 loc_oBusca.DefinirCursor("cursor_4c_Busca", "fpags", "descrs", "Busca de Condi" + CHR(231) + CHR(245) + "es de Pagamento")
2866:                 loc_oBusca.Mostrar()
2867: 
2868:                 loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2869:                 IF !EMPTY(loc_cCodigo)
2870:                     THIS.this_oBusinessObject.Buscar("fpags = '" + loc_cCodigo + "'")
2871:                     IF USED("cursor_4c_Dados")
2872:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
2873:                     ENDIF
2874:                     loc_lResultado = .T.
2875:                 ENDIF
2876:             ENDIF
2877: 
2878:             IF USED("cursor_4c_Busca")
2879:                 USE IN cursor_4c_Busca
2880:             ENDIF
2881:         CATCH TO loc_oErro
2882:             MsgErro("Erro em Formpag.BtnBuscarClick: " + loc_oErro.Message, "Erro")
2883:             IF USED("cursor_4c_Busca")
2884:                 USE IN cursor_4c_Busca
2885:             ENDIF
2886:         ENDTRY
2887: 
2888:         RETURN loc_lResultado

