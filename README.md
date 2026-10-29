# vendor_rbe

RBE (remote builds via BuildBuddy) auto-hook for Build Aosp

This repo syncs as `vendor/rbe/` inside a Aosp Root. AOSP `build/envsetup.sh`
automatically executes every `vendorsetup.sh`, so RBE is enabled on every
`source build/envsetup.sh`.

### 1. Add the RBE local manifest

```bash
mkdir -p .repo/local_manifests
curl -fsSL https://raw.githubusercontent.com/kibria5/vendor_rbe/main/rbe.xml \
  -o .repo/local_manifests/rbe.xml

repo sync vendor/rbe
```

### 2. Configure BuildBuddy authentication

Set your BuildBuddy API key before enabling the build environment.

```bash
export BUILDBUDDY_API_KEY="YOUR_BUILDBUDDY_API_KEY"
```

### 3. Initialize the Build Environment

```bash
source build/envsetup.sh
```

## Verify

```bash
source build/envsetup.sh   # expect: including vendor/rbe/vendorsetup.sh
echo $USE_RBE              # expect: 1
echo $RBE_DIR              # expect: /home/username/aosp_root/prebuilts/remoteexecution-client/buildbuddyfix
```