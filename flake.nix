{
  description = " install  Packet Tracer 7";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; 
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.ciscoPacketTracer7 = nixpkgs.legacyPackages.x86_64-linux.ciscoPacketTracer7;

    packages.x86_64-linux.default = self.packages.x86_64-linux.ciscoPacketTracer7;
  };
}
