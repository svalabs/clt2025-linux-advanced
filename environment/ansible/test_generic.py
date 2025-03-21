"""
Deployment unit tests
Generic tests
"""


def test_software(host):
    """
    Check whether required software packages are installed
    """
    packages = [
        "vim-common",
        "dos2unix",
        "acl",
        "htop",
        "bash-completion",
        "bzip2",
        "file",
        "tmux",
        "lvm2",
        "cryptsetup",
        "lsof",
        "mdadm",
        "sl",
        "nmon",
        "iotop",
        "iptraf-ng",
        "bonnie++",
        "stress-ng"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed


def test_ssh_options(host):
    """
    Check whether required SSH options are set
    """
    options = [
        "PasswordAuthentication yes",
        "PermitRootLogin yes"
    ]
    _ssh = host.file("/etc/ssh/sshd_config")
    for _opt in options:
        assert _ssh.contains(_opt)


def test_ssh_hetzner(host):
    """
    Check whether SSH logins via password are possible
    """
    # check port
    ssh_port = host.socket("tcp://0.0.0.0:22")
    assert ssh_port.is_listening

    # check SSH configs
    ssh_files = ['/etc/ssh/sshd_config'] + [f"/etc/ssh/sshd_config.d/{x}" for x in host.file("/etc/ssh/sshd_config.d").listdir()]
    for _file in ssh_files:
        assert host.file(_file).contains('PasswordAuthentication yes') or not host.file(_file).contains('PasswordAuthentication no')


def test_firewall(host):
    """
    Check whether firewall is enabled
    """
    if host.system_info.distribution == "ubuntu":
        _service = host.service("ufw.service")
    else:
        _service = host.service("firewalld.service")
    assert _service.is_enabled
    assert _service.is_running


def test_user(host):
    """
    Check whether user exists and has valid home directory
    """
    user = host.user("user")
    home_dir = host.file(user.home)
    assert user.exists
    assert home_dir.is_directory
    assert home_dir.user == user.name


def test_user_sudo(host):
    """
    Check whether user can use use
    """
    sudo_config = host.file("/etc/sudoers")
    assert sudo_config.contains('user  ALL=(ALL)       NOPASSWD: ALL')


def test_solutions(host):
    """
    Check whether solutions have been copied
    """
    labs_dir = host.file("/labs")
    assert labs_dir.exists
    assert int(host.run("ls -r1 /labs|wc -l").stdout.strip()) > 8


def test_binaries(host):
    """
    Check additional binaries
    """
    binaries = [
        '/usr/bin/commander',
        '/usr/bin/lab'
    ]
    for _bin in binaries:
        _file = host.file(_bin)
        assert _file.exists
        assert _file.mode == 0o755


def test_directories(host):
    """
    Check if important directories exist
    """
    directories = [
        '/labs',
        '/var/labs',
        '/import/labs',
        '/ramdisk'
    ]
    for _dir in directories:
        assert host.file(_dir).is_directory
