<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="Segment(7:0)" />
        <signal name="Segment(7)" />
        <signal name="Segment(6)" />
        <signal name="Segment(5)" />
        <signal name="Segment(4)" />
        <signal name="Segment(3)" />
        <signal name="Segment(2)" />
        <signal name="Segment(1)" />
        <signal name="Segment(0)" />
        <signal name="AN(3:0)" />
        <signal name="Hex(3:0)" />
        <signal name="Hex(3)" />
        <signal name="Hex(2)" />
        <signal name="Hex(1)" />
        <signal name="Hex(0)" />
        <signal name="HEXS(31:0)" />
        <signal name="LES(7:0)" />
        <signal name="XLXN_19(7:0)" />
        <signal name="SW0" />
        <signal name="Scan(2:0)" />
        <signal name="flash" />
        <signal name="XLXN_25" />
        <signal name="SEG_OUT(7:0)" />
        <signal name="point(7:0)" />
        <signal name="XLXN_30" />
        <signal name="XLXN_32" />
        <port polarity="Output" name="AN(3:0)" />
        <port polarity="Input" name="HEXS(31:0)" />
        <port polarity="Input" name="LES(7:0)" />
        <port polarity="Input" name="SW0" />
        <port polarity="Input" name="Scan(2:0)" />
        <port polarity="Input" name="flash" />
        <port polarity="Output" name="SEG_OUT(7:0)" />
        <port polarity="Input" name="point(7:0)" />
        <blockdef name="Seg_map">
            <timestamp>2019-3-5T12:44:42</timestamp>
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="0" y="84" height="24" />
            <line x2="0" y1="96" y2="96" x1="64" />
            <rect width="64" x="400" y="-44" height="24" />
            <line x2="464" y1="-32" y2="-32" x1="400" />
            <rect width="336" x="64" y="-64" height="192" />
        </blockdef>
        <blockdef name="MUX2T1_8">
            <timestamp>2019-3-5T12:50:1</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <blockdef name="ScanSync">
            <timestamp>2019-3-6T2:17:21</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="MC14495_ZJU">
            <timestamp>2017-3-1T16:0:0</timestamp>
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <line x2="0" y1="-240" y2="-240" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-336" y2="-336" x1="64" />
            <rect width="192" x="64" y="-404" height="404" />
            <line x2="320" y1="-32" y2="-32" x1="256" />
            <line x2="320" y1="-80" y2="-80" x1="256" />
            <line x2="320" y1="-128" y2="-128" x1="256" />
            <line x2="320" y1="-176" y2="-176" x1="256" />
            <line x2="320" y1="-224" y2="-224" x1="256" />
            <line x2="320" y1="-272" y2="-272" x1="256" />
            <line x2="320" y1="-320" y2="-320" x1="256" />
            <line x2="320" y1="-368" y2="-368" x1="256" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
        </blockdef>
        <block symbolname="Seg_map" name="XLXI_4">
            <blockpin signalname="XLXN_19(7:0)" name="Seg_map(7:0)" />
            <blockpin signalname="HEXS(31:0)" name="Hexs(31:0)" />
            <blockpin signalname="Scan(2:0)" name="Scan(2:0)" />
        </block>
        <block symbolname="MUX2T1_8" name="XLXI_5">
            <blockpin signalname="SW0" name="s" />
            <blockpin signalname="XLXN_19(7:0)" name="I0(7:0)" />
            <blockpin signalname="Segment(7:0)" name="I1(7:0)" />
            <blockpin signalname="SEG_OUT(7:0)" name="o(7:0)" />
        </block>
        <block symbolname="and2" name="XLXI_6">
            <blockpin signalname="XLXN_25" name="I0" />
            <blockpin signalname="flash" name="I1" />
            <blockpin signalname="XLXN_32" name="O" />
        </block>
        <block symbolname="ScanSync" name="XLXI_9">
            <blockpin signalname="HEXS(31:0)" name="Hexs(31:0)" />
            <blockpin signalname="Scan(2:0)" name="Scan(2:0)" />
            <blockpin signalname="point(7:0)" name="point(7:0)" />
            <blockpin signalname="LES(7:0)" name="LES(7:0)" />
            <blockpin signalname="XLXN_30" name="p" />
            <blockpin signalname="XLXN_25" name="LE" />
            <blockpin signalname="Hex(3:0)" name="Hexo(3:0)" />
            <blockpin signalname="AN(3:0)" name="AN(3:0)" />
        </block>
        <block symbolname="MC14495_ZJU" name="XLXI_10">
            <blockpin signalname="Hex(3)" name="D0" />
            <blockpin signalname="Hex(2)" name="D1" />
            <blockpin signalname="Hex(1)" name="D2" />
            <blockpin signalname="Hex(0)" name="D3" />
            <blockpin signalname="Segment(7)" name="p" />
            <blockpin signalname="Segment(6)" name="g" />
            <blockpin signalname="Segment(5)" name="f" />
            <blockpin signalname="Segment(4)" name="e" />
            <blockpin signalname="Segment(3)" name="d" />
            <blockpin signalname="Segment(2)" name="c" />
            <blockpin signalname="Segment(1)" name="b" />
            <blockpin signalname="Segment(0)" name="a" />
            <blockpin signalname="XLXN_30" name="point" />
            <blockpin signalname="XLXN_32" name="LE" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="Segment(7:0)">
            <wire x2="1888" y1="1008" y2="2000" x1="1888" />
            <wire x2="2064" y1="2000" y2="2000" x1="1888" />
            <wire x2="2640" y1="1008" y2="1008" x1="1888" />
            <wire x2="2640" y1="464" y2="528" x1="2640" />
            <wire x2="2640" y1="528" y2="592" x1="2640" />
            <wire x2="2640" y1="592" y2="656" x1="2640" />
            <wire x2="2640" y1="656" y2="720" x1="2640" />
            <wire x2="2640" y1="720" y2="784" x1="2640" />
            <wire x2="2640" y1="784" y2="848" x1="2640" />
            <wire x2="2640" y1="848" y2="912" x1="2640" />
            <wire x2="2640" y1="912" y2="1008" x1="2640" />
        </branch>
        <bustap x2="2544" y1="912" y2="912" x1="2640" />
        <branch name="Segment(7)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2536" y="912" type="branch" />
            <wire x2="2352" y1="816" y2="816" x1="2272" />
            <wire x2="2352" y1="816" y2="896" x1="2352" />
            <wire x2="2352" y1="896" y2="896" x1="2320" />
            <wire x2="2320" y1="896" y2="912" x1="2320" />
            <wire x2="2544" y1="912" y2="912" x1="2320" />
        </branch>
        <bustap x2="2544" y1="848" y2="848" x1="2640" />
        <branch name="Segment(6)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2536" y="848" type="branch" />
            <wire x2="2288" y1="768" y2="768" x1="2272" />
            <wire x2="2288" y1="768" y2="832" x1="2288" />
            <wire x2="2320" y1="832" y2="832" x1="2288" />
            <wire x2="2320" y1="832" y2="848" x1="2320" />
            <wire x2="2544" y1="848" y2="848" x1="2320" />
        </branch>
        <bustap x2="2544" y1="784" y2="784" x1="2640" />
        <branch name="Segment(5)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2536" y="784" type="branch" />
            <wire x2="2304" y1="720" y2="720" x1="2272" />
            <wire x2="2304" y1="720" y2="768" x1="2304" />
            <wire x2="2320" y1="768" y2="768" x1="2304" />
            <wire x2="2320" y1="768" y2="784" x1="2320" />
            <wire x2="2544" y1="784" y2="784" x1="2320" />
        </branch>
        <bustap x2="2544" y1="720" y2="720" x1="2640" />
        <branch name="Segment(4)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2536" y="720" type="branch" />
            <wire x2="2320" y1="672" y2="672" x1="2272" />
            <wire x2="2320" y1="672" y2="720" x1="2320" />
            <wire x2="2544" y1="720" y2="720" x1="2320" />
        </branch>
        <bustap x2="2544" y1="656" y2="656" x1="2640" />
        <branch name="Segment(3)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2536" y="656" type="branch" />
            <wire x2="2320" y1="624" y2="624" x1="2272" />
            <wire x2="2320" y1="624" y2="656" x1="2320" />
            <wire x2="2544" y1="656" y2="656" x1="2320" />
        </branch>
        <bustap x2="2544" y1="592" y2="592" x1="2640" />
        <branch name="Segment(2)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2536" y="592" type="branch" />
            <wire x2="2320" y1="576" y2="576" x1="2272" />
            <wire x2="2320" y1="576" y2="592" x1="2320" />
            <wire x2="2544" y1="592" y2="592" x1="2320" />
        </branch>
        <bustap x2="2544" y1="528" y2="528" x1="2640" />
        <branch name="Segment(1)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2536" y="528" type="branch" />
            <wire x2="2320" y1="528" y2="528" x1="2272" />
            <wire x2="2544" y1="528" y2="528" x1="2320" />
        </branch>
        <bustap x2="2544" y1="464" y2="464" x1="2640" />
        <branch name="Segment(0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2536" y="464" type="branch" />
            <wire x2="2320" y1="480" y2="480" x1="2272" />
            <wire x2="2544" y1="464" y2="464" x1="2320" />
            <wire x2="2320" y1="464" y2="480" x1="2320" />
        </branch>
        <branch name="AN(3:0)">
            <wire x2="1952" y1="1296" y2="1296" x1="1024" />
        </branch>
        <iomarker fontsize="28" x="1952" y="1296" name="AN(3:0)" orien="R0" />
        <branch name="Hex(3:0)">
            <wire x2="1632" y1="1232" y2="1232" x1="1024" />
            <wire x2="1632" y1="448" y2="464" x1="1632" />
            <wire x2="1632" y1="464" y2="544" x1="1632" />
            <wire x2="1632" y1="544" y2="624" x1="1632" />
            <wire x2="1632" y1="624" y2="704" x1="1632" />
            <wire x2="1632" y1="704" y2="1232" x1="1632" />
        </branch>
        <bustap x2="1728" y1="704" y2="704" x1="1632" />
        <branch name="Hex(3)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1736" y="704" type="branch" />
            <wire x2="1936" y1="704" y2="704" x1="1728" />
            <wire x2="1952" y1="656" y2="656" x1="1936" />
            <wire x2="1936" y1="656" y2="704" x1="1936" />
        </branch>
        <bustap x2="1728" y1="624" y2="624" x1="1632" />
        <branch name="Hex(2)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1736" y="624" type="branch" />
            <wire x2="1936" y1="624" y2="624" x1="1728" />
            <wire x2="1952" y1="608" y2="608" x1="1936" />
            <wire x2="1936" y1="608" y2="624" x1="1936" />
        </branch>
        <bustap x2="1728" y1="544" y2="544" x1="1632" />
        <branch name="Hex(1)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1736" y="544" type="branch" />
            <wire x2="1936" y1="544" y2="544" x1="1728" />
            <wire x2="1936" y1="544" y2="560" x1="1936" />
            <wire x2="1952" y1="560" y2="560" x1="1936" />
        </branch>
        <bustap x2="1728" y1="464" y2="464" x1="1632" />
        <branch name="Hex(0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1736" y="464" type="branch" />
            <wire x2="1936" y1="464" y2="464" x1="1728" />
            <wire x2="1936" y1="464" y2="512" x1="1936" />
            <wire x2="1952" y1="512" y2="512" x1="1936" />
        </branch>
        <branch name="HEXS(31:0)">
            <wire x2="368" y1="1168" y2="1168" x1="240" />
            <wire x2="368" y1="1168" y2="1744" x1="368" />
            <wire x2="544" y1="1744" y2="1744" x1="368" />
            <wire x2="480" y1="1168" y2="1168" x1="368" />
            <wire x2="608" y1="1040" y2="1040" x1="480" />
            <wire x2="608" y1="1040" y2="1104" x1="608" />
            <wire x2="640" y1="1104" y2="1104" x1="608" />
            <wire x2="480" y1="1040" y2="1168" x1="480" />
        </branch>
        <branch name="LES(7:0)">
            <wire x2="640" y1="1296" y2="1296" x1="240" />
        </branch>
        <iomarker fontsize="28" x="240" y="1168" name="HEXS(31:0)" orien="R180" />
        <iomarker fontsize="28" x="240" y="1296" name="LES(7:0)" orien="R180" />
        <instance x="544" y="1712" name="XLXI_4" orien="R0">
        </instance>
        <instance x="2064" y="2032" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_19(7:0)">
            <wire x2="1536" y1="1680" y2="1680" x1="1008" />
            <wire x2="1536" y1="1680" y2="1936" x1="1536" />
            <wire x2="2064" y1="1936" y2="1936" x1="1536" />
        </branch>
        <branch name="SW0">
            <wire x2="1712" y1="1456" y2="1456" x1="640" />
            <wire x2="1712" y1="1456" y2="1872" x1="1712" />
            <wire x2="2064" y1="1872" y2="1872" x1="1712" />
        </branch>
        <iomarker fontsize="28" x="640" y="1456" name="SW0" orien="R180" />
        <branch name="Scan(2:0)">
            <wire x2="304" y1="1104" y2="1104" x1="240" />
            <wire x2="304" y1="1104" y2="1808" x1="304" />
            <wire x2="544" y1="1808" y2="1808" x1="304" />
            <wire x2="576" y1="1104" y2="1104" x1="304" />
            <wire x2="576" y1="1104" y2="1168" x1="576" />
            <wire x2="640" y1="1168" y2="1168" x1="576" />
        </branch>
        <iomarker fontsize="28" x="240" y="1104" name="Scan(2:0)" orien="R180" />
        <instance x="704" y="480" name="XLXI_6" orien="R0" />
        <branch name="flash">
            <wire x2="704" y1="352" y2="352" x1="304" />
        </branch>
        <iomarker fontsize="28" x="304" y="352" name="flash" orien="R180" />
        <branch name="XLXN_25">
            <wire x2="704" y1="416" y2="416" x1="624" />
            <wire x2="624" y1="416" y2="496" x1="624" />
            <wire x2="1056" y1="496" y2="496" x1="624" />
            <wire x2="1056" y1="496" y2="1120" x1="1056" />
            <wire x2="1056" y1="1120" y2="1168" x1="1056" />
            <wire x2="1056" y1="1168" y2="1168" x1="1024" />
        </branch>
        <branch name="SEG_OUT(7:0)">
            <wire x2="2752" y1="1872" y2="1872" x1="2448" />
        </branch>
        <iomarker fontsize="28" x="2752" y="1872" name="SEG_OUT(7:0)" orien="R0" />
        <instance x="640" y="1328" name="XLXI_9" orien="R0">
        </instance>
        <branch name="point(7:0)">
            <wire x2="640" y1="1232" y2="1232" x1="240" />
        </branch>
        <iomarker fontsize="28" x="240" y="1232" name="point(7:0)" orien="R180" />
        <instance x="1952" y="848" name="XLXI_10" orien="R0">
        </instance>
        <branch name="XLXN_30">
            <wire x2="1760" y1="1104" y2="1104" x1="1024" />
            <wire x2="1936" y1="864" y2="864" x1="1760" />
            <wire x2="1760" y1="864" y2="1104" x1="1760" />
            <wire x2="1952" y1="816" y2="816" x1="1936" />
            <wire x2="1936" y1="816" y2="864" x1="1936" />
        </branch>
        <branch name="XLXN_32">
            <wire x2="1440" y1="384" y2="384" x1="960" />
            <wire x2="1440" y1="384" y2="784" x1="1440" />
            <wire x2="1936" y1="784" y2="784" x1="1440" />
            <wire x2="1952" y1="752" y2="752" x1="1936" />
            <wire x2="1936" y1="752" y2="784" x1="1936" />
        </branch>
    </sheet>
</drawing>