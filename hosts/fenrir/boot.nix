{ config, pkgs, ... }:

let
  edidGeneratorSrc = pkgs.fetchFromGitHub {
    owner = "akatrevorjay";
    repo = "edid-generator";
    rev = "master";
    sha256 = "02xzqib721lgmvdlvxdfndcvma9dzzavzarm81f1wm7pdrxp6v2h";
  };
  buildEdidScript = pkgs.writeText "build_edid.py" ''
    with open("1920x1080.bin.nocrc", "rb") as f:
        b = f.read()
    assert len(b) == 128, "expected 128 bytes, got %d" % len(b)
    checksum = (256 - sum(b[:127])) % 256
    with open("sunshine-1920x1080.bin", "wb") as f:
        f.write(b[:127])
        f.write(bytes([checksum]))
  '';
  edidPkg = pkgs.runCommand "edid-sunshine-1920x1080" {
    nativeBuildInputs = [
      pkgs.stdenv.cc
      pkgs.binutils
      pkgs.v4l-utils
      pkgs.python3
    ];
    src = edidGeneratorSrc;
    script = buildEdidScript;
  } ''
    cp -r $src edid-gen
    chmod -R u+w edid-gen
    cd edid-gen
    [ -f 1920x1080.S ] || cd edid-generator-*
    gcc -E -P -DCRC=0x00 1920x1080.S -o 1920x1080_prep.s
    as -o 1920x1080.o 1920x1080_prep.s
    objcopy -j .data -Obinary 1920x1080.o 1920x1080.bin.nocrc
    python3 $script
    mkdir -p $out/lib/firmware/edid
    cp sunshine-1920x1080.bin $out/lib/firmware/edid/sunshine-1920x1080.bin
  '';
in
{
  boot.extraModulePackages = [ config.boot.kernelPackages.zenpower config.boot.kernelPackages.v4l2loopback ];
  boot.kernelParams = [
    "pcie_aspm=force"
    "amdgpu.ppfeaturemask=0xffffffff"
    "amdgpu.sg_display=0"
  ];

  hardware.display.edid.packages = [ edidPkg ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="Webcam-Remota" exclusive_caps=1
  '';
  boot.kernelModules = [ "zenpower" "v4l2loopback" ];
  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
}
