#!/usr/bin/bash

set -e
set -u
set -o pipefail

if [ ! -e /etc/debian_version ]; then
    echo "Not a Debian distro, skipping."
    exit 0
fi

echo "Updating package index..."
sudo apt update

echo "Installing virtualization packages..."
sudo apt install -y \
    qemu-system \
    libvirt-daemon-system \
    ovmf \
    virt-manager

#echo "Enabling contrib and non-free repos..."
#sudo apt-add-repository contrib
#sudo apt-add-repository non-free

# libvirt
echo "Adding current user to libvirt group..."
sudo adduser $(whoami) libvirt

echo "Importing VM configuration..."
VM_NAME=proto-type-00-tiny10
THIS_FOLDER="$(dirname $0)"
CONF_DIR="$THIS_FOLDER/../other-configs/usr/share"

sudo cp -r "$CONF_DIR/qemu" /usr/share/

VM_CONF="$VM_NAME.xml"
cp "$CONF_DIR/$VM_CONF" .
sed -i 's/\/usr\/share\/edk2\/x64\/OVMF_VARS.4m.fd/\/usr\/share\/OVMF\/OVMF_VARS_4M.fd/g' $VM_CONF
sed -i 's/\/usr\/share\/edk2\/x64\/OVMF_CODE.4m.fd/\/usr\/share\/OVMF\/OVMF_CODE_4M.fd/g' $VM_CONF

sudo virsh define --file $VM_CONF
rm $VM_CONF

echo ""
echo "REMEMBER: edit the VM with the appropriate devices for passthrough."
echo ""
echo "All done!"

