# Autonomous Vision driven LIMO

**Autonomous Vision driven LIMO** is a research project focused on developing an end-to-end autonomous navigation system for the LIMO Pro robot ( https://github.com/agilexrobotics/limo_ros2 ). Leveraging state-of-the-art concepts in robotics and artificial intelligence, the project explores:

* **Deep Learning for Perception** : real-time obstacle detection and scene understanding using convolutional neural networks.
* **Sensor Fusion** : combining LiDAR, odometry, and camera data with Extended Kalman Filters or particle filters to achieve robust state estimation.
* **SLAM & Path Planning** : constructing a map of the environment and computing safe, efficient trajectories (e.g., A\* or Dijkstra).
* **Control & Command** : low-level motion control in ROS 2 using C++ for precise velocity and steering commands.

**Objective** : deliver a modular ROS 2 framework with simulation-ready components (Gazebo) and language-agnostic packages (C++/Python) to demonstrate reliable autonomous navigation on LIMO Pro.
