# 6DOP
_Six Degrees of Planning: Automated Planning for Surgical Navigation Under MyCobot’s Six Degrees of Freedom_

Project created for the CISC 813 class of Prof. Christian Muise, in Fall '23 at Queen's University - Canada, by <a href="https://github.com/ColtonBarr">@ColtonBarr</a> and <a href="https://github.com/MahatKC">@MahatKC</a>.

---

<p align="center">
  <a href="https://shop.elephantrobotics.com/en-ca/products/mycobot-pi-worlds-smallest-and-lightest-six-axis-collaborative-robot"><img src="https://shop.elephantrobotics.com/cdn/shop/products/myCobot280Pi_d059bf49-0c40-402b-ae52-3617c81d2cc7_1000x.png?v=1676893070" align="middle" width="450" ></a>
</p>

<p align="center">
  MyCobot's Six Degrees of Freedom Robotic Arm
</p>

This project aims to model an automated planner capable of outlining a set of movements for the joints of a 6 Degrees of Freedom (DoF) MyCobot robotic arm so that, given an initial state of the robot, it can get an actuator to a specified position in 3D space without hitting an obstacle.

Since the robotic arm mentioned is used for surgical navigation, the actual application scenario would be in such context, with the actuator being a needle, the target, a location in the patient's head, and the obstacle, the patient's head itself.

For that matter, this project falls within the Hybrid domain of planning, using Numeric variables and durative actions. Thus, the planner used is ENHSP (https://sites.google.com/view/enhsp/home), created by Enrico Scala et al.

---

### Roadmap

Given the complexity of the problem and its potential implementation in real-world scenarios, we have devised the following roadmap:

- v0.1 - With a single movable joint (J2) starting at a position in 3D space, have the joint reach the target position (M2) ✅
- v0.2 - Still with a single movable joint (J2), add a simple spatial obstacle (cube or sphere) and have the joint reach the target without hitting the obstacle ✅
- v0.3 - Add another movable joint (J3 and M3), forbidding either of them of hitting the obstacle and having the edge of the last joint reach the obstacle (that being the goal for future versions as well) ✅
- v0.4 - Forbid the joints of hitting the floor (having that constraint for all joints added in future versions) ✅
- v0.5 - Add a third joint (J4) that does not move on its own ✅
- v0.6 - Add all remaining joints (J0, J1, J5, J6, J7, J8, J9) and model their movement according to the previously modelled movements, add M5, create python visualization tool ✅
- v0.7 - Add M7
- v0.8 - Model collision of the joints' segments
- v0.9 - Add M8
- v1.0 - Add M9
- v1.1 - Improve the obstacle's shape to better simulate an actual head
- v1.2 - Consider the width of the joints' segments to better simulate segment collision
- v1.3 - Apply the output of the planner to the 3D Slicer simulator
- v2.0 - Fully integrate the planner to 3D Slicer so the planning takes place from a position set at the simulator and outputs a set of actions that can be visualized on 3D Slicer
- v3.0 - Integrate the planner with ROS (Robot Operating System) so that it moves the actual MyCobot robotic arm
