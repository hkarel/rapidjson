import qbs

Product {
    name: "RapidJson"
    targetName: "rapidjson"

    type: "staticlibrary"

    Depends { name: "cpp" }
    Depends { name: "cpufeatures" }

    Properties {
        condition: qbs.architecture.startsWith("arm")
        cpp.defines: ["RAPIDJSON_NEON"]
        cpufeatures.arm_neon: true
    }
    Properties {
        condition: qbs.architecture.startsWith("x86")
        cpp.defines: ["RAPIDJSON_SSE42"]
        cpufeatures.x86_sse4_2: true
    }

    cpp.cxxFlags: [
        //"-msse4",
        "-ggdb3",
        "-Wall",
        "-Wextra",
        "-Wno-unused-parameter",
    ]
    cpp.includePaths: ["include"]
    cpp.cxxLanguageVersion: "c++17"

    files: [
        "include/rapidjson/error/*.h",
        "include/rapidjson/internal/*.h",
        "include/rapidjson/msinttypes/*.h",
        "include/rapidjson/*.h",
    ]
    Export {
        Depends { name: "cpp" }
        Depends { name: "cpufeatures" }
        cpp.includePaths: ["include"]
        cpp.defines: ["RAPID_JSON"]
    }
}
