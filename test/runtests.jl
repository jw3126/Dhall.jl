using Dhall
using Test

@testset "Dhall.jl" begin
    for (name, path) in pairs(Dhall.PATHS)
        @test ispath(path)
        @test isfile(path)
        version = read(`$path --version`, String)
        @show name
        @show version
        @show path
    end
end
