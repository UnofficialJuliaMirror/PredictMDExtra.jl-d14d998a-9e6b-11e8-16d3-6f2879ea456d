##### Beginning of file

import Pkg

function _package_list()::Vector{String}
    project_toml::String = package_directory("Project.toml",)
    test_project_toml::String = package_directory("test", "Project.toml",)
    package_list::Vector{String} = sort(
        unique(
            strip.(
                vcat(
                    collect(
                        keys(Pkg.TOML.parsefile(project_toml)["deps"])
                        ),
                    collect(
                        keys(Pkg.TOML.parsefile(test_project_toml)["deps"])
                        ),
                    )
                )
            )
        )
    return package_list
end

function _print_list_of_package_imports(io::IO = stdout)::Nothing
    package_list = sort(unique(_package_list()))
    println("##### Beginning of file")
    println()
    for i = 1:length(package_list)
        println(io, "import $(package_list[i])",)
    end
    println()
    println("##### End of file")
    return nothing
end

##### End of file
