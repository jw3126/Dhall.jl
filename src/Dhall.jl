module Dhall

using Pkg.Artifacts: @artifact_str
using JSON: JSON
using FileIO: @format_str, File, Stream, FileIO

const PATHS = Dict(
        "dhall"         => joinpath(artifact"dhall", "bin", "dhall"),
        "dhall-to-json" => joinpath(artifact"dhall-json", "bin", "dhall-to-json"),
        "json-to-dhall" => joinpath(artifact"dhall-json", "bin", "json-to-dhall"),
        "dhall-to-yaml" => joinpath(artifact"dhall-json", "bin", "dhall-to-yaml"),
       )

function load(f::File{format"dhall"}; kw...)
    open(f) do stream
        load(stream; kw...)
    end
end
function load(st::Stream{format"dhall"}; kw...)
    io = FileIO.stream(st)
    load_via_json(io; kw...)
end

function path_from_io(io::IO)
    re = r"<file (.*)>"
    match(re, io.name)[1]
end

function load_via_json(io::IO; dir=nothing)
    if dir == nothing
        dir = dirname(path_from_io(io))
    end
    exe = Dhall.PATHS["dhall-to-json"]
    io_out = Pipe()
    p = pipeline(Cmd(`$exe`, dir=dir), stdin=io, stdout=io_out)
    run(p)
    JSON.parse(io_out)
end

function load_via_json(path::AbstractString; kw...)
    open(path) do io_in
        load_via_json(io_in; kw...)
    end
end

end#module
