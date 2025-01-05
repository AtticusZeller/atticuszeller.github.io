# Bugs

## Time Wrong in Dul System

To change the RTC setting to UTC in Windows, you need to edit the registry:

1. Press `Win + R`, type `regedit` and press Enter.
2. Navigate to `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation`.
3. Right-click the blank area and select `New` -> `DWORD (32-bit) Value`.
4. Name the new value `RealTimeIsUniversal`.
5. Double-click the newly created `RealTimeIsUniversal`, enter `1` in the Value Data box, and click OK.
6. Restart Windows. F. Restart Windows.
