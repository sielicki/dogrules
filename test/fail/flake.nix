{
  inputs.dogrules.url = "git+file://../";
  inputs.flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*";

  outputs = {...}@inputs: {
    schemas = inputs.dogrules.schemas;
    buildPlatforms = ["aaaaaaaaaaaaaarch64-darwin"];
    targetPlatforms = ["xxxxxxxxxxx86_64-linux"];
    hostPlatforms = ["aaaaaaaaaaaaarmv7l-linux"];
  };
}
