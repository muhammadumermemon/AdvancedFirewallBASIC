10 REM Packet Filtering Module
20 DIM rules$(100)
30 OPEN "rules.txt" FOR INPUT AS #1
40 FOR i = 1 TO 100
50   INPUT #1, rules$(i)
60 NEXT i
70 CLOSE #1

80 REM Function to check packet against rules
90 FUNCTION CheckPacket(ip$, port, protocol$)
100 FOR i = 1 TO 100
110   IF rules$(i) = "" THEN EXIT FOR
120   IF INSTR(rules$(i), ip$) AND INSTR(rules$(i), STR$(port)) AND INSTR(rules$(i), protocol$) THEN
130     CheckPacket = TRUE
140     EXIT FUNCTION
150   END IF
160 NEXT i
170 CheckPacket = FALSE
180 END FUNCTION

190 REM Example usage
200 ip$ = "192.168.1.1"
210 port = 80
220 protocol$ = "TCP"
230 IF CheckPacket(ip$, port, protocol$) THEN
240   PRINT "Packet allowed"
250 ELSE
260   PRINT "Packet blocked"
270 END IF
300 REM Logging Module
310 OPEN "traffic_log.txt" FOR APPEND AS #2

320 REM Function to log traffic
330 FUNCTION LogTraffic(ip$, port, protocol$, action$)
340 PRINT #2, "IP: " + ip$ + ", Port: " + STR$(port) + ", Protocol: " + protocol$ + ", Action: " + action$
350 END FUNCTION

360 REM Example usage
370 LogTraffic(ip$, port, protocol$, "Allowed")
400 REM Rule Management Module
410 REM Function to add a rule
420 FUNCTION AddRule(rule$)
430 OPEN "rules.txt" FOR APPEND AS #1
440 PRINT #1, rule$
450 CLOSE #1
460 END FUNCTION

470 REM Function to remove a rule
480 FUNCTION RemoveRule(rule$)
490 OPEN "rules.txt" FOR INPUT AS #1
500 DIM rules$(100)
510 FOR i = 1 TO 100
520   INPUT #1, rules$(i)
530 NEXT i
540 CLOSE #1

550 OPEN "rules.txt" FOR OUTPUT AS #1
560 FOR i = 1 TO 100
570   IF rules$(i) <> rule$ THEN PRINT #1, rules$(i)
580 NEXT i
590 CLOSE #1
600 END FUNCTION

610 REM Example usage
620 AddRule("192.168.1.1,80,TCP")
630 RemoveRule("192.168.1.1,80,TCP")
700 REM Intrusion Detection Module
710 REM Function to detect suspicious activity
720 FUNCTION DetectIntrusion(ip$, port, protocol$)
730 REM Simple rule: block repeated access attempts
740 STATIC accessCount
750 IF ip$ = "192.168.1.1" THEN
760   accessCount = accessCount + 1
770   IF accessCount > 5 THEN
780     PRINT "Intrusion detected from IP: " + ip$
790     LogTraffic(ip$, port, protocol$, "Blocked - Intrusion")
800     DetectIntrusion = TRUE
810     EXIT FUNCTION
820   END IF
830 ELSE
840   accessCount = 0
850 END IF
860 DetectIntrusion = FALSE
870 END FUNCTION

880 REM Example usage
890 IF DetectIntrusion(ip$, port, protocol$) THEN
900   PRINT "Intrusion detected"
910 ELSE
920   PRINT "No intrusion detected"
930 END IF
1000 REM File System Interaction
1010 REM Read configuration file
1020 OPEN "config.txt" FOR INPUT AS #3
1030 DIM config$(100)
1040 FOR i = 1 TO 100
1050   INPUT #3, config$(i)
1060 NEXT i
1070 CLOSE #3

1080 REM Write to log file
1090 OPEN "traffic_log.txt" FOR APPEND AS #2
1100 PRINT #2, "Firewall started at " + DATE$ + " " + TIME$
1110 CLOSE #2
1200 REM Main Program
1210 REM Initialize
1220 GOSUB 1000 ' File System Interaction
1230 GOSUB 300 ' Logging Module
1240 GOSUB 400 ' Rule Management Module
1250 GOSUB 700 ' Intrusion Detection Module

1260 REM Main loop
1270 DO
1280   REM Simulate packet reception
1290   ip$ = "192.168.1.1"
1300   port = 80
1310   protocol$ = "TCP"
1320   IF CheckPacket(ip$, port, protocol$) THEN
1330     IF NOT DetectIntrusion(ip$, port, protocol$) THEN
1340       PRINT "Packet allowed"
1350       LogTraffic(ip$, port, protocol$, "Allowed")
1360     ELSE
1370       PRINT "Packet blocked due to intrusion"
1380     END IF
1390   ELSE
1400     PRINT "Packet blocked"
1410     LogTraffic(ip$, port, protocol$, "Blocked")
1420   END IF
1430 LOOP
