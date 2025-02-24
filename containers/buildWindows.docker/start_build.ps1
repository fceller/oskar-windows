# (c) ArangoDB, 2025

Write-Output "ArangoDB build latest started!"

git clone --recurse-submodules --jobs 8 https://github.com/arangodb/arangodb

cmake --fresh -G "Visual Studio 17 2022" -B ./build-arangodb/ -S ./arangodb/  --preset community -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld-link" -DSKIP_PACKAGING=TRUE -DUSE_JEMALLOC=FALSE -DUSE_LIBUNWIND=FALSE

cmake --build ./build-arangodb/ --target arangod