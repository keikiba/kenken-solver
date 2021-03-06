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

	%A
	region(4, /, [A1, B1]),
	region(1, -, [A2, B2]),
	region(105, *, [A3, B3, B4]),
	region(3, /, [A4, A5]),
	region(3, +, [A6, A7]),
	region(2, -, [A8, A9]),
	%B
	region(2016, *, [B5, B6, C5, C6]),
	region(8, -, [B7, B8]),
	region(3, -, [B9, C9]),
	%C
	region(7, +, [C1, D1]),
	region(4, /, [C2, D2]),
	region(13, +, [C3, C4]),
	region(84, *, [C7, C8, D8]),
	%D
	region(8, -, [D3, D4]),
	region(11, +, [D5, D6]),
	region(23, +, [D7, E7, F7, F8]),
	region(21, +, [D9, E8, E9]),
	%E
	region(8, -, [E1, E2]),
	region(9, +, [E3, E4]),
	region(15, *, [E5, E6]),
	%F
	region(2, -, [F1, G1]),
	region(7, +, [F2, G2]),
	region(2, -, [F3, F4]),
	region(1, -, [F5, F6]),
	region(135, *, [F9, G9, H9]),
	%G
	region(2, /, [G3, G4]),
	region(42, *, [G5, G6, H5]),
	region(3, -, [G7, G8]),
	%H
	region(5, -, [H1, I1]),
	region(2, -, [H2, I2]),
	region(12, *, [H3, H4, I3]),
	region(360, *, [H6, I6, I7]),
	region(1, -, [H7, H8]),
	%I
	region(10, +, [I4, I5]),
	region(4, /, [I8, I9]),
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


