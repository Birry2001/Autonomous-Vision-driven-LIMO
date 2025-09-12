FROM ubuntu:24.04

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=1000
ENV DEBIAN_FRONTEND=noninteractive

# Base
RUN apt-get update && apt-get install -y \
    locales sudo curl gnupg2 lsb-release ca-certificates \
    build-essential cmake git python3-pip python3-venv \
    && locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Dépôt ROS 2
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
  | gpg --dearmor -o /usr/share/keyrings/ros-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
  http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
  | tee /etc/apt/sources.list.d/ros2.list

# Dépôt OSRF (Gazebo) – utile avec ros_gz
RUN curl -sSL https://packages.osrfoundation.org/gazebo.gpg \
  | gpg --dearmor -o /usr/share/keyrings/gz-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/gz-archive-keyring.gpg] \
  http://packages.osrfoundation.org/gazebo/ubuntu-stable $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
  > /etc/apt/sources.list.d/gazebo-stable.list

# ROS 2 Jazzy + ros_gz + outils dev + teleop
RUN apt-get update && apt-get install -y \
    ros-jazzy-desktop \
    ros-jazzy-ros-gz-sim ros-jazzy-ros-gz-bridge \
    ros-jazzy-xacro ros-jazzy-teleop-twist-keyboard \
    python3-colcon-common-extensions python3-rosdep python3-vcstool python3-argcomplete \
    x11-apps mesa-utils \
    && rm -rf /var/lib/apt/lists/*

# rosdep (tolère la ré-exécution)
RUN rosdep init || true && rosdep update || true

# Utilisateur non-root
RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd -m -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} ${USERNAME} && \
    usermod -aG sudo ${USERNAME} && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
SHELL ["/bin/bash","-lc"]

# Environnement ROS
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc

WORKDIR /workspaces/Autonomous-Vision-driven-LIMO
ENTRYPOINT ["/bin/bash"]
