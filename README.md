# Kodi from Debian - Nightly Repository

This is the unofficial binary repository of Kodi 20.0 "Nexus" targeting Debian 11 "bullseye".

Supported architectures for now include only amd64 and i386 (32-bit and 64-bit x86 CPUs, like Intel or AMD)

## Note for Debian 10 "buster" users

The packages for buster-backports were removed in favor of official backports available from Debian backports

To migrate Kodi 19.0 setup from this repository to official backports:

1. Download the migration script:

    ```shell
    curl -L -O -J https://basilgello.github.io/kodi-nightly-debian-repo/buster-migration-script.sh
    ```

2. (OPTIONALLY) Download and verify GPG signature of script:

    ```shell
    curl -L -O -J https://basilgello.github.io/kodi-nightly-debian-repo/repository-key.asc
    curl -L -O -J https://basilgello.github.io/kodi-nightly-debian-repo/buster-migration-script.sh.asc
    gpg --import repository-key.asc
    gpg --verify buster-migration-script.sh.asc buster-migration-script.sh

    ```

3. Run migration script as root:

   ```shell
   sudo sh buster-migration-script.sh
   ```

4. Reboot computer!

## Contact

This repository is maintained by Vasyl Gello <vasek.gello@gmail.com>.
