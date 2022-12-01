#!/usr/bin/env -S swipl -f -q

:- initialization main.

main :-
  %trace,
  input_to_list(L),
  sum_lists(L,LP),
  max_list(LP,M),
  writeln(M),
  halt(0).

sum_lists([], []).
sum_lists([X|XS], [Y|YS]) :- sum_list(X,Y), sum_lists(XS, YS).

input_to_list(L) :-
  read_line_to_string(user_input, S),
  (
  S == "" -> (input_to_list(XS), append([[]], XS, L));
  S == end_of_file -> (L = [[]]);
  (input_to_list([X|XS]), atom_number(S, N), L = [[N|X]|XS])
  ).
