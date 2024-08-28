{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
 #    <home-manager/nixos>
    ];
  
  nix = {
         # Garbage colletcor\
       gc = {
         automatic = true;
         dates = "weekly";
         options = "--delete-older-than 1w";
       };
   
       settings = {
         # Enable flakes and new 'nix' command
         experimental-features = "nix-command flakes";
         # Deduplicate and optimize nix store
         auto-optimise-store = true;
       };
     };
    nixpkgs.config.allowUnfree = true;

 #home-manager.useUserPackages = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Определите ваше имя хоста.
  networking.networkmanager.enable = true; # Включите сетевое соединение.
  
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.blueman.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.pppo = {
    isNormalUser = true;
    description = "pppo";
    extraGroups = [ "networkmanager" "wheel" ];
    home = "/home/pppo";
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

   
 
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    telegram-desktop
    sigil
    megacmd
    micro
    libreoffice
    vscode-with-extensions
    git
	bluez
    blueman
	htop
	nnn
	mc
  # ciscoPacketTracer8
	vlc
	clementine
    gns3-server
    gns3-gui
    dynamips
    libvirt
  ];

  #nixpkgs.config.allowUnfree = true;

  system.stateVersion = "nixos-unstable"; # Ветка



 # Некондиционные пакеты
  nixpkgs.config.allowUnfree = true;
  

 
 # Удалить все, кроме n последних системных профилей
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true; # Если хотите автоматически перезагружать систему после обновления
 # system.autoUpgrade.n = 5; # Количество сохраняемых версий

  # Fonts.
  fonts.packages = with pkgs; [
    jetbrains-mono

    noto-fonts-color-emoji
    noto-fonts-emoji
    noto-fonts-cjk
    noto-fonts

    dejavu_fonts

    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ];

  
}
