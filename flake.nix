{
  inputs.flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*";
  inputs.nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
  inputs.systems.url = "github:nix-systems/default";
  #inputs.flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/0.1.369.tar.gz";
  #inputs.nix-unit.url = "github:nix-community/nix-unit";

  outputs = {self, ... }@inputs:
    #inputs.flake-parts.lib.mkFlake { inherit inputs; } ({...}:
    let
      lib = inputs.nixpkgs-lib.lib;
      inherit (builtins)
        all
        isList
        tryEval
        ;
      inherit (lib)
        genAttrs
        systems
        concatStringsSep
        ;
      mkPlatformSchema = type: {
        version = 1;
        doc = ''
          The `${type}` flake output defines the system doubles this flake expects to work with.
        '';
        inventory = output:
          if !isList output then throw "unsupported '${type}' type"
          else
            {
              what = "${concatStringsSep ", " output}";
              evalChecks.allElaborate = all (x: x.success == true) (map (x: tryEval (systems.elaborate x)) output);
            };
      };
      localSchema = (inputs.flake-schemas).schemas // genAttrs [
        "buildPlatforms"
        "targetPlatforms"
        "hostPlatforms"
      ]
      mkPlatformSchema;

      #mkDummyFlake = testCaseName: {
      #    inputs = {
      #      dogrules.url = "${builtins.storePath self}";
      #      flake-schemas.url = "${builtins.storePath inputs.flake-schemas}";
      #    };
      #    outputs = inputs.flake-parts.lib.mkFlake { inputs = {}; }({...}:{ systems = [ "aarch64-darwin" ]; flake.foo = "bar"; });
      #};

    in
    {
      #systems = import inputs.systems;
      #imports = [
      #  inputs.nix-unit.modules.flake.default
      #];
      #perSystem = {config,pkgs,...}: {
      #  #packages.testFiles =
      #};
      #flake = {
      #  inherit mkDummyFlake;
        schemas = lib.mergeAttrs inputs.flake-schemas.schemas localSchema;
      #  tests.testBar = {
      #    expr = "bar";
      #    expected = "bar";
      #  };
      #};
    }
    #)
    ;
}
