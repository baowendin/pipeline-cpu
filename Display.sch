<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="flash" />
        <signal name="LES(7:0)" />
        <signal name="point(7:0)" />
        <signal name="Hexs(31:0)" />
        <signal name="Hexs(31:0),Hexs(31:0)" />
        <signal name="clk" />
        <signal name="rst" />
        <signal name="Start" />
        <signal name="Text" />
        <signal name="XLXN_17(63:0)" />
        <signal name="SEGCLK" />
        <signal name="SEGOUT" />
        <signal name="SEGEN" />
        <signal name="SEGCLR" />
        <signal name="XLXN_18(63:0)" />
        <signal name="XLXN_19(63:0)" />
        <port polarity="Input" name="flash" />
        <port polarity="Input" name="LES(7:0)" />
        <port polarity="Input" name="point(7:0)" />
        <port polarity="Input" name="Hexs(31:0)" />
        <port polarity="Input" name="clk" />
        <port polarity="Input" name="rst" />
        <port polarity="Input" name="Start" />
        <port polarity="Input" name="Text" />
        <port polarity="Output" name="SEGCLK" />
        <port polarity="Output" name="SEGOUT" />
        <port polarity="Output" name="SEGEN" />
        <port polarity="Output" name="SEGCLR" />
        <blockdef name="HexTo8SEG">
            <timestamp>2019-3-5T11:12:42</timestamp>
            <rect width="304" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="368" y="-236" height="24" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
        </blockdef>
        <blockdef name="P2S">
            <timestamp>2017-3-2T8:32:9</timestamp>
            <rect width="208" x="16" y="-212" height="212" />
            <line x2="224" y1="-32" y2="-32" x1="240" />
            <line x2="224" y1="-128" y2="-128" x1="240" />
            <line x2="0" y1="-128" y2="-128" x1="16" />
            <line x2="0" y1="-80" y2="-80" x1="16" />
            <line x2="224" y1="-80" y2="-80" x1="240" />
            <line x2="0" y1="-176" y2="-176" x1="16" />
            <line x2="224" y1="-176" y2="-176" x1="240" />
            <line x2="0" y1="-32" y2="-32" style="linewidth:W" x1="16" />
        </blockdef>
        <blockdef name="MUX2T1_64">
            <timestamp>2019-3-5T11:15:4</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="SSeg_map">
            <timestamp>2019-3-5T12:27:49</timestamp>
            <rect width="352" x="64" y="-64" height="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="416" y="-44" height="24" />
            <line x2="480" y1="-32" y2="-32" x1="416" />
        </blockdef>
        <block symbolname="HexTo8SEG" name="XLXI_1">
            <blockpin signalname="flash" name="flash" />
            <blockpin signalname="LES(7:0)" name="LES(7:0)" />
            <blockpin signalname="point(7:0)" name="point(7:0)" />
            <blockpin signalname="Hexs(31:0)" name="Hexs(31:0)" />
            <blockpin signalname="XLXN_19(63:0)" name="SEG_TXT(63:0)" />
        </block>
        <block symbolname="MUX2T1_64" name="XLXI_4">
            <blockpin signalname="Text" name="sel" />
            <blockpin signalname="XLXN_18(63:0)" name="I0(63:0)" />
            <blockpin signalname="XLXN_19(63:0)" name="I1(63:0)" />
            <blockpin signalname="XLXN_17(63:0)" name="o(63:0)" />
        </block>
        <block symbolname="SSeg_map" name="XLXI_5">
            <blockpin signalname="Hexs(31:0),Hexs(31:0)" name="Disp_num(63:0)" />
            <blockpin signalname="XLXN_18(63:0)" name="SSeg_map(63:0)" />
        </block>
        <block symbolname="P2S" name="XLXI_6">
            <blockpin signalname="SEGCLR" name="s_clrn" />
            <blockpin signalname="SEGOUT" name="sout" />
            <blockpin signalname="rst" name="rst" />
            <blockpin signalname="SEGEN" name="EN" />
            <blockpin signalname="Start" name="Serial" />
            <blockpin signalname="clk" name="clk" />
            <blockpin signalname="SEGCLK" name="s_clk" />
            <blockpin signalname="XLXN_17(63:0)" name="P_Data(63:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="2720" height="1760">
        <instance x="880" y="688" name="XLXI_1" orien="R0">
        </instance>
        <branch name="flash">
            <wire x2="880" y1="464" y2="464" x1="656" />
        </branch>
        <instance x="1712" y="832" name="XLXI_4" orien="R0">
        </instance>
        <branch name="LES(7:0)">
            <wire x2="880" y1="528" y2="528" x1="656" />
        </branch>
        <branch name="point(7:0)">
            <wire x2="880" y1="592" y2="592" x1="656" />
        </branch>
        <branch name="Hexs(31:0)">
            <wire x2="880" y1="656" y2="656" x1="656" />
        </branch>
        <branch name="Hexs(31:0),Hexs(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="528" y="1056" type="branch" />
            <wire x2="896" y1="1056" y2="1056" x1="528" />
            <wire x2="896" y1="1056" y2="1072" x1="896" />
            <wire x2="896" y1="1072" y2="1072" x1="816" />
            <wire x2="816" y1="1072" y2="1152" x1="816" />
            <wire x2="896" y1="1152" y2="1152" x1="816" />
        </branch>
        <branch name="clk">
            <wire x2="1536" y1="64" y2="64" x1="928" />
        </branch>
        <branch name="rst">
            <wire x2="1536" y1="112" y2="112" x1="928" />
        </branch>
        <branch name="Start">
            <wire x2="1536" y1="160" y2="160" x1="928" />
        </branch>
        <branch name="Text">
            <wire x2="1328" y1="224" y2="224" x1="928" />
            <wire x2="1328" y1="224" y2="672" x1="1328" />
            <wire x2="1712" y1="672" y2="672" x1="1328" />
        </branch>
        <branch name="XLXN_17(63:0)">
            <wire x2="1536" y1="208" y2="208" x1="1472" />
            <wire x2="1472" y1="208" y2="320" x1="1472" />
            <wire x2="2160" y1="320" y2="320" x1="1472" />
            <wire x2="2160" y1="320" y2="672" x1="2160" />
            <wire x2="2160" y1="672" y2="672" x1="2096" />
        </branch>
        <branch name="SEGCLK">
            <wire x2="1952" y1="64" y2="64" x1="1776" />
        </branch>
        <branch name="SEGOUT">
            <wire x2="1952" y1="112" y2="112" x1="1776" />
        </branch>
        <branch name="SEGEN">
            <wire x2="1952" y1="160" y2="160" x1="1776" />
        </branch>
        <branch name="SEGCLR">
            <wire x2="1952" y1="208" y2="208" x1="1776" />
        </branch>
        <iomarker fontsize="28" x="1952" y="64" name="SEGCLK" orien="R0" />
        <iomarker fontsize="28" x="1952" y="112" name="SEGOUT" orien="R0" />
        <iomarker fontsize="28" x="1952" y="160" name="SEGEN" orien="R0" />
        <iomarker fontsize="28" x="1952" y="208" name="SEGCLR" orien="R0" />
        <iomarker fontsize="28" x="928" y="64" name="clk" orien="R180" />
        <iomarker fontsize="28" x="928" y="112" name="rst" orien="R180" />
        <iomarker fontsize="28" x="928" y="160" name="Start" orien="R180" />
        <iomarker fontsize="28" x="928" y="224" name="Text" orien="R180" />
        <iomarker fontsize="28" x="656" y="464" name="flash" orien="R180" />
        <iomarker fontsize="28" x="656" y="528" name="LES(7:0)" orien="R180" />
        <iomarker fontsize="28" x="656" y="592" name="point(7:0)" orien="R180" />
        <iomarker fontsize="28" x="656" y="656" name="Hexs(31:0)" orien="R180" />
        <instance x="896" y="1184" name="XLXI_5" orien="R0">
        </instance>
        <instance x="1536" y="240" name="XLXI_6" orien="R0">
        </instance>
        <branch name="XLXN_18(63:0)">
            <wire x2="1536" y1="1152" y2="1152" x1="1376" />
            <wire x2="1536" y1="736" y2="1152" x1="1536" />
            <wire x2="1712" y1="736" y2="736" x1="1536" />
        </branch>
        <branch name="XLXN_19(63:0)">
            <wire x2="1504" y1="464" y2="464" x1="1312" />
            <wire x2="1504" y1="464" y2="800" x1="1504" />
            <wire x2="1712" y1="800" y2="800" x1="1504" />
        </branch>
    </sheet>
</drawing>