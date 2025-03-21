"""
Deployment unit tests
node1 tests
"""


def test_software(host):
    """
    Check whether required software packages are installed
    """
    packages = [
        "python3-policycoreutils",
        "policycoreutils-devel",
        "selinux-policy-doc",
        "podman",
        "podman-compose",
        "cockpit",
        "cockpit-podman",
        "nfs-utils",
        "procps-ng",
        "iproute"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed


def test_selinux(host):
    """
    Check whether SELinux is configured properly
    """
    selinux_state = host.run("getenforce")
    selinux_cfg = host.file("/etc/sysconfig/selinux")
    assert "Enforcing" in selinux_state.stdout
    assert selinux_cfg.contains("SELINUX=enforcing")
    assert selinux_cfg.contains("SELINUXTYPE=targeted")


def test_disks(host):
    """
    Check whether additional disks were added
    """
    # check for vdX or sdX style devices
    if host.file("/dev/vdb").exists:
        disks = ['/dev/vdb', '/dev/vdc']
    else:
        disks = ['/dev/sdb', '/dev/sdc']
    for disk in disks:
        assert host.block_device(disk).size >= (10 * 1024 * 1024 * 1024)


def test_firewall(host):
    """
    Check whether required services are enabled
    """
    services = [
        'ssh',
        'http',
        'samba',
        'cockpit'
    ]
    ports = [
        '8080/tcp'
    ]
    with host.sudo():
        _ports = host.run("firewall-cmd --list-ports").stdout
        _services = host.run("firewall-cmd --list-services").stdout

    for _srv in services:
        assert _srv in _services

    for _port in ports:
        assert _port in _ports


def test_services(host):
    """
    Check whether requires services are running
    """
    services = [
        'slow-app.service',
        'cockpit.socket'
    ]
    for _srv in services:
        assert host.service(_srv).is_running
        assert host.service(_srv).is_enabled


def test_binaries(host):
    """
    Check additional binaries
    """
    binaries = [
        '/usr/local/bin/crapp.sh'
    ]
    for _bin in binaries:
        _file = host.file(_bin)
        assert _file.exists
        assert _file.mode == 0o755
