# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMen.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (572 linhas total):

*-- Linhas 99 a 252:
99:     *--------------------------------------------------------------------------
100:         THIS.AddObject("cnt_4c_Sombra", "Container")
101:         WITH THIS.cnt_4c_Sombra
102:             .Top         = 0
103:             .Left        = 0
104:             .Width       = THIS.Width
105:             .Height      = 80
106:             .BorderWidth = 0
107:             .BackColor   = RGB(100, 100, 100)
108:             .Visible     = .T.
109:         ENDWITH
110: 
111:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
112:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
113:             .FontBold  = .T.
114:             .FontName  = "Tahoma"
115:             .FontSize  = 18
116:             .WordWrap  = .T.
117:             .Alignment = 0
118:             .BackStyle = 0
119:             .Caption   = "Mensagens"
120:             .Height    = 40
121:             .Left      = 10
122:             .Top       = 18
123:             .Width     = 769
124:             .ForeColor = RGB(0, 0, 0)
125:             .Visible   = .T.
126:         ENDWITH
127: 
128:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
129:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
130:             .FontBold  = .T.
131:             .FontName  = "Tahoma"
132:             .FontSize  = 18
133:             .WordWrap  = .T.
134:             .Alignment = 0
135:             .BackStyle = 0
136:             .Caption   = "Mensagens"
137:             .Height    = 46
138:             .Left      = 10
139:             .Top       = 17
140:             .Width     = 769
141:             .ForeColor = RGB(255, 255, 255)
142:             .Visible   = .T.
143:         ENDWITH
144:     ENDPROC
145: 
146:     *--------------------------------------------------------------------------
147:     PROTECTED PROCEDURE ConfigurarShape()
148:     *--------------------------------------------------------------------------
149:         THIS.AddObject("shp_4c_Shape1", "Shape")
150:         WITH THIS.shp_4c_Shape1
151:             .Top         = 7
152:             .Left        = 691
153:             .Height      = 110
154:             .Width       = 90
155:             .BackStyle   = 0
156:             .BorderStyle = 0
157:             .BorderColor = RGB(136, 189, 188)
158:             .Visible     = .T.
159:         ENDWITH
160:     ENDPROC
161: 
162:     *--------------------------------------------------------------------------
163:     PROTECTED PROCEDURE ConfigurarLabel2()
164:     *--------------------------------------------------------------------------
165:         THIS.AddObject("lbl_4c_Label2", "Label")
166:         WITH THIS.lbl_4c_Label2
167:             .AutoSize  = .T.
168:             .FontBold  = .T.
169:             .FontName  = "Tahoma"
170:             .FontSize  = 8
171:             .BackStyle = 0
172:             .Caption   = "[ Texto ]"
173:             .Height    = 15
174:             .Left      = 376
175:             .Top       = 90
176:             .Width     = 51
177:             .ForeColor = RGB(90, 90, 90)
178:             .Visible   = .T.
179:         ENDWITH
180:     ENDPROC
181: 
182:     *--------------------------------------------------------------------------
183:     PROTECTED PROCEDURE ConfigurarContainer()
184:     *--------------------------------------------------------------------------
185:         THIS.AddObject("cnt_4c_Container1", "Container")
186:         WITH THIS.cnt_4c_Container1
187:             .Top           = 108
188:             .Left          = 123
189:             .Width         = 554
190:             .Height        = 150
191:             .SpecialEffect = 1
192:             .BackColor     = RGB(255, 255, 255)
193:             .Visible       = .T.
194:         ENDWITH
195: 
196:         THIS.cnt_4c_Container1.AddObject("obj_4c_GetMemo", "EditBox")
197:         WITH THIS.cnt_4c_Container1.obj_4c_GetMemo
198:             .BorderStyle = 0
199:             .Height      = 140
200:             .Left        = 6
201:             .ReadOnly    = .T.
202:             .ScrollBars  = 0
203:             .Top         = 5
204:             .Width       = 541
205:             .BackColor   = RGB(212, 208, 200)
206:             .Visible     = .F.
207:         ENDWITH
208: 
209:         THIS.cnt_4c_Container1.AddObject("lbl_4c_Gettexto", "Label")
210:         WITH THIS.cnt_4c_Container1.lbl_4c_Gettexto
211:             .WordWrap  = .T.
212:             .Alignment = 2
213:             .Caption   = ""
214:             .Height    = 123
215:             .Left      = 8
216:             .Top       = 8
217:             .Width     = 520
218:             .Visible   = .T.
219:         ENDWITH
220:     ENDPROC
221: 
222:     *--------------------------------------------------------------------------
223:     PROTECTED PROCEDURE ConfigurarBotaoOk()
224:     *--------------------------------------------------------------------------
225:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
226:         WITH THIS.cmd_4c_Ok
227:             .Top           = 3
228:             .Left          = 725
229:             .Width         = 75
230:             .Height        = 75
231:             .Caption       = "OK"
232:             .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
233:             .FontName      = "Comic Sans MS"
234:             .FontBold      = .T.
235:             .FontItalic    = .T.
236:             .FontSize      = 8
237:             .ForeColor     = RGB(90, 90, 90)
238:             .BackColor     = RGB(255, 255, 255)
239:             .Themes        = .F.
240:             .SpecialEffect = 0
241:             .MousePointer  = 15
242:             .WordWrap      = .T.
243:             .PicturePosition = 13
244:             .Visible       = .T.
245:         ENDWITH
246: 
247:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
248:     ENDPROC
249: 
250:     *--------------------------------------------------------------------------
251:     PROTECTED PROCEDURE CarregarMensagem()
252:     *--------------------------------------------------------------------------

*-- Linhas 272 a 289:
272:                        " para o Produto : " + ;
273:                        THIS.this_oBusinessObject.this_cCpros
274: 
275:         THIS.Caption = loc_cCaption
276:         THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
277:         THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
278: 
279:         *-- BO usa ALLTRIM ao carregar: "I " -> "I", "B " -> "B", "BI" permanece
280:         LOCAL loc_cEstilos
281:         loc_cEstilos = ALLTRIM(THIS.this_oBusinessObject.this_cEstilos)
282: 
283:         IF THIS.this_lUsaDescr
284:             THIS.cnt_4c_Container1.lbl_4c_Gettexto.Visible = .F.
285:             WITH THIS.cnt_4c_Container1.obj_4c_GetMemo
286:                 .Visible    = .T.
287:                 .Value      = ALLTRIM(loc_cCaptionA + loc_cCaptionB)
288:                 .FontName   = ALLTRIM(THIS.this_oBusinessObject.this_cFontes)
289:                 .FontSize   = THIS.this_oBusinessObject.this_nTamanhos

*-- Linhas 297 a 308:
297:                     .FontBold = .T.
298:                 ENDIF
299:             ENDWITH
300:             THIS.cmd_4c_Ok.SetFocus()
301:         ELSE
302:             WITH THIS.cnt_4c_Container1.lbl_4c_Gettexto
303:                 .Caption    = ALLTRIM(loc_cCaptionA + loc_cCaptionB)
304:                 .FontName   = ALLTRIM(THIS.this_oBusinessObject.this_cFontes)
305:                 .FontSize   = THIS.this_oBusinessObject.this_nTamanhos
306:                 .ForeColor  = THIS.this_oBusinessObject.this_nCors
307:                 .FontBold   = .F.
308:                 .FontItalic = .F.

*-- Linhas 405 a 415:
405:             THIS.cnt_4c_Container1.Visible = .T.
406:             THIS.cnt_4c_Container1.Refresh()
407:         ENDIF
408:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
409:             THIS.cmd_4c_Ok.Visible = .T.
410:             THIS.cmd_4c_Ok.Enabled = .T.
411:         ENDIF
412:     ENDPROC
413: 
414:     *--------------------------------------------------------------------------
415:     * AlternarPagina - Adaptador para forms OPERACIONAIS planos

*-- Linhas 432 a 441:
432:             THIS.cnt_4c_Container1.Refresh()
433:         ENDIF
434: 
435:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5) AND THIS.cmd_4c_Ok.Visible
436:             THIS.cmd_4c_Ok.SetFocus()
437:         ENDIF
438: 
439:         RETURN loc_nPagina
440:     ENDPROC
441: 

*-- Linhas 527 a 560:
527:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
528:         LOCAL loc_lHabilitar
529:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
530:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
531:             THIS.cmd_4c_Ok.Enabled = loc_lHabilitar
532:         ENDIF
533:     ENDPROC
534: 
535:     *--------------------------------------------------------------------------
536:     * LimparCampos - Limpa exibicao do painel de mensagem
537:     *--------------------------------------------------------------------------
538:     PROTECTED PROCEDURE LimparCampos()
539:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
540:             IF PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Gettexto", 5)
541:                 THIS.cnt_4c_Container1.lbl_4c_Gettexto.Caption = ""
542:             ENDIF
543:             IF PEMSTATUS(THIS.cnt_4c_Container1, "obj_4c_GetMemo", 5)
544:                 THIS.cnt_4c_Container1.obj_4c_GetMemo.Value = ""
545:             ENDIF
546:         ENDIF
547:     ENDPROC
548: 
549:     *--------------------------------------------------------------------------
550:     * AjustarBotoesPorModo - Dialog sem botoes CRUD; nada a ajustar
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE AjustarBotoesPorModo()
553:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
554:             THIS.cmd_4c_Ok.Visible = .T.
555:             THIS.cmd_4c_Ok.Enabled = .T.
556:         ENDIF
557:     ENDPROC
558: 
559:     *--------------------------------------------------------------------------
560:     PROCEDURE Destroy()


### BO (C:\4c\projeto\app\classes\SigPdMenBO.prg):
*==============================================================================
* SigPdMenBO.prg - Business Object para Mensagens de Produto
* Tabela: SigCdMsg
* Chave: cidchaves
*==============================================================================

DEFINE CLASS SigPdMenBO AS BusinessBase

    *-- Campos de SigCdMsg
    this_cCidChave  = ""
    this_nCors      = 0
    this_cCpros     = ""
    this_cEmpcpros  = ""
    this_cEmps      = ""
    this_cEstilos   = ""
    this_cFontes    = ""
    this_cLinha1s   = ""
    this_cLinha2s   = ""
    this_nTamanhos  = 0
    this_cCgrus     = ""
    this_cMercs     = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        this_cTabela     = "SigCdMsg"
        this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMensagem - Carrega dados de SigCdMsg pelo cidchave
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMensagem(par_cCidChave)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cors, cpros, empcpros, emps, " + ;
                       "estilos, fontes, linha1s, linha2s, tamanhos, cgrus, mercs " + ;
                       "FROM SigCdMsg " + ;
                       "WHERE estilos = " + EscaparSQL(par_cCidChave)

            IF USED("cursor_4c_SigPdMenMsg")
                TABLEREVERT(.T., "cursor_4c_SigPdMenMsg")
                USE IN cursor_4c_SigPdMenMsg
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPdMenMsg") > 0
                IF !EOF("cursor_4c_SigPdMenMsg")
                    SELECT cursor_4c_SigPdMenMsg
                    THIS.this_cCidChave  = ALLTRIM(NVL(cidchaves, ""))
                    THIS.this_nCors      = NVL(cors, 0)
                    THIS.this_cCpros     = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cEmpcpros  = ALLTRIM(NVL(empcpros, ""))
                    THIS.this_cEmps      = ALLTRIM(NVL(emps, ""))
                    THIS.this_cEstilos   = ALLTRIM(NVL(estilos, ""))
                    THIS.this_cFontes    = ALLTRIM(NVL(fontes, ""))
                    THIS.this_cLinha1s   = ALLTRIM(NVL(linha1s, ""))
                    THIS.this_cLinha2s   = ALLTRIM(NVL(linha2s, ""))
                    THIS.this_nTamanhos  = NVL(tamanhos, 9)
                    THIS.this_cCgrus     = ALLTRIM(NVL(cgrus, ""))
                    THIS.this_cMercs     = ALLTRIM(NVL(mercs, ""))
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao buscar mensagem do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChave  = ALLTRIM(TratarNulo(cidchaves, "C"))
            THIS.this_nCors      = TratarNulo(cors, "N")
            THIS.this_cCpros     = ALLTRIM(TratarNulo(cpros, "C"))
            THIS.this_cEmpcpros  = ALLTRIM(TratarNulo(empcpros, "C"))
            THIS.this_cEmps      = ALLTRIM(TratarNulo(emps, "C"))
            THIS.this_cEstilos   = ALLTRIM(TratarNulo(estilos, "C"))
            THIS.this_cFontes    = ALLTRIM(TratarNulo(fontes, "C"))
            THIS.this_cLinha1s   = ALLTRIM(TratarNulo(linha1s, "C"))
            THIS.this_cLinha2s   = ALLTRIM(TratarNulo(linha2s, "C"))
            THIS.this_nTamanhos  = TratarNulo(tamanhos, "N")
            THIS.this_cCgrus     = ALLTRIM(TratarNulo(cgrus, "C"))
            THIS.this_cMercs     = ALLTRIM(TratarNulo(mercs, "C"))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF EMPTY(ALLTRIM(THIS.this_cCidChave))
            MsgAviso("Chave da mensagem " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cCpros))
            MsgAviso("C" + CHR(243) + "digo do produto " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("C" + CHR(243) + "digo da empresa " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdMsg " + ;
                       "(cidchaves, cors, cpros, empcpros, emps, " + ;
                       "estilos, fontes, linha1s, linha2s, tamanhos, cgrus, mercs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChave) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCors) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cEmpcpros) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEstilos) + ", " + ;
                       EscaparSQL(THIS.this_cFontes) + ", " + ;
                       EscaparSQL(THIS.this_cLinha1s) + ", " + ;
                       EscaparSQL(THIS.this_cLinha2s) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTamanhos) + ", " + ;
                       EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       EscaparSQL(THIS.this_cMercs) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMsg SET " + ;
                       "cors = " + FormatarNumeroSQL(THIS.this_nCors) + ", " + ;
                       "cpros = " + EscaparSQL(THIS.this_cCpros) + ", " + ;
                       "empcpros = " + EscaparSQL(THIS.this_cEmpcpros) + ", " + ;
                       "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "estilos = " + EscaparSQL(THIS.this_cEstilos) + ", " + ;
                       "fontes = " + EscaparSQL(THIS.this_cFontes) + ", " + ;
                       "linha1s = " + EscaparSQL(THIS.this_cLinha1s) + ", " + ;
                       "linha2s = " + EscaparSQL(THIS.this_cLinha2s) + ", " + ;
                       "tamanhos = " + FormatarNumeroSQL(THIS.this_nTamanhos) + ", " + ;
                       "cgrus = " + EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       "mercs = " + EscaparSQL(THIS.this_cMercs) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMsg " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

