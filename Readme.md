# Modern CMake and CUDA Example
This is an example of a simple CUDA project which is built using modern CMake (>= 3.12) tooling.

## Building on Windows 10
CMake 3.12 or greater is required.

Note: This is due to a workaround for a lack of compatability between CUDA 9.2 and the latest Visual Studio 2017 (15.8 at time of writing). CUDA requires the Visual Studio compiler toolset to be <= to the version shipped with Visual Studio 2017 version 15.6. To work around this, we can install the [older toolset side-by-side](https://blogs.msdn.microsoft.com/vcblog/2017/11/15/side-by-side-minor-version-msvc-toolsets-in-visual-studio-2017/) with our current Visual Studio installation.

```
PS> cmake --version
cmake version 3.12.1
# Ensure you're using 3.12 or greater!
```

We now configure CMake and specify to use the 14.13 toolset version, which is the latest known version compatible with CUDA 9.2.

```
PS> cmake . -Bbuild -G"Visual Studio 15 2017 Win64" -T"version=14.13"
```

Now, you can either open the `.sln` file in the `build/` directory and build with Visual Studio, or you can build form the command line.

```
PS> cd build
PS> cmake --build .
PS> .\Debug\cmake_cuda.exe
1, 0
2, 0
2, 5
5, 5
0, 10
```

### A note on Visual Studio 2017 CMake Support
At the time of writing, Visual Studio ships with a custom CMake version of CMake 3.11 which does not support the `-T version=xyz` flag.

For this reason, it is recommended to configure with a locally installed CMake as above, and then open the solution in Visual Studio 2017.
