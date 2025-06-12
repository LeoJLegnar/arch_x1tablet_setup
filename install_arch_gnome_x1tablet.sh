#!/bin/bash
# Script de instalación base de Arch Linux para ThinkPad X1 Tablet Gen 1
# ⚠️ Ejecutar desde el live ISO de Arch

set -e

# Variables
HOSTNAME="x1tablet"
USERNAME="leo"
DISK="/dev/sda"

# Configurar teclado y mirrorlist
loadkeys es
reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Particionado rápido (reemplaza esto si usas Btrfs o LUKS)
/usr/bin/sgdisk -Z $DISK
/usr/bin/sgdisk -n 1:0:+512M -t 1:ef00 -c 1:"EFI System Partition" $DISK
/usr/bin/sgdisk -n 2:0:0     -t 2:8300 -c 2:"Linux root" $DISK
mkfs.fat -F32 ${DISK}1
mkfs.ext4 ${DISK}2

mount ${DISK}2 /mnt
mkdir -p /mnt/boot
mount ${DISK}1 /mnt/boot

# Instalación base
pacstrap -K /mnt base linux linux-firmware gnome networkmanager sudo git grub efibootmgr

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/bash -c "
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc
sed -i 's/#es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=es_ES.UTF-8' > /etc/locale.conf
echo $HOSTNAME > /etc/hostname
echo '127.0.1.1 $HOSTNAME.localdomain $HOSTNAME' >> /etc/hosts
echo 'KEYMAP=es' > /etc/vconsole.conf
useradd -m -G wheel $USERNAME
echo '%wheel ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo 'root:changeme' | chpasswd
echo '$USERNAME:changeme' | chpasswd
systemctl enable NetworkManager gdm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
"

echo "✅ Instalación base completa. Reinicia y luego ejecuta el script de postinstalación."
