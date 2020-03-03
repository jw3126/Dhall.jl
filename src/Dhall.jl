module Dhall

using Pkg.Artifacts: @artifact_str

const PATHS = Dict(
    "dhall" => joinpath(artifact"dhall", "bin", "dhall"),
    "dhall-to-json" => joinpath(artifact"dhall-json", "bin", "dhall-to-json"),
    "json-to-dhall" => joinpath(artifact"dhall-json", "bin", "json-to-dhall"),
    "dhall-to-yaml" => joinpath(artifact"dhall-json", "bin", "dhall-to-yaml"),
   )

end#module
