using Dhall
using Test
using FileIO


function load(path::AbstractString)
    # TODO delete this function after registration
    f = FileIO.File(FileIO.format"dhall", path)
    Dhall.load(f)
end

function testdatapath(args...)
    joinpath(@__DIR__, "assets", args...)
end

@testset "load" begin
    @test load(testdatapath("hello_world.dhall")) == ["hello", "world"]
    @test load(testdatapath("hello_world2.dhall")) == ["hello", "world"]
end

@testset "smoketest executables $name" for (name, path) in pairs(Dhall.PATHS)
    @test ispath(path)
    @test isfile(path)
    version = read(`$path --version`, String)
    @show version
end
