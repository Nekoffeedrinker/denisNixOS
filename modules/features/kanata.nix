{...}: {
  flake.nixosModules.kanata = {...}: {
    # Configuración de Kanata para caps -> esc+ctrl
    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
                caps)

            (defalias
                escctrl (tap-hold 200 200 esc lctrl))

            (deflayer base
                @escctrl)
          '';
        };
      };
    };
  };
}
# --------------- IMPORTANTE ---------------
# Hay que establecer el teclado que usará kanata en el host.
# El nombre del teclado se obtiene con:
#
#       ls -l /dev/input/by-path/
#
# Ahí buscaremos alguno que contenga 'kbd'.
# Ejemplo:
#
# services.kanata.keyboards.internalKeyboard.devices = [
#   "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
# ];
