; read input to x and convert to list
(setq a (coerce (read-line) 'list))
; generate all 4 char offset substrings
(setq sub1 (subseq a 1))
(setq sub2 (subseq a 2))
(setq sub3 (subseq a 3))
; and map to sets
(setq mapped (mapcar #'(lambda(w x y z)(adjoin z (adjoin y (adjoin x (adjoin w nil))))) a sub1 sub2 sub3))
; evaluate how many elements are in each set
(setq len_mapped (mapcar #'length mapped))
(setq c 0)
; find first subset with size 4
; and write that
(write (loop
   (when (= (nth c len_mapped) 4) (return (+ c 4)))
   (setq c (+ c 1))
))
(terpri)
