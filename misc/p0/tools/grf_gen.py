#!/usr/bin/env python3
"""
    <comp lib="0" loc="(230,1490)" name="Tunnel">
      <a name="width" val="32"/>
      <a name="label" val="we_0"/>
    </comp>
    <comp lib ="0" loc="(230,1520)" name="Tunnel">
      <a name="width" val="32"/>
      <a name="label" val="we_1"/>
    </comp>
"""

for i in range(32):
    s = f"""    <comp lib="0" loc="(230,{1490 + 30 * i})" name="Tunnel">
      <a name="width" val="32"/>
      <a name="label" val="we_{i}"/>
    </comp>"""
    print(s)

for i in range(32):
    s = f"""    <comp lib="0" loc="(560,{1070 + 30 * i})" name="Tunnel">
      <a name="facing" val="east"/>
      <a name="width" val="32"/>
      <a name="label" val="rd_{i}"/>
    </comp>"""
    print(s)
