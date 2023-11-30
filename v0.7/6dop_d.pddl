(define
    (domain six_dop_dom_v0_6)

    (:requirements :disjunctive-preconditions :durative-actions :fluents :numeric-fluents :duration-inequalities :time :negative-preconditions :equality)

    (:predicates
        ;J2 movement fluents
        (joint_2_moving)
        (joint_2_moving_clockwise)
        (joint_2_moving_counterclockwise)
        (joint_2_finished)

        ;J3 movement fluents
        (joint_3_moving)
        (joint_3_moving_clockwise)
        (joint_3_moving_counterclockwise)
        (joint_3_finished)

        ;J5 movement fluents
        (joint_5_moving)
        (joint_5_moving_clockwise)
        (joint_5_moving_counterclockwise)
        (joint_5_finished)

        ;J7 movement fluents
        (joint_7_moving)
        (joint_7_moving_clockwise)
        (joint_7_moving_counterclockwise)
        (joint_7_finished)

        ;J8 movement fluents
        (joint_8_moving)
        (joint_8_moving_clockwise)
        (joint_8_moving_counterclockwise)
        (joint_8_finished)

        ;J9 movement fluents
        (joint_9_moving)
        (joint_9_moving_clockwise)
        (joint_9_moving_counterclockwise)
        (joint_9_finished)

        ;Global fluents
        (no_movement)
        (head_hit)
        (floor_hit)
    )

    (:functions
        (j1_x)
        (j1_y)
        (j1_z)
        (l1)

        ;J2 variables
        (j2_x)
        (j2_y)
        (j2_z)
        (l2)
        (j2_angle)

        ;J3 variables
        (j3_x)
        (j3_y)
        (j3_z)
        (l3)
        (j3_angle)

        ;J4 variables
        (j4_x)
        (j4_y)
        (j4_z)
        (l4)

        ;J5 variables
        (j5_x)
        (j5_y)
        (j5_z)
        (l5)
        (j5_angle)

        ;J6 variables
        (j6_x)
        (j6_y)
        (j6_z)
        (l6)

        ;J7 variables
        (j7_x)
        (j7_y)
        (j7_z)
        (l7)
        (j7_angle)

        ;J8 variables
        (j8_x)
        (j8_y)
        (j8_z)
        (l8)
        (j8_angle)

        ;J9 variables
        (j9_x)
        (j9_y)
        (j9_z)
        (l9)
        (j9_angle)

        ;Sphere variables
        (sphere_center_x)
        (sphere_center_y)
        (sphere_center_z)
        (squared_sphere_radius)

        ;Global variables
        (target_x)
        (target_y)
        (target_z)
        (total_time)
        (lambda)
        (epsilon)
        (w)
        (updating_positions)

        ;Sums of lengths
        (l3_l5)
        (l3_l5_l7)
        (l3_l5_l7_l9)
        (l5_l7)
        (l5_l7_l9)
        (l7_l9)
    )  

    ;---------------------------------- J2 --------------------------------------------------------
    (:action move_j2_clockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_2_moving))
            (not (joint_2_finished))
        )
        :effect (and 
            (joint_2_moving)
            (joint_2_moving_clockwise)
            (not (no_movement))
        )
    )

    (:process moving_j2_clockwise
        :parameters ()
        :precondition (and
            (joint_2_moving)
            (joint_2_moving_clockwise)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and
            (decrease (j2_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (updating_positions) 1.0)
        )
    )

    (:action move_j2_counterclockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_2_moving))
            (not (joint_2_finished))
        )
        :effect (and 
            (joint_2_moving)
            (joint_2_moving_counterclockwise)
            (not (no_movement))
        )
    )

    (:process moving_j2_counterclockwise
        :parameters ()
        :precondition (and
            (joint_2_moving)
            (joint_2_moving_counterclockwise)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and
            (increase (j2_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (updating_positions) 1.0)
        )
    )

    (:event update_positions_j2_moving
        :parameters ()
        :precondition (and
            (joint_2_moving)
            (= updating_positions 1.0)
        )
        :effect (and
            ;Some updates happen before assignment, some don't
            (assign (j2_x)(* l2 (cos (j2_angle))))
            (assign (j2_y)(* l2 (sin (j2_angle))))
            (assign (j3_x)(* l2 (cos (j2_angle))))
            (assign (j3_y)(* l2 (sin (j2_angle))))
            ;J4 and J5 will not change
            (assign (j6_x)(* l2 (cos (j2_angle))))
            (assign (j6_y)(* l2 (sin (j2_angle))))
            (assign (j7_x)(* l2 (cos (j2_angle))))
            (assign (j7_y)(* l2 (sin (j2_angle))))
            (assign (j8_x)(* (+ l2 l8)(cos (j2_angle))))
            (assign (j8_y)(* (+ l2 l8)(sin (j2_angle))))
            (assign (j9_x)(* (+ l2 l8)(cos (j2_angle))))
            (assign (j9_y)(* (+ l2 l8)(sin (j2_angle))))
            (assign updating_positions 0.0)
        )
    )

    (:action stop_j2
        :parameters ()
        :precondition (and
            (joint_2_moving)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and 
            (not (joint_2_moving))
            (not (joint_2_moving_clockwise))
            (not (joint_2_moving_counterclockwise))
            (no_movement)
            (joint_2_finished)
        )
    )

    ;---------------------------------- J3 --------------------------------------------------------
    (:action move_j3_clockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_3_moving))
            (not (joint_3_finished))
            (joint_2_finished)
        )
        :effect (and 
            (joint_3_moving)
            (joint_3_moving_clockwise)
            (not (no_movement))
        )
    )

    (:process moving_j3_clockwise
        :parameters ()
        :precondition (and
            (joint_3_moving)
            (joint_3_moving_clockwise)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and
            (decrease (j3_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (updating_positions) 1.0)
            ;Further angles using absolute value in relation to world
            (decrease (j5_angle) (* #t w))
            (decrease (j7_angle) (* #t w))
            (decrease (j9_angle) (* #t w))
        )

    )
    
    (:action move_j3_counterclockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_3_moving))
            (not (joint_3_finished))
            (joint_2_finished)
        )
        :effect (and 
            (joint_3_moving)
            (joint_3_moving_counterclockwise)
            (not (no_movement))
        )
    )

    (:process moving_j3_counterclockwise
        :parameters ()
        :precondition (and
            (joint_3_moving)
            (joint_3_moving_counterclockwise)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and
            (increase (j3_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (updating_positions) 1.0)
            ;Further angles using absolute value in relation to world
            (increase (j5_angle) (* #t w))
            (increase (j7_angle) (* #t w))
            (increase (j9_angle) (* #t w))
        )
    )

    (:event update_positions_j3_moving
        :parameters ()
        :precondition (and
            (joint_3_moving)
            (= updating_positions 1.0)
        )
        :effect (and
            ;J3 UPDATE
            (assign (j3_x)
                (+ j2_x (
                    * (sin j2_angle)
                    (* l3 (sin (j3_angle)))
                ))
            )
            (assign (j3_y)
                (+ j2_y (
                    * (cos j2_angle)
                    (* l3 (sin (j3_angle)))
                ))
            )
            (assign (j3_z)
                (+ j2_z 
                    (* l3 (cos (j3_angle)))
                )
            )
            ;J4 UPDATE
            (assign (j4_x)
                (* (sin j2_angle)
                    (* l3 (sin (j3_angle)))
                )
            )
            (assign (j4_y)
                (* (cos j2_angle)
                    (* l3 (sin (j3_angle)))
                )
            )
            (assign (j4_z)
                (+ j1_z 
                    (* l3 (cos (j3_angle)))
                )
            )
            ;J5 UPDATE
            (assign (j5_x)
                (* (sin j2_angle)
                    (* l3_l5 (sin (j3_angle)))
                )
            )
            (assign (j5_y)
                (* (cos j2_angle)
                    (* l3_l5 (sin (j3_angle)))
                )
            )
            (assign (j5_z)
                (+ j1_z 
                    (* l3_l5 (cos (j3_angle)))
                )
            )
            ;J6 UPDATE
            (assign (j6_x)
                (+ j2_x (
                    * (sin j2_angle)
                    (* l3_l5 (sin (j3_angle)))
                ))
            )
            (assign (j6_y)
                (+ j2_y (
                    * (cos j2_angle)
                    (* l3_l5 (sin (j3_angle)))
                ))
            )
            (assign (j6_z)
                (+ j2_z 
                    (* l3_l5 (cos (j3_angle)))
                )
            )
            ;J7 UPDATE
            (assign (j7_x)
                (+ j2_x (
                    * (sin j2_angle)
                    (* l3_l5_l7 (sin (j3_angle)))
                ))
            )
            (assign (j7_y)
                (+ j2_y (
                    * (cos j2_angle)
                    (* l3_l5_l7 (sin (j3_angle)))
                ))
            )
            (assign (j7_z)
                (+ j2_z 
                    (* l3_l5_l7 (cos (j3_angle)))
                )
            )
            ;J8 UPDATE
            (assign (j8_x)
                (+ (+ j2_x (* l8 (cos j2_angle))) (
                    * (sin j2_angle)
                    (* l3_l5_l7 (sin (j3_angle)))
                ))
            )
            (assign (j8_y)
                (+ (+ j2_y (* l8 (sin j2_angle))) (
                    * (cos j2_angle)
                    (* l3_l5_l7 (sin (j3_angle)))
                ))
            )
            (assign (j8_z)
                (+ j2_z 
                    (* l3_l5_l7 (cos (j3_angle)))
                )
            )
            ;J9 UPDATE
            (assign (j9_x)
                (+ (+ j2_x (* l8 (cos j2_angle))) (
                    * (sin j2_angle)
                    (* l3_l5_l7_l9 (sin (j3_angle)))
                ))
            )
            (assign (j9_y)
                (+ (+ j2_y (* l8 (sin j2_angle))) (
                    * (cos j2_angle)
                    (* l3_l5_l7_l9 (sin (j3_angle)))
                ))
            )
            (assign (j9_z)
                (+ j2_z 
                    (* l3_l5_l7_l9 (cos (j3_angle)))
                )
            )
            (assign updating_positions 0.0)
        )
    )

    (:action stop_j3
        :parameters ()
        :precondition (and
            (joint_3_moving)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and 
            (not (joint_3_moving))
            (not (joint_3_moving_clockwise))
            (not (joint_3_moving_counterclockwise))
            (no_movement)
            (joint_3_finished)
        )
    )

    ;---------------------------------- J5 --------------------------------------------------------
    (:action move_j5_clockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_5_moving))
            (not (joint_5_finished))
            (joint_3_finished)
        )
        :effect (and 
            (joint_5_moving)
            (joint_5_moving_clockwise)
            (not (no_movement))
        )
    )

    (:process moving_j5_clockwise
        :parameters ()
        :precondition (and
            (joint_5_moving)
            (joint_5_moving_clockwise)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and
            (decrease (j5_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (updating_positions) 1.0)
            ;Further angles using absolute value in relation to world
            (decrease (j7_angle) (* #t w))
            (decrease (j9_angle) (* #t w))
        )

    )
    
    (:action move_j5_counterclockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_5_moving))
            (not (joint_5_finished))
            (joint_3_finished)
        )
        :effect (and 
            (joint_5_moving)
            (joint_5_moving_counterclockwise)
            (not (no_movement))
        )
    )

    (:process moving_j5_counterclockwise
        :parameters ()
        :precondition (and
            (joint_5_moving)
            (joint_5_moving_counterclockwise)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and
            (increase (j5_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (updating_positions) 1.0)
            ;Further angles using absolute value in relation to world
            (increase (j7_angle) (* #t w))
            (increase (j9_angle) (* #t w))
        )
    )

    (:event update_positions_j5_moving
        :parameters ()
        :precondition (and
            (joint_5_moving)
            (= updating_positions 1.0)
        )
        :effect (and
            ;J5 UPDATE
            (assign (j5_x)
                (+ j4_x 
                    (* (sin j2_angle)
                        (* l5 (sin (j5_angle)))
                    )
                )
            )
            (assign (j5_y)
                (+ j4_y 
                    (* (cos j2_angle)
                        (* l5 (sin (j5_angle)))
                    )
                )
            )
            (assign (j5_z)
                (+ j4_z 
                    (* l5 (cos (j5_angle)))
                )
            )
            ;J6 UPDATE
            (assign (j6_x)
                (+ j3_x (
                    * (sin j2_angle)
                    (* l5 (sin (j5_angle)))
                ))
            )
            (assign (j6_y)
                (+ j3_y (
                    * (cos j2_angle)
                    (* l5 (sin (j5_angle)))
                ))
            )
            (assign (j6_z)
                (+ j3_z 
                    (* l5 (cos (j5_angle)))
                )
            )
            ;J7 UPDATE
            (assign (j7_x)
                (+ j3_x (
                    * (sin j2_angle)
                    (* l5_l7 (sin (j5_angle)))
                ))
            )
            (assign (j7_y)
                (+ j3_y (
                    * (cos j2_angle)
                    (* l5_l7 (sin (j5_angle)))
                ))
            )
            (assign (j7_z)
                (+ j3_z 
                    (* l5_l7 (cos (j5_angle)))
                )
            )
            ;J8 UPDATE
            (assign (j8_x)
                (+ (+ j3_x (* l8 (cos j2_angle))) (
                    * (sin j2_angle)
                    (* l5_l7 (sin (j5_angle)))
                ))
            )
            (assign (j8_y)
                (+ (+ j3_y (* l8 (sin j2_angle))) (
                    * (cos j2_angle)
                    (* l5_l7 (sin (j5_angle)))
                ))
            )
            (assign (j8_z)
                (+ j3_z 
                    (* l5_l7 (cos (j5_angle)))
                )
            )
            ;J9 UPDATE
            (assign (j9_x)
                (+ (+ j3_x (* l8 (cos j2_angle))) (
                    * (sin j2_angle)
                    (* l5_l7_l9 (sin (j5_angle)))
                ))
            )
            (assign (j9_y)
                (+ (+ j3_y (* l8 (sin j2_angle))) (
                    * (cos j2_angle)
                    (* l5_l7_l9 (sin (j5_angle)))
                ))
            )
            (assign (j9_z)
                (+ j3_z 
                    (* l5_l7_l9 (cos (j5_angle)))
                )
            )
            (assign updating_positions 0.0)
        )
    )

    (:action stop_j5
        :parameters ()
        :precondition (and
            (joint_5_moving)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and 
            (not (joint_5_moving))
            (not (joint_5_moving_clockwise))
            (not (joint_5_moving_counterclockwise))
            (no_movement)
            (joint_5_finished)
        )
    )

    ;---------------------------------- J7 --------------------------------------------------------
    (:action move_j7_clockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_7_moving))
            (not (joint_7_finished))
            (joint_5_finished)
        )
        :effect (and 
            (joint_7_moving)
            (joint_7_moving_clockwise)
            (not (no_movement))
        )
    )

    (:process moving_j7_clockwise
        :parameters ()
        :precondition (and
            (joint_7_moving)
            (joint_7_moving_clockwise)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and
            (decrease (j7_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (updating_positions) 1.0)
            ;Further angles using absolute value in relation to world
            (decrease (j9_angle) (* #t w))
        )

    )
    
    (:action move_j7_counterclockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_7_moving))
            (not (joint_7_finished))
            (joint_5_finished)
        )
        :effect (and 
            (joint_7_moving)
            (joint_7_moving_counterclockwise)
            (not (no_movement))
        )
    )

    (:process moving_j7_counterclockwise
        :parameters ()
        :precondition (and
            (joint_7_moving)
            (joint_7_moving_counterclockwise)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and
            (increase (j7_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (updating_positions) 1.0)
            ;Further angles using absolute value in relation to world
            (increase (j9_angle) (* #t w))
        )
    )

    (:event update_positions_j7_moving
        :parameters ()
        :precondition (and
            (joint_7_moving)
            (= updating_positions 1.0)
        )
        :effect (and
            ;J7 UPDATE
            (assign (j7_x)
                (+ j6_x (
                    * (sin j2_angle)
                    (* l7 (sin (j7_angle)))
                ))
            )
            (assign (j7_y)
                (+ j6_y (
                    * (cos j2_angle)
                    (* l7 (sin (j7_angle)))
                ))
            )
            (assign (j7_z)
                (+ j6_z 
                    (* l7 (cos (j7_angle)))
                )
            )
            ;J8 UPDATE
            (assign (j8_x)
                (+ (+ j6_x (* l8 (cos j2_angle))) (
                    * (sin j2_angle)
                    (* l7 (sin (j7_angle)))
                ))
            )
            (assign (j8_y)
                (+ (+ j6_y (* l8 (sin j2_angle))) (
                    * (cos j2_angle)
                    (* l7 (sin (j7_angle)))
                ))
            )
            (assign (j8_z)
                (+ j6_z 
                    (* l7 (cos (j7_angle)))
                )
            )
            ;J9 UPDATE
            (assign (j9_x)
                (+ (+ j6_x (* l8 (cos j2_angle))) (
                    * (sin j2_angle)
                    (* l7_l9 (sin (j7_angle)))
                ))
            )
            (assign (j9_y)
                (+ (+ j6_y (* l8 (sin j2_angle))) (
                    * (cos j2_angle)
                    (* l7_l9 (sin (j7_angle)))
                ))
            )
            (assign (j9_z)
                (+ j6_z 
                    (* l7_l9 (cos (j7_angle)))
                )
            )
            (assign updating_positions 0.0)
        )
    )

    (:action stop_j7
        :parameters ()
        :precondition (and
            (joint_7_moving)
            (not (no_movement))
            (<= updating_positions 0)
        )
        :effect (and 
            (not (joint_7_moving))
            (not (joint_7_moving_clockwise))
            (not (joint_7_moving_counterclockwise))
            (no_movement)
            (joint_7_finished)
        )
    )

    ;---------------------------- COLLISIONS --------------------------------------------------------
    ;Each collision event has to check if any of the joints has collided, while movement is happening
    (:event floor_collision
        :parameters ()
        :precondition (and
            (not (no_movement))
            (or
                (<= j2_z 0.0)
                (<= j3_z 0.0)
                (<= j4_z 0.0)
                (<= j5_z 0.0)
                (<= j6_z 0.0)
                (<= j7_z 0.0)
                (<= j8_z 0.0)
                (<= j9_z 0.0)
            )
        )
        :effect (and
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (floor_hit)
        )
    )

    (:event head_collision_j2
        :parameters ()
        :precondition (and
            (not (no_movement))
            ;J2 Collision
            (<= 
                (+ 
                    (^ (- j2_x sphere_center_x) 2)
                    (+ (^ (- j2_y sphere_center_y) 2)
                    (^ (- j2_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            ;;Stop any and all movement happening
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (head_hit)
        )
    )

    (:event head_collision_j3
        :parameters ()
        :precondition (and
            (not (no_movement))
            ;J3 Collision
            (<= 
                (+ 
                    (^ (- j3_x sphere_center_x) 2)
                    (+ (^ (- j3_y sphere_center_y) 2)
                    (^ (- j3_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            ;;Stop any and all movement happening
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (head_hit)
        )
    )

    (:event head_collision_j4
        :parameters ()
        :precondition (and
            (not (no_movement))
            ;J4 Collision
            (<= 
                (+ 
                    (^ (- j4_x sphere_center_x) 2)
                    (+ (^ (- j4_y sphere_center_y) 2)
                    (^ (- j4_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            ;;Stop any and all movement happening
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (head_hit)
        )
    )

    (:event head_collision_j5
        :parameters ()
        :precondition (and
            (not (no_movement))
            ;J5 Collision
            (<= 
                (+ 
                    (^ (- j5_x sphere_center_x) 2)
                    (+ (^ (- j5_y sphere_center_y) 2)
                    (^ (- j5_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            ;;Stop any and all movement happening
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (head_hit)
        )
    )

    (:event head_collision_j6
        :parameters ()
        :precondition (and
            (not (no_movement))
            ;J6 Collision
            (<= 
                (+ 
                    (^ (- j6_x sphere_center_x) 2)
                    (+ (^ (- j6_y sphere_center_y) 2)
                    (^ (- j6_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            ;;Stop any and all movement happening
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (head_hit)
        )
    )

    (:event head_collision_j7
        :parameters ()
        :precondition (and
            (not (no_movement))
            ;J7 Collision
            (<= 
                (+ 
                    (^ (- j7_x sphere_center_x) 2)
                    (+ (^ (- j7_y sphere_center_y) 2)
                    (^ (- j7_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            ;;Stop any and all movement happening
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (head_hit)
        )
    )

    (:event head_collision_j8
        :parameters ()
        :precondition (and
            (not (no_movement))
            ;J8 Collision
            (<= 
                (+ 
                    (^ (- j8_x sphere_center_x) 2)
                    (+ (^ (- j8_y sphere_center_y) 2)
                    (^ (- j8_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            ;;Stop any and all movement happening
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (head_hit)
        )
    )

    (:event head_collision_j9
        :parameters ()
        :precondition (and
            (not (no_movement))
            ;J9 Collision
            (<= 
                (+ 
                    (^ (- j9_x sphere_center_x) 2)
                    (+ (^ (- j9_y sphere_center_y) 2)
                    (^ (- j9_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            ;;Stop any and all movement happening
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (not (joint_5_moving))
            (not (joint_7_moving))
            (not (joint_8_moving))
            (not (joint_9_moving))
            (head_hit)
        )
    )

    ;---------------------------- ANGLE RESETS --------------------------------------------
    ;Angle resets are relevant to avoid infinite states
    ;Each angle must have its own resetting event
    (:event reset_j2_angle
        :parameters ()
        :precondition (and
            (or 
                (>= (j2_angle) 6.28318530717958648)
                (<= (j2_angle) -6.28318530717958648)
            )
        )
        :effect (and
            (assign (j2_angle) 0.0)
        )
    )

    (:event reset_j3_angle
        :parameters ()
        :precondition (and
            (or 
                (>= (j3_angle) 6.28318530717958648)
                (<= (j3_angle) -6.28318530717958648)
            )
        )
        :effect (and
            (assign (j3_angle) 0.0)
        )
    )

    (:event reset_j5_angle
        :parameters ()
        :precondition (and
            (or 
                (>= (j5_angle) 6.28318530717958648)
                (<= (j5_angle) -6.28318530717958648)
            )
        )
        :effect (and
            (assign (j5_angle) 0.0)
        )
    )

    (:event reset_j7_angle
        :parameters ()
        :precondition (and
            (or 
                (>= (j7_angle) 6.28318530717958648)
                (<= (j7_angle) -6.28318530717958648)
            )
        )
        :effect (and
            (assign (j7_angle) 0.0)
        )
    )

    (:event reset_j8_angle
        :parameters ()
        :precondition (and
            (or 
                (>= (j8_angle) 6.28318530717958648)
                (<= (j8_angle) -6.28318530717958648)
            )
        )
        :effect (and
            (assign (j8_angle) 0.0)
        )
    )

    (:event reset_j9_angle
        :parameters ()
        :precondition (and
            (or 
                (>= (j9_angle) 6.28318530717958648)
                (<= (j9_angle) -6.28318530717958648)
            )
        )
        :effect (and
            (assign (j9_angle) 0.0)
        )
    )
    
)
