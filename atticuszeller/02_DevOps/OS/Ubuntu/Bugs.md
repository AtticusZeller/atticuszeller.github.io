# Bugs

## Ubuntu Keyring Configuration Guide for Auto-Login Setups

### 1. Core Components & How It Works

- __Relevant system component__: __GNOME Keyring__ (the GNOME keyring daemon).
- __Relevant tool__: __Seahorse__ (GUI tool shown as “Passwords and Keys”).
- __Underlying mechanism__:
	- Applications like Chrome and VSCode store sensitive data (cookies, login tokens) in encrypted form, and the encryption key is stored inside `login.keyring`.
	- By default, the keyring password is __the same as your system login password__.
	- __Conflict__: When Ubuntu uses __password-less auto-login__, the system never receives your password during boot, so the keyring cannot unlock automatically.
	- __Result__: Applications cannot access the keyring → they ask for a password → if you cancel, apps cannot decrypt their data → after reboot, login sessions disappear.

### 2. Correct Setup for Your Next Machine (Best Practice)

If you install Ubuntu on a new machine and plan to use __auto-login__, do __this setup immediately__ _before opening Chrome or VSCode_, so everything works cleanly and permanently:

#### Scenario: Auto-login is Enabled

__Goal__: Set the default keyring password to an empty password so the system can unlock it automatically.

1. After logging into your desktop, search for and open __“Passwords and Keys” (Seahorse)__.
2. In the left sidebar, find the __“Login”__ keyring (if it doesn’t exist, create a new keyring named `login`).![[assets/Pasted image 20251126105517.png|300]]
3. __Right-click__ the “Login” keyring and select __“Change Password”__.
	- __Old password__: your system login password.
	- __New password__: __leave empty__.
	- __Confirm password__: __leave empty__.
4. A warning about insecure storage will appear; click __Continue__.
5. __Right-click → Set as Default__ to ensure it’s the default keyring.

__Done!__ Now when you install or open Chrome, VSCode, and similar apps, they will write data into this non-encrypted keyring, and your login sessions will persist across reboots—no pop-ups, no password prompts.
