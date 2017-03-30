% Cle a r v a r i a b l e s and c l o s e f i g u r e s
c lear a l l
c lose a l l
5
% Load d a t a
load nonLinea r . mat % Loads {X, y , X te s t , y t e s t }
[ n , d ] = s i z e (X ) ;
[ t , ˜ ] = s i z e ( X te s t ) ;
% Find b e s t v a l u e o f RBF k e r n e l parame ter ,
% t r a i n i n g on 9/10 o f t h e t r a i n s e t and v a l i d a t i n g on t h e rema in ing
minErr = i n f ;
n S p l i t s = 5 ;
for sigma = 2. ˆ[ −1 5: 1 5]
for lambda = 2. ˆ[ −1 5: 1 5]
v ali d E r r o r = 0 ;
for s p l i t = 1 : n S p l i t s
% Get t h e t r a i n i n g s e t and t e s t s e t i n d i c e s
t e s t S t a r t = 1 + ( n/ n S p l i t s ) ∗ ( s p l i t −1);
te s tEnd = ( n/ n S p l i t s )∗ s p l i t ;
trainNdx = [ 1 : t e s t S t a r t −1 te s tEnd +1:n ] ;
testNdx = t e s t S t a r t : te s tEnd ;
% Tra in on t h e t r a i n i n g s e t
model = leastSquaresRBFL2 (X( trainNdx , : ) , y ( trainNdx ) , lambda , sigma ) ;
% Compute t h e e r r o r on t h e v a l i d a t i o n s e t
yhat = model . p r e d i c t ( model ,X( testNdx ) ) ;
v ali d E r r o r = v ali d E r r o r + sum( ( yhat − y ( testNdx ) ) . ˆ 2 ) / ( n/ n S p l i t s ) ;
end
fp r in t f ( ’ E r r o r with lambda = %.3e , sigma = %.3 e = %.2 f \n ’ , lambda , sigma , v ali d E r r o r ) ;
% Keep t r a c k o f t h e l o w e s t v a l i d a t i o n e r r o r
i f v ali d E r r o r < minErr
minErr = v ali d E r r o r ;
bestLambda = lambda ;
bestSigma = sigma ;
end
end
end
fp r in t f ( ’ Value o f lambda and sigma t h a t a c hi e v e d the l o w e s t v a l i d a t i o n e r r o r were %.3 e and %.3 e \n ’ , bestLambda , bestSigma ) ;
% Tra in l e a s t s q u a r e s model on t r a i n i n g d a t a
model = leastSquaresRBFL2 (X, y , bestLambda , bestSigma ) ;
% Tes t l e a s t s q u a r e s model on t e s t d a t a
yhat = model . p r e d i c t ( model , X te s t ) ;
% Repor t t e s t e r r o r
s q u a r e dT e s tE r r o r = sum( ( yhat−y t e s t ) . ˆ 2 ) / t
% Pl o t model
6
f igure ( 1 ) ;
p lot (X, y , ’ b . ’ ) ;
hold on
p lot ( Xtest , y t e s t , ’ g . ’ ) ;
Xhat = [min(X ) : . 1 :max(X ) ] ’ ; % Choose p o i n t s t o e v a l u a t e t h e f u n c t i o n
yhat = model . p r e d i c t ( model , Xhat ) ;
p lot ( Xhat , yhat , ’ r ’ ) ;
ylim ([ −300 4 0 0 ] ) ;
pr int −dpng n onLine a r 2 . png