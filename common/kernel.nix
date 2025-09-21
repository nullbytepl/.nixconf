{ cpuArch ? "x86-64-v2", usesNv ? false, config, pkgs, lib, ...}:
let
  llvmKernelStdenv =
    pkgs.stdenvAdapters.overrideInStdenv pkgs.llvmPackages.stdenv [
      pkgs.llvm
      pkgs.lld
    ];

  kernel = pkgs.linuxKernel.kernels.linux_latest.override {
    name = "linux-kernel-latest-opt-${cpuArch}";
    modDirVersion = pkgs.linuxKernel.kernels.linux_latest.modDirVersion + "-opt-${cpuArch}";
    extraMakeFlags = [
      "KCFLAGS+=-O3"
      "KCFLAGS+=-mtune=${cpuArch}"
      "KCFLAGS+=-march=${cpuArch}"
      "KCFLAGS+=-Wno-unused-command-line-argument"
      "CC=${pkgs.llvmPackages.clang-unwrapped}/bin/clang"
      "AR=${pkgs.llvm}/bin/llvm-ar"
      "NM=${pkgs.llvm}/bin/llvm-nm"
      "LD=${pkgs.lld}/bin/ld.lld"
      "LLVM=1"
    ];

    stdenv = llvmKernelStdenv;

    defconfig = "defconfig LLVM=1 ARCH=x86_64";

    structuredExtraConfig = with lib.kernel; {
      CC_IS_CLANG = lib.mkForce yes;
      LTO = lib.mkForce yes;
      LTO_CLANG = lib.mkForce yes;
      LTO_CLANG_THIN = lib.mkForce yes;
    };

    ignoreConfigErrors = true; # "error: unused option: RUST"
  };

  linuxPackages_custom =  (pkgs.linuxPackagesFor kernel).extend (kfinal: kprev: {
    systemtap = kprev.systemtap.overrideAttrs (old: {
      stapBuild = old.stapBuild.overrideAttrs (oldStap: {
        configureFlags = (oldStap.configureFlags or []) ++ [ "--disable-Werror" ];
      });
    });

    perf = kprev.perf.overrideAttrs (old: {
      makeFlags = (old.makeFlags or []) ++ [
        # Just build it with GCC..
        "CC=${pkgs.stdenv.cc}/bin/gcc"
      ];
    });

    zenpower = kprev.zenpower.overrideAttrs (old: {
      makeFlags = (old.makeFlags or []) ++ [
        # Just build it with GCC..
        "CC=${pkgs.stdenv.cc}/bin/gcc"
      ];
    });
  });

in {

  boot.kernelPackages = linuxPackages_custom;

  hardware.nvidia = lib.mkIf (usesNv) {
    package = config.boot.kernelPackages.nvidiaPackages.latest.overrideAttrs (old: {
      passthru = old.passthru // {
        open = old.passthru.open.overrideAttrs (o: {
          makeFlags = (o.makeFlags or []) ++ [
            "CC=${pkgs.llvmPackages.clang-unwrapped}/bin/clang"
            "KCFLAGS+=-isystem ${pkgs.glibc.dev}/include"
            "KCFLAGS+=-Wno-implicit-function-declaration"
          ];
        });
      };
    });
  };

  boot.extraModulePackages = lib.mkIf (usesNv) [ config.hardware.nvidia.package ];
}
