# m-BITBEAM

This is source repository of m-BITBEAM parts. It is based on ``bitbeam-lib``
openscad library, which is append as sub-module under the ``scad`` directory.

Parts must be shifted to right position, to good positioning in LDRAW type
software.

## Parts naming

There is simple as could be naming key for files and parts naming. This could
help you to understand what kind of file, resp. part is it.

```
bb-drv-mbkitronic-th
                   ^---- subtype if is needed
          ^------------- additional values of part
     ^------------------ type of part
 ^---------------------- main group or category of part
```
### group
There are some main groups, the base group is **bb**, which means bit beam, so
this is printed bitbeam parts. With **ws** group, only they are in STL release
file.
  * **bb** - bit beam
  * **co** - complete part - typical bit beams with some other parts like
    sensor or special wheel supports.
  * **nut**, **ws**, **sc** - nut, washer or screw
  * **sen** - that is sensor
  * **pin** - plastic pin
  * **shaft**, **t-shaft** - shaft

### type
Type of part, that could tell you, what kind of beam, sensor or driver it is.
  * **a** - L shape with defined angle
  * **b** - Beam
  * **bd** - board (Arduino, OctopusLAB, etc.)
  * **gr** - Gear
  * **h**, **o**, **d** - Beam frame with specific shape
  * **t**, **x**, **u** - Beam with the specific shape, which looks like T,
    X(+) and U
  * **sen** - Box for sensor, driver or other separate electric part
  * **wh**, **pivot** - Wheel and special stabilization ball.
  * **tr** - piece of track chain

### subtype
Some part have defined sub-type.
  * **sm** - Smooth, that means version without too much holes.
  * **th** - Thin size, that means height of Beam is one half of unit.

### value
Value is short as possible which represent specific of part. That means number
of each beams - size, type of sensor etc. Examples:
  * ``bb-b-20x1`` - Bit Beam 20x1
  * ``bb-a90-3x4`` - Bit Beam L type 3 for one arm and 4 for second with 90
    degrees angle.
  * ``bb-sen-rwc`` - Bit Beam box for rcw sensor
  * ``drv-mbkitronic`` - electronic part Motor Driver from Kitronic for
    BBC Micro:bit.
  * ``bb-drv-mbkitronic`` - bit beam box for motor driver
  * ``sc-M4x20`` - M4 screw 20mm length

## Releases

Avery tagged commit is released by Travis, and two "binary" files are
created:

  * ``m-bitbeam-stl-X.Y.Z.zip`` which is printed STL files.
  * ``m-bitbeam-parts-X.Y.Z.zip`` which is parts library for LDRAW type
    software.

## Authors

This work is created or based or more authors. So all parts is tagged as
work of Collective Authors, they are in ``AUTHORS`` file.

## License

All files in this repository is public under the Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 license. See ``LICENSE.md`` file
for more details.
