CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-TIPO] Linha ~2288: Cursor 'cursor_4c_Itens' campo 'ordems' tipo VFP='C' incompativel com SQL 'numeric' (esperado: N/B/Y)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormLpr.prg):

--- Linhas 2269 a 2309 ---
2269:         ENDTRY
2270:     ENDPROC
2271: 
2272:     *==========================================================================
2273:     * BtnINSEREClick - Insere linha em branco no cursor de itens da lista
2274:     *==========================================================================
2275:     PROCEDURE BtnINSEREClick()
2276:         LOCAL loc_oPg2, loc_cLpreco
2277:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2278:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2279: 
2280:         IF EMPTY(loc_cLpreco)
2281:             MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de inserir itens.", "Aviso")
2282:             RETURN
2283:         ENDIF
2284: 
2285:         TRY
2286:             IF !USED("cursor_4c_Itens")
2287:                 SET NULL ON
2288:                 CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2289:                     cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2290:                     pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2291:                     vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2292:                     ordems c(1), ccontroles c(1), precode n(16,6))
2293:                 SET NULL OFF
2294:             ENDIF
2295: 
2296:             SELECT cursor_4c_Itens
2297:             SET FILTER TO
2298:             INSERT INTO cursor_4c_Itens (lprecos, ordems) VALUES (loc_cLpreco, CHR(255))
2299:             SET FILTER TO !DELETED("cursor_4c_Itens")
2300: 
2301:             THIS.VincularGrade()
2302: 
2303:             SELECT cursor_4c_Itens
2304:             GO BOTTOM
2305: 
2306:             IF THIS.this_cCompVenda = "C" AND PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) ;
2307:                     AND loc_oPg2.grd_4c_GradeC.Visible
2308:                 loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2309:             ELSE



## Trechos relevantes do BO (C:\4c\projeto\app\classes\LprBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormLpr.prg
- BO: C:\4c\projeto\app\classes\LprBO.prg
