# Isaac Lab

## Installation

> [!INFO ]
> When running Isaac Sim for the first time, all dependent extensions will be pulled from the registry. This process can take upwards of 10 minutes and is required __on the first run__ of each experience file
[^1]

# Isaac Sim

## Livestream

download webrtc client in windows or linux [here](https://docs.isaacsim.omniverse.nvidia.com/latest/installation/download.html#isaac-sim-latest-release)

append `--livestream 2` to enable webrtc in isaaclab [^2] and make sure `UDP port 47998 TCP port 49100` port are open[^3]

# Warnings

```bash
2025-12-08T02:37:14Z [822ms] [Warning] [gpu.foundation.plugin] CPU performance profile is set to powersave. This profile sets the CPU to the lowest frequency reducing performance.
```

enable performance mode

![[OS/Ubuntu/System#CPU Mode|System]]

# Disable Ros2

```bash
find .venv -name "isaacsim.exp.full.kit"
```

-> `.venv/lib/python3.11/site-packages/isaacsim/apps/isaacsim.exp.full.kit`

```bash
code .venv/lib/python3.11/site-packages/isaacsim/apps/isaacsim.exp.full.kit
```

1. Find the line `isaac.startup.ros_bridge_extension = "isaacsim.ros2.bridge"`.
2. Change it to `isaac.startup.ros_bridge_extension = ""` to disable the ROS 2 bridge.
3. Save and close the file.
[^4]

# compatibility_check

```bash
isaacsim isaacsim.exp.compatibility_check
```

[^5]

# Bugs

## No `libXt.so` and `libGLU.so`

TO fix(gemini 3 pro thinking):

- `libXt.so: cannot open shared object file`
- `libGLU.so: cannot open shared object file`

```bash
python  scripts/reinforcement_learning/skrl/train.py --task=Isaac-Ant-v0 --headless
[INFO][AppLauncher]: Using device: cuda:0
[INFO][AppLauncher]: Loading experience file: /root/Devspace/IsaacLab-uv/isaaclab/apps/isaaclab.python.headless.kit
Loading user config located at: '/root/Devspace/IsaacLab-uv/.venv/lib/python3.11/site-packages/isaacsim/kit/data/Kit/Isaac-Sim/5.1/user.config.json'
[Info] [carb] Logging to file: /root/Devspace/IsaacLab-uv/.venv/lib/python3.11/site-packages/isaacsim/kit/logs/Kit/Isaac-Sim/5.1/kit_20251210_103032.log
2025-12-10T02:30:32Z [88ms] [Warning] [omni.usd_config.extension] Enable omni.materialx.libs extension to use MaterialX
2025-12-10T02:30:32Z [129ms] [Error] [omni.ext.plugin] Could not load the dynamic library from /root/Devspace/IsaacLab-uv/.venv/lib/python3.11/site-packages/isaacsim/extscache/omni.usd.libs-1.0.1+69cbf6ad.lx64.r.cp311/bin/libMaterialXRenderHw.so. Error: libXt.so: cannot open shared object file: No such file or directory (note that this may be caused by a dependent library)
2025-12-10T02:30:33Z [135ms] [Error] [omni.ext.plugin] Could not load the dynamic library from /root/Devspace/IsaacLab-uv/.venv/lib/python3.11/site-packages/isaacsim/extscache/omni.usd.libs-1.0.1+69cbf6ad.lx64.r.cp311/bin/libMaterialXRenderGlsl.so. Error: libXt.so: cannot open shared object file: No such file or directory (note that this may be caused by a dependent library)
2025-12-10T02:30:33Z [140ms] [Error] [omni.ext.plugin] Could not load the dynamic library from /root/Devspace/IsaacLab-uv/.venv/lib/python3.11/site-packages/isaacsim/extscache/omni.usd.libs-1.0.1+69cbf6ad.lx64.r.cp311/bin/libusd_usdBakeMtlx.so. Error: libXt.so: cannot open shared object file: No such file or directory (note that this may be caused by a dependent library)
2025-12-10T02:30:33Z [200ms] [Error] [omni.ext.plugin] Could not load the dynamic library from /root/Devspace/IsaacLab-uv/.venv/lib/python3.11/site-packages/isaacsim/extscache/omni.iray.libs-0.0.0+69cbf6ad.lx64.r/bin/iray/libneuray.so. Error: libGLU.so: cannot open shared object file: No such file or directory (note that this may be caused by a dependent library)
```

```bash
apt-get update
apt-get install -y libxt6 libglu1-mesa libgl1-mesa-glx
```

## VkResult: ERROR_INCOMPATIBLE_DRIVER

```bash
2025-12-10T02:48:39Z [4,250ms] [Error] [carb.graphics-vulkan.plugin] VkResult: ERROR_INCOMPATIBLE_DRIVER
2025-12-10T02:48:39Z [4,250ms] [Error] [carb.graphics-vulkan.plugin] vkCreateInstance failed. Vulkan 1.1 is not supported, or your driver requires an update.
2025-12-10T02:48:39Z [4,250ms] [Error] [gpu.foundation.plugin] carb::graphics::createInstance failed.
2025-12-10T02:48:39Z [4,423ms] [Error] [gpu.foundation.plugin] Invalid getDeviceInfo parameters.
```

check [autodl document](https://www.autodl.com/docs/vulkan/)

> Vulkan is a GPU driver interface standard [^6]

## OMNI_KIT_ALLOW_ROOT

```bash
isaacsim isaacsim.exp.compatibility_check
Omniverse Kit cannot be run as the root user without the --allow-root flag or envvar OMNI_KIT_ALLOW_ROOT set to 1.
Running as root should not be necessary under most circumstances.
Doing this may cause kit to encounter errors when running as a normal user again.
[1]    20169 segmentation fault (core dumped)  isaacsim isaacsim.exp.compatibility_check
```

```bash
echo 'export OMNI_KIT_ALLOW_ROOT=1' >> ~/.zshrc
source ~/.zshrc
```

## `pylance` Failed to Recognize Isaaclab as Packages

add `extraPaths` in `.vscode/settings.json`

```json
{
  "python.analysis.extraPaths": [
    "${workspaceFolder}/isaaclab/source/isaaclab",
    "${workspaceFolder}/isaaclab/source/isaaclab_assets",
    "${workspaceFolder}/isaaclab/source/isaaclab_mimic",
    "${workspaceFolder}/isaaclab/source/isaaclab_rl",
    "${workspaceFolder}/isaaclab/source/isaaclab_tasks"
  ],
  "python.autoComplete.extraPaths": [
    "${workspaceFolder}/isaaclab/source/isaaclab",
    "${workspaceFolder}/isaaclab/source/isaaclab_assets",
    "${workspaceFolder}/isaaclab/source/isaaclab_mimic",
    "${workspaceFolder}/isaaclab/source/isaaclab_rl",
    "${workspaceFolder}/isaaclab/source/isaaclab_tasks"
  ]
}
```

[^7][^8]

# Training

## Logger

```bash
uv add --upgrade wandb
wandb login --cloud
```

extra args for`rsl_rl`

```bash
python scripts/reinforcement_learning/rsl_rl/train.py \
  --task=Isaac-Velocity-Rough-Unitree-Go2-v0\
  --headless \
  --logger wandb \
  --run_name Velocity-Rough\
  --log_project_name isaaclab-unitree-go2
```

the final run name is date+`--run_name`
more options in `isaaclab/scripts/reinforcement_learning/rsl_rl/cli_args.py`

[^1]: [Installation using Isaac Sim Pip Package — Isaac Lab Documentation](https://isaac-sim.github.io/IsaacLab/main/source/setup/installation/pip_installation.html)
[^2]: [Deep-dive into AppLauncher — Isaac Lab Documentation](https://isaac-sim.github.io/IsaacLab/main/source/tutorials/00_sim/launch_app.html)
[^3]: [Livestream Clients — Isaac Sim Documentation](https://docs.isaacsim.omniverse.nvidia.com/latest/installation/manual_livestream_clients.html#isaac-sim-short-webrtc-streaming-client)
[^4]: [ROS 2 Installation — Isaac Sim Documentation](https://docs.isaacsim.omniverse.nvidia.com/5.1.0/installation/install_ros.html#disabling-the-ros-bridge-in-isaac-sim-sh)
[^5]: [Workstation Installation — Isaac Sim Documentation](https://docs.isaacsim.omniverse.nvidia.com/5.1.0/installation/install_workstation.html#isaac-sim-compatibility-checker)
[^6]: [Vulkan - Wikipedia](https://en.wikipedia.org/wiki/Vulkan)
[^7]: [Python settings reference](https://code.visualstudio.com/docs/python/settings-reference#_python-language-server-settings)
[^8]: [Python settings reference](https://code.visualstudio.com/docs/python/settings-reference#_autocomplete-settings)
