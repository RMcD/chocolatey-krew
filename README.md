# chocolatey-krew
Chocolatey Wrapper for krew.

This appears to be working.
However krew and kubectl seem to be having issues on Windows 10.
https://github.com/kubernetes-sigs/krew/issues/156
And this appears to not be fixed until after kubectl 1.16 which is currently un-released. Until this is fixed it doesn't seem approporiate to publish this to Chocolatey.


Uninstall TODO:
Have uninstall actually uninstall the plugin.
Remove the bin path from the user path.