JsOsaDAS1.001.00bplist00�Vscripto+ v a r   D e f a u l t S e t t i n g s   =   { 
         g i t F o l d e r :   " " , 
         m a x C h a n g e s :   1 0 0 0 , 
         c h e c k I n t e r v a l :   6 0 
 } 
 
 v a r   c o u n t S u b c o m a n d   =   " e g r e p   \ " \ . ( s w i f t | m | h ) $ \ "   |   a w k   ' {   s u m   + =   $ 1 ;   }   E N D   {   p r i n t   s u m ;   } '   \ " $ @ \ " " ; 
 v a r   g i t C o m m i t t e d D i f f C o m m a n d   =   " g i t   d i f f   ` g i t   m e r g e - b a s e   o r i g i n / m a s t e r   H E A D ` . . H E A D   - - n u m s t a t " ; 
 v a r   g i t N o n I n d e x D i f f C o m m a n d   =   " g i t   d i f f   - - n u m s t a t " ; 
 v a r   g i t I n d e x D i f f C o m m a n d   =   " g i t   d i f f   - - s t a g e d   - - n u m s t a t " ; 
 
 v a r   a p p   =   A p p l i c a t i o n . c u r r e n t A p p l i c a t i o n ( ) 
 a p p . i n c l u d e S t a n d a r d A d d i t i o n s   =   t r u e 
 
 v a r   s e A p p   =   A p p l i c a t i o n ( " S y s t e m   E v e n t s " ) ; 
 
 v a r   S e t t i n g s   =   D e f a u l t S e t t i n g s ; 
 
 v a r   s e t t i n g s P l i s t P a t h I n f o   =   { 
         f o l d e r :   a p p . d o S h e l l S c r i p t ( " c d   ~ ;   p w d " )   +   " / . g m c n " , 
         f i l e N a m e :   " g m c n . p l i s t " , 
         p a t h :   f u n c t i o n ( )   { 
                 r e t u r n   P a t h ( t h i s . f o l d e r   +   " / "   +   t h i s . f i l e N a m e ) 
         } 
 } 
 
 v a r   s e t t i n g s K e y s   =   { 
         g i t F o l d e r :   " g i t _ f o l d e r " , 
         m a x C h a n g e s :   " m a x _ c h a n g e s " , 
         c h e c k I n t e r v a l :   " c h e c k _ i n t e r v a l " , 
 } ; 
 
 i f   ( ! s e A p p . e x i s t s ( s e t t i n g s P l i s t P a t h I n f o . p a t h ( ) ) )   { 
         c o n s o l e . l o g ( " p l i s t   i s n ' t   e x i s t " ) ; 
         a p p . d o S h e l l S c r i p t ( " m k d i r   "   +   s e t t i n g s P l i s t P a t h I n f o . f o l d e r ) ; 
 
         v a r   g i t F o l d e r ; 
         v a r   c h e c k R e s u l t ; 
         v a r   c h o o s e F o l d e r   =   f u n c t i o n ( )   { 
                 g i t F o l d e r   =   a p p . c h o o s e F o l d e r ( { 
                         w i t h P r o m p t :   " P l e a s e   s e l e c t   a   g i t   f o l d e r : " 
                 } ) ; 
                 c h e c k R e s u l t   =   a p p . d o S h e l l S c r i p t ( " c d   "   +   g i t F o l d e r   +   " ;   g i t   s t a t u s   & >   / d e v / n u l l   & &   e c h o   1 ;   ( e x i t   0 ) " ) ; 
         } 
 
         c h o o s e F o l d e r ( ) ; 
 
         w h i l e   ( c h e c k R e s u l t   ! =   " 1 " )   { 
                 a p p . d i s p l a y A l e r t ( " S e l e c t e d   f o l d e r   i s n ' t   g i t   r e p o s i t o r y ! " ) ; 
                 c h o o s e F o l d e r ( ) ; 
         } 
 
         v a r   i t e m 1   =   { } 
         i t e m 1 [ s e t t i n g s K e y s . g i t F o l d e r ]   =   g i t F o l d e r . t o S t r i n g ( ) ; 
         i t e m 1 [ s e t t i n g s K e y s . m a x C h a n g e s ]   =   S e t t i n g s . m a x C h a n g e s ; 
         i t e m 1 [ s e t t i n g s K e y s . c h e c k I n t e r v a l ]   =   S e t t i n g s . c h e c k I n t e r v a l ; 
 
         v a r   p l i s t   =   $ . N S D i c t i o n a r y . d i c t i o n a r y W i t h D i c t i o n a r y ( i t e m 1 ) ; 
         p l i s t . w r i t e T o F i l e A t o m i c a l l y ( s e t t i n g s P l i s t P a t h I n f o . p a t h ( ) . t o S t r i n g ( ) ,   t r u e ) ; 
 } 
 
 v a r   c o n t e n t   =   $ . N S D i c t i o n a r y . d i c t i o n a r y W i t h C o n t e n t s O f F i l e ( s e t t i n g s P l i s t P a t h I n f o . p a t h ( ) . t o S t r i n g ( ) ) ; 
 v a r   p l i s t D i c t   =   O b j C . d e e p U n w r a p ( c o n t e n t ) ; 
 S e t t i n g s . g i t F o l d e r   =   p l i s t D i c t [ s e t t i n g s K e y s . g i t F o l d e r ] ; 
 S e t t i n g s . m a x C h a n g e s   =   p l i s t D i c t [ s e t t i n g s K e y s . m a x C h a n g e s ] ; 
 S e t t i n g s . c h e c k I n t e r v a l   =   p l i s t D i c t [ s e t t i n g s K e y s . c h e c k I n t e r v a l ] ; 
 
 v a r   l a s t C h a n g e s N u m b e r   =   0 ; 
 
 s h o w L a u n c h N o t i f i c a t i o n ( ) ; 
 
 w h i l e   ( t r u e )   { 
         c o n s o l e . l o g ( " c h e c k . . .   l a s t C h a n g e s N u m b e r   =   "   +   l a s t C h a n g e s N u m b e r ) ; 
         v a r   n u m C h a n g e s   =   g e t C o m m i t t e d D i f f C o u n t ( )   +   g e t N o n I n d e x D i f f C o u n t ( )   +   g e t I n d e x D i f f C o u n t ( ) ; 
 
         i f   ( n u m C h a n g e s   >   S e t t i n g s . m a x C h a n g e s   & &   n u m C h a n g e s   >   l a s t C h a n g e s N u m b e r )   { 
                 s h o w N o t i f i c a t i o n ( n u m C h a n g e s ) ; 
         } 
 
         l a s t C h a n g e s N u m b e r   =   n u m C h a n g e s ; 
 
         d e l a y ( S e t t i n g s . c h e c k I n t e r v a l ) ; 
 } 
 
 f u n c t i o n   s h o w L a u n c h N o t i f i c a t i o n ( )   { 
         a p p . d i s p l a y N o t i f i c a t i o n ( " g i t   f o l d e r :   "   +   S e t t i n g s . g i t F o l d e r   +   " ,   c h e c k   i n t e r v a l :   "   +   S e t t i n g s . c h e c k I n t e r v a l   +   "   s ,   m a x   c h a n g e s :   "   +   S e t t i n g s . m a x C h a n g e s ,   { w i t h T i t l e :   " G M C N   s t a r t e d ! " ,   s o u n d N a m e :   " B a s s o " } ) ; 
 } 
 
 f u n c t i o n   s h o w N o t i f i c a t i o n ( n u m C h a n g e s )   { 
         a p p . d i s p l a y N o t i f i c a t i o n ( "#  B51O  C65   "   +   n u m C h a n g e s   +   "  87<5=5=89 ! \ n5  ?>@0  ;8  70?8;8BL  # ?�>� " ,   { w i t h T i t l e :   " G I T   A L A R M ! " ,   s o u n d N a m e :   " B a s s o " } ) ; 
 } 
 
 f u n c t i o n   e x e c C o m m a n d I n D i r ( d i r ,   c o m m a n d )   { 
         v a r   f u l l C o m m a n d   =   " c d   "   +   S e t t i n g s . g i t F o l d e r   +   " ; "   +   c o m m a n d ; 
         c o n s o l e . l o g ( f u l l C o m m a n d ) ; 
         v a r   r e s u l t   =   a p p . d o S h e l l S c r i p t ( f u l l C o m m a n d ) ; 
         c o n s o l e . l o g ( r e s u l t ) ; 
 
         r e t u r n   r e s u l t ; 
 } 
 
 f u n c t i o n   g e t C o m m i t t e d D i f f C o u n t ( d i r )   { 
         r e t u r n   e x e c C o m m a n d I n D i r ( d i r ,   g i t C o m m i t t e d D i f f C o m m a n d   +   "   |   "   +   c o u n t S u b c o m a n d )   *   1 ; 
 } 
 
 f u n c t i o n   g e t N o n I n d e x D i f f C o u n t ( d i r )   { 
         r e t u r n   e x e c C o m m a n d I n D i r ( d i r ,   g i t N o n I n d e x D i f f C o m m a n d   +   "   |   "   +   c o u n t S u b c o m a n d )   *   1 ;       
 } 
 
 f u n c t i o n   g e t I n d e x D i f f C o u n t ( d i r )   { 
         r e t u r n   e x e c C o m m a n d I n D i r ( d i r ,   g i t I n d e x D i f f C o m m a n d   +   "   |   "   +   c o u n t S u b c o m a n d )   *   1 ; 
 }                              ljscr  ��ޭ