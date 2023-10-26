(define
    (domain six_dop_dom_v0_4)

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

        ;Global fluents
        (no_movement)
        (head_hit)
        (floor_hit)
    )

    (:functions
        (j2_x)
        (j2_y)
        (j2_z)
        (l2)
        (j2_angle)

        (j3_x)
        (j3_y)
        (j3_z)
        (l3)
        (j3_angle)

        (sphere_center_x)
        (sphere_center_y)
        (sphere_center_z)
        (squared_sphere_radius)

        (target_x)
        (target_y)
        (target_z)
        (total_time)
        (epsilon)
        (w)
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
        )
        :effect (and
            (decrease (j2_angle) (* #t w))
            (increase (total_time) (* #t 1.0))

            ;Angle update doesn't happen before cos/sin calculations, so calculation has to happen here:
            (assign (j2_x)(* l2 (cos (- (j2_angle)(* #t w)))))
            (assign (j2_y)(* l2 (sin (- (j2_angle)(* #t w)))))
            (assign (j3_x)(j2_x))
            (assign (j3_y)(j2_y))
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
        )
        :effect (and
            (increase (j2_angle) (* #t w))
            (increase (total_time) (* #t 1.0))

            ;Angle update doesn't happen before cos/sin calculations, so calculation has to happen here:
            (assign (j2_x)(* l2 (cos (+ (j2_angle)(* #t w)))))
            (assign (j2_y)(* l2 (sin (+ (j2_angle)(* #t w)))))
            (assign (j3_x)(j2_x))
            (assign (j3_y)(j2_y))
        )
    )

    (:action stop_j2
        :parameters ()
        :precondition (and
            (joint_2_moving)
            (not (no_movement))
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
        )
        :effect (and
            (increase (j3_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (j3_x)
                (+ j2_x (
                    * (sin j2_angle)
                    (* l3 (sin j3_angle))
                ))
            )
            (assign (j3_y)
                (+ j2_y (
                    * (cos j2_angle)
                    (* l3 (sin j3_angle))
                ))
            )
            (assign (j3_z)
                (+ j2_z 
                    (* l3 (cos (+ j3_angle (* #t w))))
                )
            )
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
        )
        :effect (and
            (decrease (j3_angle) (* #t w))
            (increase (total_time) (* #t 1.0))
            (assign (j3_x)
                (+ j2_x (
                    * (sin j2_angle)
                    (* l3 (sin j3_angle))
                ))
            )
            (assign (j3_y)
                (+ j2_y (
                    * (cos j2_angle)
                    (* l3 (sin j3_angle))
                ))
            )
            (assign (j3_z)
                (+ j2_z 
                    (* l3 (cos (- j3_angle (* #t w))))
                )
            )
        )
    )

    (:action stop_j3
        :parameters ()
        :precondition (and
            (joint_3_moving)
            (not (no_movement))
        )
        :effect (and 
            (not (joint_3_moving))
            (not (joint_3_moving_clockwise))
            (not (joint_3_moving_counterclockwise))
            (no_movement)
            (joint_3_finished)
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
            )
        )
        :effect (and
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
            (floor_hit)
        )
    )

    (:event head_collision
        :parameters ()
        :precondition (and
            (not (no_movement))
            (or
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
        )
        :effect (and
            (no_movement)
            (not (joint_2_moving))
            (not (joint_3_moving))
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
    
)
