(define (problem six_dop_pro_v0_6)
  (:domain six_dop_dom_v0_6)
  (:objects
    
  )

  (:init
    ;Metric variable (not currently being used)
    (= (total_time) 0.0)

	;;J1 constants
    (= (j1_x) 0.0) 
	(= (j1_y) 0.0)
	(= (j1_z) 131.56)
	(= (l1) 131.56)

	;;J2 variables
    (= (j2_x) 64.61) 
	(= (j2_y) 0)
	(= (j2_z) 131.56)
	(= (j2_angle) 0.0) ;;Angle between J2->J1 and the x axis
	(= (l2) 64.610)

	;;J3 variables
    (= (j3_x) 64.61) 
	(= (j3_y) 0)
	(= (j3_z) 241.96)
	(= (j3_angle) 0.0) ;;Angle between J3->J2 and the z axis
	(= (l3) 110.4)

	;;J4 variables
    (= (j4_x) 0.0) ;;L4
	(= (j4_y) 0.0)
	(= (j4_z) 241.96)
	(= (l4) 64.610)

	;;J5 variables
    (= (j5_x) 0.0) 
	(= (j5_y) 0.0)
	(= (j5_z) 352.36)
	(= (j5_angle) 0.0) ;;Angle between J5->J4 and J3->J2
	(= (l5) 110.4)

	;;J6 variables
    (= (j6_x) 64.61) 
	(= (j6_y) 0)
	(= (j6_z) 352.36)
	(= (l6) 64.61)

	;;J7 variables
    (= (j7_x) 64.61) 
	(= (j7_y) 0)
	(= (j7_z) 462.76)
	(= (j7_angle) 0.0) ;;Angle between J7->J6 and J5->J4
	(= (l7) 110.4)

	;;J8 variables
    (= (j8_x) 84.61) 
	(= (j8_y) 0)
	(= (j8_z) 462.76)
	(= (j8_angle) 3.14159265) ;;Angle between J8->J7 and the axis that's perpendicular to J7->J6 and parallel to J6->J5
	(= (l8) 20)

	;;J9 variables
    (= (j9_x) 84.61) 
	(= (j9_y) 0)
	(= (j9_z) 492.76)
	(= (j9_angle) 0.0) ;;Angle between J9->J8 and J7->J6
	(= (l9) 30)

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
	(= (lambda) 1) ;;Acceptable squared error, can be increased
	(= (epsilon) 0.000001) ;;Very small value to be used instead of 0
	(no_movement)
	(= (updating_positions) 0)

	;;Sums of lengths to speed up computations
	(= (l3_l5) 220.8)
	(= (l3_l5_l7) 331.2)
	(= (l3_l5_l7_l9) 361.2)
	(= (l5_l7) 220.8)
	(= (l5_l7_l9) 250.8)
	(= (l7_l9) 140.4)
  )

  (:goal
	; (and 
	; 	;Desired joint must be close to target (closeness determined by lambda)
	; 	(<= 
	; 		(+ (^ (- j9_x target_x) 2)
	; 		   (+ (^ (- j9_y target_y) 2)
	; 		      (^ (- j9_z target_z) 2)
	; 		   )
	; 		)
	; 		(lambda)
	; 	)
	; 	;No movement must be happening (stop action must have been called)
	; 	(no_movement)
	; 	;No collision has happened
	; 	(not (head_hit))
	; 	(not (floor_hit))
	; )

    ;####### Auxiliary goals to test different behaviors #######
	;##### Change goal to specific joint angles
	(and 
		(<= (j2_angle) 1.571)
		(>= (j2_angle) 1.570) 
		(<= (j3_angle) -0.261)
		(>= (j3_angle) -0.262)
		(<= (j5_angle) 0.001)
		(>= (j5_angle) 0.000)
		(<= (j7_angle) 0.524)
		(>= (j7_angle) 0.523)
		(<= (j8_angle) 0.001)
		(>= (j8_angle) 0.000)
		(<= (j9_angle) 1.571)
		(>= (j9_angle) 1.570) 
		;(>= (j7_angle) 0.0872664625997) ;-45 degrees (-90 + 15 + 30)
		(no_movement)
	)

	;##### Change goal so that the obstacle is hit
	; (and (head_hit)(no_movement))

	; (and (<= j6_x epsilon)
	; 	(<= j2_x epsilon)
	; 	(<= j3_x epsilon)
	; 	(<= j7_x epsilon)
	; 	(<= j8_x epsilon)
	; 	(<= j9_x epsilon)
	; 	(no_movement)
	; )
  )

  ;Set a metric (hasn't had any effect yet, might have an effect in the future)
  ;(:metric minimize (total_time))
)
