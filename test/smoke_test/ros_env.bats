#!/usr/bin/env bats

setup() {
    load "${BATS_TEST_DIRNAME}/test_helper"
}

# -------------------- ROS environment --------------------

@test "ROS_DISTRO is set" {
    assert [ -n "${ROS_DISTRO}" ]
}

@test "ROS 2 setup.bash exists" {
    assert [ -f "/opt/ros/${ROS_DISTRO}/setup.bash" ]
}

@test "ROS 2 setup.bash can be sourced" {
    run bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash"
    assert_success
}

# -------------------- RealSense packages --------------------

@test "realsense2_camera is installed" {
    run dpkg -l ros-${ROS_DISTRO}-realsense2-camera
    assert_success
}

@test "realsense2_description is installed" {
    run dpkg -l ros-${ROS_DISTRO}-realsense2-description
    assert_success
}

# -------------------- Configuration --------------------

@test "RealSense udev rules exist" {
    assert [ -f "/etc/udev/rules.d/99-realsense-libusb.rules" ]
}

# -------------------- System --------------------

@test "entrypoint.sh exists and is executable" {
    assert [ -x "/entrypoint.sh" ]
}
