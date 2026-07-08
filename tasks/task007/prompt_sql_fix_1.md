CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-TIPO] Linha ~396: Cursor 'cursor_4c_Dados' campo 'situas' tipo VFP='N' incompativel com SQL 'char' (esperado: C)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formcfo.prg):

--- Linhas 377 a 417 ---
377:             .BackColor     = RGB(234, 232, 228)
378:             .ForeColor     = RGB(0, 0, 0)
379:             .FontName      = "Tahoma"
380:             .FontSize      = 8
381:             .Themes        = .F.
382:             .SpecialEffect = 0
383:             .MousePointer  = 15
384:         ENDWITH
385:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML, "Click", THIS, "BtnImpXMLClick")
386: 
387:         *----------------------------------------------------------------------
388:         * Cursor placeholder para o Grid
389:         * cursor_4c_Dados: codigos C(10), descricaos C(60), situas N(1,0)
390:         * O BO usa ZAP+APPEND para preservar as colunas existentes do grid
391:         *----------------------------------------------------------------------
392:         IF USED("cursor_4c_Dados")
393:             USE IN cursor_4c_Dados
394:         ENDIF
395:         SET NULL ON
396:         CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
397:         SET NULL OFF
398: 
399:         *----------------------------------------------------------------------
400:         * Grid grd_4c_Lista
401:         * Top=164 = original 135 + compensacao 29
402:         * Width=971, Height=448 (do analise.json ajustado)
403:         * RecordSource e ColumnCount FORA de WITH para criar colunas imediatamente
404:         *----------------------------------------------------------------------
405:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
406:         loc_oGrid = loc_oPagina.grd_4c_Lista
407: 
408:         loc_oGrid.Top                 = 164
409:         loc_oGrid.Left                = 12
410:         loc_oGrid.Width               = 971
411:         loc_oGrid.Height              = 445
412:         loc_oGrid.FontName            = "Verdana"
413:         loc_oGrid.FontSize            = 8
414:         loc_oGrid.ForeColor           = RGB(90, 90, 90)
415:         loc_oGrid.BackColor           = RGB(255, 255, 255)
416:         loc_oGrid.GridLineColor       = RGB(238, 238, 238)
417:         loc_oGrid.GridLines           = 3



## Trechos relevantes do BO (C:\4c\projeto\app\classes\cfoBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formcfo.prg
- BO: C:\4c\projeto\app\classes\cfoBO.prg
