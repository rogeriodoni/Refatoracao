SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
#DEFINE SAIDA "C:\4c\automation\compile_prod.txt"
COMPILE "C:\4c\projeto\app\forms\cadastros\FormProduto.prg"
COMPILE "C:\4c\projeto\app\classes\ProdutoBO.prg"
STRTOFILE("FormProduto: " + ;
    IIF(FILE("C:\4c\projeto\app\forms\cadastros\FormProduto.err"), ;
        FILETOSTR("C:\4c\projeto\app\forms\cadastros\FormProduto.err"), "LIMPO") + ;
    CHR(13) + CHR(10) + "ProdutoBO  : " + ;
    IIF(FILE("C:\4c\projeto\app\classes\ProdutoBO.err"), ;
        FILETOSTR("C:\4c\projeto\app\classes\ProdutoBO.err"), "LIMPO") + ;
    CHR(13) + CHR(10), SAIDA)
QUIT
