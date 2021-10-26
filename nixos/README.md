I test things using:

```
sudo nixos-rebuild test -I nixos-config=machines/AsusZenbook/configuration.nix
sudo nixos-rebuild switch -I nixos-config=machines/AsusZenbook/configuration.nix
```

---

## Install

I a new system I tend to replace the entire `/etc/nixos/configuration.nix` with a single import of the configuration I need, for example for Zenbook I do:

```nix
{ config, ... }:

{
  imports = ["/home/gianarb/.dotfiles/nixos/machines/AsusZenbook/configuration.nix"];
}

```

---

## Credits

A list of NixOS configuration I often look at:

* [grahamc/nixos-config](https://github.com/grahamc/nixos-config)
* [danielfullmer/pinecube-nixos](https://github.com/danielfullmer/pinecube-nixos)
* [lovesegfault/nix-config](https://github.com/lovesegfault/nix-config)
* [balsoft/nixos-config](https://github.com/balsoft/nixos-config)
* [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config)
