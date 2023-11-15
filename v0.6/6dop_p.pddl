(define (problem six_dop_pro_v0_4)
  (:domain six_dop_dom_v0_4)
  (:objects
    
  )

  (:init
    ;Metric variable (not currently being used)
    (= (total_time) 0.0)

	;;J1 constants
    (= (j1_x) 0.0) 
	(= (j1_y) 0.0)
	(= (j1_z) 131.56) ;;L1
	(= (j1_angle) 0.0) ;;Angle between J2->J1 and the x axis
	(= (l1) 131.56)

	;;J2 variables
    (= (j2_x) 0.0) ;;L2
	(= (j2_y) -64.610)
	(= (j2_z) 131.56)
	(= (j2_angle) 0.0) ;;Angle between J2->J1 and the x axis
	(= (l2) 64.610)

	;;J3 variables
    (= (j3_x) 0) ;;L3
	(= (j3_y) -64.610)
	(= (j3_z) 241.96)
	(= (j3_angle) 0.0) ;;Angle between J3->J2 and the z axis
	(= (l3) 110.4)

	;;J4 variables
    (= (j4_x) 0.0) ;;L4 = 5
	(= (j4_y) 0.0)
	(= (j4_z) 241.96)
	(= (j4_angle) 0.0) ;;Angle between J4->J3 and the z axis
	(= (l4) 64.610)

	;;Target
	(= (target_x) 128)
	(= (target_y) 71)
	(= (target_z) 155)

	;;Head is modelled as a sphere
	(= (sphere_center_x) 261.0)
	(= (sphere_center_y) 22.0)
	(= (sphere_center_z) 105.0)
	(= (squared_sphere_radius) 22500.0) ;;r², avoids needing to calculate the square of the radius for every collision check
	
	;;Global goal conditions
	(= (w) 0.0174533) ;;Angular speed of joints in radians, 0.0174533 = 1 degree/sec. This value makes it easy to interpret performed actions
	(= (epsilon) 1600) ;;Acceptable squared error, can be increased
	(no_movement)
  )

  (:goal
	(and 
		;Desired joint must be close to target (closeness determined by epsilon)
		(<= 
			(+ (^ (- j4_x target_x) 2)
			   (+ (^ (- j4_y target_y) 2)
			      (^ (- j4_z target_z) 2)
			   )
			)
			(epsilon)
		)
		;No movement must be happening (stop action must have been called)
		(no_movement)
		;No collision has happened
		(not (head_hit))
		(not (floor_hit))
	)

    ;####### Auxiliary goals to test different behaviors #######
	;##### Change goal to specific joint angles
	; (and 
	; 	(>= (j2_angle) 1.5707969851791859) ;90 degrees
	; 	(<= (j3_angle) -1.5707969851791859) ;-90 degrees
	; 	(no_movement))

	;##### Change goal so that the obstacle is hit
	;(and (head_hit))
  )

  ;Set a metric (hasn't had any effect yet, might have an effect in the future)
  ;(:metric minimize (total_time))
)
