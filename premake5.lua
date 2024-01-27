-- premake5.lua
-- Refer to: https://github.com/premake/premake-core/wiki/Tutorial-Premake-example-with-GLFW-and-OpenGL
workspace "folium"
   architecture "x64"
   configurations { "Debug", "Release", "Dist" }
   startproject "folium-app"

   -- Workspace-wide build options for MSVC
--    filter "system:windows"
--       buildoptions { "/EHsc", "/Zc:preprocessor", "/Zc:__cplusplus" }

outputdir = "%{cfg.system}-%{cfg.architecture}/%{cfg.buildcfg}"

-- Config filters
filter "configurations:Debug"
    defines { "DEBUG" }
    runtime "Debug"
    symbols "On"

filter "configurations:Release"
    defines { "RELEASE" }
    runtime "Release"
    optimize "On"
    symbols "On"

filter "configurations:Dist"
    kind "WindowedApp"
    defines { "DIST" }
    runtime "Release"
    optimize "On"
    symbols "Off"

-- This function includes GLFW's header files
function includeGLFW()
	includedirs "lib/glfw/include"
end

function includeImGUI()
    files { 
        "lib/imgui/**.cpp",
        "lib/imgui/**.h",
    }
    
    vpaths { ["imgui"] = "lib/imgui/**" }
    includedirs {
        "lib/imgui",
        -- "lib/imgui/backends",
    }
end

-- This function links statically against GLFW
function linkGLFW()
	libdirs "lib/glfw/lib-vc2022"

	-- Our static lib should not link against GLFW
	filter "kind:not StaticLib"
		links "glfw3"
	filter {}
end

-- GUI code
project "folium-gui"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"
    staticruntime "off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin/obj/" .. outputdir .. "/%{prj.name}")

    files {
        "gui/*.cpp",
        "gui/*.h",
    }
    vpaths { ["gui"] = "gui/**" }

    includeGLFW()
    includeImGUI()
    

project "folium-app"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    staticruntime "off"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin/obj/" .. outputdir .. "/%{prj.name}")

    files {
        "src/*.cpp",
        "src/*.h",
    }
    vpaths { ["src"] = "src/**" }

    includeGLFW()
    includeImGUI()

    includedirs {
        "gui/",
    }
    
    linkGLFW()
    links "folium-gui"
    -- links "folium-gui.lib"
    -- libdirs { "bin/windows-x86_64/%{cfg.buildcfg}/folium-gui", }

    -- Additional system based linking/settings
    filter { "system:windows" }
		links { "OpenGL32" }
        ignoredefaultlibraries { "MSVCRT" }
        systemversion "latest"
        defines { }

	filter { "system:not windows" }
		links { "GL" }
