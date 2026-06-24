# Flake de Denis Pilar para NixOS

Este es mi flake personal donde guardo mis configuraciones de NixOS. Está
estructurado usando `flake-parts` e `import-tree`, y además tiene soporte para
usar `wrapper-modules`. Pero no usa Home Manager porque varios programas todavía
los gestiono mediante 'dotfiles'.

Algunos módulos no los utilizo en mis _host_, pero los mantengo como un recuerdo
o por si los llego a necesitar en un futuro.

## Instalación

Para instalarlo hay que seguir una serie de pasos.

### 1. Instalar algunas herramientas

``` bash
nix-shell -p neovim git nh
```

### 2. Clonar el repositorio

``` bash
git clone https://github.com/Nekoffeedrinker/denisNixOS.git ~/denisNixOS/
```

### 3. Activar flakes en la maquina actual

Hay que añadir esta linea a `/etc/nixos/configuration.nix`:

``` nix
nix.settings.experimental-features = ["nix-command" "flakes"];
```

Y ejecutar `sudo nixos-rebuild switch`.

### 4. Adecuar el hardware del host actual en el flake

En `./modules/hosts/` están las instlalaciones que podemos usar. Dentro de la respectiva carpeta del host que elejimos, hay que modificar el `hardware.nix` para que coincida con la instalación de Nix actual (es decir, la que está en `/etc/nixos/`).

Temporalmente, también se puede importar esa configuración local modificando
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

### 5. Ejecutar la instalación

``` bash
nh os boot ~/denisNixOs -H thinkpadx13 -a --impure
```

- Pero remplazando el host para que coincida con el de tu maquina.
- `--impure` solo es necesario cuando hay rutas absolutas en los `imports`. Si se modifica `hardware.nix` como se mencionó antes, no será necesario.

Y cuando termine, reiniciamos

``` bash
reboot
```

## Cambiar el remote a ssh

Ver el remote actual
``` bash
git remote -v
```

Cambiar el remote
``` bash
git remote set-url origin git@github.com:Nekoffeedrinker/denisNixOS.git
```
