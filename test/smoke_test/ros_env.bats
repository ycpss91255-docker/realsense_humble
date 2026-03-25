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

@test "realsense2_camera package is available" {
    run bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && ros2 pkg list | grep realsense2_camera"
    assert_success
}

@test "realsense2_description package is available" {
    run bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && ros2 pkg list | grep realsense2_description"
    assert_success
}

@test "librealsense2 library is installed" {
    run dpkg -l | grep librealsense2
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
