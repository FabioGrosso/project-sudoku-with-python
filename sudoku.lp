% Sudoku Solver
%
% Hints:
% For subgrid of size n, subgrids can be identified by labels 1..n*n
% A cell (x,y) can be mapped to the subgrid labeled 1+(((x-1)/n)*n+(y-1)/n)
% Disclosure: Consulted course material, the Potassco clingo manual,
% and a public blog (https://ddmler.github.io/asp/2018/07/06/answer-set-programming-the-basics.html,
% https://ddmler.github.io/asp/2018/07/10/answer-set-programming-sudoku-solver.html).
% Also received conceptual guidance from an AI tutor. All code written by the group.

% Implementation start

% 3*3 is 9 for a 9x9 grid
#const n=3.
row(1..n*n).
col(1..n*n).

% defining the subgrids for the 9x9 grid, n = subgrid size
subgrid(X, Y, Z) :- row(X), col(Y), Z = 1+(((X-1)/n)*n+(Y-1)/n).

sudoku(X, Y, N) :- initial(X, Y, N).
% achieved: supports partial solutions from input

{ sudoku(X, Y, 1..n*n) } = 1 :- row(X), col(Y), not initial(X, Y, _).
% achieved: selects one in 1..9 for each row/column pair (excluding starting cells)

:- { sudoku(X, Y, N) : row(X) } != 1, col(Y), N = 1..n*n.
% achieved: each column contains each value once

:- { sudoku(X, Y, N) : col(Y) } != 1, row(X), N = 1..n*n.
% achieved: each row contains each value once

:- subgrid(X, Y, Z), subgrid(A, B, Z), sudoku(X, Y, N), sudoku(A, B, N), X != A; Y != B. 
% achieved: unique numbers in each subgrid

#show sudoku/3.