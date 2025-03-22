{
  inputs.dogrules.url = "git+file://../";
  inputs.flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*";

  outputs = {...}@inputs: {
    schemas = inputs.dogrules.schemas;
    buildPlatforms = ["aarch64-darwin"];
    targetPlatforms = ["x86_64-linux"];
    hostPlatforms = ["armv7l-linux"];
  };
}
