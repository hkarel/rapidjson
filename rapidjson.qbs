import qbs
import GccUtl

Product {
    name: "RapidJson"
    targetName: "rapidjson"

    type: "staticlibrary"
    Depends { name: "cpp" }
    Depends { name: "cpufeatures" }

    cpp.archiverName: GccUtl.ar(cpp.toolchainPathPrefix)

    Properties {
        condition: qbs.architecture.startsWith("arm")
        cpp.defines: ["RAPIDJSON_NEON"]
        cpufeatures.arm_neon: true
    }
    Properties {
        condition: qbs.architecture.startsWith("x86")
        cpp.defines: ["RAPIDJSON_SSE2"]
        cpufeatures.x86_sse2: true
    }

    cpp.cxxFlags: [
        "-std=c++14",
        //"-msse4",
        "-ggdb3",
        "-Wall",
        "-Wextra",
        "-Wno-unused-parameter",
    ]
    cpp.includePaths: ["include"]

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
        cpp.defines: ["JSON_SERIALIZATION", "RAPID_JSON"]
    }
}
