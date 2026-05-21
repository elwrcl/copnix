{ ... }:

{
  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:X:X:X"; # change to your AMD GPU's bus ID, e.g. "PCI:1:0:0"
    nvidiaBusId = "PCI:X:X:X"; # change to your NVIDIA GPU's bus ID, e.g. "PCI:2:0:0"
  };
}
