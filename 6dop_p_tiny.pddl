(define (problem six_dop_pro_tiny)
  (:domain six_dop_dom_tiny)
  (:objects
    
  )

  (:init
    (= (j2_x) 5.0) ;;L2
	(= (j2_y) 0.0)
	(= (j2_z) 6.0)
	(= (j2_angle) 0.0) ;;Angle between J2->J1 and the x axis
	(= (w2) 0.87266) ;;Angular speed (~ 50 degrees/sec)

	(= (target_x) 0.0)
	(= (target_y) 5.0)
	(= (target_z) 6.0)
	
	(= (epsilon) 1) ;;Acceptable squared error
	(no_movement)
	(not (joint_2_moving))
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
