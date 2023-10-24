(define (problem six_dop_prob)
  (:domain six_dop_dom)
  (:objects
    
  )

  (:init
    (= (mov_x) 0.0)
	(= (mov_y) 0.0)
	(= (mov_z) 0.0)

    (= (j0_x) 0.0)
	(= (j0_y) 0.0)
	(= (j0_z) 0.0)

    (= (j1_x) 0.0)
	(= (j1_y) 0.0)
	(= (j1_z) 6.0) ;;L1
	(= (l1) 6.0)

    (= (j2_x) 5.0) ;;L2
	(= (j2_y) 0.0)
	(= (j2_z) 6.0)
	(= (l2) 5.0)
	(= (j2_angle) 0.0) ;;Angle between J2->J1 and the x axis
	(= (w2) 0.87266) ;;Angular speed (~ 50 degrees/sec)

	(= (cube_center_x) 4.1)
	(= (cube_center_y) 5.0)
	(= (cube_center_z) 4.0)
	(= (cube_half_dim) 4.0) ;;size of cube = 8.0

	(= (target_x) 0.0)
	(= (target_y) 5.0)
	(= (target_z) 6.0)
	
	(no_movement)
	(= (epsilon) 0.01) ;;acceptable  squared error
	(not (head_hit))
	(not (joint_2_moving_clockwise))
	(not (joint_2_moving_counterclockwise))
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
		(not (head_hit))
	)
  )
)
