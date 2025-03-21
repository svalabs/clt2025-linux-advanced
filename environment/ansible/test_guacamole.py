"""
Deployment unit tests
Guacamole tests
"""


def test_software(host):
    """
    Check whether required software packages are installed
    """
    packages = [
        "docker-ce"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed


def test_files(host):
    """
    Check whether required files exist
    """
    _files = [
        '/usr/bin/docker-compose'
    ]
    for _file in _files:
        assert host.file(_file).exists

def test_guacamole_web(host):
    """
    Check whether the Guacamole web interface
    responds properly
    """
    ansible_vars = host.ansible('setup')
    _curl = host.run(f"curl -k https://{ansible_vars['ansible_facts']['ansible_default_ipv4']['address']}")
    assert _curl.rc == 0
    assert 'guacamole-common-js' in _curl.stdout

# TODO: test_users?
