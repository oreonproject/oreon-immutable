#!/bin/bash

set -ouex pipefail


# Add repositories
cat <<EOF > /etc/yum.repos.d/oreon.repo
[devel]
name=devel
baseurl=https://raw.repo.almalinux.org/almalinux/10/devel/\$basearch/os/
exclude=kpatch,kpatch-dnf,almalinux-release,anaconda,anaconda-gui,anaconda-core,anaconda-tui,anaconda-widgets,almalinux-indexhtml,almalinux-bookmarks,firefox
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10

[oreon]
name=oreon
baseurl=https://download.copr.fedorainfracloud.org/results/brandonlester/oreon-10/centos-stream-10-\$basearch/
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/brandonlester/oreon-10/pubkey.gpg
repo_gpgcheck=0

# [oreonoldrepo]
# name=oreonoldrepo
# baseurl=https://packages.boostyconnect.com/oreon-10/\$basearch/
# gpgcheck=0

# [oreonextras]
# name=oreonextras
# baseurl=https://packages.boostyconnect.com/oreon-10/extras-\$basearch/
# gpgcheck=0

[epel]
name=epel
baseurl=https://dl.fedoraproject.org/pub/epel/10/Everything/\$basearch/
gpgcheck=1
gpgkey=https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-10

[base]
name=base
baseurl=https://repo.almalinux.org/almalinux/10/BaseOS/\$basearch/os/
exclude=anaconda-live,kpatch,kpatch-dnf,almalinux-release,anaconda,anaconda-gui,anaconda-core,anaconda-tui,anaconda-widgets,almalinux-indexhtml,almalinux-bookmarks,firefox
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10


[appstream]
name=appstream
baseurl=https://repo.almalinux.org/almalinux/10/AppStream/\$basearch/os/
exclude=anaconda-live,kpatch,kpatch-dnf,almalinux-release,anaconda,anaconda-gui,anaconda-core,anaconda-tui,anaconda-widgets,almalinux-indexhtml,almalinux-bookmarks,firefox
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10

[extras]
name=extras
baseurl=https://repo.almalinux.org/almalinux/10/extras/\$basearch/os/
exclude=anaconda-live,kpatch,kpatch-dnf,almalinux-release,anaconda,anaconda-gui,anaconda-core,anaconda-tui,anaconda-widgets,almalinux-indexhtml,almalinux-bookmarks,firefox
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10

[crb]
name=crb
baseurl=https://repo.almalinux.org/almalinux/10/CRB/\$basearch/os/
exclude=anaconda-live,kpatch,kpatch-dnf,almalinux-release,anaconda,anaconda-gui,anaconda-core,anaconda-tui,anaconda-widgets,almalinux-indexhtml,almalinux-bookmarks,firefox
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-10

[backports]
name=backports
baseurl=https://download.copr.fedorainfracloud.org/results/brandonlester/oreon-10-backports/centos-stream-9-\$basearch/
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/brandonlester/oreon-10-backports/pubkey.gpg
repo_gpgcheck=0
EOF

# Install packages (remove unwanted, install wanted)
dnf remove -y setroubleshoot
rpm -e --nodeps almalinux-release setup sudo almalinux-repos
dnf install --releasever=10 -y oreon-repos oreon-logos oreon-release oreon-backgrounds \
  gnome-shell-extension-dash-to-panel-oreon \
  gnome-shell-extension-arc-menu-oreon \
  gnome-shell-extension-blur-my-shell-oreon \
  gnome-shell-extension-desktop-icons \
  gnome-shell-oreon-theming \
  oreon-shell-theme \
  kernel-devel dracut-live python3-crypt-r memtest86+ \
  anaconda anaconda-install-env-deps anaconda-live anaconda-webui \
  livesys-scripts epel-release fuse xdg-utils atheros-firmware

echo "Configuration complete."

systemctl enable podman.socket
