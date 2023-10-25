(define (problem six_dop_pro_v0_3)
  (:domain six_dop_dom_v0_3)
  (:objects
    
  )

  (:init
	;;J2 variables
    (= (j2_x) 5.0) ;;L2
	(= (j2_y) 0.0)
	(= (j2_z) 3.0)
	(= (j2_angle) 0.0) ;;Angle between J2->J1 and the x axis
	(= (l2) 5.0)

	;;J3 variables
    (= (j3_x) 5.0) ;;L3
	(= (j3_y) 0.0)
	(= (j3_z) 8.0)
	(= (j3_angle) 0.0) ;;Angle between J3->J2 and the z axis
	(= (l3) 5.0)

	;;Target
	(= (target_x) 0.0)
	(= (target_y) 5.0)
	(= (target_z) 8.0)

	;;Head is modelled as a sphere
	(= (sphere_center_x) 4.0)
	(= (sphere_center_y) 4.0)
	(= (sphere_center_z) 3.0)
	(= (squared_sphere_radius) 9.0) ;;r², avoids needing to calculate the square of the radius for every collision check
	
	;;Global goal conditions
	(= (w) 0.0174533) ;;Angular speed of joints: 1 degree/sec
	(= (epsilon) 0.00) ;;Acceptable squared error
	(no_movement)
  )

  (:goal
    (and 
		(<= 
			(^ (- j3_x target_x) 2)
			(epsilon)
		)
		(<= 
			(^ (- j3_y target_y) 2)
			(epsilon)
		)
		(<= 
			(^ (- j3_z target_z) 2)
			(epsilon)
		)
		(no_movement)
		(not (head_hit))
	)
	;(and (head_hit))
  )
)
