"""
Deployment unit tests
node1 tests
"""


def test_software(host):
    """
    Check whether required software packages are installed
    """
    packages = [
        "procps",
        "iproute2"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed

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


def test_docker(host):
    """
    Check whether Docker works as expected
    """
    assert host.service('docker.service').is_running
    assert host.service('docker.service').is_enabled


def test_docker_user(host):
    """
    Check whether Docker works for the user
    """
    _container = host.run('docker run hello-world').stdout
    _user = host.user("user")
    assert 'hello from docker' in _container.lower()
    assert "docker" in _user.groups


def test_firewall(host):
    """
    Check whether required services are enabled
    """
    ports = [
        '22',
        '80',
        '8080',
        '139',
        '445'
    ]
    with host.sudo():
        _ports = host.run("ufw status | grep -i allow").stdout

    for _port in ports:
        assert _port in _ports
