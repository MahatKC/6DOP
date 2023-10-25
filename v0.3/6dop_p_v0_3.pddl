(define (problem six_dop_pro_v0_3)
  (:domain six_dop_dom_v0_3)
  (:objects
    
  )

  (:init
    (= (j2_x) 5.0) ;;L2
	(= (j2_y) 0.0)
	(= (j2_z) 3.0)
	(= (j2_angle) 0.0) ;;Angle between J2->J1 and the x axis
	(= (l2) 5.0)
	(= (w2) 0.0174533) ;;Angular speed (1 degree/sec)

	(= (target_x) 0.0)
	(= (target_y) 5.0)
	(= (target_z) 3.0)

	(= (sphere_center_x) 4.0)
	(= (sphere_center_y) 4.0)
	(= (sphere_center_z) 3.0)
	(= (squared_sphere_radius) 9.0) ;;r², avoids needing to calculate the square of the radius for every collision check
	
	(= (epsilon) 0.00) ;;Acceptable squared error
	(no_movement)
  )

  (:goal
    (and 
		(<= 
			(^ (- j2_x target_x) 2)
			(epsilon)
		)
		(<= 
			(^ (- j2_y target_y) 2)
			(epsilon)
		)
		(<= 
			(^ (- j2_z target_z) 2)
			(epsilon)
		)
		(no_movement)
		(not (head_hit))
	)
	;(and (head_hit))
  )
)
