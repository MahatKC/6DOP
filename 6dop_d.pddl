(define
    (domain six_dop_dom)

    (:requirements :disjunctive-preconditions :durative-actions :fluents :numeric-fluents :duration-inequalities :time :negative-preconditions :equality)

    (:predicates
        (joint_2_moving_clockwise)
        (joint_2_moving_counterclockwise)
        (no_movement)
        (head_hit)
    )

    (:functions
        (mov_x)
        (mov_y)
        (mov_z)

        (j0_x)
        (j0_y)
        (j0_z)

        (j1_x)
        (j1_y)
        (j1_z)
        (l1)

        (j2_x)
        (j2_y)
        (j2_z)
        (l2)
        (j2_angle)
        (w2)

        (cube_center_x)
        (cube_center_y)
        (cube_center_z)
        (cube_half_dim)

        (target_x)
        (target_y)
        (target_z)
        (epsilon)
    )  

    ; (:event collision_head
    ;     :parameters ()
    ;     :precondition (or
    ;         (and
    ;             (= (mov_x)(+ (cube_center_x)(cube_half_dim)))
    ;             (<= (mov_y)(- (cube_center_y)(cube_half_dim)))
    ;             (>= (mov_y)(+ (cube_center_y)(cube_half_dim)))
    ;             (<= (mov_z)(- (cube_center_z)(cube_half_dim)))
    ;             (>= (mov_z)(+ (cube_center_z)(cube_half_dim)))
    ;         )
    ;         (and
    ;             (= (mov_x)(- (cube_center_x)(cube_half_dim)))
    ;             (<= (mov_y)(- (cube_center_y)(cube_half_dim)))
    ;             (>= (mov_y)(+ (cube_center_y)(cube_half_dim)))
    ;             (<= (mov_z)(- (cube_center_z)(cube_half_dim)))
    ;             (>= (mov_z)(+ (cube_center_z)(cube_half_dim)))
    ;         )
    ;         (and
    ;             (= (mov_y)(+ (cube_center_y)(cube_half_dim)))
    ;             (<= (mov_x)(- (cube_center_x)(cube_half_dim)))
    ;             (>= (mov_x)(+ (cube_center_x)(cube_half_dim)))
    ;             (<= (mov_z)(- (cube_center_z)(cube_half_dim)))
    ;             (>= (mov_z)(+ (cube_center_z)(cube_half_dim)))
    ;         )
    ;         (and
    ;             (= (mov_y)(- (cube_center_y)(cube_half_dim)))
    ;             (<= (mov_x)(- (cube_center_x)(cube_half_dim)))
    ;             (>= (mov_x)(+ (cube_center_x)(cube_half_dim)))
    ;             (<= (mov_z)(- (cube_center_z)(cube_half_dim)))
    ;             (>= (mov_z)(+ (cube_center_z)(cube_half_dim)))
    ;         )
    ;         (and
    ;             (= (mov_z)(+ (cube_center_z)(cube_half_dim)))
    ;             (<= (mov_x)(- (cube_center_x)(cube_half_dim)))
    ;             (>= (mov_x)(+ (cube_center_x)(cube_half_dim)))
    ;             (<= (mov_y)(- (cube_center_y)(cube_half_dim)))
    ;             (>= (mov_y)(+ (cube_center_y)(cube_half_dim)))
    ;         )
    ;         (and
    ;             (= (mov_z)(- (cube_center_z)(cube_half_dim)))
    ;             (<= (mov_x)(- (cube_center_x)(cube_half_dim)))
    ;             (>= (mov_x)(+ (cube_center_x)(cube_half_dim)))
    ;             (<= (mov_y)(- (cube_center_y)(cube_half_dim)))
    ;             (>= (mov_y)(+ (cube_center_y)(cube_half_dim)))
    ;         )            
    ;     )
    ;     :effect (and
    ;         (no_movement)
    ;         (not (joint_2_moving_clockwise))
    ;         (not (joint_2_moving_counterclockwise))
    ;         (head_hit)
    ;     )
    ; )

    ; (:process moving_j2_clockwise
    ;     :parameters ()
    ;     :precondition (and
    ;         (joint_2_moving_clockwise)
    ;         (not (no_movement))
    ;         (not (head_hit))
    ;     )
    ;     :effect (and
    ;         (increase (j2_angle) (* #t w2))
    ;         ;;5th degree polynomial approximation of sine function
    ;         (assign mov_y
    ;             (* j2_angle
    ;                 (+ 0.999696773139043458688377873291916597
    ;                     (* j2_angle
    ;                         (* j2_angle
    ;                             (- 0.165673079320546139044772080908073214
    ;                                 (* 0.00751437717830006597565730091774665237
    ;                                     (^ j2_angle 2)
    ;                                 )))))))
    ;         (assign mov_x
    ;             ;;4th degree polynomial approximation of cossine function
    ;             (+ 0.999403229473690017702542651419315985
    ;                 (* j2_angle
    ;                     (* j2_angle
    ;                         (- 0.495580849220651811464013801967281656
    ;                             (* 0.0367916827993590494951089345856308425
    ;                                 (^ j2_angle 2)
    ;                             )
    ;                         )
    ;                     )
    ;                 )
    ;             )
    ;         )
    ;     )
    ; )

    ; (:process moving_j2_clockwise
    ;     :parameters ()
    ;     :precondition (and
    ;         (joint_2_moving_clockwise)
    ;         (not (no_movement))
    ;         (not (head_hit))
    ;     )
    ;     :effect (and
    ;         (decrease (j2_angle) (* #t w2))
    ;         ;;5th degree polynomial approximation of sine function
    ;         (assign mov_y
    ;             (* j2_angle
    ;                 (+ 0.999696773139043458688377873291916597
    ;                     (* j2_angle
    ;                         (* j2_angle
    ;                             (- 0.165673079320546139044772080908073214
    ;                                 (* 0.00751437717830006597565730091774665237
    ;                                     (^ j2_angle 2)
    ;                                 )))))))
    ;         (assign (mov_x)
    ;             ;;4th degree polynomial approximation of cossine function
    ;             (+ 0.999403229473690017702542651419315985
    ;                 (* j2_angle
    ;                     (* j2_angle
    ;                         (- 0.495580849220651811464013801967281656
    ;                             (* 0.0367916827993590494951089345856308425
    ;                                 (^ j2_angle 2)
    ;                             )
    ;                         )
    ;                     )
    ;                 )
    ;             )
    ;         )
    ;     )
    ; )

    (:process moving_j2_clockwise
        :parameters ()
        :precondition (and
            (joint_2_moving_clockwise)
            (not (no_movement))
            (not (head_hit))
        )
        :effect (and
            (decrease (j2_angle)(* #t w2))
            (assign (j2_x)(cos (- j2_angle (* #t w2))))
            (assign (j2_y)(sin (- j2_angle (* #t w2))))
        )
    )

    (:process moving_j2_counterclockwise
        :parameters ()
        :precondition (and
            (joint_2_moving_counterclockwise)
            (not (no_movement))
            (not (head_hit))
        )
        :effect (and
            (increase (j2_angle) (* #t w2))
            (assign (j2_x)(cos (+ j2_angle (* #t w2))))
            (assign (j2_y)(sin (+ j2_angle (* #t w2))))
        )
    )

    (:action move_j2_clockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (head_hit))
        )
        :effect (and 
            (not (no_movement))
            (joint_2_moving_clockwise)
            (assign mov_x j2_x)
            (assign mov_y j2_y)
            (assign mov_z j2_z)
        )
    )

    (:action move_j2_counterclockwise
        :parameters ()
        :precondition (and 
            (no_movement)
            (not (head_hit))
        )
        :effect (and 
            (not (no_movement))
            (joint_2_moving_counterclockwise)
            (assign mov_x j2_x)
            (assign mov_y j2_y)
            (assign mov_z j2_z)
        )
    )

    ; (:action stop_j2
    ;     :parameters ()
    ;     :precondition (and
    ;         (joint_2_moving_counterclockwise)
    ;         (not (no_movement))
    ;     )
    ;     :effect (and 
    ;         (not (joint_2_moving_counterclockwise))
    ;         (no_movement)
    ;         (assign j2_x mov_x)
    ;         (assign j2_y mov_y)
    ;         (assign j2_z mov_z)
    ;         (assign mov_x 0)
    ;         (assign mov_y 0)
    ;         (assign mov_z 0)
    ;     )
    ; )

    (:action stop_j2
        :parameters ()
        :precondition (and
            (or 
                (joint_2_moving_clockwise)
                (joint_2_moving_counterclockwise)
            )
            (not (no_movement))
        )
        :effect (and 
            (not (joint_2_moving_clockwise))
            (not (joint_2_moving_counterclockwise))
            (no_movement)
            (assign j2_x mov_x)
            (assign j2_y mov_y)
            (assign j2_z mov_z)
            (assign mov_x 0)
            (assign mov_y 0)
            (assign mov_z 0)
        )
    )
)
