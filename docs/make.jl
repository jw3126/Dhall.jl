using Dhall
using Documenter

makedocs(;
    modules=[Dhall],
    authors="Jan Weidner <jw3126@gmail.com>",
    repo="https://github.com/jw3126/Dhall.jl/blob/{commit}{path}#L{line}",
    sitename="Dhall.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jw3126.github.io/Dhall.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jw3126/Dhall.jl",
)
