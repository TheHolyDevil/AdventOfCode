#!/usr/bin/env -S swipl -f -q

:- initialization main.

main :-
  %trace,
  input_to_list(L),
  sum_lists(L,LP),
  max_n_list(LP,LPP, 3),
  sum_list(LPP,M),
  writeln(M),
  halt(0).

max_n_list(_, [], 0).
max_n_list(L, [M|LP], N) :-
  N > 0,
  NI is N - 1,
  max_list(L, M),
  select(M, L, LM), !,
  max_n_list(LM, LP, NI).

sum_lists([], []).
sum_lists([X|XS], [Y|YS]) :- sum_list(X,Y), sum_lists(XS, YS).

input_to_list(L) :-
  read_line_to_string(user_input, S),
  (
  S == "" -> (input_to_list(XS), append([[]], XS, L));
  S == end_of_file -> (L = [[]]);
  (input_to_list([X|XS]), atom_number(S, N), L = [[N|X]|XS])
  ).
