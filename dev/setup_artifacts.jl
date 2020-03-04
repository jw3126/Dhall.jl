using Pkg.Artifacts
using Pkg.GitTools
using Pkg.PlatformEngines
using Pkg.PlatformEngines: sha256
using Pkg

Pkg.PlatformEngines.probe_platform_engines!()

function bind!(toml, item; force=false)
    h = artifact_hash(item.name, toml)
    if force && (h != nothing) && ispath(artifact_path(h))
        rm(path, recursive=true)
    end
    h_tar = nothing
    if h == nothing
        h = create_artifact() do artifact_dir
            @info "Creating artifact $item"
            tarball = download(item.url, joinpath(tempdir(), "$(item.name).tar.bz2"))
            try
                h_tar = open(tarball) do io
                    bytes2hex(sha256(io))
                end
                unpack(tarball, artifact_dir)
            finally
                rm(tarball)
            end
        end
        bind_artifact!(toml, item.name, h;
                   download_info=[(item.url, h_tar)],
                   lazy=true,
                   force=true)
        @info "At path $(artifact_path(h))"
    end
    @info "Skipping existing artifact $item"
    h
end

toml = joinpath(@__DIR__, "..", "Artifacts.toml")
for item in [
             (name="dhall", url="https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-1.30.0-x86_64-linux.tar.bz2"),
             (name="dhall-json", url="https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-json-1.6.2-x86_64-linux.tar.bz2"),
            # (name="dhall-bash", url="https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-bash-1.0.28-x86_64-linux.tar.bz2"),
             (name="dhall-yaml", url="https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-yaml-1.0.2-x86_64-linux.tar.bz2")
            ]
    bind!(toml, item)
end
