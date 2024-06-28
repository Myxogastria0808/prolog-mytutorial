%足し算
% x + y = y (x=0のとき)
% s(x1) + y = s(x1 + y) (x=s(x1)のとき)
plus(0, Y, Y).
plus(s(X), Y, s(Z)) :- plus(X, Y, Z).

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
divided(X, Y, s(Q), R) :- plus(W, Y, X), divided(W, Y, Q, R).

neq_zero(0) :- !, false.
neq_zero(_).

% %M / N -> M / (N-1) -> ... -> M / 2
check_mod(M, s(s(0))).
check_mod(M, s(N)) :- divided(M, N, _, R), neq_zero(R), check_mod(M, N).

% %素数判定
prime(X) :- check_mod(X, X).
