# Bugs

## Time Wrong in Dul System

To change the RTC setting to UTC in Windows, you need to edit the registry:
a. Press `Win + R`, type `regedit` and press Enter.
b. Navigate to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation`.
c. Right-click the blank area and select `New` -> `DWORD (32-bit) Value`.
d. Name the new value `RealTimeIsUniversal`.
e. Double-click the newly created `RealTimeIsUniversal`, enter `1` in the Value Data box, and click OK.
f. Restart Windows. F. Restart Windows.
