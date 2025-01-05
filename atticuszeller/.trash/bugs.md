# Bugs

## open3d

me/atticuszz/miniconda3/envs/localization/bin/python /home/atticuszz/DevSpace/AutoDrive_backend/src/localization/ReplicaLoader.py libGL error: MESA-LOADER: failed to open radeonsi: /usr/lib/dri/radeonsi_dri.so: cannot open shared object file: No such file or directory (search paths /usr/lib/x86_64-linux-gnu/dri:\$${ORIGIN}/dri:/usr/lib/dri, suffix_dri) libGL error: failed to load driver: radeonsi libGL error: MESA-LOADER: failed to open swrast: /usr/lib/dri/swrast_dri.so: cannot open shared object file: No such file or directory (search paths /usr/lib/x86_64-linux-gnu/dri:\$${ORIGIN}/dri:/usr/lib/dri, suffix \_dri) libGL error: failed to load driver: swrast [Open3D WARNING] GLFW Error: GLX: Failed to create context: GLXBadFBConfig [Open3D WARNING] Failed to create window [Open3D WARNING] [DrawGeometries] Failed creating OpenGL window. what should i to install to fix it?
Grimoire

The errors you're encountering are related to the OpenGL drivers on your Linux system, specifically with Mesa drivers for Radeon graphics (`radeonsi`) and the software rasterizer fallback (`swrast`). These issues typically occur due to missing or misconfigured graphics drivers, or because the application or library (in this case, Open3D) is unable to correctly locate or use the OpenGL libraries. Here's how you can address these issues:

# Step 1: Update Your System

Before proceeding with specific fixes, ensure your system is up to date. This can sometimes resolve driver issues by installing the latest versions of libraries and drivers.

For Ubuntu or Debian-based systems, use:

bashCopy code

`sudo apt-get update sudo apt-get upgrade`

# Step 2: Install or Reinstall Mesa Drivers

Mesa provides the OpenGL implementation for AMD (including Radeon), Intel, and other GPUs on Linux. Ensure the Mesa drivers are installed and up to date.

bashCopy code

`sudo apt-get install --reinstall libgl1-mesa-glx libgl1-mesa-dri`

# Step 3: Install Missing Libraries

The errors indicate missing `radeonsi_dri.so` and `swrast_dri.so`. These are part of the Mesa drivers. Reinstalling Mesa drivers should solve this, but ensure all necessary components are installed:

bashCopy code

`sudo apt-get install mesa-utils`

# Step 4: Configure Your System to Use the Correct Drivers

If you have multiple graphics drivers installed, your system might not be using the correct one. Configure your system to use the Mesa drivers:

- For AMD GPUs, ensure the `radeonsi` driver is enabled. This is typically handled automatically, but problems can still occur.

# Step 5: Check for Hardware Acceleration

Ensure that hardware acceleration is enabled and working:

bashCopy code

`glxinfo | grep "direct rendering"`

You should see `direct rendering: Yes` in the output.

# Step 6: Set LIBGL_DRIVERS_PATH

If the system still can't find the drivers, you might need to manually set the `LIBGL_DRIVERS_PATH` environment variable to point to the directory containing the drivers (`radeonsi_dri.so` and `swrast_dri.so`):

bashCopy code

`export LIBGL_DRIVERS_PATH=/usr/lib/dri`

You can add this line to your `.bashrc` or `.bash_profile` (for bash shell) or the equivalent for your shell to make the change permanent.

# Step 7: Verify Installation and Configuration

After installing or reinstalling the necessary drivers and libraries, reboot your system. Then, verify that OpenGL is working correctly:

bashCopy code

`glxgears`

If you see a window with gears turning, the basic OpenGL setup is correct.

# Step 8: Check for Open3D Specific Requirements

Open3D might have specific requirements or configurations. Check the Open3D documentation or forums for any additional setup or configuration steps specific to your system or the version of Open3D you're using.

# If Problems Persist

If you continue to experience issues after following these steps:

- Check the Open3D GitHub issues page for similar problems reported by other users.
- Consider reporting your issue there with detailed information about your system, the steps you've taken, and the exact error messages.

This approach addresses the most common causes of OpenGL driver issues on Linux. However, if your setup is highly customized or you're using less common hardware, additional steps may be necessary.

# Settings Disappper

```bash
sudo apt update
sudo apt upgrade
sudo apt full-upgrade

sudo apt update
sudo apt install --reinstall gnome-control-center
```

[solved: Could not load the Qt platform plugin "xcb" · NVlabs/instant-ngp · Discussion ##300 · GitHub](https://github.com/NVlabs/instant-ngp/discussions/300)

```bash
pip uninstall opencv-python
pip install opencv-python-headless
```
