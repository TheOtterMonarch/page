#! /bin/bash


echo "Checking your package manager..."

if command -v apt > /dev/null 2>&1; then
    echo "apt package manager"
    packageManager="apt"
    sudo apt update -y
    sudo apt-get -y install whiptail
elif command -v dnf > /dev/null 2>&1; then
    echo "dnf package manager"
    packageManager="dnf"
    sudo dnf install newt
elif command -v yum > /dev/null 2>&1; then
    echo "yum package manager"
    packageManager="yum"
    sudo yum install newt
elif command -v zypper > /dev/null 2>&1; then
    echo "zypper package manager"
    packageManager="zypper"
    sudo zypper install newt
elif command -v pacman > /dev/null 2>&1; then
    echo "pacman package manager"
    packageManager="pacman"
    sudo pacman -Sy libnewt
elif command -v xbps-install > /dev/null 2>&1; then
    echo "xbps package manager"
    packageManager="xbps-install"
    sudo xbps-install -S newt
else
    echo "No known package manager found. Your system is not compatible with this script. Press Ctrl+C to cancel."
    read
fi


whiptail --msgbox "Welcome to the Krebbler Studios set-up script! Press OK to continue." 8 78

browser=$(whiptail --title "Main Menu" --menu "Choose an option:" 15 50 10 \
    "1" "Google Chrome" \
    "2" "Microsoft Edge" \
    "3" "Vivaldi" \
    "4" "Brave" \
    "5" "Firefox" \
    "6" "Librewolf" \
    "7" "Zen Browser" \
    "8" "Chromium" \
    "9" "Floorp" 3>&1 1>&2 2>&3)

# Clear the screen
clear

# Check the selected option
case $browser in
    1)
        browser="1"
        ;;
    2)
        browser="2"
        ;;
    3)
        browser="3"
        ;;
    4)
        browser="4"
        ;;
    5)
        browser="5"
        ;;
    6)
        browser="6"
        ;;
    7)
        browser="7"
        ;;
    8)
        browser="8"
        ;;
    9)
        browser="9"
        ;;
    *)
        echo "Invalid option."
        exit
        ;;
esac


if whiptail --title "Art" --yesno "Would you like to install art tools?" 8 78; then
    art="y"
else
    art="N"
fi

clear


echo ""
echo ""
echo "Are you ready to begin setup? Press Enter to begin."
read
echo ""
echo ""


if [[ "$packageManager" == "apt" ]]; then
    # Install Flatpak
    sudo apt update
    sudo apt install -y flatpak

    # Add Flathub Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

elif [[ "$packageManager" == "dnf" ]]; then
    # Install Flatpak (Try dnf first, fallback to yum if needed)
    sudo dnf install -y flatpak

    # Add Flathub Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

elif [[ "$packageManager" == "yum" ]]; then
    # Install Flatpak (Try dnf first, fallback to yum if needed)
    sudo yum install -y flatpak

    # Add Flathub Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
elif [[ "$packageManager" == "zypper" ]]; then
    # Install Flatpak
    sudo zypper install -y flatpak

    # Add Flathub Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

elif [[ "$packageManager" == "pacman" ]]; then
    # Install Flatpak
    sudo pacman -S --noconfirm flatpak

    # Add Flathub Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

elif [[ "$packageManager" == "xbps-install" ]]; then
    # Install Flatpak
    sudo xbps-install -S flatpak

    # Add Flathub Repository
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

fi

flatpak install flathub com.github.fastfetch-cli.fastfetch -y

flatpak install flathub org.godotengine.Godot -y

flatpak install flathub com.vscodium.codium -y

flatpak install flathub io.github.shiftey.Desktop -y

flatpak install flathub im.riot.Riot

if [[ "$browser" == "1" ]]; then
    flatpak install flathub com.google.Chrome -y
elif [[ "$browser" == "2" ]]; then
    flatpak install flathub com.microsoft.Edge -y
elif [[ "$browser" == "3" ]]; then
    flatpak install flathub com.vivaldi.Vivaldi -y
elif [[ "$browser" == "4" ]]; then
    flatpak install flathub com.brave.Browser -y
elif [[ "$browser" == "5" ]]; then
    flatpak install flathub org.mozilla.firefox org.freedesktop.Platform.ffmpeg-full/x86_64/20.08 -y
elif [[ "$browser" == "6" ]]; then
    flatpak install --system flathub io.gitlab.librewolf-community -y
elif [[ "$browser" == "7" ]]; then
    flatpak install flathub io.github.zen_browser.zen -y
elif [[ "$browser" == "8" ]]; then
    flatpak install flathub org.chromium.Chromium -y
elif [[ "$browser" == "9" ]]; then
    flatpak install flathub one.ablaze.floorp -y
fi

if [[ "$art" == "y"]]; then
    flatpak install flathub com.github.libresprite.LibreSprite -y
    flatpak install flathub org.blender.Blender -y
    flatpak install flathub org.kde.krita -y
fi

echo "

Flatpak and Flathub support have been added to your system. Fastfetch, Godot, VSCodium, GitHub Desktop and Element have also been installed, alongside the browser of your choice.

If you asked for art tools to be installed, Blender, Krita and LibreSprite have also been installed."
echo "


Setup complete! You may need to manually change your default browser. Press Enter to finish."
read


