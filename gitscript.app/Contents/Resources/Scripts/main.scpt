JsOsaDAS1.001.00bplist00�Vscripto  v a r   M A X _ C H A N G E S _ N U M   =   1 0 0 0 ; 
 
 v a r   a p p   =   A p p l i c a t i o n . c u r r e n t A p p l i c a t i o n ( ) 
 a p p . i n c l u d e S t a n d a r d A d d i t i o n s   =   t r u e 
 
 v a r   s e A p p   =   A p p l i c a t i o n ( " S y s t e m   E v e n t s " ) ; 
 
 v a r   s e t t i n g s P l i s t P a t h   =   P a t h ( a p p . d o S h e l l S c r i p t ( " c d   ~ ;   p w d " )   +   " / g i t d i r . p l i s t " ) ; 
 
 v a r   g i t F o l d e r ; 
 
 i f   ( s e A p p . e x i s t s ( s e t t i n g s P l i s t P a t h ) )   { 
 	 v a r   c o n t e n t   =   $ . N S D i c t i o n a r y . d i c t i o n a r y W i t h C o n t e n t s O f F i l e ( s e t t i n g s P l i s t P a t h . t o S t r i n g ( ) ) ; 
 	 v a r   p l i s t D i c t   =   O b j C . d e e p U n w r a p ( c o n t e n t ) ; 
 	 g i t F o l d e r   =   P a t h ( p l i s t D i c t [ " g i t d i r " ] ) ; 
 }   e l s e   { 
 	 g i t F o l d e r   =   a p p . c h o o s e F o l d e r ( { 
         	 w i t h P r o m p t :   " P l e a s e   s e l e c t   a   g i t   f o l d e r : " 
 	 } ) 
 	 
 	 v a r   i t e m 1   =   { " g i t d i r " :   g i t F o l d e r . t o S t r i n g ( ) } ; 
 	 v a r   p l i s t   =   $ . N S D i c t i o n a r y . d i c t i o n a r y W i t h D i c t i o n a r y ( i t e m 1 ) ; 
 	 p l i s t . w r i t e T o F i l e A t o m i c a l l y ( s e t t i n g s P l i s t P a t h . t o S t r i n g ( ) ,   t r u e ) ; 
 } 
 
 w h i l e   ( t r u e )   { 
 	 v a r   r e s u l t   =   a p p . d o S h e l l S c r i p t ( " c d   "   +   g i t F o l d e r   +   " ;   g i t   d i f f   m a s t e r   - - n u m s t a t " ) ; 
 
 	 i f   ( r e s u l t . l e n g t h   = =   0 )   { 
 	 	 d e l a y ( 5 ) ; 
 	 	 c o n t i n u e ; 
 	 } 
 	 
 	 v a r   l i n e s   =   r e s u l t . s p l i t ( " \ r " ) ; 
 	 
 	 v a r   n u m C h a n g e s   =   0 ; 
 	 
 	 f o r   ( v a r   i   =   0 ;   i   <   l i n e s . l e n g t h ;   i + + )   { 
 	 	 v a r   l i n e   =   l i n e s [ i ] ; 
 	 	 v a r   p a r t s   =   l i n e . s p l i t ( " 	 " ) ; 
 	 	 
 	 	 v a r   a d d i t i o n a l s N u m   =   p a r t s [ 0 ] ; 
 	 	 v a r   d e l e t i o n s N u m   =   p a r t s [ 1 ] ; 
 	 	 
 	 	 v a r   f i l e N u m C h a n g e s   =   0 ; 
 	 	 
 	 	 i f   ( a d d i t i o n a l s N u m   ! =   " - " )   { 
 	 	 	 f i l e N u m C h a n g e s   + =   a d d i t i o n a l s N u m   *   1 ; 
 	 	 } 
 	 	 
 	 	 i f   ( d e l e t i o n s N u m   ! =   " - " )   { 
 	 	 	 f i l e N u m C h a n g e s   + =   d e l e t i o n s N u m   *   1 ; 
 	 	 } 
 	 	 
 	 	 n u m C h a n g e s   + =   f i l e N u m C h a n g e s ; 
 	 } 
 	 
 	 i f   ( n u m C h a n g e s   >   M A X _ C H A N G E S _ N U M )   { 
 	 	 a p p . d i s p l a y N o t i f i c a t i o n ( "#  B51O  C65   "   +   n u m C h a n g e s   +   "  87<5=5=89 ! \ n5  ?>@0  ;8  70?8;8BL  # ?�>� " ,   { w i t h T i t l e :   " G I T   A L A R M ! " ,   s o u n d N a m e :   " B a s s o " } ) ; 
 	 } 
 	 
 	 d e l a y ( 3 0 ) ; 
 }                              jscr  ��ޭ