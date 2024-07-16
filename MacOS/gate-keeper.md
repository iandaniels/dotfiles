# Gatekeeper

If gatekeeper is stopping a program from loading and the app isn't signed, then you can remove
the gatekeeper attribute as follows:

```
sudo xattr -dr com.apple.quarantine .
```

