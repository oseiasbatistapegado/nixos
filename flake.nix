{
  description = "NixOS + Home Manager (multi-host)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    homeManagerModule = hostHome: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit unstable; };
        users.tux = import hostHome;
        backupFileExtension = "backup";
      };
    };
    # Hardware config é gerado por host; só inclui se o arquivo existir (nixos-generate-config --dir hosts/<host>)
    fenrirModules = [
      ./hosts/fenrir.nix
      home-manager.nixosModules.home-manager
      (homeManagerModule ./modules/home/tux-fenrir.nix)
    ] ++ (if builtins.pathExists ./hosts/fenrir/hardware-configuration.nix then [ ./hosts/fenrir/hardware-configuration.nix ] else []);
    huginnModules = [
      ./hosts/huginn.nix
      home-manager.nixosModules.home-manager
      (homeManagerModule ./modules/home/tux-huginn.nix)
    ] ++ (if builtins.pathExists ./hosts/huginn/hardware-configuration.nix then [ ./hosts/huginn/hardware-configuration.nix ] else []);
  in
  {
    nixosConfigurations.FENRIR = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = fenrirModules;
    };

    nixosConfigurations.HUGINN = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = huginnModules;
    };
  };
}
