function [ model ] = l o g i s t i c L 2 (X, y , lambda )
% Add b i a s v a r i a b l e
[ n , d ] = s i z e (X ) ;
X = [ one s ( n , 1 ) X ] ;
d = d+1;
% I n i t i a l v a l u e s o f r e g r e s s i o n p ar ame ter s
w = zeros ( d , 1 ) ;
% O p t im i z a i on p ar ame ter s
maxPasses = 5 0 0;
progTol = 1e −4;
L = . 2 5 ∗sum(X. ˆ 2 ) + lambda ;
w old = w;
Xw = zeros ( n , 1 ) ;
for i = 1 : maxPasses ∗d
% Choose v a r i a b l e t o u p d a te ’ j ’
j = s am pl eDi s c r e t e (L/sum(L ) ) ;
% Compute p a r t i a l d e r i v a t i v e ’ g j ’
si gm oid = 1./(1+exp(−y . ∗Xw) ) ;
7
g j = −X( : , j ) ’ ∗ ( y.∗(1 − si gm oid ) ) + lambda∗w( j ) ;
% Update v a r i a b l e
w j ol d = w( j ) ;
w( j ) = w( j ) − ( 1 /L( j ) ) ∗ g j ;
Xw = Xw + X( : , j ) ∗ (w( j )−w j ol d ) ;
% Check f o r l a c k o f p r o g r e s s a f t e r each ” p a s s ”
i f mod( i , d ) == 0
change = norm(w−w old , i n f ) ;
fp r in t f ( ’ P a s s e s = %d , f u n c ti o n = %.3e , change = %.3 f \n ’ , i /d , l o g i s t i c L 2 l o s s (w,X, y , lambda ) , change ) ;
i f change < progTol
fp r in t f ( ’ Parameters changed by l e s s than progTol on p a s s \n ’ ) ;
break ;
end
w old = w;
end
end
model .w = w;
model . p r e d i c t = @p redic t ;
end
function [ yhat ] = p r e d i c t ( model , Xhat )
[ t , d ] = s i z e ( Xhat ) ;
Xhat = [ one s ( t , 1 ) Xhat ] ;
w = model .w;
yhat = s ign ( Xhat∗w ) ;
end
