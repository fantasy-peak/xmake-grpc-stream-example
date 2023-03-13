package("grpc")
    set_homepage("https://github.com/grpc/grpc.git")
    set_description("The C based gRPC (C++, Python, Ruby, Objective-C, PHP, C#)")
    set_license("Apache-2.0 License")

    add_urls("https://github.com/grpc/grpc/archive/refs/tags/$(version).tar.gz")
    add_versions("v1.50.2", "e941752638a92f21e27566903e1eb9b4a6380d70ca5ce91116b4cff6cb8fe2f2")

    add_deps("cmake")

    add_deps("abseil", {system=false})
    add_deps("c-ares", {system=false})
    add_deps("protobuf-cpp", {system=false})
    add_deps("re2", {system=false})
    add_deps("openssl", {system=false})
    add_deps("zlib", {system=false})

    on_install("linux", function (package)
        local configs = {"-DCMAKE_INSTALL_PREFIX=" ..package:installdir()}
        table.insert(configs, "-DCMAKE_CXX_STANDARD=17")
        table.insert(configs, "-DgRPC_INSTALL=ON")
        table.insert(configs, "-DCMAKE_BUILD_TYPE=Release")
        table.insert(configs, "-DgRPC_BUILD_TESTS=OFF")
        table.insert(configs, "-DCMAKE_INSTALL_LIBDIR=lib")
        -- table.insert(configs, "-DABSL_PROPAGATE_CXX_STD=TRUE")
        table.insert(configs, "-DgRPC_ABSL_PROVIDER=package")
        table.insert(configs, "-DgRPC_CARES_PROVIDER=package")
        table.insert(configs, "-DgRPC_PROTOBUF_PROVIDER=package")
        table.insert(configs, "-DgRPC_RE2_PROVIDER=package")
        table.insert(configs, "-DgRPC_SSL_PROVIDER=package")
        table.insert(configs, "-DgRPC_ZLIB_PROVIDER=package")
        import("package.tools.cmake").install(package, configs)
    end)
package_end()
