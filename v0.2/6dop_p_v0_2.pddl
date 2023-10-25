(define (problem six_dop_pro_v0_2)
  (:domain six_dop_dom_v0_2)
  (:objects
    
  )

  (:init
    (= (j2_x) 5.0) ;;L2
	(= (j2_y) 0.0)
	(= (j2_z) 6.0)
	(= (j2_angle) 0.0) ;;Angle between J2->J1 and the x axis
	(= (l2) 5.0)
	(= (w2) 0.0174533) ;;Angular speed (1 degree/sec)

	(= (target_x) 0.0)
	(= (target_y) 5.0)
	(= (target_z) 6.0)
	
	(= (epsilon) 0.00) ;;Acceptable squared error
	(no_movement)
  )

  (:goal
    (and 
		(<= 
			(* (- j2_x target_x)(- j2_x target_x))
			(epsilon)
		)
		(<= 
			(* (- j2_y target_y)(- j2_y target_y))
			(epsilon)
		)
		(<= 
			(* (- j2_z target_z)(- j2_z target_z))
			(epsilon)
		)
		(no_movement)
	)
  )
)
