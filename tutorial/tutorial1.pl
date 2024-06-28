%参考サイト: https://tamura70.gitlab.io/web-prolog/intro/nat.html

%自然数
natural(0).
natural(s(X)) :- natural(X).

%足し算
% x + y = y (x=0のとき)
% s(x1) + y = s(x1 + y) (x=s(x1)のとき)
plus(0, Y, Y).
plus(s(X), Y, s(Z)) :- plus(X, Y, Z).

%掛け算
%x * y = 0 (x=0のとき)
%s(x1) * y = x1 * y + y
%Z = (x1 * y) (=W) + y
times(0, Y, 0).
times(s(X), Y, Z) :- times(X, Y, W), plus(W, Y, Z).

%割り算
%divided(X, Y, Q, R)
%商 ... Q
%余り ... R
% X = Y * Q + R
%再帰の具体例1
%6 / 2 = 3 ... 0
%4 / 2 = 2 ... 0
%2 / 2 = 1 ... 0
%0 / 2 = 0 ... 0
%再帰の具体例2
%3 / 2 = 1 ... 1
%1 / 2 = 0 ... 1
divided(X, X, s(0), 0).
divided(X, Y, 0, X) :- plus(s(W), X, Y).
%Qが1減少すると、XがYだけ減少する
%XがYずつ減少 = plus(W, Y, X)　(正し、W = X - Y)
divided(X, Y, s(Q), R) :- divided(W, Y, Q, R), plus(W, Y, X).

%XのY乗がZになる
%x^y = 1 (y=0のとき)
%x^s(y1) = x^y1 * x
%Z = x^y1 (=W) * x
squared(X, 0, s(0)).
squared(X, s(Y), Z) :- squared(X, Y, W), times(X, W, Z).

%XとYの最大公約数がZになる
%再帰の具体例1
%8177(=A) / 3315(=B) = 2(=Q) ... 1547(=R)
%3315(=B) / 1547(=R) = 2 ... 221
%1547 / 221 = 7 ... 0
%再帰の具体例2
%1547(=A) / 221(=B) = 7(=Q) ... 0(=R)
%211(=B) / 0(=R) -> gcd=211(=G).
gcd(A, 0, A).
gcd(A, B, G) :- divided(A, B, Q, R), gcd(B, R, G).

%XとYの最小公倍数がZになる
lcm(A, B, L) :- gcd(A, B, G), divided(A, G, AQ, AR), divided(B, G, BQ, BR), times(AQ, BQ, W), times(W, G, L).
