kenken :-
	X = [A1, A2, A3, A4, A5, A6, A7, A8, A9, 
	B1, B2, B3, B4, B5, B6, B7, B8, B9, 
	C1, C2, C3, C4, C5, C6, C7, C8, C9,
	D1, D2, D3, D4, D5, D6, D7, D8, D9,
	E1, E2, E3, E4, E5, E6, E7, E8, E9,
	F1, F2, F3, F4, F5, F6, F7, F8, F9,
	G1, G2, G3, G4, G5, G6, G7, G8, G9,
	H1, H2, H3, H4, H5, H6, H7, H8, H9,
	I1, I2, I3, I4, I5, I6, I7, I8, I9], 
	fd_domain(X,1,9),
	%
	fd_all_different([A1, A2, A3, A4, A5, A6, A7, A8, A9]),
	fd_all_different([B1, B2, B3, B4, B5, B6, B7, B8, B9]),
	fd_all_different([C1, C2, C3, C4, C5, C6, C7, C8, C9]),
	fd_all_different([D1, D2, D3, D4, D5, D6, D7, D8, D9]),
	fd_all_different([E1, E2, E3, E4, E5, E6, E7, E8, E9]),
	fd_all_different([F1, F2, F3, F4, F5, F6, F7, F8, F9]),
	fd_all_different([G1, G2, G3, G4, G5, G6, G7, G8, G9]),
	fd_all_different([H1, H2, H3, H4, H5, H6, H7, H8, H9]),
	fd_all_different([I1, I2, I3, I4, I5, I6, I7, I8, I9]),
	%
	fd_all_different([A1, B1, C1, D1, E1, F1, G1, H1, I1]),
	fd_all_different([A2, B2, C2, D2, E2, F2, G2, H2, I2]),
	fd_all_different([A3, B3, C3, D3, E3, F3, G3, H3, I3]),
	fd_all_different([A4, B4, C4, D4, E4, F4, G4, H4, I4]),
	fd_all_different([A5, B5, C5, D5, E5, F5, G5, H5, I5]),
	fd_all_different([A6, B6, C6, D6, E6, F6, G6, H6, I6]),
	fd_all_different([A7, B7, C7, D7, E7, F7, G7, H7, I7]),
	fd_all_different([A8, B8, C8, D8, E8, F8, G8, H8, I8]),
	fd_all_different([A9, B9, C9, D9, E9, F9, G9, H9, I9]),

	% A
	region(16, [+, -, *, /], [A1, A2]), 
	region(13, [+, -, *, /], [A3, A4]), 
	region(30, [+, -, *, /], [A5, A6]), 
	region(21, [+, -, *, /], [A7, A8]), 
	region(3, [+, -, *, /], [A9, B9]),
	% B
	region(2, [+, -, *, /], [B1, C1]), 
	region(15, [+, -, *, /], [B2, B3]), 
	region(108, [+, -, *, /], [B4, B5, B6, B7, C4, D4, E4, E5, E6, E7, F7, G7, H4, H5, H6, H7]), 
	region(288, [+, -, *, /], [B8, C8, C9]),
	% C
	region(35, [+, -, *, /], [C2, C3]), 
	region(11, [+, -, *, /], [C5, D5, D6]), 
	region(7, [+, -, *, /], [C6, C7, D7]),
	% D
	region(81, [+, -, *, /], [D1, E1, E2]), 
	region(24, [+, -, *, /], [D2, D3, E3]), 
	region(35, [+, -, *, /], [D8, D9]),
	% E
	region(16, [+, -, *, /], [E8, E9, F8]),
	% F
	region(35, [+, -, *, /], [F1, G1, H1]), 
	region(7, [+, -, *, /], [F2, F3]), 
	region(12, [+, -, *, /], [F4, F5]), 
	region(30, [+, -, *, /], [F6, G5, G6]), 
	region(25, [+, -, *, /], [F9, G8, G9]),
	% G
	region(32, [+, -, *, /], [G2, H2]), 
	region(5, [+, -, *, /], [G3, G4]),
	% H
	region(28, [+, -, *, /], [H3, I3, I4]), 
	region(25, [+, -, *, /], [H8, I7, I8]), 
	region(24, [+, -, *, /], [H9, I9]),
	% I
	region(54, [+, -, *, /], [I1, I2]), 
	region(7, [+, -, *, /], [I5, I6]), 
	%
	fd_labeling(X, [variable_method(ff), value_method(random)]),
	write_matrix(X).

%
% region(+V, +OP, +CELLS)
% Define constraint on region.
%
region(V, +, X) :-
	region(V, +, X, 0), !.
region(V, *, X) :-
	region(V, *, X, 1), !.
region(V, -, [X, Y]) :-
	V #= dist(X, Y), !.
region(V, /, [X, Y]) :-
	V #= max(X, Y) / min(X, Y), !.

region(_, [], _) :- fail.
region(V, [OP|OPS], X) :-
	region(V, OP, X); region(V, OPS, X).

region(V, _, [], V) :- !.
region(V, +, [A|B], T) :-
	TA #= T + A, 
	region(V, +, B, TA).
region(V, *, [A|B], T) :-
	TA #= T * A,
	region(V, *, B, TA).

write_matrix(X) :-
	format('  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N  ~w ~w ~w ~w ~w ~w ~w ~w ~w~N', X).

run :-
	kenken.


