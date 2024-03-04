{nixpkgs}: let
  inherit
    (builtins)
    attrNames
    attrValues
    concatLists
    hasAttr
    removeAttrs
    toString
    ;
  inherit
    (nixpkgs.lib)
    concatMapAttrs
    filterAttrs
    functionArgs
    hasPrefix
    isFunction
    listToAttrs
    optionalAttrs
    setDefaultModuleLocation
    setFunctionArgs
    ;
in rec {
  /*
  Partially apply a module by applying some attrs to it transparently.

  This is useful to implement modules which take ambient environment, e.g. from flake inputs,
  but where `_module.args` won't work due to infinite recursion. That is, it's like giving
  `extraArgs` / `extraSpecialArgs` except at a module level rather than configuration one, so
  the modules can be reused.

  Type: attrs -> (attrs -> attrs) -> (attrs -> attrs)
  */
  partialApplyModule = fixed: m:
    if isFunction m
    then let
      mArgs = functionArgs m;
      residualArgs = removeAttrs mArgs (attrNames fixed);
      applicableFixed = filterAttrs (k: _: hasAttr k mArgs) fixed;
      inner = args: m (args // applicableFixed);
    in
      setFunctionArgs inner residualArgs
    else m;

  /*
  Import a module from a path, map it, and return a module function like it.
  Sets the `_file` correctly, which importing would lose.

  Type: (attrs -> attrs) -> path -> (attrs -> attrs)
  */
  importAndTransformModule = transform: path:
    setDefaultModuleLocation (toString path) (transform (import path));

  /*
  Import and map a number of modules and make an attrset with an entry for each along with a
  default module importing all, using the last segment of the path as the key name for each module.

  Type: (attrs -> attrs) -> attrsOf [path] -> {attrs -> attrs}
  */
  publishModules = transform: pathsets: let
    modulePairs =
      map (path: {
        name = baseNameOf path;
        value = importAndTransformModule transform path;
      })
      (concatLists (attrValues pathsets));
    modules = listToAttrs modulePairs;
    modulesets =
      concatMapAttrs (
        name: paths:
          optionalAttrs (!(hasPrefix "_" name))
          {${name} = {imports = map (path: modules.${baseNameOf path}) paths;};}
      )
      pathsets;
  in
    modules // modulesets;
}
