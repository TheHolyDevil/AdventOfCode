Require Import Nat.
Require Import Coq.Arith.Arith.
Require Import Coq.Lists.List.
Require Import Ascii.
Require Import Coq.Strings.String.

Definition intersection (l1 l2 : list nat) : list nat :=
  List.filter (fun n => List.existsb (Nat.eqb n) l2) l1.

(* first we need to find all newlines *)

Fixpoint list_idx_occ_help (l : list nat) (a : nat) (i : nat) : list nat :=
  match l with
  | nil => nil
  | x :: xs => if a =? x then i :: list_idx_occ_help xs a (S i) else list_idx_occ_help xs a (S i)
  end.

Definition list_idx_occ (l : list nat) (a : nat) : list nat :=
  list_idx_occ_help l a 0.


Fixpoint list_sub_help (s : string) (i : list nat) (last : nat) : list string :=
  match i with
  | nil => nil
  | idx :: is => substring last (idx - last) s :: list_sub_help s is (S idx)
  end.

Definition list_sub (s : string) (i : list nat) : list string :=
  list_sub_help s i 0.


(* show that our input is even so we can div it by two *)
(*Example input_is_div_by_2 : even (length input) = true.
Proof.
  simpl.
  apply eq_refl.
Qed.*)

Definition inp_middle (input : string) : nat := (length input) / 2.

Definition inp_left (input : string) : list nat := map nat_of_ascii (
  list_ascii_of_string (substring 0 (inp_middle input) input)
).
Definition inp_right (input : string) : list nat := map nat_of_ascii (
  list_ascii_of_string (substring (inp_middle input) (inp_middle input) input)
).

Definition inp_intersect (input : string) : list nat :=
  intersection (inp_left input) (inp_right input).

Definition map_to_result (a : nat) : nat :=
  if a <=? 90 then
    (a - 64) + 26
  else
    a - 96.


Example example_input : string := "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
".

Example real_input : string :=
"your input here! (newline at the end is important to get the last substring)
".

Definition input := real_input.

(* divide by lines *)
Definition inp_list := map nat_of_ascii (list_ascii_of_string input).
Definition list_idx := list_idx_occ inp_list 10.
Definition input_divided := list_sub input list_idx.

(* now we have a list of every input *)

Fixpoint groups_of_three (l : list string) : list (list string) :=
  match l with
  | nil => nil
  | _ :: nil => nil
  | _ :: _ :: nil => nil
  | a :: b :: c :: ls => (a :: b :: c :: nil) :: groups_of_three ls
  end.

Fixpoint group_intersect (l : list (list nat)) : list nat :=
  match l with
  | nil => nil
  | x :: nil => x
  | x :: xs => intersection x (group_intersect (xs))
end.

Definition inp_grouped :=  map (map (map nat_of_ascii)) (
  map (map list_ascii_of_string) (groups_of_three input_divided)
).

Definition inp_mapped := map (fun a => map_to_result (hd 0 a)) (map group_intersect inp_grouped).
Compute fold_right add 0 inp_mapped.




