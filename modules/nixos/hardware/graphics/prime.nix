{ ... }:

{
  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:X:X:X";
    nvidiaBusId = "PCI:X:X:X";
  };
}
