; read input to x and convert to list
(setq a (coerce (read-line) 'list))
; generate all 4 char offset substrings
(setq sub0 (subseq a 0))
(setq sub1 (subseq a 1))
(setq sub2 (subseq a 2))
(setq sub3 (subseq a 3))
(setq sub4 (subseq a 4))
(setq sub5 (subseq a 5))
(setq sub6 (subseq a 6))
(setq sub7 (subseq a 7))
(setq sub8 (subseq a 8))
(setq sub9 (subseq a 9))
(setq sub10 (subseq a 10))
(setq sub11 (subseq a 11))
(setq sub12 (subseq a 12))
(setq sub13 (subseq a 13))
; and map to sets
(setq mapped
	  (mapcar #'(lambda( a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13)
				  (adjoin a0 (adjoin a1 (adjoin a2 (adjoin a3
				  (adjoin a4 (adjoin a5 (adjoin a6 (adjoin a7
				  (adjoin a8 (adjoin a9 (adjoin a10 (adjoin a11
				  (adjoin a12 (adjoin a13 nil))))))))))))))
				  )
			  sub0 sub1 sub2 sub3 sub4 sub5 sub6 sub7 sub8 sub9 sub10 sub11
			  sub12 sub13))
; evaluate how many elements are in each set
(setq len_mapped (mapcar #'length mapped))
(setq c 0)
; find first subset with size 4
; and write that
(write (loop
   (when (= (nth c len_mapped) 14) (return (+ c 14)))
   (setq c (+ c 1))
))
(terpri)
