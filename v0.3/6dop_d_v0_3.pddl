(define
    (domain six_dop_dom_v0_3)

    (:requirements :disjunctive-preconditions :durative-actions :fluents :numeric-fluents :duration-inequalities :time :negative-preconditions :equality)

    (:predicates
        (joint_2_moving)
        (joint_2_moving_clockwise)
        (joint_2_moving_counterclockwise)
        (no_movement)
        (head_hit)
    )

    (:functions
        (mov_x)
        (mov_y)
        (mov_z)

        (j2_x)
        (j2_y)
        (j2_z)
        (l2)
        (j2_angle)
        (w)

        (sphere_center_x)
        (sphere_center_y)
        (sphere_center_z)
        (squared_sphere_radius)

        (target_x)
        (target_y)
        (target_z)
        (epsilon)
    )  

    (:action move_j2_clockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_2_moving))
        )
        :effect (and 
            (joint_2_moving)
            (joint_2_moving_clockwise)
            (not (no_movement))
            (assign (mov_x)(j2_x))
            (assign (mov_y)(j2_y))
            (assign (mov_z)(j2_z))
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
            (assign (j2_x)(* l2 (cos (- (j2_angle)(* #t w)))))
            (assign (j2_y)(* l2 (sin (- (j2_angle)(* #t w)))))
            (assign (mov_x)(j2_x))
            (assign (mov_y)(j2_y))
        )
    )

    (:action move_j2_counterclockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_2_moving))
        )
        :effect (and 
            (joint_2_moving)
            (joint_2_moving_counterclockwise)
            (not (no_movement))
            (assign (mov_x)(j2_x))
            (assign (mov_y)(j2_y))
            (assign (mov_z)(j2_z))
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
            (assign (j2_x)(* l2 (cos (- (j2_angle)(* #t w)))))
            (assign (j2_y)(* l2 (sin (- (j2_angle)(* #t w)))))
            (assign (mov_x)(j2_x))
            (assign (mov_y)(j2_y))
        )
    )

    (:event head_collision
        :parameters ()
        :precondition (and
            (not (no_movement))
            (<= 
                (+ 
                    (^ (- mov_x sphere_center_x) 2)
                    (+ (^ (- mov_y sphere_center_y) 2)
                       (^ (- mov_z sphere_center_z) 2)
                    )
                )
                (squared_sphere_radius)
            )
        )
        :effect (and
            (no_movement)
            (not (joint_2_moving))
            (head_hit)
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
        )
    )
)
