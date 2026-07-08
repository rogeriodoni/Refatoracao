**
Return( CREATEOBJECT("PDFEvent") ) 


DEFINE CLASS PDFEvent AS Custom

IMPLEMENTS __clsPDFCreator IN "PDFCreator.clsPDFCreatorOptions"

* Evénement qui indique si l'imprimante est prête

Procedure __clsPDFCreator_eReady() AS VOID

nReadyState = 1

ENDPROC

* Gestion des erreurs
Procedure __clsPDFCreator_eError() AS VOID

ENDPROC

ENDDEFINE 

