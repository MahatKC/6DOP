(define
    (domain six_dop_dom_tiny)

    (:requirements :disjunctive-preconditions :durative-actions :fluents :numeric-fluents :duration-inequalities :time :negative-preconditions :equality)

    (:predicates
        (joint_2_moving)
        (no_movement)
    )

    (:functions
        (j2_x)
        (j2_y)
        (j2_z)
        (j2_angle)
        (w2)

        (target_x)
        (target_y)
        (target_z)
        (epsilon)
    )  

    (:action move_j2
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (joint_2_moving))
        )
        :effect (and 
            (joint_2_moving)
            (not (no_movement))
        )
    )

    (:process moving_j2
        :parameters ()
        :precondition (and
            (joint_2_moving)
            (not (no_movement))
        )
        :effect (and
            (increase (j2_angle) (* #t w2))
            (assign (j2_x)(cos (+ (j2_angle)(* #t w2))))
            (assign (j2_y)(sin (+ (j2_angle)(* #t w2))))
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
            (no_movement)
        )
    )
)
