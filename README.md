# Flake de Denis Pilar para NixOS

Este es mi flake personal donde guardo mis configuraciones de NixOS. Está
estructurado usando `flake-parts` e `import-tree`, y además tiene soporte para
usar `wrapper-modules`. Pero no usa Home Manager porque varios programas todavía
los gestiono mediante 'dotfiles'.

Algunos módulos no los utilizo en mis _host_, pero los mantengo como un recuerdo
o por si los llego a necesitar en un futuro.

## Instalación

Para instalarlo será necesario clonar el repo:

``` bash
git clone git@github.com:Nekoffeedrinker/denisNixOS.git ~/denisNixOS/
```

Luego hay que modificar el `hardware.nix` de la maquina host para que coincida
con la instalación de Nix actual.

Temporalmente, también se puede importar la configuración local modificando
`configuration.nix` de la siguiente manera:

``` nix
    imports = [
      /etc/nixos/hardware-configuration.nix
      # self.nixosModules.thinkpadx13Hardware
      self.nixosModules.thinkpadx13Programs
      self.nixosModules.indispensable
      # ...
    ];
```

Como podrás observar en el ejemplo de `thinkpadx13`, se hace el import desde la
ruta absoluta y además se pone como comentario el modulo de hadware que está en
el flake, para evitar conflictos.

Y para ejecutar la instalación usarás:

``` bash
sudo nixos-rebuild boot --impure --flake ~/denisNixOS --target-host thinkpadx13
```

Pero remplazando el host para que coincida con el de tu maquina.
