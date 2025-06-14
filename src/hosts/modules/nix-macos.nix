{
  config,
  pkgs,
  lib,
  ...
}: {
  # Log access to the linux builder
  launchd.daemons.linux-builder = {
    serviceConfig = {
      StandardOutPath = "/var/log/darwin-builder.log";
      StandardErrorPath = "/var/log/darwin-builder.log";
    };
  };

  nix = {
    enable = true;

    linux-builder = {
      enable = true;
      systems = ["aarch64-linux"];
      #config = {
      #  virtualisation.cores = 4;
      #  services.openssh.enable = true;
      #};
    };

    gc = {
      interval = {
        Hour = 23;
        Minute = 55;
      };
      options = "--delete-older-than 14d";
    };

    settings = {
      substituters = ["s3://mdots?endpoint=https://s3.fr-par.scw.cloud/&region=fr-par"];
      trusted-public-keys = ["mdots:h40b7TWhz9PqO04aqOAiAEEdulJ2Q9oJ3MxXQCgQVvs="];
      trusted-users = ["m"];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      keep-failed = false
      keep-going = true
      builders-use-substitutes = true
    '';

    distributedBuilds = true;

    buildMachines = [
      {
        hostName = "purism";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        maxJobs = 4;
        supportedFeatures = ["kvm"];
      }
    ];
  };
}
