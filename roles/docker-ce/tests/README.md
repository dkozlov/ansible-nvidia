# Ansible Role tests

To run the test playbook(s) in this directory:

  1. Install and start Docker.
  1. Download the test shim (see .travis.yml file for the URL) into `tests/test.sh`:
    - `wget -O tests/test.sh https://gist.githubusercontent.com/dkozlov/3924db91c128ffbc454fa6d3581ce891/raw/`
  1. Make the test shim executable: `chmod +x tests/test.sh`.
  1. Run (from the role root directory) `distro=[distro] playbook=[playbook] ./tests/test.sh`

If you don't want the container to be automatically deleted after the test playbook is run, add the following environment variables: `cleanup=false container_id=$(date +%s)`
