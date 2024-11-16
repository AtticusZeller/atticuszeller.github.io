---
title: "How to Monitor and Test the Health of SSD in Linux"
source: "https://linuxhandbook.com/check-ssd-health/"
author:
  - "[[Sylvain Leroux]]"
published: 2018-07-31
created: 2024-10-16
description: "A detailed analysis on S.M.A.R.T. technologies for Solid State Drives and how to use smartctl tool to monitor and check the health of SSD in Linux."
tags:
  - "tutorial"
---

# How to Monitor and Test the Health of SSD in Linux

[![Warp Terminal](https://linuxhandbook.com/assets/images/warp-terminal.webp)](https://www.warp.dev/?utm_source=linux_handbook&utm_medium=display&utm_campaign=linux_launch)

## What is S.M.A.R.T.?

S.M.A.R.T. –for [Self-Monitoring, Analysis, and Reporting Technology](https://en.wikipedia.org/wiki/S.M.A.R.T.)— is a technology embedded in storage devices like hard disk drives or SSDs and whose goal is to monitor their health status.

In practice, S.M.A.R.T. will monitor several disk parameters during normal drive operations, like the number of reading errors, the drive startup times or even the environmental condition. Moreover, S.M.A.R.T. and can also perform on-demand tests on the drive.

Ideally, S.M.A.R.T. would allow anticipating __predictable__ failures such as those caused by mechanical wearing or degradation of the disk surface, as well as __unpredictable__ failures caused by an unexpected defect. Since drives usually don’t fail abruptly, S.M.A.R.T. gives an option for the operating system or the system administrator to identify soon-to-fail drives so they can be replaced before any data loss occurs.

![SSD health check on Linux](https://linuxhandbook.com/content/images/2020/06/check-ssd-health-linux.jpeg)

## What isn’t S.M.A.R.T.?

All that seems wonderful. However, S.M.A.R.T. is not a crystal ball. It cannot predict with 100% accuracy a failure nor, on the other hand, guarantee a drive will not fail without any early warning. At best, S.M.A.R.T. should be used to __estimate the likeliness__ of a failure.

Given the statistical nature of failure prediction, the S.M.A.R.T. technology particularly interests company using a large number of storage units, and field studies have been conducted to estimate the accuracy of S.M.A.R.T. reported issues to anticipate disk replacement needs in data centers or server farms.

In 2016, [Microsoft and The Pennsylvania State University conducted a study](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/08/a7-narayanan.pdf) focussing on SSDs.

According to that study, it appears some S.M.A.R.T. attributes are good indicators of imminent failure. The paper specifically mentions:

Reallocated (Realloc) Sector Count:

While the underlying technology is radically different, that indicator seems as significant in the SSD world than it was in the hard drive world. Worth mentioning because of wear-leveling algorithms used in SSDs, when several blocks start failing, chances are many more will fail soon.Program/Erase (P/E) fail count:

This is a symptom of a problem with the underlying flash hardware where the drive was unable to clear or store data in a block. Because of imperfections in the manufacturing process, few such errors can be anticipated. However, flash memories have a limited number of clear/write cycles. So, once again, a sudden increase in the number of events might indicate the drive has reached its end of life limit, and we can anticipate many more memory cells to fail soon.CRC and Uncorrectable errors (“Data Error”):

These events can be caused either by storage error or issues with the drive’s internal communication link. This indicator takes into account both __corrected__ errors (thus without any issue reported to the host system) as well as __uncorrected__ errors (thus blocks the drive has reported being unable to read to the host system). In other words, __correctable__ errors are invisible to the host operating system, but they nevertheless impact the drive performances since data has to be corrected by the drive firmware, and a possible sector relocation might occur.SATA downshift count:

Because of temporary disturbances, issues with the communication link between the drive and the host, or because of internal drive issues, the SATA interface can switch to a lower signaling rate. Downgrading the link below the nominal link rate has the obvious impact on the observed drive performances. Selecting a lower signaling rate is not uncommon, especially on older drives. So this indicator is most significant when correlated with the presence of one or several of the preceding ones.

According to the study, 62% of the failed SSD showed __at least__ one of the above symptoms. However, if you reverse that statement, that also means 38% of the studied SSDs failed __without__ showing any of the above symptoms. The study did not mention though if the failed drives have exhibited any other S.M.A.R.T. reported failure or not. So this cannot be directly compared to the 36% failure-without-prior-notice mentioned for hard drives in the Google paper.

The Microsoft/Pennsylvania State University paper does not disclose the exact drive models studied, but according to the authors, most of the drives are coming from the same vendor spanning several generations.

The study noticed significant differences in reliability between the different models. For example, the “worst” model studied exhibits a 20% failure rate nine months after the first relocation error and up to 36% failure rate nine months after the first occurrence of data errors. The “worst” model also happens to be the older drive generation studied in the paper.

On the other hand, for the same symptoms, the drives belonging to the youngest generation of devices shows only 3% and 20% respectively failure rate for the same errors. It is hard to tell if those figures can be explained by improvements in the drive design and manufacturing process, or if this is simply an effect of drive aging.

Most interestingly, and I gave some possible reasons earlier, the paper mentions that, rather than the raw value, this is a sudden increase in the number of reported errors that should be considered as an alarming indicator:

“”” There is a higher likelihood of the symptoms preceding SSD failures, with an intense manifestation and rapid progression preventing their survivability beyond a few months “””

____In other words, one occasional S.M.A.R.T. reported error is probably not to be considered as a signal of imminent failure. However, when a healthy SSD starts reporting more and more errors, a short- to mid-term failure has to be anticipated.____

But how to know if your hard drive or SSD is healthy? Either to satisfy your curiosity or because you want to start monitoring your drives closely, it is time now to introduce the `smartctl` monitoring tool:

# Using Smartctl to Monitor Status of Your SSD in Linux

There are [ways to list disks in Linux](https://linuxhandbook.com/linux-list-disks/) but to monitor the S.M.A.R.T. status of your disk, I suggest the `smartctl` tool, part of the `smartmontool` package (at least on Debian/Ubuntu).

```
sudo apt install smartmontools
```

`smartctl` is a [command line](https://linuxhandbook.com/category/linux-commands/) tool, but this is perfect, especially if you want to automate data collection, on your servers especially.

The first step when using `smartctl` is to check if your disk has S.M.A.R.T. enabled and is supported by the tool:

```
sh$ sudo smartctl -i /dev/sdb
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-6-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Momentus 7200.4
Device Model:     ST9500420AS
Serial Number:    5VJAS7FL
LU WWN Device Id: 5 000c50 02fa0b800
Firmware Version: D005SDM1
User Capacity:    500,107,862,016 bytes [500 GB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    7200 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 2.6, 3.0 Gb/s
Local Time is:    Mon Mar 12 15:54:43 2018 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
```

As you can see, my laptop internal hard drive indeed has S.M.A.R.T. capabilities, and S.M.A.R.T. support is enabled. So, what now about the S.MA.R.T. status? Are there some errors recorded?

Reporting “all SMART information about the disk” is the job of the `-a` option:

```
sh$ sudo smartctl -i -a /dev/sdb
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-6-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Momentus 7200.4
Device Model:     ST9500420AS
Serial Number:    5VJAS7FL
LU WWN Device Id: 5 000c50 02fa0b800
Firmware Version: D005SDM1
User Capacity:    500,107,862,016 bytes [500 GB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    7200 rpm
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 2.6, 3.0 Gb/s
Local Time is:    Mon Mar 12 15:56:58 2018 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED
See vendor-specific Attribute list for marginal Attributes.

General SMART Values:
Offline data collection status:  (0x82)    Offline data collection activity
                    was completed without error.
                    Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)    The previous self-test routine completed
                    without error or no self-test has ever
                    been run.
Total time to complete Offline
data collection:         (    0) seconds.
Offline data collection
capabilities:              (0x7b) SMART execute Offline immediate.
                    Auto Offline data collection on/off support.
                    Suspend Offline collection upon new
                    command.
                    Offline surface scan supported.
                    Self-test supported.
                    Conveyance Self-test supported.
                    Selective Self-test supported.
SMART capabilities:            (0x0003)    Saves SMART data before entering
                    power-saving mode.
                    Supports SMART auto save timer.
Error logging capability:        (0x01)    Error logging supported.
                    General Purpose Logging supported.
Short self-test routine
recommended polling time:      (   2) minutes.
Extended self-test routine
recommended polling time:      ( 110) minutes.
Conveyance self-test routine
recommended polling time:      (   3) minutes.
SCT capabilities:            (0x103f)    SCT Status supported.
                    SCT Error Recovery Control supported.
                    SCT Feature Control supported.
                    SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   111   099   006    Pre-fail  Always       -       29694249
  3 Spin_Up_Time            0x0003   100   098   085    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   095   095   020    Old_age   Always       -       5413
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       3
  7 Seek_Error_Rate         0x000f   071   060   030    Pre-fail  Always       -       51710773327
  9 Power_On_Hours          0x0032   070   070   000    Old_age   Always       -       26423
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   096   037   020    Old_age   Always       -       4836
184 End-to-End_Error        0x0032   100   100   099    Old_age   Always       -       0
187 Reported_Uncorrect      0x0032   072   072   000    Old_age   Always       -       28
188 Command_Timeout         0x0032   100   096   000    Old_age   Always       -       4295033738
189 High_Fly_Writes         0x003a   100   100   000    Old_age   Always       -       0
190 Airflow_Temperature_Cel 0x0022   056   042   045    Old_age   Always   In_the_past 44 (Min/Max 21/44 #22)
191 G-Sense_Error_Rate      0x0032   100   100   000    Old_age   Always       -       184
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       104
193 Load_Cycle_Count        0x0032   001   001   000    Old_age   Always       -       395415
194 Temperature_Celsius     0x0022   044   058   000    Old_age   Always       -       44 (0 13 0 0 0)
195 Hardware_ECC_Recovered  0x001a   050   045   000    Old_age   Always       -       29694249
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       1
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       1
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
240 Head_Flying_Hours       0x0000   100   253   000    Old_age   Offline      -       25131 (246 202 0)
241 Total_LBAs_Written      0x0000   100   253   000    Old_age   Offline      -       3028413736
242 Total_LBAs_Read         0x0000   100   253   000    Old_age   Offline      -       1613088055
254 Free_Fall_Sensor        0x0032   100   100   000    Old_age   Always       -       0

SMART Error Log Version: 1
ATA Error Count: 3
    CR = Command Register [HEX]
    FR = Features Register [HEX]
    SC = Sector Count Register [HEX]
    SN = Sector Number Register [HEX]
    CL = Cylinder Low Register [HEX]
    CH = Cylinder High Register [HEX]
    DH = Device/Head Register [HEX]
    DC = Device Command Register [HEX]
    ER = Error register [HEX]
    ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 3 occurred at disk power-on lifetime: 21171 hours (882 days + 3 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  60 00 08 ff ff ff 4f 00      00:45:12.580  READ FPDMA QUEUED
  60 00 08 ff ff ff 4f 00      00:45:12.580  READ FPDMA QUEUED
  60 00 08 ff ff ff 4f 00      00:45:12.579  READ FPDMA QUEUED
  60 00 08 ff ff ff 4f 00      00:45:12.571  READ FPDMA QUEUED
  60 00 20 ff ff ff 4f 00      00:45:12.543  READ FPDMA QUEUED

Error 2 occurred at disk power-on lifetime: 21171 hours (882 days + 3 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  60 00 00 ff ff ff 4f 00      00:45:09.456  READ FPDMA QUEUED
  60 00 00 ff ff ff 4f 00      00:45:09.451  READ FPDMA QUEUED
  61 00 08 ff ff ff 4f 00      00:45:09.450  WRITE FPDMA QUEUED
  60 00 00 ff ff ff 4f 00      00:45:08.878  READ FPDMA QUEUED
  60 00 00 ff ff ff 4f 00      00:45:08.856  READ FPDMA QUEUED

Error 1 occurred at disk power-on lifetime: 21131 hours (880 days + 11 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  60 00 00 ff ff ff 4f 00      05:52:18.809  READ FPDMA QUEUED
  61 00 00 7e fb 31 45 00      05:52:18.806  WRITE FPDMA QUEUED
  60 00 00 ff ff ff 4f 00      05:52:18.571  READ FPDMA QUEUED
  ea 00 00 00 00 00 a0 00      05:52:18.529  FLUSH CACHE EXT
  61 00 08 ff ff ff 4f 00      05:52:18.527  WRITE FPDMA QUEUED

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%     10904         -
# 2  Short offline       Completed without error       00%        12         -
# 3  Short offline       Completed without error       00%         0         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.
```

## Understanding the Output of Smartctl Command

That is a lot of information and it is not always easy to interpret those data. The most interesting part is probably the one labeled as __“Vendor Specific SMART Attributes with Thresholds”__. It reports various statistics gathered by the S.M.A.R.T. device and let you compare those value (current or all-time worst) with some vendor-defined threshold.

For example, here is how my disk reports relocated sectors:

```
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       3
```

You can see this a “pre-fail” attribute. That just means that attribute is corresponding to anomalies. So, __if__ that attribute exceeds the threshold, that could be an indicator of imminent failure. The other category is “Old\_age” for attributes corresponding to “normal wearing” attributes.

The last field (here “3”) is corresponding the raw value for that attribute as reported by the drive. Usually, this number has a physical significance. Here, this is the actual number of relocated sectors. However, for other attributes, it could be a temperature in degrees Celcius, a time in hours or minutes, or the number of times the drive has encountered a specific condition.

In addition to the raw value, a S.M.A.R.T. enabled drive must report “normalized” values (fields value, worst and threshold). These values are normalized in the range 1-254 (0-255 for the threshold). The disk firmware performs that normalization using some internal algorithm. Moreover, different manufacturers may normalize the same attribute differently. Most values are reported as a percentage, the higher being the best, but this is not mandatory. When a parameter is lower or equal to the manufacturer supplied threshold, the disk is said to have failed for that attribute. With all the reserves mentioned in the first part of that article, when a “pre-fail” attribute has failed, presumably a disk failure is imminent.

As a second example, let’s examine the “seek error rate”:

```
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  7 Seek_Error_Rate         0x000f   071   060   030    Pre-fail  Always       -       51710773327
```

Actually, and this is a problem with S.M.A.R.T. reporting, the exact meaning of each value is vendor-specific. In my case, Seagate is using a logarithmic scale to normalize the value. So “71” means roughly one error for 10 million seeks (10 to the 7.1st power). Amusingly enough, the all-time worst was one error for 1 million seeks (10 to the 6.0th power). If I interpret that correctly, that means my disk heads are more accurately positioned now than they were in the past. I did not follow that disk closely, so this analysis is subject to caution. Maybe the drive just needed some running-in period when it was initially commissioned? Unless this is a consequence of mechanical parts wearing, and thus opposing less friction today? In any case, and whatever the reason is, this value is more a performance indicator than a failure early warning. So that does not bother me a lot.

Besides that, and three suspects errors recorded about six months ago, that drive appears in surprisingly good conditions (according to S.M.A.R.T.) for a stock laptop drive that was powered on for more than 1100 days (26423 hours):

```
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  9 Power_On_Hours          0x0032   070   070   000    Old_age   Always       -       26423
```

Out of curiosity, I ran the same test on a much more recent laptop equipped with an SSD:

```
sh$ sudo smartctl -i /dev/sdb
smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.10.0-32-generic] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     TOSHIBA THNSNK256GVN8
Serial Number:    17FS131LTNLV
LU WWN Device Id: 5 00080d 9109b2ceb
Firmware Version: K8XA4103
User Capacity:    256 060 514 304 bytes [256 GB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    Solid State Device
Form Factor:      M.2
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-3 (minor revision not indicated)
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Tue Mar 13 01:03:23 2018 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
```

The first thing to notice, even if that device is S.M.AR.T. enabled, it is not in the `smartctl` database. That won’t prevent the tool to gather data from the SSD, but it will not be able to report the exact meaning of the different vendor-specific attributes:

```
sh$ sudo smartctl -a /dev/sdb
smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.10.0-32-generic] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00)    Offline data collection activity
                    was never started.
                    Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0)    The previous self-test routine completed
                    without error or no self-test has ever
                    been run.
Total time to complete Offline
data collection:         (  120) seconds.
Offline data collection
capabilities:              (0x5b) SMART execute Offline immediate.
                    Auto Offline data collection on/off support.
                    Suspend Offline collection upon new
                    command.
                    Offline surface scan supported.
                    Self-test supported.
                    No Conveyance Self-test supported.
                    Selective Self-test supported.
SMART capabilities:            (0x0003)    Saves SMART data before entering
                    power-saving mode.
                    Supports SMART auto save timer.
Error logging capability:        (0x01)    Error logging supported.
                    General Purpose Logging supported.
Short self-test routine
recommended polling time:      (   2) minutes.
Extended self-test routine
recommended polling time:      (  11) minutes.
SCT capabilities:            (0x003d)    SCT Status supported.
                    SCT Error Recovery Control supported.
                    SCT Feature Control supported.
                    SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000a   100   100   000    Old_age   Always       -       0
  2 Throughput_Performance  0x0005   100   100   050    Pre-fail  Offline      -       0
  3 Spin_Up_Time            0x0007   100   100   050    Pre-fail  Always       -       0
  5 Reallocated_Sector_Ct   0x0013   100   100   050    Pre-fail  Always       -       0
  7 Unknown_SSD_Attribute   0x000b   100   100   050    Pre-fail  Always       -       0
  8 Unknown_SSD_Attribute   0x0005   100   100   050    Pre-fail  Offline      -       0
  9 Power_On_Hours          0x0012   100   100   000    Old_age   Always       -       171
 10 Unknown_SSD_Attribute   0x0013   100   100   050    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0012   100   100   000    Old_age   Always       -       105
166 Unknown_Attribute       0x0012   100   100   000    Old_age   Always       -       0
167 Unknown_Attribute       0x0022   100   100   000    Old_age   Always       -       0
168 Unknown_Attribute       0x0012   100   100   000    Old_age   Always       -       0
169 Unknown_Attribute       0x0013   100   100   010    Pre-fail  Always       -       100
170 Unknown_Attribute       0x0013   100   100   010    Pre-fail  Always       -       0
173 Unknown_Attribute       0x0012   200   200   000    Old_age   Always       -       0
175 Program_Fail_Count_Chip 0x0013   100   100   010    Pre-fail  Always       -       0
192 Power-Off_Retract_Count 0x0012   100   100   000    Old_age   Always       -       18
194 Temperature_Celsius     0x0023   063   032   020    Pre-fail  Always       -       37 (Min/Max 11/68)
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
240 Unknown_SSD_Attribute   0x0013   100   100   050    Pre-fail  Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.
```

This is typically the output you can expect for a brand new SSD. Even if, because of the lack of normalization or metainformation for vendor-specific data, many attributes are reported as “Unknown\_SSD\_Attribute.” I may only hope future versions of `smartctl` will incorporate data relative to that particular drive model in the tool database, so I could more accurately identify possible issues.

# Test Your SSD in Linux with Smartctl

Until now we have examined the data collected by the drive during its normal operations. However, the S.M.A.R.T. protocol also supports several “self-tests” commands to launch diagnosis on demand.

Unless explicitly requested, the self-tests can run during normal disk operations. Since both the test and the host I/O requests will compete for the drive, the disk performances will degrade during the test. The S.M.A.R.T. specification specifies several kinds of self-test. The most important are:

Short self-test (`-t short`)

This test will check for the electrical and mechanical performances as well as the read performances of the drive. The short self-test typically only requires few minutes to complete (2 to 10 usually).Extended self-test (`-t long`)

This test takes one or two orders of magnitude longer to complete. Usually, this is a more in-depth version of the short self-test. In addition, that test will scan the entire disk surface for data errors with no time limit. The test duration will be proportional to the disk size.Conveyance self-test (`-t conveyance`)

this test suite is designed as a relatively quick way to check for possible damage incurred during transporting of the device.

Here are examples taken from the same disks as above. I let you guess which is which:

```
sh$ sudo smartctl -t short /dev/sdb
smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.10.0-32-generic] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
Sending command: "Execute SMART Short self-test routine immediately in off-line mode".
Drive command "Execute SMART Short self-test routine immediately in off-line mode" successful.
Testing has begun.
Please wait 2 minutes for test to complete.
Test will complete after Mon Mar 12 18:06:17 2018

Use smartctl -X to abort test.
```

The test has now being stated. Let’s wait until completion to show the outcome:

```
sh$ sudo sh -c 'sleep 120 && smartctl -l selftest /dev/sdb'
smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.10.0-32-generic] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF READ SMART DATA SECTION ===
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%       171         -
```

Let’s do now the same test on my other disk:

```
sh$ sudo smartctl -t short /dev/sdb
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-6-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
Sending command: "Execute SMART Short self-test routine immediately in off-line mode".
Drive command "Execute SMART Short self-test routine immediately in off-line mode" successful.
Testing has begun.
Please wait 2 minutes for test to complete.
Test will complete after Mon Mar 12 21:59:39 2018

Use smartctl -X to abort test.
```

Once again, sleep for two minutes and display the test outcome:

```
sh$ sudo sh -c 'sleep 120 && smartctl -l selftest /dev/sdb'
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-6-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF READ SMART DATA SECTION ===
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%     26429         -
# 2  Short offline       Completed without error       00%     10904         -
# 3  Short offline       Completed without error       00%        12         -
# 4  Short offline       Completed without error       00%         0         -
```

Interestingly, in that case, it appears both the drive and the computer manufacturers seems to have performed some quick tests on the disk (at lifetime 0h and 12h). __I__ was definitely much less concerned with monitoring the drive health myself. So, since I am running some self-tests for that article, let’s start an __extended__ test to so how it goes:

```
sh$ sudo smartctl -t long /dev/sdb
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-6-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
Sending command: "Execute SMART Extended self-test routine immediately in off-line mode".
Drive command "Execute SMART Extended self-test routine immediately in off-line mode" successful.
Testing has begun.
Please wait 110 minutes for test to complete.
Test will complete after Tue Mar 13 00:09:08 2018

Use smartctl -X to abort test.
```

Apparently, this time we will have to wait much longer than for the short test. So let’s do it:

```
sh$ sudo bash -c 'sleep $((110*60)) && smartctl -l selftest /dev/sdb'
[sudo] password for sylvain:
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-6-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF READ SMART DATA SECTION ===
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed: read failure       20%     26430         810665229
# 2  Short offline       Completed without error       00%     26429         -
# 3  Short offline       Completed without error       00%     10904         -
# 4  Short offline       Completed without error       00%        12         -
# 5  Short offline       Completed without error       00%         0         -
```

In that latter case, pay special attention to the different outcomes obtained with the short and extended tests, even if they were performed one right after the other. Well, maybe that disk is not that healthy after all! An important thing to notice is the test will stop after the first read error. So if you want an exhaustive diagnosis of all read errors, you will have to __continue__ the test after each error. I encourage you to take a look at the very well written smartctl(8) manual page for the more information about the options `-t select,N-max` and `-t select,cont` for that:

```
sh$ sudo smartctl -t select,810665230-max /dev/sdb
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-6-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
Sending command: "Execute SMART Selective self-test routine immediately in off-line mode".
SPAN         STARTING_LBA           ENDING_LBA
   0            810665230            976773167
Drive command "Execute SMART Selective self-test routine immediately in off-line mode" successful.
Testing has begun.
```

```
smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.9.0-6-amd64] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF READ SMART DATA SECTION ===
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Selective offline   Completed without error       00%     26432         -
# 2  Extended offline    Completed: read failure       20%     26430         810665229
# 3  Short offline       Completed without error       00%     26429         -
# 4  Short offline       Completed without error       00%     10904         -
# 5  Short offline       Completed without error       00%        12         -
# 6  Short offline       Completed without error       00%         0         -
```

## Conclusion

Definitely, S.M.A.R.T. reporting is a technology you can add to your [tool chest to monitor your servers](https://linuxhandbook.com/server-monitoring-tools/) disk health. In that case, you should also take a look at the S.M.A.R.T. Disk Monitoring Daemon [smartd(8)](https://www.smartmontools.org/browser/trunk/smartmontools/smartd.8.in) that could help you automate monitoring through [syslog](https://linuxhandbook.com/syslog-guide/) reporting.

Given the statistical nature of failure prediction, I am a little bit less convinced however that aggressive S.M.A.R.T. monitoring is of great benefit on a personal computer. Finally, don’t forget whatever is its technology, a drive __will__ fail— and we have seen earlier, in one-third of the case, it will fail without prior notice. So nothing will replace [RAID](https://en.wikipedia.org/wiki/RAID) __and__ offline backups to ensure your data integrity!
