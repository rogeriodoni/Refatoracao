# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 328: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (827 linhas total):

*-- Linhas 66 a 141:
66:                 THIS.ConfigurarPaginaLista()
67:                 THIS.ConfigurarPaginaDados()
68: 
69:                 *-- Propagar Caption correto para labels do cabecalho
70:                 loc_cCaption = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
71:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = loc_cCaption
72:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = loc_cCaption
73: 
74:                 *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
75:                 THIS.TornarControlesVisiveis(THIS)
76: 
77:                 loc_lSucesso = .T.
78:             ENDIF
79: 
80:         CATCH TO loc_oErro
81:             MsgErro(loc_oErro.Message, "Erro em InicializarForm")
82:         ENDTRY
83: 
84:         RETURN loc_lSucesso
85:     ENDPROC
86: 
87:     *==========================================================================
88:     * ConfigurarPageFrame - Imagem de fundo + container cabecalho (cnt_4c_Sombra)
89:     * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo cria apenas
90:     * o background e o cabecalho cinza superior com labels de titulo.
91:     *==========================================================================
92:     PROTECTED PROCEDURE ConfigurarPageFrame()
93:         *-- Imagem de fundo (forms OPERACIONAIS usam new_background.jpg)
94:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
95: 
96:         *-- Container cabecalho: fundo cinza + labels sombra e titulo
97:         THIS.AddObject("cnt_4c_Sombra", "Container")
98:         WITH THIS.cnt_4c_Sombra
99:             .Top         = 0
100:             .Left        = 0
101:             .Width       = THIS.Width
102:             .Height      = 80
103:             .BackColor   = RGB(100, 100, 100)
104:             .BackStyle   = 1
105:             .BorderWidth = 0
106: 
107:             .AddObject("lbl_4c_Sombra", "Label")
108:             WITH .lbl_4c_Sombra
109:                 .Top       = 18
110:                 .Left      = 10
111:                 .Width     = THIS.Width
112:                 .Height    = 40
113:                 .AutoSize  = .F.
114:                 .FontBold  = .T.
115:                 .FontName  = "Tahoma"
116:                 .FontSize  = 18
117:                 .BackStyle = 0
118:                 .ForeColor = RGB(0, 0, 0)
119:                 .WordWrap  = .T.
120:                 .Caption   = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
121:             ENDWITH
122: 
123:             .AddObject("lbl_4c_Titulo", "Label")
124:             WITH .lbl_4c_Titulo
125:                 .Top       = 17
126:                 .Left      = 10
127:                 .Width     = THIS.Width
128:                 .Height    = 46
129:                 .AutoSize  = .F.
130:                 .FontBold  = .T.
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 18
133:                 .BackStyle = 0
134:                 .ForeColor = RGB(255, 255, 255)
135:                 .WordWrap  = .T.
136:                 .Caption   = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
137:             ENDWITH
138:         ENDWITH
139:     ENDPROC
140: 
141:     *==========================================================================

*-- Linhas 171 a 180:
171:         *-- Grid de divisoes da O.P. com 5 colunas (Pedido, Cor, Tam, Qtd.Atual, Quantidade)
172:         THIS.AddObject("grd_4c_Dados", "Grid")
173:         WITH THIS.grd_4c_Dados
174:             .Top           = 195
175:             .Left          = 71
176:             .Width         = 629
177:             .Height        = 285
178:             .FontName      = "Arial"
179:             .FontSize      = 8
180:             .DeleteMark    = .F.

*-- Linhas 197 a 205:
197:                 .FontName          = "Arial"
198:                 .FontSize          = 8
199:                 .ForeColor         = RGB(0, 0, 0)
200:                 .Header1.Caption   = "Pedido"
201:                 .Header1.FontName  = "Arial"
202:                 .Header1.FontSize  = 8
203:                 .Header1.Alignment = 2
204:             ENDWITH
205: 

*-- Linhas 213 a 221:
213:                 .Resizable         = .F.
214:                 .FontName          = "Arial"
215:                 .FontSize          = 8
216:                 .Header1.Caption   = "Cor"
217:                 .Header1.FontSize  = 8
218:                 .Header1.Alignment = 2
219:             ENDWITH
220: 
221:             *-- Column3: Tam (CodTams)

*-- Linhas 228 a 236:
228:                 .Resizable         = .F.
229:                 .FontName          = "Arial"
230:                 .FontSize          = 8
231:                 .Header1.Caption   = "Tam"
232:                 .Header1.FontSize  = 8
233:                 .Header1.Alignment = 2
234:             ENDWITH
235: 
236:             *-- Column4: Qtd.Atual (Qtds - quantidade original, readonly)

*-- Linhas 244 a 252:
244:                 .FontName          = "Arial"
245:                 .FontSize          = 8
246:                 .InputMask         = "999,999.999"
247:                 .Header1.Caption   = "Qtd.Atual"
248:                 .Header1.FontName  = "Arial"
249:                 .Header1.FontSize  = 8
250:                 .Header1.Alignment = 2
251:             ENDWITH
252: 

*-- Linhas 261 a 269:
261:                 .Resizable         = .F.
262:                 .FontName          = "Arial"
263:                 .FontSize          = 8
264:                 .Header1.Caption   = "Quantidade"
265:                 .Header1.FontName  = "Arial"
266:                 .Header1.FontSize  = 8
267:                 .Header1.Alignment = 2
268:             ENDWITH
269:         ENDWITH

*-- Linhas 282 a 340:
282:         *-- EditBox de observacoes da divisao selecionada (readonly, vinculada ao cursor)
283:         THIS.AddObject("edt_4c_Obss", "EditBox")
284:         WITH THIS.edt_4c_Obss
285:             .Top               = 490
286:             .Left              = 68
287:             .Width             = 632
288:             .Height            = 96
289:             .ReadOnly          = .T.
290:             .FontName          = "Tahoma"
291:             .FontSize          = 8
292:             .ControlSource     = "cursor_4c_DivOp.Obss"
293:             .DisabledBackColor = RGB(255, 255, 255)
294:         ENDWITH
295: 
296:         *-- CommandGroup: Confirmar (inicia desabilitado) + Encerrar
297:         THIS.AddObject("cmg_4c_Conf", "CommandGroup")
298:         WITH THIS.cmg_4c_Conf
299:             .Top           = 0
300:             .Left          = 775
301:             .Width         = 160
302:             .Height        = 85
303:             .BackStyle     = 0
304:             .BorderStyle   = 0
305:             .SpecialEffect = 1
306:             .ButtonCount   = 2
307:             .Themes        = .F.
308:             .AutoSize      = .F.
309: 
310:             WITH .Buttons(1)
311:                 .Top             = 5
312:                 .Left            = 5
313:                 .Width           = 75
314:                 .Height          = 75
315:                 .Caption         = "Confirmar"
316:                 .FontBold        = .T.
317:                 .FontItalic      = .T.
318:                 .ForeColor       = RGB(90, 90, 90)
319:                 .BackColor       = RGB(255, 255, 255)
320:                 .Themes          = .F.
321:                 .SpecialEffect   = 0
322:                 .PicturePosition = 13
323:                 .WordWrap        = .T.
324:                 .AutoSize        = .F.
325:                 .MousePointer    = 15
326:                 .Enabled         = .F.
327:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
328:             ENDWITH
329: 
330:             WITH .Buttons(2)
331:                 .Top             = 5
332:                 .Left            = 80
333:                 .Width           = 75
334:                 .Height          = 75
335:                 .Caption         = "Encerrar"
336:                 .FontName        = "Comic Sans MS"
337:                 .FontBold        = .T.
338:                 .FontItalic      = .T.
339:                 .FontSize        = 8
340:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 582 a 637:
582:     *==========================================================================
583:     PROTECTED PROCEDURE ConfigurarPaginaDados()
584:         *-- Label "O.P.:"
585:         THIS.AddObject("lbl_4c_Label1", "Label")
586:         WITH THIS.lbl_4c_Label1
587:             .Top       = 128
588:             .Left      = 100
589:             .Width     = 44
590:             .Height    = 18
591:             .Caption   = "O.P. :"
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .BackStyle = 0
595:             .ForeColor = RGB(90, 90, 90)
596:         ENDWITH
597: 
598:         *-- TextBox numero da O.P. (entrada principal do usuario)
599:         THIS.AddObject("txt_4c_OP", "TextBox")
600:         WITH THIS.txt_4c_OP
601:             .Top       = 124
602:             .Left      = 152
603:             .Width     = 137
604:             .Height    = 23
605:             .InputMask = "999999999999"
606:             .MaxLength = 12
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .Value     = ""
610:         ENDWITH
611:         BINDEVENT(THIS.txt_4c_OP, "GotFocus", THIS, "TxtOPGotFocus")
612:         BINDEVENT(THIS.txt_4c_OP, "KeyPress", THIS, "TxtOPKeyPress")
613: 
614:         *-- Label "Produto:"
615:         THIS.AddObject("lbl_4c_Label2", "Label")
616:         WITH THIS.lbl_4c_Label2
617:             .Top       = 161
618:             .Left      = 71
619:             .Width     = 67
620:             .Height    = 18
621:             .Caption   = "Produto :"
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .BackStyle = 0
625:             .ForeColor = RGB(90, 90, 90)
626:         ENDWITH
627: 
628:         *-- TextBox codigo do produto (preenchido ao carregar OP, readonly)
629:         THIS.AddObject("txt_4c_Produto", "TextBox")
630:         WITH THIS.txt_4c_Produto
631:             .Top      = 157
632:             .Left     = 152
633:             .Width    = 137
634:             .Height   = 23
635:             .FontName = "Tahoma"
636:             .FontSize = 8
637:             .ReadOnly = .T.


### BO (C:\4c\projeto\app\classes\SigPrAopBO.prg):
*------------------------------------------------------------------------------
* SigPrAopBO.prg - Business Object para Alteracao de Quantidade da O.P.
* Form OPERACIONAL: Altera quantidades de divisoes de Ordens de Producao
* Tabelas principais: SigOpPic, SigCdPam, SigCdNec, SigPdMvf
*------------------------------------------------------------------------------
DEFINE CLASS SigPrAopBO AS BusinessBase

    *-- Tabela principal e chave
    this_cTabela            = "SigOpPic"
    this_cCampoChave        = "cIdChaves"

    *-- Empresa corrente
    this_cEmps              = ""

    *-- O.P. corrente
    this_nNops              = 0        && Numero da O.P. (Nops)
    this_cEmpDNps           = ""       && Chave composta empresa+DoppPads+Nops (EmpDNps)

    *-- Produto da O.P. (de SigPdMvf)
    this_cCodPds            = ""       && Codigo do produto (CodPds)

    *-- Parametros de configuracao (SigCdPam)
    this_cDoppPads          = ""       && Prefixo de OP (DoppPads)
    this_cMascNums          = ""       && Mascara de numeros (MascNums)

    *-- Flags de estado da O.P.
    this_lOpEncerrada       = .F.      && OP ja encerrada (ChkSubn = .T.)
    this_lOpLocalizada      = .F.      && OP foi localizada em SigCdNec

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = DODEFAULT()

        IF loc_lSucesso
            THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de configuracao de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DoppPads, MascNums FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    THIS.this_cDoppPads = ALLTRIM(NVL(DoppPads, ""))
                    THIS.this_cMascNums = ALLTRIM(NVL(MascNums, ""))
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros do sistema (SigCdPam).", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOP - Valida e carrega os itens da O.P. em cursor_4c_DivOp
    * Equivalente ao Get_OP.Valid do legado
    *--------------------------------------------------------------------------
    FUNCTION CarregarOP(par_nNops)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmpDNps
        LOCAL loc_lEncerrada, loc_nSeq, loc_lContinuar

        loc_lSucesso   = .F.
        loc_lContinuar = (par_nNops > 0)

        TRY
            IF loc_lContinuar
                THIS.this_nNops         = par_nNops
                loc_cEmpDNps            = THIS.this_cEmps + THIS.this_cDoppPads + STR(par_nNops, 10)
                THIS.this_cEmpDNps      = loc_cEmpDNps
                THIS.this_lOpLocalizada = .F.
                THIS.this_lOpEncerrada  = .F.
                THIS.this_cCodPds       = ""

                *-- Limpa cursor antes de carregar
                IF USED("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    ZAP
                ENDIF

                *-- Verifica existencia e status da O.P. em SigCdNec
                loc_cSQL = "SELECT ChkSubn FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nec") > 0
                    IF EOF("cursor_4c_Nec")
                        loc_lContinuar = .F.
                        IF USED("cursor_4c_Nec")
                            USE IN cursor_4c_Nec
                        ENDIF
                        MsgAviso("O.P. N" + CHR(227) + "o Localizada!!!", "Aviso")
                    ELSE
                        SELECT cursor_4c_Nec
                        loc_lEncerrada = NVL(ChkSubn, .F.)
                        IF USED("cursor_4c_Nec")
                            USE IN cursor_4c_Nec
                        ENDIF

                        THIS.this_lOpLocalizada = .T.
                        THIS.this_lOpEncerrada  = loc_lEncerrada

                        IF loc_lEncerrada
                            loc_lContinuar = .F.
                            MsgAviso("O.P. J" + CHR(225) + " Foi Encerrada!!!", "Aviso")
                        ENDIF
                    ENDIF
                ELSE
                    loc_lContinuar = .F.
                    MsgErro("Erro ao verificar O.P. em SigCdNec.", "Erro")
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Carrega codigo do produto da O.P. em SigPdMvf
                loc_cSQL = "SELECT CodPds FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(THIS.this_cEmpDNps)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Mvf") > 0
                    IF !EOF("cursor_4c_Mvf")
                        SELECT cursor_4c_Mvf
                        THIS.this_cCodPds = ALLTRIM(NVL(CodPds, ""))
                    ENDIF
                    IF USED("cursor_4c_Mvf")
                        USE IN cursor_4c_Mvf
                    ENDIF
                ENDIF

                *-- Carrega divisoes da O.P. de SigOpPic
                loc_cSQL = "SELECT Dopes, Numes, Qtds, DataEs, Obss, " + ;
                           "CPros, CodCors, CodTams, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPicTemp") > 0
                    loc_nSeq = 1
                    SELECT cursor_4c_OpPicTemp
                    SCAN
                        INSERT INTO cursor_4c_DivOp ;
                            (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, ;
                             SeqDivs, Cpros, CodCors, CodTams, cItens) ;
                        VALUES ;
                            (ALLTRIM(NVL(cursor_4c_OpPicTemp.Dopes, "")), ;
                             NVL(cursor_4c_OpPicTemp.Numes, 0), ;
                             NVL(cursor_4c_OpPicTemp.Qtds, 0), ;
                             NVL(cursor_4c_OpPicTemp.Qtds, 0), ;
                             cursor_4c_OpPicTemp.DataEs, ;
                             NVL(cursor_4c_OpPicTemp.Obss, ""), ;
                             loc_nSeq, ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CPros, "")), ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CodCors, "")), ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CodTams, "")), ;
                             NVL(cursor_4c_OpPicTemp.Citens, 0))
                        loc_nSeq = loc_nSeq + 1
                    ENDSCAN

                    IF USED("cursor_4c_OpPicTemp")
                        USE IN cursor_4c_OpPicTemp
                    ENDIF

                    SELECT cursor_4c_DivOp
                    GO TOP
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar itens da O.P. em SigOpPic.", "Erro")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Salva quantidades alteradas de volta ao SQL Server
    * Equivalente ao Grupo_Conf.Salva.Click do legado:
    * 1. Reset SeqDivs=0 em SigOpPic para a O.P.
    * 2. Para cada linha de cursor_4c_DivOp, atualiza Qtds+SeqDivs em SigOpPic
    * 3. Soma total de QtdDivs e atualiza SigPdMvf
    *--------------------------------------------------------------------------
    FUNCTION SalvarAlteracoes(par_nNops)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        LOCAL loc_cIdChaves, loc_nQtdTotal, loc_lContinuar
        LOCAL loc_cDopes, loc_nNumes, loc_nCItens, loc_nQtdDivs, loc_nSeqDiv

        loc_lSucesso   = .F.
        loc_lContinuar = (par_nNops > 0)

        TRY
            IF loc_lContinuar
                *-- Passo 1: Reseta SeqDivs = 0 para todos os itens da O.P.
                loc_cSQL = "UPDATE SigOpPic SET SeqDivs = 0 " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd0") < 1
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update - SigOpPic 1)")
                ELSE
                    IF USED("cursor_4c_Upd0")
                        USE IN cursor_4c_Upd0
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 2: Recarrega SigOpPic com cIdChaves para UPDATE por chave
                loc_cSQL = "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPicSave") < 1
                    loc_lContinuar = .F.
                    MsgErro("Erro ao recarregar dados de SigOpPic para grava" + ;
                            CHR(231) + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 3: Para cada divisao, localiza e atualiza Qtds+SeqDivs em SigOpPic
                IF USED("cursor_4c_DivOp") AND !EOF("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    GO TOP
                    SCAN WHILE loc_lContinuar
                        loc_cDopes   = ALLTRIM(cursor_4c_DivOp.Dopes)
                        loc_nNumes   = cursor_4c_DivOp.Numes
                        loc_nCItens  = cursor_4c_DivOp.cItens
                        loc_nQtdDivs = cursor_4c_DivOp.QtdDivs
                        loc_nSeqDiv  = cursor_4c_DivOp.SeqDivs

                        *-- Busca a linha correspondente em SigOpPic (SeqDivs=0 = ainda nao processado)
                        SELECT cursor_4c_OpPicSave
                        LOCATE FOR Citens         = loc_nCItens AND ;
                                   ALLTRIM(Dopes) = loc_cDopes  AND ;
                                   Numes          = loc_nNumes  AND ;
                                   SeqDivs        = 0

                        IF FOUND()
                            loc_cIdChaves = ALLTRIM(cursor_4c_OpPicSave.cIdChaves)

                            loc_cSQL = "UPDATE SigOpPic " + ;
                                       "SET Qtds = "    + FormatarNumeroSQL(loc_nQtdDivs) + ;
                                       ", SeqDivs = "   + FormatarNumeroSQL(loc_nSeqDiv)  + ;
                                       " WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd1") < 1
                                loc_lContinuar = .F.
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (Update - SigOpPic 2)")
                            ELSE
                                IF USED("cursor_4c_Upd1")
                                    USE IN cursor_4c_Upd1
                                ENDIF
                                *-- Marca como processado no cursor local (SeqDivs != 0)
                                REPLACE SeqDivs WITH loc_nSeqDiv IN cursor_4c_OpPicSave
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_DivOp
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_OpPicSave")
                    USE IN cursor_4c_OpPicSave
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 4: Soma QtdDivs e atualiza total em SigPdMvf
                loc_nQtdTotal = 0
                IF USED("cursor_4c_DivOp") AND !EOF("cursor_4c_DivOp")
                    SELECT SUM(QtdDivs) AS nTotalQtd FROM cursor_4c_DivOp ;
                           INTO CURSOR cursor_4c_Soma READWRITE
                    IF !EOF("cursor_4c_Soma")
                        loc_nQtdTotal = NVL(cursor_4c_Soma.nTotalQtd, 0)
                    ENDIF
                    IF USED("cursor_4c_Soma")
                        USE IN cursor_4c_Soma
                    ENDIF
                ENDIF

                loc_cSQL = "SELECT cIdChaves FROM SigPdMvf " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvfSave") > 0
                    IF !EOF("cursor_4c_MvfSave")
                        SELECT cursor_4c_MvfSave
                        loc_cIdChaves = ALLTRIM(cursor_4c_MvfSave.cIdChaves)

                        loc_cSQL = "UPDATE SigPdMvf " + ;
                                   "SET Qtds = " + FormatarNumeroSQL(loc_nQtdTotal) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd2") < 1
                            loc_lContinuar = .F.
                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                    "Falha na Conex" + CHR(227) + "o (Update - SigPdMvf)")
                        ELSE
                            IF USED("cursor_4c_Upd2")
                                USE IN cursor_4c_Upd2
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MvfSave")
                        USE IN cursor_4c_MvfSave
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 5: Auditoria, limpa cursor e reseta estado
                THIS.RegistrarAuditoria("ALTERAR")

                IF USED("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    ZAP
                ENDIF

                THIS.this_nNops    = 0
                THIS.this_cEmpDNps = ""
                THIS.this_cCodPds  = ""

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    * Aceita alias contendo qualquer subset dos campos: Nops, CodPds, Dopes,
    * Numes, Qtds, DataEs, Obss, Cpros, CodCors, CodTams, cItens, SeqDivs
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            *-- Chave da O.P.
            IF TYPE("Nops") != "U"
                THIS.this_nNops = NVL(Nops, 0)
            ENDIF

            *-- Empresa
            IF TYPE("Emps") != "U"
                THIS.this_cEmps = ALLTRIM(NVL(Emps, ""))
            ENDIF

            *-- Produto (SigPdMvf)
            IF TYPE("CodPds") != "U"
                THIS.this_cCodPds = ALLTRIM(NVL(CodPds, ""))
            ENDIF

            *-- Recompoe chave composta se possivel
            IF !EMPTY(THIS.this_cDoppPads) AND THIS.this_nNops > 0
                THIS.this_cEmpDNps = THIS.this_cEmps + THIS.this_cDoppPads + STR(THIS.this_nNops, 10)
            ENDIF

            *-- Status da O.P. (SigCdNec)
            IF TYPE("ChkSubn") != "U"
                THIS.this_lOpEncerrada  = NVL(ChkSubn, .F.)
                THIS.this_lOpLocalizada = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "Nops=" + TRANSFORM(THIS.this_nNops)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL nao insere novos registros em SigOpPic
    * A tela apenas ALTERA quantidades de OPs existentes. Metodo mantido
    * para satisfazer contrato de BusinessBase; delega para SalvarAlteracoes
    * quando invocado via Salvar() em modo de insercao (nao usado nesta tela).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nNops > 0
            loc_lSucesso = THIS.SalvarAlteracoes(THIS.this_nNops)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("INSERIR")
            ENDIF
        ELSE
            *-- Nada a inserir - fluxo nao aplicavel a esta tela operacional
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Grava alteracoes de quantidade de volta em SigOpPic
    * Fluxo real esta em SalvarAlteracoes (chamada por BtnConfirmarClick do
    * form). Este metodo delega e registra auditoria conforme contrato de
    * BusinessBase.Salvar().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nNops > 0
            loc_lSucesso = THIS.SalvarAlteracoes(THIS.this_nNops)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Nenhuma O.P. carregada para atualiza" + CHR(231) + CHR(227) + "o."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

