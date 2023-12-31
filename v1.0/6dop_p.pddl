(define (problem six_dop_pro_v0_6)
  (:domain six_dop_dom_v0_6)
  (:objects
    
  )

  (:init
	;;J1 constants
    (= (j1_x) 0.0) 
	(= (j1_y) 0.0)
	(= (j1_z) 131.56)
	(= (l1) 131.56)

	;;J2 variables
    (= (j2_x) 64.61) 
	(= (j2_y) 0)
	(= (j2_z) 131.56)
	(= (j2_angle) 0.0)
	(= (l2) 64.610)

	;;J3 variables
    (= (j3_x) 64.61) 
	(= (j3_y) 0)
	(= (j3_z) 241.96)
	(= (j3_angle) 0.0)
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
	(= (j5_angle) 0.0)
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
	(= (j7_angle) 0.0) 
	(= (l7) 110.4)

	;;J8 variables
    (= (j8_x) 84.61) 
	(= (j8_y) 0)
	(= (j8_z) 462.76)
	(= (j8_angle) 3.14159265) 
	(= (l8) 20)

	;;J9 variables
    (= (j9_x) 84.61) 
	(= (j9_y) 0)
	(= (j9_z) 492.76)
	(= (j9_angle) 0.0)
	(= (l9) 30)

	;;Target
	;; 2 movements
	; (= (target_x) -93.49)
	; (= (target_y) 84.61)
	; (= (target_z) 480.45)
	;;all movements
	(= (target_x) 59.53)
	(= (target_y) 39.79)
	(= (target_z) 455.2)

	;;Head is modelled as a sphere
	(= (sphere_center_x) 261.0)
	(= (sphere_center_y) 22.0)
	(= (sphere_center_z) 105.0)
	(= (squared_sphere_radius) 22500.0) ;;r², avoids needing to calculate the square of the radius for every collision check
	
	;;Global goal conditions
	(= (w) 0.0174533) ;;Angular speed of joints in radians, 0.0174533 = 1 degree/sec. This value makes it easy to interpret performed actions
	(= (lambda) 625) ;;Acceptable squared error, can be increased
	(no_movement)
	(= (updating_positions) 0)
	(= (squared_joint_radius) 4)

	;;Sums of lengths to speed up computations
	(= (l3_l5) 220.8)
	(= (l3_l5_l7) 331.2)
	(= (l3_l5_l7_l9) 361.2)
	(= (l5_l7) 220.8)
	(= (l5_l7_l9) 250.8)
	(= (l7_l9) 140.4)
  )

  (:goal
	(and 
		;Desired joint must be close to target (closeness determined by lambda)
		(<= 
			(+ (^ (- j9_x target_x) 2)
			   (+ (^ (- j9_y target_y) 2)
			      (^ (- j9_z target_z) 2)
			   )
			)
			(lambda)
		)
		;No movement must be happening (stop action must have been called)
		(no_movement)
		;No collision has happened
		(not (head_hit))
		(not (floor_hit))
		(not (joint_hit))
	)

    ;####### Auxiliary goals to test different behaviors #######

	;##### Change goal to specific joint angles
	;Inequalities are used to assist the planner
	; (and 
	; 	(<= (j2_angle) 1.571)
	; 	(>= (j2_angle) 1.570) 
	; 	(<= (j3_angle) -0.261)
	; 	(>= (j3_angle) -0.262)
	; 	(<= (j5_angle) 0.001)
	; 	(>= (j5_angle) 0.000)
	; 	(<= (j7_angle) 0.524)
	; 	(>= (j7_angle) 0.523)
	; 	(<= (j8_angle) 0.524)
	; 	(>= (j8_angle) 0.523)
	; 	(<= (j9_angle) 0.524)
	; 	(>= (j9_angle) 0.523) 
	; 	(no_movement)
	; 	(not (head_hit))
	; 	(not (floor_hit))
	; 	(not (joint_hit))
	; )

	;##### Change goal so that the robot hits itself
	; (and (joint_hit)(no_movement))

	;##### Change goal so that the robot hits the floor
	; (and (floor_hit)(no_movement))
	
	;##### Change goal so that the robot hits the head
	; (and (head_hit)(no_movement))
  )
)
