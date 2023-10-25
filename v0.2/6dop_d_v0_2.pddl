(define
    (domain six_dop_dom_v0_2)

    (:requirements :disjunctive-preconditions :durative-actions :fluents :numeric-fluents :duration-inequalities :time :negative-preconditions :equality)

    (:predicates
        (joint_2_moving)
        (joint_2_moving_clockwise)
        (joint_2_moving_counterclockwise)
        (no_movement)
        (head_hit)
    )

    (:functions
        (j2_x)
        (j2_y)
        (j2_z)
        (l2)
        (j2_angle)
        (w2)

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
            (decrease (j2_angle) (* #t w2))
            (assign (j2_x)(* l2 (cos (- (j2_angle)(* #t w2)))))
            (assign (j2_y)(* l2 (sin (- (j2_angle)(* #t w2)))))
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
            (increase (j2_angle) (* #t w2))
            (assign (j2_x)(* l2 (cos (+ (j2_angle)(* #t w2)))))
            (assign (j2_y)(* l2 (sin (+ (j2_angle)(* #t w2)))))
        )
    )

    (:event head_collision
        :parameters ()
        :precondition (and
            (not (no_movement))
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
