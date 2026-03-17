{
  description = "NixOS + Home Manager (multi-host) with agenix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nvchad4nix, agenix, ... }@inputs:
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
        extraSpecialArgs = { inherit unstable nvchad4nix agenix; };
        users.tux = import hostHome;
        backupFileExtension = "backup";
      };
    };

    commonModules = [
      home-manager.nixosModules.home-manager
    ];

    fenrirModules = commonModules ++ [
      ./hosts/fenrir.nix
      (homeManagerModule ./hosts/fenrir/home/flake.nix)
    ] ++ (if builtins.pathExists ./hosts/fenrir/hardware-configuration.nix then [ ./hosts/fenrir/hardware-configuration.nix ] else []);

    huginnModules = commonModules ++ [
      ./hosts/huginn.nix
      (homeManagerModule ./hosts/huginn/home/flake.nix)
    ] ++ (if builtins.pathExists ./hosts/huginn/hardware-configuration.nix then [ ./hosts/huginn/hardware-configuration.nix ] else []);

  in
  {
    nixosConfigurations.FENRIR = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs unstable; };
      modules = fenrirModules;
    };

    nixosConfigurations.HUGINN = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs unstable; };
      modules = huginnModules;
    };
  };
}
