#!/bin/bash

echo "[RBE] Enabling RBE Configuration..."

# --- One-time Setup Script Executions ---
if [ ! -d "tutorial" ]; then
    git clone https://github.com/7jari/new_rbe_fix.git tutorial
fi

if [ ! -f ".rbe_patched" ]; then
    bash tutorial/scripts/build_patched_reclient.sh . && touch .rbe_patched
fi

if ! patch --dry-run -R -p1 < tutorial/patches/android-rbe-buildbuddyfix-defaults.patch >/dev/null 2>&1; then
    patch -p1 < tutorial/patches/android-rbe-buildbuddyfix-defaults.patch
fi

# --- Enable CCACHE
export USE_CCACHE=1

# --- Enable RBE and General Settings ---
export USE_RBE=1
export RBE_DIR="$PWD/prebuilts/remoteexecution-client/buildbuddyfix"
export NINJA_REMOTE_NUM_JOBS=80

# --- BuildBuddy Connection Settings ---
export RBE_service="remote.buildbuddy.io:443"
export RBE_remote_headers="x-buildbuddy-api-key=$BUILDBUDDY_API_KEY"
export RBE_service_no_auth=true
export RBE_use_rpc_credentials=false

# --- Unified Downloads/Uploads
export RBE_use_unified_downloads=true
export RBE_use_unified_uploads=true

# --- Execution Strategies ---
export RBE_R8_EXEC_STRATEGY=remote_local_fallback
export RBE_D8_EXEC_STRATEGY=remote_local_fallback
export RBE_JAVAC_EXEC_STRATEGY=remote_local_fallback
export RBE_JAR_EXEC_STRATEGY=remote_local_fallback
export RBE_ZIP_EXEC_STRATEGY=remote_local_fallback
export RBE_TURBINE_EXEC_STRATEGY=remote_local_fallback
export RBE_SIGNAPK_EXEC_STRATEGY=remote_local_fallback
export RBE_CXX_EXEC_STRATEGY=remote_local_fallback
export RBE_CXX_LINKS_EXEC_STRATEGY=remote_local_fallback
export RBE_ABI_LINKER_EXEC_STRATEGY=remote_local_fallback
export RBE_CLANG_TIDY_EXEC_STRATEGY=remote_local_fallback
export RBE_METALAVA_EXEC_STRATEGY=remote_local_fallback
export RBE_LINT_EXEC_STRATEGY=remote_local_fallback

# --- Enable RBE for Specific Tools ---
export RBE_R8=1
export RBE_D8=1
export RBE_JAVAC=1
export RBE_JAR=1
export RBE_ZIP=1
export RBE_TURBINE=1
export RBE_SIGNAPK=1
export RBE_CXX_LINKS=1
export RBE_CXX=1
export RBE_ABI_LINKER=1
export RBE_CLANG_TIDY=1
export RBE_METALAVA=1
export RBE_LINT=1

# --- Resource Pools ---
export RBE_JAVA_POOL=default
export RBE_METALAVA_POOL=default
export RBE_LINT_POOL=default

export SKIP_ABI_CHECKS=true

echo "[RBE] RBE is ready for building."
