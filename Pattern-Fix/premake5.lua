PROJECT_GENERATOR_VERSION = 3

newoption({
    trigger = "gmcommon",
    description = "Sets the path to the garrysmod_common (https://github.com/danielga/garrysmod_common) directory",
    value = "path to garrysmod_common directory"
})

-- newoption({
    -- trigger = "autoinstall",
    -- description = "autointsall to gmod dir",
    -- value = "boolean"
-- })

local gmcommon = assert(_OPTIONS.gmcommon or os.getenv("GARRYSMOD_COMMON"),
	"you didn't provide a path to your garrysmod_common (https://github.com/danielga/garrysmod_common) directory")
include(gmcommon)

CreateWorkspace({
    name = "Pattern_Fix", -- Not use '-' otherwise print error 'invalid macro definition'
})
	cppdialect 'C++17'
	
	CreateProject({
		serverside = false,
		source_path = "./src" -- optional
		-- manual_files = project_manual_files, -- optional
	})

	IncludeLuaShared() -- uses this repo path
	IncludeDetouring() -- uses this repo detouring submodule
	IncludeScanning() -- uses this repo scanning submodule



	CreateProject({
		serverside = true,
		source_path = "./src" -- optional
		-- manual_files = project_manual_files, -- optional
	})


	IncludeLuaShared() -- uses this repo path
	IncludeDetouring() -- uses this repo detouring submodule
	IncludeScanning() -- uses this repo scanning submodule
